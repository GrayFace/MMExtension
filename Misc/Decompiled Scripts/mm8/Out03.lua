local TXT = Localize{
	[0] = " ",
	[1] = "Alvar",
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
	[12] = "ubjectsap",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
	[16] = "Tent",
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
	[40] = "Pine tree",
	[41] = "Rock",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "Wasp Nest",
	[46] = "Ogre Raiding Fort",
	[47] = "Dark Dwarf Compound",
	[48] = "",
	[49] = "",
	[50] = "Enter the Wasp Nest",
	[51] = "Enter the Ogre Raiding Fort",
	[52] = "Enter the Dark Dwarf Compound",
	[53] = "",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Personality +25 (Temporary)",
	[61] = "Might +2 (Permanent)",
	[62] = "You mind clears, and you recover some Mana",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "You have killed all of the Ogres",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(325)

evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 287)  -- "Withersmythe Estate"
evt.house[12] = 287  -- "Withersmythe Estate"
evt.HouseDoor(13, 288)  -- "Vespers Hall"
evt.house[14] = 288  -- "Vespers Hall"
evt.HouseDoor(15, 289)  -- "Hall of Solis"
evt.house[16] = 289  -- "Hall of Solis"
evt.HouseDoor(17, 290)  -- "Eversmyle Hall"
evt.house[18] = 290  -- "Eversmyle Hall"
evt.HouseDoor(19, 291)  -- "Moore Cottage"
evt.house[20] = 291  -- "Moore Cottage"
evt.HouseDoor(21, 292)  -- "House of Krewlen"
evt.house[22] = 292  -- "House of Krewlen"
evt.HouseDoor(23, 293)  -- "Darkenmoore Hall"
evt.house[24] = 293  -- "Darkenmoore Hall"
evt.HouseDoor(25, 294)  -- "Dervish Estate"
evt.house[26] = 294  -- "Dervish Estate"
evt.HouseDoor(27, 295)  -- "Agraynel Hall"
evt.house[28] = 295  -- "Agraynel Hall"
evt.HouseDoor(29, 296)  -- "House of Lightfinger"
evt.house[30] = 296  -- "House of Lightfinger"
evt.HouseDoor(31, 297)  -- "Nightwalker Cottage"
evt.house[32] = 297  -- "Nightwalker Cottage"
evt.HouseDoor(33, 298)  -- "Sparkman Home"
evt.house[34] = 298  -- "Sparkman Home"
evt.HouseDoor(35, 299)  -- "Sablewood Hall"
evt.house[36] = 299  -- "Sablewood Hall"
evt.HouseDoor(37, 300)  -- "Steele Estate"
evt.house[38] = 300  -- "Steele Estate"
evt.HouseDoor(39, 301)  -- "Guild of Bounty Hunters"
evt.house[40] = 301  -- "Guild of Bounty Hunters"
evt.HouseDoor(41, 302)  -- "Watershed Cottage"
evt.house[42] = 302  -- "Watershed Cottage"
evt.HouseDoor(43, 303)  -- "Fromago Manor"
evt.house[44] = 303  -- "Fromago Manor"
evt.HouseDoor(45, 304)  -- "Blackthorne Estate"
evt.house[46] = 304  -- "Blackthorne Estate"
evt.HouseDoor(47, 305)  -- "House of Nevermore"
evt.house[48] = 305  -- "House of Nevermore"
evt.HouseDoor(49, 306)  -- "Ittalle Cottage"
evt.house[50] = 306  -- "Ittalle Cottage"
evt.HouseDoor(51, 307)  -- "Havest Hall"
evt.house[52] = 307  -- "Havest Hall"
evt.HouseDoor(53, 308)  -- "Iverson Estate"
evt.house[54] = 308  -- "Iverson Estate"
evt.HouseDoor(55, 309)  -- "Oscleton Residence"
evt.house[56] = 309  -- "Oscleton Residence"
evt.HouseDoor(57, 310)  -- "Thelbourne Residence"
evt.house[58] = 310  -- "Thelbourne Residence"
evt.HouseDoor(59, 311)  -- "Greydawn Residence"
evt.house[60] = 311  -- "Greydawn Residence"
evt.HouseDoor(61, 312)  -- "House Stellare"
evt.house[62] = 312  -- "House Stellare"
evt.HouseDoor(63, 313)  -- "House of Brandy"
evt.house[64] = 313  -- "House of Brandy"
evt.HouseDoor(65, 314)  -- "Bowes Residence"
evt.house[66] = 314  -- "Bowes Residence"
evt.HouseDoor(67, 315)  -- "Breman Residence"
evt.house[68] = 315  -- "Breman Residence"
evt.HouseDoor(69, 325)  -- " Home of Rihansi "
evt.house[70] = 325  -- " Home of Rihansi "
evt.HouseDoor(71, 326)  -- "Bombah Hall"
evt.house[72] = 326  -- "Bombah Hall"
evt.HouseDoor(73, 327)  -- "Keldon's Cottage"
evt.house[74] = 327  -- "Keldon's Cottage"
evt.HouseDoor(75, 330)  -- "Featherwind's House"
evt.house[76] = 330  -- "Featherwind's House"
evt.HouseDoor(77, 329)  -- "House Farswell"
evt.house[78] = 329  -- "House Farswell"
evt.HouseDoor(79, 328)  -- "Veldon's Cottage"
evt.house[80] = 328  -- "Veldon's Cottage"
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

