local TXT = Localize{
	[0] = " ",
	[1] = "Quedagh Curse",
	[2] = "Drink from Well.",
	[3] = "You feel Strange.",
	[4] = "+5000 Experience, -5000 Gold.",
	[5] = "+30 Level temporary.  Look Out!",
	[6] = "Drink from Fountain",
	[7] = "+10 Magic resistance permanent.",
	[8] = "+40 Armor class temporary.",
	[9] = "+5 Elemental resistance permanent.",
	[10] = "Refreshing!",
	[11] = "Chest",
	[12] = "Begone!",
	[13] = "Norseland",
	[14] = "Shrine of Poison",
	[15] = "You pray at the shrine.",
	[16] = "+10 Poison resistance permanent",
	[17] = "+3 Poison resistance permanent",
	[18] = "Pedestal",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            ttd__nuy_ts_ecwi_",
	[20] = "Obelisk",
	[21] = "Shrine of Luck",
	[22] = "You pray at the shrine.",
	[23] = "+10 Luck permanent",
	[24] = "+3 Luck permanent",
	[25] = "You cannot enter at this time",
	[26] = "The entrance is magically warded.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[13]  -- "Norseland"
-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[91] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[92] not assigned for hint, because Hint command is missing
-- ERROR: Duplicate label: 100:11
-- ERROR: Duplicate label: 150:5
-- ERROR: Duplicate label: 150:6
-- ERROR: Duplicate label: 150:7
-- ERROR: Duplicate label: 150:8

evt.house[2] = 14  -- "Egil’s Items for Home Defense"
evt.map[2] = function()
	evt.EnterHouse(14)         -- "Egil’s Items for Home Defense"
end

evt.house[3] = 14  -- "Egil’s Items for Home Defense"
evt.map[3] = function()
end

evt.house[4] = 26  -- "Hlín’s Armorwear"
evt.map[4] = function()
	evt.EnterHouse(26)         -- "Hlín’s Armorwear"
end

evt.house[5] = 26  -- "Hlín’s Armorwear"
evt.map[5] = function()
end

evt.house[6] = 36  -- "Arngeirr’s Curiosities "
evt.map[6] = function()
	evt.EnterHouse(36)         -- "Arngeirr’s Curiosities "
end

evt.house[7] = 36  -- "Arngeirr’s Curiosities "
evt.map[7] = function()
end

evt.house[8] = 55  -- "Ulrich’s Shipments"
evt.map[8] = function()
	evt.EnterHouse(55)         -- "Ulrich’s Shipments"
end

evt.house[9] = 55  -- "Ulrich’s Shipments"
evt.map[9] = function()
end

evt.house[10] = 87  -- "Heremod’s Fitness"
evt.map[10] = function()
	evt.EnterHouse(87)         -- "Heremod’s Fitness"
end

evt.house[11] = 87  -- "Heremod’s Fitness"
evt.map[11] = function()
end

evt.house[12] = 111  -- "Gullveig’s Brew"
evt.map[12] = function()
	evt.EnterHouse(111)         -- "Gullveig’s Brew"
end

evt.house[13] = 111  -- "Gullveig’s Brew"
evt.map[13] = function()
end

evt.house[14] = 552  -- "Hermit's Hut"
evt.map[14] = function()
	evt.EnterHouse(552)         -- "Hermit's Hut"
end

evt.house[40] = 235  -- "Bogna The Alchemist"
evt.map[40] = function()
	evt.EnterHouse(235)         -- "Bogna The Alchemist"
end

evt.house[41] = 236  -- "House"
evt.map[41] = function()
	evt.EnterHouse(236)         -- "House"
end

evt.house[42] = 237  -- "House"
evt.map[42] = function()
	evt.EnterHouse(237)         -- "House"
end

evt.house[43] = 238  -- "House"
evt.map[43] = function()
	evt.EnterHouse(238)         -- "House"
end

evt.house[50] = 239  -- "Home of Tanfana"
evt.map[50] = function()
	evt.EnterHouse(239)         -- "Home of Tanfana"
end

evt.house[51] = 240  -- "House"
evt.map[51] = function()
	evt.EnterHouse(240)         -- "House"
end

evt.house[52] = 241  -- "House"
evt.map[52] = function()
	evt.EnterHouse(241)         -- "House"
end

evt.house[53] = 242  -- "House"
evt.map[53] = function()
	evt.EnterHouse(242)         -- "House"
end

evt.house[54] = 243  -- "House"
evt.map[54] = function()
	evt.EnterHouse(243)         -- "House"
end

evt.house[55] = 244  -- "House"
evt.map[55] = function()
	evt.EnterHouse(244)         -- "House"
end

evt.house[56] = 245  -- "House"
evt.map[56] = function()
	evt.EnterHouse(245)         -- "House"
end

evt.house[57] = 246  -- "House"
evt.map[57] = function()
	evt.EnterHouse(246)         -- "House"
end

evt.house[58] = 541  -- "House"
evt.map[58] = function()
	evt.EnterHouse(541)         -- "House"
end

evt.house[59] = 542  -- "House"
evt.map[59] = function()
	evt.EnterHouse(542)         -- "House"
end

evt.house[60] = 543  -- "House"
evt.map[60] = function()
	evt.EnterHouse(543)         -- "House"
end

evt.house[61] = 544  -- "House"
evt.map[61] = function()
	evt.EnterHouse(544)         -- "House"
end

evt.house[62] = 545  -- "House"
evt.map[62] = function()
	evt.EnterHouse(545)         -- "House"
end

evt.house[63] = 546  -- "House"
evt.map[63] = function()
	evt.EnterHouse(546)         -- "House"
end

evt.house[64] = 547  -- "House"
evt.map[64] = function()
	evt.EnterHouse(547)         -- "House"
end

evt.house[65] = 548  -- "House"
evt.map[65] = function()
	evt.EnterHouse(548)         -- "House"
end

evt.hint[75] = evt.str[11]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[11]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.map[90] = function()
	evt.MoveToMap{X = -2048, Y = 3453, Z = 2049, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 197, Icon = 5, Name = "T6.Blv"}         -- "Superior Temple of Baa"
end

evt.map[91] = function()
	evt.MoveToMap{X = 2702, Y = -2926, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 189, Icon = 5, Name = "D19.Blv"}         -- "Agar's Laboratory"
end

evt.map[92] = function()
	evt.MoveToMap{X = -9600, Y = 22127, Z = 1, Direction = 1540, LookAngle = 0, SpeedZ = 0, HouseId = 187, Icon = 5, Name = "D17.Blv"}         -- "Lair of the Wolf"
end

evt.house[93] = 201  -- "Fortress of The Ancients"
evt.map[93] = function()
	if not evt.Cmp("Awards", 42) then         -- "Retrieved the Jewel of Power"
		if not evt.Cmp("QBits", 131) then         -- "Find the Jewel of Power in the Fortress of the Ancients in Norseland.  Then return to the Seer."
			evt.StatusText(26)         -- "The entrance is magically warded."
			return
		end
	end
	evt.MoveToMap{X = 5861, Y = 2720, Z = 169, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 201, Icon = 5, Name = "CD3.Blv"}         -- "Fortress of The Ancients"
end

evt.hint[94] = evt.str[1]  -- "Quedagh Curse"
evt.map[94] = function()
	if evt.Cmp("NPCs", 112) then         -- "Hodge Podge"
		evt.MoveToMap{X = 1408, Y = -1664, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 178, Icon = 5, Name = "D08.Blv"}         -- "Quedagh Curse"
	else
		evt.StatusText(26)         -- "The entrance is magically warded."
	end
end

evt.hint[100] = evt.str[2]  -- "Drink from Well."
evt.map[100] = function()
	evt.StatusText(3)         -- "You feel Strange."
	evt.ForPlayer("All")
	evt.Add("Drunk", 0)
end

evt.hint[101] = evt.str[2]  -- "Drink from Well."
evt.map[101] = function()
	if evt.Cmp("MapVar0", 1) then
		if evt.Cmp("Gold", 5000) then
			evt.Subtract("Gold", 5000)
			evt.Add("Experience", 5000)
			evt.Subtract("MapVar0", 1)
			evt.StatusText(4)         -- "+5000 Experience, -5000 Gold."
			evt.Set("AutonotesBits", 46)         -- "5000 Experience and minus 5000 gold from the southern well in the town of Akershaven."
			return
		end
	end
	evt.StatusText(10)         -- "Refreshing!"
end

Timer(function()
	evt.Set("MapVar0", 10)
end, const.Day, 1*const.Second)

evt.hint[102] = evt.str[2]  -- "Drink from Well."
evt.map[102] = function()
	if evt.Cmp("LevelBonus", 30) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("LevelBonus", 30)
		evt.StatusText(5)         -- "+30 Level temporary.  Look Out!"
		evt.Set("AutonotesBits", 47)         -- "30 Temporary levels from the western well in the town of Akershaven."
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -13280, Y = 19696, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -13368, Y = 18096, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -10976, Y = 18152, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9992, Y = 19056, Z = 160}
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from Fountain"
evt.map[103] = function()
	if evt.Cmp("PlayerBits", 6) then
		evt.Set("Eradicated", 0)
	else
		evt.Set("PlayerBits", 6)
		evt.Add("MagicResistance", 10)
		evt.Set("Eradicated", 0)
		evt.StatusText(7)         -- "+10 Magic resistance permanent."
		evt.Set("AutonotesBits", 48)         -- "10 Points of permanent magic resistance from the fountain north of the Dragon Tower in the town of Akershaven."
	end
