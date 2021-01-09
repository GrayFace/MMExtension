local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Troll Tomb",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "",
	[7] = "",
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
	[20] = "Vilebite is now at rest !",
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
evt.hint[11] = evt.str[2]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[12] = evt.str[2]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[13] = evt.str[2]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[14] = evt.str[2]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[15] = evt.str[2]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[16] = evt.str[2]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[17] = evt.str[2]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 13, State = 0}
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[18] = evt.str[2]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[19] = evt.str[2]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 17, State = 0}
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[20] = evt.str[2]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 19, State = 0}
	evt.SetDoorState{Id = 20, State = 0}
end

evt.hint[21] = evt.str[2]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[22] = evt.str[2]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 23, State = 0}
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[23] = evt.str[2]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 25, State = 0}
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[24] = evt.str[2]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 27, State = 0}
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[25] = evt.str[2]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 29, State = 0}
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[26] = evt.str[2]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[27] = evt.str[2]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 33, State = 0}
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[28] = evt.str[2]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 35, State = 0}
	evt.SetDoorState{Id = 36, State = 0}
end

evt.hint[29] = evt.str[2]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 37, State = 0}
	evt.SetDoorState{Id = 38, State = 0}
end

evt.hint[30] = evt.str[2]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 39, State = 0}
	evt.SetDoorState{Id = 40, State = 0}
end

evt.hint[31] = evt.str[2]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 41, State = 0}
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[32] = evt.str[2]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 43, State = 0}
	evt.SetDoorState{Id = 44, State = 0}
end

evt.hint[33] = evt.str[2]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 45, State = 0}
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[34] = evt.str[2]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 47, State = 0}
	evt.SetDoorState{Id = 48, State = 0}
end

evt.hint[35] = evt.str[2]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 49, State = 0}
	evt.SetDoorState{Id = 50, State = 0}
end

evt.hint[36] = evt.str[2]  -- "Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
end

evt.hint[37] = evt.str[2]  -- "Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 53, State = 0}
	evt.SetDoorState{Id = 54, State = 0}
end

evt.hint[38] = evt.str[2]  -- "Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
end

evt.hint[39] = evt.str[2]  -- "Door"
evt.map[39] = function()
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
end

evt.hint[40] = evt.str[2]  -- "Door"
evt.map[40] = function()
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
end

evt.hint[41] = evt.str[2]  -- "Door"
evt.map[41] = function()
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
end

evt.hint[42] = evt.str[2]  -- "Door"
evt.map[42] = function()
	evt.SetDoorState{Id = 63, State = 0}
	evt.SetDoorState{Id = 64, State = 0}
end

evt.hint[43] = evt.str[2]  -- "Door"
evt.map[43] = function()
	evt.SetDoorState{Id = 65, State = 0}
	evt.SetDoorState{Id = 66, State = 0}
end

evt.hint[44] = evt.str[2]  -- "Door"
evt.map[44] = function()
	evt.SetDoorState{Id = 67, State = 0}
	evt.SetDoorState{Id = 68, State = 0}
end

evt.hint[45] = evt.str[2]  -- "Door"
evt.map[45] = function()
	evt.SetDoorState{Id = 69, State = 0}
	evt.SetDoorState{Id = 70, State = 0}
end

evt.hint[46] = evt.str[2]  -- "Door"
evt.map[46] = function()
	evt.SetDoorState{Id = 71, State = 0}
	evt.SetDoorState{Id = 72, State = 0}
end

evt.hint[47] = evt.str[2]  -- "Door"
evt.map[47] = function()
	evt.SetDoorState{Id = 73, State = 0}
	evt.SetDoorState{Id = 74, State = 0}
end

evt.hint[48] = evt.str[2]  -- "Door"
evt.map[48] = function()
	evt.SetDoorState{Id = 75, State = 0}
	evt.SetDoorState{Id = 76, State = 0}
end

