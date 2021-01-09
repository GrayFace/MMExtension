local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Cabinet",
	[3] = "Crystal of Accuracy",
	[4] = "Full sack",
	[5] = "Switch",
	[6] = "Flickering Torch",
	[7] = "Empty barrel",
	[8] = "The skulls seem to sap your might",
	[9] = "You have restored the Crystal of Accuracy.",
	[10] = "You pull the torch and it shifts in your hand",
	[11] = "The door won't budge",
	[12] = "(removed) The keg is empty",
	[13] = "Exit",
	[14] = "(removed) Keg",
	[15] = "Wrenford's Retreat",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

