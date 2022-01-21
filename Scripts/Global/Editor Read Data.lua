local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local mmver = offsets.MMVersion

Editor = Editor or {}
local _KNOWNGLOBALS

local VertexShifts
local FacetDoorIdx
local Vertexes
local Facets
local Sprites
local Lights

local function inorm(x, y, z)
	local n = x*x + y*y + z*z
	return (n ~= 0) and n^(-0.5) or 0
end

local function normalize(x, y, z, mul)
	local n = inorm(x, y, z)*(mul or 1)
	return x*n, y*n, z*n
end

local function ReadList(list, ref, t)
	for i, id in list do
		t[i + 1] = assert(ref[id])
	end
	return t
end

local function KeysList(list, ref, t)
	for i, id in list do
		local f = ref[id + 1]
		if f then
			t[f] = true
		end
	end
	return t
end

local function boolcopy(t)
	local t1 = {}
	for k in pairs(t) do
		t1[k] = true
	end
	return t1
end

local function CompatibleIds(t)  -- to transfer maps to higher version of MM that indroduce "Id" attribute
	for a, id in pairs(t) do
		a.Id = id
	end
end

Editor._FacetBits = {
	IsPortal = 0x00000001,
	IsWater = 0x00000010,
	Invisible = 0x00002000,
	AnimatedTFT = 0x00004000,
	MoveByDoor = 0x00040000,
	AlternativeSound = 0x00200000,
	IsSky = 0x00400000,  -- horizontal flow
	-- FlipU = 0x00800000,
	-- FlipV = 0x01000000,
	TriggerByClick = 0x02000000,
	TriggerByStep = 0x04000000,
	Untouchable = 0x20000000,
	IsLava = 0x40000000,
}

if Game.Version > 6 then
	table.copy({
		IsSecret = 0x00000002,  -- show in red with Perception
		ScrollDown = 0x00000004,  -- moving texture
		ScrollUp = 0x00000020,
		ScrollLeft = 0x00000040,
		ScrollRight = 0x00000800,
		AlignTop = 0x00000008,  -- align door texture in D3D
		AlignLeft = 0x00001000,
		AlignRight = 0x00008000,
		AlignBottom = 0x00020000,
	}, Editor._FacetBits, true)
end
if Game.Version < 8 then
	table.copy({
		TriggerByMonster = 0x08000000,  -- happens even if there's no event assigned
		TriggerByObject = 0x10000000,  -- happens even if there's no event assigned
	}, Editor._FacetBits, true)
else
	table.copy({
		DisableEventByCtrlClick = 0x08000000,  -- indoor only: click event gets disabled by Ctrl+Click
		EventDisabledByCtrlClick = 0x10000000,
	}, Editor._FacetBits, true)
end


local FacetDataProps = {
	"BitmapU",
	"BitmapV",
	"Id",
	"Event",
}

local function MakeExact(a, skip)
	local exact = {}
	skip = skip or {}
	for k, v in structs.enum(a) do
		if type(v) ~= 'table' and k ~= 'Bits' and not skip[k] then
			exact[k] = v
		end
	end
	return exact
end

-----------------------------------------------------
-- VertexShifts
-----------------------------------------------------

local function InitVertexShifts()
	VertexShifts = {}
	for _, t in Map.Doors do
		local dx = {Delete = Editor.ExactMode ~= 2}
		XYZ(dx, normalize(t.DirectionX, t.DirectionY, t.DirectionZ, t.MoveLength/2))
		for i, vi in t.VertexIds do
			VertexShifts[vi] = dx
		end
	end
end

local function CleanVertexShifts()
	for i, v in pairs(Vertexes) do
		if v.Shift and v.Shift.Delete then
			v.Shift = nil
		end
	end
	VertexShifts = nil
end

local function ShiftVertexes(operate, f, done)
	local mul = operate and 1 or -1
	for i, v in ipairs(f.Vertexes) do
		local a = v.Shift
		if a and not done[v] then
			v.X = v.X + a.X*mul
			v.Y = v.Y + a.Y*mul
			v.Z = v.Z + a.Z*mul
			done[v] = true
		end
	end
end

-- would be called before and after export/import
function Editor.ShiftVertexes(operate)
	local done = {}
	for _, r in ipairs((Editor.State or {}).Rooms or {}) do
		for f in pairs(r.Facets) do
			ShiftVertexes(operate, f, done)
		end
	end
