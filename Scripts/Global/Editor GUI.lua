local memstr = mem.string
local persist = internal.persist
local unpersist = internal.unpersist
local DevPath = DevPath or AppPath

Editor = Editor or {}
local _KNOWNGLOBALS
Editor.Selection = Editor.Selection or {}
local skSpawn = 1  -- in the game 1 is for doors
local skObject = 2
local skMonster = 3
local skSprite = 5
local skFacet = 6
local skLight = 7
local skModel = 8


local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local MessageBox = MessageBox or Message
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end


local DLL = mem.dll[DevPath.."ExeMods/MMExtension/MMEditorDlg.dll"]
local Commands = {}
Editor.Commands = Commands

-- function events.Tick()
	-- if Editor.VisibleGUI then
		-- DLL.OnTick()
	-- end
-- end

function events.KeyDown(t)
	local key = t.Key
	if key == const.Keys.F1 and t.Alt then
		t.Key = 0
		Editor()
	elseif Editor.VisibleGUI and Game.CurrentScreen == 0 then
		if t.Alt then
			--
		elseif Keys.IsPressed(const.Keys.CTRL) then
			DLL.CtrlKeyPressed(key)
		else
			DLL.KeyPressed(key)
		end
		local IsNum = (key >= const.Keys.NUMPAD0 and key <= const.Keys.NUMPAD9)
		local IsShift = Keys.IsPressed(const.Keys.SHIFT) or not t.ExtendedKey and Keys.IsToggled(const.Keys.NUMLOCK) ~= IsNum
		if key == const.Keys.RIGHT or key == const.Keys.NUMPAD6 then
			Editor.MoveKeyPressed(1, 0, 0, IsShift)
		elseif key == const.Keys.LEFT or key == const.Keys.NUMPAD4 then
			Editor.MoveKeyPressed(-1, 0, 0, IsShift)
		elseif key == const.Keys.UP or key == const.Keys.NUMPAD8 then
			Editor.MoveKeyPressed(0, 1, 0, IsShift)
		elseif key == const.Keys.DOWN or key == const.Keys.NUMPAD2 then
			Editor.MoveKeyPressed(0, -1, 0, IsShift)
		elseif key == const.Keys.PGUP or key == const.Keys.NUMPAD9 then
			Editor.MoveKeyPressed(0, 0, 1, IsShift)
		elseif key == const.Keys.PGDN or key == const.Keys.NUMPAD3 then
			Editor.MoveKeyPressed(0, 0, -1, IsShift)
		end
	end
end

function events.KeyUp(t)
	if Editor.VisibleGUI and Game.CurrentScreen == 0 and not t.Alt and not Keys.IsPressed(const.Keys.CTRL) then
		DLL.KeyUp(t.Key)
	end
end

Editor.Close = DLL.CloseEditor
local function OnLeave()
	Editor.StateSync = false
	Editor.Selection = {}
	events.EditorSelectionChanged()
	Editor.Close()
end
events.LeaveMap = OnLeave
events.LeaveGame = OnLeave

local function CheckLastError()
	if Editor.LastError then
		local _, v = next(Editor.LastErrorFacets)
		if v and type(v) == "table" then  -- because somewhere I used index instead of vertex table
			v = v.Vertexes[1]
			Party.X, Party.Y, Party.Z = v.X, v.Y, v.Z
			-- select bad facets
			Editor.ClearSelection()
			Editor.SelectionKind = skFacet
			for _, f in pairs(Editor.LastErrorFacets) do
				Editor.SelectFacet(f)
			end
			Editor.SelectionChanged = true
			Editor.UpdateSelectionState()
		end
		MessageBox("Error: "..Editor.LastError..".", nil, "error")
	end
end

if not Editor.GUICommandHook then
	Editor.GUICommandHook = mem.hookalloc()
	mem.hookjmp(Editor.GUICommandHook, function(d)
		Editor.GUICommand(d, d:getparams(0, 2))
		d:ret(8)
	end)
end

local LastCmdResult
local NeedFocus

function Editor.GUICommand(d, cmd, params)
	Editor.LastError = nil
	cmd = Commands[memstr(cmd)]
	NeedFocus = cmd
	LastCmdResult = nil
	if cmd then
		Editor.BeginUndoState()
		local ok, ret = pcall2(cmd, params)
		Editor.EndUndoState()
		LastCmdResult = ok and ret
	end
	d.eax = mem.topointer(LastCmdResult)
	if NeedFocus then
		mem.dll.user32.BringWindowToTop(Game.WindowHandle)
	end
	
	Editor.CheckDoorsUpdate()
	Editor.UpdateSelectionState()
	CheckLastError()
end

function Editor.SetState(state)
	Editor.State = state
	Editor.StateSync = false
	Editor.UpdateSelectionState(true)
end

function Editor.SetStateLoaded()
	Editor.StateSync = true
	Editor.UpdateSelectionState(true)
	Editor.UpdateTileSelectState()
end

function Editor.UpdateBSPState()
	if Game.IsD3D or not Editor.State or not Editor.StateSync or Map.IsOutdoor() then
		return
	end
	local on = false
	for _, r in ipairs(Editor.State.Rooms) do
		if r.BSP == nil then
			on = true
			break
		end
	end
	DLL.UpdateBSPState(on)
end

