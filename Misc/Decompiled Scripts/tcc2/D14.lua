local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Sarcophagus",
	[3] = "Burial niche",
	[4] = "Elevator",
	[5] = "Platform",
	[6] = "Gate",
	[7] = "The door will not budge.",
	[8] = "Fumes make you feel sick.",
	[9] = "You find something among the bones.",
	[10] = "The niche is empty.",
	[11] = "Door.",
	[12] = "Exit.",
	[13] = "Tomb of Luftka the Kruel",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