end

local function InitFacetDoorIdx()
	FacetDoorIdx = {}
	for di, t in Map.Doors do
		for i, fi in t.FacetIds do
			local f = Facets[fi + 1]
			if f then
				local j = FacetDoorIdx[f] or 0
				if j % 200 ~= di then
					FacetDoorIdx[f] = j*200 + di
				end
			end
		end
	end
end

-----------------------------------------------------
-- ReadFacet
-----------------------------------------------------

local function cross(x1, y1, z1, x2, y2, z2)
	if not z1 then
		local v1, v2 = x1, y1
		x1, y1, z1 = v1.X, v1.Y, v1.Z
		x2, y2, z2 = v2.X, v2.Y, v2.Z
	end
	local nx = z2*y1 - z1*y2
	local ny = x2*z1 - x1*z2
	local nz = x1*y2 - x2*y1
	return nx, ny, nz
end

local function HasDoorVerts(vert)
	for i, v in ipairs(vert) do
		if v.Shift then
			return true
		end
	end
end

local function ReadFacetData(a, t, mf)
	a["?ptr"] = a["?ptr"]  -- speed up
	for _, k in ipairs(FacetDataProps) do
		t[k] = a[k]
		if t[k] == 0 then
			t[k] = nil
		end
	end
	a["?ptr"] = nil
	-- if mf.BitmapId >= 0 then
		-- t.ImportVertex = t.Vertexes[1]
		-- local b = Game.BitmapsLod.Bitmaps[mf.BitmapId]
		-- local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections(mf)
		-- local vertX, vertY, vertZ = t.ImportVertex.X, t.ImportVertex.Y, t.ImportVertex.Z
		-- t.ImportU = (a.BitmapU + ux*vertX + uy*vertY + uz*vertZ)/b.Width % 1
		-- t.ImportV = (a.BitmapV + vx*vertX + vy*vertY + vz*vertZ)/b.Height % 1
		-- t.BitmapU, t.BitmapV = nil, nil
	-- end
	return t
end

