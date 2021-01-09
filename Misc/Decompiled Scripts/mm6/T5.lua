local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Chest",
	[4] = "Altar of Might",
	[5] = "Altar of Life",
	[6] = "Altar of Endurance",
	[7] = "Altar of Accuracy",
	[8] = "Altar of Speed",
	[9] = "Altar of Luck",
	[10] = "Altar of the Moon",
	[11] = "Plaque",
	[12] = "The door won't budge",
	[13] = "You kneel at the altar for a moment of silent prayer.",
	[14] = "Life above all, Accuracy before Might, Endurance before Speed, and finally, Luck.",
	[15] = "Ouch!",
	[16] = "Exit",
	[17] = "Temple of the Moon",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[17]  -- "Temple of the Moon"

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
	if evt.Cmp("MapVar6", 21) then
		evt.SetDoorState{Id = 3, State = 1}
		evt.SetDoorState{Id = 4, State = 1}
	else
		evt.StatusText(12)         -- "The door won't budge"
	end
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
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

evt.hint[11] = evt.str[2]  -- "Switch"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[13] = evt.str[3]  -- "Chest"
evt.map[13] = function()
	evt.OpenChest(1)
end

evt.hint[14] = evt.str[3]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(2)
end

evt.hint[15] = evt.str[3]  -- "Chest"
evt.map[15] = function()
	evt.OpenChest(3)
end

evt.hint[16] = evt.str[4]  -- "Altar of Might"
evt.map[16] = function()
	if evt.Cmp("MapVar7", 1) then
		goto _3
	end
	if not evt.Cmp("MapVar3", 1) then
		if not evt.Cmp("MapVar0", 1) then
			goto _3
		end
		evt.Set("MapVar3", 1)
		evt.Add("MapVar6", 3)
		evt.ForPlayer(0)
		evt.Add("BaseMight", 5)
		evt.ForPlayer(1)
		evt.Add("BaseMight", 5)
		evt.ForPlayer(2)
		evt.Add("BaseMight", 5)
		evt.ForPlayer(3)
		evt.Add("BaseMight", 5)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
	do return end
::_3::
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
	evt.Set("MapVar7", 1)
	evt.Set("MapVar3", 1)
	evt.Add("MapVar6", 3)
	evt.StatusText(15)         -- "Ouch!"
end

evt.hint[17] = evt.str[5]  -- "Altar of Life"
evt.map[17] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
		evt.Set("MapVar5", 1)
		evt.Add("MapVar6", 1)
		evt.StatusText(15)         -- "Ouch!"
		return
	end
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.Add("MapVar6", 1)
		evt.ForPlayer(0)
		evt.Add("BasePersonality", 5)
		evt.ForPlayer(1)
		evt.Add("BasePersonality", 5)
		evt.ForPlayer(2)
		evt.Add("BasePersonality", 5)
		evt.ForPlayer(3)
		evt.Add("BasePersonality", 5)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
end

evt.hint[18] = evt.str[6]  -- "Altar of Endurance"
evt.map[18] = function()
	if evt.Cmp("MapVar7", 1) then
		goto _3
	end
	if not evt.Cmp("MapVar1", 1) then
		if not evt.Cmp("MapVar3", 1) then
			goto _3
		end
		evt.Set("MapVar1", 1)
		evt.Add("MapVar6", 4)
		evt.ForPlayer(0)
		evt.Add("BaseEndurance", 5)
		evt.ForPlayer(1)
		evt.Add("BaseEndurance", 5)
		evt.ForPlayer(2)
		evt.Add("BaseEndurance", 5)
		evt.ForPlayer(3)
		evt.Add("BaseEndurance", 5)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
	do return end
::_3::
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
	evt.Set("MapVar7", 1)
	evt.Set("MapVar1", 1)
	evt.Add("MapVar6", 4)
	evt.StatusText(15)         -- "Ouch!"
end

evt.hint[19] = evt.str[7]  -- "Altar of Accuracy"
evt.map[19] = function()
	if evt.Cmp("MapVar7", 1) then
		goto _3
	end
	if not evt.Cmp("MapVar0", 1) then
		if not evt.Cmp("MapVar5", 1) then
			goto _3
		end
		evt.Set("MapVar0", 1)
		evt.Add("MapVar6", 2)
		evt.ForPlayer(0)
		evt.Add("BaseAccuracy", 5)
		evt.ForPlayer(1)
		evt.Add("BaseAccuracy", 5)
		evt.ForPlayer(2)
		evt.Add("BaseAccuracy", 5)
		evt.ForPlayer(3)
		evt.Add("BaseAccuracy", 5)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
	do return end
