local TXT = Localize{
	[0] = " ",
	[1] = "Circle of Stones",
	[2] = "Chest",
	[3] = "The Sword won't budge!",
	[4] = "Drink from Well.",
	[5] = "+20 Intellect and Personality temporary.",
	[6] = "Drink from Fountain",
	[7] = "+25 Spell points restored.",
	[8] = "WOW!",
	[9] = "+2 Accuracy permanent.",
	[10] = "+2 Speed permanent.",
	[11] = "Refreshing!",
	[12] = "Avalon",
	[13] = "Shrine of Speed",
	[14] = "You pray at the shrine.",
	[15] = "+10 Speed permanent",
	[16] = "+3 Speed permanent",
	[17] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            s_r_ao_o_cr_cl_et",
	[18] = "Obelisk",
	[19] = "The Citadel /Temple of Tranquility",
	[20] = "Avalon",
	[21] = "You cannot enter at this time.",
	[22] = "Lady Kathryn is in council and cannot be disturbed.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[12]  -- "Avalon"
-- ERROR: Duplicate label: 152:2

evt.house[2] = 10  -- "Gallagher’s Shop for Home Security"
evt.map[2] = function()
	evt.EnterHouse(10)         -- "Gallagher’s Shop for Home Security"
end

evt.house[3] = 10  -- "Gallagher’s Shop for Home Security"
evt.map[3] = function()
end

evt.house[4] = 22  -- "Gallagher’s Protective Clothing"
evt.map[4] = function()
	evt.EnterHouse(22)         -- "Gallagher’s Protective Clothing"
end

evt.house[5] = 22  -- "Gallagher’s Protective Clothing"
evt.map[5] = function()
end

evt.house[6] = 32  -- "O’Malley’s Parlor Tricks"
evt.map[6] = function()
	evt.EnterHouse(32)         -- "O’Malley’s Parlor Tricks"
end

evt.house[7] = 32  -- "O’Malley’s Parlor Tricks"
evt.map[7] = function()
end

evt.house[8] = 44  -- "Trader Joe's"
evt.map[8] = function()
	evt.EnterHouse(44)         -- "Trader Joe's"
end

evt.house[9] = 44  -- "Trader Joe's"
evt.map[9] = function()
end

evt.house[10] = 53  -- "O’Malley’s Affordable Transport"
evt.map[10] = function()
	evt.EnterHouse(53)         -- "O’Malley’s Affordable Transport"
end

evt.house[11] = 53  -- "O’Malley’s Affordable Transport"
evt.map[11] = function()
end

evt.house[12] = 61  -- "Wind Dancer"
evt.map[12] = function()
	evt.EnterHouse(61)         -- "Wind Dancer"
end

evt.house[13] = 75  -- "Avalon Ministries"
evt.map[13] = function()
	evt.EnterHouse(75)         -- "Avalon Ministries"
end

evt.house[14] = 81  -- "MacGregor’s Skill Center"
evt.map[14] = function()
	evt.EnterHouse(81)         -- "MacGregor’s Skill Center"
end

evt.house[15] = 81  -- "MacGregor’s Skill Center"
evt.map[15] = function()
end

evt.house[16] = 91  -- "Town Hall"
evt.map[16] = function()
	evt.EnterHouse(91)         -- "Town Hall"
end

evt.house[17] = 100  -- "The Old Bell"
evt.map[17] = function()
	evt.EnterHouse(100)         -- "The Old Bell"
end

evt.house[18] = 100  -- "The Old Bell"
evt.map[18] = function()
end

evt.house[19] = 101  -- "Fishermen’s Friend"
evt.map[19] = function()
	evt.EnterHouse(101)         -- "Fishermen’s Friend"
end

evt.house[20] = 101  -- "Fishermen’s Friend"
evt.map[20] = function()
end

evt.house[21] = 115  -- "Nimradur Savings and Loan"
evt.map[21] = function()
	evt.EnterHouse(115)         -- "Nimradur Savings and Loan"
end

evt.house[22] = 115  -- "Nimradur Savings and Loan"
evt.map[22] = function()
end

evt.house[23] = 125  -- "Terra Magic for the Apprentice"
evt.map[23] = function()
	evt.EnterHouse(125)         -- "Terra Magic for the Apprentice"
end

evt.house[24] = 125  -- "Terra Magic for the Apprentice"
evt.map[24] = function()
end

evt.house[25] = 133  -- "Light Magic for the Apprentice"
evt.map[25] = function()
	evt.EnterHouse(133)         -- "Light Magic for the Apprentice"
end

evt.house[26] = 133  -- "Light Magic for the Apprentice"
evt.map[26] = function()
end

evt.house[27] = 140  -- "Creation Magic for the Proficient"
evt.map[27] = function()
	evt.EnterHouse(140)         -- "Creation Magic for the Proficient"
end

evt.hint[28] = evt.str[140]
evt.house[29] = 143  -- "Berserkers' Fury"
evt.map[29] = function()
	evt.EnterHouse(143)         -- "Berserkers' Fury"
end

evt.house[30] = 143  -- "Berserkers' Fury"
evt.map[30] = function()
end

evt.house[31] = 150  -- "Security Specialists Will Train"
evt.map[31] = function()
	evt.EnterHouse(150)         -- "Security Specialists Will Train"
end

evt.house[32] = 63  -- "Kraken "
evt.map[32] = function()
	evt.EnterHouse(63)         -- "Kraken "
end

evt.house[33] = 166  -- "Circus"
evt.map[33] = function()
	evt.EnterHouse(166)         -- "Circus"
end

evt.house[34] = 162  -- "Leannor Hall"
evt.map[34] = function()
	evt.ForPlayer("Current")
	if not evt.Cmp("DiplomacySkill", 136) then
		evt.SetNPCTopic{NPC = 183, Index = 0, Event = 5}         -- "Guard" : "Audience with the Baroness"
		evt.SpeakNPC(183)         -- "Guard"
		return
	end
	if not evt.Cmp("QBits", 402) then         -- Vice-Elder Dissappear
		if evt.Cmp("Awards", 7) then         -- "Destroyed the Norse Lair"
			evt.MoveNPC{NPC = 305, HouseId = 209}         -- "Vice-Elder Grummond" -> "Vice-Elder's Private Chambers"
			evt.EnterHouse(209)         -- "Vice-Elder's Private Chambers"
			return
		end
	end
	evt.EnterHouse(162)         -- "Leannor Hall"
end

evt.hint[35] = evt.str[19]  -- "The Citadel /Temple of Tranquility"
evt.map[35] = function()
	evt.StatusText(19)         -- "The Citadel /Temple of Tranquility"
end

evt.hint[36] = evt.str[20]  -- "Avalon"
evt.map[36] = function()
	evt.StatusText(20)         -- "Avalon"
end

evt.house[50] = 366  -- "House"
evt.map[50] = function()
	evt.EnterHouse(366)         -- "House"
end

evt.house[51] = 367  -- "House"
evt.map[51] = function()
	evt.EnterHouse(367)         -- "House"
end

evt.house[52] = 368  -- "House"
evt.map[52] = function()
	evt.EnterHouse(368)         -- "House"
end

evt.house[53] = 369  -- "House"
evt.map[53] = function()
	evt.EnterHouse(369)         -- "House"
end

evt.house[54] = 370  -- "House"
evt.map[54] = function()
	evt.EnterHouse(370)         -- "House"
end

evt.house[55] = 371  -- "House"
evt.map[55] = function()
	evt.EnterHouse(371)         -- "House"
end

evt.house[56] = 372  -- "House"
evt.map[56] = function()
	evt.EnterHouse(372)         -- "House"
end

evt.house[57] = 373  -- "House"
evt.map[57] = function()
	evt.EnterHouse(373)         -- "House"
end

evt.house[58] = 374  -- "House"
evt.map[58] = function()
	evt.EnterHouse(374)         -- "House"
end

evt.house[59] = 375  -- "House"
evt.map[59] = function()
	evt.EnterHouse(375)         -- "House"
end

evt.house[60] = 376  -- "House"
evt.map[60] = function()
	evt.EnterHouse(376)         -- "House"
end

evt.house[61] = 377  -- "House"
evt.map[61] = function()
	evt.EnterHouse(377)         -- "House"
end

evt.house[62] = 378  -- "House"
evt.map[62] = function()
	evt.EnterHouse(378)         -- "House"
end

evt.house[63] = 379  -- "House"
evt.map[63] = function()
	evt.EnterHouse(379)         -- "House"
end

evt.house[64] = 380  -- "House"
evt.map[64] = function()
	evt.EnterHouse(380)         -- "House"
end

evt.house[65] = 381  -- "House"
evt.map[65] = function()
	evt.EnterHouse(381)         -- "House"
end

evt.house[66] = 382  -- "Mallt's Home"
evt.map[66] = function()
	evt.EnterHouse(382)         -- "Mallt's Home"
end

evt.house[67] = 383  -- "House"
evt.map[67] = function()
	evt.EnterHouse(383)         -- "House"
end

evt.house[68] = 384  -- "House"
evt.map[68] = function()
	evt.EnterHouse(384)         -- "House"
end

evt.house[69] = 385  -- "House"
evt.map[69] = function()
	evt.EnterHouse(385)         -- "House"
end

evt.house[70] = 386  -- "House"
evt.map[70] = function()
	evt.EnterHouse(386)         -- "House"
end

evt.house[71] = 387  -- "House"
evt.map[71] = function()
	evt.EnterHouse(387)         -- "House"
end

evt.house[72] = 388  -- "House"
evt.map[72] = function()
	evt.EnterHouse(388)         -- "House"
end

evt.house[73] = 389  -- "House"
evt.map[73] = function()
	evt.EnterHouse(389)         -- "House"
end

evt.house[74] = 390  -- "House"
evt.map[74] = function()
	evt.EnterHouse(390)         -- "House"
end

evt.house[75] = 391  -- "House"
evt.map[75] = function()
	evt.EnterHouse(391)         -- "House"
end

evt.house[76] = 392  -- "House"
evt.map[76] = function()
	evt.EnterHouse(392)         -- "House"
end

evt.house[77] = 393  -- "House"
evt.map[77] = function()
	evt.EnterHouse(393)         -- "House"
end

evt.house[78] = 394  -- "House"
evt.map[78] = function()
	evt.EnterHouse(394)         -- "House"
end

evt.house[79] = 395  -- "House"
evt.map[79] = function()
	evt.EnterHouse(395)         -- "House"
end

evt.house[80] = 396  -- "House"
evt.map[80] = function()
	evt.EnterHouse(396)         -- "House"
end

evt.house[81] = 397  -- "House"
evt.map[81] = function()
	evt.EnterHouse(397)         -- "House"
end

evt.house[82] = 398  -- "House"
evt.map[82] = function()
	evt.EnterHouse(398)         -- "House"
end

evt.house[83] = 399  -- "House"
evt.map[83] = function()
	evt.EnterHouse(399)         -- "House"
end

evt.house[84] = 400  -- "Home of Aelwen"
evt.map[84] = function()
	evt.EnterHouse(400)         -- "Home of Aelwen"
end

evt.house[85] = 401  -- "House"
evt.map[85] = function()
	evt.EnterHouse(401)         -- "House"
end

evt.house[86] = 402  -- "House"
evt.map[86] = function()
	evt.EnterHouse(402)         -- "House"
end

evt.house[87] = 403  -- "House"
evt.map[87] = function()
	evt.EnterHouse(403)         -- "House"
end

evt.house[88] = 404  -- "House"
evt.map[88] = function()
	evt.EnterHouse(404)         -- "House"
end

evt.house[89] = 405  -- "House"
evt.map[89] = function()
	evt.EnterHouse(405)         -- "House"
end

evt.house[90] = 406  -- "Home of HodgePodge"
evt.map[90] = function()
	evt.EnterHouse(406)         -- "Home of HodgePodge"
end

evt.house[91] = 407  -- "House"
evt.map[91] = function()
	evt.EnterHouse(407)         -- "House"
end

evt.house[92] = 408  -- "House"
evt.map[92] = function()
	evt.EnterHouse(408)         -- "House"
end

evt.house[93] = 409  -- "House"
evt.map[93] = function()
	evt.EnterHouse(409)         -- "House"
end

evt.house[94] = 410  -- "House"
evt.map[94] = function()
	evt.EnterHouse(410)         -- "House"
end

evt.house[95] = 411  -- "House"
evt.map[95] = function()
	evt.EnterHouse(411)         -- "House"
end

evt.hint[100] = evt.str[2]  -- "Chest"
evt.map[100] = function()
	evt.OpenChest(1)
end

evt.hint[101] = evt.str[2]  -- "Chest"
evt.map[101] = function()
	evt.OpenChest(2)
end

evt.hint[102] = evt.str[2]  -- "Chest"
evt.map[102] = function()
	evt.OpenChest(3)
end

evt.house[150] = 182  -- "Temple of Agrona's Faithful"
evt.map[150] = function()
	evt.MoveToMap{X = -128, Y = -3968, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "D13.Blv"}
end

evt.house[151] = 183  -- "Druid Temple"
evt.map[151] = function()
	evt.MoveToMap{X = -2, Y = -128, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 183, Icon = 5, Name = "D10.Blv"}         -- "Druid Temple"
end

evt.house[152] = 186  -- "The Citadel"
evt.map[152] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(186)         -- "The Citadel"
	else
		evt.StatusText(22)         -- "Lady Kathryn is in council and cannot be disturbed."
	end
end

evt.hint[161] = evt.str[4]  -- "Drink from Well."
evt.map[161] = function()
	if evt.Cmp("IntellectBonus", 20) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Set("IntellectBonus", 20)
		evt.Set("PersonalityBonus", 20)
		evt.StatusText(5)         -- "+20 Intellect and Personality temporary."
		evt.Set("AutonotesBits", 25)         -- "20 Points of temporary intellect and personality from the fountain in the north side of Avalon."
	end
end

evt.hint[162] = evt.str[6]  -- "Drink from Fountain"
evt.map[162] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("SP", 25)
		evt.StatusText(7)         -- "+25 Spell points restored."
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 26)         -- "25 Spell points restored by the fountain outside of Town Hall in Avalon."
end

