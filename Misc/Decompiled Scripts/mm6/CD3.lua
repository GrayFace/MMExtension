local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "The door won't budge",
	[4] = "Exit  ",
	[5] = "Empty",
	[6] = " Switch",
	[7] = "Memory crystal",
	[8] = "Guardian of Kriegspire",
	[9] = "The Guardian of Kriegspire proclaims, 'For 50,000 gold, the secret will be revealed!'",
	[10] = "Accept (Yes/No)?",
	[11] = "Yes",
	[12] = "Y",
	[13] = "Get Lost!",
	[14] = "Curator of Kriegspire",
	[15] = "The Curator of Kriegspire proclaims, 'For 10,000 gold you shall be healed.'",
	[16] = "Cage",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[17]  -- ""

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

evt.hint[5] = evt.str[1]  -- "Door"
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

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[8]  -- "Guardian of Kriegspire"
evt.map[13] = function()
	if not evt.Cmp("QBits", 340) then         -- NPC
		evt.SetMessage(9)         -- "The Guardian of Kriegspire proclaims, 'For 50,000 gold, the secret will be revealed!'"
		if not evt.Question{Question = 10, Answer1 = 11, Answer2 = 12} then         -- "Accept (Yes/No)?" ("Yes", "Y")
			evt.StatusText(13)         -- "Get Lost!"
			return
		end
		if not evt.Cmp("Gold", 50000) then
			evt.StatusText(13)         -- "Get Lost!"
			return
		end
		evt.Subtract("Gold", 50000)
	end
	evt.MoveToMap{X = 13487, Y = 3117, Z = 673, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[15] = function()
	evt.MoveToMap{X = 5773, Y = 5678, Z = -848, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[35]
evt.map[19] = function()
	evt.MoveToMap{X = -11534, Y = -9562, Z = 97, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB1.Odm"}
end

evt.hint[27] = evt.str[14]  -- "Curator of Kriegspire"
evt.map[27] = function()
	evt.SetMessage(15)         -- "The Curator of Kriegspire proclaims, 'For 10,000 gold you shall be healed.'"
	if not evt.Question{Question = 10, Answer1 = 11, Answer2 = 12} then         -- "Accept (Yes/No)?" ("Yes", "Y")
		evt.StatusText(13)         -- "Get Lost!"
	elseif evt.Cmp("Gold", 10000) then
		evt.Subtract("Gold", 10000)
		evt.ForPlayer("All")
		evt.Set("MainCondition", const.Condition.Cursed)
		evt.Add("HasFullHP", 0)
		evt.Add("HasFullSP", 0)
		evt.Subtract("ReputationIs", 500)
	else
		evt.StatusText(13)         -- "Get Lost!"
	end
end

evt.map[20] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 13458, Y = 3830, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 13458, Y = 4084, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 13458, Y = 4518, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 13054, Y = 4878, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 12677, Y = 4878, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 12364, Y = 4878, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 11991, Y = 4505, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 11991, Y = 4122, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 11991, Y = 3688, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 12424, Y = 3368, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 12776, Y = 3368, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 13182, Y = 3368, Z = 673}
		evt.Set("MapVar1", 1)
	end
end

evt.map[21] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 14033, Y = 4539, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 14033, Y = 4131, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 14033, Y = 3720, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 14444, Y = 3362, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 14779, Y = 3362, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 15195, Y = 3362, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 15548, Y = 3749, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 15548, Y = 4100, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 15548, Y = 4460, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 15142, Y = 4872, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 14765, Y = 4872, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 14361, Y = 4872, Z = 673}
		evt.Set("MapVar2", 1)
	end
end

evt.map[22] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 12990, Y = 1356, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 12454, Y = 1356, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 13482, Y = 1741, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 13482, Y = 2360, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 13000, Y = 2830, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 12414, Y = 2830, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 13147, Y = 2142, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 12388, Y = 2142, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 12750, Y = 2501, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 12750, Y = 1703, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 12441, Y = 1760, Z = 673}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 13115, Y = 2297, Z = 673}
		evt.Set("MapVar3", 1)
	end
end

evt.map[23] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 14373, Y = 2407, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 14373, Y = 1670, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 15056, Y = 1670, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 15056, Y = 2407, Z = 256}
		evt.Set("MapVar4", 1)
	end
end

evt.map[24] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.Add("Gold", 15000)
	end
end

evt.map[25] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 1)
		evt.Add("Gold", 15000)
	end
end

evt.hint[26] = evt.str[16]  -- "Cage"
evt.map[26] = function()
	if not evt.Cmp("MapVar8", 1) then
		evt.Add("Inventory", 545)         -- "Roland's Journal"
		evt.Set("MapVar8", 1)
	end
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 32, State = 1}
end

evt.hint[41] = evt.str[2]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(1)
end

evt.hint[42] = evt.str[2]  -- "Chest"
evt.map[42] = function()
	if not evt.Cmp("MapVar0", 1) then
		if evt.Cmp("QBits", 299) then         -- NPC
			evt.OpenChest(9)
			return
		end
	end
	evt.OpenChest(2)
	evt.Set("QBits", 299)         -- NPC
	evt.Set("MapVar0", 1)
end

evt.hint[43] = evt.str[2]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(3)
end

evt.hint[44] = evt.str[2]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(4)
end

evt.hint[45] = evt.str[2]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(5)
end

evt.map[46] = function()
	evt.MoveToMap{X = 6383, Y = 4644, Z = 222, Direction = 315, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[49] = evt.str[2]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(6)
end

evt.hint[50] = evt.str[2]  -- "Chest"
evt.map[50] = function()
	evt.OpenChest(7)
end

evt.hint[58] = evt.str[1]  -- "Door"
evt.map[58] = function()
	evt.StatusText(3)         -- "The door won't budge"
end

evt.hint[59] = evt.str[37]
evt.map[59] = function()
	evt.Set("MapVar7", 1)
	evt.SetDoorState{Id = 19, State = 1}
end

evt.map[60] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.SetDoorState{Id = 33, State = 1}
		evt.SetDoorState{Id = 34, State = 1}
	end
end

evt.map[61] = function()
	evt.MoveToMap{X = 9111, Y = 2540, Z = 121, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[62] = evt.str[38]
evt.map[62] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 104) then         -- CD3
		if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
			evt.SetSprite{SpriteId = 290, Visible = 1, Name = "crysdisc"}
			evt.ForPlayer("Current")
			evt.Add("Inventory", 553)         -- "Memory Crystal Epsilon"
			evt.Set("QBits", 104)         -- CD3
			evt.Set("QBits", 194)         -- Quest item bits for seer
		end
	end
end

evt.map[63] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 104) then         -- CD3
		if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
			return
		end
	end
	evt.SetSprite{SpriteId = 290, Visible = 1, Name = "crysdisc"}
end

events.LoadMap = evt.map[63].last

