local TXT = Localize{
	[0] = " ",
	[1] = "Exit Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Blue Torch",
	[5] = "Empty",
	[6] = "Empty",
	[7] = "Door",
	[8] = "T",
	[9] = "h",
	[10] = "e",
	[11] = "Q",
	[12] = "u",
	[13] = "i",
	[14] = "c",
	[15] = "k",
	[16] = "B",
	[17] = "r",
	[18] = "o",
	[19] = "w",
	[20] = "n",
	[21] = "F",
	[22] = "O",
	[23] = "x",
	[24] = "Halls of the Adept",
	[25] = "The Torch is activated.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[24]  -- "Halls of the Adept"

evt.hint[1] = evt.str[7]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[7]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[7]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[7]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[7]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[7]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[7]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[7]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[7]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[7]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[7]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[7]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[7]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[7]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[7]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[7]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[7]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[7]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[8]  -- "T"
evt.map[19] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 3, FromX = 2496, FromY = 4864, FromZ = 360, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.hint[20] = evt.str[9]  -- "h"
evt.map[20] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.SetDoorState{Id = 55, State = 1}
		evt.SetDoorState{Id = 56, State = 1}
		evt.SetDoorState{Id = 57, State = 0}
		evt.SetDoorState{Id = 58, State = 0}
		evt.SetTexture{Facet = 2011, Name = "t1swdu"}
	end
end

evt.hint[21] = evt.str[10]  -- "e"
evt.map[21] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.SetDoorState{Id = 57, State = 1}
		evt.SetDoorState{Id = 58, State = 1}
		evt.SetDoorState{Id = 55, State = 0}
		evt.SetDoorState{Id = 56, State = 0}
		evt.SetTexture{Facet = 2012, Name = "t1swdu"}
	end
end

evt.hint[22] = evt.str[11]  -- "Q"
evt.map[22] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.SetDoorState{Id = 40, State = 1}
		evt.SetDoorState{Id = 52, State = 1}
		evt.SetDoorState{Id = 51, State = 1}
		evt.SetDoorState{Id = 57, State = 0}
		evt.SetDoorState{Id = 58, State = 0}
		evt.SetTexture{Facet = 2013, Name = "t1swdu"}
	end
end

evt.hint[23] = evt.str[12]  -- "u"
evt.map[23] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.SetDoorState{Id = 57, State = 1}
		evt.SetDoorState{Id = 58, State = 1}
		evt.SetDoorState{Id = 40, State = 0}
		evt.SetDoorState{Id = 52, State = 0}
		evt.SetDoorState{Id = 51, State = 0}
		evt.SetTexture{Facet = 2009, Name = "t1swdu"}
	end
end

evt.hint[24] = evt.str[13]  -- "i"
evt.map[24] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.SetDoorState{Id = 36, State = 1}
		evt.SetDoorState{Id = 47, State = 1}
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 55, State = 0}
		evt.SetDoorState{Id = 56, State = 0}
		evt.SetTexture{Facet = 2008, Name = "t1swdu"}
	end
end

evt.hint[25] = evt.str[14]  -- "c"
evt.map[25] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.SetDoorState{Id = 59, State = 1}
		evt.SetDoorState{Id = 60, State = 1}
		evt.SetTexture{Facet = 2007, Name = "t1swdu"}
	end
end

evt.hint[26] = evt.str[15]  -- "k"
evt.map[26] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 1)
		evt.SetDoorState{Id = 38, State = 1}
		evt.SetDoorState{Id = 44, State = 1}
		evt.SetDoorState{Id = 36, State = 0}
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 48, State = 0}
		evt.SetTexture{Facet = 2006, Name = "t1swdu"}
	end
end

evt.hint[27] = evt.str[16]  -- "B"
evt.map[27] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.Set("MapVar7", 1)
		evt.SetDoorState{Id = 36, State = 1}
		evt.SetDoorState{Id = 47, State = 1}
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 38, State = 0}
		evt.SetDoorState{Id = 44, State = 0}
		evt.SetTexture{Facet = 2002, Name = "t1swdu"}
	end
end

evt.hint[28] = evt.str[17]  -- "r"
evt.map[28] = function()
	if not evt.Cmp("MapVar8", 1) then
		evt.Set("MapVar8", 1)
		evt.SetDoorState{Id = 36, State = 1}
		evt.SetDoorState{Id = 47, State = 1}
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 40, State = 0}
		evt.SetDoorState{Id = 52, State = 0}
		evt.SetDoorState{Id = 51, State = 0}
		evt.SetTexture{Facet = 2003, Name = "t1swdu"}
	end
