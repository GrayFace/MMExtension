local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Abandoned Temple",
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
	[30] = "The button will not move",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 403) then         -- Roster Character In Party 4
		evt.SpeakNPC(452)         -- "Simon Templar"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar10", 15) then
		evt.SetDoorState{Id = 108, State = 0}
		evt.SetDoorState{Id = 109, State = 0}
	else
		evt.SetDoorState{Id = 108, State = 1}
		evt.SetDoorState{Id = 109, State = 1}
		evt.Set("MapVar0", 0)
		evt.Set("MapVar1", 0)
		evt.Set("MapVar2", 0)
		evt.Set("MapVar3", 0)
		evt.Set("MapVar4", 0)
		evt.Set("MapVar5", 0)
		evt.Set("MapVar6", 0)
		evt.Set("MapVar7", 0)
		evt.Set("MapVar10", 0)
	end
	evt.SetDoorState{Id = 110, State = 1}
	evt.SetDoorState{Id = 111, State = 1}
	evt.SetDoorState{Id = 112, State = 1}
	evt.SetDoorState{Id = 113, State = 1}
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 626) then         -- "Prophecies of the Sun"
		evt.Add("QBits", 218)         -- Prophesies of the Sun - I lost it
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.map[10] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 136) then         -- Found Prophiecies of the Snake
		if evt.Cmp("Inventory", 652) then         -- "Prophecies of the Snake"
			evt.Set("QBits", 136)         -- Found Prophiecies of the Snake
			evt.Subtract("QBits", 135)         -- "Find the Prophecies of the Snake for Pascella Tisk."
		end
	end
end

events.LeaveMap = evt.map[10].last

evt.hint[11] = evt.str[2]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetTexture{Facet = 10, Name = "t65a05bl"}
	evt.SetTexture{Facet = 11, Name = "t65a05br"}
end

evt.hint[12] = evt.str[100]  -- ""
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

evt.hint[20] = evt.str[5]  -- "Button"
evt.map[20] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 53, State = 1}
end

evt.hint[21] = evt.str[5]  -- "Button"
evt.map[21] = function()
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 53, State = 0}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 52, State = 1}
end

evt.hint[22] = evt.str[5]  -- "Button"
evt.map[22] = function()
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 54, State = 0}
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 55, State = 1}
end

evt.hint[23] = evt.str[5]  -- "Button"
evt.map[23] = function()
	if not evt.Cmp("MapVar20", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8000, Y = 640, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 13, State = 0}
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 54, State = 1}
	evt.Set("MapVar20", 1)
end

evt.hint[24] = evt.str[5]  -- "Button"
evt.map[24] = function()
	evt.SetDoorState{Id = 14, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 57, State = 1}
end

evt.hint[25] = evt.str[5]  -- "Button"
evt.map[25] = function()
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 56, State = 1}
end

evt.hint[26] = evt.str[5]  -- "Button"
evt.map[26] = function()
	evt.SetDoorState{Id = 16, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 59, State = 1}
end

evt.hint[27] = evt.str[5]  -- "Button"
evt.map[27] = function()
	evt.SetDoorState{Id = 17, State = 0}
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 16, State = 1}
	evt.SetDoorState{Id = 58, State = 1}
end

evt.hint[28] = evt.str[5]  -- "Button"
evt.map[28] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9600, Y = -192, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
	evt.SetDoorState{Id = 19, State = 1}
	evt.SetDoorState{Id = 61, State = 1}
	evt.Set("MapVar19", 1)
end

evt.hint[29] = evt.str[5]  -- "Button"
evt.map[29] = function()
	evt.SetDoorState{Id = 19, State = 0}
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 18, State = 1}
	evt.SetDoorState{Id = 60, State = 1}
end

evt.hint[30] = evt.str[5]  -- "Button"
evt.map[30] = function()
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 63, State = 1}
end

evt.hint[31] = evt.str[5]  -- "Button"
evt.map[31] = function()
	if not evt.Cmp("MapVar21", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 6784, Y = -896, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 63, State = 0}
	evt.SetDoorState{Id = 20, State = 1}
	evt.SetDoorState{Id = 62, State = 1}
	evt.Set("MapVar21", 1)
end

