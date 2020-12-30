local mmver = Game.Version

local function StructInfo(a)
	local fields = (getmetatable(a) or {}).members
	local kind = fields and structs.name(a)
	if not kind and debug.upvalues(getmetatable(a).__newindex).SetLen then
		return
	elseif not kind then
		fields = {}
		local ok = pcall(|| for i in a do
			fields[i] = true
		end)
		if not ok and a.Male ~= nil and a.Female ~= nil then  -- MapMonster.Prefers is the only union of interest
			return const.MonsterPref
		elseif not ok then
			return
		end
	end
	return fields, kind
end

local function CleanupStruct(a, t)
	for k in pairs(StructInfo(a) or {}) do
		if type(t[k]) == 'table' then
			CleanupStruct(a[k], t[k])
		elseif a[k] == t[k] then
			t[k] = nil
		end
	end
end

local SkipFields = {
	MapSprite = {Bits = true, DecName = true},
	MapMonster = {Bits = true, PrefClass = true},
	MapRoom = {},
}
local PostRead = {
	MapMonster = |a, t| do
		Map.Monsters.Count = 0
		local b = SummonMonster(t.Id, 0, 0, 0, true)
		b.GuardRadius = 0
		CleanupStruct(b, t)
		t.Id = b.Id
		if mmver == 6 or (t.NPC_ID or 0) < 0 or (t.NPC_ID or 0) >= 5000 then
			t.NPC_ID = nil
		end
	end,
	MapFacet = |a, t| if mmver == 6 and t.Untouchable and not t.Invisible and (t.NormalZ or 0) ~= 0 then
		t.UntouchableMM6 = true
		t.Untouchable = nil
	end,
	FacetData = |a, t| t.Id = mmver ~= 6 and t.Id or t.FacetIndex,
	MapLight = |a, t, idx| t.Id = t.Id or idx,
}
local PreWrite = {
	MapMonster = |a, t| do
		Map.Monsters.Count = 0
		local b = SummonMonster(t.Id, 0, 0, 0, true)
		b.GuardRadius = 0
		mem.copy(a['?ptr'], b['?ptr'], a['?size'])
	end,
	MapLight = |a, t| if mmver ~= 6 then
		a.Type = 5
		a.Brightness = 31
	end,
}
local PostWrite = {
	MapObject = |a, t| do
		-- a.Type = Game.ItemsTxt[a.Item.Number].SpriteIndex
		a.TypeIndex = Game.ObjListBin.Find(a.Type)
	end,
	MapFacet = |a, t| do
		a.NormalFX = t.NormalFX or a.NormalX/0x10000
		a.NormalFY = t.NormalFY or a.NormalY/0x10000
		a.NormalFZ = t.NormalFZ or a.NormalZ/0x10000
		a.NormalFDistance = t.NormalFDistance or a.NormalDistance/0x10000
		if mmver == 6 then
			a.Untouchable = t.Untouchable or t.UntouchableMM6
		end
		t.Bits = a.Bits  -- for dlv
	end,
	MapSprite = |a, t| t.Bits = a.Bits,  -- for dlv
}

local invoke = |f, ...| if f then
	f(...)
end

local function IsResizeable(t)
	local f = getmetatable(t).__newindex
	if f then
		local i, v = debug.findupvalue(f, 'SetLen')
		return v ~= nil
	end
end

local function CopyStruct(a, t, name, read)
	local fields, kind = StructInfo(a)
	-- print('fields:', fields)
	if not fields then
		return true
	end
	t = tget(t, name)
	
	local skip = SkipFields[kind] or {Bits = true}
	invoke(not read and PreWrite[kind], a, t, name)
	for k in pairs(fields) do
		if k == '' or skip[k] then
			-- skip
		elseif type(a[k]) == 'table' then
			-- if kind == 'MapChest' then
			-- 	print(debug.upvalues(getmetatable(a[k]).__newindex).SetLen)
			-- end
			if CopyStruct(a[k], t, k, read) and IsResizeable(a[k]) then
				if read then
					t['#'..k] = a[k].count
				elseif t['#'..k] then
					a[k].count = t['#'..k]
				end
			end
		elseif read then
			t[k] = a[k]
		else
			a[k] = t[k]
		end
	end
	invoke((read and PostRead or PostWrite)[kind], a, t, name)
end