end

evt.hint[29] = evt.str[18]  -- "o"
evt.map[29] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 1)
		evt.SetDoorState{Id = 59, State = 1}
		evt.SetDoorState{Id = 60, State = 1}
		evt.SetDoorState{Id = 57, State = 0}
		evt.SetDoorState{Id = 58, State = 0}
		evt.SetTexture{Facet = 2004, Name = "t1swdu"}
	end
end

evt.hint[30] = evt.str[19]  -- "w"
evt.map[30] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.Set("MapVar10", 1)
		evt.SetDoorState{Id = 38, State = 1}
		evt.SetDoorState{Id = 44, State = 1}
		evt.SetDoorState{Id = 55, State = 0}
		evt.SetDoorState{Id = 56, State = 0}
		evt.SetTexture{Facet = 2005, Name = "t1swdu"}
	end
end

evt.hint[31] = evt.str[20]  -- "n"
evt.map[31] = function()
	evt.MoveToMap{X = 9000, Y = 1916, Z = -767, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[32] = evt.str[21]  -- "F"
evt.map[32] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.Set("MapVar11", 1)
		evt.SetDoorState{Id = 40, State = 1}
		evt.SetDoorState{Id = 51, State = 1}
		evt.SetDoorState{Id = 52, State = 1}
		evt.SetDoorState{Id = 36, State = 0}
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 48, State = 0}
		evt.SetTexture{Facet = 2000, Name = "t1swdu"}
	end
end

evt.hint[33] = evt.str[22]  -- "O"
evt.map[33] = function()
	if not evt.Cmp("MapVar12", 1) then
		evt.Set("MapVar12", 1)
		evt.SetDoorState{Id = 57, State = 1}
		evt.SetDoorState{Id = 58, State = 1}
		evt.SetDoorState{Id = 59, State = 0}
		evt.SetDoorState{Id = 60, State = 0}
		evt.SetTexture{Facet = 1999, Name = "t1swdu"}
	end
end

evt.hint[34] = evt.str[23]  -- "x"
evt.map[34] = function()
	evt.Set("MapVar0", 0)
	evt.Set("MapVar1", 0)
	evt.Set("MapVar2", 0)
	evt.Set("MapVar3", 0)
	evt.Set("MapVar4", 0)
	evt.Set("MapVar5", 0)
	evt.Set("MapVar6", 0)
	evt.Set("MapVar7", 0)
	evt.Set("MapVar8", 0)
	evt.Set("MapVar9", 0)
	evt.Set("MapVar10", 0)
	evt.Set("MapVar11", 0)
	evt.Set("MapVar12", 0)
	evt.SetTexture{Facet = 2011, Name = "T1swDd"}
	evt.SetTexture{Facet = 2012, Name = "T1swDd"}
	evt.SetTexture{Facet = 2013, Name = "T1swDd"}
	evt.SetTexture{Facet = 2009, Name = "T1swDd"}
	evt.SetTexture{Facet = 2008, Name = "T1swDd"}
	evt.SetTexture{Facet = 2007, Name = "T1swDd"}
	evt.SetTexture{Facet = 2006, Name = "T1swDd"}
	evt.SetTexture{Facet = 2002, Name = "T1swDd"}
	evt.SetTexture{Facet = 2003, Name = "T1swDd"}
	evt.SetTexture{Facet = 2004, Name = "T1swDd"}
	evt.SetTexture{Facet = 2005, Name = "T1swDd"}
	evt.SetTexture{Facet = 2000, Name = "T1swDd"}
	evt.SetTexture{Facet = 1999, Name = "T1swDd"}
	evt.SetDoorState{Id = 40, State = 0}
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
	evt.SetDoorState{Id = 36, State = 0}
	evt.SetDoorState{Id = 47, State = 0}
	evt.SetDoorState{Id = 48, State = 0}
	evt.SetDoorState{Id = 38, State = 0}
	evt.SetDoorState{Id = 44, State = 0}
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
end

