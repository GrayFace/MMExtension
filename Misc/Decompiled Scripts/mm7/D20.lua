local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Mercenary Guild",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "Wine Rack",
	[12] = "You see nothing of interest",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.map[6] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.map[7] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.map[8] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.map[9] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.map[10] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.map[11] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.map[12] = function()
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 9, State = 0}
end

evt.map[13] = function()
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 9, State = 1}
end

evt.map[14] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.map[15] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[16] = evt.str[10]  -- "Bookcase"
evt.map[16] = function()
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 37, State = 0}
end

evt.map[17] = function()
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
end

evt.map[18] = function()
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 1, State = 0}
end

evt.map[19] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.map[20] = function()
	evt.SetDoorState{Id = 17, State = 0}
	evt.SetDoorState{Id = 18, State = 0}
end

evt.map[21] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[22] = evt.str[10]  -- "Bookcase"
evt.map[22] = function()
	evt.SetDoorState{Id = 23, State = 0}
	evt.SetDoorState{Id = 24, State = 0}
end

evt.map[23] = function()
	evt.SetDoorState{Id = 25, State = 0}
	evt.SetDoorState{Id = 26, State = 0}
end

evt.map[24] = function()
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 26, State = 1}
end

evt.map[25] = function()
	evt.SetDoorState{Id = 27, State = 0}
	evt.SetDoorState{Id = 28, State = 0}
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 7, FromX = -1136, FromY = 4480, FromZ = 29, ToX = 112, ToY = 4480, ToZ = 160}         -- "Blades"
end

evt.map[26] = function()
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 1}
end

evt.map[27] = function()
	evt.SetDoorState{Id = 29, State = 0}
	evt.SetDoorState{Id = 30, State = 0}
end

evt.map[28] = function()
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 30, State = 1}
end

evt.map[29] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.map[30] = function()
	evt.SetDoorState{Id = 31, State = 1}
end

evt.map[31] = function()
	evt.SetDoorState{Id = 32, State = 0}
end

evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	if not evt.Cmp("QBits", 217) then         -- Heart of Wood - I lost it
		evt.OpenChest(3)
		evt.Add("QBits", 217)         -- Heart of Wood - I lost it
	end
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[196] = evt.str[11]  -- "Wine Rack"
evt.map[196] = function()
	local i
	if evt.Cmp("MapVar4", 2) then
		return
	end
	i = Game.Rand() % 6
	if i == 2 then
		return
	elseif i == 3 or i == 4 then
		goto _12
	elseif i == 5 then
		goto _13
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.Add("Inventory", 223)         -- "Magic Potion"
	elseif i == 2 then
		evt.Add("Inventory", 227)         -- "Awaken"
	elseif i == 3 then
		evt.Add("Inventory", 228)         -- "Haste"
	elseif i == 4 then
		evt.Add("Inventory", 222)         -- "Cure Wounds"
	elseif i == 5 then
		evt.Add("Inventory", 238)         -- "Remove Curse"
	end
::_12::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_13::
	evt.Add("MapVar4", 1)
end

evt.map[197] = function()
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.map[198] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
end

evt.map[199] = function()
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
end

evt.map[200] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 2, FromX = 2240, FromY = 4336, FromZ = 215, ToX = 2240, ToY = 4336, ToZ = -64}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 2, FromX = 2464, FromY = 4032, FromZ = 215, ToX = 2464, ToY = 4336, ToZ = -64}         -- "Poison Spray"
end

evt.hint[452] = evt.str[10]  -- "Bookcase"
evt.map[452] = function()
	evt.StatusText(12)         -- "You see nothing of interest"
end

evt.hint[501] = evt.str[2]  -- "Leave the Mercenary Guild"
evt.map[501] = function()
	evt.MoveToMap{X = 17920, Y = 16803, Z = 3072, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out13.odm"}
end