local function ReadWrite(state, fname, read)
	local blv = io.open(fname, read and 'rb' or 'wb')
	local dlv = io.open(path.setext(fname, '.dlv'), read and 'rb' or 'wb')
	local buf = mem.malloc(10000)
	local target, file = state, blv
	
	local function Each(t, f, hdrName)
		local off = file:seek()
		for i = 0, #t do
			target = t[i]
			if target then
				f(target)
			end
		end
		target = state
		if hdrName then
			state.Header[hdrName] = file:seek() - off
		end
	end
	
	local function zero(n)
		if read then
			file:seek(nil, n)
		else
			file:write(string.rep('\000', n))
		end
	end

	local function str(name, n)
		if read then
			target[name] = file:read(n):match'[^%z]*'
		else
			local s = target[name]:sub(1, n - 1)
			file:write(s..string.rep('\0', n - #s))
		end
	end
	
	local function num(name, n)
		if read then
			local s = file:read(n or 4)
			local v = 0
			for i = #s, 1, -1 do
				v = v*256 + s:byte(i)
			end
			local v1 = 256^(n or 4)
			target[name] = (v*2 < v1 and v or v - v1)
		else
			local v, data = target[name] or 0, {}
			for i = 1, n or 4 do
				data[#data + 1] = string.char(v % 256)
				v = v:div(256)
			end
			file:write(table.concat(data))
		end
	end
	
	local function stru(name, kind)
		local a = structs[kind]:new(buf)
		-- print(name, kind, 'off', file:seek(), 'size', a['?size'])
		if read then
			local s = file:read(a['?size'])
			mem.copy(buf, s)
		else
			mem.fill(buf, a['?size'])
		end
		CopyStruct(a, target, name, read)
		if not read then
			file:write(mem.string(buf, a['?size'], true))
		end
	end
	
	local function narr(f, name, n, ...)
		-- print('off', file:seek(), 'name', name, 'count', n)
		local old = target
		target = tget(target, name)
		for i = 0, n - 1 do
			f(i, ...)
		end
		target = old
	end
	local function arr(f, name, ...)
		num('#'..name)
		-- print('vcount', target['#'..name], 'newoff', file:seek())
		narr(f, name, target['#'..name], ...)
	end
	local function marr(add, f, name, ...)
		narr(f, name, target['#'..name] + add, ...)
	end
	
	local astru = |...| arr(stru, ...)
	local nstru = |...| narr(stru, ...)
	local nnum = |...| narr(num, ...)
	local mnum = |...| marr(0, num, ...)
	local mnum1 = |...| marr(1, num, ...)
	
	-- Blv
	stru('Header', 'BlvHeader')
	astru('Vertexes', 'MapVertex')
	
	astru('Facets', 'MapFacet')
	Each(state.Facets, |a| do
		mnum1('VertexIds', 2)
		mnum1('XInterceptDisplacement', 2)
		mnum1('YInterceptDisplacement', 2)
		mnum1('ZInterceptDisplacement', 2)
		mnum1('UList', 2)
		mnum1('VList', 2)
	end, 'FacetDataSize')
	-- error'Hello!'
	Each(state.Facets, || str('Bitmap', 10))
	
	astru('FacetData', 'FacetData')
	Each(state.FacetData, |a| zero(10))
	astru('Rooms', 'MapRoom')
	Each(state.Rooms, || do
		mnum('Floors', 2)
		mnum('Walls', 2)
		mnum('Ceils', 2)
		mnum('Fluids', 2)
		mnum('Portals', 2)
		mnum('DrawFacets', 2)
		mnum('Cogs', 2)
		mnum('Sprites', 2)
		mnum('Markers', 2)
	end, 'RoomDataSize')
	Each(state.Rooms, || mnum('Lights', 2), 'RoomLightDataSize')

	num('DoorsCount')
	astru('Sprites', 'MapSprite')
	Each(state.Sprites, || str('DecName', 32))
	astru('Lights', 'MapLight')
	astru('BSPNodes', 'BSPNode')
	astru('Spawns', 'SpawnPoint')
	astru('Outlines', 'MapOutline')
	
	-- Dlv
	file = dlv
	zero(mmver > 6 and 40 or 8)  -- header
	zero(875)  -- visible outlines
	if mmver > 6 then
		Each(state.Facets, || num('Bits'))
		Each(state.Sprites, || num('Bits', 2))
	end
	astru('Monsters', 'MapMonster')
	astru('Objects', 'MapObject')
	astru('Chests', 'MapChest')
	
	nstru('Doors', 200, 'MapDoor')
	Each(state.Doors, |a| do
		mnum('VertexIds', 2)
		mnum('FacetIds', 2)
		mnum('RoomIds', 2)
		mnum('FacetStartU', 2)
		mnum('FacetStartV', 2)
		mnum('VertexStartX', 2)
		mnum('VertexStartY', 2)
		mnum('VertexStartZ', 2)
	end, 'DoorDataSize')
	
	zero(200)  -- Map.Vars
	zero(56)  -- other map props
	if mmver == 8 then
		zero(30604)  -- notes
	end
	
	-- Blv
	file = blv
	file:seek'set'
	stru('Header', 'BlvHeader')
	
	mem.free(buf)
	blv:close()
	dlv:close()
end

function ReadRawBlv(fname, save)
	local state = {}
	ReadWrite(state, fname, true)
	if save then
		io.save(save, internal.persist(state))
	end
	return state
end

function WriteRawBlv(fname, state)
	ReadWrite(state, fname, false)
end
