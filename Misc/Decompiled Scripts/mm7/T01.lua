local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Temple of Light",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Altar",
	[10] = "Bookcase",
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
	if not evt.Cmp("MapVar4", 2) then
		if evt.Cmp("QBits", 99) then         -- Chose the path of Light
			return
		end
		evt.Set("MapVar4", 2)
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.Subtract("MapVar3", 1)
		evt.SetDoorState{Id = 5, State = 0}
	else
		evt.Add("MapVar3", 1)
		evt.SetDoorState{Id = 5, State = 1}
	end
end

evt.map[4] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
	evt.Set("MapVar0", 1)
end

evt.map[5] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Subtract("MapVar9", 1)
		evt.SetDoorState{Id = 7, State = 0}
	else
		evt.Add("MapVar9", 1)
		evt.SetDoorState{Id = 7, State = 1}
	end
end

evt.map[6] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
	evt.Set("MapVar1", 1)
end

evt.map[7] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.Subtract("MapVar5", 1)
		evt.SetDoorState{Id = 9, State = 0}
	else
		evt.SetDoorState{Id = 9, State = 1}
		evt.Add("MapVar5", 1)
	end
end

evt.map[8] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.Subtract("MapVar6", 1)
		evt.SetDoorState{Id = 10, State = 0}
	else
		evt.SetDoorState{Id = 10, State = 1}
		evt.Add("MapVar6", 1)
	end
end

evt.map[9] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.Subtract("MapVar7", 1)
		evt.SetDoorState{Id = 11, State = 0}
	else
		evt.SetDoorState{Id = 11, State = 1}
		evt.Add("MapVar7", 1)
	end
end

evt.map[10] = function()
	if evt.Cmp("MapVar8", 1) then
		evt.Subtract("MapVar8", 1)
		evt.SetDoorState{Id = 12, State = 0}
	else
		evt.SetDoorState{Id = 12, State = 1}
		evt.Add("MapVar8", 1)
	end
end

evt.map[11] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.Set("MapVar2", 1)
end

evt.hint[12] = evt.str[9]  -- "Altar"
evt.map[12] = function()
	if evt.Cmp("MapVar0", 1) then
		if evt.Cmp("MapVar1", 1) then
			if evt.Cmp("MapVar2", 1) then
				evt.SetDoorState{Id = 14, State = 2}         -- switch state
			end
		end
	end
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetChestBit{ChestId = 0, Bit = const.ChestBits.Trapped, On = false}
	elseif not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
	evt.OpenChest(1)
	evt.Add("QBits", 232)         -- Altar Piece (Good) - I lost it
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
	evt.OpenChest(20)
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.SpeakNPC(275)         -- "Guard"
		evt.Set("MapVar4", 1)
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 0)
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[501] = evt.str[2]  -- "Leave the Temple of Light"
evt.map[501] = function()
	evt.MoveToMap{X = -5779, Y = 15131, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

