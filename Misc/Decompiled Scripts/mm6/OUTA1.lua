local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Well.",
	[2] = "Poison!",
	[3] = "Drink from Fountain",
	[4] = "+50 Seven Statistic temporary.",
	[5] = "Refreshing!",
	[6] = "Chest",
	[7] = "Sweet Water",
	[8] = "Pedestal",
	[9] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            Itotecthothesaip",
	[10] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Sweet Water"

evt.HouseDoor(204, 204)  -- "House"
evt.HouseDoor(205, 205)  -- "House"
evt.hint[75] = evt.str[6]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.house[90] = 203  -- "The Hive"
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
		evt.Set("AutonotesBits", 53)         -- "50 Points of temporary might, accuracy, endurance, speed, personality, intellect, and luck from the fountain southwest of the village of Sweet Water."
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
						evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Twillen"
						evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Twillen" -> "House"
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
	evt.SetMessage(9)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            Itotecthothesaip"
	evt.SimpleMessage()
	evt.Set("QBits", 360)         -- NPC
	evt.Set("AutonotesBits", 79)         -- "Obelisk Message # 1:  Itotecthothesaip"
end

