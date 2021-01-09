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
	[17] = "",
	[18] = "",
	[19] = "Fruit Tree",
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "+50 Fire Resistance temporary.",
	[23] = "+5 Hit points restored.",
	[24] = "+5 Spell points restored.",
	[25] = "+2 Luck permanent",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter The Temple of the Moon",
	[31] = "Enter the Dragon's Cave",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "Lord Markham",
	[41] = "",
	[42] = "",
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

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[46]  -- "Welcome to Emerald Isle"
evt.HouseDoor(2, 1)  -- "The Knight's Blade"
evt.house[3] = 1  -- "The Knight's Blade"
evt.HouseDoor(4, 15)  -- "Erik's Armory"
evt.house[5] = 15  -- "Erik's Armory"
evt.HouseDoor(6, 29)  -- "Emerald Enchantments"
evt.house[7] = 29  -- "Emerald Enchantments"
evt.HouseDoor(8, 42)  -- "The Blue Bottle"
evt.house[9] = 42  -- "The Blue Bottle"
evt.HouseDoor(10, 74)  -- "Healer's Tent"
evt.house[11] = 74  -- "Healer's Tent"
evt.HouseDoor(12, 89)  -- "Island Training Grounds"
evt.house[13] = 89  -- "Island Training Grounds"
evt.HouseDoor(14, 107)  -- "Two Palms Tavern"
evt.house[15] = 107  -- "Two Palms Tavern"
evt.HouseDoor(16, 139)  -- "Initiate Guild of Fire"
evt.house[17] = 139  -- "Initiate Guild of Fire"
evt.HouseDoor(18, 143)  -- "Initiate Guild of Air"
evt.house[19] = 143  -- "Initiate Guild of Air"
evt.HouseDoor(20, 155)  -- "Initiate Guild of Spirit"
evt.house[21] = 155  -- "Initiate Guild of Spirit"
evt.HouseDoor(22, 163)  -- "Initiate Guild of Body"
evt.house[23] = 163  -- "Initiate Guild of Body"
evt.HouseDoor(24, 238)  -- "The Lady Margaret"
evt.house[25] = 63  -- "Lady Margaret"
evt.hint[49] = evt.str[7]  -- "House"
evt.HouseDoor(50, 224)  -- "Donna Wyrith's Residence"
evt.HouseDoor(51, 225)  -- "Mia Lucille' Home"
evt.HouseDoor(52, 226)  -- "Vandalir Residence"
evt.HouseDoor(53, 227)  -- "House 227"
evt.HouseDoor(54, 228)  -- "House 228"
evt.HouseDoor(55, 229)  -- "House 229"
evt.HouseDoor(56, 239)  -- "Carolyn Weathers' House"
evt.HouseDoor(57, 240)  -- "Tellmar Residence"
evt.HouseDoor(58, 241)  -- "House 241"
evt.HouseDoor(59, 242)  -- "House 242"
evt.HouseDoor(60, 254)  -- "House 254"
evt.HouseDoor(61, 255)  -- "House 255"
evt.HouseDoor(62, 255)  -- "House 255"
evt.hint[63] = evt.str[14]  -- "Anvil"
evt.hint[64] = evt.str[10]  -- "Cart"
evt.hint[65] = evt.str[9]  -- "Keg"
evt.HouseDoor(66, 186)  -- "Markham's Headquarters"
evt.house[67] = 186  -- "Markham's Headquarters"
evt.hint[68] = evt.str[36]  -- "Guilds"
evt.hint[69] = evt.str[39]  -- "Shops"
evt.hint[70] = evt.str[40]  -- "Lord Markham"
evt.hint[101] = evt.str[30]  -- "Enter The Temple of the Moon"
evt.map[101] = function()
	evt.MoveToMap{X = -1208, Y = -4225, Z = 366, Direction = 320, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 3, Name = "D06.blv"}         -- "Temple of the Moon"
end

evt.hint[102] = evt.str[31]  -- "Enter the Dragon's Cave"
evt.map[102] = function()
	evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 192, Icon = 3, Name = "D28.Blv"}         -- "Dragon's Lair"
end

evt.hint[109] = evt.str[3]  -- "Well"
evt.hint[110] = evt.str[4]  -- "Drink from the Well"
evt.map[110] = function()
	if evt.Cmp("FireResBonus", 50) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Set("FireResBonus", 50)
		evt.StatusText(22)         -- "+50 Fire Resistance temporary."
		evt.Add("AutonotesBits", 2)         -- ""
	end
end

evt.map[111] = function()  -- RefillTimer(<function>, const.Day)
	evt.Set("MapVar0", 30)
	evt.Set("MapVar1", 30)
end

RefillTimer(evt.map[111].last, const.Day)

evt.hint[112] = evt.str[4]  -- "Drink from the Well"
evt.map[112] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("HP", 5)
		evt.Add("AutonotesBits", 3)         -- ""
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
	evt.Set("AutonotesBits", 4)         -- ""
end

evt.hint[114] = evt.str[4]  -- "Drink from the Well"
evt.map[114] = function()
	if not evt.Cmp("BaseLuck", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BaseLuck", 2)
			evt.Add("AutonotesBits", 5)         -- ""
			evt.StatusText(25)         -- "+2 Luck permanent"
			return
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar2", 8)
end, const.Month)

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
end, const.Week)

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
		evt.SpeakNPC(19)         -- "Margaret the Docent"
	end
end

evt.map[201] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(20)         -- "Margaret the Docent"
	end
end

evt.map[202] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(21)         -- "Margaret the Docent"
	end
end

evt.map[203] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(22)         -- "Margaret the Docent"
	end
end

evt.map[204] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(23)         -- "Margaret the Docent"
	end
end

evt.map[205] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(24)         -- "Margaret the Docent"
	end
end

evt.map[206] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(25)         -- "Margaret the Docent"
	end
end

evt.map[207] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(26)         -- "Margaret the Docent"
	end
end

evt.map[208] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(27)         -- "Margaret the Docent"
	end
end

evt.map[209] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(28)         -- "Margaret the Docent"
	end
end

evt.map[210] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(29)         -- "Margaret the Docent"
	end
end

evt.map[211] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(30)         -- "Margaret the Docent"
	end
end

evt.map[212] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(31)         -- "Margaret the Docent"
	end
end

evt.map[213] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(32)         -- "Margaret the Docent"
	end
end

evt.map[214] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(33)         -- "Margaret the Docent"
	end
end

evt.map[215] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(34)         -- "Margaret the Docent"
	end
end

evt.map[216] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(35)         -- "Margaret the Docent"
	end
end

evt.map[217] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(36)         -- "Margaret the Docent"
	end
end

evt.map[218] = function()
	if not evt.Cmp("QBits", 17) then         -- No more docent babble
		evt.SpeakNPC(37)         -- "Margaret the Docent"
	end
end

evt.hint[219] = evt.str[15]  -- "Button"
evt.map[219] = function()
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 10, FromX = 10495, FromY = 17724, FromZ = 2370, ToX = 10495, ToY = 24144, ToZ = 4500}         -- "Death Blossom"
end

evt.hint[220] = evt.str[100]  -- ""
evt.map[220] = function()  -- RefillTimer(<function>, const.Day)
	if evt.CheckMonstersKilled{CheckType = 1, Id = 20, Count = 0} then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -336, Y = 14512, Z = 0, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = 16, Y = 16352, Z = 90, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 480, Y = 18288, Z = 6, NPCGroup = 20, unk = 0}         -- "Ridge walkers in Bracada"
	end
end

RefillTimer(evt.map[220].last, const.Day)

