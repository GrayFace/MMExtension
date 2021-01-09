local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Chest",
	[4] = "Exit",
	[5] = "The door is locked.",
	[6] = "The door won't budge.",
	[7] = "Castle Alamos",
	[8] = "Tree",
	[9] = "Etched into the tree a message reads:                                                                                                                                                                                                                              The first is half the forth plus one, better hurry or you'll be done!",
	[10] = "Etched into the tree a message reads:                                                                                                                                                                                                                              The second is next to the third, oh so pretty like a bird!",
	[11] = "Etched into the tree a message reads:                                                                                                                                                                                                                              The third is the first of twenty six, A through Z you'll have to mix!",
	[12] = "Etched into the tree a message reads:                                                                                                                                                                                                                              The fifth is twice the second, five letters in all I reckon!",
	[13] = "Etched into the tree a message reads:                                                                                                                                                                                                                              The forth is eight from the end, Archibald really is your friend!",
	[14] = "What's the password?",
	[15] = "JBARD",
	[16] = "jbard",
	[17] = "Wrong!",
	[18] = "Ok!",
	[19] = "Who told you!  Alright, you may pass!",
	[20] = "Teleporter",
	[21] = "Restricted area - Keep out.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Castle Alamos"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
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
	if evt.Cmp("Inventory", 569) then         -- "Teleporter Key"
		evt.Subtract("Inventory", 569)         -- "Teleporter Key"
		evt.SetDoorState{Id = 8, State = 1}
	else
		evt.StatusText(5)         -- "The door is locked."
	end
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	if evt.Cmp("Inventory", 568) then         -- "Treasure Room Key"
		evt.Subtract("Inventory", 568)         -- "Treasure Room Key"
		evt.SetDoorState{Id = 10, State = 1}
	else
		evt.StatusText(5)         -- "The door is locked."
	end
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
	evt.MoveToMap{X = -2112, Y = 14240, Z = 40, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[14] = function()
	evt.MoveToMap{X = 4480, Y = 8064, Z = -340, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[18] = function()
	if not evt.Cmp("MapVar0", 5) then
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -2194, Y = 4048, Z = 225}
		evt.Add("MapVar0", 1)
	end
end

evt.hint[30] = evt.str[3]  -- "Chest"
evt.map[30] = function()
	evt.OpenChest(0)
end

evt.hint[31] = evt.str[2]  -- "Switch"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[33] = evt.str[1]  -- "Door"
evt.map[33] = function()
	evt.StatusText(6)         -- "The door won't budge."
end

evt.map[35] = function()
	evt.SetDoorState{Id = 35, State = 2}         -- switch state
end

evt.hint[41] = evt.str[3]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(1)
end

evt.hint[42] = evt.str[3]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(2)
end

evt.hint[43] = evt.str[3]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(3)
end

evt.hint[44] = evt.str[3]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(4)
end

evt.hint[45] = evt.str[3]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(5)
end

evt.hint[47] = evt.str[20]  -- "Teleporter"
evt.map[47] = function()
	if evt.Cmp("QBits", 54) then         -- Chris
		evt.MoveToMap{X = 7829, Y = -7173, Z = 224, Direction = 568, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "OutD1.Odm"}
	end
end

evt.hint[51] = evt.str[3]  -- "Chest"
evt.map[51] = function()
	evt.OpenChest(6)
end

evt.hint[52] = evt.str[3]  -- "Chest"
evt.map[52] = function()
	evt.OpenChest(7)
end

evt.hint[53] = evt.str[3]  -- "Chest"
evt.map[53] = function()
	evt.OpenChest(8)
end

evt.hint[54] = evt.str[3]  -- "Chest"
evt.map[54] = function()
	evt.OpenChest(9)
end

evt.hint[55] = evt.str[3]  -- "Chest"
evt.map[55] = function()
	evt.OpenChest(10)
end

evt.hint[56] = evt.str[3]  -- "Chest"
evt.map[56] = function()
	evt.OpenChest(11)
end

evt.hint[57] = evt.str[3]  -- "Chest"
evt.map[57] = function()
	evt.OpenChest(12)
end

evt.hint[58] = evt.str[3]  -- "Chest"
evt.map[58] = function()
	evt.OpenChest(13)
end

evt.hint[59] = evt.str[4]  -- "Exit"
evt.map[59] = function()
	if not evt.Cmp("QBits", 54) then         -- Chris
		evt.Set("QBits", 54)         -- Chris
		evt.SetSprite{SpriteId = 394, Visible = 1, Name = "crysdisc"}
		evt.Add("Inventory", 551)         -- "Memory Crystal Beta"
		evt.Set("QBits", 192)         -- Quest item bits for seer
	end
end

evt.map[60] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 54) then         -- Chris
		evt.SetSprite{SpriteId = 394, Visible = 1, Name = "crysdisc"}
	end
