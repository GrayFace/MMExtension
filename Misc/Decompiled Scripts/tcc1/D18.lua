local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "The Door won't budge.",
	[4] = "Tile",
	[5] = "Chest",
	[6] = "The Door is locked",
	[7] = "Found something!",
	[8] = "Bookcase",
	[9] = "Exit",
	[10] = "Oozew Pit",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[10]  -- "Oozew Pit"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.map[2] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[2]  -- "Lever"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[4] = evt.str[2]  -- "Lever"
evt.map[4] = function()
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[5] = evt.str[2]  -- "Lever"
evt.map[5] = function()
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[6] = evt.str[2]  -- "Lever"
evt.map[6] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[7] = evt.str[2]  -- "Lever"
evt.map[7] = function()
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[8] = evt.str[2]  -- "Lever"
evt.map[8] = function()
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 14, State = 1}
	evt.SetDoorState{Id = 49, State = 0}
end

evt.hint[9] = evt.str[2]  -- "Lever"
evt.map[9] = function()
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[10] = evt.str[2]  -- "Lever"
evt.map[10] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[11] = evt.str[2]  -- "Lever"
evt.map[11] = function()
	evt.SetDoorState{Id = 19, State = 1}
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[12] = evt.str[2]  -- "Lever"
evt.map[12] = function()
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[13] = evt.str[2]  -- "Lever"
evt.map[13] = function()
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[14] = evt.str[2]  -- "Lever"
evt.map[14] = function()
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
end

evt.hint[15] = evt.str[2]  -- "Lever"
evt.map[15] = function()
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
end

evt.hint[16] = evt.str[2]  -- "Lever"
evt.map[16] = function()
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
end

evt.hint[17] = evt.str[2]  -- "Lever"
evt.map[17] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[18] = evt.str[2]  -- "Lever"
evt.map[18] = function()
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 1}
end

evt.hint[19] = evt.str[2]  -- "Lever"
evt.map[19] = function()
	evt.SetDoorState{Id = 35, State = 1}
	evt.SetDoorState{Id = 36, State = 1}
end

evt.hint[20] = evt.str[2]  -- "Lever"
evt.map[20] = function()
	evt.SetDoorState{Id = 37, State = 1}
	evt.SetDoorState{Id = 38, State = 1}
end

evt.hint[21] = evt.str[2]  -- "Lever"
evt.map[21] = function()
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
end

evt.hint[22] = evt.str[2]  -- "Lever"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[2]  -- "Lever"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.hint[24] = evt.str[2]  -- "Lever"
evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[25] = evt.str[2]  -- "Lever"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
end

evt.hint[26] = evt.str[2]  -- "Lever"
evt.map[26] = function()
	evt.SetDoorState{Id = 26, State = 1}
end

evt.hint[29] = evt.str[2]  -- "Lever"
evt.map[29] = function()
	evt.SetDoorState{Id = 29, State = 1}
end

