local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Door",
	[3] = "Lever",
	[4] = "Gold vein",
	[5] = "Gems",
	[6] = "Cave-in!",
	[7] = "Orpheus’s Gateway ",
	[8] = "Black liquid filled barrel",
	[9] = "Old bones",
	[10] = "Glowing dinosaur bones",
	[11] = "Elevator platform",
	[12] = "Gateway Door",
	[13] = "",
	[14] = "",
	[15] = "Chest",
	[16] = "",
	[17] = "",
	[18] = "The door will not budge",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "Bones",
	[25] = "The bones feel weird (+5 Poison resistance permanent)",
	[26] = "The bones feel weird (+5 Magic resistance permanent)",
	[27] = "No effect",
	[28] = "Only the Horn of Vainen can open the Gateway.",
	[29] = "You blow the Horn of Vainen and the Gateway opens.",
	[30] = "Exit",
	[31] = "The bones feel weird (+5 Might permanent)",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