evt.hint[49] = evt.str[2]  -- "Door"
evt.map[49] = function()
	evt.SetDoorState{Id = 77, State = 0}
	evt.SetDoorState{Id = 78, State = 0}
end

evt.hint[50] = evt.str[2]  -- "Door"
evt.map[50] = function()
	evt.SetDoorState{Id = 79, State = 0}
	evt.SetDoorState{Id = 80, State = 0}
end

evt.hint[51] = evt.str[2]  -- "Door"
evt.map[51] = function()
	evt.SetDoorState{Id = 81, State = 0}
	evt.SetDoorState{Id = 82, State = 0}
end

evt.hint[52] = evt.str[2]  -- "Door"
evt.map[52] = function()
	evt.SetDoorState{Id = 83, State = 0}
	evt.SetDoorState{Id = 84, State = 0}
end

evt.hint[53] = evt.str[2]  -- "Door"
evt.map[53] = function()
	evt.SetDoorState{Id = 85, State = 0}
	evt.SetDoorState{Id = 86, State = 0}
end

evt.hint[54] = evt.str[2]  -- "Door"
evt.map[54] = function()
	evt.SetDoorState{Id = 87, State = 0}
	evt.SetDoorState{Id = 88, State = 0}
end

evt.hint[55] = evt.str[2]  -- "Door"
evt.map[55] = function()
	evt.SetDoorState{Id = 89, State = 0}
	evt.SetDoorState{Id = 90, State = 0}
end

evt.hint[56] = evt.str[2]  -- "Door"
evt.map[56] = function()
	evt.SetDoorState{Id = 91, State = 0}
	evt.SetDoorState{Id = 92, State = 0}
end

evt.hint[57] = evt.str[2]  -- "Door"
evt.map[57] = function()
	evt.SetDoorState{Id = 93, State = 0}
	evt.SetDoorState{Id = 94, State = 0}
end

evt.hint[58] = evt.str[2]  -- "Door"
evt.map[58] = function()
	evt.SetDoorState{Id = 95, State = 0}
	evt.SetDoorState{Id = 96, State = 0}
end

evt.hint[59] = evt.str[2]  -- "Door"
evt.map[59] = function()
	evt.SetDoorState{Id = 97, State = 0}
	evt.SetDoorState{Id = 98, State = 0}
end

evt.hint[60] = evt.str[2]  -- "Door"
evt.map[60] = function()
	evt.SetDoorState{Id = 99, State = 0}
	evt.SetDoorState{Id = 100, State = 0}
end

evt.hint[61] = evt.str[2]  -- "Door"
evt.map[61] = function()
	evt.SetDoorState{Id = 101, State = 0}
	evt.SetDoorState{Id = 102, State = 0}
end

evt.hint[62] = evt.str[2]  -- "Door"
evt.map[62] = function()
	evt.SetDoorState{Id = 103, State = 0}
	evt.SetDoorState{Id = 104, State = 0}
end

evt.hint[63] = evt.str[2]  -- "Door"
evt.map[63] = function()
	evt.SetDoorState{Id = 105, State = 0}
	evt.SetDoorState{Id = 106, State = 0}
end

evt.hint[64] = evt.str[2]  -- "Door"
evt.map[64] = function()
	evt.SetDoorState{Id = 107, State = 0}
	evt.SetDoorState{Id = 108, State = 0}
end

evt.hint[65] = evt.str[2]  -- "Door"
evt.map[65] = function()
	evt.SetDoorState{Id = 109, State = 0}
	evt.SetDoorState{Id = 110, State = 0}
end

evt.hint[66] = evt.str[2]  -- "Door"
evt.map[66] = function()
	evt.SetDoorState{Id = 111, State = 0}
	evt.SetDoorState{Id = 112, State = 0}
end

evt.hint[67] = evt.str[2]  -- "Door"
evt.map[67] = function()
	evt.SetDoorState{Id = 113, State = 0}
	evt.SetDoorState{Id = 114, State = 0}
end

