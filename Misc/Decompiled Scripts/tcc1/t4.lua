local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "The door is locked",
	[6] = "Exit",
	[7] = "Temple of Babzot",
	[8] = "Gepetto's Thermos",
	[9] = "The caudron is empty,",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[7]  -- "Temple of Babzot"
-- ERROR: Duplicate label: 13:10

evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[2]  -- "Chest"
evt.map[4] = function()
	evt.OpenChest(0)
end

evt.hint[5] = evt.str[2]  -- "Chest"
evt.map[5] = function()
	evt.OpenChest(1)
end

evt.hint[6] = evt.str[2]  -- "Chest"
evt.map[6] = function()
	evt.OpenChest(2)
end

evt.hint[7] = evt.str[2]  -- "Chest"
evt.map[7] = function()
	evt.OpenChest(3)
end

evt.hint[8] = evt.str[3]  -- "Chest"
evt.map[8] = function()
	evt.OpenChest(4)
end

evt.hint[9] = evt.str[2]  -- "Chest"
evt.map[9] = function()
	evt.OpenChest(5)
end

evt.hint[10] = evt.str[2]  -- "Chest"
evt.map[10] = function()
	evt.OpenChest(6)
end

evt.hint[11] = evt.str[3]  -- "Chest"
evt.map[11] = function()
	evt.OpenChest(7)
end

evt.hint[12] = evt.str[2]  -- "Chest"
evt.map[12] = function()
	evt.OpenChest(8)
end

evt.hint[13] = evt.str[4]  -- "Cabinet"
evt.map[13] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.GiveItem{Strength = 4, Type = const.ItemType.Sword, Id = 0}
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.GiveItem{Strength = 4, Type = const.ItemType.Shield_, Id = 0}
	end
	evt.Set("MapVar4", 1)
end

evt.hint[14] = evt.str[6]  -- "Exit"
evt.map[14] = function()
	evt.MoveToMap{X = -21468, Y = -263, Z = 193, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE3.odm"}
end

evt.map[15] = function()  -- Timer(<function>, const.Day, 21*const.Hour)
	evt.SetLight{Id = 0, On = false}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_NIT1"}
end

Timer(evt.map[15].last, const.Day, 21*const.Hour)

evt.map[16] = function()  -- Timer(<function>, const.Day, 88*const.Hour)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = true}
	evt.SetTexture{Facet = 79, Name = "OrAir256"}
end

Timer(evt.map[16].last, const.Day, 88*const.Hour)

evt.map[17] = function()  -- Timer(<function>, const.Day, 208*const.Hour)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_SNS1"}
end

Timer(evt.map[17].last, const.Day, 208*const.Hour)

evt.map[18] = function()  -- Timer(<function>, const.Day, 244*const.Hour)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_SNS1"}
end

Timer(evt.map[18].last, const.Day, 244*const.Hour)

evt.map[19] = function()  -- function events.LoadMap()
	if not evt.Cmp("HourIs", 2100) then
		if evt.Cmp("HourIs", 2000) then
			goto _9
		end
		if evt.Cmp("HourIs", 600) then
			return
		end
		if evt.Cmp("HourIs", 500) then
			goto _9
		end
	end
	evt.SetLight{Id = 0, On = false}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_NIT1"}
	do return end
::_9::
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_SNS1"}
end

events.LoadMap = evt.map[19].last

evt.map[20] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.Add("Inventory", 286)         -- "Sun Ray"
	end
end

evt.map[21] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.Add("Inventory", 286)         -- "Sun Ray"
	end
end

evt.map[22] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.Add("Inventory", 286)         -- "Sun Ray"
	end
end

evt.map[23] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.Add("Inventory", 286)         -- "Sun Ray"
	end
end

evt.map[24] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 481) then         -- Abandoned Temple Reload Once
		evt.Set("QBits", 481)         -- Abandoned Temple Reload Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -1120, Y = 596, Z = -63}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 1599, Y = 187, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -1120, Y = 580, Z = -63}
	end
end

events.LoadMap = evt.map[24].last

evt.hint[25] = evt.str[8]  -- "Gepetto's Thermos"
evt.map[25] = function()
	if evt.Cmp("QBits", 483) then         -- Gepeto's Thermos
		evt.StatusText(9)         -- "The caudron is empty,"
	else
		evt.ForPlayer("All")
		evt.Set("RepairSkill", 68)
		evt.Set("QBits", 483)         -- Gepeto's Thermos
	end
end

