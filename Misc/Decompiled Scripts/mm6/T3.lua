local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "Chest",
	[4] = "Cell",
	[5] = "The door is locked",
	[6] = "Temple of Tsantsa",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[6]  -- "Temple of Tsantsa"

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

evt.hint[26] = evt.str[2]  -- "Lever"
evt.map[26] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
end

evt.map[25] = function()
	evt.SetDoorState{Id = 17, State = 1}
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
	if not evt.Cmp("QBits", 6) then         --  6 T3, given when you rescue prisoner
		evt.SpeakNPC(155)         -- "Sherell Ivanaveh"
		evt.Set("NPCs", 155)         -- "Sherell Ivanaveh"
		evt.Set("QBits", 6)         --  6 T3, given when you rescue prisoner
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

