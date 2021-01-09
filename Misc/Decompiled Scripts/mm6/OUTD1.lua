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
	[12] = "Silver Cove",
	[13] = "Shrine of Personality",
	[14] = "You pray at the shrine.",
	[15] = "+10 Personality permanent",
	[16] = "+3 Personality permanent",
	[17] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            nnaifnt_ieif_tu_",
	[18] = "Obelisk",
	[19] = "Castle Stone",
	[20] = "Silver Cove",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[12]  -- "Silver Cove"

evt.HouseDoor(2, 10)  -- "Abdul's Discount Weapons"
evt.house[3] = 10  -- "Abdul's Discount Weapons"
evt.HouseDoor(4, 22)  -- "Abdul's Discount Armor"
evt.house[5] = 22  -- "Abdul's Discount Armor"
evt.HouseDoor(6, 32)  -- "Abdul's Discount Magic Supplies"
evt.house[7] = 32  -- "Abdul's Discount Magic Supplies"
evt.HouseDoor(8, 44)  -- "Trader Joe's"
evt.house[9] = 44  -- "Trader Joe's"
evt.HouseDoor(10, 53)  -- "Abdul's Discount Travel"
evt.house[11] = 53  -- "Abdul's Discount Travel"
evt.HouseDoor(12, 61)  -- "Cerulean Skies"
evt.HouseDoor(13, 75)  -- "Silver Cove Temple"
evt.HouseDoor(14, 81)  -- "Abdul's Discount Training Center"
evt.house[15] = 81  -- "Abdul's Discount Training Center"
evt.HouseDoor(16, 91)  -- "Town Hall"
evt.HouseDoor(17, 100)  -- "Anchors Away"
evt.house[18] = 100  -- "Anchors Away"
evt.HouseDoor(19, 101)  -- "The Grove"
evt.house[20] = 101  -- "The Grove"
evt.HouseDoor(21, 115)  -- "The First Bank of Enroth"
evt.house[22] = 115  -- "The First Bank of Enroth"
evt.HouseDoor(23, 125)  -- "Initiate Guild of Earth"
evt.house[24] = 125  -- "Initiate Guild of Earth"
evt.HouseDoor(25, 133)  -- "Initiate Guild of Light"
evt.house[26] = 133  -- "Initiate Guild of Light"
evt.HouseDoor(27, 140)  -- "Adept Guild of the Self"
evt.hint[28] = evt.str[140]
evt.HouseDoor(29, 143)  -- "Berserkers' Fury"
evt.house[30] = 143  -- "Berserkers' Fury"
evt.HouseDoor(31, 150)  -- "Protection Services"
evt.HouseDoor(32, 63)  -- "Barracuda"
evt.HouseDoor(33, 166)  -- "Circus"
evt.house[34] = 162  -- "Throne Room"
evt.map[34] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 161, Icon = 2, Name = "0"}         -- "Castle Fleise"
	evt.EnterHouse(162)         -- "Throne Room"
end

evt.hint[35] = evt.str[19]  -- "Castle Stone"
evt.map[35] = function()
	evt.StatusText(19)         -- "Castle Stone"
end

evt.hint[36] = evt.str[20]  -- "Silver Cove"
evt.map[36] = function()
	evt.StatusText(20)         -- "Silver Cove"
end

evt.HouseDoor(50, 366)  -- "House"
evt.HouseDoor(51, 367)  -- "House"
evt.HouseDoor(52, 368)  -- "House"
evt.HouseDoor(53, 369)  -- "House"
evt.HouseDoor(54, 370)  -- "House"
evt.HouseDoor(55, 371)  -- "House"
evt.HouseDoor(56, 372)  -- "House"
evt.HouseDoor(57, 373)  -- "House"
evt.HouseDoor(58, 374)  -- "House"
evt.HouseDoor(59, 375)  -- "House"
evt.HouseDoor(60, 376)  -- "House"
evt.HouseDoor(61, 377)  -- "House"
evt.HouseDoor(62, 378)  -- "House"
evt.HouseDoor(63, 379)  -- "House"
evt.HouseDoor(64, 380)  -- "House"
evt.HouseDoor(65, 381)  -- "House"
evt.HouseDoor(66, 382)  -- "House"
evt.HouseDoor(67, 383)  -- "House"
evt.HouseDoor(68, 384)  -- "House"
evt.HouseDoor(69, 385)  -- "House"
evt.HouseDoor(70, 386)  -- "House"
evt.HouseDoor(71, 387)  -- "House"
evt.HouseDoor(72, 388)  -- "House"
evt.HouseDoor(73, 389)  -- "House"
evt.HouseDoor(74, 390)  -- "House"
evt.HouseDoor(75, 391)  -- "House"
evt.HouseDoor(76, 392)  -- "House"
evt.HouseDoor(77, 393)  -- "House"
evt.HouseDoor(78, 394)  -- "House"
evt.HouseDoor(79, 395)  -- "House"
evt.HouseDoor(80, 396)  -- "House"
evt.HouseDoor(81, 397)  -- "House"
evt.HouseDoor(82, 398)  -- "House"
evt.HouseDoor(83, 399)  -- "House"
evt.HouseDoor(84, 400)  -- "House"
evt.HouseDoor(85, 401)  -- "House"
evt.HouseDoor(86, 402)  -- "House"
evt.HouseDoor(87, 403)  -- "House"
evt.HouseDoor(88, 404)  -- "House"
evt.HouseDoor(89, 405)  -- "House"
evt.HouseDoor(90, 406)  -- "House"
evt.HouseDoor(91, 407)  -- "House"
evt.HouseDoor(92, 408)  -- "House"
evt.HouseDoor(93, 409)  -- "House"
evt.HouseDoor(94, 410)  -- "House"
evt.HouseDoor(95, 411)  -- "House"
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

