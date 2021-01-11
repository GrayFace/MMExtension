--[[
Help commands:

Force no help:
--!-

Force help for a function:
--!+ description

Make help for a variable:
--!v

Make a new help entity not related to particular code (may be followed by more ++ commands):
--++(NewName)

Treat a local as local from parent's scope (to add fields to a table in parent scope):
--!ParentLocal(LocHere=ParentLoc)

Description for file with functions:
--!File

Description for file with events:
--!Events

Commands below may be combined:

Set name:
--!n(NewName)

Set parameters:
--!(params) desctiption

Set array part of table (and possibly the start of fields part):
--!a{params}

Add fields to fields part of table (that would be sorted alphabetically):
--!k{key1, key2 description,-key3}
would add key1, add key2 with description, delete key3

Set a certain kind:
--!t(kind)
Currently supported kinds: function, event
]]

local abs, floor, ceil, max, min = math.abs, math.floor, math.ceil, math.max, math.min
local type = type
local pairs = pairs
local ipairs = ipairs
local setmetatable = setmetatable
local assert = assert
local error = error
local _loadstring = loadstring or load
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
local HasGoto = _loadstring("::a::") and true
local Lua52 = HasGoto and (_VERSION ~= "Lua 5.1")
local LuaJIT = _loadstring("#") and true  -- jit.* might be hidden

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

local _G = getfenv(1)
local loadfile = loadfile
local print = print
local dump = dump
local next = next
local rawget = rawget
local getmetatable = getmetatable
local concat = table.concat
local t_remove = table.remove
local sortpairs = sortpairs

----------- No globals from this point ------------

local _NOGLOBALS

----------- Main Vars ------------

local P = {Options = {}}
local str, pos, C, globals  -- C for common state, globals for known globals
local E, locals  -- E for current ExpList state

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

local function MatchPattern(s)
	local n, n1 = match(str, s.."()", pos)
	C.LastCapture = n
	pos = (n1 or n or pos)
	return n
end

local function Error(s, ...)
	local p, n = pos, 1  -- find line number
	pos = 1
	while MatchPattern("([\r\n])") and pos < p do
		if C.LastCapture == "\r" then
			MatchStr("\n")
		end
		n = n + 1
	end
	C.Error = C.Error or format(s, n, ...)
	pos = #str + 1
end

----------- HelpStructs ------------

