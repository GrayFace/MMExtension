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
local select = select
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
local d_getupvalue = debug.getupvalue
local d_upvaluejoin = debug.upvaluejoin
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
local dummy = {}

-- dofile(CoreScriptsPath.."RSFunctions.lua")
-- PrintToFile("InternalLog.txt")  -- temporary

dofile(CoreGamePath.."offsets.lua")
offsets = offsets or {}
dofile(CoreScriptsPath.."Common.lua")
internal.NoGlobals.CheckChunkFile(1, 1)
internal.NoGlobals.Options.NameCharCodes[("?"):byte()] = true

local function path_insert(str, new, after)
	local n1, n2 = str:find(after, 1, true)
	if n1 then
		return str:sub(1, n2)..';'..new..str:sub(n2 + 1)
	end
	return new..';'..str
end

local function make_cpath(scripts)
	return scripts.."Dll\\?.dll;"..scripts.."Dll\\loadall.dll"
end

local package_main = AppPath.."Scripts\\Modules\\?.lua"
package.path = package_main..(GitPath and ";"..GitPath.."Scripts\\Modules\\?.lua" or "")
local package_cmain = make_cpath(AppPath.."Scripts\\")
package.cpath = package_cmain..(GitPath and ";"..make_cpath(GitPath.."Scripts\\") or "")--..';'..DevPath.."ExeMods\\MMExtension\\socket.dll"
GitPath = internal.GitPath  -- allow changing GitPath by offsets.lua
local loadfile = loadfile
local loadstring = loadstring
local dofile = dofile
local error = error
local offsets = offsets
local events = events
local table_copy = table.copy
local table_invert = table.invert
local sortpairs = sortpairs
local d_findupvalue = debug.findupvalue
local path_find = path.find
local path_addslash = path.addslash
local path_name = path.name
local package = package

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
	-- Calls allocation function that MM uses for most of things. Note that my patch intersects these calls and uses Delphi memory manager to do the allocation.
	function _G.mem.allocMM(size)
		return call(offsets.allocMM, 1, offsets.allocatorMM, 0, assertnum(size, 2), 0) % 0x100000000
	end
	local allocMM = mem.allocMM

	-- Free memory allocated by #mem.allocMM:#.
	function _G.mem.freeMM(p)
		return call(offsets.freeMM, 1, offsets.allocatorMM, p)
	end
	local freeMM = mem.freeMM

	-- Resizes memory, reallocating as necessary, preserving content. Returns new (or the same if no reallocation occured) address.
	-- If 'NoFree' is 'true', the memory at 'p' isn't freed. This is useful for extending static arrays of the game.
	-- 'p' can be a sctrucure, in which case its '?ptr' field is modified automatically.
	function _G.mem.reallocMM(p, OldSize, NewSize, NoFree)
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
		if not NoFree then
			freeMM(p)
		end
		if t then
			t["?ptr"] = new
		end
		return new
	end
	local reallocMM = mem.reallocMM
	
	-- Resizes an array allocated with #mem.allocMM:# function. 'n' is the new count.
	function _G.mem.resizeArrayMM(t, n)
		local old, oldP = t.size, t["?ptr"]
		t.count = n
		local sz, p = t.size, t["?ptr"]
		if sz ~= old and p == oldP then  -- support automatically resized arrays
			p = reallocMM(p, old, sz)
			t["?ptr"] = p
		end
		return p
	end
	
	mem_internal.AsmProlog = mem_internal.AsmProlog..([[
		mmver equ %v%
		mm%v% equ 1
		mm%v1% equ 0
		mm%v2% equ 0
		macro mmdef name,m6,m7,m8
		{
			name equ m%v%
		}
		macro mm%v%cmd [cmd]
		{
		common
			cmd
		}
		macro mm%v1%cmd [cmd]
		{
		}
		macro mm%v2%cmd [cmd]
		{
		}
	]]):gsub('%%v(%d?)%%', function(i)
		return (isMM + ('0'..i))%3 + 6
	end)
	
elseif offsets.MainWindow then
	u4[internal.MainWindowPtrPtr] = offsets.MainWindow
else
	offsets.MainWindow = u4[internal.MainWindowPtrPtr]
end

--!++(mem.EditPChar)v Editable PChar
--!++(mem.ConstPChar)v Editable write-protected PChar

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

-- 'typ' can be a numeric value that MessageBox WinAPI function accepts or one of predefined strings: "error" (OK), "warning" (OK), "warn" (OK/Cancel), "confirm" (OK/Cancel), "confirmsnd" (OK/Cancel). Returns a number returned by the WinAPI funciton: 1 - OK, 2 - Cancel.
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

-- Shows debug console. Message includes file name and line number, and than each argument is added to the message as a new line of text.
function _G.debug.Message(...)
	local dbg = debug_getinfo(2,"Sl")
	dbg = dbg and dbg.short_src and dbg.currentline and dbg.currentline > 0 and dbg
	local msg = dbg and format(" %s of %s", dbg.currentline, dbg.short_src)
	local par = d_debug and {"Debug Message"..(msg and ' at line'..msg..':' or ''), ...} or {msg and 'Line'..msg..':' or ':', ...}
	for i = 2, select('#', ...) + 1 do
		par[i] = tostring(par[i])
	end
	msg = table_concat(par, "\n")
	if d_debug then
		d_debug(msg)
	else
		MessageBox(msg, "Debug Message")
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
structs.aux = structs.aux or {}  -- various functions useful for structs

function structs.class(t)
	local mt = getmetatable(t)
	return mt and rawget(mt, "class")
end

function structs.enum(t)
	local a = (getmetatable(t) or dummy).members
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

