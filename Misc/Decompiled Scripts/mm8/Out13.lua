local TXT = Localize{
	[0] = " ",
	[1] = "Regna",
	[2] = "",
	[3] = "Chest",
	[4] = "",
	[5] = "Well",
	[6] = "Drink from the well",
	[7] = "Fountain",
	[8] = "Drink from the fountain",
	[9] = "Refreshing",
	[10] = "That was not so refreshing",
	[11] = "You hear a low rumbling noise",
	[12] = "gholdsold",
	[13] = "Fire the cannon !",
	[14] = "Door",
	[15] = "The door is locked",
	[16] = "Regnan Ship",
	[17] = "Sunk Regnan Ship",
	[18] = "You do not see the right kind of ammunition anywhere",
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
	[43] = "Tower",
	[44] = "Enter the Tower",
	[45] = "Pirate Stronghold",
	[46] = "Abandoned Pirate Keep",
	[47] = "Tunnel",
	[48] = "Small Sub Pen",
	[49] = "A Cave",
	[50] = "Enter the Pirate Stronghold",
	[51] = "Enter the Abandoned Pirate Keep",
	[52] = "Enter the Tunnel",
	[53] = "Enter the Small Sub Pen",
	[54] = "Enter the Cave",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Speed +2 (Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(473)
Game.LoadSound(472)
Game.LoadSound(351)
Game.LoadSound(336)
Game.LoadSound(338)

evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 423)  -- "Dragontracker Hall"
evt.house[12] = 423  -- "Dragontracker Hall"
evt.HouseDoor(13, 424)  -- "Nirses Loot"
evt.house[14] = 424  -- "Nirses Loot"
evt.HouseDoor(15, 425)  -- "Burnkindle's Spoils"
evt.house[16] = 425  -- "Burnkindle's Spoils"
evt.HouseDoor(17, 426)  -- "Cleareye Hall"
evt.house[18] = 426  -- "Cleareye Hall"
evt.HouseDoor(19, 427)  -- "Shadowrunner's Vault"
evt.house[20] = 427  -- "Shadowrunner's Vault"
evt.HouseDoor(21, 428)  -- "Lifter's Lockup"
evt.house[22] = 428  -- "Lifter's Lockup"
evt.HouseDoor(23, 429)  -- "Steelcoif Hall"
evt.house[24] = 429  -- "Steelcoif Hall"
evt.HouseDoor(25, 430)  -- "Jawblower Manor"
evt.house[26] = 430  -- "Jawblower Manor"
evt.HouseDoor(27, 431)  -- "Marmon Domicile"
evt.house[28] = 431  -- "Marmon Domicile"
evt.HouseDoor(29, 432)  -- "One-eye's Lair"
evt.house[30] = 432  -- "One-eye's Lair"
evt.HouseDoor(31, 433)  -- "Paul's Estate"
evt.house[32] = 433  -- "Paul's Estate"
evt.HouseDoor(33, 434)  -- "Terrence's Home"
evt.house[34] = 434  -- "Terrence's Home"
evt.HouseDoor(35, 435)  -- "Ferne Lair"
evt.house[36] = 435  -- "Ferne Lair"
evt.HouseDoor(37, 436)  -- "Pavel's Place"
evt.house[38] = 436  -- "Pavel's Place"
evt.HouseDoor(39, 437)  -- "Nalani's Hall"
evt.house[40] = 437  -- "Nalani's Hall"
evt.HouseDoor(41, 438)  -- "Mercer Domicile"
evt.house[42] = 438  -- "Mercer Domicile"
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
	if evt.Cmp("BaseSpeed", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseSpeed", 2)
		evt.StatusText(60)         -- "Speed +2 (Permanent)"
		evt.Add("AutonotesBits", 271)         -- "Well on the Island of Regna gives a permanent Speed bonus up to a Speed of 16."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[104] = evt.str[8]  -- "Drink from the fountain"
evt.map[104] = function()
	evt.StatusText(9)         -- "Refreshing"
	if not evt.Cmp("QBits", 183) then         -- Hareckburg Town Portal
		evt.Add("QBits", 183)         -- Hareckburg Town Portal
	end
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 194) then         -- Obelisk Area 13
		evt.StatusText(12)         -- "gholdsold"
		evt.Add("AutonotesBits", 18)         -- "Obelisk message #2: gholdsold"
		evt.Add("QBits", 194)         -- Obelisk Area 13
	end
end

evt.HouseDoor(171, 7)  -- "Custom Cutlass"
evt.house[172] = 7  -- "Custom Cutlass"
evt.HouseDoor(173, 21)  -- "Karr Battlegear"
evt.house[174] = 21  -- "Karr Battlegear"
evt.HouseDoor(175, 35)  -- "Gifts of Regna"
evt.house[176] = 35  -- "Gifts of Regna"
evt.HouseDoor(177, 46)  -- "Poultices and Cures"
evt.house[178] = 46  -- "Poultices and Cures"
evt.HouseDoor(179, 146)  -- "Protective Magic"
evt.house[180] = 146  -- "Protective Magic"
evt.HouseDoor(183, 68)  -- "Spindrift"
evt.house[184] = 68  -- "Spindrift"
evt.HouseDoor(185, 80)  -- "The Blessed Sea"
evt.house[186] = 80  -- "The Blessed Sea"
evt.HouseDoor(191, 115)  -- "Pirate's Rest"
evt.house[192] = 115  -- "Pirate's Rest"
evt.hint[401] = evt.str[45]  -- "Pirate Stronghold"
evt.hint[402] = evt.str[46]  -- "Abandoned Pirate Keep"
evt.hint[403] = evt.str[43]  -- "Tower"
evt.hint[404] = evt.str[48]  -- "Small Sub Pen"
evt.hint[405] = evt.str[49]  -- "A Cave"
evt.hint[406] = evt.str[16]  -- "Regnan Ship"
evt.hint[407] = evt.str[17]  -- "Sunk Regnan Ship"
evt.hint[449] = evt.str[7]  -- "Fountain"
evt.hint[450] = evt.str[5]  -- "Well"
evt.hint[451] = evt.str[13]  -- "Fire the cannon !"
evt.map[451] = function()
	if not evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 662) then         -- "Cannonball of Dominion"
			evt.Subtract("Inventory", 662)         -- "Cannonball of Dominion"
			evt.ForPlayer("Current")
			evt.StatusText(11)         -- "You hear a low rumbling noise"
			evt.Add("MapVar39", 1)
			evt.PlaySound{Id = 473, X = -12945, Y = 12015}
			evt.Subtract("QBits", 224)         -- Cannonball of Dominion - I lost it
			return
		end
	end
	evt.StatusText(18)         -- "You do not see the right kind of ammunition anywhere"
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()  -- Timer(<function>, 1*const.Minute)
	if not evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		if evt.Cmp("MapVar39", 3) then
			evt.Add("QBits", 37)         -- Regnan Pirate Fleet is sunk.
			evt.MoveNPC{NPC = 77, HouseId = 276}         -- "Derrin Delver" -> "Hostel"
			evt.MoveNPC{NPC = 24, HouseId = 277}         -- "Queen Catherine" -> "Hostel"
			evt.MoveNPC{NPC = 25, HouseId = 277}         -- "King Roland" -> "Hostel"
			evt.Add("History13", 0)
			evt.Set("MapVar39", 0)
			evt.SetFacetBit{Id = 31, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 31, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Invisible, On = true}
			evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Untouchable, On = true}
		elseif evt.Cmp("MapVar39", 2) then
			evt.Add("MapVar39", 1)
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -19692, FromY = 14204, FromZ = 4000, ToX = -19692, ToY = 14204, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -16984, FromY = 15783, FromZ = 4000, ToX = -16984, ToY = 15783, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -12333, FromY = 18364, FromZ = 4000, ToX = -12333, ToY = 18364, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -13102, FromY = 20346, FromZ = 4000, ToX = -13102, ToY = 20346, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -15489, FromY = 18406, FromZ = 4000, ToX = -15489, ToY = 18406, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -19300, FromY = 18374, FromZ = 4000, ToX = -19300, ToY = 18374, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -17229, FromY = 20297, FromZ = 4000, ToX = -17229, ToY = 20297, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -13235, FromY = 20616, FromZ = 4000, ToX = -13235, ToY = 20616, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -16787, FromY = 13839, FromZ = 4000, ToX = -16787, ToY = 13839, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -12748, FromY = 14383, FromZ = 4000, ToX = -12748, ToY = 14383, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 9, Mastery = const.GM, Skill = 3, FromX = -15107, FromY = 13092, FromZ = 4000, ToX = -15107, ToY = 13092, ToZ = 0}         -- "Meteor Shower"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -16984, FromY = 15783, FromZ = 4000, ToX = -16984, ToY = 15783, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -12333, FromY = 18364, FromZ = 4000, ToX = -12333, ToY = 18364, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -13102, FromY = 20346, FromZ = 4000, ToX = -13102, ToY = 20346, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -15489, FromY = 18406, FromZ = 4000, ToX = -15489, ToY = 18406, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -19300, FromY = 18374, FromZ = 4000, ToX = -19300, ToY = 18374, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -17229, FromY = 20297, FromZ = 4000, ToX = -17229, ToY = 20297, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 3, FromX = -13235, FromY = 20616, FromZ = 4000, ToX = -13235, ToY = 20616, ToZ = 0}         -- "Lightning Bolt"
			evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -15743, ToY = 15989, ToZ = 2731}         -- "Death Blossom"
			evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -12022, ToY = 19402, ToZ = 2728}         -- "Death Blossom"
			evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13168, ToY = 15608, ToZ = 2725}         -- "Death Blossom"
			evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -14622, ToY = 15778, ToZ = 2724}         -- "Death Blossom"
		elseif evt.Cmp("MapVar39", 1) then
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13740, ToZ = 2793}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13600, ToY = 13740, ToZ = 2793}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13250, ToY = 13740, ToZ = 2793}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13600, ToZ = 2793}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13820, ToZ = 3000}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13740, ToZ = 2250}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13800, ToZ = 2500}         -- "Fireball"
			evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13100, ToY = 13740, ToZ = 3000}         -- "Fireball"
			evt.Add("MapVar39", 1)
			evt.Jump{Direction = 1736, ZAngle = 256, Speed = 2000}
			evt.PlaySound{Id = 472, X = -13305, Y = 12958}
		end
	end
