local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

if mmver == 6 then
	return
end

local function mm78(...)
	local ret = select(mmver - 6, ...)
	assert(ret ~= nil)
	return ret
end

local OldCount, NewCount = mm78(31, 131), nil

local function Process(t, d)
	for _, p in ipairs(t) do
		u4[p] = u4[p] + d
	end
end

local function Extend(p, size, t, tend, extraSize)
	local esize = tonumber(extraSize) or 0
	local new = mem.StaticAlloc(size*NewCount + esize)
	mem.copy(new, p, size*min(OldCount, NewCount) + esize)
	if extraSize == 'fill' then
		for i = OldCount, NewCount - 1 do
			mem.copy(new + i*size, p, size)
		end
	end
	Process(t, new - p)
	if tend then
		Process(tend, new - p + (NewCount - OldCount)*size)
	end
	return new
end

local function ChangeGameArray(name, p, count)
	structs.o.GameStructure[name] = p
	internal.SetArrayUpval(Game[name], "o", p)
	internal.SetArrayUpval(Game[name], "count", count or NewCount)
end

mem.autohook(mm78(0x454FA2, 0x452789), function(d)
	NewCount = DataTables.ComputeRowCountInPChar(d.eax, 2, 2)
	if NewCount == OldCount then
		return
	end
	
	-- set new read limit
	
	mem.IgnoreProtection(true)

	if mmver == 7 then
		Process({0x455045-4, 0x454FC3-4}, NewCount - OldCount)
	else
		Process({0x45282F-4, 0x4527AA-4}, NewCount - OldCount)
	end

	if NewCount <= OldCount then
		return mem.IgnoreProtection(false)
	end

	-- extend the array
	local ptr
	if mmver == 7 then
		ptr = Extend(0x5D27D8, 4, {0x41EA15, 0x421340, 0x454FAE-4}, nil, 'fill')
	else
		ptr = Extend(0x5EF9B0, 4, {0x420769, 0x456E7A, 0x452795-4}, nil, 'fill')
	end
	ChangeGameArray("PlaceMonTxt", ptr)
end)