evt.hint[32] = evt.str[5]  -- "Button"
evt.map[32] = function()
	evt.SetDoorState{Id = 22, State = 0}
	evt.SetDoorState{Id = 64, State = 0}
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 65, State = 1}
end

evt.hint[33] = evt.str[5]  -- "Button"
evt.map[33] = function()
	if not evt.Cmp("MapVar22", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8256, Y = -896, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 23, State = 0}
	evt.SetDoorState{Id = 65, State = 0}
	evt.SetDoorState{Id = 22, State = 1}
	evt.SetDoorState{Id = 64, State = 1}
	evt.Set("MapVar22", 1)
end

evt.hint[34] = evt.str[5]  -- "Button"
evt.map[34] = function()
	if not evt.Cmp("MapVar23", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8832, Y = -960, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 66, State = 0}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 67, State = 1}
	evt.Set("MapVar23", 1)
end

evt.hint[35] = evt.str[5]  -- "Button"
evt.map[35] = function()
	evt.SetDoorState{Id = 25, State = 0}
	evt.SetDoorState{Id = 67, State = 0}
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 66, State = 1}
end

evt.hint[36] = evt.str[5]  -- "Button"
evt.map[36] = function()
	if not evt.Cmp("MapVar24", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9792, Y = -960, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 26, State = 0}
	evt.SetDoorState{Id = 68, State = 0}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 69, State = 1}
	evt.Set("MapVar24", 1)
end

evt.hint[37] = evt.str[5]  -- "Button"
evt.map[37] = function()
	if not evt.Cmp("MapVar25", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 10176, Y = -960, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 27, State = 0}
	evt.SetDoorState{Id = 69, State = 0}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 68, State = 1}
	evt.Set("MapVar25", 1)
end

evt.hint[38] = evt.str[5]  -- "Button"
evt.map[38] = function()
	if not evt.Cmp("MapVar26", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 6208, Y = -1664, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 28, State = 0}
	evt.SetDoorState{Id = 70, State = 0}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 71, State = 1}
	evt.Set("MapVar26", 1)
end

evt.hint[39] = evt.str[5]  -- "Button"
evt.map[39] = function()
	if not evt.Cmp("MapVar27", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 6592, Y = -1664, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 29, State = 0}
	evt.SetDoorState{Id = 71, State = 0}
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 70, State = 1}
	evt.Set("MapVar27", 1)
end

evt.hint[40] = evt.str[5]  -- "Button"
evt.map[40] = function()
	evt.SetDoorState{Id = 30, State = 0}
	evt.SetDoorState{Id = 72, State = 0}
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 73, State = 1}
end

evt.hint[41] = evt.str[5]  -- "Button"
evt.map[41] = function()
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 73, State = 0}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 72, State = 1}
end

evt.hint[42] = evt.str[5]  -- "Button"
evt.map[42] = function()
	evt.SetDoorState{Id = 32, State = 0}
	evt.SetDoorState{Id = 74, State = 0}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 75, State = 1}
	evt.SetDoorState{Id = 76, State = 1}
	evt.SetDoorState{Id = 77, State = 1}
end

evt.hint[43] = evt.str[5]  -- "Button"
evt.map[43] = function()
	if not evt.Cmp("MapVar30", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9024, Y = -1728, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 33, State = 0}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 75, State = 0}
	evt.SetDoorState{Id = 76, State = 1}
	evt.SetDoorState{Id = 77, State = 1}
	evt.Set("MapVar30", 1)
end

evt.hint[44] = evt.str[5]  -- "Button"
evt.map[44] = function()
	if not evt.Cmp("MapVar31", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9408, Y = -1728, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 0}
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 75, State = 1}
	evt.SetDoorState{Id = 76, State = 0}
	evt.SetDoorState{Id = 77, State = 1}
	evt.Set("MapVar31", 1)
end

evt.hint[45] = evt.str[5]  -- "Button"
evt.map[45] = function()
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 35, State = 0}
	evt.SetDoorState{Id = 74, State = 1}
	evt.SetDoorState{Id = 75, State = 1}
	evt.SetDoorState{Id = 76, State = 1}
	evt.SetDoorState{Id = 77, State = 0}
	evt.Set("MapVar31", 0)
end

