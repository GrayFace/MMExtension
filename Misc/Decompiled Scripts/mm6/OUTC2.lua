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
	[10] = "Free Haven",
	[11] = "Shrine of Accuracy",
	[12] = "You pray at the shrine.",
	[13] = "+10 Accuracy permanent",
	[14] = "+3 Accuracy permanent",
	[15] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            lg____gtS_cln;__",
	[16] = "Obelisk",
	[17] = "Free Haven",
	[18] = "Castle Temper",
	[19] = "Temple of Baa",
	[20] = "Darkmoor",
	[21] = "Guild of Water",
	[22] = "Armory",
	[23] = "Temple",
	[24] = "Rockham",
	[25] = "Whitecap",
	[26] = "Castle Stone",
	[27] = "Blackshire",
	[28] = "Guild of Mind",
	[29] = "The stone cutter and carpenter begin rebuilding the temple.",
	[30] = "You hand the Sacred Chalice to the monks of the temple who ensconce it in the main altar.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[10]  -- "Free Haven"

evt.HouseDoor(2, 7)  -- "The Sharpening Stone"
evt.house[3] = 7  -- "The Sharpening Stone"
evt.HouseDoor(4, 8)  -- "Feathers and String"
evt.house[5] = 8  -- "Feathers and String"
evt.HouseDoor(6, 20)  -- "The Foundry"
evt.house[7] = 20  -- "The Foundry"
evt.HouseDoor(8, 25)  -- "The Footman's Friend"
evt.house[9] = 25  -- "The Footman's Friend"
evt.HouseDoor(10, 39)  -- "Alchemy and Incantations"
evt.house[11] = 39  -- "Alchemy and Incantations"
evt.HouseDoor(12, 45)  -- "Abdul's Discount Goods"
evt.house[13] = 45  -- "Abdul's Discount Goods"
evt.HouseDoor(14, 50)  -- "Free Haven Travel East"
evt.house[15] = 50  -- "Free Haven Travel East"
evt.HouseDoor(16, 51)  -- "Free Haven Travel West"
evt.house[17] = 51  -- "Free Haven Travel West"
evt.HouseDoor(18, 62)  -- "Windrunner"
evt.house[19] = 551  -- "Free Haven Temple"
evt.map[19] = function()
	if evt.Cmp("QBits", 107) then         -- "Take the Sacred Chalice from the monks in their island temple east of Free Haven, return it to Temple Stone in Free Haven, and then return to Lord Stone at Castle Stone."
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 434) then         -- "Sacred Chalice"
			evt.Subtract("Inventory", 434)         -- "Sacred Chalice"
			evt.Subtract("QBits", 188)         -- Quest item bits for seer
			evt.Set("QBits", 108)         -- NPC
			evt.EnterHouse(70)         -- "Temple Stone"
			return
		end
		goto _14
	end
	if evt.Cmp("QBits", 106) then         -- NPC
		if evt.Cmp("QBits", 105) then         -- "Hire a Stonecutter and a Carpenter, bring them to Temple Stone in Free Haven to repair the Temple, and then return to Lord Anthony Stone at Castle Stone."
			goto _10
		end
		evt.SetMessage(30)         -- "You hand the Sacred Chalice to the monks of the temple who ensconce it in the main altar."
		goto _14
	end
	if evt.Cmp("HasNPCProfession", const.NPCProfession.StoneCutter) then
		if evt.Cmp("HasNPCProfession", const.NPCProfession.Carpenter) then
			evt.Set("QBits", 106)         -- NPC
			evt.Subtract("HasNPCProfession", const.NPCProfession.Carpenter)
			evt.Subtract("HasNPCProfession", const.NPCProfession.StoneCutter)
			evt.SetMessage(29)         -- "The stone cutter and carpenter begin rebuilding the temple."
		end
	end
::_10::
	evt.EnterHouse(551)         -- "Free Haven Temple"
	do return end
::_14::
	evt.EnterHouse(70)         -- "Temple Stone"
end

