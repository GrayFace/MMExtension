local TXT = Localize{
	[0] = " ",
	[1] = "Exit",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[1]  -- "Exit"
evt.map[1] = function()
	evt.MoveToMap{X = 14088, Y = 2800, Z = 96, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD3.Odm"}
end

evt.map[5] = function()
	evt.SpeakNPC(307)         -- "Arena Master"
end