local banned = {
	-- std
	assert = true,
	collectgarbage = true,
	["coroutine.create"] = true,
	["coroutine.resume"] = true,
	["coroutine.running"] = true,
	["coroutine.status"] = true,
	["coroutine.wrap"] = true,
	["coroutine.yield"] = true,
	["debug.debug"] = true,
	["debug.getfenv"] = true,
	["debug.gethook"] = true,
	["debug.getinfo"] = true,
	["debug.getlocal"] = true,
	["debug.getmetatable"] = true,
	["debug.getregistry"] = true,
	["debug.getupvalue"] = true,
	["debug.setfenv"] = true,
	["debug.sethook"] = true,
	["debug.setlocal"] = true,
	["debug.setmetatable"] = true,
	["debug.setupvalue"] = true,
	["debug.traceback"] = true,
	dofile = true,
	error = true,
	["file:close"] = true,
	["file:flush"] = true,
	["file:lines"] = true,
	["file:read"] = true,
	["file:seek"] = true,
	["file:setvbuf"] = true,
	["file:write"] = true,
	getfenv = true,
	getmetatable = true,
	["io.close"] = true,
	["io.flush"] = true,
	["io.input"] = true,
	["io.lines"] = true,
	["io.open"] = true,
	["io.output"] = true,
	["io.popen"] = true,
	["io.read"] = true,
	["io.stderr"] = true,
	["io.stdin"] = true,
	["io.stdout"] = true,
	["io.tmpfile"] = true,
	["io.type"] = true,
	["io.write"] = true,
	ipairs = true,
	load = true,
	loadfile = true,
	loadstring = true,
	["math.abs"] = true,
	["math.acos"] = true,
	["math.asin"] = true,
	["math.atan"] = true,
	["math.atan2"] = true,
	["math.ceil"] = true,
	["math.cos"] = true,
	["math.cosh"] = true,
	["math.deg"] = true,
	["math.exp"] = true,
	["math.floor"] = true,
	["math.fmod"] = true,
	["math.frexp"] = true,
	["math.huge"] = true,
	["math.ldexp"] = true,
	["math.log"] = true,
	["math.log10"] = true,
	["math.max"] = true,
	["math.min"] = true,
	["math.modf"] = true,
	["math.pi"] = true,
	["math.pow"] = true,
	["math.rad"] = true,
	["math.random"] = true,
	["math.randomseed"] = true,
	["math.sin"] = true,
	["math.sinh"] = true,
	["math.sqrt"] = true,
	["math.tan"] = true,
	["math.tanh"] = true,
	module = true,
	next = true,
	["os.clock"] = true,
	["os.date"] = true,
	["os.difftime"] = true,
	["os.execute"] = true,
	["os.exit"] = true,
	["os.getenv"] = true,
	["os.remove"] = true,
	["os.rename"] = true,
	["os.setlocale"] = true,
	["os.time"] = true,
	["os.tmpname"] = true,
	["package.cpath"] = true,
	["package.loaded"] = true,
	["package.loaders"] = true,
	["package.loadlib"] = true,
	["package.path"] = true,
	["package.preload"] = true,
	["package.seeall"] = true,
	pairs = true,
	pcall = true,
	print = true,
	rawequal = true,
	rawget = true,
	rawset = true,
	require = true,
	select = true,
	setfenv = true,
	setmetatable = true,
	["string.byte"] = true,
	["string.char"] = true,
	["string.dump"] = true,
	["string.find"] = true,
	["string.format"] = true,
	["string.gmatch"] = true,
	["string.gsub"] = true,
	["string.len"] = true,
	["string.lower"] = true,
	["string.match"] = true,
	["string.rep"] = true,
	["string.reverse"] = true,
	["string.sub"] = true,
	["string.upper"] = true,
	["table.concat"] = true,
	["table.insert"] = true,
	["table.maxn"] = true,
	["table.remove"] = true,
	["table.sort"] = true,
	tonumber = true,
	tostring = true,
	type = true,
	unpack = true,
	xpcall = true,
}

P.IgnoreNames = banned
P.EventCalls = {}

local Help
local NewEntities  -- added with ++
-- local _ArrayStart = {}
-- local _ArrayEnd = {}