evt.hint[91] = evt.str[42]  -- ""
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[46]  -- "Ogre Raiding Fort"
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
	if evt.Cmp("PersonalityBonus", 25) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("PersonalityBonus", 25)
		evt.StatusText(60)         -- "Personality +25 (Temporary)"
		evt.Add("AutonotesBits", 251)         -- "Well in the city of Alvar gives a temporary Personality bonus of 25."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if evt.Cmp("BaseMight", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseMight", 2)
		evt.StatusText(61)         -- "Might +2 (Permanent)"
		evt.Add("AutonotesBits", 252)         -- "Well in the city of Alvar gives a permanent Strength bonus up to a Strength of 16."
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[104] = evt.str[8]  -- "Drink from the fountain"
evt.map[104] = function()
	if not evt.Cmp("QBits", 181) then         -- Alvar Town Portal
		evt.Add("QBits", 181)         -- Alvar Town Portal
	end
	if evt.Cmp("HasFullSP", 0) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("SP", 25)
		evt.StatusText(62)         -- "You mind clears, and you recover some Mana"
		evt.Add("AutonotesBits", 253)         -- "Fountain in the city of Alvar restores Spell Points."
	end
end

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()  -- Timer(<function>, 10*const.Minute)
	if not evt.Cmp("QBits", 130) then         -- Killed all Ogres in Alvar canyon area and in Ogre Fortress
		if evt.CheckMonstersKilled{CheckType = 2, Id = 30, Count = 0, InvisibleAsDead = 0} then
			if evt.CheckMonstersKilled{CheckType = 2, Id = 31, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 32, Count = 0, InvisibleAsDead = 0} then
					if evt.Cmp("QBits", 131) then         -- Ogre Questbit set for Riki
						evt.Set("QBits", 130)         -- Killed all Ogres in Alvar canyon area and in Ogre Fortress
						evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
						evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
						evt.StatusText(70)         -- "You have killed all of the Ogres"
					else
						evt.Set("QBits", 131)         -- Ogre Questbit set for Riki
						evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = -30272, Y = -16512, Z = 0, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
						evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
					end
				end
			end
		end
	end
end

Timer(evt.map[131].last, 10*const.Minute)

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 188) then         -- Obelisk Area 3
		evt.StatusText(12)         -- "ubjectsap"
		evt.Add("AutonotesBits", 21)         -- "Obelisk message #5: ubjectsap"
		evt.Add("QBits", 188)         -- Obelisk Area 3
	end
end

