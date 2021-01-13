local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

mem.ExtendGameStructure{'HouseMovies', Size = 0x10,
	Refs = mmv(
		{0x43A12F, 0x43A1E4, 0x43A28B, 0x43C1C5, 0x43C583, 0x43C5C0, 0x43C664, 0x43C70D, 0x49635F, 0x49644F, 0x4964B1, 0x496534, 0x499F3B, 0x499F9F, 0x49A0C9, 0x49A178, 0x49BAF1, 0x49C6E3, 0x49C732, 0x49D7C3, 0x49D8F4, 0x49DF9B, 0x49E12E, 0x49E5EC, 0x49E76A, 0x49F34E, 0x49F416, 0x49F4A4, 0x49F68A, 0x49F7EC, 0x49F905, 0x49F95B, 0x4A4E8E, 0x4A5032, 0x4A51EB, 0x4A5317, 0x4A5640},
		{0x4449AD, 0x444A26, 0x44611A, 0x446410, 0x446456, 0x44656B, 0x446AD8, 0x4B1E07},
		{0x4BBE00, 0x4BBE06}
	),
	CountRefs = mmv({}, {}, {0x4BBDF6}),
}

local HouseMoviesStd = DataTables.HouseMovies

function DataTables.HouseMovies(str)
	if str then
		local n = DataTables.ComputeRowCountInPChar(mem.topointer(str), 2) - 1
		Game.HouseMovies.Resize(n, true)  -- shrink when needed
	end
	return HouseMoviesStd(str)
end