-- returns address of a field inside a structure or an element inside an array
function structs.ptr(t, field)
	local name = structs.name(t)
	if name then
		return structs.o[name][field] + t['?ptr']
	end
	-- assume an array
	return (field - t.Low)*t.ItemSize + t['?ptr']
end

-- EditablePChar

local EditablePCharText = {}
internal.EditablePCharText = EditablePCharText

local function EditPChar_newindex(_, o, val)
	local p = u4[o]
	local s = (p ~= 0 and mem_string(p) or nil)
	val = val and tostring(val) or nil
	if s == val then
		return
	end
	local p1, len = EditablePCharText[o], s and #s or -1
	if not val or p1 ~= p or len < #val then
		if p1 then
			free(p1)
		end
		if not val then
			EditablePCharText[o] = nil
			u4[o] = 0
			return
		end
		p = malloc(#val + 1)
		EditablePCharText[o] = p
	end
	u4[o] = p
	mem_copy(p, val, #val + 1)
end

local function EditConstPChar_newindex(_, o, v)
	IgnoreProtection(true)
	EditPChar_newindex(_, o, v)
	IgnoreProtection(false)
end

mem.EditPChar = setmetatable({}, {__index = pchar, __newindex = EditPChar_newindex})
mem.editpchar = mem.EditPChar
mem.EditConstPChar = setmetatable({}, {__index = pchar, __newindex = EditConstPChar_newindex})
mem.ConstPChar = mem.EditConstPChar
mem.constpchar = mem.ConstPChar

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

function internal.SetArrayUpval(t, name, val, unique)
	local f = getmetatable(t).__newindex
	local k = d_findupvalue(f, name)
	if unique then
		local f2 = function() return val end
		d_upvaluejoin(f, k, f2, d_findupvalue(f2, 'val'))
	else
		d_setupvalue(f, k, val)
	end
end

function internal.GetArrayUpval(t, name)
	local f = getmetatable(t).__newindex
	local k, v = d_getupvalue(f, d_findupvalue(f, name))
	return v
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

local PathList = table_invert{GamePath..'Scripts/', GitPath and GitPath..'Scripts/'}
internal.PathList = PathList

function _G.AddScriptsPath(s)
	s = path_addslash(s)
	if not PathList[s] then
		package.path = path_insert(package.path, s..'Modules\\?.lua', package_main)
		package.cpath = path_insert(package.cpath, make_cpath(s), package_cmain)
	end
	PathList[s] = true
end

-- core files

dofile(CoreScriptsPath.."Debug.lua")
d_debug = _G.debug.debug

local CoreFiles = offsets.CoreFiles or {
	CoreGamePath.."ConstAndBits.lua",
	CoreGamePath.."events.lua",
	isMM and CoreGamePath.."npc.lua" or nil,
	isMM and CoreGamePath.."timers.lua" or nil,
	isMM and CoreGamePath.."evt.lua" or nil,
}
for _, s in ipairs(CoreFiles) do
	dofile(s)
end

-- call structs

local function RunFiles(path, func)
	local t = {}
	for dir in pairs(PathList) do
		for s in path_find(dir..path) do
			t[(path_name(s)..'\0'..dir):lower()] = s
		end
	end
	for _, s in sortpairs(t) do
		(func or dofile)(s)
	end
end
internal.RunFiles = RunFiles

RunFiles("Include/*.lua")

RunFiles("Structs/*.lua")

-- for a, v in pairs(structs.f) do
	-- structs[a] = mem.struct(v)
-- end

events.cocalls("StructsLoaded")

--------------------------- Load Other Scripts -------------------------

local Sleep = mem.dll.kernel32.Sleep
local AbsoleteStr = "-- this file is here to raplace the one from older MMExtension versions"
local function CheckNoDel(fname, bad)
	bad = bad or AbsoleteStr
	local f = assert(_G.io.open(fname, "rb"))
	local s = f:read(#bad + 1)
	f:close()
	if bad ~= s then
		return true
	end
	for i = 1, 20 do
		if _G.os.remove(fname, true) then
			break
		end
		Sleep(10)
	end
end

RunFiles("Structs/After/*.lua")

function _G.ReloadLocalization()
	RunFiles("Localization/*.txt", function(f)
		_G.LoadTextTable(f, _G.LocalizeAll{})
	end)
	RunFiles("Localization/*.lua")
end
_G.ReloadLocalization()

-- Delete very old absolete files. Since MMExt is distributed as an archive not an installer,
-- I just distribute these "DeleteMe" files that overwrite the old ones.
if isMM then
	for f in path_find(AppPath.."MMExtension.txt") do
		CheckNoDel(f)
	end
	for f in path_find(AppPath.."General/*.lua") do
		CheckNoDel(f)
	end
	if isMM == 6 then
		-- old Town Portal.txt had locations arranged incorrectly
		for f in path_find(AppPath..'Data/Tables/Town Portal.txt') do
			CheckNoDel(f, "#\9Map\9X\9Y\9Z\9Direction\9LookAngle\9Icon X\9Icon Y\9Icon Width\9Icon Height\13\n0\9OutB2.Odm\9-15079\00912878\009161\0091536\0090\009346\009280\00962\00931\13\n1\9OutC2.Odm\0096991\00913438\00997\0090\0090\009360\009186\00946\00942\13\n2\9OutE2.Odm\0093489\9-14582\009257\0090\0090\009318\009121\00952\00926\13\n3\9OutE3.Odm\9-9705\9-6858\009161\0091536\0090\009223\009156\00951\00930\13\n4\9OutD1.Odm\00913146\9-9194\0091\0090\0090\009113\009150\00951\00933\13\n5\9OutC1.Odm\9-9138\00914518\00997\0090\0090\009192\00981\00954\00930\13\n")
		end
	end
end

RunFiles("General/*.lua")

events.cocalls("ScriptsLoaded")

--]=]