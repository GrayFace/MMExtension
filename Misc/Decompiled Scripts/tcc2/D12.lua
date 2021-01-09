local TXT = Localize{
	[0] = " ",
	[1] = "Skull Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "I am Sir John Silver.  I was most foully murdered by my Lieutenant when I discovered that he was involved with his sorcererous brother and a senior priest in the Temple of Baa in a conspiracy against King Roland.  There are no good men left in the order, and it sickens my soul to say so.",
	[6] = "I am Sir John Silver.  I was most foully murdered by my Lieutenant when I discovered that he was involved with his sorcererous brother and a senior priest in the Temple of Baa in a conspiracy against King Roland.  I am grateful for the rescue of my niece, Melody, from my treacherous Lieutenant by you.  I will open a secret door to a nearby treasure room for you as a reward for your heroism.",
	[7] = "Mercenary Stronghold",
	[8] = "Skull Door 1",
	[9] = "Skull Door 2",
	[10] = "Skull Door 3",
	[11] = "Skull Door 4",
	[12] = "Skull Door 5",
	[13] = "Skull Door 6",
	[14] = "Skull Door 7",
	[15] = "Skull Door 8",
	[16] = "Skull Door 9",
	[17] = "Skull Door 10",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

