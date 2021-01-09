local TXT = Localize{
	[0] = " ",
	[1] = "Exit",
	[2] = "Cavern of the Rogue",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[2]  -- "Cavern of the Rogue"

evt.hint[1] = evt.str[1]  -- "Exit"
evt.map[1] = function()
	evt.MoveToMap{X = -287, Y = 18687, Z = 256, Direction = 2040, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD3.Odm"}
end

evt.map[2] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 424) then         -- Drider Spwan Glacier's End QBIT once.
		evt.Add("QBits", 424)         -- Drider Spwan Glacier's End QBIT once.
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 7, X = -206, Y = 311, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 480, Y = 320, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = 863, Y = 1152, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = 256, Y = 1024, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 0, Y = 128, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -86, Y = -583, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 4, X = 378, Y = 520, Z = 1}
	end
end

events.LoadMap = evt.map[2].last

