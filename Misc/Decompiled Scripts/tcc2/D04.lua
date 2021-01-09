local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "All must have amber.  Take life force!",
	[4] = "The chest is locked.",
	[5] = "Magically Refreshing!",
	[6] = "Exit",
	[7] = "Deleted",
	[8] = "The door is locked.",
	[9] = "Ah, delicious amber!",
	[10] = "Stone Face",
	[11] = "Water",
	[12] = "Bag",
	[13] = "The Door is warded.",
	[14] = "All wards must be destroyed.",
	[15] = "The door won't budge.",
	[16] = "Lord of Forgetfullness",
	[17] = "Forbidden Vault",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

