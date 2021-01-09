local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Drink from Well.",
	[3] = "+2 Might permanent",
	[4] = "Look Out!",
	[5] = "Drink from Fountain",
	[6] = "+25 Hit points restored.",
	[7] = "Drink from Trough.",
	[8] = "Hic…",
	[9] = "Refreshing!",
	[10] = "Port Sleigon",
	[11] = "Shrine of Endurance",
	[12] = "You pray at the shrine.",
	[13] = "+25 Endurance permanent",
	[14] = "+5 Endurance permanent",
	[15] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            mnfts_t_srrnoohtl",
	[16] = "Obelisk",
	[17] = "Port Sleigon",
	[18] = "Glastonbury Tor",
	[19] = "Temple of Carmen",
	[20] = "Bog of Tuonela",
	[21] = "Guild of Aqua",
	[22] = "Armory",
	[23] = "Temple",
	[24] = "Cumbria",
	[25] = "Jorgsborg",
	[26] = "Temple of Tranquility",
	[27] = "Cheroburg",
	[28] = "Guild of Mentis",
	[29] = "Due to troubles in the North, services are temporarily suspended.",
	[30] = "You hand the Sacred Chalice to the monks of the temple who ensconce it in the main altar.",
	[31] = "The tomb is locked.",
	[32] = "You must be Master Skill Level may use this Guild.",
	[33] = "Sir Zeddicus Z'ul V is in council and cannot be disturbed.",
	[34] = "You cannot enter at this time.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[10]  -- "Port Sleigon"
-- ERROR: Duplicate label: 19:10
-- ERROR: Duplicate label: 19:11
-- ERROR: Duplicate label: 49:10
-- ERROR: evt.house[150] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[152] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[153] not assigned for hint, because Hint command is missing

evt.house[2] = 7  -- "The Sharpening Stone"
evt.map[2] = function()
	evt.EnterHouse(7)         -- "The Sharpening Stone"
end

evt.house[3] = 7  -- "The Sharpening Stone"
evt.map[3] = function()
end

evt.house[4] = 8  -- "Feathers and String"
evt.map[4] = function()
	evt.EnterHouse(8)         -- "Feathers and String"
end

evt.house[5] = 8  -- "Feathers and String"
evt.map[5] = function()
end

evt.house[6] = 20  -- "The Foundry"
evt.map[6] = function()
	evt.EnterHouse(20)         -- "The Foundry"
end

evt.house[7] = 20  -- "The Foundry"
evt.map[7] = function()
end

evt.house[8] = 25  -- "The Footman's Friend"
evt.map[8] = function()
	evt.EnterHouse(25)         -- "The Footman's Friend"
end

evt.house[9] = 25  -- "The Footman's Friend"
evt.map[9] = function()
end

evt.house[10] = 39  -- "Alchemy and Incantations"
evt.map[10] = function()
	evt.EnterHouse(39)         -- "Alchemy and Incantations"
end

evt.house[11] = 39  -- "Alchemy and Incantations"
evt.map[11] = function()
end

evt.house[12] = 45  -- "Abdul's Discount Goods"
evt.map[12] = function()
	evt.EnterHouse(45)         -- "Abdul's Discount Goods"
end

evt.house[13] = 45  -- "Abdul's Discount Goods"
evt.map[13] = function()
end

evt.house[14] = 50  -- "Port Sleigon Travel East"
evt.map[14] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(50)         -- "Port Sleigon Travel East"
	else
		evt.StatusText(29)         -- "Due to troubles in the North, services are temporarily suspended."
	end
end

evt.house[15] = 50  -- "Port Sleigon Travel East"
evt.map[15] = function()
end

evt.house[16] = 51  -- "Port Sleigon Travel West"
evt.map[16] = function()
	evt.EnterHouse(51)         -- "Port Sleigon Travel West"
end

evt.house[17] = 51  -- "Port Sleigon Travel West"
evt.map[17] = function()
end

evt.house[18] = 62  -- "Windrunner"
evt.map[18] = function()
	evt.EnterHouse(62)         -- "Windrunner"
end

evt.house[19] = 70  -- "Sleigon Temple"
evt.map[19] = function()
	evt.EnterHouse(70)         -- "Sleigon Temple"
end

evt.house[20] = 80  -- "The Academy"
evt.map[20] = function()
	evt.EnterHouse(80)         -- "The Academy"
