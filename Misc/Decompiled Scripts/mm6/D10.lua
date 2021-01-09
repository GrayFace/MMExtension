local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Lever",
	[4] = "Cabinet",
	[5] = "Switch",
	[6] = "The Door won't budge.",
	[7] = "Caught!",
	[8] = "Rats!",
	[9] = "Are those footsteps?",
	[10] = "Exit",
	[11] = "Dragoons' Keep",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[11]  -- "Dragoons' Keep"

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

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[3]  -- "Lever"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
end

evt.hint[10] = evt.str[3]  -- "Lever"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[5]  -- "Switch"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[16] = evt.str[5]  -- "Switch"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
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

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
end

evt.hint[26] = evt.str[2]  -- "Chest"
evt.map[26] = function()
	evt.OpenChest(1)
end

evt.hint[27] = evt.str[2]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(2)
end

evt.hint[28] = evt.str[2]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(3)
end

evt.hint[34] = evt.str[4]  -- "Cabinet"
evt.map[34] = function()
	evt.OpenChest(4)
end

evt.hint[35] = evt.str[4]  -- "Cabinet"
evt.map[35] = function()
	evt.OpenChest(5)
end

evt.hint[36] = evt.str[4]  -- "Cabinet"
evt.map[36] = function()
	evt.OpenChest(6)
end

evt.hint[37] = evt.str[4]  -- "Cabinet"
evt.map[37] = function()
	evt.OpenChest(7)
end

evt.hint[38] = evt.str[4]  -- "Cabinet"
evt.map[38] = function()
	evt.OpenChest(8)
end

evt.hint[39] = evt.str[4]  -- "Cabinet"
evt.map[39] = function()
	evt.OpenChest(9)
end

evt.hint[29] = evt.str[2]  -- "Chest"
evt.map[29] = function()
	if not evt.Cmp("MapVar3", 1) then
		if evt.Cmp("QBits", 4) then         --  4 D10, given when you retreive artifact from chest
			evt.OpenChest(11)
			return
		end
	end
	evt.Set("MapVar3", 1)
	evt.Set("QBits", 4)         --  4 D10, given when you retreive artifact from chest
	evt.OpenChest(10)
end

evt.hint[30] = evt.str[3]  -- "Lever"
evt.map[30] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	if not evt.Cmp("MapVar0", 5) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -2976, Y = 2512, Z = 0}
		evt.Add("MapVar0", 1)
	end
end

evt.hint[31] = evt.str[3]  -- "Lever"
evt.map[31] = function()
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
	if not evt.Cmp("MapVar0", 5) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -1111, Y = 4424, Z = 0}
		evt.Add("MapVar0", 1)
	end
end

evt.hint[33] = evt.str[10]  -- "Exit"
evt.map[33] = function()
	evt.MoveToMap{X = -4369, Y = -18311, Z = 161, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outc2.odm"}
end

evt.hint[32] = evt.str[1]  -- "Door"
evt.map[32] = function()
	evt.StatusText(6)         -- "The Door won't budge."
end

evt.map[40] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.SetDoorState{Id = 17, State = 0}
		evt.FaceExpression{Player = "All", Frame = 5}
		evt.SetSprite{SpriteId = 69, Visible = 1, Name = "torchnf"}
		evt.StatusText(7)         -- "Caught!"
		evt.Set("MapVar1", 1)
		evt.Set("MapVar2", 1)
	end
end

evt.map[41] = function()  -- Timer(<function>, 7.5*const.Minute)
	if not evt.Cmp("MapVar4", 1) then
		if evt.Cmp("MapVar2", 1) then
			if evt.Cmp("MapVar2", 3) then
				evt.StatusText(9)         -- "Are those footsteps?"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -1152, Y = 9840, Z = -256}
				evt.SetDoorState{Id = 17, State = 1}
				evt.Set("MapVar4", 1)
			else
				evt.StatusText(8)         -- "Rats!"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -1216, Y = 10992, Z = -256}
				evt.Add("MapVar2", 1)
			end
		end
	end
end

Timer(evt.map[41].last, 7.5*const.Minute)

evt.map[42] = function()  -- function events.LoadMap()
	if evt.Cmp("Awards", 47) then         -- "Found Zoltan's Artifact"
		evt.Set("MapVar3", 0)
	end
end

events.LoadMap = evt.map[42].last

evt.map[43] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 0}
		evt.Set("MapVar5", 1)
	end
end

