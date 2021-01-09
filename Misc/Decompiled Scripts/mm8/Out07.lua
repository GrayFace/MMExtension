local TXT = Localize{
	[0] = " ",
	[1] = "Murmurwoods",
	[2] = "",
	[3] = "Chest",
	[4] = "",
	[5] = "Well",
	[6] = "Drink from the well",
	[7] = "Fountain",
	[8] = "Drink from the fountain",
	[9] = "Refreshing",
	[10] = "That was not so refreshing",
	[11] = "",
	[12] = "pearswhil",
	[13] = "Statue",
	[14] = "",
	[15] = "The door is locked",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "Fruit Tree",
	[21] = "You receive an apple",
	[22] = "Berry Bush",
	[23] = "You receive some berries",
	[24] = "",
	[25] = "North",
	[26] = "West",
	[27] = "East",
	[28] = "South",
	[29] = "",
	[30] = "Shrine",
	[31] = "Altar",
	[32] = "You Pray",
	[33] = "Obelisk",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "Tree",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "The Temple of the Sun",
	[46] = "A Druid Circle",
	[47] = "Ancient Troll Home",
	[48] = "Gate to the Plane of Air",
	[49] = "",
	[50] = "Enter the Temple of the Sun",
	[51] = "Enter the Druid Circle",
	[52] = "Enter the Ancient Troll Home",
	[53] = "Enter the Plane of Air",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Personality +2 (Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(351)
Game.LoadSound(342)
Game.LoadSound(335)
Game.LoadSound(336)
Game.LoadSound(337)
Game.LoadSound(338)
Game.LoadSound(340)
Game.LoadSound(343)
Game.LoadSound(346)
Game.LoadSound(345)
Game.LoadSound(339)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 40) then         -- Found and Rescued Cauri Blackthorne
		evt.SetSprite{SpriteId = 20, Visible = 0, Name = "on"}
		evt.SetSprite{SpriteId = 21, Visible = 0, Name = "on"}
		evt.SetSprite{SpriteId = 22, Visible = 0, Name = "on"}
		evt.SetSprite{SpriteId = 23, Visible = 0, Name = "on"}
		evt.SetSprite{SpriteId = 24, Visible = 0, Name = "on"}
	end
	if not evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if not evt.Cmp("QBits", 230) then         -- You have Pissed off the clerics
			return
		end
	end
	evt.SetMonGroupBit{NPCGroup = 39, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 40, Bit = const.MonsterBits.Hostile, On = true}         -- ""
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 388)  -- "Ravensight Residence"
evt.house[12] = 388  -- "Ravensight Residence"
evt.HouseDoor(13, 389)  -- "Dreamwright Residence"
evt.house[14] = 389  -- "Dreamwright Residence"
evt.HouseDoor(15, 390)  -- "Snowtree Residence"
evt.house[16] = 390  -- "Snowtree Residence"
evt.HouseDoor(17, 391)  -- "Dantillion's Residence"
evt.house[18] = 391  -- "Dantillion's Residence"
evt.HouseDoor(19, 392)  -- "Mithrit Residence"
evt.house[20] = 392  -- "Mithrit Residence"
evt.HouseDoor(21, 393)  -- "Tonk Residence"
evt.house[22] = 393  -- "Tonk Residence"
evt.HouseDoor(23, 394)  -- "Keenedge Residence"
evt.house[24] = 394  -- "Keenedge Residence"
evt.HouseDoor(25, 395)  -- "Treasurestone Residence"
evt.house[26] = 395  -- "Treasurestone Residence"
evt.HouseDoor(27, 396)  -- "Sampson Residence"
evt.house[28] = 396  -- "Sampson Residence"
evt.HouseDoor(29, 482)  -- "Verish's House"
evt.house[30] = 482  -- "Verish's House"
evt.hint[81] = evt.str[3]  -- "Chest"
evt.map[81] = function()
	evt.OpenChest(0)
end

evt.hint[82] = evt.str[3]  -- "Chest"
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- "Chest"
evt.map[83] = function()
	evt.OpenChest(2)