evt.HouseDoor(20, 80)  -- "Free Haven Academy"
evt.house[21] = 80  -- "Free Haven Academy"
evt.HouseDoor(22, 105)  -- "The Echoing Whisper"
evt.house[23] = 105  -- "The Echoing Whisper"
evt.HouseDoor(24, 104)  -- "Viktor's Hall"
evt.house[25] = 104  -- "Viktor's Hall"
evt.HouseDoor(26, 106)  -- "Rockham's Pride"
evt.house[27] = 106  -- "Rockham's Pride"
evt.HouseDoor(28, 116)  -- "Foreign Exchange"
evt.house[29] = 116  -- "Foreign Exchange"
evt.HouseDoor(30, 120)  -- "Adept Guild of Fire"
evt.house[31] = 120  -- "Adept Guild of Fire"
evt.HouseDoor(32, 122)  -- "Adept Guild of Air"
evt.house[33] = 122  -- "Adept Guild of Air"
evt.HouseDoor(34, 124)  -- "Adept Guild of Water"
evt.house[35] = 124  -- "Adept Guild of Water"
evt.HouseDoor(36, 126)  -- "Adept Guild of Earth"
evt.house[37] = 126  -- "Adept Guild of Earth"
evt.HouseDoor(38, 128)  -- "Adept Guild of Spirit"
evt.house[39] = 128  -- "Adept Guild of Spirit"
evt.HouseDoor(40, 130)  -- "Adept Guild of Mind"
evt.house[41] = 130  -- "Adept Guild of Mind"
evt.HouseDoor(42, 132)  -- "Adept Guild of Body"
evt.house[43] = 132  -- "Adept Guild of Body"
evt.HouseDoor(44, 144)  -- "Duelists' Edge"
evt.house[45] = 144  -- "Duelists' Edge"
evt.HouseDoor(46, 151)  -- "Smugglers' Guild"
evt.house[47] = 151  -- "Smugglers' Guild"
evt.HouseDoor(48, 157)  -- "Castle Temper"
evt.HouseDoor(49, 165)  -- "High Council"
evt.house[50] = 165  -- "High Council"
evt.HouseDoor(52, 68)  -- "Enterprise"
evt.HouseDoor(53, 78)  -- "Temple Baa"
evt.HouseDoor(54, 37)  -- "The Sorcerer's Shoppe"
evt.house[55] = 37  -- "The Sorcerer's Shoppe"
evt.HouseDoor(56, 283)  -- "House"
evt.HouseDoor(57, 284)  -- "House"
evt.HouseDoor(58, 285)  -- "House"
evt.HouseDoor(59, 286)  -- "House"
evt.HouseDoor(60, 287)  -- "House"
evt.HouseDoor(61, 288)  -- "House"
evt.HouseDoor(62, 289)  -- "House"
evt.HouseDoor(63, 290)  -- "House"
evt.HouseDoor(64, 291)  -- "House"
evt.HouseDoor(65, 292)  -- "House"
evt.HouseDoor(66, 293)  -- "House"
evt.HouseDoor(67, 294)  -- "House"
evt.HouseDoor(68, 295)  -- "House"
evt.HouseDoor(69, 296)  -- "House"
evt.HouseDoor(70, 297)  -- "House"
evt.HouseDoor(71, 298)  -- "House"
evt.HouseDoor(72, 299)  -- "House"
evt.HouseDoor(73, 300)  -- "House"
evt.HouseDoor(74, 301)  -- "House"
evt.HouseDoor(75, 302)  -- "House"
evt.HouseDoor(76, 303)  -- "House"
evt.HouseDoor(77, 304)  -- "House"
evt.HouseDoor(78, 305)  -- "House"
evt.HouseDoor(79, 306)  -- "House"
evt.HouseDoor(80, 307)  -- "House"
evt.HouseDoor(81, 308)  -- "House"
evt.HouseDoor(82, 309)  -- "House"
evt.HouseDoor(83, 310)  -- "House"
evt.HouseDoor(84, 311)  -- "House"
evt.HouseDoor(85, 312)  -- "House"
evt.HouseDoor(86, 313)  -- "House"
evt.HouseDoor(87, 314)  -- "House"
evt.HouseDoor(88, 315)  -- "House"
evt.HouseDoor(89, 316)  -- "House"
evt.HouseDoor(90, 317)  -- "House"
evt.HouseDoor(91, 318)  -- "House"
evt.HouseDoor(92, 319)  -- "House"
evt.HouseDoor(93, 320)  -- "House"
evt.HouseDoor(94, 321)  -- "House"
evt.HouseDoor(95, 322)  -- "House"
evt.HouseDoor(96, 323)  -- "House"
evt.HouseDoor(97, 324)  -- "House"
evt.HouseDoor(98, 325)  -- "House"
evt.HouseDoor(99, 326)  -- "House"
evt.HouseDoor(100, 327)  -- "House"
evt.HouseDoor(101, 328)  -- "House"
evt.HouseDoor(102, 329)  -- "House"
evt.HouseDoor(103, 330)  -- "House"
evt.HouseDoor(104, 331)  -- "House"
evt.HouseDoor(105, 332)  -- "House"
evt.HouseDoor(106, 333)  -- "House"
evt.HouseDoor(107, 519)  -- "House"
evt.HouseDoor(108, 520)  -- "House"
evt.HouseDoor(109, 521)  -- "House"
evt.HouseDoor(110, 522)  -- "House"
evt.HouseDoor(111, 523)  -- "House"
evt.HouseDoor(112, 524)  -- "House"
evt.HouseDoor(113, 525)  -- "House"
evt.HouseDoor(114, 526)  -- "House"
evt.HouseDoor(115, 527)  -- "House"
evt.HouseDoor(116, 528)  -- "House"
evt.HouseDoor(117, 529)  -- "House"
evt.HouseDoor(118, 530)  -- "House"
evt.HouseDoor(119, 531)  -- "House"
evt.hint[122] = evt.str[17]  -- "Free Haven"
evt.map[122] = function()
	evt.StatusText(17)         -- "Free Haven"
