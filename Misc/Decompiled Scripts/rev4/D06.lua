local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Temple of the Moon",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "Antonio’s Venetian Tea",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 10:3
-- ERROR: Duplicate label: 10:5

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.map[5] = function()  -- function events.LoadMap()
	evt.SetMonsterItem{Monster = 1, Item = 658, Has = true}         -- "Contestant's Shield"
	evt.SetMonsterItem{Monster = 1, Item = 64, Has = true}         -- "Blaster"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end

events.LoadMap = evt.map[5].last

evt.hint[10] = evt.str[15]  -- "Antonio’s Venetian Tea"
evt.map[10] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 330) then         -- 1-time EI temple
		evt.Set("QBits", 330)         -- 1-time EI temple
		evt.Set("MerchantSkill", 70)
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end

evt.map[16] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 330) then         -- 1-time EI temple
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "sp57"}
	end
end

events.LoadMap = evt.map[16].last

evt.hint[21] = evt.str[3]  -- "Chest"
evt.map[21] = function()
	evt.OpenChest(1)
end

evt.hint[22] = evt.str[3]  -- "Chest"
evt.map[22] = function()
	evt.OpenChest(2)
end

evt.hint[23] = evt.str[3]  -- "Chest"
evt.map[23] = function()
	evt.OpenChest(3)
end

evt.hint[24] = evt.str[3]  -- "Chest"
evt.map[24] = function()
	evt.OpenChest(4)
end

evt.hint[25] = evt.str[3]  -- "Chest"
evt.map[25] = function()
	evt.OpenChest(5)
end

evt.hint[26] = evt.str[3]  -- "Chest"
evt.map[26] = function()
	evt.OpenChest(6)
end

evt.hint[27] = evt.str[3]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(7)
end

evt.hint[28] = evt.str[3]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(8)
end

evt.hint[29] = evt.str[10]  -- "Bookcase"
evt.map[29] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.Add("Inventory", 400)         -- "Torch Light"
	end
end

evt.hint[30] = evt.str[10]  -- "Bookcase"
evt.map[30] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.Add("Inventory", 422)         -- "Awaken"
	end
end

evt.hint[31] = evt.str[10]  -- "Bookcase"
evt.map[31] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.Add("Inventory", 302)         -- "Fire Resistance"
	end
end

evt.hint[32] = evt.str[10]  -- "Bookcase"
evt.map[32] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.Add("Inventory", 311)         -- "Wizard Eye"
	end
end

evt.hint[33] = evt.str[10]  -- "Bookcase"
evt.map[33] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.Add("Inventory", 301)         -- "Fire Bolt"
	end
end

evt.hint[34] = evt.str[10]  -- "Bookcase"
evt.map[34] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.Add("Inventory", 323)         -- "Poison Spray"
	end
end

evt.hint[35] = evt.str[10]  -- "Bookcase"
evt.map[35] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 1)
		evt.Add("Inventory", 300)         -- "Torch Light"
	end
end

evt.hint[36] = evt.str[10]  -- "Bookcase"
evt.map[36] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.Set("MapVar7", 1)
		evt.Add("Inventory", 300)         -- "Torch Light"
	end
end

evt.hint[37] = evt.str[10]  -- "Bookcase"
evt.map[37] = function()
	if not evt.Cmp("MapVar8", 1) then
		evt.Set("MapVar8", 1)
		evt.Add("Inventory", 300)         -- "Torch Light"
	end
end

evt.hint[38] = evt.str[10]  -- "Bookcase"
evt.map[38] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 1)
		evt.Add("Inventory", 300)         -- "Torch Light"
	end
end

evt.hint[39] = evt.str[10]  -- "Bookcase"
evt.map[39] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.Set("MapVar10", 1)
		evt.Add("Inventory", 300)         -- "Torch Light"
	end
end

evt.hint[40] = evt.str[10]  -- "Bookcase"
evt.map[40] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.Set("MapVar11", 1)
		evt.Add("Inventory", 311)         -- "Wizard Eye"
	end
end

evt.hint[41] = evt.str[10]  -- "Bookcase"
evt.map[41] = function()
	if not evt.Cmp("MapVar12", 1) then
		evt.Set("MapVar12", 1)
		evt.Add("Inventory", 311)         -- "Wizard Eye"
	end
end

evt.hint[42] = evt.str[10]  -- "Bookcase"
evt.map[42] = function()
	if not evt.Cmp("MapVar13", 1) then
		evt.Set("MapVar13", 1)
		evt.Add("Inventory", 311)         -- "Wizard Eye"
	end
end

evt.hint[43] = evt.str[10]  -- "Bookcase"
evt.map[43] = function()
	if not evt.Cmp("MapVar14", 1) then
		evt.Set("MapVar14", 1)
		evt.Add("Inventory", 311)         -- "Wizard Eye"
	end
end

evt.map[51] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -2619, FromY = 7850, FromZ = -95, ToX = -2619, ToY = 4008, ToZ = -95}         -- "Fire Bolt"
	evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -2619, FromY = 4050, FromZ = -95, ToX = -2619, ToY = 7896, ToZ = -95}         -- "Fire Bolt"
end

Timer(evt.map[51].last, 2.5*const.Minute)

evt.hint[100] = evt.str[2]  -- "Leave the Temple of the Moon"
evt.map[100] = function()
	evt.MoveToMap{X = 15816, Y = 12161, Z = 1133, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "Out01.Odm"}
end

