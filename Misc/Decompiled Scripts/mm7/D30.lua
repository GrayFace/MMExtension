local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Lambent",
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
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Tapestry",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		goto _6
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if evt.Cmp("Counter10", 720) then
			evt.Subtract("QBits", 270)         -- Your friends are mad at you 
			evt.Set("MapVar4", 0)
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
			return
		end
		goto _6
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_7::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_6::
	evt.Set("MapVar4", 2)
	goto _7
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.map[6] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar0", 0)
	else
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetDoorState{Id = 12, State = 0}
		evt.SetDoorState{Id = 13, State = 0}
		evt.Set("MapVar0", 1)
	end
end

evt.map[7] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.map[8] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[11] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	if not evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
		evt.SetDoorState{Id = 13, State = 2}         -- switch state
	end
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 1, State = 0}
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
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 130) then         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
			evt.SetChestBit{ChestId = 7, Bit = const.ChestBits.Trapped, On = false}
			evt.OpenChest(7)
			evt.Add("QBits", 235)         -- Wetsuit - I lost it
			return
		end
		goto _7
	end
	if evt.Cmp("MapVar4", 2) then
		goto _7
	end
	evt.Set("MapVar4", 2)
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
::_8::
	evt.OpenChest(19)
	do return end
::_7::
	evt.SetChestBit{ChestId = 19, Bit = const.ChestBits.Trapped, On = false}
	goto _8
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 130) then         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
			evt.SetChestBit{ChestId = 8, Bit = const.ChestBits.Trapped, On = false}
			evt.OpenChest(8)
			evt.Add("QBits", 235)         -- Wetsuit - I lost it
			return
		end
		goto _7
	end
	if evt.Cmp("MapVar4", 2) then
		goto _7
	end
	evt.Set("MapVar4", 2)
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
::_8::
	evt.OpenChest(0)
	do return end
::_7::
	evt.SetChestBit{ChestId = 0, Bit = const.ChestBits.Trapped, On = false}
	goto _8
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

evt.hint[376] = evt.str[100]  -- ""
evt.map[376] = function()
	if not evt.Cmp("QBits", 199) then         -- Take the Associate's Tapestry
		if evt.Cmp("QBits", 99) then         -- Chose the path of Light
			if evt.Cmp("QBits", 182) then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
				evt.SetTexture{Facet = 10, Name = "cwb"}
				evt.Add("Inventory", 620)         -- "Big Tapestry"
				evt.Add("QBits", 199)         -- Take the Associate's Tapestry
				evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
				evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
				evt.Set("MapVar4", 2)
			end
		end
	end
end

evt.hint[377] = evt.str[100]  -- ""
evt.map[377] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 199) then         -- Take the Associate's Tapestry
		evt.SetTexture{Facet = 15, Name = "cwb"}
	end
end

events.LoadMap = evt.map[377].last

evt.house[416] = 182  -- "Throne Room"
evt.map[416] = function()
	if evt.Cmp("MapVar4", 2) then
		evt.StatusText(21)         -- "The Door is Locked"
	else
		evt.EnterHouse(182)         -- "Throne Room"
	end
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 1) then
			evt.SpeakNPC(279)         -- "Castle Guard"
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
			evt.Set("Counter10", 0)
			evt.Set("QBits", 270)         -- Your friends are mad at you 
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 0)
	end
end

evt.hint[501] = evt.str[2]  -- "Leave Castle Lambent"
evt.map[501] = function()
	evt.MoveToMap{X = -1264, Y = 19718, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

