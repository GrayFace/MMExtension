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

local function normalize(x, y, z)
	local n = inorm(x, y, z)
	return x*n, y*n, z*n
end

local function new(a, count)
	mem.freeMM(a["?ptr"])
	a.count = count
	rawset(a, "?ptr", nil)
	a["?ptr"] = mem.allocMM(a.size)
	mem.fill(a["?ptr"], a.size, 0)
end

local state
local Facets
local FacetIds
local DeanimateFacets


local CopyFacetDataProps = {
	-- !!! TFTBitmap
	Id = true,
	Event = true,
}

-----------------------------------------------------
-- WriteVertex
-----------------------------------------------------

local function WriteVertex(a, v)
	a.X = round(v.X)
	a.Y = round(v.Y)
	a.Z = round(v.Z)
end

-----------------------------------------------------
-- WriteFacetData
-----------------------------------------------------

local function WriteFacetData(f, t)
	for k in pairs(CopyFacetDataProps) do
		f[k] = t[k] or 0
	end
	if t.ImportVertex then
		if f.BitmapId < 0 then
			return
		end
		local b = Game.BitmapsLod.Bitmaps[f.BitmapId]
		local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(f)
		local vertX, vertY, vertZ = t.ImportVertex.X, t.ImportVertex.Y, t.ImportVertex.Z
		local facetId = FacetIds[t]
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
-- WriteFacet
-----------------------------------------------------

Editor.OutdoorUVCorrection = mmv(0, 4, 4)  -- need to add 4 to X,Y,Z when calculating UV outside in MM7 and MM8

local function UpdateFacetMinMax(a, t)
	local v = t.Vertexes
	local door = t.Door or {}
	-- BBox
	local function minmax(coord)
		local m1, m2 = v[1][coord], v[1][coord]
		for i = 2, #v do
			m1 = min(m1, v[i][coord])
			m2 = max(m2, v[i][coord])
		end
		a["Min"..coord] = round(m1) - 5
		a["Max"..coord] = round(m2) + 5
	end
	minmax("X")
	minmax("Y")
	minmax("Z")
end

local function WriteFacet(a, t, m, VertexIds)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	local v = t.Vertexes
	
	-- vertexes
	local n = #v
	assert(n <= 20, "facet with over 20 vertices found")
	a.VertexesCount = n
	for i = 1, n do
		a.VertexIds[i - 1] = VertexIds[v[i]]
	end
	
	-- normal
	do
		local v = v[1]
		t.ndist = -(v.X*t.nx + v.Y*t.ny + v.Z*t.nz)
	end
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
	if mmver == 6 then
		a.IsSky = t.ScrollDown
	end
	
	-- U, V
	local oc = Editor.OutdoorUVCorrection
	Editor.WriteUV(a, v, oc, oc, oc)
	
	-- InterceptDisplacement
	Editor.WriteInterceptDisplacement(a, v)

	-- GradientVertexes
	if #v > 2 then
		--a.GradientVertexes[0] = 0
		local x0, y0 = round(v[1].X), round(v[1].Y)
		local ax, ay, d0
		for i = 2, #v - 1 do
			a.GradientVertexes[1] = i - 1
			ax, ay = round(v[i].X) - x0, round(v[i].Y) - y0
			d0 = ax*ax + ay*ay
			if d0 ~= 0 then
				break
			end
		end
		d0 = 1/d0
		for i = 3, #v do
			a.GradientVertexes[2] = i - 1
			local bx, by = round(v[i].X) - x0, round(v[i].Y) - y0
			local d1 = 1/(bx*bx + by*by)
			local mul = ax*bx + ay*by
			if mul*mul*d0*d1 < 0.95 then  -- if colinear, abs((a, b)) = |a|*|b|
				break
			end
		end
	end
	
	-- duplicate the first vertex at the end
	if n < 20 then
		a.VertexIds[n] = a.VertexIds[0]
		a.UList[n] = a.UList[0]
		a.VList[n] = a.VList[0]
		a.XInterceptDisplacement[n] = a.XInterceptDisplacement[0]
		a.YInterceptDisplacement[n] = a.YInterceptDisplacement[0]
		a.ZInterceptDisplacement[n] = a.ZInterceptDisplacement[0]
	end
	
	UpdateFacetMinMax(a, t)

	-- other
	WriteFacetData(a, t)
end

-----------------------------------------------------
-- WriteModel
-----------------------------------------------------

