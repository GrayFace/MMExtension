local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
HelpStructs = {}
HelpStructsForVer = {}
local _KNOWNGLOBALS_F

local mem_internal = internal.mem_internal
local structs_name_t = internal.structs_name_t
local getdefine = mem.structs.getdefine
local types = mem.structs.types

local next_field_t = {}
local Help = HelpStructsForVer

-----------------------------------------------------
-- configure help parser
-----------------------------------------------------

local parse = require"HelpParse"

table.copy({
	events = true,
	internal = true,
	DataTables = true,
	PrintToFile = true,
}, parse.IgnoreNames)

table.copy({
	events = {
		call = true,
		pcall = true,
		pcalls = true,
		cocall = true,
		cocalls = true,		
	},
	MapCheckHook = true,
}, parse.EventCalls)

function parse.EventHook(t, more)
	if more[1] == "MapCheckHook" then
		table.remove(t, 1)
	end
end

-----------------------------------------------------
-- intercept structs
-----------------------------------------------------

local function NewHelpStruct(t, a)
	local v = {Fields = {}, Functions = {}, Methods = {}}
	rawset(t, a, v)
	return v
end

local function Help_DefineStruct(define, a, kind)
	local name = "structs."..a
	define.rofields[structs_name_t] = name
	define.rofields[next_field_t] = {}
	HelpStructs[name] = {{Kind = kind or "struct", Name = name}}
end

local function structs_index(t, a)
	local v = rawget(structs, "f")[a]
	if assert(v, a) then
		local class = {}
		rawset(structs, a, class)
		return mem.struct(function(define, ...)
			structs.o[a] = define.offsets
			structs.m[a] = define.members
			define.class[structs_name_t] = a
			Help_DefineStruct(define, a)
			return v(define, ...)
		end, class)
	end
end

-- hook into Evt commands
local old = mem.struct
function mem.struct(f, ...)
	local loc = debug.findlocal(2, "offs0") and debug.findlocal(2, "name")
	local locNum = debug.findlocal(2, "num")
	if loc and locNum then
		local _, name = debug.getlocal(2, loc)
		local _, num = debug.getlocal(2, locNum)
		name = ("%.2d.evt.%s"):format(num, name)
		return old(function(define, ...)
			define.class[structs_name_t] = name
			Help_DefineStruct(define, name)
			return f(define, ...)
		end, ...)
	end
	return old(f, ...)
end

