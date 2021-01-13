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

mem.ExtendGameStructure{'PlaceMonTxt', Size = 4,
	Refs = mm78({0x41EA15, 0x421340, 0x454FAE-4}, {0x420769, 0x456E7A, 0x452795-4}),
	CountRefs = mm78({0x455045-4, 0x454FC3-4}, {0x45282F-4, 0x4527AA-4}),
	Fill = 0,
}

mem.autohook(mm78(0x454FA2, 0x452789), function(d)
	local n = DataTables.ComputeRowCountInPChar(d.eax, 2, 2)
	Game.PlaceMonTxt.Resize(n, true)  -- shrink when needed
end)
