local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local OldCount, NewCount = Game.HouseMovies.Count, nil

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

local function DoIt(str)
	NewCount = DataTables.ComputeRowCountInPChar(mem.topointer(str), 2) - 1

	if mmver == 8 then
		mem.IgnoreProtection(true)
		i4[0x4BBDF6] = NewCount
		mem.IgnoreProtection(false)
	end
	
	if NewCount <= OldCount then
		return
	end
	
	-- extend the array
	local ptr

	mem.IgnoreProtection(true)
	if mmver == 6 then
		ptr = Extend(0x4BE888, 0x10,
			{0x43A12F, 0x43A1E4, 0x43A28B, 0x43C1C5, 0x43C583, 0x43C5C0, 0x43C664, 0x43C70D, 0x49635F, 0x49644F, 0x4964B1, 0x496534, 0x499F3B, 0x499F9F, 0x49A0C9, 0x49A178, 0x49BAF1, 0x49C6E3, 0x49C732, 0x49D7C3, 0x49D8F4, 0x49DF9B, 0x49E12E, 0x49E5EC, 0x49E76A, 0x49F34E, 0x49F416, 0x49F4A4, 0x49F68A, 0x49F7EC, 0x49F905, 0x49F95B, 0x4A4E8E, 0x4A5032, 0x4A51EB, 0x4A5317, 0x4A5640}
		)
	elseif mmver == 7 then
		ptr = Extend(0x4E5F40, 0x10,
			{0x4449AD, 0x444A26, 0x44611A, 0x446410, 0x446456, 0x44656B, 0x446AD8, 0x4B1E07}
		)
	else
		ptr = Extend(0x4F66D8, 0x10,
			{0x4BBE00, 0x4BBE06}
		)
	end
	mem.IgnoreProtection(false)

	OldCount = NewCount
	
	ChangeGameArray("HouseMovies", ptr)
end


local HouseMoviesStd = DataTables.HouseMovies

function DataTables.HouseMovies(str)
	if str then
		DoIt(str)
	end
	return HouseMoviesStd(str)
end