local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 3, State = 1}
end

evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Chest"
evt.map[5] = function()
	evt.OpenChest(2)
end

evt.hint[6] = evt.str[1]  -- "Chest"
evt.map[6] = function()
	evt.OpenChest(3)
end

