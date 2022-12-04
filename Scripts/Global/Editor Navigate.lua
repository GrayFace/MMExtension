local DevPath = DevPath or AppPath

Editor = Editor or {}
local _KNOWNGLOBALS

local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local skSpawn = 1
local skObject = 2
local skMonster = 3
local skSprite = 5
local skFacet = 6
local skLight = 7

local function nullproc()
end

local DLL = mem.dll[DevPath.."ExeMods\\MMExtension\\MMEditorDlg.dll"]

local HookManager = HookManager
local TmpHooks = HookManager()
if not TmpHooks.AddEx then  -- support older MMExt versions just in case
	local old = HookManager
	function HookManager(...)
		local t = old(...)
		local add = t.Add
		function t.Add(memf, ...)
			if memf ~= mem.hook and memf ~= mem.hookjmp then
				return add(memf, ...)
			end
			local ret
			add(function(...)
				ret = memf(...)
			end, ...)
			return ret
		end
		for proc in pairs{hook = false, hookjmp = false} do
			t[proc] = function(...)
				return t.Add(mem[proc], ...)
			end
		end
		function t.AddEx(RetMem, ...)
			return add(...)
		end
		return t
	end
	TmpHooks = HookManager()
end

events.LeaveGame = TmpHooks.Clear

local function TmpHookManager(...)
	local t = HookManager(...)
	TmpHooks[#TmpHooks + 1] = t.Clear
	return t
end

local function TmpAlloc(size)
	local p = mem.hookalloc(size)
	TmpHooks[#TmpHooks + 1] = function(on)
		if on == "off" then
			mem.hookfree(p)
		end
	end
	return p
end

local WorkModeHooks = TmpHookManager{}

local function WorkHookManager(...)
	local t = HookManager(...)
	WorkModeHooks[#WorkModeHooks + 1] = t.Switch
	return t
end

-----------------------------------------------------
-- Editor.SetWorkMode
-----------------------------------------------------

Editor.SelectionKind = Editor.SelectionKind or skObject

local PatchOptionsPtr = mem.dll[AppPath.."mm"..mmver.."patch"].GetOptions
PatchOptionsPtr = PatchOptionsPtr and PatchOptionsPtr()
local PatchOptionsSize = PatchOptionsPtr and i4[PatchOptionsPtr] or 0

local PatchOptions = {}
local PatchOpOff = 4

local function PatchOption(name, val, p)
	p = p or PatchOpOff
	PatchOpOff = p + 4
	if val and PatchOptionsSize >= p + 4 then
		Editor[name] = Editor[name] or i4[PatchOptionsPtr + p]
		PatchOptions[#PatchOptions + 1] = {PatchOptionsPtr + p, Editor[name], val}
	end
end

local function SwitchPatchOptions(on)
	for _, t in ipairs(PatchOptions) do
		local p, std, v = unpack(t)
		i4[p] = on and v or std
	end
end

PatchOption("BaseMaxLookAngle", 512)
PatchOption("BaseMouseLook", 1)
PatchOption("BaseMouseLookUseAltMode")
PatchOption("BaseCapsLockToggleMouseLook")
PatchOption("BaseMouseFly", 1)
PatchOption("BaseWheelFly")
PatchOption("BaseMouseLookTempKey")
PatchOption("BaseMouseLookChangeKey")
PatchOption("BaseInventoryKey", 0)
PatchOption("BaseCharScreenKey", 0)

local function SwitchableEvents()
	local t, was = {}, false
	return t, function(on)
		if not on ~= was then
			return
		end
		was = not was
		for s, f in pairs(t) do
			events[was and 'add' or 'remove'](s, f)
		end
	end
end
local WorkEvents, SwitchWorkEvents = SwitchableEvents()
local WorkLoadEvents, SwitchWorkLoadEvents = SwitchableEvents()
Editor.SwitchWorkLoadEvents = SwitchWorkLoadEvents

function events.LeaveGame()
	Editor.LoadBlvTime = nil
	Editor.SetWorkMode(false)
	Editor.SwitchWorkLoadEvents = nil
end

function Editor.SetWorkMode(mode)
	Editor.Time = Game.Time
	Editor.WorkMode = mode
	SwitchPatchOptions(mode)
	WorkModeHooks.Switch(mode)
	SwitchWorkEvents(mode)
	SwitchWorkLoadEvents(mode or Editor.LoadBlvTime)
	if mode then
		-- Party.NeedRender = false
		Party.Drowning = false
		Party.InAir = true
		Party.EnemyDetectorRed = false
		Party.EnemyDetectorYellow = false
		Party.FlyingBit = false
		Party.WaterWalkingBit = false
		Party.InJumpSpell = true
		Party.InLava = false
		if Editor.SelectionKind == skFacet then
			local sel = Editor.Selection
			Editor.Selection = {}
			for id in pairs(sel) do
				Editor.SelectSingleFacet(id)
			end
		end
	elseif Editor.SelectionKind == skFacet then
		local sel = Editor.Selection  -- table.copy(Editor.Selection)
		Editor.ClearSelection()
		Editor.Selection = sel
	end
	events.EditorSelectionChanged()
	Editor.UpdateVisibility(true)
	Editor.UpdateTileSelectState()
	if Editor.State and Editor.StateSync then
		if mode then
			Editor.UpdateDynamicStuff()
		elseif not Editor.State.TestWithLivingMonsters then
			-- kill monsters to avoid them killing player
			for _, a in Map.Monsters do
				if a.AIState ~= 19 then
					a.AIState = 5
				end
			end
		end
	end
	Editor.UpdateGameBits()
	Editor.UpdateShowInvisible()
	Editor.UpdateNoDark()
end

-----------------------------------------------------
-- Free movement
-----------------------------------------------------

function Editor.ProcessDoors(move)
	local old = not move and Game.TimeDelta
	if old then
		Game.TimeDelta = 0
	end
	mem.call(mmv(0x4603E0, 0x46F22C, 0x46DD08))
	if old then
		Game.TimeDelta = old
	end
end

local deltaX, deltaY, deltaZ = 0, 0, 0
local SubDir = PatchOptionsSize >= 388 + 8 and PatchOptionsPtr + 388

local function PartyDir()
	return Party.Direction + (SubDir and i4[SubDir] or 0)/2048
end

local function PartyLookAngle()
	return Party.LookAngle + (SubDir and i4[SubDir + 4] or 0)/2048
end

function Editor.GetPartyDirection()
	local a, b = PartyDir()*math.pi/1024, PartyLookAngle()*math.pi/1024
	local c = math.cos(b)
	return math.cos(a)*c, math.sin(a)*c, math.sin(b)
end

function Editor.GetMouseDirection()
	local mx, my = (Game.Mouse.GetPos or XYZ)(Game.Mouse)
	if mmver == 6 then
		my = my + i4[0x9DE3C0] - i4[0x9DE3C4]
	end

	local angle = PartyLookAngle() + mem.call(mmv(0x45B880, 0x46A0FA, 0x46846A), 2, my)
	local a, b = PartyDir()*math.pi/1024, angle*math.pi/1024
	local ca, sa = math.cos(a), math.sin(a)
	local cb = math.cos(b)
	local x, y, z = ca*cb, sa*cb, math.sin(b)
	local ax = mem.call(mmv(0x45B880, 0x46A0A5, 0x468415), 2, mx)*math.pi/1024
	local c, s = math.cos(ax), math.sin(ax)
	-- return x*c - sa*s, y*c + ca*s, z*c

	local px = x*c - sa*s
  local py = y*c + ca*s
  local pz = z*c
	local d = (px*px + py*py + pz*pz)^-0.5
	return px*d, py*d, pz*d
end

function Editor.GetPartyUpDirection()
	local a, b = Party.Direction*math.pi/1024, Party.LookAngle*math.pi/1024
	local c = -math.sin(b)
	return math.cos(a)*c, math.sin(a)*c, math.cos(b)
end

function Editor.GetPartyRightDirection()
	local a = (Party.Direction - 512)*math.pi/1024
	return math.cos(a), math.sin(a), 0
end

WorkModeHooks.hook(mmv(0x453B5E, 0x463471, 0x461451), function(data)
	local d = i4[offsets.TimeStruct1 + 0x1C]*8
	if Keys.IsPressed(const.Keys.CTRL) then
		d = 0
	elseif Keys.IsPressed(const.Keys.SHIFT) then
		d = d*3
	end
	local x, y, z = deltaX, deltaY, deltaZ
	do
		local x1, y1, z1 = Editor.GetPartyDirection()
		local d = d*((Keys.IsPressed(const.Keys.W) and 1 or 0) - (Keys.IsPressed(const.Keys.S) and 1 or 0))
		x, y, z = x + x1*d, y + y1*d, z + z1*d
	end
	do
		local x1, y1 = Editor.GetPartyRightDirection()
		local d = d/2*((Keys.IsPressed(const.Keys.D) and 1 or 0) - (Keys.IsPressed(const.Keys.A) and 1 or 0))
		x, y = x + x1*d, y + y1*d
	end
	deltaX, deltaY, deltaZ = x%1, y%1, z%1
	Party.X, Party.Y, Party.Z = Party.X + x - deltaX, Party.Y + y - deltaY, Party.Z + z - deltaZ

	Editor.ProcessDoors(true)
	u4[data.esp] = u4[data.esp] + 5  -- skip movement
end)

function WorkEvents.WindowMessage(t)
	if t.Msg == 0x20A and Game.CurrentScreen == 0 then  -- mouse wheel
		local d = 40*(t.WParam < 0 and -1 or 1)*(Keys.IsPressed(const.Keys.SHIFT) and 2 or 1)
		local x, y, z = Editor.GetPartyUpDirection()
		Party.X = Party.X + d*x
		Party.Y = Party.Y + d*y
		Party.Z = Party.Z + d*z
	elseif t.Msg == 0x203 and Editor.StateSync then  -- WM_LBUTTONDBLCLK
		t.Msg = 0x201  -- WM_LBUTTONDOWN
	end
end

function Editor.CopyPartyPos(to, from)
	XYZ(to, XYZ(from))
	to.Direction = from.Direction
	to.LookAngle = from.LookAngle
end

function WorkEvents.Tick()
	if not Editor.LoadBlvTime then
		Game.Time = Editor.Time
	end
	if Editor.StateSync and Game.CurrentScreen == 0 and not Game.MoveToMap.Defined then
		Editor.State.Party = Editor.State.Party or {}
		Editor.CopyPartyPos(Editor.State.Party, Party)
	end
end

-----------------------------------------------------
-- Ignore standard actions
-----------------------------------------------------

local IgnoreActions = {
	[23] = true,
	[25] = true,
	[94] = true,
	[106] = true,
	[200] = true,
	[105] = true,
	[201] = true,
	[224] = true,
	[104] = true,
	[176] = true,
	[168] = true,
	[134] = true,
	[135] = true,
	[203] = true,  -- 'T'
	-- [10] = true,  -- click
	-- [14] = true,  -- click
}

local IgnoreActionsSync = {
	[404] = true,  -- space
	[110] = true,  -- select character
}

function WorkEvents.Action(t)
	if Game.CurrentScreen == 0 and
			(IgnoreActions[t.Action] or Editor.StateSync and IgnoreActionsSync[t.Action]) then
		t.Action = 0
	end
end

local allowKeys = {[9] = 1, [18] = 2, [23] = 2, [24] = 2}

function WorkLoadEvents.KeysFilter(t)
	if (Editor.WorkMode or Editor.LoadBlvTime) and Game.CurrentScreen == 0 then
		t.Result = t.On and (allowKeys[t.Key] or 0) > (Editor.StateSync and 1 or 0)  -- and Keys.IsPressed(const.Keys.M)
	end
end

-----------------------------------------------------
-- See from outside of rooms
-----------------------------------------------------

local max, min = math.max, math.min

local function CalcRoomDist(r, x, y, z)
	x = max(0, r.MinX - x) + max(0, x - r.MaxX)
	y = max(0, r.MinY - y) + max(0, y - r.MaxY)
	z = max(0, r.MinZ - z) + max(0, z - r.MaxZ)
	return x*x + y*y + z*z
end

local LastRoom

WorkModeHooks.autohook(mmv(0x4344F8, 0x44086E, 0x43D7D6), function(d)
	if d.eax == 0 then
		local x, y, z = Party.X, Party.Y, Party.Z
		local room, dist = LastRoom, LastRoom and LastRoom <= Map.Rooms.high and CalcRoomDist(Map.Rooms[LastRoom], x, y, z) or math.huge
		for i, r in Map.Rooms do
			local d = CalcRoomDist(r, x, y, z)
			if d < dist then
				room, dist = i, d
			end
		end
		i4[d.esi + 0x1C] = room
	else
		LastRoom = d.eax
	end
end)


-- ROOM = 1
-- oldHK = mem.hook(0x43C3A0, function(d)
	-- mem.call(oldHK, 0)
	-- if i4[0x52CE64] == 0 then
		-- i4[0x52CE64] = ROOM
		-- local n = Map.Rooms.Count
		-- i4[0x52DE84] = n - 1
		-- for i = 1, n do
			-- local o = (i - 1)*0x8CC
			-- local a1, a2, a3, a4 = i4[0x52CE9C], i4[0x52CEA0], i4[0x52CEA4], i4[0x52CEA8]
			-- i2[0x52DE88 + o] = i
			-- i2[0x52DE8A + o], i2[0x52DE8C + o], i2[0x52DE8E + o], i2[0x52DE90 + o] = a1, a2, a3, a4
			-- mem.call(0x43C90D, 1, 0x52DE94 + o, a1, a2, a3, a4)
			-- i2[0x52E62C + o] = -1
			-- i4[0x52E630 + o] = 1
		-- end
		-- for i = 0, n - 1 do
			-- mem.call(0x43D5C4, 2, i)
		-- end
		-- mem.call(0x43C247, 1, 0x52CEE0)
	-- end
-- end)

-----------------------------------------------------
-- Draw flickering sprite selection
-----------------------------------------------------

-- local FlickerState
-- local FlickerTime = 0
-- local FlickerInterval = 200

-- function events.TimeChanged()
	-- if Editor.WorkMode and Editor.StateSync and Game.CurrentScreen == 0 and next(Editor.Selection) then
		-- --local time = timeGetTime()
		-- if Editor.SelectionKind == skSprite then--and time > FlickerTime then
			-- --FlickerTime = time + FlickerInterval
			-- FlickerState = not FlickerState
			-- local sprites = Map.Sprites
			-- for i in pairs(Editor.Selection) do
				-- sprites[i].Invisible = FlickerState
			-- end
		-- end
	-- end
-- end

-----------------------------------------------------
-- Left Click - Select facets and objects
-----------------------------------------------------

local function ForEachModelFacet(id, proc, param)
	id = (type(id) ~= "number" and Editor.FacetIds[id] or id)
	local base = Editor.Models[id:div(64) + 1].PartOf
	for m, mid in pairs(Editor.ModelIds) do
		if m.PartOf == base then
			for i = mid*64, mid*64 + 63 do
				if not Editor.Facets[i + 1] then
					break
				end
				proc(i, param)
			end
		end
	end
end

local function ForEachFacetPart(id, proc, param)
	if Editor.ModelMode and Map.IsOutdoor() then
		return ForEachModelFacet(id, proc, param)
	end
	local base = (type(id) ~= "number" and id or Editor.Facets[id + 1]).PartOf
	for f, i in pairs(Editor.FacetIds) do
		if f.PartOf == base then
			proc(i, param)
		end
	end
end

function Editor.ClearSelection()
	if Editor.SelectFacetBitmapMode and Editor.SelectionKind == skFacet then
		for id in pairs(Editor.Selection) do
			if Editor.ModelMode then
				Editor.DeselectFacet(id)
			else
				Editor.DeselectSingleFacet(id)
			end
		end
	end
	Editor.Selection = {}
	Editor.SelectionChanged = true
end

function Editor.SelectSingleFacet(id)
	if not Editor.Selection[id] then
		local f = Map.GetFacet(id)
		Editor.Selection[id] = true
		if Editor.SelectFacetBitmapMode then
			if f.AnimatedTFT then
				f.AnimatedTFT = false
			else
				Editor.Selection[id] = f.BitmapId
			end
			f.BitmapId = (mmver == 6 and Editor.LoadBitmap("pending") or Editor.LoadBitmap("effpar01"))
		end
		Editor.SelectionChanged = true
		-- FlickerState = false
	end
end

function Editor.SelectFacet(id)
	ForEachFacetPart(id, Editor.SelectSingleFacet)
end

function Editor.DeselectSingleFacet(id, force)
	if Editor.Selection[id] or force then
		if Editor.SelectFacetBitmapMode then
			local a = Map.GetFacet(id)
			local bmp = Editor.Selection[id]
			if true or bmp == true then
				Editor.LoadFacetBitmap(a, Editor.Facets[id + 1])
			else
				a.BitmapId = bmp
			end
		end
		Editor.Selection[id] = nil
		Editor.SelectionChanged = true
	end
end

function Editor.DeselectFacet(id)
	ForEachFacetPart(id, Editor.DeselectSingleFacet, Editor.SelectFacetBitmapMode and Editor.ModelMode)
end


-- Left Click - Select facets and objects
local std

std = TmpHooks.hook(mmv(0x42D4E6, 0x434F45, 0x4328D2), function()
	Editor.LButtonPressed = true
	if Editor.WorkMode and Editor.StateSync and (Editor.TileBrushSize == 0 or Map.IsIndoor()) then
		local obj = Mouse.GetTarget()
		local kind = obj.Kind
		local id = obj.Index
		-- unselect
		if not Keys.IsPressed(const.Keys.SHIFT) then
			Editor.ClearSelection()
		elseif next(Editor.Selection) and (kind ~= Editor.SelectionKind) then
			return
		end
		Editor.SelectionKind = kind
		-- check if it's a proper id
		local props = Editor.GetNewProps()
		if not props or not props.get(id, "OBJ") then
			return Editor.UpdateSelectionState()
		end
		-- select
		if Editor.Selection[id] then
			-- unselect on second shift+click
			if kind == skFacet then
				Editor.DeselectFacet(id)
			else
				Editor.Selection[id] = nil
			end
		elseif kind == skFacet then
			Editor.SelectFacet(id)
		elseif kind <= 7 and kind >= 1 then
			Editor.Selection[id] = true
		end
		Editor.UpdateSelectionState()
	else
		mem.call(std, 0)
	end
end)


-----------------------------------------------------
-- Tint selected facets
-----------------------------------------------------

local SelectionColorBuf = TmpAlloc(4)
Editor.SelectionColor = Editor.SelectionColor or 0x50A0A0

local hooks = TmpHookManager{
	PtrGetBW = PalettesInfo and PalettesInfo.PtrGetBW,
	-- MapFacets = mmv(0x5F7AA8, 0x6BE248, 0x6F3A08) + 636,
	MapFacetOff = mmv(0x50, 0x60, 0x60) - 2,  -- use 1 of 2 unused bytes
	TintColor = SelectionColorBuf,
	ModelFacetOff = 0x128,  -- use 1 of 2 unused bytes
	IndoorDarkness = mmv(0x9DDAA4, 0xF8ABD4, 0xFFCFDC),
	FacetPtrBuf = TmpAlloc(4),
}

if Game.IsD3D then

	-- indoor
	hooks.asmhook(mmv(nil, 0x4A2F97, 0x4A0E4C), [[
		mov eax, [ebp + 0xC]  ; facet
		;mov [%FacetPtrBuf%], eax
		cmp byte [eax + %MapFacetOff%], 0
		jz @f
		mov eax, [%TintColor%]
		mov [ebp - 4], eax
	@@:
	]])

	-- need to set color, move vertices to front etc.
	-- hooks.asmhook(mmv(nil, nil, 0x4A10F7), [[
	-- 	mov eax, [%FacetPtrBuf%]  ; facet
	-- 	cmp byte [eax + %MapFacetOff%], 0
	-- 	jz @f
	-- 	mov     eax, [edi+40088h]
	-- 	mov     eax, [eax+38h]
	-- 	mov     ecx, [eax]
	-- 	push    1Ch
	-- 	push    dword ptr [ebp+8]
	-- 	push    $7BC410
	-- 	push    1C4h
	-- 	push    2
	-- 	push    eax
	-- 	call    dword ptr [ecx+70h]
	-- @@:
	-- ]])
	
	-- outdoor
	hooks.asmhook2(mmv(nil, 0x4A1FE6, 0x49FAE1), [[
		mov eax, [ebp + 0x10]
		mov [%FacetPtrBuf%], eax
	]])
	
	local OutCode = [[
		mov ecx, [%FacetPtrBuf%]  ; facet
		cmp byte [ecx + %ModelFacetOff%], 0
		jz @f
		mov eax, [%TintColor%]
	@@:
	]]
	hooks.asmhook2(mmv(nil, 0x4A2578, 0x4A006B), OutCode)
	hooks.asmhook2(mmv(nil, 0x4A20F4, 0x49FBF3), OutCode)

	-- Tiles
	-- local TileCode = [[
		-- ; poly: [ebp + Ch]
		-- ; X: [poly + 5Ch]
		-- ; Y: [poly + 5Dh]
		-- mov eax, 0x50B0B0
	-- ]]
	-- hooks.asmhook2(0x4A0643, TileCode)
	-- hooks.asmhook2(0x4A0B38, TileCode)
	
elseif mmver ~= 6 then

	-- indoor
	hooks.asmhook(mmv(nil, 0x47C250, 0x47B53F), [[
		; facet: ecx
		; pal: edx
		cmp byte [ecx + %MapFacetOff%], 0
		jz @f
		
		; no shades
		mov dword [%IndoorDarkness%], 0

		mov ecx, edx
		call absolute %PtrGetBW%
		ret 8
	@@:
	]])
	
	-- outdoor
	hooks.asmhook(mmv(nil, 0x47C1CE, 0x47B4BD), [[
		; poly: ecx
		; facet: [poly + 54h]
		; PolyType: [poly + 59h]
		cmp byte [ecx + 0x59], 5
		jnz @f
		mov eax, [ecx + 0x54]
		cmp byte [eax + %ModelFacetOff%], 0
		jz @f

		mov eax, [ecx + 0x3C]
		movsx ecx, word [eax + 0x26]
		call absolute %PtrGetBW%
		ret 8h
	@@:
	]])
	
else  -- not working

	-- indoor
	-- fasm doesn't make an optimal instruction size here: hooks.asmpatch(0x492A19, "db 0x83, 0xEC, 0x90", 3)
	
	-- save facet ptr
	hooks.asmhook(0x494F22, [[mov al, [esi + %MapFacetOff%]
		mov [%FacetPtrBuf%], al
	]])  
	
	local codeIn = [[
		; facet bit: [%FacetPtrBuf%]
		; pal: %i% -> %out%
		cmp byte [%FacetPtrBuf%], 0
		jz @f
		
		; no shades
		mov dword [%IndoorDarkness%], 0

		savereg %savereg%
		
		mov ecx, %i%
		call absolute %PtrGetBW%
		mov %out%, eax
		
		loadreg
		%after%
		jmp absolute %jmp%
	@@:
	]]

	local ref = hooks.ref
	ref.after = ""
	
	ref.savereg = "eax, edx"
	ref.i = "ecx"
	ref.out = "ecx"
	ref.jmp = 0x49520B
	hooks.asmhook(0x495202, codeIn)
	
	ref.savereg = "ecx"
	ref.i = "edx"
	ref.out = "eax"
	ref.jmp = 0x49545B
	hooks.asmhook(0x495449, codeIn)
	
	ref.savereg = "eax, ecx"
	ref.i = "edx"
	ref.out = "edx"
	ref.jmp = 0x492B3C
	hooks.asmhook(0x492B33, codeIn)
	ref.jmp = 0x493444
	hooks.asmhook(0x49343B, codeIn)
	
	ref.savereg = "edx"
	ref.i = "eax"
	ref.out = "ecx"
	ref.after = "cmp byte [0x52D278], 0"
	ref.jmp = 0x492EE1
	hooks.asmhook(0x492EC8, codeIn)
	
	-- outdoor
	hooks.asmhook(0x46B8F0, [[
		; poly: edx
		; facet: [poly + 48h]
		; PolyType: [poly + 4Eh]
		cmp byte [edx + 0x4E], 5
		jnz @f
		mov eax, [edx + 0x48]
		cmp byte [eax + %ModelFacetOff%], 0
		jz @f

		mov eax, [edx + 0x30]
		movsx ecx, word [eax + 0x26]
		call absolute %PtrGetBW%
		ret 8h
	@@:
	]])
end

hooks.Switch(false)
Editor.SelectedModels = {}
Editor.RawSelectedModels = {}

function events.EditorSelectionChanged()
	local kind = (Editor.WorkMode and Editor.StateSync and next(Editor.Selection) and Editor.SelectionKind)
	local on = (kind == skFacet and not Editor.SelectFacetBitmapMode)
	hooks.Switch(on)
	mem.i4[SelectionColorBuf] = Editor.SelectionColor
	if mmver > 6 then
		local p = 0xE20 + mem.u4[mmv(nil, 0x71FE94, 0x75CE00)]
		local v = mem.u4[p]
		local function bit(n, on)
			v = on and v:Or(n) or v:AndNot(n)
		end
		bit(0x800, not on)
		mem.u4[p] = v
	end
	local Sel = Editor.Selection
	if on and Map.IsIndoor() then
		local sz = mmv(0x50, 0x60, 0x60)
		local p = Map.Facets["?ptr"] + hooks.ref.MapFacetOff
		for i = 0, Map.Facets.Count - 1 do
			u1[p + i*sz] = Sel[i] and 1 or 0
		end
	elseif on or kind == skFacet and Editor.ModelMode then
		local mmode = Editor.ModelMode
		local lsel = Editor.RawSelectedModels
		local msel = {}
		for id in pairs(Editor.Selection) do
			msel[id:div(64)] = true
		end
		if mmode then
			local selo = {}
			for id in pairs(msel) do
				selo[Editor.Models[id + 1].PartOf] = true
			end
			for t, id in pairs(Editor.ModelIds) do
				if selo[t.PartOf] then
					msel[id] = true
				end
			end
			Editor.SelectedModels = selo
		end
		Editor.RawSelectedModels = msel
		if not on then
			return
		end
		local sz = 0x134
		local MapModels = Map.Models
		for _, mid in pairs(Editor.ModelIds) do
			if lsel[mid] or msel[mid] then
				local m = MapModels[mid]
				local p = m.Facets["?ptr"] + hooks.ref.ModelFacetOff
				if mmode then
					local on = msel[mid] and 1 or 0
					for i = 0, m.Facets.Count - 1 do
						u1[p + i*sz] = on
					end
				else
					for i = 0, m.Facets.Count - 1 do
						u1[p + i*sz] = mmode or Sel[mid*64 + i] and 1 or 0
					end
				end
			end
		end
	end
end


-----------------------------------------------------
-- Tint selected objects
-----------------------------------------------------

local hooks = TmpHookManager{
	PtrGetBW = PalettesInfo and PalettesInfo.PtrGetBW,
	TintColor = SelectionColorBuf,
}

if Game.IsD3D then

	-- local function hookf(d)
		-- local obj = u2[u4[d.ebp - 0x20] - 0x28 + 0x10]
		-- local kind = obj % 8
		-- if kind == Editor.SelectionKind and Editor.Selection[(obj - kind)/8] then
			-- d.eax = Editor.SelectionColor
		-- end
	-- end
	-- hooks.autohook(mmv(0, 0x4A4485, 0x4A2338), hookf)
	-- hooks.autohook(mmv(0, 0x4A40FD, 0x4A1FB2), hookf)
	
	local code = [[
		mov ecx, [ebp - 0x20]
		mov cx, [ecx - 0x28 + 0x1E]
		test ecx, 0x100  ; test the BW palette bit I use for selection in SW
		jz @f
		mov eax, [%TintColor%]
	@@:
	]]
	hooks.asmhook(mmv(nil, 0x4A4485, 0x4A2338), code)
	hooks.asmhook(mmv(nil, 0x4A40FD, 0x4A1FB2), code)

-- elseif mmver ~= 6 and hooks then  -- not working in MM8, done in spawn/light hook instead

	-- local function hookf(d)
		-- local p = d.eax
		-- local obj = u2[p + 0x10]
		-- local kind = obj % 8
		-- if kind == Editor.SelectionKind and Editor.Selection[(obj - kind)/8] then
			-- u2[p + 0x1E] = u2[p + 0x1E]:Or(0x100)
			-- -- d.ecx = 300
		-- end
	-- end
	-- hooks.autohook(mmv(nil, 0x43F5B7, 0x43C4BD), hookf)

-- elseif hooks then  -- done at spawn/light hook instead

	-- local function hookf(off)
		-- return function(d)
			-- local p = d.esi - off
			-- local obj = u2[p + 4]
			-- local kind = obj % 8
			-- if kind == Editor.SelectionKind and Editor.Selection[(obj - kind)/8] then
				-- u2[p + 0xE] = u2[p + 0xE]:Or(0x100)
				-- --u2[p + 0x1A] = Editor.SelectionShade
			-- end
		-- end
	-- end
	-- hooks.autohook(0x43338C, hookf(0xC))
	-- hooks.autohook(0x46B6C6, hookf(0xA))

end

hooks.Switch(false)

function events.EditorSelectionChanged()
	local kind = (Editor.WorkMode and Editor.StateSync and next(Editor.Selection) and Editor.SelectionKind)
	local on = (kind ~= 0 and kind ~= skFacet)
	hooks.Switch(on)
end


-----------------------------------------------------
-- Display spawn/light sprites, mark selected sprites
-----------------------------------------------------


do
	local hooks = TmpHooks
	
	local PalId = 23391
	Editor.PaletteNumber = PalId
	local SpawnNames = {
		[skMonster] = {"m1", "m2", "m3", "m1a", "m2a", "m3a", "m1b", "m2b", "m3b", "m1c", "m2c", "m3c"},
		[skObject] = {"i1", "i2", "i3", "i4", "i5", "i6", "i7"},
	}
	for _, t in pairs(SpawnNames) do
		for i, s in pairs(t) do
			t[i] = "Editor "..s
		end
	end
	local PalHook
	
	Editor.LightDrawLimit = Editor.LightDrawLimit or 10000
	Editor.SpawnDrawLimit = Editor.SpawnDrawLimit or 18000

	-- load my palette bypassing HSV conversion for better quality
	local function LoadPalette()
		if mmver == 6 then
			return Game.LoadPalette(PalId)
		end
		if not PalHook then
			hooks.ref.PalJmp = mmv(nil, 0x48A567, 0x489E5F)
			hooks.asmpatch(mmv(nil, 0x48A428, 0x489D1C), [[
				savereg esi, edi
				mov esi, eax
				lea edi, [ebp - 0x388]
				mov ecx, 256*3/4
				rep movsd
				loadreg
				jmp absolute %PalJmp%
			]])
			PalHook = #hooks
		else
			hooks[PalHook](true)
		end
		local Palette = Game.LoadPalette(PalId)
		hooks[PalHook](false)
		return Palette
	end
	
	local SpritesLod = Game.SpritesLod
	local DrawCount = mmv(0x4DA9B8, 0x518660, 0x529F40)
	local DrawSize = mmv(0x20, 0x34, 0x34)
	local DrawPal = mmv(0xA, 0x1A, 0x1A)
	local DrawSprite = mmv(0x8, 0x18, 0x18)
	local DrawObjRef = mmv(0x4, 0x10, 0x10)
	local DrawBits = mmv(0x0E, 0x1E, 0x1E)
	local DecName = mmv("Pending!", "Dec34", "pending")
	local BaseScale = 80000/Game.SFTBin[Game.DecListBin[Game.LoadDecSprite(DecName)].SFTIndex].Scale
	
	local function hookf(d)
		if not Editor.StateSync then
			return
		end
		local DrawMax = u4[mmv(0x4338AB, 0x43FC72, 0x43CBF6)]
		local DrawPtr = u4[mmv(0x4338A4+2, 0x43FC6B+2, 0x43CBEF+2)]
		local n = Map.Sprites.Count, nil
		Map.Sprites.Count = 1
		local a = Map.Sprites[0]
		a["?ptr"] = a["?ptr"]  -- speed up
		local old = mem.string(a["?ptr"], a["?size"], true)
		mem.fill(a)
		a.DecName = DecName
		local indoor = Map.IsIndoors()
		local Palette = LoadPalette()
		local LoadedSprites = {}
		
		local ended
		
		local function Add(SpName, ObjRef, scale, sel, ...)
			XYZ(a, ...)
			local i = i4[DrawCount]
			if indoor then
				local r = 0 --Map.RoomFromPoint(...)
				mem.call(mmv(0x433530, 0x43FA56, 0x43C95F), 2, 0, r)
			else
				mem.call(mmv(0x46A890, 0x47A962, 0x479B4A), 0)
			end
			if i4[DrawCount] > i then
				local p = DrawPtr + DrawSize*i
				if SpName then
					i4[p] = i4[p]*scale*BaseScale
					if mmver > 6 then
						i4[p + 4] = i4[p]
					end
					i2[p + DrawPal] = Palette
					local sp = LoadedSprites[SpName]
					if not sp then
						sp = SpritesLod:LoadSprite(SpName, PalId)
						LoadedSprites[SpName] = sp
					end
					i2[p + DrawSprite] = sp
				end
				if sel then
					u2[p + DrawBits] = u2[p + DrawBits]:Or(0x100)
				end
				u2[p + DrawObjRef] = ObjRef
			elseif i4[DrawCount] >= DrawMax then
				ended = true
			end
		end
		
		local x1, y1, z1 = XYZ(Party)
		local function CheckLim(x, y, z, lim)
			x = x - x1
			y = y - y1
			z = z - z1
			return not ended and x*x + y*y + z*z <= lim*lim
		end
		
		local SelKind = Editor.SelectionKind
		local Sel = Editor.Selection
		
		-- do sprites selection
		if next(Sel) and (SelKind == skSprite or SelKind == skMonster or SelKind == skObject) then
			for p = DrawPtr, DrawPtr + DrawSize*i4[DrawCount] - 1, DrawSize do
				local v = u2[p + DrawObjRef]
				local kind = v % 8
				if kind == SelKind and Sel[(v - kind)/8] then
					u2[p + DrawBits] = u2[p + DrawBits]:Or(0x100)
				end
			end
		end
		-- add spawns
		for t, i in pairs(Editor.SpawnIds) do
			local x, y, z = XYZ(t)
			if CheckLim(x, y, z, Editor.SpawnDrawLimit) then
				if not indoor then
					z = max(z, Map.GetGroundLevel(x, y) + 1)
				end
				local s = (SpawnNames[t.Kind] or {})[t.Index]
				local scale = (t.Kind == skMonster and 1 or t.Index == 7 and 1 or 0.7)
				Add(s, i*8 + skSpawn, scale, SelKind == skSpawn and Sel[i], x, y, z)
			end
		end
		-- add lights
		for t, i in pairs(Editor.LightIds) do
			local x, y, z = XYZ(t)
			if CheckLim(x, y, z, Editor.LightDrawLimit) then
				Add("EditorLight", i*8 + skLight, 0.5, SelKind == skLight and Sel[i], x, y, z)
			end
		end
		
		mem.copy(a["?ptr"], old, #old)
		a["?ptr"] = nil
		Map.Sprites.Count = n
	end
	
	WorkModeHooks.autohook(mmv(0x433187, 0x43F525, 0x43C40A), hookf)  -- indoor
	WorkModeHooks.autohook(mmv(0x46A242, 0x47A808, 0x4799FF), hookf)  -- outdoor
	
	--hooks.asmhook(0x43C415
end


-----------------------------------------------------
-- Change texture of selected tiles
-----------------------------------------------------

if not Editor.GroundHooked then
	local addr = mmv(0x47BA92, 0x488F05, 0x488805)
	local addr2 = (mmver == 8 and 0x486E5D or nil)
	local CodeStd = mem.string(addr, 5, true)
	local Code2Std = addr2 and mem.string(addr2, 5, true)
	
	local p = DLL.HookGroundBitmap(addr, addr2)
	
	local CodeMine = mem.string(addr, 5, true)
	local Code2Mine = addr2 and mem.string(addr2, 5, true)
	
	function Editor.DisplaySelectedTiles()
		mem.fill(p + 4, 128*128, 0)
		for n in pairs(Editor.SelectedTiles) do
			u1[p + 4 + n] = 1
		end
	end
	
	function Editor.UpdateTileSelectState()
		local on = Editor.WorkMode and Editor.StateSync and Editor.TileBrushSize > 0
		mem.IgnoreProtection(true)
		mem.copy(addr, on and CodeMine or CodeStd, 5)
		if addr2 then
			mem.copy(addr2, on and Code2Mine or Code2Std, 5)
		end
		mem.IgnoreProtection(false)
		i4[p] = on and Editor.LoadBitmap() or 0
	end
	Editor.UpdateTileSelectState()
	Editor.SelectedTiles = {}
end

-----------------------------------------------------
-- Avoid idclip effect in SW
-----------------------------------------------------

if not Game.IsD3D then
	WorkModeHooks.autohook(mmv(0x4371AD, 0x441D04, 0x43E95B), function(d)
		local p = d.ecx
		local x1 = i4[p + 0x2C]*2
		local w = i4[p + 0x34]*2 - x1
		local dy = i4[p + 0x24]*2
		local buf = u4[p + 0x20] + x1
		local buf2 = u4[p + 0x40] + x1*2
		for y = i4[p + 0x30], i4[p + 0x38] do
			mem.fill(buf + dy*y, w)
			mem.fill(buf2 + dy*y*2, w*2)
		end
	end)
end

-----------------------------------------------------
-- Load clean dlv 
-----------------------------------------------------

Editor.LoadedBlv = Editor.LoadedBlv or nullproc
TmpHooks.autohook(mmv(0x48C37B, 0x49AB56, 0x49806A), function(d)
	Editor.LoadedBlv()
end)

-----------------------------------------------------
-- Load clean ddm 
-----------------------------------------------------

TmpHooks.autohook(mmv(0x46E063, 0x47EBDC, 0x47E129), function(d)
	-- print(Map.Name, dump(Map.OutdoorHeader), dump(Map.OutdoorExtra))
	Editor.LoadedBlv()
end)

-----------------------------------------------------
-- Clean Portals display
-----------------------------------------------------

local function CleanPortals()
	mem.IgnoreProtection(true)
	if mmver == 7 then
		u2[0x49CD37] = 0xE990
		u1[0x49CC23] = 0xEB
		u1[0x49CAF7] = 0xEB
		u1[0x49C5AE] = 0xEB
		u1[0x49C64D] = 0xEB
	elseif mmver == 8 then
		u2[0x49A216] = 0xE990
		u1[0x499FD6] = 0xEB
		u1[0x49A102] = 0xEB
		u1[0x499A8D] = 0xEB
		u1[0x499B2C] = 0xEB
	end
	mem.IgnoreProtection(false)
	CleanPortals = nil
end

-----------------------------------------------------
-- Editor.UpdateGameBits
-----------------------------------------------------

function Editor.UpdateGameBits()
	local portals = Editor.ShowPortals and Editor.VisibleGUI
	if Game.Version > 6 then
		local p = 0xE20 + mem.u4[mmv(nil, 0x71FE94, 0x75CE00)]
		local v = mem.u4[p]
		local function bit(n, on)
			v = on and v:Or(n) or v:AndNot(n)
		end
		bit(8, portals)
		-- bit(2, Editor.NoShades and Editor.VisibleGUI)
		mem.u4[p] = v
		if portals and CleanPortals then
			CleanPortals()
		end
	end
	mem.u4[mmv(0x52D2A8, 0x576EB8, 0x587AE8)] = portals and 1 or 0
end

-----------------------------------------------------
-- Disable saving game and loading map scripts
-----------------------------------------------------

function events.CanSaveGame(t)
	if Editor.State and Editor.StateSync or Editor.LoadBlvTime then
		t.Result = false
	elseif Editor.WorkMode then
		Editor.SetWorkMode(false)
	end
end

function events.CancelLoadingMapScripts()
	if Editor.State and Editor.StateSync or Editor.LoadBlvTime then
		Map.LastRefillDay = 0
		return true
	end
end

function events.LoadSavedMap(t)
	if Editor.LoadBlvTime then
		Map.LastRefillDay = 0
	end
end

-----------------------------------------------------
-- Done: switch all work mode hooks off
-----------------------------------------------------

WorkModeHooks.Switch(false)
