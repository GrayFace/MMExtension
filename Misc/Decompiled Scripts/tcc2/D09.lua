local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Double Door",
	[4] = "Chest",
	[5] = "Cabinet",
	[6] = "Bookshelves",
	[7] = "You thumb through the books, but find nothing of interest.",
	[8] = "The Door is Locked",
	[9] = "Exit",
	[10] = "Pool",
	[11] = "+10 Hit points restored.",
	[12] = "+10 Spell points restored.",
	[13] = "Refreshing!",
	[14] = "You are not smart enough!",
	[15] = "Glastonbury Tor",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

