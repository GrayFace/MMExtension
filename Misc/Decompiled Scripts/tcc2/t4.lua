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


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

