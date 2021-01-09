local TXT = Localize{
	[0] = " ",
	[1] = "Leave the dragon cave",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = "Bookshelf",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "Cave Entrance",
	[15] = "The door is locked",
	[16] = "The cave is empty",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "You have killed all of the Dragons",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.map[5] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if not evt.Cmp("QBits", 233) then         -- You have Pissed of the Dragons
			return
		end
		if evt.Cmp("Counter10", 1344) then
			evt.SetMonGroupBit{NPCGroup = 44, Bit = const.MonsterBits.Hostile, On = false}         -- ""
			evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki(M1)"
			evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Hostile, On = false}         -- "Misc Group for Riki(M1)"
			evt.Subtract("QBits", 233)         -- You have Pissed of the Dragons
			evt.Set("MapVar9", 0)
			evt.SetMonGroupBit{NPCGroup = 45, Bit = const.MonsterBits.Hostile, On = false}         -- ""
			return
		end
	end
	evt.SetMonGroupBit{NPCGroup = 44, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki(M1)"
	evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki(M1)"
	evt.Set("MapVar9", 2)
	evt.SetMonGroupBit{NPCGroup = 45, Bit = const.MonsterBits.Hostile, On = true}         -- ""
end

events.LoadMap = evt.map[5].last

evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.map[8] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 233) then         -- You have Pissed of the Dragons
		if evt.Cmp("MapVar9", 2) then
			evt.Add("QBits", 233)         -- You have Pissed of the Dragons
			evt.Set("Counter10", 0)
		else
			evt.Set("MapVar9", 0)
		end
	end
end

events.LeaveMap = evt.map[8].last

evt.hint[9] = evt.str[100]  -- ""
evt.map[9] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		if not evt.Cmp("QBits", 155) then         -- Killed all Dragons in Garrote Gorge Area
			if evt.CheckMonstersKilled{CheckType = 2, Id = 189, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 190, Count = 0, InvisibleAsDead = 0} then
					if evt.CheckMonstersKilled{CheckType = 2, Id = 191, Count = 0, InvisibleAsDead = 0} then
						if evt.CheckMonstersKilled{CheckType = 2, Id = 69, Count = 0, InvisibleAsDead = 0} then
							if evt.CheckMonstersKilled{CheckType = 2, Id = 70, Count = 0, InvisibleAsDead = 0} then
								if evt.CheckMonstersKilled{CheckType = 2, Id = 71, Count = 0, InvisibleAsDead = 0} then
									if evt.Cmp("QBits", 156) then         -- Questbit set for Riki
										evt.Set("QBits", 155)         -- Killed all Dragons in Garrote Gorge Area
										evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
										evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
										evt.StatusText(30)         -- "You have killed all of the Dragons"
									else
										evt.Set("QBits", 156)         -- Questbit set for Riki
										evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 223, X = -8, Y = 170, Z = 0, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
										evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

events.LeaveMap = evt.map[9].last

Timer(function()
	if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		if not evt.Cmp("QBits", 155) then         -- Killed all Dragons in Garrote Gorge Area
			if evt.CheckMonstersKilled{CheckType = 2, Id = 189, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 190, Count = 0, InvisibleAsDead = 0} then
					if evt.CheckMonstersKilled{CheckType = 2, Id = 191, Count = 0, InvisibleAsDead = 0} then
						if evt.CheckMonstersKilled{CheckType = 2, Id = 69, Count = 0, InvisibleAsDead = 0} then
							if evt.CheckMonstersKilled{CheckType = 2, Id = 70, Count = 0, InvisibleAsDead = 0} then
								if evt.CheckMonstersKilled{CheckType = 2, Id = 71, Count = 0, InvisibleAsDead = 0} then
									if evt.Cmp("QBits", 156) then         -- Questbit set for Riki
										evt.Set("QBits", 155)         -- Killed all Dragons in Garrote Gorge Area
										evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
										evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
										evt.StatusText(30)         -- "You have killed all of the Dragons"
									else
										evt.Set("QBits", 156)         -- Questbit set for Riki
										evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 223, X = -8, Y = 170, Z = 0, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
										evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
									end
								end
							end
						end
					end
				end
			end
		end
	end
end, 10*const.Minute)

evt.hint[10] = evt.str[100]  -- ""
evt.map[10] = function()  -- function events.LeaveMap()
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.MoveNPC{NPC = 21, HouseId = 0}         -- "Deftclaw Redreaver"
		evt.MoveNPC{NPC = 66, HouseId = 175}         -- "Deftclaw Redreaver" -> "Council Chamber Door"
	end
end

events.LeaveMap = evt.map[10].last

evt.hint[81] = evt.str[3]  -- "Chest"
evt.map[81] = function()
	evt.OpenChest(0)
end

evt.hint[82] = evt.str[3]  -- "Chest"
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- "Chest"
evt.map[83] = function()
	evt.OpenChest(2)
end

evt.hint[84] = evt.str[3]  -- "Chest"
evt.map[84] = function()
	evt.OpenChest(3)
end

evt.hint[85] = evt.str[3]  -- "Chest"
evt.map[85] = function()
	evt.OpenChest(4)
end

evt.hint[86] = evt.str[3]  -- "Chest"
evt.map[86] = function()
	evt.OpenChest(5)
end

evt.hint[87] = evt.str[3]  -- "Chest"
evt.map[87] = function()
	evt.OpenChest(6)
end

evt.hint[88] = evt.str[3]  -- "Chest"
evt.map[88] = function()
	evt.OpenChest(7)
end

evt.hint[89] = evt.str[3]  -- "Chest"
evt.map[89] = function()
	evt.OpenChest(8)
end

evt.hint[90] = evt.str[3]  -- "Chest"
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- "Chest"
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[3]  -- "Chest"
evt.map[92] = function()
	evt.OpenChest(11)
end

evt.hint[93] = evt.str[3]  -- "Chest"
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[3]  -- "Chest"
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[3]  -- "Chest"
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[3]  -- "Chest"
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[3]  -- "Chest"
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[3]  -- "Chest"
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[3]  -- "Chest"
evt.map[99] = function()
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[3]  -- "Chest"
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.HouseDoor(131, 350)  -- "Ishton's Cave"
evt.HouseDoor(132, 351)  -- "Ithilgore's Cave"
evt.HouseDoor(133, 352)  -- "Scarwing's Cave"
evt.HouseDoor(201, 178)  -- "Dragon Leader's Cavern "
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar9", 1) then
			evt.SpeakNPC(39)         -- "Guard"
			evt.Set("MapVar9", 1)
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("MapVar9", 2) then
		evt.Set("MapVar9", 0)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar9", 2) then
		evt.SetMonGroupBit{NPCGroup = 44, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki(M1)"
		evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki(M1)"
		evt.Set("MapVar9", 2)
		evt.SetMonGroupBit{NPCGroup = 45, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	end
end

evt.hint[501] = evt.str[1]  -- "Leave the dragon cave"
evt.map[501] = function()
	evt.MoveToMap{X = 6376, Y = 12420, Z = 1616, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out05.odm"}
end

