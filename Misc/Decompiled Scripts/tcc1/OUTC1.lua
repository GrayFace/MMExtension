local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Well.",
	[2] = "Look Out!",
	[3] = "Drink from Fountain",
	[4] = "+20 Accuracy and Speed temporary.",
	[5] = "+20 Armor class temporary.",
	[6] = "+10 Level temporary.",
	[7] = "+30 Might temporary.",
	[8] = "+5 Might permanent.",
	[9] = "+5 Endurance permanent.",
	[10] = "Refreshing!",
	[11] = "Norseland",
	[12] = "Shrine of Accuracy",
	[13] = "You pray at the shrine.",
	[14] = "+10 Accuracy permanent",
	[15] = "+3 Accuracy permanent",
	[16] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _a,uef;re_oottg_l",
	[17] = "Obelisk",
	[18] = "Castle Birka",
	[19] = "Jorgsborg",
	[20] = "Cumbria/Port Sleigon",
	[21] = "Locked.  The proprietor has fled to the mountains.",
	[22] = "The Lord is in council and cannot be disturbed.",
	[23] = "You need the proper key to enter the keep.",
	[24] = "You cannot enter at this time",
	[25] = "This entrance is magically warded.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[11]  -- "Norseland"
-- ERROR: evt.house[78] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[91] not assigned for hint, because Hint command is missing
-- ERROR: Duplicate label: 265:0

evt.house[2] = 12  -- "Ullr's Arrows"
evt.map[2] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(12)         -- "Ullr's Arrows"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[3] = 12  -- "Ullr's Arrows"
evt.map[3] = function()
end

evt.house[4] = 27  -- "Bruar's Armor"
evt.map[4] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(27)         -- "Bruar's Armor"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[5] = 27  -- "Bruar's Armor"
evt.map[5] = function()
end

evt.house[6] = 35  -- "Apples, Thorns, and Potions"
evt.map[6] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(35)         -- "Apples, Thorns, and Potions"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[7] = 35  -- "Apples, Thorns, and Potions"
evt.map[7] = function()
end

evt.house[8] = 46  -- "General Store"
evt.map[8] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(46)         -- "General Store"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[9] = 46  -- "General Store"
evt.map[9] = function()
end

evt.house[10] = 73  -- "Jorgsborg Temple"
evt.map[10] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(73)         -- "Jorgsborg Temple"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[11] = 88  -- "Riverside Academy"
evt.map[11] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(88)         -- "Riverside Academy"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[12] = 88  -- "Riverside Academy"
evt.map[12] = function()
end

evt.house[13] = 108  -- "The Frosty Tankard"
evt.map[13] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(108)         -- "The Frosty Tankard"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[14] = 108  -- "The Frosty Tankard"
evt.map[14] = function()
end

evt.house[15] = 107  -- "Tordoff Inn"
evt.map[15] = function()
	evt.EnterHouse(107)         -- "Tordoff Inn"
end

evt.house[16] = 107  -- "Tordoff Inn"
evt.map[16] = function()
end

evt.house[17] = 117  -- "Secure Trust"
evt.map[17] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(117)         -- "Secure Trust"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[18] = 117  -- "Secure Trust"
evt.map[18] = function()
end

evt.house[19] = 135  -- "Initiate Guild of Dark"
evt.map[19] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(135)         -- "Initiate Guild of Dark"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[20] = 135  -- "Initiate Guild of Dark"
evt.map[20] = function()
end

evt.house[21] = 138  -- "Adept Guild of the Creation Magics"
evt.map[21] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(138)         -- "Adept Guild of the Creation Magics"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[22] = 138  -- "Adept Guild of the Creation Magics"
evt.map[22] = function()
end

evt.house[23] = 145  -- "Dagger's Tip"
evt.map[23] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(145)         -- "Dagger's Tip"
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[24] = 145  -- "Dagger's Tip"
evt.map[24] = function()
end

evt.house[25] = 149  -- "Hiln's Agency"
evt.map[25] = function()
	evt.EnterHouse(149)         -- "Hiln's Agency"
end

evt.house[26] = 149  -- "Hiln's Agency"
evt.map[26] = function()
end

evt.house[27] = 9  -- "Tyr's Staffs"
evt.map[27] = function()
	evt.EnterHouse(9)         -- "Tyr's Staffs"
