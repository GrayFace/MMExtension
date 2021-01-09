local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Dragon Hunter's Camp",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "Crate",
	[7] = "",
	[8] = "",
	[9] = "Bookshelf",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
	[16] = "",
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
	[30] = "You have killed all of the Dragon Hunters",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.map[5] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		if not evt.Cmp("QBits", 234) then         -- You have Pissed of the Dragon hunters
			return
		end
		if evt.Cmp("Counter7", 1344) then
			evt.SetMonGroupBit{NPCGroup = 22, Bit = const.MonsterBits.Hostile, On = false}         -- "Dragon Hunters"
			evt.SetMonGroupBit{NPCGroup = 23, Bit = const.MonsterBits.Hostile, On = false}         -- "Dragon Hunters"
			evt.SetMonGroupBit{NPCGroup = 43, Bit = const.MonsterBits.Hostile, On = false}         -- ""
			evt.Subtract("QBits", 234)         -- You have Pissed of the Dragon hunters
			return
		end
	end
	evt.SetMonGroupBit{NPCGroup = 22, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
	evt.SetMonGroupBit{NPCGroup = 23, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
	evt.SetMonGroupBit{NPCGroup = 43, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.Set("MapVar9", 2)
end

events.LoadMap = evt.map[5].last

evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.map[9] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if not evt.Cmp("QBits", 158) then         -- Killed all Dragon Hunters in Garrote Gorge wilderness area
			if evt.CheckMonstersKilled{CheckType = 2, Id = 42, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 43, Count = 0, InvisibleAsDead = 0} then
					if evt.CheckMonstersKilled{CheckType = 2, Id = 44, Count = 0, InvisibleAsDead = 0} then
						if evt.Cmp("QBits", 159) then         -- Questbit set for Riki
							evt.Set("QBits", 158)         -- Killed all Dragon Hunters in Garrote Gorge wilderness area
							evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
							evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
							evt.StatusText(30)         -- "You have killed all of the Dragon Hunters"
						else
							evt.Set("QBits", 159)         -- Questbit set for Riki
							evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 64, X = 1888, Y = 1, Z = 0, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
							evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
						end
					end
				end
			end
		end
	end
end

events.LeaveMap = evt.map[9].last

evt.hint[10] = evt.str[100]  -- ""
evt.map[10] = function()  -- function events.LeaveMap()
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.MoveNPC{NPC = 19, HouseId = 0}         -- "Sir Charles Quixote"
		evt.MoveNPC{NPC = 65, HouseId = 175}         -- "Sir Charles Quixote" -> "Council Chamber Door"
		evt.MoveNPC{NPC = 64, HouseId = 179}         -- "Garret Deverro" -> "Charles Quixote's House"
	end
	if not evt.Cmp("QBits", 234) then         -- You have Pissed of the Dragon hunters
		if evt.Cmp("MapVar9", 2) then
			evt.Set("QBits", 234)         -- You have Pissed of the Dragon hunters
			evt.Set("Counter7", 0)
		else
			evt.Set("MapVar9", 0)
		end
	end
end

events.LeaveMap = evt.map[10].last

evt.hint[11] = evt.str[9]  -- "Bookshelf"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[12] = evt.str[2]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[13] = evt.str[2]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[14] = evt.str[2]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[15] = evt.str[2]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[16] = evt.str[2]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[17] = evt.str[2]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[18] = evt.str[2]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[19] = evt.str[2]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[20] = evt.str[2]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[21] = evt.str[2]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[22] = evt.str[2]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[23] = evt.str[2]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[24] = evt.str[2]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[25] = evt.str[2]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[26] = evt.str[2]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[27] = evt.str[2]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[28] = evt.str[2]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[29] = evt.str[2]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[30] = evt.str[2]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 20, State = 0}
end

evt.hint[31] = evt.str[2]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[32] = evt.str[2]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[33] = evt.str[2]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[34] = evt.str[2]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[35] = evt.str[2]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[36] = evt.str[2]  -- "Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[37] = evt.str[2]  -- "Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[38] = evt.str[2]  -- "Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[39] = evt.str[2]  -- "Door"
evt.map[39] = function()
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[40] = evt.str[2]  -- "Door"
evt.map[40] = function()
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[41] = evt.str[2]  -- "Door"
evt.map[41] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.hint[42] = evt.str[2]  -- "Door"
evt.map[42] = function()
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[43] = evt.str[2]  -- "Door"
evt.map[43] = function()
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[44] = evt.str[2]  -- "Door"
evt.map[44] = function()
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[45] = evt.str[2]  -- "Door"
evt.map[45] = function()
	evt.SetDoorState{Id = 35, State = 0}
end

evt.hint[46] = evt.str[2]  -- "Door"
evt.map[46] = function()
	evt.SetDoorState{Id = 36, State = 0}
end

evt.hint[47] = evt.str[2]  -- "Door"
evt.map[47] = function()
	evt.SetDoorState{Id = 37, State = 0}
end

evt.hint[48] = evt.str[2]  -- "Door"
evt.map[48] = function()
	evt.SetDoorState{Id = 38, State = 0}
end

evt.hint[49] = evt.str[2]  -- "Door"
evt.map[49] = function()
	evt.SetDoorState{Id = 39, State = 0}
end

evt.hint[50] = evt.str[2]  -- "Door"
evt.map[50] = function()
	evt.SetDoorState{Id = 40, State = 0}
end

evt.hint[51] = evt.str[2]  -- "Door"
evt.map[51] = function()
	evt.SetDoorState{Id = 41, State = 0}
end

evt.hint[52] = evt.str[2]  -- "Door"
evt.map[52] = function()
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[53] = evt.str[2]  -- "Door"
evt.map[53] = function()
	evt.SetDoorState{Id = 43, State = 0}
end

evt.hint[54] = evt.str[2]  -- "Door"
evt.map[54] = function()
	evt.SetDoorState{Id = 44, State = 0}
end

evt.hint[55] = evt.str[2]  -- "Door"
evt.map[55] = function()
	evt.SetDoorState{Id = 45, State = 0}
end

evt.hint[56] = evt.str[2]  -- "Door"
evt.map[56] = function()
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[57] = evt.str[2]  -- "Door"
evt.map[57] = function()
	evt.SetDoorState{Id = 47, State = 0}
end

evt.hint[58] = evt.str[2]  -- "Door"
evt.map[58] = function()
	evt.SetDoorState{Id = 48, State = 0}
end

evt.hint[59] = evt.str[2]  -- "Door"
evt.map[59] = function()
	evt.SetDoorState{Id = 49, State = 0}
end

evt.hint[60] = evt.str[2]  -- "Door"
evt.map[60] = function()
	evt.SetDoorState{Id = 50, State = 0}
end

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

evt.HouseDoor(201, 179)  -- "Charles Quixote's House"
evt.hint[401] = evt.str[6]  -- "Crate"
evt.hint[402] = evt.str[9]  -- "Bookshelf"
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar9", 1) then
			evt.Set("MapVar9", 1)
			evt.SpeakNPC(40)         -- "Guard"
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
		evt.SetMonGroupBit{NPCGroup = 22, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
		evt.SetMonGroupBit{NPCGroup = 23, Bit = const.MonsterBits.Hostile, On = true}         -- "Dragon Hunters"
		evt.SetMonGroupBit{NPCGroup = 43, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.Set("MapVar9", 2)
	end
end

evt.hint[501] = evt.str[1]  -- "Leave the Dragon Hunter's Camp"
evt.map[501] = function()
	evt.MoveToMap{X = 8909, Y = -15194, Z = 640, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out05.odm"}
end