evt.hint[46] = evt.str[5]  -- "Button"
evt.map[46] = function()
	if not evt.Cmp("MapVar32", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 7104, Y = -2432, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 36, State = 0}
	evt.SetDoorState{Id = 78, State = 0}
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 79, State = 1}
	evt.Set("MapVar32", 1)
end

evt.hint[47] = evt.str[5]  -- "Button"
evt.map[47] = function()
	if not evt.Cmp("MapVar33", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 7488, Y = -2432, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 37, State = 0}
	evt.SetDoorState{Id = 79, State = 0}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 78, State = 1}
	evt.Set("MapVar33", 1)
end

evt.hint[48] = evt.str[5]  -- "Button"
evt.map[48] = function()
	evt.SetDoorState{Id = 38, State = 0}
	evt.SetDoorState{Id = 80, State = 0}
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 81, State = 1}
end

evt.hint[49] = evt.str[5]  -- "Button"
evt.map[49] = function()
	if not evt.Cmp("MapVar34", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8832, Y = -2496, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 39, State = 0}
	evt.SetDoorState{Id = 81, State = 0}
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 80, State = 1}
	evt.Set("MapVar34", 1)
end

evt.hint[50] = evt.str[5]  -- "Button"
evt.map[50] = function()
	if not evt.Cmp("MapVar35", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9600, Y = -2496, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 40, State = 0}
	evt.SetDoorState{Id = 82, State = 0}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 83, State = 1}
	evt.Set("MapVar35", 1)
end

evt.hint[51] = evt.str[5]  -- "Button"
evt.map[51] = function()
	if not evt.Cmp("MapVar36", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9984, Y = -2496, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 41, State = 0}
	evt.SetDoorState{Id = 83, State = 0}
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 82, State = 1}
	evt.Set("MapVar36", 1)
end

evt.hint[52] = evt.str[5]  -- "Button"
evt.map[52] = function()
	evt.SetDoorState{Id = 42, State = 0}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 84, State = 0}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 89, State = 1}
end

evt.hint[53] = evt.str[5]  -- "Button"
evt.map[53] = function()
	if not evt.Cmp("MapVar37", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 7872, Y = -3264, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 43, State = 0}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 0}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 89, State = 1}
	evt.Set("MapVar37", 1)
end

evt.hint[54] = evt.str[5]  -- "Button"
evt.map[54] = function()
	if not evt.Cmp("MapVar38", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8256, Y = -3264, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 0}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 0}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 89, State = 1}
	evt.Set("MapVar38", 1)
end

evt.hint[55] = evt.str[5]  -- "Button"
evt.map[55] = function()
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 45, State = 0}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 87, State = 0}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 89, State = 1}
end

evt.hint[56] = evt.str[5]  -- "Button"
evt.map[56] = function()
	if not evt.Cmp("MapVar39", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 9024, Y = -3264, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 0}
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 0}
	evt.SetDoorState{Id = 89, State = 1}
	evt.Set("MapVar39", 1)
end

evt.hint[57] = evt.str[5]  -- "Button"
evt.map[57] = function()
	evt.SetDoorState{Id = 42, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
	evt.SetDoorState{Id = 47, State = 0}
	evt.SetDoorState{Id = 84, State = 1}
	evt.SetDoorState{Id = 85, State = 1}
	evt.SetDoorState{Id = 86, State = 1}
	evt.SetDoorState{Id = 87, State = 1}
	evt.SetDoorState{Id = 88, State = 1}
	evt.SetDoorState{Id = 89, State = 0}
end

evt.hint[58] = evt.str[5]  -- "Button"
evt.map[58] = function()
	if not evt.Cmp("MapVar40", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 7296, Y = -4032, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 48, State = 0}
	evt.SetDoorState{Id = 90, State = 0}
	evt.SetDoorState{Id = 49, State = 1}
	evt.SetDoorState{Id = 91, State = 1}
	evt.Set("MapVar40", 1)
end

evt.hint[59] = evt.str[5]  -- "Button"
evt.map[59] = function()
	if not evt.Cmp("MapVar41", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 7680, Y = -4032, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 49, State = 0}
	evt.SetDoorState{Id = 91, State = 0}
	evt.SetDoorState{Id = 48, State = 1}
	evt.SetDoorState{Id = 90, State = 1}
	evt.Set("MapVar41", 1)
end

evt.hint[60] = evt.str[5]  -- "Button"
evt.map[60] = function()
	if not evt.Cmp("MapVar42", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8448, Y = -4032, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 50, State = 0}
	evt.SetDoorState{Id = 92, State = 0}
	evt.SetDoorState{Id = 51, State = 1}
	evt.SetDoorState{Id = 93, State = 1}
	evt.Set("MapVar42", 1)
end

evt.hint[61] = evt.str[5]  -- "Button"
evt.map[61] = function()
	if not evt.Cmp("MapVar43", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 8832, Y = -4032, Z = -640, NPCGroup = 0, unk = 0}
	end
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 93, State = 0}
	evt.SetDoorState{Id = 50, State = 1}
	evt.SetDoorState{Id = 92, State = 1}
	evt.Set("MapVar43", 1)
