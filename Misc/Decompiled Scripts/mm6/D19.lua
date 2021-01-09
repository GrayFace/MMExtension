local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Elevator platform",
	[3] = "Chest",
	[4] = "Door",
	[5] = "Pushing this switch gives you a bad feeling.",
	[6] = "Uh oh....",
	[7] = "Here we go again….",
	[8] = "The switch doesn’t seem to work..",
	[9] = "Exit",
	[10] = "Chandelier",
	[11] = "Cauldron",
	[12] = "+50 Intellect permanent.",
	[13] = "Agar's Laboratory",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Agar's Laboratory"
-- ERROR: Duplicate label: 35:0

evt.hint[2] = evt.str[1]  -- "Switch"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[3] = evt.str[1]  -- "Switch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[4] = evt.str[1]  -- "Switch"
evt.map[4] = function()
	evt.Set("MapVar1", 1)
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
	evt.FaceExpression{Player = "All", Frame = 39}
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 18, State = 1}
	end
end

evt.hint[7] = evt.str[1]  -- "Switch"
evt.map[7] = function()
	evt.Set("MapVar0", 1)
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 9, State = 1}
	evt.FaceExpression{Player = "All", Frame = 39}
	if evt.Cmp("MapVar1", 1) then
		evt.SetDoorState{Id = 18, State = 1}
	end
end

evt.hint[10] = evt.str[1]  -- "Switch"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
	evt.FaceExpression{Player = "All", Frame = 48}
end

evt.map[13] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.StatusText(6)         -- "Uh oh...."
		evt.SetDoorState{Id = 13, State = 1}
		evt.Add("MapVar19", 1)
	end
end

evt.hint[14] = evt.str[4]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[15] = evt.str[1]  -- "Switch"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 3, State = 1}
end

evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[18] = evt.str[3]  -- "Chest"
evt.map[18] = function()
	evt.OpenChest(0)
end

evt.hint[19] = evt.str[3]  -- "Chest"
evt.map[19] = function()
	evt.OpenChest(1)
end

evt.hint[20] = evt.str[3]  -- "Chest"
evt.map[20] = function()
	evt.OpenChest(2)
end

evt.map[21] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.CastSpell{Spell = 32, Mastery = const.Master, Skill = 7, FromX = -2048, FromY = 9712, FromZ = -2282, ToX = -2048, ToY = 9050, ToZ = -2282}         -- "Ice Blast"
end

Timer(evt.map[21].last, 2.5*const.Minute)

evt.hint[25] = evt.str[10]  -- "Chandelier"
evt.map[25] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.Add("Inventory", 436)         -- "Diamond"
	end
end

evt.hint[26] = evt.str[10]  -- "Chandelier"
evt.map[26] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.Add("Inventory", 436)         -- "Diamond"
	end
end

evt.hint[27] = evt.str[10]  -- "Chandelier"
evt.map[27] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 1)
		evt.Add("Inventory", 436)         -- "Diamond"
	end
end

evt.map[30] = function()
	evt.SetDoorState{Id = 16, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[31] = evt.str[1]  -- "Switch"
evt.map[31] = function()
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[35] = evt.str[11]  -- "Cauldron"
evt.map[35] = function()
	evt.ForPlayer("Current")
	if not evt.Cmp("Cursed", 0) then
		evt.Set("Dead", 0)
	elseif not evt.Cmp("PlayerBits", 36) then
		evt.Add("BaseIntellect", 50)
		evt.Set("PlayerBits", 36)
		evt.StatusText(12)         -- "+50 Intellect permanent."
	end
end

evt.hint[50] = evt.str[9]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 7762, Y = 16306, Z = 449, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB1.Odm"}
end

