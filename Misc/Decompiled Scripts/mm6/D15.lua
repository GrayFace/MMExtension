local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Gate",
	[3] = "Cabinet",
	[4] = "Button",
	[5] = "Bed",
	[6] = "Chest",
	[7] = "Various Foodstuff bags",
	[8] = "Throne",
	[9] = "Lever",
	[10] = "Table",
	[11] = "The gate will not budge.",
	[12] = "You find something around the bed.",
	[13] = "Something rumbles off in the distance.",
	[14] = "The bed(s) are empty.",
	[15] = "Exit",
	[16] = "Icewind Keep",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[16]  -- "Icewind Keep"

evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[9]  -- "Lever"
evt.map[2] = function()
	evt.StatusText(13)         -- "Something rumbles off in the distance."
	evt.FaceExpression{Player = "Random", Frame = 30}
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[3] = evt.str[9]  -- "Lever"
evt.map[3] = function()
	evt.StatusText(13)         -- "Something rumbles off in the distance."
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
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

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[9]  -- "Lever"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
end

evt.hint[20] = evt.str[6]  -- "Chest"
evt.map[20] = function()
	evt.OpenChest(0)
end

evt.hint[21] = evt.str[6]  -- "Chest"
evt.map[21] = function()
	evt.OpenChest(1)
end

evt.hint[22] = evt.str[3]  -- "Cabinet"
evt.map[22] = function()
	evt.OpenChest(2)
end

evt.hint[23] = evt.str[6]  -- "Chest"
evt.map[23] = function()
	evt.OpenChest(3)
end

evt.hint[24] = evt.str[6]  -- "Chest"
evt.map[24] = function()
	evt.OpenChest(4)
end

evt.hint[25] = evt.str[6]  -- "Chest"
evt.map[25] = function()
	if not evt.Cmp("MapVar9", 1) then
		if evt.Cmp("QBits", 25) then         -- 25 D15, Given to find merchants White pearl
			evt.OpenChest(7)
			return
		end
	end
	evt.OpenChest(5)
	evt.Add("MapVar9", 1)
	evt.Set("QBits", 25)         -- 25 D15, Given to find merchants White pearl
	evt.Set("QBits", 189)         -- Quest item bits for seer
end

evt.hint[26] = evt.str[6]  -- "Chest"
evt.map[26] = function()
	evt.OpenChest(6)
end

evt.hint[27] = evt.str[5]  -- "Bed"
evt.map[27] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar0", 1)
	end
end

evt.hint[28] = evt.str[5]  -- "Bed"
evt.map[28] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar1", 1)
	end
end

evt.hint[29] = evt.str[5]  -- "Bed"
evt.map[29] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar2", 1)
	end
end

evt.hint[30] = evt.str[5]  -- "Bed"
evt.map[30] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar3", 1)
	end
end

evt.hint[31] = evt.str[5]  -- "Bed"
evt.map[31] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar4", 1)
	end
end

evt.hint[32] = evt.str[5]  -- "Bed"
evt.map[32] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar5", 1)
	end
end

evt.hint[33] = evt.str[5]  -- "Bed"
evt.map[33] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("Inventory", 29)         -- "Heavy Poleax"
		evt.Add("MapVar6", 1)
	end
end

evt.hint[34] = evt.str[5]  -- "Bed"
evt.map[34] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.StatusText(14)         -- "The bed(s) are empty."
	else
		evt.StatusText(12)         -- "You find something around the bed."
		evt.Add("Inventory", 11)         -- "Mighty Broadsword"
		evt.Add("MapVar7", 1)
	end
end

evt.hint[35] = evt.str[2]  -- "Gate"
evt.map[35] = function()
	evt.StatusText(11)         -- "The gate will not budge."
end

evt.hint[50] = evt.str[15]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -18638, Y = -5133, Z = 64, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC1.Odm"}
end

evt.map[51] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.Set("MapVar19", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Helm_, Id = 0}
	end
end

evt.map[52] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.Set("MapVar19", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Helm_, Id = 0}
	end
end