evt.hint[30] = evt.str[2]  -- "Lever"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.hint[31] = evt.str[4]  -- "Tile"
evt.map[31] = function()
	evt.Set("MapVar0", 0)
	evt.MoveToMap{X = 1916, Y = 6618, Z = 1, Direction = 502, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[32] = evt.str[4]  -- "Tile"
evt.map[32] = function()
	evt.Set("MapVar0", 0)
	evt.MoveToMap{X = -2688, Y = 1152, Z = 1152, Direction = 1550, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[33] = evt.str[2]  -- "Lever"
evt.map[33] = function()
	evt.SetDoorState{Id = 48, State = 2}         -- switch state
	evt.SetDoorState{Id = 41, State = 2}         -- switch state
end

evt.hint[34] = evt.str[2]  -- "Lever"
evt.map[34] = function()
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
	evt.SetDoorState{Id = 50, State = 2}         -- switch state
end

evt.hint[35] = evt.str[2]  -- "Lever"
evt.map[35] = function()
	evt.SetDoorState{Id = 43, State = 2}         -- switch state
	evt.SetDoorState{Id = 53, State = 2}         -- switch state
end

evt.hint[36] = evt.str[2]  -- "Lever"
evt.map[36] = function()
	evt.SetDoorState{Id = 44, State = 2}         -- switch state
	evt.SetDoorState{Id = 51, State = 2}         -- switch state
end

evt.hint[38] = evt.str[2]  -- "Lever"
evt.map[38] = function()
	evt.SetDoorState{Id = 45, State = 2}         -- switch state
	evt.SetDoorState{Id = 48, State = 2}         -- switch state
end

evt.hint[39] = evt.str[2]  -- "Lever"
evt.map[39] = function()
	evt.SetDoorState{Id = 46, State = 2}         -- switch state
	evt.SetDoorState{Id = 52, State = 2}         -- switch state
	evt.SetDoorState{Id = 49, State = 0}
end

evt.hint[40] = evt.str[2]  -- "Lever"
evt.map[40] = function()
	evt.SetDoorState{Id = 47, State = 2}         -- switch state
	evt.SetDoorState{Id = 49, State = 2}         -- switch state
end

evt.hint[41] = evt.str[4]  -- "Tile"
evt.map[41] = function()
	evt.Set("MapVar0", 0)
	evt.MoveToMap{X = -1822, Y = 4049, Z = 1, Direction = 502, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[42] = evt.str[4]  -- "Tile"
evt.map[42] = function()
	evt.Set("MapVar0", 0)
	evt.MoveToMap{X = 134, Y = 1151, Z = 1, Direction = 502, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[43] = evt.str[4]  -- "Tile"
evt.map[43] = function()
	evt.Set("MapVar0", 0)
	evt.MoveToMap{X = 2324, Y = -141, Z = -2047, Direction = 896, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[44] = evt.str[5]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(1)
end

evt.hint[45] = evt.str[5]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(2)
end

evt.hint[46] = evt.str[5]  -- "Chest"
evt.map[46] = function()
	evt.OpenChest(3)
end

evt.hint[47] = evt.str[5]  -- "Chest"
evt.map[47] = function()
	evt.OpenChest(4)
end

evt.hint[48] = evt.str[5]  -- "Chest"
evt.map[48] = function()
	if not evt.Cmp("MapVar49", 1) then
		if evt.Cmp("QBits", 5) then         --  5 D18, questbit for getting hourglass
			evt.OpenChest(8)
			return
		end
		evt.Set("MapVar49", 1)
	end
	evt.OpenChest(5)
	evt.Set("QBits", 5)         --  5 D18, questbit for getting hourglass
	evt.Set("QBits", 183)         -- Quest item bits for seer
end

evt.hint[49] = evt.str[5]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(6)
end

evt.hint[50] = evt.str[5]  -- "Chest"
evt.map[50] = function()
	evt.OpenChest(7)
end

evt.map[51] = function()
	evt.Set("MapVar0", 1)
end

evt.map[52] = function()  -- function events.LoadMap()
	evt.Set("MapVar0", 0)
end

events.LoadMap = evt.map[52].last

evt.map[53] = function()
	evt.Set("MapVar0", 0)
end

evt.map[54] = function()  -- Timer(<function>, 1*const.Minute)
	if evt.Cmp("MapVar0", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 25}
	end
end

Timer(evt.map[54].last, 1*const.Minute)

evt.hint[55] = evt.str[1]  -- "Door"
evt.map[55] = function()
	evt.StatusText(3)         -- "The Door won't budge."
end

evt.map[56] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.SummonObject{Type = 1000, X = -1792, Y = 1536, Z = -508, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	elseif i == 2 then
		evt.SummonObject{Type = 1050, X = -1024, Y = 1408, Z = -508, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 3 then
		evt.SummonObject{Type = 1000, X = -1920, Y = 640, Z = -508, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	elseif i == 4 then
		evt.SummonObject{Type = 1050, X = -1664, Y = 256, Z = -508, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 5 then
		evt.SummonObject{Type = 1050, X = -1280, Y = 128, Z = -508, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	else
		evt.SummonObject{Type = 1050, X = -1280, Y = -256, Z = -508, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	end
end

Timer(evt.map[56].last, 0.5*const.Minute)

evt.map[57] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Type = 1000, X = 2688, Y = 6016, Z = -765, Speed = 1000, Count = 2, RandomAngle = true}         -- flare
	elseif i == 2 then
		evt.SummonObject{Type = 1050, X = 3328, Y = 5888, Z = -765, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 3 then
		evt.SummonObject{Type = 1000, X = 1664, Y = 5888, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	elseif i == 4 then
		evt.SummonObject{Type = 1050, X = 2650, Y = 6528, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	else
		evt.SummonObject{Type = 1050, X = 2650, Y = 5248, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	end
end

Timer(evt.map[57].last, 0.5*const.Minute)

evt.map[58] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.SummonObject{Type = 1000, X = 4608, Y = 256, Z = -2044, Speed = 1000, Count = 2, RandomAngle = true}         -- flare
	elseif i == 2 then
		evt.SummonObject{Type = 1050, X = 4736, Y = 0, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	elseif i == 3 then
		evt.SummonObject{Type = 1050, X = 4736, Y = -640, Z = -2044, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 4 then
		evt.SummonObject{Type = 1000, X = 4608, Y = -2816, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	elseif i == 5 then
		evt.SummonObject{Type = 1050, X = 3456, Y = -3456, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	else
		evt.SummonObject{Type = 1050, X = 2816, Y = -3072, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	end
end

Timer(evt.map[58].last, 0.5*const.Minute)

evt.map[59] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{Type = 1050, X = -2432, Y = -2304, Z = -2044, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 2 then
		evt.SummonObject{Type = 1050, X = 1408, Y = -1280, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	elseif i == 3 then
		evt.SummonObject{Type = 1050, X = 512, Y = -1152, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	else
		evt.SummonObject{Type = 1000, X = -1024, Y = -1024, Z = -2044, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	end
end

Timer(evt.map[59].last, 0.5*const.Minute)

evt.map[60] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{Type = 1050, X = 2560, Y = 2304, Z = -1404, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	elseif i == 2 then
		evt.SummonObject{Type = 1000, X = 2560, Y = 1664, Z = -1404, Speed = 1000, Count = 2, RandomAngle = true}         -- flare
	elseif i == 3 then
		evt.SummonObject{Type = 1050, X = 3456, Y = 2304, Z = -1404, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	else
		evt.SummonObject{Type = 1050, X = 3456, Y = 1792, Z = -1404, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	end
end

Timer(evt.map[60].last, 0.5*const.Minute)

evt.map[61] = function()  -- Timer(<function>, 0.5*const.Minute)
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Type = 1000, X = 896, Y = 2816, Z = -765, Speed = 1000, Count = 2, RandomAngle = true}         -- flare
	elseif i == 2 then
		evt.SummonObject{Type = 1050, X = 1280, Y = 2432, Z = -765, Speed = 1000, Count = 2, RandomAngle = true}         -- fireball
	elseif i == 3 then
		evt.SummonObject{Type = 1000, X = -512, Y = 2688, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- flare
	elseif i == 4 then
		evt.SummonObject{Type = 1050, X = -1024, Y = 2304, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	else
		evt.SummonObject{Type = 1050, X = -256, Y = 2816, Z = -765, Speed = 1000, Count = 2, RandomAngle = false}         -- fireball
	end
end

Timer(evt.map[61].last, 0.5*const.Minute)

evt.hint[62] = evt.str[8]  -- "Bookcase"
evt.map[62] = function()
	local i
	if not evt.Cmp("MapVar1", 4) then
		evt.Add("MapVar1", 1)
		evt.StatusText(7)         -- "Found something!"
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 349)         -- "Guardian Angel"
		elseif i == 2 then
			evt.Add("Inventory", 359)         -- "Cure Paralysis"
		elseif i == 3 then
			evt.Add("Inventory", 362)         -- "Feeblemind"
		elseif i == 4 then
			evt.Add("Inventory", 372)         -- "Speed"
		elseif i == 5 then
			evt.Add("Inventory", 353)         -- "Shared Life"
		else
			evt.Add("Inventory", 350)         -- "Heroism"
		end
	end
end

evt.hint[90] = evt.str[9]  -- "Exit"
evt.map[90] = function()
	evt.MoveToMap{X = -7537, Y = 4032, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD2.Odm"}
end

evt.map[91] = function()
	if not evt.Cmp("MapVar44", 1) then
		if not evt.Cmp("PlayerBits", 30) then
			evt.Set("MapVar44", 1)
			evt.Set("PlayerBits", 30)
			evt.Add("FireResistance", 25)
		end
	end
end