function Editor.UpdateSelectionState(UpdState)
	if not Editor.VisibleGUI then
		return
	end
	if UpdState then
		Editor.CompleteUndoState()
		DLL.SetStateLoaded(not not Editor.State, not not Editor.StateSync, Map.IsOutdoor() == not (Editor.State or {}).Rooms, Map.IsOutdoor())
		DLL.SetUndoState(Editor.StateSync and Editor.HasUndo(), Editor.StateSync and Editor.HasRedo())
		Editor.UpdateBSPState()
	else
		Editor.CheckCompleteUndoState()
	end
	local sel = Editor.Selection
	local kind, kind2 = Editor.SelectionKind, 0
	local a = next(sel)
	if not a then
		Editor.SelectionKind = 0
		kind = 0
	elseif next(sel, a) then
		kind2 = 1
	end
	
	if Editor.SelectionChanged then
		Party.NeedRender = true
		events.EditorSelectionChanged()
	end
	
	if kind == skFacet and Map.IsIndoor() then
		-- 0 = no door, 1 = 1 door, 2 = 1 door not exact, 3 = multiple doors
		local NoDoor, Door, Door2 = false, nil, false
		for id in pairs(sel) do
			local door = Editor.Facets[id + 1].Door
			Door = Door or door
			if door == nil then
				NoDoor = true
			elseif door ~= Door then
				Door2 = true
			end
		end
		kind2 = Door2 and 3 or Door and (NoDoor and 2 or 1) or 0
		if kind2 == 1 then
			for f, id in pairs(Editor.FacetIds) do
				if f.Door == Door and not sel[id] then
					kind2 = 2
					break
				end
			end
		end
	elseif kind == skFacet and Editor.ModelMode then
		kind = skModel
		kind2 = (next(Editor.SelectedModels, next(Editor.SelectedModels)) and 1 or 0)
	end
	DLL.SetSelectionState(kind, kind2, Editor.SelectionChanged)
	Editor.SelectionChanged = false
end

function Editor.UndoChanged()
	DLL.SetUndoState(Editor.StateSync and Editor.HasUndo(), Editor.StateSync and Editor.HasRedo())
end

local function StartEditor()
	if Editor.VisibleGUI then
		return Editor.Close()
	end
	Game.TurnBased = 0
	Editor.VisibleGUI = true
	Editor.SetWorkMode(true)
	DLL.StartEditor(Game.WindowHandle, Editor.GUICommandHook, Game.IsD3D, mmver)
	Editor.UpdateSelectionState(true)
end
setmetatable(Editor, {__call = StartEditor})

function Commands.Closed()
	Editor.VisibleGUI = false
	Editor.SetWorkMode(false)
	Party.NeedRender = true
end

-----------------------------------------------------
-- Commands
-----------------------------------------------------

function Commands.SetMapsDir(dir)
	NeedFocus = false
	Editor.MapsDir = path.addslash(memstr(dir))
end

function Commands.GetFileName()
	NeedFocus = false
	return Editor.FileName
end

function Commands.GetSaveAsName()
	NeedFocus = false
	return Editor.FileName or Editor.DefaultFileName
end

function Commands.GetCompileName()
	NeedFocus = false
	local name = Editor.FileName or Editor.DefaultFileName
	name = name and path.name(name) or Map.Name
	return path.setext(name, '')
end

function Commands.GetExportFileName()
	NeedFocus = false
	local name = Editor.FileName or Editor.DefaultFileName
	name = name and path.name(name) or Map.Name
	return path.setext(name, '')
end

function Commands.GetMapName()
	NeedFocus = false
	return Map.Name
end

local function Import(name, AsObjects)
	Editor.ClearSelection()
	name = memstr(name)
	Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(path.name(name), Map.IsOutdoor() and ".odt" or '.dat')
	Editor.LoadObj(name, AsObjects)
	Editor.UpdateMap()
	if not Editor.State.Party and Map.IsIndoor() and Map.RoomFromPoint(Party.X, Party.Y, Party.Z) <= 0 then
		if Editor.State.Rooms[2] then
			local f = next(Editor.State.Rooms[2].Facets)
			if f then
				local v = Editor.FacetMiddles[f]
				Party.X, Party.Y, Party.Z = v.X + f.nx*50, v.Y + f.ny*50, v.Z + f.nz*50
			end
		end
	end
end

function Commands.Import(name)
	Import(name, false)
end

function Commands.ImportObjects(name)
	Import(name, true)
end

local function DoExport(name, selected)
	name = memstr(name)
	if not Editor.State then
		Editor.ReadMap()
		Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(path.name(name), Map.IsOutdoor() and ".odt" or '.dat')
	end
	if selected then
		local t = {}
		for o in pairs(Editor.SelectedModels) do
			t[o.Name] = o
		end
		Editor.ExportObj(name, t, false)
	else
		Editor.ExportObj(name)
	end
end

function Commands.Export(name)
	DoExport(name)
end

function Commands.ExportSelected(name)
	DoExport(name, true)
end

function Commands.Open(name)
	Editor.ClearSelection()
	name = memstr(name)
	Editor.FileName = name
	Editor.State = unpersist(io.LoadString(name))
	Editor.StateSync = false
	Editor.ClearUndoStack()
	Editor.NeedStateSync()
end

function Commands.Save(name)
	name = memstr(name)
	Editor.FileName = name
	mem.dll.kernel32.CopyFileA(name, path.setext(name, ".bak"), false)
	io.SaveString(name, persist(Editor.State))
end

function Commands.New()
	Editor.FileName, Editor.DefaultFileName = nil, nil
	local sync = Editor.StateSync or not Editor.State
	if Editor.State then
		Editor.SetState(nil)
		Editor.ClearUndoStack()
	end
	if sync and Map.IsOutdoor() then
		Editor.SetState{}
		Editor.UpdateMap()
	end
end

function Commands.Continue()
	Editor.NeedStateSync()
end

function Commands.Compile(name)
	Editor.UpdateMap(memstr(name))
end

local function FindInGamesLod(name)
	return mem.call(mmv(0x44CCA0, 0x461659, 0x45F09B), 1, Game.GamesLod['?ptr'], name) ~= 0
end

local function FindExtInGamesLod(ext)
	for _, a in Game.MapStats do
		local s = a.FileName
		if path.ext(s):lower() == ext and FindInGamesLod(s) then
			return s
		end
	end
end

function Editor.NeedStateSync()
	local s = Editor.State.BaseInternalMap
	if s and s:lower() ~= Map.Name:lower() and FindInGamesLod(s) then
		return Editor.LoadBlv(s, true)
	end
	Editor.UpdateMap()
	if not Editor.StateSync then
		if not Editor.State.Rooms and Map.IsIndoor() then
			Editor.LoadBlv(FindExtInGamesLod(".odm"), true)
		elseif Editor.State.Rooms and not Map.IsIndoor() then
			Editor.LoadBlv(FindExtInGamesLod(".blv"), true)
		else
			Editor.UpdateSelectionState(true)  -- unknown error
		end
	end