end

evt.hint[84] = evt.str[3]  -- "Chest"
evt.map[84] = function()
	evt.OpenChest(3)
end

evt.hint[85] = evt.str[3]  -- "Chest"
evt.map[85] = function()
	evt.OpenChest(4)
end

evt.hint[86] = evt.str[3]  -- "Chest"
evt.map[86] = function()
	evt.OpenChest(5)
end

evt.hint[87] = evt.str[3]  -- "Chest"
evt.map[87] = function()
	evt.OpenChest(6)
end

evt.hint[88] = evt.str[3]  -- "Chest"
evt.map[88] = function()
	evt.OpenChest(7)
end

evt.hint[89] = evt.str[3]  -- "Chest"
evt.map[89] = function()
	evt.OpenChest(8)
end

evt.hint[90] = evt.str[3]  -- "Chest"
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- "Chest"
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[3]  -- "Chest"
evt.map[92] = function()
	evt.OpenChest(11)
end

evt.hint[93] = evt.str[3]  -- "Chest"
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[3]  -- "Chest"
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[3]  -- "Chest"
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[3]  -- "Chest"
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[3]  -- "Chest"
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[3]  -- "Chest"
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[3]  -- "Chest"
evt.map[99] = function()
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[3]  -- "Chest"
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.hint[101] = evt.str[6]  -- "Drink from the well"
evt.map[101] = function()
	evt.StatusText(10)         -- "That was not so refreshing"
	evt.Set("PoisonedYellow", 0)
	if not evt.Cmp("AutonotesBits", 263) then         -- "Well near the Temple of the Sun in the Murmurwoods is poison!"
		evt.Add("AutonotesBits", 263)         -- "Well near the Temple of the Sun in the Murmurwoods is poison!"
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if evt.Cmp("BasePersonality", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BasePersonality", 2)
		evt.StatusText(60)         -- "Personality +2 (Permanent)"
		evt.Add("AutonotesBits", 265)         -- "Well in the Ravage Roaming region gives a permanent Endurance bonus up to an Endurance of 16."
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()
	if not evt.Cmp("QBits", 69) then         -- Ancient Troll Homeland Found
		if evt.Cmp("QBits", 68) then         -- "Find the Ancient Troll Homeland and return to Volog Sandwind in the Ironsand Desert."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 0) then         -- "0"
				evt.Subtract("Inventory", 0)         -- "0"
				evt.Add("QBits", 69)         -- Ancient Troll Homeland Found
			end
		end
	end
end

evt.hint[132] = evt.str[13]  -- "Statue"
evt.map[132] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 339) then         -- "Stone to Flesh"
		evt.SpeakNPC(55)         -- "Cauri Blackthorne"
		evt.Add("QBits", 40)         -- Found and Rescued Cauri Blackthorne
		evt.Subtract("Inventory", 339)         -- "Stone to Flesh"
		evt.Add("QBits", 430)         -- Roster Character In Party 31
		evt.SetSprite{SpriteId = 20, Visible = 0, Name = "on"}
	end
end

evt.hint[133] = evt.str[13]  -- "Statue"
evt.map[133] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 339) then         -- "Stone to Flesh"
		evt.SpeakNPC(59)         -- "Dark Elf Pilgrim"
		evt.Subtract("Inventory", 339)         -- "Stone to Flesh"
		evt.SetSprite{SpriteId = 21, Visible = 0, Name = "on"}
	end
end

evt.hint[134] = evt.str[13]  -- "Statue"
evt.map[134] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 339) then         -- "Stone to Flesh"
		evt.SpeakNPC(59)         -- "Dark Elf Pilgrim"
		evt.Subtract("Inventory", 339)         -- "Stone to Flesh"
		evt.SetSprite{SpriteId = 22, Visible = 0, Name = "on"}
	end
end