local function WriteModel(a, t, mid, update)
	rawset(a, "?ptr", nil)
	a["?ptr"] = a["?ptr"]  -- speed up
	-- lists
	local Vertexes, VertexIds, fn, vn = {}, {}, 0, 0
	Facets.n = mid*64
	for f, i in pairs(t.Facets) do
		if not update then
			Editor.AddToList(Facets, FacetIds, f, type(i) == "number" and mid*64 + i)
		end
		fn = fn + 1
		for _, v in ipairs(f.Vertexes) do
			if not VertexIds[v] then
				VertexIds[v], vn = vn, vn + 1
				Vertexes[vn] = v
			end
		end
	end
	assert(fn <= 64, "model has too many facets")
	Editor.FinalizeList(Facets, FacetIds)
	
	-- vertices
	new(a.Vertexes, vn)
	for i, v in ipairs(Vertexes) do
		WriteVertex(a.Vertexes[i - 1], v)
	end
	
	-- facets
	new(a.Facets, fn)
	new(a.Ordering, fn)
	for i = 1, fn do
		WriteFacet(a.Facets[i - 1], Facets[mid*64 + i], t, VertexIds)
	end
	
	-- BBox
	local function box(name, f, m)
		for _, b in a.Facets do
			m = f(m, b[name])
		end
		a[name] = m
	end
	local function fbox(X)
		box("Min"..X, min, 30000)
		box("Max"..X, max, -30000)
		local v = (a["Min"..X] + a["Max"..X])/2
		a["BoxCenter"..X] = v
		a[X] = v
	end
	fbox "X"
	fbox "Y"
	fbox "Z"
	
	local x, y, z, m = a.X, a.Y, a.Z, 0
	for _, v in a.Vertexes do
		m = max(m, mem.call(mmv(0x445420, 0x462217, 0x46003B), 2, abs(v.X - x), abs(v.Y - y), abs(v.Z - z)))
	end
	a.BoundingRadius = m
	
	-- other
	t = t.PartOf
	a.Name = t.Name
	a.Name2 = t.ObjName or t.Name
	
	Editor.RemoveListSpeedup(a.Facets)
	a["?ptr"] = nil
end

-----------------------------------------------------
-- Editor.CreateModels
-----------------------------------------------------

function Editor.CreateModels(models)
	Facets = Editor.Facets
	FacetIds = Editor.FacetIds
	DeanimateFacets = {}
	local t = next(models)
	local ret
	local n = Map.Models.Count
	for i = 0, Editor.ModelLimit - 1 do
		if i >= n or not Editor.Models[i + 1].PartOf then
			if i >= n then
				Map.Models.Count = i + 1
			end
			Editor.Models[i + 1] = t
			Editor.ModelIds[t] = i
			ret = i
			WriteModel(Map.Models[i], t, i)
			t = next(models, t)
			if not t then
				break
			end
		end
	end
	if t then
		local i = 0
		repeat
			i = i + 1
			t = next(models, t)
		until not t
		Editor.LastError = ("%d models limit reached, failed to add a new model (limit exceeded by %d)"):format(Editor.ModelLimit, i)
		Editor.LastErrorFacets = {}
	end
	for f in pairs(DeanimateFacets) do
		f.AnimatedTFT = false
	end
	return ret
end

-----------------------------------------------------
-- WriteSquares
-----------------------------------------------------

-- z = z' * 32/0x200 = z' / 16
-- (0, 0, a)   (1, 0, b)
--             (1, -1, c)
-- (1, 0, b - a) x (0, 1, b - c) = (a - b, c - b, 1)    =>  (a' - b', c' - b', 16)
-- 
-- (0, 0, a)   
-- (0, -1, d)   (1, -1, c)
-- (1, 0, c - d) x (0, 1, a - d) = (d - c, d - a, 1)

local function WriteSquareNormal(x, y, z, i, f, ...)
	local nx, ny, nz = normalize(...)
	local X, Y, Z = (x - 64)*0x200, (65 - y)*0x200, z*32
	Map.TerNormDist[x][y][i] = -(X*nx + Y*ny + Z*nz)
	f(x, y, i, nx, ny, nz)
end

local function WriteSingleSquareNormals(x, y, f)
	local hm = Map.HeightMap
	local a = hm[y-1][x]
	local b = hm[y-1][x+1]
	local c = hm[y][x+1]
	local d = hm[y][x]
	WriteSquareNormal(x, y, a, 0, f,  a - b, c - b, 16)
	WriteSquareNormal(x, y, a, 1, f,  d - c, d - a, 16)
end

function Editor.UpdateNormals(x, y)
	local function SetNorm(x, y, i, ...)
		local a = Map.TerNorm[Map.TerNormId[x][y][i]]
		a.X, a.Y, a.Z = ...
	end
	if x < 127 and y > 0 and mmver > 6 then
		WriteSingleSquareNormals(x, y, SetNorm)
	end
end

