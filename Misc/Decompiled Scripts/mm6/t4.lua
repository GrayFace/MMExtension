local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "The door is locked",
	[6] = "Exit",
	[7] = "Temple of the Sun",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Temple of the Sun"

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
	if not evt.Cmp("QBits", 51) then         -- 51 T4, Given when characters find Silver Chalice.
		evt.Set("QBits", 51)         -- 51 T4, Given when characters find Silver Chalice.
		evt.Add("Inventory", 434)         -- "Sacred Chalice"
		evt.Set("QBits", 188)         -- Quest item bits for seer
	elseif not evt.Cmp("MapVar4", 1) then
		evt.GiveItem{Strength = 4, Type = const.ItemType.Sword, Id = 0}
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.GiveItem{Strength = 4, Type = const.ItemType.Shield_, Id = 0}
		evt.Set("MapVar4", 1)
	end
end

evt.hint[14] = evt.str[6]  -- "Exit"
evt.map[14] = function()
	evt.MoveToMap{X = -7537, Y = 4032, Z = 97, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD2.Odm"}
end

evt.map[15] = function()  -- Timer(<function>, const.Day, 21*const.Hour, false)
	evt.SetLight{Id = 0, On = false}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_NIT1"}
end

Timer(evt.map[15].last, const.Day, 21*const.Hour, false)

evt.map[16] = function()  -- Timer(<function>, const.Day, 88*const.Hour, false)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = true}
	evt.SetTexture{Facet = 79, Name = "OrAir256"}
end

Timer(evt.map[16].last, const.Day, 88*const.Hour, false)

evt.map[17] = function()  -- Timer(<function>, const.Day, 208*const.Hour, false)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_SNS1"}
end

Timer(evt.map[17].last, const.Day, 208*const.Hour, false)

evt.map[18] = function()  -- Timer(<function>, const.Day, 244*const.Hour, false)
	evt.SetLight{Id = 0, On = true}
	evt.SetLight{Id = 1, On = false}
	evt.SetTexture{Facet = 79, Name = "SKY_SNS1"}
end

Timer(evt.map[18].last, const.Day, 244*const.Hour, false)

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

