local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "The door is locked.",
	[5] = "The door is locked.",
	[6] = "The door is locked.",
	[7] = "Zap!",
	[8] = "The door is locked.",
	[9] = "The door is locked.",
	[10] = "The door is locked.",
	[11] = "The door is locked.",
	[12] = "Refreshing.",
	[13] = "Harbor Grace",
	[14] = "",
	[15] = "",
	[16] = "",
	[17] = "",
	[18] = "A wooden sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[19] = "The haunted sounds of tortured souls assail your ears.",
	[20] = "A silver sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[21] = "A copper sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[22] = "A lapis sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[23] = "Sign",
	[24] = "Found something!",
	[25] = "You scoop away a handful of someone's hopes and dreams.",
	[26] = "Fountain",
	[27] = "You toss a few coins into the fountain.",
	[28] = " +20 Hit points restored.",
	[29] = "Statue",
	[30] = "The door clicks.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

