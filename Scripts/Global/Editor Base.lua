local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min

Editor = Editor or {}
local _KNOWNGLOBALS

local function inorm(x, y, z)
	local n = x*x + y*y + z*z
	return (n ~= 0) and n^(-0.5) or 0
end

-----------------------------------------------------
-- Unique vertexes and facets
-----------------------------------------------------

function Editor.AddUnique(state, SingleModel)
	state = state or Editor.State
	local ids = {}
	local id = 1
	local verts = {}
	local facs = {}
	local starting = true
	
	local function UniqueVertex(x, y, z, v)
		local list = verts[x]
		if list then
			for v1 in pairs(list) do
				if y == v1.Y and z == v1.Z then
					if v1.Shift == (v and v.Shift) then
						if starting then
							ids[v] = ids[v1]
						end
						return v1, false
					else
						if v1.Shift then
							v1.Shift.Delete = nil
						else
							v.Shift.Delete = nil
						end
					end
				end
			end
			v = v or {X = x, Y = y, Z = z}
			list[v] = true
		else
			v = v or {X = x, Y = y, Z = z}
			verts[x] = {[v] = true}
		end
		ids[v] = id
		id = id + 1
		return v, true
	end
	
	local function UniqueFacet(v, a)
		local m, d = -1, 0
		local n = #v
		for i = 1, n do
			local id = ids[v[i]]
			if id > m then
				m, d = id, i - 1
			end
		end
		
		local t = {}
		for i = 1, n do
			t[i] = ids[v[(i + d - 1) % n + 1]]
		end
		local s = table.concat(t, " ")
		local f = facs[s]
		if f then
			return f, false
		end
		a = a or {Vertexes = v}
		facs[s] = a
		return a, true
	end
	
	local rooms = state.Rooms or {SingleModel}
	for _, r in ipairs(rooms) do
		local facets = r.BaseFacets or r.Facets
		for a in pairs(facets) do
			for _,v in ipairs(a.Vertexes) do
				UniqueVertex(v.X, v.Y, v.Z, v)
			end
			UniqueFacet(a.Vertexes, a)
		end
	end
	starting = false
	
	return UniqueVertex, UniqueFacet
end

-----------------------------------------------------
-- Editor.FindNormal
-----------------------------------------------------

local function cross(x1, y1, z1, x2, y2, z2)
	-- if not z1 then
		-- local v1, v2 = x1, y1
		-- x1, y1, z1 = v1.X, v1.Y, v1.Z
		-- x2, y2, z2 = v2.X, v2.Y, v2.Z
	-- end
	local nx = z2*y1 - z1*y2
	local ny = x2*z1 - x1*z2
	local nz = x1*y2 - x2*y1
	return nx, ny, nz
end

function Editor.FindNormal(t, silent)
	local cancave
	local v = t.Vertexes
	local n = #v
	if n < 3 then
		return silent or error("facet with less than 3 vertices found")
	end
	local nx, ny, nz = 0, 0, 0
	if n == 3 then
		local v0, v1, v2 = v[1], v[2], v[3]
		local x1, y1, z1, x2, y2, z2 = v1.X - v0.X, v1.Y - v0.Y, v1.Z - v0.Z, v2.X - v1.X, v2.Y - v1.Y, v2.Z - v1.Z
		nx, ny, nz = cross(x1, y1, z1, x2, y2, z2)
		cancave = false
	else
		for i = 1, n do
			local v0, v1, v2 = v[(i - 2) % n + 1], v[i], v[i % n + 1]
			local x1, y1, z1, x2, y2, z2 = v1.X - v0.X, v1.Y - v0.Y, v1.Z - v0.Z, v2.X - v1.X, v2.Y - v1.Y, v2.Z - v1.Z
			local x, y, z = cross(x1, y1, z1, x2, y2, z2)
			local cs = (x1*x2 + y1*y2 + z1*z2) * (x1*x1 + y1*y1 + z1*z1)^(-0.5) * (x2*x2 + y2*y2 + z2*z2)^(-0.5)
			local mul = math.acos(min(1, max(cs, -1)))*inorm(x, y, z)
			cancave = cancave or x*nx + y*ny + z*nz < 0 and cs > -0.9999
			nx, ny, nz = nx + x*mul, ny + y*mul, nz + z*mul
		end
	end
	if nx*nx + ny*ny + nz*nz <= 0 then
		return silent or error("unable to find normal:\n"..dump(t))
	end
	local n = (nx*nx + ny*ny + nz*nz)^(-0.5)
	nx, ny, nz = nx*n, ny*n, nz*n
	t.nx, t.ny, t.nz = nx, ny, nz
	local v = v[1]
	t.ndist = -(v.X*nx + v.Y*ny + v.Z*nz)
	t.Cancave = cancave
	t.Bent = Editor.IsFacetBent(t)