evt.hint[35] = evt.str[4]  -- "Blue Torch"
evt.map[35] = function()
	if evt.Cmp("QBits", 475) then         -- Goblinwatch Torch 2
		evt.MoveToMap{X = 17205, Y = -16395, Z = 128, Direction = 1520, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE1.Odm"}
	else
		evt.StatusText(25)         -- "The Torch is activated."
		evt.Set("QBits", 476)         -- Goblinwatch Torch 1
	end
end

evt.hint[36] = evt.str[4]  -- "Blue Torch"
evt.map[36] = function()
	if evt.Cmp("QBits", 476) then         -- Goblinwatch Torch 1
		evt.MoveToMap{X = 17205, Y = -16395, Z = 128, Direction = 1520, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE1.Odm"}
	else
		evt.StatusText(25)         -- "The Torch is activated."
		evt.Set("QBits", 475)         -- Goblinwatch Torch 2
	end
end

evt.hint[41] = evt.str[2]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(1)
end

evt.hint[42] = evt.str[2]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(2)
end

evt.hint[43] = evt.str[2]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(3)
end

evt.hint[44] = evt.str[2]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(4)
end

evt.hint[45] = evt.str[2]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(5)
end

evt.hint[46] = evt.str[2]  -- "Chest"
evt.map[46] = function()
	evt.OpenChest(6)
end

evt.hint[47] = evt.str[2]  -- "Chest"
evt.map[47] = function()
	evt.OpenChest(7)
	if not evt.Cmp("MapVar19", 1) then
		evt.Set("MapVar19", 1)
		evt.SummonObject{Type = 2100, X = 9856, Y = 4992, Z = -1024, Speed = 512, Count = 3, RandomAngle = false}         -- starburst
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 9856, Y = 4992, Z = -1024}
	end
end

evt.hint[48] = evt.str[2]  -- "Chest"
evt.map[48] = function()
	evt.OpenChest(8)
end

evt.hint[49] = evt.str[2]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(9)
end

evt.hint[50] = evt.str[2]  -- "Chest"
evt.map[50] = function()
	evt.OpenChest(10)
end

evt.hint[51] = evt.str[1]  -- "Exit Door"
evt.map[51] = function()
	evt.MoveToMap{X = 16387, Y = -20005, Z = 225, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD2.Odm"}
end

evt.map[55] = function()
	if not evt.Cmp("MapVar24", 1) then
		evt.Set("MapVar24", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
	end
end

evt.hint[60] = evt.str[7]  -- "Door"
evt.map[60] = function()
	evt.SetDoorState{Id = 45, State = 1}
	evt.SetDoorState{Id = 46, State = 1}
end

evt.hint[61] = evt.str[7]  -- "Door"
evt.map[61] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.hint[62] = evt.str[3]  -- "Switch"
evt.map[62] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
end

evt.map[63] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.map[64] = function()
	if not evt.Cmp("MapVar13", 1) then
		evt.CastSpell{Spell = 12, Mastery = const.Novice, Skill = 15, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Wizard Eye"
		evt.Set("MapVar13", 1)
	end
end

evt.map[65] = function()  -- Timer(<function>, const.Day, 1*const.Second)
	evt.Set("MapVar13", 0)
end

Timer(evt.map[65].last, const.Day, 1*const.Second)

evt.map[66] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar0", 1) then
		evt.SetTexture{Facet = 2011, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar1", 1) then
		evt.SetTexture{Facet = 2012, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar2", 1) then
		evt.SetTexture{Facet = 2013, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar2", 1) then
		evt.SetTexture{Facet = 2009, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar4", 1) then
		evt.SetTexture{Facet = 2008, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar5", 1) then
		evt.SetTexture{Facet = 2007, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar6", 1) then
		evt.SetTexture{Facet = 2006, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar7", 1) then
		evt.SetTexture{Facet = 2002, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar8", 1) then
		evt.SetTexture{Facet = 2003, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar9", 1) then
		evt.SetTexture{Facet = 2004, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar10", 1) then
		evt.SetTexture{Facet = 2005, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar11", 1) then
		evt.SetTexture{Facet = 2000, Name = "t1swdu"}
	end
	if evt.Cmp("MapVar12", 1) then
		evt.SetTexture{Facet = 1999, Name = "t1swdu"}
	end
end

events.LoadMap = evt.map[66].last

evt.map[70] = function()  -- function events.LoadMap()
	evt.Cmp("QBits", 477)         -- Goblinwatch Reload once
end

events.LoadMap = evt.map[70].last

