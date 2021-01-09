local TXT = Localize{
	[0] = " ",
	[1] = "Leave Balthazar Lair",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "Fountain",
	[7] = "Drink from the Fountain",
	[8] = "Refreshing",
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
	[30] = "Your wounds begin to heal",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.SetMonGroupBit{NPCGroup = 35, Bit = const.MonsterBits.Invisible, On = false}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetMonGroupBit{NPCGroup = 36, Bit = const.MonsterBits.Invisible, On = false}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetMonGroupBit{NPCGroup = 37, Bit = const.MonsterBits.Invisible, On = false}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetMonGroupBit{NPCGroup = 38, Bit = const.MonsterBits.Invisible, On = false}         -- "Guards"
	elseif not evt.Cmp("MapVar9", 1) then
		evt.SetMonGroupBit{NPCGroup = 35, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetMonGroupBit{NPCGroup = 36, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetMonGroupBit{NPCGroup = 37, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasant Minotaurs in Balzathar Lair"
		evt.SetMonGroupBit{NPCGroup = 38, Bit = const.MonsterBits.Invisible, On = true}         -- "Guards"
		return
	end
	evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LeaveMap()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.MoveNPC{NPC = 13, HouseId = 0}         -- "Masul"
		evt.MoveNPC{NPC = 68, HouseId = 175}         -- "Masul" -> "Council Chamber Door"
	end
end

events.LeaveMap = evt.map[6].last

evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.hint[11] = evt.str[4]  -- "Lever"
evt.map[11] = function()
	if not evt.Cmp("MapVar9", 1) then
		if evt.Cmp("MapVar10", 1) then
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = false}
			evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Untouchable, On = false}
			evt.SetDoorState{Id = 1, State = 1}
			evt.SetDoorState{Id = 2, State = 1}
			evt.SetDoorState{Id = 3, State = 1}
			evt.SetDoorState{Id = 4, State = 1}
			evt.SetDoorState{Id = 5, State = 1}
			evt.SetDoorState{Id = 6, State = 1}
			evt.SetDoorState{Id = 7, State = 1}
			evt.SetDoorState{Id = 8, State = 1}
			evt.SetDoorState{Id = 9, State = 1}
			evt.SetDoorState{Id = 10, State = 1}
			evt.SetDoorState{Id = 11, State = 1}
			evt.SetDoorState{Id = 12, State = 1}
			evt.Set("MapVar10", 0)
		else
			evt.SetDoorState{Id = 1, State = 0}
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
			evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
			evt.Set("MapVar10", 1)
		end
	end
end

evt.hint[12] = evt.str[4]  -- "Lever"
evt.map[12] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 2, State = 0}
		evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = true}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[13] = evt.str[4]  -- "Lever"
evt.map[13] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 3, State = 0}
		evt.SetDoorState{Id = 4, State = 1}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[14] = evt.str[4]  -- "Lever"
evt.map[14] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 4, State = 0}
		evt.SetDoorState{Id = 3, State = 1}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[15] = evt.str[4]  -- "Lever"
evt.map[15] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 5, State = 0}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[16] = evt.str[4]  -- "Lever"
evt.map[16] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 6, State = 0}
		evt.SetDoorState{Id = 7, State = 1}
		evt.SetDoorState{Id = 8, State = 1}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[17] = evt.str[4]  -- "Lever"
evt.map[17] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 6, State = 1}
		evt.SetDoorState{Id = 7, State = 0}
		evt.SetDoorState{Id = 8, State = 1}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[18] = evt.str[4]  -- "Lever"
evt.map[18] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 6, State = 1}
		evt.SetDoorState{Id = 7, State = 1}
		evt.SetDoorState{Id = 8, State = 0}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = true}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[19] = evt.str[4]  -- "Lever"
evt.map[19] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 9, State = 0}
		evt.SetDoorState{Id = 5, State = 1}
		evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[20] = evt.str[4]  -- "Lever"
evt.map[20] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetDoorState{Id = 5, State = 1}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[21] = evt.str[4]  -- "Lever"
evt.map[21] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 11, State = 0}
		evt.SetDoorState{Id = 5, State = 1}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = false}
		evt.Set("MapVar10", 1)
	end
end

evt.hint[22] = evt.str[4]  -- "Lever"
evt.map[22] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetDoorState{Id = 12, State = 0}
		evt.SetDoorState{Id = 13, State = 0}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 4, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 5, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 6, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 7, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 8, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 9, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Untouchable, On = true}
		evt.Subtract("QBits", 30)         -- "Rescue the Minotaurs trapped in their lair in Ravage Roaming."
		evt.ShowMovie{DoubleSize = 1, Name = "\"savemino\" "}
		evt.Set("MapVar9", 1)
	end
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

