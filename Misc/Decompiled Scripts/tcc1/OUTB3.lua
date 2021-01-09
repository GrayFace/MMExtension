local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "+10 Elemental resistance permanent.",
	[3] = "+10 Seven statistics permanent.",
	[4] = "+50 Hit points temporary.",
	[5] = "Refreshing!",
	[6] = "Chest",
	[7] = "+20 to all stats permanent.",
	[8] = "Baal's Garden",
	[9] = "Shrine of Magic",
	[10] = "You pray at the shrine.",
	[11] = "+10 Magic resistance permanent",
	[12] = "+3 Magic resistance permanent",
	[13] = "Pedestal",
	[14] = "\"The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            elroioeuuefo__ide",
	[15] = "Obelisk",
	[16] = "Shrine of the Gods",
	[17] = "rock",
	[18] = "You cannot enter at this time",
	[19] = "Nothing happens.",
	[20] = "Whom the gods bless, they first curse!",
	[21] = "Abrakadabra",
	[22] = "What is the 1st word of the incantation?",
	[23] = "Wrong, Moose Brains!",
	[24] = "What is the 2nd word of the incantation?",
	[25] = "What is the 3rd word of the incantation?",
	[26] = "What is the 4th word of the incantation?",
	[27] = "What is the 5th word of the incantation?",
	[28] = "What is the 6th word of the incantation?",
	[29] = "What is the last word of the incantation?",
	[30] = "Wam",
	[31] = "Allakhazam",
	[32] = "Bam",
	[33] = "Mam",
	[34] = "Thank",
	[35] = "you",
	[36] = "Correct!",
	[37] = "Correct!  You may now open the chest!",
	[38] = "The Danu Tree",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[8]  -- "Baal's Garden"
-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing
Game.LoadSound(14050)

evt.hint[1] = evt.str[17]  -- "rock"
evt.house[50] = 260  -- "House"
evt.map[50] = function()
	evt.EnterHouse(260)         -- "House"
end

evt.house[51] = 261  -- "House"
evt.map[51] = function()
	evt.EnterHouse(261)         -- "House"
end

evt.house[52] = 262  -- "House"
evt.map[52] = function()
	evt.EnterHouse(262)         -- "House"
end

evt.house[53] = 263  -- "House"
evt.map[53] = function()
	evt.EnterHouse(263)         -- "House"
end

evt.house[54] = 264  -- "House"
evt.map[54] = function()
	evt.EnterHouse(264)         -- "House"
end

evt.house[55] = 265  -- "House"
evt.map[55] = function()
	evt.EnterHouse(265)         -- "House"
end

evt.house[56] = 266  -- "Tent"
evt.map[56] = function()
	evt.EnterHouse(266)         -- "Tent"
end

evt.house[57] = 267  -- "Tent"
evt.map[57] = function()
	evt.EnterHouse(267)         -- "Tent"
end

evt.house[58] = 555  -- "Tent"
evt.map[58] = function()
	evt.EnterHouse(555)         -- "Tent"
end

evt.house[59] = 556  -- "Tent"
evt.map[59] = function()
	evt.EnterHouse(556)         -- "Tent"
end

evt.house[60] = 557  -- "Tent"
evt.map[60] = function()
	evt.EnterHouse(557)         -- "Tent"
end

evt.hint[75] = evt.str[6]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[6]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[6]  -- "Chest"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.hint[78] = evt.str[6]  -- "Chest"
evt.map[78] = function()
	evt.OpenChest(4)
end

evt.hint[79] = evt.str[6]  -- "Chest"
evt.map[79] = function()
	evt.OpenChest(5)
end

evt.map[90] = function()
	evt.StatusText(18)         -- "You cannot enter at this time"
end

evt.map[91] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE3.Odm"}
end

evt.map[92] = function()
	evt.StatusText(18)         -- "You cannot enter at this time"
end

evt.hint[100] = evt.str[1]  -- "Drink from Fountain"
evt.map[100] = function()
	if evt.Cmp("PlayerBits", 3) then
		evt.Set("Eradicated", 0)
	else
		evt.Add("FireResistance", 10)
		evt.Add("ElecResistance", 10)
		evt.Add("ColdResistance", 10)
		evt.Add("PoisonResistance", 10)
		evt.Set("PlayerBits", 3)
		evt.Set("Eradicated", 0)
		evt.StatusText(2)         -- "+10 Elemental resistance permanent."
		evt.Set("AutonotesBits", 38)         -- "10 Points of permanent fire, electricity, cold, and poison resistance from the fountain on the east island in Baal's Garden."
	end
