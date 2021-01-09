local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "",
	[3] = "Autonote added.",
	[4] = "",
	[5] = "",
	[6] = "Lenny 1",
	[7] = "Lenny 4",
	[8] = "Lenny  Msg #1.  To get to  Baal's Garden you must first visit the Squiggies.",
	[9] = "Lenny Msg #4.  To visit the Squiggies, you must go through the Tunnel to the Valley of Stones.",
	[10] = "You cannot understand the Lenny.",
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

evt.hint[10] = evt.str[6]  -- "Lenny 1"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 503)         -- Campfire
		evt.SetMessage(8)         -- "Lenny  Msg #1.  To get to  Baal's Garden you must first visit the Squiggies."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 9)         -- "Lenny  Msg #1.  To get to  Baal's Garden you must first visit the Squiggies."
		evt.StatusText(3)         -- "Autonote added."
	else
		evt.StatusText(10)         -- "You cannot understand the Lenny."
	end
end

evt.hint[11] = evt.str[7]  -- "Lenny 4"
evt.map[11] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 500)         -- Tobin Cage
		evt.SetMessage(9)         -- "Lenny Msg #4.  To visit the Squiggies, you must go through the Tunnel to the Valley of Stones."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 13)         -- "Lenny Msg #4.  To visit the Squiggies, you must go through the Flashing Tunnel to the Valley of Stones."
		evt.StatusText(3)         -- "Autonote added."
	else
		evt.StatusText(10)         -- "You cannot understand the Lenny."
	end
end

evt.map[260] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 466) then         -- Norseland Once
		evt.Set("QBits", 466)         -- Norseland Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 7932, Y = 15832, Z = 445}
		if not evt.Cmp("QBits", 508) then         -- Void Fountain2
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 21791, Y = 19452, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 21059, Y = 17947, Z = 704}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 15543, Y = 19519, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 15535, Y = 19510, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 13431, Y = 17838, Z = 232}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -14885, Y = 6365, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -14880, Y = 6360, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -11553, Y = -12828, Z = 1600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 6, X = -10425, Y = -12828, Z = 1600}
	end
	if evt.Cmp("QBits", 507) then         -- Void Fountain3
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 19036, Y = 18498, Z = 486}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 13563, Y = 15923, Z = 284}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -14875, Y = 6355, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -11550, Y = -12820, Z = 1600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -9559, Y = -12058, Z = 1600}
	end
end

events.LoadMap = evt.map[260].last

evt.map[266] = function()  -- function events.LoadMap()
	evt.SetSnow{EffectId = 0, On = true}
end

events.LoadMap = evt.map[266].last

evt.map[271] = function()  -- function events.LoadMap()
	evt.SetSnow{EffectId = 0, On = true}
end

events.LoadMap = evt.map[271].last

