local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

if mmver ~= 7 then
	return  -- only for MM7
end

mem.ExtendGameStructure{'AutonoteTxt', 'AutonoteCategory', Size = 8,
	Refs = {0x412656, 0x412665, 0x4137DC, 0x4137F1, 0x41392B, 0x44ACE1, 0x44ACFC, 0x44B6A6, 0x44B6C4, 0x476797},
	CountRefs = {0x41264C-4, 0x41382B-4},
	EndRefs = {0x47689D},
}
Game.AutonoteTxt.Resize(256)
