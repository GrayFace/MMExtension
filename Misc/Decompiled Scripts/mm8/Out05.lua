local TXT = Localize{
	[0] = " ",
	[1] = "Garrote Gorge",
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
	[12] = "theunicornkin",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "Tent",
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
	[41] = "Flowers",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "Dragon Hunter Camp",
	[46] = "Dragon Cave",
	[47] = "Naga Vault",
	[48] = "Grand Temple of Eep",
	[49] = "",
	[50] = "Enter the Dragon Hunter's Camp",
	[51] = "Enter the Dragon Cave",
	[52] = "Enter the Naga Vault",
	[53] = "Enter the Grand Temple of Eep",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Fire Resistance +2 (Permanent)",
	[61] = "Accuracy +2 (Permanent)",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "You have killed all of the Dragons",
	[71] = "You have killed all of the Dragon Hunters",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(325)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetMonGroupBit{NPCGroup = 22, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
		evt.SetMonGroupBit{NPCGroup = 23, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
		evt.SetMonGroupBit{NPCGroup = 24, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters at Training Camp"
	elseif evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.SetMonGroupBit{NPCGroup = 44, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.SetMonGroupBit{NPCGroup = 45, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	end
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
evt.HouseDoor(11, 316)  -- "Stormlance Residence"
evt.house[12] = 316  -- "Stormlance Residence"
evt.HouseDoor(13, 317)  -- "Morningstar Residence"
evt.house[14] = 317  -- "Morningstar Residence"
evt.HouseDoor(15, 318)  -- "Foestryke Residence"
evt.house[16] = 318  -- "Foestryke Residence"
evt.HouseDoor(17, 319)  -- "Ironfist Residence"
evt.house[18] = 319  -- "Ironfist Residence"
evt.HouseDoor(19, 340)  -- "Avalon's Residence"
evt.house[20] = 340  -- "Avalon's Residence"
evt.HouseDoor(21, 341)  -- "Arin Residence"
evt.house[22] = 341  -- "Arin Residence"
evt.HouseDoor(23, 342)  -- "Lightsworn Residence"
evt.house[24] = 342  -- "Lightsworn Residence"
evt.HouseDoor(25, 343)  -- "Otterton Residence"
evt.house[26] = 343  -- "Otterton Residence"
evt.HouseDoor(27, 344)  -- "Calandril's Residence"
evt.house[28] = 344  -- "Calandril's Residence"
evt.HouseDoor(29, 345)  -- "Maker Residence"
evt.house[30] = 345  -- "Maker Residence"
evt.HouseDoor(31, 346)  -- "Slayer Residence"
evt.house[32] = 346  -- "Slayer Residence"
evt.HouseDoor(33, 347)  -- "Kern Residence"
evt.house[34] = 347  -- "Kern Residence"
evt.HouseDoor(35, 348)  -- "Jeni Residence"
evt.house[36] = 348  -- "Jeni Residence"
evt.HouseDoor(37, 349)  -- "Weldrick's Home"
evt.house[38] = 349  -- "Weldrick's Home"
evt.HouseDoor(39, 480)  -- "Nelix's House"
evt.house[40] = 480  -- "Nelix's House"
evt.HouseDoor(41, 481)  -- "Tempus' House"
evt.house[42] = 481  -- "Tempus' House"
evt.HouseDoor(43, 320)  -- "Reaverston Residence"
evt.house[44] = 320  -- "Reaverston Residence"
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

evt.hint[91] = evt.str[41]  -- "Flowers"
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
	if not evt.Cmp("MapVar29", 2) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("BankGold", 99) then
				evt.Add("Gold", 200)
				evt.Add("MapVar29", 1)
				evt.Add("AutonotesBits", 256)         -- "Well at the Dragon Hunters Camp in Garrote Gorge gives 200 gold if the total gold on party and in the bank is less than 100."
				return
			end
		end
	end
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if evt.Cmp("FireResistance", 10) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("FireResistance", 2)
		evt.StatusText(60)         -- "Fire Resistance +2 (Permanent)"
		evt.Add("AutonotesBits", 257)         -- "Well at the Dragon Hunters Camp in Garrote Gorge gives a permanent Fire Resistance bonus up to a Fire Resistance of 10."
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	if evt.Cmp("BaseAccuracy", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseAccuracy", 2)
		evt.StatusText(61)         -- "Accuracy +2 (Permanent)"
		evt.Add("AutonotesBits", 258)         -- "Well at the Dragon Hunters Camp in Garrote Gorge gives a permanent Accuracy bonus up to an Accuracy of 16."
	end
end

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()  -- Timer(<function>, 10*const.Minute)
	if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		if not evt.Cmp("QBits", 155) then         -- Killed all Dragons in Garrote Gorge Area
			if evt.CheckMonstersKilled{CheckType = 2, Id = 189, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 190, Count = 0, InvisibleAsDead = 0} then
					if evt.CheckMonstersKilled{CheckType = 2, Id = 191, Count = 0, InvisibleAsDead = 0} then
						if evt.Cmp("QBits", 156) then         -- Questbit set for Riki
							evt.Set("QBits", 155)         -- Killed all Dragons in Garrote Gorge Area
							evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
							evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
							evt.StatusText(70)         -- "You have killed all of the Dragons"
						else
							evt.Set("QBits", 156)         -- Questbit set for Riki
							evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = -30272, Y = -16512, Z = 0, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
							evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
						end
					end
				end
			end
		end
	end
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if not evt.Cmp("QBits", 158) then         -- Killed all Dragon Hunters in Garrote Gorge wilderness area
			if evt.CheckMonstersKilled{CheckType = 2, Id = 42, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 43, Count = 0, InvisibleAsDead = 0} then
					if evt.CheckMonstersKilled{CheckType = 2, Id = 44, Count = 0, InvisibleAsDead = 0} then
						if evt.Cmp("QBits", 159) then         -- Questbit set for Riki
							evt.Set("QBits", 158)         -- Killed all Dragon Hunters in Garrote Gorge wilderness area
							evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
							evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
							evt.StatusText(71)         -- "You have killed all of the Dragon Hunters"
						else
							evt.Set("QBits", 159)         -- Questbit set for Riki
							evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -30272, Y = -16512, Z = 0, NPCGroup = 2, unk = 0}         -- "Lizardmen Warriors"
							evt.SetMonGroupBit{NPCGroup = 2, Bit = const.MonsterBits.Invisible, On = true}         -- "Lizardmen Warriors"
						end
					end
				end
			end
		end
	end
	if not evt.Cmp("QBits", 75) then         -- Killed all Dragon Slayers in southwest encampment in Area 5
		if evt.CheckMonstersKilled{CheckType = 1, Id = 24, Count = 0, InvisibleAsDead = 0} then
			evt.Set("QBits", 75)         -- Killed all Dragon Slayers in southwest encampment in Area 5
		end
	end
	if not evt.Cmp("QBits", 200) then         -- Sword of Whistlebone - I lost it
		if evt.CheckMonstersKilled{CheckType = 4, Id = 2, Count = 1, InvisibleAsDead = 0} then
			evt.Set("QBits", 200)         -- Sword of Whistlebone - I lost it
		end
	end
end

Timer(evt.map[131].last, 10*const.Minute)

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 190) then         -- Obelisk Area 5
		evt.StatusText(12)         -- "theunicornkin"
		evt.Add("AutonotesBits", 17)         -- "Obelisk message #1: theunicornkin"
		evt.Add("QBits", 190)         -- Obelisk Area 5
	end
end

evt.house[171] = 4  -- "Lance's Spears"
evt.map[171] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(4)         -- "Lance's Spears"
	end
end

evt.house[172] = 4  -- "Lance's Spears"
evt.house[173] = 18  -- "Plated Protection"
evt.map[173] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(18)         -- "Plated Protection"
	end
end

evt.house[174] = 18  -- "Plated Protection"
evt.house[175] = 32  -- "Wards and Pendants"
evt.map[175] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(32)         -- "Wards and Pendants"
	end
end

evt.house[176] = 32  -- "Wards and Pendants"
evt.house[181] = 57  -- "Guild Caravans"
evt.map[181] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(57)         -- "Guild Caravans"
	end
end

evt.house[182] = 57  -- "Guild Caravans"
evt.house[185] = 77  -- "Sacred Steel"
evt.map[185] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(77)         -- "Sacred Steel"
	end
end

evt.house[186] = 77  -- "Sacred Steel"
evt.house[187] = 92  -- "Godric's Gauntlet"
evt.map[187] = function()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(92)         -- "Godric's Gauntlet"
	end
end

evt.house[188] = 92  -- "Godric's Gauntlet"
evt.HouseDoor(191, 111)  -- "Dragon's Blood Inn"
evt.house[192] = 111  -- "Dragon's Blood Inn"
evt.hint[401] = evt.str[45]  -- "Dragon Hunter Camp"
evt.hint[402] = evt.str[46]  -- "Dragon Cave"
evt.hint[403] = evt.str[47]  -- "Naga Vault"
evt.hint[404] = evt.str[48]  -- "Grand Temple of Eep"
evt.hint[405] = evt.str[19]  -- "Tent"
evt.hint[450] = evt.str[5]  -- "Well"
evt.hint[479] = evt.str[100]  -- ""
evt.hint[490] = evt.str[100]  -- ""
evt.map[490] = function()  -- Timer(<function>, 7.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		evt.PlaySound{Id = 325, X = 11520, Y = -13664}
	end
end

Timer(evt.map[490].last, 7.5*const.Minute)

evt.hint[501] = evt.str[50]  -- "Enter the Dragon Hunter's Camp"
evt.map[501] = function()
	evt.MoveToMap{X = -1216, Y = 1888, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 202, Icon = 1, Name = "d16.blv"}         -- "Dragon Hunter Camp"
end

evt.hint[502] = evt.str[51]  -- "Enter the Dragon Cave"
evt.map[502] = function()
	evt.MoveToMap{X = 223, Y = -8, Z = 170, Direction = 1088, LookAngle = 0, SpeedZ = 0, HouseId = 203, Icon = 1, Name = "d17.blv"}         -- "Dragon Cave"
end

evt.hint[503] = evt.str[52]  -- "Enter the Naga Vault"
evt.map[503] = function()
	evt.MoveToMap{X = -500, Y = -1567, Z = -63, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 204, Icon = 1, Name = "d18.blv"}         -- "Naga Vault"
end

evt.hint[504] = evt.str[53]  -- "Enter the Grand Temple of Eep"
evt.map[504] = function()
	evt.MoveToMap{X = -2812, Y = 726, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D44.blv"}
end