end

evt.hint[101] = evt.str[1]  -- "Drink from Fountain"
evt.map[101] = function()
	if evt.Cmp("PlayerBits", 4) then
		evt.Set("Eradicated", 0)
	else
		evt.Add("BaseMight", 10)
		evt.Add("BaseIntellect", 10)
		evt.Add("BasePersonality", 10)
		evt.Add("BaseEndurance", 10)
		evt.Add("BaseSpeed", 10)
		evt.Add("BaseAccuracy", 10)
		evt.Add("BaseLuck", 10)
		evt.Set("PlayerBits", 4)
		evt.Set("Eradicated", 0)
		evt.StatusText(3)         -- "+10 Seven statistics permanent."
		evt.Set("AutonotesBits", 39)         -- "10 Points of permanent might, accuracy, speed, endurance, personality, intellect, and luck from the fountain on the south island in Baal's Garden."
	end
end

evt.hint[102] = evt.str[1]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("HP", 50)
		evt.StatusText(4)         -- "+50 Hit points temporary."
	else
		evt.StatusText(5)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 40)         -- "50 Hit points restored from fountain on the northwest island in Baal's Garden."
end

RefillTimer(function()
	evt.Set("MapVar0", 20)
end, const.Week, true)

evt.hint[103] = evt.str[16]  -- "Shrine of the Gods"
evt.map[103] = function()
	if not evt.Cmp("QBits", 438) then         -- Baal's Garden God's Bless/Curse
		evt.Set("QBits", 438)         -- Baal's Garden God's Bless/Curse
		evt.ForPlayer("All")
		evt.Set("Cursed", 0)
		evt.StatusText(20)         -- "Whom the gods bless, they first curse!"
	else
		if not evt.Cmp("QBits", 436) then         -- Shrine of Gods once
			evt.ForPlayer("All")
			evt.Add("FireResistance", 20)
			evt.Add("ElecResistance", 20)
			evt.Add("ColdResistance", 20)
			evt.Add("PoisonResistance", 20)
			evt.Add("MagicResistance", 20)
			evt.Add("BaseMight", 20)
			evt.Add("BaseIntellect", 20)
			evt.Add("BasePersonality", 20)
			evt.Add("BaseEndurance", 20)
			evt.Add("BaseSpeed", 20)
			evt.Add("BaseAccuracy", 20)
			evt.Add("BaseLuck", 20)
			evt.Set("QBits", 436)         -- Shrine of Gods once
			evt.Set("MainCondition", const.Condition.Cursed)
			evt.PlaySound{Id = 14050, X = 0, Y = 0}
			evt.StatusText(7)         -- "+20 to all stats permanent."
		end
	end
end

evt.hint[105] = evt.str[13]  -- "Pedestal"
evt.map[105] = function()
	if not evt.Cmp("Inventory", 453) then         -- "Statuette of Holy Cleansing"
		if not evt.Cmp("Inventory", 452) then         -- "Wolf Statuette"
			return
		end
		if not evt.Cmp("QBits", 225) then         -- NPC
			return
		end
		evt.Subtract("Inventory", 452)         -- "Wolf Statuette"
	else
		evt.Subtract("Inventory", 453)         -- "Statuette of Holy Cleansing"
	end
	evt.SetSprite{SpriteId = 321, Visible = 1, Name = "ped03"}
	evt.Set("QBits", 224)         -- NPC
	if evt.Cmp("QBits", 223) then         -- NPC
		if evt.Cmp("QBits", 222) then         -- NPC
			if evt.Cmp("QBits", 225) then         -- NPC
				if evt.Cmp("QBits", 226) then         -- NPC
					evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Jaana Barthold"
					evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Maikki Barthold" -> "Barthold Residence"
				end
			end
		end
	end
end

evt.map[106] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 224) then         -- NPC
		evt.SetSprite{SpriteId = 321, Visible = 1, Name = "ped03"}
	end
end

events.LoadMap = evt.map[106].last

evt.hint[107] = evt.str[15]  -- "Obelisk"
evt.map[107] = function()
	evt.SetMessage(14)         -- "\"The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            elroioeuuefo__ide"
	evt.SimpleMessage()
	evt.Set("QBits", 365)         -- NPC
	evt.Set("AutonotesBits", 84)         -- "Obelisk Message # 6:  elroioeuuefo__ide"
end

