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
	[12] = "Drow Hive",
	[13] = "Poison spray!",
	[14] = "empty",
	[15] = "Havin' fun yet??",
	[16] = "empty",
	[17] = "Keg",
	[18] = " +20 Hit Points",
	[19] = "The Portal is not powered.",
	[20] = "The Portal needs the Ether Jewel.",
	[21] = "Ether Portal",
	[22] = "empty",
	[23] = "empty",
	[24] = "empty",
	[25] = "The door is locked",
	[26] = "empty",
	[27] = "Exit",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[12]  -- "Drow Hive"

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
	if not evt.Cmp("QBits", 440) then         -- Hive Sanctum Door Once
		evt.Set("QBits", 440)         -- Hive Sanctum Door Once
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 3455, Y = 23408, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 3450, Y = 23408, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3455, Y = 23415, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 3696, Y = 23741, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 3690, Y = 23741, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3700, Y = 23730, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 4108, Y = 24169, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 4100, Y = 24169, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 4115, Y = 24175, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 4748, Y = 24171, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 4760, Y = 24171, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 4730, Y = 24180, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 5180, Y = 23883, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 5190, Y = 23883, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 5170, Y = 23870, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = 4388, Y = 23517, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 3253, Y = 22521, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 3240, Y = 22510, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5527, Y = 22664, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = 5540, Y = 22650, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 5782, Y = 21636, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 4, X = 5443, Y = 20997, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = 4753, Y = 20767, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 4, X = 3356, Y = 21063, Z = -2255}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = 3419, Y = 21861, Z = -2255}
	end
	evt.SetDoorState{Id = 28, State = 1}
end

evt.map[99] = function()  -- function events.LoadMap()
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
	evt.SetDoorState{Id = 53, State = 1}
end

events.LoadMap = evt.map[99].last

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

Timer(function()
	evt.Cmp("MapVar20", 1)
end, 2.5*const.Minute)

Timer(function()
	evt.Cmp("MapVar19", 1)
end, 5*const.Minute)

evt.hint[56] = evt.str[15]  -- "Havin' fun yet??"
evt.map[56] = function()
	evt.Set("MapVar1", 1)
end

Timer(function()
	evt.Cmp("MapVar0", 1)
end, 1*const.Hour)

evt.map[58] = function()
	evt.Set("MapVar1", 0)
end

evt.hint[60] = evt.str[21]  -- "Ether Portal"
evt.map[60] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 437) then         -- Hive teleportal once - show Tamara
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 481)         -- "Jewel of Power"
		evt.Subtract("Inventory", 479)         -- "Ether Jewel"
		evt.MoveToMap{X = -2921, Y = 13139, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "CD1.Blv"}
	else
		if not evt.Cmp("Inventory", 481) then         -- "Jewel of Power"
			evt.StatusText(19)         -- "The Portal is not powered."
		else
			if evt.Cmp("Inventory", 479) then         -- "Ether Jewel"
				evt.Set("QBits", 437)         -- Hive teleportal once - show Tamara
				evt.SetNPCTopic{NPC = 8, Index = 0, Event = 293}         -- "Tamara" : "The Fortress of Anarchy"
				evt.SpeakNPC(8)         -- "Tamara"
			else
				evt.StatusText(20)         -- "The Portal needs the Ether Jewel."
			end
		end
	end
end

evt.map[100] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 439) then         -- Hive Reload Once
		evt.Set("QBits", 439)         -- Hive Reload Once
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -6646, Y = 13357, Z = -1399}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -4225, Y = 18156, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 8441, Y = 7060, Z = -1334}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -1160, Y = 16932, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 1297, Y = 16381, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1290, Y = 16381, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 1300, Y = 16390, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 1318, Y = 15267, Z = -1535}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 1318, Y = 12669, Z = -2020}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -5592, Y = 2853, Z = -1710}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -1673, Y = 2682, Z = -2037}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -1385, Y = 2730, Z = -2037}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1709, Y = 8178, Z = -1535}
	end
	if evt.Cmp("QBits", 508) then         -- Warrior
		if evt.Cmp("QBits", 404) then         -- Hive  Once
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 431, Y = 4379, Z = 1}
		if not evt.Cmp("QBits", 507) then         -- Death Wish
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 422, Y = 4919, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 547, Y = 5219, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 435, Y = 5747, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 435, Y = 5921, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 435, Y = 6017, Z = 1}
	end
	evt.Add("QBits", 404)         -- Hive  Once
end

events.LoadMap = evt.map[100].last

