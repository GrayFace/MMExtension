local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

evt = {[0] = {}, {}, {}, {}, (mmver == 8 and {} or nil), All = {}, Random = {}, Current = {}}
Evt = evt
local EvtTables = table.copy(evt)
EvtTables.evt = evt

for _, t in pairs(evt) do
	for k, v in pairs(evt) do
		t[k] = v
	end
end

local _KNOWNGLOBALS = vars, Vars, mapvars, MapVars, Game, Party, Map

local function MakeEventsTable()
	local ret = events.new()
	local m = getmetatable(ret)
	local get = m.__index
	local set = m.__newindex
	local defcall = ret.call
	function m.__index(t, a)
		if type(a) ~= "number" then
			return rawget(t, a)
		end
		local function index(_, a1)
			if type(a1) == "number" then
				return get(t, a*256 + a1)
			else
				return get(t, a*256)[a1]
			end
		end
		local function newindex(_, a1, v)
			set(t, a*256 + a1, v)
		end
		local function call(_, ...)
			return defcall(a*256, ...)
		end
		return setmetatable({}, {__index = index, __newindex = newindex, __call = call})
	end
	function m.__newindex(t, a, v)
		if type(a) ~= "number" then
			return rawset(t, a, v)
		end
		set(t, a*256, v)
	end
	return ret
end

local ResetMapStr
local ClearMapStr
local UpdateEventJustHint

local CurMapScripts = {}
local GlobalScripts = {}
local MayShow = 0  -- 0 in loading screen, 1 after the game was loaded
local WasInGame, WasLoaded

local function OnLeaveMap()
	internal.ResetEvtPlayer()
	events.cocall("LeaveMap")
	events.RemoveFiles(CurMapScripts)
	evt.global.RemoveFiles(CurMapScripts)
	internal.TimersLeaveMap(CurMapScripts)
	CurMapScripts = {}
	-- internal.MonstersRestore()
	ClearMapStr()
	internal.MapName = nil
end
internal.OnLeaveMap = OnLeaveMap

local function OnLeaveGame()
	MayShow = 0
	if internal.InGame then
		events.cocall("LeaveGame")
		internal.TimersLeaveGame()
		internal.InGame = false
	end
	table.copy(CurMapScripts, GlobalScripts, true)
	events.RemoveFiles(GlobalScripts)
	GlobalScripts = {}
	CurMapScripts = {}
	internal.SaveGameData = nil
	ClearMapStr()
	internal.MapName = nil
end
internal.OnBeforeLoadGame = function()
	OnLeaveGame()
	internal.GameLoading = true
end
internal.OnExitToMainMenu = OnLeaveGame

local function LoadScripts(fpath, t)
	internal.RunFiles(fpath, function(f)
		local chunk, err = loadfile(f)
		if chunk == nil then
			debug.ErrorMessage(err)
		else
			t[debug.FunctionFile(chunk)] = true
			cocall2(chunk)
		end
	end)
end

local function InitVars()
	local sgd = tget(internal, "SaveGameData")
	--!v Variables that are stored in saved game
	vars = tget(sgd, "Vars")
	Vars = vars
	return sgd
end
internal.InitVars = InitVars

function internal.BeforeMapLoad()
	MayShow = 0
	local sgd = InitVars()
	if mmver == 6 then
		evt.MazeInfo = nil
	end
	internal.MapName = nil  -- safeguard
	local MapName = mem.string(offsets.MapName, 20):lower()
	--!v Variables stored in a saved game that belong to current map. On map refill 'mapvars' are cleared, but old table is stored in #Map.Refilled:#.
	mapvars = tget(sgd, "Maps", MapName)
	MapVars = mapvars
	WasInGame, WasLoaded = internal.InGame, internal.GameLoading
	if not WasInGame then
		internal.InGame, internal.GameLoading = true, nil
		evt.Global = MakeEventsTable()
		evt.global = evt.Global
		if mmver > 6 then
			--!v([]) [MM7+]  Functions that can return 'true' or 'false' to change topic visibility
			evt.CanShowTopic = events.new()
		end
	end
	--!-
	events.cocall("InternalBeforeLoadMap", WasInGame, WasLoaded)
	if not WasInGame then
		LoadScripts("Global/*.lua", GlobalScripts)
		LoadScripts("Maps/*.global.lua", GlobalScripts)
	end
	events.cocall("BeforeLoadMap", WasInGame, WasLoaded)
end

function internal.OnLoadMap()
	local MapName = mem.string(offsets.MapName, 20):lower()
	internal.MapName = MapName  -- this is needed because my OnMapLeave works in MM6 when map name is already changed
	Map.Refilled = nil
	internal.MapRefilled = (internal.MapRefilled == 1)
	if internal.MapRefilled then
		Map.Refilled = internal.SaveGameData.Maps[MapName] or {}
		mapvars = {}
		MapVars = mapvars
		internal.SaveGameData.Maps[MapName] = mapvars
	end
	--!v([]) Event handlers
	--
	-- Event indexes convention:
	-- Indexes 20000 - 22999 are for sprite events, so that event (20000 + i) corresponds to #Map.Sprites:#[i].
	evt.map = MakeEventsTable()
	evt.Map = evt.map
	--!v([])
	evt.hint = {}
	evt.Hint = evt.hint
	if mmver == 6 then
		--!v [MM6]
		evt.MazeInfo = nil
	end
	ResetMapStr()
	internal.StartTimers()
	-- internal.LoadMonsterIds()
	CurMapScripts = {}
	-- Return 'true' to cancel execution of map scripts. Used by the Editor.
	local NoScripts = events.call("CancelLoadingMapScripts")
	if not NoScripts then
		internal.ResetEvtPlayer()
		events.cocall("BeforeLoadMapScripts", WasInGame)
		LoadScripts("Maps/"..path.setext(MapName, ".lua"), CurMapScripts)
		LoadScripts("Maps/*."..path.setext(MapName, ".lua"), CurMapScripts)
		internal.ResetEvtPlayer()
		-- Use this event instead of 'LoadMap' in Global and General scripts
		events.cocall("LoadMapScripts", WasInGame)
	end
	internal.ResetEvtPlayer()
	-- 'NoScripts' = 'true' if map scripts execution was cancelled by #CancelLoadingMapScripts:events.CancelLoadingMapScripts# event.
	events.cocall("LoadMap", WasInGame, NoScripts)
	UpdateEventJustHint()
	MayShow = 1
end

function internal.AfterLoadMap()
	internal.ResetEvtPlayer()
	events.cocall("AfterLoadMap", WasInGame)
end

----------- Hint, MazeInfo

local TextBuffer = internal.TextBuffer

local function GetHouseHint(id)
	if id and id ~= 600 and id ~= 601 then
		return Game.Houses[id].Name
	end
end

