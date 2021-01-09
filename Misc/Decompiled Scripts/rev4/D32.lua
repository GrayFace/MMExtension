local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Navan",
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
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "Enter the Throne Room",
	[21] = "The Door is Locked",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("MapVar4", 2) then
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return
		end
		evt.Set("MapVar4", 2)
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.map[4] = function()
	if evt.Cmp("QBits", 35) then         -- "Raid the Elven Treasury at Castle Navan in the Tularean Forest and return to Frederick Org in Erathia."
		evt.SetDoorState{Id = 7, State = 0}
	end
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.SetDoorState{Id = 14, State = 0}
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 16, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 18, State = 0}
end

evt.map[11] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
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
	local i
	if evt.Cmp("MapVar50", 1) then
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
	evt.Add("MapVar50", 1)
end

evt.hint[198] = evt.str[10]  -- "Bookcase"
evt.map[198] = function()
	local i
	if evt.Cmp("MapVar51", 1) then
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
	evt.Add("MapVar51", 1)
end

evt.hint[199] = evt.str[10]  -- "Bookcase"
evt.map[199] = function()
	evt.StatusText(19)         -- ""
end

evt.hint[376] = evt.str[100]  -- ""
evt.map[376] = function()
	if not evt.Cmp("QBits", 60) then         -- Robbed Elven treasury.  Black Knight promo quest.
		evt.ForPlayer("All")
		evt.Set("QBits", 60)         -- Robbed Elven treasury.  Black Knight promo quest.
	end
end

evt.house[416] = 178  -- "Throne Room"
evt.map[416] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		if not evt.Cmp("MapVar4", 2) then
			evt.EnterHouse(178)         -- "Throne Room"
			return
		end
	end
	evt.StatusText(21)         -- "The Door is Locked"
	evt.FaceAnimation{Player = "Current", Animation = 18}
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 1) then
			evt.SpeakNPC(278)         -- "Castle Guard"
			evt.Set("MapVar4", 1)
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 2) then
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
			evt.Set("MapVar4", 2)
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 2) then
			evt.Set("MapVar4", 0)
		end
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()  -- RefillTimer(<function>, const.Month, true)
	evt.Set("MapVar4", 0)
end

RefillTimer(evt.map[454].last, const.Month, true)

evt.hint[501] = evt.str[2]  -- "Leave Castle Navan"
evt.map[501] = function()
	evt.MoveToMap{X = -18532, Y = -10251, Z = 1537, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out04.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Castle Navan"
