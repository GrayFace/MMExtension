local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "",
	[31] = "",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "A giant's sword",
	[44] = "Escaton's Crystal",
	[45] = "Escaton's Palace",
	[46] = "Prison of the Air Lord",
	[47] = "Prison of the Earth Lord",
	[48] = "Prison of the Fire Lord",
	[49] = "Prison of the Water Lord",
	[50] = "Enter Escaton's Palace",
	[51] = "Enter the Prison of the Air Lord",
	[52] = "Enter the Prison of the Fire Lord",
	[53] = "Enter the Prison of the Water Lord",
	[54] = "Enter the Prison of the Earth Lord",
	[55] = "Enter Escaton's Crystal",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.hint[81] = evt.str[3]  -- ""
evt.map[81] = function()
	evt.OpenChest(0)
end

evt.hint[82] = evt.str[3]  -- ""
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- ""
evt.map[83] = function()
	evt.OpenChest(2)
end

evt.hint[84] = evt.str[3]  -- ""
evt.map[84] = function()
	evt.OpenChest(3)
end

evt.hint[85] = evt.str[3]  -- ""
evt.map[85] = function()
	evt.OpenChest(4)
end

evt.hint[86] = evt.str[3]  -- ""
evt.map[86] = function()
	evt.OpenChest(5)
end

evt.hint[87] = evt.str[3]  -- ""
evt.map[87] = function()
	evt.OpenChest(6)
end

evt.hint[88] = evt.str[3]  -- ""
evt.map[88] = function()
	evt.OpenChest(7)
end

evt.hint[89] = evt.str[3]  -- ""
evt.map[89] = function()
	evt.OpenChest(8)
end

evt.hint[90] = evt.str[3]  -- ""
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- ""
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[3]  -- ""
evt.map[92] = function()
	evt.OpenChest(11)
end

evt.hint[93] = evt.str[3]  -- ""
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[3]  -- ""
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[3]  -- ""
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[3]  -- ""
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[3]  -- ""
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[3]  -- ""
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[3]  -- ""
evt.map[99] = function()
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[3]  -- ""
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.hint[401] = evt.str[45]  -- "Escaton's Palace"
evt.hint[402] = evt.str[46]  -- "Prison of the Air Lord"
evt.hint[403] = evt.str[47]  -- "Prison of the Earth Lord"
evt.hint[404] = evt.str[48]  -- "Prison of the Fire Lord"
evt.hint[405] = evt.str[49]  -- "Prison of the Water Lord"
evt.hint[406] = evt.str[44]  -- "Escaton's Crystal"
evt.hint[501] = evt.str[50]  -- "Enter Escaton's Palace"
evt.map[501] = function()
	evt.MoveToMap{X = -704, Y = -5312, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 218, Icon = 1, Name = "d35.blv"}         -- "Escaton's Palace"
end

evt.hint[502] = evt.str[51]  -- "Enter the Prison of the Air Lord"
evt.map[502] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Ring of Keys"
		evt.MoveToMap{X = -733, Y = -2563, Z = -1051, Direction = 960, LookAngle = 0, SpeedZ = 0, HouseId = 219, Icon = 1, Name = "d36.blv"}         -- "Prison of the Lord of Air"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[503] = evt.str[52]  -- "Enter the Prison of the Fire Lord"
evt.map[503] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Ring of Keys"
		evt.MoveToMap{X = -128, Y = 896, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 455, Icon = 1, Name = "d37.blv"}         -- "Prison of the Lord of Fire"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[504] = evt.str[53]  -- "Enter the Prison of the Water Lord"
evt.map[504] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Ring of Keys"
		evt.MoveToMap{X = 2393, Y = -10664, Z = 1, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 456, Icon = 1, Name = "d38.blv"}         -- "Prison of the Lord of Water"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[505] = evt.str[54]  -- "Enter the Prison of the Earth Lord"
evt.map[505] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Ring of Keys"
		evt.MoveToMap{X = -2, Y = 118, Z = 1, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 454, Icon = 1, Name = "d39.blv"}         -- "Prison of the Lord of Earth"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[506] = evt.str[55]  -- "Enter Escaton's Crystal"
evt.map[506] = function()
	evt.MoveToMap{X = -14232, Y = -2956, Z = 800, Direction = 432, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D10.blv"}
end

evt.hint[507] = evt.str[43]  -- "A giant's sword"
evt.map[507] = function()
	if evt.Cmp("Inventory", 634) then         -- "Flute"
		evt.MoveToMap{X = 19, Y = -601, Z = 1, Direction = 1552, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "d50.blv"}
	end
end