evt.HouseDoor(171, 3)  -- "Polished Steel"
evt.house[172] = 3  -- "Polished Steel"
evt.HouseDoor(173, 17)  -- "Armory"
evt.house[174] = 17  -- "Armory"
evt.HouseDoor(175, 31)  -- "Arcane Items"
evt.house[176] = 31  -- "Arcane Items"
evt.HouseDoor(177, 44)  -- "Prepared Potions"
evt.house[178] = 44  -- "Prepared Potions"
evt.HouseDoor(179, 141)  -- "Self Study"
evt.house[180] = 141  -- "Self Study"
evt.HouseDoor(181, 55)  -- "Guild Caravans"
evt.house[182] = 55  -- "Guild Caravans"
evt.HouseDoor(185, 76)  -- "House of Healing"
evt.house[186] = 76  -- "House of Healing"
evt.HouseDoor(187, 91)  -- "Guild Training Hall"
evt.house[188] = 91  -- "Guild Training Hall"
evt.HouseDoor(189, 103)  -- "Placeholder"
evt.house[190] = 103  -- "Placeholder"
evt.HouseDoor(191, 109)  -- "Profit House"
evt.house[192] = 109  -- "Profit House"
evt.HouseDoor(193, 130)  -- "Guild House of Finance"
evt.house[194] = 130  -- "Guild House of Finance"
evt.HouseDoor(195, 117)  -- "Miho's Roadhouse"
evt.house[196] = 117  -- "Miho's Roadhouse"
evt.house[197] = 176  -- "Merchant Guildhouse"
evt.map[197] = function()
	if not evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		if evt.Cmp("Players", 4) then
			if evt.IsPlayerInParty(4) then         -- "Overdune Snapfinger"
				evt.ShowMovie{DoubleSize = 1, Name = "\"overrept\" "}
				evt.SetNPCTopic{NPC = 5, Index = 0, Event = 43}         -- "Bastian Loudrin" : "Quest"
				evt.SetNPCGreeting{NPC = 5, Greeting = 15}         -- "Bastian Loudrin" : "Good day."
				evt.ForPlayer("All")
				evt.Add("Experience", 10000)
				evt.Add("Awards", 5)         -- "Found a witness to the cataclysm in the Ironsand Desert."
				evt.Add("History6", 0)
				evt.ForPlayer("Current")
				evt.Subtract("QBits", 25)         -- "Find a witness to the lake of fire's formation. Bring him back to the merchant guild in Alvar."
				evt.Set("QBits", 13)         -- "Form an alliance among the major factions of Jadame."
				evt.Set("QBits", 14)         -- "Form an alliance with the Necromancers' Guild in Shadowspire."
				evt.Set("QBits", 15)         -- "Form an alliance with the Temple of the Sun in Murmurwoods."
				evt.Set("QBits", 16)         -- "Form an alliance with the Dragon hunters of Garrote Gorge."
				evt.Set("QBits", 17)         -- "Form an alliance with the Dragons of Garrote Gorge."
				evt.Set("QBits", 18)         -- "Form an alliance with the Minotaurs of Ravage Roaming."
				evt.Set("QBits", 59)         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
				evt.Add("Gold", 4000)
				evt.SetNPCTopic{NPC = 13, Index = 0, Event = 65}         -- "Masul" : "Alliance"
			end
		end
	end
	evt.EnterHouse(176)         -- "Merchant Guildhouse"
end

