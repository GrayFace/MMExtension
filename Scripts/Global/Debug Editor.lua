Editor = Editor or {}
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
Editor.ImportIndex = ImportIndex or {}

local skSpawn = 1
local skObject = 2
local skMonster = 3
local skSprite = 5
local skFacet = 6
local skLight = 7
local skModel = 8

-----------------------------------------------------
-- BSP
-----------------------------------------------------

function BSP(rebuild)
	if rebuild then
		for _, r in ipairs(Editor.State.Rooms) do
			r.BSP = nil
		end
	end
	Editor.BuildBSP(true)
	Editor.UpdateMap()
end

-- local LastSel

-- local function DoFindInBSP(inode, facets, sel)
-- 	if inode >= 0 then
-- 		local node = Map.BSPNodes[inode]
-- 		local front, back = node.FrontNode, node.BackNode
-- 		if sel[facets[node.CoplanarOffset]] then
-- 			return node
-- 		end
-- 		DoFindInBSP(front, facets, portals)
-- 		DoFindInBSP(back, facets, portals)
-- 	end
-- end

-- local function SelectTree(inode, facets, sel)
-- 	if inode >= 0 then
-- 		local node = Map.BSPNodes[inode]
-- 		local front, back = node.FrontNode, node.BackNode

-- 		sel[facets[node.CoplanarOffset]] = true
-- 		DoFindInBSP(front, facets, portals)
-- 		DoFindInBSP(back, facets, portals)
-- 	end
-- end

-- local function FindInBSP(sel)
-- 	local r = Map.RoomFromPoint(Party)
-- 	local node = DoFindInBSP(r.FirstBSPNode, r.DrawFacets, sel)
	
-- end

-- function I()

-- end

-- function A()

-- end

local function AlignPortalNodes(inode, facets, portals)
	if inode >= 0 then
		local node = Map.BSPNodes[inode]
		local front, back = node.FrontNode, node.BackNode
		if Map.Facets[facets[node.CoplanarOffset]].IsPortal then
			node.FrontNode, node.BackNode = back, front
		end
		AlignPortalNodes(front, facets, portals)
		AlignPortalNodes(back, facets, portals)
	end
end

function InvertPortalsBSP()
	for _, r in Map.Rooms do
		if r.Bits:And(0x10) ~= 0 then
			AlignPortalNodes(r.FirstBSPNode, r.DrawFacets, t)
		end
	end
end



