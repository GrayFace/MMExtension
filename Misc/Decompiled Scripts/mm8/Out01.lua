local TXT = Localize{
	[0] = " ",
	[1] = "Dagger Wound Islands",
	[2] = "",
	[3] = "Chest",
	[4] = "Open Crate",
	[5] = "Well",
	[6] = "Drink from the well",
	[7] = "Fountain",
	[8] = "Drink from the fountain",
	[9] = "Refreshing",
	[10] = "That was not so refreshing",
	[11] = "Sealed Crate",
	[12] = "summerday",
	[13] = "Fire the Cannon !",
	[14] = "You need a power stone to operate this teleporter",
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
	[34] = "Landing Craft",
	[35] = "Pirate Ship",
	[36] = "Pirate Ship",
	[37] = "Pirate Ship",
	[38] = "",
	[39] = "",
	[40] = "Buoy",
	[41] = "Palm tree",
	[42] = "Flower",
	[43] = "",
	[44] = "",
	[45] = "Abandoned Temple",
	[46] = "Regnan Pirate Outpost",
	[47] = "Uplifted Library",
	[48] = "Gate to the Plane of Earth",
	[49] = "",
	[50] = "Enter the Abandoned Temple",
	[51] = "Enter the Regnan Pirate Outpost",
	[52] = "Enter the Uplifted Library",
	[53] = "Enter the Plane of Earth",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Intellect +15 (Temporary)",
	[61] = "Luck +2 (Permanent)",
	[62] = "Your Wounds begin to Heal",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = false}
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetMonGroupBit{NPCGroup = 14, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki"
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki"
		evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki(M1)"
		evt.SetNPCGroupNews{NPCGroup = 12, NPCNews = 13}         -- "Misc Group for Riki(M2)" : "With the Pirate Outpost defeated our homes are once again safe!  Thank you!"
		evt.SetNPCGroupNews{NPCGroup = 13, NPCNews = 13}         -- "Misc Group for Riki(M3)" : "With the Pirate Outpost defeated our homes are once again safe!  Thank you!"
		evt.SetNPCGroupNews{NPCGroup = 1, NPCNews = 2}         -- "Peasants on Main Island of Dagger Wound" : "Our thanks for defeating the pirates!  Now if you could only do something about the mountain of fire!"
	else
		evt.SetNPCGroupNews{NPCGroup = 12, NPCNews = 12}         -- "Misc Group for Riki(M2)" : "Help us!  If we do not push the pirates off the island all will be lost!"
		evt.SetNPCGroupNews{NPCGroup = 13, NPCNews = 12}         -- "Misc Group for Riki(M3)" : "Help us!  If we do not push the pirates off the island all will be lost!"
		if not evt.Cmp("QBits", 36) then         -- "Sink the Regnan Fleet. Return to the Ravenshore council chamber."
			if not evt.Cmp("QBits", 38) then         -- Quest 36 is done.
				evt.SetFacetBit{Id = 25, Bit = const.FacetBits.Invisible, On = true}
				evt.SetFacetBit{Id = 25, Bit = const.FacetBits.Untouchable, On = true}
				return
			end
		end
	end
	evt.SetFacetBit{Id = 25, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 25, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 26, Bit = const.FacetBits.Untouchable, On = true}
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[100]  -- ""
evt.map[3] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 226) then         -- game Init stuff in area one
		evt.Add("QBits", 226)         -- game Init stuff in area one
		evt.Add("QBits", 185)         -- Blood Drop Town Portal
		evt.Add("QBits", 401)         -- Roster Character In Party 2
		evt.Add("QBits", 407)         -- Roster Character In Party 8
	end
end

events.LoadMap = evt.map[3].last

evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 224)  -- "Hiss' Hut"
evt.house[12] = 224  -- "Hiss' Hut"
evt.HouseDoor(13, 225)  -- "Rohtnax's House"
evt.house[14] = 225  -- "Rohtnax's House"
evt.HouseDoor(15, 226)  -- "Tisk's Hut"
evt.house[16] = 226  -- "Tisk's Hut"
evt.HouseDoor(17, 227)  -- "Thadin's House"
evt.house[18] = 227  -- "Thadin's House"
evt.HouseDoor(19, 228)  -- "House of Ich"
evt.house[20] = 228  -- "House of Ich"
evt.HouseDoor(21, 229)  -- "Languid's Hut"
evt.house[22] = 229  -- "Languid's Hut"
evt.HouseDoor(23, 230)  -- "House of Thistle"
evt.house[24] = 230  -- "House of Thistle"
evt.HouseDoor(25, 231)  -- "Zevah's Hut"
evt.house[26] = 231  -- "Zevah's Hut"
evt.HouseDoor(27, 232)  -- "Isthric's House"
evt.house[28] = 232  -- "Isthric's House"
evt.HouseDoor(29, 233)  -- "Bone's House"
evt.house[30] = 233  -- "Bone's House"
evt.HouseDoor(31, 234)  -- "Lasatin's Hut"
evt.house[32] = 234  -- "Lasatin's Hut"
evt.HouseDoor(33, 235)  -- "Menasaur's House"
evt.house[34] = 235  -- "Menasaur's House"
evt.HouseDoor(35, 236)  -- "Husk's Hut"
evt.house[36] = 236  -- "Husk's Hut"
evt.HouseDoor(37, 237)  -- "Talimere's Hut"
evt.house[38] = 237  -- "Talimere's Hut"
evt.HouseDoor(39, 238)  -- "House of Reshie"
evt.house[40] = 238  -- "House of Reshie"
evt.HouseDoor(41, 239)  -- "House"
evt.house[42] = 239  -- "House"
evt.HouseDoor(43, 240)  -- "Long-Tail's Hut"
evt.house[44] = 240  -- "Long-Tail's Hut"
evt.HouseDoor(45, 241)  -- "Aislen's House"
evt.house[46] = 241  -- "Aislen's House"
evt.HouseDoor(47, 242)  -- "House of Grivic"
evt.house[48] = 242  -- "House of Grivic"
evt.HouseDoor(49, 243)  -- "Ush's Hut"
evt.house[50] = 243  -- "Ush's Hut"
evt.hint[81] = evt.str[3]  -- "Chest"
evt.map[81] = function()
	if evt.Cmp("Players", 2) then
		evt.OpenChest(3)
	else
		evt.OpenChest(0)
	end
end

evt.hint[82] = evt.str[3]  -- "Chest"
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- "Chest"
evt.map[83] = function()
	evt.OpenChest(2)
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

evt.hint[93] = evt.str[4]  -- "Open Crate"
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[4]  -- "Open Crate"
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[4]  -- "Open Crate"
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[4]  -- "Open Crate"
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[4]  -- "Open Crate"
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[4]  -- "Open Crate"
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[4]  -- "Open Crate"
evt.map[99] = function()
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[4]  -- "Open Crate"
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.hint[101] = evt.str[6]  -- "Drink from the well"
evt.map[101] = function()
	if evt.Cmp("IntellectBonus", 15) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("IntellectBonus", 15)
		evt.StatusText(60)         -- "Intellect +15 (Temporary)"
		evt.Add("AutonotesBits", 245)         -- "Well in the village of Blood Drop on Dagger Wound Island gives a temporary Intellect bonus of 15."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if evt.Cmp("BaseLuck", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseLuck", 2)
		evt.StatusText(61)         -- "Luck +2 (Permanent)"
		evt.Add("AutonotesBits", 246)         -- "Well in the village of Blood Drop on Dagger Wound Island gives a  permanent Luck bonus up to a Luck of 16."
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	if not evt.Cmp("MapVar29", 2) then
		if not evt.Cmp("Gold", 99) then
			if not evt.Cmp("BankGold", 99) then
				if evt.Cmp("BaseLuck", 14) then
					evt.Add("Gold", 1000)
					evt.Add("MapVar29", 1)
					evt.Add("AutonotesBits", 247)         -- "Well in the village of Blood Drop on Dagger Wound Island gives 1000 gold if Luck is greater than 14 and total gold on party and in the bank is less than 100."
					return
				end
			end
		end
	end
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[104] = evt.str[8]  -- "Drink from the fountain"
evt.map[104] = function()
	if evt.Cmp("HasFullHP", 0) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("HP", 25)
		evt.StatusText(62)         -- "Your Wounds begin to Heal"
		evt.Add("AutonotesBits", 248)         -- "Fountain in the village of Blood Drop on Dagger Wound Island restores Hit Points."
	end
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 186) then         -- Obelisk Area 1
		evt.StatusText(12)         -- "summerday"
		evt.Add("AutonotesBits", 25)         -- "Obelisk message #9: summerday"
		evt.Add("QBits", 186)         -- Obelisk Area 1
	end
