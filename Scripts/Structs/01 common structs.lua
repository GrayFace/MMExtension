local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

local _KNOWNGLOBALS = BinarySearch, Game, Party, Map, Mouse

local TmpBuf = mem.StaticAlloc(12)

local GamesLodAdd = (mmver == 6 and 1 or 0)

local function FindInGamesLod(name)
	name = name:lower()
	for i, a in Game.GamesLod.Files do
		if a.Name:lower() == name then
			return i + GamesLodAdd
		end
	end
end

local function FindInMapStats(name, ErrorLevel)
	local i = call(mmv(0x446BD0, 0x4547CF, 0x451F39), 1, Game.MapStats["?ptr"], name)
	if i > 0 then
		return i, Game.MapStats[i]
	elseif ErrorLevel then
		error(('Map "%s" not found in MapStats.txt'):format(name), (ErrorLevel or 2) + 1)
	end
end

local FindInObjListProc
local FindInObjListCode = [[
	push    esi
	mov     esi, [ecx]
	xor     eax, eax
	test    esi, esi
	jle     @loc_42EB3F
	mov     ecx, [ecx+4]
	add     ecx, %offset%

@loc_42EB2D:
	cmp     dx, [ecx]
	jz      @loc_42EB42
	inc     eax
	add     ecx, %size%
	cmp     eax, esi
	jl      @loc_42EB2D

@loc_42EB3F:
	mov     eax, -1

@loc_42EB42:
	pop     esi
	ret
]]

local function FindInObjList(id)
	local a = Game.ObjListBin
	local i = call(FindInObjListProc, 2, a.lenP, id)
	if i >= 0 then
		return i, a[i]
	end
end

local function AddAction(name)
	return function(type, info1, info2)
		local a = Game[name]
		local i = a.Count
		if i < 40 then
			a.Count = i + 1
			a = a[i]
			a.Action = type
			a.Param = info1 or 0
			a.Param2 = info2 or 0
		end
	end
end

function events.StructsLoaded()
	FindInObjListProc = HookManager{
		size = structs.ObjListItem['?size'],
		offset = structs.o.ObjListItem.Id,
	}.asmproc(FindInObjListCode)
	internal.FindInObjListProc = FindInObjListProc

	rawset(Game.MapEvtLines, "RemoveEvent", internal.EventLines_RemoveEvent)
	rawset(Game.GlobalEvtLines, "RemoveEvent", internal.EventLines_RemoveEvent)
	if mmver ~= 8 then
		rawset(Game, "CurrentTileBin", Game.TileBin)
	end
	rawset(Game, "IsD3D", mmver > 6 and i4[mmv(nil, 0xDF1A68, 0xEC1980)] ~= 0)
	rawset(Game, "Version", offsets.MMVersion)
	rawset(Game.MapStats, "Find", FindInMapStats)
	rawset(Game.ObjListBin, "Find", FindInObjList)
	rawset(Game.Actions, "Add", AddAction'Actions')
	if mmver > 6 then
		rawset(Game.ActionsNext, "Add", AddAction'ActionsNext')
	end
	rawset(Game.Actions, "Process", mem.func{p = mmv(0x42ADA0, 0x4304D6, 0x42EDD8)})
end

local function MapInGamesLod(o, obj, name, val)
	local p = obj["?ptr"] + o
	if val then
		i2[p] = FindInGamesLod(val) or -FindInMapStats(val, 3)
	else
		local v = i2[p]
		if v >= 0 then
			return Game.GamesLod.Files[v - GamesLodAdd].Name
		else
			return Game.MapStats[-v].FileName
		end
	end
end

local function MapInMapStats(a)
	return function(o, obj, name, val)
		local p = obj["?ptr"] + o
		if val then
			a[p] = FindInMapStats(val, 3)
		else
			return Game.MapStats[a[p]].FileName
		end
	end
end

local SoundByTileset = {[0] = 54, [1] = 58, [2] = 52, [3] = 51, [5] = 62, [6] = 49, [7] = 61}
local Sound2ByTileset = {[0] = 93, [1] = 97, [2] = 91, [3] = 90, [5] = 101, [6] = 88, [7] = 100}

function structs.f.GameMap(define)
	define
	 .Info{Name = "Map"}
	 .Info{new = true, Name = "Refilled", "If the map has been refilled this visit, contains the last #mapvars:# table."}
	[offsets.MapName].CustomType('Name', 20, function(o, obj, name, val)
		if val ~= nil then
			error("Map.Name is read-only", 3)
		else
			return internal.MapName or mem.string(offsets.MapName, 20):lower()
		end
	end)
	[mmv(0x6107D4, 0x6BE1E0, 0x6F39A0)].u4  'IndoorOrOutdoor'
	[mmv(0x56F478, 0x5FEFD8, 0x61C540)].array{500, lenA = i4, lenP = mmv(0x5B22F8, 0x6650A8, 0x692FB0)}.struct(structs.MapMonster)  'Monsters'
	[mmv(0x5B22FC, 0x5E4B10, 0x602078)].array(0, 199).u1  'Vars'
	 .Info "Variables for barrels/contests/etc events start at 75"
	[mmv(0x5C9AD8, 0x6650B0, 0x692FB8)].array{1000, lenA = i4, lenP = mmv(0x5E2180, 0x6650AC, 0x692FB4)}.struct(structs.MapObject)  'Objects'
	 .Info "Items, spells effects"
	[mmv(0x5B23C8, 0x683550, 0x6B1458)].array{3000, lenA = i4, lenP = mmv(0x5B23C4, 0x69AC50, 0x6C8B58)}.struct(structs.MapSprite)  'Sprites'
	[mmv(0x5B22C8, 0x680638, 0x6AE540)].array{10, lenA = i4, lenP = mmv(0x5C9AD0, 0x680660, 0x6AE568)}.i4  'SoundSprites'
	[mmv(0x5E2580, 0x5E4FD0, 0x602538)].array{20, lenA = i4, lenP = mmv(0x5E2184, 0x5FEFC0, 0x61C528)}.struct(structs.MapChest)  'Chests'
	[mmv(0x6A5F58, 0x6BDFBC, 0x6F30C4)].i4  'MapStatsIndex'
	if mmver == 7 then
		define[0x6BE245].b1  'NoNPC'
	end

	-- outdoors only:
	local base = mmv(0x6297A8, 0x6A0C70, 0x6CEBD0)
	define.class.OutdoorPtr = base
	local d = mmv(0, 0, 4)
	define
	[base].struct(structs.OdmHeader)  'OutdoorHeader'
	[base + 160].array(4).struct(structs.TilesetDef)  'Tilesets'
	[base + d + 180].parray(128).array(128).u1  'HeightMap'
	 .Info{Sig = "[y][x]"; "!Lua[=[[(64 - Party.Y / 0x200):round()] [(64 + Party.X / 0x200):round()] = (Party.Z / 32):floor()]=]"}
	[base + d + 184].parray(128).array(128).u1  'TileMap'
	 .Info{Sig = "[y][x]"; "!Lua[=[[(64 - Party.Y / 0x200):floor()] [(64 + Party.X / 0x200):floor()]]=]"}
	[base + d + 188].parray(128).array(128).u1  'UnknownMap'  -- AMAP
	[base + d + 216].parray{lenA = i4, lenP = base + d + 176}.struct(structs.MapModel)  'Models'
	[base + d + 224].parray{lenA = i4, lenP = base + d + 220}.struct(structs.ObjectRef2)  'IDList'
	 .Info "IDs of sprites on map (in ObjectRef:structs.ObjectRef form)"
	[base + d + 228].parray(128).array(128).i4  'IDOffsets'
	 .Info{Sig = "[y][x]"; "OMAP - offsets in IDList"}
	[base + d + 232].i4  'LoadedSkyBitmap'
	
	local d = mmv(393216, 0, 4)
	define
	[base + d + 1220].parray{lenA = i4, lenP = base + d + 1216}.struct(structs.SpawnPoint)  'OutdoorSpawns'
	[base + d + 1224].i4  'OutdoorRefillCount'
	[base + d + 1228].i4  'OutdoorLastRefillDay'
	 .Info "First visit day"
	 
	local d = mmv(393184, 0, 12)
	define
	[base + d + 1264].struct(structs.MapExtra)  'OutdoorExtra'
	[base + d + 1264].i8  'OutdoorLastVisitTime'
	[base + d + 1320].array(88).array(88).abit  'VisibleMap1'
	[base + d + 2288].array(88).array(88).abit  'VisibleMap2'
	if mmver >= 7 then
		define[base + d + 1232].i4  'OutdoorReputation'
	end
	if mmver == 8 then
		define[base + 95].u1  'TilesetsFile'
		 .Info "0 = dtile.bin, 1 = dtile2.bin, 2 = dtile3.bin"
		-- +1272 Scenery
		[base + 192].parray(128).array(128).u1  'UnknownMap2'  -- DMAP
		[0x6CF894].array(100).struct(structs.MapNote)  'Notes'
	end
	if mmver >= 7 then
		-- [x][y] instead of [y][x]
		define
		[mmv(nil, 0x73D394, 0x77B35C)].array(128).array(128).array(2).r4  'TerNormDist'
		.array(128).array(128).array(2).i2  'TerNormId'
		.parray{lenA = i4, lenP = mmv(nil, 0x73D390, 0x77B358)}.struct(structs.FloatVector)  'TerNorm'
	end
	
	-- indoors only:
	base = mmv(0x5F7AA8, 0x6BE248, 0x6F3A08)
	define.class.IndoorPtr = base
	define
	[base + 488].struct(structs.BlvHeader)  'IndoorHeader'
	[base + 628].parray{lenA = i4, lenP = base + 624}.struct(structs.MapVertex)  'Vertexes'
	[base + 636].parray{lenA = i4, lenP = base + 632}.struct(structs.MapFacet)  'Facets'
	[base + 644].parray{lenA = i4, lenP = base + 640}.struct(structs.FacetData)  'FacetData'
	[base + 652].parray{lenA = i4, lenP = base + 648}.struct(structs.MapRoom)  'Rooms'
	[base + 660].parray{lenA = i4, lenP = base + 656}.struct(structs.MapLight)  'Lights'
	[base + 668].parray{200, lenA = i4, lenP = base + 664}.struct(structs.MapDoor)  'Doors'
	[base + 676].parray{lenA = i4, lenP = base + 672}.struct(structs.BSPNode)  'BSPNodes'
	[base + 680].pstruct(structs.MapOutlines)  'Outlines'
	[base + 704].parray{lenA = i4, lenP = base + 700}.struct(structs.SpawnPoint)  'IndoorSpawns'
	[base + 708].i4  'IndoorRefillCount'
	[base + 712].i4  'IndoorLastRefillDay'
	[base + mmv(716, 748, 748)].struct(structs.MapExtra)  'IndoorExtra'
	[base + mmv(716, 748, 748)].i8  'IndoorLastVisitTime'
	[base + mmv(772, 804, 804)].array(7000).abit  'VisibileOutlines'
	if mmver >= 7 then
		define[base + 716].i4  'IndoorReputation'
	end
	
	local function IndoorOutdoorField(o, obj, name, val)
		name = (obj.IndoorOrOutdoor == 2 and "Outdoor" or "Indoor")..name
		if val == nil then
			return obj[name]
		else
			obj[name] = val
		end
	end
	
	define
	.CustomType('Spawns', 0, IndoorOutdoorField)
	.CustomType('RefillCount', 0, IndoorOutdoorField)
	.CustomType('LastRefillDay', 0, IndoorOutdoorField)
	.CustomType('LastVisitTime', 0, IndoorOutdoorField)
	.CustomType('Reputation', 0, IndoorOutdoorField)
	
	if mmver > 6 then
		local p = mmv(nil, 0x518674, 0x529F5C)
		define[p].array{400, lenA = i4, lenP = p + 400*12}.struct(structs.BaseLight)  'SpriteLights'
	end

	define
	.func{name = "RemoveObject", p = mmv(0x42ABD0, 0x42F90F, 0x42E392), cc = 1, must = 1}
	 .Info{Sig = "Index"}

	local c = define.class
	function define.f.Render()
		local v = Game.Map.IndoorOrOutdoor
		if v == 2 then
			call(mmv(0x437040, 0x441D22, 0x43E979), 0)
		elseif v == 1 then
			call(mmv(0x4371E0, 0x441BF7, 0x43E84D), 0)
		end
	end
	function define.f.IsIndoor()
		return Game.Map.IndoorOrOutdoor == 1
	end
	define.Info{AltName = "IsIndoors"}
	c.IsIndoors = c.IsIndoor
	function define.f.IsOutdoor()
		return Game.Map.IndoorOrOutdoor == 2
	end
	define.Info{AltName = "IsOutdoors"}
	c.IsOutdoors = c.IsOutdoor
	function define.f.LoadTileset(id)
		if mmver == 8 then
			call(0x487729, 1, u4[0x6F2FD4], id)
		else
			call(mmv(0x47A5D0, 0x487E3E), 1, mmv(0x610740, 0x6BDEC8), id)
		end
		if SoundByTileset[id] then
			Game.LoadSound(SoundByTileset[id])
			Game.LoadSound(Sound2ByTileset[id])
		end
	end
	define.Info{Sig = "Id"}
	function define.f.RoomFromPoint(x, y, z)
		if type(x) == "table" then
			x, y, z = x.X, x.Y, x.Z
		end
		assert(x and y and z)
		return call(mmv(0x48C3D0, 0x49ABA0, 0x4980BA), 1, mmv(0x5F7AA8, 0x6BE248, 0x6F3A08), x, y, z)
	end
	define.Info{Sig = "x, y, z"}
	function define.f.GetFloorLevel(x, y, z, room)
		local i
		if Map.IsIndoor() then
			i = call(mmv(0x45DD10, 0x46CEC7, 0x46B975), 2, x, y, z, room or Map.RoomFromPoint(x, y, z), TmpBuf)
		elseif mmver == 8 then
			i = call(0x46BF50, 2, 0, x, y, z, 0, TmpBuf + 4, TmpBuf + 8, TmpBuf, 1)
		else
			i = call(mmv(0x45E2E0, 0x46D4A2), 2, x, y, z, 0, TmpBuf + 4, TmpBuf, 1)
		end
		return i, i4[TmpBuf]
	end
	define.Info{Sig = "x, y, z, room"; "Returns 'FloorZ', 'FacetId'."}
	function define.f.GetGroundLevel(x, y)
		if mmver == 8 then
			return call(0x481E19, 2, 0, x, y, TmpBuf, TmpBuf + 4, 1, 1)
		else
			return call(mmv(0x472040, 0x48257E), 2, x, y, TmpBuf, TmpBuf + 4)
		end
	end
	define.Info{Sig = "x, y"}
	function define.f.GetFacet(id)
		if Map.IsIndoor() then
			return Map.Facets[id]
		else
			return Map.Models[id:div(64)].Facets[id % 64]
		end
	end
	define.Info{Sig = "Id"}
	-- function define.f.GetTileBitmap(x, y)
		-- return call(mmv(nil, nil, 0x47E383), 1, Map.OutdoorPtr, x, y)
	-- end