local function MatchCommentCmd(h)
	local s = h[1]
	
	-- --!++(name)
	local new, s1 = s:match("^%+%+(%b())(.*)")
	if new and NewEntities then
		NewEntities[#NewEntities + 1] = new:sub(2, -2)
	end
	s = s1 or s
	
	-- --!+
	s = s:match("^%+(.*)") or s
	
	-- --!v
	local s1 = s:match("^v(.*)")
	h.Kind = not s1 and h.Kind or nil
	s = s1 or s
	
	-- --!n(name)
	local cmd, s1 = s:match("^n(%b())(.*)")
	h.Name = cmd and cmd:sub(2, -2) or h.Name
	s = s1 or s

	-- --!t(kind)
	local cmd, s1 = s:match("^t(%b())(.*)")
	h.Kind = cmd and cmd:sub(2, -2) or h.Kind
	s = s1 or s

	-- --!a{array part of table}
	local cmd, s1 = s:match("^a(%b{})(.*)")
	cmd = cmd and cmd:sub(2, -2)
	if cmd and cmd ~= "" then
		-- add ";" at the end of one-liner, remove \n at the end of multiline
		cmd = cmd:match("\n") and cmd:match("^(.-)\r?\n?$") or cmd:match("^(.-)[,;]?$")..";"
	end
	h.ArrayText = cmd and cmd or h.ArrayText
	s = s1 or s
	
	-- --!k{key1,key2,key3}
	local cmd, s1 = s:match("^k(%b{})(.*)")
	h.AdditionalKeys = cmd and cmd:sub(2, -2) or h.AdditionalKeys
	s = s1 or s
	
	-- --!(params)
	local sig, s1 = s:match("^(%b())(.*)")
	h.Sig = sig and sig:sub(2, -2) or h.Sig
	s = s1 or s
	
	h[1], s1 = s, s ~= s
	return s1
end

local function ProcessComment(h, c)
	if c then
		local t = {}
		if type(c) == "string" then
			t[1] = c
		else
			for i = 1, #c, 2 do
				t[#t+1] = sub(str, c[i], c[i+1]-1)
				if i > 1 then
					t[#t] = t[#t]:match("^ ?(.*)")
				end
			end
		end
		local s = concat(t, "\n")
		if s:sub(1, 1) == "!" then
			if s:sub(2, 2) == "-" then
				return
			end
			h[1] = s:sub(2, -1)
			while MatchCommentCmd(h) do
			end
			s = h[1]
		end
		h[1] = s:match("^[ \r\n\t]+(.-)[ \r\n\t]*$")
	end
	return h
end

local function AddHelp(h)
	if not h then
		return
	end
	for i = 2, #Help do
		if Help[i].Name == h.Name and h.Kind == Help[i].Kind then
			return
		end
	end
	Help[#Help + 1] = h
end

-- local function Exists(name)
-- 	if not P.ExistsCheck then
-- 		return true
-- 	end
-- 	local t = _G
-- 	for s in name:gmatch("[^%.:]+") do
-- 		if s ~= "" then
-- 			if type(t) == "table" then
-- 				t = t[s]
-- 			else
-- 				t = nil
-- 			end
-- 		end
-- 	end
-- 	return t
-- end

local function HelpFunction(name, sig, comment)
	C.Comment = nil
	local pre, post = name:match("^([^%.:]*)%.(.*)")
	if pre == "_G" or Lua52 and pre == "_ENV" then  -- get rid of _G prefix
		name = post
		pre, post = name:match("^([^%.:]*)%.(.*)")
	end
	if banned[name] or pre and banned[pre] or banned[name:gsub(":", ".")] then
		return
	end
	AddHelp(ProcessComment({Name = name, Kind = "function", Sig = sig}, comment))
end

local function ProcessFields(fields)
	local t = {}
	local s = fields.ArrayText or sub(str, fields.ArrayStart, fields.ArrayEnd - 1)
	if s ~= "" then
		s = "{"..s
	else
		s = "{"
	end
	local add = fields.AdditionalKeys or ""
	for _, s in ipairs(add:split(add:match("^([^%w_%-])") or ",")) do
		if s ~= "" then
			local del, k, v = s:match("(%-?)([%w_]+)(.*)")
			if del == "" or not k then
				fields.Fields[k or s] = v or ""
			else
				fields.Fields[k] = nil
			end
		end
	end
	for s, v in sortpairs(fields.Fields) do
		if type(s) == "string" then
			local c = ProcessComment({}, v)[1] or ""
			local c1, c2 = c:match("^(:[^ ]+) ?(.*)")
			c = c2 or c
			-- local c2, c3 = c:match("^(%b[]) ?(.*)")
			local c2, c3 = c:match("^(%b[])( ?)$")
			c = c3 or c
			t[#t+1] = "  "..s..(c1 or "")..(c2 and " "..c2 or "")..(c ~= "" and " = "..c or "")
		end
	end
	if not next(t) then
		return s.."}"
	end
	t[#t] = t[#t]:match("^(.-)[ \r\n\t]*$")
	return s.."\n"..concat(t, "\n").."\n}"
end

--[=[
Supports out of the box:
events.cocall("name", params...)
event("name", params...)

Not out the box, but possible with HelpHook:
events.name(params)
event([[name]], params...)
]=]
local function HelpEvent(sig, comment, more)
	local info = ProcessComment({}, comment)
	local t = sig:split(",")
	if P.EventHook then
		P.EventHook(t, more)
	end
	local name = t[1]
	t_remove(t, 1)
	-- expand tables...
	for i = 1, #t do
		local s1, s, s2 = t[i]:match("^([ \r\n\t]+)(.-)([ \r\n\t]*)$")
		local fields = locals[s]
		if type(fields) == "table" and fields.Fields then
			fields.ArrayText = info and info.ArrayText
			fields.AdditionalKeys = info and info.AdditionalKeys
			t[i] = s1..ProcessFields(fields)..s2
		end
	end
	sig = concat(t, ","):match("^[ \r\n\t]*(.-)[ \r\n\t]*$")
	-- handle the (cond and "Event1" or "Event2") case too
	for name in name:gmatch("[\"'](.-)[\"']") do
		AddHelp(ProcessComment({Name = name, Kind = "event", Sig = sig}, comment))
	end
end

local function ParentLocal(s)
	local last = getmetatable(locals).__index
	for new, old in s:gmatch("([%w_]+) *= *([%w_]+)") do
		locals[new] = last[old]
	end
end

----------- Space and comments ------------

local SpaceCodes = {[32] = true}
for i = 9, 13 do
	SpaceCodes[i] = true
end
P.Options.SpaceCharCodes = SpaceCodes

local function Space(main)
	local function CheckAnyComment(comment)
		if comment and str:match("^!%+%+%(", comment[1]) then
			NewEntities = {}
			ProcessComment({}, comment, true)
			local t = NewEntities
			NewEntities = nil
			for _, name in ipairs(t) do
				AddHelp(ProcessComment({Name = name, Kind = "function"}, comment))
			end
		end
	end
	local function CheckFileComment(comment)
		if comment and str:match("^!File", comment[1]) then
			comment[1] = comment[1] + 5
			ProcessComment(Help[1], comment)
			-- print(dump(Help[1]))
			return true
		elseif comment and str:match("^!Events", comment[1]) then
			comment[1] = comment[1] + 7
			local t = {}
			ProcessComment(t, comment)
			Help[1].EventsInfo = t[1]
			-- print(dump(Help[1]))
			return true
		-- elseif comment and str:match("^!%+%+%(", comment[1]) then
		-- 	NewEntities = {}
		-- 	ProcessComment({}, comment, true)
		-- 	local t = NewEntities
		-- 	NewEntities = nil
		-- 	for _, name in ipairs(t) do
		-- 		AddHelp(ProcessComment({Name = name, Kind = "function"}, comment))
		-- 	end
		end
	end
	
	local comment
	local short
	local newline = (pos == 1)
	while true do
		local v = byte(str, pos)
		if v == 10 then
			if newline then
				CheckAnyComment(comment)
				comment = nil
			end
			newline = true
		end
		if SpaceCodes[v] then
			pos = pos + 1
		elseif v == 0x2D and MatchStr("--") then
			-- if main and Help[1].Name == "timers.lua" then
			-- 	print(str:match("(.-)[\r\n]", pos))
			-- end
			local last = comment
			-- if not MatchPattern("^%[(=*)%[.-%]%1%]") and not MatchPattern("[\r\n]") then
			-- 	pos = #str + 1
			-- end
			if MatchPattern("^%[(=*)%[") then
				comment = {pos}
				MatchPattern("()%]"..C.LastCapture.."%]")
				comment[2] = C.LastCapture
				comment = newline and comment
				short, newline = nil, nil
			else
				comment = short and not str:match("^!%+%+%(", pos) and comment or {}
				comment[#comment + 1] = pos
				if MatchPattern("^!ParentLocal(%b())") then
					ParentLocal(C.LastCapture:sub(2, -2))
				-- elseif str:match("^!%+%+%(", pos) then
				-- 	NewEntities = {}
				-- 	ProcessComment({}, {pos}, true)
				-- 	local t = NewEntities
				-- 	NewEntities = nil
				-- 	for _, name in ipairs(t) do
				-- 		AddHelp(ProcessComment({Name = name, Kind = "function"}, {pos}))
				-- 	end
				end
				if not MatchPattern("()[\r\n]") then
					pos = #str + 1
				elseif byte(str, pos - 1) == 13 and byte(str, pos) == 10 then
					pos = pos + 1
				end
				comment[#comment + 1] = C.LastCapture
				comment = newline and comment
				short, newline = true, true
			end
			if main and comment ~= last then
				CheckFileComment(last)
			end
			if comment ~= last then
				-- CheckAnyComment(comment)
				CheckAnyComment(last)
			end
		else
			CheckAnyComment(comment)
			if main == true and newline then
				if CheckFileComment(comment) then
					comment = nil
				end
				C.Comment = comment
				C.TokenPos = pos
			end
			return v
		end
	end
end

local function Name()
	local old = pos
	while NameCodes[byte(str, pos)] do
		pos = pos + 1
	end
	return sub(str, old, pos - 1)
end

----------- Parsers ------------

local Parsers = {}

local SLeftSide = 1
local SLocals = 2
local SRightSide = 3
-- negative state means a variable has been read, binary operator or new statement is expected
local SNewLine = -SLeftSide

local function Reg(f, op, ...)
	Parsers[op] = f
	return (...) and Reg(f, ...) or f
end

local function StoreLocals(donot)
	if donot then
		return
	end
	for k, v in pairs(E.Locals) do
		locals[k] = v
	end
	E.Locals = {}
	if E.OnNewStatement then
		E.OnNewStatement()
	end
end

local function AssignLocal(loc, name, val)
	while not rawget(loc, name) do
		loc = getmetatable(loc).__index
	end
	loc[name] = val
end

-- ExpList
local function ExpList(BaseState, RetState, IsBlock)
	local p1 = pos
	local fields
	local Last, LastLocals = E, locals
	E.State = RetState or -abs(E.State)
	E = {State = BaseState or SNewLine, Locals = {}, IsBlock = IsBlock, Token = C.Token, Last = Last}
	locals = IsBlock and setmetatable({}, {__index = locals}) or locals
	function E.End()
		locals = LastLocals
		E = Last
		-- detect events 2
		local last = (E.CurInfo == "(" and E.LastInfo)
		if type(last) == "table" and last.IsEvent then
			HelpEvent(sub(str, p1, pos - 2), last.Comment, last)
		end
		-- detect table fields
		if fields then
			fields.ArrayEnd = fields.ArrayEnd or pos - 1
		end
	end
	-- detect table fields:  t = {...} case
	local a0, a1, a2, a3 = Last.CurInfo, Last.LastInfo, Last.LastInfo2, Last.LastInfo3
	local IsFine = (a3 ~= "." and a3 ~= ":" and a3 ~= ",")
	local IsCurLocal = (Last.Locals and Last.Locals[a2])
	if a0 == "{" and a1 == "=" and IsFine and (IsCurLocal or LastLocals[a2]) then
		fields = {ArrayStart = pos, Fields = {}}
		E.Fields = fields
		if IsCurLocal then
			Last.Locals[a2] = fields
		else
			AssignLocal(LastLocals, a2, fields)
		end
	end
end

local function Block(BaseState, RetState)
	StoreLocals()
	ExpList(BaseState, RetState or SNewLine, true)
end

-- vars
local function VarName(s, newF)
	-- skip after '.' and ':'
	if E.LastInfo == "." or E.LastInfo == ":" then
		E.State = -max(E.State, SLeftSide)
		-- detect events
		local last = E.LastInfo2
		if type(last) == "table" and last.Events and last.Events[s] then
			E.CurInfo = {s, IsEvent = true, Comment = last.Comment}
		else
			E.CurInfo = {s}
		end
		E.CurInfo.DotParent = last
		-- detect table fields
		if type(last) == "table" and last.IsLocal then
			local t = locals[last[1]]
			if type(t) == "table" and t.Fields then
				t.Fields[s] = t.Fields[s] or last.Comment or {}
			end
		end
		return
	end
	
	StoreLocals(E.State > 0)
	if s == "" then  -- parse error
		-- pos = #str + 1
		if pos <= #str then
			s = Name()
			Error("%d: HelpParse parser failure near %q", (s ~= "" and s or sub(str, pos, pos)))
		end
	elseif abs(byte(s) - 0x35 + 0.5) < 5 then  -- number
		MatchPattern("^%.[0-9a-fA-FpP]*")
		s = match(str, "^[eEpP]", pos - 1) and MatchPattern("^[%+%-][0-9]+")  -- general form
	elseif E.Token == "{" and abs(E.State) < SRightSide and Space() and match(str, "^=", pos) then
		-- table field declaration (do nothing)
		-- detect table fields
		if E.Fields then
			local t = E.Fields
			t.Fields[s] = C.Comment or {}
			t.ArrayEnd = t.ArrayEnd or E.LastInfo and C.TokenPos or 1
		end
	elseif E.State == SLocals then  -- new local
		E.Locals[s] = true
	else
		local IsGlobal = not locals[s]
		if IsGlobal then  -- variable access
			globals[s] = true
			-- if this is a module with modified fenv, skip it
			if s == "module" and E.State < 0 and C.Token == s then
				pos = #str + 1
			end
			-- handle "local table = table" situation
			if E.State == SRightSide and next(E.Locals) and not next(E.Locals, next(E.Locals)) then
				if not match(str, "^ *[%.:%({*/%^%%<>=~]", pos) then  -- not a call etc.
					E.Locals[next(E.Locals)] = { Replace = s }
				end
			end
		else
			-- detect functions globalization ("persist = doperstist" after "local dopersist")
			local a1, a2 = E.LastInfo, E.LastInfo2
			if type(locals[s]) == "table" and locals[s].Func and a1 == "=" and type(a2) == "table" then
				local fname = ""
				while type(a2) == "table" and a2.DotParent do
					fname = "."..a2[1]..fname
					a2 = a2.DotParent
				end
				local loc = (type(a2) == "table" and a2.IsLocal and locals[a2[1]])
				if type(loc) == "table" and loc.Replace then
					fname = loc.Replace..fname
				elseif type(a2) == "table" and a2.IsGlobal then
					local s1 = a2[1]
					fname = a2[1]..fname
				else
					fname = nil
				end
				local sig, comment = unpack(locals[s].Func)
				fname = fname and not str:match("^ *[%.:%({*/%^%%<>=~]", pos) and HelpFunction(fname, sig, C.Comment or comment)
			end
		end
		E.CurInfo = {s, Comment = C.Comment}
		-- detect events
		if C.Token ~= "function" and P.EventCalls[s] then
			E.CurInfo.IsEvent = true
			E.CurInfo.Events = P.EventCalls[s]
		end
		-- --!+ to force function creation, --!v for variables
		if IsGlobal and C.Comment and str:match("^![%+v]", C.Comment[1]) then
			local s1 = str:match("^[%w_%.:]*", pos)
			if not str:match("^ *[%({*/%^%%<>~]", pos + #s1) then
				HelpFunction(s..s1, nil, C.Comment)
			end
		end
		-- detect table fields and functions globalization
		E.CurInfo.IsLocal = not IsGlobal
		E.CurInfo.IsGlobal = IsGlobal
		E.CurInfo.LastInfo = E.LastInfo
	end
	E.State = -max(E.State, SLeftSide)
end

Reg(function()
	E.State = -SRightSide
end, "...")

-- unary operations
local UnOp = Reg(function()
end, "#", "not")

-- binary operations
local BinOp = Reg(function()
	E.State = abs(E.State)
end, '+', '-', '*', '/', '^', '%', '..', '<', '<=', '>', '>=', '==', '~=', 'and', 'or', '.', ':')
-- Lua53 binary operators, also may be in Lua patches ('\' is added for possible patches)
for _, op in ipairs{'//', '&', '~', '|', '>>', '<<', '\\'} do
	if _loadstring("return a"..op.."a") then
		Reg(BinOp, op)
	end
end

-- string
Reg(function(chr)
	while MatchPattern("(["..chr.."\\])") and C.LastCapture == "\\" do
		pos = pos + 1
	end
	E.State = -SRightSide
end, "'", '"')

-- -- '.', ':'
-- Reg(function()
-- 	Name(Space())
-- end, ".", ":")

-- brackets
Reg(function()
	if MatchPattern("^(=*)%[.-%]%1%]") then  -- long string
		E.State = -SRightSide
	else
		ExpList(SRightSide)
	end
end, "[")

Reg(function()
	ExpList(SRightSide)
end, "(")

Reg(function()
	ExpList(SNewLine)
end, "{")

-- assignment
Reg(function()
	E.State = SRightSide
end, "=", "in")

-- local
Reg(function()
	StoreLocals()
	E.State = SLocals
end, "local")

-- if, while, return
Reg(function()
	StoreLocals()
	E.State = SRightSide
end, "if", "while", "return")

-- line ends
local SetNewLine = Reg(function()
	StoreLocals()
	E.State = SNewLine
end, ";", "break")

Reg(function()
	E.State = (E.Token == "{" and SNewLine or abs(E.State))
end, ",")

-- expression list ends
Reg(function()
	StoreLocals()
	E.End()
end, "]", "}", ")", "end")

Reg(function()
	StoreLocals()
	E.End()
	E.State = SRightSide
end, "elseif")

Reg(function()
	E.OnNewStatement = E.End
	E.State = SRightSide
end, "until")

Reg(function()
	StoreLocals()
	E.End()
	Block()
end, "else")

-- blocks
Reg(function()
	Block()
end, "repeat", "then")

Reg(function()
	if E.Token == "for" then
		E.Token = "do"
		return SetNewLine()
	end
	Block()
end, "do")

-- for
Reg(function()
	Block(SLocals)
end, "for")

local function ExpandFunctionArg(help, arg)
	local fields = {Fields = {}, ArrayText = help.ArrayText or "...;", AdditionalKeys = help.AdditionalKeys}
	locals[arg] = fields
	local old = E.End
	function E.End()
		if next(fields.Fields) then
			help.Sig = ProcessFields(fields)
		end
		old()
	end
end

-- function
Reg(function()
	local self
	local IsLocal = (E.State == SLocals)
	local fname = (E.State ~= SRightSide)
	if fname then
		StoreLocals(E.State > 0)
		Space()

		local p1 = pos
		local prefix = ""

		local s = Name()
		
		local p2 = pos
		if not IsLocal then
			local loc = locals[s]
			if type(loc) == "table" and loc.Replace then
				prefix = loc.Replace
				p1 = pos
			elseif loc and s ~= "_G" and (s ~= "_ENV" or not Lua52) then
				IsLocal = true
			end
		end
		
		while Space() and MatchPattern("^([%.:])") do
			self = (C.LastCapture == ":")
			Name(Space())
			p2 = pos
			fname = not IsLocal
		end
		VarName(s, self == nil)
		fname = fname and p2 > p1 and prefix..sub(str, p1, p2-1)
	end
	local comment = C.Comment
	Block(SNewLine, (E.State == SRightSide and -SRightSide or SNewLine))
	locals.self = self or nil
	Space()
	C.Token = MatchStr("(")
	local p1 = pos
	ExpList(SLocals, SNewLine)
	local old = E.End
	function E.End()
		old()
		local t = {sub(str, p1, pos - 2), comment}
		if IsLocal and E.Last.Locals[fname] then
			E.Last.Locals[fname] = {Func = t}
		elseif IsLocal and fname then
			-- detect functions globalization ("persist = doperstist" after "local dopersist")
			AssignLocal(getmetatable(locals).__index, fname, {Func = t})
		elseif fname then
			HelpFunction(fname, unpack(t))
			if Help[#Help].Name == fname and Help[#Help].Sig == "t" then
				ExpandFunctionArg(Help[#Help], t[1])
			end
		end
	end
end, "function")

-- goto
Parsers["goto"] = HasGoto and function(s)
	if not E.IsBlock or E.State > SNewLine or Name(Space()) == "" then
		return VarName(s)
	end
	E.State = SNewLine
end

Parsers["::"] = HasGoto and function()
	Space(Name(Space()))
	MatchPattern("::")
	E.State = SNewLine
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
		if NotName(s, 1) then
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
		local s = FindToken(TokenLists[Space(true)]) or Name()
		if s == "" and P.Options.SkipUnknown then
			pos = pos + 1
		else
			C.Token = s
			E.LastInfo4 = E.LastInfo3
			E.LastInfo3 = E.LastInfo2
			E.LastInfo2 = E.LastInfo
			E.LastInfo = E.CurInfo
			E.CurInfo = s
			-- print(s, E.State, E.Token)--, pos)
			;(Parsers[s] or VarName)(s)
		end
	end
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
	str = fstr
	pos = 1
	C = {}
	P.Help = {{Kind = "file", Name = (GetChunkName(chunk) or "?"):match("[^\\/:]*$")}}
	Help = P.Help
	globals = getfenv(type(chunk) == "function" and chunk or 1)
	globals = setmetatable({}, {__index = globals})
	locals = {["nil"] = true, ["false"] = true, ["true"] = true}
	E = {Locals = {}}
	if Lua52 then
		locals._ENV = true
	end
	MatchStr("\239\187\191")  -- UTF-8 BOM
	MatchPattern("^#[^\r\n]*")  -- Unix exec. file?
	Block()
	ParseLoop()
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
	P.Help = {}
	local d = debug_getinfo and debug_getinfo(f, "fS")
	local fname = d and d.source and match(d.source, "^@(.*%.[lL][uU][aA])$")
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
	P.Help = {}
	local f, s = loadfile(fname)
	local s = f and DoCheckChunkFile(f, "^@(.+)") or s
	if s and raise then
		error(s, raise)
	end
	return s
end

function P.GetLastUsedGlobals()
	setmetatable(globals, nil)
	return globals
end

function P.Options.AddOperators(binary, ...)
	Reg(binary and BinOp or UnOp, ...)
	RebuildParsers()
end

P.new = debug_getinfo and debug_getinfo(1, "f").func

return P