end

evt.house[21] = 80  -- "The Academy"
evt.map[21] = function()
end

evt.house[22] = 105  -- "The Echoing Whisper"
evt.map[22] = function()
	evt.EnterHouse(105)         -- "The Echoing Whisper"
end

evt.house[23] = 105  -- "The Echoing Whisper"
evt.map[23] = function()
end

evt.house[24] = 104  -- "Viktor's Hall"
evt.map[24] = function()
	evt.EnterHouse(104)         -- "Viktor's Hall"
end

evt.house[25] = 104  -- "Viktor's Hall"
evt.map[25] = function()
end

evt.house[26] = 106  -- "Rockham's Pride"
evt.map[26] = function()
	evt.EnterHouse(106)         -- "Rockham's Pride"
end

evt.house[27] = 106  -- "Rockham's Pride"
evt.map[27] = function()
end

evt.house[28] = 116  -- "Foreign Exchange"
evt.map[28] = function()
	evt.EnterHouse(116)         -- "Foreign Exchange"
end

evt.house[29] = 116  -- "Foreign Exchange"
evt.map[29] = function()
end

evt.house[30] = 120  -- "Adept Guild of Ignis"
evt.map[30] = function()
	if evt.Cmp("FireSkill", 88) then
		evt.EnterHouse(120)         -- "Adept Guild of Ignis"
	else
		evt.StatusText(32)         -- "You must be Master Skill Level may use this Guild."
	end
end

evt.house[31] = 120  -- "Adept Guild of Ignis"
evt.map[31] = function()
end

evt.house[32] = 122  -- "Adept Guild of Aeros"
evt.map[32] = function()
	if evt.Cmp("AirSkill", 132) then
		evt.EnterHouse(122)         -- "Adept Guild of Aeros"
	else
		evt.StatusText(32)         -- "You must be Master Skill Level may use this Guild."
	end
end

evt.house[33] = 122  -- "Adept Guild of Aeros"
evt.map[33] = function()
end

evt.house[34] = 124  -- "Adept Guild of Aqua Magics"
evt.map[34] = function()
	if evt.Cmp("WaterSkill", 136) then
		evt.EnterHouse(124)         -- "Adept Guild of Aqua Magics"
	else
		evt.StatusText(32)         -- "You must be Master Skill Level may use this Guild."
	end
end

evt.house[35] = 124  -- "Adept Guild of Aqua Magics"
evt.map[35] = function()
end

evt.house[36] = 126  -- "Adept Guild of Terra Magics"
evt.map[36] = function()
	if evt.Cmp("EarthSkill", 136) then
		evt.EnterHouse(126)         -- "Adept Guild of Terra Magics"
	else
		evt.StatusText(32)         -- "You must be Master Skill Level may use this Guild."
	end
end

evt.house[37] = 126  -- "Adept Guild of Terra Magics"
evt.map[37] = function()
end

evt.house[38] = 128  -- "Adept Guild of Animus"
evt.map[38] = function()
	evt.EnterHouse(128)         -- "Adept Guild of Animus"
end

evt.house[39] = 128  -- "Adept Guild of Animus"
evt.map[39] = function()
end

evt.house[40] = 130  -- "Adept Guild of the Mentis"
evt.map[40] = function()
	evt.EnterHouse(130)         -- "Adept Guild of the Mentis"
end

evt.house[41] = 130  -- "Adept Guild of the Mentis"
evt.map[41] = function()
end

evt.house[42] = 132  -- "Adept Guild of Corpus"
evt.map[42] = function()
	evt.EnterHouse(132)         -- "Adept Guild of Corpus"
end

evt.house[43] = 132  -- "Adept Guild of Corpus"
evt.map[43] = function()
end

evt.house[44] = 144  -- "Duelists' Edge"
evt.map[44] = function()
	evt.EnterHouse(144)         -- "Duelists' Edge"
end

evt.house[45] = 144  -- "Duelists' Edge"
evt.map[45] = function()
end

evt.house[46] = 151  -- "Smugglers' Guild"
evt.map[46] = function()
	evt.EnterHouse(151)         -- "Smugglers' Guild"
end

evt.house[47] = 151  -- "Smugglers' Guild"
evt.map[47] = function()
end

