local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "Rejuvination!",
	[3] = "Refreshing!",
	[4] = "Chest",
	[5] = "The Far Reaches",
	[6] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           _naotip_s_edro_ftd",
	[7] = "Obelisk",
	[8] = "Rock of Ages",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

