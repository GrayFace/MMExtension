local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Oracle Memory Crystal",
	[5] = "Exit",
	[6] = "Cylinder",
	[7] = "Supreme Temple of Baa",
	[8] = "Altar of Fire",
	[9] = "Trial by Fire",
	[10] = "Altar of Cold",
	[11] = "Trial by Cold",
	[12] = "Altar of Pain",
	[13] = "Trial by Pain",
	[14] = "Shrine of Fire",
	[15] = "+10 Fire resistance permanent.",
	[16] = "Shrine of Air",
	[17] = "+10 Electric resistance permanent.",
	[18] = "Shrine of Water",
	[19] = "+10 Cold resistance permanent.",
	[20] = "Shrine of Earth",
	[21] = "+10 Magic resistance permanent.",
	[22] = "You're not worthy!",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Supreme Temple of Baa"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[3]  -- "Switch"
evt.map[12] = function()
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[13] = evt.str[3]  -- "Switch"
evt.map[13] = function()
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[14] = evt.str[3]  -- "Switch"
evt.map[14] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[15] = evt.str[3]  -- "Switch"
evt.map[15] = function()
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.map[16] = function()
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[17] = evt.str[2]  -- "Chest"
evt.map[17] = function()
	evt.OpenChest(1)
end

evt.hint[18] = evt.str[2]  -- "Chest"
evt.map[18] = function()
	evt.OpenChest(2)
end

evt.hint[19] = evt.str[2]  -- "Chest"
evt.map[19] = function()
	evt.OpenChest(3)
end

evt.hint[20] = evt.str[2]  -- "Chest"
evt.map[20] = function()
	evt.OpenChest(4)
end

evt.hint[21] = evt.str[2]  -- "Chest"
evt.map[21] = function()
	evt.OpenChest(5)
end

evt.hint[22] = evt.str[2]  -- "Chest"
evt.map[22] = function()
	evt.OpenChest(6)
end

evt.hint[23] = evt.str[2]  -- "Chest"
evt.map[23] = function()
	evt.OpenChest(7)
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[24] = evt.str[2]  -- "Chest"
evt.map[24] = function()
	evt.OpenChest(8)
end

evt.map[30] = function()
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[31] = evt.str[6]  -- "Cylinder"
evt.map[31] = function()
	evt.Set("QBits", 176)         -- NPC
	evt.MoveToMap{X = -9110, Y = -5381, Z = 17, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 5, Name = "sewer.blv"}
end

evt.hint[32] = evt.str[4]  -- "Oracle Memory Crystal"
evt.map[32] = function()
	if not evt.Cmp("QBits", 53) then         -- 53 T6, Given when characters take the Oracle Crystal from the altar.
		evt.Set("QBits", 53)         -- 53 T6, Given when characters take the Oracle Crystal from the altar.
		evt.SetMessage(5)         -- "Exit"
		evt.SetSprite{SpriteId = 132, Visible = 1, Name = "crysdisc"}
		evt.Add("Inventory", 550)         -- "Memory Crystal Alpha"
		evt.Set("QBits", 191)         -- Quest item bits for seer
	end
end

evt.map[33] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 53) then         -- 53 T6, Given when characters take the Oracle Crystal from the altar.
		evt.SetSprite{SpriteId = 132, Visible = 1, Name = "crysdisc"}
	end
end

events.LoadMap = evt.map[33].last

evt.map[34] = function()
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 1000}
end

evt.hint[35] = evt.str[5]  -- "Exit"
evt.map[35] = function()
	evt.MoveToMap{X = -19914, Y = -18118, Z = 65, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outA3.odm"}
end

evt.map[36] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.Add("Inventory", 54)         -- "Death Mace"
	end
end

evt.map[37] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -416, Y = 416, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -576, Y = 0, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -416, Y = -416, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 0, Y = -576, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 416, Y = -416, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 576, Y = 0, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 416, Y = 416, Z = -1016}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 576, Z = -1016}
		evt.Set("MapVar1", 1)
	end
end

evt.hint[40] = evt.str[8]  -- "Altar of Fire"
evt.map[40] = function()
	if not evt.Cmp("QBits", 315) then         -- NPC
		evt.Set("QBits", 315)         -- NPC
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 75}
	end
	evt.StatusText(9)         -- "Trial by Fire"
end

evt.hint[41] = evt.str[10]  -- "Altar of Cold"
evt.map[41] = function()
	if not evt.Cmp("QBits", 316) then         -- NPC
		evt.Set("QBits", 316)         -- NPC
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Elec, Damage = 75}
	end
	evt.StatusText(11)         -- "Trial by Cold"
end

evt.hint[42] = evt.str[12]  -- "Altar of Pain"
evt.map[42] = function()
	if not evt.Cmp("QBits", 317) then         -- NPC
		evt.Set("QBits", 317)         -- NPC
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 75}
	end
	evt.StatusText(12)         -- "Altar of Pain"
end

evt.hint[43] = evt.str[14]  -- "Shrine of Fire"
evt.map[43] = function()
	if evt.Cmp("QBits", 318) then         -- NPC
		return
	end
	if evt.Cmp("QBits", 315) then         -- NPC
		if evt.Cmp("QBits", 316) then         -- NPC
			if evt.Cmp("QBits", 317) then         -- NPC
				evt.StatusText(15)         -- "+10 Fire resistance permanent."
				evt.Add("FireResistance", 10)
				evt.Set("QBits", 318)         -- NPC
				return
			end
		end
	end
	evt.StatusText(22)         -- "You're not worthy!"
end

evt.hint[44] = evt.str[16]  -- "Shrine of Air"
evt.map[44] = function()
	if evt.Cmp("QBits", 319) then         -- NPC
		return
	end
	if evt.Cmp("QBits", 315) then         -- NPC
		if evt.Cmp("QBits", 316) then         -- NPC
			if evt.Cmp("QBits", 317) then         -- NPC
				evt.StatusText(17)         -- "+10 Electric resistance permanent."
				evt.Add("ElecResistance", 10)
				evt.Set("QBits", 319)         -- NPC
				return
			end
		end
	end
	evt.StatusText(22)         -- "You're not worthy!"
end

evt.hint[45] = evt.str[18]  -- "Shrine of Water"
evt.map[45] = function()
	if evt.Cmp("QBits", 320) then         -- NPC
		return
	end
	if evt.Cmp("QBits", 315) then         -- NPC
		if evt.Cmp("QBits", 316) then         -- NPC
			if evt.Cmp("QBits", 317) then         -- NPC
				evt.StatusText(19)         -- "+10 Cold resistance permanent."
				evt.Add("ColdResistance", 10)
				evt.Set("QBits", 320)         -- NPC
				return
			end
		end
	end
	evt.StatusText(22)         -- "You're not worthy!"
end

evt.hint[46] = evt.str[20]  -- "Shrine of Earth"
evt.map[46] = function()
	if evt.Cmp("QBits", 321) then         -- NPC
		return
	end
	if evt.Cmp("QBits", 315) then         -- NPC
		if evt.Cmp("QBits", 316) then         -- NPC
			if evt.Cmp("QBits", 317) then         -- NPC
				evt.StatusText(21)         -- "+10 Magic resistance permanent."
				evt.Add("MagicResistance", 10)
				evt.Set("QBits", 321)         -- NPC
				return
			end
		end
	end
	evt.StatusText(22)         -- "You're not worthy!"
end

