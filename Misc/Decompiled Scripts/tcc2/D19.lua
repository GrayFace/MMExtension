local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Elevator platform",
	[3] = "Chest",
	[4] = "Door",
	[5] = "Pushing this switch gives you a bad feeling.",
	[6] = "Uh oh....",
	[7] = "Here we go again….",
	[8] = "The switch doesn’t seem to work..",
	[9] = "Exit",
	[10] = "Chandelier",
	[11] = "Cauldron",
	[12] = "+50 Intellect permanent.",
	[13] = "The Garrison",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