::_3::
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
	evt.Set("MapVar7", 1)
	evt.Add("MapVar6", 2)
	evt.Set("MapVar0", 1)
	evt.StatusText(15)         -- "Ouch!"
end

evt.hint[20] = evt.str[8]  -- "Altar of Speed"
evt.map[20] = function()
	if evt.Cmp("MapVar7", 1) then
		goto _3
	end
	if not evt.Cmp("MapVar4", 1) then
		if not evt.Cmp("MapVar1", 1) then
			goto _3
		end
		evt.Set("MapVar4", 1)
		evt.Add("MapVar6", 5)
		evt.ForPlayer(0)
		evt.Add("BaseSpeed", 5)
		evt.ForPlayer(1)
		evt.Add("BaseSpeed", 5)
		evt.ForPlayer(2)
		evt.Add("BaseSpeed", 5)
		evt.ForPlayer(3)
		evt.Add("BaseSpeed", 5)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
	do return end
::_3::
	evt.Set("MapVar4", 1)
	evt.Set("MapVar7", 1)
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
	evt.Add("MapVar6", 5)
	evt.StatusText(15)         -- "Ouch!"
end

evt.hint[21] = evt.str[9]  -- "Altar of Luck"
evt.map[21] = function()
	if evt.Cmp("MapVar7", 1) then
		goto _3
	end
	if not evt.Cmp("MapVar2", 1) then
		if not evt.Cmp("MapVar4", 1) then
			goto _3
		end
		evt.ForPlayer(0)
		evt.Add("BaseLuck", 5)
		evt.ForPlayer(1)
		evt.Add("BaseLuck", 5)
		evt.ForPlayer(2)
		evt.Add("BaseLuck", 5)
		evt.ForPlayer(3)
		evt.Add("BaseLuck", 5)
		evt.Set("MapVar2", 1)
		evt.Add("MapVar6", 6)
	end
	evt.StatusText(13)         -- "You kneel at the altar for a moment of silent prayer."
	do return end
::_3::
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 10}
	evt.Set("MapVar7", 1)
	evt.Set("MapVar2", 1)
	evt.Add("MapVar6", 6)
	evt.StatusText(15)         -- "Ouch!"
end

evt.hint[27] = evt.str[10]  -- "Altar of the Moon"
evt.map[27] = function()
	if not evt.Cmp("QBits", 174) then         -- NPC
		if evt.Cmp("QBits", 119) then         -- "Visit the Altar of the Moon in the Temple of the Moon at midnight of a full moon."
			if not evt.Cmp("HourIs", 1) then
				if evt.Cmp("HourIs", 0) then
					evt.SpeakNPC(306)         -- "Loretta Fleise"
				end
			end
		end
	end
end

evt.hint[22] = evt.str[11]  -- "Plaque"
evt.map[22] = function()
	evt.SetMessage(14)         -- "Life above all, Accuracy before Might, Endurance before Speed, and finally, Luck."
	evt.SimpleMessage()
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[50] = evt.str[16]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -18178, Y = 19695, Z = 161, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outc2.odm"}
end

evt.map[51] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.Set("MapVar19", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Cloak_, Id = 0}
	end
end

evt.map[52] = function()
	if not evt.Cmp("MapVar20", 1) then
		evt.Set("MapVar20", 1)
		evt.Add("Inventory", 239)         -- "Stone to Flesh"
	end
end

evt.map[53] = function()
	if not evt.Cmp("MapVar21", 1) then
		evt.Set("MapVar21", 1)
		evt.Add("Inventory", 239)         -- "Stone to Flesh"
	end
end

evt.map[54] = function()
	if not evt.Cmp("MapVar22", 1) then
		evt.Set("MapVar22", 1)
		evt.Add("Inventory", 239)         -- "Stone to Flesh"
	end
end

evt.map[55] = function()
	if not evt.Cmp("MapVar23", 1) then
		evt.Set("MapVar23", 1)
		evt.Add("Inventory", 239)         -- "Stone to Flesh"
	end
end

evt.map[56] = function()
	if not evt.Cmp("MapVar24", 1) then
		evt.Set("MapVar24", 1)
		evt.Add("Inventory", 239)         -- "Stone to Flesh"
	end
end

