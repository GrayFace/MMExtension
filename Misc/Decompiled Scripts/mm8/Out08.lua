local TXT = Localize{
	[0] = " ",
	[1] = "Ravage Roaming",
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
	[12] = "amonghiss",
	[13] = "Sealed Crate",
	[14] = "Open Crate",
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
	[40] = "Rock",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "Balthazar Lair",
	[46] = "Barbarian Fortress",
	[47] = "The Crypt of Korbu",
	[48] = "Church of Eep",
	[49] = "Gate to the Plane of Water",
	[50] = "Enter the Balthazar Lair",
	[51] = "Enter the Barbarian Fortress",
	[52] = "Enter the Crypt of Korbu",
	[53] = "Enter the Church of Eep",
	[54] = "Enter the Plane of Water",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Endurance +2 (Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(322)

evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.map[4] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	end
end

events.LoadMap = evt.map[4].last

evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 397)  -- "Xevius's Residence"
evt.house[12] = 397  -- "Xevius's Residence"
evt.HouseDoor(13, 398)  -- "Vish's House"
evt.house[14] = 398  -- "Vish's House"
evt.HouseDoor(15, 399)  -- "Sail's Shack"
evt.house[16] = 399  -- "Sail's Shack"
evt.HouseDoor(17, 400)  -- "Pordo's Hovel"
evt.house[18] = 400  -- "Pordo's Hovel"
evt.HouseDoor(19, 401)  -- "Galvinus's Home"
evt.house[20] = 401  -- "Galvinus's Home"
evt.HouseDoor(23, 452)  -- "Cagnor's Shop"
evt.house[24] = 452  -- "Cagnor's Shop"
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

evt.hint[87] = evt.str[14]  -- "Open Crate"
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

evt.hint[90] = evt.str[40]  -- "Rock"
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- "Chest"
evt.map[91] = function()
	evt.OpenChest(10)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
end

evt.hint[92] = evt.str[3]  -- "Chest"
evt.map[92] = function()
	evt.OpenChest(11)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
end

evt.hint[93] = evt.str[3]  -- "Chest"
evt.map[93] = function()
	evt.OpenChest(12)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
end

evt.hint[94] = evt.str[3]  -- "Chest"
evt.map[94] = function()
	evt.OpenChest(13)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
end

evt.hint[95] = evt.str[3]  -- "Chest"
evt.map[95] = function()
	evt.OpenChest(14)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
end

evt.hint[96] = evt.str[3]  -- "Chest"
evt.map[96] = function()
	evt.OpenChest(15)
	evt.Set("QBits", 168)         -- Found the treasure of the Dread Pirate Stanley!
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
				return
			end
		end
	end
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if evt.Cmp("BaseEndurance", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseEndurance", 2)
		evt.StatusText(60)         -- "Endurance +2 (Permanent)"
	end
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 193) then         -- Obelisk Area 8
		evt.StatusText(12)         -- "amonghiss"
		evt.Add("AutonotesBits", 20)         -- "Obelisk message #4: amonghiss"
		evt.Add("QBits", 193)         -- Obelisk Area 8
	end
end

evt.HouseDoor(183, 66)  -- "Mist"
evt.house[184] = 66  -- "Mist"
evt.HouseDoor(191, 114)  -- "Bull's Eye Inn"
evt.house[192] = 114  -- "Bull's Eye Inn"
evt.hint[401] = evt.str[45]  -- "Balthazar Lair"
evt.hint[402] = evt.str[46]  -- "Barbarian Fortress"
evt.hint[403] = evt.str[47]  -- "The Crypt of Korbu"
evt.hint[404] = evt.str[48]  -- "Church of Eep"
evt.hint[405] = evt.str[49]  -- "Gate to the Plane of Water"
evt.hint[406] = evt.str[13]  -- "Sealed Crate"
evt.hint[450] = evt.str[100]  -- ""
evt.hint[479] = evt.str[100]  -- ""
evt.map[479] = function()  -- Timer(<function>, 10*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 322, X = 7296, Y = -5280}
	elseif i == 2 then
		evt.PlaySound{Id = 322, X = -1580, Y = -4064}
	elseif i == 3 then
		evt.PlaySound{Id = 322, X = -11808, Y = -3392}
	elseif i == 4 then
		evt.PlaySound{Id = 322, X = -10816, Y = 4352}
	elseif i == 5 then
		evt.PlaySound{Id = 322, X = -1280, Y = 3776}
	end
end

Timer(evt.map[479].last, 10*const.Minute)

evt.hint[501] = evt.str[50]  -- "Enter the Balthazar Lair"
evt.map[501] = function()
	evt.MoveToMap{X = 1, Y = -100, Z = -85, Direction = 1540, LookAngle = 0, SpeedZ = 0, HouseId = 207, Icon = 1, Name = "d24.blv"}         -- "Minotaur Lair"
end

evt.hint[502] = evt.str[51]  -- "Enter the Barbarian Fortress"
evt.map[502] = function()
	evt.MoveToMap{X = -2284, Y = 1847, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 208, Icon = 1, Name = "d25.blv"}         -- "Barbarian Fortress"
end

evt.hint[503] = evt.str[52]  -- "Enter the Crypt of Korbu"
evt.map[503] = function()
	evt.MoveToMap{X = -4436, Y = -6538, Z = 317, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d26.blv"}
end

evt.hint[504] = evt.str[50]  -- "Enter the Balthazar Lair"
evt.map[504] = function()
	evt.MoveToMap{X = 832, Y = 849, Z = 44, Direction = 1548, LookAngle = 0, SpeedZ = 0, HouseId = 499, Icon = 1, Name = "d24.blv"}         -- "Balthazar Lair"
end

evt.hint[505] = evt.str[51]  -- "Enter the Barbarian Fortress"
evt.map[505] = function()
	evt.MoveToMap{X = 614, Y = 1858, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 208, Icon = 1, Name = "d25.blv"}         -- "Barbarian Fortress"
end

evt.hint[506] = evt.str[51]  -- "Enter the Barbarian Fortress"
evt.map[506] = function()
	evt.MoveToMap{X = 628, Y = -1274, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 208, Icon = 1, Name = "d25.blv"}         -- "Barbarian Fortress"
end

evt.hint[507] = evt.str[51]  -- "Enter the Barbarian Fortress"
evt.map[507] = function()
	evt.MoveToMap{X = -2284, Y = -1353, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 208, Icon = 1, Name = "d25.blv"}         -- "Barbarian Fortress"
end

evt.hint[508] = evt.str[54]  -- "Enter the Plane of Water"
evt.map[508] = function()
	evt.MoveToMap{X = -6144, Y = -20528, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 223, Icon = 1, Name = "ElemW.odm"}         -- "Gateway to the Plane of Water"
end

evt.hint[509] = evt.str[53]  -- "Enter the Church of Eep"
evt.map[509] = function()
	evt.MoveToMap{X = -21, Y = 5, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D46.blv"}
end

