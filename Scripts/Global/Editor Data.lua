Editor = Editor or {}
local _KNOWNGLOBALS = FacetRefsLimit, BitmapsHDScale

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

local function inorm(x, y, z)
	local n = x*x + y*y + z*z
	return (n ~= 0) and n^(-0.5) or 0
end

local function normalize(x, y, z, mul)
	local n = inorm(x, y, z)*(mul or 1)
	return x*n, y*n, z*n
end

local state
local Vertexes
local VertexIds
local Facets
local FacetIds
local FacetData
local FacetRooms
local BSP
local RoomSprites
local RoomLights
local Lights
local LightIds
local VertexLim
local DeanimateFacets

local AllocSize = 0x1000000  -- 16 MB
Editor.DataBuf = Editor.DataBuf or mem.StaticAlloc(AllocSize + 0x10000)
Editor.DummyItem = structs.Item:new(Editor.DataBuf)
local allocBuf = Editor.DataBuf + Editor.DummyItem['?size']
local allocStart = allocBuf
local allocPtr = allocBuf + AllocSize

-- allocate memory on the same rights as map data, i.e. zeroed out on level rebuild, lost on level exit
function Editor.Alloc(size)
	local r = allocStart
	allocStart = r + size
	assert(allocStart - allocBuf <= AllocSize, "out of memory")
	return r
end

local function alloc(size)
	local r = allocPtr
	allocPtr = r + size
	assert(allocPtr - allocBuf <= AllocSize, "out of memory")
	return r
end

local function new(a, count)
	mem.freeMM(a["?ptr"])
	a.count = count
	rawset(a, "?ptr", nil)
	a["?ptr"] = mem.allocMM(a.size)
	mem.fill(a["?ptr"], a.size, 0)
end