evt.house[48] = 157  -- "Z'ul Keep"
evt.map[48] = function()
	evt.EnterHouse(157)         -- "Z'ul Keep"
end

evt.house[49] = 158  -- "Z'ul Keep"
evt.map[49] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(158)         -- "Z'ul Keep"
	else
		evt.StatusText(33)         -- "Sir Zeddicus Z'ul V is in council and cannot be disturbed."
	end
end

evt.house[50] = 165  -- "High Council"
evt.map[50] = function()
end

evt.house[52] = 68  -- "Enterprise"
evt.map[52] = function()
	evt.EnterHouse(68)         -- "Enterprise"
end

evt.house[53] = 78  -- "Temple Carmen"
evt.map[53] = function()
	evt.EnterHouse(78)         -- "Temple Carmen"
end

evt.house[54] = 37  -- "The Sorcerer's Shoppe"
evt.map[54] = function()
	evt.EnterHouse(37)         -- "The Sorcerer's Shoppe"
end

evt.house[55] = 37  -- "The Sorcerer's Shoppe"
evt.map[55] = function()
end

evt.house[56] = 283  -- "House"
evt.map[56] = function()
	evt.EnterHouse(283)         -- "House"
end

evt.house[57] = 284  -- "House"
evt.map[57] = function()
	evt.EnterHouse(284)         -- "House"
end

evt.house[58] = 285  -- "House"
evt.map[58] = function()
	evt.EnterHouse(285)         -- "House"
end

evt.house[59] = 286  -- "House"
evt.map[59] = function()
	evt.EnterHouse(286)         -- "House"
end

evt.house[60] = 287  -- "House"
evt.map[60] = function()
	evt.EnterHouse(287)         -- "House"
end

evt.house[61] = 288  -- "House"
evt.map[61] = function()
	evt.EnterHouse(288)         -- "House"
end

evt.house[62] = 289  -- "House"
evt.map[62] = function()
	evt.EnterHouse(289)         -- "House"
end

evt.house[63] = 290  -- "House"
evt.map[63] = function()
	evt.EnterHouse(290)         -- "House"
end

evt.house[64] = 291  -- "House"
evt.map[64] = function()
	evt.EnterHouse(291)         -- "House"
end

evt.house[65] = 292  -- "House"
evt.map[65] = function()
	evt.EnterHouse(292)         -- "House"
end

evt.house[66] = 293  -- "House"
evt.map[66] = function()
	evt.EnterHouse(293)         -- "House"
end

evt.house[67] = 294  -- "House"
evt.map[67] = function()
	evt.EnterHouse(294)         -- "House"
end

evt.house[68] = 295  -- "O'Farrell Residence"
evt.map[68] = function()
	evt.EnterHouse(295)         -- "O'Farrell Residence"
end

evt.house[69] = 296  -- "House"
evt.map[69] = function()
	evt.EnterHouse(296)         -- "House"
end

evt.house[70] = 297  -- "Tierney Quinn's Place"
evt.map[70] = function()
	evt.EnterHouse(297)         -- "Tierney Quinn's Place"
end

evt.house[71] = 298  -- "House"
evt.map[71] = function()
	evt.EnterHouse(298)         -- "House"
end

evt.house[72] = 299  -- "House"
evt.map[72] = function()
	evt.EnterHouse(299)         -- "House"
end

evt.house[73] = 300  -- "House"
evt.map[73] = function()
	evt.EnterHouse(300)         -- "House"
end

evt.house[74] = 301  -- "Mallt's House"
evt.map[74] = function()
	evt.EnterHouse(301)         -- "Mallt's House"
end

evt.house[75] = 302  -- "House"
evt.map[75] = function()
	evt.EnterHouse(302)         -- "House"
end

evt.house[76] = 303  -- "House"
evt.map[76] = function()
	evt.EnterHouse(303)         -- "House"
end

evt.house[77] = 304  -- "House"
evt.map[77] = function()
	evt.EnterHouse(304)         -- "House"
end

evt.house[78] = 305  -- "House"
evt.map[78] = function()
	evt.EnterHouse(305)         -- "House"
end

evt.house[79] = 306  -- "House"
evt.map[79] = function()
	evt.EnterHouse(306)         -- "House"
end

evt.house[80] = 307  -- "House"
evt.map[80] = function()
	evt.EnterHouse(307)         -- "House"
end

