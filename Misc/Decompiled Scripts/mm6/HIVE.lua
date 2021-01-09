local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "The Door Won't Budge",
	[4] = "Warning!  Flush system activated!",
	[5] = "Flush sequence in progress.",
	[6] = "Flush system activated.",
	[7] = "Flush sequence complete.",
	[8] = "Flush system deactivated",
	[9] = "Switch",
	[10] = "empty",
	[11] = "empty",
	[12] = "The Hive",
	[13] = "Poison spray!",
	[14] = "empty",
	[15] = "Protected",
	[16] = "empty",
	[17] = "Keg",
	[18] = " +20 Hit Points",
	[19] = "empty",
	[20] = "empty",
	[21] = "empty",
	[22] = "empty",
	[23] = "empty",
	[24] = "empty",
	[25] = "The door is locked",
	[26] = "empty",
	[27] = "Exit",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[12]  -- "The Hive"

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

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	if evt.Cmp("Inventory", 570) then         -- "Hive Sanctum Key"
		evt.SetDoorState{Id = 6, State = 1}
		evt.Subtract("Inventory", 570)         -- "Hive Sanctum Key"
	else
		evt.StatusText(25)         -- "The door is locked"
	end
end

evt.hint[7] = evt.str[1]  -- "Door"
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

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[16] = evt.str[9]  -- "Switch"
evt.map[16] = function()
	evt.MoveToMap{X = 468, Y = 3690, Z = 1, Direction = 45, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
	evt.Set("MapVar0", 0)
	evt.StatusText(8)         -- "Flush system deactivated"
end

evt.map[17] = function()
	if not evt.Cmp("MapVar21", 1) then
		if not evt.Cmp("MapVar0", 1) then
			evt.StatusText(6)         -- "Flush system activated."
			evt.Set("MapVar0", 0)
		end
	end
end

evt.map[19] = function()
	if not evt.Cmp("MapVar21", 1) then
		if not evt.Cmp("MapVar0", 1) then
			evt.Set("MapVar0", 1)
		end
	end
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.StatusText(3)         -- "The Door Won't Budge"
end

evt.map[22] = function()
	evt.Set("MapVar3", 0)
end

evt.hint[23] = evt.str[17]  -- "Keg"
evt.map[23] = function()
	evt.StatusText(18)         -- " +20 Hit Points"
	evt.Add("HP", 20)
end

evt.map[27] = function()
	evt.SetDoorState{Id = 43, State = 1}
end

evt.hint[28] = evt.str[1]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 28, State = 1}
end

evt.map[29] = function()
	evt.Set("MapVar0", 0)
end

evt.hint[31] = evt.str[9]  -- "Switch"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
end

evt.map[33] = function()
	evt.SetDoorState{Id = 35, State = 2}         -- switch state
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
end

evt.hint[34] = evt.str[9]  -- "Switch"
evt.map[34] = function()
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
end

evt.hint[36] = evt.str[9]  -- "Switch"
evt.map[36] = function()
	evt.SetDoorState{Id = 41, State = 2}         -- switch state
	evt.SetDoorState{Id = 43, State = 2}         -- switch state
end

evt.map[38] = function()
	evt.SetDoorState{Id = 42, State = 1}
end

evt.map[39] = function()
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
end

evt.hint[41] = evt.str[2]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(1)
end

evt.hint[42] = evt.str[2]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(2)
	evt.Set("MapVar10", 1)
end

evt.hint[43] = evt.str[2]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(3)
end

evt.hint[44] = evt.str[2]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(4)
end

evt.hint[45] = evt.str[2]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(5)
end

evt.hint[48] = evt.str[27]  -- "Exit"
evt.map[48] = function()
	evt.MoveToMap{X = -14355, Y = 15010, Z = 3841, Direction = 1408, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutA1.Odm"}
end

evt.hint[50] = evt.str[9]  -- "Switch"
evt.map[50] = function()
	evt.SetDoorState{Id = 50, State = 1}
	evt.Set("MapVar21", 1)
end

evt.map[51] = function()  -- Timer(<function>, 2.5*const.Minute)
	if evt.Cmp("MapVar20", 1) then
		evt.StatusText(7)         -- "Flush sequence complete."
		evt.Set("MapVar20", 0)
	end
end

Timer(evt.map[51].last, 2.5*const.Minute)

evt.map[54] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("MapVar19", 1) then
		return
	end
	evt.StatusText(5)         -- "Flush sequence in progress."
	if not evt.Cmp("MapVar1", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
	end
	evt.Set("MapVar20", 1)
	evt.Set("MapVar19", 0)
end

Timer(evt.map[54].last, 5*const.Minute)

evt.hint[56] = evt.str[15]  -- "Protected"
evt.map[56] = function()
	evt.Set("MapVar1", 1)
end

evt.map[57] = function()  -- Timer(<function>, 1*const.Hour)
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(4)         -- "Warning!  Flush system activated!"
		evt.Set("MapVar19", 1)
	end
end

Timer(evt.map[57].last, 1*const.Hour)

evt.map[58] = function()
	evt.Set("MapVar1", 0)
end

evt.hint[60] = evt.str[27]  -- "Exit"
evt.map[60] = function()
	if not evt.Cmp("QBits", 202) then         -- NPC
		evt.StatusText(25)         -- "The door is locked"
	else
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 544) then         -- "Ritual of the Void"
			evt.Set("QBits", 237)         -- NPC
			evt.Subtract("QBits", 198)         -- Quest item bits for seer
			evt.Subtract("Inventory", 544)         -- "Ritual of the Void"
			evt.Set("Awards", 36)         -- "Destroyed the Hive and Saved Enroth"
			evt.EnterHouse(600)         -- Win
		else
			evt.EnterHouse(601)         -- Lose
		end
	end
end

evt.map[100] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 180) then         -- NPC
		evt.SetDoorState{Id = 28, State = 0}
		evt.SetDoorState{Id = 30, State = 1}
		evt.SetDoorState{Id = 51, State = 0}
		evt.SetDoorState{Id = 52, State = 0}
		evt.SetDoorState{Id = 53, State = 1}
	end
end

events.LoadMap = evt.map[100].last

