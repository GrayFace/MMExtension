local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Sign",
	[5] = "Door ",
	[6] = "There is a hissing sound coming from the wall",
	[7] = "The crimson embers will lead the way",
	[8] = "Lever",
	[9] = "The way has been cleared",
	[10] = "The fires of the dead shall burn forever",
	[11] = "Podium",
	[12] = "The Book is destroyed",
	[13] = "The Book of Liches is destroyed",
	[14] = "Crystal",
	[15] = "Forcefield",
	[16] = "Your way is blocked.",
	[17] = "Temple of Tranquility",
	[18] = "Sarcophagus",
	[19] = "How Clever!  +20 Skill points",
	[20] = "Steal from the dead?",
	[21] = "Steal (Yes/No)?",
	[22] = "Yes",
	[23] = "Y",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

