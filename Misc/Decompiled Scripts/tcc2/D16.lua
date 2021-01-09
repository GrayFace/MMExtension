local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "You are pulled through the door!",
	[6] = "The door is locked.",
	[7] = "The door is double locked.",
	[8] = "You were unable to pick the lock.",
	[9] = "Chest of Drawers",
	[10] = "You have found two keys!",
	[11] = "You have found a key!",
	[12] = "Switch",
	[13] = "The Eagle Statuette!",
	[14] = "Exit",
	[15] = "This door won't open.",
	[16] = "Haldegarn's Lair",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

