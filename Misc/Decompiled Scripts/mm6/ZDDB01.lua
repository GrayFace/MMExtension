local TXT = Localize{
	[0] = " ",
	[1] = "Exit",
	[2] = "Dragon's Lair",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[2]  -- "Dragon's Lair"

evt.hint[1] = evt.str[1]  -- "Exit"
evt.map[1] = function()
	evt.MoveToMap{X = -17962, Y = 20974, Z = 1, Direction = 1152, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC3.Odm"}
end