evt.hint[68] = evt.str[2]  -- "Door"
evt.map[68] = function()
	evt.SetDoorState{Id = 115, State = 0}
	evt.SetDoorState{Id = 116, State = 0}
end

evt.hint[69] = evt.str[2]  -- "Door"
evt.map[69] = function()
	evt.SetDoorState{Id = 117, State = 0}
	evt.SetDoorState{Id = 118, State = 0}
end

evt.hint[70] = evt.str[2]  -- "Door"
evt.map[70] = function()
	evt.SetDoorState{Id = 119, State = 0}
	evt.SetDoorState{Id = 120, State = 0}
end

evt.hint[71] = evt.str[2]  -- "Door"
evt.map[71] = function()
	evt.SetDoorState{Id = 121, State = 0}
	evt.SetDoorState{Id = 122, State = 0}
end

evt.hint[72] = evt.str[2]  -- "Door"
evt.map[72] = function()
	evt.SetDoorState{Id = 123, State = 0}
	evt.SetDoorState{Id = 124, State = 0}
end

evt.hint[73] = evt.str[2]  -- "Door"
evt.map[73] = function()
	evt.SetDoorState{Id = 125, State = 0}
	evt.SetDoorState{Id = 126, State = 0}
end

evt.hint[74] = evt.str[2]  -- "Door"
evt.map[74] = function()
	evt.SetDoorState{Id = 127, State = 0}
	evt.SetDoorState{Id = 128, State = 0}
end

evt.hint[75] = evt.str[100]  -- ""
evt.map[75] = function()
	evt.SetDoorState{Id = 129, State = 0}
	evt.SetDoorState{Id = 130, State = 0}
end

evt.hint[76] = evt.str[2]  -- "Door"
evt.map[76] = function()
	evt.SetDoorState{Id = 131, State = 0}
	evt.SetDoorState{Id = 132, State = 0}
end

evt.hint[77] = evt.str[2]  -- "Door"
evt.map[77] = function()
	evt.SetDoorState{Id = 133, State = 0}
	evt.SetDoorState{Id = 134, State = 0}
end

evt.hint[78] = evt.str[2]  -- "Door"
evt.map[78] = function()
	evt.SetDoorState{Id = 135, State = 0}
	evt.SetDoorState{Id = 136, State = 0}
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

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()
	if not evt.Cmp("QBits", 62) then         -- Vilebites Ashes (item603) placed in troll tomb.
		if evt.Cmp("QBits", 61) then         -- "Put Vilebite's ashes in the Dust village tomb then return to Overdune."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 603) then         -- "Urn of Ashes"
				evt.Subtract("Inventory", 603)         -- "Urn of Ashes"
				evt.Add("QBits", 62)         -- Vilebites Ashes (item603) placed in troll tomb.
				evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
				evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
				evt.StatusText(20)         -- "Vilebite is now at rest !"
				evt.Subtract("QBits", 202)         -- Urn of Ashes - I lost it
			end
		end
	end
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.SetDoorState{Id = 73, State = 1}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 71, State = 1}
	evt.SetDoorState{Id = 72, State = 1}
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	evt.SetDoorState{Id = 75, State = 1}
	evt.SetDoorState{Id = 76, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 69, State = 1}
	evt.SetDoorState{Id = 70, State = 1}
	evt.SetDoorState{Id = 93, State = 1}
	evt.SetDoorState{Id = 94, State = 1}
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetDoorState{Id = 67, State = 1}
	evt.SetDoorState{Id = 68, State = 1}
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	evt.SetDoorState{Id = 73, State = 1}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 71, State = 1}
	evt.SetDoorState{Id = 72, State = 1}
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetDoorState{Id = 65, State = 1}
	evt.SetDoorState{Id = 66, State = 1}
	evt.SetDoorState{Id = 97, State = 1}
	evt.SetDoorState{Id = 98, State = 1}
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 61, State = 1}
	evt.SetDoorState{Id = 62, State = 1}
end

