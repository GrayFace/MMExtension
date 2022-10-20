local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

if mmver ~= 7 then
	return  -- only for MM7 for now
end

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local BaseCount = Game.NPCProfNames.limit
local BasePtr = Game.NPCProfNames['?ptr']

local function unbind(n, old)
	-- make sure they don't reference Global.txt
	local gl = {[0] = 153, 308, 309, 7, 306, 310, 311, 312, 313, 314, 105, 315, 316, 317, 115, 318, 319, 320, 321, 322, 323, 293, 324, 498, 525, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 596, 345, 346, 347, 348, 349, 350, 597, 352, 353, 598, 344, 26, 599, 21, 600, 370}
	local names = Game.NPCProfNames
	local p1, p2 = names['?ptr'], Game.GlobalTxt['?ptr']
	for i = 0, min(n, old) - 1 do
		if gl[i] and u4[p1 + i*4] == u4[p2 + gl[i]*4] then
			local s = names[i]
			u4[p1 + i*4] = 0
			names[i] = s
		end
	end
end

mem.ExtendGameStructure{'NPCProfNames', Size = 4,
	Refs = {0x416C79, 0x41E9DD, 0x445488, 0x4B2B10},
	Fill = 0,
	Custom = {
		|...| unbind = unbind and unbind(...)
	}
}

mem.ExtendGameStructure{'NPCProfTxt', Size = mmv(0x4C, 0x14),
	Refs = {0x416B8F, 0x416BA3, 0x420CAB, 0x44536E, 0x44551D, 0x445526, 0x445548, 0x4455A7, 0x4455B0, 0x49597F, 0x4B1FE5, 0x4B228F, 0x4B2298, 0x4B22ED, 0x4B2367, 0x4B3DDC, 0x4B4104, 0x4BC680, 0x477189-4},
	CountRefs = {0x477196-4, 0x477265-4},
	Fill = 0,
}

mem.autohook(mmv(nil, 0x477167), function(d)
	local n = DataTables.ComputeRowCountInPChar(d.eax, 3, mmv(4, 3)) - 3
	if n == BaseCount and BasePtr == Game.NPCProfNames['?ptr'] then
		return
	end
	Game.NPCProfNames.Resize(n, true)  -- shrink when needed
	Game.NPCProfTxt.Resize(n, true)
	
	-- load names from NPCProf.txt
	local t = mem.string(d.eax):split('\r\n', true)
	for i = 1, n - 1 do
		Game.NPCProfNames[i] = t[i + 4]:match('\t([^\t]*)')
	end
end)