end

function structs.f.TilesetDef(define)
	define
	.CustomType('Group', 2, function(o, obj, _, val)
		local p = obj["?ptr"] + o
		if val == nil then
			return mem.i2[p]
		end
		i2[p] = val
		-- i2[p+2] = Map.GetTilesetOffset
		if mmver == 8 then
			i2[p+2] = call(0x4877AE, 1, u4[0x6F2FD4], val, 1)
		else
			i2[p+2] = call(mmv(0x47A650, 0x487EBC), 1, mmv(0x610740, 0x6BDEC8), val, 1)
		end
	end)
	.i2  'Offset'
end

function structs.f.BlvHeader(define)
	define
	[4].string(60)  'Name'
	.skip(40)
	.i4  'FacetDataSize'
	.i4  'RoomDataSize'
	.i4  'RoomLightDataSize'
	.i4  'DoorDataSize'
	.size = 0x88
end

function structs.f.OdmHeader(define)
	define
	.string(32)  'Name'
	.string(32)  'FileName'
	.string(31)  'VersionStr'  -- must be "MM6 Outdoor v1.11" for MM6 and isn't used in others
	if mmver == 8 then
		define.u1  'TilesetsFile'
		 .Info "0 = dtile.bin, 1 = dtile2.bin, 2 = dtile3.bin"
	else
		define.skip(1)
	end
	define
	.skip(32)  --.string(32)  'SkyBitmap'
	.skip(32)  --.string(32)  'GroundBitmap'
	.array(4).struct(structs.TilesetDef)  'Tilesets'
	if mmver == 8 then
		define.u4  'Bits'
	end
end

function structs.f.MapExtra(define)
	define
	.i8  'LastVisitTime'
	.string(12, mmver == 8)  'SkyBitmap'
	.bit('Foggy', 0x1)
	.u4  'DayBits'
	.i4  'FogRange1'
	.i4  'FogRange2'
	if mmver == 8 then
		define
		.bit('Raining', 0x1)
		.bit('Snowing', 0x2)
		.bit('Underwater', 0x4)  .Info "elemw.odm"
		.bit('NoTerrain', 0x8)  .Info "elema.odm"
		.bit('AlwaysDark', 0x10)
		.bit('AlwaysLight', 0x20)  .Info "elema.odm"
		.bit('AlwaysFoggy', 0x40)  .Info "elemf.odm, elemw.odm"
		.bit('RedFog', 0x80)  .Info "elemf.odm"
		.u4  'Bits'
		.i4  'Ceiling'
	else
		define
		.skip(8)
	end
	-- added in v2.1 of my patches, was unused before:
	define
	.u4  'LastWeeklyTimer'
	.u4  'LastMonthlyTimer'
	.u4  'LastYearlyTimer'
	.u4  'LastDailyTimer'
	define.size = 0x38
end

function structs.f.Weather(define)
	define
	[mmv(0x61A968, 0x6BDEA0, 0x6F2F98)].i4  'Shade'
	 .Info "0 = sunny, 1 = dark, 2 = misty"
	if mmver < 8 then
		define.b4  'Snow'
	else
		define[0x6F2658 + 0x93C].b4  'Rain'
	end
	define
	[mmv(0x61A978, 0x6BDEB0, 0x6F2FA4)].CustomType('Fog', 0, function(o, obj, _, val)
		if val == nil then
			return u1[o]:And(1) ~= 0
		else
			val = val and u1[o]:Or(1) or u1[o]:AndNot(1)
			u1[o] = val
			u1[mmv(0x689C8C, 0x6A1174, 0x6CF0E0)] = val
		end
	end)
	[mmv(0x61A988, 0x6BDEC0, 0x6F2FB4)].CustomType('FogRange1', 4, function(o, obj, _, val)
		if val == nil then
			return i4[o]
		else
			i4[o] = val
			i4[mmv(0x689C90, 0x6A1178, 0x6CF0E4)] = val
		end
	end)
	[mmv(0x61A98C, 0x6BDEC4, 0x6F2FB8)].CustomType('FogRange2', 4, function(o, obj, _, val)
		if val == nil then
			return i4[o]
		else
			i4[o] = val
			i4[mmv(0x689C94, 0x6A117C, 0x6CF0E8)] = val
		end
	end)
	
	function define.f.SetFog(range1, range2)
		local t = Game.Weather
		t.Fog = range1
		t.FogRange1 = range1 or 0
		t.FogRange2 = range2 or 0
	end
	define.Info{Sig = "Range1, Range2"}
	
	function define.f.RandomFog(LightChance, MiddleChance, ThickChance)
		LightChance = LightChance or 0
		MiddleChance = (MiddleChance or 0) + LightChance
		ThickChance = (ThickChance or 0) + MiddleChance
		local f1, f2
		local a = math.random(0, 99)
		if a < LightChance then
			f1, f2 = 4096, 8192
		elseif a < MiddleChance then
			f1, f2 = 0, 4096
		elseif a < ThickChance then
			f1, f2 = 0, 2048
		end
		Game.Weather.SetFog(f1, f2)
	end
	define.Info{Sig = "LightChance, MiddleChance, ThickChance"}
	
	function define.f.New()  -- randomizes new weather
		if mmver > 6 and Map.IsOutdoor() then
			call(mmv(nil, 0x48946D, 0x488D93))
		end
	end
end

function structs.f.Item(define)
	define
	[0x0].i4  'Number'
	[0x4].i4  'Bonus'
	 .Info "From STDITEMS.TXT. You can use #const.Stats:#, just add 1 to a supported value from it."
	[0x8].i4  'BonusStrength'
	[0xC].i4  'Bonus2'
	 .Info "From SPCITEMS.TXT. Value in case of gold."
	[0x10].i4  'Charges'
	[0x14].bit('Identified', 1)
	[0x14].bit('Broken', 2)
	[0x14].bit('TemporaryBonus', 8)  -- MM7, MM8
	[0x14].bit('Stolen', 0x100)  -- MM7, MM8
	[0x14].bit('Hardened', 0x200)  -- MM7, MM8
	[0x14].bit('Refundable', 0x400)  -- MM7, MM8
	 .Info "Added in patch v2.5.4. Used internally to remove artifacts generated in unopened chests from #ArtifactsFound:structs.GameParty.ArtifactsFound# upon map refill."
	[0x14].i4  'Condition'
	[0x18].i1  'BodyLocation'
	[0x19].u1  'MaxCharges'
	[0x1A].i1  'Owner'  -- ??
	[0x1B].skip(1)
	.size = 0x1C
	if mmver > 6 then
		define
		[0x1C].i8  'BonusExpireTime'
		.size = 0x24
	end
	
	define
	.method{p = mmv(0x448610, 0x45646E, 0x453CE7), name = "GetValue"}
	.method{p = mmv(0x448660, 0x4564C5, 0x453D3E), name = "GetName", ret = ""}
	.method{p = mmv(0x448680, 0x4564DF, 0x453D58), name = "GetIdentifiedName", ret = ""}
	.method{p = mmv(0x44A6B0, 0x4505F8, 0x44DD43), name = "GenerateArtifact"}

	local pItems = mmv(0x560C10, 0x5D2860, 0x5EFBC8)
	function define.m:Randomize(strength, type)
		mem.fill(self["?ptr"], self["?size"])
		return call(mmv(0x448790, 0x45664C, 0x453ECC), 1, pItems, assertnum(strength, 2), assertnum(type or 0, 2), self)
	end
	define.Info{Sig = "Strength, Type:const.ItemType"}
	function define.m:T()
		return Game.ItemsTxt[self.Number]
	end
	define.Info "Returns ItemsTxt entry."
	function define.m:InitSpecial()
		if mmver > 6 then
			call(mm78(0x456D51, 0x4545E8), 1, pItems, self)
		end
	end
	define.Info '[MM7+] Sets up enchantments if the item is "Special" as marked by "material" column of items.txt'
end

function structs.f.MouseStruct(define)
	define
	[0x0].struct(structs.ObjectRef)  'Target'
	 .Info "Use #Mouse.GetTarget:# instead."
	if mmver == 6 then
		define
		[0x10].i4  'X'
		[0x14].i4  'Y'
	else
		define
		[0x108].i4  'X'
		[0x10C].i4  'Y'	
	end
	define
	.method{p = mmv(0x45A990, 0x469907, 0x467C67), name = "SetIcon"; "MICON1"}
	 .Info{Sig = 'Icon = "MICON1"';  "There are 3 special values:\n"..
	 '"MICON1" = arrow cursor\n'..
	 '"MICON2" = crosshair cursor for spells\n'..
	 '"MICON3" = this cursor doesn\'t exist, don\'t use it\n'..
	 "Other values change the picture of item carried by mouse."}
	.method{p = mmv(0x45A910, 0x4698AA, 0x467C0A), name = "RemoveItem"}
	 .Info "Deletes item carried by the mouse and restores arrow cursor."
	.method{p = mmv(0x487750, 0x4936D9, 0x491A27), name = "AddItem", must = 1}
	 .Info{Sig = "Item:structs.Item";  "If there already was an item carried by the mouse, it will be taken into inventory or dropped."}
	.method{p = mmv(0x41FE70, 0x421AD5, 0x4209D4), name = "ReleaseItem"}  -- take or drop
	 .Info "If there is an item carried by the mouse, it will be taken into inventory or dropped."
end

local MTargetBuf, MTarget

function structs.f.GameMouse(define)
	define.Info{Name = "Mouse"}
	local p = mmv(0x6A6110, 0, 0)
	if mmver == 6 then
		structs.f.MouseStruct(define)
	else
		define
		[mmv(nil, 0x720808, 0x75D770)].pstruct(structs.MouseStruct)  'MouseStruct'
		.indexmember  'MouseStruct'
		.newindexmember  'MouseStruct'
	end
	define
	[mmv(0x90E81C, 0xAD458C, 0xB7CA64) - p].struct(structs.Item)  'Item'
	
	function define.f.GetTarget()
		if mmver ~= 6 and Game.RendererD3D ~= 0 then
			MTargetBuf = MTargetBuf or mem.StaticAlloc(4)
			MTarget = MTarget or structs.ObjectRef:new(MTargetBuf)
			i4[MTargetBuf] = call(mmv(nil, 0x4C1B63, 0x4BF70D), 1, u4[u4[mmv(nil, 0x71FE94, 0x75CE00)] + 3660])
			return MTarget
		end
		local mouse = Game.Mouse
		return Game.ObjectByPixel[mouse.Y][mouse.X]
	end
	define.Info"Returns #ObjectRef:structs.ObjectRef# of current mouse target"
	function define.f.GetPos()
		local m, op = Game.Mouse, Game.PatchOptions
		local x, y = m.X, m.Y
		if op.Present("MouseDY") then
			x = x + op.MouseDX
			y = y + op.MouseDY
		end
		return x, y
	end
	define.Info("Returns floating-point mouse position that includes sub-pixel difference caused by upscaling.\n"..
	 "In UILayout mode this is the only way to find mouse coordinates when it's over 3D view. #Mouse.X:# and #Mouse.Y:# would just return the middle of the view. When mouse is over interface items, both this function and #Mouse.X:#, #Mouse.Y:# get coordinates within traditional interface to which UI layout is mapped.")
end

function structs.f.ObjectRefAny(define, long)
	if long then
		define[2].i2  'ZBuf'
	end
	define
	[0].u2  'Value'
	 .Info "Raw value. In inventory screen this is item index, in other screens it equals !Lua[[Kind + Index*8]]."
	[0].CustomType('Kind', 0, function(o, obj, _, val)
		local p = obj["?ptr"] + o
		if val == nil then
			return u1[p]%8
		else
			u1[p] = u1[p]:AndNot(7) + val%8
		end
	end)
	 .Info{Type = "const.ObjectRefKind"}
	[0].CustomType('Index', 2, function(o, obj, _, val)
		local p = obj["?ptr"] + o
		if val == nil then
			return u2[p]:div(8)
		else
			u2[p] = u2[p]%8 + floor(val)*8
		end
	end)
	-- [0].CustomType('ModelId', 2, function(o, obj, _, val)
		-- local p = obj["?ptr"] + o
		-- if val == nil then
			-- return u2[p]:div(8*64)
		-- else
			-- u2[p] = u2[p]%8 + floor(val)*8
		-- end
	-- end)

	function define.m.Get(obj)
		local k = obj.Kind
		local i = obj.Index
		if k == 1 then
			return Map.Doors[i]
		elseif k == 2 then
			return Map.Objects[i]
		elseif k == 3 then
			return Map.Monsters[i]
		elseif k == 4 then
			return Party[i]
		elseif k == 5 then
			return Map.Sprites[i]
		elseif k == 6 then
			if Map.IsIndoors() then
				return Map.Facets[i]
			else
				local m = Map.Models[i:Div(64)]
				return m.Facets[i % 64], m
			end
		end
	end
	define.Info{AltName = "get"}
	define.class.get = define.class.Get
	--[[
	0 - nothing
	1 - door
	2 - objects
	3 - monster
	4 - party: Index is player index
	5 - sprite
	6 - facet (outdoors Index = ModelId*64 + FaceId)  => only 128 models per map?!
	--]]
end

function structs.f.ObjectRef(define)
	structs.f.ObjectRefAny(define, true)
end

function structs.f.ObjectRef2(define)
	define.Info{ReplaceWith = "structs.ObjectRef"}
	structs.f.ObjectRefAny(define, false)
end

function structs.f.BaseBonus(define)
	define
	.i2  'Base'
	.i2  'Bonus'
end

if mmver > 6 then
	function structs.f.PlayerResistanceBaseBonus(define)
		define
		 .Info{ReplaceWith = "structs.BaseBonus"}
		[0].i2  'Base'
		[0x16].i2  'Bonus'
		.size = 2
	end
end

