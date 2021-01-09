local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Sarcophagus",
	[3] = "Burial niche",
	[4] = "Elevator",
	[5] = "Platform",
	[6] = "Gate",
	[7] = "The door will not budge.",
	[8] = "Fumes make you feel sick.",
	[9] = "You find something among the bones.",
	[10] = "The niche is empty.",
	[11] = "Door.",
	[12] = "Exit.",
	[13] = "Tomb of Ethric the Mad",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Tomb of Ethric the Mad"

evt.hint[1] = evt.str[4]  -- "Elevator"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[2] = evt.str[4]  -- "Elevator"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[3] = evt.str[4]  -- "Elevator"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[4] = evt.str[11]  -- "Door."
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[5] = evt.str[1]  -- "Switch"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Switch"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[7] = evt.str[11]  -- "Door."
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[11]  -- "Door."
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[11]  -- "Door."
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[11]  -- "Door."
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[11]  -- "Door."
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[13] = evt.str[1]  -- "Switch"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.hint[14] = evt.str[2]  -- "Sarcophagus"
evt.map[14] = function()
	evt.OpenChest(0)
end

evt.hint[15] = evt.str[2]  -- "Sarcophagus"
evt.map[15] = function()
	evt.OpenChest(1)
end

evt.hint[16] = evt.str[2]  -- "Sarcophagus"
evt.map[16] = function()
	evt.OpenChest(2)
end

evt.hint[17] = evt.str[2]  -- "Sarcophagus"
evt.map[17] = function()
	evt.OpenChest(3)
end

evt.hint[18] = evt.str[2]  -- "Sarcophagus"
evt.map[18] = function()
	evt.OpenChest(4)
end

evt.hint[19] = evt.str[2]  -- "Sarcophagus"
evt.map[19] = function()
	evt.OpenChest(5)
end

evt.hint[20] = evt.str[2]  -- "Sarcophagus"
evt.map[20] = function()
	evt.OpenChest(6)
end

evt.hint[21] = evt.str[3]  -- "Burial niche"
evt.map[21] = function()
	evt.StatusText(8)         -- "Fumes make you feel sick."
	evt.ForPlayer("Random")
	evt.Add("DiseasedRed", 2)
end

evt.hint[22] = evt.str[3]  -- "Burial niche"
evt.map[22] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar0", 1)
	end
end

evt.hint[23] = evt.str[3]  -- "Burial niche"
evt.map[23] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar1", 1)
	end
end

evt.hint[24] = evt.str[3]  -- "Burial niche"
evt.map[24] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar2", 1)
	end
end

evt.hint[25] = evt.str[3]  -- "Burial niche"
evt.map[25] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar3", 1)
	end
end

evt.hint[26] = evt.str[3]  -- "Burial niche"
evt.map[26] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar4", 1)
	end
end

evt.hint[27] = evt.str[3]  -- "Burial niche"
evt.map[27] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar4", 1)
	end
end

evt.hint[28] = evt.str[3]  -- "Burial niche"
evt.map[28] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar4", 1)
	end
end

evt.hint[29] = evt.str[3]  -- "Burial niche"
evt.map[29] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Inventory", 164)         -- "Cure Wounds"
		evt.Add("MapVar5", 1)
	end
end

evt.hint[30] = evt.str[3]  -- "Burial niche"
evt.map[30] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Inventory", 113)         -- "Cavalier Gauntlets"
		evt.Add("MapVar6", 1)
	end
end

evt.hint[31] = evt.str[3]  -- "Burial niche"
evt.map[31] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Inventory", 142)         -- "Fairy Wand of Poison"
		evt.Add("MapVar7", 1)
	end
end

evt.hint[32] = evt.str[3]  -- "Burial niche"
evt.map[32] = function()
	if evt.Cmp("MapVar8", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Inventory", 158)         -- "Mystic Wand of Shrinking"
		evt.Add("MapVar8", 1)
	end
end

evt.hint[33] = evt.str[2]  -- "Sarcophagus"
evt.map[33] = function()
	evt.OpenChest(7)
end

evt.hint[34] = evt.str[6]  -- "Gate"
evt.map[34] = function()
	evt.StatusText(7)         -- "The door will not budge."
end

evt.hint[35] = evt.str[3]  -- "Burial niche"
evt.map[35] = function()
	evt.StatusText(10)         -- "The niche is empty."
end

evt.hint[36] = evt.str[3]  -- "Burial niche"
evt.map[36] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Gold", 500)
		evt.Add("MapVar9", 1)
	end
end

evt.hint[37] = evt.str[3]  -- "Burial niche"
evt.map[37] = function()
	if evt.Cmp("MapVar10", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Gold", 500)
		evt.Add("MapVar10", 1)
	end
end

evt.hint[38] = evt.str[3]  -- "Burial niche"
evt.map[38] = function()
	if evt.Cmp("MapVar11", 1) then
		evt.StatusText(10)         -- "The niche is empty."
	else
		evt.StatusText(9)         -- "You find something among the bones."
		evt.Add("Gold", 500)
		evt.Add("MapVar11", 1)
	end
end

evt.hint[39] = evt.str[11]  -- "Door."
evt.map[39] = function()
	evt.StatusText(7)         -- "The door will not budge."
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[40] = evt.str[11]  -- "Door."
evt.map[40] = function()
	evt.StatusText(7)         -- "The door will not budge."
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[50] = evt.str[12]  -- "Exit."
evt.map[50] = function()
	evt.MoveToMap{X = -19989, Y = -1020, Z = 159, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outc2.odm"}
end

evt.hint[51] = evt.str[3]  -- "Burial niche"
evt.map[51] = function()
	if not evt.Cmp("MapVar29", 1) then
		evt.Set("MapVar29", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Boots_, Id = 0}
	end
end

evt.hint[52] = evt.str[3]  -- "Burial niche"
evt.map[52] = function()
	if not evt.Cmp("MapVar30", 1) then
		evt.Set("MapVar30", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Cloak_, Id = 0}
	end
end

evt.hint[53] = evt.str[3]  -- "Burial niche"
evt.map[53] = function()
	if not evt.Cmp("MapVar31", 1) then
		evt.Set("MapVar31", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Shield_, Id = 0}
	end
end

evt.hint[54] = evt.str[3]  -- "Burial niche"
evt.map[54] = function()
	if not evt.Cmp("MapVar32", 1) then
		evt.Set("MapVar32", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Gountlets_, Id = 0}
	end
end

evt.map[55] = function()
	if not evt.Cmp("MapVar33", 1) then
		evt.Set("MapVar33", 1)
		evt.Add("Inventory", 155)         -- "Mystic Wand of Implosion"
	end
end

evt.map[56] = function()  -- Timer(<function>, 1.5*const.Minute)
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 7, FromX = -1088, FromY = 1984, FromZ = 896, ToX = 960, ToY = 3456, ToZ = 896}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 7, FromX = -1088, FromY = 4160, FromZ = 896, ToX = 960, ToY = 2624, ToZ = 896}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 7, FromX = 832, FromY = 4160, FromZ = 896, ToX = -1280, ToY = 2688, ToZ = 896}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 7, FromX = 832, FromY = 1984, FromZ = 896, ToX = -1216, ToY = 3584, ToZ = 896}         -- "Fireball"
end

Timer(evt.map[56].last, 1.5*const.Minute)