function internal.OnGetEventHint(evtId)
	local h = evt.house and (events.call("GetEventHint", evtId) or evt.hint[evtId] or GetHouseHint(evt.house[evtId]))
	if h then
		mem.copy(TextBuffer, h, #h + 1)
	end
	return h and 1 or 0
end

if mmver == 6 then
	function internal.OnGetMazeInfo()
		local h = events.call("GetMazeInfo") or evt.MazeInfo
		if h then
			mem.copy(TextBuffer, h, #h + 1)
		end
		return h and 1 or 0
	end
end

----------- UpdateEventJustHint

function UpdateEventJustHint()
	if mmver == 6 or not evt.house then
		-- do nothing
	elseif Map.IsIndoors() then
		for _, a in Map.FacetData do
			local ev = a.Event
			if ev ~= 0 and evt.map.exists(ev*256) then
				Map.Facets[a.FacetIndex].IsEventJustHint = false
			elseif ev ~= 0 and evt.hint[ev] then
				Map.Facets[a.FacetIndex].IsEventJustHint = true
			end
		end
	else
		for _, a in Map.Models do
			for _, a in a.Facets do
				local ev = a.Event
				if ev ~= 0 and evt.map.exists(ev*256) then
					a.IsEventJustHint = false
				elseif ev ~= 0 and evt.hint[ev] then
					a.IsEventJustHint = true
				end
			end
		end
	end
end

----------- CanShowTopic

function internal.CanShowTopic(topic, def)
	local ret = evt.CanShowTopic[topic](topic)
	if ret == nil then
		return def
	end
	return ret and 1 or 0
end

----------- Str

local strbuf = {}

local function str_index(t, a)
	if a >= 500 or a < 0 then
		error("evt.str index out of bounds [0..499]", 2)
	end
	return mem.string(offsets.MapStrBuf + u4[offsets.MapStrOffsets + a*4])
end

local function str_newindex(t, a, v)
	if a >= 500 or a < 0 then
		error("evt.str index out of bounds [0..499]", 2)
	end
	local buf = strbuf[a]
	if buf then
		mem.free(buf)
	end
	buf = mem.malloc(#v + 1)
	strbuf[a] = buf
	mem.copy(buf, v, #v + 1)
	u4[offsets.MapStrOffsets + a*4] = buf - offsets.MapStrBuf
end

function ClearMapStr()
	if strbuf then
		for i, v in pairs(strbuf) do
			mem.free(v)
		end
	end
	strbuf = nil
	evt.str = nil
	evt.Str = nil
	evt.house = nil
	evt.House = nil
end

function ResetMapStr()
	strbuf = {}
	--!v([])
	evt.str = setmetatable({}, {__index = str_index, __newindex = str_newindex})
	evt.Str = evt.str
	--!v([]) House name used for hint
	evt.house = {}
	evt.House = evt.house
end

----------- AfterProcessEvent

local GlobalEventInfo, TargetObj
local AsyncProc, AsyncTrue, AsyncPlayer, AsyncCurrentPlayer, AsyncTargetObj

function internal.ResetEvtPlayer()
	evt.Player = u4[offsets.CurrentPlayer] - 1
	if evt.Player < 0 then
		--!v
		evt.Player = math.random(Party.Count) - 1
	end
	--!v
	evt.CurrentPlayer = evt.Player
end

function internal.AfterProcessEvent(evtId, seq, globalEventInfo, targetObj, param, retseq)
	if evt.house == nil then  -- OnLoadMap wasn't executed
		return
	end
	local old1, old2, old3, old4 = GlobalEventInfo, TargetObj, evt.Player, evt.CurrentPlayer
	GlobalEventInfo, TargetObj, MayShow = globalEventInfo, targetObj, param
	internal.ResetEvtPlayer()
	local f = AsyncProc
	AsyncProc = nil
	if evtId ~= 0x7FFF then
		local ev = (globalEventInfo == 0) and evt.map or evt.global
		local evn = evtId*256 + seq
		ev.cocall(evn, evtId, seq)
		events.cocall((globalEventInfo == 0) and "EvtMap" or "EvtGlobal", evtId, seq)
	elseif f then
		evt.Player, evt.CurrentPlayer = AsyncPlayer, AsyncCurrentPlayer
		if type(f) == "thread" then
			coroutine.resume2(f, retseq == AsyncTrue)
		else
			pcall2(f, retseq == AsyncTrue)
		end
	end
	GlobalEventInfo, TargetObj, evt.Player, evt.CurrentPlayer = old1, old2, old3, old4
end

--------- Some Functions

function evt.InGlobal()
	return GlobalEventInfo and GlobalEventInfo ~= 0 or Game.CurrentScreen == 4 or Game.CurrentScreen == 13
end

function evt.ForPlayer(n)
	if type(n) == "table" then
		n = n.Player or n[1]
	end
	if type(n) == "string" then
		evt.Player = evt.Players[n]
	else
		evt.Player = n
	end
	return evt
end

-- Here's what it does:
-- !Lua[[
-- evt.house[evtId] = houseId
-- evt.map[evtId] = function()
-- 	evt.EnterHouse(houseId)
-- end
-- ]]
function evt.HouseDoor(evtId, houseId)
	evt.house[evtId] = houseId
	evt.map[evtId] = function()
		evt.EnterHouse(houseId)
	end
end

--------- Call Events

local CmdDef = {}
local DeclareCmd = {}
local VarNumToStr, PlayerToStr = {}, {}
local Deco = {CmdStructs = {}, CmdNames = {}, CmdInfo = {}, DeclareCmd = DeclareCmd, CmdDef = CmdDef, VarNumToStr = VarNumToStr, PlayerToStr = PlayerToStr}
internal.EvtInternal = Deco

local EvtBuf, LinesBuf, LinesEnd = internal.EvtBuf, offsets.EvtLinesBuf + 12*12, offsets.EvtLinesBuf + offsets.EvtLinesBufCount
local BufPtr, EvtBufEnd = EvtBuf + 256, EvtBuf + (internal.EvtBufSize or 0x10000)
local LineN

-- reset evt buffers in case of an overflow error
-- for this situation I'm leaving space for 3 evt calls at the beginning of them normally
local function EvtAssert(cond, msg)
	if cond then
		return
	end
	EvtBuf, LinesBuf = internal.EvtBuf, offsets.EvtLinesBuf
	BufPtr = EvtBuf
	error(msg)
end

local function FillLine()
	EvtAssert(LinesBuf < LinesEnd, 'evt lines overfow')
	local p = LinesBuf
	u4[p] = 0x7FFF
	u4[p + 4] = LineN
	u4[p + 8] = BufPtr - EvtBuf
	LinesBuf = LinesBuf + 12
	LineN = LineN + 1
end

local CurInfo -- arguments for MakeCmd

local function MakeCmd(name, num, f, invis)
	CurInfo = {FieldTypes = {}, FieldsOrder = {}}
	local offs0
	local cmdStruct = mem.struct(function(define, ...)
		offs0 = define.offsets
		if invis then
			define.Info(false)
		end
		return f(define, ...)
	end)
	Deco.CmdStructs[num] = cmdStruct
	Deco.CmdNames[num] = name
	local textName = CurInfo.TextName
	local def = CmdDef[num]
	local order = CurInfo.FieldsOrder
	Deco.CmdInfo[num] = CurInfo
	local jump, jumpTrue = CurInfo.Jump, (CurInfo.JumpY and 3 or 2)
	CurInfo.CanEmit = CurInfo.CanEmit or not invis

	if cmdStruct["?size"] ~= #def - ((num == 6 or num == 0xD) and 1 or 0) then
		error(("Cmd%d size(%d) doesn't match CmdDef size(%d)"):format(num, cmdStruct["?size"], #def - (num == 6 and 1 or 0)), 2)
	end

	-- fill order
	do
		local offs = {}
		for a, b in pairs(offs0) do
			offs[b] = a
		end
		local j = 0
		local s
		for i = 0, cmdStruct["?size"] - 1 do
			s = offs[i]
			if s and s ~= jump then
				j = j + 1
				order[j] = s
			end
		end
	end

	DeclareCmd[num] = function(t)
		local len = #def
		EvtAssert(BufPtr + len + 5 <= EvtBufEnd, 'evt buffer overfow')
		u2[BufPtr + 1] = 0x7FFF
		u1[BufPtr + 3] = LineN
		u1[BufPtr + 4] = num
		FillLine()
		mem.copy(BufPtr + 5, def, len)
		if t then
			local a = cmdStruct:new(BufPtr + 5)
			local kn
			for k,v in pairs(t) do
				kn = order[k] or k
				if kn == textName then
					len = cmdStruct["?size"] + #v
					EvtAssert(BufPtr + len + 5 <= EvtBufEnd, 'evt buffer overfow')
				end
				a[kn] = v
			end
		end
		u1[BufPtr] = len + 4
		BufPtr = BufPtr + len + 5
	end

	if invis ~= nil then
		return
	end
	
	local function MakeEvt(player)
		return function(t, ...)
			if t == nil or type(t) ~= "table" then
				t = {t, ...}
			end
			if jump then
				t[jump] = 3
			end

			local o = offsets
			local old1, old2, old3, old4 = u4[o.CurrentEvtBuf], u4[o.CurrentEvtLines], u4[o.CurrentEvtLinesCount], i4[o.AbortEvt]
			local oldEvt, oldBuf, oldLines, oldPlayer, oldCurrentPlayer = EvtBuf, BufPtr, LinesBuf, evt.Player, evt.CurrentPlayer
			EvtBuf = BufPtr
			LineN = 0
			DeclareCmd[0]()  -- for buggy commands like 0x1A
			DeclareCmd[num](t)
			DeclareCmd[1]()
			DeclareCmd[1]()  -- for jump

			if num == 3 then
				Game.LoadSound(t.Id or 0)
			elseif num == 0x21 and mmver == 8 and Game.CurrentScreen == 0 then
				mem.u4[0xFFD45C] = 0
			end

			u4[o.CurrentEvtLinesCount] = LineN
			local IsGlobal = t.Global == true and (GlobalEventInfo ~= 0 and GlobalEventInfo or 1) or t.Global == false and 0 or GlobalEventInfo
			local oldGlobalEventInfo
			if IsGlobal or u4[o.GlobalEventInfo] == 0 then
				oldGlobalEventInfo = u4[o.GlobalEventInfo]
				u4[o.GlobalEventInfo] = IsGlobal or (Game.CurrentScreen == 4 or Game.CurrentScreen == 13) and 1 or 0
			end
			u4[o.EvtTargetObj] = TargetObj or 0
			local player = player or evt.Player
			if not player or player == evt.Players.Current then
				player = evt.CurrentPlayer or evt.Players.Current
			end
			u4[o.CurrentEvtBuf] = EvtBuf
			u4[o.CurrentEvtLines] = oldLines

			local ret = mem.call(internal.CallProcessEvent2, 0, 0x7FFF, t.KeepSound and 1 or 0, player, MayShow)
			local abort = i4[o.AbortEvt] ~= 0

			if oldGlobalEventInfo then
				u4[o.GlobalEventInfo] = oldGlobalEventInfo
			end
			EvtBuf, BufPtr, LinesBuf, evt.Player, evt.CurrentPlayer = oldEvt, oldBuf, oldLines, oldPlayer, oldCurrentPlayer
			u4[o.CurrentEvtBuf], u4[o.CurrentEvtLines], u4[o.CurrentEvtLinesCount], i4[o.AbortEvt] = old1, old2, old3, old4

			if abort then -- don't overwrite async command if aborted due to lack of gold
				if not t.OnDone and not t.NoYield and coroutine.running() then
					return coroutine.yield()
				end
			elseif ret == 0 then -- async command
				AsyncTrue = jumpTrue
				AsyncProc = t.OnDone
				AsyncPlayer, AsyncCurrentPlayer = evt.Player, evt.CurrentPlayer
				local c = not AsyncProc and not t.NoYield and coroutine.running()
				if c then
					AsyncProc = c
					return coroutine.yield()
				end
			end
			return (ret == jumpTrue)
		end
	end
	evt[name] = MakeEvt()
	for i = 0, (mmver == 8 and 4 or 3) do
		evt[i][name] = MakeEvt(i)
	end
	evt.All[name] = MakeEvt(5)
	evt.Random[name] = MakeEvt(6)
	evt.Current[name] = MakeEvt(mmver == 8 and 7 or 4)
end

--------------------------------------------------------------------------------

local function DeclareCommands()

	local types_u1
	do
		mem.struct(function(define)  types_u1 = define.u1  end)
	end
	local function EvtVar(name)
		local a = mmver == 6 and u1 or u2
		return mem.structs.CustomType(name or "VarNum", mmver == 6 and 1 or 2,
			function(o, obj, name, val)
				local p = obj["?ptr"] + o
				if val then
					a[p] = evt.VarNum[val] or val
				else
					val = a[p]
					return VarNumToStr[val] or val --a[p]
				end
			end
		).Info{Type = "evt.VarNum"}
	end

	local function EvtString(name)
		CurInfo.TextName = name
		return mem.structs.CustomType(name, 1,
			function(o, obj, name, val)
				local p = obj["?ptr"] + o
				if val then
					mem.copy(p, val, #val + 1)
				else
					return mem.string(p)
				end
			end
		)
	end

	local function YJump(name)
		CurInfo.Jump = name
		CurInfo.JumpY = true
		return types_u1(name).Info(false)
	end

	local function NJump(name)
		CurInfo.Jump = name
		CurInfo.JumpY = false
		return types_u1(name).Info(false)
	end

	local getdefine = mem.structs.getdefine
	local function Type(kind)
		local define = getdefine()
		CurInfo.FieldTypes[define.LastDefinedMemberName] = kind
		return define.Info{Type = "const."..kind}
	end

	local function Mastery(name)
		return mem.structs.CustomType(name or 'Mastery', 1,
			function(o, obj, name, val)
				local p = obj["?ptr"] + o
				if val == nil then
					return u1[p] + 1
				end
				u1[p] = val - 1
			end
		).Info{Type = "const"}
	end

	local function Player(name)
		return mem.structs.CustomType(name or 'Player', 1,
			function(o, obj, name, val)
				local p = obj["?ptr"] + o
				if val then
					u1[p] = evt.Players[val] or val
				else
					val = u1[p]
					return PlayerToStr[val] or val
				end
			end
		).Info{Type = "evt.Players"}
	end

	---------------------------
	MakeCmd("Cmd00", 0x00, function(define)
	end, true)
	
	---------------------------
	MakeCmd("Exit", 0x01, function(define)
		define
		.size = 1
	end, true)

	---------------------------
	MakeCmd("EnterHouse", 0x02, function(define)
		define
		.u4  'Id'
		 .Info ("In 2DEvents.txt\n"..
		  "600 = you won\n"..
		  "601 = you won 2 / you lost")
	end)

	---------------------------
	MakeCmd("PlaySound", 0x03, function(define)
		define
		.i4  'Id'
		.i4  'X'
		.i4  'Y'
	end)

	---------------------------
	MakeCmd("Hint", 0x04, function(define)
		define
		.u1  'Str'
	end, true)

	---------------------------
	MakeCmd("MazeInfo", 0x05, function(define)
		define
		.u1  'Str'
	end, true)

	---------------------------
	MakeCmd("MoveToMap", 0x06, function(define)
		define.Info ("Notes:\n"..
		 "If cancel is pressed, event execution is stopped\n"..
		 "If 'X', 'Y', 'Z', 'Direction', 'LookAngle', 'SpeedZ' are all 0, the party isn't moved\n"..
		 "If 'HouseId' and 'Icon' are 0, the enter dungeon dialog isn't shown")

		define
		.i4  'X'
		.i4  'Y'
		.i4  'Z'
		.i4  'Direction'
		 .Info "-1 = special case"
		.i4  'LookAngle'
		.i4  'SpeedZ'
		define[mmver == 8 and "u2" or "u1"]  'HouseId'
		 .Info "In 2DEvents.txt"
		define.u1  'Icon'
		EvtString 'Name'
		 .Info 'if unspecified or starts with "0" => current map'
	end)

	---------------------------
	MakeCmd("OpenChest", 0x07, function(define)
		define
		.u1  'Id'
	end)

	---------------------------
	MakeCmd("FaceExpression", 0x08, function(define)
		Player()
		.u1  'Frame'
	end)

	---------------------------
	MakeCmd("DamagePlayer", 0x09, function(define)
		Player()
		.u1  'DamageType'
		 Type("Damage")
		.i4  'Damage'
	end)

	---------------------------
	MakeCmd("SetSnow", 0x0A, function(define)
		define
		.u1  'EffectId'
		 .Info "Only 0 available"
		.b1  'On'
	end)

	---------------------------
	MakeCmd("SetTexture", 0x0B, function(define)
		define
		.i4  'Facet'
		 .Info "[MM6]  Index in #Map.Facets:# indoors.\n[MM7+]  Id of facets group."
		EvtString 'Name'
	end)

	---------------------------
	if mmver ~= 6 then
		MakeCmd("ShowMovie", 0x0C, function(define)
			define
			.u1  'DoubleSize'
			.b1  'ExitCurrentScreen'
			 .Info ("Use 'true' only before using #evt.MoveToMap:# command in houses and before showing game ending.\n"
			   .."Prevents loading of house anmation after the movie stops playing, but doesn't exit the screen properly.")
			EvtString 'Name'
		end)
	else
		MakeCmd("SetTextureOutdoors", 0x0C, function(define)
			define
			.u4  'Model'
			.u4  'Facet'
			EvtString 'Name'
		end)
	end

	---------------------------
	MakeCmd("SetSprite", 0x0D, function(define)
		define
		.i4  'SpriteId'
		.u1  'Visible'
		 .Info "bit 0x20 of sprite"
		EvtString 'Name'
		 .Info[[If 'Name' is unspecified or "0", the sprite isn't changed]]
	end)

	---------------------------
	MakeCmd("Cmp", 0x0E, function(define)
		define.Info "Usually performs Variable >= Value comparison"
		EvtVar  'VarNum'
		.i4  'Value'
		YJump  '  jump'
		
		CurInfo.Simple = true
		CurInfo.ForPlayer = true
	end)

	---------------------------
	MakeCmd("SetDoorState", 0x0F, function(define)
		define
		.u1  'Id'
		.u1  'State'
		 .Info "0 - state (0),\n1 - state (1),\n2 - switch state if the door isn't moving,\n3 - switch state"
	end)

	---------------------------
	MakeCmd("Add", 0x10, function(define)
		EvtVar  'VarNum'
		.i4  'Value'
		
		CurInfo.Simple = true
		CurInfo.ForPlayer = true
	end)

	---------------------------
	MakeCmd("Subtract", 0x11, function(define)
		define.Info "Also available as 'evt.Sub'."
		EvtVar  'VarNum'
		.i4  'Value'
		
		CurInfo.Simple = true
		CurInfo.ForPlayer = true
	end)
	for _, t in pairs(EvtTables) do
		t.Sub = t.Subtract
	end

	---------------------------
	MakeCmd("Set", 0x12, function(define)
		EvtVar  'VarNum'
		.i4  'Value'
		
		CurInfo.Simple = true
		CurInfo.ForPlayer = true
	end)
	
	---------------------------
	MakeCmd("SummonMonsters", 0x13, function(define)
		define
		.u1  'TypeIndexInMapStats'
		.u1  'Level'
		.u1  'Count'
		.i4  'X'
		.i4  'Y'
		.i4  'Z'
		if mmver ~= 6 then
			define
			.i4  'NPCGroup'
			.i4  'unk'
		end
	end)

	---------------------------
	MakeCmd("Cmd14", 0x14, function(define)
		define
		.i4  'unk_1'
		.u1  'unk_2'
	end, true)

	---------------------------
	MakeCmd("CastSpell", 0x15, function(define)
		define
		.u1  'Spell'
		Mastery()
		.u1  'Skill'
		.i4  'FromX'
		.i4  'FromY'
		.i4  'FromZ'
		.i4  'ToX'
		.i4  'ToY'
		.i4  'ToZ'
	end)

	---------------------------
	MakeCmd("SpeakNPC", 0x16, function(define)
		define
		.i4  'NPC'
	end)

	---------------------------
	MakeCmd("SetFacetBit", 0x17, function(define)
		define
		.i4  'Id'
		 .Info "[MM6]  Index in #Map.Facets:# indoors.\n[MM7+]  Id of facets group."
		.u4  'Bit'
		 Type("FacetBits")
		.b1  'On'
	end)

	---------------------------
	if mmver == 6 then
		MakeCmd("SetFacetBitOutdoors", 0x18, function(define)
			define
			.i4  'Model'
			 .Info "Model index in #Map.Models:#"
			.i4  'Facet'
			 .Info "-1 = for all faces of the model"
			.i4  'Bit'
			 Type("FacetBits")
			.b1  'On'
		end)
	else
		MakeCmd("SetMonsterBit", 0x18, function(define)
			define
			.i4  'Monster'
			.i4  'Bit'
			 Type("MonsterBits")
			.b1  'On'
		end)
	end

	---------------------------
	MakeCmd("RandomGoTo", 0x19, function(define)
		define
		.u1  'jumpA'
		.u1  'jumpB'
		.u1  'jumpC'
		.u1  'jumpD'
		.u1  'jumpE'
		.u1  'jumpF'
		 .Info "0 to skip a label"
		CurInfo.CanEmit = true
	end, true)

	---------------------------
	MakeCmd("Question", 0x1A, function(define)
		define
		 .Info [=[Use #Question:# function instead, e.g.!Lua[[
if Question("Restricted area - Keep out.", "What's the password?"):lower() == "jbard" then ...]]]=]
		.i4  'Question'
		.i4  'Answer1'
		.i4  'Answer2'
		YJump  '  jump(ok)'
	end)

	---------------------------
	MakeCmd("Cmd1B", 0x1B, function(define)
		define
		.u1  'unk_1'
		.u1  'unk_2'
	end, true)

	---------------------------
	MakeCmd("Cmd1C", 0x1C, function(define)
		define
		.u1  'unk_1'
	end, true)

	---------------------------
	MakeCmd("StatusText", 0x1D, function(define)
		define
		 .Info [=[Use #Game.ShowStatusText:# function instead, e.g.!Lua[[
Game.ShowStatusText("Hi!")]]]=]
		.i4  'Str'
	end)

	---------------------------
	MakeCmd("SetMessage", 0x1E, function(define)
		define
		 .Info [=[Use #Message:# function instead, e.g.!Lua[[
Message("Hi!")]]]=]
		.i4  'Str'
	end)

	---------------------------
	local function DeclareTimer(define)
		define
		.b1  'EachYear'
		.b1  'EachMonth'
		.b1  'EachWeek'
		-- else each day at the specified time
		.u1  'Hour'
		.u1  'Minute'
		.u1  'Second'
		.u2  'IntervalInHalfMinutes'
		.skip(2)
		
		local Timer = "Timer(<function>, "
		
		function define.f:Decompile(cmd)
			local s, s1
			if self.IntervalInHalfMinutes ~= 0 then
				local s, n = "*const.Minute", self.IntervalInHalfMinutes/2
				if n % 60 == 0 then
					s, n = "*const.Hour", n/60
				end
				return Timer..n..s..")"
			elseif self.EachYear then
				s = "const.Year"
			elseif self.EachMonth then
				s = "const.Month"
			elseif self.EachWeek then
				s = "const.Week"
			else
				s = "const.Day"
				local t = {self.Hour ~= 0 and self.Hour.."*const.Hour" or nil}
				t[#t+1] = (self.Minute ~= 0 and self.Minute.."*const.Minute" or nil)
				t[#t+1] = (self.Second ~= 0 and self.Second.."*const.Second" or nil)
				t[1] = t[1] or "0"
				s1 = table.concat(t, " + ")
			end
			if cmd == 0x1F and s1 then
				return Timer..s..", "..s1..", false)"
			elseif cmd == 0x1F then
				return Timer..s..")"
			end
			return "Refill"..Timer..s..")"
		end
	end
	
	MakeCmd("OnTimer", 0x1F, DeclareTimer, true)

	---------------------------
	MakeCmd("SetLight", 0x20, function(define)
		define
		.i4  'Id'
		 .Info "[MM6, MM7]  #Map.Lights:# index\n[MM8]  Light group id"
		.b1  'On'
	end)

	---------------------------
	MakeCmd("SimpleMessage", 0x21, function(define)
		define
		 .Info [=[Use #Message:# function instead, e.g.!Lua[[
Message("Hi!")]]]=]
		.skip(1)
	end)

	---------------------------
	MakeCmd("SummonObject", 0x22, function(define)
		if mmver == 8 then
			define.i4  'Item'
			 .Info "Item index. Index over 1000 means random item of the same kind as 'Item' % 1000 of strength 'Item' div 1000. For backward compatibility, this parameter can also be called 'Type'."
			CurInfo.FieldsOrder.Type = "Item"  -- for backward compatibility
		else
			define.i4  'Type'
			 .Info "Object kind index (ObjList.txt)"
		end
		define
		.i4  'X'
		.i4  'Y'
		.i4  'Z'
		.i4  'Speed'
		.u1  'Count'
		.b1  'RandomAngle'
	end)

	---------------------------
	MakeCmd("ForPlayer", 0x23, function(define)
		define
		.Info([[
Sets current player and returns 'evt'. You can thus write things like this:!Lua[=[
	evt.ForPlayer("All").Add("Exp", 1000)]=]
You can also manipulate #evt.Player:# and #evt.CurrentPlayer:# variables directly.
Usually a better approach is to specify player after 'evt', this way it only effects one call that follows:!Lua[=[
	evt.All.Add("Exp", 1000)
	evt[0].Add("Gold", 1000)]=]
]])
		Player()
	end, false)

	---------------------------
	MakeCmd("GoTo", 0x24, function(define)
		YJump  'jump'
	end, true)

	---------------------------
	MakeCmd("OnLoadMap", 0x25, function(define)
		define
		.skip(1)
		
		function define.f:Decompile(cmd)
			return "function events.LoadMap()"
		end
	end, true)

	---------------------------
	MakeCmd("OnRefillTimer", 0x26, DeclareTimer, true)

	---------------------------
	MakeCmd("SetNPCTopic", 0x27, function(define)
		define
		.i4  'NPC'
		.u1  'Index'
		.i4  'Event'
	end)

	---------------------------
	MakeCmd("MoveNPC", 0x28, function(define)
		define
		.u4  'NPC'
		.u4  'HouseId'
		 .Info "In 2DEvents.txt"
	end)

	---------------------------
	MakeCmd("GiveItem", 0x29, function(define)
		define
		.u1  'Strength'
		 .Info "1-6 (like described at the end of STDITEMS.TXT)"
		.u1  'Type'
		 Type("ItemType")
		.u4  'Id'
		 .Info ("If 'Id' is 0, a random item is chosen from the specified class with specified strength,\n"..
		  "otherwise, 'Type' and 'Strength' determine the enchantments")
	end)

	---------------------------
	MakeCmd("ChangeEvent", 0x2A, function(define)
		define
		.u4  'NewEvent'
		 .Info "Changes global event for barrels, pedestals etc. The kinds of sprites with such events are hard-coded."
	end)

	---------------------------
	MakeCmd("CheckSkill", 0x2B, function(define)
		define
		 .Info "Checks that the skill meets specified 'Level' requirement and that 'Mastery' exactly matches that of the player (Novice matches any mastery). Was supposed to include \"Double effect\" enchantments and NPC bonuses, but doesn't."
		.u1  'Skill'
		 Type("Skills")
		Mastery()
		.i4  'Level'
		YJump  '  jump(>=)'
		CurInfo.ForPlayer = true
	end)


	--------------------------- Patch

	MakeCmd("RefundChestArtifacts", 0x45, function(define)
		define
		 .Info "To be added in 2.5.6 or 2.6 of the patches. Removes all artifacts randomly generated in the chest from #Party.ArtifactsFound:structs.GameParty.ArtifactsFound#."
		.u1  'Id'
	end)


	--------------------------- MM7

	if mmver < 7 then
		return
	end

	---------------------------
	MakeCmd("CanShowTopic.Cmp", 0x2C, function(define)
		EvtVar  'VarNum'
		.i4  'Value'
		YJump  '  jump'
		
		CurInfo.Simple = true
		CurInfo.CanEmit = true
	end, true)

	---------------------------
	MakeCmd("CanShowTopic.Exit", 0x2D, function(define)
		define
		.skip(1)
	end, true)

	---------------------------
	MakeCmd("CanShowTopic.Set", 0x2E, function(define)
		define
		.b1  'Visible'
		CurInfo.CanEmit = true
	end, true)

	---------------------------
	MakeCmd("SetNPCGroupNews", 0x2F, function(define)
		define
		.u4  'NPCGroup'
		.u4  'NPCNews'
	end)

	---------------------------
	MakeCmd("SetMonsterGroup", 0x30, function(define)
		define
		.u4  'Monster'
		.u4  'NPCGroup'
	end)

	---------------------------
	MakeCmd("SetNPCItem", 0x31, function(define)
		define
		.i4  'NPC'
		.i4  'Item'
		.b1  'On'
	end)

	---------------------------
	MakeCmd("SetNPCGreeting", 0x32, function(define)
		define
		.i4  'NPC'
		.i4  'Greeting'
	end)

	---------------------------
	local function CheckMonstersKilled(define)
		define
		.u1  'CheckType'
		 .Info "0 - any monster, 1 - in group, 2 - of type, 3 - specific monster, 4 - specific monster by name (MM8)"
		.u4  'Id'
		 .Info "Depending on 'CheckType': 0 - not used, 1 - group id, 2 - monster type minus 1, 3 - monster id, 4 - id in placemon.txt (MM8 only)"
		.u1  'Count'
		 .Info "0 - all must be killed, else a number of monsters that must be killed"
		if mmver == 8 then
			define.u1  'InvisibleAsDead'
			 .Info "1 (default) - treat invisible (that is, currently disabled, like pirates in Ravenshore before you enter Regna) monsters as dead when counting, 0 - include invisible monsters"
		end
		YJump  '  jump(>=)'
		CurInfo.CanEmit = true
	end
	
	MakeCmd("CheckMonstersKilled", 0x33, CheckMonstersKilled)

	---------------------------
	MakeCmd("CanShowTopic.CheckMonstersKilled", 0x34, CheckMonstersKilled, true)

	---------------------------
	MakeCmd("OnLeaveMap", 0x35, function(define)
		define
		.skip(1)

		function define.f:Decompile(cmd)
			return "function events.LeaveMap()"
		end
	end, true)

	---------------------------
	MakeCmd("ChangeGroupToGroup", 0x36, function(define)
		define
		.i4  'Old'
		.i4  'New'
	end)
	
	---------------------------
	MakeCmd("ChangeGroupAlly", 0x37, function(define)
		define
		.i4  'NPCGroup'
		.i4  'Ally'
		 .Info "Monster class that guards this group. That is, !Lua[[(Id + 2):div(3)]], like in Hostile.txt."
	end)
	
	---------------------------
	MakeCmd("CheckSeason", 0x38, function(define)
		define
		.u1  'Season'
		YJump  '  jump(ok)'
	end)

	---------------------------
	MakeCmd("SetMonGroupBit", 0x39, function(define)
		define
		.i4  'NPCGroup'
		.u4  'Bit'
		 Type("MonsterBits")
		.b1  'On'
	end)

	---------------------------
	MakeCmd("SetChestBit", 0x3A, function(define)
		define
		.i4  'ChestId'
		.u4  'Bit'
		 Type("ChestBits")
		.b1  'On'
	end)

	---------------------------
	MakeCmd("FaceAnimation", 0x3B, function(define)
		Player()
		.u1  'Animation'
	end)

	---------------------------
	MakeCmd("SetMonsterItem", 0x3C, function(define)
		define
		.i4  'Monster'
		.i4  'Item'
		.b1  'Has'
	end)

	--------------------------- MM8

	if mmver < 8 then
		return
	end

	---------------------------
	MakeCmd("OnDateTimer", 0x3D, function(define)
		define
		.u1  'Id'
		 .Info "0x3D00 is added to this"
		.u1  'HourPlus1'
		.u1  'DayPlus1'
		.u1  'WeekPlus1'
		.u1  'YearPlus1'
		.u2  'FullYearPlus1'
		.u1  'EnableAfter'
		 .Info ("works every half of second\n"..
		  "By default date timer is disabled!")
		CurInfo.CanEmit = true
	end, true)

	---------------------------
	MakeCmd("EnableDateTimer", 0x3E, function(define)
		define
		.u2  'IdPlus0x3D00'
		 .Info "add 0x3D00 to Id of Cmd_3D"
		.b1  'On'
		CurInfo.CanEmit = true
	end, true)

	---------------------------
	MakeCmd("StopDoor", 0x3F, function(define)
		define
		.i4  'Id'
	end)

	---------------------------
	MakeCmd("CheckItemsCount", 0x40, function(define)
		define
		.u2  'MinItemIndex'
		.u2  'MaxItemIndex'
		.u2  'Count'
		YJump  '  jump(>=)'
	end)

	---------------------------
	MakeCmd("RemoveItems", 0x41, function(define)
		define
		.u2  'MinItemIndex'
		.u2  'MaxItemIndex'
		.u2  'Count'
	end)

	---------------------------
	MakeCmd("Jump", 0x42, function(define)
		define
		.i2  'Direction'
		.i2  'ZAngle'
		.i4  'Speed'
	end)

	---------------------------
	MakeCmd("IsTotalBountyInRange", 0x43, function(define)
		define
		.i4  'MinGold'
		.i4  'MaxGold'
		YJump  '  jump(ok)'
	end)

	---------------------------
	MakeCmd("CanPlayerAct", 0x44, function(define)
		define
		.u4  'Id'
		 .Info "from Roster.txt"
		YJump  '  jump(ok)'
	end)
	for _, t in pairs(EvtTables) do
		t.IsPlayerInParty = t.CanPlayerAct  -- backward compatibility
	end

end

--------------------------------------------------------------------------------

CmdDef[0x00] = ""
CmdDef[0x01] = "\0"
CmdDef[0x02] = "\0\0\0\0"
CmdDef[0x03] = "\0\0\0\0\0\0\0\0\0\0\0\0"
CmdDef[0x04] = "\0"
CmdDef[0x05] = "\0" -- MM6
if mmver == 8 then
	CmdDef[0x06] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\48\0"
else
	CmdDef[0x06] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\48\0"
end
CmdDef[0x07] = "\0"
CmdDef[0x08] = "\4\0" -- MM6
if mmver == 8 then
	CmdDef[0x09] = "\7\0\0\0\0\0"
else
	CmdDef[0x09] = "\4\0\0\0\0\0"
end
CmdDef[0x0A] = "\0\0" -- MM6
CmdDef[0x0B] = "\0\0\0\0\0"
if mmver ~= 6 then
	CmdDef[0x0C] = "\1\0\0" -- (ShowMovie)
else
	CmdDef[0x0C] = "\0\0\0\0\0\0\0\0\0"
end
CmdDef[0x0D] = "\0\0\0\0\1\48\0"
if mmver ~= 6 then
	CmdDef[0x0E] = "\0\0\0\0\0\0\0"
else
	CmdDef[0x0E] = "\0\0\0\0\0\0"
end
CmdDef[0x0F] = "\0\0"
if mmver ~= 6 then
	CmdDef[0x10] = "\0\0\0\0\0\0"
else
	CmdDef[0x10] = "\0\0\0\0\0"
end
if mmver ~= 6 then
	CmdDef[0x11] = "\0\0\0\0\0\0"
else
	CmdDef[0x11] = "\0\0\0\0\0"
end
if mmver ~= 6 then
	CmdDef[0x12] = "\0\0\0\0\0\0"
else
	CmdDef[0x12] = "\0\0\0\0\0"
end
if mmver ~= 6 then
	CmdDef[0x13] = "\1\1\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
else
	CmdDef[0x13] = "\1\1\1\0\0\0\0\0\0\0\0\0\0\0\0"
end
CmdDef[0x14] = "\0\0\0\0\1"
CmdDef[0x15] = "\0\3\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
CmdDef[0x16] = "\0\0\0\0"
CmdDef[0x17] = "\0\0\0\0\0\0\0\0\0"
if mmver ~= 6 then
	CmdDef[0x18] = "\0\0\0\0\0\0\0\0\0"
else
	CmdDef[0x18] = "\0\0\0\0\255\255\255\255\0\0\0\0\0"
end
CmdDef[0x19] = "\1\0\0\0\0\0"
CmdDef[0x1A] = "\0\0\0\0\0\0\0\0\0\0\0\0\0"
CmdDef[0x1B] = "\0\0"
CmdDef[0x1C] = "\0"
CmdDef[0x1D] = "\0\0\0\0"
CmdDef[0x1E] = "\0\0\0\0"
CmdDef[0x1F] = "\0\0\0\0\0\0\0\0\0\0"
CmdDef[0x20] = "\1\0\0\0\0"
CmdDef[0x21] = "\0"
CmdDef[0x22] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\232\3\0\0\1\0"
CmdDef[0x23] = "\0"
CmdDef[0x24] = "\0"
CmdDef[0x25] = "\0"
CmdDef[0x26] = "\0\0\0\0\0\0\0\0\0\0"
CmdDef[0x27] = "\0\0\0\0\0\0\0\0\0"
CmdDef[0x28] = "\0\0\0\0\0\0\0\0"
CmdDef[0x29] = "\1\0\0\0\0\0"
CmdDef[0x2A] = "\0\0\0\0"
CmdDef[0x2B] = "\0\3\40\0\0\0\0"
CmdDef[0x2C] = "\0\0\0\0\0\0\0"
CmdDef[0x2D] = "\0"
CmdDef[0x2E] = "\0"
CmdDef[0x2F] = "\0\0\0\0\0\0\0\0"
CmdDef[0x30] = "\0\0\0\0\0\0\0\0"
CmdDef[0x31] = "\0\0\0\0\0\0\0\0\0"
CmdDef[0x32] = "\0\0\0\0\0\0\0\0"
if mmver == 8 then
	CmdDef[0x33] = "\0\0\0\0\0\0\1\0"
else
	CmdDef[0x33] = "\0\0\0\0\0\0\0"
end
CmdDef[0x34] = CmdDef[0x33]
CmdDef[0x35] = "\0"
CmdDef[0x36] = "\0\0\0\0\0\0\0\0"
CmdDef[0x37] = "\0\0\0\0\0\0\0\0"
CmdDef[0x38] = "\0\0"
CmdDef[0x39] = "\0\0\0\0\0\0\0\0\0"
CmdDef[0x3A] = "\0\0\0\0\1\0\0\0\0"
if mmver == 8 then
	CmdDef[0x3B] = "\7\18"
else
	CmdDef[0x3B] = "\4\18"
end
CmdDef[0x3C] = "\0\0\0\0\0\0\0\0\1"
CmdDef[0x3D] = "\0\0\0\0\0\0\0\0"
CmdDef[0x3E] = "\0\0\0"
CmdDef[0x3F] = "\0\0\0\0"
CmdDef[0x40] = "\0\0\0\0\0\0\0"
CmdDef[0x41] = "\0\0\0\0\0\0"
CmdDef[0x42] = "\0\0\0\0\220\5\0\0"
CmdDef[0x43] = "\0\0\0\0\0\0\0\0\0"
CmdDef[0x44] = "\0\0\0\0\0"
CmdDef[0x45] = "\0"

DeclareCommands()

----------- Enums

if mmver ~= 8 then
	evt.Players = {
		[0] = 0,
		[1] = 1,
		[2] = 2,
		[3] = 3,
		Current = 4,
		current = 4,
		All = 5,
		all = 5,
		Random = 6,
		random = 6,
	}
else
	evt.Players = {
		[0] = 0,
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		All = 5,
		all = 5,
		Random = 6,
		random = 6,
		Current = 7,
		current = 7,
	}
end

for k, v in pairs(evt.Players) do
	if type(k) ~= "number" and k ~= k:lower() then
		PlayerToStr[v] = k  -- "Players."..k
	end
end


do
	local p, LastName = 1, nil
	evt.VarNum = {}
	local function add(name, name2)
		if name then
			evt.VarNum[name] = p
			VarNumToStr[p] = name
			-- print("\t"..name.." = "..p..",")
		end
		if name2 then
			evt.VarNum[name2] = p
		end
		p, LastName = p + 1, name
	end
	local function comment(s)
		if internal.VarNumComments then
			internal.VarNumComments[LastName] = s
		end
	end
	
	add("SexIs")                     -- 01
	add("ClassIs")                   -- 02
	add("HP")                        -- 03
	add("HasFullHP")                 -- 04
	add("SP")                        -- 05
	add("HasFullSP")                 -- 06
	add("ArmorClass", "AC")          -- 07
	add("ArmorClassBonus", "ACBonus")-- 08
	add("BaseLevel")                 -- 09
	add("LevelBonus")                -- 0A
	add("AgeBonus")                  -- 0B
	add("Awards")                    -- 0C
	add("Experience", "Exp")         -- 0D
	add(nil)                         -- 0E : not used
	add(nil)                         -- 0F : not used
	add("QBits")                     -- 10
	add("Inventory", "Items")        -- 11
	add("HourIs")                    -- 12
	add("DayOfYearIs")               -- 13
	add("DayOfWeekIs")               -- 14
	add("Gold")                      -- 15
	add("GoldAddRandom")             -- 16
	add("Food")                      -- 17
	add("FoodAddRandom")             -- 18
	add("MightBonus")                -- 19
	add("IntellectBonus")            -- 1A
	add("PersonalityBonus")          -- 1B
	add("EnduranceBonus")            -- 1C
	add("SpeedBonus")                -- 1D
	add("AccuracyBonus")             -- 1E
	add("LuckBonus")                 -- 1F
	add("BaseMight")                 -- 20
	add("BaseIntellect")             -- 21
	add("BasePersonality")           -- 22
	add("BaseEndurance")             -- 23
	add("BaseSpeed")                 -- 24
	add("BaseAccuracy")              -- 25
	add("BaseLuck")                  -- 26
	add("CurrentMight")              -- 27
	add("CurrentIntellect")          -- 28
	add("CurrentPersonality")        -- 29
	add("CurrentEndurance")          -- 2A
	add("CurrentSpeed")              -- 2B
	add("CurrentAccuracy")           -- 2C
	add("CurrentLuck")               -- 2D
	evt.VarNum.BaseStats = {}
	evt.VarNum.CurrentStats = {}
	for k, v in pairs(const.Stats) do
		if v < 7 then
			evt.VarNum.BaseStats[v] = assert(evt.VarNum["Base"..k])
			evt.VarNum.CurrentStats[v] = assert(evt.VarNum["Current"..k])
		end
	end
	local function AddRes(name)
		local t, res = {}, mmver == 6 and
			{'Fire', 'Elec', 'Cold', 'Poison', 'Magic'} or
			{'Fire', 'Air', 'Water', 'Earth', 'Spirit', 'Mind', 'Body', 'Light', 'Dark', false, 'Magic'}
		evt.VarNum[name] = t
		for i, s in ipairs(res) do
			if s then
				t[const.Damage[s]] = p
				add(s..name)
				if i >= 8 then
					comment "unused resistance"
				end
			else
				add(nil)
			end
		end
	end
	AddRes'Resistance'               -- 2E-32/2E-38
	AddRes'ResBonus'                 -- 33-37/39-43
	evt.VarNum.Skills = {}           -- 38-56/44-68/44-6A
	for i, v in sortpairs(table.invert(const.Skills)) do
		evt.VarNum.Skills[i] = p
		add(v.."Skill")
	end
	evt.VarNum.Conditions = {}
	for k, i in pairs(const.Condition) do
		if i <= 16 then
			evt.VarNum.Conditions[i] = p + i
			evt.VarNum[k] = p + i
		end
	end
	add("Cursed")                    -- 57/69/6B
	add("Weak")                      -- 58/6A
	add("Asleep")                    -- 59/6B
	add("Afraid")                    -- 5A/6C
	add("Drunk")                     -- 5B/6D
	add("Insane")                    -- 5C/6E
	add("PoisonedGreen")             -- 5D/6F
	add("DiseasedGreen")             -- 5E/70
	add("PoisonedYellow")            -- 5F/71
	add("DiseasedYellow")            -- 60/72
	add("PoisonedRed")               -- 61/73
	add("DiseasedRed")               -- 62/74
	add("Paralysed")                 -- 63/75
	add("Unconscious")               -- 64/76
	add("Dead")                      -- 65/77
	add("Stoned")                    -- 66/78
	add("Eradicated")                -- 67/79
	add("MainCondition")             -- 68/7A/7C
	evt.VarNum.MapVars = {}          -- 69-CC/7B-DE/7D-E0
	for i = 0, 99 do
		evt.VarNum.MapVars[i] = p
		add("MapVar"..i)
	end
	add("AutonotesBits")             -- CD/DF/E1
	add("IsMightMoreThanBase")       -- CE/E0
	add("IsIntellectMoreThanBase")   -- CF/E1
	add("IsPersonalityMoreThanBase") -- D0/E2
	add("IsEnduranceMoreThanBase")   -- D1/E3
	add("IsSpeedMoreThanBase")       -- D2/E4
	add("IsAccuracyMoreThanBase")    -- D3/E5
	add("IsLuckMoreThanBase")        -- D4/E6
	add("PlayerBits")                -- D5/E7/E9
	add(mmver ~= 8 and "NPCs" or nil)-- D6/E8
	add("ReputationIs")              -- D7/E9/EB
	evt.VarNum.DaysCounters = {}
	for i = 1, 6 do
		evt.VarNum.DaysCounters[i] = p
		add("DaysCounter"..i)          -- D8-DD/EA-EF/EC-F1
		 comment "#evt.Set:# starts the count, #evt.Cmp:# compares the difference of dates"
	end
	add("Flying")                    -- DE/F0/F2
	add("HasNPCProfession")          -- DF/F1
	add("TotalCircusPrize")          -- E0/F2
	add("SkillPoints")               -- E1/F3
	add("MonthIs")                   -- E2/F4
	if mmver >= 7 then
		evt.VarNum.Counters = {}
		for i = 1, 10 do
			evt.VarNum.Counters[i] = p
			add("Counter"..i)            -- F5-FE/F7-100
			 comment "#evt.Set:# starts the count, #evt.Cmp:# compares the exact time spent in hours"
		end
		evt.VarNum.SpecialDates = {}
		for i = 1, 20 do
			evt.VarNum.SpecialDates[i] = p
			add('SpecialDate'..i)        -- FF-112/101-114
			 comment('#evt.Set:# remembers current time and plays sound. The date can be used in messages as %'..(50 + i))
		end
		add("Reputation")              -- 113/115
		evt.VarNum.History = {}        -- 114/116
		for i = 1, 29 do
			evt.VarNum.History[i] = p
			add("History"..i)
		end
		add("MapAlert")                -- 131/133
		add("BankGold")                -- 132/134
		add("Deaths")                  -- 133/135
		add("MontersHunted")           -- 134/136
		add("PrisonTerms")             -- 135/137
		add("ArenaWinsPage")           -- 136/138
		add("ArenaWinsSquire")         -- 137/138
		add("ArenaWinsKnight")         -- 138/13A
		add("ArenaWinsLord")           -- 139/13B
		add("Invisible")               -- 13A/13C
		add("IsWearingItem")           -- 13B/13D
		if mmver == 8 then
			add("Players")               -- 13E
		end
	end
	
	if mmver == 6 and evt.VarNum.MonthIs ~= 0xE2 or mmver == 7 and evt.VarNum.IsWearingItem ~= 0x13B or mmver == 8 and evt.VarNum.Players ~= 0x13E then
		error("wrong evt.VarNum")
	end
end

--------- Decompile

dofile(internal.CoreScriptsPath.."evtdeco.lua", Deco)
