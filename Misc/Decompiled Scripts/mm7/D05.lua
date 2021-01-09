local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Arena",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[376] = evt.str[1]  -- "Door"
evt.map[376] = function()
	evt.SpeakNPC(300)         -- "Arena Master"
end

evt.map[451] = function()  -- Timer(<function>, 2*const.Minute)
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

Timer(evt.map[451].last, 2*const.Minute)

evt.map[452] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

Timer(evt.map[452].last, 2.5*const.Minute)

evt.map[453] = function()  -- Timer(<function>, 1.5*const.Minute)
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

Timer(evt.map[453].last, 1.5*const.Minute)

evt.map[454] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

Timer(evt.map[454].last, 2.5*const.Minute)

evt.map[455] = function()  -- Timer(<function>, 2*const.Minute)
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

Timer(evt.map[455].last, 2*const.Minute)

evt.map[456] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

Timer(evt.map[456].last, 2.5*const.Minute)

evt.map[457] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.hint[501] = evt.str[2]  -- "Leave the Arena"
evt.map[501] = function()
	evt.MoveToMap{X = -5692, Y = 11137, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out02.odm"}
end

