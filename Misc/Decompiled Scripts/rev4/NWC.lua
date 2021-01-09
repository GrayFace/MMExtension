local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Cave",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "The lever won't budge",
	[10] = "Bookcase",
	[11] = "You must have the Book of UnMakings in order to leave",
	[12] = "You must kill all hostiles in order to leave the temple.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	if evt.Cmp("QBits", 293) then         -- Return to NWC
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetDoorState{Id = 73, State = 1}
		evt.SetDoorState{Id = 74, State = 1}
		evt.SetDoorState{Id = 81, State = 1}
		evt.SetDoorState{Id = 75, State = 1}
		evt.SetDoorState{Id = 82, State = 1}
		evt.SetDoorState{Id = 76, State = 1}
		evt.SetDoorState{Id = 83, State = 1}
		evt.SetDoorState{Id = 77, State = 1}
		evt.SetDoorState{Id = 84, State = 1}
		evt.SetDoorState{Id = 78, State = 1}
		evt.SetDoorState{Id = 85, State = 1}
		evt.SetDoorState{Id = 79, State = 1}
		evt.SetDoorState{Id = 86, State = 1}
		evt.SetDoorState{Id = 72, State = 1}
		evt.SetDoorState{Id = 73, State = 1}
		evt.SetDoorState{Id = 80, State = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 2756, Y = 4781, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
	end
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
end

evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
end

evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
end

evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
end

evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
end

evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
end

evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
end

evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 2}         -- switch state
end

evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 2}         -- switch state
end

evt.map[26] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
end

evt.map[27] = function()
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

evt.map[28] = function()
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
end

evt.map[29] = function()
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
end

evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
end

evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
end

evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
end

evt.map[33] = function()
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.map[34] = function()
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
end

evt.map[35] = function()
	evt.SetDoorState{Id = 35, State = 2}         -- switch state
end

evt.map[36] = function()
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
end

evt.map[37] = function()
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
end

evt.map[38] = function()
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
end

evt.map[39] = function()
	evt.SetDoorState{Id = 39, State = 2}         -- switch state
end

evt.map[40] = function()
	evt.SetDoorState{Id = 40, State = 2}         -- switch state
end

evt.map[41] = function()
	evt.SetDoorState{Id = 41, State = 2}         -- switch state
end

evt.map[42] = function()
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
end

evt.map[43] = function()
	evt.SetDoorState{Id = 43, State = 2}         -- switch state
end

evt.map[44] = function()
	evt.SetDoorState{Id = 44, State = 2}         -- switch state
end

evt.map[45] = function()
	evt.SetDoorState{Id = 45, State = 2}         -- switch state
end

evt.map[46] = function()
	evt.SetDoorState{Id = 46, State = 2}         -- switch state
end

evt.map[47] = function()
	evt.SetDoorState{Id = 47, State = 2}         -- switch state
end

evt.map[48] = function()
	evt.SetDoorState{Id = 48, State = 2}         -- switch state
end

evt.map[49] = function()
	evt.SetDoorState{Id = 49, State = 2}         -- switch state
end

evt.map[50] = function()
	evt.SetDoorState{Id = 50, State = 2}         -- switch state
end

evt.map[51] = function()
	evt.SetDoorState{Id = 51, State = 2}         -- switch state
end

evt.map[52] = function()
	evt.SetDoorState{Id = 52, State = 2}         -- switch state
end

evt.map[53] = function()
	evt.SetDoorState{Id = 53, State = 2}         -- switch state
end

evt.map[54] = function()
	evt.SetDoorState{Id = 54, State = 2}         -- switch state
end

evt.map[55] = function()
	evt.SetDoorState{Id = 55, State = 2}         -- switch state
end

evt.map[56] = function()
	evt.SetDoorState{Id = 56, State = 2}         -- switch state
end

evt.map[57] = function()
	evt.SetDoorState{Id = 57, State = 2}         -- switch state
end

evt.map[58] = function()
	evt.SetDoorState{Id = 58, State = 2}         -- switch state
end

evt.map[59] = function()
	evt.SetDoorState{Id = 59, State = 2}         -- switch state
end

evt.map[60] = function()
	evt.SetDoorState{Id = 60, State = 2}         -- switch state
end

evt.map[61] = function()
	evt.SetDoorState{Id = 61, State = 2}         -- switch state
end

evt.map[62] = function()
	evt.SetDoorState{Id = 62, State = 2}         -- switch state
end

evt.map[63] = function()
	evt.SetDoorState{Id = 63, State = 2}         -- switch state
end

evt.map[64] = function()
	evt.SetDoorState{Id = 64, State = 2}         -- switch state
end

evt.map[65] = function()
	evt.SetDoorState{Id = 65, State = 2}         -- switch state
end

evt.map[66] = function()
	evt.SetDoorState{Id = 66, State = 2}         -- switch state
end

evt.map[67] = function()
	evt.SetDoorState{Id = 67, State = 2}         -- switch state