function mem_internal.member_callback(name, define, newfields, newoffs, newrofields)
	local oldname = define.rofields[structs_name_t]
	local t = oldname and HelpStructs[oldname]
	if t == nil or name == '' then
		return
	end
	local NextField = define.rofields[next_field_t]
	NextField.Name = name
	t[#t + 1] = NextField
	if name == "Player" and oldname and oldname:match("structs%.%d%d%.evt%.") then
		NextField.Type = "evt.Players"
	end
	if newrofields then
		local newname = oldname..'.'..name
		NextField.Type = newname
		HelpStructs[newname] = {{Kind = "struct", Name = newname, Embed = true}}
		newrofields[structs_name_t] = define.rofields[structs_name_t]..'.'..name
		newrofields[next_field_t] = {}
	end
	define.rofields[next_field_t] = {}
end

function types.Info(info)
	local t = HelpStructs[getdefine().rofields[structs_name_t]]
	if type(info) == "table" then
		if info.new or info.New then
			info.new, info.New = nil, nil
			t[#t + 1] = info
		else
			table.copy(info, t[#t], true)
		end
	elseif info == false then
		if #t > 1 then
			t[#t] = nil
		else
			t[1].Ignore = true
		end
	else
		t[#t][1] = info
	end
	return getdefine()
end

local function wrap(name, f)
	local old = types[name]
	types[name] = function(...)
		return f(old, ...)
	end
end

local function mystruct(old, f, ...)
	if type(f) == "function" then
		f = mem.struct(f)
		if f == nil then
			return getdefine()
		end
	end
	if type(f) == "table" then
		getdefine().rofields[next_field_t].Type = "structs."..f[structs_name_t]
	end
	return old(f, ...)
end

wrap("struct", mystruct)
wrap("pstruct", mystruct)

-- local old = types.union
-- function types.union(a, ...)
-- 	if not a then
-- 		return old(a, ...)
-- 	end
-- 	local name = getdefine().rofields[structs_name_t].."."..a
-- 	getdefine().rofields[next_field_t].Type = "structs."..name
-- 	getdefine().rofields[next_field_t].Kind = "union"
-- 	old(a, ...)
-- 	if a then
-- 		Help_DefineStruct(getdefine(), name, "union")
-- 	end
-- 	return getdefine()
-- end

local function myarray(old, ...)
	local t = getdefine().rofields[next_field_t]
	t.ArrayCount = (t.ArrayCount or 0) + 1
	return old(...)
end

wrap("array", myarray)
wrap("parray", myarray)

local function myfunc(old, kind, def, ...)
	local sname = getdefine().rofields[structs_name_t]
	local t1 = sname and HelpStructs[sname]
	if t1 then
		local t = {Name = def.name, Kind = kind}
		t1[#t1 + 1] = t
		local must = def.must or 0
		local sig = {}
		for i = 1, max(must, #def) do
			local parName = "arg"..i
			if def[i] == nil then
				sig[#sig+1] = parName
			elseif def[i] ~= getdefine().class.ptr then
				sig[#sig+1] = parName.." = "..dump(def[i], nil, true)
			end
		end
		t.Sig = table.concat(sig, ", ")
	end
	return old(def, ...)
end

local old = types.method
function types.method(...)
	return myfunc(old, "method", ...)
end

local old = types.func
function types.func(...)
	return myfunc(old, "function", ...)
end

local function FuncDefiner(kind)
	local function newindex(t, a, v)
		local define = getdefine()
		define.class[a] = v
		local sname = define.rofields[structs_name_t]
		local t = sname and HelpStructs[sname]
		if t == nil then
			return
		end
		t[#t + 1] = {Name = a, Kind = kind}
	end
	return setmetatable({}, {__newindex = newindex})
end

types.f = FuncDefiner("function")
types.m = FuncDefiner("method")

local function IndexDefiner(name)
	local old = types[name]
	types[name] = function(...)
		local sname = getdefine().rofields[structs_name_t]
		local t = sname and HelpStructs[sname]
		if t then
			t[name] = ...
		end
		return old(...)
	end
end
IndexDefiner "indexmember"
IndexDefiner "newindexmember"

mem_internal.UpdateCallbacks()

-----------------------------------------------------
-- get const comments
-----------------------------------------------------

local ConstComments = {}

local ConstAndBits = io.LoadString(DevPath..'Scripts/Core/ConstAndBits.lua')
ConstAndBits = ConstAndBits:gsub("function MakeBitsDefiner", "function ___")

function MakeBitsDefiner(name)
	internal[name] = function(define)
		local comment = ConstComments[name] or {}
		for n, b in pairs(const[name]) do
			define.bit(n, b)
			if comment[n] then
				define.Info(comment[n])
			end
		end
		return define
	end
end

-- populate ConstComments
do
	local ConstName
	for s in ConstAndBits:gmatch("[^\r\n]+") do
		ConstName = s:match("const%.([%w_]+) *= *{") or ConstName
		local name, comment = s:match("\t([%w_]+) *=.-%-%- *(.*)")
		if name then
			ConstComments[ConstName] = ConstComments[ConstName] or {}
			ConstComments[ConstName][name] = comment
		end
	end
end

-----------------------------------------------------
-- run certain files again for all versions
-----------------------------------------------------

local OldStructs = table.copy(structs)
local OldMeta = getmetatable(structs)
setmetatable(structs, {__index = structs_index})
local OldConst = const

local function ProcessIndex()  -- embeds MouseStruct into GameMouse
	local NeedStruct = {}
	
	local function CheckNeededStructs(tt)
		for i = 2, #tt do
			local t = tt[i]
			if t.Name == tt.indexmember then
				t.Default = (t.Name == tt.newindexmember and "rw" or "r")
			end
			if t.Type then
				local tstruct = HelpStructs[t.Type]
				t.Type = tstruct and tstruct[1].ReplaceWith or t.Type
				local need = t.ArrayCount or t[1] or (t.Default ~= "rw")
				NeedStruct[t.Type] = NeedStruct[t.Type] or need
			end
		end
	end
	local function CheckEmbeddedStructs(tt)
		for i = #tt, 2, -1 do
			local name = tt[i].Type
			if NeedStruct[name] == false then
				local t = HelpStructs[name]
				table.remove(tt, i)
				for j = 2, #t do
					table.insert(tt, i + j - 2, t[j])
				end
				tt.indexmember = t.indexmember
				tt.newindexmember = t.newindexmember
			end
		end
	end
	
	for k, t in pairs(HelpStructs) do
		CheckNeededStructs(t)
	end
	for k, t in pairs(HelpStructs) do
		if NeedStruct[k] ~= false then
			CheckEmbeddedStructs(t)
		end
	end
end

local function DoProcessConst(name, c, real, full)
	full = full or name ~= "*" and "const."..name or "const"
	local t = {{Kind = "const", Name = (name ~= "*" and full or "const.*")}}
	local inv = const[name.."Inv"]
	local comment = ConstComments[name] or {}
	
	local function Add(a)
		if type(real[a]) ~= "table" then
			t[#t+1] = {comment[a]; Name = a, Val = real[a]}
		else
			t[#t+1] = {comment[a]; Name = a, Sig = "[]"}
		end
	end
	
	if inv then
		for _, a in sortpairs(inv) do
			Add(a)
		end
	else
		inv = table.invert(c)
		for n in sortpairs(inv) do
			if type(n) ~= "table" then
				for a, v in sortpairs(c) do
					if v == n then
						Add(a)
					end
				end
			end
		end
		for a, v in sortpairs(c) do
			if type(v) == "table" then
				Add(a)
			end
		end
	end
	HelpStructs[full] = t
end

local function ProcessEvtConst(name)
	local t, name = evt[name], "evt."..name
	DoProcessConst(name, t, t, name)
end

local function ProcessConst()
	local base = {}
	for k, t in pairs(const) do
		if type(t) == "number" then
			base[k] = t
		elseif type(next(t)) == "string" then
			DoProcessConst(k, t, t)
		end
	end
	base.Second = nil
	base.MonsterImmune = 100000000000
	base.MapLimit = 200000000000
	DoProcessConst("*", base, const)
	ProcessEvtConst("Players")
	ProcessEvtConst("VarNum")
end

local function ProcessStructs(ver)
	HelpStructs = setmetatable({}, {__index = NewHelpStruct})
	offsets.MMVersion = ver
	for k in pairs(structs) do
		structs[k] = nil
	end
	structs.f = {}  -- definition functions
	structs.o = {}  -- offsets
	structs.m = {}  -- members
	const = {}
	-- dofile(DevPath..'Scripts/Core/ConstAndBits.lua')
	loadstring(ConstAndBits)()
	dofile(DevPath..'Scripts/Structs/00 structs.lua')
	dofile(DevPath..'Scripts/Structs/01 common structs.lua')
	dofile(DevPath..'Scripts/Core/evt.lua')
	-- print(dump(structs.f))
	Help[ver] = HelpStructs, structs.GameStructure
	setmetatable(HelpStructs, nil)
	ProcessIndex()
	ProcessConst()
end

for i = 6, 8 do
	pcall2(ProcessStructs, i)
end

offsets.MMVersion = Game.Version
table.copy(OldStructs, structs, true)
setmetatable(structs, OldMeta)
const = OldConst

-----------------------------------------------------
-- combine HelpStructs
-----------------------------------------------------

HelpStructs = {}

local function Respect(it)
	return (it[1] and 100 or 0) + (it.Sig and 90 or 0) + (it.Type and 80 or 0) + (it.ArrayCount or 0)
	-- arrays over unions
end

local function CombineStructForGame(t, name, ver)
	local k = 1
	local function InsertItem(it)
		for i = 1, #t do
			local t1 = t[i]
			if t1.Name == it.Name then
				if Respect(it) > Respect(t1) then  
					t[i] = it
					it[6] = t1[6]
					it[7] = t1[7]
					it[8] = t1[8]
					t1, it = it, t1
				end
				t1[ver] = true
				if t1.Val ~= it.Val then
					t1.Val = nil
				end
				k = max(i + 1, k)
				return
			end
		end
		table.insert(t, k, it)
		it[ver] = true
		k = k + 1
	end
	
	for _, it in ipairs(Help[ver][name] or {}) do
		InsertItem(it)
	end
end

local function CombineStruct(name)
	local t = {}
	for i = 6, 8 do
		CombineStructForGame(t, name, i)
	end
	local evtName = name:match("^structs%.(%d%d%.evt%..*)")  -- fix evt.* names
	if evtName then
		name, t[1].Name, t[1].Kind = evtName, evtName:match("^%d%d%.(.*)"), "evt"
	end
	HelpStructs[name] = t
end

do
	local t = {}
	table.copy(Help[6], t, true)
	table.copy(Help[7], t, true)
	table.copy(Help[8], t, true)
	for k in pairs(t) do
		CombineStruct(k)
	end
end

-- delete unused structs

local UsedStruct = {["structs.GameStructure"] = true}

local function CheckUsedStructs(tt)
	for i = 2, #tt do
		local name = tt[i].Type
		if name then
			UsedStruct[name] = true
		end
	end
end

for k, t in pairs(HelpStructs) do
	CheckUsedStructs(t)
end
for k, t in pairs(HelpStructs) do
	if t[1].Ignore or not UsedStruct[k] and t[1].Kind == "struct" then
		HelpStructs[k] = nil
	end
end

-----------------------------------------------------
-- process functions
-----------------------------------------------------

local function ProcessFunctions(dir, modules)
	for f in _G.path.find(DevPath.."Scripts/"..dir.."/*.lua") do
		parse.CheckFile(f)
		local t = parse.Help
		if t[2] then
			local name = f:match("[^\\/:]*[\\/:][^\\/:]*$") -- path.GetRelativePath(DevPath.."Scripts", f):match([[^%.?\?(.*)$]])
			HelpStructs[name] = t
			t[1].Name = modules and path.setext(path.name(f), '') or f:match("Scripts[\\/](.*)")
			if f:lower():match("rsmem.lua") then
				t[1].NoChildTOC = true
			end
		end
	end
end

-- parse.CheckFile("Scripts/Core/events.lua")
-- parse.CheckFile("Scripts/Structs/After/Backup.lua")
ProcessFunctions("Core")
ProcessFunctions("Structs/After")
ProcessFunctions("Modules")
