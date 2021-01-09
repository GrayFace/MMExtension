local TXT = Localize{
	[0] = " ",
	[1] = "Wooden Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "Mural",
	[6] = "Ched Rhinn",
	[7] = "The chest is locked",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[6]  -- "Ched Rhinn"
-- ERROR: Duplicate label: 60:11

evt.hint[1] = evt.str[1]  -- "Wooden Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Wooden Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Wooden Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Wooden Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Wooden Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[3]  -- "Switch"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Wooden Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Wooden Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Wooden Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Wooden Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Wooden Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[1]  -- "Wooden Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[1]  -- "Wooden Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Wooden Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[2]  -- "Chest"
evt.map[16] = function()
	if not evt.Cmp("MapVar4", 1) then
		if evt.Cmp("QBits", 11) then         -- 11 D7, opens tomb in D18.
			evt.OpenChest(6)
			return
		end
	end
	evt.OpenChest(1)
	evt.Set("MapVar4", 1)
	evt.Set("QBits", 11)         -- 11 D7, opens tomb in D18.
	evt.Set("QBits", 199)         -- Quest item bits for seer
end

evt.hint[17] = evt.str[2]  -- "Chest"
evt.map[17] = function()
	evt.OpenChest(2)
end

evt.hint[18] = evt.str[2]  -- "Chest"
evt.map[18] = function()
	if evt.Cmp("Inventory", 514) then         -- "Chest Key"
		evt.Subtract("Inventory", 514)         -- "Chest Key"
		evt.OpenChest(3)
	else
		evt.StatusText(7)         -- "The chest is locked"
	end
end

evt.map[19] = function()
	evt.SetDoorState{Id = 6, State = 0}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[20] = evt.str[4]  -- "Exit"
evt.map[20] = function()
	evt.MoveToMap{X = -21214, Y = 21886, Z = 289, Direction = 920, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB1.Odm"}
end

evt.hint[21] = evt.str[3]  -- "Switch"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 43, State = 0}
end

evt.map[22] = function()
	evt.SetDoorState{Id = 24, State = 2}         -- switch state
end

evt.map[23] = function()
	evt.SetDoorState{Id = 25, State = 2}         -- switch state
end

evt.map[24] = function()
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
end

evt.map[25] = function()
	evt.SetDoorState{Id = 24, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

evt.map[26] = function()
	evt.SetDoorState{Id = 25, State = 2}         -- switch state
end

evt.map[27] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
end

evt.map[28] = function()
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

evt.map[29] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 1}
end

evt.map[30] = function()
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
end

evt.map[31] = function()
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.map[32] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
end

evt.map[33] = function()
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
end

evt.map[34] = function()
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.map[35] = function()
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
end

evt.map[36] = function()
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 1}
end

evt.map[37] = function()
	evt.SetDoorState{Id = 39, State = 2}         -- switch state
end

evt.map[38] = function()
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
	evt.SetDoorState{Id = 40, State = 2}         -- switch state
end

evt.map[39] = function()
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
	evt.SetDoorState{Id = 41, State = 2}         -- switch state
end

evt.map[40] = function()
	evt.SetDoorState{Id = 39, State = 2}         -- switch state
end

evt.map[41] = function()
	evt.SetDoorState{Id = 40, State = 2}         -- switch state
end

evt.map[42] = function()
	evt.SetDoorState{Id = 41, State = 2}         -- switch state
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
end

evt.map[43] = function()
	evt.SetDoorState{Id = 43, State = 1}
end

evt.map[44] = function()
	evt.SetDoorState{Id = 44, State = 1}
end

evt.map[45] = function()
	evt.SetDoorState{Id = 45, State = 1}
end

evt.map[46] = function()
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 22, State = 1}
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[47] = evt.str[5]  -- "Mural"
evt.map[47] = function()
	if evt.Cmp("MapVar1", 3) then
		evt.MoveToMap{X = 7, Y = 3107, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = 7, Y = 3107, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 4, Y = 2120, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 1630, Y = 3072, Z = 350}
		evt.Add("MapVar1", 1)
	end
end

evt.hint[48] = evt.str[2]  -- "Chest"
evt.map[48] = function()
	evt.OpenChest(4)
end

evt.hint[49] = evt.str[2]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(5)
end

evt.hint[50] = evt.str[5]  -- "Mural"
evt.map[50] = function()
	if not evt.Cmp("MapVar2", 3) then
		evt.MoveToMap{X = -1635, Y = 5470, Z = 257, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -1418, Y = 4986, Z = 257}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -1418, Y = 4811, Z = 257}
		evt.SetDoorState{Id = 44, State = 0}
		evt.SetDoorState{Id = 45, State = 0}
		evt.Add("MapVar2", 1)
	end
end

evt.map[51] = function()
	evt.SetDoorState{Id = 43, State = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 10, Y = 2120, Z = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 1630, Y = 3072, Z = 350}
end

evt.map[57] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 1)
		evt.Add("Inventory", 327)         -- "Ice Bolt"
	end
end

evt.map[60] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 400) then         -- Ched Rhinn Once
		evt.Add("QBits", 400)         -- Ched Rhinn Once
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 4241, Y = 3061, Z = 800}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 2615, Y = 3061, Z = 625}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 3515, Y = 3061, Z = 800}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 4061, Y = 3061, Z = 800}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 3761, Y = 3061, Z = 800}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 3281, Y = 3061, Z = 800}
			end
		end
	end
end

events.LoadMap = evt.map[60].last

