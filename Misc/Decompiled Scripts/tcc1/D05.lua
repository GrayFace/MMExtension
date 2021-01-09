local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Door",
	[3] = "Lever",
	[4] = "Gold vein",
	[5] = "Gems",
	[6] = "Cave-in!",
	[7] = "Orpheus’s Gateway ",
	[8] = "Black liquid filled barrel",
	[9] = "Old bones",
	[10] = "Glowing dinosaur bones",
	[11] = "Elevator platform",
	[12] = "Gateway Door",
	[13] = "",
	[14] = "",
	[15] = "Chest",
	[16] = "",
	[17] = "",
	[18] = "The door will not budge",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "Bones",
	[25] = "The bones feel weird (+5 Poison resistance permanent)",
	[26] = "The bones feel weird (+5 Magic resistance permanent)",
	[27] = "No effect",
	[28] = "Only the Horn of Vainen can open the Gateway.",
	[29] = "You blow the Horn of Vainen and the Gateway opens.",
	[30] = "Exit",
	[31] = "The bones feel weird (+5 Might permanent)",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[7]  -- "Orpheus’s Gateway "

evt.hint[3] = evt.str[1]  -- "Switch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[4] = evt.str[10]  -- "Glowing dinosaur bones"
evt.map[4] = function()
	evt.MoveToMap{X = 1576, Y = -1921, Z = 1, Direction = 44, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[6] = evt.str[3]  -- "Lever"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[15]  -- "Chest"
evt.map[8] = function()
	evt.OpenChest(0)
end

evt.hint[9] = evt.str[12]  -- "Gateway Door"
evt.map[9] = function()
	if not evt.Cmp("QBits", 397) then         -- Orpheus Gateway once
		if evt.Cmp("Inventory", 435) then         -- "Horn of Vainen"
			evt.SetDoorState{Id = 9, State = 1}
			evt.StatusText(29)         -- "You blow the Horn of Vainen and the Gateway opens."
			evt.Subtract("Inventory", 1)         -- "Longsword"
			evt.Add("QBits", 397)         -- Orpheus Gateway once
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 387, Y = 8721, Z = 257}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = 420, Y = 8538, Z = 257}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 44, Y = 8517, Z = 247}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = -208, Y = 8507, Z = 257}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -455, Y = 8588, Z = 247}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = -556, Y = 8573, Z = 257}
			evt.Set("QBits", 454)         -- Opened the Gateway
		else
			evt.StatusText(28)         -- "Only the Horn of Vainen can open the Gateway."
		end
	end
end

evt.hint[10] = evt.str[4]  -- "Gold vein"
evt.map[10] = function()
	local i
	if not evt.Cmp("MapVar11", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 204, Name = "T3LL6"}
			evt.Set("MapVar11", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 204, Name = "T3LL6"}
			evt.Set("MapVar11", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 204, Name = "T3LL6"}
			evt.Set("MapVar11", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 204, Name = "T3LL6"}
			evt.Set("MapVar11", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 204, Name = "T3LL6"}
			evt.Set("MapVar11", 1)
		end
	end
end

evt.hint[11] = evt.str[4]  -- "Gold vein"
evt.map[11] = function()
	local i
	if not evt.Cmp("MapVar12", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 207, Name = "T3LL6"}
			evt.Set("MapVar12", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 207, Name = "T3LL6"}
			evt.Set("MapVar12", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 207, Name = "T3LL6"}
			evt.Set("MapVar12", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 207, Name = "T3LL6"}
			evt.Set("MapVar12", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 207, Name = "T3LL6"}
			evt.Set("MapVar12", 1)
		end
	end
end

evt.hint[12] = evt.str[4]  -- "Gold vein"
evt.map[12] = function()
	local i
	if not evt.Cmp("MapVar13", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 12, Name = "T3LL6"}
			evt.Set("MapVar13", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 12, Name = "T3LL6"}
			evt.Set("MapVar13", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 12, Name = "T3LL6"}
			evt.Set("MapVar13", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 12, Name = "T3LL6"}
			evt.Set("MapVar13", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 12, Name = "T3LL6"}
			evt.Set("MapVar13", 1)
		end
	end
end

evt.hint[13] = evt.str[4]  -- "Gold vein"
evt.map[13] = function()
	local i
	if not evt.Cmp("MapVar14", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 624, Name = "T3LL6"}
			evt.Set("MapVar14", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 624, Name = "T3LL6"}
			evt.Set("MapVar14", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 624, Name = "T3LL6"}
			evt.Set("MapVar14", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 624, Name = "T3LL6"}
			evt.Set("MapVar14", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 624, Name = "T3LL6"}
			evt.Set("MapVar14", 1)
		end
	end
end

evt.hint[14] = evt.str[4]  -- "Gold vein"
evt.map[14] = function()
	local i
	if not evt.Cmp("MapVar15", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 612, Name = "T3LL6"}
			evt.Set("MapVar15", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 612, Name = "T3LL6"}
			evt.Set("MapVar15", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 612, Name = "T3LL6"}
			evt.Set("MapVar15", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 612, Name = "T3LL6"}
			evt.Set("MapVar15", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 612, Name = "T3LL6"}
			evt.Set("MapVar15", 1)
		end
	end
end

evt.hint[21] = evt.str[8]  -- "Black liquid filled barrel"
evt.map[21] = function()
	evt.Add("PoisonedRed", 3)
	evt.StatusText(14)         -- ""
end

evt.hint[22] = evt.str[8]  -- "Black liquid filled barrel"
evt.map[22] = function()
	evt.Add("PoisonedRed", 3)
	evt.StatusText(14)         -- ""
end

evt.hint[23] = evt.str[8]  -- "Black liquid filled barrel"
evt.map[23] = function()
	evt.Add("PoisonedYellow", 3)
	evt.StatusText(14)         -- ""