end

evt.hint[62] = evt.str[2]  -- "Door"
evt.map[62] = function()
	evt.SetDoorState{Id = 108, State = 0}
end

evt.hint[63] = evt.str[2]  -- "Door"
evt.map[63] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.SetDoorState{Id = 109, State = 1}
		evt.SetDoorState{Id = 108, State = 1}
		evt.SetDoorState{Id = 110, State = 0}
		evt.SetDoorState{Id = 111, State = 0}
		evt.SetDoorState{Id = 112, State = 0}
		evt.SetDoorState{Id = 113, State = 0}
		evt.SetTexture{Facet = 1, Name = "t65b11c"}
		evt.SetTexture{Facet = 2, Name = "t65b11c"}
		evt.SetTexture{Facet = 3, Name = "t65b11c"}
		evt.SetTexture{Facet = 4, Name = "t65b11c"}
		evt.SetTexture{Facet = 5, Name = "t65b11c"}
		evt.SetTexture{Facet = 6, Name = "t65b11c"}
		evt.SetTexture{Facet = 7, Name = "t65b11c"}
		evt.SetTexture{Facet = 8, Name = "t65b11c"}
		evt.SetLight{Id = 1, On = true}
		evt.SetLight{Id = 2, On = true}
		evt.SetLight{Id = 3, On = true}
		evt.SetLight{Id = 4, On = true}
		evt.SetLight{Id = 5, On = true}
		evt.SetLight{Id = 6, On = true}
		evt.SetLight{Id = 7, On = true}
		evt.SetLight{Id = 8, On = true}
		evt.Add("MapVar10", 1)
	end
end

evt.hint[64] = evt.str[1]  -- "Leave the Abandoned Temple"
evt.map[64] = function()
	evt.SetDoorState{Id = 109, State = 0}
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

evt.hint[101] = evt.str[100]  -- ""
evt.map[101] = function()
	evt.ForPlayer("All")
	evt.Set("Dead", 0)
end

evt.hint[102] = evt.str[5]  -- "Button"
evt.map[102] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar0", 1) then
				evt.Set("MapVar0", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 1, Name = "t65b11c"}
				evt.SetLight{Id = 1, On = true}
			else
				evt.Set("MapVar0", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 1, Name = "t65b11b"}
				evt.SetLight{Id = 1, On = false}
			end
		end
	end
end

evt.hint[103] = evt.str[5]  -- "Button"
evt.map[103] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar1", 1) then
				evt.Set("MapVar1", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 2, Name = "t65b11c"}
				evt.SetLight{Id = 2, On = true}
			else
				evt.Set("MapVar1", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 2, Name = "t65b11b"}
				evt.SetLight{Id = 2, On = false}
			end
		end
	end
end

evt.hint[104] = evt.str[5]  -- "Button"
evt.map[104] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar2", 1) then
				evt.Set("MapVar2", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 3, Name = "t65b11c"}
				evt.SetLight{Id = 3, On = true}
			else
				evt.Set("MapVar2", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 3, Name = "t65b11b"}
				evt.SetLight{Id = 3, On = false}
			end
		end
	end
end

evt.hint[105] = evt.str[5]  -- "Button"
evt.map[105] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar3", 1) then
				evt.Set("MapVar3", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 4, Name = "t65b11c"}
				evt.SetLight{Id = 4, On = true}
			else
				evt.Set("MapVar3", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 4, Name = "t65b11b"}
				evt.SetLight{Id = 4, On = false}
			end
		end
	end
end

