local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "The door is locked.",
	[5] = "The door is locked.",
	[6] = "The door is locked.",
	[7] = "Zap!",
	[8] = "The door is locked.",
	[9] = "The door is locked.",
	[10] = "The door is locked.",
	[11] = "The door is locked.",
	[12] = "Refreshing.",
	[13] = "Temple of Baa",
	[14] = "",
	[15] = "",
	[16] = "",
	[17] = "",
	[18] = "A wooden sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[19] = "The haunted sounds of tortured souls assail your ears.",
	[20] = "A silver sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[21] = "A copper sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[22] = "A lapis sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened.",
	[23] = "Sign",
	[24] = "Found something!",
	[25] = "You scoop away a handful of someone's hopes and dreams.",
	[26] = "Fountain",
	[27] = "You toss a few coins into the fountain.",
	[28] = " +20 Hit points restored.",
	[29] = "Statue",
	[30] = "The door clicks.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Temple of Baa"
Game.LoadSound(215)

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 558) then         -- "Secret Door Key"
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 558)         -- "Secret Door Key"
		evt.SetDoorState{Id = 1, State = 1}
	else
		evt.StatusText(8)         -- "The door is locked."
	end
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 557) then         -- "Treasure Room Key"
		evt.SetDoorState{Id = 2, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 557)         -- "Treasure Room Key"
	else
		evt.StatusText(5)         -- "The door is locked."
	end
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 563) then         -- "Treasure Room Key"
		evt.SetDoorState{Id = 3, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 563)         -- "Treasure Room Key"
	else
		evt.StatusText(6)         -- "The door is locked."
	end
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 556) then         -- "Store Room Key"
		evt.SetDoorState{Id = 5, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 556)         -- "Store Room Key"
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9956, Y = -2760, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9956, Y = -2908, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -9956, Y = -3108, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9866, Y = -2606, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -10102, Y = -2606, Z = -255}
	else
		evt.StatusText(4)         -- "The door is locked."
	end
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 562) then         -- "Store Room Key"
		evt.SetDoorState{Id = 6, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 562)         -- "Store Room Key"
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9956, Y = -2760, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9956, Y = -2908, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -9956, Y = -3108, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9866, Y = -2606, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -10102, Y = -2606, Z = -255}
	else
		evt.StatusText(10)         -- "The door is locked."
	end
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
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 555) then         -- "Bathhouse Key"
		evt.SetDoorState{Id = 9, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 555)         -- "Bathhouse Key"
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9986, Y = 3669, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9986, Y = 3741, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -9986, Y = 3870, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9986, Y = 2537, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9986, Y = 3603, Z = -255}
	else
		evt.StatusText(9)         -- "The door is locked."
	end
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 561) then         -- "Bathhouse Key"
		evt.SetDoorState{Id = 10, State = 1}
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 561)         -- "Bathhouse Key"
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9986, Y = 3669, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9986, Y = 3741, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -9986, Y = 3870, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9986, Y = 2537, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9986, Y = 3603, Z = -255}
	else
		evt.StatusText(11)         -- "The door is locked."
	end
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.Add("MapVar3", 1)
		if not evt.Cmp("MapVar3", 2) then
			evt.StatusText(30)         -- "The door clicks."
			return
		end
		evt.Set("MapVar3", 1)
	end
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 10}
	evt.Set("MapVar2", 0)
	evt.Set("MapVar3", 0)
	evt.Set("MapVar4", 0)
	evt.Set("MapVar8", 0)
	evt.StatusText(7)         -- "Zap!"
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.Add("MapVar8", 1)
		if not evt.Cmp("MapVar8", 2) then
			if evt.Cmp("MapVar2", 1) then
				if evt.Cmp("MapVar3", 1) then
					if evt.Cmp("MapVar4", 1) then
						evt.SetDoorState{Id = 20, State = 1}
						evt.SetDoorState{Id = 19, State = 1}
						evt.SetDoorState{Id = 21, State = 1}
						evt.SetDoorState{Id = 22, State = 1}
						evt.Set("MapVar2", 0)
						evt.Set("MapVar3", 0)
						evt.Set("MapVar4", 0)
						evt.Set("MapVar8", 0)
					end
				end
			end
			return
		end
		evt.Set("MapVar8", 1)
	end
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 10}
	evt.StatusText(7)         -- "Zap!"
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.Add("MapVar4", 1)
		if not evt.Cmp("MapVar4", 2) then
			evt.StatusText(30)         -- "The door clicks."
			return
		end
		evt.Set("MapVar3", 1)
	end
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 10}
	evt.Set("MapVar2", 0)
	evt.Set("MapVar3", 0)
	evt.Set("MapVar4", 0)
	evt.Set("MapVar8", 0)
	evt.StatusText(7)         -- "Zap!"
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.Add("MapVar2", 1)
	if evt.Cmp("MapVar2", 2) then
		evt.Set("MapVar2", 1)
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 10}
		evt.StatusText(7)         -- "Zap!"
	else
		evt.StatusText(30)         -- "The door clicks."
	end
