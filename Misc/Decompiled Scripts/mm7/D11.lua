local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Walls of Mist",
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
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.Set("MapVar18", 0)
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
end

evt.map[4] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 0)
		evt.Set("MapVar1", 1)
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
		evt.Set("MapVar1", 0)
		evt.Set("MapVar4", 1)
	end
end

evt.map[5] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.Subtract("MapVar5", 1)
		evt.Subtract("MapVar0", 1)
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
		evt.Add("MapVar5", 1)
	end
end

evt.map[6] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 0)
		evt.Set("MapVar1", 1)
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.Set("MapVar1", 0)
		evt.Set("MapVar6", 1)
	end
end

evt.map[7] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.Set("MapVar7", 0)
		evt.Set("MapVar1", 1)
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
		evt.Set("MapVar1", 0)
		evt.Set("MapVar7", 1)
	end
end

evt.map[8] = function()
	if evt.Cmp("MapVar8", 1) then
		evt.Subtract("MapVar8", 1)
		evt.Subtract("MapVar0", 1)
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
		evt.Add("MapVar8", 1)
	end
end

evt.map[9] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 0)
		evt.Set("MapVar1", 1)
		evt.SetDoorState{Id = 10, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 10, State = 2}         -- switch state
		evt.Set("MapVar1", 0)
		evt.Set("MapVar9", 1)
	end
end

evt.map[10] = function()
	if not evt.Cmp("MapVar1", 1) then
		if evt.Cmp("MapVar4", 1) then
			return
		end
		if evt.Cmp("MapVar6", 1) then
			return
		end
		if evt.Cmp("MapVar9", 1) then
			return
		end
	end
	if evt.Cmp("MapVar0", 2) then
		evt.SetDoorState{Id = 3, State = 2}         -- switch state
		evt.SetDoorState{Id = 4, State = 2}         -- switch state
		evt.SetDoorState{Id = 11, State = 2}         -- switch state
		evt.Set("MapVar0", 0)
		evt.Set("MapVar5", 0)
		evt.Set("MapVar8", 0)
	end
end

evt.map[11] = function()
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
end

evt.map[12] = function()
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
end

evt.map[151] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.map[152] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if not evt.Cmp("MapVar98", 1) then
		if not evt.Cmp("QBits", 48) then         -- "Retrieve the lich jars from the Proving Grounds in Celeste and bring them back to Halfgild Wynac in the Pit."
			evt.OpenChest(1)
			return
		end
	end
	evt.OpenChest(0)
	evt.Set("MapVar98", 1)
	evt.Add("QBits", 148)         -- Got Lich Jar from Walls of Mist
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
	evt.Subtract("QBits", 229)         -- Lich Jar (Empty) - I lost it
end