end

events.LoadMap = evt.map[60].last

evt.hint[61] = evt.str[4]  -- "Exit"
evt.map[61] = function()
	evt.MoveToMap{X = 13830, Y = 7687, Z = 673, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutE1.odm"}
end

evt.hint[62] = evt.str[1]  -- "Door"
evt.map[62] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[63] = evt.str[1]  -- "Door"
evt.map[63] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[64] = evt.str[8]  -- "Tree"
evt.map[64] = function()
	evt.Set("MapVar1", 1)
	evt.SetMessage(9)         -- "Etched into the tree a message reads:                                                                                                                                                                                                                              The first is half the forth plus one, better hurry or you'll be done!"
	evt.SimpleMessage()
end

evt.hint[65] = evt.str[8]  -- "Tree"
evt.map[65] = function()
	evt.Set("MapVar2", 1)
	evt.SetMessage(10)         -- "Etched into the tree a message reads:                                                                                                                                                                                                                              The second is next to the third, oh so pretty like a bird!"
	evt.SimpleMessage()
end

evt.hint[66] = evt.str[8]  -- "Tree"
evt.map[66] = function()
	evt.Set("MapVar3", 1)
	evt.SetMessage(11)         -- "Etched into the tree a message reads:                                                                                                                                                                                                                              The third is the first of twenty six, A through Z you'll have to mix!"
	evt.SimpleMessage()
end

evt.hint[67] = evt.str[8]  -- "Tree"
evt.map[67] = function()
	evt.Set("MapVar4", 1)
	evt.SetMessage(12)         -- "Etched into the tree a message reads:                                                                                                                                                                                                                              The fifth is twice the second, five letters in all I reckon!"
	evt.SimpleMessage()
end

evt.hint[68] = evt.str[8]  -- "Tree"
evt.map[68] = function()
	evt.Set("MapVar5", 1)
	evt.SetMessage(13)         -- "Etched into the tree a message reads:                                                                                                                                                                                                                              The forth is eight from the end, Archibald really is your friend!"
	evt.SimpleMessage()
end

evt.map[69] = function()
	if evt.Cmp("MapVar6", 1) then
		return
	end
	if evt.Cmp("MapVar1", 1) then
		if evt.Cmp("MapVar2", 1) then
			if evt.Cmp("MapVar3", 1) then
				if evt.Cmp("MapVar4", 1) then
					if evt.Cmp("MapVar5", 1) then
						evt.SetMessage(21)         -- "Restricted area - Keep out."
						if evt.Question{Question = 14, Answer1 = 15, Answer2 = 16} then         -- "What's the password?" ("JBARD", "jbard")
							evt.StatusText(18)         -- "Ok!"
							evt.Set("MapVar6", 1)
						else
							evt.StatusText(17)         -- "Wrong!"
							evt.MoveToMap{X = -3136, Y = 2240, Z = 224, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
						end
						return
					end
				end
			end
		end
	end
	evt.SetMessage(21)         -- "Restricted area - Keep out."
	if evt.Question{Question = 14, Answer1 = 15, Answer2 = 16} then         -- "What's the password?" ("JBARD", "jbard")
		evt.StatusText(19)         -- "Who told you!  Alright, you may pass!"
		evt.Set("MapVar6", 1)
	else
		evt.StatusText(17)         -- "Wrong!"
		evt.MoveToMap{X = -3136, Y = 2240, Z = 224, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[70] = function()  -- Timer(<function>, 10*const.Minute)
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 10, FromX = 2995, FromY = 9373, FromZ = -840, ToX = 2000, ToY = 9373, ToZ = -840}         -- "Fireball"
end

Timer(evt.map[70].last, 10*const.Minute)