local function WriteSquareNormals(compile)
	if mmver == 6 then
		return
	end
	-- normal refs
	local norm = {{}}
	
	local function AddNorm(x, y, i, ...)
		local t = {...}
		local n = 0
		if not compile or t[1] ~= 0 or t[2] ~= 0 or t[3] ~= 0 then
			n = #norm
			norm[n + 1] = t
		end
		Map.TerNormId[x][y][i] = n
	end
	
	mem.fill(Map.TerNormId)
	mem.fill(Map.TerNormDist)
	for y = 1, 127 do
		for x = 0, 126 do
			WriteSingleSquareNormals(x, y, AddNorm)
		end
	end
	
	-- normals list
	new(Map.TerNorm, #norm)
	for i, a in Map.TerNorm do
		table.copy(norm[i + 1], a, true)
	end
end

local function WriteSquares(compile)
	local state = Editor.State
	if state.HeightMap then
		mem.copy(Map.HeightMap["?ptr"], Editor.State.HeightMap, #Editor.State.HeightMap)
	else
		mem.fill(Map.HeightMap)
		state.HeightMap = mem.string(Map.HeightMap["?ptr"], Map.HeightMap["?size"], true)
	end
	
	if state.TileMap then
		mem.copy(Map.TileMap["?ptr"], Editor.State.TileMap, #Editor.State.TileMap)
	else
		mem.fill(Map.TileMap, nil, 1)
		state.TileMap = mem.string(Map.TileMap["?ptr"], Map.TileMap["?size"], true)
	end
	
	mem.fill(Map.UnknownMap)
	if mmver == 8 then
		mem.fill(Map.UnknownMap2)
	end
	WriteSquareNormals(compile)
end

-----------------------------------------------------
-- UpdateOutdoorHeader
-----------------------------------------------------

local DefSets = {[0] = 0, 5, 1, 10}
local TilesetFiles = {0x6F2FC4, 0x6F2FBC}

Editor.OdmBits = {
	Foggy = true,
	RedFog = true,
	NoTerrain = true,
	AlwaysDark = true,
	AlwaysLight = true,
	AlwaysFoggy = true,
}

local function UpdateOutdoorExtra()
	local h = Editor.State.Header
	local a = Map.OutdoorExtra
	mem.fill(a)
	-- h.SkyBitmap = h.SkyBitmap or "plansky3"
	-- Map.OutdoorExtra.SkyBitmap = h.SkyBitmap
	a.Ceiling = mmver == 8 and (h.Ceiling or 4000) or nil
	for k in pairs(Editor.OdmBits) do
		a[k] = h[k]
	end
	Game.Weather.SetFog(h.Foggy and (h.FogRange1 or 0), h.Foggy and h.FogRange2 or 4096)
end

function Editor.UpdateOutdoorHeader()
	local h = Editor.State.Header
	mem.fill(Map.OutdoorHeader)
	UpdateOutdoorExtra()
	if mmver == 6 then
		Map.OutdoorHeader.VersionStr = "MM6 Outdoor v1.11"
	end
	if mmver == 8 then
		h.TilesetsFile = h.TilesetsFile or 0
		Map.TilesetsFile = h.TilesetsFile
		Game.CurrentTileBin["?ptr"] = TilesetFiles[Map.TilesetsFile] or 0x6F2FCC
	end
	h.Tilesets = h.Tilesets or {}
	for i = 0, 3 do
		h.Tilesets[i] = h.Tilesets[i] or DefSets[i]
		Map.Tilesets[i].Group = h.Tilesets[i]
		Map.LoadTileset(h.Tilesets[i])
	end
	Map.LoadTileset(4)
	Editor.TilesetsChanged()
	h.MinimapName = h.MinimapName or "Editor Map"
	local p = Game.IconsLod:LoadBitmap(h.MinimapName)
	if p ~= 0 then
		i4[mmv(0x52D298, 0x576EA8, 0x587AD8)] = p
	end
end

-----------------------------------------------------
-- Write All
-----------------------------------------------------

local function PrepareLists()
	Editor.CheckLazyModels()
	state.Header = state.Header or {}
	-- facets
	DeanimateFacets = {}
	Facets = {}
	FacetIds = {}
	Editor.Facets = Facets
	Editor.FacetIds = FacetIds
	Editor.ImportBitmapU = {}
	Editor.ImportBitmapV = {}
	-- models
	state.ModelByName = state.ModelByName or {}
	state.Models = state.Models or {}
	Editor.ModelIds = {}
	Editor.Models = {}
	for a, id in pairs(state.Models) do
		Editor.AddToList(Editor.Models, Editor.ModelIds, a, id)
	end
	Editor.FinalizeList(Editor.Models, Editor.ModelIds)
	-- sprites
	Editor.Sprites = {}
	Editor.SpriteIds = {}
	state.Sprites = state.Sprites or {}
	for a, id in pairs(state.Sprites) do
		Editor.AddToList(Editor.Sprites, Editor.SpriteIds, a, id)
	end
	Editor.FinalizeList(Editor.Sprites, Editor.SpriteIds)
	-- other
	Editor.Lights, Editor.LightIds = {}, {}
end

function Editor.UpdateOdm(CompileFile)
	state = Editor.State
	if state.Rooms then
		return
	end
	local profile = Editor.profile
	profile "PrepareLists"
	PrepareLists()

	profile "UpdateOutdoorHeader"
	Editor.UpdateOutdoorHeader()
	-- models
	profile "Models"
	for i, a in Map.Models do
		mem.freeMM(a.Vertexes["?ptr"])
		mem.freeMM(a.Facets["?ptr"])
		mem.freeMM(a.Ordering["?ptr"])
		mem.freeMM(a.BSPNodes["?ptr"])
	end
	Editor.ModelLimit = max(#Editor.Models, (FacetRefsLimit or 0x2000) / 64)
	new(Map.Models, Editor.ModelLimit)
	Map.Models.Count = #Editor.Models
	for i, a in ipairs(Editor.Models) do
		WriteModel(Map.Models[i - 1], a, i - 1)
	end
	
	-- ground
	profile "Ground"
	WriteSquares(CompileFile)

	-- other
	profile "Other"
	Editor.WriteSpawns()
	Editor.WriteSprites()
	
	if CompileFile then
		RebildIDList()
		Editor.WriteChests()
	end

	-- Dynamic:
	profile "Dynamic"
	Editor.UpdateDynamicStuff()
	
	if CompileFile then
		Editor.CompileOdm(CompileFile)
		WriteSquareNormals()
		Editor.WriteListIds()
	end
	mem.fill(Map.IDOffsets)
	new(Map.IDList, 0)
	
	-- Prepare for editing
	profile "Prepare for editing"
	Editor.SetStateLoaded()
	for f in pairs(DeanimateFacets) do
		f.AnimatedTFT = false
	end
	for _, a in Map.Sprites do
		a.Event = 666  -- set Event to make sprites clickable
	end
	if Map.Models.Count*64 > (FacetRefsLimit or 0x2000) and not Editor.LastError then
		Editor.LastError = ("too many models (%d/%d)"):format(Map.Models.Count, (FacetRefsLimit or 0x2000)/64)
		Editor.LastErrorFacets = {}
	end
	mem.fill(Map.VisibleMap1, nil, 0xFF)
	mem.fill(Map.VisibleMap2, nil, 0xFF)
	if mmver == 8 then
		mem.fill(Map.Notes, 30604)
	end
	Editor.MapUpdated()
	profile(nil)
end

-----------------------------------------------------
-- Compile Blv & Dlv
-----------------------------------------------------

function Editor.CompileOdm(fname)
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
	
	-- Odm
	local bin = Editor.BinInfo
	-- mem.fill(hdr)
	-- hdr.TilesetsFile = state.TilesetsFile
	-- hdr.GroundBitmap = "grastyl"
	-- for i = 1, 4 do
		-- hdr.Tilesets[i-1].Group = state.Tilesets[i] or 0
	-- end
	
	
	write(Map.OutdoorHeader)
	write(Map.HeightMap)
	write(Map.TileMap)
	write(Map.UnknownMap)
	if mmver >= 7 then
		writenum(Map.TerNorm.Count)
		write(Map.TerNormDist)
		write(Map.TerNormId)
		write(Map.TerNorm)
	end
	
	awrite(Map.Models)
	for mid, a in Map.Models do
		write(a.Vertexes)
		write(a.Facets)
		write(a.Ordering)
		write(a.BSPNodes)
		-- write textures of facets
		for i = 1, a.Facets.Count do
			local s = Editor.GetFacetBitmap(Editor.Facets[mid*64 + i] or {}, a.Facets[i - 1])
			data[#data + 1] = s:sub(1, 10)
			writenum(0, 10 - #s)
		end
	end

	awrite(Map.Sprites)
	write(bin.SpritesBuf, bin.SpritesSize)
	awrite(Map.IDList)
	write(Map.IDOffsets)
	awrite(Map.OutdoorSpawns)
	
	io.SaveString(fname, table.concat(data))

	-- Ddm
	data = {}
	writenum(0, mmv(8, 40, 40))  -- header
	writenum(0, 968*2)  -- visible map
	if mmver > 6 then
		for _, m in Map.Models do
			for _, a in m.Facets do
				writenum(a.Bits)
			end
		end
		for _, a in Map.Sprites do
			writenum(a.Bits, 2)
		end
	end
	awrite(Map.Monsters)
	awrite(Map.Objects)
	awrite(Map.Chests)
	
	writenum(0, 200)  -- Map.Vars
	UpdateOutdoorExtra()
	write(Map.OutdoorExtra)  -- other map props
	if mmver == 8 then
		writenum(0, 30604)  -- notes
	end

	io.SaveString(path.setext(fname, ".ddm"), table.concat(data))
end