evt.house[81] = 308  -- "House"
evt.map[81] = function()
	evt.EnterHouse(308)         -- "House"
end

evt.house[82] = 309  -- "House"
evt.map[82] = function()
	evt.EnterHouse(309)         -- "House"
end

evt.house[83] = 310  -- "House"
evt.map[83] = function()
	evt.EnterHouse(310)         -- "House"
end

evt.house[84] = 311  -- "House"
evt.map[84] = function()
	evt.EnterHouse(311)         -- "House"
end

evt.house[85] = 312  -- "House"
evt.map[85] = function()
	evt.EnterHouse(312)         -- "House"
end

evt.house[86] = 313  -- "House"
evt.map[86] = function()
	evt.EnterHouse(313)         -- "House"
end

evt.house[87] = 314  -- "House"
evt.map[87] = function()
	evt.EnterHouse(314)         -- "House"
end

evt.house[88] = 315  -- "House"
evt.map[88] = function()
	evt.EnterHouse(315)         -- "House"
end

evt.house[89] = 316  -- "House"
evt.map[89] = function()
	evt.EnterHouse(316)         -- "House"
end

evt.house[90] = 317  -- "House"
evt.map[90] = function()
	evt.EnterHouse(317)         -- "House"
end

evt.house[91] = 318  -- "House"
evt.map[91] = function()
	evt.EnterHouse(318)         -- "House"
end

evt.house[92] = 319  -- "House"
evt.map[92] = function()
	evt.EnterHouse(319)         -- "House"
end

evt.house[93] = 320  -- "House"
evt.map[93] = function()
	evt.EnterHouse(320)         -- "House"
end

evt.house[94] = 321  -- "House"
evt.map[94] = function()
	evt.EnterHouse(321)         -- "House"
end

evt.house[95] = 322  -- "House"
evt.map[95] = function()
	evt.EnterHouse(322)         -- "House"
end

evt.house[96] = 323  -- "House"
evt.map[96] = function()
	evt.EnterHouse(323)         -- "House"
end

evt.house[97] = 324  -- "House"
evt.map[97] = function()
	evt.EnterHouse(324)         -- "House"
end

evt.house[98] = 325  -- "House"
evt.map[98] = function()
	evt.EnterHouse(325)         -- "House"
end

evt.house[99] = 326  -- "House"
evt.map[99] = function()
	evt.EnterHouse(326)         -- "House"
end

evt.house[100] = 327  -- "House"
evt.map[100] = function()
	evt.EnterHouse(327)         -- "House"
end

evt.house[101] = 328  -- "House"
evt.map[101] = function()
	evt.EnterHouse(328)         -- "House"
end

evt.house[102] = 329  -- "House"
evt.map[102] = function()
	evt.EnterHouse(329)         -- "House"
end

evt.house[103] = 330  -- "House"
evt.map[103] = function()
	evt.EnterHouse(330)         -- "House"
end

evt.house[104] = 331  -- "House"
evt.map[104] = function()
	evt.EnterHouse(331)         -- "House"
end

evt.house[105] = 332  -- "House"
evt.map[105] = function()
	evt.EnterHouse(332)         -- "House"
end

evt.house[106] = 333  -- "House"
evt.map[106] = function()
	evt.EnterHouse(333)         -- "House"
end

evt.house[107] = 519  -- "House"
evt.map[107] = function()
	evt.EnterHouse(519)         -- "House"
end

evt.house[108] = 520  -- "House"
evt.map[108] = function()
	evt.EnterHouse(520)         -- "House"
end

evt.house[109] = 521  -- "House"
evt.map[109] = function()
	evt.EnterHouse(521)         -- "House"
end

evt.house[110] = 522  -- "House"
evt.map[110] = function()
	evt.EnterHouse(522)         -- "House"
end

evt.house[111] = 523  -- "House"
evt.map[111] = function()
	evt.EnterHouse(523)         -- "House"
end

evt.house[112] = 524  -- "House"
evt.map[112] = function()
	evt.EnterHouse(524)         -- "House"
end

evt.house[113] = 525  -- "House"
evt.map[113] = function()
	evt.EnterHouse(525)         -- "House"
end

evt.house[114] = 526  -- "House"
evt.map[114] = function()
	evt.EnterHouse(526)         -- "House"
end

evt.house[115] = 527  -- "House"
evt.map[115] = function()
	evt.EnterHouse(527)         -- "House"
