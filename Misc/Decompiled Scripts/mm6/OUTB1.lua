local TXT = Localize{
	[0] = " ",
	[1] = "Demon Lair",
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
	[12] = "You are not a follower of Baa.  Begone!",
	[13] = "Kriegspire",
	[14] = "Shrine of Cold",
	[15] = "You pray at the shrine.",
	[16] = "+10 Cold resistance permanent",
	[17] = "+3 Cold resistance permanent",
	[18] = "Pedestal",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            t_haat_lt__en_lc",
	[20] = "Obelisk",
	[21] = "Shrine of Fire",
	[22] = "You pray at the shrine.",
	[23] = "+10 Fire permanent",
	[24] = "+3 Fire permanent",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Kriegspire"

evt.HouseDoor(2, 14)  -- "Knight's Paradise"
evt.house[3] = 14  -- "Knight's Paradise"
evt.HouseDoor(4, 26)  -- "Armorworks "
evt.house[5] = 26  -- "Armorworks "
evt.HouseDoor(6, 36)  -- "Unusual Enchantments"
evt.house[7] = 36  -- "Unusual Enchantments"
evt.HouseDoor(8, 55)  -- "King's Highway"
evt.house[9] = 55  -- "King's Highway"
evt.HouseDoor(10, 87)  -- "Lone Tree Training"
evt.house[11] = 87  -- "Lone Tree Training"
evt.HouseDoor(12, 111)  -- "The Broken Promise"
evt.house[13] = 111  -- "The Broken Promise"
evt.HouseDoor(14, 552)  -- "Hermit's Hut"
evt.HouseDoor(40, 235)  -- "House"
evt.HouseDoor(41, 236)  -- "House"
evt.HouseDoor(42, 237)  -- "House"
evt.HouseDoor(43, 238)  -- "House"
evt.HouseDoor(50, 239)  -- "House"
evt.HouseDoor(51, 240)  -- "House"
evt.HouseDoor(52, 241)  -- "House"
evt.HouseDoor(53, 242)  -- "House"
evt.HouseDoor(54, 243)  -- "House"
evt.HouseDoor(55, 244)  -- "House"
evt.HouseDoor(56, 245)  -- "House"
evt.HouseDoor(57, 246)  -- "House"
evt.HouseDoor(58, 541)  -- "House"
evt.HouseDoor(59, 542)  -- "House"
evt.HouseDoor(60, 543)  -- "House"
evt.HouseDoor(61, 544)  -- "House"
evt.HouseDoor(62, 545)  -- "House"
evt.HouseDoor(63, 546)  -- "House"
evt.HouseDoor(64, 547)  -- "House"
evt.HouseDoor(65, 548)  -- "House"
evt.hint[75] = evt.str[11]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[11]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.house[90] = 197  -- "Superior Temple of Baa"
evt.map[90] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 485) then         -- "Cloak of Baa"
		evt.MoveToMap{X = 2094, Y = -19, Z = 177, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 197, Icon = 5, Name = "T7.Blv"}         -- "Superior Temple of Baa"
	else
		evt.StatusText(12)         -- "You are not a follower of Baa.  Begone!"
	end
end

evt.house[91] = 189  -- "Agar's Laboratory"
evt.map[91] = function()
	evt.MoveToMap{X = 2702, Y = -2926, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 189, Icon = 5, Name = "D19.Blv"}         -- "Agar's Laboratory"
end

evt.house[92] = 190  -- "Caves of the Dragon Riders"
evt.map[92] = function()
	evt.MoveToMap{X = -49, Y = -42, Z = -2, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 190, Icon = 5, Name = "D20.Blv"}         -- "Caves of the Dragon Riders"
end

evt.house[93] = 201  -- "Castle Kriegspire"
evt.map[93] = function()
	evt.MoveToMap{X = 5861, Y = 2720, Z = 169, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 201, Icon = 5, Name = "CD3.Blv"}         -- "Castle Kriegspire"
end

evt.hint[94] = evt.str[1]  -- "Demon Lair"
evt.map[94] = function()
	evt.MoveToMap{X = 1893, Y = 122, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 5, Name = "ZDwj02.Blv"}
end

evt.hint[100] = evt.str[2]  -- "Drink from Well."
evt.map[100] = function()
	evt.StatusText(3)         -- "You feel Strange."
	evt.MoveToMap{X = 12768, Y = 4192, Z = 512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "CD3.Blv"}