end

evt.hint[23] = evt.str[3]  -- "Chest"
evt.map[23] = function()
	if evt.Cmp("MapVar19", 1) then
		evt.OpenChest(0)
	else
		evt.OpenChest(0)
		evt.Set("MapVar19", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -9986, Y = 1295, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -10224, Y = 1295, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -9716, Y = 1295, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9688, Y = 1678, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -10273, Y = 1678, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -8716, Y = 101, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -8716, Y = 405, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -8716, Y = -117, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -8261, Y = -227, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -8261, Y = 453, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -10009, Y = -1039, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9713, Y = -1039, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -10272, Y = -1039, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -10281, Y = -1402, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9716, Y = -1402, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -11291, Y = 138, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -11291, Y = -93, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -11291, Y = 454, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -11675, Y = 454, Z = -255}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -11675, Y = -139, Z = -255}
	end
end

evt.hint[12] = evt.str[23]  -- "Sign"
evt.map[12] = function()
	evt.SetMessage(20)         -- "A silver sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened."
	evt.SimpleMessage()
end

evt.hint[14] = evt.str[23]  -- "Sign"
evt.map[14] = function()
	evt.SetMessage(21)         -- "A copper sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened."
	evt.SimpleMessage()
end

evt.hint[16] = evt.str[23]  -- "Sign"
evt.map[16] = function()
	evt.SetMessage(22)         -- "A lapis sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened."
	evt.SimpleMessage()
end

evt.hint[24] = evt.str[23]  -- "Sign"
evt.map[24] = function()
	evt.SetMessage(18)         -- "A wooden sign reads: As the winds blow, the seasons change, and only at the end of all can the doors be opened."
	evt.SimpleMessage()
end

evt.map[26] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("PerceptionSkill", 1) then
		if not evt.Cmp("Cursed", 1) then
			evt.CastSpell{Spell = 91, Mastery = const.Novice, Skill = 10, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Mass Curse"
			evt.StatusText(19)         -- "The haunted sounds of tortured souls assail your ears."
		end
	end
end

evt.hint[27] = evt.str[3]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(1)
end

evt.hint[28] = evt.str[3]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(2)
end

evt.hint[29] = evt.str[3]  -- "Chest"
evt.map[29] = function()
	evt.OpenChest(3)
end

evt.hint[30] = evt.str[3]  -- "Chest"
evt.map[30] = function()
	evt.OpenChest(4)
end

evt.hint[31] = evt.str[3]  -- "Chest"
evt.map[31] = function()
	evt.OpenChest(5)
end

evt.hint[32] = evt.str[29]  -- "Statue"
evt.map[32] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.Add("Inventory", 556)         -- "Store Room Key"
		evt.StatusText(24)         -- "Found something!"
		evt.Set("MapVar10", 1)
	end
end

evt.hint[34] = evt.str[26]  -- "Fountain"
evt.map[34] = function()
	if evt.Cmp("MapVar14", 1) then
		evt.Subtract("MapVar14", 1)
		evt.Add("HP", 20)
		evt.StatusText(28)         -- " +20 Hit points restored."
	else
		evt.StatusText(12)         -- "Refreshing."
	end
end

evt.hint[50] = evt.str[2]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 4885, Y = -7698, Z = 96, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD3.Odm"}
end

evt.map[51] = function()  -- Timer(<function>, 2.5*const.Minute)
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 4, FromX = -1590, FromY = 133, FromZ = -100, ToX = -2200, ToY = 133, ToZ = -100}         -- "Fireball"
end

Timer(evt.map[51].last, 2.5*const.Minute)

evt.map[52] = function()
	if not evt.Cmp("MapVar29", 1) then
		evt.PlaySound{Id = 215, X = 0, Y = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3702, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = 3326, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2950, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 2400, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1985, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1476, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 810, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 440, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 0, Y = -2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 3216, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 2572, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = 0, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = -643, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = -1286, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = -1929, Z = 577}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -650, Y = -2572, Z = 577}
		evt.Set("MapVar29", 1)
	end
end

evt.map[53] = function()
	if not evt.Cmp("MapVar24", 1) then
		evt.Add("Gold", 5000)
		evt.Set("MapVar24", 1)
	end
end

evt.map[70] = function()  -- function events.LoadMap()
	evt.Set("MapVar2", 0)
	evt.Set("MapVar3", 0)
	evt.Set("MapVar4", 0)
	evt.Set("MapVar8", 0)
end

events.LoadMap = evt.map[70].last