local function AlignPortalNodes(inode, facets, indent)
	if inode >= 0 then
		local node = Map.BSPNodes[inode]
		local front, back = node.FrontNode, node.BackNode
		local t = {}
		for i = node.CoplanarOffset, node.CoplanarOffset + node.CoplanarSize - 1 do
			t[#t + 1] = facets[i]
		end
		print(indent..table.concat(t, ", "))
		indent = indent.."  "
		AlignPortalNodes(front, facets, indent)
		AlignPortalNodes(back, facets, indent)
	else
		print(indent.."-")
	end
end

function PrintBSP(r)
	print("Room "..r..":")
	r = Map.Rooms[r]
	print("(%s non-BSP)", r.NonBSPDrawFacetsCount)
	if r.Bits:And(0x10) ~= 0 then
		AlignPortalNodes(r.FirstBSPNode, r.DrawFacets, "")
	end
end

-- function PrintBSP()
-- 	for _, r in Map.Rooms do
-- 		if r.Bits:And(0x10) ~= 0 then
-- 			AlignPortalNodes(r.FirstBSPNode, r.DrawFacets, "")
-- 		end
-- 	end
-- end

-----------------------------------------------------
-- Export
-----------------------------------------------------

function E()
	Editor.ReadMap()
	Editor.ExportObj(AppPath.."MapObj/"..path.setext(Map.Name, ".obj"))
end

function E1()
	E()
	L(path.setext(Map.Name, ".obj"))
end

function EM()
	local name = AppPath.."MapObj/"..path.setext(Map.Name, ".obj")
	if not Editor.State then
		Editor.ReadMap()
		Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(path.name(name), Map.IsOutdoor() and ".odt" or '.dat')
	end
	local old = Editor.ExportMergeRooms
	Editor.ExportMergeRooms = true

	Editor.ExportObj(name)
	
	Editor.ExportMergeRooms = old
end

-----------------------------------------------------
-- Import
-----------------------------------------------------

local function bound(x, n)
	if x < 0 then
		return 0
	elseif x > n then
		return n
	end
	return x
end

function LG(name)  -- LoadGroundObj
	local m0, m1 = math.huge, -math.huge
	local t = {}
	ParseObj(name or [[c:\Games\mm8\MapObj\ground\d4.obj]], function(v)
		t[#t + 1] = v
		m0 = min(m0, v[3])
		m1 = max(m1, v[3])
	end)
	assert(#t == 128*128, "not a ground model")
	table.sort(t, function(a, b)
		if abs(a[2] - b[2]) < 0x10 then
			return a[1] < b[1]
		else
			return a[2] > b[2]
		end
	end)
	
	if m0 >= 0 and m1 < 255*32 + 16 then
		m0 = 0
	end
	local hm = Map.HeightMap
	for y = 0, 127 do
		for x = 0, 127 do
			hm[y][x] = bound((t[y*128 + x + 1][3]/32):round(), 255)
		end
	end
	Editor.State = Editor.State or {}
	Editor.ReadSquares()
	Editor.UpdateMap()
end

function L(file)
	Editor.State = nil
	--Editor.LoadObj("c:/3d7.obj")
	--Editor.LoadObj("c:/sfera.obj")
	-- Editor.LoadObj(AppPath.."MapObj/"..(file or "d1-nflip.obj"))
	Editor.LoadObj(AppPath.."MapObj/"..(file or "3room.obj"))
	--do return dump(Editor.LoadObj("c:/dun01noflip.obj")) end
	Editor.UpdateMap()
	-- local r = Map.Rooms[1]
	-- Party.X, Party.Y, Party.Z = (r.MinX + r.MaxX)/2, (r.MinY + r.MaxY)/2, (r.MinZ + r.MaxZ)/2
	if Map.IsIndoor() then
		local v = next(Editor.State.Rooms[2].Facets).Vertexes[1]
		Party.X, Party.Y, Party.Z = v.X, v.Y, v.Z
	end
	-- evt.MoveToMap()
	-- return Party.X, Party.Y, Party.Z
end

-----------------------------------------------------
-- Navigate
-----------------------------------------------------

-- function W()
-- 	Editor.SetWorkMode(not Editor.WorkMode)
-- end

function Por()
	for f, i in pairs(Editor.FacetIds) do
		if f.IsPortal then
			local a = Map.GetFacet(i)
			a.IsPortal = not a.IsPortal
		end
	end
end

function NoPor()
	for _, a in Map.Facets do
		a.IsPortal = false
	end
end

-- function ClosestModel()
-- 	local xp,yp,zp = XYZ(Party)
-- 	local dist, mid = 1/0, nil
-- 	for id, m in Map.Models do
-- 		local x,y,z = XYZ(m)
-- 		x = x - xp
-- 		y = y - yp
-- 		z = z - zp
-- 		local d = x*x + y*y + z*z
-- 		if d < dist then
-- 			dist, mid = d, id
-- 		end
-- 	end
-- 	return mid
-- end

-- function ClosestModelName()
-- 	return Editor.Models[ClosestModel() + 1].Name
-- end

-- function ClosestModelFCount()
-- 	local n = 0
-- 	local t = Editor.Models[ClosestModel() + 1].PartOf.BaseFacets
-- 	for _ in pairs(t) do
-- 		n = n + 1
-- 	end
-- 	return n
-- end


-- -- test
-- -- mem.asmhook2(0x49FAD2, [[
-- 	-- and eax, 0xFF
-- -- ]])


-- -- local function TestUV(a, dx, dy, dz)
-- 	-- dx = dx or 0
-- 	-- dy = dy or 0
-- 	-- dz = dz or 0
-- 	-- local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ

-- 	-- -- U, V
-- 	-- local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
	
-- 	-- for i, id in a.VertexIds do
-- 		-- local v = Map.Vertexes[id]
-- 		-- local vertX, vertY, vertZ = round(v.X) + dx, round(v.Y) + dy, round(v.Z) + dz
-- 		-- assert(a.UList[i] == floor(ux*vertX + uy*vertY + uz*vertZ))
-- 		-- assert(a.VList[i] == floor(vx*vertX + vy*vertY + vz*vertZ))
-- 	-- end
-- -- end

-- -- local hooks = TmpHookManager{}

-- -- hooks.autohook(0x46E239, function(d)
-- 	-- local a = structs.MapFacet:new(d.ebx)
-- 	-- TestUV(a)
-- -- end)


-- -- test outdoor UV
-- local function TestUV(a, m, dx, dy, dz)
-- 	dx = dx or 0
-- 	dy = dy or 0
-- 	dz = dz or 0
-- 	local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ

-- 	-- U, V
-- 	local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
-- 	if a["?ptr"] == 0x41EAAF4 then
-- 		local v = m.Vertexes[a.VertexIds[0]]
-- 		local vertX, vertY, vertZ = round(v.X) + dx, round(v.Y) + dy, round(v.Z) + dz
-- 		print(vertX, vertY, vertZ, ux, uy, uz, vx, vy, vz)
-- 		print(a.UList[0], floor(ux*vertX + uy*vertY + uz*vertZ))
-- 		print(a.VList[0], floor(vx*vertX + vy*vertY + vz*vertZ))
-- 	end
	
-- 	local ok = true
-- 	for i, id in a.VertexIds do
-- 		local v = m.Vertexes[id]
-- 		local vertX, vertY, vertZ = round(v.X) + dx, round(v.Y) + dy, round(v.Z) + dz
-- 		local was = ok
-- 		ok = ok and (a.UList[i] == floor(ux*vertX + uy*vertY + uz*vertZ))
-- 		ok = ok and (a.VList[i] == floor(vx*vertX + vy*vertY + vz*vertZ))
-- 		-- if was and not ok then
-- 			-- print(nx, ny, nz, v.X, v.Y, v.Z)
-- 			-- print(a.UList[i] - floor(ux*vertX + uy*vertY + uz*vertZ))
-- 			-- print(a.VList[i] - floor(vx*vertX + vy*vertY + vz*vertZ))
-- 		-- end
-- 	end
-- 	return ok
-- end

-- local function MoveToFacet(a)
-- 	local x, y, z, n = 0, 0, 0, 0
-- 	for i, id in a.VertexIds do
-- 		local v = m.Vertexes[id]
-- 		x = x + v.X
-- 		y = y + v.Y
-- 		z = z + v.Z
-- 	end
-- end

-- function tst()
-- 	local good, bad = 0, 0
-- 	local oc = Editor.OutdoorUVCorrection
-- 	for _, m in Map.Models do
-- 		for _, f in m.Facets do
-- 			if TestUV(f, m, oc, oc, oc) then
-- 				good = good + 1
-- 			else
-- 				bad = bad + 1
-- 				-- return MoveToFacet(a)
-- 			end
-- 		end
-- 	end
-- 	return good, bad
-- end


-----------------------------------------------------
-- Ddm Data
-----------------------------------------------------

-- function CompileDdm(fname)
-- 	local data = {}
	
-- 	local function writenum(num, n)
-- 		for i = 1, n or 4 do
-- 			data[#data + 1] = string.char(num % 256)
-- 			num = num:div(256)
-- 		end
-- 	end

-- 	local function write(p, size)
-- 		if not size then
-- 			size = p.size or p["?size"]
-- 			p = p["?ptr"]
-- 		end
-- 		data[#data + 1] = mem.string(p, size, true)
-- 	end

-- 	local function awrite(a)
-- 		writenum(a.count)
-- 		write(a)
-- 	end
	
-- 	-- Ddm
-- 	data = {}
-- 	writenum(0, mmv(8, 40, 40))  -- header
-- 	writenum(0, 968*2)  -- visible map
-- 	for _, m in Map.Models do
-- 		for _, a in m.Facets do
-- 			writenum(a.Bits:AndNot(0x00100000))
-- 		end
-- 	end
-- 	for _, a in Map.Sprites do
-- 		writenum(a.Bits, 2)
-- 	end
-- 	awrite(Map.Monsters)
-- 	awrite(Map.Objects)
-- 	awrite(Map.Chests)
	
-- 	writenum(0, 200)  -- Map.Vars
-- 	write(Map.OutdoorExtra)  -- other map props
-- 	if mmver == 8 then
-- 		writenum(0, 30604)  -- notes
-- 	end

-- 	io.SaveString(path.setext(fname or AppPath.."Data\tmp.", ".ddm"), table.concat(data))
-- end


-----------------------------------------------------
-- Read Data
-----------------------------------------------------

function L1()
	Editor.ReadMap()
	Editor.UpdateMap()
end

L2 = || Editor.ReadMap()

-- function d()
	-- print(dump(Map.Vertexes))
	-- print("----- Facets ------")
	-- print(dump(Map.Facets))
	-- print("----- FacetData ------")
	-- print(dump(Map.FacetData))
	-- print("----- Rooms ------")
	-- print(dump(Map.Rooms))
-- end

-- -- function CheckMonsters()
-- 	-- local t = {}
-- 	-- for id, a in Map.Monsters do
-- 		-- local s, s1 = Editor.Monsters[id + 1].BinData, mem.string(a["?ptr"], a["?size"], true)
-- 		-- for i = 1, #s do 
-- 			-- if s:byte(i) ~= s1:byte(i) then
-- 				-- t[i - 1] = (t[i - 1] or 0) + 1
-- 			-- end
-- 		-- end
-- 	-- end
-- 	-- return dump(t)
-- -- end


-- -- for manual editing of maps
-- function FacetBin()
-- 	local p = Mouse.Target:Get()["?ptr"]
-- 	local s = ""
-- 	for p = p, p + 0x33 do
-- 		s = ("%s%.2X "):format(s, mem.u1[p])
-- 	end
-- 	return s
-- end

-----------------------------------------------------
-- GUI
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

function SelId(v)
	return SelectFacetWith("Id", v, true)
end

function SelectDoor()
	SelectFacetWith("Door", Editor.Facets[next(Editor.Selection) + 1].Door)
	-- local door = Editor.Facets[next(Editor.Selection) + 1].Door
	-- for f, id in pairs(Editor.FacetIds) do
	-- 	if f.Door == door and not Editor.Selection[id] then
	-- 		Editor.Selection[id] = Map.GetFacet(id).BitmapId
	-- 		Map.GetFacet(id).BitmapId = 0
	-- 	end
	-- end
end

function GetDoor()
	local door = Editor.Facets[next(Editor.Selection) + 1].Door
	return Map.Doors[Editor.DoorIds[door]]
end

function GetF()
	local t = next(Editor.EnumSelection())
	-- local t = Editor.Facets[next(Editor.Selection) + 1]
	return t, dump(t)
end

function GetMF()
	local t = Map.GetFacet(next(Editor.Selection))
	return t, dump(t)
end

function ImpI()
	local t = {}
	for a in pairs(Editor.EnumSelection()) do
		t[#t+1] = Editor.ImportIndex[a]
	end
	table.sort(t)
	return unpack(t)
end

function ImpB()
	local t = {}
	for a in sortpairs(Editor.EnumSelection()) do
		t[#t+1] = Editor.ImportBin[a]
	end
	return unpack(t)
end

function ImpBB()
	local t = {}
	for a in sortpairs(Editor.EnumSelection()) do
		t[#t+1] = Editor.ImportBin[a]:gsub(".", |s| ("%.2x "):format(s:byte()))
	end
	return unpack(t)
end


function ExtractChests(fname)
	fname = AppPath.."Data\\"..(fname or "Chests")
	Editor.WriteChests()
	local data = {}
	
	local function write(p, size)
		if not size then
			size = p.size or p["?size"]
			p = p["?ptr"]
		end
		data[#data + 1] = mem.string(p, size, true)
	end
	
	write(Map.Chests)
	
	io.save(fname, table.concat(data))
end


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

function DoBatchSave(dir)
	Sleep(1)
	local co = coroutine.running()
	local done = AutoResume()
	for _, a in Game.MapStats do
		local s = a.FileName
		if s ~= "" then
			print('loading', s)
			function events.LoadMap()
				events.remove('LoadMap', 1)
				io.SaveString(dir..s..".dat", internal.persist(Editor.State))
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

function BatchSave(dir)
	dir = path.addslash(dir or AppPath.."Batch")
	os.mkdir(dir)
	cocall2(DoBatchSave, dir)
end

function DoBatchLoad(mask, odir, preproc, postproc)
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
		Editor.UpdateMap(odir..path.setext(path.name(s), ''))
		print('ok', s)
	end
	done()
	if postproc then
		postproc()
	end
end

function DoBatchLoadAll(dir, odir, ...)
	dir = path.addslash(dir or AppPath.."Batch")
	odir = path.addslash(odir or AppPath.."BatchCompiled")
	Sleep(1)
	DoBatchLoad(dir.."*.dat", odir, ...)
	-- DoBatchLoad(dir.."*.blv.dat", odir, preproc)
	-- DoBatchLoad(dir.."*.odm.dat", odir, preproc)
end

function BatchLoad(...)
	cocall2(DoBatchLoadAll, ...)
end

-----------------------------------------------------
-- Unrelated to editor
-----------------------------------------------------

function blv(name)
	evt.MoveToMap{Name=name..".blv"}
end

function odm(name)
	evt.MoveToMap{Name=name..".odm"}
end

function MTarget()
	return Mouse:GetTarget():Get()
end

function ToBin(s, size)
	s = s or Mouse:GetTarget():Get()
	if type(s) ~= "string" then
		if size then
			s = mem.string(s, size, true)
		elseif s["?ptr"] then
			s = mem.string(s["?ptr"], s["?size"], true)
		end
	end
	return s:gsub(".", |s| ("%.2x "):format(s:byte(1))):sub(1, -2)
end

function TargetBits()
	local a = Mouse:GetTarget():Get()
	local o = a and structs.o[structs.name(a)].Bits
	return o and ToBin(a["?ptr"] + o, a["?size"] - o)
end
