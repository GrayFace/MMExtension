--[[
To disable 90 degree rotation that makes Y axis the vertical one in .obj file,
put this code into a separate file (to avoid any problems upgrading MMEditor):
 Editor = Editor or {}
 Editor.NoExportRotation = true
Most 3D editors default to doing the rotation, so I do it by default as well
]]--

Editor = Editor or {}
local _KNOWNGLOBALS
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local MessageBox = MessageBox or Message
local insert = table.insert

-----------------------------------------------------
-- LoadMtl
-----------------------------------------------------

local function LoadMtl(file, t, inv)
	local ok, f = pcall(io.LoadString, file)
	if ok then
		local name
		for line in f:gmatch("[^\r\n]+") do
			local s, arg = line:match("^%s*([^%s]+)%s+(.*)")
			if s == "newmtl" then
				name = arg
			elseif s == "map_Ka" or s == "map_Kd" then
				-- parse out params (http://paulbourke.net/dataformats/mtl/)
				arg = arg:match("^%-s%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+(.*)") or arg
				arg = arg:match("^%-o%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+(.*)") or arg
				arg = arg:match("^%-mm%s+[^%s]+%s+[^%s]+%s+(.*)") or arg
				t[name] = path.setext(path.name(arg), "")
			elseif s == "d" or s == "Tr" then
				inv[name] = (inv[name] or inv[name] == nil) and (tonumber(arg) < 1)
			end
		end
	end
	return t
end

-----------------------------------------------------
-- ParseObj
-----------------------------------------------------

local ParseVerts
-- local ParseLine

local function ParseObjString(str)
	local t = {}
	local t1 = {}
	for s, s1 in str:gmatch(" ([^%s/]+)/?([^%s/]*)") do
		t[#t + 1] = assert(tonumber(s))
		t1[#t1 + 1] = tonumber(s1) or 0
	end
	return t, t1
end

local function ParseObj(file, AddVertex, AddFacet, NewObject)
	local scale = (Editor.ImportScale or 1)
	local mtl = {}
	local mtlInv = {}
	--local mtl = LoadMtl(path.setext(file, ".mtl"), {})
	local verts = {}
	ParseVerts = verts
	local vt = {}
	local texture, invis
	for line in io.LoadString(file):gmatch("[^\r\n]+") do
		assert(line:sub(-1) ~= "\\", "\\ at the end of the line isn't supported")
		-- ParseLine = line
		local s = line:match("^([^%s]+)")
		assert(s ~= "call", "call statements aren't supported")
		if s == "mtllib" then
			LoadMtl(path.dir(file)..line:match("%s([^%s].*)"), mtl, mtlInv)
		elseif s == "usemtl" then
			local s = line:match("%s([^%s]+)")
			texture = mtl[s]
			invis = mtlInv[s]
			if not texture then
				texture, invis = events.EditorImportMissingTexture(s)
			end
		elseif s == "v" then
			local t = ParseObjString(line)
			if not Editor.NoExportRotation then
				t[3], t[2] = t[2], -t[3]
			end
			t[1], t[2], t[3] = t[1]*scale, t[2]*scale, t[3]*scale
			t = AddVertex and AddVertex(t) or t
			verts[#verts + 1] = t
		elseif s == "vt" then
			vt[#vt + 1] = ParseObjString(line)
		-- Object
		elseif s == "g" or s == "o" then
			if NewObject then
				NewObject(line:match("%s([^%s]+)"))
			end
		-- Facet
		elseif s == "f" then --and(not texture or texture ~= "_Portal_") then
			local t, t1 = ParseObjString(line)
			for i = 1, #t do
				t[i] = verts[t[i] % (#verts + 1)]
				assert(t[i], ("vertex index out of bounds (%s): %s"):format(#verts, line))
			end
			local a = t1[1] and vt[t1[1] % (#vt + 1)] or {}
			if AddFacet then
				AddFacet(t, texture, invis, a[1], a[2] and 1 - a[2])
			end
		end
	end
end


-----------------------------------------------------

local state
local UniqueVertex, UniqueFacet
-- local NewVertexes, OldVertexes
local NewFacets, OldFacets

-----------------------------------------------------
-- AddVertex
-----------------------------------------------------

local function AddVertex(t)
	local v, new = UniqueVertex(unpack(t)) --math.round(x), math.round(y), math.round(z))
	-- if new then
		-- NewVertexes[v] = true
	-- else
		-- OldVertexes[v] = true
	-- end
	return v
end

-----------------------------------------------------
-- AddFacet
-----------------------------------------------------

local function AddFacet(t)
	-- remove duplicated vertices
	for i = #t, 2, -1 do
		while t[i] == t[i - 1] do
			table.remove(t, i)
		end
	end
	while t[1] == t[#t] and #t > 1 do
		t[#t] = nil
	end

	--CheckConvex(t)
	local a, new = UniqueFacet(t)
	if new then
		a.PartOf = a
		if Editor.FindNormal(a, true) then  -- !!! tmp? ignore bad facets
			return --a
		end
		NewFacets[a] = true
	else
		OldFacets[a] = true
	end
	return a, new
end

-----------------------------------------------------
-- LoadBlvObj
-----------------------------------------------------

local function LoadBlvObj(file, AsObjects)
	UniqueVertex, UniqueFacet = Editor.AddUnique(state)
	-- NewVertexes, OldVertexes = {}, {}
	NewFacets, OldFacets = {}, {}
	local OldRoomObj = state.RoomObj or {}
	state.RoomObj = {}
	local obj
	local ObjName
	
	ParseObj(file, AddVertex, 
		-- Facet
		function(t, texture, invis, u, v)
			local t, new = AddFacet(t)
			if not t then
				return
			end
			t.IsPortal = texture and texture == "_Portal_"
			if t.IsPortal and t.nx then
				-- Editor.ConvexifyPortal(t)
				t.Bent = false
				--t.Cancave = false
				-- assert(not t.Cancave, "cancave portal found: "..line)
			elseif texture and texture == "_Invisible_" then
				t.Invisible = true
				t.Bitmap = nil
			elseif texture and not t.IsPortal and (new or t.Bitmap ~= texture) then
				t.Invisible = invis
				t.Bitmap = texture
			end
			if u and v then
				t.ImportVertex, t.ImportU, t.ImportV = t.Vertexes[1], u % 1, v % 1
			end
			if AsObjects then
				t.ObjectName = ObjName
			end
			obj = obj or AsObjects and {}
			if not obj then
				local o = OldRoomObj.DefaultRoom or {}
				state.RoomObj.DefaultRoom = o
				obj = {}
				o.BaseFacets = obj
				--assert(obj, "facets aren't assigned to an object (via \"g\" command in .obj file)")
			end
			if t.nx then
				obj[t] = true
			end
		end,
		-- Object
		function(s)
			ObjName = s
			if not AsObjects then
				local o = OldRoomObj[ObjName] or {}
				state.RoomObj[ObjName] = o
				obj = {}
				o.BaseFacets = obj
			end
		end
	)
	
	if AsObjects then
		if next(NewFacets) then
			local o = OldRoomObj.DefaultRoom or {}
			if not o.BaseFacets and next(OldRoomObj) then
				local o1 = next(OldRoomObj)
				o.Darkness = o1.Darkness
				o.EaxEnvironment = o1.EaxEnvironment
			end
			o.BaseFacets = obj
			state.RoomObj.DefaultRoom = o
		else
			state.RoomObj = OldRoomObj
			for name, o in pairs(OldRoomObj) do
				for f in pairs(o.BaseFacets) do
					if not OldFacets[f] then
						o.BaseFacets[f] = nil
					end
				end
				if not next(o.BaseFacets) then
					OldRoomObj[name] = nil
				end
			end
		end
	end
end

-----------------------------------------------------
-- BuildRooms
-----------------------------------------------------

local VertexRoom1, VertexRoom2

-- Each room is a separate RoomObj
-- Portals belong to one room only, but they are recognized by "_Portal_" texture
-- BuildRooms copies portals to the other room after import
-- If no manual portals are present, any 2 rooms having common vertexes are connected with a portal

local function AutoPortal(r1, r2)
	local t = {}
	for v, r in pairs(VertexRoom2) do
		if r == r1 and VertexRoom1[v] == r2 or r == r2 and VertexRoom1[v] == r1 then
			t[#t+1] = v
		end
	end
	return Editor.ConvexHullFacet(t)
end

local function BuildRooms()
	local rooms = {{Facets = {}}}
	state.Rooms = rooms
	state.Outlines = nil  -- need to remake if they were loaded from game map
	
	-- add facets to rooms, fill portals and vertex rooms lists
	VertexRoom1, VertexRoom2 = {}, {}
	local portals, HasPortal = {}, {}
	for _, r in pairs(state.RoomObj) do
		rooms[#rooms + 1] = r
		local id = #rooms
		-- add facets
		r.Facets = {}
		r.BSP, r.DrawFacets, r.NonBSP = nil, nil, nil  -- !!! preserve, but check?
		for f in pairs(r.BaseFacets) do
			if f.Cancave and f.IsPortal then
				r.Facets[Editor.ConvexifyPortal(table.copy(f))] = true
			end
			if f.Cancave or f.Bent or #f.Vertexes > 50 and assert(not f.IsPortal, "portal with over 50 vertices found") then
				Editor.Triangulate(f, r.Facets)
			else
				r.Facets[f] = true
			end
			for _, v in ipairs(f.Vertexes) do
				if VertexRoom1[v] == nil then
					VertexRoom1[v] = id
				elseif VertexRoom1[v] ~= id then
					VertexRoom2[v] = id
				end
			end
		end
		-- add portals
		for f in pairs(r.Facets) do
			if f.IsPortal then
				portals[f] = true
			end
			f.Room, f.RoomBehind = nil
		end
	end
	
	-- add portals to their second room
	local function AddToRoom(rn, f)
		rooms[rn].Facets[f] = true
		HasPortal[rn] = true
	end
	for f in pairs(portals) do
		for _, v in ipairs(f.PartOf.Vertexes) do
			AddToRoom(VertexRoom1[v], f)
			AddToRoom(VertexRoom2[v] or VertexRoom1[v], f)
		end
	end

	-- build portals for rooms without them automatically
	for i = 1, #rooms do
		if not HasPortal[i] then
			for j = 1, #rooms do
				local f = (j > i or HasPortal[j]) and AutoPortal(i, j)
				if f then
					f.IsPortal = true
					f.Bent = false
					f.PartOf = f
					rooms[i].Facets[f] = true
					rooms[j].Facets[f] = true
				end
			end
		end
	end
end

-----------------------------------------------------
-- LoadOdmObj
-----------------------------------------------------

local GroundStr = "_Ground_"

local function LoadOdmObj(file)
	Editor.CheckLazyModels()
	UniqueVertex, UniqueFacet = Editor.AddUnique(state)
	-- NewVertexes, OldVertexes = {}, {}
	NewFacets, OldFacets = {}, {}
	local OldModels = state.ModelByName or {}
	local models = {}
	state.ModelByName = models
	local obj
	local ObjName
	local hm = {}
	
	local function WriteGround(t)
		-- local i = y*128 + x + 1
		-- (x - 64)*0x200, (64 - y)*0x200, hm:byte(i)*32
		for i = 1, #t do
			local v = t[i]
			if not obj[v] then
				obj[v] = true
				local x = 64 + (v.X/0x200):round()
				local y = 64 - (v.Y/0x200):round()
				local z = (v.Z/32):round()
				if z < 0 then
					z = 0
				elseif z > 255 then
					z = 255
				end
				-- if hm[y*128 + x + 1] then
				-- 	print(dump(v))
				-- end
				if x >= 0 and x < 128 and y >= 0 and y < 128 then
					hm[y*128 + x + 1] = string.char(z)
				end
			end
		end
	end
	
	ParseObj(file, AddVertex, 
		-- Facet
		function(t, texture, invis, u, v)
			if ObjName == GroundStr then
				return WriteGround(t)
			end
			t = AddFacet(t)
			if not t then
				return
			end
			if texture and texture == "_Invisible_" then
				t.Invisible = true
				t.Bitmap = nil
			elseif texture then
				t.Invisible = invis
				t.Bitmap = texture
			end
			if u and v then
				t.ImportVertex, t.ImportU, t.ImportV = t.Vertexes[1], u % 1, v % 1
			end
			assert(obj, ".obj file must be exported with groups/objects")
			if t.nx then
				obj[t] = true
			end
		end,
		-- Object
		function(s)
			ObjName = s
			obj = {}
			if s == GroundStr then
				return
			end
			UniqueVertex, UniqueFacet = Editor.AddUnique(state, OldModels[s])
			local model = OldModels[s] or {Name = s}
			model.BaseFacets = obj
			models[s] = model
			-- NewVertexes, OldVertexes = {}, {}
			NewFacets, OldFacets = {}, {}
			for i = 1, #ParseVerts do
				ParseVerts[i] = UniqueVertex(XYZ(ParseVerts[i]))
			end
		end
	)
	
	if next(hm) then
		-- allow map rotation - fix 1st row and 1st column of height map
		for i = 1, 128*128, 128 do
			hm[i] = hm[i] or hm[i+1]
		end
		for i = 1, 128 do
			hm[i] = hm[i] or hm[i+128]
		end
		-- allow broken height maps
		local last = 0
		for i = 1, 128*128 do
			if not hm[i] then
				hm[i] = last
				Editor.LastError = "Height map is invalid"
				Editor.LastErrorFacets = {}
			else
				last = hm[i]
			end
		end
		hm[128*128 + 1] = nil
		state.HeightMap = table.concat(hm)
	end
	
	local keep
	for n, m in pairs(OldModels) do
		if not models[n] then
			if keep == nil then
				keep = MessageBox("Would you like to delete models that aren't present in the imported file?", nil, "confirm") ~= 1
				if not keep then
					Editor.ExclusiveUndoState()
				end
			end
			if keep then
				models[n] = m
			else
				Editor.AddDeleteModelUndo(m, state)
			end
		end
	end
end

-----------------------------------------------------
-- BuildModels
-----------------------------------------------------

local function GetCoordLen(t, X)
	local m1, m2 = 1/0, -1/0
	for _, f in ipairs(t) do
		local v = f.Vertexes[1][X]
		if v < m1 then
			m1 = v
		end
		if v > m2 then
			m2 = v
		end
	end
	return m2 - m1
end

local CmpCoord, CmpGroup

local function FacetCmp(f1, f2)
	local d = f1.Vertexes[1][CmpCoord] - f2.Vertexes[1][CmpCoord]
	return d < 0 or d == 0 and tostring(f1) < tostring(f2)
end

local function FacetCmp2(f1, f2)
	local d = CmpGroup[f1] - CmpGroup[f2]
	d = (d ~= 0) and d or f1.Vertexes[1][CmpCoord] - f2.Vertexes[1][CmpCoord]
	return d < 0 or d == 0 and tostring(f1) < tostring(f2)
end

local function AddModel(models, r)
	-- add facets
	r.Facets = {}
	for f in pairs(r.BaseFacets) do
		if f.Cancave or f.Bent or #f.Vertexes > 19 then
			Editor.Triangulate(f, r.Facets)
		else
			r.Facets[f] = true
		end
	end
	-- add model
	r.PartOf = r
	local fac = {}
	for f in pairs(r.Facets) do
		fac[#fac + 1] = f
	end
	--print(r.Name, #fac)  -- tmp
	if #fac > 64 then
		-- break it into something like square blocks
		-- nx = lenX*?, ny = lenY*?
		-- nx * ny = n/64
		-- ? = (n/64/lenX/lenY)^0.5
		local lenX, lenY = GetCoordLen(fac, "X"), GetCoordLen(fac, "Y")
		local X, Y = "X", "Y"
		if lenX < lenY then
			X, Y, lenX, lenY = Y, X, lenY, lenX
		end
		local ny = ((#fac/64/lenX/lenY)^0.5*lenY):round()
		CmpCoord = X
		table.sort(fac, FacetCmp)
		if ny > 1 then
			CmpCoord = Y
			CmpGroup = {}
			for i = 1, #fac do
				CmpGroup[fac[i]] = (i - 1):div(64*ny)
			end
			table.sort(fac, FacetCmp2)
			for i = 1, #fac do
				assert(CmpGroup[fac[i]] == (i - 1):div(64*ny), CmpGroup[fac[i]].."  "..(i - 1):div(64*ny) )
			end
		end
		
		local t = {}
		for i = 1, #fac do
			t[fac[i]] = true
			if i == #fac or i % 64 == 0 then
				t = {PartOf = r, Facets = t}
				t.BaseFacets = nil
				models[t] = true
				t = {}
			end
		end
	elseif #fac > 0 then
		models[r] = true
	end
end

local function BuildModels()
	local models = {}
	state.Models = models
	
	for name, r in pairs(state.ModelByName) do
		if next(r.BaseFacets) then
			AddModel(models, r)
		else
			state.ModelByName[name] = nil
		end
	end
end

function Editor.PrepareModelTemplate(t, BaseName)
	local all = {}
	for o in pairs(t) do
		local models = {}
		AddModel(models, o)
		if next(models) then
			for X in XYZ do
				o[X] = o[X] or Editor.GetModelCoord(o, X)
				o["Lazy"..X] = o["Lazy"..X] or o[X]
			end
			o.Name = o.Name or BaseName
			o.ObjName = o.Name
			all[models] = true
		end
	end
	if next(all) then
		return all
	end
end

-----------------------------------------------------
-- Editor.ImportModelTemplate
-----------------------------------------------------

local function LoadModelObj(file)
	local BaseModels = {}
	local obj
	
	local function AddObject(s)
		obj = {}
		BaseModels[{X = 0, Y = 0, Z = 0, Name = s, BaseFacets = obj}] = true
		UniqueVertex, UniqueFacet = Editor.AddUnique(state)
		NewFacets, OldFacets = {}, {}
		for i = 1, #ParseVerts do
			ParseVerts[i] = UniqueVertex(XYZ(ParseVerts[i]))
		end
	end
	ParseVerts = {}
	AddObject()
	
	ParseObj(file, AddVertex, 
		-- Facet
		function(t, texture, invis, u, v)
			t = AddFacet(t)
			if not t or not t.nx then
				return
			end
			if texture and texture == "_Invisible_" then
				t.Invisible = true
				t.Bitmap = nil
			elseif texture then
				t.Invisible = invis
				t.Bitmap = texture
			end
			if u and v then
				t.ImportVertex, t.ImportU, t.ImportV = t.Vertexes[1], u % 1, v % 1
			end
			obj[t] = true
		end,
		-- Object
		AddObject
	)
	return BaseModels
end

function Editor.ImportModelTemplate(name)
	local BaseModels = LoadModelObj(name)
	return Editor.PrepareModelTemplate(BaseModels, path.setext(path.name(name), ''))
end

-----------------------------------------------------
-- Editor.LoadObj
-----------------------------------------------------

function Editor.LoadObj(file, AsObjects)
	if not Editor.State then
		Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(path.name(file), '.dat')
	end
	-- local back = internal.persist(Editor.State)
	if Map.IsIndoor() then
		state = Editor.State or {Rooms = {{Facets = {}}}}
		state.Objects = state.Objects or {}
		Editor.profile "LoadObj"
		Editor.ShiftVertexes(true)
		LoadBlvObj(file, AsObjects)
		Editor.ShiftVertexes(false)
		Editor.profile "BuildRooms"
		BuildRooms()
		Editor.SetState(state)
		Editor.UpdatePortalRooms()
	else
		state = Editor.State or {Header = {}}
		Editor.profile "LoadObj"
		LoadOdmObj(file)
		Editor.profile "BuildModels"
		BuildModels()
		Editor.SetState(state)
	end
	Editor.DoorCache = nil
	-- if BuildRooms() then
		-- Editor.State = state
	-- else
		-- Editor.State = internal.unpersist(back)
	-- end
end