function structs.f.NPC(define)
	define
	[0x0].b4  'Exist'
	 .Info 'Use to check if a slot is empty in Party.HiredNPC array'
	[0x0].EditPChar  'Name'
	[0x4].i4  'Pic'
	[0x8].bit('BribedBefore', 1)
	[0x8].bit(mmver == 6 and 'BeggedBefore' or 'TalkedBefore', 2)
	[0x8].bit('ThreatenedBefore', 4)
	[0x8].bit('Hired', 0x80)
	[0x8].u4  'Bits'
	[0xC].i4  'Fame'
	[0x10].i4  'Rep'
	[0x14].i4  'House'
	[0x18].i4  'Profession'
	if mmver > 6 then
		define[0x1C].i4  'Greet'
	end
	define
	.i4  'Joins'  -- 0x1C/0x20
	.i4  'TellsNews'  -- 0x20/nil
	.alt.array(mmv(3, 6, 6)).i4  'Events'  -- 0x24/0x28
	.i4  'EventA'  -- 0x24/0x28
	.i4  'EventB'  -- 0x28/0x2C
	.i4  'EventC'  -- 0x2C/0x30
	if mmver > 6 then
		define
		.i4  'EventD'  -- nil/0x34
		.i4  'EventE'  -- nil/0x38
		.i4  'EventF'  -- nil/0x3C
	end
	define
	.i4  'Sex'  -- 0x30/0x40
	.i4  'UsedSpell'  -- 0x34/0x44
	.i4  'NewsTopic'  -- 0x38/0x48
	.size = mmv(0x3C, 0x4C, 0x4C)
end

function structs.f.NPCNewsItem(define)
	define
	.EditPChar  'Topic'
	.EditPChar  'Text'
	.i1  'Map'
	.size = 12
end

function structs.f.HistoryTxtItem(define)
	define
	.EditPChar  'Text'
	.EditPChar  'Title'
	.i1  'Time'
	.size = 12
end

function structs.f.SpellBuff(define)
	define
	[0x0].i8  'ExpireTime'
	[0x8].i2  'Power'
	[0xA].i2  'Skill'
	[0xC].i2  'OverlayId'
	[0xE].u1  'Caster'
	[0xF].u1  'Bits'
	
	function define.m:Set(time, skill, power, overlay, caster)
		local tm = time%0x100000000
		return call(mmv(0x44A970, 0x458519, 0x455D97), 1, self['?ptr'], tm, (time - tm)/0x100000000, skill or 1, power or 1, overlay or 0, caster or 0)
	end
	define.Info{Sig = "ExpireTime, Skill, Power, OverlayId, Caster"}
	.size = 0x10
end

function structs.f.TravelInfo(define)
	define
	[0x0].u1  'MapIndex'
	[0x1].alt.array(7).u1  'DaysAvailable'
	[0x1].b1  'Monday'
	.b1  'Tuesday'
	.b1  'Wednesday'
	.b1  'Thursday'
	.b1  'Friday'
	.b1  'Saturday'
	.b1  'Sunday'
	[0x8].u1  'DaysCount'
	[0xC].array(3).i4  'Pos'
	[0xC].i4  'X'
	[0x10].i4  'Y'
	[0x14].i4  'Z'
	[0x18].i4  'Direction'
	[0x1C].i4  'QBit'
	.size = 0x20
	
	local MapType = (mmver ~= 6 and MapInMapStats(u1) or function(o, obj, name, val)
		local p = obj["?ptr"] + o
		if val then
			local v = FindInGamesLod(val)
			if v then
				u1[p], u1[p+9] = v, 0
			else
				u1[p], u1[p+9] = FindInMapStats(val, 3), 1
			end
		else
			if u1[p+9] == 0 then
				return Game.GamesLod.Files[u1[p] - 1].Name
			else
				return Game.MapStats[u1[p]].FileName
			end
		end
	end)
	
	define[0x0].CustomType('Map', 1, MapType)
end

function structs.f.Dlg(define)
	define
	[0x0].i4  'Left'
	[0x4].i4  'Top'
	[0x8].i4  'Width'
	[0xC].i4  'Height'
	[0x10].i4  'Right_'
	[0x14].i4  'Bottom_'
	[0x18].i4  'DlgID'
	[0x1C][mmver == 6 and 'i2' or 'i4']  'Param'
	 .Info "2D Events Id / Chest Id / ..."
	[0x20].i4  'ItemsCount'
	-- 24
	[0x28].i4  'KeyboardItemsCount'
	[0x2C].i4  'KeyboardItem'
	[0x30].i4  'KeyboardNavigationTrackMouse'
	[0x34].i4  'KeyboardLeftRightStep'
	[0x38].i4  'KeyboardItemsStart'
	[0x3C].i4  'Index'
	-- 40
	[0x44].i4  'UseKeyboadNavigation'
	--[0x48].i4  '' -- Param2
	-- [0x4C].alt.pstruct(structs.Button)  'FirstItem'
	[0x4C].u4  'FirstItemPtr'
	-- [0x50].alt.pstruct(structs.Button)  'LastItem'
	[0x50].u4  'LastItemPtr'
	.size = 0x54

	define
	.method{p = mmv(0x41A170, 0x41D0D8, 0x41C513), name = "AddButton", cc = 0, must = 4; 0, 0, 0, 0, 1, 0, 0, 0, 0, "";  0, 0, 0, 0, 0, 0}
	 .Info{Sig = "X, Y, Width, Height, Shape = 1, HintAction, ActionType, ActionInfo, Key, Hint, Sprites..., 0"}
	.method{p = mmv(0x41A0E0, 0x41D038, 0x41C473), name = "SetKeyboardNavigation"; 0, 1, 0, 0}
	 .Info{Sig = "KeyboardItemsCount, KeyboardNavigationTrackMouse, KeyboardLeftRightStep, KeyboardItemsStart"}
	.method{p = mmv(0x419D50, 0x41CCE4, 0x41C205), name = "GetItemPtrByIndex", must = 1; 0}
	 .Info{Sig = "Index"}
	
	function define.m:Destroy(KeepMonPic)
		local p = 0x5A5370
		local old = mmver == 8 and KeepMonPic and u4[p]
		call(mmv(0x4190D0, 0x41C213, 0x41B923), 1, self)
		if old then
			u4[p] = old
		end
	end
end

function structs.f.Button(define)
	define
	[0x0].i4  'Left'
	[0x4].i4  'Top'
	[0x8].i4  'Width'
	[0xC].i4  'Height'
	[0x10].i4  'Right'
	[0x14].i4  'Bottom'
	[0x18].i4  'Shape'
	[0x1C].i4  'HintAction'
	[0x20].i4  'ActionType'
	[0x24].i4  'ActionParam'
	local o = 0
	if mmver > 6 then
		define[0x28].i4  'ActionParam2'
		o = 4
	end
	define
	[0x28+o].b4  'Pressed'
	-- [0x2C+o].alt.pstruct(structs.Button)  'PrevItem'
	[0x2C+o].u4  'PrevItemPtr'
	-- [0x30+o].alt.pstruct(structs.Button)  'NextItem'
	[0x30+o].u4  'NextItemPtr'
	[0x34+o].alt.pstruct(structs.Dlg)  'Parent'
	[0x34+o].u4  'ParentPtr'
	[0x38+o].array{5, lenA = i4, lenP = 0x4C+o}.i4  'Sprites'
	[0x50+o].u1  'ShortCut'
	[0x51+o].string(103)  'Hint'
	.size = 0xB8+o
	
	local function GetLink(p, nxt, parent)
		return p == 0 and parent + 0x4C + (nxt and 0 or 4) or p+o + 0x2C + (nxt and 4 or 0)
	end
	function define.m:Destroy()
		local p = self['?ptr']
		local pn = u4[GetLink(p, true)]
		local pl = u4[GetLink(p, false)]
		local parent = u4[p+o + 0x34]
		u4[GetLink(pl, true, parent)] = pn
		u4[GetLink(pn, false, parent)] = pl
		u4[parent + 0x20] = u4[parent + 0x20] - 1
		mem.freeMM(p)
	end
	define.Info "Make sure to update Parent.KeyboardItemsCount on your own if you delete one of them"
end

function structs.f.MonsterAttackInfo(define)
	define
	.u1  'Type'
	.u1  'DamageDiceCount'  -- ATTACK1_DAMAGE_DICE_COUNT
	.u1  'DamageDiceSides'  -- ATTACK1_DAMAGE_DICE_TYPE
	.u1  'DamageAdd'  -- ATTACK1_DAMAGE_DICE_ADJUSTMENT
	.u1  'Missile'  -- ATTACK1_MISSILE_TYPE
end

function structs.f.MonsterSchedule(define)
	define
	.array(3).i2  'Pos'
	[0].i2  'X'  -- Schedule#1:x
	.i2  'Y'  -- Schedule#1:y
	.i2  'Z'  -- Schedule#1:z
	.u2  'Bits'  -- Schedule#1:attributes  (1 - on)
	 .Info "(1 - on)"
	.u1  'Action'  -- Schedule#1:action
	.u1  'Hour'  -- Schedule#1:hour
	.u1  'Day'  -- Schedule#1:day
	.u1  'Month'  -- Schedule#1:month
end

local function CommonMonsterProps(define, montxt)
	if montxt then
		define
		.EditPChar  'Name'  -- 0x0
		.EditPChar  'Picture'  -- 0x4
	else
		define.skip(8)
	end
	if mmver == 6 then
		define.u1  'Id'  -- 0x8
		 .Info "Changing may cause random crashes after loading the game! Be careful."
	end
	define
	.u1  'Level'  -- 0x9/0x8
	.u1  'TreasureItemPercent'  -- 0xA/0x9
	.u1  'TreasureDiceCount'  -- 0xB/0xA
	.u1  'TreasureDiceSides'  -- 0xC/0xB
	.u1  'TreasureItemLevel'  -- 0xD/0xC
	.u1  'TreasureItemType'  -- 0xE/0xD
	.u1  'Fly'  -- 0xF/0xE
	.u1  'MoveType'  -- 0x10/0xF
	.u1  'AIType'  -- 0x11/0x10
	.u1  'HostileType'  -- 0x12/0x11
	if mmver == 6 then
		define
		.union  'Prefers'
			internal.MonsterPref(define)
		.union()
		.u1  'PrefClass'  -- 0x13/0x54(u4)    Preferred target
		 .Info "Preferred target"
	else
		define.skip(1)
	end
	define


	.u1  'Bonus'  -- 0x14/0x13    (steal, curse, ...)
	 .Info "(steal, curse, ...)"
	.u1  'BonusMul'  -- 0x15/0x14
	 .Info "Disease1x5 etc. The chance that a monster would use the bonus is 'Level'*'BonusMul'"
	.struct(structs.MonsterAttackInfo)  'Attack1'  -- 0x16/0x15
	.u1  'Attack2Chance'  -- 0x1B/0x1A    ATTACK2_PERCENTAGE
	.struct(structs.MonsterAttackInfo)  'Attack2'  -- 0x1C/0x1B
	.u1  'SpellChance'  -- 0x21/0x20    SPELL_ATTACK_USE_PERCENTAGE
	.u1  'Spell'  -- 0x22/0x21    SPELL_ID
	if mmver == 6 then
		define
		.u1  'SpellSkill'  -- 0x23    SPELL_RANK_AND_SKILL_LEVEL
		--.array(6).u1  'Resistances'  -- won't work due to physical resistance (monsters have it before Magic, chars don't have it)
		local p = define.offset
		define.union  'Resistances'
			.u1(const.Damage.Fire)
			.u1(const.Damage.Elec)
			.u1(const.Damage.Cold)
			.u1(const.Damage.Poison)
			.u1(const.Damage.Phys)
			.u1(const.Damage.Magic)
		.union().Info{Sig = "[kind:const.Damage]"; "For immunity use #const.MonsterImmune:#"}
		[p]
		.u1  'FireResistance'  -- 0x24    FIRE_RESISTANCE
		.u1  'ElecResistance'  -- 0x25    ELECTRICAL_RESISTANCE
		.u1  'ColdResistance'  -- 0x26    COLD_RESISTANCE
		.u1  'PoisonResistance'  -- 0x27    POISON_RESISTANCE
		.u1  'PhysResistance'  -- 0x28    PHYSICAL_RESISTANCE
		.u1  'MagicResistance'  -- 0x29    MAGICAL_RESISTANCE
		.u1  'PrefNum'  -- 0x2A
		 .Info "Number of party members to hit using Attack1 & Attack2"
		.skip(1)  -- 0x2B    PADDING?
		.i2  'QuestItem'  -- 0x2C  attributes
	else  -- MM7, MM8
		define
		.u1  'Spell2Chance'  -- nil/0x22    SPELL_ATTACK_USE_PERCENTAGE
		.u1  'Spell2'  -- nil/0x23    SPELL_ATTACK_USE_PERCENTAGE
		local p = define.offset
		local res = mmv(nil, define.u1, define.u2)
		define.union  'Resistances'
			res(const.Damage.Fire)
			res(const.Damage.Air)
			res(const.Damage.Water)
			res(const.Damage.Earth)
			res(const.Damage.Mind)
			res(const.Damage.Spirit)
			res(const.Damage.Body)
			res(const.Damage.Light)
			res(const.Damage.Dark)
			res(const.Damage.Phys)
		.union()
		.goto(p)
		res  'FireResistance'  -- 0x24
		res  'AirResistance'  -- 0x25
		res  'WaterResistance'  -- 0x26
		res  'EarthResistance'  -- 0x27
		res  'MindResistance'  -- 0x28
		res  'SpiritResistance'  -- 0x29
		res  'BodyResistance'  -- 0x2A
		res  'LightResistance'  -- 0x2B
		res  'DarkResistance'  -- 0x2C
		res  'PhysResistance'  -- 0x2D
		.u1  'Special'  -- 0x2E  {shot, summon, explode}
		 .Info ("1 = shot, 2 = summon, 3 = explode")
		.u1  'SpecialA'  -- 0x2F
		 .Info (
		 "shot: C = count\n"..
		 "summon: A = {RandomLevel = 0, fixed = 1} - monster level (0 means A, B or C is chosen randomly, monster index should be that of A variation. Values of 2 and 3 are the same as 1, but in MM7 before GrayFace Patch v2.1 it was causing a bug), B = {ground = 0, air = 1}, C = already summoned count (up to 3), D = monster index\n"..
		 "explode: AdB + C, D = attack type")
		.u1  'SpecialB'  -- 0x30
		 .Info {Merge = "SpecialA"}
		.u1  'SpecialC'  -- 0x31
		 .Info {Merge = "SpecialA"}
		.u1  'PrefNum'  -- 0x32
		 .Info "Number of party members to hit using 'Attack1' & 'Attack2'"
		.skip(1)
		.u2  'Id'  -- 0x34
		.u2  'BloodSplat'  -- 0x36  attributes (Quest)!!!
		.u2  'SpellSkill'  -- 0x38
		.u2  'Spell2Skill'  -- 0x3A
		.u2  'SpecialD'  -- 0x3C
		 .Info "(summoned monster or damage type in case of explosive attack)"
	end
	if mmver < 8 then
		define.skip(2)  -- 0x2E/0x3E
	end
	define
	.alt.i4  'FullHP'  -- 0x30/0x40   HIT_POINTS
	.i4  'FullHitPoints'  -- 0x30/0x40   HIT_POINTS
	.i4  'ArmorClass'  -- 0x34/0x44   ARMOR_CLASS
	.alt.i4  'Exp'  -- 0x38/0x48   EXPERIENCE
	.i4  'Experience'  -- 0x38/0x48   EXPERIENCE
	.i4  'MoveSpeed'  -- 0x3C/0x4C    ATTACK_SPEED
	.i4  'AttackRecovery'  -- 0x40/0x50    ATTACK_RECOVERY
	if mmver == 6 then
		define.i4  ''  -- 0x44  UNKNOWN2?
	else
		define
		.union  'Prefers'
			internal.MonsterPref(define)
		.union()
		.i4  'PrefClass'  -- 0x54
	end
	return define
