local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Lever",
	[4] = "Cabinet",
	[5] = "Switch",
	[6] = "The Door won't budge.",
	[7] = "Caught!",
	[8] = "Guards!",
	[9] = "Are those footsteps?",
	[10] = "Exit",
	[11] = "Druid's Temple",
	[12] = "You open the chest and exchange the pearls.",
	[13] = "The chest is locked.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

