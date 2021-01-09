local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Trash Heap",
	[9] = "Keg",
	[10] = "Cart",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Anvil",
	[15] = "Button",
	[16] = "Chest",
	[17] = "Event 46",
	[18] = "Event 1",
	[19] = "Fruit Tree",
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "+50 Fire Resistance temporary.",
	[23] = "+5 Hit points restored.",
	[24] = "+5 Spell points restored.",
	[25] = "+2 Luck permanent",
	[26] = "Event 15",
	[27] = "Event 29",
	[28] = "Event 42",
	[29] = "Event 74",
	[30] = "Enter The Temple of the Moon",
	[31] = "Enter the Dragon's Cave",
	[32] = "Event 89",
	[33] = "Event 107",
	[34] = "Event 139",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "Lord Markham",
	[41] = "This cave is sealed by a powerful magical ward.",
	[42] = "Enjoy 'The Game'",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "Welcome to Emerald Isle",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "Nothing Seems to have happened",
	[52] = "Shrine",
	[53] = "Alter",
	[54] = "You Pray",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[46]  -- "Welcome to Emerald Isle"
evt.house[2] = 1  -- "The Knight's Blade"
evt.map[2] = function()
	evt.EnterHouse(1)         -- "The Knight's Blade"
end

evt.house[3] = 1  -- "The Knight's Blade"
evt.map[3] = function()
end

evt.house[4] = 15  -- "Erik's Armory"
evt.map[4] = function()
	evt.EnterHouse(15)         -- "Erik's Armory"
end

evt.house[5] = 15  -- "Erik's Armory"
evt.map[5] = function()
end

evt.house[6] = 29  -- "Emerald Enchantments"
evt.map[6] = function()
	evt.EnterHouse(29)         -- "Emerald Enchantments"
end

evt.house[7] = 29  -- "Emerald Enchantments"
evt.map[7] = function()
end

evt.house[8] = 42  -- "The Blue Bottle"
evt.map[8] = function()
	evt.EnterHouse(42)         -- "The Blue Bottle"
end

evt.house[9] = 42  -- "The Blue Bottle"
evt.map[9] = function()
end

evt.house[10] = 74  -- "Healer's Tent"
evt.map[10] = function()
	evt.EnterHouse(74)         -- "Healer's Tent"
end

evt.house[11] = 74  -- "Healer's Tent"
evt.map[11] = function()
end

evt.house[12] = 89  -- "Island Training Grounds"
evt.map[12] = function()
	evt.EnterHouse(89)         -- "Island Training Grounds"
end

evt.house[13] = 89  -- "Island Training Grounds"
evt.map[13] = function()
end

evt.house[14] = 107  -- "Two Palms Tavern"
evt.map[14] = function()
	evt.EnterHouse(107)         -- "Two Palms Tavern"
end

evt.house[15] = 107  -- "Two Palms Tavern"
evt.map[15] = function()
end

evt.house[16] = 139  -- "Initiate Guild of Fire"
evt.map[16] = function()
	evt.EnterHouse(139)         -- "Initiate Guild of Fire"
end

evt.house[17] = 139  -- "Initiate Guild of Fire"
evt.map[17] = function()
end

evt.house[18] = 143  -- "Initiate Guild of Air"
evt.map[18] = function()
	evt.EnterHouse(143)         -- "Initiate Guild of Air"
end

evt.house[19] = 143  -- "Initiate Guild of Air"
evt.map[19] = function()
end

evt.house[20] = 155  -- "Initiate Guild of Spirit"
evt.map[20] = function()
	evt.EnterHouse(155)         -- "Initiate Guild of Spirit"
end

evt.house[21] = 155  -- "Initiate Guild of Spirit"
evt.map[21] = function()
end

evt.house[22] = 163  -- "Initiate Guild of Body"
evt.map[22] = function()
	evt.EnterHouse(163)         -- "Initiate Guild of Body"
end

evt.house[23] = 163  -- "Initiate Guild of Body"
evt.map[23] = function()
end

evt.house[24] = 238  -- "The Lady Margaret"
evt.map[24] = function()
	evt.EnterHouse(238)         -- "The Lady Margaret"
