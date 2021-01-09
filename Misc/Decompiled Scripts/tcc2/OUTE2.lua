local TXT = Localize{
	[0] = " ",
	[1] = "Rock of Translation",
	[2] = "You touch the rock and begin to understand.",
	[3] = "Chest",
	[4] = "Drink from Well.",
	[5] = "Drink from Fountain.",
	[6] = "Drink from Trough.",
	[7] = "Refreshing!",
	[8] = "+10 Spell points restored.",
	[9] = "+10 Intellect and Personality temporary.",
	[10] = "+5 Elemental resistance temporary.",
	[11] = "+20 Luck temporary.",
	[12] = "Poison!",
	[13] = "Welcome to Ellesia",
	[14] = "Ellesia",
	[15] = "Shrine of Might",
	[16] = "You pray at the shrine.",
	[17] = "+10 Might permanent",
	[18] = "+3 Might permanent",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           iNs_u_t_rfesh_'ns",
	[20] = "Obelisk",
	[21] = "The Barrel is empty.",
	[22] = "Green Super Barrel",
	[23] = "Thank you!",
	[24] = "A caged Prisoner!",
	[25] = "Closed for repairs.",
	[26] = "You need a key to enter the temple.",
	[27] = "Campfire",
	[28] = "Elixir of Revelation",
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

evt.hint[10] = evt.str[1]  -- "Rock of Translation"
evt.map[10] = function()
	evt.SetMessage(2)         -- "You touch the rock and begin to understand."
	evt.SimpleMessage()
	if not evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.ForPlayer("All")
		evt.Add("Experience", 2000000)
		evt.Add("QBits", 505)         -- Stone of Translation
		evt.Add("Awards", 3)         -- "Touched the Rock of Translation"
	end
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 403) then         -- Hive  Twice
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 9550, Y = 10200, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 9555, Y = 10220, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 10100, Y = 11400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 10200, Y = 11400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = 5450, Y = 17050, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5460, Y = 17050, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -8166, Y = -7000, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -8155, Y = -6990, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 13700, Y = 8450, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -4670, Y = -18620, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 7, X = -4670, Y = -18620, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -7960, Y = -12220, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -7955, Y = -12230, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -7950, Y = -12210, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -265, Y = 11000, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -11765, Y = 6880, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -9130, Y = 12060, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -5630, Y = -6620, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -5125, Y = -6583, Z = 0}
		evt.Set("QBits", 403)         -- Hive  Twice
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

