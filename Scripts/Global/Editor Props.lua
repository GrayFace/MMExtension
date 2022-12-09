local ReadLodTextTable = ReadLodTextTable or function() end

Editor = Editor or {}
local _KNOWNGLOBALS

local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min

local skSpawn = 1
local skObject = 2
local skMonster = 3
local skSprite = 5
local skFacet = 6
local skLight = 7

-----------------------------------------------------
-- Props
-----------------------------------------------------

local mmver = Game.Version

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local IsXYZ = {
	X = true,
	Y = true,
	Z = true,
}

local function mm7(s)
	return mmver >= 7 and s
end

local function mm8(s)
	return mmver >= 8 and s
end

local function mm6o(s)
	return mmver == 6 and s
end

local function mm7o(s)
	return mmver == 7 and s
end

local mm8o = mm8

local function mm67(s)
	return mmver < 8 and s
end

local function tostr(s)
	s = tostring2(s)
	return s == "-0" and "0" or s
end

local function FindConst(name, v)
	local a = table.find(const[name], v)
	return a and "const."..name.."."..a
end

local function GetFromArray(arr, n, name)
	if n >= arr.low and n <= arr.high then
		return (name and arr[n][name] or arr[n])
	end
end

local COMMENT = "      --"


local Updates = {}
function Editor.Update(f)
	Updates[f] = true
end

local CurrentProps
local NoUndo
local PropsChanged

local function AddUndoCall(props, f, ...)
	PropsChanged = true
	if NoUndo then
		NoUndo = false
		return
	end
	local undo = props.undo and props.undo(f, ...)
	if not undo then
		local par = {...}
		function undo()
			f(unpack(par))
		end
	end
	Editor.AddUndo(undo, props.done)
	return ...
end

local function AddUndoProp(id, prop, val)
	AddUndoCall(CurrentProps, CurrentProps.set, id, prop, val)
end

local function AddSelectionCalls(props, sel, kind)
	local f = props.select or function(id)
		Editor.Selection[id] = true
	end
	for id in pairs(sel) do
		AddUndoCall(props, f, id)
	end
	Editor.AddUndo(function()
		Editor.ClearSelection()
		Editor.SelectionKind = kind
	end)
end

local function ClearListId(t, ref, id, SetId, prop)
	for a, v in pairs(t) do
		if v == id then
			AddUndoProp(ref[a], prop or "Index", id)
			t[a] = true
			if SetId then
				a.Id = true
			end
			return
		end
	end
end

local function MakeProps(t)
	for i = #t, 1, -1 do
		if not t[i] then
			table.remove(t, i)
		end
	end
	
	local done = t.done
	function t.done()
		if done then
			done()
		end
		for f in pairs(Updates) do
			Updates[f] = nil
			f()
		end
	end
	
	local create = t.create
	function t.create(...)
		CurrentProps = t
		Editor.AddUndo()
		return AddUndoCall(t, t.delete, create(...))
	end
	
	local delete = t.delete
	function t.delete(...)
		CurrentProps = t
		Editor.AddUndo()
		return AddUndoCall(t, t.create, delete(...))
	end
	
	local il, IndexSetId = t.IndexList, t.IndexSetId
	local get = t.get
	function t.get(id, prop, val, ...)
		CurrentProps = t
		if prop == "Index" and il then
			local ret = Editor.State[il][Editor[il][id + 1]]
			return ret ~= true and ret or nil
		end
		return get(id, prop, val, ...)
	end
	
	local set = t.set
	function t.set(id, prop, val, ...)
		CurrentProps = t
		Party.NeedRender = true
		if prop == "Index" and il then
			local t, OldVal = Editor[il][id + 1], CurrentProps.get(id, prop)
			AddUndoProp(id, prop, OldVal)
			val = tonumber(val)
			if val then
				ClearListId(Editor.State[il], Editor[il:sub(1, -2).."Ids"], val, IndexSetId)
			end
			if IndexSetId then
				t.Id = val
			end
			Editor.State[il][t] = val or true
		else
			set(id, prop, val, ...)
		end
	end
	
	t.GetExcluded = t.GetExcluded or function() end
	
	return t
end

local function Remapper(name)
	return function(f, id, ...)
		if type(id) ~= "number" then
			return
		end
		-- if the 1st parameter is a number, it's considered an ID and will be remapped
		local par = {...}
		local obj = Editor[name.."s"][id + 1]
		return function()
			local id = Editor[name.."Ids"][obj]
			if id then
				f(id, unpack(par))
			end
		end
	end
end

-----------------------------------------------------
-- FacetProps
-----------------------------------------------------

local FacetBits = table.copy(const.FacetBits, {
	DontShowOnMap = true,
	DoorStaticBmp = true,
	MovedByDoor = true,
	MultiDoor = true,
	UntouchableMM6 = true,
}, true)

local IsFacetDataProp = {
	BitmapU = true,
	BitmapV = true,
	Id = true,
	Event = true,
}

local IsFacetAlignProp = {
	AlignLeft = "BitmapU",
	AlignRight = "BitmapU",
	AlignTop = "BitmapV",
	AlignBottom = "BitmapV",
	-- return standard U, V coordinates after scrolling is stopped:
	IsSky = "BitmapV",  -- outdoor
	ScrollUp = "BitmapV",
	ScrollDown = "BitmapV",
	ScrollLeft = "BitmapU",
	ScrollRight = "BitmapU",
}
table.copy(IsFacetAlignProp, FacetBits, true)
table.copy(IsFacetAlignProp, IsFacetDataProp, true)

local FacetUpdateDoors = {}
local FacetUpdateMap

local function FacetRemapper(f, id, ...)
	if type(id) ~= "number" then
		return
	end
	local par = {...}
	local obj = Editor.Facets[id + 1].PartOf
	return function()
		for t, id in pairs(Editor.FacetIds) do
			if t.PartOf == obj then
				f(id, unpack(par))
			end
		end
	end
end

local function GetFacets(id)
	return Map.IsIndoor() and Editor.State.Rooms[Map.GetFacet(id).Room + 1].Facets or Editor.Models[id:div(64) + 1].Facets
end