end

evt.house[25] = 63  -- "Lady Margaret"
evt.map[25] = function()
end

evt.hint[26] = evt.str[100]  -- ""
evt.map[26] = function()  -- function events.LoadMap()
	evt.Subtract("NPCs", 3)         -- "Big Daddy Jim"
end

events.LoadMap = evt.map[26].last

evt.hint[37] = evt.str[100]  -- ""
evt.map[37] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 294) then         -- Return to EI
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 3244, Y = 9265, Z = 900, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 4406, Y = 8851, Z = 900, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = 500, Y = 8191, Z = 700, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = 5893, Y = 8379, Z = 400, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 6758, Y = 8856, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 7738, Y = 7005, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = 8402, Y = 7527, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 5, X = 9881, Y = 7481, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 11039, Y = 7117, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12360, Y = 6764, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 13389, Y = 6797, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 14777, Y = 6911, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12560, Y = 5717, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 5, X = 12438, Y = 4787, Z = 170, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 12481, Y = 3299, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 12674, Y = 2105, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 11248, Y = 2852, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = 9585, Y = 5015, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 12205, Y = 4919, Z = 170, -- ERROR: Not found
NPCGroup = 2047, unk = 0}
		evt.SpeakNPC(17)         -- "Sally"
		evt.Subtract("QBits", 294)         -- Return to EI
	end
end

events.LoadMap = evt.map[37].last

evt.hint[49] = evt.str[7]  -- "House"
evt.house[50] = 224  -- "Donna Wyrith's Residence"
evt.map[50] = function()
	evt.EnterHouse(224)         -- "Donna Wyrith's Residence"
end

evt.house[51] = 225  -- "Mia Lucille' Home"
evt.map[51] = function()
	evt.EnterHouse(225)         -- "Mia Lucille' Home"
end

evt.house[52] = 523  -- "Zedd's Place"
evt.map[52] = function()
	evt.EnterHouse(523)         -- "Zedd's Place"
end

evt.house[53] = 227  -- "House 227"
evt.map[53] = function()
	evt.EnterHouse(227)         -- "House 227"
end

evt.house[54] = 228  -- "House 228"
evt.map[54] = function()
	evt.EnterHouse(228)         -- "House 228"
end

evt.house[55] = 229  -- "House 229"
evt.map[55] = function()
	evt.EnterHouse(229)         -- "House 229"
end

evt.house[56] = 239  -- "Carolyn Weathers' House"
evt.map[56] = function()
	evt.EnterHouse(239)         -- "Carolyn Weathers' House"
end

evt.house[57] = 240  -- "Tellmar Residence"
evt.map[57] = function()
	evt.EnterHouse(240)         -- "Tellmar Residence"
end

evt.house[58] = 241  -- "House 241"
evt.map[58] = function()
	evt.EnterHouse(241)         -- "House 241"
end

evt.house[59] = 242  -- "House 242"
evt.map[59] = function()
	evt.EnterHouse(242)         -- "House 242"
end

evt.house[60] = 254  -- "House 254"
evt.map[60] = function()
	evt.EnterHouse(254)         -- "House 254"
end

evt.house[61] = 255  -- "House 255"
evt.map[61] = function()
	evt.EnterHouse(255)         -- "House 255"
end

evt.house[62] = 255  -- "House 255"
evt.map[62] = function()
	evt.EnterHouse(255)         -- "House 255"
end

evt.hint[63] = evt.str[14]  -- "Anvil"
evt.hint[64] = evt.str[10]  -- "Cart"
evt.hint[65] = evt.str[9]  -- "Keg"
evt.house[66] = 186  -- "Markham's Headquarters"
evt.map[66] = function()
	evt.EnterHouse(186)         -- "Markham's Headquarters"
end

evt.house[67] = 186  -- "Markham's Headquarters"
evt.map[67] = function()
end

