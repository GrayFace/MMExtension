local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
	[3] = "Cave of Mabon",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[3]  -- "Cave of Mabon"

evt.hint[1] = evt.str[2]  -- "Exit"
evt.map[1] = function()
	evt.MoveToMap{X = -19604, Y = 20019, Z = 161, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD3.Odm"}
end

evt.map[2] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 422) then         -- Mabon Bats once
		evt.Add("QBits", 422)         -- Mabon Bats once
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = 1089, Y = 122, Z = 50}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 945, Y = 275, Z = 50}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 9, X = 940, Y = 256, Z = 50}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 9, X = 840, Y = -44, Z = 50}
		end
	end
end

events.LoadMap = evt.map[2].last

