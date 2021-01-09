local TXT = Localize{
	[0] = " ",
	[1] = "Fig Tree",
	[2] = "You found some food!",
	[3] = "Place Holder for Prince of Thieves.  Paul needs to provide this.",
	[4] = "Stone of Revelation",
	[5] = "You cannot read the inscription.",
	[6] = "Revelation Msg#5.  Untold treasures may be found if you leave The Path, but at great peril.",
	[7] = "There are no more figs on the tree.",
	[8] = "Autonote added.",
	[9] = "+2 Intellect permanent.",
	[10] = "+2 Personality permanent.",
	[11] = "+20 Spell points restored.",
	[12] = "No one is here.  The Circus has moved.",
	[13] = "Sylphland",
	[14] = "Shrine of Intellect",
	[15] = "You pray at the shrine.",
	[16] = "+10 Intellect permanent",
	[17] = "+3 Intellectt permanent",
	[18] = "Pedestal",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                          tota_uruNkiuhiy_r",
	[20] = "Obelisk",
	[21] = "???",
	[22] = "Sylphland",
	[23] = "Circus (Winter)",
	[24] = "Drink from Fountain",
	[25] = "You cannot enter at this time.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 262:14

evt.hint[1] = evt.str[1]  -- "Fig Tree"
evt.map[1] = function()
	if evt.Cmp("MapVar7", 5) then
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("MapVar7", 1)
		evt.ForPlayer("Current")
		evt.Add("Food", 1)
		evt.StatusText(2)         -- "You found some food!"
	end
end

RefillTimer(function()
	evt.Set("MapVar7", 0)
end, const.Week, true)

evt.hint[2] = evt.str[1]  -- "Fig Tree"
evt.map[2] = function()
	if evt.Cmp("MapVar8", 4) then
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("MapVar8", 1)
		evt.ForPlayer("Current")
		evt.Add("Food", 1)
		evt.StatusText(2)         -- "You found some food!"
	end
end

RefillTimer(function()
	evt.Set("MapVar8", 0)
end, const.Week, true)

evt.hint[3] = evt.str[1]  -- "Fig Tree"
evt.map[3] = function()
	if evt.Cmp("MapVar12", 3) then
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("MapVar12", 1)
		evt.ForPlayer("Current")
		evt.Add("Food", 1)
		evt.StatusText(2)         -- "You found some food!"
	end
end

RefillTimer(function()
	evt.Set("MapVar12", 0)
end, const.Week, true)

evt.hint[4] = evt.str[1]  -- "Fig Tree"
evt.map[4] = function()
	if evt.Cmp("MapVar13", 5) then
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("MapVar13", 1)
		evt.ForPlayer("Current")
		evt.Add("Food", 1)
		evt.StatusText(2)         -- "You found some food!"
	end
end

RefillTimer(function()
	evt.Set("MapVar13", 0)
end, const.Week, true)

evt.hint[5] = evt.str[1]  -- "Fig Tree"
evt.map[5] = function()
	if evt.Cmp("QBits", 355) then         -- NPC
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("QBits", 355)         -- NPC
		evt.Add("Food", 1)
	end
end

evt.hint[6] = evt.str[1]  -- "Fig Tree"
evt.map[6] = function()
	if evt.Cmp("QBits", 356) then         -- NPC
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("QBits", 356)         -- NPC
		evt.Add("Food", 1)
	end
end

evt.hint[7] = evt.str[1]  -- "Fig Tree"
evt.map[7] = function()
	if evt.Cmp("QBits", 357) then         -- NPC
		evt.StatusText(7)         -- "There are no more figs on the tree."
	else
		evt.Add("QBits", 357)         -- NPC
		evt.Add("Food", 1)
	end
end

evt.hint[10] = evt.str[4]  -- "Stone of Revelation"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 492)         -- Reload Each December
		evt.SetMessage(6)         -- "Revelation Msg#5.  Untold treasures may be found if you leave The Path, but at great peril."
		evt.SimpleMessage()
		evt.Add("AutonotesBits", 83)         -- "Revelation Msg#5.  Untold treasures may be found if you leave The Path, but at great peril."
		evt.StatusText(8)         -- "Autonote added."
	else
		evt.StatusText(5)         -- "You cannot read the inscription."
	end
end

evt.map[11] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[11].last

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 401) then         -- Elixir  of Revelation once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 224, Y = -19050, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 240, Y = -20500, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -600, Y = -19400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 1024, Y = -19880, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 9216, Y = -15312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -12610, Y = -20890, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -13728, Y = -19900, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -6096, Y = 3968, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -18970, Y = -4650, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -4460, Y = 4410, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 16800, Y = 17296, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 17725, Y = 16736, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -12752, Y = -19524, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 210, Y = -19040, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 230, Y = -20500, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -4450, Y = 4420, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 17360, Y = 16730, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 1015, Y = -19870, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 17072, Y = -20170, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 224, Y = -19056, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 240, Y = -20512, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -610, Y = -19400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 1024, Y = -19880, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 9216, Y = -15312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -12624, Y = -20896, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -13728, Y = -19984, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -18704, Y = -16240, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -18976, Y = -4656, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -6096, Y = 3968, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4464, Y = 4416, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 16800, Y = 17296, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 17376, Y = 16736, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 15776, Y = 14640, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = 16240, Y = 15248, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -21216, Y = -7936, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -17856, Y = -4976, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -20064, Y = -7904, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -12352, Y = -20384, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -18160, Y = -16144, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 14576, Y = -16128, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 14672, Y = -20192, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 6976, Y = -22784, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 7952, Y = -17760, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 5168, Y = -6256, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = 6112, Y = -6416, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 15968, Y = -9616, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 17776, Y = -9104, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 14496, Y = 12032, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -7616, Y = 19232, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -2816, Y = 5312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = -19248, Y = 19008, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -18352, Y = 18976, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -13680, Y = -20656, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = -12752, Y = -19536, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 17072, Y = -20176, Z = 0}
		evt.Add("QBits", 401)         -- Elixir  of Revelation once
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

