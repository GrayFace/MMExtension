--[[
ParseLua v0.0
(c) 2015 Sergey Rozhenko, MIT license


How it works:
  A light-weight Lua parser assumes Lua code is validated by Lua.

Typical usage:

Functions:

CheckStr(string, chunk)
  Checks the string and uses 'chunk' as the name for errors. Returns error string or nothing.
  If 'chunk' is a function, uses its name.
  If 'chunk' is nil, returns the error in form "line_num: error"

CheckChunkFile(f, raise)
  Checks the source file of 'f'. 'f' can be a stack level.
  If 'raise' is specified, raises the error at 'raise' level.

CheckFile(fname, raise)

Options = {
  BuildTree
  AddOperators(binary, ...) adds given names to binary ('binary' = true) or unary ('binary' = false) operators list.
  SkipUnknown, when set to true, makes the parser try to skip unknown symbolic operators.
  NameCharCodes is a table with valid indentifier char codes as keys and 'true' as values.
  SpaceCharCodes is a similar table for whitespace char codes.
}

--]]
local abs, floor, ceil, max, min = math.abs, math.floor, math.ceil, math.max, math.min
local type = type
local pairs = pairs
local ipairs = ipairs
local setmetatable = setmetatable
local assert = assert
local error = error
local print = print
local loadstring = loadstring or load
local loadfile = loadfile
local unpack = unpack
local concat = table.concat
local table_sort = table.sort
local debug_getinfo = debug and debug.getinfo
local debug_getupvalue = debug and debug.getupvalue
local io_open = io.open
local sub = string.sub
local match = string.match
local byte = string.byte
local format = string.format
local HasGoto = loadstring("::a::") and true
local Lua52 = HasGoto and (_VERSION ~= "Lua 5.1")
local LuaJIT = loadstring("#") and true  -- jit.* might be hidden

local getfenv = getfenv or debug_getinfo and debug_getupvalue and function(f)
	f = (type(f) == 'function' and f or assert(f ~= 0) and debug_getinfo(f + 1, 'f').func)
	local name, val
	local up = 0
	repeat
		up = up + 1
		name, val = debug_getupvalue(f, up)
	until name == '_ENV' or name == nil
	return val
end
getfenv = getfenv or function()
	return _ENV
end

----------- No globals from this point ------------

local _NOGLOBALS

----------- Main Vars ------------

local P = {Options = {BuildTree = true}, LowLevel = {}}
local LL = P.LowLevel
local str, pos, C  -- C for common state

local NameCodes = {[0x5F] = true}  -- use LuaJIT permissive default
for i = 0x30, 0x39 do
	NameCodes[i] = true
end
for i = 0x41, 0x5A do
	NameCodes[i] = true
end
for i = 0x61, 0x7A do
	NameCodes[i] = true
end
for i = 0x80, 0xFF do
	NameCodes[i] = true
end
P.Options.NameCharCodes = NameCodes

----------- General functions ------------

