local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Wine Cellar",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Altar",
	[10] = "Wine Rack",
	[11] = "",
	[12] = "",
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

evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		evt.Set("QBits", 107)         -- Slayed the vampire
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[100]  -- ""
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[4] = evt.str[4]  -- "Button"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[7] = evt.str[10]  -- "Wine Rack"
evt.map[7] = function()
	evt.SetDoorState{Id = 1, State = 1}
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
	evt.OpenChest(3)
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

evt.hint[196] = evt.str[10]  -- "Wine Rack"
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

evt.hint[501] = evt.str[2]  -- "Leave the Wine Cellar"
evt.map[501] = function()
	evt.Set("QBits", 107)         -- Slayed the vampire
	evt.MoveToMap{X = 8216, Y = -10619, Z = 289, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out13.odm"}
end