end

evt.map[68] = function()
	evt.SetDoorState{Id = 68, State = 2}         -- switch state
end

evt.map[69] = function()
	evt.SetDoorState{Id = 69, State = 2}         -- switch state
end

evt.map[70] = function()
	evt.SetDoorState{Id = 70, State = 2}         -- switch state
end

evt.map[71] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.map[72] = function()
	evt.SetDoorState{Id = 71, State = 2}         -- switch state
end

evt.map[73] = function()
	evt.SetDoorState{Id = 72, State = 2}         -- switch state
end

evt.map[74] = function()
	evt.SetDoorState{Id = 73, State = 2}         -- switch state
end

evt.map[75] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 285) then         -- NWC Switch1
		evt.Set("QBits", 286)         -- NWC Switch2
		evt.SetDoorState{Id = 74, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[76] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 287) then         -- NWC Switch3
		evt.Set("QBits", 288)         -- NWC Switch4
		evt.SetDoorState{Id = 75, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[77] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 288) then         -- NWC Switch4
		evt.Set("QBits", 289)         -- NWC Switch5
		evt.SetDoorState{Id = 76, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[78] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 290) then         -- NWC Switch6
		evt.Set("QBits", 291)         -- NWC Tele Bit
		evt.SetDoorState{Id = 77, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[79] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 286) then         -- NWC Switch2
		evt.Set("QBits", 287)         -- NWC Switch3
		evt.SetDoorState{Id = 78, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[80] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 289) then         -- NWC Switch5
		evt.Set("QBits", 290)         -- NWC Switch6
		evt.SetDoorState{Id = 79, State = 1}
	else
		evt.StatusText(9)         -- "The lever won't budge"
	end
end

evt.map[81] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 293) then         -- Return to NWC
		return
	end
	if evt.Cmp("QBits", 291) then         -- NWC Tele Bit
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.MoveToMap{X = 2752, Y = 13056, Z = -1376, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		return
	end
	if evt.Cmp("QBits", 285) then         -- NWC Switch1
		return
	end
	evt.Set("QBits", 285)         -- NWC Switch1
	evt.SetDoorState{Id = 71, State = 1}
	evt.SetDoorState{Id = 72, State = 1}
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SpeakNPC(8)         -- "Halfgild Wynac"
			return
		end
	end
	evt.SpeakNPC(7)         -- "Thomas Grey"
end

evt.hint[176] = evt.str[1]  -- "Door"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[1]  -- "Door"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[1]  -- "Door"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[1]  -- "Door"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[1]  -- "Door"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[1]  -- "Door"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[1]  -- "Door"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[1]  -- "Door"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[1]  -- "Door"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[1]  -- "Door"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[1]  -- "Door"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[1]  -- "Door"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[1]  -- "Door"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[1]  -- "Door"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[1]  -- "Door"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[1]  -- "Door"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[1]  -- "Door"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[1]  -- "Door"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[1]  -- "Door"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[1]  -- "Door"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.map[451] = function()
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 2756, Y = 4781, Z = 0, -- ERROR: Not found
NPCGroup = 512, unk = 0}
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetDoorState{Id = 73, State = 1}
end

evt.map[452] = function()
	evt.MoveToMap{X = 2752, Y = 13056, Z = -1376, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[453] = function()
	local i
	if not evt.Cmp("Gold", 10000) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Gold", 1)
		elseif i == 2 then
			evt.Add("Gold", 1)
		elseif i == 3 then
			evt.Add("Gold", 1)
		elseif i == 4 then
			evt.Add("Gold", 1)
		elseif i == 5 then
			evt.Add("Gold", 1)
		else
			evt.Set("Gold", 1)
		end
	end
end

evt.map[454] = function()
	evt.Subtract("Gold", 10)
	evt.Add("Inventory", 220)         -- "Potion Bottle"
end

evt.map[501] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 293) then         -- Return to NWC
		if evt.CheckMonstersKilled{CheckType = 1, Id = 5, Count = 0} then
			evt.Set("QBits", 302)         -- Small House only Once
			evt.MoveToMap{X = -15360, Y = 2956, Z = 129, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "mdt15.blv"}
		else
			evt.StatusText(12)         -- "You must kill all hostiles in order to leave the temple."
		end
		return
	end
	evt.SetNPCTopic{NPC = 48, Index = 0, Event = 95}         -- "Thomas Grey" : "We've retrieved the Book of UnMakings!"
	evt.SetNPCTopic{NPC = 49, Index = 0, Event = 97}         -- "Halfgild Wynac" : "Lord Godwinson sent us!"
	if not evt.Cmp("Inventory", 499) then         -- "Book of UnMakings"
		evt.StatusText(11)         -- "You must have the Book of UnMakings in order to leave"
		return
	end
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.MoveToMap{X = 3309, Y = -7974, Z = 0, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "d26.blv"}
			return
		end
	end
	evt.MoveToMap{X = 670, Y = -93, Z = 0, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "d14.blv"}
end