evt.house[150] = 182  -- "Silver Helm Stronghold"
evt.map[150] = function()
	evt.MoveToMap{X = -127, Y = 4190, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 182, Icon = 5, Name = "D12.Blv"}         -- "Silver Helm Stronghold"
end

evt.house[151] = 183  -- "The Monolith"
evt.map[151] = function()
	evt.MoveToMap{X = -128, Y = -3968, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 183, Icon = 5, Name = "D13.Blv"}         -- "The Monolith"
end

evt.house[152] = 186  -- "Warlord's Fortress"
evt.map[152] = function()
	evt.MoveToMap{X = -4724, Y = 1494, Z = 127, Direction = 1920, LookAngle = 0, SpeedZ = 0, HouseId = 186, Icon = 5, Name = "D16.Blv"}         -- "Warlord's Fortress"
end

evt.hint[161] = evt.str[4]  -- "Drink from Well."
evt.map[161] = function()
	if evt.Cmp("IntellectBonus", 20) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Set("IntellectBonus", 20)
		evt.Set("PersonalityBonus", 20)
		evt.StatusText(5)         -- "+20 Intellect and Personality temporary."
		evt.Set("AutonotesBits", 25)         -- "20 Points of temporary intellect and personality from the fountain in the north side of Silver Cove."
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
	evt.Set("AutonotesBits", 26)         -- "25 Spell points restored by the fountain outside of Town Hall in Silver Cove."
end

RefillTimer(function()
	evt.Set("MapVar0", 20)
end, const.Day)

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
			evt.Add("BaseAccuracy", 2)
			evt.StatusText(9)         -- "+2 Accuracy permanent."
			evt.Set("AutonotesBits", 27)         -- "2 Points of permanent accuracy from the north fountain west of Silver Cove."
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar1", 8)
end, const.Month)

evt.hint[165] = evt.str[6]  -- "Drink from Fountain"
evt.map[165] = function()
	if not evt.Cmp("BaseSpeed", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BaseSpeed", 2)
			evt.StatusText(10)         -- "+2 Speed permanent."
			evt.Set("AutonotesBits", 28)         -- "2 Points of permanent speed from the south fountain west of Silver Cove."
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar2", 8)
end, const.Month)

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
evt.map[211] = function()
	if evt.Cmp("QBits", 173) then         -- NPC
		return
	end
	if not evt.Cmp("DayOfYearIs", 76) then
		if not evt.Cmp("DayOfYearIs", 161) then
			if not evt.Cmp("DayOfYearIs", 247) then
				if not evt.Cmp("DayOfYearIs", 329) then
					return
				end
			end
		end
	end
	if evt.Cmp("QBits", 118) then         -- "Visit the Altar of the Sun in the circle of stones north of Silver Cove on an equinox or solstice (HINT:  March 20th is an equinox)."
		evt.SpeakNPC(305)         -- "Loretta Fleise"
	end
end

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
			evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 4}         -- "Champion Sword"
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
			evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 5}         -- "Lionheart Sword"
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
			evt.GiveItem{Strength = 6, Type = const.ItemType.Sword, Id = 8}         -- "Heroic Sword"
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
	evt.SetMessage(17)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            nnaifnt_ieif_tu_"
	evt.SimpleMessage()
	evt.Set("QBits", 369)         -- NPC
	evt.Set("AutonotesBits", 88)         -- "Obelisk Message # 10: nnaifnt_ieif_tu_"
end

evt.map[226] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 158) then         -- NPC
		evt.SetTextureOutdoors{Model = 117, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[226].last

evt.hint[261] = evt.str[13]  -- "Shrine of Personality"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 2) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 209) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BasePersonality", 3)
				evt.StatusText(16)         -- "+3 Personality permanent"
			else
				evt.Set("QBits", 209)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BasePersonality", 10)
				evt.StatusText(15)         -- "+10 Personality permanent"
			end
			return
		end
	end
	evt.StatusText(14)         -- "You pray at the shrine."
end