end

evt.HouseDoor(171, 1)  -- "True Mettle"
evt.house[172] = 1  -- "True Mettle"
evt.HouseDoor(173, 15)  -- "The Tannery"
evt.house[174] = 15  -- "The Tannery"
evt.HouseDoor(175, 29)  -- "Fearsome Fetishes"
evt.house[176] = 29  -- "Fearsome Fetishes"
evt.HouseDoor(177, 42)  -- "Herbal Elixirs"
evt.house[178] = 42  -- "Herbal Elixirs"
evt.HouseDoor(179, 139)  -- "Cures and Curses"
evt.house[180] = 139  -- "Cures and Curses"
evt.HouseDoor(183, 63)  -- "The Windling"
evt.house[184] = 63  -- "The Windling"
evt.HouseDoor(185, 74)  -- "Mystic Medicine"
evt.house[186] = 74  -- "Mystic Medicine"
evt.HouseDoor(187, 89)  -- "Rites of Passage"
evt.house[188] = 89  -- "Rites of Passage"
evt.HouseDoor(191, 107)  -- "The Grog and Grub"
evt.house[192] = 107  -- "The Grog and Grub"
evt.HouseDoor(193, 128)  -- "The Some Place Safe"
evt.house[194] = 128  -- "The Some Place Safe"
evt.HouseDoor(197, 173)  -- "Clan Leader's Hall"
evt.house[198] = 173  -- "Clan Leader's Hall"
evt.HouseDoor(199, 185)  -- "The Adventurer's Inn"
evt.house[200] = 185  -- "The Adventurer's Inn"
evt.hint[401] = evt.str[45]  -- "Abandoned Temple"
evt.hint[402] = evt.str[46]  -- "Regnan Pirate Outpost"
evt.hint[403] = evt.str[47]  -- "Uplifted Library"
evt.hint[404] = evt.str[48]  -- "Gate to the Plane of Earth"
evt.hint[405] = evt.str[35]  -- "Pirate Ship"
evt.hint[406] = evt.str[36]  -- "Pirate Ship"
evt.hint[407] = evt.str[37]  -- "Pirate Ship"
evt.hint[408] = evt.str[34]  -- "Landing Craft"
evt.hint[449] = evt.str[7]  -- "Fountain"
evt.hint[450] = evt.str[5]  -- "Well"
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.MoveToMap{X = -480, Y = 5432, Z = 384, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	evt.MoveToMap{X = 10123, Y = 4488, Z = 736, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("QBits", 1) then         -- Activate Area 1 teleporters 3 and 4.
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 617) then         -- "Power Stone"
			evt.StatusText(14)         -- "You need a power stone to operate this teleporter"
			return
		end
		if not evt.Cmp("QBits", 8) then         -- Fredrick Talimere visited by player with crystal in their possesion.
			return
		end
		evt.Subtract("Inventory", 617)         -- "Power Stone"
		evt.Add("QBits", 1)         -- Activate Area 1 teleporters 3 and 4.
	end
	evt.MoveToMap{X = -21528, Y = -1384, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[454] = evt.str[45]  -- "Abandoned Temple"
evt.map[454] = function()
	evt.FaceAnimation{Player = "Current", Animation = 18}
end

evt.hint[455] = evt.str[100]  -- ""
evt.map[455] = function()
	evt.ForPlayer("All")
	evt.Set("Dead", 0)
end

evt.hint[456] = evt.str[100]  -- ""
evt.map[456] = function()  -- Timer(<function>, 15*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -9216, ToY = -12848, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 2 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -9232, ToY = -7680, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 3 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -5872, ToY = -8832, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 4 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -7200, ToY = -4656, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 5 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -4960, ToY = -3440, ToZ = 3000}         -- "Meteor Shower"
	else
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -3472, ToY = -6544, ToZ = 3000}         -- "Meteor Shower"
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -96, ToY = -3568, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 2 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 3184, ToY = -976, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 3 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 912, ToY = 544, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 4 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 2976, ToY = 2240, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 5 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 6144, ToY = 832, ToZ = 3000}         -- "Meteor Shower"
	else
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 9376, ToY = -4416, ToZ = 3000}         -- "Meteor Shower"
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 12256, ToY = -8640, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 2 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 5136, ToY = -14192, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 3 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 6320, ToY = -15840, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 4 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 7584, ToY = -20016, ToZ = 3000}         -- "Meteor Shower"
	elseif i == 5 then
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = -3504, ToY = -15744, ToZ = 3000}         -- "Meteor Shower"
	else
		evt.CastSpell{Spell = 9, Mastery = 11, Skill = 3, FromX = 19872, FromY = -19824, FromZ = 5084, ToX = 560, ToY = -9776, ToZ = 3000}         -- "Meteor Shower"
	end
