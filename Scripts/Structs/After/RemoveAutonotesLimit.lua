local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local mmv = |...| (select(mmver - 5, ...))
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil

mem.ExtendGameStructure{'AutonoteTxt', is78 and 'AutonoteCategory', Size = mmv(4, 8, 8),
	Refs = mmv(
		{0x40D7A7, 0x40E705, 0x40E855, 0x4684BB;  0x46852F},
		{0x412656, 0x412665, 0x4137DC, 0x4137F1, 0x41392B, 0x44ACE1, 0x44ACFC, 0x44B6A6, 0x44B6C4, 0x476797;  0x47689D},
		{0x412E6A, 0x412E79, 0x448284, 0x4482AA, 0x448BB2, 0x448BD5, 0x47587D, 0x4CCA42, 0x4CCA53, 0x4CCA74, 0x4CCC95, 0x4CCD5D, 0x4CCD6C;  0x475982}
	),
}

if mmver == 7 then
	internal.SetArrayUpval(Party.AutonotesBits, 'count', 255)
	Game.AutonoteTxt.SetHigh(255)
	mem.BatchAdd({0x41264C-4, 0x41382B-4}, 255 - 195)
	mem.BatchAdd({0x47689D}, (255 - 195)*8)
end