evt.hint[106] = evt.str[5]  -- "Button"
evt.map[106] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar4", 1) then
				evt.Set("MapVar4", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 5, Name = "t65b11c"}
				evt.SetLight{Id = 5, On = true}
			else
				evt.Set("MapVar4", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 5, Name = "t65b11b"}
				evt.SetLight{Id = 5, On = false}
			end
		end
	end
end

evt.hint[107] = evt.str[5]  -- "Button"
evt.map[107] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar5", 1) then
				evt.Set("MapVar5", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 6, Name = "t65b11c"}
				evt.SetLight{Id = 6, On = true}
			else
				evt.Set("MapVar5", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 6, Name = "t65b11b"}
				evt.SetLight{Id = 6, On = false}
			end
		end
	end
end

evt.hint[108] = evt.str[5]  -- "Button"
evt.map[108] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar6", 1) then
				evt.Set("MapVar6", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 7, Name = "t65b11c"}
				evt.SetLight{Id = 7, On = true}
			else
				evt.Set("MapVar6", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 7, Name = "t65b11b"}
				evt.SetLight{Id = 7, On = false}
			end
		end
	end
end

evt.hint[109] = evt.str[5]  -- "Button"
evt.map[109] = function()
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar7", 1) then
				evt.Set("MapVar7", 0)
				evt.Subtract("MapVar10", 1)
				evt.SetTexture{Facet = 8, Name = "t65b11c"}
				evt.SetLight{Id = 8, On = true}
			else
				evt.Set("MapVar7", 1)
				evt.Add("MapVar10", 1)
				evt.SetTexture{Facet = 8, Name = "t65b11b"}
				evt.SetLight{Id = 8, On = false}
			end
		end
	end
end

evt.hint[110] = evt.str[100]  -- ""
evt.map[110] = function()  -- Timer(<function>, 2.5*const.Minute)
	if not evt.Cmp("MapVar10", 15) then
		if evt.Cmp("MapVar10", 9) then
			evt.StopDoor(110)
			evt.StopDoor(111)
			evt.StopDoor(112)
			evt.StopDoor(113)
			evt.SetDoorState{Id = 108, State = 0}
			evt.SetDoorState{Id = 109, State = 0}
			evt.Set("MapVar10", 15)
		end
	end
end

Timer(evt.map[110].last, 2.5*const.Minute)

evt.hint[111] = evt.str[100]  -- ""
evt.map[111] = function()
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13184, FromY = 2848, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13088, FromY = 2944, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13184, FromY = 3040, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13280, FromY = 2944, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
end

evt.hint[112] = evt.str[100]  -- ""
evt.map[112] = function()
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13184, FromY = 1824, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13088, FromY = 1920, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13184, FromY = 2016, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 13280, FromY = 1920, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
end

evt.hint[113] = evt.str[100]  -- ""
evt.map[113] = function()
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10368, FromY = 2016, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10464, FromY = 1920, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10368, FromY = 1824, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10272, FromY = 1920, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
end

evt.hint[114] = evt.str[100]  -- ""
evt.map[114] = function()
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10368, FromY = 3040, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10464, FromY = 2944, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10368, FromY = 2848, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 10, FromX = 10272, FromY = 2944, FromZ = -464, ToX = 0, ToY = 0, ToZ = 0}         -- "Poison Spray"
end

evt.hint[115] = evt.str[100]  -- ""
evt.map[115] = function()
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 10, FromX = 11840, FromY = 2496, FromZ = -448, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Bolt"
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 10, FromX = 11840, FromY = 2368, FromZ = -448, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Bolt"
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 10, FromX = 11712, FromY = 2368, FromZ = -448, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Bolt"
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 10, FromX = 11712, FromY = 2496, FromZ = -448, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Bolt"
end

evt.hint[402] = evt.str[100]  -- ""
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("MapVar12", 1) then
		if not evt.Cmp("MapVar11", 3) then
			if evt.Cmp("MapVar11", 2) then
				evt.SetFacetBit{Id = 15, Bit = const.FacetBits.IsSecret, On = true}
				evt.Add("MapVar11", 1)
			else
				evt.Add("MapVar11", 1)
				evt.Set("MapVar12", 1)
			end
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if evt.Cmp("MapVar12", 1) then
		evt.Set("MapVar12", 0)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	evt.SetDoorState{Id = 115, State = 0}
