--[[
ShortFunctions v0.0
(c) 2016 Sergey Rozhenko, MIT license

Inspired by short functions from MetaLua, but significantly more powerful.

Syntax:
CanShow = || Q.ExampleQuest == "Done"
mul2 = |x| x*2
sum = |x, y| x + y
xy = (|x, y| x, y )
setXY = (|x, y| x, y = 1, 2 )
print12 = (|| print(1); print(2) )
loop = || for i = 1, 2 do  print(i)  end
BadIdea = |x)
  return x*2
end
function BadIdea2(x| x*2

--]]
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local ipairs = ipairs
local string_sub = string.sub
local table_concat = table.concat
local debug_getupvalue = debug.getupvalue
local debug_setupvalue = debug.setupvalue
local parse = dofile(debug.getregistry().CoreScriptsPath.."RSParseLua.lua")
local LL = parse.LowLevel
local _E, C = LL.E, LL.C
local SNewLine = LL.SNewLine
local SLeftSide = LL.SLeftSide
local SLocals = LL.SLocals
local SRightSide = LL.SRightSide
parse.Options.BuildTree = false
local CharEqual, CharOpen = ("=("):byte(1, -1)

----------- No globals from this point ------------

local _NOGLOBALS

----------- Convert ------------

local RepList, RepPlace
local function Replace(n, new, len)
	RepPlace = RepPlace or 1
	if RepPlace > 0 then
		RepList[#RepList + 1] = string_sub(LL.str(), RepPlace or 1, n - 1)
	end
	RepList[#RepList + 1] = new
	RepPlace = n + len
	return #RepList
end

LL.Reg(function()
	local E, C = _E(), C()
	local pos = LL.pos() - 1
	if E.Special ~= "args" then  -- left |
		Replace(pos, "function(", 1)
		local enclosed = (E.Kind == "(" and not E.ParentToken.IsCall and not E.ExpCount and not E.Exp[2])  -- first in the list
		C.Token = "function"
		LL.Block(SLocals, -SRightSide)
		E = _E()
		E.Special = "args"
		E.ShortFunctionEnclosed = enclosed
	else  -- right |
		E.Special = nil
		LL.StoreTokenEnd()
		C.Token = "return"
		LL.StoreTokenStart()
		LL.GetToken().ShortFunctionReturn = true
		LL.SetNewLine()
		E.State = SRightSide
		E.ShortFunction = Replace(pos, ")", 1)
	end
end, "|")

local LastTok

function parse.Options.OnExpEnd(E, exp)
	E.LastExp = exp
	LastTok = max(LastTok, (exp[#exp] or {}).End)
	if E.ShortFunction and not E.ShortFunctionEnclosed and (exp[2] or not exp[1].ShortFunctionReturn or LL.GetToken().s == "," or LL.GetToken().s == ";") then
		E.ShortFunctionDone = true
		LL.End()
	end
end

local function FindToken(exp, s)
	for i, tok in ipairs(exp) do
		if tok.s == s then
			return i
		end
	end
end

function parse.Options.OnListEnd(E)
	if not E.ShortFunction then
		return
	end
	local exp = E.LastExp
	if exp[1].ShortFunctionReturn and exp[2] and not FindToken(exp, "=") and (exp[2].s ~= "function" or (exp[3] or {}).s == "(") and (exp[2].s ~= "do") then
		RepList[E.ShortFunction] = ") return "
	end
	Replace(LastTok, " end ", 0)
	if not E.ShortFunctionDone then
		LL.End()
		LL.NewStatement()
	end
end

local oldComma = LL.Parsers()[","]
LL.Reg(function(...)
	while _E().Special == "until" or _E().ShortFunction and not _E().ShortFunctionEnclosed do
		LL.NewStatement()
	end
	return oldComma(...)
end, ",")

local function ConvertStr(str, chunk)
	RepList, RepPlace, LastTok = {}, nil, 0
	local s = parse.CheckStr(str, chunk)
	Replace(0, nil, 0)
	return table_concat(RepList), s
end

----------- HookParser ------------

local function GetUpvalue(f, Name, NeedIndex)
	local name, val
	local up = 0
	repeat
		up = up + 1
		name, val = debug_getupvalue(f, up)
	until name == Name or name == nil
	return NeedIndex and up or val, up
end

local function HookParser(P)
	local Reg = GetUpvalue(P.Options.AddOperators, "Reg")
	local CheckStr = P.CheckStr
	local strN = GetUpvalue(CheckStr, "str", true)
	local posN = GetUpvalue(CheckStr, "pos", true)
	local LL = P.LowLevel	
	Reg(function()
		parse.Options.NameCharCodes = P.Options.NameCharCodes
		parse.Options.SpaceCharCodes = P.Options.SpaceCharCodes
		-- ignore stuff added by AddOperators, I don't use it
		local _, str = debug_getupvalue(CheckStr, strN)
		local str, err = ConvertStr(str)
		debug_setupvalue(CheckStr, strN, str)
		if err then
			GetUpvalue(CheckStr, "C").Error = err
			debug_setupvalue(CheckStr, posN, #str + 1)
		else
			local _, pos = debug_getupvalue(CheckStr, posN)
			debug_setupvalue(CheckStr, posN, pos - 1)
			if LL then
				LL.TokenInfo{Cancel = true}
			end
		end
	end, "|")
	P.Options.AddOperators()
	function P.GetConvertedStr()
		local _, str = debug_getupvalue(CheckStr, strN)
		return str
	end
	local new = P.new
	P.new = new and function(...)
		return HookParser(new(...))
	end
	return P
end

return {ConvertStr = ConvertStr, HookParser = HookParser}