evt.hint[135] = evt.str[13]  -- "Statue"
evt.map[135] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 339) then         -- "Stone to Flesh"
		evt.SpeakNPC(59)         -- "Dark Elf Pilgrim"
		evt.Subtract("Inventory", 339)         -- "Stone to Flesh"
		evt.SetSprite{SpriteId = 23, Visible = 0, Name = "on"}
	end
end

evt.hint[136] = evt.str[13]  -- "Statue"
evt.map[136] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 339) then         -- "Stone to Flesh"
		evt.SpeakNPC(59)         -- "Dark Elf Pilgrim"
		evt.Subtract("Inventory", 339)         -- "Stone to Flesh"
		evt.SetSprite{SpriteId = 24, Visible = 0, Name = "on"}
	end
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 192) then         -- Obelisk Area 7
		evt.StatusText(12)         -- "pearswhil"
		evt.Add("AutonotesBits", 22)         -- "Obelisk message #6: pearswhil"
		evt.Add("QBits", 192)         -- Obelisk Area 7
	end
end

evt.HouseDoor(191, 113)  -- "Traveler's Rest"
evt.house[192] = 113  -- "Traveler's Rest"
evt.HouseDoor(201, 142)  -- "Guild of Light"
evt.house[202] = 142  -- "Guild of Light"
evt.hint[401] = evt.str[45]  -- "The Temple of the Sun"
evt.hint[402] = evt.str[46]  -- "A Druid Circle"
evt.hint[403] = evt.str[47]  -- "Ancient Troll Home"
evt.hint[404] = evt.str[48]  -- "Gate to the Plane of Air"
evt.hint[450] = evt.str[5]  -- "Well"
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()  -- Timer(<function>, 15*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 351, X = 14784, Y = 10304}
	elseif i == 2 then
		evt.PlaySound{Id = 351, X = 17152, Y = 5440}
	elseif i == 3 then
		evt.PlaySound{Id = 351, X = -5696, Y = 7040}
	elseif i == 4 then
		evt.PlaySound{Id = 351, X = -17920, Y = 15360}
	elseif i == 5 then
		evt.PlaySound{Id = 351, X = -16256, Y = -576}
	else
		evt.PlaySound{Id = 351, X = -2880, Y = -5248}
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 342, X = 16448, Y = 15340}
	elseif i == 2 then
		evt.PlaySound{Id = 335, X = 11200, Y = 15040}
	elseif i == 3 then
		evt.PlaySound{Id = 336, X = 1440, Y = 6016}
	elseif i == 4 then
		evt.PlaySound{Id = 337, X = 9728, Y = -3584}
	elseif i == 5 then
		evt.PlaySound{Id = 338, X = 5568, Y = -12224}
	else
		evt.PlaySound{Id = 340, X = 18048, Y = -11968}
	end
end

Timer(evt.map[451].last, 15*const.Minute)

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()  -- Timer(<function>, 12.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 343, X = -11392, Y = 13248}
	elseif i == 2 then
		evt.PlaySound{Id = 342, X = -7744, Y = -4992}
	elseif i == 3 then
		evt.PlaySound{Id = 346, X = -16512, Y = -2048}
	elseif i == 4 then
		evt.PlaySound{Id = 345, X = -11456, Y = 10112}
	elseif i == 5 then
		evt.PlaySound{Id = 339, X = -19136, Y = 16000}
	else
		evt.PlaySound{Id = 340, X = -4160, Y = -19840}
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 340, X = 4672, Y = 18176}
	elseif i == 2 then
		evt.PlaySound{Id = 335, X = -4096, Y = -12736}
	elseif i == 3 then
		evt.PlaySound{Id = 336, X = -2816, Y = -9088}
	elseif i == 4 then
		evt.PlaySound{Id = 337, X = 320, Y = -12352}
	elseif i == 5 then
		evt.PlaySound{Id = 338, X = -896, Y = 14976}
	else
		evt.PlaySound{Id = 339, X = 15552, Y = 13568}
	end
end

