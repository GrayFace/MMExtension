local TXT = Localize{
	[0] = " ",
	[1] = "Exit Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Blue Torch",
	[5] = "Empty",
	[6] = "Empty",
	[7] = "Door",
	[8] = "T",
	[9] = "h",
	[10] = "e",
	[11] = "Q",
	[12] = "u",
	[13] = "i",
	[14] = "c",
	[15] = "k",
	[16] = "B",
	[17] = "r",
	[18] = "o",
	[19] = "w",
	[20] = "n",
	[21] = "F",
	[22] = "O",
	[23] = "x",
	[24] = "Halls of the Adept",
	[25] = "The Torch is activated.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

