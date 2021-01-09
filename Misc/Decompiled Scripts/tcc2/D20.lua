local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
	[3] = "Barrel",
	[4] = "Lair of Koschei",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