end

evt.house[116] = 528  -- "House"
evt.map[116] = function()
	evt.EnterHouse(528)         -- "House"
end

evt.house[117] = 529  -- "House"
evt.map[117] = function()
	evt.EnterHouse(529)         -- "House"
end

evt.house[118] = 530  -- "House"
evt.map[118] = function()
	evt.EnterHouse(530)         -- "House"
end

evt.house[119] = 531  -- "House"
evt.map[119] = function()
	evt.EnterHouse(531)         -- "House"
end

evt.hint[122] = evt.str[17]  -- "Port Sleigon"
evt.map[122] = function()
	evt.StatusText(17)         -- "Port Sleigon"
end

evt.hint[123] = evt.str[18]  -- "Glastonbury Tor"
evt.map[123] = function()
	evt.StatusText(18)         -- "Glastonbury Tor"
end

evt.hint[124] = evt.str[19]  -- "Temple of Carmen"
evt.map[124] = function()
	evt.StatusText(19)         -- "Temple of Carmen"
end

evt.hint[125] = evt.str[17]  -- "Port Sleigon"
evt.map[125] = function()
	evt.StatusText(17)         -- "Port Sleigon"
end

evt.hint[126] = evt.str[20]  -- "Bog of Tuonela"
evt.map[126] = function()
	evt.StatusText(20)         -- "Bog of Tuonela"
end

evt.hint[127] = evt.str[18]  -- "Glastonbury Tor"
evt.map[127] = function()
	evt.StatusText(18)         -- "Glastonbury Tor"
end

evt.hint[128] = evt.str[21]  -- "Guild of Aqua"
evt.map[128] = function()
	evt.StatusText(21)         -- "Guild of Aqua"
end

evt.hint[129] = evt.str[22]  -- "Armory"
evt.map[129] = function()
	evt.StatusText(22)         -- "Armory"
end

evt.hint[130] = evt.str[23]  -- "Temple"
evt.map[130] = function()
	evt.StatusText(23)         -- "Temple"
end

evt.hint[131] = evt.str[17]  -- "Port Sleigon"
evt.map[131] = function()
	evt.StatusText(17)         -- "Port Sleigon"
end

evt.hint[132] = evt.str[24]  -- "Cumbria"
evt.map[132] = function()
	evt.StatusText(24)         -- "Cumbria"
end

evt.hint[133] = evt.str[27]  -- "Cheroburg"
evt.map[133] = function()
	evt.StatusText(27)         -- "Cheroburg"
end

evt.hint[134] = evt.str[24]  -- "Cumbria"
evt.map[134] = function()
	evt.StatusText(24)         -- "Cumbria"
end

evt.hint[135] = evt.str[28]  -- "Guild of Mentis"
evt.map[135] = function()
	evt.StatusText(28)         -- "Guild of Mentis"
end

evt.map[136] = function()
	evt.StatusText(0)         -- " "
end

evt.hint[137] = evt.str[17]  -- "Port Sleigon"
evt.map[137] = function()
	evt.StatusText(17)         -- "Port Sleigon"
end

evt.hint[138] = evt.str[25]  -- "Jorgsborg"
evt.map[138] = function()
	evt.StatusText(25)         -- "Jorgsborg"
end

evt.hint[139] = evt.str[26]  -- "Temple of Tranquility"
evt.map[139] = function()
	evt.StatusText(26)         -- "Temple of Tranquility"
end

evt.hint[120] = evt.str[1]  -- "Chest"
evt.map[120] = function()
	evt.OpenChest(1)
end

evt.hint[121] = evt.str[1]  -- "Chest"
evt.map[121] = function()
	evt.OpenChest(2)
end

evt.map[150] = function()
	evt.MoveToMap{X = -127, Y = 4190, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 180, Icon = 5, Name = "D12.Blv"}         -- "Dragoons' Keep"
end

evt.house[151] = 184  -- "Tomb of Luftka the Kruel"
evt.map[151] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 425) then         -- Luftka's Tomb once
		if not evt.Cmp("Inventory", 577) then         -- "Key to Luftka's Tomb"
			evt.StatusText(31)         -- "The tomb is locked."
			return
		end
	end
	evt.MoveToMap{X = -118, Y = -1640, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 184, Icon = 5, Name = "D14.Blv"}         -- "Tomb of Luftka the Kruel"