Timer(function()
	evt.Set("MapVar0", 20)
end, const.Day, 1*const.Second)

evt.hint[163] = evt.str[6]  -- "Drink from Fountain"
evt.map[163] = function()
	evt.Set("Insane", 0)
	evt.StatusText(8)         -- "WOW!"
end

evt.hint[164] = evt.str[6]  -- "Drink from Fountain"
evt.map[164] = function()
	if not evt.Cmp("BaseAccuracy", 15) then
		if evt.Cmp("MapVar1", 1) then
			evt.Subtract("MapVar1", 1)
			evt.Add("BaseAccuracy", 7)
			evt.StatusText(9)         -- "+2 Accuracy permanent."
			evt.Set("AutonotesBits", 27)         -- "2 Points of permanent accuracy from the north fountain west of Avalon."
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar1", 8)
end, const.Month, true)

evt.hint[165] = evt.str[6]  -- "Drink from Fountain"
evt.map[165] = function()
	if not evt.Cmp("BaseSpeed", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BaseSpeed", 2)
			evt.StatusText(10)         -- "+2 Speed permanent."
			evt.Set("AutonotesBits", 28)         -- "2 Points of permanent speed from the south fountain west of Avalon."
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar2", 8)
end, const.Month, true)

evt.map[209] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 158) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = 11032, FromY = -8940, FromZ = 2830, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[209].last, 5*const.Minute)

