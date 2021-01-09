local TXT = Localize{
	[0] = " ",
	[1] = "Leave the Necromancers' Guild",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "Door Beam",
	[7] = "The lever will not move",
	[8] = "The Beam will not move",
	[9] = "Bookshelf",
	[10] = "The Door will not move",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _5
	end
	if evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		if not evt.Cmp("Counter9", 1344) then
			goto _5
		end
		evt.Set("MapVar9", 0)
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = false}         -- "Misc Group for Riki"
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki"
		evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = false}         -- ""
		evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = false}         -- ""
		evt.Subtract("QBits", 229)         -- You have Pissed off the Necros
	end
::_17::
	evt.SetDoorState{Id = 5, State = 1}
	do return end
::_5::
	evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
	evt.Set("MapVar9", 2)
	goto _17
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 13, State = 0}
	evt.SetDoorState{Id = 14, State = 0}
	evt.SetDoorState{Id = 15, State = 0}
	evt.SetDoorState{Id = 16, State = 0}
	evt.Set("MapVar19", 0)
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.MoveNPC{NPC = 9, HouseId = 0}         -- "Sandro"
		evt.MoveNPC{NPC = 69, HouseId = 175}         -- "Sandro" -> "Council Chamber Door"
		evt.MoveNPC{NPC = 76, HouseId = 180}         -- "Thant" -> "Sandro/Thant's Throne Room"
	end
	if not evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		if evt.Cmp("MapVar9", 2) then
			evt.Add("QBits", 229)         -- You have Pissed off the Necros
			evt.Set("Counter9", 0)
		else
			evt.Set("MapVar9", 0)
		end
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.hint[11] = evt.str[2]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[12] = evt.str[5]  -- "Button"
evt.map[12] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[13] = evt.str[5]  -- "Button"
evt.map[13] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[14] = evt.str[5]  -- "Button"
evt.map[14] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[15] = evt.str[2]  -- "Door"
evt.map[15] = function()
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _10
	end
	if evt.Cmp("Players", 34) then
		if evt.IsPlayerInParty(34) then         -- "Dyson Leyland"
			goto _10
		end
		evt.SetNPCGreeting{NPC = 58, Greeting = 144}         -- "Guard" : ""
	else
		evt.SetNPCGreeting{NPC = 58, Greeting = 107}         -- "Guard" : "Halt! These areas are off limits to guests! Guild members only!"
	end
	if not evt.Cmp("Invisible", 0) then
		evt.SpeakNPC(58)         -- "Guard"
	end
	evt.FaceAnimation{Player = "Current", Animation = 18}
	do return end
::_10::
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[16] = evt.str[2]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[18] = evt.str[5]  -- "Button"
evt.map[18] = function()
	if evt.Cmp("MapVar19", 15) then
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.SetDoorState{Id = 8, State = 0}
		evt.SetDoorState{Id = 9, State = 1}
		evt.SetDoorState{Id = 10, State = 0}
		if evt.Cmp("MapVar19", 6) then
			evt.Subtract("MapVar19", 1)
		end
	end
end

evt.hint[19] = evt.str[5]  -- "Button"
evt.map[19] = function()
	if not evt.Cmp("MapVar19", 15) then
		if evt.Cmp("MapVar19", 5) then
			evt.SetDoorState{Id = 8, State = 1}
			evt.SetDoorState{Id = 9, State = 0}
			evt.SetDoorState{Id = 10, State = 1}
			evt.Add("MapVar19", 1)
			return
		end
	end
	evt.StatusText(10)         -- "The Door will not move"
end

evt.hint[20] = evt.str[4]  -- "Lever"
evt.map[20] = function()
	if not evt.Cmp("MapVar19", 15) then
		if not evt.Cmp("MapVar19", 6) then
			if not evt.Cmp("MapVar19", 5) then
				if not evt.Cmp("MapVar19", 4) then
					if not evt.Cmp("MapVar19", 3) then
						if not evt.Cmp("MapVar19", 2) then
							if evt.Cmp("MapVar19", 1) then
								evt.SetDoorState{Id = 11, State = 0}
								evt.Subtract("MapVar19", 1)
							else
								evt.SetDoorState{Id = 11, State = 1}
								evt.Add("MapVar19", 1)
							end
							return
						end
					end
				end
			end
		end
	end
	evt.StatusText(7)         -- "The lever will not move"
