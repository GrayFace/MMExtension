local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local mmv = |...| (select(mmver - 5, ...))
local mm78 = |...| mmv(nil, ...)

-- extend Game.QuestsTxt

mem.ExtendGameStructure{'QuestsTxt', Size = 4, StartBefore = 4*Game.QuestsTxt.low,
	Refs = mmv(
		{0x40D3C9, 0x40E300, 0x46858B;  0x4685FF},
		{0x412805, 0x41333E, 0x44A8EC, 0x44B2B7, 0x4768F5;  0x47696E},
		{0x447EF2, 0x44884A, 0x4759DB, 0x4CC428, 0x4CC449, 0x4CCF0C;  0x475A53}
	),
}

-- extend Party.QBits? (mm8 - 4759D0)