end

evt.hint[501] = evt.str[1]  -- "Leave the Abandoned Temple"
evt.map[501] = function()
	evt.MoveToMap{X = -12789, Y = 18734, Z = 1857, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "out01.odm"}
end

evt.hint[502] = evt.str[1]  -- "Leave the Abandoned Temple"
evt.map[502] = function()
	evt.MoveToMap{X = 21519, Y = 21106, Z = 97, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "out01.odm"}
end

evt.hint[506] = evt.str[100]  -- ""
evt.map[506] = function()
	evt.SetDoorState{Id = 94, State = 0}
end

evt.hint[507] = evt.str[100]  -- ""
evt.map[507] = function()
	evt.SetDoorState{Id = 95, State = 0}
end

evt.hint[508] = evt.str[100]  -- ""
evt.map[508] = function()
	evt.SetDoorState{Id = 96, State = 0}
end

evt.hint[509] = evt.str[100]  -- ""
evt.map[509] = function()
	evt.SetDoorState{Id = 97, State = 0}
end

evt.hint[510] = evt.str[100]  -- ""
evt.map[510] = function()
	evt.SetDoorState{Id = 98, State = 0}
end

evt.hint[511] = evt.str[100]  -- ""
evt.map[511] = function()
	evt.SetDoorState{Id = 99, State = 0}
end

evt.hint[512] = evt.str[100]  -- ""
evt.map[512] = function()
	evt.SetDoorState{Id = 94, State = 1}
	evt.SetDoorState{Id = 95, State = 1}
	evt.SetDoorState{Id = 96, State = 1}
	evt.SetDoorState{Id = 97, State = 1}
	evt.SetDoorState{Id = 98, State = 1}
	evt.SetDoorState{Id = 99, State = 1}
end

evt.hint[513] = evt.str[5]  -- "Button"
evt.map[513] = function()
	if not evt.Cmp("MapVar29", 1) then
		evt.SetDoorState{Id = 100, State = 1}
		evt.SetDoorState{Id = 101, State = 0}
		evt.SetFacetBit{Id = 100, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 101, Bit = const.FacetBits.MoveByDoor, On = true}
		evt.Set("MapVar29", 1)
	end
end

evt.hint[514] = evt.str[5]  -- "Button"
evt.map[514] = function()
	if not evt.Cmp("MapVar29", 2) then
		if evt.Cmp("MapVar29", 1) then
			evt.SetDoorState{Id = 102, State = 1}
			evt.SetDoorState{Id = 103, State = 0}
			evt.SetFacetBit{Id = 101, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 101, Bit = const.FacetBits.MoveByDoor, On = false}
			evt.SetFacetBit{Id = 102, Bit = const.FacetBits.MoveByDoor, On = true}
			evt.Set("MapVar29", 2)
		else
			evt.StatusText(30)         -- "The button will not move"
		end
	end
end

evt.hint[515] = evt.str[5]  -- "Button"
evt.map[515] = function()
	if not evt.Cmp("MapVar29", 3) then
		if evt.Cmp("MapVar29", 2) then
			evt.SetDoorState{Id = 104, State = 1}
			evt.SetDoorState{Id = 105, State = 0}
			evt.SetFacetBit{Id = 102, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 102, Bit = const.FacetBits.MoveByDoor, On = false}
			evt.SetFacetBit{Id = 103, Bit = const.FacetBits.MoveByDoor, On = true}
			evt.Set("MapVar29", 3)
		else
			evt.StatusText(30)         -- "The button will not move"
		end
	end
end

evt.hint[516] = evt.str[5]  -- "Button"
evt.map[516] = function()
	if not evt.Cmp("MapVar29", 4) then
		if evt.Cmp("MapVar29", 3) then
			evt.SetDoorState{Id = 106, State = 1}
			evt.SetDoorState{Id = 107, State = 0}
			evt.SetFacetBit{Id = 103, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 103, Bit = const.FacetBits.MoveByDoor, On = false}
			evt.Set("MapVar29", 4)
		else
			evt.StatusText(30)         -- "The button will not move"
		end
	end
end

evt.hint[517] = evt.str[100]  -- ""
evt.map[517] = function()
	evt.SetDoorState{Id = 114, State = 0}
end