end

function structs.f.MonstersTxtItem(define)
	CommonMonsterProps(define, true)
	.size = mmv(0x48, 0x58, 0x60)
end

function structs.f.MapMonster(define)
	if mmver == 6 then
		define[0x0].string(32)  'Name'
	end
	define
	[0x20].i2  'NPC_ID'
	 .Info "[MM6] Index in #Game.StreetNPC:structs.GameStructure.StreetNPC# + 1\n[MM7+] Index in #Game.NPC:structs.GameStructure.NPC# or index in #Game.StreetNPC:structs.GameStructure.StreetNPC# + 5000"
	.skip(2)
	.goto(0x24)  internal.MonsterBits(define)
	[0x24].u4  'Bits'
	 .Info{Type = "const.MonsterBits"}
	[0x28].alt.i2  'HP'
	[0x28].i2  'HitPoints'
	.goto(0x2C)  CommonMonsterProps(define)
	local o = mmv(0, 0x10, 0x18)
	define
	[0x74+o].i2  'RangeAttack'  -- 74/84  RANGE_ATTACK
	[0x76+o].i2  'Id2'  -- !!! MONSTER_ID_TYPE
	[0x78+o].i2  'BodyRadius'  -- PHYSICAL_RADIUS
	[0x7a+o].i2  'BodyHeight'  -- PHYSICAL_HEIGHT
	[0x7c+o].i2  'Velocity'  -- VELOCITY
	[0x7e+o].array(3).i2  'Pos'
	[0x7e+o].i2  'X'  -- X_COORD
	[0x80+o].i2  'Y'  -- Y_COORD
	[0x82+o].i2  'Z'  -- Z_COORD
	[0x84+o].i2  'VelocityX'  -- VELOCITY_X
	[0x86+o].i2  'VelocityY'  -- VELOCITY_Y
	[0x88+o].i2  'VelocityZ'  -- VELOCITY_Z
	[0x8a+o].i2  'Direction'  -- FACING
	[0x8c+o].i2  'LookAngle'  -- TILT
	[0x8e+o].i2  'Room'  -- ROOM
	[0x90+o].i2  'CurrentActionLength'  -- CURRENT_ACTION_LENGTH
	[0x92+o].i2  'StartX'  -- STARTING_X
	[0x94+o].i2  'StartY'  -- STARTING_Y
	[0x96+o].i2  'StartZ'  -- STARTING_Z
	[0x98+o].i2  'GuardX'  -- GUARDING_X
	[0x9a+o].i2  'GuardY'  -- GUARDING_Y
	[0x9c+o].i2  'GuardZ'  -- GUARDING_Z
	[0x9e+o].i2  'GuardRadius'  -- TETHER_DISTANCE
	[0xa0+o].i2  'AIState'  -- AI_STATE
	 .Info {Type = "const.AIState"}
	[0xa2+o].i2  'GraphicState'  -- GRAPHIC_STATE
	[0xa4+o].i2  'Item'  -- ITEM_CARRIED
	.skip(2)  -- PADDING4?
	[0xa8+o].i4  'CurrentActionStep'  -- CURRENT_ACTION_TIME_SO_FAR
	[0xac+o].alt.array(8).i2  'Frames'  -- FRAME_TABLE_STANDING
	[0xac+o].i2  'FramesStand'  -- FRAME_TABLE_STANDING
	[0xae+o].i2  'FramesWalk'  -- FRAME_TABLE_WALKING
	[0xb0+o].i2  'FramesAttack'  -- FRAME_TABLE_NEAR_ATTACK
	[0xb2+o].i2  'FramesShoot'  -- FRAME_TABLE_FAR_ATTACK
	[0xb4+o].i2  'FramesStun'  -- FRAME_TABLE_STUN
	[0xb4+o].i2  'FramesGotHit'  -- FRAME_TABLE_STUN
	 .Info {Type = "Same as FramesStun"}
	[0xb6+o].i2  'FramesDie'  -- FRAME_TABLE_DYING
	[0xb8+o].i2  'FramesDead'  -- FRAME_TABLE_DEAD
	[0xba+o].i2  'FramesFidget'  -- FRAME_TABLE_FIDGETING
	[0xbc+o].alt.array(4).i2  'Sounds'
	[0xbc+o].i2  'SoundAttack'  -- SOUND_EFFECT_1
	[0xbe+o].i2  'SoundDie'  -- SOUND_EFFECT_2
	[0xc0+o].i2  'SoundGetHit'  -- SOUND_EFFECT_3
	[0xc0+o].i2  'SoundGotHit'  -- SOUND_EFFECT_3
	 .Info {Type = "Same as SoundGetHit"}
	[0xc2+o].i2  'SoundFidget'  -- SOUND_EFFECT_4
	[0xc4+o].array(mmv(14, 22, 30)).struct(structs.SpellBuff)  'SpellBuffs'
	 .Info{Sig = "[buff:const.MonsterBuff]"}
	if mmver > 6 then
		define.array(4).struct(structs.Item)  'Items'
		 .Info "Indexes 0 and 1 are used for stolen items, indexes 2 and 3 are used if TreasureGenerated bit is set: index 2 holds the item and index 3 holds the gold."
	end
	o = mmv(0, 0x2c4 - 0x1a4, 0x34c - 0x1a4)
	define
	[0x1a4+o].i4  'Group'
	[0x1a8+o].i4  'Ally'
	 .Info "Monster class that guards or is guraded by this one. That is, !Lua[[(Id + 2):div(3)]], like in Hostile.txt."
	[0x1ac+o].array(8).struct(structs.MonsterSchedule)  'Schedules'
	[0x20c+o].i4  'Summoner'
	[0x210+o].i4  'LastAttacker'
	 .Info "Last one who hit the monster"
	if mmver > 6 then
		define
		[0x214+o].i4  'NameId'  -- NAME_ID
		 .Info "From PlaceMon.txt"
		[0x218+o].skip(3*3)  -- RESERVED
		.method{p = mm78(0x40104C, 0x401051), cc = 2, name = "IsAgainst"; 0}
		 .Info{Sig = "Mon2:structs.MapMonster";  "If 'Mon2' isn't specified, attitude towards party is checked"}
	end
	define.size = mmv(0x224, 0x344, 0x3CC)

	define
	.method{p = mmv(0x44BF50, 0x4595D3, 0x456E90), name = "LoadFrames"; false}
	 .Info{Sig = "SoundLoaded = false";  "If 'SoundLoaded' = 'false', sound indexes would be loaded for the monster as well."}
	.method{p = mmv(0x4219B0, 0x426DC7, 0x425203), name = "ChooseTargetPlayer"}
	 .Info "Returns player slot index"
	.method{p = mmv(0x421DC0, 0x427522, 0x425951), name = "CalcTakenDamage", must = 2, ret = true}
	 .Info{Sig = "DamageKind, Damage";  "Returns the amount of damage the monster has to actually receive"}
	.method{p = mmv(0x421E90, 0x427619, 0x425A4F), name = "CalcHitByEffect", must = 1, ret = true}
	 .Info{Sig = "DamageKind";  "Returns 'true' if the monster couldn't dodge the effect"}
	.method{p = mmv(0x421D50, 0x427464, 0x425893), name = "CalcHitOrMiss", cc = 0, must = 1, ret = true}
	 .Info{Sig = "Player:structs.Player"}
	.method{p = mmv(0x44C140, 0x4597A6, 0x457060), name = "UpdateGraphicState", ret = 'nil'}
	 .Info "Updates #GraphicState:structs.MapMonster.GraphicState# in accordance with #AIState:structs.MapMonster.AIState#"
	if mmver > 6 then
		define.method{p = mm78(0x4A7E19, 0x4A63FA), name = "ShowSpellEffect", cc = 0, ret = 'nil'; 0}
		 .Info{Sig = "Color24 = 0";  "Shows effect from a spell (as a cylinder of colored dots around the monster)"}
	end

	function define.m:GotHit(By, ResetAnimation)
		call(mmv(0x403730, 0x4030AD, 0x4032DD), 2, self:GetIndex(), By or 4, ResetAnimation or false)
	end
	define.Info{Sig = "By = 4, ResetAnimation = false";  "Shows monster's getting hit animation, produces sound and boosts aggression level. 'By' is the attacker #object reference value:structs.ObjectRef.Value#."}
	if mmver > 6 then
		local sounds = {Attack = 0, Die = 1, GotHit = 2, Fidget = 3}
		function define.m:PlaySound(i)
			call(mm78(0x402CED, 0x402DF6), 2, self:GetIndex(), assert(sounds[i] or i))
		end
		define.Info{Sig = "SoundIndex";  [['SoundIndex' is from 0 to 3 or any of these corresponding strings: "Attack", "Die", "GotHit", "Fidget"]]}
	end
	function define.m:LoadFramesAndSounds()
		call(mmv(0x44BF50, 0x4595D3, 0x456E90), 1, self, 0)
		for i = 0, 3 do
			Game.LoadSound(self.Sounds[i])
		end
	end
	function define.m:ChangeLook(id)
		local old = self.Id
		self.Id = id or old
		self:LoadFramesAndSounds()
		self.Id = old
	end
	define.Info{Sig = "id";  "Takes on the look of another monster kind"}
	function define.m:GetPropertiesFromId(id)
		local old = self.Id
		local hp = self.HP/max(self.FullHP, 1)
		mem.copy(self["?ptr"] + structs.o.MapMonster.StandardName,
		         Game.MonstersTxt[id]["?ptr"] + structs.o.MonstersTxtItem.Name, structs.MonstersTxtItem["?size"])
		self.Id = old
		hp = self.FullHP * hp
		if hp > 1 then
			hp = hp:round()
		elseif hp ~= 0 then
			hp = 1
		end
		self.HP = hp
		if mmver == 6 then
			self.Name = self.StandardName
		end
	end
	define.Info{Sig = "id";  "Takes all properties, except appearance and sounds from another monster kind"}
	function define.m:SetId(id)
		self.Id = id
		if self.Id2 ~= 0 then
			self.Id2 = id
		end
	end
	define.Info{Sig = "id";  "Changes 'Id' and, if it's not 0, 'Id2'"}
	function define.m:SetCustomFrames(...)
		local t = {...}
		for i = 1, 8 do
			if t[i] then
				local id = Game.SFTBin:FindGroup(t[i])
				self.Frames[i - 1] = id
				Game.SFTBin:LoadGroup(id)
			end
		end
	end
	define.Info{Sig = "Stand, Walk, Attack, Shoot, Stun, GotHit, Die, Dead, Fidget";  "Any argument can be 'nil'. Also loads the frames."}
	function define.m:GetIndex()
		local a = Map.Monsters
		local i = (self["?ptr"] - a["?ptr"])/self["?size"]
		if i % 1 == 0 and i >= 0 and i < a.Count then
			return i
		end
	end
end


local MM6TPMapPtr = {0x42E623+4, 0x42E617+4, 0x42E5FF+4, 0x42E5F3+4, 0x42E60B+4, 0x42E62F+4}

function structs.f.TownPortalTownInfo(define)
	define
	[0x0].array(3).i4  'Pos'
	[0x0].i4  'X'
	[0x4].i4  'Y'
	[0x8].i4  'Z'
	[0xC].i2  'Direction'
	[0xE].i2  'LookAngle'
	[0x10].i2  'MapStatsIndex'
	[0x12].skip(2) --i2  ''
	.size = 0x14
	if mmver == 6 then
		define
		.CustomType('MapIndex', 0, function(o, obj, name, val)
			local p = (obj["?ptr"] - Game.TownPortalInfo["?ptr"]) / 0x14
			p = MM6TPMapPtr[p + 1]
			if val then
				mem.IgnoreProtection(true)
				u1[p] = val
				mem.IgnoreProtection(false)
			else
				return u1[p]
			end
		end)
	end
	
	define
	[0x10].CustomType('Map', 2, MapInMapStats(i2))
end

function structs.f.LloydBeaconSlot(define)
	define
	[0x0].i8  'ExpireTime'
	[0x8].array(3).i4  'Pos'
	[0x8].i4  'X'
	[0xC].i4  'Y'
	[0x10].i4  'Z'
	[0x14].i2  'Direction'
	[0x16].i2  'LookAngle'
	[0x18].i2  'Active'
	[0x1A].i2  'MapIndex'
	.size = 0x1C
	
	define[0x1A].CustomType('Map', 2, MapInGamesLod)
end

function structs.f.MapStatsItem(define)
	define
	[0x0].EditPChar  'Name'
	[0x4].EditPChar  'FileName'
	[0x8].EditPChar  'Monster1Pic'
	[0xC].EditPChar  'Monster2Pic'
	[0x10].EditPChar  'Monster3Pic'
	[0x14].i4  'ResetCount'
	[0x18].i4  'FirstVisitDay'
	[0x1C].i4  'RefillDays'
	if mmver > 6 then
		define
		[0x20].i4  'AlertDays'
		[0x24].i4  'StealPerm'
		[0x28].i4  'Per'
	end
	define
	.skip(1)
	.u1  'Lock'
	 .Info "x5Lock"
	.u1  'Trap'
	 .Info "D20sTrap"
	.u1  'Tres'
	.u1  'EncounterChance'
	.u1  'EncounterChanceM1'
	.u1  'EncounterChanceM2'
	.u1  'EncounterChanceM3'
	.u1  'Mon1Dif'
	.u1  'Mon1Low'
	.u1  'Mon1Hi'
	.u1  'Mon2Dif'
	.u1  'Mon2Low'
	.u1  'Mon2Hi'
	.u1  'Mon3Dif'
	.u1  'Mon3Low'
	.u1  'Mon3Hi'
	.skip(3)
	.u1  'RedbookTrack'
	if mmver > 6 then
		define
		.u1  'EaxEnvironments'
		.skip(2)
	else
		define.skip(3)
	end
	define.size = mmv(0x38, 0x44, 0x44)
