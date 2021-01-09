local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Switch",
	[3] = "Double Door",
	[4] = "Chest",
	[5] = "Cabinet",
	[6] = "Bookshelves",
	[7] = "You thumb through the books, but find nothing of interest.",
	[8] = "The Door is Locked",
	[9] = "Exit",
	[10] = "Pool",
	[11] = "+10 Hit points restored.",
	[12] = "+10 Spell points restored.",
	[13] = "Refreshing!",
	[14] = "You are not smart enough!",
	[15] = "Glastonbury Tor",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[15]  -- "Glastonbury Tor"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	if evt.Cmp("Inventory", 572) then         -- "Cell Key"
		evt.SetDoorState{Id = 2, State = 1}
		evt.Subtract("Inventory", 572)         -- "Cell Key"
	else
		evt.StatusText(8)         -- "The Door is Locked"
	end
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 3, State = 1}
	else
		evt.StatusText(8)         -- "The Door is Locked"
	end
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 4, State = 1}
	else
		evt.StatusText(8)         -- "The Door is Locked"
	end
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[3]  -- "Double Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	if evt.Cmp("CurrentIntellect", 40) then
		evt.SetDoorState{Id = 9, State = 1}
	else
		evt.ForPlayer("All")
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 30}
		evt.StatusText(14)         -- "You are not smart enough!"
	end
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

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
end

evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[3]  -- "Double Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
end

evt.hint[26] = evt.str[1]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 26, State = 1}
end

evt.hint[27] = evt.str[5]  -- "Cabinet"
evt.map[27] = function()
	evt.OpenChest(1)
	evt.Set("MapVar0", 1)
	if not evt.Cmp("MapVar19", 1) then
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -1280, Y = 3200, Z = 30}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1920, Y = 2688, Z = 30}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -2560, Y = 2944, Z = 30}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -1792, Y = 3584, Z = 0}
		evt.Set("MapVar19", 1)
	end
end

evt.hint[28] = evt.str[5]  -- "Cabinet"
evt.map[28] = function()
	evt.OpenChest(2)
end

evt.hint[29] = evt.str[5]  -- "Cabinet"
evt.map[29] = function()
	evt.OpenChest(3)
end

evt.hint[30] = evt.str[5]  -- "Cabinet"
evt.map[30] = function()
	evt.OpenChest(4)
end

evt.hint[31] = evt.str[5]  -- "Cabinet"
evt.map[31] = function()
	evt.OpenChest(5)
end

evt.hint[32] = evt.str[4]  -- "Chest"
evt.map[32] = function()
	evt.OpenChest(6)
end

evt.hint[33] = evt.str[4]  -- "Chest"
evt.map[33] = function()
	evt.OpenChest(7)
end

evt.hint[34] = evt.str[4]  -- "Chest"
evt.map[34] = function()
	evt.OpenChest(8)
end

evt.hint[35] = evt.str[4]  -- "Chest"
evt.map[35] = function()
	evt.OpenChest(9)
end

evt.hint[36] = evt.str[5]  -- "Cabinet"
evt.map[36] = function()
	evt.OpenChest(10)
end

evt.hint[37] = evt.str[5]  -- "Cabinet"
evt.map[37] = function()
	evt.OpenChest(11)
end

evt.hint[39] = evt.str[6]  -- "Bookshelves"
evt.hint[40] = evt.str[6]  -- "Bookshelves"
evt.map[40] = function()
	evt.StatusText(7)         -- "You thumb through the books, but find nothing of interest."
	evt.FaceExpression{Player = "Current", Frame = 39}
end

evt.map[41] = function()
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = 10054, Y = 3290, Z = -511}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = 10065, Y = 2200, Z = -511}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 10060, Y = 2220, Z = -511}
end

evt.hint[50] = evt.str[9]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 16637, Y = -12300, Z = 705, Direction = 32, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC2.Odm"}
end

evt.map[60] = function()  -- Timer(<function>, const.Day, 1*const.Second)
	evt.Set("MapVar49", 20)
	evt.Set("MapVar50", 20)