evt.map[210] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 158) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 158)         -- NPC
			evt.SetTextureOutdoors{Model = 117, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.hint[211] = evt.str[1]  -- "Circle of Stones"
evt.map[212] = function()
	evt.MoveToMap{X = -12344, Y = 17112, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[213] = function()
	evt.MoveToMap{X = -9400, Y = 17184, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[214] = function()
	evt.MoveToMap{X = -11512, Y = 19368, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[215] = function()
	evt.MoveToMap{X = -9192, Y = 21936, Z = 160, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[220] = function()
	if not evt.Cmp("QBits", 310) then         -- NPC
		if evt.Cmp("CurrentMight", 60) then
			evt.Set("QBits", 310)         -- NPC
			evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 0}
			evt.SetSprite{SpriteId = 359, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(3)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 310) then         -- NPC
		evt.SetSprite{SpriteId = 359, Visible = 1, Name = "swrdstx"}
	end
end

evt.map[221] = function()
	if not evt.Cmp("QBits", 311) then         -- NPC
		if evt.Cmp("CurrentMight", 60) then
			evt.Set("QBits", 311)         -- NPC
			evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 0}
			evt.SetSprite{SpriteId = 360, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(3)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 311) then         -- NPC
		evt.SetSprite{SpriteId = 360, Visible = 1, Name = "swrdstx"}
	end
end

evt.map[222] = function()
	if not evt.Cmp("QBits", 312) then         -- NPC
		if evt.Cmp("CurrentMight", 100) then
			evt.Set("QBits", 312)         -- NPC
			evt.GiveItem{Strength = 6, Type = const.ItemType.Sword, Id = 0}
			evt.SetSprite{SpriteId = 361, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(3)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 312) then         -- NPC
		evt.SetSprite{SpriteId = 361, Visible = 1, Name = "swrdstx"}
	end
end

evt.map[223] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 179) then         -- NPC
		evt.Set("QBits", 179)         -- NPC
	end
end

events.LoadMap = evt.map[223].last

evt.hint[224] = evt.str[18]  -- "Obelisk"
evt.map[224] = function()
	evt.SetMessage(17)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            s_r_ao_o_cr_cl_et"
	evt.SimpleMessage()
	evt.Set("QBits", 369)         -- NPC
	evt.Set("AutonotesBits", 88)         -- "Obelisk Message # 10: s_r_ao_o_cr_cl_et"
end

evt.map[226] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 158) then         -- NPC
		evt.SetTextureOutdoors{Model = 117, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[226].last

evt.hint[261] = evt.str[13]  -- "Shrine of Speed"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 5) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 209) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseSpeed", 3)
				evt.StatusText(16)         -- "+3 Speed permanent"
			else
				evt.Set("QBits", 209)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseSpeed", 10)
				evt.StatusText(15)         -- "+10 Speed permanent"
			end
			return
		end
	end
	evt.StatusText(14)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 420) then         -- Avalon once
		if evt.Cmp("QBits", 507) then         -- Death Wish
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 13686, Y = -9529, Z = 95}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 7648, Y = -6368, Z = 290}
		end
	else
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.Add("QBits", 420)         -- Avalon once
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = 3853, Y = -10725, Z = 625}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = -21148, Y = -2475, Z = 220}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -21187, Y = -2943, Z = 161}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 3237, Y = -11957, Z = 625}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 2452, Y = -11066, Z = 625}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -20919, Y = -2705, Z = 220}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -20399, Y = -3339, Z = 161}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -20058, Y = -3205, Z = 225}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -20183, Y = -2491, Z = 225}
			end
		end
	end
end

events.LoadMap = evt.map[262].last