end

function structs.f.ItemsTxtItem(define)
	define
	[0x0].EditPChar  'Picture'
	[0x4].EditPChar  'Name'
	[0x8].EditPChar  'NotIdentifiedName'
	[0xC].EditPChar  'Notes'
	[0x10].i4  'Value'
	local o = 0
	if mmver > 6 then
		define
		[0x14].i2  'SpriteIndex'
		.skip(2)
		[0x18].i2  'EquipX'
		[0x1A].i2  'EquipY'
		o = 0x8
	end
	define
	[0x14+o].u1  'EquipStat'
	 .Info "Subtract 1 from #const.ItemType:# value"
	if mmver > 6 then
		define.u1  'Skill'
	else
		define.CustomType('Skill', 1, function(o, obj, name, val)
			if val == nil then
				return u1[obj['?ptr'] + o] - 1
			else
				u1[obj['?ptr'] + o] = val + 1
			end
		end)
	end
	define
	 .Info {Type = "const.Skill"}
	[0x16+o].u1  'Mod1DiceCount'
	[0x17+o].u1  'Mod1DiceSides'
	[0x18+o].u1  'Mod2'
	[0x19+o].u1  'Material'
	 .Info "0 = normal,  1 = artifact,  2 = relic,  3 = special"
	if mmver > 6 then
		define
		[0x22].u1  'Bonus2'
		 .Info "VarA"
		[0x23].u1  'Bonus'
		 .Info "VarA"
		[0x24].u1  'BonusStrength'
		 .Info "VarB"
		.skip(3)
		o = 0xE
	end
	define
	[0x1B+o].array(1, 6).u1  'ChanceByLevel'
	[0x20+o].i1  'IdRepSt' -- ID/Rep/St
	if mmver == 6 then
		define
		[0x21].i1  'SpriteIndex'
		[0x22].i2  'EquipX'
		[0x24].i2  'EquipY'
		.skip(2)
	else
		define.skip(1)
	end
	define.size = mmv(0x28, 0x30, 0x30)
end

function structs.f.StdItemsTxtItem(define)
	define
	.EditPChar  'NameAdd'
	.EditPChar  'BonusStat'
	.alt.array(9).u1  'ChanceForSlot'
	.u1  'Arm'
	.u1  'Shld'
	.u1  'Helm'
	.u1  'Belt'
	.u1  'Cape'
	.u1  'Gaunt'
	.u1  'Boot'
	.u1  'Ring'
	.u1  'Amul'
	.size = 0x14
end

function structs.f.SpcItemsTxtItem(define)
	define
	.EditPChar  'NameAdd'
	.EditPChar  'BonusStat'
	.alt.array(12).u1  'ChanceForSlot'
	.u1  'W1'
	.u1  'W2'
	.u1  'Miss'
	.u1  'Arm'
	.u1  'Shld'
	.u1  'Helm'
	.u1  'Belt'
	.u1  'Cape'
	.u1  'Gaunt'
	.u1  'Boot'
	.u1  'Ring'
	.u1  'Amul'
	.i4  'Value'
	.u1  'Lvl'
	.size = 0x1C
end

if mmver == 6 then
	function structs.f.SpellInfo(define)
		define
		-- copied from spells.txt by my patch
		[0x0].array(1, 3).i2  'SpellPoints'
		[0x0].i2  'SpellPointsNormal'
		[0x2].i2  'SpellPointsExpert'
		[0x4].i2  'SpellPointsMaster'
		-- hard-coded
		[0x6].array(1, 3).i2  'Delay'
		[0x6].i2  'DelayNormal'
		[0x8].i2  'DelayExpert'
		[0xA].i2  'DelayMaster'
		-- from spells.txt
		[0xC].u2  'Bits'  -- Bits? (always zero)
		.size = 0xE
	end
else
	function structs.f.SpellInfo(define)
		define
		-- hard-coded
		[0x0].array(1, 4).i2  'SpellPoints'
		[0x0].i2  'SpellPointsNormal'
		[0x2].i2  'SpellPointsExpert'
		[0x4].i2  'SpellPointsMaster'
		[0x6].i2  'SpellPointsGM'
		[0x8].array(1, 4).i2  'Delay'
		[0x8].i2  'DelayNormal'
		[0xA].i2  'DelayExpert'
		[0xC].i2  'DelayMaster'
		[0xE].i2  'DelayGM'
		[0x10].u1  'DamageAdd'
		[0x11].u1  'DamageDiceSides'
		-- from spells.txt
		[0x12].bit('CastByMonster', 0x0001)  -- M
		 .Info '"M" in "Stats" from spells.txt'
		[0x12].bit('CastByEvent', 0x0002)  -- E
		 .Info '"E" in "Stats" from spells.txt'
		[0x12].bit('CauseDamage', 0x0004)  -- C
		 .Info '"C" in "Stats" from spells.txt'
		[0x12].bit('SpecialDamage', 0x0008)  -- X
		 .Info '"X" in "Stats" from spells.txt'
		[0x12].u2  'Bits'
		.size = 0x14
	end
end

function structs.f.SpellsTxtItem(define)
	define
	[0x0].EditPChar  'Name'
	[0x4].EditPChar  'ShortName'
	[0x8].EditPChar  'Description'
	[0xC].EditPChar  'Normal'
	[0x10].EditPChar  'Expert'
	[0x14].EditPChar  'Master'
	if mmver > 6 then
		define
		[0x18].alt.EditPChar  'GM'
		[0x18].EditPChar  'GrandMaster'
	end
	define
	.u1  'DamageType'
	.alt.array(1, mmv(3, 4, 4)).u1  'SpellPoints'
	.u1  'SpellPointsNormal'
	.u1  'SpellPointsExpert'
	.u1  'SpellPointsMaster'
	if mmver ~= 6 then
		define.u1  'SpellPointsGM'
	end
	define.size = mmv(0x1C, 0x24, 0x24)
end

function structs.f.Events2DItem(define)
	define
	[0x0].i2  'Type'
	[0x2].i2  'Picture'
	[0x4].EditPChar  'Name'
	[0x8].EditPChar  'OwnerName'
	[0xC].EditPChar  'EnterText'
	[0x10].EditPChar  'OwnerTitle'
	[0x14].i2  'PictureUnk'
	[0x16].i2  'State'
	[0x18].i2  'Rep'
	[0x1A].i2  'Per'
	[0x1C].i2  'C'
	.skip(2)
	[0x20].r4  'Val'
	if mmver > 6 then
		define
		[0x24].r4  'A'
	end
	define
	.i2  'OpenHour'  -- 0x24
	.i2  'CloseHour'  -- 0x26
	.i2  'ExitPic'  -- 0x28
	.i2  'ExitMap'  -- 0x2A
	.alt.i2  'QBit'
	.i2  'QuestBitRestriction'  -- 0x2C
	 .Info '(old name)'
	.skip(2)
	.size = mmv(0x30, 0x34, 0x34)
end

function structs.f.HouseMovie(define)
	define
	.EditPChar  'FileName'
	.u1  'Background'
	 .Info "EVTPAR* index, used only in MM6"
	.skip(3)
	.i4  'NPCPic'
	.u1  'HouseType'
	.u1  'Sounds'
	 .Info "30000 + Sounds*100 is the Id in Sounds.txt"
	.skip(2)
	.size = 0x10
end

function structs.f.ActionItem(define)
	define
	.i4  'Action'
	.i4  'Param'
	.i4  'Param2'
end

function structs.f.MapObject(define)
	define
	[0x0].i2  'Type'
	 .Info "look type  (see Id in dobjlist.bin)"
	[0x2].i2  'TypeIndex'
	 .Info "line in dobjlist.bin"
	[0x4].array(3).i4  'Pos'
	[0x4].i4  'X'
	[0x8].i4  'Y'
	[0xc].i4  'Z'
	[0x10].array(3).i2  'Velocity'
	[0x10].i2  'VelocityX'
	[0x12].i2  'VelocityY'
	[0x14].i2  'VelocityZ'
	[0x16].i2  'Direction'
	[0x18].i2  'LookAngle'
	[0x1a].bit('Visible', 0x0001)
	[0x1a].bit('Temporary', 0x0002)
	[0x1a].bit('HaltTurnBased', 0x0004)  -- turn based mode must wait until this object hits or is removed
	[0x1a].bit('DroppedByPlayer', 0x0008)
	[0x1a].bit('IgnoreRange', 0x0010)  -- override any range limits of this object
	[0x1a].bit('NoZBuffer', 0x0020)  -- object should not check zbuffer
	[0x1a].bit('SkipAFrame', 0x0040)  -- object movement will not update for one frame
	[0x1a].bit('AttachToHead', 0x0080)  -- object moves with target, seemingly attached to it's head.
	[0x1a].bit('Missile', 0x0100)  -- item field contains the launching weapon
	[0x1a].bit('Removed', 0x0200)  -- item was removed
	[0x1a].u2  'Bits'
	[0x1c].i2  'Room'
	[0x1e].i2  'Age'
	[0x20].i2  'MaxAge'
	[0x22].i2  'LightMultiplier'
	[0x24].struct(structs.Item)  'Item'
	-- Here are properties of chest traps and spells:
	.alt.i4  'SpellType'
	.i4  'Spell'
	 .Info "same as 'SpellType'"
	.i4  'SpellSkill'
	.alt.i4  'SpellLevel'
	.i4  'SpellMastery'
	 .Info "same as 'SpellLevel'"
	if mmver > 6 then
		define.pstruct(structs.SpellEffect)  'SpellEffect'
	end
	define
	.i4  'Owner'
	.i4  'Target'
	.u1  'Range'
	 .Info  "Distance to target: 0 - less than 307.2, 1 - less than 1024, 2 - less then 2560, 3 - 2560 or more"
	.u1  'AttackType'
	 .Info  "0 - Attack1, 1 - Attack2, 2 - Spell, 3 - Spell2, 4 - Explode"
	.skip(2)
	.alt.array(3).i4  'StartPos'
	.i4  'StartX'
	 .Info "starting x"
	.i4  'StartY'
	 .Info "starting y"
	.i4  'StartZ'
	 .Info "starting z"
	.size = mmv(0x64, 0x70, 0x70)
end

function structs.f.SpellEffect(define)
end

function structs.f.MapChest(define)
	define
	.i2  'ChestPicture'
	 .Info "0..7  chest id"
	internal.ChestBits(define)
	[0x2].u2  'Bits'
	 .Info{Type = "const.ChestBits"}
	[0x4].array(1, 140).struct(structs.Item)  'Items'
	.array(140).i2  'Inventory'
	 .Info "('Items' index) for main item cell,  -(1 + main 'Inventory' cell index) for other cells"
	local RefundChestArtifacts = offsets.PatchDll.RefundChestArtifacts
	function define.m:RefundArtifacts()
		return not not (RefundChestArtifacts and RefundChestArtifacts(self['?ptr']))
	end
end

function structs.f.MapSprite(define)
	local size = mmv(0x1C, 0x20, 0x20)
	define
	[0x0].alt.i2  'DecListId'  -- DecList ID #
	.CustomType('DecName', 2, function(o, obj, name, val)
		if val ~= nil then
			if Game.Version == 6 then
				evt.SetSprite((obj["?ptr"] - Map.Sprites["?ptr"])/size, obj.Invisible and 0 or 1, val)
			else
				obj.DecListId = Game.LoadDecSprite(val)
			end
		else
			local id = obj.DecListId
			return id > 0 and mem.string(u4[mmv(0x5E2188, 0x69AC54, 0x6C8B5C) + 4] + mmv(80, 84, 84)*id) or nil
		end
	end)
	define
	.goto(0x2) internal.SpriteBits(define)
	[0x2].u2  'Bits'  -- attributes
	 .Info{Type = "const.SpriteBits"}
	[0x4].array(3).i4  'Pos'
	[0x4].i4  'X'
	[0x8].i4  'Y'
	[0xc].i4  'Z'
	[0x10].i4  'Direction'
	[0x14].i2  (mmv('EventVariable', 'Id', 'Id'))
	[0x16].i2  'Event'
	 .Info "normal event"
	[0x18].i2  'TriggerRadius'  -- variable1
	--[0x1a].i2  ''  -- variable2
	if mmver > 6 then
		define
		[0x1C].i2  'EventVariable'
		 .Info "event variable for barrels etc."
		.skip(2)
	end
	define.size = size
end

function structs.f.FloatVector(define)
	define
	[0x0].r4  (1)
	 .Info "same as 'X'"
	[0x0].r4  'X'
	[0x4].r4  (2)
	 .Info "same as 'Y'"
	[0x4].r4  'Y'
	[0x8].r4  (3)
	 .Info "same as 'Z'"
	[0x8].r4  'Z'
	.size = 0xC
end

function structs.f.MapVertex(define)
	define
	[0x0].i2  (1)
	 .Info "same as 'X'"
	[0x0].i2  'X'
	[0x2].i2  (2)
	 .Info "same as 'Y'"
	[0x2].i2  'Y'
	[0x4].i2  (3)
	 .Info "same as 'Z'"
	[0x4].i2  'Z'
	.size = 0x6
end

function structs.f.ModelVertex(define)
	define
	[0x0].i4  (1)
	 .Info "same as 'X'"
	[0x0].i4  'X'
	[0x4].i4  (2)
	 .Info "same as 'Y'"
	[0x4].i4  'Y'
	[0x8].i4  (3)
	 .Info "same as 'Z'"
	[0x8].i4  'Z'
	.size = 0xC
end

function structs.f.BSPNode(define)
	define
	.i2  'FrontNode'  -- Front Node
	.i2  'BackNode'  -- Back Node
	.i2  'CoplanarOffset'  -- Coplanar Offset
	.i2  'CoplanarSize'  -- Coplanar Size
	.size = 8
end

local function FacetCommon(define)
	define
	.alt.array(3).i4  'Normal'
	 .Info "normal fixed pt (0..0x10000)"
	.i4  'NormalX'
	 .Info "normal X fixed pt (0..0x10000)"
	.i4  'NormalY'
	 .Info "normal Y fixed pt (0..0x10000)"
	.i4  'NormalZ'
	 .Info "normal Z fixed pt (0..0x10000)"
	.i4  'NormalDistance'
	 .Info "normal distance fixed pt (0..0x10000)"
	.i4  'ZCalc1'
	 .Info "  !Lua[[= -(NormalX * 2^16) / NormalZ         ]](or 0 if 'NormalZ' is 0)"
	.i4  'ZCalc2'
	 .Info "  !Lua[[= -(NormalY * 2^16) / NormalZ         ]](or 0 if 'NormalZ' is 0)"
	.i4  'ZCalc3'
	 .Info "  !Lua[[= -(NormalDistance * 2^16) / NormalZ  ]](or 0 if 'NormalZ' is 0)"
	internal.FacetBits(define)
	.u4  'Bits'
	 .Info{Type = "const.FacetBits"}
	return define
