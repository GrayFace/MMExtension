local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Guano Rock",
	[5] = "You've Rescued a child!  How patriarchal of you",
	[6] = "This Rock is covered in bat guano",
	[7] = "You harvest the guano and put it in your pouch",
	[8] = "You pick up some guano, but have nowhere to put it.",
	[9] = "Cage",
	[10] = "You open the cage and remove the bones.",
	[11] = "Teleporter",
	[12] = "Underwald",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

