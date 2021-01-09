local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Sign",
	[5] = "Scroll",
	[6] = "Expert Perception is the key and the doors of Chaos will let you be.                                                                                                                                                                                                                  The Spiral then each head, talk to Baa or you'll be dead.",
	[7] = "Chaos Idol",
	[8] = "You've defaced the idol!",
	[9] = "Chaos Idol",
	[10] = "You've defaced the idol!",
	[11] = "Chaos Idol",
	[12] = "You've defaced the idol!",
	[13] = "Chaos Idol",
	[14] = "You've defaced the idol!",
	[15] = "Chaos laughs at you!",
	[16] = "Almighty Idol of Chaos.",
	[17] = "Chaos laughs at you!",
	[18] = "You defaced the idol!  +250,000 Experience.",
	[19] = "The Idol is defaced!",
	[20] = "Book Case",
	[21] = "Podium",
	[22] = "Chest Is locked.",
	[23] = "Lava pool",
	[24] = "The Temple of Chaos",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

