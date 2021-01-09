local TXT = Localize{
	[0] = " ",
	[1] = "Stone of Revelation",
	[2] = "Revelation Msg#1.  To reach your derstination you must first enter the Pyramid in Baal's Garden.",
	[3] = "",
	[4] = "",
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

evt.map[5] = function()
	evt.MoveToMap{X = -1769, Y = 12542, Z = 1000, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC2.Odm"}
end

evt.hint[6] = evt.str[1]  -- "Stone of Revelation"
evt.map[6] = function()
	evt.SetMessage(2)         -- "Revelation Msg#1.  To reach your derstination you must first enter the Pyramid in Baal's Garden."
	evt.SimpleMessage()
	evt.Add("QBits", 496)         -- Tortuga Hall Reload
	evt.Add("AutonotesBits", 79)         -- "Revelation Msg#1.  To reach your derstination you must first enter the Pyramid in Baal's Garden."
	evt.StatusText(8)         -- "Autonote added."
end

evt.map[221] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 411) then         -- Quaddah onc
		evt.Add("QBits", 411)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -9629, Y = 13740, Z = 428}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -8923, Y = 11797, Z = 898}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = -8194, Y = 16033, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -8437, Y = 18772, Z = 661}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -6821, Y = 17533, Z = 181}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -7862, Y = 16690, Z = 661}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -7482, Y = 11385, Z = 725}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -7689, Y = 9128, Z = 800}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 1568, Y = 1771, Z = 354}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 1468, Y = 1771, Z = 354}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 1568, Y = 1271, Z = 354}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 1568, Y = 1771, Z = 854}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 1468, Y = 1771, Z = 925}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 1568, Y = 1271, Z = 800}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 2468, Y = 1271, Z = 354}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 2468, Y = 1271, Z = 850}
		evt.ForPlayer("All")
		evt.Add("Experience", 2000000)
	end
end

events.LoadMap = evt.map[221].last

