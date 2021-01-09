local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Bed",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "Sewer Grate",
	[6] = "Someone's hiding under the bed!",
	[7] = "Torch",
	[8] = "Trash",
	[9] = "Something's stashed here!",
	[10] = "Ouch!",
	[11] = "The door is locked.",
	[12] = "Exit",
	[13] = "Cylinder",
	[14] = "+10 Hit points restored.",
	[15] = "Refreshing!",
	[16] = "Well",
	[17] = "The Underground",
	[18] = "Strange Light",
	[19] = "The ladder is broken!",
	[20] = "Caged Prisoner",
	[21] = "What took you so long?",
	[22] = "Antonio's Venetian Tea",
	[23] = "The chest is locked!",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