evt.house[198] = 176  -- "Merchant Guildhouse"
evt.HouseDoor(199, 147)  -- "Elemental Guild"
evt.house[200] = 147  -- "Elemental Guild"
evt.hint[401] = evt.str[45]  -- "Wasp Nest"
evt.hint[402] = evt.str[46]  -- "Ogre Raiding Fort"
evt.hint[403] = evt.str[47]  -- "Dark Dwarf Compound"
evt.hint[404] = evt.str[16]  -- "Tent"
evt.hint[449] = evt.str[7]  -- "Fountain"
evt.hint[450] = evt.str[5]  -- "Well"
evt.HouseDoor(451, 279)  -- "House Memoria"
evt.house[452] = 279  -- "House Memoria"
evt.HouseDoor(453, 280)  -- "House of Hawthorne "
evt.house[454] = 280  -- "House of Hawthorne "
evt.HouseDoor(455, 281)  -- "Lott's Family Home"
evt.house[456] = 281  -- "Lott's Family Home"
evt.HouseDoor(457, 282)  -- "House of Nosewort"
evt.house[458] = 282  -- "House of Nosewort"
evt.HouseDoor(459, 286)  -- "Dotes Family Hovel"
evt.house[460] = 286  -- "Dotes Family Hovel"
evt.HouseDoor(461, 283)  -- "Hall of the Tracker"
evt.house[462] = 283  -- "Hall of the Tracker"
evt.HouseDoor(463, 284)  -- "Hunter's Hovel"
evt.house[464] = 284  -- "Hunter's Hovel"
evt.HouseDoor(465, 285)  -- "Dervish's Cottage"
evt.house[466] = 285  -- "Dervish's Cottage"
evt.hint[467] = evt.str[100]  -- ""
evt.hint[468] = evt.str[100]  -- ""
evt.hint[469] = evt.str[100]  -- ""
evt.hint[470] = evt.str[100]  -- ""
evt.hint[471] = evt.str[100]  -- ""
evt.hint[472] = evt.str[100]  -- ""
evt.hint[479] = evt.str[100]  -- ""
evt.hint[490] = evt.str[100]  -- ""
evt.map[490] = function()  -- Timer(<function>, 7.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		evt.PlaySound{Id = 325, X = 4544, Y = 13872}
	end
end

Timer(evt.map[490].last, 7.5*const.Minute)

evt.hint[491] = evt.str[46]  -- "Ogre Raiding Fort"
evt.map[491] = function()
	evt.MoveToMap{X = -20497, Y = 1169, Z = 1051, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[495] = evt.str[40]  -- "Pine tree"
evt.map[495] = function()
	local i
	if evt.Cmp("QBits", 276) then         -- Reagant spout area 3
		return
	end
	if not evt.Cmp("PerceptionSkill", 5) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{-- ERROR: Not found
Item = 2138, X = 14624, Y = -160, Z = 3296, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gold Ring"
	elseif i == 2 then
		evt.SummonObject{-- ERROR: Not found
Item = 2139, X = 14624, Y = -160, Z = 3296, Speed = 1000, Count = 1, RandomAngle = true}         -- "Pearl Ring"
	elseif i == 3 then
		evt.SummonObject{-- ERROR: Not found
Item = 2140, X = 14624, Y = -160, Z = 3296, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gemstone Ring"
	else
		evt.SummonObject{-- ERROR: Not found
Item = 2141, X = 14624, Y = -160, Z = 3296, Speed = 1000, Count = 1, RandomAngle = true}         -- "Amethyst Ring"
	end
	evt.Add("QBits", 276)         -- Reagant spout area 3
end

evt.hint[496] = evt.str[40]  -- "Pine tree"
evt.map[496] = function()
	local i
	if evt.Cmp("QBits", 275) then         -- Reagant spout area 3
		return
	end
	if not evt.Cmp("PerceptionSkill", 7) then
		return
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.SummonObject{Item = 240, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Might Boost" : "Might Boost"
	elseif i == 2 then
		evt.SummonObject{Item = 241, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Intellect Boost" : "Intellect Boost"
	elseif i == 3 then
		evt.SummonObject{Item = 242, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Personality Boost" : "Personality Boost"
	elseif i == 4 then
		evt.SummonObject{Item = 243, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Endurance Boost" : "Endurance Boost"
	elseif i == 5 then
		evt.SummonObject{Item = 244, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Speed Boost" : "Speed Boost"
	else
		evt.SummonObject{Item = 245, X = -15104, Y = 19808, Z = 3698, Speed = 1000, Count = 1, RandomAngle = true}         -- "Accuracy Boost" : "Accuracy Boost"
	end
	evt.Add("QBits", 275)         -- Reagant spout area 3
end

evt.hint[501] = evt.str[50]  -- "Enter the Wasp Nest"
evt.map[501] = function()
	evt.MoveToMap{X = -2192, Y = -1840, Z = -127, Direction = 33, LookAngle = 0, SpeedZ = 0, HouseId = 197, Icon = 1, Name = "d11.blv"}         -- "Wasp Nest"
end

evt.hint[502] = evt.str[51]  -- "Enter the Ogre Raiding Fort"
evt.map[502] = function()
	evt.MoveToMap{X = -3424, Y = 32, Z = 0, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 198, Icon = 1, Name = "d12.blv"}         -- "Ogre Raiding Fort"
end

evt.hint[503] = evt.str[52]  -- "Enter the Dark Dwarf Compound"
evt.map[503] = function()
	evt.MoveToMap{X = -10528, Y = -352, Z = -896, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d41.blv"}
end

evt.hint[504] = evt.str[50]  -- "Enter the Wasp Nest"
evt.map[504] = function()
	evt.MoveToMap{X = 301, Y = 2162, Z = 513, Direction = 161, LookAngle = 0, SpeedZ = 0, HouseId = 197, Icon = 1, Name = "d11.blv"}         -- "Wasp Nest"
end

