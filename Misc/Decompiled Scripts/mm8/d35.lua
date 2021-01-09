local TXT = Localize{
	[0] = " ",
	[1] = "Leave Escaton's Palace",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "Take a Drink",
	[7] = "Refreshing",
	[8] = "",
	[9] = "Bookshelf",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
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
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "",
	[51] = "",
	[52] = "",
	[53] = "",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "",
	[71] = "",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "",
	[77] = "",
	[78] = "",
	[79] = "",
	[80] = "",
	[81] = "",
	[82] = "",
	[83] = "",
	[84] = "",
	[85] = "",
	[86] = "",
	[87] = "",
	[88] = "",
	[89] = "",
	[90] = "",
	[91] = "",
	[92] = "",
	[93] = "",
	[94] = "",
	[95] = "",
	[96] = "",
	[97] = "",
	[98] = "",
	[99] = "",
	[100] = "prison",
	[101] = "jail",
	[102] = "in",
	[103] = "inside",
	[104] = "egg",
	[105] = "an egg",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- "prison"
evt.hint[2] = evt.str[100]  -- "prison"
evt.hint[3] = evt.str[100]  -- "prison"
evt.hint[4] = evt.str[100]  -- "prison"
evt.hint[5] = evt.str[100]  -- "prison"
evt.hint[6] = evt.str[100]  -- "prison"
evt.hint[7] = evt.str[100]  -- "prison"
evt.hint[8] = evt.str[100]  -- "prison"
evt.hint[9] = evt.str[100]  -- "prison"
evt.hint[10] = evt.str[100]  -- "prison"
evt.hint[11] = evt.str[2]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[12] = evt.str[2]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[13] = evt.str[2]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[14] = evt.str[2]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[15] = evt.str[2]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[16] = evt.str[2]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[17] = evt.str[2]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[18] = evt.str[2]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[19] = evt.str[2]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[20] = evt.str[2]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[21] = evt.str[2]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[22] = evt.str[2]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[23] = evt.str[2]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[24] = evt.str[2]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[25] = evt.str[2]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[26] = evt.str[2]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[27] = evt.str[2]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[28] = evt.str[2]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[29] = evt.str[2]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[30] = evt.str[2]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 20, State = 0}
end

evt.hint[31] = evt.str[2]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[32] = evt.str[2]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[33] = evt.str[2]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[34] = evt.str[2]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[35] = evt.str[2]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[36] = evt.str[2]  -- "Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[37] = evt.str[2]  -- "Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[38] = evt.str[2]  -- "Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[50] = evt.str[4]  -- "Lever"
evt.map[50] = function()
	evt.SetDoorState{Id = 29, State = 0}
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[51] = evt.str[4]  -- "Lever"
evt.map[51] = function()
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[52] = evt.str[4]  -- "Lever"
evt.map[52] = function()
	evt.SetDoorState{Id = 33, State = 0}
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[53] = evt.str[4]  -- "Lever"
evt.map[53] = function()
	evt.SetDoorState{Id = 35, State = 0}
	evt.SetDoorState{Id = 36, State = 0}
end

evt.hint[54] = evt.str[4]  -- "Lever"
evt.map[54] = function()
	evt.SetDoorState{Id = 37, State = 0}
	evt.SetDoorState{Id = 38, State = 0}
end

evt.hint[55] = evt.str[5]  -- "Button"
evt.map[55] = function()
	evt.SetDoorState{Id = 39, State = 0}
	evt.SetDoorState{Id = 40, State = 0}
end

evt.hint[56] = evt.str[4]  -- "Lever"
evt.map[56] = function()
	evt.SetDoorState{Id = 41, State = 0}
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[57] = evt.str[4]  -- "Lever"
evt.map[57] = function()
	evt.SetDoorState{Id = 43, State = 0}
	evt.SetDoorState{Id = 44, State = 0}
end

