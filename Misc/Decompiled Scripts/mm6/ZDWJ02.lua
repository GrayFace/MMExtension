local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
	[3] = "Devil Outpost",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[3]  -- "Devil Outpost"

evt.hint[1] = evt.str[2]  -- "Exit"
evt.map[1] = function()
	evt.MoveToMap{X = -17420, Y = -959, Z = 161, Direction = 1920, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB1.Odm"}
end

