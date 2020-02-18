local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local mmver = offsets.MMVersion

Editor = Editor or {}
local _KNOWNGLOBALS

local function boolcopy(t)
	local t1 = {}
	for k in pairs(t) do
		t1[k] = true
	end
	return t1
end

local state
local ModelByXYZ

-----------------------------------------------------
-- ReadFacets
-----------------------------------------------------

local function ReadFacets(m, base, ids, vert)
	-- local x, y, z = XYZ(m)
	local oc = Editor.OutdoorUVCorrection
	local x, y, z = oc, oc, oc
	
	for i, a in m.Facets do
		a["?ptr"] = a["?ptr"]  -- speed up
		local t = Editor.ReadFacet(a, nil, vert)
		if t then
			if Editor.ImportIndex then
				Editor.ImportIndex[t] = base*1000/64 + i
				Editor.ImportBin[t] = mem.string(a["?ptr"], a["?size"], true)
			end
			-- change bitmap coordinates
			local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(a)
			t.BitmapU = (t.BitmapU or 0) + ux*x + uy*y + uz*z
			t.BitmapV = (t.BitmapV or 0) + vx*x + vy*y + vz*z
			Editor.FacetIds[t] = base + i
			ids[t] = i
			Editor.Facets[base + i + 1] = t
			-- check U, V align properties
			if t.AlignLeft or t.AlignRight then
				local u = a.BitmapU
				Editor.UpdateBitmapU(t)
				if u ~= a.BitmapU then
					a.BitmapU = u
					t.AlignLeft, t.AlignRight = nil, nil
				end
			end
			if t.AlignTop or t.AlignBottom then
				local v = a.BitmapV
				Editor.UpdateBitmapV(t)
				if v ~= a.BitmapV then
					a.BitmapV = v
					t.AlignTop, t.AlignBottom = nil, nil
				end
			end
		end
		a["?ptr"] = nil
	end
	return ids
end

-----------------------------------------------------
-- ReadModel
-----------------------------------------------------

local function CheckSimilarNames(s1, s2, k)
	if not k then
		local k = 1
		while s1:byte(k) == s2:byte(k) and s1:byte(k, k) do
			k = k + 1
		end
		return s1:sub(k + 1) == s2:sub(k + 1) and k
	elseif s1:sub(1, k - 1) == s2:sub(1, k - 1) and s1:sub(k + 1) == s2:sub(k + 1) then
		return k
	end
end

local function ReadModel(a, t, mid)
	a["?ptr"] = a["?ptr"]  -- speed up
	-- if a.Name ~= a.Name2 then
		-- print(a.Name, a.Name2)
	-- end
	t.Name = a.Name
	t.ObjName = a.Name2
	-- Editor.AddModelUseUniqueName(t, state)

	XYZ(t, XYZ(a))

	local vert = {}
	for i, v in a.Vertexes do
		vert[i] = {X = v.X, Y = v.Y, Z = v.Z}
	end
	
	t.Facets = ReadFacets(a, mid*64, {}, vert)
	
	-- detect parts of a single model:
	-- 1) they have the same coordinates
	-- 2) their names tipically differ by 1 letter, either '1','2',... or 'A','B',...
	local xz = t.X % 0x20000 + 0x20000*(t.Y % 0x20000 + 0x20000 * (t.Z % 0x20000))
	-- (max double stored precisely: 32*0x10000*0x10000*0x10000 - 1)
	for i = 1, 1/0 do
		local mm = ModelByXYZ[i] or {}
		ModelByXYZ[i] = mm
		local m = mm[xz]
		local k = m and CheckSimilarNames(m.ObjName, t.ObjName, m.IndexChar)
		if k and CheckSimilarNames(m.Name, t.Name, k) then
			if not m.IndexChar then  -- actual model from the map is there, create an accumulative model
				local t0 = {Name = m.Name, ObjName = m.ObjName, Facets = table.copy(m.Facets), IndexChar = k}
				t0.BaseFacets = t0.Facets
				XYZ(t0, XYZ(m))
				m.BaseFacets = nil
				t0.PartOf, m.PartOf = t0, t0
				m, mm[xz] = t0, t0
			end
			table.copy(t.Facets, m.Facets, true)
			t.PartOf = m
			break
		elseif not m then
			mm[xz] = t
			t.PartOf = t
			t.BaseFacets = t.Facets
			break
		end
	end
	
	local m = ModelByXYZ[xz]
	
	a["?ptr"] = nil
	return t
end

function Editor.AddModelUseUniqueName(t, state)
	state = state or Editor.State
	if not state.ModelByName[t.Name] and t.Name and t.Name ~= "_Ground_" then
		--
	elseif not state.ModelByName[t.ObjName] and t.ObjName and t.ObjName ~= "_Ground_" then
		t.Name = t.ObjName
	else
		t.ObjName = t.ObjName or t.Name
		for i = 1, math.huge do
			t.Name = t.ObjName.."_"..i
			if not state.ModelByName[t.Name] then
				break
			end
		end
	end
	state.ModelByName[t.Name] = t
end

local function ProcessModelByName()
	for _, mm in ipairs(ModelByXYZ) do
		for _, t in pairs(mm) do
			local k = t.IndexChar
			if k then
				t.Name = t.Name:sub(1, k - 1)..t.Name:sub(k + 1)
				t.ObjName = t.ObjName:sub(1, k - 1)..t.ObjName:sub(k + 1)
				t.IndexChar = nil
			end
			Editor.AddModelUseUniqueName(t, state)
		end
	end
end

-----------------------------------------------------
-- Editor.ReadSquares
-----------------------------------------------------

function Editor.ReadSquares(state)
	state = state or Editor.State
	state.HeightMap = mem.string(Map.HeightMap["?ptr"], Map.HeightMap["?size"], true)
	state.TileMap = mem.string(Map.TileMap["?ptr"], Map.TileMap["?size"], true)
end

-----------------------------------------------------
-- ReadHeader
-----------------------------------------------------

local function ReadHeader(state)
	state.Header = {
		TilesetsFile = (mmver == 8 and Map.TilesetsFile or nil),
		Tilesets = {},
		-- SkyBitmap = Map.OutdoorExtra.SkyBitmap,
		Ceiling = Map.OutdoorExtra.Ceiling,
		MinimapName = path.setext(Map.Name, ""),
	}
	for k in pairs(Editor.OdmBits) do
		state.Header[k] = Map.OutdoorExtra[k]
	end
	for i = 0, 3 do
		state.Header.Tilesets[i] = Map.Tilesets[i].Group
	end
end

-----------------------------------------------------
-- Editor.ReadOdm
-----------------------------------------------------

function Editor.ReadOdm()
	if Map.IsIndoor() then
		return
	end
	
	Editor.profile "ReadOdm"
	Editor.ImportIndex = Editor.ImportIndex and setmetatable({}, {__mode = "k"})
	Editor.ImportBin = Editor.ImportIndex and setmetatable({}, {__mode = "k"})
	state = {BaseInternalMap = Map.Name, ModelByName = {}}
	ReadHeader(state)
	Editor.Facets, Editor.FacetIds = {}, {}
	-- models
	ModelByXYZ = {}
	Editor.Models, Editor.ModelIds = Editor.ReadListEx({}, {}, Map.Models, ReadModel, true)
	state.Models = table.copy(Editor.ModelIds)
	ProcessModelByName()
	-- squares
	Editor.ReadSquares(state)
	-- other properties
	Editor.ReadMapCommon(state)
	
	Editor.SetState(state)
	
	Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(Map.Name, '.odt')
	Editor.profile(nil)
end
