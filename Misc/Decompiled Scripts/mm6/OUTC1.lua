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
	[11] = "Frozen Highlands",
	[12] = "Shrine of Endurance",
	[13] = "You pray at the shrine.",
	[14] = "+10 Endurance permanent",
	[15] = "+3 Endurance permanent",
	[16] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _ay,enis_nn_ans.",
	[17] = "Obelisk",
	[18] = "Castle Stromgard",
	[19] = "White Cap",
	[20] = "Rockham/Free Haven",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[11]  -- "Frozen Highlands"

evt.HouseDoor(2, 12)  -- "Mark and Missile"
evt.house[3] = 12  -- "Mark and Missile"
evt.HouseDoor(4, 27)  -- "Silver Lining Armor & Shield"
evt.house[5] = 27  -- "Silver Lining Armor & Shield"
evt.HouseDoor(6, 35)  -- "Apples, Thorns, and Potions"
evt.house[7] = 35  -- "Apples, Thorns, and Potions"
evt.HouseDoor(8, 46)  -- "General Store"
evt.house[9] = 46  -- "General Store"
evt.HouseDoor(10, 73)  -- "White Cap Temple"
evt.HouseDoor(11, 88)  -- "Riverside Academy"
evt.house[12] = 88  -- "Riverside Academy"
evt.HouseDoor(13, 108)  -- "The Frosty Tankard"
evt.house[14] = 108  -- "The Frosty Tankard"
evt.HouseDoor(15, 107)  -- "Rime and Reason"
evt.house[16] = 107  -- "Rime and Reason"
evt.HouseDoor(17, 117)  -- "Secure Trust"
evt.house[18] = 117  -- "Secure Trust"
evt.HouseDoor(19, 135)  -- "Initiate Guild of Dark"
evt.house[20] = 135  -- "Initiate Guild of Dark"
evt.HouseDoor(21, 138)  -- "Adept Guild of the Elements"
evt.house[22] = 138  -- "Adept Guild of the Elements"
evt.HouseDoor(23, 145)  -- "Blades' End"
evt.house[24] = 145  -- "Blades' End"
evt.HouseDoor(25, 149)  -- "Protection Services"
evt.house[26] = 149  -- "Protection Services"
evt.HouseDoor(27, 9)  -- "Haft and Handle Pole arms"
evt.house[28] = 9  -- "Haft and Handle Pole arms"
evt.HouseDoor(29, 23)  -- "Quality Armor"
evt.house[30] = 23  -- "Quality Armor"
evt.HouseDoor(31, 54)  -- "White Cap Transport Co."
evt.house[32] = 54  -- "White Cap Transport Co."
evt.house[33] = 160  -- "Throne Room"
evt.map[33] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 159, Icon = 2, Name = "0"}         -- "Castle Stone"
	evt.EnterHouse(160)         -- "Throne Room"
end

evt.house[34] = 164  -- "Throne Room"
evt.map[34] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 163, Icon = 2, Name = "0"}         -- "Castle Stromgard"
	evt.EnterHouse(164)         -- "Throne Room"
end

evt.hint[35] = evt.str[18]  -- "Castle Stromgard"
evt.map[35] = function()
	evt.StatusText(18)         -- "Castle Stromgard"
end

evt.hint[36] = evt.str[19]  -- "White Cap"
evt.map[36] = function()
	evt.StatusText(19)         -- "White Cap"
end

evt.hint[37] = evt.str[20]  -- "Rockham/Free Haven"
evt.map[37] = function()
	evt.StatusText(20)         -- "Rockham/Free Haven"
end

evt.HouseDoor(50, 268)  -- "House"
evt.HouseDoor(51, 269)  -- "House"
evt.HouseDoor(52, 270)  -- "House"
evt.HouseDoor(53, 271)  -- "House"
evt.HouseDoor(54, 272)  -- "House"
evt.HouseDoor(55, 273)  -- "House"
evt.HouseDoor(56, 274)  -- "House"
evt.HouseDoor(57, 275)  -- "House"
evt.HouseDoor(58, 276)  -- "House"
evt.HouseDoor(59, 277)  -- "House"
evt.HouseDoor(60, 278)  -- "House"
evt.HouseDoor(61, 279)  -- "House"
evt.HouseDoor(62, 280)  -- "House"
evt.HouseDoor(63, 281)  -- "House"
evt.HouseDoor(64, 282)  -- "House"
evt.HouseDoor(65, 499)  -- "House"
evt.HouseDoor(66, 500)  -- "House"
evt.HouseDoor(67, 501)  -- "House"
evt.HouseDoor(68, 502)  -- "House"
evt.HouseDoor(69, 503)  -- "House"
evt.HouseDoor(70, 504)  -- "House"
evt.HouseDoor(71, 505)  -- "House"
evt.HouseDoor(72, 506)  -- "House"
evt.HouseDoor(73, 507)  -- "House"
evt.HouseDoor(74, 508)  -- "House"
evt.HouseDoor(75, 509)  -- "House"
evt.HouseDoor(76, 510)  -- "House"
evt.HouseDoor(77, 511)  -- "House"
evt.HouseDoor(78, 512)  -- "House"
evt.HouseDoor(79, 513)  -- "House"
evt.HouseDoor(80, 514)  -- "House"
evt.HouseDoor(81, 515)  -- "House"
evt.HouseDoor(82, 516)  -- "House"
evt.HouseDoor(83, 517)  -- "House"
evt.HouseDoor(84, 518)  -- "House"
evt.map[85] = function()
	evt.OpenChest(1)
end

evt.map[86] = function()
	evt.OpenChest(2)
end

evt.house[90] = 178  -- "Shadow Guild"
evt.map[90] = function()
	evt.MoveToMap{X = 1408, Y = -1664, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 178, Icon = 5, Name = "D08.Blv"}         -- "Shadow Guild"
end

evt.house[91] = 185  -- "Icewind Keep"
evt.map[91] = function()
	evt.MoveToMap{X = -495, Y = -219, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 185, Icon = 5, Name = "D15.Blv"}         -- "Icewind Keep"
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
end, const.Month)

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
end, const.Month)

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
		evt.Set("AutonotesBits", 35)         -- "30 Points of temporary might from the fountain west of Castle Stromgard."
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
		evt.Set("AutonotesBits", 36)         -- "5 Points of permanent might from the north fountain east of White Cap Temple."
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
		evt.Set("AutonotesBits", 37)         -- "5 Points of permanent endurance from the south fountain east of White Cap Temple."
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
	evt.SetMessage(16)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _ay,enis_nn_ans."
	evt.SimpleMessage()
	evt.Set("QBits", 366)         -- NPC
	evt.Set("AutonotesBits", 85)         -- "Obelisk Message # 7:  _ay,enis_nn_ans."
end

evt.map[214] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 161) then         -- NPC
		evt.SetTextureOutdoors{Model = 114, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[214].last

evt.hint[261] = evt.str[12]  -- "Shrine of Endurance"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 3) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 210) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 3)
				evt.StatusText(15)         -- "+3 Endurance permanent"
			else
				evt.Set("QBits", 210)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 10)
				evt.StatusText(14)         -- "+10 Endurance permanent"
			end
			return
		end
	end
	evt.StatusText(13)         -- "You pray at the shrine."
end