end

evt.hint[101] = evt.str[2]  -- "Drink from Well."
evt.map[101] = function()
	if evt.Cmp("MapVar0", 1) then
		if evt.Cmp("Gold", 5000) then
			evt.Subtract("Gold", 5000)
			evt.Add("Experience", 5000)
			evt.Subtract("MapVar0", 1)
			evt.StatusText(4)         -- "+5000 Experience, -5000 Gold."
			evt.Set("AutonotesBits", 46)         -- "5000 Experience and minus 5000 gold from the southern well in the town of Kriegspire."
			return
		end
	end
	evt.StatusText(10)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar0", 10)
end, const.Day)

evt.hint[102] = evt.str[2]  -- "Drink from Well."
evt.map[102] = function()
	if evt.Cmp("LevelBonus", 30) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("LevelBonus", 30)
		evt.StatusText(5)         -- "+30 Level temporary.  Look Out!"
		evt.Set("AutonotesBits", 47)         -- "30 Temporary levels from the western well in the town of Kriegspire."
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -13280, Y = 19696, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -13368, Y = 18096, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -10976, Y = 18152, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9992, Y = 19056, Z = 160}
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from Fountain"
evt.map[103] = function()
	if evt.Cmp("PlayerBits", 8) then
		evt.Set("Eradicated", 0)
	else
		evt.Set("PlayerBits", 8)
		evt.Add("MagicResistance", 10)
		evt.Set("Eradicated", 0)
		evt.StatusText(7)         -- "+10 Magic resistance permanent."
		evt.Set("AutonotesBits", 48)         -- "10 Points of permanent magic resistance from the fountain north of the Dragon Tower in the town of Kriegspire."
	end
end

evt.hint[104] = evt.str[6]  -- "Drink from Fountain"
evt.map[104] = function()
	if evt.Cmp("ArmorClassBonus", 40) then
		evt.StatusText(10)         -- "Refreshing!"
	else
		evt.Set("ArmorClassBonus", 40)
		evt.StatusText(8)         -- "+40 Armor class temporary."
		evt.Set("AutonotesBits", 49)         -- "40 Points of temporary armor class from the fountain outside of Castle Kriegspire."
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

evt.hint[261] = evt.str[14]  -- "Shrine of Cold"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 9) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 216) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("ColdResistance", 3)
				evt.StatusText(17)         -- "+3 Cold resistance permanent"
			else
				evt.Set("QBits", 216)         -- NPC
				evt.ForPlayer("All")
				evt.Add("ColdResistance", 10)
				evt.StatusText(16)         -- "+10 Cold resistance permanent"
			end
			return
		end
	end
	evt.StatusText(15)         -- "You pray at the shrine."
end

evt.hint[262] = evt.str[21]  -- "Shrine of Fire"
evt.map[262] = function()
	if evt.Cmp("MonthIs", 7) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 214) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("FireResistance", 3)
				evt.StatusText(24)         -- "+3 Fire permanent"
			else
				evt.Set("QBits", 214)         -- NPC
				evt.ForPlayer("All")
				evt.Add("FireResistance", 10)
				evt.StatusText(23)         -- "+10 Fire permanent"
			end
			return
		end
	end
	evt.StatusText(22)         -- "You pray at the shrine."
end

evt.hint[150] = evt.str[18]  -- "Pedestal"
evt.map[150] = function()
	if evt.Cmp("Inventory", 451) then         -- "Bear Statuette"
		evt.Subtract("Inventory", 451)         -- "Bear Statuette"
		evt.SetSprite{SpriteId = 141, Visible = 1, Name = "ped01"}
		evt.Set("QBits", 223)         -- NPC
		if evt.Cmp("QBits", 222) then         -- NPC
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

evt.map[151] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 223) then         -- NPC
		evt.SetSprite{SpriteId = 141, Visible = 1, Name = "ped01"}
	end
end

events.LoadMap = evt.map[151].last

evt.hint[152] = evt.str[20]  -- "Obelisk"
evt.map[152] = function()
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            t_haat_lt__en_lc"
	evt.SimpleMessage()
	evt.Set("QBits", 363)         -- NPC
	evt.Set("AutonotesBits", 82)         -- "Obelisk Message # 4:  t_haat_lt__en_lc"
end