evt.map[376] = function()
	if evt.Cmp("MapVar15", 1) then
		return
	end
	if evt.Cmp("Inventory", 652) then         -- "West Pillar Key"
		evt.Subtract("Inventory", 652)         -- "West Pillar Key"
		evt.SetDoorState{Id = 31, State = 2}         -- switch state
		evt.Set("MapVar15", 1)
		evt.Add("MapVar18", 1)
		if not evt.Cmp("MapVar18", 3) then
			return
		end
	elseif not evt.Cmp("MapVar18", 3) then
		return
	end
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[377] = function()
	if evt.Cmp("MapVar16", 1) then
		return
	end
	if evt.Cmp("Inventory", 653) then         -- "Central Pillar Key"
		evt.Subtract("Inventory", 653)         -- "Central Pillar Key"
		evt.SetDoorState{Id = 32, State = 2}         -- switch state
		evt.Set("MapVar16", 1)
		evt.Add("MapVar18", 1)
		if not evt.Cmp("MapVar18", 3) then
			return
		end
	elseif not evt.Cmp("MapVar18", 3) then
		return
	end
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[378] = function()
	if evt.Cmp("MapVar17", 1) then
		return
	end
	if evt.Cmp("Inventory", 654) then         -- "East Pillar Key"
		evt.Subtract("Inventory", 654)         -- "East Pillar Key"
		evt.SetDoorState{Id = 33, State = 2}         -- switch state
		evt.Set("MapVar17", 1)
		evt.Add("MapVar18", 1)
		if not evt.Cmp("MapVar18", 3) then
			return
		end
	elseif not evt.Cmp("MapVar18", 3) then
		return
	end
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[452] = function()
	evt.MoveToMap{X = -10880, Y = 7424, Z = 96, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[453] = function()
	evt.MoveToMap{X = -1792, Y = -128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[454] = function()
	evt.MoveToMap{X = -896, Y = -128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[455] = function()
	evt.MoveToMap{X = 8448, Y = -21120, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[456] = function()
	evt.MoveToMap{X = 13568, Y = -6528, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[457] = function()
	evt.MoveToMap{X = 1, Y = -128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[458] = function()
	evt.MoveToMap{X = 13280, Y = 1152, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[459] = function()
	evt.MoveToMap{X = 13312, Y = 704, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[460] = function()
	evt.MoveToMap{X = 13248, Y = 2976, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[461] = function()
	evt.MoveToMap{X = 13248, Y = 3456, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[462] = function()
	evt.MoveToMap{X = 12384, Y = 2144, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[463] = function()
	evt.MoveToMap{X = 11936, Y = 2144, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[464] = function()
	evt.MoveToMap{X = 14240, Y = 2048, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[465] = function()
	evt.MoveToMap{X = 14944, Y = 2080, Z = 160, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[466] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.IsWater, On = true}
		evt.SetTexture{Facet = 1, Name = "wtrtyl"}
		evt.SetDoorState{Id = 17, State = 2}         -- switch state
		evt.Add("MapVar11", 1)
		if not evt.Cmp("MapVar10", 1) then
			evt.SetDoorState{Id = 24, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif not evt.Cmp("MapVar10", 2) then
			evt.SetDoorState{Id = 25, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif evt.Cmp("MapVar10", 3) then
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
			evt.SetDoorState{Id = 27, State = 2}         -- switch state
		else
			evt.SetDoorState{Id = 26, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		end
	end
end

evt.map[467] = function()
	if not evt.Cmp("MapVar12", 1) then
		evt.SetDoorState{Id = 18, State = 2}         -- switch state
		evt.SetFacetBit{Id = 2, Bit = const.FacetBits.IsWater, On = true}
		evt.SetTexture{Facet = 2, Name = "wtrtyl"}
		evt.SetDoorState{Id = 19, State = 2}         -- switch state
		evt.Add("MapVar12", 1)
		if not evt.Cmp("MapVar10", 1) then
			evt.SetDoorState{Id = 24, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif not evt.Cmp("MapVar10", 2) then
			evt.SetDoorState{Id = 25, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif evt.Cmp("MapVar10", 3) then
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
			evt.SetDoorState{Id = 27, State = 2}         -- switch state
		else
			evt.SetDoorState{Id = 26, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		end
	end
end

evt.map[468] = function()
	if not evt.Cmp("MapVar13", 1) then
		evt.SetDoorState{Id = 20, State = 2}         -- switch state
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.IsWater, On = true}
		evt.SetTexture{Facet = 3, Name = "wtrtyl"}
		evt.SetDoorState{Id = 21, State = 2}         -- switch state
		evt.Add("MapVar13", 1)
		if not evt.Cmp("MapVar10", 1) then
			evt.SetDoorState{Id = 24, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif not evt.Cmp("MapVar10", 2) then
			evt.SetDoorState{Id = 25, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif evt.Cmp("MapVar10", 3) then
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
			evt.SetDoorState{Id = 27, State = 2}         -- switch state
		else
			evt.SetDoorState{Id = 26, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		end
	end
end

evt.map[469] = function()
	if not evt.Cmp("MapVar14", 1) then
		evt.SetDoorState{Id = 22, State = 2}         -- switch state
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.IsWater, On = true}
		evt.SetTexture{Facet = 4, Name = "wtrtyl"}
		evt.SetDoorState{Id = 23, State = 2}         -- switch state
		evt.Add("MapVar14", 1)
		if not evt.Cmp("MapVar10", 1) then
			evt.SetDoorState{Id = 24, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif not evt.Cmp("MapVar10", 2) then
			evt.SetDoorState{Id = 25, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		elseif evt.Cmp("MapVar10", 3) then
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
			evt.SetDoorState{Id = 27, State = 2}         -- switch state
		else
			evt.SetDoorState{Id = 26, State = 2}         -- switch state
			evt.Add("MapVar10", 1)
		end
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Walls of Mist"
evt.map[501] = function()
	evt.MoveToMap{X = 1728, Y = 3648, Z = 97, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Walls of Mist"
evt.map[502] = function()
	if not evt.CheckMonstersKilled{CheckType = 1, Id = 1, Count = 1} then
		evt.ForPlayer("All")
		evt.Set("QBits", 102)         -- Completed Proving Grounds without killing a single creature
	end
	evt.MoveToMap{X = 1728, Y = 3648, Z = 97, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

