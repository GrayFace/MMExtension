local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local Extend = mem.ExtendGameStructure

-- for now only TrainingLevels and TransportIndex
Extend{'TrainingLevels', Size = 4,
	Refs = mmv({0x499DE9}, {0x4B4704, 0x4BCAB4}, {0x4B314B, 0x4B324A, 0x4BAAEC}),
}

Extend{'TransportIndex', Size = 4,
	Refs = mmv({0x49CDA8, 0x49D13E, 0x49D700, 0x49FBF3, 0x4A44EF}, {0x4B6855, 0x4B69B2, 0x4B6CD4, 0x4BCC2F}, {0x4B50CF, 0x4B518F, 0x4B5589, 0x4BAB6E}), 
	CountRefs = mmv({0x43C76B-4}, {0x4465D2}, {0x443492-4}),
}