end

Timer(evt.map[456].last, 15*const.Minute)

evt.hint[457] = evt.str[13]  -- "Fire the Cannon !"
evt.map[457] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 8704, FromY = 2000, FromZ = 686, ToX = 8704, ToY = 1965, ToZ = 686}         -- "Fireball"
	evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 8704, FromY = 1950, FromZ = 686, ToX = 8704, ToY = -2592, ToZ = 686}
end

evt.hint[458] = evt.str[13]  -- "Fire the Cannon !"
evt.map[458] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 15872, FromY = 1500, FromZ = 686, ToX = 15872, ToY = -1000, ToZ = 686}         -- "Fireball"
	evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 15872, FromY = 1440, FromZ = 686, ToX = 15872, ToY = -3100, ToZ = 686}
end

evt.hint[459] = evt.str[13]  -- "Fire the Cannon !"
evt.map[459] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 18400, FromY = 3584, FromZ = 652, ToX = 18522, ToY = 3584, ToZ = 652}         -- "Fireball"
	evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 18522, FromY = 3584, FromZ = 652, ToX = 22880, ToY = 3584, ToZ = 100}
end

evt.hint[460] = evt.str[100]  -- ""
evt.map[460] = function()  -- Timer(<function>, 15*const.Minute)
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		return
	end
	if not evt.CheckMonstersKilled{CheckType = 4, Id = 8, Count = 1, InvisibleAsDead = 1} then
		evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 15872, FromY = 1500, FromZ = 686, ToX = 15872, ToY = -1000, ToZ = 686}         -- "Fireball"
		evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 15872, FromY = 1440, FromZ = 686, ToX = 15872, ToY = -3100, ToZ = 100}
	end
	if not evt.CheckMonstersKilled{CheckType = 4, Id = 9, Count = 1, InvisibleAsDead = 1} then
		evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1536, FromY = 16400, FromZ = 682, ToX = 1536, ToY = 16480, ToZ = 682}         -- "Fireball"
		evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 1536, FromY = 16480, FromZ = 682, ToX = 1536, ToY = 21528, ToZ = 100}
	end
end

Timer(evt.map[460].last, 15*const.Minute)

evt.hint[461] = evt.str[13]  -- "Fire the Cannon !"
evt.map[461] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1536, FromY = 16400, FromZ = 682, ToX = 1536, ToY = 16480, ToZ = 682}         -- "Fireball"
	evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = 1536, FromY = 16480, FromZ = 682, ToX = 1536, ToY = 21528, ToZ = 100}
end

evt.hint[462] = evt.str[13]  -- "Fire the Cannon !"
evt.map[462] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = -520, FromY = 15360, FromZ = 682, ToX = -610, ToY = 15360, ToZ = 682}         -- "Fireball"
	evt.CastSpell{Spell = 136, Mastery = const.Expert, Skill = 1, FromX = -610, FromY = 15360, FromZ = 682, ToX = -6320, ToY = 15360, ToZ = 100}