end

evt.hint[123] = evt.str[18]  -- "Castle Temper"
evt.map[123] = function()
	evt.StatusText(18)         -- "Castle Temper"
end

evt.hint[124] = evt.str[19]  -- "Temple of Baa"
evt.map[124] = function()
	evt.StatusText(19)         -- "Temple of Baa"
end

evt.hint[125] = evt.str[17]  -- "Free Haven"
evt.map[125] = function()
	evt.StatusText(17)         -- "Free Haven"
end

evt.hint[126] = evt.str[20]  -- "Darkmoor"
evt.map[126] = function()
	evt.StatusText(20)         -- "Darkmoor"
end

evt.hint[127] = evt.str[18]  -- "Castle Temper"
evt.map[127] = function()
	evt.StatusText(18)         -- "Castle Temper"
end

evt.hint[128] = evt.str[21]  -- "Guild of Water"
evt.map[128] = function()
	evt.StatusText(21)         -- "Guild of Water"
end

evt.hint[129] = evt.str[22]  -- "Armory"
evt.map[129] = function()
	evt.StatusText(22)         -- "Armory"
end

evt.hint[130] = evt.str[23]  -- "Temple"
evt.map[130] = function()
	evt.StatusText(23)         -- "Temple"
end

evt.hint[131] = evt.str[17]  -- "Free Haven"
evt.map[131] = function()
	evt.StatusText(17)         -- "Free Haven"
end

evt.hint[132] = evt.str[24]  -- "Rockham"
evt.map[132] = function()
	evt.StatusText(24)         -- "Rockham"
end

evt.hint[133] = evt.str[27]  -- "Blackshire"
evt.map[133] = function()
	evt.StatusText(27)         -- "Blackshire"
end

evt.hint[134] = evt.str[24]  -- "Rockham"
evt.map[134] = function()
	evt.StatusText(24)         -- "Rockham"
end

evt.hint[135] = evt.str[28]  -- "Guild of Mind"
evt.map[135] = function()
	evt.StatusText(28)         -- "Guild of Mind"
end

evt.map[136] = function()
	evt.StatusText(0)         -- " "
end

