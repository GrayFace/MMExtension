local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[101] = evt.str[1]  -- ""
evt.map[101] = function()
	evt.MoveToMap{X = 13839, Y = 16367, Z = 169, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "Out01.Odm"}
end

evt.map[201] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Add("Inventory", 43)         -- "Longbow"
		evt.Set("MapVar0", 1)
	end
end

evt.map[202] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Add("Inventory", 658)         -- "Contestant's Shield"
		evt.Set("MapVar1", 1)
	end
end

