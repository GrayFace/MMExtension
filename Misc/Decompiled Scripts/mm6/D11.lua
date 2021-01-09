local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Chest",
	[4] = "This Door won't budge.",
	[5] = "Wall",
	[6] = "Exit",
	[7] = "Corlagon's Estate",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Corlagon's Estate"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.Set("MapVar1", 1)
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[14] = evt.str[2]  -- "Switch"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[16] = evt.str[2]  -- "Switch"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
end

evt.hint[20] = evt.str[2]  -- "Switch"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[5]  -- "Wall"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.hint[24] = evt.str[24]
evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[25] = evt.str[5]  -- "Wall"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
end

evt.hint[26] = evt.str[2]  -- "Switch"
evt.map[26] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

evt.hint[28] = evt.str[1]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 28, State = 1}
end

evt.hint[29] = evt.str[1]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 29, State = 1}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
end

evt.hint[32] = evt.str[1]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[33] = evt.str[1]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 33, State = 1}
end

evt.hint[34] = evt.str[1]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 34, State = 1}
end

evt.hint[35] = evt.str[1]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 35, State = 1}
end

evt.hint[42] = evt.str[3]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(1)
end

evt.hint[43] = evt.str[3]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(2)
end

evt.hint[44] = evt.str[3]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(3)
end

evt.hint[45] = evt.str[3]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(4)
end

evt.hint[46] = evt.str[3]  -- "Chest"
evt.map[46] = function()
	evt.OpenChest(5)
end

evt.hint[47] = evt.str[3]  -- "Chest"
evt.map[47] = function()
	evt.OpenChest(6)
end

evt.hint[48] = evt.str[3]  -- "Chest"
evt.map[48] = function()
	evt.OpenChest(7)
end

evt.hint[49] = evt.str[3]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(8)
end

evt.hint[50] = evt.str[3]  -- "Chest"
evt.map[50] = function()
	if not evt.Cmp("MapVar0", 1) then
		if evt.Cmp("QBits", 2) then         --  2 D11, given for glass shard for staff of terrax quest
			evt.OpenChest(11)
			return
		end
	end
	evt.OpenChest(9)
	evt.Set("MapVar0", 1)
	evt.Set("QBits", 2)         --  2 D11, given for glass shard for staff of terrax quest
	evt.Set("QBits", 186)         -- Quest item bits for seer
end

evt.hint[51] = evt.str[3]  -- "Chest"
evt.map[51] = function()
	evt.OpenChest(10)
end

evt.hint[52] = evt.str[1]  -- "Door"
evt.hint[53] = evt.str[1]  -- "Door"
evt.map[53] = function()
	evt.StatusText(4)         -- "This Door won't budge."
end

evt.hint[60] = evt.str[6]  -- "Exit"
evt.map[60] = function()
	evt.MoveToMap{X = -19677, Y = -17439, Z = 96, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD3.Odm"}
end

evt.map[65] = function()
	evt.MoveToMap{X = -5768, Y = 656, Z = -1296, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[66] = function()
	evt.MoveToMap{X = -6416, Y = 7560, Z = -1296, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[69] = function()
	evt.MoveToMap{X = 6538, Y = 114, Z = -255, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[70] = function()
	evt.MoveToMap{X = 6537, Y = 5945, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[71] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.MoveToMap{X = 3584, Y = -5248, Z = -832, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		evt.Subtract("MapVar1", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 1408, Y = -4992, Z = -832}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 1408, Y = -4864, Z = -832}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 1408, Y = -4736, Z = -832}
	end
end

evt.map[75] = function()
	evt.OpenChest(0)
end