end

Timer(evt.map[452].last, 1*const.Minute)

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 3, FromX = -13312, FromY = 12864, FromZ = 2432, ToX = -13371, ToY = 13740, ToZ = 2793}         -- "Fireball"
end

evt.hint[454] = evt.str[40]  -- "Tree"
evt.map[454] = function()
	if not evt.Cmp("QBits", 285) then         -- Got the Tele scroll in area 13
		evt.Add("Inventory", 341)         -- "Telekinesis"
		evt.Add("QBits", 285)         -- Got the Tele scroll in area 13
	end
end

evt.hint[479] = evt.str[100]  -- ""
evt.map[479] = function()  -- Timer(<function>, 10*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 351, X = -11712, Y = -10784}
	elseif i == 2 then
		evt.PlaySound{Id = 351, X = 5568, Y = -16352}
	elseif i == 3 then
		evt.PlaySound{Id = 351, X = -1248, Y = 12480}
	elseif i == 4 then
		evt.PlaySound{Id = 336, X = -800, Y = -2432}
	elseif i == 5 then
		evt.PlaySound{Id = 338, X = 3704, Y = 1024}
	end
end

Timer(evt.map[479].last, 10*const.Minute)

evt.hint[490] = evt.str[14]  -- "Door"
evt.map[490] = function()
	evt.FaceAnimation{Player = "Current", Animation = 18}
	evt.StatusText(15)         -- "The door is locked"