evt.hint[68] = evt.str[36]  -- "Guilds"
evt.hint[69] = evt.str[39]  -- "Shops"
evt.hint[70] = evt.str[40]  -- "Lord Markham"
evt.hint[101] = evt.str[30]  -- "Enter The Temple of the Moon"
evt.map[101] = function()
	evt.MoveToMap{X = -1208, Y = -4225, Z = 366, Direction = 320, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 3, Name = "D06.blv"}         -- "Temple of the Moon"
end

evt.hint[102] = evt.str[31]  -- "Enter the Dragon's Cave"
evt.map[102] = function()
	if evt.Cmp("Inventory", 562) then         -- "Ring of UnWarding"
		evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 192, Icon = 3, Name = "D28.Blv"}         -- "Dragon's Lair"
	else
		evt.StatusText(41)         -- "This cave is sealed by a powerful magical ward."
	end
end

evt.hint[109] = evt.str[3]  -- "Well"
evt.hint[110] = evt.str[4]  -- "Drink from the Well"
evt.map[110] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 316) then         -- 1-time EI Well
		evt.Set("QBits", 316)         -- 1-time EI Well
		evt.Add("BaseEndurance", 32)
		evt.Add("SkillPoints", 5)
	else
		if evt.Cmp("FireResBonus", 50) then
			evt.StatusText(11)         -- "Refreshing!"
		else
			evt.Set("FireResBonus", 50)
			evt.StatusText(22)         -- "+50 Fire Resistance temporary."
			evt.Add("AutonotesBits", 2)         -- "50 points of temporary Fire resistance from the central town well on Emerald Island."
		end
	end
end

evt.map[111] = function()  -- Timer(<function>, const.Day, 1*const.Second)
	evt.Set("MapVar0", 30)
	evt.Set("MapVar1", 30)
end

Timer(evt.map[111].last, const.Day, 1*const.Second)

evt.hint[112] = evt.str[4]  -- "Drink from the Well"
evt.map[112] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("HP", 5)
		evt.Add("AutonotesBits", 3)         -- "5 Hit Points regained from the well east of the Temple on Emerald Island."
		evt.StatusText(23)         -- "+5 Hit points restored."
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
end

evt.hint[113] = evt.str[4]  -- "Drink from the Well"
evt.map[113] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.Subtract("MapVar1", 1)
		evt.Add("SP", 5)
		evt.StatusText(24)         -- "+5 Spell points restored."
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 4)         -- "5 Spell Points regained from the well west of the Temple on Emerald Island."
end

evt.hint[114] = evt.str[4]  -- "Drink from the Well"
evt.map[114] = function()
	if evt.Cmp("QBits", 24) then         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
		goto _15
	end
	if evt.Cmp("QBits", 26) then         -- "Find the Blessed Panoply of Sir BunGleau and return  to William Setag in the Deyja Moors."
		goto _15
	end
	if not evt.Cmp("BaseLuck", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BaseLuck", 2)
			evt.StatusText(25)         -- "+2 Luck permanent"
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
	do return end
::_15::
	evt.MoveToMap{X = 9828, Y = 6144, Z = 97, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "mdt09.blv"}
end

RefillTimer(function()
	evt.Set("MapVar2", 8)
end, const.Month, true)

evt.hint[115] = evt.str[4]  -- "Drink from the Well"
evt.map[115] = function()
	if not evt.Cmp("MapVar4", 3) then
		if not evt.Cmp("MapVar3", 1) then
			if not evt.Cmp("Gold", 201) then
				if evt.Cmp("BaseLuck", 15) then
					evt.Add("MapVar3", 1)
					evt.Add("Gold", 1000)
					evt.Add("MapVar4", 1)
					return
				end
			end
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar3", 0)
end, const.Week, true)

evt.hint[118] = evt.str[1]  -- "Crate"
evt.map[118] = function()
	evt.OpenChest(1)
end

evt.hint[119] = evt.str[1]  -- "Crate"
evt.map[119] = function()
	evt.OpenChest(2)
end

evt.hint[120] = evt.str[1]  -- "Crate"
evt.map[120] = function()
	evt.OpenChest(3)
end

evt.hint[121] = evt.str[1]  -- "Crate"
evt.map[121] = function()
	evt.OpenChest(4)
