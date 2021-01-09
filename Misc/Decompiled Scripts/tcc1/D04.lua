local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "All must have amber.  Take life force!",
	[4] = "The chest is locked.",
	[5] = "Magically Refreshing!",
	[6] = "Exit",
	[7] = "Deleted",
	[8] = "The door is locked.",
	[9] = "Ah, delicious amber!",
	[10] = "Stone Face",
	[11] = "Water",
	[12] = "Bag",
	[13] = "The Door is warded.",
	[14] = "All wards must be destroyed.",
	[15] = "The door won't budge.",
	[16] = "Lord of Forgetfullness",
	[17] = "Forbidden Vault",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[17]  -- "Forbidden Vault"

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
	if evt.Cmp("QBits", 71) then         -- Walt
		goto _14
	end
	if not evt.Cmp("MapVar9", 1) then
		if not evt.Cmp("QBits", 41) then         -- Bruce
			evt.StatusText(13)         -- "The Door is warded."
			return
		end
		if not evt.Cmp("Inventory", 482) then         -- "Amber"
			evt.StatusText(13)         -- "The Door is warded."
			return
		end
		evt.Subtract("Inventory", 482)         -- "Amber"
		evt.Set("MapVar9", 1)
	end
	if not evt.Cmp("MapVar19", 1) then
		evt.StatusText(14)         -- "All wards must be destroyed."
		return
	end
	evt.Set("QBits", 71)         -- Walt
::_14::
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 20, State = 1}
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

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
	evt.SetDoorState{Id = 45, State = 0}
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	if evt.Cmp("QBits", 71) then         -- Walt
		goto _14
	end
	if not evt.Cmp("MapVar19", 1) then
		if not evt.Cmp("QBits", 41) then         -- Bruce
			evt.StatusText(13)         -- "The Door is warded."
			return
		end
		if not evt.Cmp("Inventory", 482) then         -- "Amber"
			evt.StatusText(13)         -- "The Door is warded."
			return
		end
		evt.Subtract("Inventory", 482)         -- "Amber"
		evt.Set("MapVar19", 1)
	end
	if not evt.Cmp("MapVar9", 1) then
		evt.StatusText(14)         -- "All wards must be destroyed."
		return
	end
	evt.Set("QBits", 71)         -- Walt
::_14::
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 2}         -- switch state
end

evt.hint[27] = evt.str[10]  -- "Stone Face"
evt.map[27] = function()
	evt.MoveToMap{X = -1792, Y = -19, Z = 1, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[28] = function()
	evt.MoveToMap{X = -2853, Y = 1600, Z = -2655, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[29] = function()
	evt.MoveToMap{X = 2823, Y = 1534, Z = -2655, Direction = 45, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.map[31] = function()
	evt.SetDoorState{Id = 30, State = 0}
end

evt.map[32] = function()
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
end

evt.map[33] = function()
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[41] = evt.str[2]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(1)
end

evt.hint[42] = evt.str[2]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(2)
	evt.Set("QBits", 75)         -- Lisa
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

evt.hint[46] = evt.str[2]  -- "Chest"
evt.map[46] = function()
	evt.OpenChest(6)
end

evt.hint[47] = evt.str[2]  -- "Chest"
evt.map[47] = function()
	evt.OpenChest(7)
end

evt.hint[48] = evt.str[2]  -- "Chest"
evt.map[48] = function()
	evt.OpenChest(8)
end

evt.hint[49] = evt.str[2]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(9)
end

evt.map[50] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.CastSpell{Spell = 83, Mastery = const.Novice, Skill = 4, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Day of the Gods"
		evt.Set("MapVar1", 1)
		evt.StatusText(5)         -- "Magically Refreshing!"
	end
end

evt.hint[51] = evt.str[6]  -- "Exit"
evt.map[51] = function()
	evt.MoveToMap{X = 15218, Y = -14862, Z = 161, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC1.odm"}
end

evt.hint[52] = evt.str[16]  -- "Lord of Forgetfullness"
evt.map[52] = function()
	evt.SetDoorState{Id = 51, State = 1}
	evt.SetDoorState{Id = 52, State = 1}
	evt.Set("QBits", 41)         -- Bruce
end

evt.hint[53] = evt.str[2]  -- "Chest"
evt.map[53] = function()
	evt.OpenChest(10)
end

evt.hint[54] = evt.str[10]  -- "Stone Face"
evt.map[54] = function()
	evt.MoveToMap{X = -1792, Y = -19, Z = 1, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[55] = evt.str[1]  -- "Door"
evt.map[55] = function()
	evt.SetDoorState{Id = 55, State = 1}
end

evt.map[56] = function()  -- Timer(<function>, const.Day, 12*const.Hour)
	evt.Set("MapVar1", 0)
end

Timer(evt.map[56].last, const.Day, 12*const.Hour)

evt.map[57] = function()  -- Timer(<function>, const.Day, 12*const.Hour)
	evt.Set("MapVar1", 0)
end

Timer(evt.map[57].last, const.Day, 12*const.Hour)

evt.hint[58] = evt.str[10]  -- "Stone Face"
evt.map[58] = function()
	evt.MoveToMap{X = -1792, Y = -19, Z = 1, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[59] = evt.str[12]  -- "Bag"
evt.map[59] = function()
	evt.OpenChest(11)
end

evt.hint[60] = evt.str[1]  -- "Door"
evt.map[60] = function()
	evt.SetDoorState{Id = 58, State = 1}
end

evt.map[61] = function()  -- function events.LoadMap()
	evt.Set("QBits", 71)         -- Walt
end

events.LoadMap = evt.map[61].last