local function MatchStr(s)
	if sub(str, pos, pos + #s - 1) == s then
		pos = pos + #s
		return s
	end
end
LL.MatchStr = MatchStr

local function MatchPattern(s)
	local n, n1 = match(str, s.."()", pos)
	C.LastCapture = n
	pos = (n1 or n or pos)
	return n
end
LL.MatchPattern = MatchPattern

local function GetLineNumber(p)
	local old, n = pos, 1
	pos = 1
	while MatchPattern("([\r\n])") and pos < p do
		if C.LastCapture == "\r" then
			MatchStr("\n")
		end
		n = n + 1
	end
	pos = old
	return n
end
LL.GetLineNumber = GetLineNumber
P.GetLineNumber = GetLineNumber

local function Error(s, ...)
	C.Error = C.Error or format("%d: "..s, GetLineNumber(pos), ...)
	pos = #str + 1
end
LL.Error = Error

----------- Space and comments ------------

local SpaceCodes = {[32] = true}
for i = 9, 13 do
	SpaceCodes[i] = true
end
P.Options.SpaceCharCodes = SpaceCodes

local function Space()
	while true do
		local v = byte(str, pos)
		if SpaceCodes[v] then
			pos = pos + 1
		elseif v == 0x2D and MatchStr("--") then
			if not MatchPattern("^%[(=*)%[.-%]%1%]") and not MatchPattern("[\r\n]") then
				pos = #str + 1
			end
		else
			return v
		end
	end
end
LL.Space = Space

local function Name()
	local old = pos
	while NameCodes[byte(str, pos)] do
		pos = pos + 1
	end
	return sub(str, old, pos - 1)
end
LL.Name = Name

----------- Parsers ------------

local Parsers = {}
local E  -- E for current ExpList state

local SNewLine = 0
local SLeftSide = 1
local SLocals = 2
local SRightSide = 3
-- negative state means a variable has been read, binary operator or new statement is expected

local function NewExp()
	return {}
end

local function StoreTokenStart(comment, start)
	local exp, n = E.Exp, #E.Exp + 1
	exp[n] = {
		Index = n,
		SpaceBefore = comment,
		Start = start,
		End = pos,
		s = C.Token,
		-- State = E.State,
		Special = E.Special,
	}
end
LL.StoreTokenStart = StoreTokenStart

local function StoreTokenEnd()
	local exp = E.Exp
	if exp[1] then
		local tok = exp[#exp]
		tok.End = pos
		if tok.Cancel then
			exp[#exp] = nil
		end
	end
end
LL.StoreTokenEnd = StoreTokenEnd

local _empty = {}

local function GetToken(n)
	local t = E.Exp
	return t[#t + (n or 0)] or _empty
end
LL.GetToken = GetToken

local function TokenInfo(t)
	local tok = GetToken()
	for k, v in pairs(t) do
		tok[k] = v
	end
end
LL.TokenInfo = TokenInfo

local function NewLocal(s)
	return {
		Name = s,
		ParentList = E,
		ParentExp = E.Exp,
		ParentToken = E.Exp[#E.Exp],
		Hides = E.Locals[s]
	}
end
LL.NewLocal = NewLocal

local function StoreLocals()
	for k, v in pairs(E.NewLocals) do
		E.Locals[k] = v
	end
	E.NewLocals = {}
end
LL.StoreLocals = StoreLocals

local CheckUntil

local function NewStatement(donot, nountil)
	if donot or not E.Exp[2] then
		return
	end
	StoreLocals()
	-- move last token to new expression
	local exp = E.Exp
	E.Exp = NewExp()
	if not C.Finished then
		local tok = exp[#exp]
		E.Exp[1] = tok
		tok.Index, exp[#exp] = 1, nil
	end
	-- callbacks
	if P.Options.BuildTree then
		E[#E + 1] = exp
	end
	exp.Parent, exp.Index = E, #E
	E.State = SNewLine
	if P.Options.OnExpEnd then
		P.Options.OnExpEnd(E, exp)
	end
	if not nountil then
		CheckUntil(E)
	end
end
LL.NewStatement = NewStatement

local function End()
	NewStatement(false, true)
	local E_ = E
	if E.ParentList then
		local exp = E.Exp
		E = E.ParentList
		E.Exp[#E.Exp + 1] = exp[1]
	end
	if P.Options.OnListEnd then
		P.Options.OnListEnd(E_)
	end
	CheckUntil(E_)
end
LL.End = End

function CheckUntil(E)
	if E.Special == "until" then
		E.Special, GetToken().Special = nil, nil
		End()
		NewStatement()
	end
end

local function OpState()
	return max(SLeftSide, abs(E.State))
end
LL.OpState = OpState

-- ExpList
local function ExpList(BaseState, RetState, IsBlock)
	if E then
		E.State = RetState or -OpState()
		StoreTokenEnd()
	end
	E = {
		Str = str,
		State = BaseState or SNewLine,
		ParentList = E,
		ParentExp = E and E.Exp,
		ParentToken = E and E.Exp[#E.Exp],
		Locals = IsBlock and setmetatable({}, {__index = E and E.Locals or nil}) or E.Locals,
		NewLocals = {},
		IsBlock = IsBlock,
		Kind = C.Token,
		Exp = NewExp(),
	}
	if not E.Parent and Lua52 then
		E.Locals._ENV = NewLocal("_ENV")
	end
	if P.Options.BuildTree and E.ParentToken then
		E.ParentToken.List = E
	end
	if P.Options.OnListStart then
		P.Options.OnListStart(E)
	end
end
LL.ExpList = ExpList

local function Block(BaseState, RetState)
	if E then
		StoreLocals()
	end
	ExpList(BaseState, RetState or SNewLine, true)
end
LL.Block = Block

local function LookaheadAssignment()
	local p0 = pos
	local b = Space() and MatchStr("=")
	pos = p0
	return b
end

-- vars
local function VarName(s)
	NewStatement(E.State > 0)
	local tok = GetToken()
	local last = GetToken(-1).s
	
	if s == "" then  -- parse error
		if pos <= #str then
			s = Name()
			Error("RSParseLua failure near %q", (s ~= "" and s or sub(str, pos, pos)))
		end
	elseif last == "." or last == ":" then  -- table field access
		E.State = -OpState()
		tok.Kind = "field"
		if P.Options.OnField then
			P.Options.OnField(E, s, tok)
		end
		return
	elseif last == "goto" or last == "::" then  -- goto
		tok.Kind = "label"
		return
	elseif E.Kind == "{" and (not last or last == "," or last == ";") and LookaheadAssignment() then
		-- table field declaration
		tok.Kind = "field"
		if P.Options.OnField then
			P.Options.OnField(E, s, tok)
		end
	else  -- variable
		tok.Kind = "variable"
		if E.State == SLocals then  -- new local
			local t = NewLocal(s)
			E.NewLocals[s] = t
			tok.Local = t
		else
			tok.Local = E.Locals[s]
		end
		if P.Options.OnVariable then
			P.Options.OnVariable(E, s, tok)
		end
	end
	E.State = -max(E.State, SLeftSide)
end
LL.VarName = VarName

-- register operations
local function Reg(f, op, ...)
	if not op then
		return f
	end
	Parsers[op] = f
	return Reg(f, ...)
end

-- ...
Reg(function(s)
	NewStatement(E.State > 0)
	E.State = -SRightSide
end, "...")

-- nil, true, false
Reg(function(s)
	GetToken().Constant = true
	NewStatement(E.State > 0)
	E.State = -SRightSide
end, "nil", "true", "false")

-- unary operations
local UnOp = Reg(function()
end, "#", "not")

-- binary operations
local BinOp = Reg(function()
	E.State = OpState()
end, '+', '-', '*', '/', '^', '%', '..', '<', '<=', '>', '>=', '==', '~=', 'and', 'or', '.', ':')

-- Lua53 operators, also may be in Lua patches ('\' is added for possible patches)
for _, op in ipairs{'//', '&', '~', '|', '>>', '<<', '\\'} do
	if loadstring("return a"..op.."a") then
		Reg(op == "~" and UnOp or BinOp, op)
	end
end

-- numbers
Reg(function(s)
	TokenInfo{Kind = "number", Constant = true}
	NewStatement(E.State > 0)
	E.State = -SRightSide
	if s == "0" and MatchPattern("^[xX]") then  -- hex
		if not MatchPattern("^[0-9a-fA-F]*[lL][lL]") then  -- hex, long
			MatchPattern("^[0-9a-fA-F]*%.?[0-9a-fA-F]*")  -- number with a dot
			MatchPattern("^[pP][%+%-]?[0-9]+")  -- exp
		end
	elseif not MatchPattern("^[0-9]*[lL][lL]") then  -- long
		MatchPattern("^[0-9]*%.?[0-9]*")  -- number with a dot
		MatchPattern("^[eE][%+%-]?[0-9]+")  -- exp
	end
	-- return not NameCodes[byte(str, pos)]
end, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")

-- string
Reg(function(chr)
	while MatchPattern("(["..chr.."\\])") and C.LastCapture == "\\" do
		pos = pos + 1
	end
	TokenInfo{Kind = "string", Constant = true, Border = 1}
	E.State = -SRightSide
end, "'", '"')

-- [
Reg(function()
	if MatchPattern("^(=*)%[.-%]%1%]") then  -- long string
		TokenInfo{s = '"', Kind = "string", Constant = true, Border = #C.LastCapture + 2}
		E.State = -SRightSide
	else
		ExpList(SRightSide)
	end
end, "[")

-- (
Reg(function()
	if E.Special ~= "function" then
		local tok = GetToken(-1)
		local s = tok.s
		if E.State == SNewLine or tok.Constant or s == "..." or s == "end" or s == "}" and not GetToken(-2).IsCall then
			NewStatement()
		end
		GetToken().IsCall = (E.State < 0)
		return ExpList(SRightSide)
	end
	-- function
	local lastDot = GetToken(-2).s
	E.Special = nil
	C.Token = "function"
	-- Block(SLocals, (E.State == SRightSide and -SRightSide or SNewLine))
	Block(SLocals, (GetToken(-1).s == "function" and -SRightSide or SNewLine))
	E.Special = "args"
	E.HasSelf = (lastDot == ":")
	E.Locals.self = (lastDot == ":") and NewLocal("self") or nil
end, "(")

-- {
Reg(function()
	GetToken().IsCall = (E.State < 0)
	ExpList(SNewLine)
end, "{")

-- assignment
Reg(function()
	E.State = SRightSide
end, "=", "in")

-- local
Reg(function()
	NewStatement()
	E.State = SLocals
end, "local")

-- if, while
Reg(function()
	NewStatement()
	E.State = SRightSide
	E.Special = C.Token
end, "if", "while")

-- return
Reg(function()
	NewStatement()
	E.State = SRightSide
end, "return")

-- line ends
local SetNewLine = Reg(function()
	NewStatement()
	E.State = SNewLine
end, ";", "break")
LL.SetNewLine = SetNewLine

Reg(function()
	if E.Kind == "{" then
		return SetNewLine()
	end
	E.State = OpState()
end, ",")

-- expression list ends
Reg(function()
	End()
end, "]", "}", "end")

Reg(function()
	if E.Special == "args" then
		E.Special = nil
		return SetNewLine()
	end
	End()
end, ")")

Reg(function()
	End()
	E.State = SRightSide
	E.Special = C.Token
end, "elseif")

Reg(function()
	E.State = SRightSide
	E.Special = "until"
end, "until")

Reg(function()
	End()
	Block()
end, "else")

-- blocks
Reg(function()
	NewStatement()
	Block()
end, "repeat")

Reg(function()
	E.Special = nil
	Block()
end, "then")

Reg(function()
	if E.Special == "for" then
		E.Special = nil
		return SetNewLine()
	end
	E.Special = nil
	Block()
end, "do")

-- for
Reg(function()
	NewStatement()
	Block(SLocals)
	E.Special = C.Token
end, "for")

-- function
Reg(function()
	if E.State ~= SRightSide then
		NewStatement(E.State > 0)
		E.State = OpState()
	end
	E.Special = C.Token
end, "function")

-- goto
Parsers["goto"] = HasGoto and function(s)
	local p0 = pos
	if not E.IsBlock or E.State > 0 or Name(Space()) == "" then
		pos = p0
		return VarName(s)
	end
	pos = p0
	NewStatement()
	GetToken().Kind = "goto"
	E.State = SLeftSide
end

Parsers["::"] = HasGoto and function()
	if GetToken(-1).Kind ~= "label" or GetToken(-2).s ~= "::" then
		NewStatement()
		E.State = SLeftSide
	else
		E.State = SNewLine
	end
end

----------- TokenLists ------------
-- create a [first char] -> [tokens array] mapping for symbolic tokens

local function NotName(s, i)
	return #s < i or not NameCodes[byte(s, i)] and NotName(s, i + 1)
end

local TokenLists
local function RebuildParsers()
	TokenLists = {}
	for i = 0, 255 do
		TokenLists[i] = {}
	end
	for s, f in pairs(Parsers) do
		if NotName(s, 1) or match(s, "^[0-9]") then
			local t = TokenLists[byte(s)]
			t[#t + 1] = s
		end
	end
	for i = 0, 255 do
		local t = TokenLists[i]
		table_sort(t)  -- longer matches would be at the end of the list
		TokenLists[i] = t[1] and t  -- remove empty lists
	end
end
RebuildParsers()

local function FindToken(t)
	if t then
		for i = #t, 1, -1 do
			if MatchStr(t[i]) then
				return t[i]
			end
		end
	end
end

----------- ParseLoop ------------

local function ParseLoop()
	while pos <= #str do
		local p0 = pos
		local c = Space()
		local p1 = pos
		local s = FindToken(TokenLists[c]) or Name()
		if s == "" and P.Options.SkipUnknown then
			pos = pos + 1
		else
			C.Token = s
			StoreTokenStart(p0, p1)
			if not P.Options.OnToken or not P.Options.OnToken(s) then
				(Parsers[s] or VarName)(s)
			end
			StoreTokenEnd()
		end
	end
	StoreTokenEnd()
	C.Finished = true
	End()
end

----------- Module functions ------------

local function GetChunkName(chunk)
	local d = debug_getinfo and debug_getinfo(chunk, "nSu")
	return d and (d.name ~= "" and d.name or d.short_src)
end

local function CheckStr(fstr, chunk)
	if byte(fstr) == 33 then
		return  -- '!' signals a binary chunk produced by string.dump
	end
	NameCodes = P.Options.NameCharCodes
	SpaceCodes = P.Options.SpaceCharCodes
	str = fstr
	pos = 1
	C = {}
	E = nil
	MatchStr("\239\187\191")  -- UTF-8 BOM
	MatchPattern("^#[^\r\n]*")  -- Unix exec. file?
	Block()
	if P.Options.OnStart then
		P.Options.OnStart()
	end
	ParseLoop()
	if P.Options.OnFinish then
		P.Options.OnFinish()
	end
	if C.Error and chunk then
		if type(chunk) ~= "string" then
			chunk = GetChunkName(chunk) or "?"
		end
		return chunk..":"..C.Error
	end
	return C.Error
end
P.CheckStr = CheckStr

local function DoCheckChunkFile(f, pattern)
	local d = debug_getinfo and debug_getinfo(f, "fS")
	local fname = d and d.source and match(d.source, pattern)
	if fname then
		local file = io_open(fname, "rb")
		if file then
			local s = file:read("*a")
			file:close()
			return CheckStr(s, d.func or fname)
		end
	end
end

function P.CheckChunkFile(f, raise)
	if type(f) == "number" then
		f = f + 2
	end
	local s = DoCheckChunkFile(f, "^@(.+)")
	if s and raise then
		error(s, raise)
	end
	return s
end

function P.CheckFile(fname, raise)
	local f, s = loadfile(fname)
	local s = f and DoCheckChunkFile(f, "^@(.+)") or s
	if s and raise then
		error(s, raise)
	end
	return s
end

-- returns a list of comments or new line markers:
-- {"-", Start = ..., End = ...} for one line comment
-- {"[", Start = ..., End = ...} for multiline commend
-- {"n", Start = ..., End = ...} for carriage return
function P.ParseSpace(p0)
	local t, old = {}, pos
	pos = p0
	local function L(kind)
		t[#t+1] = {kind, Start = pos}
	end
	local function R(p)
		t[#t].End = p or pos
	end
	while true do
		local v = byte(str, pos)
		if v == 13 or v == 10 then  -- carriage return
			L("n")
			pos = pos + 1
			if v == 13 and byte(str, pos) == 10 then
				pos = pos + 1
			end
			R()
		elseif SpaceCodes[v] then
			pos = pos + 1
		elseif v == 0x2D and MatchStr("--") then
			if MatchPattern("^%[(=*)%[") then  -- multiline comment
				L("[")
				R(MatchPattern("()^%]"..C.LastCapture.."%]"))
			else
				L("-")
				if MatchPattern("[\r\n]") then  -- one line comment
					pos = pos - 1
				else
					pos = #str + 1
				end
				R()
			end
		else
			break
		end
	end
	pos = old
	return t
end


do
	local skip = {
		["local"] = 1,
		["break"] = 1,
		["if"] = 1,
		["else"] = 1,
		["then"] = 1,
		["until"] = 1,
		["while"] = 1,
		["return"] = 1,
		["function"] = 1,
		["end"] = 1,
	}
	local nogo = {
		["for"] = 1,
		["do"] = 1,
		["repeat"] = 1,
		["goto"] = 1,
		["::"] = 1,
	}

	local function SetIsWrite(exp, list, IsLeft)
		for i = 1, list and #list or 0, 2 do
			local IsLeft = IsLeft
			for i = list[i+1], list[i], -1 do
				local tok = exp[i]
				if tok.Kind == "variable" or tok.Kind == "field" or tok.s == "]" then
					tok.IsWrite = IsLeft
				elseif tok.s == "[" and tok.Kind ~= "string" then
					tok.IsWrite = exp[i + 1].IsWrite
				end
				IsLeft = false
			end
		end
	end

	-- Returns {LeftList}, {RightList}, Kind
	-- Lists: {start1, end1, start2, end2, ...}
	-- Kind: "=" or "in" or nil
	-- Function declaration is treated as assignment.
	-- Locals declaration without assignment turns into ({LeftList}, nil, nil)
	-- Any non-assignment statement involving some operation on variables or constants
	-- translates into (nil, {RightList}, nil).
	-- if-elseif blocks translate into RightList containing all conditions as separate items.
	function P.SplitAssignment(exp)
		local list1, list2, eq = {}, {}, nil
		local list = list1
		list[1] = 1
		list[2] = 0
		for i, tok in ipairs(exp) do
			local s = tok.s
			if nogo[s] or i == 1 and (s == "end" or s == ")" or s == "," or s == ";") then
				return
			elseif s == "(" and tok.Special == "function" and exp[i - 1].s ~= "function" then  -- named function
				eq = "="
				list = list2
				list[#list+1] = i
				list[#list+1] = i
			elseif skip[s] then
				if list[#list-1] == i then
					list[#list-1] = i + 1
				end
			elseif s ~= "=" and s ~= "in" and s ~= "," and s ~= "elseif" then
				list[#list] = i
			else
				if s == "=" or s == "in" then
					eq = tok.s
					list = list2
				end
				list[#list+1] = i + 1
				list[#list+1] = 0
			end
		end
		if list[2] == 0 then
			return  -- found nothing, e.g. "do", "break"
		end
		if list ~= list2 then  -- 1 side only
			if exp[1].s == "local" or exp[1].Special == "args" then
				list2 = nil
			else
				list1, list2 = nil, list1
			end
		end
		SetIsWrite(exp, list1, true)
		SetIsWrite(exp, list2)
		return list1, list2, eq
	end
end

function P.ParseConst(tok)
	return loadstring("return "..sub(str, tok.Start, tok.End - 1))()
end

P.ParseError = Error

function LL.str(val)
	if not val then
		return str
	end
	str = val
end
function LL.pos(val)
	if not val then
		return pos
	end
	pos = val
end
function LL.C()
	return C
end
function LL.Parsers()
	return Parsers
end
function LL.E()
	return E
end
P.GetList = LL.E

LL.SNewLine = SNewLine
LL.SLeftSide = SLeftSide
LL.SLocals = SLocals
LL.SRightSide = SRightSide

function P.Options.AddOperators(binary, ...)
	Reg(binary and BinOp or UnOp, ...)
	RebuildParsers()
end

function LL.Reg(...)
	Reg(...)
	RebuildParsers()
end

P.new = debug_getinfo and debug_getinfo(1, "f").func

return P