end

evt.house[28] = 9  -- "Tyr's Staffs"
evt.map[28] = function()
end

evt.house[29] = 23  -- "Forseti's Forge"
evt.map[29] = function()
	evt.EnterHouse(23)         -- "Forseti's Forge"
end

evt.house[30] = 23  -- "Forseti's Forge"
evt.map[30] = function()
end

evt.house[31] = 54  -- "Jorgsborg Transport Co."
evt.map[31] = function()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.EnterHouse(54)         -- "Jorgsborg Transport Co."
	else
		evt.StatusText(21)         -- "Locked.  The proprietor has fled to the mountains."
	end
end

evt.house[32] = 54  -- "Jorgsborg Transport Co."
evt.map[32] = function()
end

evt.house[33] = 160  -- "Temple of Tranquility"
evt.map[33] = function()
	evt.MoveToMap{X = 21169, Y = 1920, Z = -689, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 200, Icon = 5, Name = "CD2.Blv"}         -- "Castle Darkmoor"
end

evt.house[34] = 164  -- "Castle Birka"
evt.map[34] = function()
	if evt.Cmp("QBits", 85) then         -- "Enter Castle Birka in Demonclaw and talk with Lord Godwinson."
		evt.Set("QBits", 486)         -- Birka Entrance after Bona Fide
	else
		if evt.Cmp("QBits", 86) then         -- "Raise the siege of Birka and secure Jorgsburg."
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = -12760, Y = 14065, Z = 97}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 7, X = -13575, Y = 15569, Z = 97}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = -15893, Y = 16608, Z = 430}
		else
			if not evt.Cmp("QBits", 486) then         -- Birka Entrance after Bona Fide
				if not evt.Cmp("Inventory", 515) then         -- "Bona  Fide"
					evt.StatusText(22)         -- "The Lord is in council and cannot be disturbed."
					return
				end
			end
		end
	end
	evt.EnterHouse(164)         -- "Castle Birka"
end

evt.hint[35] = evt.str[18]  -- "Castle Birka"
evt.map[35] = function()
	evt.StatusText(18)         -- "Castle Birka"
end

evt.hint[36] = evt.str[19]  -- "Jorgsborg"
evt.map[36] = function()
	evt.StatusText(19)         -- "Jorgsborg"
end

evt.hint[37] = evt.str[20]  -- "Cumbria/Port Sleigon"
evt.map[37] = function()
	evt.StatusText(20)         -- "Cumbria/Port Sleigon"
end

evt.house[50] = 268  -- "House"
evt.map[50] = function()
	evt.EnterHouse(268)         -- "House"
end

evt.house[51] = 269  -- "House"
evt.map[51] = function()
	evt.EnterHouse(269)         -- "House"
end

evt.house[52] = 270  -- "House"
evt.map[52] = function()
	evt.EnterHouse(270)         -- "House"
end

evt.house[53] = 271  -- "House"
evt.map[53] = function()
	evt.EnterHouse(271)         -- "House"
end

evt.house[54] = 272  -- "House"
evt.map[54] = function()
	evt.EnterHouse(272)         -- "House"
end

evt.house[55] = 273  -- "House"
evt.map[55] = function()
	evt.EnterHouse(273)         -- "House"
end

evt.house[56] = 274  -- "House"
evt.map[56] = function()
	evt.EnterHouse(274)         -- "House"
end

evt.house[57] = 275  -- "House"
evt.map[57] = function()
	evt.EnterHouse(275)         -- "House"
end

evt.house[58] = 276  -- "House"
evt.map[58] = function()
	evt.EnterHouse(276)         -- "House"
end

evt.house[59] = 277  -- "House"
evt.map[59] = function()
	evt.EnterHouse(277)         -- "House"
end

evt.house[60] = 278  -- "House"
evt.map[60] = function()
	evt.EnterHouse(278)         -- "House"
end

evt.house[61] = 279  -- "House"
evt.map[61] = function()
	evt.EnterHouse(279)         -- "House"
end

evt.house[62] = 280  -- "House"
evt.map[62] = function()
	evt.EnterHouse(280)         -- "House"
end

evt.house[63] = 281  -- "House"
evt.map[63] = function()
	evt.EnterHouse(281)         -- "House"