end

evt.hint[104] = evt.str[6]  -- "Drink from Fountain"
evt.map[104] = function()
	if evt.Cmp("ArmorClassBonus", 40) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("ArmorClassBonus", 40)
		evt.StatusText(8)         -- "+40 Armor class temporary."
		evt.Set("AutonotesBits", 49)         -- "40 Points of temporary armor class from the fountain outside of the Fortress of The Ancients."
	end
end

evt.hint[105] = evt.str[6]  -- "Drink from Fountain"
evt.map[105] = function()
	if evt.Cmp("PlayerBits", 7) then
		evt.Set("Dead", 0)
	else
		evt.Set("PlayerBits", 7)
		evt.Add("FireResistance", 5)
		evt.Add("ElecResistance", 5)
		evt.Add("ColdResistance", 5)
		evt.Add("PoisonResistance", 5)
		evt.Set("Dead", 0)
		evt.StatusText(9)         -- "+5 Elemental resistance permanent."
		evt.Set("AutonotesBits", 50)         -- "5 Points of permanent fire, electricity, cold, and poison resistance from the fountain northwest of the Superior Temple of Baa."
	end
end

evt.hint[261] = evt.str[14]  -- "Shrine of Poison"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 10) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 216) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("PoisonResistance", 3)
				evt.StatusText(17)         -- "+3 Poison resistance permanent"
			else
				evt.Set("QBits", 216)         -- NPC
				evt.ForPlayer("All")
				evt.Add("PoisonResistance", 10)
				evt.StatusText(16)         -- "+10 Poison resistance permanent"
			end
			return
		end
	end
	evt.StatusText(15)         -- "You pray at the shrine."
