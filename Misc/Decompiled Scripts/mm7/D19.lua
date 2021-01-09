local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Grand Temple of the Moon",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Drawer",
	[10] = "Bookcase",
	[11] = "Altar",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "You have Purified the Altar",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()  -- function events.LoadMap()
	evt.Set("MapVar0", 1)
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()  -- function events.LeaveMap()
	evt.ForPlayer("All")
::_2::
	if not evt.Cmp("Inventory", 341) then         -- "Telekinesis"
		return
	end
	evt.Subtract("Inventory", 341)         -- "Telekinesis"
	goto _2
end

events.LeaveMap = evt.map[2].last

evt.map[3] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.map[6] = function()
	if not evt.Cmp("MapVar0", 2) then
		evt.SetDoorState{Id = 8, State = 0}
		evt.SetDoorState{Id = 9, State = 0}
	end
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 13, State = 0}
end

evt.map[10] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[11] = evt.str[8]  -- "Switch"
evt.map[11] = function()
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 22, State = 0}
	evt.SetDoorState{Id = 23, State = 0}
end

evt.map[16] = function()
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[17] = evt.str[9]  -- "Drawer"
evt.map[17] = function()
	evt.SetDoorState{Id = 26, State = 0}
	evt.OpenChest(6)
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[19] = evt.str[4]  -- "Button"
evt.map[19] = function()
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 15, State = 0}
end

evt.map[20] = function()
	evt.Add("Inventory", 341)         -- "Telekinesis"
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.map[22] = function()
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 5, State = 0}
end

evt.map[23] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 50, State = 0}
end

evt.map[25] = function()
	evt.SetDoorState{Id = 52, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[7]  -- "Cabinet"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[7]  -- "Cabinet"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[7]  -- "Cabinet"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
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

evt.hint[196] = evt.str[10]  -- "Bookcase"
evt.map[196] = function()
	local i
	if evt.Cmp("MapVar49", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add("MapVar49", 1)
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
evt.map[197] = function()
	evt.StatusText(19)         -- ""
end

evt.hint[376] = evt.str[11]  -- "Altar"
evt.map[376] = function()
	if not evt.Cmp("QBits", 62) then         -- Purified the Altar of Evil.  Priest of Light promo quest.
		if evt.Cmp("QBits", 42) then         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Rebecca Devine in Celeste."
			evt.SetTexture{Facet = 20, Name = "T2BEDSHT"}
			evt.ForPlayer("All")
			evt.Set("QBits", 62)         -- Purified the Altar of Evil.  Priest of Light promo quest.
			evt.Add("QBits", 245)         -- "Congratulations"
			evt.Subtract("QBits", 245)         -- "Congratulations"
			evt.StatusText(15)         -- "You have Purified the Altar"
		end
	end
end

evt.map[451] = function()
	if evt.Cmp("MapVar0", 2) then
		evt.Set("MapVar0", 1)
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetDoorState{Id = 30, State = 1}
	else
		evt.Set("MapVar0", 2)
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetDoorState{Id = 30, State = 0}
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Grand Temple of the Moon"
evt.map[501] = function()
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 341)         -- "Telekinesis"
	evt.MoveToMap{X = 8472, Y = -3176, Z = 32, Direction = 1408, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out09.odm"}
end