evt.hint[108] = evt.str[38]  -- "The Danu Tree"
evt.map[108] = function()
	if evt.Cmp("QBits", 435) then         -- Danu Chest Open
		if not evt.Cmp("QBits", 419) then         -- Danu Treasure Chest once
			evt.Add("QBits", 419)         -- Danu Treasure Chest once
			evt.Add("Awards", 55)         -- "Obtained the Treasures of Danu."
			evt.Subtract("QBits", 164)         -- "Solve the mystery of Danu’s Incantation and obtain the Treasure of Danu."
			evt.OpenChest(6)
		end
		return
	end
	if evt.Cmp("QBits", 434) then         -- Danu Answer 6
		if evt.Question{Question = 27, Answer1 = 34, Answer2 = 34} then         -- "What is the 5th word of the incantation?" ("Thank")
			evt.StatusText(37)         -- "Correct!  You may now open the chest!"
			evt.Add("QBits", 435)         -- Danu Chest Open
			return
		end
	else
		if evt.Cmp("QBits", 433) then         -- Danu Answer 5
			if evt.Question{Question = 26, Answer1 = 32, Answer2 = 32} then         -- "What is the 4th word of the incantation?" ("Bam")
				evt.StatusText(36)         -- "Correct!"
				evt.Add("QBits", 434)         -- Danu Answer 6
				return
			end
		else
			if evt.Cmp("QBits", 432) then         -- Danu Answer 4
				if evt.Question{Question = 28, Answer1 = 35, Answer2 = 35} then         -- "What is the 6th word of the incantation?" ("you")
					evt.StatusText(36)         -- "Correct!"
					evt.Add("QBits", 433)         -- Danu Answer 5
					return
				end
			else
				if evt.Cmp("QBits", 431) then         -- Danu Answer 3
					if evt.Question{Question = 25, Answer1 = 30, Answer2 = 30} then         -- "What is the 3rd word of the incantation?" ("Wam")
						evt.StatusText(36)         -- "Correct!"
						evt.Add("QBits", 432)         -- Danu Answer 4
						return
					end
				else
					if evt.Cmp("QBits", 430) then         -- Danu Answer 2
						if evt.Question{Question = 24, Answer1 = 31, Answer2 = 31} then         -- "What is the 2nd word of the incantation?" ("Allakhazam")
							evt.StatusText(36)         -- "Correct!"
							evt.Add("QBits", 431)         -- Danu Answer 3
							return
						end
					else
						if evt.Cmp("QBits", 429) then         -- Danu Answer 1
							if evt.Question{Question = 29, Answer1 = 33, Answer2 = 33} then         -- "What is the last word of the incantation?" ("Mam")
								evt.StatusText(36)         -- "Correct!"
								evt.Add("QBits", 430)         -- Danu Answer 2
								return
							end
						else
							if evt.Question{Question = 22, Answer1 = 21, Answer2 = 21} then         -- "What is the 1st word of the incantation?" ("Abrakadabra")
								evt.StatusText(36)         -- "Correct!"
								evt.Add("QBits", 429)         -- Danu Answer 1
								return
							end
						end
					end
				end
			end
		end
	end
	evt.Subtract("QBits", 435)         -- Danu Chest Open
	evt.Subtract("QBits", 434)         -- Danu Answer 6
	evt.Subtract("QBits", 433)         -- Danu Answer 5
	evt.Subtract("QBits", 432)         -- Danu Answer 4
	evt.Subtract("QBits", 431)         -- Danu Answer 3
	evt.Subtract("QBits", 430)         -- Danu Answer 2
	evt.Subtract("QBits", 429)         -- Danu Answer 1
	evt.StatusText(23)         -- "Wrong, Moose Brains!"
	evt.MoveToMap{X = 17525, Y = 13543, Z = 210, Direction = 1896, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[260] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 455) then         -- Baal's Garden Once
		evt.Set("QBits", 455)         -- Baal's Garden Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -12125, Y = 20923, Z = 288}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -12120, Y = 20920, Z = 288}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -12130, Y = 20928, Z = 288}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 5, X = -12015, Y = 22196, Z = 225}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -13068, Y = -5928, Z = 161}
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -11524, Y = 19742, Z = 226}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -12901, Y = 20232, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = -13612, Y = 16161, Z = 292}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -13760, Y = 13331, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -15871, Y = 11231, Z = 223}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -19186, Y = 1604, Z = 288}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -11425, Y = -7240, Z = 164}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -11757, Y = 19726, Z = 300}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -12033, Y = 18205, Z = 193}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -15138, Y = 7482, Z = 128}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -19139, Y = -3157, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -8503, Y = -13100, Z = 1745}
	end
end

events.LoadMap = evt.map[260].last