end

evt.hint[463] = evt.str[100]  -- ""
evt.map[463] = function()  -- Timer(<function>, 10*const.Minute)
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		return
	end
	if evt.CheckMonstersKilled{CheckType = 1, Id = 10, Count = 0, InvisibleAsDead = 1} then
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 776, Y = -66192, Z = 0, NPCGroup = 10, unk = 0}         -- "Misc Group for Riki"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 0, Y = -5608, Z = 0, NPCGroup = 10, unk = 0}         -- "Misc Group for Riki"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -656, Y = -5696, Z = 23, NPCGroup = 10, unk = 0}         -- "Misc Group for Riki"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -1280, Y = -5720, Z = 0, NPCGroup = 10, unk = 0}         -- "Misc Group for Riki"
	end
	if evt.CheckMonstersKilled{CheckType = 1, Id = 11, Count = 0, InvisibleAsDead = 1} then
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -2744, Y = 4864, Z = 176, NPCGroup = 11, unk = 0}         -- "Misc Group for Riki(M1)"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -2984, Y = 4208, Z = 561, NPCGroup = 11, unk = 0}         -- "Misc Group for Riki(M1)"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -3624, Y = 4280, Z = 400, NPCGroup = 11, unk = 0}         -- "Misc Group for Riki(M1)"
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -3504, Y = 4992, Z = 74, NPCGroup = 11, unk = 0}         -- "Misc Group for Riki(M1)"
	end
	if evt.CheckMonstersKilled{CheckType = 1, Id = 12, Count = 0, InvisibleAsDead = 1} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5208, Y = -736, Z = 46, NPCGroup = 12, unk = 0}         -- "Misc Group for Riki(M2)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 3120, Y = 800, Z = 226, NPCGroup = 12, unk = 0}         -- "Misc Group for Riki(M2)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 3480, Y = -2656, Z = 88, NPCGroup = 12, unk = 0}         -- "Misc Group for Riki(M2)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 2080, Y = -2248, Z = 539, NPCGroup = 12, unk = 0}         -- "Misc Group for Riki(M2)"
	end
	if evt.CheckMonstersKilled{CheckType = 1, Id = 13, Count = 0, InvisibleAsDead = 1} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -896, Y = 55504, Z = 384, NPCGroup = 13, unk = 0}         -- "Misc Group for Riki(M3)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -104, Y = 5328, Z = 384, NPCGroup = 13, unk = 0}         -- "Misc Group for Riki(M3)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -880, Y = 4464, Z = 510, NPCGroup = 13, unk = 0}         -- "Misc Group for Riki(M3)"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -1256, Y = 5296, Z = 241, NPCGroup = 13, unk = 0}         -- "Misc Group for Riki(M3)"
	end
end

Timer(evt.map[463].last, 10*const.Minute)