end

evt.hint[25] = evt.str[10]  -- "Glowing dinosaur bones"
evt.map[25] = function()
	if not evt.Cmp("MapVar7", 1) then
		if not evt.Cmp("BaseMight", 40) then
			evt.Add("MapVar7", 1)
			evt.Add("BaseMight", 5)
			evt.StatusText(31)         -- "The bones feel weird (+5 Might permanent)"
			evt.FaceExpression{Player = "Current", Frame = 52}
			return
		end
	end
	evt.StatusText(27)         -- "No effect"
end

evt.hint[26] = evt.str[4]  -- "Gold vein"
evt.map[26] = function()
	local i
	if not evt.Cmp("MapVar19", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 143, Name = "T3LL6"}
			evt.Set("MapVar19", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 1000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 143, Name = "T3LL6"}
			evt.Set("MapVar19", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 143, Name = "T3LL6"}
			evt.Set("MapVar19", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 143, Name = "T3LL6"}
			evt.Set("MapVar19", 1)
		else
			evt.Add("GoldAddRandom", 400)
			evt.SetTexture{Facet = 143, Name = "T3LL6"}
			evt.Set("MapVar19", 1)
		end
	end
end

evt.hint[28] = evt.str[5]  -- "Gems"
evt.map[28] = function()
	local i
	if not evt.Cmp("MapVar16", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 124, Name = "T3LL6"}
			evt.Set("MapVar16", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 2000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 124, Name = "T3LL6"}
			evt.Set("MapVar16", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 1200)
			evt.SetTexture{Facet = 124, Name = "T3LL6"}
			evt.Set("MapVar16", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 124, Name = "T3LL6"}
			evt.Set("MapVar16", 1)
		else
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 124, Name = "T3LL6"}
			evt.Set("MapVar16", 1)
		end
	end
end

evt.hint[29] = evt.str[5]  -- "Gems"
evt.map[29] = function()
	local i
	if not evt.Cmp("MapVar17", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 132, Name = "T3LL6"}
			evt.Set("MapVar17", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 2000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 132, Name = "T3LL6"}
			evt.Set("MapVar17", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 1200)
			evt.SetTexture{Facet = 132, Name = "T3LL6"}
			evt.Set("MapVar17", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 132, Name = "T3LL6"}
			evt.Set("MapVar17", 1)
		else
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 132, Name = "T3LL6"}
			evt.Set("MapVar17", 1)
		end
	end
end

evt.hint[30] = evt.str[5]  -- "Gems"
evt.map[30] = function()
	local i
	if not evt.Cmp("MapVar18", 1) then
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 135, Name = "T3LL6"}
			evt.Set("MapVar18", 1)
		elseif i == 3 then
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 20}
			evt.Add("Gold", 2000)
			evt.StatusText(6)         -- "Cave-in!"
			evt.SetTexture{Facet = 135, Name = "T3LL6"}
			evt.Set("MapVar18", 1)
		elseif i == 4 then
			evt.Add("GoldAddRandom", 1200)
			evt.SetTexture{Facet = 135, Name = "T3LL6"}
			evt.Set("MapVar18", 1)
		elseif i == 5 then
			evt.Add("GoldAddRandom", 800)
			evt.SetTexture{Facet = 135, Name = "T3LL6"}
			evt.Set("MapVar18", 1)
		else
			evt.Add("GoldAddRandom", 600)
			evt.SetTexture{Facet = 135, Name = "T3LL6"}
			evt.Set("MapVar18", 1)
		end
	end
end

evt.hint[31] = evt.str[18]  -- "The door will not budge"
evt.map[31] = function()
	evt.StatusText(18)         -- "The door will not budge"
end

evt.hint[32] = evt.str[24]  -- "Bones"
evt.map[32] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.StatusText(27)         -- "No effect"
	else
		evt.Add("MapVar9", 1)
		evt.Add("PoisonResistance", 5)
		evt.StatusText(25)         -- "The bones feel weird (+5 Poison resistance permanent)"
	end
end

evt.hint[33] = evt.str[24]  -- "Bones"
evt.map[33] = function()
	if evt.Cmp("MapVar10", 1) then
		evt.StatusText(27)         -- "No effect"
	else
		evt.Add("MapVar10", 1)
		evt.Add("MagicResistance", 5)
		evt.StatusText(26)         -- "The bones feel weird (+5 Magic resistance permanent)"
	end
end

evt.map[35] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar11", 1) then
		evt.SetTexture{Facet = 204, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar12", 1) then
		evt.SetTexture{Facet = 207, Name = "t3ll6"}
	end
	evt.Cmp("MapVar13", 1)
	if evt.Cmp("MapVar14", 1) then
		evt.SetTexture{Facet = 624, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 612, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar19", 1) then
		evt.SetTexture{Facet = 143, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar16", 1) then
		evt.SetTexture{Facet = 124, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar17", 1) then
		evt.SetTexture{Facet = 132, Name = "t3ll6"}
	end
	if evt.Cmp("MapVar18", 1) then
		evt.SetTexture{Facet = 135, Name = "t3ll6"}
	end
end

events.LoadMap = evt.map[35].last

evt.hint[50] = evt.str[30]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -17962, Y = 20974, Z = 1, Direction = 1152, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC3.Odm"}
end

evt.map[51] = function()
	local i
	if not evt.Cmp("MapVar24", 1) then
		evt.Set("MapVar24", 1)
		i = Game.Rand() % 3
		if i == 1 then
			evt.GiveItem{Strength = 5, Type = const.ItemType.Ring_, Id = 0}
		elseif i == 2 then
			evt.GiveItem{Strength = 5, Type = const.ItemType.Weapon_, Id = 0}
		else
			evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
		end
	end
end

