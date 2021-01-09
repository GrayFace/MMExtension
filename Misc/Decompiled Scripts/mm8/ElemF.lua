local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Plane of Fire",
	[2] = "Gate out of the Plane of Fire",
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
	[28] = "Take a Drink",
	[29] = "Refreshing",
	[30] = "Fire Resistance +25 (Temporary)",
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
	[45] = "Castle of Fire",
	[46] = "War Camp",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Enter the Castle of Fire",
	[51] = "Enter the War Camp",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 242) then         -- Got the heart of fire
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 606) then         -- "Heart of Fire"
			evt.Add("QBits", 242)         -- Got the heart of fire
			evt.Add("Experience", 100000)
			evt.Add("QBits", 205)         -- Heart of Fire - I lost it
		end
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 467)  -- "Ember's House"
evt.house[12] = 467  -- "Ember's House"
evt.HouseDoor(13, 468)  -- "Evenblaze's House"
evt.house[14] = 468  -- "Evenblaze's House"
evt.HouseDoor(15, 469)  -- "Empty House"
evt.house[16] = 469  -- "Empty House"
evt.HouseDoor(17, 470)  -- "Empty House"
evt.house[18] = 470  -- "Empty House"
evt.HouseDoor(19, 471)  -- "Empty House"
evt.house[20] = 471  -- "Empty House"
evt.HouseDoor(21, 321)  -- "Burn's House"
evt.house[22] = 321  -- "Burn's House"
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

evt.hint[401] = evt.str[45]  -- "Castle of Fire"
evt.hint[402] = evt.str[46]  -- "War Camp"
evt.hint[403] = evt.str[2]  -- "Gate out of the Plane of Fire"
evt.hint[451] = evt.str[28]  -- "Take a Drink"
evt.map[451] = function()
	if evt.Cmp("FireResBonus", 25) then
		evt.StatusText(29)         -- "Refreshing"
	else
		evt.Add("FireResBonus", 25)
		evt.StatusText(30)         -- "Fire Resistance +25 (Temporary)"
		evt.Add("AutonotesBits", 270)         -- "Well in the Plane of Fire gives a temporary Fire Resistance bonus of 25."
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	evt.Jump{Direction = 1024, ZAngle = 512, Speed = 1500}
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	evt.Jump{Direction = 1536, ZAngle = 512, Speed = 1500}
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	evt.Jump{Direction = 0, ZAngle = 512, Speed = 1500}
end

evt.hint[501] = evt.str[50]  -- "Enter the Castle of Fire"
evt.map[501] = function()
	evt.MoveToMap{X = 1, Y = 1, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 216, Icon = 1, Name = "d29.blv"}         -- "Castle of Fire"
end

evt.hint[502] = evt.str[51]  -- "Enter the War Camp"
evt.map[502] = function()
	evt.MoveToMap{X = 4, Y = -1050, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 217, Icon = 1, Name = "d30.blv"}         -- "War Camp"
end

evt.hint[505] = evt.str[1]  -- "Leave the Plane of Fire"
evt.map[505] = function()
	evt.MoveToMap{X = 20912, Y = 20208, Z = 918, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out04.odm"}
end