end

evt.map[152] = function()
	evt.MoveToMap{X = 0, Y = -2135, Z = 125, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 5, Name = "T5.Blv"}         -- "Temple of the Moon"
end

evt.map[153] = function()
	evt.StatusText(31)         -- "The tomb is locked."
end

evt.hint[161] = evt.str[2]  -- "Drink from Well."
evt.map[161] = function()
	if not evt.Cmp("BaseMight", 15) then
		if evt.Cmp("MapVar0", 1) then
			evt.Subtract("MapVar0", 1)
			evt.Add("BaseMight", 2)
			evt.StatusText(3)         -- "+2 Might permanent"
			evt.Set("AutonotesBits", 30)         -- "2 Points of permanent might from the fountain in the northeast of Port Sleigon."
			return
		end
	end
	evt.StatusText(9)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar0", 8)
end, const.Month, true)

evt.hint[162] = evt.str[2]  -- "Drink from Well."
evt.map[162] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(9)         -- "Refreshing!"
	else
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -13168, Y = 19504, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -13696, Y = 17408, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -10960, Y = 18016, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -9840, Y = 19280, Z = 160}
		evt.Set("MapVar4", 1)
		evt.StatusText(4)         -- "Look Out!"
	end
end

RefillTimer(function()
	evt.Set("MapVar4", 0)
end, const.Month, true)

evt.hint[163] = evt.str[5]  -- "Drink from Fountain"
evt.map[163] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.Subtract("MapVar1", 1)
		evt.Add("HP", 25)
		evt.StatusText(6)         -- "+25 Hit points restored."
	else
		evt.StatusText(9)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 31)         -- "25 Hit points restored from the central fountain in Port Sleigon."
end

Timer(function()
	evt.Set("MapVar1", 30)
end, const.Day, 1*const.Second)

evt.hint[164] = evt.str[7]  -- "Drink from Trough."
evt.map[164] = function()
	evt.Set("Drunk", 0)
	evt.StatusText(8)         -- "Hic…"
end

evt.map[209] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 159) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = 3823, FromY = 10974, FromZ = 2700, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[209].last, 5*const.Minute)

evt.map[210] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 159) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 159)         -- NPC
			evt.SetTextureOutdoors{Model = 116, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.house[211] = 179  -- "Glastonbury Tor"
evt.map[211] = function()
	evt.MoveToMap{X = -3714, Y = 1250, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 1, Name = "D09.Blv"}         -- "Glastonbury Tor"
end

evt.map[212] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 178) then         -- NPC
		evt.Set("QBits", 178)         -- NPC
	end
end

events.LoadMap = evt.map[212].last

evt.hint[213] = evt.str[16]  -- "Obelisk"
evt.map[213] = function()
	evt.SetMessage(15)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            mnfts_t_srrnoohtl"
	evt.SimpleMessage()
	evt.Set("QBits", 367)         -- NPC
	evt.Set("AutonotesBits", 86)         -- "Obelisk Message # 8:  mnfts_t_srrnoohtl"
end

evt.map[214] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 159) then         -- NPC
		evt.SetTextureOutdoors{Model = 116, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[214].last

evt.hint[261] = evt.str[11]  -- "Shrine of Endurance"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 3) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 211) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 5)
				evt.StatusText(14)         -- "+5 Endurance permanent"
			else
				evt.Set("QBits", 211)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 25)
				evt.StatusText(13)         -- "+25 Endurance permanent"
			end
			return
		end
	end
	evt.StatusText(12)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 421) then         -- Port Sleigon once
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.Add("QBits", 421)         -- Port Sleigon once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = 12510, Y = -22038, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = -22312, Y = 14554, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = 16639, Y = 21844, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 16033, Y = 21693, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 10472, Y = 22066, Z = 262}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 6, X = 3841, Y = 22180, Z = 257}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 3123, Y = 22012, Z = 170}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = 4679, Y = 21731, Z = 256}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 12630, Y = -20957, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 13228, Y = -20272, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -22024, Y = 14837, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -22281, Y = 14329, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 15626, Y = 21471, Z = 201}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 14498, Y = 21741, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 4679, Y = 21731, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = 6118, Y = 22029, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 7306, Y = 21402, Z = 225}
	end
end

events.LoadMap = evt.map[262].last

