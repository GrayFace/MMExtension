local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Well.",
	[2] = "Poison!",
	[3] = "Drink from Fountain",
	[4] = "+50 Seven Statistic temporary.",
	[5] = "Refreshing!",
	[6] = "Chest",
	[7] = "Serenity",
	[8] = "Pedestal",
	[9] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           Itm_etortiaas_tler",
	[10] = "Obelisk",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[7]  -- "Serenity"
-- ERROR: evt.house[205] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing

evt.house[204] = 204  -- "House"
evt.map[204] = function()
	evt.EnterHouse(204)         -- "House"
end

evt.map[205] = function()
	evt.EnterHouse(205)         -- "House"
end

evt.hint[75] = evt.str[6]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.map[90] = function()
	if not evt.Cmp("QBits", 237) then         -- NPC
		evt.MoveToMap{X = 435, Y = 3707, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 203, Icon = 5, Name = "Hive.Blv"}         -- "The Hive"
	end
end

evt.hint[100] = evt.str[1]  -- "Drink from Well."
evt.map[100] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Cold, Damage = 200}
	evt.Set("PoisonedRed", 0)
	evt.StatusText(2)         -- "Poison!"
end

evt.hint[101] = evt.str[3]  -- "Drink from Fountain"
evt.map[101] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Cold, Damage = 200}
	evt.Set("PoisonedRed", 0)
	evt.StatusText(2)         -- "Poison!"
end

evt.hint[102] = evt.str[3]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("MightBonus", 50) then
		evt.StatusText(5)         -- "Refreshing!"
	else
		evt.Set("MightBonus", 50)
		evt.Set("IntellectBonus", 50)
		evt.Set("PersonalityBonus", 50)
		evt.Set("EnduranceBonus", 50)
		evt.Set("SpeedBonus", 50)
		evt.Set("AccuracyBonus", 50)
		evt.Set("LuckBonus", 50)
		evt.StatusText(4)         -- "+50 Seven Statistic temporary."
		evt.Set("AutonotesBits", 53)         -- "50 Points of temporary might, accuracy, endurance, speed, personality, intellect, and luck from the fountain southwest of the village of Glacier's End."
	end
end

evt.hint[103] = evt.str[8]  -- "Pedestal"
evt.map[103] = function()
	if evt.Cmp("Inventory", 450) then         -- "Tiger Statuette"
		evt.Subtract("Inventory", 450)         -- "Tiger Statuette"
		evt.SetSprite{SpriteId = 606, Visible = 1, Name = "ped02"}
		evt.Set("QBits", 222)         -- NPC
		if evt.Cmp("QBits", 223) then         -- NPC
			if evt.Cmp("QBits", 224) then         -- NPC
				if evt.Cmp("QBits", 225) then         -- NPC
					if evt.Cmp("QBits", 226) then         -- NPC
						evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Jaana Barthold"
						evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Maikki Barthold" -> "Barthold Residence"
					end
				end
			end
		end
	end
end

evt.map[104] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 222) then         -- NPC
		evt.SetSprite{SpriteId = 606, Visible = 1, Name = "ped02"}
	end
end

events.LoadMap = evt.map[104].last

evt.hint[210] = evt.str[10]  -- "Obelisk"
evt.map[210] = function()
	evt.SetMessage(9)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           Itm_etortiaas_tler"
	evt.SimpleMessage()
	evt.Set("QBits", 360)         -- NPC
	evt.Set("AutonotesBits", 79)         -- "Obelisk Message # 1:  Itm_etortiaas_tler"
end

evt.map[220] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 441) then         -- Glacier's End once
		evt.Set("QBits", 441)         -- Glacier's End once
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -14691, Y = 13433, Z = 3333}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -13590, Y = 15206, Z = 3840}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -16214, Y = 16990, Z = 3898}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -17052, Y = 14513, Z = 3884}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -15831, Y = 14846, Z = 3862}
	end
end

events.LoadMap = evt.map[220].last

evt.map[221] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 424) then         -- Drider Spwan Glacier's End QBIT once.
		if evt.Cmp("QBits", 134) then         -- "Enter the Drow Hive in Glacier’s End, find the Ether Jewel, and activate the Ether  Portal."
			evt.Add("QBits", 424)         -- Drider Spwan Glacier's End QBIT once.
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -9629, Y = 13740, Z = 428}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -8923, Y = 11797, Z = 398}
			if evt.Cmp("QBits", 508) then         -- Warrior
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -8194, Y = 16033, Z = 161}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -8437, Y = 18772, Z = 161}
				if evt.Cmp("QBits", 507) then         -- Death Wish
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -6821, Y = 17533, Z = 181}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -7862, Y = 16690, Z = 161}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -7482, Y = 11385, Z = 161}
					evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -7689, Y = 9128, Z = 163}
				end
			end
		end
	end
end

events.LoadMap = evt.map[221].last