evt.hint[464] = evt.str[11]  -- "Sealed Crate"
evt.hint[465] = evt.str[100]  -- ""
evt.map[465] = function()
	if not evt.Cmp("QBits", 1) then         -- Activate Area 1 teleporters 3 and 4.
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 617) then         -- "Power Stone"
			evt.StatusText(14)         -- "You need a power stone to operate this teleporter"
			return
		end
		if not evt.Cmp("QBits", 8) then         -- Fredrick Talimere visited by player with crystal in their possesion.
			return
		end
		evt.Subtract("Inventory", 617)         -- "Power Stone"
		evt.Add("QBits", 1)         -- Activate Area 1 teleporters 3 and 4.
	end
	evt.MoveToMap{X = -12496, Y = -9728, Z = 160, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[466] = evt.str[100]  -- ""
evt.map[466] = function()
	if not evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 618) then         -- "Power Stone"
			evt.StatusText(14)         -- "You need a power stone to operate this teleporter"
			return
		end
		evt.Subtract("Inventory", 618)         -- "Power Stone"
		evt.Add("QBits", 2)         -- Activate Area 1 teleporters 5 and 6.
	end
	evt.MoveToMap{X = -13912, Y = 14096, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[467] = evt.str[100]  -- ""
evt.map[467] = function()
	if not evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 618) then         -- "Power Stone"
			evt.StatusText(14)         -- "You need a power stone to operate this teleporter"
			return
		end
		evt.Subtract("Inventory", 618)         -- "Power Stone"
		evt.Add("QBits", 2)         -- Activate Area 1 teleporters 5 and 6.
	end
	evt.MoveToMap{X = -18952, Y = 8608, Z = 96, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[468] = evt.str[100]  -- ""
evt.map[468] = function()  -- Timer(<function>, 20*const.Minute)
	local i
	if not evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		i = Game.Rand() % 5
		if i == 1 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 16433, FromY = -3164, FromZ = 180, ToX = 15920, ToY = 2850, ToZ = 977}         -- "Fireball"
		elseif i == 2 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 16298, FromY = -3164, FromZ = 180, ToX = 14789, ToY = 3735, ToZ = 705}         -- "Fireball"
		elseif i == 3 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 16168, FromY = -3164, FromZ = 180, ToX = 13056, ToY = 3752, ToZ = 736}         -- "Fireball"
		elseif i == 4 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 16041, FromY = -3164, FromZ = 180, ToX = 15926, ToY = 1274, ToZ = 420}         -- "Fireball"
		end
	end
end

Timer(evt.map[468].last, 20*const.Minute)

evt.hint[469] = evt.str[100]  -- ""
evt.map[469] = function()  -- Timer(<function>, 20*const.Minute)
	local i
	if not evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		i = Game.Rand() % 5
		if i == 1 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1496, FromY = 21593, FromZ = 180, ToX = 15920, ToY = 2850, ToZ = 977}         -- "Fireball"
		elseif i == 2 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1634, FromY = 21593, FromZ = 180, ToX = 14789, ToY = 3735, ToZ = 705}         -- "Fireball"
		elseif i == 3 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1729, FromY = 21593, FromZ = 180, ToX = 13056, ToY = 3752, ToZ = 736}         -- "Fireball"
		elseif i == 4 then
			evt.CastSpell{Spell = 6, Mastery = const.Expert, Skill = 1, FromX = 1891, FromY = 21593, FromZ = 180, ToX = 15926, ToY = 1274, ToZ = 420}         -- "Fireball"
		end
	end
end

Timer(evt.map[469].last, 20*const.Minute)

