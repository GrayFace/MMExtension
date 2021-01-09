local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Chest",
	[3] = "Chest",
	[4] = "Exit",
	[5] = "You easily defeat the lock.",
	[6] = "A teleporter!",
	[7] = "You are unable to pick the lock.",
	[8] = "-50 Speed Temporary",
	[9] = "Cage",
	[10] = "Haunt of the Rusalka",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

