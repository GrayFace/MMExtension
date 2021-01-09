local TXT = Localize{
	[0] = " ",
	[1] = "Wooden Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "Mural",
	[6] = "Ched Rhinn",
	[7] = "The chest is locked",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