end

evt.hint[21] = evt.str[4]  -- "Lever"
evt.map[21] = function()
	if not evt.Cmp("MapVar19", 15) then
		if not evt.Cmp("MapVar19", 6) then
			if not evt.Cmp("MapVar19", 5) then
				if not evt.Cmp("MapVar19", 4) then
					if evt.Cmp("MapVar19", 3) then
						evt.SetDoorState{Id = 12, State = 0}
						evt.Subtract("MapVar19", 1)
						return
					end
					if evt.Cmp("MapVar19", 2) then
						evt.SetDoorState{Id = 12, State = 1}
						evt.Add("MapVar19", 1)
						return
					end
					evt.Cmp("MapVar19", 1)
				end
			end
		end
	end
	evt.StatusText(7)         -- "The lever will not move"
end

evt.hint[22] = evt.str[4]  -- "Lever"
evt.map[22] = function()
	if not evt.Cmp("MapVar19", 15) then
		if not evt.Cmp("MapVar19", 6) then
			if not evt.Cmp("MapVar19", 5) then
				if not evt.Cmp("MapVar19", 4) then
					if not evt.Cmp("MapVar19", 3) then
						if evt.Cmp("MapVar19", 2) then
							evt.SetDoorState{Id = 13, State = 0}
							evt.Subtract("MapVar19", 1)
							return
						end
						if evt.Cmp("MapVar19", 1) then
							evt.SetDoorState{Id = 13, State = 1}
							evt.Add("MapVar19", 1)
							return
						end
					end
				end
			end
		end
	end
	evt.StatusText(7)         -- "The lever will not move"
end

evt.hint[23] = evt.str[4]  -- "Lever"
evt.map[23] = function()
	if not evt.Cmp("MapVar19", 15) then
		if not evt.Cmp("MapVar19", 6) then
			if evt.Cmp("MapVar19", 5) then
				goto _11
			end
			if evt.Cmp("MapVar19", 4) then
				evt.SetDoorState{Id = 14, State = 1}
				evt.Add("MapVar19", 1)
				return
			end
			if not evt.Cmp("MapVar19", 3) then
				if not evt.Cmp("MapVar19", 2) then
					if evt.Cmp("MapVar19", 1) then
						goto _11
					end
				end
			end
		end
	end
	evt.StatusText(7)         -- "The lever will not move"
	do return end
::_11::
	evt.SetDoorState{Id = 14, State = 0}
	evt.Subtract("MapVar19", 1)
end

evt.hint[24] = evt.str[4]  -- "Lever"
evt.map[24] = function()
	if not evt.Cmp("MapVar19", 15) then
		if not evt.Cmp("MapVar19", 6) then
			if not evt.Cmp("MapVar19", 5) then
				if evt.Cmp("MapVar19", 4) then
					evt.SetDoorState{Id = 15, State = 0}
					evt.Subtract("MapVar19", 1)
					return
				end
				if evt.Cmp("MapVar19", 3) then
					evt.SetDoorState{Id = 15, State = 1}
					evt.Add("MapVar19", 1)
					return
				end
				if not evt.Cmp("MapVar19", 2) then
					evt.Cmp("MapVar19", 1)
				end
			end
		end
	end
	evt.StatusText(7)         -- "The lever will not move"
end

evt.hint[25] = evt.str[6]  -- "Door Beam"
evt.map[25] = function()
	if not evt.Cmp("MapVar19", 6) then
		evt.StatusText(8)         -- "The Beam will not move"
	elseif evt.Cmp("MapVar19", 15) then
		evt.SetDoorState{Id = 16, State = 0}
		evt.Set("MapVar19", 6)
	else
		evt.SetDoorState{Id = 16, State = 1}
		evt.Set("MapVar19", 15)
	end
end

evt.hint[26] = evt.str[2]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 59, State = 1}
	evt.SetDoorState{Id = 60, State = 1}
	evt.SetDoorState{Id = 61, State = 1}
	evt.SetDoorState{Id = 62, State = 1}
end

evt.hint[27] = evt.str[2]  -- "Door"
evt.map[27] = function()
	if evt.Cmp("MapVar19", 15) then
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.SetDoorState{Id = 8, State = 0}
		evt.SetDoorState{Id = 9, State = 1}
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
		evt.SetDoorState{Id = 7, State = 0}
	end
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

