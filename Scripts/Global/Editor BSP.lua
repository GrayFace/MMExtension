Editor = Editor or {}
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local ffi = require("ffi")
local _KNOWNGLOBALS

local Delta = 2.5

-----------------------------------------------------
-- BuildRoomBSP
-----------------------------------------------------

local UniqueVertex
local SplitEdges
local DoorVerts
local CHK_FRONT = 1
local CHK_BACK = 2
local CHK_INTERSECT = 3
local CHK_COPLANAR = 4
local CHK_DOOR = 5

local function FacetPlane(a)
	return a.NormalX, a.NormalY, a.NormalZ, a.NormalDistance
end

local function DoCheckFacet(a, nx, ny, nz, d)
	local front, back
	for _, v in ipairs(a.Vertexes) do
		local dist = v.X*nx + v.Y*ny + v.Z*nz + d
		if dist > Delta then
			front = true
		elseif dist < -Delta then
			back = true
		end
	end
	if front and back then
		return a.IsPortal and CHK_DOOR or CHK_INTERSECT  -- intersect
	elseif front then
		return CHK_FRONT  -- front
	elseif back then
		return CHK_BACK  -- back
	else
		return CHK_COPLANAR  -- coplanar
	end
end

-- these door checks assume the whole facet is moved by the door, which isn't always the case

local function DoorCheck(func, a, nx, ny, nz, d, dd)
	if dd == 0 then
		return func(a, nx, ny, nz, d)
	end
	local r1 = func(a, nx, ny, nz, d)
	local r2 = func(a, nx, ny, nz, d + dd)
	if r1 == CHK_INTERSECT or r2 ==CHK_INTERSECT then
		return CHK_DOOR
	elseif r1 == r2 or r2 == CHK_COPLANAR then
		return r1
	elseif r1 == CHK_COPLANAR then
		return r2
	else
		return CHK_DOOR
	end
end

local function DoorNonStatic(f)  -- ignore static facets that can't be stretched
	local a = f.Door
	if a and (f.MovedByDoor or math.abs(f.nx*a.DirectionX + f.ny*a.DirectionY + f.nz*a.DirectionZ) > Editor.DoorMinCos) then
		return a
	end
end

local function DoCheckFacet2(a, nx, ny, nz, d)  -- checks with respect to door of 'a'
	local q = DoorNonStatic(a)
	local dd = q and q.MoveLength*(q.DirectionX*nx + q.DirectionY*ny + q.DirectionZ*nz) or 0
	return DoorCheck(DoCheckFacet, a, nx, ny, nz, d, dd)
end

local function CheckFacet(a, nx, ny, nz, d, f)  -- checks if 'a' can be split by 'f' with respect to both doors
	local q = DoorNonStatic(f)
	if q == DoorNonStatic(a) then
		return DoCheckFacet(a, nx, ny, nz, d)
	end
	local dd = q and -q.MoveLength*(q.DirectionX*nx + q.DirectionY*ny + q.DirectionZ*nz) or 0
	return DoorCheck(DoCheckFacet2, a, nx, ny, nz, d, dd)
end

local function QuickCheckFacet(a, nx, ny, nz, d, f)
	if a.IsPortal or DoorNonStatic(f) ~= DoorNonStatic(a) then
		return CheckFacet(a, nx, ny, nz, d, f)
	end
	local IsCop = (abs(a.nx*nx + a.ny*ny + a.nz*nz) >= 0.999)
	local front, back
	for _, v in ipairs(a.Vertexes) do
		local dist = v.X*nx + v.Y*ny + v.Z*nz + d
		if dist > Delta then
			return CHK_FRONT  -- front
		elseif dist < -Delta then
			return CHK_BACK  -- back
		elseif IsCop then
			return CHK_COPLANAR  -- coplanar
		end
	end
	return CHK_COPLANAR  -- coplanar
end