end

evt.hint[122] = evt.str[1]  -- "Crate"
evt.map[122] = function()
	evt.OpenChest(5)
end

evt.hint[123] = evt.str[1]  -- "Crate"
evt.map[123] = function()
	evt.OpenChest(6)
end

evt.hint[124] = evt.str[16]  -- "Chest"
evt.map[124] = function()
	evt.OpenChest(7)
end

evt.map[200] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(3)         -- "Big Daddy Jim"
	end
	evt.Set("QBits", 17)         -- No more docent babble
end

evt.map[201] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(20)         -- "Baron BunGleau"
	end
end

evt.map[202] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(21)         -- "Zedd True Shot"
	end
end

evt.map[203] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(22)         -- "Alex the Mentor"
	end
end

evt.map[204] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(23)         -- "Alex the Mentor"
	end
end

evt.map[205] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(24)         -- "Alex the Mentor"
	end
end

evt.map[206] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(25)         -- "Operator"
	end
end

evt.map[207] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(26)         -- "Count ZERO"
	end
end

evt.map[208] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(27)         -- "Messenger"
	end
end

evt.map[209] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(28)         -- "Alex the Mentor"
	end
end

evt.map[210] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(29)         -- "Alex the Mentor"
	end
end

evt.map[211] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(30)         -- "Doom Bearer"
	end
end

evt.map[212] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(31)         -- "Alex the Mentor"
	end
end

evt.map[213] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(32)         -- "Myrta Bumblebee"
	end
end

evt.map[214] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(33)         -- "Alex the Mentor"
	end
end

evt.map[215] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(34)         -- "Duke Bimbasto"
	end
end

evt.map[216] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(35)         -- "Sir Vilx of Stone City"
	end
end

evt.map[217] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(36)         -- "Alex the Mentor"
	end
end

evt.map[218] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(37)         -- "Pascal the Mad Mage"
	end
end

evt.hint[219] = evt.str[15]  -- "Button"
evt.map[219] = function()
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 10, FromX = 10495, FromY = 17724, FromZ = 2370, ToX = 10495, ToY = 24144, ToZ = 4500}         -- "Death Blossom"
end

evt.hint[220] = evt.str[100]  -- ""
evt.map[220] = function()  -- Timer(<function>, const.Day, 1*const.Hour)
	if evt.CheckMonstersKilled{CheckType = 1, Id = 20, Count = 0} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -336, Y = 14512, Z = 0, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = 16, Y = 16352, Z = 90, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 480, Y = 18288, Z = 6, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
	end
end

Timer(evt.map[220].last, const.Day, 1*const.Hour)

evt.map[573] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 738) then         -- "Lost Scroll of Wonka"
		evt.SetMessage(768)
		return
	end
	evt.SetMessage(769)
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 8)
	end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 272)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.Subtract("Inventory", 738)         -- "Lost Scroll of Wonka"
	evt.Add("Awards", 87)         -- "Recovered the Lost Scroll of  Wonka"
	evt.SetNPCTopic{NPC = 139, Index = 1, Event = 0}         -- "Blayze "
	evt.Add("Experience", 40000)
end

evt.map[574] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 559) then         -- "Watcher's Ring of Elemental Water"
		evt.SetMessage(772)
		evt.SetNPCTopic{NPC = 144, Index = 0, Event = 575}         -- "Tobren Rainshield" : "The Greatest Hero"
		return
	end
	if not evt.Cmp("Inventory", 326) then         -- "Water Walk"
		evt.ForPlayer("Current")
		evt.Set("Inventory", 326)         -- "Water Walk"
	end
	evt.SetMessage(771)
end

evt.map[575] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("WaterSkill", 136) then
		evt.SetMessage(130)
	else
		if not evt.Cmp("WaterSkill", 72) then
			evt.SetMessage(126)
		else
			if evt.Cmp("Gold", 3000) then
				evt.Add("WaterSkill", 128)
				evt.Subtract("Gold", 3000)
				evt.SetMessage(133)
			else
				evt.SetMessage(125)
			end
		end
	end
end

