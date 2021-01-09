local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "You are pulled through the door!",
	[6] = "The door is locked.",
	[7] = "The door is double locked.",
	[8] = "You were unable to pick the lock.",
	[9] = "Chest of Drawers",
	[10] = "You have found two keys!",
	[11] = "You have found a key!",
	[12] = "Switch",
	[13] = "The Eagle Statuette!",
	[14] = "Exit",
	[15] = "This door won't open.",
	[16] = "Warlord's Fortress",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[16]  -- "Warlord's Fortress"

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

evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[2]  -- "Door"
evt.map[6] = function()
	if not evt.Cmp("Inventory", 565) then         -- "Storage Key"
		evt.StatusText(7)         -- "The door is double locked."
	elseif not evt.Cmp("Inventory", 571) then         -- "Storage Key"
		evt.StatusText(7)         -- "The door is double locked."
	elseif evt.Cmp("MapVar9", 10) then
		evt.Subtract("Inventory", 565)         -- "Storage Key"
		evt.Subtract("Inventory", 571)         -- "Storage Key"
		evt.SetDoorState{Id = 6, State = 1}
	else
		evt.Set("MapVar9", 10)
		evt.SetDoorState{Id = 6, State = 1}
	end
end

evt.hint[7] = evt.str[2]  -- "Door"
evt.map[7] = function()
	if not evt.Cmp("Inventory", 565) then         -- "Storage Key"
		evt.StatusText(7)         -- "The door is double locked."
	elseif not evt.Cmp("Inventory", 571) then         -- "Storage Key"
		evt.StatusText(7)         -- "The door is double locked."
	elseif evt.Cmp("MapVar9", 10) then
		evt.Subtract("Inventory", 565)         -- "Storage Key"
		evt.Subtract("Inventory", 571)         -- "Storage Key"
		evt.SetDoorState{Id = 7, State = 1}
	else
		evt.Set("MapVar9", 10)
		evt.SetDoorState{Id = 7, State = 1}
	end
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[2]  -- "Door"
evt.map[9] = function()
	if evt.Cmp("Inventory", 564) then         -- "Warlord's Key"
		evt.SetDoorState{Id = 9, State = 1}
		evt.Subtract("Inventory", 564)         -- "Warlord's Key"
	else
		evt.StatusText(6)         -- "The door is locked."
	end
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

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

evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[12]  -- "Switch"
evt.map[19] = function()
	evt.SetTexture{Facet = 960, Name = "D8s2on"}
	evt.SetDoorState{Id = 19, State = 1}
	evt.Set("MapVar19", 1)
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.MoveToMap{X = -2539, Y = -512, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -1537, Y = -788, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = -1012, Y = -1284, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -1036, Y = -1775, Z = -255, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
	evt.StatusText(5)         -- "You are pulled through the door!"
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.MoveToMap{X = -3586, Y = -789, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -1537, Y = -788, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = -1012, Y = -1284, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -1036, Y = -1775, Z = -255, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
	evt.StatusText(5)         -- "You are pulled through the door!"
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.MoveToMap{X = -3586, Y = -789, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -2539, Y = -512, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = -1012, Y = -1284, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -1036, Y = -1775, Z = -255, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
	evt.StatusText(5)         -- "You are pulled through the door!"
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.MoveToMap{X = -3586, Y = -789, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -2539, Y = -512, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = -1537, Y = -788, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -1036, Y = -1775, Z = -255, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
	evt.StatusText(5)         -- "You are pulled through the door!"
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	local i
	i = Game.Rand() % 4
	if i == 1 then
		evt.MoveToMap{X = -3586, Y = -789, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -2539, Y = -512, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = -1537, Y = -788, Z = -255, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -1012, Y = -1284, Z = -255, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
	evt.StatusText(5)         -- "You are pulled through the door!"
end

evt.hint[25] = evt.str[3]  -- "Chest"
evt.map[25] = function()
	evt.StatusText(8)         -- "You were unable to pick the lock."
end

evt.hint[26] = evt.str[4]  -- "Cabinet"
evt.map[26] = function()
	evt.StatusText(8)         -- "You were unable to pick the lock."
end

evt.hint[27] = evt.str[3]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(2)
end

evt.hint[28] = evt.str[3]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(3)
end

evt.hint[29] = evt.str[3]  -- "Chest"
evt.map[29] = function()
	evt.OpenChest(4)
end

evt.hint[30] = evt.str[3]  -- "Chest"
evt.map[30] = function()
	evt.OpenChest(5)
end

evt.hint[31] = evt.str[3]  -- "Chest"
evt.map[31] = function()
	evt.OpenChest(6)
end

evt.hint[32] = evt.str[3]  -- "Chest"
evt.map[32] = function()
	evt.OpenChest(7)
end

evt.hint[33] = evt.str[3]  -- "Chest"
evt.map[33] = function()
	evt.OpenChest(8)
end

evt.hint[34] = evt.str[3]  -- "Chest"
evt.map[34] = function()
	evt.OpenChest(9)
end

evt.hint[35] = evt.str[4]  -- "Cabinet"
evt.map[35] = function()
	evt.OpenChest(10)
end

evt.hint[36] = evt.str[3]  -- "Chest"
evt.map[36] = function()
	if evt.Cmp("QBits", 52) then         -- 52 D16, Given when characters find the Eagle Statuette
		if not evt.Cmp("MapVar20", 1) then
			evt.OpenChest(0)
			return
		end
	end
	evt.OpenChest(11)
	evt.Set("QBits", 52)         -- 52 D16, Given when characters find the Eagle Statuette
	evt.Set("QBits", 187)         -- Quest item bits for seer
	evt.Set("MapVar20", 1)
end

evt.hint[37] = evt.str[3]  -- "Chest"
evt.map[37] = function()
	evt.OpenChest(12)
end

evt.hint[38] = evt.str[4]  -- "Cabinet"
evt.map[38] = function()
	evt.OpenChest(13)
end

evt.hint[39] = evt.str[3]  -- "Chest"
evt.map[39] = function()
	evt.OpenChest(14)
end

evt.hint[40] = evt.str[3]  -- "Chest"
evt.map[40] = function()
	evt.OpenChest(15)
end

evt.hint[41] = evt.str[3]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(16)
end

evt.hint[42] = evt.str[4]  -- "Cabinet"
evt.map[42] = function()
	evt.OpenChest(17)
end

evt.hint[43] = evt.str[4]  -- "Cabinet"
evt.map[43] = function()
	evt.OpenChest(18)
end

evt.hint[44] = evt.str[3]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(19)
end

evt.hint[45] = evt.str[9]  -- "Chest of Drawers"
evt.map[45] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.StatusText(10)         -- "You have found two keys!"
		evt.Add("Inventory", 564)         -- "Warlord's Key"
		evt.Add("Inventory", 565)         -- "Storage Key"
		evt.Set("MapVar0", 1)
	end
end

evt.hint[46] = evt.str[9]  -- "Chest of Drawers"
evt.map[46] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.StatusText(11)         -- "You have found a key!"
		evt.Add("Inventory", 571)         -- "Storage Key"
		evt.Set("MapVar1", 1)
	end
end

evt.hint[47] = evt.str[1]  -- "Door"
evt.map[47] = function()
	evt.StatusText(15)         -- "This door won't open."
end

evt.map[48] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar19", 1) then
		evt.SetTexture{Facet = 960, Name = "D8s2on"}
	end
end

events.LoadMap = evt.map[48].last

evt.hint[50] = evt.str[14]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -18606, Y = 9831, Z = 160, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD1.Odm"}
end

evt.map[51] = function()
	if not evt.Cmp("MapVar49", 1) then
		evt.Set("MapVar49", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Axe, Id = 0}
	end
end

