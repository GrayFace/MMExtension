local TXT = Localize{
	[0] = " ",
	[1] = "Stone of Revelation",
	[2] = "You cannot read the inscription",
	[3] = "Revelation Msg#6.  Once you have all six Revelations, you may then use the Tunnel to Baal's Garden.",
	[4] = "Revelation Msg#4.  If you reach the end of lights before you reach your destination, touch the last light to continue your journey.",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "Autonote added.",
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

evt.hint[10] = evt.str[1]  -- "Stone of Revelation"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 491)         -- Clear Reload Each January
		evt.SetMessage(3)         -- "Revelation Msg#6.  Once you have all six Revelations, you may then use the Tunnel to Baal's Garden."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 84)         -- "Revelation Msg#6.  Once you have all six Revelations, you may then use the Flashing Tunnel to Baal's Garden."
		evt.StatusText(8)         -- "Autonote added."
	else
		evt.StatusText(2)         -- "You cannot read the inscription"
	end
end

evt.hint[11] = evt.str[1]  -- "Stone of Revelation"
evt.map[11] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 493)         -- Seer Tamara Once
		evt.SetMessage(4)         -- "Revelation Msg#4.  If you reach the end of lights before you reach your destination, touch the last light to continue your journey."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 82)         -- "Revelation Msg#4.  If you reach the end of lights before you reach your destination, touch the last light to continue your journey."
		evt.StatusText(8)         -- "Autonote added."
	else
		evt.StatusText(2)         -- "You cannot read the inscription"
	end
end

evt.map[12] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 407) then         -- Birka Timer2
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -15079, Y = 12218, Z = 700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -15079, Y = 12218, Z = 1400}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -15079, Y = 12218, Z = 2000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -13834, Y = 12841, Z = 650}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -13834, Y = 12841, Z = 1250}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -13834, Y = 12841, Z = 1850}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -14083, Y = 14830, Z = 550}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -14083, Y = 14830, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -14083, Y = 14830, Z = 1640}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 5952, Y = 7169, Z = 1000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 5952, Y = 7169, Z = 1700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 5952, Y = 7169, Z = 2700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 3048, Y = 10254, Z = 660}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 3048, Y = 10254, Z = 1320}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 3048, Y = 10254, Z = 1900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -13961, Y = 8461, Z = 850}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -13961, Y = 8561, Z = 1800}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -13961, Y = 8661, Z = 2650}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -7575, Y = -4779, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -7675, Y = -4779, Z = 1700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -7475, Y = -4779, Z = 2500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -4052, Y = -5549, Z = 800}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -4142, Y = -5549, Z = 1540}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -4242, Y = -5549, Z = 2650}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 3253, Y = -15999, Z = 950}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 3253, Y = -15999, Z = 1760}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 3253, Y = -15999, Z = 2850}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = 6663, Y = -16358, Z = 850}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 6663, Y = -16458, Z = 1900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = 6663, Y = -16258, Z = 2600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -3481, Y = -9843, Z = 850}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = -3481, Y = -9843, Z = 1200}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -3481, Y = -9843, Z = 1800}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = -821, Y = -13453, Z = 750}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -821, Y = -13453, Z = 1450}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -821, Y = -13553, Z = 1900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 7936, Y = -15092, Z = 700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 7836, Y = -15192, Z = 925}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 7736, Y = -15292, Z = 1850}
	end
end

events.LoadMap = evt.map[12].last