evt.HouseDoor(201, 183)  -- "Minotaur Leader's Room"
evt.HouseDoor(203, 402)  -- "Thanys' House"
evt.house[204] = 402  -- "Thanys' House"
evt.house[205] = 403  -- "Ferris' House"
evt.map[205] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(403)         -- "Ferris' House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[206] = 403  -- "Ferris' House"
evt.HouseDoor(207, 404)  -- "Flooded House"
evt.house[208] = 404  -- "Flooded House"
evt.HouseDoor(209, 404)  -- "Flooded House"
evt.house[210] = 404  -- "Flooded House"
evt.house[211] = 406  -- "Weapon shop placeholder"
evt.map[211] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(406)         -- "Weapon shop placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[212] = 406  -- "Weapon shop placeholder"
evt.house[213] = 407  -- "Suretail House"
evt.map[213] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(407)         -- "Suretail House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[214] = 407  -- "Suretail House"
evt.house[215] = 408  -- "Rionel's House"
evt.map[215] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(408)         -- "Rionel's House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[216] = 408  -- "Rionel's House"
evt.house[217] = 409  -- "Armor shop placeholder"
evt.map[217] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(409)         -- "Armor shop placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[218] = 409  -- "Armor shop placeholder"
evt.house[219] = 410  -- "Magic shop placeholder"
evt.map[219] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(410)         -- "Magic shop placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[220] = 410  -- "Magic shop placeholder"
evt.house[221] = 411  -- "Spell shop placeholder"
evt.map[221] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(411)         -- "Spell shop placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[222] = 411  -- "Spell shop placeholder"
evt.house[223] = 412  -- "Ulbrecht's House"
evt.map[223] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(412)         -- "Ulbrecht's House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[224] = 412  -- "Ulbrecht's House"
evt.house[225] = 413  -- "Senjac's House"
evt.map[225] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(413)         -- "Senjac's House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[226] = 413  -- "Senjac's House"
evt.house[227] = 414  -- "Alchemist placeholder"
evt.map[227] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(414)         -- "Alchemist placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[228] = 414  -- "Alchemist placeholder"
evt.house[229] = 415  -- "Temple placeholder"
evt.map[229] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(415)         -- "Temple placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[230] = 415  -- "Temple placeholder"
evt.hint[401] = evt.str[6]  -- "Fountain"
evt.hint[451] = evt.str[7]  -- "Drink from the Fountain"
evt.map[451] = function()
	if not evt.Cmp("QBits", 184) then         -- Balthazar Town Portal
		evt.Add("QBits", 184)         -- Balthazar Town Portal
	end
	if not evt.Cmp("HasFullHP", 0) then
		evt.Add("HP", 25)
		evt.StatusText(30)         -- "Your wounds begin to heal"
		evt.Add("AutonotesBits", 266)         -- "Fountain in Balthazar Lair restores Hit Points."
	end
end

evt.house[452] = 416  -- "Lotts' House"
evt.map[452] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(416)         -- "Lotts' House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[453] = 416  -- "Lotts' House"
evt.house[454] = 417  -- "Hollyfield House"
evt.map[454] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(417)         -- "Hollyfield House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[455] = 417  -- "Hollyfield House"
evt.house[456] = 418  -- "Tessalar's House"
evt.map[456] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(418)         -- "Tessalar's House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[457] = 418  -- "Tessalar's House"
evt.house[458] = 419  -- "Stormeye's House"
evt.map[458] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(419)         -- "Stormeye's House"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[459] = 419  -- "Stormeye's House"
evt.house[460] = 420  -- "Bank placeholder"
evt.map[460] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(420)         -- "Bank placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[461] = 420  -- "Bank placeholder"
evt.house[462] = 421  -- "Training hall placeholder"
evt.map[462] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(421)         -- "Training hall placeholder"
	else
		evt.EnterHouse(404)         -- "Flooded House"
	end
end

evt.house[463] = 421  -- "Training hall placeholder"
evt.house[464] = 6  -- "Ayzar's Axes"
evt.map[464] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(6)         -- "Ayzar's Axes"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[465] = 6  -- "Ayzar's Axes"
evt.house[466] = 20  -- "Linked Mail"
evt.map[466] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(20)         -- "Linked Mail"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[467] = 20  -- "Linked Mail"
evt.house[468] = 34  -- "Amulets of Power"
evt.map[468] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(34)         -- "Amulets of Power"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[469] = 34  -- "Amulets of Power"
evt.house[470] = 47  -- "Perius' Powders"
evt.map[470] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(47)         -- "Perius' Powders"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[471] = 47  -- "Perius' Powders"
evt.house[472] = 79  -- "The Shaman"
evt.map[472] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(79)         -- "The Shaman"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[473] = 79  -- "The Shaman"
evt.house[474] = 94  -- "Balthazar Academy"
evt.map[474] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(94)         -- "Balthazar Academy"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[475] = 94  -- "Balthazar Academy"
evt.house[476] = 132  -- "Bank of Balthazar"
evt.map[476] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(132)         -- "Bank of Balthazar"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[477] = 132  -- "Bank of Balthazar"
evt.house[478] = 145  -- "Guild of Mind"
evt.map[478] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.EnterHouse(145)         -- "Guild of Mind"
	else
		evt.EnterHouse(405)         -- "Flooded Shop"
	end
end

evt.house[479] = 145  -- "Guild of Mind"
evt.hint[501] = evt.str[1]  -- "Leave Balthazar Lair"
evt.map[501] = function()
	evt.MoveToMap{X = -10869, Y = -8850, Z = 1985, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out08.odm"}
end

evt.hint[502] = evt.str[1]  -- "Leave Balthazar Lair"
evt.map[502] = function()
	evt.MoveToMap{X = -12279, Y = -12153, Z = 2752, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out08.odm"}
end

