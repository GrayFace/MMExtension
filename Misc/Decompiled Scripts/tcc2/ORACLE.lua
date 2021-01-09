local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Not enough memory to operate.",
	[5] = "Panel",
	[6] = "Oracle",
	[7] = "Power on.  Status:  All systems functional.",
	[8] = "Power off.  Status:  All systems shut down.",
	[9] = "Insert Memory module to activate Melian.",
	[10] = "Memory module restored.",
	[11] = "+100,000 Experience",
	[12] = "Stand by…",
	[13] = "Oracle of Enroth",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