-- tricky: facet can be split, need to return multiple indeces
local function GetFacetIndex(id, a)
	local t = {}
	for f, i in pairs(GetFacets(id)) do
		if f.PartOf == a.PartOf then
			i = (i ~= true and i >= 0 and i or -1)
			t[#t + 1] = i
		end
	end
	table.sort(t)
	if t[#t] == -1 then
		return nil
	elseif #t == 1 then
		return t[1]
	end
	return t, "{"..table.concat(t, ", "):gsub("%-1", "nil").."}"
end

-- tricky: facet can be split
local function SetFacetIndex(id, prop, val, t)
	local OldVal, Facets, Facets2 = CurrentProps.get(id, prop), GetFacets(id)
	if type(OldVal) == "table" then
		local HasIds = table.invert(OldVal)
		OldVal = Facets[t]
		val = (type(val) == "table" and val or {val})
		for i, v in pairs(val) do
			if v == OldVal then
				return
			elseif not HasIds[v] then
				val = v
			end
		end
	elseif type(val) == "table" then
		val, val[1] = val[1], nil
	end
	val = tonumber(val)
	if val == OldVal then
		return
	end
	AddUndoProp(id, "Index", OldVal)
	local SetId = (mmver == 6 and Map.IsIndoor())
	if val then
		ClearListId(Facets, Editor.FacetIds, val, SetId)
	end
	if SetId then
		t.Id = val
	end
	Facets[t] = val or true
end

local function GetModelIndex(id)
	local ret = Editor.State.Models[Editor.Models[id:div(64) + 1]]
	return ret ~= true and ret or nil
end

local ModelIds = setmetatable({}, {__index = function(_, m)
	return Editor.FacetIds[next(m.Facets)]
end})

local function SetModelIndex(id, prop, val)
	local OldVal = CurrentProps.get(id, prop)
	AddUndoProp(id, prop, OldVal)
	val = tonumber(val)
	local t = Editor.Models[id:div(64) + 1]
	if val then
		ClearListId(Editor.State.Models, ModelIds, val, false, prop)
	end
	Editor.State.Models[t] = val or true
end

local function NeedFacetData(a, id)
	local d = Map.IsOutdoor() and a or a.HasData and Map.FacetData[a.DataIndex]
	if not d then
		local n = Map.FacetData.count
		mem.resizeArrayMM(Map.FacetData, n + 1)
		d = Map.FacetData[n]
		d.FacetIndex = id
		a.DataIndex = n
		a.HasData = true
	end
	return d
end

local FacetProps = MakeProps{
	"Bitmap",
	"BitmapU",
	"BitmapV",
	
	mm6o "Index",
	mm6o "ModelIndex",
	mm7 "Id",
	
	"Event",
	"TriggerByClick",
	"TriggerByStep",
	mm6o "TriggerByMonster",
	mm6o "TriggerByObject",
	mm7o "TriggerByMonster",
	mm7o "TriggerByObject",
	mm7 "IsSecret",  -- show in red with Perception
	
	mm6o "UntouchableMM6",
	"Untouchable",
	"Invisible",
	"DontShowOnMap",
	
	"MovedByDoor",
	"DoorStaticBmp",
	"MultiDoor",
	"AlignTop",
	"AlignBottom",
	"AlignLeft",
	"AlignRight",
	
	"IsWater",
	"IsSky",
	mm7 "IsLava",
	mm7 "ScrollUp",
	"ScrollDown",
	mm7 "ScrollLeft",
	mm7 "ScrollRight",
	"AnimatedTFT",
	
	GetExcluded = function()
		return Map.IsIndoor() and {
			ModelIndex = true,
			ScrollDown = mmver == 6,  -- implemented through IsSky = true in MM6 outdoors
		} or {
			IsSky = true,
			IsLava = true,
			DoorStaticBmp = true,
			MovedByDoor = true,
			MultiDoor = true,
			DontShowOnMap = true,
		}
	end,
	
	get = function(id, prop)
		Editor.CheckLazyModels()
		local t = Editor.Facets[id + 1]
		if prop == "OBJ" then
			return t
		elseif prop == "Index" then
			return GetFacetIndex(id, t)
		elseif prop == "ModelIndex" then
			return GetModelIndex(id)
		end
		local ret = t[prop]
		if ret == nil then
			if prop == "BitmapU" or prop == "BitmapV" then
				ret = Editor["Import"..prop][id] or 0
			elseif prop ~= "Bitmap" then
				ret = not FacetBits[prop] and 0
			end
		end
		return ret
	end,
	
	set = function(id, prop, val)
		local a, t = Map.GetFacet(id), Editor.Facets[id + 1]
		if prop == "Index" then
			return SetFacetIndex(id, prop, val, t)
		elseif prop == "ModelIndex" then
			return SetModelIndex(id, prop, val)
		elseif (prop == "BitmapU" or prop == "BitmapV") and val == Editor["Import"..prop][id] then
			val = nil
		elseif prop == "Door" and t.Door then
			FacetUpdateDoors[t.Door] = true
		end
		Editor.CheckLazyModels()
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		t.PartOf[prop] = val
		if prop == "Bitmap" or prop == "AnimatedTFT" then
			if Editor.SelectFacetBitmapMode and Editor.Selection[id] then
				Editor.Selection[id] = true
			else
				Editor.LoadFacetBitmap(a, t)
			end
		elseif prop == "DontShowOnMap" then
			FacetUpdateMap = true
		elseif prop == "Door" or prop == "MovedByDoor" or prop == "DoorStaticBmp" then
			if t.Door then
				FacetUpdateDoors[t.Door] = true
				if mmver > 6 or not t.DoorStaticBmp then
					NeedFacetData(a, id)
				end
			end
		elseif Editor.ShowInvisible and (prop == "Invisible" or prop == "IsSky" and not Game.IsD3D) then
			-- do nothing
		elseif prop == "ScrollDown" and mmver == 6 then
			a.IsSky = val or false
		elseif not IsFacetDataProp[prop] then
			a[prop] = val or not FacetBits[prop] or 0
		else
			local d = NeedFacetData(a, id)
			if prop == "BitmapU" or prop == "BitmapV" then
				Editor["Update"..prop](t)
			elseif IsFacetAlignProp[prop] then
				a[prop] = val or false
				Editor["Update"..IsFacetAlignProp[prop]](t)
			else
				d[prop] = val
			end
		end
	end,

	done = function()
		if next(FacetUpdateDoors) then
			Editor.DoorCache = nil
		end
		Editor.RecreateDoors(FacetUpdateDoors)
		Editor.UpdateDoorsBounds(FacetUpdateDoors)
		FacetUpdateDoors = {}
		if FacetUpdateMap then
			Editor.UpdateOutlines()
		end
		FacetUpdateMap = nil
	end,
	
	select = function(id)
		Editor.SelectSingleFacet(id)
	end,
	
	undo = FacetRemapper,
	caption = " Facet properties:",
}

-----------------------------------------------------
-- DoorProps
-----------------------------------------------------

local IsDoorFilterProp = {
	VertexFilter = true,
	VertexFilterParam1 = true,
	VertexFilterParam2 = true,
}

local IsDoorDirProp = table.copy(IsDoorFilterProp, {
	DirectionX = true,
	DirectionY = true,
	DirectionZ = true,
	ClosePortal = true,
})

local IsDoorBSPProp = table.copy(IsDoorDirProp, {
	MoveLength = true,
})

local IsDoorUpdateProp = table.copy(IsDoorBSPProp, {
	Speed1 = true,
	Speed2 = true,
})

local IsDoorBit = {
	NoSound = true,
	StartState2 = true,
	ClosePortal = true,
}

local FirstSelDoor
local DoorsNeedBounds = {}
local DoorsNeedUpdate = {}

local function CalcMoveLength(t)
	local MaxLen = 64000
	local move = MaxLen
	local ver = Editor.GetDoorVertexLists(t)
	local function check(f, v1, v2)
		if not ver[v2] then
			for X in XYZ do
				local x = v1[X] - v2[X]
				if (x + t['Direction'..X]*move)*x < 0 then
					move = abs(x/t['Direction'..X])
				end
			end
		end
	end
	for f, id in pairs(Editor.FacetIds) do
		if f.Door == t or f.MultiDoor then
			for i, v in ipairs(f.Vertexes) do
				if ver[v] then
					check(f, v, f.Vertexes[i % #f.Vertexes + 1])
					check(f, v, f.Vertexes[(i - 2) % #f.Vertexes + 1])
				end
			end
		end
	end
	return move ~= MaxLen and move
end

local DoorProps = MakeProps{
	"Id",
	"Speed1",
	"Speed2",
	"MoveLength",
	"DirectionX",
	"DirectionY",
	"DirectionZ",
	"NoSound",
	"StartState2",
	"VertexFilter",
	"VertexFilterParam1",
	"VertexFilterParam2",
	"ClosePortal",

	get = function(id, prop)
		local t = Editor.Facets[id + 1].Door or FirstSelDoor
		if not t then
			t, FirstSelDoor = Editor.FindSelectedDoor()
			t = FirstSelDoor
		end
		if prop == "VertexFilter" then
			local ret = t and t[prop]
			return ret, ('%s%s (nil, "Free", "Shrink" or "Grow")'):format(tostring2(ret), COMMENT)
		elseif IsDoorFilterProp[prop] then
			return t and t[prop]
		end
		return t and t[prop] or not IsDoorBit[prop] and 0
	end,

	set = function(id, prop, val)
		local t = Editor.Facets[id + 1].Door
		if not t then
			return
		elseif prop == 'MoveLength' and not val then
			val = CalcMoveLength(t) or t.MoveLength or 128
		end
		if t[prop] == val then
			return
		end
		AddUndoProp(id, prop, t[prop])
		local a = Map.Doors[Editor.DoorIds[t]]
		t[prop] = val
		if IsDoorDirProp[prop] then
			-- a[prop] = (val*0x10000):round()
			DoorsNeedUpdate[t] = true
		else
			a[prop] = val
		end
		if IsDoorUpdateProp[prop] then
			Editor.NeedDoorsUpdate = true
			if a.State == 2 or a.State == 0 then
				a.TimeStep = 15360
				a.State = (a.State == 2 and 1 or 3)
				a.SilentMove = true
			end
			if IsDoorBSPProp[prop] then
				DoorsNeedBounds[t] = true
				Editor.InvalidateDoorBSP(a)
			end
		end
	end,
	
	done = function()
		Editor.RecreateDoors(DoorsNeedUpdate)
		DoorsNeedUpdate = {}
		FirstSelDoor = nil
		Editor.UpdateDoorsBounds(DoorsNeedBounds)
		DoorsNeedBounds = {}
	end,

	undo = FacetRemapper,
	caption = " Door properties:",
}

-----------------------------------------------------
-- ModelProps
-----------------------------------------------------

local CoordCache = {}

local function GetModelCoord(m, X)
	local t = m.BaseFacets
	if not CoordCache[X] then
		CoordCache[X] = setmetatable({}, {__mode = "k"})
	end
	local x = CoordCache[X][t]
	if x then
		return x
	end
	local m1, m2 = 1/0, -1/0
	for f in pairs(t) do
		for _, a in ipairs(f.Vertexes) do
			local v = a[X]
			if v < m1 then
				m1 = v
			end
			if v > m2 then
				m2 = v
			end
		end
	end
	if X == "Z" then
		x = m1
	else
		x = (m2 + m1)/2
	end
	x = round(x)
	if m['Lazy'..X] then
		x = x + m[X] - m['Lazy'..X]
	end
	CoordCache[X][t] = x
	return x
end
Editor.GetModelCoord = GetModelCoord

local ModelsToMove = {}

local ModelProps = MakeProps{
	"Name",
	"ObjName",
	"X",
	"Y",
	"Z",

	get = function(id, prop)
		local t = Editor.Models[id:div(64) + 1].PartOf
		if prop == "OBJ" then
			return t
		end
		return t[prop] or IsXYZ[prop] and GetModelCoord(t, prop) or ""
	end,

	set = function(id, prop, val)
		local t = Editor.Models[id:div(64) + 1].PartOf
		if prop == "Name" and t[prop] ~= val and Editor.State.ModelByName[val] then
			Editor.LastError = ("model called %q already exists"):format(val)
			Editor.LastErrorFacets = {}
			return
		end
		AddUndoProp(id, prop, t[prop])
		if t[prop] == val then
			return
		end
		if IsXYZ[prop] and val ~= nil then
			local last = t[prop] or GetModelCoord(t, prop)
			ModelsToMove[t] = ModelsToMove[t] or {}
			ModelsToMove[t][prop] = ModelsToMove[t][prop] or last
			t["Lazy"..prop] = t["Lazy"..prop] or last
			Editor.State.LazyModels = true
			if CoordCache[prop] then
				CoordCache[prop][t.BaseFacets] = nil
			end
		elseif prop == "Name" then
			Editor.State.ModelByName[t[prop]] = nil
			Editor.State.ModelByName[val] = t
		end
		t[prop] = val
	end,
	
	done = function()
		if not next(ModelsToMove) then
			return
		end
		for id, m in Map.Models do
			local t = Editor.Models[id + 1].PartOf
			local base = ModelsToMove[t]
			if base then
				local delta = {}
				for X in XYZ do
					delta[X] = (base[X] and t[X] and round(t[X]) - round(base[X]) or 0)
				end
				MoveModel(m, XYZ(delta))
			end
		end
		ModelsToMove = {}
	end,
	
	duplicate = function(t0, pos)
		local ret = {}
		for t in pairs(Editor.ModelIds) do
			if t.PartOf == t0 then
				ret[t] = true
			end
		end
		ret = Editor.DeepCopy(ret)
		if pos then
			t0 = next(ret).PartOf
			t0.LazyX = t0.LazyX or t0.X or GetModelCoord(t0, "X")
			t0.LazyY = t0.LazyY or t0.Y or GetModelCoord(t0, "Y")
			t0.LazyZ = t0.LazyZ or t0.Z or GetModelCoord(t0, "Z")
			table.copy(pos, t0, true)
			Editor.ProcessLazyModel(t0)
		end
		return ret
	end,
	
	create = function(t)
		Editor.AddModelUseUniqueName(next(t).PartOf)
		table.copy(t, Editor.State.Models, true)
		return Editor.CreateModels(t)*64
	end,

	delete = function(id)
		local t0 = Editor.Models[id:div(64) + 1].PartOf
		if t0 == nil then
			NoUndo = true
			return
		end
		Editor.CheckLazyModels()
		Editor.State.ModelByName[t0.Name] = nil
		local ret = {}
		for id, m in Map.Models do
			local t = Editor.Models[id + 1]
			if t.PartOf == t0 then
				ret[t] = true
				Editor.Models[id + 1] = {}
				Editor.ModelIds[t] = nil
				Editor.State.Models[t] = nil
				for t in pairs(t.Facets) do
					local id = Editor.FacetIds[t]
					Editor.FacetIds[t] = nil
					Editor.Facets[id + 1] = nil
				end
				mem.freeMM(m.Vertexes["?ptr"])
				mem.freeMM(m.Facets["?ptr"])
				mem.freeMM(m.Ordering["?ptr"])
				mem.freeMM(m.BSPNodes["?ptr"])
				mem.fill(m)
			end
		end
		return ret
	end,

	undo = FacetRemapper,
	caption = " Model properties:",
}

-- because changing vertex coordinates and facets UV coordinates takes time when many models are moved
-- also avoids errors accumulation
function Editor.CheckLazyModels()
	if not Editor.State or not Editor.State.LazyModels then
		return
	end
	-- update vertices and base facets
	for _, t in pairs(Editor.State.ModelByName) do
		Editor.ProcessLazyModel(t)
	end
	Editor.State.LazyModels = nil
end

function Editor.ProcessLazyModel(t)
	local dx = (t.LazyX and round(t.X) - round(t.LazyX) or 0)
	local dy = (t.LazyY and round(t.Y) - round(t.LazyY) or 0)
	local dz = (t.LazyZ and round(t.Z) - round(t.LazyZ) or 0)
	t.LazyX, t.LazyY, t.LazyZ = nil
	if dx == 0 and dy == 0 and dz == 0 then
		return
	end
	local vert = {}
	for f in pairs(t.BaseFacets) do
		local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections{
			NormalX = round(f.nx*0x10000),
			NormalY = round(f.ny*0x10000),
			NormalZ = round(f.nz*0x10000),
		}
		if f.BitmapU then
			f.BitmapU = f.BitmapU - (ux*dx + uy*dy + uz*dz)
		end
		if f.BitmapV then
			f.BitmapV = f.BitmapV - (vx*dx + vy*dy + vz*dz)
		end
		for _, v in ipairs(f.Vertexes) do
			vert[v] = true
		end
	end
	for f in pairs(t.Facets) do
		f.BitmapU = f.PartOf.BitmapU
		f.BitmapV = f.PartOf.BitmapV
	end
	for v in pairs(vert) do
		v.X = v.X + dx
		v.Y = v.Y + dy
		v.Z = v.Z + dz
	end
end

-- for import
function Editor.AddDeleteModelUndo(t0, state)
	local ret = {}
	for t in pairs((state or Editor.State).Models) do
		if t.PartOf == t0 then
			ret[t] = true
		end
	end
	Editor.AddUndo()
	AddUndoCall(ModelProps, ModelProps.create, ret)
end

-----------------------------------------------------
-- RoomProps
-----------------------------------------------------

local RoomProps = MakeProps{
	"Darkness",
	mm8 "EaxEnvironment",
	-- "Bits",
	
	get = function(id, prop)
		id = Map.GetFacet(id).Room
		return Editor.State.Rooms[id + 1][prop] or prop == "Darkness" and Editor.DefaultRoomDarkness or 0
	end,

	set = function(id, prop, val)
		id = Map.GetFacet(id).Room
		local a, t = Map.Rooms[id], Editor.State.Rooms[id + 1]
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		a[prop] = val
		Editor.Update(Editor.UpdateNoDark)
	end,
	
	undo = FacetRemapper,
	caption = " Room properties:",
}

-----------------------------------------------------
-- SpriteProps
-----------------------------------------------------

local IsSpriteLightProp = {
	DecName = true,
	X = true,
	Y = true,
	Z = true,
	Invisible = true,
}

local function DeleteSprite(id)
	local t = Editor.Sprites[id + 1]
	Editor.Sprites[id + 1] = nil
	Editor.SpriteIds[t] = nil
	Editor.State.Sprites[t] = nil
	Map.Sprites[id].Invisible = true
	Editor.Update(Editor.UpdateSpritesList)
	Editor.Update(Editor.UpdateSpriteLights)
	return t
end

local SpriteProps = MakeProps{
	"DecName",
	"X",
	"Y",
	"Z",
	"Direction",
	"Id",
	"Event",
	"TriggerRadius",
	"TriggerByTouch",
	"TriggerByMonster",
	"TriggerByObject",
	"ShowOnMap",
	"IsChest",
	"Invisible",
	mmver == 6 and "IsShip" or "IsObeliskChest",

	IndexList = "Sprites",
	
	get = function(id, prop)
		local a = Editor.Sprites[id + 1]
		if prop == "OBJ" then
			return a
		end
		local ret = a[prop]
		if ret == nil and prop ~= "DecName" then
			ret = not const.SpriteBits[prop] and 0
		end
		return ret
	end,

	set = function(id, prop, val)
		local a, t = Map.Sprites[id], Editor.Sprites[id + 1]
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		if prop ~= "Event" and (prop ~= "Invisible" or Editor.ShowInvisible) then
			a[prop] = val
		end
		if prop == "DecName" then
			Editor.NormalSpriteDec(a)
		end
		if IsSpriteLightProp[prop] then
			Editor.Update(Editor.UpdateSpriteLights)
		end
	end,

	create = function(t)
		return Editor.CreateSprite(t)
	end,
	
	delete = DeleteSprite,
	
	undo = Remapper "Sprite",
	HasDirection = true,
	caption = " Sprite properties:",
}

-----------------------------------------------------
-- LightProps
-----------------------------------------------------

local IsPosProp = {
	X = true,
	Y = true,
	Z = true,
}

local LightProps = MakeProps{
	"X",
	"Y",
	"Z",
	"Radius",
	mm67 "Index",
	mm8 "Id",
	-- Bits
	"Off",
	-- MM7
	mm7 "R",
	mm7 "G",
	mm7 "B",
	mm7 "Halo",
	
	IndexList = "Lights",
	IndexSetId = mmver < 8,
	
	get = function(id, prop)
		local a = Editor.Lights[id + 1]
		if prop == "OBJ" then
			return a
		elseif prop == "Halo" then
			return (a.Type or 5)%4 == 2
		end
		return a[prop] or prop ~= "Off" and 0
	end,

	set = function(id, prop, val)
		local t = Editor.Lights[id + 1]
		if prop == "Halo" then
			prop = "Type"
			val = (t.Type or 5):AndNot(3) + (val and 2 or 1)
		end
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		Map.Lights[id][prop] = val
	end,

	create = function(t)
		return Editor.CreateLight(t)
	end,

	delete = function(id)
		local t = Editor.Lights[id + 1]
		Editor.Lights[id + 1] = nil
		Editor.LightIds[t] = nil
		Editor.State.Lights[t] = nil
		Editor.Update(Editor.UpdateLightsList)
		return t
	end,
	
	undo = Remapper "Light",
	caption = " Light properties:",
}

-----------------------------------------------------
-- SpawnProps
-----------------------------------------------------

local PropM = {"m1", "m2", "m3", "m1a", "m2a", "m3a", "m1b", "m2b", "m3b", "m1c", "m2c", "m3c"}
local PropI = {"i1", "i2", "i3", "i4", "i5", "i6", "i7"}
local PropM1 = table.invert(PropM)
local PropI1 = table.invert(PropI)

local SpawnProps = MakeProps{
	"Kind",
	"X",
	"Y",
	"Z",
	"Radius",
	mm7 "Group",
	mm7 "OnAlertMap",
	
	get = function(id, prop, dispVal)
		local a = Editor.Spawns[id + 1]
		if prop == "OBJ" then
			return a
		end
		if prop == "Kind" then
			return a.Kind == skMonster and PropM[a.Index] or PropI[a.Index]
		end
		if dispVal and prop == "Z" and Map.IsOutdoor() then
			return max(a.Z or 0, Map.GetGroundLevel(a.X or 0, a.Y or 0))
		end
		local ret = a[prop] or prop ~= "OnAlertMap" and 0
		local comment = (prop == "Group" and ret > 0 and ReadLodTextTable("npcgroup.txt", ret + 2, 4))
		return ret, comment and ("%s%s (%s)"):format(ret, COMMENT, comment) or nil
	end,

	set = function(id, prop, val)
		local t = Editor.Spawns[id + 1]
		if prop == "Kind" then
			AddUndoProp(id, prop, CurrentProps.get(id, prop))
			if PropM1[val] then
				t.Kind = skMonster
				t.Index = PropM1[val]
			elseif PropI1[val] then
				t.Kind = skObject
				t.Index = PropI1[val]
			end
		else
			AddUndoProp(id, prop, t[prop])
			t[prop] = val
		end
	end,

	create = function(t)
		return Editor.CreateSpawn(t)
	end,

	delete = function(id)
		local t = Editor.Spawns[id + 1]
		Editor.Spawns[id + 1] = nil
		Editor.SpawnIds[t] = nil
		Editor.State.Spawns[t] = nil
		return t
	end,
	
	undo = Remapper "Spawn",
	caption = " Spawn properties:",
}

-----------------------------------------------------
-- ObjectProps
-----------------------------------------------------

local ObjectBits = {
	Identified = true,
	Broken = true,
	Stolen = true,
	Hardened = true,
	-- TemporaryBonus = true,
}

local IsObjectSelfProp = {
	X = true,
	Y = true,
	Z = true,
	-- Visible = true,
}

local IsObjectBonus = {
	Bonus = true,
	BonusStrength = true,
	Bonus2 = true,
}

local ObjectProps = MakeProps{
	"Number",
	"X",
	"Y",
	"Z",
	"Bonus",
	"BonusStrength",
	"Bonus2",
	"Charges",
	"MaxCharges",
	"Identified",
	"Broken",
	"Stolen",
	"Hardened",

	IndexList = "Objects",
	
	get = function(id, prop)
		local a = Editor.Objects[id + 1]
		if prop == "OBJ" then
			return a
		end
		if not IsObjectSelfProp[prop] then
			a = a.Item
		end
		local ret, comment = a[prop] or IsObjectBonus[prop] and Map.Objects[id].Item[prop] or not ObjectBits[prop] and 0, nil
		if prop == "Bonus" and ret > 0 then
			comment = ReadLodTextTable("stditems.txt", ret + 4, 1)
		elseif prop == "Bonus2" and ret > 0 then
			comment = ReadLodTextTable("spcitems.txt", ret + 4, 1)
		elseif prop == "Number" and ret > 0 then
			comment = GetFromArray(Game.ItemsTxt, ret, 'Name')
		end
		return ret, comment and ("%s%s (%s)"):format(ret, COMMENT, comment)
	end,

	set = function(id, prop, val)
		local a, t = Map.Objects[id], Editor.Objects[id + 1]
		if IsObjectSelfProp[prop] then
			AddUndoProp(id, prop, t[prop])
			t[prop] = val
			a[prop] = val
			a.Room = Map.RoomFromPoint(a)
		else
			AddUndoProp(id, prop, t.Item[prop])
			t.Item[prop] = val
			a.Item[prop] = val
		end
		if prop == "Number" or val == nil and IsObjectBonus[prop] then
			Editor.WriteObject(a, t)
		end
	end,
	
	create = function(t)
		return Editor.CreateObject(t)
	end,

	delete = function(id)
		local t = Editor.Objects[id + 1]
		Editor.Objects[id + 1] = nil
		Editor.ObjectIds[t] = nil
		Editor.State.Objects[t] = nil
		Map.Objects[id].TypeIndex = 0
		return t
	end,

	undo = Remapper "Object",
	caption = " Item properties:",
}

-----------------------------------------------------
-- MonsterProps
-----------------------------------------------------

local MonstersToUpdate = {}

local function GetDamage(count, sides, add)
	if count == 0 and add == 0 then
		return "0"
	elseif add == 0 then
		return ("%dD%d"):format(count, sides)
	end
	return ("%dD%d+%d"):format(count, sides, add)
end

local function ParseDamage(s, HasAdd)
	local n = tonumber(s)
	if n then
		if HasAdd then
			return 0, 1, n
		else
			return n, n ~= 0 and 1 or 0, 0
		end
	elseif type(s) ~= "string" then
		return
	end
	local count, sides, add = string.match(s, HasAdd and "^(%d+)[dD](%d+)[.+]?(%d*)$" or "^(%d+)[dD](%d+)$")
	count, sides, add = tonumber(count), tonumber(sides), tonumber(add) or 0
	if count and sides then
		return count, sides, add
	end
end

local function ParseDamageType(s)
	if type(s) == "number" then
		return s
	elseif type(s) ~= "string" then
		return
	end
	-- assert(type(s) == "string", "damage type must be a string or number")
	if mmver == 6 then
		local s2 = s:sub(1, 2):lower()
		local s1 = s2:sub(1, 1)
		if s2 == "el" then
			return 3
		elseif s1 == "e" then
			return 6
		elseif s1 == "p" and s2 ~= "ph" then
			return 5
		elseif s1 == "c" then
			return 4
		elseif s1 == "f" then
			return 2
		elseif s1 == "m" then
			return 1
		else
			return 0
		end
	else
		return mem.call(mmv(nil, 0x454CE0, 0x4524C5), 1, s)
	end
end

local DamageName = setmetatable(table.invert(const.Damage), {__index = function(t, v)
	return v
end})

-- It's complicated, because I map a 'Special' union onto a plain list of properties.
-- "shot: C = count\n"..
-- "summon: A = {RandomLevel = 0, fixed = 1}, B = {ground = 0, air = 1}; D = summoned monster"..
-- "explode: AdB + C, D = attack type")
local MonSpecialProps = {}

function MonSpecialProps.ShotCount(val)
	return 1, val, {A = 0, B = 0, C = tonumber(val) or 1, D = 0}, {C = 1}
end

function MonSpecialProps.SummonMonster(val)
	return 2, val, {C = 0, D = tonumber(val) or 0}, {D = 0}
end

function MonSpecialProps.SummonMonsterInAir(val)
	return 2, val, {B = (val and 1 or 0)}
end

function MonSpecialProps.SummonMonsterRandomStrength(val)
	return 2, val, {A = (val and 0 or 1)}
end

function MonSpecialProps.ExplodeDeath(val)
	local A, B, C = ParseDamage(val, true)
	return 3, val, {A = A or 0, B = B or 1, C = C or 0}, {A = 0, B = 1, C = 0}
end

function MonSpecialProps.ExplodeType(val)
	return 3, val, {D = ParseDamageType(val) or const.Damage.Fire}
end

local function MonSpecialDef(special)
	return {A = (special == 2 and 1 or 0), B = 0, C = 0, D = (special == 3 and const.Damage.Fire or 0)}
end

local MonsterProps = MakeProps{
	"Id",
	"X",
	"Y",
	"Z",
	"Direction",
	"Index",
	mm6o "Name",
	mm7 "NameId",
	mm7 "Group",
	"Hostile",
	"Ally",
	"FullHitPoints",
	"Level",
	"ArmorClass",
	"Experience",
	"TreasureGold",
	"TreasureItemPercent",
	"TreasureItemLevel",
	"TreasureItemType",
	"Item",
	mm7 "NPC_ID",

	"Invisible",
	mm7 "OnAlertMap",
	"ShowOnMap",
	"Fly",
	"MoveType",
	"MoveSpeed",
	"AIType",
	"HostileType",
	"NoFlee",

	"Attack1Damage",
	"Attack1Type",
	"Attack1Missile",
	"Attack2Chance",
	"Attack2Damage",
	"Attack2Type",
	"Attack2Missile",
	"RangeAttack",
	"AttackRecovery",

	"Spell",
	"SpellChance",
	"SpellSkill",
	mm7 "Spell2",
	mm7 "Spell2Chance",
	mm7 "Spell2Skill",

	"Bonus",
	"BonusMul",

	"FireResistance",
	mm6o "ColdResistance",
	mm6o "ElecResistance",
	mm6o "PoisonResistance",
	mm6o "MagicResistance",
	mm7 "AirResistance",
	mm7 "WaterResistance",
	mm7 "EarthResistance",
	mm7 "MindResistance",
	mm7 "SpiritResistance",
	mm7 "BodyResistance",
	mm7 "LightResistance",
	mm7 "DarkResistance",
	"PhysResistance",

	-- "Special",
	-- "SpecialA",
	-- "SpecialB",
	-- "SpecialC",
	-- "SpecialD",
	mm7 "ShotCount",
	mm7 "SummonMonster",
	mm7 "SummonMonsterInAir",
	mm7 "SummonMonsterRandomStrength",
	mm7 "ExplodeDeath",
	mm7 "ExplodeType",
	-- "shot: C = count\n"..
	-- "summon: A = {RandomLevel = 0, fixed = 1}, B = {ground = 0, air = 1}; D = summoned monster"..
	-- "explode: AdB + C, D = attack type")

	-- "Prefers = const.MonsterPref,
	-- "PrefNum",

	"GuardX",
	"GuardY",
	"GuardZ",
	"GuardRadius",

	IndexList = "Monsters",
	
	get = function(id, prop)
		local a, t = Map.Monsters[id], Editor.Monsters[id + 1]
		if prop == "OBJ" then
			return t
		end
		local ret, def, comment, retVal = nil, (t[prop] == nil), nil, nil
		if prop == "TreasureGold" then
			ret = GetDamage(a.TreasureDiceCount, a.TreasureDiceSides, 0)
			def = t.TreasureDiceCount == nil
		elseif prop == "Attack1Damage" or prop == "Attack2Damage" then
			local a = (prop == "Attack1Damage" and a.Attack1 or a.Attack2)
			ret = GetDamage(a.DamageDiceCount, a.DamageDiceSides, a.DamageAdd)
			def = t[prop.."DiceCount"] == nil
		elseif prop == "Attack1Type" or prop == "Attack2Type" then
			local a = (prop == "Attack1Type" and a.Attack1 or a.Attack2)
			ret = DamageName[a.Type]
		elseif prop == "Attack1Missile" or prop == "Attack2Missile" then
			ret = (prop == "Attack1Missile" and a.Attack1.Missile or a.Attack2.Missile)
		elseif MonSpecialProps[prop] then
			local special, _, vals, defval = MonSpecialProps[prop]()
			def = t.Special == nil
			for k, v in pairs(defval or vals) do
				ret = (a.Special == special and a["Special"..k] or v)
				def = def and t["Special"..k] == nil
			end
			def = def or a.Special ~= special
			if prop == "SummonMonster" and ret > 0 then
				comment = GetFromArray(Game.MonListBin, ret, 'Name')
			elseif prop == "SummonMonsterInAir" then
				ret = ret ~= 0
			elseif prop == "SummonMonsterRandomStrength" then
				ret = ret == 0
			elseif prop == "ExplodeDeath" then
				ret = a.Special == 3 and GetDamage(a.SpecialA, a.SpecialB, a.SpecialC) or 0
			elseif prop == "ExplodeType" then
				ret = a.Special == 3 and (DamageName[a.SpecialD] or a.SpecialD) or "Fire"
			end
		else
			ret = t[prop] or a[prop]
			if prop == "Ally" and ret > 0 and ret*3 - 2 < Game.MonListBin.count then
				comment = Game.MonListBin[ret*3 - 2].Name:match("^(.-) ?A?$")
			elseif prop == "Id" and ret > 0 then
				comment = GetFromArray(Game.MonListBin, ret, 'Name')
			elseif prop == "Group" and ret > 0 then
				comment = ReadLodTextTable("npcgroup.txt", ret + 2, 4)
			elseif prop == "Item" and ret > 0 then
				comment = GetFromArray(Game.ItemsTxt, ret, 'Name')
			elseif prop == "NPC_ID" and ret > 0 then
				comment = GetFromArray(Game.NPCDataTxt, ret, 'Name')
			elseif prop == "NameId" and ret > 0 then
				comment = GetFromArray(Game.PlaceMonTxt, ret)
			elseif prop == "TreasureItemType" then
				retVal = FindConst("ItemType", ret)
			elseif prop == "Spell" or prop == "Spell2" then
				comment = GetFromArray(Game.SpellsTxt, ret, 'Name')
			elseif (prop == "SpellSkill" or prop == "Spell2Skill") and ret >= 0x40 and ret < mmv(0xC0, 0x140, 0x140) then
				local n, mast = SplitSkill(ret)
				retVal = ("JoinSkill(%s, %s)"):format(n, "const."..table.find(const, mast))
			end
		end
		comment = (def and " default" or "")..(comment and " ("..comment..")" or "")
		return ret, comment ~= "" and (retVal or tostr(ret))..COMMENT..comment or retVal, def
	end,

	set = function(id, prop, val)
		local a, t = Map.Monsters[id], Editor.Monsters[id + 1]

		local function IsDef(vals, def)  -- checks that given values make it inactive or invalid
			for k, v in pairs(def or {}) do
				if vals[k] > v then
					return false
				end
			end
			return def ~= nil
		end
		
		local function ChangeSpecial(special, on, vals, def)
			on = on ~= nil
			local base = Game.MonstersTxt[t.Id or a.Id]
			local same = (t.Special or base.Special) == special
			local noBase = base.Special ~= special
			if not on and (not same or not def and noBase) then
				return
			end
			if on and IsDef(vals, def) then
				if base.Special ~= 0 then
					special, same, vals = 0, false, {}  -- remove 'Special'
				else
					on = false
				end
			end
			if on and not same or not on and def and noBase then
				table.copy(MonSpecialDef(special), vals)
			end
			if on and not same or not on and def then
				vals[""] = special
			end
			for k, v in pairs(vals) do
				k = "Special"..k
				AddUndoProp(id, k, a[k])
				if on then
					t[k] = v
				else
					t[k] = nil
				end
			end
			MonstersToUpdate[id] = true
		end
		
		if MonSpecialProps[prop] then
			return ChangeSpecial(MonSpecialProps[prop](val))
		end
		-- set undo
		local old, _, IsDefault = CurrentProps.get(id, prop)
		if IsDefault then
			old = nil
		end
		AddUndoProp(id, prop, old)
		-- set prop
		if IsPosProp[prop] then
			t[prop] = val or 0
			a[prop] = val or 0
			a.Room = Map.RoomFromPoint(a)
			return
		end
		
		if prop == "TreasureGold" then
			local count, sides = ParseDamage(val, false)
			if not count and val ~= nil then
				return
			end
			t.TreasureDiceCount, t.TreasureDiceSides = count, sides
		elseif prop == "Attack1Damage" or prop == "Attack2Damage" then
			local count, sides, add = ParseDamage(val, true)
			if not count and val ~= nil then
				return
			end
			local s = (prop == "Attack1Damage" and "Attack1" or "Attack2")
			t[s.."DamageDiceCount"], t[s.."DamageDiceSides"], t[s.."DamageAdd"] = count, sides, add
		elseif prop == "Attack1Type" or prop == "Attack2Type" then
			t[prop] = ParseDamageType(val)
		else
			t[prop] = val
		end
		MonstersToUpdate[id] = true
	end,
	
	done = function()
		for id in pairs(MonstersToUpdate) do
			Editor.UpdateMonster(id)
		end
		MonstersToUpdate = {}
	end,

	create = function(t)
		return Editor.CreateMonster(t)
	end,

	delete = function(id)
		local t = Editor.Monsters[id + 1]
		Editor.Monsters[id + 1] = nil
		Editor.MonsterIds[t] = nil
		Editor.State.Monsters[t] = nil
		Map.Monsters[id].AIState = const.AIState.Removed
		return t
	end,
	
	undo = Remapper "Monster",
	HasDirection = true,
	caption = " Monster properties:",
}

-----------------------------------------------------
-- ChestProps
-----------------------------------------------------

local ChestProps = MakeProps{
	"ChestPicture",
	"Trapped",
	"Identified",
	"Items",
	
	get = function(id, prop)
		local a = Editor.State.Chests[id + 1] or {}
		if prop == "Items" then
			local t = {
				dump(a.Items or {}),
				'-- "{Number = -1}" or short form "-1" means level 1 item. Level 7 is artifact.',
				"-- Properties: Number, Bonus, BonusStrength, Bonus2, Charges, MaxCharges",
				"-- Bits: Identified, Broken",
			}
			if mmver >= 7 then
				t[#t] = t[#t]..", Hardened, Stolen"
			end
			return a.Items, table.concat(t, "\n")
		end
		return a[prop] or prop == "ChestPicture" and 0
	end,

	set = function(id, prop, val)
		local t = Editor.State.Chests[id + 1]
		if not t then
			t = {}
			CurrentProps.create(id, t)
		end
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
	end,
	
	create = function(n, t)
		Editor.State.Chests[n + 1] = t
		return n
	end,
	
	delete = function(n)
		local t = Editor.State.Chests[n + 1]
		Editor.State.Chests[n + 1] = nil
		return n, t
	end,
	
	caption = " Chest properties:",
}

-----------------------------------------------------
-- IndoorProps
-----------------------------------------------------

local IndoorProps = {
	"OutlineFlatSkip",
	"DefaultDarkness",

	get = function(id, prop)
		local v, comment = Editor.State[prop], nil
		if prop == "OutlineFlatSkip" then
			comment = "set lower value to ignore more outlines between almost flat facets (from 0 to 1, default is 0.9, game default is 1)"
		end
		return v, comment and ('%s%s %s'):format(tostring2(v), COMMENT, comment)
	end,
	
	set = function(id, prop, val)
		local t = Editor.State
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		if prop == "OutlineFlatSkip" and not Editor.State.Outlines then
			Editor.UpdateOutlines()
		elseif prop == "DefaultDarkness" then
			Editor.UpdateNoDark()
		end
	end,
	
	caption = " Map properties:",	
}

-----------------------------------------------------
-- OutdoorProps
-----------------------------------------------------

local OutdoorProps = {
	"MinimapName",
	mm8 "Ceiling",
	"Foggy",
	mm8 "RedFog",
	mm8 "NoTerrain",
	mm8 "AlwaysDark",
	mm8 "AlwaysLight",
	mm8 "AlwaysFoggy",
	"FogRange1",
	"FogRange2",
	
	get = function(id, prop)
		local v, comment = Editor.State.Header[prop], nil
		if prop == "Ceiling" then
			v = v ~= 0 and v or 4000
			comment = "maximum flight height"
		elseif prop == "FogRange1" then
			v = v or 0
			comment = "4096 for light fog, 0 for middle or thick"
		elseif prop == "FogRange2" then
			v = v or 4096
			comment = "8192 for light fog, 4096 for middle, 2048 for thick, must be bigger than FogRange1"
		end
		return v, comment and ('%s%s %s'):format(tostring2(v), COMMENT, comment)
	end,
	
	set = function(id, prop, val)
		local t = Editor.State.Header
		t = id and t[id] or t
		AddUndoProp(id, prop, t[prop])
		t[prop] = val
		Editor.UpdateOutdoorHeader()
	end,

	caption = " Map properties:",	
}

-----------------------------------------------------
-- CommonMapProps
-----------------------------------------------------

local CommonMapProps = {
	"TestWithLivingMonsters",
	"ImportIgnoreUV",
	"ImportScale",
	"NoExportRotation",
	
	get = function(id, prop)
		local ret, comment = Editor.State[prop], nil
		if ret == nil and prop ~= "ImportIgnoreUV" then
			ret = Editor[prop] or false
		end
		if prop == "ImportIgnoreUV" then
			comment = "set to 'true' if you want to assign texture coordinates only inside the Editor"
		elseif prop == "ImportScale" then
			ret = ret or Editor[prop] or 1
			comment = "all coordinates are multiplied by this number on import and divided by it on export"
		elseif prop == "NoExportRotation" then
			comment = "set to 'true' to keep Z coordinate the vertical one on export and import"
		end
		return ret, comment and ('%s%s %s'):format(tostring2(ret), COMMENT, comment)
	end,
	
	set = function(id, prop, val)
		AddUndoProp(id, prop, Editor.State[prop])
		Editor.State[prop] = val
		if prop == "TestWithLivingMonsters" then
			Editor.UpdateDynamicStuff()
		end
	end,
}

local function JoinProps(t, t1)
	local mine = {}
	for _, v in ipairs(t1) do
		if v then
			mine[v] = true
			t[#t+1] = v
		end
	end
	
	local get = t.get
	local get1 = t1.get
	function t.get(id, prop, ...)
		return (mine[prop] and get1 or get)(id, prop, ...)
	end

	local set = t.set
	local set1 = t1.set
	function t.set(id, prop, ...)
		return (mine[prop] and set1 or set)(id, prop, ...)
	end
	
	return MakeProps(t)
end

IndoorProps = JoinProps(IndoorProps, CommonMapProps)
OutdoorProps = JoinProps(OutdoorProps, CommonMapProps)

-----------------------------------------------------
-- Editor.EditProps
-----------------------------------------------------

local function CombineProps(sel, props, GetProp)
	local t = {}
	local s = {}
	local nilv = t
	local exclude = props.GetExcluded() or {}
	for i, prop in ipairs(props) do
		if not exclude[prop] then
			local val, bad, valStr
			for id in pairs(sel) do
				local v, str = props.get(id, prop)
				valStr = valStr or str
				if v == nil then
					v = nilv
				end
				if val == nil or val == v or str and valStr == str then
					val = v
				elseif val == 0 or val == nilv then
					val = v
					bad = 1
				elseif v == 0 or v == nilv then
					bad = 1
				elseif val ~= v then
					bad = 2
				end
			end
			if val == nilv then
				val = nil
			end
			s[#s + 1] = (bad and "--" or "")..prop.." = "..(bad ~= 2 and (valStr or tostr(val)) or "")
			if not bad then
				t[i] = val
			end
		end
	end
	return s, t
end

local function UpdateProps(t, ot, sel, props, SetProp)
	local exclude = props.GetExcluded() or {}
	for i, prop in ipairs(props) do
		if not exclude[prop] then
			local val = t[prop]
			if val ~= ot[i] then
				for id in pairs(sel) do
					props.set(id, prop, val)
				end
			end
		end
	end
end

local capN = internal.DebugConsoleCharsInLine()
local capStart = ("—"):rep(capN).."\n"
local capEnd = "\n"..("-"):rep(capN).."\n"

function Editor.EditProps(SpecialKind, ChestNum)
	local props, sel = Editor.GetProps(SpecialKind, ChestNum)
	if not props then
		return
	end
	sel = sel or Editor.Selection
	local s, t = CombineProps(sel, props)

	internal.DebugConsoleAnswer(table.concat(s, "\n"), -1)
	local timestate = PauseGame()
	s = internal.DebugConsole(capStart..props.caption..capEnd, (internal.IsTopmost or internal.IsFullScreen)(), "Editor") or ""
	internal.DebugConsole(nil, false, "Editor")
	ResumeGame(timestate)
	if s == "" then
		return
	end
	local f, err = loadstring(s)
	if not f then
		return debug.debug(err)
	end
	local ot = table.copy(t)
	setmetatable(t, {__index = _G})
	setfenv(f, t)
	f()
	setmetatable(t, nil)
	
	UpdateProps(t, ot, sel, props)
	props.done()
end

function Editor.GetNewProps(SpecialKind)
	if Editor.SelectionKind == skFacet then
		if SpecialKind == "Room" then
			return RoomProps
		elseif SpecialKind == "Door" then
			return DoorProps
		elseif Editor.ModelMode then
			return ModelProps
		else
			return FacetProps
		end
	elseif Editor.SelectionKind == skSprite then
		return SpriteProps
	elseif Editor.SelectionKind == skLight then
		return LightProps
	elseif Editor.SelectionKind == skSpawn then
		return SpawnProps
	elseif Editor.SelectionKind == skObject then
		return ObjectProps
	elseif Editor.SelectionKind == skMonster then
		return MonsterProps
	end	
end

function Editor.GetProps(SpecialKind, ChestNum)
	if SpecialKind == "Header" and Editor.State then
		return Map.IsIndoor() and IndoorProps or OutdoorProps, {[false] = true}
	elseif SpecialKind == "Chest" and Editor.State then
		return ChestProps, {[ChestNum] = true}
	elseif Editor.State and Editor.Selection and next(Editor.Selection) then
		return Editor.GetNewProps(SpecialKind)
	end
end

-- way to make some normally hidden properties visible, e.g. Index
function Editor.AddProp(name, SpecialKind)
	local props = Editor.GetProps(SpecialKind, 0)
	if not table.find(props, name) then
		props[#props + 1] = name
	end
end

function Editor.ForSelection()
	PropsChanged = nil
	local sel = Editor.Selection
	return function(props, i)
		i = next(sel, i)
		if not i and PropsChanged then
			props.done()
		end
		return i, props
	end, Editor.GetProps()
end

-----------------------------------------------------
-- Undo
-----------------------------------------------------

local UndoStack = Editor.UndoStack or {[0] = {SelectionKind = 0/0}}
Editor.UndoStack = UndoStack
Editor.UndoPosition = Editor.UndoPosition or 0
local NewUndo, ExclusiveUndo

local function CheckSameSelection(t)
	if not t or Editor.SelectionKind ~= t.SelectionKind or (timeGetTime() - t.Time) > 5000 then
		return
	end
	local n = 0
	for id in pairs(Editor.Selection) do
		n = n + 1
		if not t.Selection[id] then
			return
		end
	end
	return n == t.SelectionCount and t
end

local function InitNewState()
	NewUndo = {Selection = Editor.Selection, SelectionKind = Editor.SelectionKind}
	local n = 0
	for id in pairs(Editor.Selection) do
		n = n + 1
	end
	NewUndo.SelectionCount = n
	-- ChestProps here because any props would do
	AddSelectionCalls(Editor.GetProps() or ChestProps, Editor.Selection, Editor.SelectionKind)
end

function Editor.ClearUndoStack()
	UndoStack = {[0] = {SelectionKind = 0/0}}
	Editor.UndoStack = UndoStack
	Editor.UndoPosition = 0
	Editor.UndoChanged()
end

function Editor.BeginUndoState()
	NewUndo = CheckSameSelection(UndoStack[Editor.UndoPosition])
	ExclusiveUndo = false
	return not NewUndo
end

function Editor.AddUndo(f, done)
	if not NewUndo then
		InitNewState()
	end
	if done and not NewUndo[done] then
		NewUndo[done] = true
		NewUndo[#NewUndo + 1] = done
	end
	if f then
		NewUndo[#NewUndo + 1] = f
	end
	NewUndo.Time = timeGetTime()
end

function Editor.ExclusiveUndoState()
	NewUndo, ExclusiveUndo = nil, true
end

function Editor.EndUndoState()
	if NewUndo and NewUndo ~= UndoStack[Editor.UndoPosition] then
		Editor.CompleteUndoState()
		Editor.UndoPosition = Editor.UndoPosition + 1
		UndoStack[Editor.UndoPosition] = NewUndo
		for i = Editor.UndoPosition + 1, #UndoStack do
			UndoStack[i] = nil
		end
		if ExclusiveUndo then
			NewUndo.SelectionKind = 0/0
		end
		NewUndo = nil
		Editor.UndoChanged()
	end
end

function Editor.CompleteUndoState()
	UndoStack[Editor.UndoPosition].SelectionKind = 0/0
end

function Editor.CheckCompleteUndoState()
	local changed = not CheckSameSelection(UndoStack[Editor.UndoPosition])
	if changed then
		UndoStack[Editor.UndoPosition].SelectionKind = 0/0
	end
	return changed
end

local function DoUndo()
	NewUndo = nil
	local u = UndoStack[Editor.UndoPosition]
	for i = #u, 1, -1 do
		u[i]()
	end
	UndoStack[Editor.UndoPosition] = NewUndo or {}
	NewUndo = nil
	Editor.CompleteUndoState()
end

function Editor.HasUndo()
	return Editor.UndoPosition > 0
end

function Editor.Undo()
	if Editor.HasUndo() then
		Editor.CompleteUndoState()  -- safeguard
		DoUndo()
		Editor.UndoPosition = Editor.UndoPosition - 1
		Editor.UndoChanged()
	end
end

function Editor.HasRedo()
	return Editor.UndoPosition < #UndoStack
end

function Editor.Redo()
	if Editor.HasRedo() then
		Editor.UndoPosition = Editor.UndoPosition + 1
		DoUndo()
		Editor.UndoChanged()
	end
end