end

-----------------------------------------------------
-- Editor.ConvexifyPortal
-----------------------------------------------------

function Editor.ConvexifyPortal(t)
	local v = t.Vertexes
	local nx, ny, nz = t.nx, t.ny, t.nz
	repeat
		local cancave
		local n = #v
		for i = 1, n do
			local v0, v1, v2 = v[(i - 2) % n + 1], v[i], v[i % n + 1]
			local x1, y1, z1, x2, y2, z2 = v1.X - v0.X, v1.Y - v0.Y, v1.Z - v0.Z, v2.X - v1.X, v2.Y - v1.Y, v2.Z - v1.Z
			local x, y, z = cross(x1, y1, z1, x2, y2, z2)
			if x*nx + y*ny + z*nz < 0 then  --  -1 ?
				table.remove(v, i)
				cancave = true
				break
			end
		end
	until not cancave
	Editor.FindNormal(t)
	assert(not t.Cancave)
	return t
end

-----------------------------------------------------
-- Editor.Triangulate
-----------------------------------------------------

function Editor.Triangulate(facet, list)
	local vert = facet.Vertexes
	-- find projection plane
	local X, Y, nz
	do
		local x, y, z = abs(facet.nx), abs(facet.ny), abs(facet.nz)
		if z >= x and z >= y then
			X, Y, nz = "X", "Y", facet.nz
		elseif y >= x and y >= z then
			X, Y, nz = "Z", "X", facet.ny
		else
			X, Y, nz = "Y", "Z", facet.nx
		end
	end
	-- init linked list
	local vn = {}
	do
		local last = vert[#vert]
		for i, v1 in ipairs(vert) do
			if vn[v1] and i ~= #vert then
				v1 = table.copy(v1, {REAL = v1})
			end
			vn[last], last = v1, v1
		end
	end
	-- is it an ear?
	local BadEar
	local function NotEar(v0, v1, v2)
		local v1x, v1y = v1[X], v1[Y]
		local x1, y1, x2, y2 = v0[X] - v1x, v0[Y] - v1y, v2[X] - v1x, v2[Y] - v1y
		local mul = x1*y2 - y1*x2
		BadEar = (mul == 0)
		if mul*nz >= 0 then
			return not BadEar
		end
		mul = 1/mul
		local v = vn[v2]
		while v ~= v0 do
			local x, y = v[X] - v1x, v[Y] - v1y
			local a, b = mul*(x*y2 - y*x2), mul*(y*x1 - x*y1)
			if a > 0 and b > 0 and a + b < 1 then
				return true
			end
			v = vn[v]
		end
		-- Equations solved:
		-- x = a*x1 + b*x2
		-- y = a*y1 + b*y2
	end
	-- most primitive ear cutting
	local v0, v1, v2 = vert[1], vert[2], vert[3]
	repeat
		local _v0 = v0
		while NotEar(v0, v1, v2) do
			v0, v1, v2 = v1, v2, vn[v2] -- assert(vn[v2], "a polygon contains one vertex twice")
			if v0 == _v0 then
				return
			end
		end
		if not BadEar then
			local t = table.copy(facet, {Vertexes = {v0.REAL or v0, v1.REAL or v1, v2.REAL or v2}})
			Editor.FindNormal(t)
			list[t] = true
		end
		assert(v2 ~= v1)
		vn[v0], vn[v1] = v2, nil
		v1, v2 = v2, vn[v2]
	until v0 == v2

	-- cut polygonal ears (leads to seeming small gaps between parts of facet in D3D, which doesn't happen with triangles)
	-- local function IsReflex(v0, v1, v2)
		-- local x1, y1, x2, y2 = v0[X] - v1[X], v0[Y] - v1[Y], v2[X] - v1[X], v2[Y] - v1[Y]
		-- return (x1*y2 - y1*x2)*nz > 0
	-- end
	-- local ear
	-- local function StoreEar()
		-- if ear then
			-- list[table.copy(facet, {Vertexes = ear})] = true
			-- ear = nil
		-- end
	-- end
	-- local v0, v1, v2 = vert[1], vert[2], vert[3]
	-- repeat
		-- if ear and NotEar(v0, v1, v2) then
			-- StoreEar()
		-- end
		-- if not ear then
			-- -- find a reflex point
			-- local _v0 = v0
			-- while not IsReflex(v0, v1, v2) and v0 ~= _v0 do
				-- v0, v1, v2 = v1, v2, vn[v2]
			-- end
			-- -- start from next point
			-- local _v0 = v0
			-- v0, v1, v2 = v1, v2, vn[v2]
			-- while NotEar(v0, v1, v2) do
				-- StoreEar()
				-- v0, v1, v2 = v1, v2, vn[v2]
				-- if v0 == _v0 then
					-- return
				-- end
			-- end
		-- end
		-- if ear and (BadEar or IsReflex(ear[#ear - 1], v1, v2) or IsReflex(v2, v0, ear[2])) then
			-- StoreEar()
		-- end
		-- if not BadEar then
			-- if ear then
				-- ear[#ear + 1] = v2
			-- else
				-- ear = {v0, v1, v2}
			-- end
		-- end
		-- vn[v0], vn[v1] = v2, nil
		-- v1, v2 = v2, vn[v2]
	-- until v0 == v2
	-- StoreEar()
end

-----------------------------------------------------
-- Editor.ConvexHullFacet
-----------------------------------------------------

local function FindVertexesMinMax(v)
	local a = {}
	v[1] = v[1] or {X = 0, Y = 0, Z = 0}
	-- BBox
	local function minmax(coord)
		local m1, m2 = v[1][coord], v[1][coord]
		for i = 2, #v do
			m1 = min(m1, v[i][coord])
			m2 = max(m2, v[i][coord])
		end
		a["Min"..coord] = m1
		a["Max"..coord] = m2
	end
	minmax("X")
	minmax("Y")
	minmax("Z")
	return a
end

function Editor.ConvexHullFacet(cloud)
	local X, Y
	-- find axes
	local mm = FindVertexesMinMax(cloud)
	do
		local x, y, z = mm.MaxX - mm.MinX, mm.MaxY - mm.MinY, mm.MaxZ - mm.MinZ
		if z <= x and z <= y then
			X, Y = "X", "Y"
		elseif y <= x and y <= z then
			X, Y = "Z", "X"
		else
			X, Y = "Y", "Z"
		end
		if mm["Max"..X] == mm["Min"..X] or mm["Max"..Y] == mm["Min"..Y] then
			return
		end
	end
	
	-- find topmost-rightmost vertex
	local t, vm = {}, nil
	do
		local mx, my = -math.huge, mm["Min"..Y]
		for _, v in pairs(cloud) do
			if v[Y] == my and v[X] > mx then
				vm, mx = v, v[X]
			end
		end
	end

	-- direction of last side
	local lx, ly = 1, 0
	-- build hull
	repeat
		local last, mc = vm, -1
		local mx, my, mi
		t[#t + 1], vm = vm, nil
		for i, v in pairs(cloud) do
			local x, y = v[X] - last[X], v[Y] - last[Y]
			if x*x + y*y ~= 0 then
				local mul = (x*x + y*y)^(-0.5)
				x, y = x*mul, y*mul
				local c = x*lx + y*ly
				if c > mc then
					vm, mc, mx, my, mi = v, c, x, y, i
				end
			end
		end
		lx, ly, cloud[mi] = mx, my, nil
	until vm == t[1]
	
	t = {Vertexes = t}
	Editor.FindNormal(t)
	t.Cancave = false
	return t
end

-----------------------------------------------------
-- Editor.IsFacetBent
-----------------------------------------------------

function Editor.IsFacetBent(t)
	local nx, ny, nz = t.nx, t.ny, t.nz
	local dmax, dmin = -1/0, 1/0
	for _, v in ipairs(t.Vertexes) do
		local d = v.X*t.nx + v.Y*t.ny + v.Z*t.nz
		if d > dmax then
			dmax = d
		end
		if d < dmin then
			dmin = d
		end
	end
	return dmax - dmin > (Map.IsIndoor() and 2 or 5)
end

-----------------------------------------------------
-- Editor.JoinFacets
-----------------------------------------------------

function Editor.JoinFacetVertexes(t, q)
	local same, i = {}, nil
	for k, v in ipairs(q) do
		same[v] = k
	end
	for k, v in ipairs(t) do
		if same[v] then
			i = k
			break
		end
	end
	if not i then
		return
	end
	local n = #t
	-- go to last matching vertex
	local j = (i - 2) % n + 1
	while same[t[i % n + 1]] and i ~= j do
		i = i % n + 1
	end
	if i == j then  -- intertwined
		return
	end
	
	local j = same[t[i]]  -- starting point as seen from 'q'
	
	local vert = {}
	-- go through 't'
	repeat
		vert[#vert + 1] = t[i]
		i = i % n + 1
	until same[t[i]]
	-- go through 'q'
	n, i = #q, same[t[i]]
	repeat
		vert[#vert + 1] = q[i]
		i = i % n + 1
	until i == j
	
	-- check that all are present
	same = {}
	for k, v in ipairs(t) do
		same[v] = 1
	end
	for k, v in ipairs(q) do
		same[v] = (same[v] or 0) + 1
	end
	for k, v in ipairs(vert) do
		same[v] = 2
	end
	for v, i in pairs(same) do
		if i ~= 2 then
			return
		end
	end
	
	return vert
end

-----------------------------------------------------
-- Editor.FacetMiddles
-----------------------------------------------------

local function FacetMiddles_index(middles, f)
	local t = {}
	middles[f] = t
	local x, y, z, n = 0, 0, 0, 0
	for i, v in ipairs(f.Vertexes) do
		x, y, z, n = x + v.X, y + v.Y, z + v.Z, i
	end
	t.X, t.Y, t.Z = x/n, y/n, z/n
	
	local r = 0
	for i, v in ipairs(f.Vertexes) do
		local x, y, z = x - v.X, y - v.Y, z - v.Z
		r = max(r, x*x + y*y + z*z)
	end
	t.R2 = r
	t.R = r^0.5
	return t
end

Editor.FacetMiddles = setmetatable({}, {__mode = "k", __index = FacetMiddles_index})

-----------------------------------------------------
-- Editor.DeepCopy
-----------------------------------------------------

function Editor.DeepCopy(t)
	local all = {}
	
	local function copy(t)
		if type(t) ~= "table" then
			return t
		elseif all[t] then
			return all[t]
		end
		local new = {}
		all[t] = new
		for k, v in pairs(t) do
			new[copy(k)] = copy(v)
		end
		return new
	end
	
	return copy(t)
end

-----------------------------------------------------
-- Editor.MatchesOrientation
-----------------------------------------------------

function Editor.MatchesOrientation(p, rfacets)
	local n = #p.Vertexes
	for i, v1 in ipairs(p.Vertexes) do
		local mine = {[v1] = true, [p.Vertexes[i % n + 1]] = true}
		for f in pairs(rfacets) do
			if f ~= p then
				local n = #f.Vertexes
				for i, v in ipairs(f.Vertexes) do
					if mine[v] and mine[f.Vertexes[i % n + 1]] then
						return v ~= v1  -- if both counter-clockwise, should go in different directions
					end
				end
			end
		end
	end
	error""
end

-----------------------------------------------------
-- Editor.EdgeFacets
-----------------------------------------------------

function Editor.EdgeFacets(rooms)
	local t = setmetatable({}, {__index = function(t, k)
		local q = {}
		t[k] = q
		return q
	end})
	
	local n = 0
	local ids = setmetatable({}, {__index = function(t, k)
		n = n + 1
		t[k] = n
		return n
	end})
	
	local function get(v, v2, f)
		local i, j = ids[v], ids[v2]
		if i > j then
			i, j = j, i
		end
		if not f then
			return t[i*0x100000 + j]
		end
		local r, n = nil, 0
		for a in pairs(t[i*0x100000 + j]) do
			n = n + 1
			if a ~= f then
				r = a
			end
		end
		return r, n
	end
	
	for _, r in ipairs(rooms or Editor.State.Rooms) do
		for a in pairs(r.Facets) do
			local vert = a.Vertexes
			local n = #vert
			for i, v in ipairs(vert) do
				get(v, vert[i % n + 1])[a] = true
			end
		end
	end
	return get
end

-----------------------------------------------------
-- Editor.GenerateLookupGrid
-----------------------------------------------------

-- local function UpdateFacetMinMax(a, v)
-- 	local function minmax(coord)
-- 		local m1, m2 = v[1][coord], v[1][coord]
-- 		for i = 2, #v do
-- 			m1 = min(m1, v[i][coord])
-- 			m2 = max(m2, v[i][coord])
-- 		end
-- 		a["Min"..coord] = round(m1) - 0.01
-- 		a["Max"..coord] = round(m2) + 0.01
-- 	end
-- 	minmax("X")
-- 	minmax("Y")
-- 	minmax("Z")
-- end

-- local function Enum

-- function Editor.GenerateLookupGrid(facets, n)
	
-- end
