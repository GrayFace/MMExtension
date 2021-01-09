local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Oracle Memory Crystal",
	[5] = "Exit",
	[6] = "Cylinder",
	[7] = "Disordered Sanctum",
	[8] = "Altar of Fire",
	[9] = "Trial by Fire",
	[10] = "Altar of Cold",
	[11] = "Trial by Cold",
	[12] = "Altar of Pain",
	[13] = "Trial by Pain",
	[14] = "Shrine of Fire",
	[15] = "+10 Fire resistance permanent.",
	[16] = "Shrine of Air",
	[17] = "+10 Electric resistance permanent.",
	[18] = "Shrine of Water",
	[19] = "+10 Cold resistance permanent.",
	[20] = "Shrine of Earth",
	[21] = "+10 Magic resistance permanent.",
	[22] = "You're not worthy!",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

