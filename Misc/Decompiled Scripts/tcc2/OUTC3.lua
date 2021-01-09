local TXT = Localize{
	[0] = " ",
	[1] = "What the frack just happened?\
\
What's going on here?\
\
Where are we?\
\
This can't be the lush Baal's Garden that we've returned to.\
\
How are we gonna get back to The Pyramid to destroy the Chalice?\
\
Something's not right here.\
\
",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "Resurrection Pedestal",
	[16] = "Raise Dead Pedestal",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 532) then         -- "Chalice of Gods"
				if evt.Cmp("QBits", 485) then         -- LG 2nd Jorgsburg
					evt.Subtract("QBits", 485)         -- LG 2nd Jorgsburg
					evt.SetMessage(1)         --[[ "What the frack just happened?\
\
What's going on here?\
\
Where are we?\
\
This can't be the lush Baal's Garden that we've returned to.\
\
How are we gonna get back to The Pyramid to destroy the Chalice?\
\
Something's not right here.\
\
" ]]
					evt.SimpleMessage()
				end
				return
			end
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

Timer(function()
	if evt.Cmp("QBits", 485) then         -- LG 2nd Jorgsburg
		evt.Subtract("QBits", 485)         -- LG 2nd Jorgsburg
		evt.SetMessage(1)         --[[ "What the frack just happened?\
\
What's going on here?\
\
Where are we?\
\
This can't be the lush Baal's Garden that we've returned to.\
\
How are we gonna get back to The Pyramid to destroy the Chalice?\
\
Something's not right here.\
\
" ]]
		evt.SimpleMessage()
	end
end, 0.5*const.Minute)

evt.map[90] = function()
	evt.MoveToMap{X = -9734, Y = -19201, Z = 772, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Pyramid.Blv"}
end

evt.hint[101] = evt.str[15]  -- "Resurrection Pedestal"
evt.map[101] = function()
	evt.ForPlayer("All")
	evt.Subtract("Eradicated", 0)
end

evt.hint[102] = evt.str[16]  -- "Raise Dead Pedestal"
evt.map[102] = function()
	evt.ForPlayer("All")
	evt.Subtract("Dead", 0)
end

evt.map[260] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 405) then         -- Anarchy Once
		evt.Set("QBits", 405)         -- Anarchy Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -12125, Y = 20923, Z = 1000}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -12120, Y = 20920, Z = 1200}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -12130, Y = 20928, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 5, X = -12015, Y = 22196, Z = 2000}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -13068, Y = -5928, Z = 161}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -11524, Y = 19742, Z = 1800}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -12901, Y = 20232, Z = 750}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = -13612, Y = 16161, Z = 2200}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 4, X = -13760, Y = 13331, Z = 351}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -15871, Y = 11231, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -19186, Y = 1604, Z = 1450}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -7104, Y = 10689, Z = 1675}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -6199, Y = 10689, Z = 1150}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -12033, Y = 18205, Z = 1790}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -15138, Y = 7482, Z = 2800}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -19139, Y = -3157, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -8503, Y = -13100, Z = 1745}
	end
end

events.LoadMap = evt.map[260].last