end

evt.hint[494] = evt.str[40]  -- "Tree"
evt.map[494] = function()
	if evt.CheckItemsCount{MinItemIndex = 221, MaxItemIndex = 271, Count = 1} then         -- "Catalyst"..."Rejuvenation"
		evt.RemoveItems{MinItemIndex = 221, MaxItemIndex = 271, Count = 1}         -- "Catalyst"..."Rejuvenation"
		evt.Add("Inventory", 220)         -- "Potion Bottle"
	end
end

evt.hint[501] = evt.str[50]  -- "Enter the Pirate Stronghold"
evt.map[501] = function()
	evt.MoveToMap{X = -554, Y = 3682, Z = 1, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 209, Icon = 1, Name = "D31.blv"}         -- "Pirate Stronghold"
end

evt.hint[502] = evt.str[51]  -- "Enter the Abandoned Pirate Keep"
evt.map[502] = function()
	evt.MoveToMap{X = -6520, Y = -6512, Z = 129, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 210, Icon = 1, Name = "d32.blv"}         -- "Abandoned Pirate Keep"
end

evt.hint[503] = evt.str[44]  -- "Enter the Tower"
evt.map[503] = function()
	if evt.Cmp("QBits", 197) then         -- Door to the passage under regna from the northern watch tower is unlocked
		evt.MoveToMap{X = 5892, Y = 4632, Z = 1853, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d33.blv"}
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[504] = evt.str[54]  -- "Enter the Cave"
evt.map[504] = function()
	evt.MoveToMap{X = -28, Y = -193, Z = 57, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 211, Icon = 3, Name = "d34.blv"}         -- "Small Sub Pen"
end

evt.hint[505] = evt.str[54]  -- "Enter the Cave"
evt.map[505] = function()
	evt.MoveToMap{X = 1328, Y = -1576, Z = 4, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D47.blv"}
end

evt.hint[506] = evt.str[44]  -- "Enter the Tower"
evt.map[506] = function()
	if evt.Cmp("QBits", 198) then         -- Door to the passage under regna from the southern watch tower is unlocked
		evt.MoveToMap{X = 1926, Y = -7682, Z = 1572, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d33.blv"}
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