evt.hint[456] = evt.str[100]  -- ""
evt.map[456] = function()
	evt.SetDoorState{Id = 67, State = 1}
	evt.SetDoorState{Id = 68, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 61, State = 1}
	evt.SetDoorState{Id = 62, State = 1}
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetDoorState{Id = 69, State = 1}
	evt.SetDoorState{Id = 70, State = 1}
	evt.SetDoorState{Id = 99, State = 1}
	evt.SetDoorState{Id = 100, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 101, State = 1}
	evt.SetDoorState{Id = 102, State = 1}
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[457] = evt.str[100]  -- ""
evt.map[457] = function()
	evt.SetDoorState{Id = 63, State = 1}
	evt.SetDoorState{Id = 64, State = 1}
	evt.SetDoorState{Id = 19, State = 1}
	evt.SetDoorState{Id = 20, State = 1}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 65, State = 1}
	evt.SetDoorState{Id = 66, State = 1}
	evt.SetDoorState{Id = 103, State = 1}
	evt.SetDoorState{Id = 104, State = 1}
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[458] = evt.str[100]  -- ""
evt.map[458] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 1}
	evt.SetDoorState{Id = 102, State = 1}
	evt.SetDoorState{Id = 101, State = 1}
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 61, State = 1}
	evt.SetDoorState{Id = 62, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 99, State = 1}
	evt.SetDoorState{Id = 100, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 127, State = 1}
	evt.SetDoorState{Id = 128, State = 1}
end

evt.hint[459] = evt.str[100]  -- ""
evt.map[459] = function()
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 22, State = 1}
	evt.SetDoorState{Id = 125, State = 1}
	evt.SetDoorState{Id = 126, State = 1}
	evt.SetDoorState{Id = 103, State = 1}
	evt.SetDoorState{Id = 104, State = 1}
	evt.SetDoorState{Id = 123, State = 1}
	evt.SetDoorState{Id = 124, State = 1}
end

evt.hint[460] = evt.str[100]  -- ""
evt.map[460] = function()
	evt.SetDoorState{Id = 127, State = 1}
	evt.SetDoorState{Id = 128, State = 1}
	evt.SetDoorState{Id = 121, State = 1}
	evt.SetDoorState{Id = 122, State = 1}
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 119, State = 1}
	evt.SetDoorState{Id = 120, State = 1}
end

evt.hint[461] = evt.str[100]  -- ""
evt.map[461] = function()
	evt.SetDoorState{Id = 123, State = 1}
	evt.SetDoorState{Id = 124, State = 1}
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 117, State = 1}
	evt.SetDoorState{Id = 118, State = 1}
	evt.SetDoorState{Id = 125, State = 1}
	evt.SetDoorState{Id = 126, State = 1}
	evt.SetDoorState{Id = 97, State = 1}
	evt.SetDoorState{Id = 98, State = 1}
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetDoorState{Id = 51, State = 1}
	evt.SetDoorState{Id = 52, State = 1}
	evt.SetDoorState{Id = 115, State = 1}
	evt.SetDoorState{Id = 116, State = 1}
end

evt.hint[462] = evt.str[100]  -- ""
evt.map[462] = function()
	evt.SetDoorState{Id = 119, State = 1}
	evt.SetDoorState{Id = 120, State = 1}
	evt.SetDoorState{Id = 49, State = 1}
	evt.SetDoorState{Id = 50, State = 1}
	evt.SetDoorState{Id = 113, State = 1}
	evt.SetDoorState{Id = 114, State = 1}
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 121, State = 1}
	evt.SetDoorState{Id = 122, State = 1}
	evt.SetDoorState{Id = 105, State = 1}
	evt.SetDoorState{Id = 106, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 48, State = 1}
	evt.SetDoorState{Id = 91, State = 1}
	evt.SetDoorState{Id = 92, State = 1}
	evt.SetDoorState{Id = 59, State = 1}
	evt.SetDoorState{Id = 60, State = 1}
end

