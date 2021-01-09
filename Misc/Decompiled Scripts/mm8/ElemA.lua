local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Plane of Air",
	[2] = "Gate out of the Plane of Air",
	[3] = "Chest",
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
	[28] = "Take a Drink",
	[29] = "Refreshing",
	[30] = "Air Resistance +10 (Permanent)",
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
	[43] = "",
	[44] = "",
	[45] = "Castle of Air",
	[46] = "Raven Man Nest",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Enter the Castle of Air",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 243) then         -- Got the heart of air
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 608) then         -- "Heart of Air"
			evt.Add("QBits", 243)         -- Got the heart of air
			evt.Add("Experience", 100000)
			evt.Add("QBits", 207)         -- Heart of Air - I lost it
		end
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 443)  -- "Wingsail's House"
evt.house[12] = 443  -- "Wingsail's House"
evt.HouseDoor(13, 444)  -- "Vapor's House"
evt.house[14] = 444  -- "Vapor's House"
evt.HouseDoor(15, 445)  -- "Zephyr's House"
evt.house[16] = 445  -- "Zephyr's House"
evt.HouseDoor(17, 446)  -- "Empty House"
evt.house[18] = 446  -- "Empty House"
evt.HouseDoor(19, 447)  -- "Empty House"
evt.house[20] = 447  -- "Empty House"
evt.HouseDoor(21, 448)  -- "Empty House"
evt.house[22] = 448  -- "Empty House"
evt.HouseDoor(23, 449)  -- "Empty House"
evt.house[24] = 449  -- "Empty House"
evt.HouseDoor(25, 450)  -- "Nedlon's House"
evt.house[26] = 450  -- "Nedlon's House"
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

evt.hint[401] = evt.str[45]  -- "Castle of Air"
evt.hint[402] = evt.str[46]  -- "Raven Man Nest"
evt.hint[403] = evt.str[2]  -- "Gate out of the Plane of Air"
evt.hint[451] = evt.str[28]  -- "Take a Drink"
evt.map[451] = function()
	if evt.Cmp("AirResistance", 10) then
		evt.StatusText(29)         -- "Refreshing"
	else
		evt.Add("AirResistance", 2)
		evt.StatusText(30)         -- "Air Resistance +10 (Permanent)"
		evt.Add("AutonotesBits", 268)         -- "Well in the Plane of Air gives a permanent Air Resistance bonus up to an Air Resistance of 10."
	end
end

evt.hint[501] = evt.str[50]  -- "Enter the Castle of Air"
evt.map[501] = function()
	evt.MoveToMap{X = -545, Y = -2124, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 214, Icon = 1, Name = "D27.blv"}         -- "Castle of Air"
end

evt.hint[505] = evt.str[1]  -- "Leave the Plane of Air"
evt.map[505] = function()
	evt.MoveToMap{X = -334, Y = 21718, Z = 385, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out07.odm"}
end