end

function structs.f.MapFacet(define)
	if mmver > 6 then
		define
		[0x0].alt.array(3).r4  'NormalF'
		 .Info "normal float"
		[0x0].r4  'NormalFX'
		 .Info "normal X float"
		[0x4].r4  'NormalFY'
		 .Info "normal Y float"
		[0x8].r4  'NormalFZ'
		 .Info "normal Z float"
		[0xC].r4  'NormalFDistance'
		 .Info "normal distance float"
	end
	local o = mmv(0, 0x10, 0x10)
	FacetCommon(define)
	[0x20+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.u2  'VertexIds'
	[0x24+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.i2  'XInterceptDisplacement'
	[0x28+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.i2  'YInterceptDisplacement'
	[0x2c+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.i2  'ZInterceptDisplacement'
	[0x30+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.i2  'UList'
	[0x34+o].parray{lenA = u1, lenP = 0x4d+o, AccessBeyondLength = 1}.i2  'VList'
	[0x38+o].u2  'DataIndex'
	[0x3a+o].i2  'BitmapId'
	 .Info "Bitmap Index"
	[0x3c+o].i2  'Room'
	 .Info "Room #"
	[0x3e+o].i2  'RoomBehind'
	 .Info "Room # Behind facet"
	[0x40+o].i2  'MinX'  .Info "Bounding Box Min X"
	[0x42+o].i2  'MaxX'  .Info "Bounding Box Max X"
	[0x44+o].i2  'MinY'  .Info "Bounding Box Min Y"
	[0x46+o].i2  'MaxY'  .Info "Bounding Box Max Y"
	[0x48+o].i2  'MinZ'  .Info "Bounding Box Min Z"
	[0x4a+o].i2  'MaxZ'  .Info "Bounding Box Max Z"
	[0x4c+o].u1  'PolygonType'
	 .Info ("Polygon type:\n"..
	 "0 = empty\n"..
	 "1 = wall\n"..
	 "2 = unused\n"..
	 "3 = horizontal floor\n"..
	 "4 = irregular floor (non-horizontal)\n"..
	 "5 = horizontal ceiling\n"..
	 "6 = irregular ceiling (non-horizontal)")
	[0x4d+o].u1  'VertexesCount'
	[0x4e+o].skip(2)
	.size = mmv(0x50, 0x60, 0x60)
end

function structs.f.FacetData(define)
	define
	[0x0].i4  ''  -- Z Fade
	[0x4].i4  ''  -- X Fade
	[0x8].i4  ''  -- Y Fade
	[0xc].i2  'FacetIndex'  -- Facet Index
	[0xe].i2  'BitmapIndex'  -- Bitmap Index
	[0x10].i2  'TFTIndex'  -- Texture FrameTable Index
	[0x12].i2  ''  -- Texture FrameTable Cog Index
	[0x14].i2  'BitmapU'
	 .Info "Bitmap U Offset"
	[0x16].i2  'BitmapV'
	 .Info "Bitmap V Offset"
	[0x18].i2  'Id'  -- Cog Number
	[0x1a].i2  'Event'  -- Cog Triggered
	[0x1c].i2  ''  -- Cog Trigger Type
	[0x1e].i2  ''  -- Fade Base X Index
	[0x20].i2  ''  -- Fade Base Y
	[0x22].i2  ''  -- Light Level
	.size = 0x24
end

function structs.f.ModelFacet(define)
	FacetCommon(define)
	[0x20].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'VertexIds'
	[0x48].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'UList'
	[0x70].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'VList'
	--[0x98].array(3).array{20, lenA = u1, lenP = 0x12e}.i2  'InterceptDisplacement'
	[0x98].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'XInterceptDisplacement'
	[0xc0].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'YInterceptDisplacement'
	[0xe8].array{20, lenA = u1, lenP = 0x12e, AccessBeyondLength = true}.i2  'ZInterceptDisplacement'
	[0x110].i2  'BitmapId'  -- BITMAP_INDEX
	[0x112].i2  'BitmapU'
	[0x114].i2  'BitmapV'
	[0x116].i2  'MinX'  .Info "Bounding Box Min X"
	[0x118].i2  'MaxX'  .Info "Bounding Box Max X"
	[0x11a].i2  'MinY'  .Info "Bounding Box Min Y"
	[0x11c].i2  'MaxY'  .Info "Bounding Box Max Y"
	[0x11e].i2  'MinZ'  .Info "Bounding Box Min Z"
	[0x120].i2  'MaxZ'  .Info "Bounding Box Max Z"
	[0x122].i2  'Id'  -- COG_NUMBER
	[0x124].i2  'Event'  -- COG_TRIGGERED_NUMBER
	[0x126].i2  ''  -- COG_TRIGGER_TYPE
	[0x128].skip(2)  -- RESERVED
	[0x12a].array(4).u1  'GradientVertexes'  -- GRADIENT_VERTEXES_LIST
	[0x12e].u1  'VertexesCount'  -- VERTEX_COUNT
	[0x12f].u1  'PolygonType'  -- POLYGON_TYPE
	 .Info ("Polygon type:\n"..
	 "0 = empty\n"..
	 "1 = wall\n"..
	 "2 = unused\n"..
	 "3 = horizontal floor\n"..
	 "4 = irregular floor (non-horizontal)\n"..
	 "5 = horizontal ceiling\n"..
	 "6 = irregular ceiling (non-horizontal)")
	[0x130].u1  ''  -- SHADE
	[0x131].u1  ''  -- VISIBILITY (ATM)
	.skip(2)
	.size = 0x134
end

function structs.f.MapModel(define)
	define
	[0x00].string(32)  'Name'
	[0x20].string(32)  'Name2'
	[0x40].bit('ShowOnMap', 1)
	[0x40].u4  'Bits'  -- Attributes
	[0x48].parray{lenA = i4, lenP = 0x44}.struct(structs.ModelVertex)  'Vertexes'  -- VERTEX_OFFSET
	[0x50].i2  'ConvexFacetsCount'  -- # of Convex Facets
	[0x52].skip(2)  -- Unused
	[0x54].parray{lenA = i4, lenP = 0x4c}.struct(structs.ModelFacet)  'Facets'  -- FACES_OFFSET
	[0x58].parray{lenA = i4, lenP = 0x4c}.i2  'Ordering'  -- ORDERING_OFFSET
	[0x60].parray{lenA = i4, lenP = 0x5c}.struct(structs.BSPNode)  'BSPNodes'  -- BSPNODE_OFFSET
	[0x64].skip(4)  -- # of Decorations
	[0x68].i4  'GridX'
	 .Info "center X"
	[0x6c].i4  'GridY'
	 .Info "center Y"
	[0x70].array(3).i4  'Pos'
	[0x70].i4  'X'  -- X
	[0x74].i4  'Y'  -- Y
	[0x78].i4  'Z'  -- Z
	[0x7c].i4  'MinX'
	 .Info "Bounding MIN X"
	[0x80].i4  'MinY'
	 .Info "Bounding MIN Y"
	[0x84].i4  'MinZ'
	 .Info "Bounding MIN Z"
	[0x88].i4  'MaxX'
	 .Info "Bounding MAX X"
	[0x8c].i4  'MaxY'
	 .Info "Bounding MAX Y"
	[0x90].i4  'MaxZ'
	 .Info "Bounding MAX Z"
	[0x94].i4  'BFMinX'  -- BF_MIN_X
	[0x98].i4  'BFMinY'  -- BF_MIN_Y
	[0x9c].i4  'BFMinZ'  -- BF_MIN_Z
	[0xa0].i4  'BFMaxX'  -- BF_MAX_X
	[0xa4].i4  'BFMaxY'  -- BF_MAX_Y
	[0xa8].i4  'BFMaxZ'  -- BF_MAX_Z
	[0xac].i4  'BoxCenterX'
	 .Info "Bounding center X"
	[0xb0].i4  'BoxCenterY'
	 .Info "Bounding center Y"
	[0xb4].i4  'BoxCenterZ'
	 .Info "Bounding center Z"
	[0xb8].i4  'BoundingRadius'  -- Bounding radius
	.size = 0xBC
end

function structs.f.MapRoom(define)
	define
	[0x0].bit('HasNonVerticalPortals', 0x8)
	[0x0].bit('HasBSP', 0x10)
	[0x0].u4  'Bits'  -- Attributes
	local o = mmv(0, 0, 4)
	if mmver == 8 then
		define[0x4].i4  'EaxEnvironment'
	end
	define
	[0x8+o].parray{lenA = i2, lenP = 0x4+o}.i2  'Floors'  -- floor offsets
	[0x10+o].parray{lenA = i2, lenP = 0xc+o}.i2  'Walls'  -- walls offsets
	[0x18+o].parray{lenA = i2, lenP = 0x14+o}.i2  'Ceils'  -- ceilings offsets
	[0x20+o].parray{lenA = i2, lenP = 0x1c+o}.i2  'Fluids'  -- fluids offsets
	[0x28+o].parray{lenA = i2, lenP = 0x24+o}.i2  'Portals'  -- portals offsets
	[0x2e+o].i2  'NonBSPDrawFacetsCount'
	 .Info "# of non-BSP Node facets to draw"
	[0x30+o].parray{lenA = i2, lenP = 0x2c+o}.i2  'DrawFacets'
	 .Info "drawing order"
	[0x34+o].skip(2)  -- # of cylinder facets (not used)
	[0x38+o].skip(4)  -- cylinder facets offsets (not used)
	[0x40+o].parray{lenA = i2, lenP = 0x3C+o}.i2  'Cogs'  -- cogs offsets
	[0x48+o].parray{lenA = i2, lenP = 0x44+o}.i2  'Sprites'  -- decorations offsets
	[0x50+o].parray{lenA = i2, lenP = 0x4c+o}.i2  'Markers'  -- special markers offsets
	[0x58+o].parray{lenA = i2, lenP = 0x54+o}.i2  'Lights'  -- permanent lights offset
	[0x5c+o].i2  ''  -- Water Level
	[0x5e+o].i2  ''  -- Mist Level
	[0x60+o].i2  ''  -- Light Distance Multiplier
	[0x62+o].i2  'Darkness'
	 .Info "Min Ambient Light Level"
	[0x64+o].i2  'FirstBSPNode'
	 .Info "First BSP Node Index"
	[0x66+o].u1  ''  -- Level Room Exits To
	[0x67+o].u1  'ExitTag'  -- Exit Tag
	[0x68+o].i2  'MinX'
	 .Info "Bounding Box Min X"
	[0x6a+o].i2  'MaxX'
	 .Info "Bounding Box Max X"
	[0x6c+o].i2  'MinY'
	 .Info "Bounding Box Min Y"
	[0x6e+o].i2  'MaxY'
	 .Info "Bounding Box Max Y"
	[0x70+o].i2  'MinZ'
	 .Info "Bounding Box Min Z"
	[0x72+o].i2  'MaxZ'
	 .Info "Bounding Box Max Z"
	.size = 0x74+o
end

function structs.f.BaseLight(define)
	define
	[0x0].array(3).i2  'Pos'
	[0x0].i2  'X'  -- X
	[0x2].i2  'Y'  -- Y
	[0x4].i2  'Z'  -- Z
	if mmver > 6 then
		define
		[0x6].i2  'Radius'  -- Radius
		[0x8].u1  'R'
		[0x9].u1  'G'
		[0xA].u1  'B'
		[0xB].u1  'Type'
	else
		define.skip(2)  -- unknown
	end
end

function structs.f.MapLight(define)
	structs.f.BaseLight(define)
	define
	.bit('Off', 0x8)
	.u2  'Bits'  -- Attributes
	if mmver == 6 then
		define.i2  'Radius'  -- Radius
	else
		define.i2  'Brightness'  -- Brightness
	end
	if mmver == 8 then
		define[0x10].i4  'Id'
	end
	define.size = mmv(0xC, 0x10, 0x14)
end

function structs.f.MapOutlines(define)
	define
	[4].array{7000, lenA = i4, lenP = 0}.struct(structs.MapOutline)  'Items'
	.indexmember  'Items'
	.newindexmember  'Items'
end

function structs.f.MapOutline(define)
	define
	[0x0].i2  'Vertex1'  -- Vertex 1
	[0x2].i2  'Vertex2'  -- Vertex 2
	[0x4].i2  'Facet1'  -- Facet 1
	[0x6].i2  'Facet2'  -- Facet 2
	[0x8].i2  'Z'  -- Z
	[0xa].bit('Visible', 1)
	[0xa].u2  'Bits'  -- Attributes
end

function structs.f.SpawnPoint(define)
	define
	[0x0].array(3).i4  'Pos'
	[0x0].i4  'X'  -- X
	[0x4].i4  'Y'  -- Y
	[0x8].i4  'Z'  -- Z
	[0xc].i2  'Radius'  -- Radius
	[0xe].i2  'Kind'  -- Kind  (const.ObjectRefKind)
	 .Info {Type = "const.ObjectRefKind"}
	[0x10].i2  'Index'
	 .Info "Index: monster (1-3: M1-M3,  4-6: M1a-M3a,  7-9: M1b-M3b,  10-12: M1c-M3c) or item (1-6 for regular items, 7 for artifact)"
	[0x12].bit('OnAlertMap', 1)
	[0x12].u2  'Bits'  -- Attributes
	if mmver > 6 then
		define
		[0x14].i4  'Group'  -- Group
	end
end

function structs.f.MapDoor(define)
	define
	[0x0].bit('StartState2', 1)
	.bit('SilentMove', 2)
	.bit('NoSound', 4)
	.bit('Stopped', 8)  -- with evt.StopDoor
	[0x0].u4  'Bits'  -- attributes
	[0x4].i4  'Id'  -- door id
	[0x8].i4  'TimeStep'
	 .Info "time since triggered"
	[0xc].array(3).i4  'Direction'  -- direction x
	[0xc].i4  'DirectionX'  -- direction x
	[0x10].i4  'DirectionY'  -- direction y
	[0x14].i4  'DirectionZ'  -- direction z
	[0x18].i4  'MoveLength'  -- direction magnitude
	[0x1c].i4  'Speed2'
	 .Info "State 3 velocity (speed*time/128 = position)"
	[0x1c].i4  'OpenSpeed'
	 .Info "State 3 velocity (speed*time/128 = position)"
	[0x20].i4  'Speed1'
	 .Info "State 1 velocity (speed*time/128 = position)"
	[0x20].i4  'CloseSpeed'
	 .Info "State 1 velocity"
	[0x24].parray{lenA = i2, lenP = 0x44}.i2  'VertexIds'
	[0x28].parray{lenA = i2, lenP = 0x46}.i2  'FacetIds'
	[0x2c].parray{lenA = i2, lenP = 0x48}.i2  'RoomIds'
	[0x30].parray{lenA = i2, lenP = 0x46}.i2  'FacetStartU'
	[0x34].parray{lenA = i2, lenP = 0x46}.i2  'FacetStartV'
	[0x38].parray{lenA = i2, lenP = 0x4A}.i2  'VertexStartX'
	[0x3c].parray{lenA = i2, lenP = 0x4A}.i2  'VertexStartY'
	[0x40].parray{lenA = i2, lenP = 0x4A}.i2  'VertexStartZ'
	[0x4c].i2  'State'  -- state
	 .Info ("'State' compared with evt.SetDoorState:\n"..
	 "0 = state (0)\n"..
	 "1 = move to (1)\n"..
	 "2 = state (1)\n"..
	 "3 = move to (0)")
	.size = 0x50
end

function structs.f.SFTItem(define)
	define
	.string(12)  'GroupName'
	.string(12)  'SpriteName'
	.array(8).i2  'SpriteIndex'
	 .Info "loaded from sprite list at runtime, chosen based on sprite orientation"
	.i4  'Scale'
	.bit('NotGroupEnd', 0x00000001)
	.bit('Luminous',    0x00000002)
	.bit('GroupStart',  0x00000004)
	.bit('Image1',      0x00000010)
	 .Info "has 1 image (not 8 for different angles)"
	.bit('Center',      0x00000020)
	 .Info "center sprite"
	.bit('Fidget',      0x00000040)
	 .Info "part of monster figet sequence"
	.bit('Loaded',      0x00000080)
	 .Info "group is loaded"
	.bit('Mirror0',     0x00000100)  -- mirror image  0
	.bit('Mirror1',     0x00000200)  -- mirror image  1
	.bit('Mirror2',     0x00000400)  -- mirror image  2
	.bit('Mirror3',     0x00000800)  -- mirror image  3
	.bit('Mirror4',     0x00001000)  -- mirror image  4
	.bit('Mirror5',     0x00002000)  -- mirror image  5
	.bit('Mirror6',     0x00004000)  -- mirror image  6
	.bit('Mirror7',     0x00008000)  -- mirror image  7
	if mmver > 6 then
		define
		.bit('Images3',     0x00010000)
		 .Info "only views 0,2,4 exist (mirrored)"
		.bit('Glow',        0x00020000)
		.bit('Transparent', 0x00040000)
	end
	define[mmv('u2', 'u4', 'u4')]  'Bits'
	.i2  'LightRadius'  -- light level
	.i2  'PaletteId'
	.i2  'PaletteIndex'
	 .Info "palette index (0 if not loaded)"
	.i2  'Time'
	 .Info "time for this frame in 1/32 of a second"
	.i2  'TotalTime'
	 .Info "total time for this group"
	if mmver >= 7 then
		define.skip(2)
	end
end

function structs.f.SFT(define)
	define
	[0x8].i4  'MatchIndex'
	 .Info "used when searching for a group by name"
	[0xC].parray{lenA = i4, lenP = 0}.struct(structs.SFTItem)  'Frames'
	[0x10].parray{lenA = i4, lenP = 4}.parray().struct(structs.SFTItem)  'Groups'
	 .Info "sorted by name"
	[0x14].parray{lenA = i4, lenP = 4}.i2  'GroupIndex'
	.indexmember  'Frames'
	.newindexmember  'Frames'
	
	.method{p = mmv(0x444020, 0x44D83F, 0x44AF24), name = "FindGroup", must = 1; ""}
	.method{p = mmv(0x443CE0, 0x44D53F, 0x44AC21), name = "LoadGroup", must = 1}
end

function BinarySearch(L, H, cmp)  -- assumes there are no duplicates
	while L <= H do
		local i = (L + H):Div(2)
		local c = cmp(i)
		if c > 0 then
			L = i + 1
		elseif c < 0 then
			H = i - 1
		else
			return i, true
		end
	end
	return L, false
end

function structs.SFTGroupType(o, obj, name, val)
	local p = obj["?ptr"] + o
	if val then
		local groups = Game.SFTBin.Groups
		local name = val:lower()
		local i, found = BinarySearch(0, groups.high, function(i)
			local name1 = groups[i][0].GroupName:lower()
			if name < name1 then
				return -1
			elseif name > name1 then
				return 1
			else
				return 0
			end
		end)
		if found then
			mem.i2[p] = Game.SFTBin.GroupIndex[i]
		else
			error(('SFT group "%s" not found'):format(val), 2)
		end
	else
		return Game.SFTBin[mem.i2[p]].GroupName
	end
end

function structs.f.DecListItem(define)
	define
	.string(32)  'Name'
	.string(32)  'GameName'  -- shown on mouse over
	.i2  'Type'
	.i2  'Height'
	.i2  'Radius'
	.i2  'LightRadius'
	.alt.i2  'SFTIndex'
	.CustomType('SFTGroup', 2, structs.SFTGroupType)
	.bit('NoBlockMovement', 0x01)
	.bit('NoDraw', 0x02)
	.bit('FlickerSlow', 0x04)
	.bit('FlickerMedium', 0x08)
	.bit('FlickerFast', 0x10)
	.bit('Marker', 0x20)
	.bit('SlowLoop', 0x40)
	.bit('EmitFire', 0x80)
	.bit('SoundOnDawn', 0x100)
	.bit('SoundOnDusk', 0x200)
	.bit('EmitSmoke', 0x400)
	.u2  'Bits'
	.i2  'SoundId'
	.skip(2)
	if mmver >= 7 then
		define
		.u1  'Red'
		.u1  'Green'
		.u1  'Blue'
		.skip(1)
	end
end

function structs.f.PFTItem(define)
	define
	.u2  'GroupId'
	.u2  'FrameIndex'
	.u2  'Time'
	 .Info "time for this frame in 1/32 of a second"
	.u2  'TotalTime'
	 .Info "total time for this group"
	.bit('NotGroupEnd', 1)
	.bit('GroupStart', 4)
	.u2  'Bits'
end

function structs.f.IFTItem(define)
	define
	.string(12)  'GroupName'
	 .Info "animation name"
	.string(12)  'IconName'
	 .Info "image name in icons.lod"
	.u2  'Time'
	 .Info "time for this frame, units in 1/16 of a second"
	.u2  'TotalTime'
	 .Info "total time for this group"
	.bit('NotGroupEnd', 1)
	.bit('GroupStart', 4)
	.u2  'Bits'
	.u2  'IconIndex'  -- Icon index
end

function structs.f.TFTItem(define)
	define
	.string(12)  'Name'
	 .Info "texture name"
	.i2  'Index'
	 .Info "index in bitmaps.lod"
	.i2  'Time'
	 .Info "time for this frame in 1/32 of a second"
	.i2  'TotalTime'
	 .Info "total time for this group"
	.bit('NotGroupEnd', 1)
	.bit('GroupStart', 2)
	.u2  'Bits'
end

function structs.f.DChestItem(define)
	define
	.string(32)  'Name'
	.u1  'Width'
	.u1  'Height'
	.i2  'ImageIndex'
end

function structs.f.OverlayItem(define)
	define
	.i2  'Id'
	.i2  'Type'
	.alt.i2  'SFTIndex'
	.CustomType('SFTGroup', 2, structs.SFTGroupType)
	.skip(2)
end

function structs.f.ObjListItem(define)
	define
	.string(32)  'Name'
	.i2  'Id'
	.i2  'Radius'
	.i2  'Height'
	.bit('Invisible', 0x0001)  -- object has no sprite
	.bit('Untouchable', 0x0002)  -- object does not effect movement
	.bit('Temporary', 0x0004)  -- object has specific lifetime
	.bit('LifetimeInSFT', 0x0008)  -- read lifetime from SFT
	.bit('NoPickup', 0x0010)  -- object cannot be picked up by player
	.bit('NoGravity', 0x0020)  -- object is unaffected by gravity
	.bit('InterceptAction', 0x0040)  -- object does something when it hits
	.bit('Bounce', 0x0080)  -- object can bounce
	.bit('TrailParticles', 0x0100)  -- must be specified if the object leaves trail
	.bit('TrailFire', 0x0200)
	.bit('TrailLine', 0x0400)
	.u2  'Bits'
	.alt.i2  'SFTIndex'
	.CustomType('SFTGroup', 2, structs.SFTGroupType)
	.i2  'LifeTime'
	if mmver == 6 then
		define.u2  'LoadedParticlesColor'
		 .Info "munged 16-bit color"
	else
		define.u4  'LoadedParticlesColor'
		 .Info "RGBA color with R and B swapped"
	end
	define
	.u2  'Speed'
	 .Info "default speed of object"
	.alt.array(4).u1  'ParticlesColor'
	 .Info "color for particles"
	.u1  'ParticleR'
	.u1  'ParticleG'
	.u1  'ParticleB'
	if mmver > 6 then
		define.u1  'ParticleA'
	end
	define.size = mmv(52, 56, 56)
end

function structs.f.MonListItem(define)
	define
	.i2  'Height'
	.i2  'Radius'
	 .Info "overall monster radius"
	.i2  'Velocity'
	if mmver == 6 then
		define.skip(2)
	else
		define
		.i2  'Radius2'
		 .Info 'monster radius for "to-hit" purposes'
		.alt.i4  'Tint'
		 .Info "tint color for graphic"
		.u1  'TintB'
		.u1  'TintG'
		.u1  'TintR'
		.u1  'TintA'
	end
	define
	.alt.array(4).i2  'Sounds'
	.i2  'SoundAttack'
	.i2  'SoundDie'
	.i2  'SoundGetHit'
	.i2  'SoundFidget'
	.string(mmv(32, 32, 64))  'Name'
	.alt.array(10).string(10)  'FrameNames'
	.string(10)  'FramesStand'  -- FRAME_TABLE_STANDING
	.string(10)  'FramesWalk'  -- FRAME_TABLE_WALKING
	.string(10)  'FramesAttack'  -- FRAME_TABLE_NEAR_ATTACK
	.string(10)  'FramesShoot'  -- FRAME_TABLE_FAR_ATTACK
	.string(10)  'FramesStun'  -- FRAME_TABLE_STUN
	.string(10)  'FramesDie'  -- FRAME_TABLE_DYING
	.string(10)  'FramesDead'  -- FRAME_TABLE_DEAD
	.string(10)  'FramesFidget'  -- FRAME_TABLE_FIDGETING
	.skip(20)
	--.string(10)  'FramesUnk1'
	--.string(10)  'FramesUnk2'
end

function structs.f.SoundsItem(define)
	define
	.string(mmv(32, 32, 64))  'Name'
	 .Info "name of sound file"
	.i4  'Id'
	.i4  'Type'
	 .Info ("type of sound\n"..
	 "0 = (0)      level specific sound, load during level initialization\n"..
	 "1 = (system) system sound, always loaded\n"..
	 "2 = (swap)   level specific sound, that gets loaded and flushed\n"..
	 "3 = (?)\n"..
	 "4 = (lock)   delete sound only when game ends")
	.bit('Locked', 1)
	if mmver > 6 then
		define.bit('Is3D', 2)
	end
	define
	.u4  'Bits'  -- attributes
	.array(17).u4  'Data'
	 .Info "data pointer"
	if mmver > 6 then
		define
		.u4  'Data3D'
		 .Info "3d data pointer"
		.b4  'Decompressed'
		 .Info "true if decompressed and needs to be freed separately"
	end
end

function structs.f.TileItem(define)
	define
	.string(16)  'Name'
	.i2  'Id'
	.i2  'Bitmap'
	.i2  'TileSet'
	.i2  'Section'
	.bit('Burn', 1)
	.bit('Water', 2)
	.bit('Block', 4)
	.bit('Repulse', 8)
	.bit('Flat', 0x10)
	.bit('Wave', 0x20)
	.bit('NoDraw', 0x40)
	.bit('WaterTransition', 0x100)  -- Water2
	.bit('Transition', 0x200)
	.bit('ScrollDown', 0x400)
	.bit('ScrollUp', 0x800)
	.bit('ScrollLeft', 0x1000)
	.bit('ScrollRight', 0x2000)
	.u2  'Bits'
end


function structs.f.EventLine(define)
	define
	-- .Info "Note: Arrays of EventLine have a RemoveEvent(id) method."
	.i4  'Event'
	.i4  'Line'
	.i4  'Offset'
	.Info{new = true, Name = "RemoveEvent", Kind = "method", Sig="id", [==[
It's a method of arrays of EventLine rather than EventLine itself.
E.g. !Lua[[Game.MapEvtLines:RemoveEvent(100)]] would remove standard map event number '100', while !Lua[[Game.GlobalEvtLines:RemoveEvent(100)]] would remove standard global event number '100'.
To know exactly what would be disabled by 'RemoveEvent' method, you can look into text representations of decompiled events. For example, if you disable event '226' in 'OUTE3' in MM6, it will disable both standard !'[=[evt.map[226]]=] handler and 'events.LoadMap' event handler you see after it in the decompiled Lua script. When you see an event handler not associated with a script number in decompiled scripts, it usually belongs to the event right before it.
]==]}
end

function internal.EventLines_RemoveEvent(t, id)
	local p, n = t["?ptr"], t.high
	for i = n*12, 0, -12 do
		if mem.i4[p + i] == id then
			mem.copy(p + i, p + i + 12, n*12 - i)
			n = n - 1
		end
	end
	t.high = n
end

function structs.f.Lod(define)
	define
	[0x0].u4  'File'  
	[0x4].string(256)  'FileName'
	[0x104].b4  'Loaded'
	[0x108].u4  'IOBuffer'
	[0x10C].i4  'IOBufferSize'
	[0x110].i4  'LodHeaderSignature'
	[0x164].string(80)  'Description'
	[0x1BC].i4  'ArchivesCount'
	[0x210].u4  'ArchivesCArray'
	[0x214].string(16)  'Type'
	[0x224].u4  'ChapterHandle'
	[0x228].u4  'ChapterSize'
	[0x230].parray{lenA = i4, lenP = 0x22C}.struct(structs.LodFile)  'Files'
	[0x234].u4  'FilesOffset'
	[0x238].skip(4)
	.method{p = mmv(0x44CCA0, 0x461659, 0x45F09B), name = "HasFile", ret = true, must = 1;  ""}
end

local bmpbuf = mem.StaticAlloc(64)

function structs.f.BitmapsLod(define)
	structs.f.Lod(define)
	if mmver == 6 then
		define
		[0x23C].array{500, lenA = i4, lenP = 0x8EDC}.struct(structs.LodBitmap)  'Bitmaps'
		.size = 0x8EE0  -- not sure
	else
		define
		[0x23C].array{1000, lenA = i4, lenP = 0x11B7C}.struct(structs.LodBitmap)  'Bitmaps'
		[0x11BA4].b4  'KeepCompressed'
		.b4  'IsHardware'
		if mmver == 8 then
			define.skip(4)
		end
		define
		.parray{lenA = i4, lenP = 0x11B7C}.u4  'D3D_Surfaces'
		.parray{lenA = i4, lenP = 0x11B7C}.u4  'D3D_Textures'
		.skip(4)
		.size = 0x11BB8
	end
	
	function define.m:LoadBitmap(name, EnglishD)
		name = name or ""
		mem.copy(bmpbuf, name, min(#name + 1, 63))
		u1[bmpbuf + 63] = 0
		return call(mmv(0x40B430, 0x40FB2C, 0x410D70), 1, self["?ptr"], bmpbuf, (self == Game.IconsLod and 2 or 0), 0, EnglishD or 0)
	end
	function define.m:LoadBitmapPtr(name, EnglishD)
		local i = self:LoadBitmap(name, EnglishD)
		return self.Bitmaps[i]['?ptr']
	end
	function define.m:LoadTFTBitmap(name)
		name = name or ""
		mem.copy(bmpbuf, name, min(#name + 1, 63))
		u1[bmpbuf + 63] = 0
		local p = mmv(0x55DDA0, 0x5C6C38, 0x5E2FC8)
		local bmp = call(mmv(0x444C60, 0x44E18F, 0x44B87B), 1, p, bmpbuf)
		if bmp ~= 0 then
			call(mmv(0x444BE0, 0x44E119, 0x44B801), 1, p, bmp)
			return bmp
		end
	end
end

function structs.f.SpritesLod(define)
	structs.f.Lod(define)
	local p, n = mmv(0x23C, i4[0x450CFB], i4[0x44E558]),  mmv(1500, i4[0x462563], i4[0x4603A5])
	define
	[p].array{n, lenA = i4, lenP = 0xEC9C}.struct(structs.LodSprite)  'SpritesSW'
	[0xECAC].b4  'IsHardware'
	[0xECB0].parray{lenA = i4, lenP = 0xECB4}.struct(structs.LodSpriteD3D)  'SpritesD3D'
	.size = 0xECB8
	
	function define.m:LoadSprite(name, PaletteNumber)  -- MM6 doesn't use PaletteNumber
		local p = self["?ptr"]
		mem.copy(bmpbuf, name, min(#name + 1, 16))  -- may be unnecessary, but it was necessary for LoadBitmap
		u1[bmpbuf + 15] = 0
		return call(mmv(0x490990, 0x4AC723, 0x4AABAE), 1, self["?ptr"], bmpbuf, PaletteNumber or 0)
	end
end

function structs.f.LodFile(define)
	define
	.string(16)  'Name'
	.i4  'Offset'
	.i4  'Size'
	.skip(8)
end

function structs.f.LodBitmap(define)
	define
	[0x0].string(16)  'Name'
	[0x10].i4  'BmpSize'
	[0x14].i4  'DataSize'
	[0x18].i2  'Width'
	[0x1A].i2  'Height'
	[0x1C].i2  'WidthLn2'
	[0x1E].i2  'HeightLn2'
	[0x20].i2  'WidthMinus1'
	[0x22].i2  'HeightMinus1'
	[0x24].i2  'Palette'
	[0x26].i2  'LoadedPalette'
	[0x28].i4  'UnpackedSize'
	[0x2C].u4  'Bits'
	[0x30].i4  'Image'
	[0x34].i4  'ImageDiv2'
	[0x38].i4  'ImageDiv4'
	[0x3C].i4  'ImageDiv8'
	[0x40].i4  'Palette16'
	[0x44].i4  'Palette24'
	.size = 0x48

	function define.m:LoadBitmapPalette()  -- only for bitmaps.lod
		self.LoadedPalette = Game.LoadPalette(self.Palette)
	end
end

function structs.f.LodPcx(define)
	define
	.skip(16)
	.i4  'BufSize'
	.i2  'Width'
	.i2  'Height'
	.i2  'WidthLn2'
	.i2  'HeightLn2'
	.i2  'WidthMinus1'
	.i2  'HeightMinus1'
	.u4  'Bits'
	.i4  'Image'
	.size = 0x28
end

function structs.f.LodSprite(define)
	define
	[0x0].string(12)  'Name'
	[0xC].i4  'DataSize'
	[0x10].i2  'Width'
	[0x12].i2  'Height'
	[0x14].i2  'Palette'
	[0x16].skip(2)
	[0x18].i2  'YSkip'
	[0x1A].skip(2)
	[0x1C].i4  'UnpackedSize'
	[0x20].parray{lenA = i4, lenP = 0x12}.struct(structs.LodSpriteLine)  'Lines'
	[0x24].u4  'Buffer'
	.size = 0x28
end

function structs.f.LodSpriteLine(define)
	define
	.i2  'L'
	.i2  'R'
	.parray().u1  'Pos'
end

function structs.f.LodSpriteD3D(define)
	define
	[0x0].PChar  'Name'  
	[0x4].i4  'Palette'
	[0x8].u4  'Surface'
	[0xC].u4  'Texture'
	[0x10].i4  'AreaX'
	[0x14].i4  'AreaY'
	[0x18].i4  'BufferWidth'
	[0x1C].i4  'BufferHeight'
	[0x20].i4  'AreaWidth'
	[0x24].i4  'AreaHeight'
	.size = 0x28
end

function structs.f.MapNote(define)
	define
	.b1  'Active'
	.skip(1)
	.i2  'X'
	.i2  'Y'
	.string(298)  'Text'
	.i2  'Id'
	.size = 0x132
end

function structs.f.FogChances(define)
	define
	.u1  'Thick'
	.u1  'Medium'
	.u1  'Light'
	.size = mmv(3, 4, 4)
end

function structs.f.FaceAnimationInfo(define)
	define
	.alt.array(1, 2).u1  'Sounds'
	.u1  'Sound1'
	.u1  'Sound2'
	.skip(1)
	.alt.array(1, 5).u1  'Expressions'
	.u1  'Expression1'
	.u1  'Expression2'
	.u1  'Expression3'
	.u1  'Expression4'
	.u1  'Expression5'
end

function structs.f.ShopItemKind(define)
	define
	.i2  'Level'
	.array(1, 4).i2  'Types'
	 .Info{Sig = '[1..4]', Type = "const.ItemType"}
	.indexmember  'Types'
	.newindexmember  'Types'
end

function structs.f.GeneralStoreItemKind(define)
	define
	.i2  'Level'
	.array(1, 6).i2  'Items'
	 .Info{Sig = '[1..6]', "If it's zero, random Boots or Gountlets are generated."}
	.indexmember  'Items'
	.newindexmember  'Items'
end

function structs.f.NPCProfTxtItem(define)
	if mmver == 6 then
		define
		.i4  'Chance'
		.i4  'Cost'
		.i4  'Personality'
		.EditPChar  'Benefit'
		.EditPChar  'JoinText'
		.array(7).EditPChar 'ProfNewsTopic'
		.array(7).EditPChar 'ProfNewsText'
	else
		define
		.i4  'Cost'
		.EditPChar  'Benefit'
		.EditPChar  'ActionText'
		.EditPChar  'JoinText'
		.EditPChar  'DismissText'
	end
end

local function i4_AddOne(o, obj, name, val)
	o = obj["?ptr"] + o
	if val == nil then
		return i4[o] + 1
	else
		i4[o] = val - 1
	end
end

local function ArcIncome(o, obj, name, val)
	local d = i4[Game.Arcomage.MinIncome['?ptr'] + o]
	if val == nil then
		return i4[obj['?ptr'] + o] + d
	else
		i4[obj['?ptr'] + o] = val - d
	end
end

function structs.f.Arcomage(define)
	define
	[mm78(0x4E1860, 0x4F2D34)].i4  'StartingTower'
	.i4  'StartingWall'
	.array(3).CustomType('StartingIncome', 4, ArcIncome)
	 .Info{Sig = "[3]"}
	.CustomType('CardsCount', 4, i4_AddOne)
	 .Info "Internally up to 10 cards are supported."
	.array(3).i4  'MinIncome'
	 .Info{Sig = "[3]", "If you change these values, #StartingIncome:structs.Arcomage.StartingIncome# and #player income:structs.ArcomagePlayer.Income# would also change."}
	.i4  'TowerToWin'
	.i4  'ResToWin'
	[mm78(0x505704, 0x516D5C)].array(3).i4  'StartingRes'
	 .Info{Sig = "[3]"}
	[mm78(0x4DF3A4, 0x4F0224)].i4  'AI'  .Info '0 - 2'
	[mm78(0x505588, 0x516BE0)].array(2).struct(structs.ArcomagePlayer)  'Players'
	 .Info{Sig = "[2]", "Player 0 is the human, player 1 is AI"}
	.indexmember  'Players'
end

function structs.f.ArcomagePlayer(define)
	define
	.string(32)  'Name'
	.b1  'Human'
	.skip(3)
	.i4  'Tower'
	.i4  'Wall'
	.array(3).CustomType('Income', 4, ArcIncome)
	 .Info{Sig = "[3]"}
	.array(3).i4  'Res'
	 .Info{Sig = "[3]"}
	.array(10).i4  'Cards'
	 .Info{Sig = "[10]"}
	.array(10).array(2).i4  'unk'
	 .Info{Sig = "[10][2]"}
	.size = 47*4
end

function structs.f.ProgressBar(define)
	define
	[0xA].u1  'Max'
	.u1  'Current'
	.i4  'Kind'
	-- .array(8).b1  'ShownScreens'
	-- ...
	.method{p = mmv(0x438C30, 0x4434A7, 0x440288), name = "Show"}
	.method{p = mmv(0x438D40, 0x443605, 0x4403DA), name = "Hide"}
	.method{p = mmv(0x438E20, 0x443693, 0x44047E), name = "Draw"}
	.method{p = mmv(0x438D20, 0x4435F0, 0x4403C5), name = "Increment"}
	.method{p = mmv(0x438D00, 0x4435DE, 0x4403B3), name = "SetMax", must = 1}
end

function structs.f.MissileDirection(define)
	define
	.alt.array(3).i4  'DirectionVector'
	.i4  'DirectionX'
	.i4  'DirectionY'
	.i4  'DirectionZ'
	.i4  'Distance'
	.i4  'DistanceXY'
	.i4  'Direction'
	.i4  'LookAngle'
end

function structs.f.MissileSetup(define)
	define
	.bit  'AlwaysShowSprite'
	 .Info "When there's a special way to display the object, still show the sprite as well"
	.bit  'HideSpecialDisplay'
	 .Info "Don't display the object in a special way"
	.bit  'AutoCollision'
	 .Info "When the object hits anything, show an explosion, play explosion sound of the spell and call #MonsterAttacked:events.MonsterAttacked# or #PlayerAttacked:events.PlayerAttacked# appropriately"
	.size = 1
end

function structs.f.DialogLogic(define)
	if mmver > 6 then
		define
		[mm78(0x5C3490, 0x5DB940)].array{1000, lenA = i4, lenP = mm78(0x5063A4, 0x517AF4)}.i4  'List'
		 .Info "List of indexes to be displayed"
		[mm78(0x50639C, 0x517AEC)].i4  'ScrollPage'
		.i4  'CountOnScreen'
		.i4  'ListCount'
		.i4  'ScrollPos'
		.b4  'AutonoteTab6Clicked'
		.b4  'AutonoteTab5Clicked'
		.alt.b4  'MapMoveRightClicked'
		.b4  'AutonoteTab4Clicked'
		.alt.b4  'MapMoveLeftClicked'
		.b4  'AutonoteTab3Clicked'
		.alt.b4  'MapMoveDownClicked'
		.b4  'AutonoteTab2Clicked'
		.alt.b4  'MapMoveUpClicked'
		.b4  'AutonoteTab1Clicked'
		.b4  'ScrollDownClicked'
		.b4  'ScrollUpClicked'
		.i4  'SpellBookSelection'
		 .Info 'Selected spell index within current page (1..11)'
		.b1  'SpellBookSelectedNewSpell'
		.skip(3 + 5*4)
		.i4  'AutonotesCategory'
		[mm78(0x4E29F8, 0x4F3900)].array(5).prot.i4  'ArmorSkills'
		.array(9).prot.i4  'WeaponSkills'
		.array(12).prot.i4  'MiscSkills'
		.array(mm78(9, 12)).prot.i4  'MagicSkills'
	else
		define
		[internal.DialogIndexListPtr or 0].parray{2000, lenA = i4, lenP = 0x4CB1E0}.i4  'List'
		[0x4CAEB8].i4  'ScrollPage'
		[0x4CB1D8].i4  'CountOnScreen'
		[0x4CB1E0].i4  'ListCount'
		[0x4CAEC8].i4  'ScrollPos'
		[0x4CB11C].b4  'AutonoteTab5Clicked'
		[0x4CB1F4].alt.i4  'MapMoveRightClicked'
		.b4  'AutonoteTab4Clicked'
		[0x4CB1A8].alt.i4  'MapMoveLeftClicked'
		.b4  'AutonoteTab3Clicked'
		[0x4CAEC0].alt.i4  'MapMoveDownClicked'
		.b4  'AutonoteTab2Clicked'
		[0x4CB1B0].alt.i4  'MapMoveUpClicked'
		.b4  'AutonoteTab1Clicked'
		[0x4CB1F0].b4  'ScrollDownClicked'
		[0x4CB128].b4  'ScrollUpClicked'
		[0x4CB214].i4  'SpellBookSelection'
		[0x4CB1FC].i4  'AutonotesCategory'
	end
	define
	[mmv(0x4CB3B8, 0x506400, 0x517B50)].struct(structs.MapMonster)  'MonsterInfoMonster'
end

function structs.f.MoveToMap(define)
	define
	.alt.array(3).i4  'Pos'
	.i4  'X'
	.i4  'Y'
	.i4  'Z'
	.i4  'Direction'
	 .Info "0 - 2047. 0 is East."
	.i4  'LookAngle'
	.i4  'SpeedZ'
	.b4  'Defined'
	function define.m.Set(a, x, y, z, direction, lookAngle, speedZ)
		a.Defined = true
		a.X = x == 0 and 1 or x
		a.Y = y == 0 and 1 or y
		a.Z = z == 0 and 1 or z
		a.Direction = direction == 0 and 1 or direction
		a.LookAngle = lookAngle == 0 and 1 or lookAngle
		a.SpeedZ = speedZ or 0
	end
end
