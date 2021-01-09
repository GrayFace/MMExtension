local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Mad Necromancer's Lab",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "Bookshelf",
	[10] = "",
	[11] = "Take a Drink",
	[12] = "Refreshing !",
	[13] = "That was not so refreshing",
	[14] = "",
	[15] = "The door is locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.map[5] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
end

events.LoadMap = evt.map[5].last

evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 539) then         -- "Ebonest"
		evt.Add("QBits", 199)         -- Ebonest - I lost it
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.map[10] = function()  -- function events.LeaveMap()
	if evt.Cmp("QBits", 71) then         -- Found Blazen Stormlance and recovered Ebonest
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki"
	end
end

events.LeaveMap = evt.map[10].last

evt.hint[11] = evt.str[2]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[12] = evt.str[5]  -- "Button"
evt.map[12] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[13] = evt.str[5]  -- "Button"
evt.map[13] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[14] = evt.str[2]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[15] = evt.str[2]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[16] = evt.str[2]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[17] = evt.str[2]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[18] = evt.str[2]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[19] = evt.str[2]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[20] = evt.str[2]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[21] = evt.str[2]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[22] = evt.str[2]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[23] = evt.str[2]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[24] = evt.str[2]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[25] = evt.str[2]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[26] = evt.str[2]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[27] = evt.str[2]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[28] = evt.str[2]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[29] = evt.str[2]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[30] = evt.str[2]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 20, State = 0}
end

evt.hint[31] = evt.str[2]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[32] = evt.str[2]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[33] = evt.str[2]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[34] = evt.str[2]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[35] = evt.str[2]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[36] = evt.str[2]  -- "Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[37] = evt.str[2]  -- "Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[38] = evt.str[2]  -- "Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[39] = evt.str[2]  -- "Door"
evt.map[39] = function()
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[40] = evt.str[2]  -- "Door"
evt.map[40] = function()
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[41] = evt.str[2]  -- "Door"
evt.map[41] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.hint[42] = evt.str[2]  -- "Door"
evt.map[42] = function()
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[43] = evt.str[2]  -- "Door"
evt.map[43] = function()
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[44] = evt.str[2]  -- "Door"
evt.map[44] = function()
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[45] = evt.str[2]  -- "Door"
evt.map[45] = function()
	evt.SetDoorState{Id = 35, State = 0}
end

evt.hint[46] = evt.str[2]  -- "Door"
evt.map[46] = function()
	evt.SetDoorState{Id = 36, State = 0}
end

evt.hint[47] = evt.str[2]  -- "Door"
evt.map[47] = function()
	evt.SetDoorState{Id = 37, State = 0}
end

evt.hint[48] = evt.str[2]  -- "Door"
evt.map[48] = function()
	evt.SetDoorState{Id = 38, State = 0}
end

evt.hint[49] = evt.str[2]  -- "Door"
evt.map[49] = function()
	evt.SetDoorState{Id = 39, State = 0}
end

evt.hint[50] = evt.str[2]  -- "Door"
evt.map[50] = function()
	evt.SetDoorState{Id = 40, State = 0}
end

evt.hint[51] = evt.str[2]  -- "Door"
evt.map[51] = function()
	evt.SetDoorState{Id = 41, State = 0}
end

evt.hint[52] = evt.str[2]  -- "Door"
evt.map[52] = function()
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[53] = evt.str[2]  -- "Door"
evt.map[53] = function()
	evt.SetDoorState{Id = 43, State = 0}
end

evt.hint[54] = evt.str[2]  -- "Door"
evt.map[54] = function()
	evt.SetDoorState{Id = 44, State = 0}
end

evt.hint[55] = evt.str[2]  -- "Door"
evt.map[55] = function()
	evt.SetDoorState{Id = 45, State = 0}
end

evt.hint[56] = evt.str[2]  -- "Door"
evt.map[56] = function()
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[57] = evt.str[2]  -- "Door"
evt.map[57] = function()
	evt.SetDoorState{Id = 47, State = 0}
end

evt.hint[58] = evt.str[2]  -- "Door"
evt.map[58] = function()
	evt.SetDoorState{Id = 48, State = 0}
end

evt.hint[59] = evt.str[2]  -- "Door"
evt.map[59] = function()
	evt.SetDoorState{Id = 49, State = 0}
end

evt.hint[60] = evt.str[2]  -- "Door"
evt.map[60] = function()
	evt.SetDoorState{Id = 50, State = 0}
end

evt.hint[61] = evt.str[2]  -- "Door"
evt.map[61] = function()
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
end

evt.hint[62] = evt.str[2]  -- "Door"
evt.map[62] = function()
	evt.SetDoorState{Id = 53, State = 0}
	evt.SetDoorState{Id = 54, State = 0}
end

evt.hint[63] = evt.str[2]  -- "Door"
evt.map[63] = function()
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
end

evt.hint[64] = evt.str[2]  -- "Door"
evt.map[64] = function()
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
end

evt.hint[65] = evt.str[2]  -- "Door"
evt.map[65] = function()
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
end

evt.hint[66] = evt.str[2]  -- "Door"
evt.map[66] = function()
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
end

evt.hint[81] = evt.str[3]  -- "Chest"
evt.map[81] = function()
	evt.OpenChest(0)
end

evt.hint[82] = evt.str[3]  -- "Chest"
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- "Chest"
evt.map[83] = function()
	evt.OpenChest(2)
end

evt.hint[84] = evt.str[3]  -- "Chest"
evt.map[84] = function()
	evt.OpenChest(3)
end

evt.hint[85] = evt.str[3]  -- "Chest"
evt.map[85] = function()
	evt.OpenChest(4)
end

evt.hint[86] = evt.str[3]  -- "Chest"
evt.map[86] = function()
	evt.OpenChest(5)
