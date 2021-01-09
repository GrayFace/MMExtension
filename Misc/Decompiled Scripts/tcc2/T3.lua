local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "Chest",
	[4] = "Cell",
	[5] = "The door is locked",
	[6] = "Lunatic Vault",
	[7] = "Flame of Might",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