evt.hint[463] = evt.str[100]  -- ""
evt.map[463] = function()
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 99, State = 1}
	evt.SetDoorState{Id = 100, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 101, State = 1}
	evt.SetDoorState{Id = 102, State = 1}
end

evt.hint[464] = evt.str[100]  -- ""
evt.map[464] = function()
	evt.SetDoorState{Id = 103, State = 1}
	evt.SetDoorState{Id = 104, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 97, State = 1}
	evt.SetDoorState{Id = 98, State = 1}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 65, State = 1}
	evt.SetDoorState{Id = 66, State = 1}
	evt.SetDoorState{Id = 63, State = 1}
	evt.SetDoorState{Id = 64, State = 1}
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 22, State = 1}
	evt.SetDoorState{Id = 19, State = 1}
	evt.SetDoorState{Id = 20, State = 1}
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[465] = evt.str[100]  -- ""
evt.map[465] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetDoorState{Id = 99, State = 1}
	evt.SetDoorState{Id = 100, State = 1}
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 67, State = 1}
	evt.SetDoorState{Id = 68, State = 1}
	evt.SetDoorState{Id = 69, State = 1}
	evt.SetDoorState{Id = 70, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 101, State = 1}
	evt.SetDoorState{Id = 102, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 119, State = 1}
	evt.SetDoorState{Id = 120, State = 1}
	evt.SetDoorState{Id = 121, State = 1}
	evt.SetDoorState{Id = 122, State = 1}
end

evt.hint[466] = evt.str[100]  -- ""
evt.map[466] = function()
	evt.SetDoorState{Id = 93, State = 1}
	evt.SetDoorState{Id = 94, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
end

evt.hint[467] = evt.str[100]  -- ""
evt.map[467] = function()
	evt.SetDoorState{Id = 95, State = 1}
	evt.SetDoorState{Id = 96, State = 1}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 73, State = 1}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 71, State = 1}
	evt.SetDoorState{Id = 72, State = 1}
end

evt.hint[468] = evt.str[100]  -- ""
evt.map[468] = function()
	evt.SetDoorState{Id = 115, State = 1}
	evt.SetDoorState{Id = 116, State = 1}
	evt.SetDoorState{Id = 57, State = 1}
	evt.SetDoorState{Id = 58, State = 1}
	evt.SetDoorState{Id = 51, State = 1}
	evt.SetDoorState{Id = 52, State = 1}
	evt.SetDoorState{Id = 117, State = 1}
	evt.SetDoorState{Id = 118, State = 1}
	evt.SetDoorState{Id = 55, State = 1}
	evt.SetDoorState{Id = 56, State = 1}
end

evt.hint[469] = evt.str[100]  -- ""
evt.map[469] = function()
	evt.SetDoorState{Id = 59, State = 1}
	evt.SetDoorState{Id = 60, State = 1}
	evt.SetDoorState{Id = 53, State = 1}
	evt.SetDoorState{Id = 54, State = 1}
	evt.SetDoorState{Id = 113, State = 1}
	evt.SetDoorState{Id = 114, State = 1}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
end

evt.hint[470] = evt.str[100]  -- ""
evt.map[470] = function()
	evt.SetDoorState{Id = 55, State = 1}
	evt.SetDoorState{Id = 56, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 83, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
end

evt.hint[471] = evt.str[100]  -- ""
evt.map[471] = function()
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 81, State = 1}
	evt.SetDoorState{Id = 82, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 48, State = 1}
	evt.SetDoorState{Id = 91, State = 1}
	evt.SetDoorState{Id = 92, State = 1}
	evt.SetDoorState{Id = 49, State = 1}
	evt.SetDoorState{Id = 50, State = 1}
	evt.SetDoorState{Id = 105, State = 1}
	evt.SetDoorState{Id = 106, State = 1}
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 79, State = 1}
	evt.SetDoorState{Id = 80, State = 1}
	evt.SetDoorState{Id = 53, State = 1}
	evt.SetDoorState{Id = 54, State = 1}
end