end

evt.house[64] = 282  -- "House"
evt.map[64] = function()
	evt.EnterHouse(282)         -- "House"
end

evt.house[65] = 499  -- "House"
evt.map[65] = function()
	evt.EnterHouse(499)         -- "House"
end

evt.house[66] = 500  -- "House"
evt.map[66] = function()
	evt.EnterHouse(500)         -- "House"
end

evt.house[67] = 501  -- "House"
evt.map[67] = function()
	evt.EnterHouse(501)         -- "House"
end

evt.house[68] = 502  -- "House"
evt.map[68] = function()
	evt.EnterHouse(502)         -- "House"
end

evt.house[69] = 503  -- "House"
evt.map[69] = function()
	evt.EnterHouse(503)         -- "House"
end

evt.house[70] = 504  -- "House"
evt.map[70] = function()
	evt.EnterHouse(504)         -- "House"
end

evt.house[71] = 108  -- "The Frosty Tankard"
evt.map[71] = function()
	evt.EnterHouse(108)         -- "The Frosty Tankard"
end

evt.house[72] = 73  -- "Jorgsborg Temple"
evt.map[72] = function()
	evt.EnterHouse(73)         -- "Jorgsborg Temple"
end

evt.house[73] = 507  -- "House"
evt.map[73] = function()
	evt.EnterHouse(507)         -- "House"
end

evt.house[74] = 508  -- "House"
evt.map[74] = function()
	evt.EnterHouse(508)         -- "House"
end

evt.house[75] = 509  -- "House"
evt.map[75] = function()
	evt.EnterHouse(509)         -- "House"
end

evt.house[76] = 510  -- "House"
evt.map[76] = function()
	evt.EnterHouse(510)         -- "House"
end

evt.house[77] = 511  -- "House"
evt.map[77] = function()
	evt.EnterHouse(511)         -- "House"
end

evt.map[78] = function()
	evt.EnterHouse(512)         -- "House"
end

evt.house[79] = 513  -- "House"
evt.map[79] = function()
	evt.EnterHouse(513)         -- "House"
end

evt.house[80] = 514  -- "House"
evt.map[80] = function()
	evt.EnterHouse(514)         -- "House"
end

evt.house[81] = 515  -- "House"
evt.map[81] = function()
	evt.EnterHouse(515)         -- "House"
end

evt.house[82] = 516  -- "House"
evt.map[82] = function()
	evt.EnterHouse(516)         -- "House"
end

evt.house[83] = 517  -- "House"
evt.map[83] = function()
	evt.EnterHouse(517)         -- "House"
end

evt.house[84] = 518  -- "Royal Guest Chambers"
evt.map[84] = function()
	evt.EnterHouse(518)         -- "Royal Guest Chambers"
end

evt.map[85] = function()
	evt.OpenChest(1)
end

evt.map[86] = function()
	evt.OpenChest(2)
end

evt.house[90] = 174  -- "Forbidden Vault"
evt.map[90] = function()
	if not evt.Cmp("Awards", 39) then         -- "Delivered the four skulls to Magnus"
		if not evt.Cmp("QBits", 128) then         -- "Recover the Bronze skull from the Forbidden Vault and return to Magnus."
			evt.StatusText(25)         -- "This entrance is magically warded."
			return
		end
	end
	evt.MoveToMap{X = -1792, Y = -19, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 171, Icon = 5, Name = "D04.Blv"}         -- "Goblinwatch"
end

evt.map[91] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 482) then         -- The Barracks Once
		if not evt.Cmp("Inventory", 490) then         -- "Barracks Key"
			evt.StatusText(23)         -- "You need the proper key to enter the keep."
			return
		end
	end
	evt.MoveToMap{X = -495, Y = -219, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 185, Icon = 5, Name = "D15.Blv"}         -- "Barracks  Keep"
end

evt.hint[100] = evt.str[1]  -- "Drink from Well."
evt.map[100] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 15024, Y = -4720, Z = 96}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 16960, Y = -3936, Z = 96}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 16320, Y = -1648, Z = 224}
		evt.Set("MapVar0", 1)
		evt.StatusText(2)         -- "Look Out!"
	end
end