local function WriteList(a, t, ref)
	a.count = #t
	rawset(a, "?ptr", nil)
	a["?ptr"] = alloc(2*#t)
	for i, v in ipairs(t) do
		a[i - 1] = ref and ref[v] or v
	end
end

local function WriteKeysList(a, t, ref)
	a.count = 0x7FFF
	rawset(a, "?ptr", nil)
	a["?ptr"] = allocPtr
	local n = 0
	for v in pairs(t) do
		a[n] = ref and ref[v] or v
		n = n + 1
	end
	a.count = n
	alloc(2*n)
end

local function AddToList(list, ids, obj, id)
	if type(id) == "number" then
		list.m = max(id + 1, list.m or 0)
		ids[obj] = id
		list[id + 1], obj = obj, list[id + 1]
		if not obj then
			return
		end
	end
	local i = list.n or 0
	repeat
		i = i + 1
	until not list[i]
	list[i], ids[obj] = obj, i - 1
	list.n = i
end
Editor.AddToList = AddToList

local function FinalizeList(list, ids)
	local k = (list.n or 0) + 1
	for i = k, list.m or 0 do
		local v = list[i]
		if v then
			if k < i then
				list[k], ids[v] = v, k - 1
				list[i] = nil
			end
			k = k + 1
		end
	end
	list.n, list.m = nil, nil
end
Editor.FinalizeList = FinalizeList


local CopyFacetDataProps = {
	Id = mmver > 6 or nil,
	Event = true,
}

local IsFacetDataProp = table.copy(CopyFacetDataProps, {
	BitmapU = true,
	BitmapV = true,
	ImportVertex = true,
	AlignLeft = "BitmapU",
	AlignRight = "BitmapU",
	AlignTop = "BitmapV",
	AlignBottom = "BitmapV",
}, true)

-----------------------------------------------------
-- WriteVertex
-----------------------------------------------------

local function WriteVertex(a, v)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	a.X = round(v.X)
	a.Y = round(v.Y)
	a.Z = round(v.Z)
end

-----------------------------------------------------
-- WriteFacet
-----------------------------------------------------

function Editor.WriteNormal(a, t)
	-- calculate normal
	if mmver > 6 and Map.IsIndoor() then
		a.NormalFX = t.nx
		a.NormalFY = t.ny
		a.NormalFZ = t.nz
		a.NormalFDistance = t.ndist
	end
	a.NormalX = round(t.nx*0x10000)
	a.NormalY = round(t.ny*0x10000)
	a.NormalZ = round(t.nz*0x10000)
	a.NormalDistance = round(t.ndist*0x10000)
	
	-- calculate ZCalc
	local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
	local n = a.NormalDistance
	if nz ~= 0 then
		a.ZCalc1 = -nx*0x10000/nz
		a.ZCalc2 = -ny*0x10000/nz
		local zc = -n*0x10000/nz
		if zc > 0x7FFFFFFF then
			zc = 0x7FFFFFFF
		elseif zc < -0x80000000 then
			zc = -0x80000000
		end
		a.ZCalc3 = zc
	end

	-- interception directions bit
	local x, y, z = abs(nx), abs(ny), abs(nz)
	local b = a.Bits:AndNot(0x700)
	if z >= x and z >= y then
		a.Bits = b + 0x100  -- XY
	elseif y >= x and y >= z then
		a.Bits = b + 0x200  -- XZ
	else
		a.Bits = b + 0x400  -- YZ
	end
end

local function trunc(x, d)
	if x < 0 then
		return x + (-x % d)
	else
		return x - x % d
	end
end

function Editor.GetUVDirections(a)
	local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
	local ux, uy, uz, vx, vy, vz
	if nz == 0 then  -- wall
		ux, uy, uz = -ny/0x10000, nx/0x10000, 0
		vx, vy, vz = 0, 0, -1
	elseif abs(nz) >= (Map.IsIndoor() and 0xB569 or 0xE6CA) then  -- floor, ceil
		ux, uy, uz = 1, 0, 0
		vx, vy, vz = 0, -1, 0
	else
		local q = (nx*nx + ny*ny)^(-0.5)
		ux, uy, uz = trunc(-ny*q, 1/0x10000), trunc(nx*q, 1/0x10000), 0
		vx, vy, vz = 0, 0, -1
	end
	return ux, uy, uz, vx, vy, vz
end

function Editor.WriteUV(a, v, dx, dy, dz)
	dx = dx or 0
	dy = dy or 0
	dz = dz or 0
	local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
	-- set PolygonType
	if nz == 0 then  -- wall
		a.PolygonType = 1
	else
		a.PolygonType = (nz > 0 and 3 or 5) + (nx == 0 and ny == 0 and 0 or 1)
	end
	
	-- U, V
	local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
	
	for i = 1, #v do
		local vertX, vertY, vertZ = round(v[i].X) + dx, round(v[i].Y) + dy, round(v[i].Z) + dz
		a.UList[i - 1] = floor(ux*vertX + uy*vertY + uz*vertZ)
		a.VList[i - 1] = floor(vx*vertX + vy*vertY + vz*vertZ)
	end
end

function Editor.WriteInterceptDisplacement(a, v)
	local DELTA = 3  -- displacement magnitude
	local n = #v
	for i = 1, n do
		local v0, v1 = v[(i - 2) % n + 1], v[i]
		local x, y, z = v0.X - v1.X, v0.Y - v1.Y, v0.Z - v1.Z
		local m = -DELTA*inorm(x, y, z)
		a.XInterceptDisplacement[i - 1] = round(x*m)
		a.YInterceptDisplacement[i - 1] = round(y*m)
		a.ZInterceptDisplacement[i - 1] = round(z*m)
	end
end

local function UpdateFacetMinMax(a, t)
	local vert = t.Vertexes
	if not vert[1] then
		return  -- for exact mode
	end
	local NeedDoors = t.Door or t.IsPortal or t.MultiDoor
	-- BBox
	for coord in XYZ do
		local m1, m2 = math.huge, -math.huge
		for i, v in ipairs(vert) do
			m1 = min(m1, v[coord])
			m2 = max(m2, v[coord])
			local door = NeedDoors and Editor.GetVertexDoor(t, v)
			if door then
				local d = (door["Direction"..coord] or 0)*(door.MoveLength or 0)
				m1 = min(m1, v[coord] + d)
				m2 = max(m2, v[coord] + d)
			end
		end
		a["Min"..coord] = round(m1) - 5
		a["Max"..coord] = round(m2) + 5
	end
end

function Editor.LoadBitmap(name)
	local i = Game.BitmapsLod:LoadBitmap(name or "pending")
	if i >= 0 then
		Game.BitmapsLod.Bitmaps[i]:LoadBitmapPalette()
	end
	return i
end

local DefBmp = {
	mmv("OFlr", "Hive8", "t31a02a"),
	mmv("t1c2", "Hive21", "t31a02b"),
	mmv("t1w11a", "Hive2", "t31a01"),
}

function Editor.GetFacetBitmap(t, a)
	local nz = t.Bitmap or a.NormalZ
	return t.Bitmap or (t.Invisible or t.IsPortal) and "pending" or nz >= 0xB569 and DefBmp[1] or nz <= -0xB569 and DefBmp[2] or DefBmp[3]
end

function Editor.LoadFacetBitmap(a, t)
	local bmp = (t.Bitmap and t.AnimatedTFT and Game.BitmapsLod:LoadTFTBitmap(t.Bitmap))
	if bmp then
		a.AnimatedTFT = true
		a.BitmapId = bmp
	else
		a.AnimatedTFT = false
		a.BitmapId = Editor.LoadBitmap(Editor.GetFacetBitmap(t, a))
	end
end

local function WriteFacet(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	local v = t.Vertexes
	
	local function bcopy(a, b)
		if b then
			mem.copy(a["?ptr"], b, #b)
		end
	end
	
	bcopy(a, t.bytes)
	-- vertexes
	local n = #v + 1  -- count with extra vertex
	if n > 51 then
		Editor.LastError = "facet with over 50 vertices found"
		Editor.LastErrorFacets = {t}
	end
	a.VertexesCount = n - 1
	a.VertexIds["?ptr"] = alloc(2*n)
	for i = 1, n - 1 do
		a.VertexIds[i - 1] = VertexIds[v[i]]
	end
	
	-- normal
	Editor.WriteNormal(a, t)

	-- Bitmap
	Editor.LoadFacetBitmap(a, t)
	if t.AnimatedTFT ~= a.AnimatedTFT then
		DeanimateFacets[a] = true
	end

	-- Bits
	for k in pairs(Editor._FacetBits) do
		a[k] = t[k]
	end
	a.MoveByDoor = t.Door ~= nil and not t.DoorStaticBmp

	-- InterceptDisplacement
	a.XInterceptDisplacement["?ptr"] = alloc(2*n)
	a.YInterceptDisplacement["?ptr"] = alloc(2*n)
	a.ZInterceptDisplacement["?ptr"] = alloc(2*n)
	bcopy(a.XInterceptDisplacement, t.bytesXInterceptDisplacement)
	bcopy(a.YInterceptDisplacement, t.bytesYInterceptDisplacement)
	bcopy(a.ZInterceptDisplacement, t.bytesZInterceptDisplacement)
	if not t.bytesXInterceptDisplacement then
		Editor.WriteInterceptDisplacement(a, v)
	end

	-- U, V
	a.UList["?ptr"] = alloc(2*n)
	a.VList["?ptr"] = alloc(2*n)
	Editor.WriteUV(a, v)

	-- duplicate the first vertex at the end
	n = n - 1
	a.VertexIds[n] = a.VertexIds[0]
	a.UList[n] = a.UList[0]
	a.VList[n] = a.VList[0]
	a.XInterceptDisplacement[n] = a.XInterceptDisplacement[0]
	a.YInterceptDisplacement[n] = a.YInterceptDisplacement[0]
	a.ZInterceptDisplacement[n] = a.ZInterceptDisplacement[0]
	
	-- other properties
	a.HasData = t.Door ~= nil and (mmver > 6 or not t.DoorStaticBmp)
	-- print(#FacetData, a.HasData)
	for x in pairs(IsFacetDataProp) do
		if t[x] and t[x] ~= 0 then
			a.HasData = true
			break
		end
	end
	if t.UntouchableMM6 and mmver == 6 then
		a.Untouchable = true
	end

	UpdateFacetMinMax(a, t)
	
	if t.ExactData then
		-- table.copy(t.ExactData, a, true)
		for k, v in pairs(t.ExactData) do
			if v ~= a[k] and (k:sub(1,3) == 'Min' or k:sub(1,3) == 'Max') then --k:lower() > "m" and k:lower() < "n" then
				a[k] = v
			end
		end
	end
	
	if a.HasData then
		local n = #FacetData
		FacetData[n + 1] = t
		a.DataIndex = n
	end
	if t.IsPortal then
		a.Room = t.Room or 0
		a.RoomBehind = t.RoomBehind or 0
	else
		a.Room = FacetRooms[t]
	end
end

-----------------------------------------------------
-- WriteFacetData
-----------------------------------------------------

local function UpdateBitmapCoord(t, prop, Left, Right, UList)
	local id = Editor.FacetIds[t]
	local a = Map.GetFacet(id)
	local d = Map.IsOutdoor() and a or a.HasData and Map.FacetData[a.DataIndex]
	if not d then
		return
	end
	if t[Left] or t[Right] then
		local sign = t[Left] and -1 or 1
		local mu
		for _, u in a[UList] do
			if not mu or (u - mu)*sign > 0 then
				mu = u
			end
		end
		d[prop] = -mu
	else
		local v = t[prop] or Editor["Import"..prop][id] or 0
		if Map.IsOutdoor() then
			-- local x, y, z = XYZ(Editor.Models[id:div(64) + 1])
			local oc = Editor.OutdoorUVCorrection
			local x, y, z = oc, oc, oc
			local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
			v = v - (prop == "BitmapU" and ux*x + uy*y + uz*z or vx*x + vy*y + vz*z)
		end
		d[prop] = v:round()
	end
end

function Editor.UpdateBitmapU(t)
	UpdateBitmapCoord(t, "BitmapU", "AlignLeft", "AlignRight", "UList")
end

function Editor.UpdateBitmapV(t)
	UpdateBitmapCoord(t, "BitmapV", "AlignTop", "AlignBottom", "VList")
end

local function WriteFacetData(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	local facetId = FacetIds[t]
	if not facetId then
		return
	end
	a.FacetIndex = facetId
	for k in pairs(CopyFacetDataProps) do
		a[k] = t[k] or 0
	end
	if t.ImportVertex then
		local f = Map.Facets[facetId]
		if f.BitmapId < 0 then
			return
		end
		local b = Game.BitmapsLod.Bitmaps[f.BitmapId]
		local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(f)
		local vertX, vertY, vertZ = t.ImportVertex.X, t.ImportVertex.Y, t.ImportVertex.Z
		local bw, bh = b.Width, b.Height
		if BitmapsHDScale then
			bw, bh = bw/2, bh/2
		end
		Editor.ImportBitmapU[facetId] = -(ux*vertX + uy*vertY + uz*vertZ) + t.ImportU*bw
		Editor.ImportBitmapV[facetId] = -(vx*vertX + vy*vertY + vz*vertZ) + t.ImportV*bh
	end
	Editor.UpdateBitmapU(t)
	Editor.UpdateBitmapV(t)
end

-----------------------------------------------------
-- WriteFacetBitmaps
-----------------------------------------------------

local function WriteFacetBitmaps(all, prop)
	for i, t in ipairs(all) do
		local s = Editor.GetFacetBitmap(t, Map.Facets[i - 1])
		mem.copy(alloc(10), s, #s)
	end
end

-----------------------------------------------------
-- WriteRoom
-----------------------------------------------------

local function StoreBSP(node)
	if not node then
		return -1
	end
	local n = #BSP
	local t = {CoplanarOffset = node.CoplanarOffset, CoplanarSize = node.CoplanarSize}
	BSP[n + 1] = t
	t.FrontNode = StoreBSP(node.Front)
	t.BackNode = StoreBSP(node.Back)
	return n
end

local function WriteRoom(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	-- facet lists
	local walls, floors, ceils, portals, draw = {}, {}, {}, {}, {}
	local typelist = {walls, walls, floors, floors, ceils, ceils}
	for i, _f in ipairs(t.DrawFacets) do
		local id = FacetIds[_f]
		local f = Map.Facets[id]
		if f.IsPortal then
			portals[#portals + 1] = id
		else
			local list = typelist[f.PolygonType]
			list[#list + 1] = id
		end
	end
	WriteList(a.Floors, floors)
	WriteList(a.Walls, walls)
	WriteList(a.Ceils, ceils)
	WriteList(a.Portals, portals)
	-- DrawFacets (draw portals under everything else)
	WriteList(a.DrawFacets, t.DrawFacets, FacetIds)
	WriteKeysList(a.Sprites, RoomSprites[t], Editor.SpriteIds)
	-- Markers
	
	-- BBox
	local function box(name, f, m)
		for _, fid in a.DrawFacets do
			m = f(m, Map.Facets[fid][name])
		end
		a[name] = m
	end
	box("MinX", min, 30000)
	box("MinY", min, 30000)
	box("MinZ", min, 30000)
	box("MaxX", max, -30000)
	box("MaxY", max, -30000)
	box("MaxZ", max, -30000)
	
	-- other properties
	a.Bits = t.BSP and 24 or 8  -- 8 for 'have non-vertical portals', 16 for 'has BSP'
	a.Darkness = t.Darkness or state.DefaultDarkness
	a.FirstBSPNode = StoreBSP(t.BSP)
	a.NonBSPDrawFacetsCount = t.NonBSP
	if Game.Version == 8 then
		a.EaxEnvironment = t.EaxEnvironment or 0
	end
end

local function WriteRoomLigths(a, t)
	WriteKeysList(a.Lights, RoomLights[t], LightIds)
end

-----------------------------------------------------
-- WriteOutlines
-----------------------------------------------------

local function GetEdgeName(v1, v2)
	local v1i = VertexIds[v1]
	local v2i = VertexIds[v2]
	return min(v1i, v2i).." "..max(v1i, v2i), v1i, v2i
end

local function GetSplitEdges()
	local SplitEdges = {}
	for _, r in ipairs(state.Rooms) do
		local t = r.BSP and r.BSP.SplitEdges or {}
		for i = 1, #t, 3 do
			local vv = {t[i], t[i+1]}
			SplitEdges[GetEdgeName(t[i], t[i+2])] = vv
			SplitEdges[GetEdgeName(t[i+1], t[i+2])] = vv
		end
	end
	return SplitEdges
end

local function IsOutline(f1, f2)
	-- invisible
	if f1.DontShowOnMap or f2.DontShowOnMap then
		return false
	end

	-- ceiling
	if f1.nz < 0 and f2.nz <= 0 or f1.nz <= 0 and f2.nz < 0 then
		return false
	end
	
	-- same normal
	if f1 ~= f2 and f1.nx == f2.nx and f1.ny == f2.ny and f1.nz == f2.nz then
		return false
	end

	-- parts of the same facet
	if f1 ~= f2 and f1.PartOf == f2.PartOf then
		return false
	end
	
	-- too horizontal
	local lim = state.OutlineFlatSkip
	if f1 ~= f2 and f1.nz > lim and f2.nz > lim then
		return false
	end
	return true
end

local function GetOFlatness(f1, f2)
	f2 = f2 or f1
	return f1 ~= f2 and f1.nx*f2.nx + f1.ny*f2.ny + f1.nz*f2.nz or 0 --min(f1.nz, f2.nz) or 0
end

local function GetOIndex(o)
	local i, j = o.Vertex1, o.Vertex2
	return min(i, j)*0x100000 + max(i, j)
end

local function WriteStoredOutlines(sorted)
	local mo, lim = Map.Outlines.Items, Map.Outlines.Limit
	if #sorted > lim and not Editor.LastError then
		Editor.LastError = ("Too many outlines (%s/"..lim..")"):format(#sorted)
		Editor.LastErrorFacets = {}
	end
	for _, t in ipairs(sorted) do
		local n = mo.count
		if n == lim then
			break
		end
		mo.count = n + 1
		local a = mo[n]
		rawset(a, "?ptr", nil)
		a["?ptr"] = a["?ptr"]  -- speed up
		a.Vertex1 = VertexIds[t.Vertex1]
		a.Vertex2 = VertexIds[t.Vertex2]
		a.Facet1 = FacetIds[t.Facet1]
		a.Facet2 = FacetIds[t.Facet2]
		a.Z = t.Z
		a["?ptr"] = nil
	end
end

local function WriteOutlines()
	mem.fill(Map.VisibileOutlines)
	mem.fill(Map.Outlines)
	if state.Outlines then
		return WriteStoredOutlines(state.Outlines)
	end
	local SplitEdges = GetSplitEdges()
	local out = {}
	local count = 0
	
	local function DiffDir(a, b)
		return a[1]*b[1] + a[2]*b[2] + a[3]*b[3] < 0
	end
	
	local function AddEdge(v1, v2, f, facId, dir)
		local s, v1i, v2i = GetEdgeName(v1, v2)
		local vv = SplitEdges[s]
		if vv then
			return AddEdge(vv[1], vv[2], f, facId, dir)
		end
		local o = out[s]
		if o then
			-- same direction means that they are parts of the same edge split in BSP process
			if (not o.f2 or IsOutline(f, o.f1)) and DiffDir(o.dir, dir) then
				o.Facet2 = facId
				o.f2 = f
			end
		elseif v1.X ~= v2.X or v1.Y ~= v2.Y then
			count = count + 1
			o = {}
			out[s] = o
			o.Facet1 = facId
			o.Facet2 = facId
			o.Vertex1 = v1i
			o.Vertex2 = v2i
			o.Z = (v1.Z + v2.Z)/2
			o.Visible = false
			o.f1 = f
			o.v1 = v1
			o.v2 = v2
			o.dir = dir
		end
	end
	
	for f, facId in pairs(FacetIds) do
		if --[[not f.DontShowOnMap and]] not f.IsPortal and not f.Invisible and not f.Untouchable then
			local n = #f.Vertexes
			for i, v1 in ipairs(f.Vertexes) do
				local v2 = f.Vertexes[i % n + 1]
				AddEdge(v1, v2, f, facId, {v2.X - v1.X, v2.Y - v1.Y, v2.Z - v1.Z})
			end
		end
	end
	
	-- need to sort in case there's too many of them
	local sorted, lim = {}, Map.Outlines.Limit
	for _, o in pairs(out) do
		if IsOutline(o.f1, o.f2 or o.f1) then
			sorted[#sorted + 1] = o
		end
	end
	if #sorted > lim and not Editor.LastError then
		Editor.LastError = ("Too many outlines (%s/"..lim..")"):format(#sorted)
		Editor.LastErrorFacets = {}
	end
	table.sort(sorted, function(o1, o2)
		local i = GetOFlatness(o1.f1, o1.f2) - GetOFlatness(o2.f1, o2.f2)
		if i ~= 0 then
			return i < 0
		end
		return GetOIndex(o1) < GetOIndex(o2)
	end)
	
	local mo = Map.Outlines.Items
	for _, o in ipairs(sorted) do
		o.f1, o.f2 = nil, nil
		o.v1, o.v2 = nil, nil
		local n = mo.count
		if n == lim then
			break
		end
		mo.count = n + 1
		local m = mo[n]
		rawset(m, "?ptr", nil)
		m["?ptr"] = m["?ptr"]  -- speed up
		table.copy(o, m, true)
		m["?ptr"] = nil
	end
end

function Editor.UpdateOutlines()
	state = Editor.State
	WriteOutlines()
	for _, o in Map.Outlines do
		o.Visible = true
	end
end

-----------------------------------------------------
-- WriteSprites
-----------------------------------------------------

function Editor.NormalSpriteDec(a)
	local t = Game.DecListBin[a.DecListId]
	if a.DecListId == 0 or t.SFTIndex <= 0 or t.NoDraw then
		a.DecName = mmv("Pending!", "dec34", "pending")
	end
end

local function CreateSprite(t)
	local n = Map.Sprites.Count
	Map.Sprites.Count = n + 1
	local sp = Map.Sprites[n]
	rawset(sp, "?ptr", nil)
	sp["?ptr"] = sp["?ptr"]  -- speed up
	mem.fill(sp)
	table.copy(t, sp, true)
	Editor.NormalSpriteDec(sp)
	sp["?ptr"] = nil
end

function Editor.WriteSprites()
	Editor.BinInfo.SpritesBuf = allocPtr
	Map.Sprites.Count = 0
	Map.SoundSprites.Count = 0
	for i, t in ipairs(Editor.Sprites) do
		CreateSprite(t)
		local s = t.DecName or ""
		mem.copy(alloc(32), s, #s)
	end
	Editor.BinInfo.SpritesSize = allocPtr - Editor.BinInfo.SpritesBuf
end

local function InsertEntity(t, ename, limit)
	local lname = ename.."s"
	for i = 1, limit do
		if not Editor[lname][i] then
			Map[lname].Count = max(Map[lname].Count, i)
			Editor[lname][i] = t
			Editor[ename.."Ids"][t] = i - 1
			local e = Map[lname][i - 1]
			mem.fill(e)
			return e
		end
	end
	error(("Too many %s (>%s)"):format(lname:lower(), limit))
end

local function AddMapSprite(t)
	local sp = InsertEntity(t, "Sprite", Map.Sprites.Limit)
	sp.Event = 666
	return sp
end

function Editor.CreateSprite(t)
	local sp = AddMapSprite(t)
	rawset(sp, "?ptr", nil)
	sp["?ptr"] = sp["?ptr"]  -- speed up
	table.copy(t, sp, true)
	sp.Event = 666
	Editor.NormalSpriteDec(sp)
	Editor.State.Sprites[t] = true
	Editor.Update(Editor.UpdateSpritesList)
	Editor.Update(Editor.UpdateShowInvisible)
	sp["?ptr"] = nil
	return Editor.SpriteIds[t]
end

function Editor.UpdateSpriteLights()
	if Map.SpriteLights and Map.IsIndoor() then
		Map.SpriteLights.Count = 0
		for i, a in Map.Sprites do
			local es = Editor.Sprites[i + 1]
			local t = Game.DecListBin[a.DecListId]
			if not a.Invisible and not t.NoDraw and t.LightRadius ~= 0 then
				local R, G, B
				if Game.RendererD3D ~= 0 and i4[mmv(nil, 0xEF50AC, 0xFC4FC4)] ~= 0 then
					R, G, B = t.Red, t.Green, t.Blue
				else
					R, G, B = 255, 255, 255
				end
				mem.call(mmv(nil, 0x4AD32B, 0x4AB6E5), 1, mmv(nil, 0x518670, 0x529F58), a.X, a.Y, a.Z + t.Height:div(2), t.LightRadius, R, G, B, 5)
			end
		end
	end
end

local function AssignEntityToRooms(rooms, t, r2)
	for _, a in pairs(rooms) do
		a[t] = nil
	end
	-- local log = {r}
	local x, y, z = t.X, t.Y, t.Z
	local best = math.huge
	for ri, room in ipairs(Editor.State.Rooms) do
		for _, f in pairs(room.DrawFacets) do
			local m = Editor.FacetMiddles[f]
			local x, y, z = x - m.X, y - m.Y, z - m.Z
			local r = x*f.nx + y*f.ny + z*f.nz
			if r > -1 then
				local r = max(0, (x*x + y*y + z*z - r*r)^0.5 - m.R)^2 + r*r
				if r < best then
					best = r
				end
				if r <= r2 then
					-- log[#log+1] = r
					rooms[room][t] = true
					-- if rooms == RoomSprites then
					-- 	print(ri)
					-- end
					break
				end
			end
		end
	end
	-- print(unpack(log))
	if best > r2 then
		AssignEntityToRooms(rooms, t, best)
	end
end

local function AssignSpriteToRooms(t)
	local x, y, z = XYZ(t)
	local i = Map.RoomFromPoint(x, y, z)
	if i == 0 then
		i = Map.RoomFromPoint(x, y, z + 10)
	end
	if i == 0 then
		-- print('failed', XYZ(t))
		return AssignEntityToRooms(RoomSprites, t, 1024^2)
	end
	-- found
	for _, a in pairs(RoomSprites) do
		a[t] = nil
	end
	RoomSprites[Editor.State.Rooms[i + 1]][t] = true
	-- return AssignEntityToRooms(RoomSprites, t, 1024^2)
end

-- for editing assign all sprites to all rooms in a single list

local function UpdateRoomEntityList(name)
	if Map.IsOutdoor() then
		return
	end
	local lst = Map.Rooms[0][name]
	lst.Count = 0x7FFF
	local n = 0
	local L = Editor[name]
	for i = 1, Map[name].Count do
		if L[i] then
			lst[n], n = i - 1, n + 1
		end
	end
	for _, r in Map.Rooms do
		r[name].Count = n
	end
end

local function InitRoomEntityList(name)
	local p = alloc(3000*2)  -- 3000 entities
	for _, r in Map.Rooms do
		r[name]["?ptr"] = p
	end
	UpdateRoomEntityList(name)
end

function Editor.UpdateSpritesList()
	UpdateRoomEntityList("Sprites")
end

-----------------------------------------------------
-- WriteLights
-----------------------------------------------------

local function WriteLights()
	new(Map.Lights, 3000)
	Map.Lights.Count = #Lights
	for t, i in pairs(LightIds) do
		local a = Map.Lights[i]
		rawset(a, "?ptr", nil)
		a["?ptr"] = a["?ptr"]  -- speed up
		if mmver ~= 6 then
			a.Type = 5
			a.Brightness = 31
		end
		table.copy(t, a, true)
		a["?ptr"] = nil
	end
	Editor.Lights = Lights
	Editor.LightIds = LightIds
end

function Editor.CreateLight(t)
	Editor.State.Lights[t] = true
	local a = InsertEntity(t, "Light", 3000)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	if mmver ~= 6 then
		a.Type = 5
		a.Brightness = 31
	end
	table.copy(t, a, true)
	a["?ptr"] = nil
	Editor.Update(Editor.UpdateLightsList)
	return Editor.LightIds[t]
end

local function AssignLightToRooms(t)
	return AssignEntityToRooms(RoomLights, t, (t.Radius or 0)^2)
end

function Editor.UpdateLightsList()
	UpdateRoomEntityList("Lights")
end

-----------------------------------------------------
-- WriteSpawns
-----------------------------------------------------

function Editor.WriteSpawns()
	local state = Editor.State
	local Spawns, SpawnIds = {}, {}
	local n = 0
	state.Spawns = state.Spawns or {}
	for a in pairs(state.Spawns) do
		SpawnIds[a], n = n, n + 1
		Spawns[n] = a
	end
	Editor.Spawns = Spawns
	Editor.SpawnIds = SpawnIds
	
	new(Map.Spawns, 3000)
	Map.Spawns.Count = #Spawns
	for t, i in pairs(SpawnIds) do
		table.copy(t, Map.Spawns[i], true)
	end
end

function Editor.CreateSpawn(t)
	Editor.State.Spawns[t] = true
	InsertEntity(t, "Spawn", 3000)
	return Editor.SpawnIds[t]
end

-----------------------------------------------------
-- Editor.WriteDoor
-----------------------------------------------------

local DoorProps = {
	Id = true,
	MoveLength = true,
	Speed1 = true,
	Speed2 = true,
	NoSound = true,
	StartState2 = true,
}

local DoorUncutVertex = {}

function Editor.UpdateDoorsBounds(doors)
	if next(doors) then
		for f, id in pairs(Editor.FacetIds) do
			if doors[f.Door] then
				UpdateFacetMinMax(Map.Facets[id], f)
			end
		end
	end
end

function Editor.FindVertexOnLine(f, v0, vecs, tx, ty, tz)
	for _, v in ipairs(f.Vertexes) do
		if vecs[v] then
			local x, y, z = normalize(v.X - v0.X, v.Y - v0.Y, v.Z - v0.Z)
			if x*tx + y*ty + z*tz > 0.999 then
				return v
			end
		end
	end
end

Editor.DoorVertexFilter = Editor.DoorVertexFilter or {}

local function SplitFilter(shrink, t, move, maybe, static, other, param, param2)
	shrink = shrink and -1 or 1
	local vert = table.copy(table.copy(move, maybe), static)
	local dirX, dirY, dirZ = t.DirectionX*shrink, t.DirectionY*shrink, t.DirectionZ*shrink
	-- min, max on Direction line
	local x1, x2 = 1/0, -1/0
	for v in pairs(vert) do
		local x = v.X*dirX + v.Y*dirY + v.Z*dirZ
		x1 = min(x1, x)
		x2 = max(x2, x)
	end
	-- find x >= lim
	param = x1 + (x2 - x1)*(param or 0.5)
	param2 = x1 + (x2 - x1)*(param2 or 2)
	local dvert = {}
	for v, x in pairs(vert) do
		local x = v.X*dirX + v.Y*dirY + v.Z*dirZ
		if x >= param and x <= param2 then
			dvert[v] = true
		end
	end
	return dvert
end

function Editor.DoorVertexFilter.Grow(...)
	return SplitFilter(false, ...)
end

function Editor.DoorVertexFilter.Shrink(...)
	return SplitFilter(true, ...)
end

function Editor.DoorVertexFilter.Free(t, move, maybe, static, other)
	return table.copy(table.copy(move, maybe), static), nil, table.copy(other)
end

function Editor.DoorVertexFilter.CheckShift(t, move, maybe, static, other)
	local function enum(t)
		for v in pairs(t) do
			if v.Shift and not static[v] then
				return v.Shift
			end
		end
	end
	local sh = enum(move) or enum(maybe)
	if not sh then
		return move, maybe, static, other
	end
	for v in pairs(table.copy(move, maybe)) do
		if v.Shift == sh then
			move[v] = true
			static[v] = nil
		end
	end
	return move, maybe, static, other
end


Editor.DoorMinCos = 0.05  -- for unmoved facets that can't be stretched
function Editor.GetDoorVertexLists(t, Add2, write)
	if t.ExactFacets and t.ExactVertexes then
		return table.copy(t.ExactVertexes), {}, table.copy(t.ExactFacets)
	end	
	local dirX, dirY, dirZ = normalize(t.DirectionX, t.DirectionY, t.DirectionZ)
	-- prepare lists
	local state = Editor.State
	Add2 = Add2 or function() end
	local FacetIds = Editor.FacetIds
	local DFacets = {}
	local DVertex = {}
	local DStaticVertex = {}
	local NDVertex = {}
	local ForceStaticVertex = {}
	local Portals = {}
	local Mults = {}
	
	local function AddDFacet(f, rid)
		DFacets[#DFacets + 1] = FacetIds[f]
		Add2(f, rid)
	end
	
	local function AddFacetVerts(f, isdoor)
		local tbl = not isdoor and NDVertex or f.MovedByDoor and DVertex or DStaticVertex
		if tbl == DStaticVertex and abs(f.nx*dirX + f.ny*dirY + f.nz*dirZ) > Editor.DoorMinCos then
			-- unmoved facet that can't be stretched
			tbl = ForceStaticVertex
			if write then
				Map.Facets[FacetIds[f]].MoveByDoor = false
			end
		end
		for _, v in ipairs(f.Vertexes) do
			tbl[v] = true
		end
	end
	
	-- enumerate facets
	local exact = t.ExactFacets
	for rid, r in ipairs(Editor.State.Rooms) do
		for _, f in ipairs(r.DrawFacets) do
			local isdoor = exact and exact[f] or (f.Door == t)
			if not isdoor and not exact and (f.MultiDoor or t.ClosePortal and f.IsPortal) then
				if t.ClosePortal ~= true and f.IsPortal then
					Portals[f] = rid
				else
					Mults[f] = rid
				end
			else
				if isdoor then
					AddDFacet(f, rid)
				end
				AddFacetVerts(f, isdoor)
			end
		end
	end
	
	-- enumerate differed multidoor facets
	for f, rid in pairs(Mults) do
		for i, v in ipairs(f.Vertexes) do
			if DVertex[v] then
				AddDFacet(f, rid)
				AddFacetVerts(f, true)
				break
			end
		end
	end
	
	-- filter vertices
	if t.VertexFilter then
		local f = Editor.DoorVertexFilter[t.VertexFilter]
		if f then
			local par = {}
			for i = 1, 1/0 do
				par[i] = t["VertexFilterParam"..i]
				if not par[i] then
					break
				end
			end
			local q = {f(t, DVertex, DStaticVertex, ForceStaticVertex, NDVertex, unpack(par))}
			DVertex = q[1] or {}
			DStaticVertex = q[2] or {}
			ForceStaticVertex = q[3] or {}
		else
			Editor.LastError = "Unknown VertexFilter"
			Editor.LastErrorFacets = DFacets
		end
	end
	
	-- remove vertices that must be static
	for v in pairs(ForceStaticVertex) do
		DVertex[v] = nil
	end
	
	-- ClosePortal ~= true is a special case in which portal vertices are moved from static side of the door to the active side
	-- it's no longer generated, but still supported
	local function PortalVertex(f, i, v1)
		if v1 then
			local new = table.copy(v1)
			new.id = VertexIds[f.Vertexes[i]]
			new.portal = FacetIds[f]
			new.index = i - 1
			DVertex[new] = true
			return true
		end
	end
	
	for f, rid in pairs(Portals) do
		local ok
		for i, v in ipairs(f.Vertexes) do
			if DStaticVertex[v] and not DVertex[v] then
				ok = PortalVertex(f, i, Editor.FindVertexOnLine(f, v, DVertex, -dirX, -dirY, -dirZ)) or ok
			end
		end
		if ok then
			AddDFacet(f, rid)
		end
	end
	
	return DVertex, NDVertex, DFacets
end


function Editor.WriteDoor(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	mem.fill(a)
	for k in pairs(DoorProps) do
		a[k] = t[k]
	end
	local dirX, dirY, dirZ = normalize(t.DirectionX, t.DirectionY, t.DirectionZ)
	a.DirectionX = (dirX*0x10000):round()
	a.DirectionY = (dirY*0x10000):round()
	a.DirectionZ = (dirZ*0x10000):round()
	
	-- prepare lists
	local state = Editor.State
	local FacetIds = Editor.FacetIds
	local FacetStartU = {}
	local FacetStartV = {}
	local DRooms = {}

	local function AddDFacet2(f, rid)
		DRooms[rid - 1] = true
		local n = #FacetStartU + 1
		local mf = Map.Facets[FacetIds[f]]
		FacetStartU[n] = Map.FacetData[mf.DataIndex].BitmapU
		FacetStartV[n] = Map.FacetData[mf.DataIndex].BitmapV
		mf.MoveByDoor = not f.DoorStaticBmp and not f.IsPortal
		-- make ZCalc recalculation safe
		local nd = mf.NormalDistance
		local nd = max(abs(nd), abs(nd - dirX*mf.NormalX - dirY*mf.NormalY - dirZ*mf.NormalZ) + 2)
		if abs(mf.NormalZ) < floor(nd/0x8000) then
			--Party.X, Party.Y, Party.Z = XYZ(f.Vertexes[1])
			mf.NormalZ, mf.ZCalc1, mf.ZCalc2, mf.ZCalc3, mf.PolygonType = 0, 0, 0, 0, 1
		end
	end
	
	local DVertex, NDVertex, DFacets = Editor.GetDoorVertexLists(t, AddDFacet2, true)
	
	-- cut vertexes, create vertex lists
	local CutVertex = {}
	local UncutVertex = {}
	local Vertexes = {}
	local VertexStartX = {}
	local VertexStartY = {}
	local VertexStartZ = {}
	for v in pairs(DVertex) do
		local i = assert(VertexIds[v] or v.id)
		if NDVertex[v] or v.portal then
			-- a vertex is used both for door and static geometry
			-- create a "moveable" copy of the vertex
			local n = Map.Vertexes.Count
			if n == VertexLim then
				mem.reallocMM(Map.Vertexes, VertexLim*6, VertexLim*12)
				VertexLim = VertexLim*2
			end
			Map.Vertexes.Count = n + 1
			WriteVertex(Map.Vertexes[n], v)
			UncutVertex[n], CutVertex[i], i = i, n, n
			
			if v.portal then
				Map.Facets[v.portal].VertexIds[v.index] = n
			end
		end
		local n = #Vertexes + 1
		Vertexes[n] = i
		VertexStartX[n] = Map.Vertexes[i].X
		VertexStartY[n] = Map.Vertexes[i].Y
		VertexStartZ[n] = Map.Vertexes[i].Z
	end
	-- set new vertex ids for door facets
	local function ReplaceVerts(CutVertex, all)
		if CutVertex and next(CutVertex) then
			for f, i in pairs(FacetIds) do
				if all or f.Door == t or f.MultiDoor then
					local vert = Map.Facets[i].VertexIds
					vert.Count = vert.Count + 1
					for i, vi in vert do
						if CutVertex[vi] then
							vert[i] = CutVertex[vi]
						end
					end
					vert.Count = vert.Count - 1
				end
			end
		end
	end
	ReplaceVerts(DoorUncutVertex[t], true)
	ReplaceVerts(CutVertex)
	DoorUncutVertex[t] = UncutVertex
	
	WriteList(a.VertexIds, Vertexes)
	WriteList(a.FacetIds, DFacets)
	WriteKeysList(a.RoomIds, DRooms)
	WriteList(a.FacetStartU, FacetStartU)
	WriteList(a.FacetStartV, FacetStartV)
	WriteList(a.VertexStartX, VertexStartX)
	WriteList(a.VertexStartY, VertexStartY)
	WriteList(a.VertexStartZ, VertexStartZ)

	if next(Vertexes) or next(DFacets) then
		a.TimeStep = (a.MoveLength*128/a.Speed2):ceil()
		a.State = a.StartState2 and 1 or 3
		a.SilentMove = true
		Editor.NeedDoorsUpdate = true
	else
		local id = Editor.DoorIds[t]
		Editor.Doors[id + 1] = nil
		Editor.DoorIds[t] = nil
	end
	
	a["?ptr"] = nil
end

function Editor.ResetMoveByDoor()
	if Map.IsOutdoor() then
		return
	end
	for t, id in pairs(Editor.FacetIds) do
		Map.Facets[id].MoveByDoor = t.Door ~= nil and not t.DoorStaticBmp
	end
end

local function WriteDoors()
	DoorUncutVertex = {}
	local Doors = {}
	local DoorIds = {}
	local nd = 0
	Map.Doors.Count = 0
	for f in pairs(FacetIds) do
		if f.Door and not DoorIds[f.Door] then
			DoorIds[f.Door], nd = nd, nd + 1
			Doors[nd] = f.Door
			Map.Doors.Count = nd
			Editor.WriteDoor(Map.Doors[nd - 1], f.Door)
		end
	end
	Editor.Doors = Doors
	Editor.DoorIds = DoorIds
end

function Editor.CheckDoorsUpdate()
	if Editor.NeedDoorsUpdate then
		Editor.NeedDoorsUpdate = false
		Editor.ProcessDoors()
	end
end

function Editor.InvalidateDoorBSP(a)
	for _, i in a.RoomIds do
		Editor.State.Rooms[i + 1].BSP = nil
	end
	Editor.UpdateBSPState()
end

-- must be followed by a call to Editor.UpdateDoorsBounds
function Editor.RecreateDoors(list)
	Editor.DoorCache = nil
	for door in pairs(list) do
		local id = Editor.DoorIds[door]
		local a = id and Map.Doors[id]
		if not a then
			for i = 1, 200 do
				if not Editor.Doors[i] then
					Map.Doors.Count = max(Map.Doors.Count, i)
					a = Map.Doors[i - 1]
					Editor.Doors[i] = door
					Editor.DoorIds[door] = i - 1
					mem.fill(a)
					a.TimeStep = 15360
					break
				end
			end
		end
		if a then
			local OldState, OldStep = a.State, a.TimeStep
			Editor.ResetDoor(a)
			Editor.WriteDoor(a, door)
			Editor.InvalidateDoorBSP(a)
			a.State = (OldState == 0 or OldState == 3) and 3 or 1
			a.TimeStep = OldStep
		else
			Editor.LastError = "too many doors (>200)"
			Editor.LastErrorFacets = {}
		end
	end
	if next(list) then
		Editor.ResetMoveByDoor()
	end
	Editor.CheckDoorsUpdate()
end

function Editor.MakeDoorCache()
	Editor.DoorCache, Editor.DoorCacheN = {}, {}
	local doors = {}
	for f in pairs(Editor.FacetIds) do
		if f.Door then
			doors[f.Door] = true
		end
	end
	for door in pairs(doors) do
		local vert, nvert = Editor.GetDoorVertexLists(door)
		for v in pairs(vert) do
			Editor.DoorCache[v] = door
			if nvert[v] then
				Editor.DoorCacheN[v] = true
			end
		end
	end
	return Editor.DoorCache
end

function Editor.GetVertexDoor(t, v)
	local vd = Editor.DoorCache or Editor.MakeDoorCache()
	local vnd = Editor.DoorCacheN
	local door = vd[v]
	if door and (not vnd[v] or door == t.Door or t.MultiDoor or door.ClosePortal and t.IsPortal) then
		return door
	end
end


-----------------------------------------------------
-- WriteChests
-----------------------------------------------------

local ChestProps = {
	ChestPicture = true,
	Trapped = true,
	Identified = true,
}

local function WriteChest(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	mem.fill(a)
	for k in pairs(ChestProps) do
		a[k] = t[k]
	end
	t.Items = t.Items or {}
	local di = a.Items.low - 1  -- 0 since MMExt 2.2, -1 before
	for i = 1, #t.Items do
		if i <= 140 then
			local it = t.Items[i]
			if type(it) == "number" then
				a.Items[i + di].Number = it
			else
				table.copy(it, a.Items[i + di], true)
			end
		else
			t.Items[i] = nil
		end
	end
	a["?ptr"] = nil
end
Editor.WriteChest = WriteChest

function Editor.WriteChests()
	local state = Editor.State
	state.Chests = state.Chests or {}
	Map.Chests.Count = 0
	for i, t in pairs(state.Chests) do
		Map.Chests.Count = max(Map.Chests.Count, i)
		WriteChest(Map.Chests[i - 1], t)
	end
end

-----------------------------------------------------
-- WriteObjects
-----------------------------------------------------

local ObjectProps = {
	X = true,
	Y = true,
	Z = true,
	-- Visible = true,
}

function Editor.ItemInitSpecial(a, num)
	a.Number = num
	if a.InitSpecial then
		a:InitSpecial()
	elseif mmver > 6 then
		mem.call(mmv(nil, 0x456D51, 0x4545E8), 1, Game.ItemsTxt["?ptr"] - 4, a)
	end
end

function Editor.WriteObject(a, t)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	mem.fill(a)
	for k in pairs(ObjectProps) do
		a[k] = t[k]
	end
	a.Room = Map.RoomFromPoint(a)
	Editor.ItemInitSpecial(a.Item, t.Item.Number)
	table.copy(t.Item, a.Item, true)
	Editor.UpdateObjectLook(a)
	a["?ptr"] = nil
end

local function RemapSelection(old, new)
	local t = {}
	for id in pairs(Editor.Selection) do	
		t[new[old[id + 1]]] = true
	end
	Editor.Selection = t
end

local function WriteObjects()
	Editor.State.Objects = Editor.State.Objects or {}
	Map.Objects.Count = 0
	local OldObjects = Editor.Objects
	Editor.Objects = {}
	Editor.ObjectIds = {}
	for t, id in pairs(Editor.State.Objects) do
		AddToList(Editor.Objects, Editor.ObjectIds, t, id)
	end
	FinalizeList(Editor.Objects, Editor.ObjectIds)
	Map.Objects.Count = #Editor.Objects
	for i, t in ipairs(Editor.Objects) do
		Editor.WriteObject(Map.Objects[i - 1], t)
	end
	if Editor.SelectionKind == skObject then
		RemapSelection(OldObjects, Editor.ObjectIds)
	end
end

function Editor.UpdateObjectLook(a)
	a.Type = Game.ItemsTxt[a.Item.Number].SpriteIndex
	a.TypeIndex = Game.ObjListBin.Find(a.Type)
end

function Editor.CreateObject(t)
	Editor.WriteObject(InsertEntity(t, "Object", 1000), t)
	Editor.State.Objects[t] = true
	return Editor.ObjectIds[t]
end

-----------------------------------------------------
-- WriteMonsters
-----------------------------------------------------

local function WriteMonProps(a, t, props, prefix)
	for k, props in pairs(props) do
		if type(props) == "table" then
			WriteMonProps(a[k], t, props, prefix..k)
		else
			a[k] = t[prefix..k]
		end
	end
end

local function WriteMonster(a, t, CompileFile)
	assert(a, "Too many monsters (>500)")
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	WriteMonProps(a, t, Editor.MonsterProps, "")
	a.HP = a.FullHitPoints
	a.AIState = t.Invisible and const.AIState.Invisible or nil
	mem.u8[a["?ptr"] + 0x2C] = 0  -- StandardName, Picture pointers
	if not CompileFile then
		a.AIState = 0
	end
	a["?ptr"] = nil
end

function Editor.SummonMonster(...)
	local a, n = SummonMonster(...)
	if a then
		a.GuardRadius = 0
	end
	return a, n
end

local function WriteMonsters(CompileFile)
	Editor.State.Monsters = Editor.State.Monsters or {}
	Map.Monsters.Count = 0
	local OldMonsters = Editor.Monsters
	Editor.Monsters = {}
	Editor.MonsterIds = {}
	for t, id in pairs(Editor.State.Monsters) do
		AddToList(Editor.Monsters, Editor.MonsterIds, t, id)
	end
	FinalizeList(Editor.Monsters, Editor.MonsterIds)
	for i, t in ipairs(Editor.Monsters) do
		local a, n = Editor.SummonMonster(t.Id, t.X, t.Y, t.Z, true)
		if not a then
			Editor.LastError = "Too many monsters (>500)"
			Editor.LastErrorFacets = {}
		else
			assert(n == i - 1)
			WriteMonster(a, t, CompileFile)
		end
	end
	if Editor.SelectionKind == skMonster then
		RemapSelection(OldMonsters, Editor.MonsterIds)
	end
end

function Editor.UpdateMonster(n)
	local t = Editor.Monsters[n + 1]
	local a = Editor.SummonMonster(t.Id, t.X, t.Y, t.Z, true, n)
	WriteMonster(a, t)
end

function Editor.CreateMonster(t)
	Editor.State.Monsters[t] = true
	local n = Map.Monsters.Count
	if Map.Monsters.Count >= 499 then
		Editor.LastError = "Too many monsters (>500)"
		Editor.LastErrorFacets = {}
		return
	end
	local a, n = Editor.SummonMonster(t.Id, t.X, t.Y, t.Z, true)
	WriteMonster(a, t)
	Editor.Monsters[n + 1] = t
	Editor.MonsterIds[t] = n
	return n
end

-----------------------------------------------------
-- Write All
-----------------------------------------------------

function Editor.UpdateDynamicStuff(CompileFile)
	WriteObjects()
	WriteMonsters(CompileFile)
end

local function NewEntityList()
	local t = {}
	for i, r in ipairs(state.Rooms) do
		t[r] = {}
	end
	return t
end

local function PrepareLists(compile)
	FacetData = {{}}
	DeanimateFacets = {}
	Vertexes = {}
	VertexIds = {}
	Facets = {}
	FacetIds = {}
	FacetRooms = {}
	Editor.Sprites = {}
	Editor.SpriteIds = {}
	Lights = {}
	LightIds = {}
	Editor.Facets = Facets
	Editor.FacetIds = FacetIds
	
	-- verts
	if state.ExactVertexes then
		VertexIds = table.invert(state.ExactVertexes)
		for i, v in pairs(state.ExactVertexes) do
			Vertexes[i + 1] = v
		end
	end
	
	-- facets
	local vn = 0
	for i, r in ipairs(state.Rooms) do
		if not r.DrawFacets then
			local t = {}
			for a in pairs(r.Facets) do
				if a.IsPortal then
					t[#t + 1] = a
				end
			end
			for a in pairs(r.Facets) do
				if not a.IsPortal then
					t[#t + 1] = a
				end
			end
			r.DrawFacets = t
			r.NonBSP = #t
			r.BSP = nil
		end
		for _, a in ipairs(r.DrawFacets) do
			FacetRooms[a] = i - 1
			if not a.IsPortal or not a.Room or a.Room == i - 1 or a.RoomBehind ~= i - 1 then
				AddToList(Facets, FacetIds, a, r.Facets[a])
				for _, v in ipairs(a.Vertexes) do
					if not VertexIds[v] then
						VertexIds[v], vn = vn, vn + 1
						Vertexes[vn] = v
					end
				end
			end
		end
	end
	for a in pairs(FacetRooms) do
		if not FacetIds[a] then
			print(dump(a))
		end
	end
	FinalizeList(Facets, FacetIds)
	
	-- sprites
	RoomSprites = state.ExactRoomSprites or NewEntityList()
	state.Sprites = state.Sprites or {}
	for a, id in pairs(state.Sprites) do
		AddToList(Editor.Sprites, Editor.SpriteIds, a, id)
		if compile and not state.ExactRoomSprites then
			AssignSpriteToRooms(a)
		end
	end
	FinalizeList(Editor.Sprites, Editor.SpriteIds)
	
	-- lights
	RoomLights = state.ExactRoomLights or NewEntityList()
	state.Lights = state.Lights or {}
	for a, id in pairs(state.Lights) do
		AddToList(Lights, LightIds, a, id)
		if compile and not state.ExactRoomLights then
			AssignLightToRooms(a)
		end
	end
	FinalizeList(Lights, LightIds)
	
	-- BSP
	BSP = {}
end

function Editor.RemoveListSpeedup(list)
	for _, a in list do
		a["?ptr"] = nil
	end
end

local lastTime, profName
local function profile(name)
	-- local t = os.clock()
	-- if profName then
	-- 	print("Profiler: "..profName, t - lastTime)
	-- else
	-- 	print("Profiler: ----------------------------")
	-- end
	-- lastTime, profName = t, name
end
Editor.profile = profile

function Editor.UpdateMap(CompileFile)
	Editor.DoorCache = nil
	Editor.Selection = {}
	mem.dll.user32.BringWindowToTop(Game.WindowHandle)
	local bin = {}
	Editor.BinInfo = bin

	if not Map.IsIndoor() then
		mem.fill(allocBuf, allocPtr - allocBuf, 0)
		allocPtr = allocStart
		return Editor.UpdateOdm(CompileFile)
	end
	
	state = Editor.State
	if not state.Rooms and state.Models then
		return
	end
	
	state.Rooms = state.Rooms or {}
	state.Rooms[1] = state.Rooms[1] or {Facets = {}}
	if not Game.IsD3D or CompileFile then
		profile "BuildBSP"
		PrepareLists(CompileFile)
		Editor.BuildBSP(true)
	end
	if CompileFile and not Editor.StateSync then
		Editor.UpdateMap()  -- need RoomFromPoint for sprites
	end
	profile "PrepareLists"
	PrepareLists(CompileFile)
	
	-- prepare to allocate
	mem.fill(allocBuf, allocPtr - allocBuf, 0)
	allocPtr = allocStart

	-- vertexes
	profile "vertexes"
	VertexLim = #Vertexes + 10000
	new(Map.Vertexes, VertexLim)  -- with room for vertex copies by doors
	Map.Vertexes.Count = #Vertexes
	for i, a in ipairs(Vertexes) do
		WriteVertex(Map.Vertexes[i - 1], a)
	end
	Editor.Vertexes = Vertexes
	Editor.VertexIds = VertexIds
	
	-- facets
	profile "facets"
	new(Map.Facets, #Facets)
	bin.FacetsBuf = allocPtr
	for i, a in ipairs(Facets) do
		WriteFacet(Map.Facets[i - 1], a)
	end
	
	if CompileFile then
		bin.HdrFacetsSize = allocPtr - bin.FacetsBuf
		WriteFacetBitmaps(Facets)
		bin.FacetsSize = allocPtr - bin.FacetsBuf
	end
	
	-- facetdata
	profile "facetdata"
	Editor.ImportBitmapU = {}
	Editor.ImportBitmapV = {}
	new(Map.FacetData, #FacetData)
	for i, a in ipairs(FacetData) do
		WriteFacetData(Map.FacetData[i - 1], a)
	end
	bin.FacetDataBuf = allocPtr
	allocPtr = allocPtr + 10*#FacetData
	bin.FacetDataSize = allocPtr - bin.FacetDataBuf
	
	-- rooms
	profile "rooms"
	state.DefaultDarkness = state.DefaultDarkness or 18
	new(Map.Rooms, #state.Rooms)
	bin.RoomsBuf = allocPtr
	for i, a in ipairs(state.Rooms) do
		WriteRoom(Map.Rooms[i - 1], a)
	end
	bin.HdrRoomsSize = allocPtr - bin.RoomsBuf
	for i, a in ipairs(state.Rooms) do
		WriteRoomLigths(Map.Rooms[i - 1], a)
	end
	bin.RoomsSize = allocPtr - bin.RoomsBuf
	
	-- BSP
	profile "WriteBSP"
	new(Map.BSPNodes, #BSP)
	for i, a in ipairs(BSP) do
		table.copy(a, Map.BSPNodes[i - 1], true)
	end
	
	-- outlines are written later
	
	-- other
	profile "WriteLights"
	WriteLights()
	profile "WriteSpawns"
	Editor.WriteSpawns()
	
	profile "Doors"
	bin.DoorsBuf = allocPtr
	if CompileFile then
		Map.Doors.Count = Map.Doors.Limit
		mem.fill(Map.Doors)
	end
	WriteDoors()
	bin.DoorsSize = allocPtr - bin.DoorsBuf
	
	profile "WriteSprites"
	Editor.WriteSprites()
	
	-- Editor.UpdateSpriteLights() -- Editor.UpdateShowInvisible() does this

	-- outlines
	profile "WriteOutlines"
	state.OutlineFlatSkip = state.OutlineFlatSkip or 0.9
	WriteOutlines()

	if CompileFile then
		Editor.WriteChests()
	end

	-- Dynamic:
	profile "UpdateDynamicStuff"
	Editor.UpdateDynamicStuff()
	
	Editor.CheckDoorsUpdate()

	if CompileFile then
		Editor.CompileBlv(CompileFile)
		Editor.WriteListIds()
	end
	
	-- Prepare for editing
	profile "Prepare for editing"
	Editor.SetStateLoaded()
	for f in pairs(DeanimateFacets) do
		f.AnimatedTFT = false
	end
	for _, a in Map.Sprites do
		a.Event = 666  -- set Event to make sprites clickable
	end
	for _, a in Map.Monsters do
		a.AIState = 0
	end
	for _, o in Map.Outlines do
		o.Visible = true
	end
	InitRoomEntityList("Sprites")
	InitRoomEntityList("Lights")
	profile(nil)
	-- return standard struct behavior
	Editor.RemoveListSpeedup(Map.Vertexes)
	Editor.RemoveListSpeedup(Map.Facets)
	Editor.RemoveListSpeedup(Map.FacetData)
	Editor.RemoveListSpeedup(Map.Rooms)
	Editor.ModelMode = false
	
	if Map.Facets.Count > (FacetRefsLimit or 0x2000) and not Editor.LastError then
		Editor.LastError = ("too many facets (%d/%d)"):format(Map.Facets.Count, FacetRefsLimit or 0x2000)
		Editor.LastErrorFacets = {}
	end
	Editor.MapUpdated()
end

-----------------------------------------------------
-- Compile Blv & Dlv
-----------------------------------------------------

function Editor.CompileBlv(fname)
	local data = {}
	
	local function writenum(num, n)
		for i = 1, n or 4 do
			data[#data + 1] = string.char(num % 256)
			num = num:div(256)
		end
	end

	local function write(p, size)
		if not size then
			size = p.size or p["?size"]
			p = p["?ptr"]
		end
		data[#data + 1] = mem.string(p, size, true)
	end

	local function awrite(a)
		writenum(a.count)
		write(a)
	end
	
	-- Blv
	local bin = Editor.BinInfo
	local hdr = Map.IndoorHeader
	mem.fill(hdr)
	hdr.FacetDataSize = bin.HdrFacetsSize
	hdr.RoomDataSize = bin.HdrRoomsSize
	hdr.RoomLightDataSize = bin.RoomsSize - bin.HdrRoomsSize
	hdr.DoorDataSize = bin.DoorsSize
	
	write(hdr)
	awrite(Map.Vertexes)
	awrite(Map.Facets)
	write(bin.FacetsBuf, bin.FacetsSize)
	awrite(Map.FacetData)
	write(bin.FacetDataBuf, bin.FacetDataSize)
	awrite(Map.Rooms)
	write(bin.RoomsBuf, bin.RoomsSize)
	writenum(Map.Doors.Count)
	awrite(Map.Sprites)
	write(bin.SpritesBuf, bin.SpritesSize)
	awrite(Map.Lights)
	awrite(Map.BSPNodes)
	awrite(Map.IndoorSpawns)
	awrite(Map.Outlines.Items)
	
	io.SaveString(fname, table.concat(data))

	-- Dlv
	data = {}
	writenum(0, mmv(8, 40, 40))  -- header
	writenum(0, 875)  -- visible outlines
	if mmver > 6 then
		for _, a in Map.Facets do
			writenum(a.Bits)
		end
		for _, a in Map.Sprites do
			writenum(a.Bits, 2)
		end
	end
	awrite(Map.Monsters)
	awrite(Map.Objects)
	awrite(Map.Chests)
	
	local n = Map.Doors.Count
	Map.Doors.Count = 200
	write(Map.Doors)
	Map.Doors.Count = n
	write(bin.DoorsBuf, bin.DoorsSize)
	
	writenum(0, 200)  -- Map.Vars
	writenum(0, 56)  -- other map props
	if mmver == 8 then
		writenum(0, 30604)  -- notes
	end
	
	io.SaveString(path.setext(fname, ".dlv"), table.concat(data))
end