end

function Editor.LoadBlv(name, KeepState)
	if not Editor.JustOpenMap then
		Editor.LoadBlvTime = Game.Time
		Editor.LoadBlvKeepState = KeepState
		Game.Time = Game.Time + 0x1000000000
		Editor.ClearUndoStack()
		if mmver == 6 then
			mem.u1[offsets.MapName] = 1  -- avoid triggering losing game
		end
	end
	evt.MoveToMap{Name = name}
end

function Commands.LoadBlv(name)
	Editor.LoadBlv(memstr(name))
end

function Editor.LoadedBlv()
	if Editor.LoadBlvTime then
		Map.LastRefillDay = 0
		if not Editor.LoadBlvKeepState then
			Editor.FileName, Editor.DefaultFileName = nil, nil
			Editor.ReadMap()
		else
			Map.Monsters.Count = 0  -- avoid loading of frames
			Map.Objects.Count = 0
			Map.Sprites.Count = 0
		end
		Game.MapEvtLines.Count = 0
		
		-- Map.OutdoorExtra.Bits = 0
		-- Map.OutdoorExtra.Ceiling = 100
	end
end

function events.LoadMap()
	if Editor.LoadBlvTime then
		Game.Time = Editor.LoadBlvTime
		Editor.LoadBlvTime = nil
		Editor.StateSync = not Editor.LoadBlvKeepState
		Editor()
		Editor.UpdateMap()
		CheckLastError()
	end
end

function Commands.Undo()
	Editor.Undo()
end

function Commands.Redo()
	Editor.Redo()
end

----- Misc

function Commands.EditProps()
	Editor.ExclusiveUndoState()
	Editor.EditProps()
end

function Commands.ShowPortals(param)
	Editor.ShowPortals = param ~= 0
	Editor.UpdateGameBits()
end

function Commands.UpdateBSP()
	Editor.UpdateMap()
end

function Commands.NoDark(param)
	Editor.NoDark = param ~= 0
	Editor.UpdateNoDark()
end

local function SetPartyBuff(BuffId, on, power)
	local t = 0xF0000000*0x100000
	local a = Party.SpellBuffs[BuffId]
	if (a.ExpireTime >= t) ~= on then
		if on then
			a.ExpireTime = a.ExpireTime + t
			a.Power = a.Power + power
		else
			a.ExpireTime = a.ExpireTime - t
			a.Power = a.Power - power
		end
	end
end

function Editor.UpdateNoDark()
	if Map.IsOutdoor() then
		return SetPartyBuff(const.PartyBuff.TorchLight, Editor.WorkMode, Game.IsD3D and 40 or 20)
	elseif not Editor.StateSync then
		return
	end
	local md = Editor.NoDark and Editor.WorkMode and 7 or math.huge
	for i, a in Map.Rooms do
		a.Darkness = math.min(md, Editor.State.Rooms[i + 1].Darkness or Editor.State.DefaultDarkness)
	end
end

function Commands.ShowInvisible(param)
	Editor.ShowInvisible = param ~= 0
	Editor.UpdateShowInvisible()
end

function Editor.UpdateShowInvisible()
	if not Editor.StateSync then
		return
	end
	local allow = not Editor.ShowInvisible or not Editor.VisibleGUI
	local sw = not Game.IsD3D
	for t, i in pairs(Editor.FacetIds) do
		Map.GetFacet(i).Invisible = allow and t.Invisible
		if sw then
			Map.GetFacet(i).IsSky = allow and t.IsSky
		end
	end
	for t, i in pairs(Editor.SpriteIds) do
		Map.Sprites[i].Invisible = allow and t.Invisible
	end
	Editor.UpdateSpriteLights()
end

function Editor.MapUpdated()
	Game.MapEvtLines.Count = 0
	Editor.UpdateShowInvisible()
	Editor.UpdateNoDark()
	if mmver > 6 then
		Party[0].Skills[const.Skills.Perception] = JoinSkill(60, const.GM)
		Party[0].Skills[const.Skills.IdentifyMonster] = JoinSkill(60, const.GM)
	end
	-- once had an AV due to corrupt ObjectByPixel
	if mmver == 6 or Game.RendererD3D == 0 then
		for i, a in Game.ObjectByPixel do
			for i in a do
				a[i].Value = 0
			end
		end
	end
	if Editor.State.Party then
		Editor.CopyPartyPos(Party, Editor.State.Party)
	end
	Party.NeedRender = true
end

local PauseState

function Commands.Pause(on)
	if on ~= 0 then
		NeedFocus = false
		PauseState = PauseGame()
	else
		ResumeGame(PauseState)
	end
end