evt.hint[58] = evt.str[5]  -- "Button"
evt.map[58] = function()
	evt.SetDoorState{Id = 45, State = 0}
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[59] = evt.str[4]  -- "Lever"
evt.map[59] = function()
	evt.SetDoorState{Id = 47, State = 0}
	evt.SetDoorState{Id = 48, State = 0}
end

evt.hint[60] = evt.str[5]  -- "Button"
evt.map[60] = function()
	evt.SetDoorState{Id = 49, State = 0}
	evt.SetDoorState{Id = 50, State = 0}
end

evt.hint[61] = evt.str[4]  -- "Lever"
evt.map[61] = function()
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
end

evt.hint[62] = evt.str[4]  -- "Lever"
evt.map[62] = function()
	evt.SetDoorState{Id = 53, State = 0}
	evt.SetDoorState{Id = 54, State = 0}
end

evt.hint[63] = evt.str[5]  -- "Button"
evt.map[63] = function()
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
end

evt.hint[64] = evt.str[2]  -- "Door"
evt.map[64] = function()
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
end

evt.hint[65] = evt.str[2]  -- "Door"
evt.map[65] = function()
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
end

evt.hint[66] = evt.str[2]  -- "Door"
evt.map[66] = function()
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
end

evt.hint[67] = evt.str[2]  -- "Door"
evt.map[67] = function()
	evt.SetDoorState{Id = 63, State = 0}
	evt.SetDoorState{Id = 64, State = 0}
end

evt.hint[68] = evt.str[2]  -- "Door"
evt.map[68] = function()
	evt.SetDoorState{Id = 65, State = 0}
	evt.SetDoorState{Id = 66, State = 0}
end

evt.hint[69] = evt.str[2]  -- "Door"
evt.map[69] = function()
	evt.SetDoorState{Id = 67, State = 0}
	evt.SetDoorState{Id = 68, State = 0}
end

evt.hint[70] = evt.str[2]  -- "Door"
evt.map[70] = function()
	evt.SetDoorState{Id = 69, State = 0}
	evt.SetDoorState{Id = 70, State = 0}
end

evt.hint[71] = evt.str[2]  -- "Door"
evt.map[71] = function()
	evt.SetDoorState{Id = 71, State = 0}
	evt.SetDoorState{Id = 72, State = 0}
end

evt.hint[72] = evt.str[2]  -- "Door"
evt.map[72] = function()
	evt.SetDoorState{Id = 73, State = 0}
	evt.SetDoorState{Id = 74, State = 0}
end

evt.hint[73] = evt.str[2]  -- "Door"
evt.map[73] = function()
	evt.SetDoorState{Id = 75, State = 0}
	evt.SetDoorState{Id = 76, State = 0}
end

evt.hint[74] = evt.str[2]  -- "Door"
evt.map[74] = function()
	evt.SetDoorState{Id = 77, State = 0}
	evt.SetDoorState{Id = 78, State = 0}
end

evt.hint[75] = evt.str[2]  -- "Door"
evt.map[75] = function()
	evt.SetDoorState{Id = 79, State = 0}
	evt.SetDoorState{Id = 80, State = 0}
end

evt.hint[76] = evt.str[2]  -- "Door"
evt.map[76] = function()
	evt.SetDoorState{Id = 81, State = 0}
	evt.SetDoorState{Id = 82, State = 0}
end

evt.hint[77] = evt.str[2]  -- "Door"
evt.map[77] = function()
	evt.SetDoorState{Id = 83, State = 0}
	evt.SetDoorState{Id = 84, State = 0}
end

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

evt.HouseDoor(201, 184)  -- "Escaton's Throne Room"
evt.hint[451] = evt.str[6]  -- "Take a Drink"
evt.map[451] = function()
	evt.StatusText(7)         -- "Refreshing"
end

evt.hint[501] = evt.str[1]  -- "Leave Escaton's Palace"
evt.map[501] = function()
	evt.MoveToMap{X = 1482, Y = -1643, Z = 209, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "pbp.odm"}
end

