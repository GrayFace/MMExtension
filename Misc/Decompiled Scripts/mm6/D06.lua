local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Chest",
	[4] = "Double Door",
	[5] = "The door won't budge",
	[6] = "Lever",
	[7] = "Exit",
	[8] = "Dragoons' Caverns",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[8]  -- "Dragoons' Caverns"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[2]  -- "Switch"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[6]  -- "Lever"
evt.map[12] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
		evt.SetDoorState{Id = 13, State = 2}         -- switch state
		evt.SetFacetBit{Id = 2667, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar0", 0)
	else
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
		evt.SetDoorState{Id = 13, State = 2}         -- switch state
		evt.SetFacetBit{Id = 2667, Bit = const.FacetBits.Untouchable, On = true}
		evt.Set("MapVar0", 1)
	end
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[2]  -- "Switch"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[2]  -- "Switch"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
	evt.SetDoorState{Id = 24, State = 2}         -- switch state
end

evt.hint[25] = evt.str[6]  -- "Lever"
evt.map[25] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 25, State = 2}         -- switch state
		evt.SetDoorState{Id = 26, State = 2}         -- switch state
		evt.SetFacetBit{Id = 2668, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar0", 0)
	else
		evt.SetDoorState{Id = 25, State = 2}         -- switch state
		evt.SetDoorState{Id = 26, State = 2}         -- switch state
		evt.SetFacetBit{Id = 2668, Bit = const.FacetBits.Untouchable, On = true}
		evt.Set("MapVar0", 1)
	end
end

evt.hint[27] = evt.str[1]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 27, State = 1}
end

evt.hint[28] = evt.str[1]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 28, State = 1}
end

evt.hint[29] = evt.str[1]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 29, State = 1}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
end

evt.hint[32] = evt.str[1]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[33] = evt.str[1]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 33, State = 1}
end

evt.hint[34] = evt.str[4]  -- "Double Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 35, State = 1}
end

evt.hint[36] = evt.str[36]
evt.map[36] = function()
	evt.SetDoorState{Id = 36, State = 1}
end

evt.hint[37] = evt.str[3]  -- "Chest"
evt.map[37] = function()
	evt.OpenChest(1)
end

evt.hint[38] = evt.str[3]  -- "Chest"
evt.map[38] = function()
	if not evt.Cmp("MapVar2", 1) then
		if evt.Cmp("QBits", 14) then         -- 14 D6, given when Message 504 given out.
			evt.OpenChest(9)
			return
		end
	end
	evt.OpenChest(0)
	evt.Set("QBits", 14)         -- 14 D6, given when Message 504 given out.
	evt.Set("MapVar2", 1)
end

evt.hint[39] = evt.str[3]  -- "Chest"
evt.map[39] = function()
	evt.OpenChest(3)
end

evt.hint[40] = evt.str[3]  -- "Chest"
evt.map[40] = function()
	evt.OpenChest(4)
end

evt.hint[41] = evt.str[3]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(5)
end

evt.hint[42] = evt.str[3]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(6)
end

evt.hint[43] = evt.str[3]  -- "Chest"
evt.map[43] = function()
	if evt.Cmp("Awards", 40) then         -- "Retrieved Andrew's Harp"
		goto _7
	end
	if not evt.Cmp("MapVar1", 1) then
		if evt.Cmp("QBits", 3) then         --  3 D06, given when harp is recovered
			goto _7
		end
	end
	evt.OpenChest(7)
	evt.Set("QBits", 3)         --  3 D06, given when harp is recovered
	evt.Set("MapVar1", 1)
	do return end
::_7::
	evt.OpenChest(2)
end

evt.hint[44] = evt.str[3]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(8)
end

evt.hint[45] = evt.str[3]  -- "Chest"
evt.map[45] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.MoveToMap{X = 2752, Y = -256, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = 3222, Y = -2076, Z = -31, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = 1152, Y = -5193, Z = -511, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 4 then
		evt.MoveToMap{X = -59, Y = 1997, Z = -896, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 5 then
		evt.MoveToMap{X = -831, Y = 3109, Z = -128, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		i = Game.Rand() % 4
		if i == 1 then
			evt.MoveToMap{X = -7023, Y = -1413, Z = -383, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		elseif i == 2 then
			evt.MoveToMap{X = 1847, Y = 8410, Z = -767, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		elseif i == 3 then
			evt.MoveToMap{X = -843, Y = 6440, Z = -767, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		else
			evt.MoveToMap{X = -3622, Y = 5464, Z = -639, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		end
	end
end

evt.hint[46] = evt.str[1]  -- "Door"
evt.map[46] = function()
	evt.StatusText(5)         -- "The door won't budge"
end

evt.hint[50] = evt.str[7]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 16495, Y = -14570, Z = 96, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD3.Odm"}
end

evt.map[51] = function()
	if not evt.Cmp("QBits", 306) then         -- NPC
		evt.Set("QBits", 306)         -- NPC
		evt.Add("BaseLuck", 10)
	end
end