end

evt.hint[262] = evt.str[21]  -- "Shrine of Luck"
evt.map[262] = function()
	if evt.Cmp("MonthIs", 6) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 214) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseLuck", 3)
				evt.StatusText(24)         -- "+3 Luck permanent"
			else
				evt.Set("QBits", 214)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseLuck", 10)
				evt.StatusText(23)         -- "+10 Luck permanent"
			end
			return
		end
	end
	evt.StatusText(22)         -- "You pray at the shrine."
end

evt.hint[150] = evt.str[18]  -- "Pedestal"
evt.map[150] = function()
	if evt.Cmp("QBits", 223) then         -- NPC
		evt.MoveToMap{X = 4427, Y = 3061, Z = 769, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "D07.Blv"}
	else
		if evt.Cmp("Inventory", 451) then         -- "Bear Statuette"
			evt.Subtract("Inventory", 451)         -- "Bear Statuette"
			evt.SetSprite{SpriteId = 141, Visible = 1, Name = "ped01"}
			evt.Set("QBits", 223)         -- NPC
		end
	end
end

evt.map[151] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 223) then         -- NPC
		evt.SetSprite{SpriteId = 141, Visible = 1, Name = "ped01"}
	end
end

events.LoadMap = evt.map[151].last

evt.hint[152] = evt.str[20]  -- "Obelisk"
evt.map[152] = function()
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            ttd__nuy_ts_ecwi_"
	evt.SimpleMessage()
	evt.Set("QBits", 363)         -- NPC
	evt.Set("AutonotesBits", 82)         -- "Obelisk Message # 4:  ttd__nuy_ts_ecwi_"
end

evt.map[260] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 466) then         -- Norseland Once
		evt.Set("QBits", 466)         -- Norseland Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 7932, Y = 15832, Z = 445}
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 21791, Y = 19452, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 21059, Y = 17947, Z = 704}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 15543, Y = 19519, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 15535, Y = 19510, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 13431, Y = 17838, Z = 232}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -14885, Y = 6365, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -14880, Y = 6360, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -11553, Y = -12828, Z = 1600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 6, X = -10425, Y = -12828, Z = 1600}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 19036, Y = 18498, Z = 486}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 13563, Y = 15923, Z = 284}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -14875, Y = 6355, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -11550, Y = -12820, Z = 1600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -9559, Y = -12058, Z = 1600}
	end
end

events.LoadMap = evt.map[260].last

