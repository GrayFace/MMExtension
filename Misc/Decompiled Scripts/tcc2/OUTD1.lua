local TXT = Localize{
	[0] = " ",
	[1] = "Lennie 5",
	[2] = "Lenny Msg #5.  Return to  Lenny the Elder in Land's Gateway after you have visited  my four brothers and he will activate the Whirling Tunnel.",
	[3] = "Autonote added.",
	[4] = "",
	[5] = "",
	[6] = "Lenny 5",
	[7] = "",
	[8] = "You cannot understand the Lenny.",
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

evt.hint[10] = evt.str[6]  -- "Lenny 5"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 499)         -- Fountain of Enchantment once
		evt.SetMessage(2)         -- "Lenny Msg #5.  Return to  Lenny the Elder in Land's Gateway after you have visited  my four brothers and he will activate the Whirling Tunnel."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 14)         -- "Lenny Msg #5.  Return to Lenny the Elder in Land's Gateway after you have visited  my four brothers and he will activate the Flashing Tunnel."
		evt.StatusText(3)         -- "Autonote added."
	else
		evt.StatusText(8)         -- "You cannot understand the Lenny."
	end
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 404) then         -- Hive  Once
		evt.Add("QBits", 404)         -- Hive  Once
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = 3853, Y = -10725, Z = 625}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = -21148, Y = -2475, Z = 220}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -21187, Y = -2943, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 3237, Y = -11957, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 2452, Y = -11066, Z = 1200}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -20919, Y = -2705, Z = 560}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -20399, Y = -3339, Z = 299}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -20058, Y = -3205, Z = 1100}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -20183, Y = -2491, Z = 1700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 13686, Y = -9529, Z = 650}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 7648, Y = -6368, Z = 890}
	end
end

events.LoadMap = evt.map[262].last

evt.map[266] = function()  -- function events.LoadMap()
	evt.SetSnow{EffectId = 0, On = true}
end

events.LoadMap = evt.map[266].last

