local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "The door won't budge",
	[4] = "Exit  ",
	[5] = "Empty",
	[6] = " Switch",
	[7] = "Memory crystal",
	[8] = "Guardian of the Fortress",
	[9] = "The Guardian of the Fortress proclaims, 'For 50,000 gold, the secret will be revealed!'",
	[10] = "Accept (Yes/No)?",
	[11] = "Yes",
	[12] = "Y",
	[13] = "Get Lost!",
	[14] = "Curator of the Fortress",
	[15] = "The Curator of the Fortress proclaims, 'For 10,000 gold you shall be healed.'",
	[16] = "Cage",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