evt.hint[470] = evt.str[100]  -- ""
evt.hint[471] = evt.str[100]  -- ""
evt.map[471] = function()
	evt.MoveToMap{X = 8760, Y = 4408, Z = 736, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	if not evt.Cmp("QBits", 227) then         -- Turn on Temple Bypass tele in area one
		evt.Add("QBits", 227)         -- Turn on Temple Bypass tele in area one
	end
end

evt.hint[472] = evt.str[100]  -- ""
evt.map[472] = function()
	if evt.Cmp("QBits", 227) then         -- Turn on Temple Bypass tele in area one
		evt.MoveToMap{X = 21216, Y = 18680, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.hint[479] = evt.str[100]  -- ""
evt.hint[494] = evt.str[41]  -- "Palm tree"
evt.map[494] = function()
	local i
	if evt.Cmp("QBits", 270) then         -- Reagent spout area 1
		return
	end
	if not evt.Cmp("PerceptionSkill", 3) then
		return
	end
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Item = 200, X = 3896, Y = 8080, Z = 544, Speed = 1000, Count = 1, RandomAngle = true}         -- "Widowsweep Berries" : "Widowsweep Berries"
	elseif i == 2 then
		evt.SummonObject{Item = 205, X = 3896, Y = 8080, Z = 544, Speed = 1000, Count = 1, RandomAngle = true}         -- "Phima Root" : "Phima Root"
	elseif i == 3 then
		evt.SummonObject{Item = 210, X = 3896, Y = 8080, Z = 544, Speed = 1000, Count = 1, RandomAngle = true}         -- "Poppy Pod" : "Poppy Pod"
	elseif i == 4 then
		evt.SummonObject{Item = 215, X = 3896, Y = 8080, Z = 544, Speed = 1000, Count = 1, RandomAngle = true}         -- "Mushroom" : "Mushroom"
	else
		evt.SummonObject{Item = 220, X = 3896, Y = 8080, Z = 544, Speed = 1000, Count = 1, RandomAngle = true}         -- "Potion Bottle" : "Potion Bottle"
	end
	evt.Add("QBits", 270)         -- Reagent spout area 1
end

evt.hint[495] = evt.str[42]  -- "Flower"
evt.map[495] = function()
	local i
	if evt.Cmp("QBits", 271) then         -- Reagent spout area 1
		return
	end
	if not evt.Cmp("PerceptionSkill", 5) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{-- ERROR: Not found
Item = 2138, X = -18832, Y = 5840, Z = 330, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gold Ring"
	elseif i == 2 then
		evt.SummonObject{-- ERROR: Not found
Item = 2139, X = -18832, Y = 5840, Z = 330, Speed = 1000, Count = 1, RandomAngle = true}         -- "Pearl Ring"
	elseif i == 3 then
		evt.SummonObject{-- ERROR: Not found
Item = 2140, X = -18832, Y = 5840, Z = 330, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gemstone Ring"
	else
		evt.SummonObject{-- ERROR: Not found
Item = 2141, X = -18832, Y = 5840, Z = 330, Speed = 1000, Count = 1, RandomAngle = true}         -- "Amethyst Ring"
	end
	evt.Add("QBits", 271)         -- Reagent spout area 1
end

evt.hint[497] = evt.str[40]  -- "Buoy"
evt.map[497] = function()
	if not evt.Cmp("QBits", 268) then         -- Area 1 buoy
		if evt.Cmp("BaseLuck", 13) then
			evt.Add("QBits", 268)         -- Area 1 buoy
			evt.Add("SkillPoints", 2)
		end
	end
end

evt.hint[498] = evt.str[40]  -- "Buoy"
evt.map[498] = function()
	if not evt.Cmp("QBits", 269) then         -- Area 1 buoy
		if evt.Cmp("BaseLuck", 20) then
			evt.Add("QBits", 269)         -- Area 1 buoy
			evt.Add("SkillPoints", 5)
		end
	end
end

evt.hint[500] = evt.str[100]  -- ""
evt.map[500] = function()  -- Timer(<function>, const.Day, 10*const.Hour, false)
	if not evt.Cmp("QBits", 232) then         -- Set when you talk to S'ton
		evt.SpeakNPC(31)         -- "S'ton"
		evt.Add("QBits", 232)         -- Set when you talk to S'ton
	end
end

Timer(evt.map[500].last, const.Day, 10*const.Hour, false)

evt.hint[501] = evt.str[50]  -- "Enter the Abandoned Temple"
evt.map[501] = function()
	evt.MoveToMap{X = -3008, Y = -1696, Z = 2464, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 1, Name = "D05.blv"}         -- "Abandoned Temple"
end

evt.hint[502] = evt.str[51]  -- "Enter the Regnan Pirate Outpost"
evt.map[502] = function()
	evt.MoveToMap{X = -7, Y = -714, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 192, Icon = 1, Name = "D06.blv"}         -- "Pirate Outpost"
end

evt.hint[503] = evt.str[52]  -- "Enter the Uplifted Library"
evt.map[503] = function()
	evt.MoveToMap{X = -592, Y = 624, Z = 0, Direction = 552, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d40.blv"}
end

evt.hint[504] = evt.str[50]  -- "Enter the Abandoned Temple"
evt.map[504] = function()
	evt.MoveToMap{X = 12704, Y = 2432, Z = 385, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 500, Icon = 1, Name = "d05.blv"}         -- "Backdoor of Abandoned Temple"
end

evt.hint[505] = evt.str[53]  -- "Enter the Plane of Earth"
evt.map[505] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 49, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 221, Icon = 1, Name = "ElemE.blv"}         -- "Gateway to the Plane of Earth"
end