local function SplitFacet(facet, nx, ny, nz, ndist)
	local front, back = {}, {}
	local last = facet.Vertexes[#facet.Vertexes]
	local lastD = last.X*nx + last.Y*ny + last.Z*nz + ndist
	for i, v in ipairs(facet.Vertexes) do
		local d = v.X*nx + v.Y*ny + v.Z*nz + ndist
		local a, b = front, back
		if d < 0 then
			a, b = b, a
		end
		if d*lastD < 0 then
			if math.abs(lastD) < Delta then
				a[#a + 1] = last
			elseif math.abs(d) < Delta then
				b[#b + 1] = v
			else
				local p = math.abs(lastD/(d - lastD))
				local q = 1 - p
				local v1 = {X = v.X*p + last.X*q, Y = v.Y*p + last.Y*q, Z = v.Z*p + last.Z*q, Shift = v.Shift}
				v1 = UniqueVertex(v1.X, v1.Y, v1.Z, v1)
				SplitEdges[#SplitEdges + 1] = last
				SplitEdges[#SplitEdges + 1] = v
				SplitEdges[#SplitEdges + 1] = v1
				a[#a + 1], b[#b + 1] = v1, v1
			end
		elseif d == 0 then
			b[#b + 1] = v
		end
		a[#a + 1] = v
		lastD = d
		last = v
	end
	assert(#front >= 3 and #back >= 3)
	return table.copy(facet, {Vertexes = front}), table.copy(facet, {Vertexes = back})
end

local function BuildRoomBSP(rid, r, DifferErrors)
	if r.BSP ~= nil or not next(r.Facets) then
		r.BSP = r.BSP or false
		return
	end
	local Process, ProcessHugeRoom, ProcessNormalRoom
	local profile = Editor.profile
	local NonBSP = 0
	local draw = {}
	local InBSP
	local facets, num
	local Checks
	SplitEdges = {}
	-- Init front/back/coplanar/intersect checks list
	local function UpdateChecks(list, list2, quick)
		for i, f in pairs(list2 or facets) do
			local s = f.IsPortal and f.Room ~= rid and -1 or 1
			local nx, ny, nz, d = s*f.nx, s*f.ny, s*f.nz, s*f.ndist
			for j in pairs(list) do
				if i ~= j then
					Checks[i*num + j] = (quick and QuickCheckFacet or CheckFacet)(facets[j], nx, ny, nz, d, f)
				end
			end
		end
	end

	local function PrepareBSPNode(bsp, i, intersect, NeedBack)
		InBSP = true
		local f = facets[i]
		local s = f.IsPortal and f.Room ~= rid and -1 or 1
		local nx, ny, nz, d = s*f.nx, s*f.ny, s*f.nz, s*f.ndist
		bsp.CoplanarOffset = #draw
		local back = {}
		draw[#draw + 1] = facets[i]
		facets[i] = nil
		for j, f in pairs(facets) do
			local ch = Checks[i*num + j]
			if ch == CHK_COPLANAR then
				draw[#draw + 1] = f
				facets[j] = nil
			elseif ch == CHK_BACK and NeedBack then
				facets[j], back[j] = nil, f
			elseif ch == CHK_INTERSECT then
				facets[j], back[j] = SplitFacet(f, nx, ny, nz, d)
				if intersect then
					intersect[j] = true
				end
			end
		end
		bsp.CoplanarSize = #draw - bsp.CoplanarOffset
		return back, bsp
	end

	function ProcessHugeRoom()
		local function DoSpit(i)
			UpdateChecks(facets, {facets[i]})
			local back, bsp = PrepareBSPNode({}, i, nil, true)
			bsp.Front = ProcessNormalRoom(facets)
			bsp.Back = ProcessNormalRoom(back)
			return bsp
		end
		
		Checks = ffi.new("unsigned char[?]", num)
		local limI, minPart = num/40, min(2000, num/5)
		num = 0
		local bestMN, best = 0, nil
		for i, f in pairs(facets) do
			UpdateChecks(facets, {f}, true)
			local ni, nf, nb, nc = 0, 0, 0, 0
			for j in pairs(facets) do
				if i ~= j then
					local ch = Checks[j]
					if ch == CHK_INTERSECT then
						ni = ni + 1
						if ni > limI then
							break
						end
					elseif ch == CHK_DOOR then
						ni = math.huge
						break
					elseif ch == CHK_FRONT then
						nf = nf + 1
					elseif ch == CHK_BACK then
						nb = nb + 1
					elseif ch == CHK_COPLANAR then
						nc = nc + 1
					end
				end
			end
			local mn = min(nf, nb) + nc - ni
			if ni <= limI and mn >= minPart and ni*20 <= mn then
				return DoSpit(i)
			elseif ni <= limI and mn > bestMN then
				bestMN, best = mn, i
			end
		end
		if best then
			return DoSpit(best)
		end
		error("failed to build BSP")
	end
	
	function ProcessNormalRoom(NewFac)
		facets, num = {}, 0
		if NewFac then
			for i, f in pairs(NewFac) do
				facets[num], num = f, num + 1
			end
		else
			for f in pairs(r.Facets) do
				facets[num], num = f, num + 1
			end
		end
		if num > 4000 then
			return ProcessHugeRoom()
		end
		Checks = ffi.new("unsigned char[?]", num*num)
		profile "UpdateChecks"
		UpdateChecks(facets)
		profile "Process"
		local ret = Process()
		profile(nil)
		return ret
	end

	-- Process facets
	function Process(bsp)
		bsp = bsp or {}
		local BaseBSP = bsp
		-- Find best facet
		local bestI, bestC, best, bestFront = math.huge, -1, nil, 0
		repeat
			local HadFast = false
			for i, f in pairs(facets) do
				local ni, nf, nb, nc, nbb = 0, 0, 0, 0, 0
				for j in pairs(facets) do
					if i ~= j then
						local ch = Checks[i*num + j]
						if ch == CHK_INTERSECT then
							ni = ni + 1
							if ni > bestI then
								break
							end
						elseif ch == CHK_DOOR then
							ni = math.huge
							break
						elseif ch == CHK_FRONT then
							nf = nf + 1
						elseif ch == CHK_BACK then
							nb = nb + 1
							if Checks[j*num + i] ~= CHK_BACK then
								nbb = nbb + 1
							end
						elseif ch == CHK_COPLANAR then
							nc = nc + 1
						end
					end
				end
				if ni == 0 and (nb == 0 or not InBSP and nbb == 0 or InBSP and nf == 0) then
					if not InBSP then
						NonBSP = NonBSP + 1
						draw[NonBSP] = f
					else
						bsp.CoplanarOffset = #draw
						draw[#draw + 1] = f
						if nc > 0 then
							for j, f1 in pairs(facets) do
								if i ~= j and Checks[i*num + j] == CHK_COPLANAR then
									draw[#draw + 1] = f1
									facets[j] = nil
									if j == best then
										bestI, best, bestFront = math.huge, nil, 0
									end
									bestC = bestC - 1
								end
							end
						end
						bsp.CoplanarSize = nc + 1
						local base = bsp
						bsp = {}
						if nf == 0 then
							base.Back = bsp
						else
							base.Front = bsp
						end
					end
					facets[i] = nil
					if not next(facets) then
						return next(BaseBSP) and BaseBSP
					elseif i == best then
						bestI, best, bestFront = math.huge, nil, 0
					end
					bestC = -1
					HadFast = true
				elseif ni < bestI or ni == bestI and nc > bestC then
					bestI, bestC, best, bestFront = ni, nc, i, nf
				end
			end
		until not HadFast
		if best == nil then
			return
		elseif bestI == math.huge then
			if DifferErrors then
				Editor.LastError = "BSP compilation failed due to doors"
				Editor.LastErrorFacets = table.copy(facets)
			else
				local v = facets[best].Vertexes[1]
				Party.X, Party.Y, Party.Z = v.X, v.Y, v.Z
				error("BSP compilation failed due to doors")
			end
		end
		
		-- Prepare front/back lists
		local intersect = bestI > 0 and {}
		local back = PrepareBSPNode(bsp, best, intersect, (bestFront + bestI > 0))
		-- Front
		if intersect then
			UpdateChecks(intersect)
		elseif bestFront == 0 then
			bsp.Front = nil
			bsp.Back = Process()
			return BaseBSP
		end
		bsp.Front = Process()
		-- Back
		facets = back
		if intersect then
			UpdateChecks(intersect)
		end
		bsp.Back = Process()
		return BaseBSP
	end

	r.BSP = ProcessNormalRoom() or false
	r.DrawFacets = draw
	r.NonBSP = NonBSP
	r.OldBSP = nil
	if r.BSP then
		r.BSP.SplitEdges = SplitEdges
	end
end

-----------------------------------------------------
-- Editor.BuildBSP
-----------------------------------------------------

function Editor.BuildBSP(DifferErrors)
	UniqueVertex = Editor.AddUnique()
	DoorVerts = {}
	for i, r in ipairs(Editor.State.Rooms) do
		BuildRoomBSP(i - 1, r, DifferErrors)
	end
end

-----------------------------------------------------
-- Editor.UpdatePortalRooms
-----------------------------------------------------

function Editor.UpdatePortalRooms()
	UniqueVertex = Editor.AddUnique()
	for i, r in ipairs(Editor.State.Rooms) do
		for f in pairs(r.Facets) do
			if f.IsPortal then
				f[Editor.MatchesOrientation(f.PartOf, r.Facets) and "Room" or "RoomBehind"] = i - 1
			end
		end
	end
end