RefillTimer(function()
	evt.Set("MapVar0", 0)
end, const.Month, true)

evt.hint[101] = evt.str[1]  -- "Drink from Well."
evt.map[101] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -5136, Y = 15968, Z = 96}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -6912, Y = 13952, Z = 96}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -5152, Y = 13648, Z = 96}
		evt.Set("MapVar1", 1)
		evt.StatusText(2)         -- "Look Out!"
	end
end

RefillTimer(function()
	evt.Set("MapVar1", 0)
end, const.Month, true)

evt.hint[102] = evt.str[3]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("AccuracyBonus", 20) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("AccuracyBonus", 20)
		evt.Set("SpeedBonus", 20)
		evt.StatusText(4)         -- "+20 Accuracy and Speed temporary."
		evt.Set("AutonotesBits", 32)         -- "20 Points of temporary speed and accuracy from the west fountain in Icewind Lake."
	end
end

evt.hint[103] = evt.str[3]  -- "Drink from Fountain"
evt.map[103] = function()
	if evt.Cmp("ArmorClassBonus", 20) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("ArmorClassBonus", 20)
		evt.StatusText(5)         -- "+20 Armor class temporary."
		evt.Set("AutonotesBits", 33)         -- "20 Points of temporary armor class from the east fountain in Icewind Lake."
	end
end

evt.hint[104] = evt.str[3]  -- "Drink from Fountain"
evt.map[104] = function()
	if evt.Cmp("LevelBonus", 10) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("LevelBonus", 10)
		evt.StatusText(6)         -- "+10 Level temporary."
		evt.Set("AutonotesBits", 34)         -- "10 Temporary levels from the fountain northeast of Castle Stone."
	end
end

evt.hint[105] = evt.str[3]  -- "Drink from Fountain"
evt.map[105] = function()
	if evt.Cmp("MightBonus", 30) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("MightBonus", 30)
		evt.StatusText(7)         -- "+30 Might temporary."
		evt.Set("AutonotesBits", 35)         -- "30 Points of temporary might from the fountain west of Castle Birka."
	end
end

evt.hint[106] = evt.str[3]  -- "Drink from Fountain"
evt.map[106] = function()
	if evt.Cmp("PlayerBits", 1) then
		evt.Set("Dead", 0)
	else
		evt.Set("PlayerBits", 1)
		evt.Add("BaseMight", 5)
		evt.Set("Dead", 0)
		evt.StatusText(8)         -- "+5 Might permanent."
		evt.Set("AutonotesBits", 36)         -- "5 Points of permanent might from the north fountain east of Jorgsborg Temple."
	end
end

evt.hint[107] = evt.str[3]  -- "Drink from Fountain"
evt.map[107] = function()
	if evt.Cmp("PlayerBits", 2) then
		evt.Set("Dead", 0)
	else
		evt.Set("PlayerBits", 2)
		evt.Add("BaseEndurance", 5)
		evt.Set("Dead", 0)
		evt.StatusText(9)         -- "+5 Endurance permanent."
		evt.Set("AutonotesBits", 37)         -- "5 Points of permanent endurance from the south fountain east of Jorgsborg Temple."
	end
end

evt.map[209] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 161) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = -6606, FromY = 15546, FromZ = 2550, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[209].last, 5*const.Minute)

evt.map[210] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 161) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 161)         -- NPC
			evt.SetTextureOutdoors{Model = 114, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.map[211] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 228) then         -- NPC
		evt.SetSnow{EffectId = 0, On = true}
	end
end

events.LoadMap = evt.map[211].last

evt.hint[213] = evt.str[17]  -- "Obelisk"
evt.map[213] = function()
	evt.SetMessage(16)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _a,uef;re_oottg_l"
	evt.SimpleMessage()
	evt.Set("QBits", 366)         -- NPC
	evt.Set("AutonotesBits", 85)         -- "Obelisk Message # 7:  _a,uef;re_oottg_l"
end