evt.hint[61] = evt.str[2]  -- "Door"
evt.map[61] = function()
	if evt.Cmp("MapVar9", 2) then
		goto _17
	end
	if evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		goto _17
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _12
	end
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if evt.Cmp("MapVar9", 1) then
			evt.Set("QBits", 229)         -- You have Pissed off the Necros
			evt.Set("Counter9", 0)
			goto _12
		end
		evt.Set("MapVar9", 1)
	end
	evt.SpeakNPC(38)         -- "Guard"
	evt.FaceAnimation{Player = "Current", Animation = 18}
	do return end
::_17::
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
	do return end
::_12::
	evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
	evt.Set("MapVar9", 2)
	goto _17
end

evt.hint[62] = evt.str[2]  -- "Door"
evt.map[62] = function()
	if evt.Cmp("MapVar9", 2) then
		goto _17
	end
	if evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		goto _17
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _12
	end
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if evt.Cmp("MapVar9", 1) then
			evt.Set("QBits", 229)         -- You have Pissed off the Necros
			evt.Set("Counter9", 0)
			goto _12
		end
		evt.Set("MapVar9", 1)
	end
	evt.SpeakNPC(38)         -- "Guard"
	evt.FaceAnimation{Player = "Current", Animation = 18}
	do return end
::_17::
	evt.SetDoorState{Id = 53, State = 0}
	evt.SetDoorState{Id = 54, State = 0}
	do return end
::_12::
	evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
	evt.Set("MapVar9", 2)
	goto _17
end

evt.hint[63] = evt.str[2]  -- "Door"
evt.map[63] = function()
	if evt.Cmp("MapVar9", 2) then
		goto _17
	end
	if evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		goto _17
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _12
	end
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if evt.Cmp("MapVar9", 1) then
			evt.Set("QBits", 229)         -- You have Pissed off the Necros
			evt.Set("Counter9", 0)
			goto _12
		end
		evt.Set("MapVar9", 1)
	end
	evt.SpeakNPC(38)         -- "Guard"
	evt.FaceAnimation{Player = "Current", Animation = 18}
	do return end
::_17::
	evt.SetDoorState{Id = 55, State = 0}
	evt.SetDoorState{Id = 56, State = 0}
	do return end
::_12::
	evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
	evt.Set("MapVar9", 2)
	goto _17
end

evt.hint[64] = evt.str[2]  -- "Door"
evt.map[64] = function()
	if evt.Cmp("MapVar9", 2) then
		goto _17
	end
	if evt.Cmp("QBits", 229) then         -- You have Pissed off the Necros
		goto _17
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _12
	end
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if evt.Cmp("MapVar9", 1) then
			evt.Set("QBits", 229)         -- You have Pissed off the Necros
			evt.Set("Counter9", 0)
			goto _12
		end
		evt.Set("MapVar9", 1)
	end
	evt.SpeakNPC(38)         -- "Guard"
	evt.FaceAnimation{Player = "Current", Animation = 18}
	do return end
::_17::
	evt.SetDoorState{Id = 57, State = 0}
	evt.SetDoorState{Id = 58, State = 0}
	do return end
::_12::
	evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
	evt.Set("MapVar9", 2)
	goto _17
end

evt.hint[65] = evt.str[2]  -- "Door"
evt.map[65] = function()
	evt.SetDoorState{Id = 59, State = 0}
	evt.SetDoorState{Id = 60, State = 0}
end

evt.hint[66] = evt.str[2]  -- "Door"
evt.map[66] = function()
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
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

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()
	if not evt.Cmp("QBits", 27) then         -- Skeleton Transformer Destroyed.
		if evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
			if evt.Cmp("Players", 34) then
				if evt.Cmp("MapVar19", 15) then
					if evt.IsPlayerInParty(34) then         -- "Dyson Leyland"
						evt.Add("QBits", 27)         -- Skeleton Transformer Destroyed.
						evt.ShowMovie{DoubleSize = 1, Name = "\"skeltrans\" "}
						evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Untouchable, On = true}
						evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Invisible, On = true}
					end
				end
			end
		end
	end
end