evt.hint[137] = evt.str[17]  -- "Free Haven"
evt.map[137] = function()
	evt.StatusText(17)         -- "Free Haven"
end

evt.hint[138] = evt.str[25]  -- "Whitecap"
evt.map[138] = function()
	evt.StatusText(25)         -- "Whitecap"
end

evt.hint[139] = evt.str[26]  -- "Castle Stone"
evt.map[139] = function()
	evt.StatusText(26)         -- "Castle Stone"
end

evt.hint[120] = evt.str[1]  -- "Chest"
evt.map[120] = function()
	evt.OpenChest(1)
end

evt.hint[121] = evt.str[1]  -- "Chest"
evt.map[121] = function()
	evt.OpenChest(2)
end

evt.house[150] = 180  -- "Dragoons' Keep"
evt.map[150] = function()
	evt.MoveToMap{X = -2, Y = -128, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 180, Icon = 5, Name = "D10.Blv"}         -- "Dragoons' Keep"
end

evt.house[151] = 184  -- "Tomb of Ethric the Mad"
evt.map[151] = function()
	evt.MoveToMap{X = -118, Y = -1640, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 184, Icon = 5, Name = "D14.Blv"}         -- "Tomb of Ethric the Mad"
end

evt.house[152] = 195  -- "Temple of the Moon"
evt.map[152] = function()
	evt.MoveToMap{X = 0, Y = -2135, Z = 125, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 5, Name = "T5.Blv"}         -- "Temple of the Moon"
end

evt.house[153] = 170  -- "The Oracle"
evt.map[153] = function()
	evt.MoveToMap{X = 7059, Y = -6153, Z = 1, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 170, Icon = 5, Name = "Oracle.Blv"}         -- "The Oracle"
end

evt.hint[161] = evt.str[2]  -- "Drink from Well."
evt.map[161] = function()
	if not evt.Cmp("BaseMight", 15) then
		if evt.Cmp("MapVar0", 1) then
			evt.Subtract("MapVar0", 1)
			evt.Add("BaseMight", 2)
			evt.StatusText(3)         -- "+2 Might permanent"
			evt.Set("AutonotesBits", 30)         -- "2 Points of permanent might from the fountain in the northeast of Free Haven."
			return
		end
	end
	evt.StatusText(9)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar0", 8)
end, const.Month)

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
end, const.Month)

evt.hint[163] = evt.str[5]  -- "Drink from Fountain"
evt.map[163] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.Subtract("MapVar1", 1)
		evt.Add("HP", 25)
		evt.StatusText(6)         -- "+25 Hit points restored."
	else
		evt.StatusText(9)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 31)         -- "25 Hit points restored from the central fountain in Free Haven."
end

RefillTimer(function()
	evt.Set("MapVar1", 30)
end, const.Day)

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

evt.house[211] = 158  -- "Throne Room"
evt.map[211] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 157, Icon = 2, Name = "0"}         -- "Castle Temper"
	evt.EnterHouse(158)         -- "Throne Room"
end

evt.map[212] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 178) then         -- NPC
		evt.Set("QBits", 178)         -- NPC
	end
end

events.LoadMap = evt.map[212].last

evt.hint[213] = evt.str[16]  -- "Obelisk"
evt.map[213] = function()
	evt.SetMessage(15)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            lg____gtS_cln;__"
	evt.SimpleMessage()
	evt.Set("QBits", 367)         -- NPC
	evt.Set("AutonotesBits", 86)         -- "Obelisk Message # 8:  lg____gtS_cln;__"
end

evt.map[214] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 159) then         -- NPC
		evt.SetTextureOutdoors{Model = 116, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[214].last

evt.hint[261] = evt.str[11]  -- "Shrine of Accuracy"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 4) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 211) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseAccuracy", 3)
				evt.StatusText(14)         -- "+3 Accuracy permanent"
			else
				evt.Set("QBits", 211)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseAccuracy", 10)
				evt.StatusText(13)         -- "+10 Accuracy permanent"
			end
			return
		end
	end
	evt.StatusText(12)         -- "You pray at the shrine."
end

