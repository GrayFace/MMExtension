local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "(removed) White Wine",
	[6] = "(removed) +1 Luck Permanent",
	[7] = "(removed) +4 Endurance Temporary",
	[8] = "(removed) Hic",
	[9] = "The door is locked.",
	[10] = "(removed) Suspicious Floor",
	[11] = "(removed) Deleted",
	[12] = "(removed) +10 Hit Points Temporary",
	[13] = "(removed) Stout Malt Ale",
	[14] = "(removed) You're too drunk to find the barrel!",
	[15] = "Door",
	[16] = "Tortuga Hall",
	[17] = "Brianna's Brandy",
	[18] = "The cauldron is empty",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