function Commands.GetLodsList(name)
	NeedFocus = false
	name = memstr(name)
	local list = mem.dll["mm"..mmver.."patch"].GetCustomLodsList
	if not list then
		return  -- patch version below 2.0
	end
	list = list()
	local n = mem.u4[list - 4]
	local t = {"Data\\"..name..".lod"}
	local p = Game[name.."Lod"]["?ptr"]
	for i = 0, n - 1 do
		if mem.u4[list + i*8] == p then
			t[#t + 1] = mem.string(mem.u4[list + i*8 + 4] + 4)
		end
	end
	return table.concat(t, '|')
end

function Commands.GetMapNames()
	NeedFocus = false
	local MonList = {}
	for i, a in Game.MonListBin do
		MonList[a.Name] = Game.SFTBin[Game.SFTBin:FindGroup(a.FramesStand)]
	end

	local t = {}
	for _, a in Game.MapStats do
		local s = a.FileName
		t[#t + 1] = a.FileName
		t[#t + 1] = a.Name
		local a = MonList[a.Monster1Pic..mmv("A", " A", " A")] or {}
		t[#t + 1] = a.SpriteName or ""
		t[#t + 1] = a.PaletteId or -1
	end
	return table.concat(t, '\001')
end

----- Facets

local function SelectByProp(prop)
	local NilOk = {}
	local ok = {}
	for id in pairs(Editor.Selection) do
		local v = Editor.Facets[id + 1][prop]
		if v == nil then
			NilOk = nil
		elseif v == v then  -- NaN safeguard
			ok[v] = true
		end
	end
	if Map.IsIndoor() then
		for f, id in pairs(Editor.FacetIds) do
			if ok[f[prop]] or f[prop] == NilOk then
				Editor.SelectSingleFacet(id)
			else
				Editor.DeselectSingleFacet(id)
			end
		end
	else
		local models = {}
		if Keys.IsPressed(const.Keys.CTRL) then
			for m in pairs(Editor.State.Models) do
				models[m.PartOf] = true
			end
		else
			for id in pairs(Editor.Selection) do
				models[Editor.Models[id:div(64) + 1].PartOf] = true
			end
		end
		for f, id in pairs(Editor.FacetIds) do
			if models[Editor.Models[id:div(64) + 1].PartOf] then
				if ok[f[prop]] or f[prop] == NilOk then
					Editor.SelectSingleFacet(id)
				else
					Editor.DeselectSingleFacet(id)
				end
			end
		end
	end
end

function Commands.SelectDoor()
	SelectByProp("Door")
	-- change button
end

function Commands.SelectSameTexture()
	SelectByProp("Bitmap")
end

function Commands.SelectObject()
	SelectByProp("ObjectName")
end

function Commands.EditRoom()
	Editor.ExclusiveUndoState()
	Editor.EditProps("Room")
end

function Commands.GetTexture()
	NeedFocus = false
	return Editor.Facets[next(Editor.Selection) + 1].Bitmap
end

function Commands.SetTexture(name)
	name = memstr(name)
	for id, props in Editor.ForSelection() do
		props.set(id, "Bitmap", name)
	end
end

----- Doors

function Commands.EditDoor()
	Editor.ExclusiveUndoState()
	Editor.EditProps("Door")
end

local function FreeDoorId()
	local id = 0
	for _, a in Map.Doors do
		id = max(id, a.Id)
	end
	return id + 1
end

function Commands.NewDoor()
	-- find the 'main' facet that would define door direction
	local FoundMoving
	local f = Editor.Facets[next(Editor.Selection) + 1]
	for id in pairs(Editor.Selection) do
		local f1 = Editor.Facets[id + 1]
		if f1.MovedByDoor then
			f = f1
			FoundMoving = true
			break
		end
	end
	-- create door
	local door = {
		DirectionX = -f.nx, DirectionY = -f.ny, DirectionZ = -f.nz,
		MoveLength = 128, Speed1 = 50, Speed2 = 50,
		VertexFilter = not FoundMoving and "Free" or nil,
		Id = FreeDoorId(),
	}
	for id, props in Editor.ForSelection() do
		props.set(id, "Door", door)
	end
end

local function FindDoor()
	for id in pairs(Editor.Selection) do
		local door = Editor.Facets[id + 1].Door
		if door then
			local i = Editor.DoorIds[door]
			return Map.Doors[i], door, i
		end
	end
end
Editor.FindSelectedDoor = FindDoor

function Commands.DeleteDoor()
	local props = Editor.GetProps()
	while true do
		local a, door, i = FindDoor()
		if not a then
			break
		end
		for f, id in pairs(Editor.FacetIds) do
			if f.Door == door then
				props.set(id, "Door", nil)
			end
		end
	end
	props.done()
end

function Commands.ChangeDoorShape()
	local a, door, i = FindDoor()
	local props = Editor.GetProps()
	for f, id in pairs(Editor.FacetIds) do
		local InSel = not not Editor.Selection[id]
		if InSel ~= (f.Door == door) then
			props.set(id, "Door", InSel and door or nil)
		end
	end
	props.done()
end

function Commands.DoorState(switch)
	local a = FindDoor()
	local state = a.State
	if switch == 1 and state ~= 2 and state ~= 0 then
		return
	end
	a.State = (state == 0 or state == 3) and 1 or 3
	if state == 2 or state == 0 then
		a.TimeStep = 0
	else
		local spd1, spd2 = a.Speed1, a.Speed2
		if state == 3 then
			spd1, spd2 = spd2, spd1
		end
		a.TimeStep = max(0, ((a.MoveLength*128 - spd1*a.TimeStep)/spd2):round())
	end
end

function Commands.MobilizeDoor()
	local a = FindDoor()
	if a.State == 0 or a.State == 2 then
		Commands.DoorState()
	end
end

function Commands.DoorStateDbl()
	local a = FindDoor()
	a.TimeStep = 15360
	Editor.NeedDoorsUpdate = true
end

function Commands.ResetDoors()
	for _, t in Map.Doors do
		if t.State ~= 0 then
			t.State = 3
			t.TimeStep = 15360
			Editor.NeedDoorsUpdate = true
		end
	end
end

----- Models

function Commands.ModelMode(on)
	Editor.ModelMode = (on ~= 0)
	Editor.SelectionChanged = true
end

function Commands.GetSaveModelName()
	NeedFocus = false
	local name
	local n = 0
	for o, id in pairs(Editor.EnumSelection()) do
		local s = o.Name2 or o.Name
		if not name or s < name then
			name = s
		end
		n = n + 1
	end
	if n > 1 then
		name = name.."_x"..n
	end
	return name
end

function Commands.SaveModel(name)
	name = memstr(name)
	local pos, sel = Editor.GetAverageSelectionPos()
	
	if path.ext(name):lower() == ".obj" then
		-- pick ObjName as the name if it's unique, otherwise pick Name
		local ByName = {}
		local ObjNamesTaken = {}
		for o in pairs(sel) do
			ByName[o.Name] = o
			if o.ObjName then
				ObjNamesTaken[o.ObjName] = (ObjNamesTaken[o.ObjName] or 0) + 1
			end
		end
		for o in pairs(Editor.EnumSelection()) do
			if ObjNamesTaken[o.ObjName] == 1 and not ByName[o.ObjName] then
				ByName[o.ObjName] = o
				ByName[o.Name] = nil
			end
		end
		for X in XYZ do
			pos[X] = round(pos[X])
		end
		return Editor.ExportModelTemplate(name, ByName, pos)
	end
	
	local props = Editor.GetProps()
	local all = {}
	for o, id in pairs(sel) do
		local t = {Name = o.ObjName or o.Name, BaseFacets = o.BaseFacets}
		for X in XYZ do
			local x = props.get(id, X)
			t["Lazy"..X] = t["Lazy"..X] or x
			t[X] = x - pos[X]
		end
		all[t] = true
	end
	io.SaveString(name, persist(all))
end

function Commands.LoadModel(name)
	name = memstr(name)
	if path.ext(name):lower() == ".obj" then
		Editor.ModelTemplate = Editor.ImportModelTemplate(name)
		return Editor.ModelTemplate and 1
	end
	local t, err = unpersist(io.LoadString(name))
	if err then
		Editor.LastError = "Invalid model file.\n"..err
		Editor.LastErrorFacets = {}
		return
	end
	-- if not t or next(t) or not next(t).BaseFacets then
		-- Editor.LastError = "Invalid model file"
		-- Editor.LastErrorFacets = {}
		-- return
	-- end
	Editor.ModelTemplate = Editor.PrepareModelTemplate(t, path.setext(path.name(name), ''))
	return Editor.ModelTemplate and 1
end

----- Objects

function Editor.EnumSelection()
	local all = {}
	for id, props in Editor.ForSelection() do
		all[props.get(id, "OBJ")] = id
	end
	return all
end

function Editor.GetAverageSelectionPos()
	local props = Editor.GetProps()
	local sel = Editor.EnumSelection()
	local pos = {}
	local pos2 = {}
	for X in XYZ do
		pos[X] = 1/0
		pos2[X] = -1/0
		for o, id in pairs(sel) do
			local x = props.get(id, X)
			if x < pos[X] then
				pos[X] = x
			end
			if x > pos2[X] then
				pos2[X] = x
			end
		end
		if X ~= "Z" then
			pos[X] = (pos[X] + pos2[X])/2
			if pos2[X] % 1 == 0 then
				pos[X] = pos[X] - pos[X] % 2
			end
		end
	end
	return pos, sel
end

function Commands.Deselect()
	Editor.ClearSelection()
end

local function CreatePos()
	local dx, dy, dz = Editor.GetMouseDirection()--Editor.GetPartyDirection()
	local d = 250
	return {X = Party.X + d*dx, Y = Party.Y + d*dy, Z = Party.Z + 120 + d*dz}
end

function Commands.Clone()
	Editor.ExclusiveUndoState()
	local props = Editor.GetProps()
	
	local pos, all = Editor.GetAverageSelectionPos()
	local t = CreatePos()
	local x = t.X - pos.X
	local y = t.Y - pos.Y
	local z = t.Z - pos.Z
	
	Editor.ClearSelection()
	for o, id in pairs(all) do
		t = {
			X = x + props.get(id, "X"),
			Y = y + props.get(id, "Y"),
			Z = z + props.get(id, "Z"),
		}
		t = (props.duplicate or Editor.DeepCopy)(o, t)
		Editor.Selection[props.create(t)] = true
	end
	if Editor.AutoLand then
		Commands.Land()
	else
		props.done()
	end
end

function Commands.SetAutoLand(on)
	NeedFocus = false
	Editor.AutoLand = on
end

local function DoNew(t, kind)
	Editor.ExclusiveUndoState()
	Editor.ClearSelection()
	Editor.SelectionKind = kind
	local props = Editor.GetNewProps()
	Editor.ClearSelection()
	Editor.Selection = {[props.create(t)] = true}
	if Editor.AutoLand then
		Commands.Land()
	else
		props.done()
	end
end

function Commands.NewSprite(name)
	local t = CreatePos()
	t.DecName = memstr(name)
	DoNew(t, skSprite)
end

function Commands.NewLight()
	local t = CreatePos()
	t.Radius = 512
	if mmver > 6 then
		t.R = 255
		t.G = 255
		t.B = 255
	end
	DoNew(t, skLight)
end

function Commands.NewSpawn(kind)
	local t = CreatePos()
	t.Radius = 32
	t.Kind = (kind <= 12 and skMonster or skObject)
	t.Index = (kind - 1) % 12 + 1
	DoNew(t, skSpawn)
end

function Commands.NewItem(num)
	local t = CreatePos()
	t.Item = {Number = num}
	DoNew(t, skObject)
end

function Commands.NewMonster(num)
	local t = CreatePos()
	t.Id = num
	t.Direction = 0
	DoNew(t, skMonster)
end

function Commands.NewModel()
	Editor.ExclusiveUndoState()
	Editor.ClearSelection()
	Editor.SelectionKind = skFacet
	Editor.ModelMode = true
	local props = Editor.GetNewProps()
	local all = Editor.DeepCopy(Editor.ModelTemplate)
	local pos = CreatePos()
	for models in pairs(all) do
		local t0 = next(models).PartOf
		for X in XYZ do
			t0[X] = (t0[X] or 0) + pos[X]
		end
		Editor.ProcessLazyModel(t0)
		Editor.Selection[props.create(models)] = true
	end
	if Editor.AutoLand then
		Commands.Land()
	else
		props.done()
	end
end

function Commands.Delete()
	for id, props in Editor.ForSelection() do
		props.delete(id)
	end
	Editor.ClearSelection()
end

function Commands.MoveToParty()
	local pos, all = Editor.GetAverageSelectionPos()
	local props = Editor.GetProps()
	for o, id in pairs(all) do
		for X in XYZ do
			props.set(id, X, props.get(id, X) - pos[X] + Party[X])
		end
		if props.HasDirection then
			props.set(id, "Direction", Party.Direction)
		end
	end
	props.done()
end

function Commands.Land()  -- called from DoNew as well. Must call props.done()
	local props = Editor.GetProps()
	local sel = Editor.EnumSelection()
	-- must temporary delete models so that they don't lend on themselves
	local Deleted = {}
	if Editor.SelectionKind == skFacet then
		for id in pairs(Editor.Selection) do
			id = id:div(64)
			if not Deleted[id] then
				local m = Map.Models[id]
				Deleted[id] = m.Facets.Count
				m.Facets.Count = 0
			end
		end
	end
	-- land
	for o, id in pairs(sel) do
		local x = props.get(id, "X")
		local y = props.get(id, "Y")
		local z = props.get(id, "Z")
		z = Map.GetFloorLevel(x, y, z)
		if z > -30000 then
			if Editor.SelectionKind == skLight then
				z = z + 1
			elseif Editor.SelectionKind == skSpawn and Map.IsOutdoor() and z == Map.GetGroundLevel(x, y) then
				z = 0
			end
			props.set(id, "Z", z)
		end
	end
	-- restore
	for id, n in pairs(Deleted) do
		Map.Models[id].Facets.Count = n
	end
	props.done()  -- must be called no matter what
end

local function SelectObjByProp(ids, prop)
	if Editor.SelectFacetBitmapMode and Editor.SelectionKind == skFacet then
		return
	end
	local props = Editor.GetProps()
	local need = {}
	for o, id in pairs(Editor.EnumSelection()) do
		need[props.get(id, prop) or false] = true
	end
	for f, id in pairs(Editor[ids]) do
		if need[props.get(id, prop)] then
			Editor.Selection[id] = true
		end
	end
	Editor.SelectionChanged = true
end

local ListMainPropByObjKind = {
	[skFacet] = {"FacetIds", "ObjName"},
	[skSprite] = {"SpriteIds", "DecName"},
	[skSpawn] = {"SpawnIds", "Kind"},
	[skObject] = {"ObjectIds", "Number"},
	[skMonster] = {"MonsterIds", "Id"},
	[skLight] = {"LightIds"},
}

function Commands.SelectSameSprite()
	SelectObjByProp(unpack(ListMainPropByObjKind[Editor.SelectionKind]))
end

function Commands.SelectAll()
	SelectObjByProp(ListMainPropByObjKind[Editor.SelectionKind][1])
end

for X in XYZ do
	Commands["Align"..X] = function()
		local props = Editor.GetProps()
		local avg, n = 0, 0
		local all = Editor.EnumSelection()
		for o, id in pairs(all) do
			avg = avg + props.get(id, X)
			n = n + 1
		end
		avg = avg/n
		for o, id in pairs(all) do
			props.set(id, X, avg)
		end
		props.done()
	end
end

----- Move with arrows

-- experimental
local function MoveFacetSelection(f, dx, dy, dz, shift, sel)
	local vecs = table.invert(f.Vertexes)
	local facs = {}
	local m = Editor.FacetMiddles[f]
	local x, y, z = XYZ(m)
	local md = x*dx + y*dy + z*dz
	local dbest, best = md, nil
	for f in pairs(Editor.FacetIds) do
		local m = Editor.FacetMiddles[f]
		local x, y, z = m.X - x, m.Y - y, m.Z - z
		local md = m.X*dx + m.Y*dy + m.Z*dz - (x*x + y*y + z*z)^(0.5)/10
		if md > dbest then
			local n = 0
			for _, v in ipairs(f.Vertexes) do
				if vecs[v] then
					n = n + 1
					if n == 2 then
						dbest = md
						best = f.PartOf
						break
					end
				end
			end
		end
	end
	if best then
		if not shift and not sel[f] then
			Editor.DeselectFacet(f)
		end
		sel[best] = true
		Editor.SelectFacet(best)
	else
		sel[f] = true
	end
end

-- when direction is close to X or Y, snap to it
local AlignDelta = 32
local function GetAlignedPartyDirection()
	local a = Party.Direction
	local b = (a + AlignDelta) % 512 - AlignDelta
	if math.abs(b) <= AlignDelta then
		a = a - b
	end
	return a
end

function Editor.MoveKeyPressed(mx, my, mz, shift)
	if not next(Editor.Selection) then
		return
	end
	local d = Keys.IsPressed(const.Keys.CTRL) and 100 or Keys.IsPressed(const.Keys.ALT) and 1 or 10
	local x, y, z = 0, 0, mz*d
	local dir = GetAlignedPartyDirection()
	local a = (dir - 512)*math.pi/1024
	x, y = x + mx*d*math.cos(a), y + mx*d*math.sin(a)
	local a = dir*math.pi/1024
	x, y = x + my*d*math.cos(a), y + my*d*math.sin(a)
	if Editor.SelectionKind ~= skFacet or Editor.ModelMode then
		Editor.BeginUndoState()
		local have = {}
		for id, props in Editor.ForSelection() do
			local o = props.get(id, "OBJ")
			if not have[o] then
				have[o] = true
				if x ~= 0 then
					props.set(id, "X", props.get(id, "X") + x)
				end
				if y ~= 0 then
					props.set(id, "Y", props.get(id, "Y") + y)
				end
				if z ~= 0 then
					props.set(id, "Z", props.get(id, "Z", true) + z)
				end
			end
		end
		Editor.EndUndoState()
	elseif mz == 0 then
		d = (d == 100 and 64 or d == 10 and 8 or 1)
		local dir = math.round(Party.Direction/512) % 4
		Editor.BeginUndoState()
		for id, props in Editor.ForSelection() do
			local a = Map.GetFacet(id)
			local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
			local u, v = -mx, my
			if vz == 0 then
				local my = (a.NormalZ < 0 and -my or my)
				if dir % 2 == 0 then
					u, v = -my, -mx
				else
					u, v = -mx, my
				end
				if dir >= 2 then
					u, v = -u, -v
				end
			end
			if u ~= 0 then
				props.set(id, "BitmapU", props.get(id, "BitmapU") + u*d)
			end
			if v ~= 0 then
				props.set(id, "BitmapV", props.get(id, "BitmapV") + v*d)
			end
			if Editor.SelectFacetBitmapMode then
				local bmp = Editor.Selection[id]
				if bmp == true then
					Editor.LoadFacetBitmap(a, Editor.Facets[id + 1])
				else
					a.BitmapId = bmp  -- show actual texture
				end
			end
		end
		Editor.EndUndoState()
		
		-- if x == 0 and y == 0 then
			-- local a = Party.Direction*math.pi/1024
			-- x, y = d*math.cos(a)/10, d*math.sin(a)/10
		-- end
		-- local facs = {}
		-- local sel = {}
		-- for id in pairs(Editor.Selection) do
			-- facs[Editor.Facets[id + 1].PartOf] = true
		-- end
		-- for f in pairs(facs) do
			-- MoveFacetSelection(f, x, y, z, shift, sel)
		-- end
	end
end

----- Kind lists

local SpriteKindList
local SpriteKindIndexes = {}

local function GetSpriteKindList()
	if SpriteKindList then
		return SpriteKindList
	end
	local t = {}
	for i, a in Game.DecListBin do
		local name = a.Name
		if name ~= "" and not SpriteKindIndexes[name] then
			SpriteKindIndexes[name] = #t/4
			SpriteKindIndexes[#t/4] = name
			t[#t + 1] = name
			t[#t + 1] = "\r\n'"..a.GameName.."'"
			t[#t + 1] = Game.SFTBin[a.SFTIndex].SpriteName
			t[#t + 1] = Game.SFTBin[a.SFTIndex].PaletteId
		end
	end
	SpriteKindList = t
	return t
end

local SpawnProps = {
	"m1", "m2", "m3", "m1a", "m2a", "m3a", "m1b", "m2b", "m3b", "m1c", "m2c", "m3c",
	"i1", "i2", "i3", "i4", "i5", "i6", "i7"
}
local SpawnPropName = {
	"Monster 1",
	"Monster 2",
	"Monster 3",
	"Monster 1 Weak",
	"Monster 2 Weak",
	"Monster 3 Weak",
	"Monster 1 Average",
	"Monster 2 Average",
	"Monster 3 Average",
	"Monster 1 Strong",
	"Monster 2 Strong",
	"Monster 3 Strong",
	"Item Level 1",
	"Item Level 2",
	"Item Level 3",
	"Item Level 4",
	"Item Level 5",
	"Item Level 6",
	"Artifact Item",
}

local function GetSpawnKindList()
	local t = {}
	for i, name in ipairs(SpawnPropName) do
		t[#t + 1] = name
		t[#t + 1] = ""
		t[#t + 1] = "Editor "..SpawnProps[i]
		t[#t + 1] = Editor.PaletteNumber
	end
	return t
end


local ObjectKindList

local function GetObjectKindList()
	if ObjectKindList then
		return ObjectKindList
	end
	local t = {}
	for i, a in Game.ItemsTxt do
		if i ~= 0 then
			t[#t + 1] = a.Name
			t[#t + 1] = "\r\n("..i..")"
			t[#t + 1] = a.Picture
			t[#t + 1] = 0
		end
	end
	ObjectKindList = t
	return t
end


local MonsterKindList

local function GetMonsterKindList()
	if MonsterKindList then
		return MonsterKindList
	end
	local t = {}
	local fix
	for i, a in Game.MonListBin do
		fix = fix or i == 0  -- account for incorrect MonListBin definition in old MMExt
		if fix then
			i = i + 1
		end
		if i <= Game.MonstersTxt.high then
			t[#t + 1] = Game.MonstersTxt[i].Name
			t[#t + 1] = "\r\n("..i..")"
			local a = Game.SFTBin[Game.SFTBin:FindGroup(a.FramesStand)]
			t[#t + 1] = a.SpriteName
			t[#t + 1] = a.PaletteId
		end
	end
	MonsterKindList = t
	return t
end

local KindsLists = {
	[skSprite] = GetSpriteKindList,
	[skObject] = GetObjectKindList,
	[skMonster] = GetMonsterKindList,
	[skSpawn] = GetSpawnKindList,
}

function Commands.GetKindList(n)
	NeedFocus = false
	if n == 0 then
		n = Editor.SelectionKind
	end
	local f = KindsLists[n]
	return f and table.concat(f(), "\001")
end

----- Kind

function Commands.GetKind()
	NeedFocus = false
	local sel = Editor.SelectionKind
	if sel == skSprite then
		GetSpriteKindList()
		local name = Editor.Sprites[next(Editor.Selection) + 1].DecName
		return SpriteKindIndexes[name]
	elseif sel == skSpawn then
		local a = Editor.Spawns[next(Editor.Selection) + 1]
		return a.Index + (a.Kind ~= skMonster and 12 or 0) - 1
	elseif sel == skObject then
		return (Editor.Objects[next(Editor.Selection) + 1].Item.Number or 0) - 1
	elseif sel == skMonster then
		return Editor.Monsters[next(Editor.Selection) + 1].Id - 1
	end
end

function Commands.SetKind(n)
	local sel = Editor.SelectionKind
	for id, props in Editor.ForSelection() do
		if sel == skSprite then
			GetSpriteKindList()
			props.set(id, "DecName", SpriteKindIndexes[n])
		elseif sel == skSpawn then
			props.set(id, "Kind", SpawnProps[n + 1])
		elseif sel == skObject then
			props.set(id, "Number", n + 1)
		elseif sel == skMonster then
			props.set(id, "Id", n + 1)
		end
	end
end

function Commands.GetMonItem()
	NeedFocus = false
	return Editor.Monsters[next(Editor.Selection) + 1].Item or 0
end

function Commands.SetMonItem(n)
	for id, props in Editor.ForSelection() do
		props.set(id, "Item", n)
	end
end

----- Chests

function Commands.GetChestsList()
	NeedFocus = false
	local all = {}
	for i = 1, math.min(20, table.maxn(Editor.State.Chests) + 1) do
		local a = Editor.State.Chests[i]
		if a then
			local count = {0, 0, 0, 0, 0, 0; 0, 0}
			for i, it in pairs(a.Items or {}) do
				it = type(it) == "number" and it or tonumber(it.Number) or 0
				if it < 0 and it >= -7 then
					count[-it] = count[-it] + 1
				else
					count[8] = count[8] + 1
				end
			end
			all[#all + 1] = ("%s:\t%s/%s/%s/%s/%s/%s A%s C%s"):format(i - 1, unpack(count))
		else
			all[#all + 1] = ("%s:\tNew Chest"):format(i - 1)
		end
	end
	return table.concat(all, "\r\n")
end

function Commands.DeleteChest(n)
	NeedFocus = false
	Editor.ExclusiveUndoState()
	local props = Editor.GetProps("Chest", n)
	props.delete(n)
	props.done()
end

function Commands.EditChest(n)
	NeedFocus = false
	Editor.ExclusiveUndoState()
	Editor.EditProps("Chest", n)
end

function Commands.TestChest(n)
	if Game.CurrentScreen == 0 and Editor.State.Chests[n + 1] then
		Map.Chests.Count = 1
		Editor.WriteChest(Map.Chests[0], Editor.State.Chests[n + 1])
		Map.Chests[0].Trapped = false
		mem.call(mmv(0x456300, 0x450244, 0x44D96C), 0)
		evt.OpenChest{Id = 0}
	end
end

----- Tiles

Editor.TileBrushSize = Editor.TileBrushSize or 0
Editor.CurrentTileset = Editor.CurrentTileset or 0
--Editor.TileBrushGrid = false
Editor.TileGridMode = Editor.TileGridMode or 0
Editor.TileBrushSpeed = Editor.TileBrushSpeed or 1

function Commands.SetTileBrushSize(n)
	NeedFocus = false
	Editor.ClearSelection()
	Editor.CompleteUndoState()
	if n == 1 and Editor.TileBrushGrid then
		n = 2
	end
	Editor.TileBrushSize = n
	Editor.GridX = 10000
	Editor.UpdateTileSelectState()
	Editor.UpdateVisibility()
end

function Commands.SetCurrentTileset(n)
	Editor.CurrentTileset = n
	Editor.CompleteUndoState()
end

function Commands.SetTileBrushGrid(n)
	Editor.TileBrushGrid = (n ~= 0)
	Editor.CompleteUndoState()
end

function Commands.SetGridMode(n)
	Editor.TileGridMode = n
	Editor.CompleteUndoState()
end

function Commands.SetTileBrushSpeed(n)
	NeedFocus = false
	Editor.TileBrushSpeed = n
end

function Commands.GetHeightMap()
	return Editor.State.HeightMap
end

function Commands.SetHeightMap(hm)
	hm = mem.string(hm, 128*128, true)
	Editor.ExclusiveUndoState()
	Editor.SetHeightMap(hm)
end

----- GetTilesetsList

local TileKindNames = {[0] = " - Grass", [1] = " - Snow", [2] = " - Desert", [3] = " - Cooled Lava",
  [5] = " - Water", [6] = " - Badlands", [7] = " - Swamp"}

local LastTilesetsList
	
function Commands.GetTilesetsList()
	NeedFocus = false
	local t = {}
	-- for i = 0, 233 do
		-- local s = i
		-- if i >= 90 then
			-- i = i - 90
			-- local j = i:div(36)
			-- i = i % 36
			-- s = ("%s: %s"):format(j, i)
			-- i = Map.Tilesets[j].Id + i
		-- end
		-- local b = (Game.CurrentTileBin or Game.TileBin)[i].Name
		-- if true then --b ~= "pending" then
			-- t[#t + 1] = b
			-- t[#t + 1] = "\r\n("..s..")"
			-- t[#t + 1] = (b:lower() == "pending" and "" or b)
			-- t[#t + 1] = "0"
		-- end
	-- end
	
	local done = {}
	local sel = Map.Tilesets[min(3, Editor.CurrentTileset - 1)].Group
	local index = 0
	for i, a in Game.CurrentTileBin do
		local k = a.TileSet
		if not done[k] and a.Section == 0 then
			if k == sel then
				index = #t / 4
			end
			done[k] = true
			t[#t + 1] = k
			t[#t + 1] = (TileKindNames[k] or "").."\r\n'"..a.Name.."'"
			t[#t + 1] = a.Name
			t[#t + 1] = "0"
		end
	end
	t[#t + 1] = index
	
	LastTilesetsList = table.concat(t, "\01")
	return LastTilesetsList
end

----- Tilesets Misc

local LastTilesetBitmap

function Commands.GetTilesetBitmap(n)
	NeedFocus = false
	local i = 1
	if n == 5 then
		i = Map.Tilesets[3].Offset + 21
	elseif n == 4 then
		i = Map.Tilesets[3].Offset + 1
	elseif n > 0 then
		i = Map.Tilesets[n - 1].Offset
	end
	return Game.CurrentTileBin[i].Name
end

function Commands.GetTilesetsFile()
	NeedFocus = false
	return Map.TilesetsFile
end

function Commands.SetTilesetsFile(n)
	Editor.ExclusiveUndoState()
	local props = Editor.GetProps("Header")
	props.set(nil, 'TilesetsFile', n)
	props.done()
end

function Commands.SetTileset(n)
	Editor.ExclusiveUndoState()
	local props = Editor.GetProps("Header")
	props.set('Tilesets', min(3, Editor.CurrentTileset - 1), n)
	props.done()
end

function Editor.TilesetsChanged()
	DLL.TilesetsChanged()
end

function Editor.ExtractTexture(name, path, extra)
	return DLL.ExtractTexture(name, path, extra or 0) ~= 0
end

----- Sky Texture

-- function Commands.GetSkyTexture()
	-- NeedFocus = false
	-- return Editor.State.Header.SkyBitmap
-- end

-- function Commands.SetSkyTexture(name)
	-- NeedFocus = false
	-- Editor.ExclusiveUndoState()
	-- local props = Editor.GetProps("Header")
	-- props.set(nil, 'SkyBitmap', memstr(name))
	-- props.done()
-- end


function Commands.EditMapProps()
	Editor.ExclusiveUndoState()
	Editor.EditProps("Header")
end