end

evt.hint[87] = evt.str[3]  -- "Chest"
evt.map[87] = function()
	evt.OpenChest(6)
end

evt.hint[88] = evt.str[3]  -- "Chest"
evt.map[88] = function()
	evt.OpenChest(7)
end

evt.hint[89] = evt.str[3]  -- "Chest"
evt.map[89] = function()
	evt.OpenChest(8)
end

evt.hint[90] = evt.str[3]  -- "Chest"
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- "Chest"
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[3]  -- "Chest"
evt.map[92] = function()
	evt.OpenChest(11)
end

evt.hint[93] = evt.str[3]  -- "Chest"
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[3]  -- "Chest"
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[3]  -- "Chest"
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[3]  -- "Chest"
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[3]  -- "Chest"
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[3]  -- "Chest"
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[3]  -- "Chest"
evt.map[99] = function()
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[3]  -- "Chest"
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.hint[101] = evt.str[100]  -- ""
evt.hint[102] = evt.str[100]  -- ""
evt.map[102] = function()
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 20, FromX = -1018, FromY = 3344, FromZ = -862, ToX = 890, ToY = 3344, ToZ = -862}         -- "Blades"
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 20, FromX = 890, FromY = 3344, FromZ = -862, ToX = -1018, ToY = 3344, ToZ = -862}         -- "Blades"
end

evt.hint[103] = evt.str[100]  -- ""
evt.map[103] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 20, FromX = 1498, FromY = 2195, FromZ = -560, ToX = 1498, ToY = 2195, ToZ = -1024}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 20, FromX = 2552, FromY = 2195, FromZ = -560, ToX = 2552, ToY = 2195, ToZ = -1024}         -- "Fireball"
end

evt.hint[104] = evt.str[100]  -- ""
evt.hint[105] = evt.str[100]  -- ""
evt.hint[106] = evt.str[100]  -- ""
evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()
	if evt.Cmp("QBits", 435) then         -- Roster Character In Party 36
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.SpeakNPC(295)         -- "Blazen Stormlance"
	end
end

evt.hint[451] = evt.str[11]  -- "Take a Drink"
evt.map[451] = function()
	evt.StatusText(12)         -- "Refreshing !"
end

evt.hint[452] = evt.str[9]  -- "Bookshelf"
evt.map[452] = function()
	local i
	if evt.Cmp("MapVar39", 3) then
		goto _14
	end
	i = Game.Rand() % 6
	if i == 1 then
		goto _14
	elseif i == 2 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 357}         -- "Mind Resistance"
		goto _15
	elseif i == 3 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 346}         -- "Fate"
		goto _15
	elseif i == 4 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 335}         -- "Earth Resistance"
		goto _15
	elseif i == 5 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 302}         -- "Fire Resistance"
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 368}         -- "Body Resistance"
::_15::
	evt.Add("MapVar39", 1)
	do return end
::_14::
	evt.StatusText(10)         -- ""
	goto _15
end

evt.hint[453] = evt.str[9]  -- "Bookshelf"
evt.map[453] = function()
	local i
	if evt.Cmp("MapVar40", 3) then
		goto _14
	end
	i = Game.Rand() % 6
	if i == 1 then
		goto _14
	elseif i == 2 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 355}         -- "Telepathy"
		goto _15
	elseif i == 3 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 356}         -- "Remove Fear"
		goto _15
	elseif i == 4 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 357}         -- "Mind Resistance"
		goto _15
	elseif i == 5 then
		evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 367}         -- "Heal"
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 334}         -- "Slow"
::_15::
	evt.Add("MapVar40", 1)
	do return end
::_14::
	evt.StatusText(10)         -- ""
	goto _15
end

evt.hint[454] = evt.str[9]  -- "Bookshelf"
evt.map[454] = function()
	local i
	if evt.Cmp("MapVar41", 1) then
		goto _14
	end
	i = Game.Rand() % 6
	if i == 1 then
		goto _14
	elseif i == 2 then
		evt.Add("Inventory", 435)         -- "Earth Resistance"
		goto _15
	elseif i == 3 then
		evt.Add("Inventory", 446)         -- "Fate"
		goto _15
	elseif i == 4 then
		evt.Add("Inventory", 457)         -- "Mind Resistance"
		goto _15
	elseif i == 5 then
		evt.Add("Inventory", 468)         -- "Body Resistance"
		goto _15
	end
	evt.Add("Inventory", 424)         -- "Water Resistance"
::_15::
	evt.Add("MapVar41", 1)
	do return end
::_14::
	evt.StatusText(10)         -- ""
	goto _15
end

evt.hint[455] = evt.str[9]  -- "Bookshelf"
evt.map[455] = function()
	local i
	if evt.Cmp("MapVar42", 1) then
		goto _14
	end
	i = Game.Rand() % 6
	if i == 1 then
		goto _14
	elseif i == 2 then
		evt.Add("Inventory", 412)         -- "Feather Fall"
		goto _15
	elseif i == 3 then
		evt.Add("Inventory", 411)         -- "Wizard Eye"
		goto _15
	elseif i == 4 then
		evt.Add("Inventory", 423)         -- "Poison Spray"
		goto _15
	elseif i == 5 then
		evt.Add("Inventory", 434)         -- "Slow"
		goto _15
	end
	evt.Add("Inventory", 401)         -- "Fire Bolt"
::_15::
	evt.Add("MapVar42", 1)
	do return end
::_14::
	evt.StatusText(10)         -- ""
	goto _15
end

evt.hint[501] = evt.str[1]  -- "Leave the Mad Necromancer's Lab"
evt.map[501] = function()
	evt.MoveToMap{X = -13071, Y = 16397, Z = 1057, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out06.odm"}
end