evt.house[201] = 180  -- "Sandro/Thant's Throne Room"
evt.map[201] = function()
	if evt.Cmp("QBits", 27) then         -- Skeleton Transformer Destroyed.
		goto _27
	end
	if evt.Cmp("MapVar9", 2) then
		goto _27
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _27
	end
	if not evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 604) then         -- "Nightshade Brazier"
			evt.Subtract("Inventory", 604)         -- "Nightshade Brazier"
			evt.Subtract("QBits", 14)         -- "Form an alliance with the Necromancers' Guild in Shadowspire."
			evt.Subtract("QBits", 15)         -- "Form an alliance with the Temple of the Sun in Murmurwoods."
			evt.Subtract("QBits", 28)         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
			evt.Subtract("QBits", 26)         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
			evt.Add("QBits", 19)         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
			evt.MoveNPC{NPC = 10, HouseId = 0}         -- "Thant"
			evt.SetNPCTopic{NPC = 9, Index = 0, Event = 0}         -- "Sandro"
			evt.SetNPCTopic{NPC = 9, Index = 1, Event = 101}         -- "Sandro" : "Thant"
			evt.SetNPCGreeting{NPC = 9, Greeting = 32}         -- "Sandro" : "Yes?"
			evt.ForPlayer("All")
			evt.Add("Awards", 10)         -- "Formed an alliance with the Necromancers' Guild."
			evt.Add("Experience", 12500)
			evt.ForPlayer("Current")
			evt.Add("Gold", 8000)
			evt.ShowMovie{DoubleSize = 1, Name = "\"nightshade\" "}
			evt.Add("History10", 0)
			evt.Subtract("QBits", 203)         -- Nightshade Brazier - I lost it
		end
	end
	evt.EnterHouse(180)         -- "Sandro/Thant's Throne Room"
	do return end
::_27::
	evt.FaceAnimation{Player = "Current", Animation = 18}
end

evt.house[203] = 181  -- "Dyson Leland's Room"
evt.map[203] = function()
	evt.Set("MapVar29", 5)
	if evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
		goto _17
	end
	if evt.Cmp("QBits", 28) then         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		goto _17
	end
::_15::
	evt.EnterHouse(181)         -- "Dyson Leland's Room"
	do return end
::_17::
	if not evt.Cmp("QBits", 89) then         -- Dyson Leland talks to you about the Necromancers. For global event 97-100.
		goto _15
	end
	if not evt.Cmp("QBits", 90) then         -- Dyson Leland talks to you about the Temple of the Sun. For Global event 97-100.
		goto _15
	end
	evt.SetNPCTopic{NPC = 11, Index = 3, Event = 634}         -- "Dyson Leland" : "Roster Join Event"
	if evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
		evt.Set("MapVar29", 4)
	end
	if evt.Cmp("QBits", 28) then         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		if evt.Cmp("MapVar29", 5) then
			evt.SetNPCGreeting{NPC = 11, Greeting = 34}         -- "Dyson Leland" : "So, do we move against the Sun Temple? Shall we get for Sandro his Nightshade Brazier?"
		else
			evt.SetNPCGreeting{NPC = 11, Greeting = 36}         -- "Dyson Leland" : "So, have you decided to steal the Nightshade Brazier from the Temple, or to destroy the guild's Skeleton Transformer? Either way…I will join you. But let us do it. I would slack my thirst for revenge."
		end
	else
		evt.SetNPCGreeting{NPC = 11, Greeting = 35}         -- "Dyson Leland" : "Are you now ready to destroy the guild's Skeleton Transformer? I will join you and we can be about the task!"
	end
	goto _15
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("MapVar9", 2) then
		evt.Set("MapVar9", 0)
	end
end

evt.hint[452] = evt.str[2]  -- "Door"
evt.map[452] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar9", 1) then
			evt.SpeakNPC(38)         -- "Guard"
			evt.Set("MapVar9", 1)
		end
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	if not evt.Cmp("MapVar9", 2) then
		if not evt.Cmp("Invisible", 0) then
			evt.SetMonGroupBit{NPCGroup = 41, Bit = const.MonsterBits.Hostile, On = true}         -- ""
			evt.SetMonGroupBit{NPCGroup = 42, Bit = const.MonsterBits.Hostile, On = true}         -- ""
			evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
			evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
			evt.Set("MapVar9", 2)
			evt.SetDoorState{Id = 7, State = 0}
		end
	end
end

evt.hint[501] = evt.str[1]  -- "Leave the Necromancers' Guild"
evt.map[501] = function()
	evt.MoveToMap{X = 15620, Y = -11571, Z = 4480, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out06.odm"}
end

