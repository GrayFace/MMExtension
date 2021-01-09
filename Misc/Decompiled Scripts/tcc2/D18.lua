local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "The Door won't budge.",
	[4] = "Tile",
	[5] = "Chest",
	[6] = "The Door is locked",
	[7] = "Found something!",
	[8] = "Bookcase",
	[9] = "Exit",
	[10] = "Oozew Pit",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

