local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Statue",
	[3] = "Strange tree",
	[4] = "Temple of Agrona's Faithful",
	[5] = "Sacred Pool",
	[6] = "Altar of Agrona",
	[7] = "Chest",
	[8] = "Nice Flower",
	[9] = "The door will not budge.",
	[10] = "You search the tree and find something.",
	[11] = "+75 Personality permanent!",
	[12] = "The statue shifts as your touch it.",
	[13] = "The rock shifts at your touch.",
	[14] = "The pool shimmers as you touch it.",
	[15] = "The monolith feels strange to the touch.",
	[16] = "You find nothing.",
	[17] = "The tree shakes at your touch.",
	[18] = "The flowers smell nice.",
	[19] = "Exit",
	[20] = "Strange rock",
	[21] = "Temple of Agorna's Faithful",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

