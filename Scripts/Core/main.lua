-- shared by MMExtension, LuaConsole and GameExtension

ffi = require("ffi")
local type = type
local unpack = unpack
local assert = assert
local format = string.format
local string_byte = string.byte
local string_sub = string.sub

local next = next
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local tostring = tostring
local rawget = rawget
local rawset = rawset
local getfenv = getfenv
local setfenv = setfenv
local getmetatable = debug.getmetatable
local d_setmetatable = debug.setmetatable
local os_time = os.time
local debug_getinfo = debug.getinfo
local d_setupvalue = debug.setupvalue
local table_insert = table.insert
local table_remove = table.remove
local table_concat = table.concat
local math_min = math.min
local math_floor = math.floor
local math_ceil = math.ceil
local abs = math.abs
local coroutine_create = coroutine.create
local coroutine_resume = coroutine.resume
local coroutine_running = coroutine.running
local msg
local d_debug

local _G = _G
internal = debug.getregistry()
local internal = internal -- internals
local mem_internal = mem
internal.mem_internal = mem_internal

local isMM = internal.MMVersion
local GitPath = internal.GitPath
AppPath = internal.AppPath
local AppPath = internal.AppPath
DevPath = GitPath or AppPath
local CoreScriptsPath = DevPath.."Scripts/Core/"
internal.CoreScriptsPath = CoreScriptsPath
local CoreGamePath = internal.CoreGamePath and internal.CoreGamePath.."Scripts/Core/" or CoreScriptsPath  -- for game-specific core files (used by LuaConsole)
local GamePath = internal.AllowForeignDir and AppPath or ""

-- dofile(CoreScriptsPath.."RSFunctions.lua")
-- PrintToFile("InternalLog.txt")  -- temporary

dofile(CoreGamePath.."offsets.lua")
offsets = offsets or {}
dofile(CoreScriptsPath.."Common.lua")
internal.NoGlobals.Options.NameCharCodes[("?"):byte()] = true
package.path = AppPath.."Scripts\\Modules\\?.lua"..(GitPath and ";"..GitPath.."Scripts\\Modules\\?.lua" or "")
GitPath = internal.GitPath  -- allow changing GitPath by offsets.lua

local loadfile = loadfile
local loadstring = loadstring
local dofile = dofile
local error = error
local offsets = offsets
local events = events
local table_copy = table.copy
local d_findupvalue = debug.findupvalue

local function roError(a, lev)  error('attempt to modify a read-only field "'..a..'".', lev + 1)  end
local function readonly(t, a)  roError(a, 2)  end

local function setmetatable(t, m)
	d_setmetatable(t, m)
	return t
end

dofile(CoreScriptsPath.."RSPersist.lua")

internal.persist = persist
persist = nil
internal.unpersist = unpersist
unpersist = nil
local function nullsub()
end

----------- Temp ------------

