local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "Chest",
	[4] = "Cell",
	[5] = "The door is locked",
	[6] = "Lunatic Vault",
	[7] = "Flame of Might",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[6]  -- "Lunatic Vault"
-- ERROR: Duplicate label: 25:4
-- ERROR: Duplicate label: 25:0

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
	evt.SetDoorState{Id = 6, State = 1}
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

evt.hint[12] = evt.str[3]  -- "Chest"
evt.map[12] = function()
	evt.OpenChest(1)
end

evt.hint[13] = evt.str[3]  -- "Chest"
evt.map[13] = function()
	evt.OpenChest(2)
end

evt.hint[31] = evt.str[3]  -- "Chest"
evt.map[31] = function()
	evt.OpenChest(3)
end

evt.hint[14] = evt.str[3]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(4)
end

evt.hint[15] = evt.str[3]  -- "Chest"
evt.map[15] = function()
	evt.OpenChest(5)
end

evt.hint[16] = evt.str[3]  -- "Chest"
evt.map[16] = function()
	evt.OpenChest(6)
end

evt.hint[17] = evt.str[2]  -- "Lever"
evt.map[17] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.map[18] = function()
	evt.Set("MapVar2", 1)
end

evt.hint[19] = evt.str[4]  -- "Cell"
evt.map[19] = function()
	if evt.Cmp("Inventory", 566) then         -- "Cell Key"
		evt.Subtract("Inventory", 566)         -- "Cell Key"
		evt.SetDoorState{Id = 25, State = 1}
	else
		evt.StatusText(5)         -- "The door is locked"
	end
end

evt.hint[20] = evt.str[2]  -- "Lever"
evt.map[20] = function()
	evt.SetDoorState{Id = 14, State = 1}
	evt.Add("MapVar0", 1)
	if evt.Cmp("MapVar0", 2) then
		evt.SetDoorState{Id = 16, State = 1}
	end
end

evt.hint[21] = evt.str[2]  -- "Lever"
evt.map[21] = function()
	evt.SetDoorState{Id = 15, State = 1}
	evt.Add("MapVar0", 1)
	if evt.Cmp("MapVar0", 2) then
		evt.SetDoorState{Id = 16, State = 1}
	end
end

evt.hint[22] = evt.str[7]  -- "Flame of Might"
evt.map[22] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 498) then         -- Flame of Might once
		evt.Add("BaseMight", 20)
		evt.Set("QBits", 498)         -- Flame of Might once
	end
end

evt.hint[23] = evt.str[2]  -- "Lever"
evt.map[23] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.hint[24] = evt.str[2]  -- "Lever"
evt.map[24] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
end

evt.map[25] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 479) then         -- Lunatic Vault Once
		return
	end
	if not evt.Cmp("QBits", 508) then         -- Warrior
		if not evt.Cmp("QBits", 507) then         -- Death Wish
			goto _4
		end
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 285, Y = -165, Z = 300}
	end
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -122, Y = -91, Z = 300}
::_4::
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 250, Z = 300}
	evt.Set("QBits", 479)         -- Lunatic Vault Once
end

events.LoadMap = evt.map[25].last

evt.hint[26] = evt.str[2]  -- "Lever"
evt.map[26] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
end

evt.map[27] = function()
	evt.Set("MapVar2", 0)
end

evt.map[28] = function()  -- Timer(<function>, 1*const.Minute)
	if evt.Cmp("MapVar2", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 5}
	end
end

Timer(evt.map[28].last, 1*const.Minute)

evt.hint[29] = evt.str[1]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 24, State = 1}
end

evt.map[30] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 423) then         -- Used for ??
		evt.Add("QBits", 423)         -- Used for ??
		evt.Add("Gold", 1000)
	end
end

evt.map[50] = function()
	evt.MoveToMap{X = 7474, Y = 17670, Z = 97, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD2.Odm"}
end

evt.map[55] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.GiveItem{Strength = 5, Type = const.ItemType.Spear, Id = 0}
	end
end

evt.map[60] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Afraid", 0)
end

events.LoadMap = evt.map[60].last

evt.map[61] = function()  -- Timer(<function>, 5*const.Minute)
	evt.ForPlayer("All")
	evt.Set("Afraid", 0)
end

Timer(evt.map[61].last, 5*const.Minute)

evt.map[62] = function()  -- Timer(<function>, 1*const.Hour)
	evt.ForPlayer("All")
	evt.Set("Insane", 0)
end

Timer(evt.map[62].last, 1*const.Hour)

