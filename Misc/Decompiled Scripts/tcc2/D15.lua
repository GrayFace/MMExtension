local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Gate",
	[3] = "Cabinet",
	[4] = "Button",
	[5] = "Bed",
	[6] = "Chest",
	[7] = "Various Foodstuff bags",
	[8] = "Throne",
	[9] = "Lever",
	[10] = "Table",
	[11] = "The gate will not budge.",
	[12] = "You find something around the bed.",
	[13] = "Something rumbles off in the distance.",
	[14] = "The bed(s) are empty.",
	[15] = "Exit",
	[16] = "The Barracks Keep",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