-- setmetatable(_G, {__newindex = function(t, a, v)
	-- assert(type(a) ~= "string" or #a > 1 or a:lower() ~= a)
	-- rawset(t, a, v)
-- end})

----------- No globals from this point ------------

local _NOGLOBALS

----------- General functions ------------

local assertnum = _G.assertnum

local function NilOrNum(i)
	if i ~= nil then
		return assertnum(i, 3)
	end
end

function _G.dofile(path, ...)
	local chunk, err = loadfile(path)
	if chunk then
		return chunk(...)
	end
	error(err, 2)
end

local mem = _G.mem
local call = mem.call
local malloc = mem.malloc
local StaticAlloc = mem.StaticAlloc
local free = mem.free
local i4, i2, i1, u8, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u8, mem.u4, mem.u2, mem.u1, mem.pchar
local mem_string = mem.string
local mem_copy = mem.copy
local mem_fill = mem.fill
local mem_structs = mem.structs
local IgnoreProtection = mem.IgnoreProtection

if isMM then

	function mem.allocMM(size)
		return call(offsets.allocMM, 1, offsets.allocatorMM, 0, assertnum(size, 2), 0)
	end
	local allocMM = mem.allocMM

	function mem.freeMM(p)
		return call(offsets.freeMM, 1, offsets.allocatorMM, p)
	end
	local freeMM = mem.freeMM

	function mem.reallocMM(p, OldSize, NewSize)
		local t = type(p) == "table" and p
		if t then
			p = t["?ptr"]
		end
		p = assertnum(p, 2)
		OldSize = assertnum(OldSize, 2)
		NewSize = assertnum(NewSize, 2)
		local new = allocMM(NewSize)
		if OldSize < NewSize then
			mem_copy(new, p, OldSize)
			mem_fill(new + OldSize, NewSize - OldSize, 0)
		else
			mem_copy(new, p, NewSize)
		end
		freeMM(p)
		if t then
			t["?ptr"] = new
		end
		return new
	end
	local reallocMM = mem.reallocMM
	
	function mem.resizeArrayMM(t, n)
		local old = t.size
		t.count = n
		return reallocMM(t, old, t.size)
	end
	
elseif offsets.MainWindow then
	u4[internal.MainWindowPtrPtr] = offsets.MainWindow
else
	offsets.MainWindow = u4[internal.MainWindowPtrPtr]
end

--------- general

if isMM then
	local function SetPause(p, b)
		local last = u4[p + 4] ~= 0
		if b ~= last and internal.InGame then
			call(offsets[b and 'PauseTime' or 'ResumeTime'], 1, p)
		end
		return last
	end
	
	function internal.PauseGame()
		local Game = _G.Game
		if Game then
			local state = {SetPause(offsets.TimeStruct1, true), SetPause(offsets.TimeStruct2, true), u4[offsets.GameStateFlags]}
			u4[offsets.GameStateFlags] = state[3]:Or(0x100)  -- idle flag
			return state
		end
	end

	function internal.ResumeGame(state)
		if state then
			local old1, old2, old3 = unpack(state)
			SetPause(offsets.TimeStruct1, old1)
			SetPause(offsets.TimeStruct2, old2)
			u4[offsets.GameStateFlags] = old3
		end
		if _G.Game and _G.Keys then
			_G.Game.CtrlPressed = _G.Keys and _G.const and _G.Keys.IsPressed(_G.const.Keys.CTRL)
		end
	end
	
	_G.PauseGame = internal.PauseGame
	_G.ResumeGame = internal.ResumeGame
end

internal.EnterDebug = internal.EnterDebug or nullsub  -- called before a non-game window is shown and after it's hidden

if isMM then
	function internal.IsFullScreen()
		return (u4[offsets.MainWindow] ~= 0) and (u4[offsets.Windowed] == 0)
	end
	-- internal.IsTopmost = internal.IsFullScreen
else
	function internal.IsFullScreen()
		local wnd = u4[offsets.MainWindow]
		return (wnd ~= 0) and (call(internal.GetWindowLong, 0, wnd, -16):And(0x800000) == 0)
	end
end

function internal.IsTopmost()
	local wnd = u4[offsets.MainWindow]
	return (wnd ~= 0) and (call(internal.GetWindowLong, 0, wnd, -20):And(8) ~= 0)
end

local DlgTypes = {
	error = 0x10,
	warning = 0x30,
	warn = 0x31,
	confirm = 0x21,
	confirmsnd = 0x41,
}

local function MessageBox(text, caption, typ)
	caption = tostring(caption or isMM and "MMExtension" or offsets.GameName or "GameExtension")
	typ = DlgTypes[typ] or typ or 0
	if _G.Game == nil then
		return call(internal.MessageBox, 0, u4[offsets.MainWindow], tostring(text), caption, typ)
	end
	if internal.IsTopmost() then
		typ = typ:Or(0x40000)  -- topmost
	end
	local state = internal.PauseGame()
	internal.EnterDebug(true)
	local ret = call(internal.MessageBox, 0, u4[offsets.MainWindow], tostring(text), caption, typ)
	internal.ResumeGame(state)
	internal.EnterDebug(false)
	return ret
end

_G.MessageBox = MessageBox


if isMM then
	_G.PrintToFile(AppPath.."MMExtensionLog.txt", true)
else
	_G.PrintToFile(AppPath..(offsets.LogFileName or "GameExtensionLog.txt"), true)
end

--------- debug

function _G.debug.Message(...)
	local dbg = debug_getinfo(2,"Sl")
	local msg
	if dbg and dbg.short_src and dbg.currentline then
		msg = format("(%s)\n{debug.Message. Line %s}", dbg.short_src, dbg.currentline)
	else
		msg = "{debug.Message}"
	end
	local par = d_debug and {"Debug Message", "", msg, ...} or {msg, ...}
	for i = 2, #par do
		par[i] = tostring(par[i])
	end
	if d_debug then
		d_debug(table_concat(par, "\n"))
	else
		MessageBox(table_concat(par, "\n"), "Debug Message")
	end
end
local msg = _G.debug.Message

local function ErrorMessage(msg)
	msg = tostring(msg)
	if internal.OnError then
		internal.OnError(msg)
	end
	_G.print(msg)
	if d_debug then
		d_debug(msg)
	else
		MessageBox(msg, isMM and "MMExtension Error" or (offsets.GameName or "GameExtension").." Error", 0x10)
	end
end
_G.debug.ErrorMessage = ErrorMessage
internal.ErrorMessage = ErrorMessage
_G.ErrorMessage = ErrorMessage

--------------------------- Structs Support -------------------------

_G.structs = _G.structs or {}  -- classes
local structs = _G.structs
structs.f = structs.f or {}  -- definition functions
structs.o = structs.o or {}  -- offsets
structs.m = structs.m or {}  -- members

function structs.class(t)
	local mt = getmetatable(t)
	return mt and rawget(mt, "class")
end

function structs.enum(t)
	local a = (getmetatable(t) or {}).members
	if a == nil then
		error("not a structure", 2)
	end
	local f, data = _G.sortpairs(a)
	return function(_, k)
		k = f(data, k)--next(a, k)
		if k ~= nil then
			return k, t[k]
		end
	end
end

local structs_name_t = {}

internal.structs_name_t = structs_name_t

function structs.name(t)
	return t[structs_name_t]
end

local function structs_index(t, a)
	local v = rawget(structs, "f")[a]
	if v then
		local class = {}
		rawset(structs, a, class)
		return mem.struct(function(define, ...)
			structs.o[a] = define.offsets
			structs.m[a] = define.members
			define.class[structs_name_t] = a
			return v(define, ...)
		end, class)
	end
end

setmetatable(structs, {__index = structs_index})

-- EditablePChar

local EditablePCharText = {}
internal.EditablePCharText = EditablePCharText

local function EditPChar_newindex(_, o, val)
	local p = u4[o]
	local s = mem_string(p)
	val = tostring(val)
	if s == val then
		return
	end
	local o1 = EditablePCharText[p]
	if not o1 or #s < #val then
		if o1 then
			EditablePCharText[p] = nil
			free(p)
		end
		p = malloc(#val + 1)
	end
	EditablePCharText[p] = o
	u4[o] = p
	mem_copy(p, val, #val + 1)
end

local function EditConstPChar_newindex(_, o, v)
	IgnoreProtection(true)
	EditPChar_newindex(_, o, v)
	IgnoreProtection(false)
end

_G.mem.EditPChar = setmetatable({}, {__index = pchar, __newindex = EditPChar_newindex})
_G.mem.editpchar = _G.mem.EditPChar
_G.mem.EditConstPChar = setmetatable({}, {__index = pchar, __newindex = EditConstPChar_newindex})
_G.mem.ConstPChar = _G.mem.EditConstPChar
_G.mem.constpchar = _G.mem.ConstPChar

local function EditablePChar(o, obj, name, val)
	if val == nil then
		return pchar[obj["?ptr"] + o]
	end
	EditPChar_newindex(nil, obj["?ptr"] + o, val)
end
structs.EditablePChar = EditablePChar


function mem_structs.types.EditPChar(name)
	return mem_structs.CustomType(name, 4, EditablePChar)
end

function mem_structs.types.EditConstPChar(name)
	return mem_structs.CustomType(name, 4, function(o, obj, name, val)
		if val == nil then
			return pchar[obj["?ptr"] + o]
		end
		EditConstPChar_newindex(nil, obj["?ptr"] + o, val)
	end)
end

function internal.SetArrayUpval(t, name, val)
	local f = getmetatable(t).__newindex
	d_setupvalue(f, d_findupvalue(f, name), val)
end

-- stuff for Help generation

local getdefine = mem.structs.getdefine
mem.structs.types.Info = getdefine

local function definer_newindex(t, a, v)
	getdefine().class[a] = v
end

local definer = setmetatable({}, {__newindex = definer_newindex})

mem.structs.types.f = definer
mem.structs.types.m = definer

--------------------------- Load Core Scripts and Structs -------------------------

dofile(CoreScriptsPath.."Debug.lua")
d_debug = _G.debug.debug
dofile(CoreGamePath.."ConstAndBits.lua")
dofile(CoreGamePath.."events.lua")
if isMM then
	dofile(CoreScriptsPath.."timers.lua")
	dofile(CoreScriptsPath.."evt.lua")
end

-- call structs

local function RunFiles(path, func)
	if GitPath then
		for s in _G.path.find(GitPath..path) do
			dofile(s)
		end
	end
	for s in _G.path.find(GamePath..path) do
		(func or dofile)(s)
	end
end

RunFiles("Scripts/Structs/*.lua")

-- for a, v in pairs(structs.f) do
	-- structs[a] = mem.struct(v)
-- end

events.cocalls("StructsLoaded")

--------------------------- Load Other Scripts -------------------------

local Sleep = mem.dll.kernel32.Sleep
local AbsoleteStr = "-- this file is here to raplace the one from older MMExtension versions"
local function CheckNoDel(fname)
	local f = assert(_G.io.open(fname, "rb"))
	local s = f:read(#AbsoleteStr + 1)
	f:close()
	if AbsoleteStr ~= s then
		return true
	end
	for i = 1, 20 do
		if _G.os.remove(fname, true) then
			break
		end
		Sleep(10);
	end
end

local function RunOrDel(fname)
	if CheckNoDel(fname) then
		dofile(fname)
	end
end

RunFiles("Scripts/Structs/After/*.lua")

function _G.ReloadLocalization()
	for f in _G.path.find(AppPath.."Scripts/Localization/*.txt") do
		_G.LoadTextTable(f, _G.LocalizeAll{})
		-- _G.LocalizeAll(_G.LoadTextTable(f), true)
	end
	for f in _G.path.find(GamePath.."Scripts/Localization/*.lua") do
		dofile(f)
	end
end
_G.ReloadLocalization()

-- delete MMExtension.txt
for f in _G.path.find(AppPath.."MMExtension.txt") do
	CheckNoDel(f)
end

RunFiles("Scripts/General/*.lua", isMM and RunOrDel)

events.cocalls("ScriptsLoaded")

--]=]