function Editor.ReadFacet(a, _, Verts)
	a["?ptr"] = a["?ptr"]  -- speed up
	local v = ReadList(a.VertexIds, Verts or Vertexes, {})
	-- remove duplicate vertexes
	do
		local j = (v[1] ~= v[#v] and 2 or 1)
		local last = v[1]
		for i = 2, #v do
			local a = v[i]
			v[i] = nil
			if a ~= last then
				v[j] = a
				j = j + 1
			end
			last = a
		end
	end
	
	if #v < (Map.IsIndoor() and (Editor.ExactMode == 2 and 0 or 1) or 3) then -- 3 then --or not a.IsPortal and IsFacetCollapsed(v) and not HasDoorVerts then
		a["?ptr"] = nil
		return
	end
	
	local t = {Vertexes = v}
	t.Bitmap = (a.BitmapId >= 0 and Game.BitmapsLod.Bitmaps[a.BitmapId].Name or nil)
	if Map.IsOutdoor() then
		ReadFacetData(a, t, a)
	elseif a.HasData then
		ReadFacetData(Map.FacetData[a.DataIndex], t, a)
	end
	for k in pairs(Editor._FacetBits) do
		t[k] = a[k]
	end
	t.MoveByDoor = a.MoveByDoor
	
	local okMul = 0.99
	local nx, ny, nz = normalize(a.NormalX, a.NormalY, a.NormalZ)
	Editor.FindNormal(t, true)
	local mulBefore = t.ndist and t.nx*nx + t.ny*ny + t.nz*nz or -2
	ShiftVertexes(true, t, {})
	t.ndist = nil
	Editor.FindNormal(t, true)
	local mulAfter = t.ndist and t.nx*nx + t.ny*ny + t.nz*nz or -2
	ShiftVertexes(false, t, {})
	if (mulBefore > okMul) ~= (mulAfter > okMul) or (mulBefore > 0) ~= (mulAfter > 0) then
		for _, v in ipairs(v) do
			if v.Shift then
				v.Shift.Delete = (mulBefore > mulAfter) and 1 or nil
			end
		end
	end
	
	if mulBefore > okMul then
		Editor.FindNormal(t, true)
	elseif mulAfter > okMul then
		local v = v[1]
		t.ndist = -(v.X*t.nx + v.Y*t.ny + v.Z*t.nz)
	else
		t.ndist = nil
	end
	if not t.ndist or abs(t.ndist*0x10000 - a.NormalDistance) > 1 then
		t.nx, t.ny, t.nz = nx, ny, nz
		t.ndist = a.NormalDistance/0x10000
	end
	t.PartOf = t
	if t.IsPortal then
		t.Room = a.Room
		t.RoomBehind = a.RoomBehind
	end
	
	if Editor.ExactMode then
		t.ExactData = MakeExact(a)
	end
	
	if mmver == 6 and t.Untouchable and not t.Invisible and nz ~= 0 then
		t.UntouchableMM6 = true
		t.Untouchable = nil
	end
	
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- JoinFacets
-----------------------------------------------------

local function SameNormal(t, q)
	local x = t.nx - q.nx
	local y = t.ny - q.ny
	local z = t.nz - q.nz
	return x*x + y*y + z*z < 0.01^2
end

local function IsFacetDifferent(t, q)
	for k, v in pairs(t) do
		if k ~= "PartOf" and k ~= "Vertexes" and k ~= "Id" and k ~= "nx" and k ~= "ny" and k ~= "nz" and k ~= "ndist" and v ~= q[k] then
			return k
		end
	end
end

local function CompareFacets(t, q)
	return SameNormal(t, q) and FacetDoorIdx[t] == FacetDoorIdx[q] and not IsFacetDifferent(t, q) and not IsFacetDifferent(q, t)
end

local function BaseFacet(f)
	while f and f.PartOf ~= f do
		f = f.PartOf
	end
	return f
end

local function JoinFacets()
	local FacetIds = Editor.FacetIds
	local get = Editor.EdgeFacets({{Facets = FacetIds}})
	for a, id in pairs(FacetIds) do
		repeat
			local vert = a.Vertexes
			local n = #vert
			for i, v in ipairs(vert) do
				local f, n1 = nil, 0
				for f1 in pairs(get(v, vert[i % n + 1])) do
					f = (f ~= a and f or BaseFacet(f1))
					n1 = n1 + 1
				end
				if n1 == 2 and f ~= a and CompareFacets(a, f) then
					a.Vertexes = Editor.JoinFacetVertexes(vert, f.Vertexes)
					if not a.Vertexes or Editor.FindNormal(a, true) or a.Cancave then
						a.Vertexes = vert
						Editor.FindNormal(a, true)
					else
						f.PartOf = a
						Facets[FacetIds[f] + 1] = nil
						FacetIds[f] = nil
						break
					end
				end
			end
		until vert == a.Vertexes
	end
end

-----------------------------------------------------
-- ReadRoom
-----------------------------------------------------

local function ReadRoom(a, t, n)
	a["?ptr"] = a["?ptr"]  -- speed up
	-- t.Facets = KeysList(a.DrawFacets, Facets, {})
	local NonBSP = a.NonBSPDrawFacetsCount
	t.Facets = {}
	t.DrawFacets = {}
	local map = {}
	for i, id in a.DrawFacets do
		local f, mf = Facets[id + 1], Map.Facets[id]
		if f and (mf.Room == n or mf.RoomBehind == n) then
			t.Facets[f] = id
			map[i] = #t.DrawFacets
			t.DrawFacets[#t.DrawFacets + 1] = f
		end
		if i == NonBSP - 1 then
			NonBSP = #t.DrawFacets
		end
	end

	local function ReadBSP(ni)
		if ni < 0 then
			return nil
		end
		local a = Map.BSPNodes[ni]
		local n, m, off = 0, 0, nil  -- n = full count, m = non-empty count 
		for i = a.CoplanarOffset, a.CoplanarOffset + a.CoplanarSize - 1, 1 do
			local o = map[i]
			if o then
				n = n + 1
				off = off or o
				if #t.DrawFacets[o + 1].Vertexes > 2 then
					m = m + 1
				end
			end
		end
		local t = {CoplanarOffset = off, Front = ReadBSP(a.FrontNode), Back = ReadBSP(a.BackNode)}
		if t.Front == false or t.Back == false then
			return false
		elseif not off then
			return not t.Back and t.Front or not t.Front and t.Back
		elseif m == 0 and not (t.Back and t.Front) then
			return t.Back or t.Front
		end
		t.CoplanarSize = n
		return t
	end
	
	t.BSP = false
	if a.HasBSP then
		t.BSP = ReadBSP(a.FirstBSPNode) or nil
		if not t.BSP then
			print('failed to keep BSP:', Map.Name, n)
		end
	end
	t.NonBSP = t.BSP and NonBSP or #t.DrawFacets
	
	--KeysList(a.Floors, Facets, t.Facets)
	-- t.Sprites = KeysList(a.Sprites, Sprites, {})
	-- t.Lights = KeysList(a.Lights, Lights, {})
	t.Darkness = a.Darkness
	t.EaxEnvironment = a.EaxEnvironment
	if t.EaxEnvironment == 0 then
		t.EaxEnvironment = nil
	end
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- ReadOutline
-----------------------------------------------------

local function ReadOutline(a, t)
	t.Vertex1 = Vertexes[a.Vertex1]
	t.Vertex2 = Vertexes[a.Vertex2]
	t.Facet1 = Facets[a.Facet1 + 1]
	t.Facet2 = Facets[a.Facet2 + 1]
	t.Z = a.Z
	return t
end

-----------------------------------------------------
-- ReadSprite
-----------------------------------------------------

local SpriteProps = table.copy(const.SpriteBits, {
	DecName = true,
	X = true,
	Y = true,
	Z = true,
	Direction = true,
	Id = true,
	Event = true,
	TriggerRadius = true,
})

local function ReadSprite(a, t)
	a["?ptr"] = a["?ptr"]  -- speed up
	for k in pairs(SpriteProps) do
		t[k] = a[k]
	end
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- ReadLight
-----------------------------------------------------

local LightProps = {
	X = true,
	Y = true,
	Z = true,
	Radius = true,
	-- Brightness = true,
	-- Bits
	Off = true,
	-- MM7
	R = true,
	G = true,
	B = true,
	-- MM8
	Id = true,
}

local function ReadLight(a, t)
	a["?ptr"] = a["?ptr"]  -- speed up
	for k in pairs(LightProps) do
		t[k] = a[k]
	end
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- ReadSpawn
-----------------------------------------------------

local SpawnProps = {
	X = true,
	Y = true,
	Z = true,
	Radius = true,
	Kind = true,
	Index = true,
	-- Bits
	OnAlertMap = true,
	-- MM7
	Group = true,
}

local function ReadSpawn(a, t)
	a["?ptr"] = a["?ptr"]  -- speed up
	for k in pairs(SpawnProps) do
		t[k] = a[k]
	end
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- Editor.ResetDoors
-----------------------------------------------------

function Editor.ResetDoor(t)
	for i, fi in t.FacetIds do
		assert(fi < Map.Facets.count)
		local f = Map.Facets[fi]
		if f.HasData then
			local fd = Map.FacetData[f.DataIndex]
			fd.BitmapU = t.FacetStartU[i]
			fd.BitmapV = t.FacetStartV[i]
		end
	end
	for i, vi in t.VertexIds do
		local v = Map.Vertexes[vi]
		v.X = t.VertexStartX[i]
		v.Y = t.VertexStartY[i]
		v.Z = t.VertexStartZ[i]
	end
	if t.State == 2 then
		t.State = 1
		t.SilentMove = true
	end
	Editor.NeedDoorsUpdate = true
end

function Editor.ResetDoors()
	for _, t in Map.Doors do
		Editor.ResetDoor(t)
	end
	-- local states = {}
	-- local times = {}
	-- for i, t in Map.Doors do
		-- if t.State ~= 0 then
			-- times[i], t.TimeStep = t.TimeStep, 15360
			-- states[i], t.State = t.State, 3
		-- end
	-- end
	-- Editor.ProcessDoors()
	-- for i, t in Map.Doors do
		-- if states[i] == 2 then
			-- t.TimeStep = 15360
			-- t.State = 1
		-- elseif states[i] then
			-- t.TimeStep = times[i]
			-- t.State = states[i] == 2 and 1 or states[i]
		-- end
	-- end
end

-----------------------------------------------------
-- ReadDoor
-----------------------------------------------------

-- local function VerToNum(v)
-- 	return v.X % 0x10000 + (v.Y % 0x10000)*0x10000 + (v.Z % 0x10000)*0x100000000
-- end

-- local function DoorCheckFree(t, ver, fac)
-- 	do return end  -- doesn't work right yet
-- 	local fac2, include, exclude = {}, {}, {}
-- 	for _, f in pairs(Facets) do
-- 		local need = fac[f]
-- 		if need and not f.MoveByDoor and not f.IsPortal then
-- 			need = false
-- 			for _, v in ipairs(f.Vertexes) do
-- 				if ver[v] then
-- 					need = true
-- 					break
-- 				end
-- 			end
-- 		end
-- 		if need then
-- 			fac2[f] = true
-- 		end
-- 		if not f.IsPortal then
-- 			for _, v in ipairs(f.Vertexes) do
-- 				(need and include or exclude)[v] = true
-- 				if not need and (not v.Shift or v.Shift.Delete) then
-- 					exclude[VerToNum(v)] = true
-- 				end
-- 			end
-- 		end
-- 	end
-- 	-- check
-- 	for v in pairs(include) do
-- 		if not ver[v] and not exclude[v] and (v.Shift and not v.Shift.Delete or not exclude[VerToNum(v)]) then
-- 			return
-- 		end
-- 	end
-- 	for v in pairs(ver) do
-- 		if exclude[v] or (not v.Shift or v.Shift.Delete) and exclude[VerToNum(v)] then
-- 			return
-- 		end
-- 	end
-- 	t.VertexFilter = "Free"
-- 	return fac2
-- end

local function DoorCheckShrink(t, ver, fac)
	local fac2, include, exclude = {}, {}, {}
	for _, f in pairs(Facets) do
		local need = fac[f]
		if need and not f.MoveByDoor and not f.IsPortal then
			need = false
			for _, v in ipairs(f.Vertexes) do
				if ver[v] then
					need = true
					break
				end
			end
		end
		if need then
			fac2[f] = true
		end
	end
	local dirX, dirY, dirZ = t.DirectionX, t.DirectionY, t.DirectionZ
	
	local range, full = {1/0, -1/0}, {1/0, -1/0}  -- included range, full range
	local function use(t, x)
		t[1] = min(t[1], x)
		t[2] = max(t[2], x)
	end
	for f in pairs(fac2) do
		for _, v in ipairs(f.Vertexes) do
			local x = v.X*dirX + v.Y*dirY + v.Z*dirZ
			use(full, x)
			if ver[v] then
				use(range, x)
			end
		end
	end
	
	local below, above = -1/0, 1/0
	for f in pairs(fac2) do
		for _, v in ipairs(f.Vertexes) do
			if not ver[v] then
				local x = v.X*dirX + v.Y*dirY + v.Z*dirZ
				if x < range[1] then
					below = max(below, x)
				else
					above = min(above, x)
				end
			end
		end
	end
	
	if below > range[1] - 0.5 or above < range[2] + 0.5 then
		return
	end
	local function inv(t)
		t[1], t[2] = -t[2], -t[1]
	end
	if below == -1/0 and above ~= 1/0 then
		t.VertexFilter = "Shrink"
		inv(range)
		inv(full)
		below, above = -above, -below
	else
		t.VertexFilter = "Grow"
	end
	local x0, L, mid = full[1], full[2] - full[1], (full[2] + full[1])/2
	if L < 0.49 then
		t.VertexFilterParam1 = -1  -- include all (below/above are empty)
	elseif above ~= 1/0 or mid - below < 0.5 or range[1] - mid < 0.5 then
		t.VertexFilterParam1 = below ~= -1/0 and ((range[1] + below)/2 - x0)/L or -1
		t.VertexFilterParam2 = above ~= 1/0 and ((range[2] + above)/2 - x0)/L or nil
	end
	return fac2
end

local function SetShiftFilter(t, ver)
	t.VertexFilter = "CheckShift"
	for v in pairs(ver) do
		v.Shift.Delete = nil
	end
end

local DoorProps = {
	Id = true,
	MoveLength = true,
	Speed1 = true,
	Speed2 = true,
	NoSound = true,
	StartState2 = true,
}
local function ReadDoor(a, t)
	a["?ptr"] = a["?ptr"]  -- speed up
	for k in pairs(DoorProps) do
		t[k] = a[k]
	end
	t.DirectionX = a.DirectionX/0x10000
	t.DirectionY = a.DirectionY/0x10000
	t.DirectionZ = a.DirectionZ/0x10000
	local dirX, dirY, dirZ = normalize(t.DirectionX, t.DirectionY, t.DirectionZ)
	local ver = {}
	local fac = {}
	for _, i in a.VertexIds do
		ver[Vertexes[i]] = true
	end
	for _, i in a.FacetIds do
		fac[Facets[i + 1] or fac] = true
	end
	fac[fac] = nil
	fac = DoorCheckShrink(t, ver, fac) or fac
	for _, f in pairs(Facets) do
		if fac[f] then
			local num, ismover = 0, true
			for _, v in ipairs(f.Vertexes) do
				if ver[v] then
					num = num + 1
				else
					ismover = false
				end
			end
			if num == 0 or not t.VertexFilter and not ismover and abs(f.nx*dirX + f.ny*dirY + f.nz*dirZ) > Editor.DoorMinCos then
				--
			elseif f.IsPortal then
				t.ClosePortal = true
			elseif f.Door then
				f.MultiDoor = true
			else
				f.Door = t
				f.MovedByDoor = ismover or nil
				f.DoorStaticBmp = not f.MoveByDoor or nil
			end
		end
	end
	
	-- check if the door is problematic
	if Editor.ExactMode == 2 then
		SetShiftFilter(t, ver)
		t.ExactFacets = fac
		t.ExactVertexes = KeysList(a.VertexIds, Vertexes, {})
	elseif not t.VertexFilter then
		local v2 = Editor.GetDoorVertexLists(t)
		for v in pairs(ver) do
			if not v2[v] then
				SetShiftFilter(t, ver)
				break
			end
		end
	-- elseif t.VertexFilter == "Free" then
	-- 	local v2 = Editor.GetDoorVertexLists(t)
	-- 	for v in pairs(v2) do
	-- 		if not ver[v] then
	-- 			SetShiftFilter(t, ver)
	-- 			break
	-- 		end
	-- 	end
	end
	
	a["?ptr"] = nil

	return t
end

-----------------------------------------------------
-- ReadChest
-----------------------------------------------------

local ItemProps = {
	Number = true,
	Bonus = true,
	BonusStrength = true,
	Bonus2 = true,
	Charges = true,
	Identified = true,
	Broken = true,
	-- TemporaryBonus = true,
	Stolen = true,
	Hardened = true,
	MaxCharges = true,
	-- Owner = true,
	-- BonusExpireTime = true,
}

local function ReadChestItem(a, t)
	a["?ptr"] = a["?ptr"]  -- speed up
	mem.fill(Editor.DummyItem)
	Editor.ItemInitSpecial(Editor.DummyItem, a.Number)
	Editor.DummyItem.Number = 0
	for k in pairs(ItemProps) do
		if a[k] and a[k] ~= Editor.DummyItem[k] then
			t[k] = a[k]
		end
	end
	a["?ptr"] = nil
	if not next(t, next(t)) then
		return t.Number
	end
	return t
end

local ChestProps = {
	ChestPicture = true,
	Trapped = true,
	Identified = true,
}

local function ReadChest(a, t)
	for k in pairs(ChestProps) do
		t[k] = a[k]
	end
	t.Items = {}
	for _, it in a.Items do
		if it.Number ~= 0 then
			t.Items[#t.Items + 1] = ReadChestItem(it, {})
		end
	end
	return t
end

-----------------------------------------------------
-- ReadObject
-----------------------------------------------------

local ObjectProps = {
	X = true,
	Y = true,
	Z = true,
	-- Visible = true,
}

local function ReadObject(a, t)
	if a.Item.Number == 0 or a.Missile or a.Removed then
		return
	end
	for k in pairs(ObjectProps) do
		t[k] = a[k]
	end
	t.Item = {}
	ReadChestItem(a.Item, t.Item)
	return t
end

-----------------------------------------------------
-- ReadMonster
-----------------------------------------------------

local MonsterAttackProps = {
	Type = true,
	DamageDiceCount = true,
	DamageDiceSides = true,
	DamageAdd = true,
	Missile = true,
}

local MonsterProps = {
	
	Id = true,
	X = true,
	Y = true,
	Z = true,
	Direction = true,
	Group = true,
	Ally = true,
	NameId = true,
	Name = true,
	FullHitPoints = true,
	Level = true,
	ArmorClass = true,
	Experience = true,
	TreasureItemPercent = true,
	TreasureDiceCount = true,
	TreasureDiceSides = true,
	TreasureItemLevel = true,
	TreasureItemType = true,
	Item = true,
	NPC_ID = mmver > 6 or nil,

	Fly = true,
	MoveType = true,
	MoveSpeed = true,
	AIType = true,
	Hostile = true,
	HostileType = true,
	OnAlertMap = true,
	ShowOnMap = true,
	Invisible = true,
	NoFlee = true,
	
	Attack1 = MonsterAttackProps,
	Attack2 = MonsterAttackProps,
	Attack2Chance = true,
	RangeAttack = true,
	AttackRecovery = true,
	
	Spell = true,
	SpellChance = true,
	SpellSkill = true,
	Spell2 = true,
	Spell2Chance = true,
	Spell2Skill = true,

	Bonus = true,
	BonusMul = true,
	
	FireResistance = true,
	ColdResistance = true,
	ElecResistance = true,
	PoisonResistance = true,
	MagicResistance = true,
	AirResistance = true,
	WaterResistance = true,
	EarthResistance = true,
	MindResistance = true,
	SpiritResistance = true,
	BodyResistance = true,
	LightResistance = true,
	DarkResistance = true,
	PhysResistance = true,
	
	Special = true,
	SpecialA = true,
	SpecialB = true,
	SpecialC = true,
	SpecialD = true,

	Prefers = const.MonsterPref,
	PrefNum = true,
	
	GuardX = true,
	GuardY = true,
	GuardZ = true,
	GuardRadius = true,
}
Editor.MonsterProps = MonsterProps

local function ReadMonProps(a, t, m0, props, prefix)
	for k, props in pairs(props) do
		local v = a[k]
		if type(props) == "table" then
			ReadMonProps(v, t, m0[k], props, prefix..k)
		elseif v ~= m0[k] then
			t[prefix..k] = v
		end
	end
	-- t.BinData = mem.string(a["?ptr"], a["?size"], true)
end

local function ReadMonster(a, t)
	if a.AIState == const.AIState.Removed then
		return
	end
	-- if a.Invisible or a.AIState == const.AIState.Invisible then
	-- 	print(Map.Name, a.AIState == const.AIState.Invisible, a.Invisible)
	-- end
	-- monster for default values
	a["?ptr"] = a["?ptr"]  -- speed up
	t.Id = a.Id
	t.Direction = a.Direction
	local m0 = Editor.SummonMonster(t.Id, 0, 0, 0, true)
	m0.AIState = const.AIState.Removed
	ReadMonProps(a, t, m0, MonsterProps, "")
	XYZ(t, a.StartX, a.StartY, a.StartZ)
	for X in XYZ do
		if t["Guard"..X] == t[X] then
			t["Guard"..X] = nil
		end
	end
	a["?ptr"] = nil
	return t
end

-----------------------------------------------------
-- Editor.WriteListIds
-----------------------------------------------------

function Editor.WriteListIds()
	table.copy(Editor.ObjectIds, Editor.State.Objects, true)
	table.copy(Editor.MonsterIds, Editor.State.Monsters, true)
	table.copy(Editor.SpriteIds, Editor.State.Sprites, true)
	if not Editor.State.Rooms and Editor.State.Models then
		table.copy(Editor.ModelIds, Editor.State.Models, true)
		for m in pairs(Editor.ModelIds) do
			for f in pairs(m.Facets) do
				m.Facets[f] = Editor.FacetIds[f] % 64
			end
		end
	else
		table.copy(Editor.LightIds, Editor.State.Lights, true)
	end
end

-----------------------------------------------------
-- Editor.ReadMap
-----------------------------------------------------

local function ReadListEx(lst, ids, array, f, passId)
	for i, a in array do
		local t = f(a, {}, passId and i)
		lst[i + 1] = t
		if t then
			if Editor.ImportIndex then
				Editor.ImportIndex[t] = i
				Editor.ImportBin[t] = mem.string(a["?ptr"], a["?size"], true)
			end
			ids[t] = i
		end
	end
	return lst, ids
end
Editor.ReadListEx = ReadListEx

function Editor.ReadMapCommon(state)
	-- remove MoveByDoor
	for _, f in pairs(Editor.Facets) do
		f.MoveByDoor = nil
	end
	-- sprites
	Sprites = {}
	Editor.Sprites, Editor.SpriteIds = ReadListEx(Sprites, {}, Map.Sprites, ReadSprite)
	state.Sprites = table.copy(Editor.SpriteIds)
	-- spawns
	Editor.Spawns, Editor.SpawnIds = ReadListEx({}, {}, Map.Spawns, ReadSpawn)
	state.Spawns = boolcopy(Editor.SpawnIds)
	-- chests
	state.Chests = ReadListEx({}, {}, Map.Chests, ReadChest)
	-- objects
	Editor.Objects, Editor.ObjectIds = ReadListEx({}, {}, Map.Objects, ReadObject)
	state.Objects = table.copy(Editor.ObjectIds)
	-- monsters
	Editor.Monsters, Editor.MonsterIds = ReadListEx({}, {}, Map.Monsters, ReadMonster)
	state.Monsters = table.copy(Editor.MonsterIds)
end

function Editor.ReadMap()
	Editor.DoorCache = nil
	if not Map.IsIndoor() then
		return Editor.ReadOdm()
	end
	Editor.profile "ReadMap"
	Editor.ImportIndex = Editor.ImportIndex and setmetatable({}, {__mode = "k"})
	Editor.ImportBin = Editor.ImportIndex and setmetatable({}, {__mode = "k"})
	Editor.ResetDoors()
	-- separate door vertices, because otherwise they would collapse with other vertices in MM6
	InitVertexShifts()
	local state = {BaseInternalMap = Map.Name, Rooms = {}, RoomObj = {}}
	-- vertexes
	Vertexes = {}
	local UniqueVertex = Editor.AddUnique(state)
	for i, v in Map.Vertexes do
		v = {X = v.X, Y = v.Y, Z = v.Z, Shift = VertexShifts[i]}
		Vertexes[i] = UniqueVertex(v.X, v.Y, v.Z, v)
		if Editor.ExactMode == 2 and Vertexes[i] ~= v then
			print('Duplicate vertex:', i)
			VertexShifts[i] = {X = 0, Y = 0, Z = 0}
			v.Shift = VertexShifts[i]
			Vertexes[i] = UniqueVertex(v.X, v.Y, v.Z, v)
		end
	end
	if Editor.ExactMode == 2 then
		state.ExactVertexes = Vertexes
	end
	-- facets
	Facets = {}
	Editor.Facets, Editor.FacetIds = ReadListEx(Facets, {}, Map.Facets, Editor.ReadFacet)
	if mmver == 6 then
		CompatibleIds(Editor.FacetIds)
	end
	-- join facets
	-- InitFacetDoorIdx()
	-- JoinFacets()
	-- remove useless vertices
	-- lights
	Lights = {}
	Editor.Lights, Editor.LightIds = ReadListEx(Lights, {}, Map.Lights, ReadLight)
	state.Lights = table.copy(Editor.LightIds)
	if mmver < 8 then
		CompatibleIds(Editor.LightIds)
	end
	-- rooms
	local dark = {}
	for i, a in Map.Rooms do
		local t = ReadRoom(a, {}, i)
		t.BaseFacets = t.Facets
		state.Rooms[i + 1] = t
		state.RoomObj["Room"..i] = t
		dark[#dark + 1] = t.Darkness
	end
	table.sort(dark)
	state.DefaultDarkness = dark[(#dark + 1):div(2)]  -- median darkness
	for _, t in ipairs(state.Rooms) do
		if t.Darkness == state.DefaultDarkness then
			t.Darkness = nil
		end
	end
	-- doors
	Editor.State = state
	Editor.Doors, Editor.DoorIds = ReadListEx({}, {}, Map.Doors, ReadDoor)
	-- outlines
	state.Outlines = ReadListEx({}, {}, Map.Outlines, ReadOutline)
	state.OutlineFlatSkip = 1
	-- other properties
	Editor.ReadMapCommon(state)
	-- remove unused vertex shifts
	CleanVertexShifts()
	-- read sprite and light lists
	if Editor.ExactMode then
		state.ExactRoomSprites = {}
		state.ExactRoomLights = {}
		for i, a in Map.Rooms do
			local t = state.Rooms[i + 1]
			state.ExactRoomSprites[t] = KeysList(a.Sprites, Sprites, {})
			state.ExactRoomLights[t] = KeysList(a.Lights, Lights, {})
		end
	end
	
	Editor.SetState(state)
	if Editor.ExactMode ~= 2 then
		Editor.AddUnique()
	end
	Editor.DefaultFileName = (Editor.MapsDir or "")..path.setext(Map.Name, '.dat')
	-- Editor.ProcessDoors()
	Editor.profile(nil)
end