evt.hint[472] = evt.str[100]  -- ""
evt.map[472] = function()
	evt.SetDoorState{Id = 83, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 107, State = 1}
	evt.SetDoorState{Id = 108, State = 1}
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 109, State = 1}
	evt.SetDoorState{Id = 110, State = 1}
	evt.SetDoorState{Id = 77, State = 1}
	evt.SetDoorState{Id = 78, State = 1}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
end

evt.hint[473] = evt.str[100]  -- ""
evt.map[473] = function()
	evt.SetDoorState{Id = 79, State = 1}
	evt.SetDoorState{Id = 80, State = 1}
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 81, State = 1}
	evt.SetDoorState{Id = 82, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 111, State = 1}
	evt.SetDoorState{Id = 112, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
end

evt.hint[474] = evt.str[100]  -- ""
evt.map[474] = function()
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 77, State = 1}
	evt.SetDoorState{Id = 78, State = 1}
	evt.SetDoorState{Id = 109, State = 1}
	evt.SetDoorState{Id = 110, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 107, State = 1}
	evt.SetDoorState{Id = 108, State = 1}
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 131, State = 1}
	evt.SetDoorState{Id = 132, State = 1}
end

evt.hint[475] = evt.str[100]  -- ""
evt.map[475] = function()
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 111, State = 1}
	evt.SetDoorState{Id = 112, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 129, State = 1}
	evt.SetDoorState{Id = 130, State = 1}
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 16, State = 1}
	evt.SetDoorState{Id = 133, State = 1}
	evt.SetDoorState{Id = 134, State = 1}
	evt.SetDoorState{Id = 135, State = 1}
	evt.SetDoorState{Id = 136, State = 1}
end

evt.hint[476] = evt.str[100]  -- ""
evt.map[476] = function()
	evt.SetDoorState{Id = 131, State = 1}
	evt.SetDoorState{Id = 132, State = 1}
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 109, State = 1}
	evt.SetDoorState{Id = 110, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 107, State = 1}
	evt.SetDoorState{Id = 108, State = 1}
end

evt.hint[477] = evt.str[100]  -- ""
evt.map[477] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 81, State = 1}
	evt.SetDoorState{Id = 82, State = 1}
	evt.SetDoorState{Id = 79, State = 1}
	evt.SetDoorState{Id = 80, State = 1}
	evt.SetDoorState{Id = 111, State = 1}
	evt.SetDoorState{Id = 112, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 129, State = 1}
	evt.SetDoorState{Id = 130, State = 1}
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 16, State = 1}
	evt.SetDoorState{Id = 105, State = 1}
	evt.SetDoorState{Id = 106, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 48, State = 1}
	evt.SetDoorState{Id = 49, State = 1}
	evt.SetDoorState{Id = 50, State = 1}
	evt.SetDoorState{Id = 91, State = 1}
	evt.SetDoorState{Id = 92, State = 1}
	evt.SetDoorState{Id = 133, State = 1}
	evt.SetDoorState{Id = 134, State = 1}
end

evt.hint[478] = evt.str[100]  -- ""
evt.map[478] = function()
	evt.SetDoorState{Id = 89, State = 1}
	evt.SetDoorState{Id = 90, State = 1}
	evt.SetDoorState{Id = 115, State = 1}
	evt.SetDoorState{Id = 116, State = 1}
	evt.SetDoorState{Id = 117, State = 1}
	evt.SetDoorState{Id = 118, State = 1}
	evt.SetDoorState{Id = 51, State = 1}
	evt.SetDoorState{Id = 52, State = 1}
	evt.SetDoorState{Id = 107, State = 1}
	evt.SetDoorState{Id = 108, State = 1}
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 109, State = 1}
	evt.SetDoorState{Id = 110, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 83, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
end

evt.hint[501] = evt.str[1]  -- "Leave the Troll Tomb"
evt.map[501] = function()
	evt.MoveToMap{X = -15458, Y = -14419, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out04.odm"}
end

