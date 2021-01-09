local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Chest",
	[4] = "Altar of Might",
	[5] = "Altar of Life",
	[6] = "Altar of Endurance",
	[7] = "Altar of Accuracy",
	[8] = "Altar of Speed",
	[9] = "Altar of Luck",
	[10] = "Altar of the Moon",
	[11] = "Plaque",
	[12] = "The door won't budge",
	[13] = "You kneel at the altar for a moment of silent prayer.",
	[14] = "Life above all, Accuracy before Might, Endurance before Speed, and finally, Luck.",
	[15] = "Ouch!",
	[16] = "Exit",
	[17] = "Den of Iniquity",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