end

Timer(evt.map[60].last, const.Day, 1*const.Second)

evt.hint[61] = evt.str[10]  -- "Pool"
evt.map[61] = function()
	if evt.Cmp("MapVar49", 1) then
		evt.Subtract("MapVar49", 1)
		evt.Add("HP", 10)
		evt.StatusText(11)         -- "+10 Hit points restored."
	else
		evt.StatusText(13)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 94)         -- "10 Hit points cured by the right side pool in Snergle's Iron Mines."
end

evt.hint[62] = evt.str[10]  -- "Pool"
evt.map[62] = function()
	if evt.Cmp("MapVar50", 1) then
		evt.Subtract("MapVar50", 1)
		evt.Add("SP", 10)
		evt.StatusText(12)         -- "+10 Spell points restored."
	else
		evt.StatusText(13)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 95)         -- "10 Spell points restored by the left side pool in Snergle's Iron Mines."
end

evt.map[63] = function()
	evt.SetDoorState{Id = 27, State = 1}
end

evt.hint[64] = evt.str[6]  -- "Bookshelves"
evt.map[64] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Add("Inventory", 300)         -- "Torch Light"
		evt.Set("MapVar1", 1)
	end
end

evt.hint[65] = evt.str[6]  -- "Bookshelves"
evt.map[65] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Add("Inventory", 301)         -- "Flame Arrow"
		evt.Set("MapVar2", 1)
	end
end

evt.hint[66] = evt.str[6]  -- "Bookshelves"
evt.map[66] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Add("Inventory", 302)         -- "Protection from Fire"
		evt.Set("MapVar3", 1)
	end
end

evt.hint[67] = evt.str[6]  -- "Bookshelves"
evt.map[67] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Add("Inventory", 311)         -- "Wizard Eye"
		evt.Set("MapVar4", 1)
	end
end

evt.hint[68] = evt.str[6]  -- "Bookshelves"
evt.map[68] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Add("Inventory", 312)         -- "Static Charge"
		evt.Set("MapVar5", 1)
	end
end

evt.hint[69] = evt.str[6]  -- "Bookshelves"
evt.map[69] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Add("Inventory", 313)         -- "Protection from Elec"
		evt.Set("MapVar6", 1)
	end
end

evt.hint[70] = evt.str[6]  -- "Bookshelves"
evt.map[70] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.Add("Inventory", 322)         -- "Awaken"
		evt.Set("MapVar7", 1)
	end
end

evt.hint[71] = evt.str[6]  -- "Bookshelves"
evt.map[71] = function()
	if not evt.Cmp("MapVar8", 1) then
		evt.Add("Inventory", 323)         -- "Cold Beam"
		evt.Set("MapVar8", 1)
	end
end

evt.hint[72] = evt.str[6]  -- "Bookshelves"
evt.map[72] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.Add("Inventory", 324)         -- "Protection from Cold"
		evt.Set("MapVar9", 1)
	end
end

evt.hint[73] = evt.str[6]  -- "Bookshelves"
evt.map[73] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.Add("Inventory", 366)         -- "Cure Weakness"
		evt.Set("MapVar10", 1)
	end
end

evt.hint[74] = evt.str[6]  -- "Bookshelves"
evt.map[74] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.Add("Inventory", 367)         -- "First Aid"
		evt.Set("MapVar11", 1)
	end
end

evt.hint[75] = evt.str[6]  -- "Bookshelves"
evt.map[75] = function()
	if not evt.Cmp("MapVar12", 1) then
		evt.Add("Inventory", 368)         -- "Protection from Poison"
		evt.Set("MapVar12", 1)
	end
end

evt.hint[76] = evt.str[6]  -- "Bookshelves"
evt.map[76] = function()
	if not evt.Cmp("MapVar13", 1) then
		evt.Add("Inventory", 348)         -- "Remove Curse"
		evt.Set("MapVar13", 1)
	end
end

evt.hint[77] = evt.str[5]  -- "Cabinet"
evt.map[77] = function()
	evt.OpenChest(12)
end

