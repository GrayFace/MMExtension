Editor = Editor or {}
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min

local skSpawn = 1
local skObject = 2
local skMonster = 3
local skSprite = 5
local skFacet = 6
local skLight = 7
local skModel = 8

local mmver = offsets.MMVersion
local function mmv(...)
	return (select(mmver - 5, ...))
end

-----------------------------------------------------
-- Functions for use from debug console
-----------------------------------------------------

function MoveToSelection(t)
	Editor.Selection = t or Editor.Selection
	local id = next(Editor.Selection)
	if id and Editor.SelectionKind == skFacet then
		v = Editor.Facets[id + 1].Vertexes[1]
		Party.X, Party.Y, Party.Z = v.X, v.Y, v.Z
	end
	Editor.SelectionChanged = true
	Editor.UpdateSelectionState()
end

function SelectFacetWith(k, v, MoveTo)
	local n = 0
	Editor.ClearSelection()
	Editor.SelectionKind = skFacet
	for f, id in pairs(Editor.FacetIds) do
		if f[k] == v then
			n = n + 1
			Editor.SelectSingleFacet(id)
			if MoveTo then
				XYZ(Party, XYZ(f.Vertexes[1]))
			end
		end
	end
	Editor.SelectionChanged = true
	Editor.UpdateSelectionState()
	return n
end

function SelectSpriteWith(k, v, MoveTo)
	local n = 0
	Editor.ClearSelection()
	Editor.SelectionKind = skSprite
	for a, id in pairs(Editor.SpriteIds) do
		if a[k] == v then
			n = n + 1
			Editor.Selection[id] = true
			if MoveTo then
				XYZ(Party, XYZ(a))
			end
		end
	end
	Editor.SelectionChanged = true
	Editor.UpdateSelectionState()
	return n
end

function FindEvent(v)
	local n = SelectFacetWith("Event", v, true)
	if n == 0 then
		n = SelectSpriteWith("Event", v, true)
	end
	return n
end

function FindNoTexture()
	local n, pen = 0, Game.BitmapsLod:LoadBitmap("pending")
	Editor.ClearSelection()
	Editor.SelectionKind = skFacet
	for f, id in pairs(Editor.FacetIds) do
		if not f.IsPortal and not f.Invisible and Map.GetFacet(id).BitmapId == pen then
			n = n + 1
			Editor.SelectSingleFacet(id)
			XYZ(Party, XYZ(f.Vertexes[1]))
		end
	end
	Editor.SelectionChanged = true
	Editor.UpdateSelectionState()
	return n
end

-----------------------------------------------------
-- Batch Save/Load
-----------------------------------------------------

local function AutoResume()
	local state = PauseGame()
	ResumeGame(state)
	local mlook = Game.PatchOptions.MouseLook
	Game.PatchOptions.MouseLook = false
	local function OnWndMsg(t)
		ResumeGame(state)
	end
	events.WindowMessage = OnWndMsg
	return function()
		events.WindowMessage.remove(OnWndMsg)
		Game.PatchOptions.MouseLook = mlook
	end
end

local function PostActivateMessage()
	mem.dll.user32.PostMessageA(Game.WindowHandle, 0x1C, 1, 0)  -- WM_ACTIVATEAPP
	mem.dll.user32.PostMessageA(Game.WindowHandle, 0, 0, 0)  -- WM_NULL
end

function DoBatchSave(dir, includeBlv, export)
	if not Editor.BatchNoSleep then
		Sleep(1)
	end
	local co = coroutine.running()
	local done = AutoResume()
	for _, a in Game.MapStats do
		local s = a.FileName
		if s ~= "" and (includeBlv or path.ext(s):lower() ~= '.blv') then
			print('loading', s)
			function events.LoadMap()
				events.remove('LoadMap', 1)
				if export then
					Editor.ExportObj(dir..s..".obj")
				else
					io.SaveString(dir..s..".dat", internal.persist(Editor.State))
				end
				Editor.Close()
				PostActivateMessage()
				function events.Tick()
					events.remove('Tick', 1)
					print('resuming after', s)
					coroutine.resume(co)
				end
			end
			Editor.LoadBlv(s)
			PostActivateMessage()
			coroutine.yield()
		end
	end
	done()
end
-- Editor.UpdateMap(dir..s)

function BatchSave(dir, includeBlv)
	dir = path.addslash(dir or AppPath.."Batch")
	os.mkdir(dir)
	cocall2(DoBatchSave, dir, includeBlv)
end

function BatchExport(dir, includeBlv)
	dir = path.addslash(dir or AppPath.."BatchExport")
	os.mkdir(dir)
	cocall2(DoBatchSave, dir, includeBlv, true)
end

function DoBatchLoad(mask, odir, preproc, postproc)
	local oldmap = Map.Name
	local co = coroutine.running()
	local done = AutoResume()
	-- for s in path.find(mask) do
	-- 	print(s)
	-- end
	for s in path.find(mask) do
		print('loading', s)
		Editor.ClearSelection()
		Editor.FileName = s
		Editor.State = internal.unpersist(io.load(s))
		if preproc then
			preproc(Editor.State, s)
		end
		Editor.StateSync = false
		Editor.ClearUndoStack()
		Editor.State.BaseInternalMap = nil
		Editor.NeedStateSync()		
		if not Editor.StateSync then
			print('indoor/outdoor switch')
			-- local oldUpd = Editor.UpdateMap
			-- function Editor.UpdateMap()
			-- end
			function events.LoadMap()
				events.remove('LoadMap', 1)
				Editor.Close()
				PostActivateMessage()
				-- Editor.UpdateMap = oldUpd
				function events.Tick()
					events.remove('Tick', 1)
					print('resuming', s)
					coroutine.resume2(co)
				end
			end
			PostActivateMessage()
			coroutine.yield()
		end
		print('compiling', s)
		
		-- prevent bitmaps overflow
		local inout = Map.IndoorOrOutdoor
		Map.IndoorOrOutdoor = 0
		mem.call(mmv(0x454930, 0x4644B6, 0x4627B6), 0)
		Map.IndoorOrOutdoor = inout
		
		Editor.UpdateMap(odir..path.setext(path.name(s), ''))
		print('ok', s)
	end
	done()
	if postproc then
		postproc()
	end
	Editor.LoadBlv(oldmap)  -- prevent crash from lack of sky texture
end

function DoBatchLoadAll(dir, odir, ...)
	dir = path.addslash(dir or AppPath.."Batch")
	odir = path.addslash(odir or AppPath.."BatchCompiled")
	if not Editor.BatchNoSleep then
		Sleep(1)
	end
	DoBatchLoad(dir.."*.dat", odir, ...)
	-- DoBatchLoad(dir.."*.blv.dat", odir, preproc)
	-- DoBatchLoad(dir.."*.odm.dat", odir, preproc)
end

function BatchLoad(...)
	cocall2(DoBatchLoadAll, ...)
end

-----------------------------------------------------
-- Unrelated to editor itself
-----------------------------------------------------

function blv(name)
	evt.MoveToMap{Name=name..".blv"}
end

function odm(name)
	evt.MoveToMap{Name=name..".odm"}
end