Timer(evt.map[452].last, 12.5*const.Minute)

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	if not evt.Cmp("QBits", 240) then         -- for riki
		evt.Add("Inventory", 332)         -- "Lloyd's Beacon"
		evt.Add("QBits", 240)         -- for riki
	end
end

evt.hint[455] = evt.str[40]  -- "Tree"
evt.map[455] = function()
	local i
	if evt.Cmp("Inventory", 186) then         -- "Diamond"
		evt.Subtract("Inventory", 186)         -- "Diamond"
		evt.Add("Inventory", 656)         -- "Horseshoe"
	elseif evt.Cmp("Inventory", 185) then         -- "Ruby"
		evt.Subtract("Inventory", 185)         -- "Ruby"
		evt.Add("Inventory", 271)         -- "Rejuvenation"
	elseif evt.Cmp("Inventory", 184) then         -- "Sapphire"
		evt.Subtract("Inventory", 184)         -- "Sapphire"
		evt.Add("Gold", 2000)
	elseif evt.Cmp("Inventory", 183) then         -- "Emerald"
		evt.Subtract("Inventory", 183)         -- "Emerald"
		evt.Add("Inventory", 655)         -- "Green Apple"
	elseif evt.Cmp("Inventory", 182) then         -- "Topaz"
		evt.Subtract("Inventory", 182)         -- "Topaz"
		i = Game.Rand() % 5
		if i == 1 then
			evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
		elseif i == 2 then
			evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
		elseif i == 3 then
			evt.GiveItem{Strength = 3, Type = const.ItemType.Scroll_, Id = 0}
		elseif i == 4 then
			evt.GiveItem{Strength = 3, Type = const.ItemType.Ring_, Id = 0}
		else
			evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
		end
	elseif evt.Cmp("Inventory", 181) then         -- "Amethyst"
		evt.Subtract("Inventory", 181)         -- "Amethyst"
		evt.Add("Inventory", 183)         -- "Emerald"
	elseif evt.Cmp("Inventory", 180) then         -- "Amber"
		evt.Subtract("Inventory", 180)         -- "Amber"
		evt.Add("Inventory", 250)         -- "Swift Potion"
	elseif evt.Cmp("Inventory", 179) then         -- "Citrine"
		evt.Subtract("Inventory", 179)         -- "Citrine"
		evt.Add("Inventory", 181)         -- "Amethyst"
	elseif evt.Cmp("Inventory", 178) then         -- "Iolite"
		evt.Subtract("Inventory", 178)         -- "Iolite"
		evt.Add("Inventory", 132)         -- "Walking Boots"
	elseif evt.Cmp("Inventory", 177) then         -- "Zircon"
		evt.Subtract("Inventory", 177)         -- "Zircon"
		evt.Add("Inventory", 179)         -- "Citrine"
	end
end

evt.hint[501] = evt.str[50]  -- "Enter the Temple of the Sun"
evt.map[501] = function()
	evt.MoveToMap{X = -768, Y = -768, Z = 96, Direction = 280, LookAngle = 0, SpeedZ = 0, HouseId = 205, Icon = 1, Name = "d22.blv"}         -- "Temple of the Sun"
end

evt.hint[502] = evt.str[51]  -- "Enter the Druid Circle"
evt.map[502] = function()
	evt.MoveToMap{X = 235, Y = 2980, Z = 673, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 206, Icon = 3, Name = "d23.blv"}         -- "Abandoned Druid Circle"
end

evt.hint[503] = evt.str[53]  -- "Enter the Plane of Air"
evt.map[503] = function()
	evt.MoveToMap{X = 5376, Y = -12240, Z = 1133, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 222, Icon = 1, Name = "ElemA.odm"}         -- "Gateway to the Plane of Air"
end

evt.hint[504] = evt.str[52]  -- "Enter the Ancient Troll Home"
evt.map[504] = function()
	if not evt.Cmp("QBits", 69) then         -- Ancient Troll Homeland Found
		evt.Set("QBits", 69)         -- Ancient Troll Homeland Found
	end
	evt.MoveToMap{X = 448, Y = -224, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D43.blv"}
end