evt.map[214] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 161) then         -- NPC
		evt.SetTextureOutdoors{Model = 114, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[214].last

evt.hint[261] = evt.str[12]  -- "Shrine of Accuracy"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 4) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 210) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseAccuracy", 3)
				evt.StatusText(15)         -- "+3 Accuracy permanent"
			else
				evt.Set("QBits", 210)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseAccuracy", 10)
				evt.StatusText(14)         -- "+10 Accuracy permanent"
			end
			return
		end
	end
	evt.StatusText(13)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 487) then         -- Demonclaw Reload
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = -4725, Y = 15551, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -3735, Y = 16118, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -7467, Y = 18362, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = -10662, Y = 13523, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 6283, Y = 17094, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = 10328, Y = 22523, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 5, X = 7978, Y = 21373, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = 12506, Y = -3215, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = 21291, Y = -1044, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 18936, Y = -3352, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 7, X = 8520, Y = 3859, Z = 2805}
		if not evt.Cmp("QBits", 508) then         -- Warrior
			evt.Set("QBits", 487)         -- Demonclaw Reload
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 12441, Y = -2439, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 20828, Y = -8961, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 16776, Y = -21566, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 10200, Y = 11400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -11349, Y = 17574, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -8253, Y = 15583, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -10548, Y = 15711, Z = 288}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -7717, Y = 12574, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -8888, Y = 17907, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5600, Y = 20403, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = 6460, Y = 15697, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -259, Y = 5153, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -5932, Y = 12049, Z = 97}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -13143, Y = 17068, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 12557, Y = -3827, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 20524, Y = -10570, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -8989, Y = 13803, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 5690, Y = 11714, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 18798, Y = -1443, Z = 0}
		evt.Set("QBits", 487)         -- Demonclaw Reload
	else
		evt.Set("QBits", 487)         -- Demonclaw Reload
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()  -- function events.LoadMap()
	if evt.Cmp("Awards", 3) then         -- "Saviors of Demonclaw"
		evt.MoveNPC{NPC = 354, HouseId = 510}         -- "Ray Boswell" -> "House"
		evt.MoveNPC{NPC = 353, HouseId = 509}         -- "Svarktel Jorgen" -> "House"
		evt.MoveNPC{NPC = 351, HouseId = 507}         -- "Abe Markoviac" -> "House"
		evt.MoveNPC{NPC = 352, HouseId = 508}         -- "Shel Stineway" -> "House"
		evt.MoveNPC{NPC = 36, HouseId = 274}         -- "Fredrick Piles" -> "House"
		evt.MoveNPC{NPC = 356, HouseId = 512}         -- "Marc Teagan" -> "House"
		evt.MoveNPC{NPC = 357, HouseId = 513}         -- "Harper Nike" -> "House"
		evt.MoveNPC{NPC = 359, HouseId = 515}         -- "Gerrold Dane" -> "House"
		evt.MoveNPC{NPC = 358, HouseId = 514}         -- "Trevor Jones" -> "House"
		evt.MoveNPC{NPC = 355, HouseId = 511}         -- "Sly Silverstone" -> "House"
		evt.MoveNPC{NPC = 278, HouseId = 278}         -- "Becky Holmes" -> "House"
		evt.MoveNPC{NPC = 360, HouseId = 516}         -- "Peace Stringer" -> "House"
		evt.MoveNPC{NPC = 96, HouseId = 273}         -- "Sure Valla" -> "House"
		evt.MoveNPC{NPC = 69, HouseId = 278}         -- "Warren Holmes" -> "House"
		evt.MoveNPC{NPC = 263, HouseId = 279}         -- "Rachel Herzl" -> "House"
		evt.MoveNPC{NPC = 282, HouseId = 279}         -- "Jennifer Herzl" -> "House"
	end
end

events.LoadMap = evt.map[263].last

evt.map[264] = function()  -- Timer(<function>, 95*const.Minute)
	if not evt.Cmp("QBits", 85) then         -- "Enter Castle Birka in Demonclaw and talk with Lord Godwinson."
		if not evt.Cmp("QBits", 485) then         -- LG 2nd Jorgsburg
			evt.Add("QBits", 86)         -- "Raise the siege of Birka and secure Jorgsburg."
		end
	end
end

Timer(evt.map[264].last, 95*const.Minute)

evt.map[265] = function()  -- Timer(<function>, 45*const.Minute)
	if evt.Cmp("QBits", 406) then         -- Birka Timer1
		evt.Add("QBits", 485)         -- LG 2nd Jorgsburg
	end
end

Timer(evt.map[265].last, 45*const.Minute)

