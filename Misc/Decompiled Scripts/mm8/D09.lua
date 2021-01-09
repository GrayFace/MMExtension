local TXT = Localize{
	[0] = " ",
	[1] = "Leave Merchant House of Alvar",
	[2] = "Door",
	[3] = "Chest",
	[4] = "Lever",
	[5] = "Button",
	[6] = "Crate",
	[7] = "",
	[8] = "",
	[9] = "Bookshelf",
	[10] = "You found nothing of interest",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[5] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.hint[11] = evt.str[6]  -- "Crate"
evt.map[11] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[12] = evt.str[9]  -- "Bookshelf"
evt.map[12] = function()
	if evt.Cmp("QBits", 13) then         -- "Form an alliance among the major factions of Jadame."
		evt.SetDoorState{Id = 2, State = 0}
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[13] = evt.str[2]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 5, State = 0}
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

evt.house[171] = 175  -- "Council Chamber Door"
evt.map[171] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
		return
	end
	if evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		evt.SetNPCTopic{NPC = 53, Index = 1, Event = 111}         -- "Elgar Fellmoon" : "Ironfists' Arrival"
		evt.SetNPCTopic{NPC = 65, Index = 0, Event = 118}         -- "Sir Charles Quixote" : "Xanthor"
		evt.SetNPCTopic{NPC = 66, Index = 0, Event = 125}         -- "Deftclaw Redreaver" : "Quixote's Treasure"
		evt.SetNPCTopic{NPC = 67, Index = 0, Event = 132}         -- "Oskar Tyre" : "Ironfists"
		evt.SetNPCTopic{NPC = 68, Index = 0, Event = 139}         -- "Masul" : "Catherine Ironfist"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 146}         -- "Sandro" : "Wizards"
	elseif not evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
			goto _6
		end
		if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
			goto _6
		end
	end
::_28::
	evt.EnterHouse(175)         -- "Council Chamber Door"
	do return end
::_6::
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		goto _9
	end
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		goto _9
	end
	goto _28
::_9::
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.Add("QBits", 34)         -- Alliance Council formed. Quest 13 done.
		evt.SetNPCTopic{NPC = 53, Index = 0, Event = 106}         -- "Elgar Fellmoon" : "Ironfists"
		evt.SetNPCTopic{NPC = 53, Index = 1, Event = 108}         -- "Elgar Fellmoon" : "Pirates"
		evt.SetNPCTopic{NPC = 65, Index = 0, Event = 117}         -- "Sir Charles Quixote" : "Blackwell Cooper"
		evt.SetNPCTopic{NPC = 66, Index = 0, Event = 124}         -- "Deftclaw Redreaver" : "Regna Island"
		evt.SetNPCTopic{NPC = 67, Index = 0, Event = 131}         -- "Oskar Tyre" : "Mace of the Sun"
		evt.SetNPCTopic{NPC = 68, Index = 0, Event = 138}         -- "Masul" : "Pirate Raid"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 145}         -- "Sandro" : "Pirate Mages"
		evt.Subtract("QBits", 13)         -- "Form an alliance among the major factions of Jadame."
	end
	goto _28
end

evt.hint[452] = evt.str[9]  -- "Bookshelf"
evt.map[452] = function()
	local i
	if evt.Cmp("MapVar52", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		i = Game.Rand() % 6
		if i == 4 or i == 5 then
			return
		end
		goto _15
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Scroll_, Id = 0}
::_15::
	evt.Add("MapVar52", 1)
end

evt.hint[453] = evt.str[9]  -- "Bookshelf"
evt.map[453] = function()
	if not evt.Cmp("MapVar39", 1) then
		evt.Add("Inventory", 744)         -- "History of the Vault of Time"
		evt.Add("MapVar39", 1)
	end
end

evt.hint[454] = evt.str[9]  -- "Bookshelf"
evt.map[454] = function()
	local i
	if evt.Cmp("MapVar49", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		i = Game.Rand() % 6
		if i == 4 or i == 5 then
			return
		end
		goto _15
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Scroll_, Id = 0}
::_15::
	evt.Add("MapVar49", 1)
end

evt.hint[455] = evt.str[9]  -- "Bookshelf"
evt.map[455] = function()
	local i
	if evt.Cmp("MapVar50", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		i = Game.Rand() % 6
		if i == 4 or i == 5 then
			return
		end
		goto _15
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_15::
	evt.Add("MapVar50", 1)
end

evt.hint[456] = evt.str[9]  -- "Bookshelf"
evt.map[456] = function()
	local i
	if evt.Cmp("MapVar51", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		i = Game.Rand() % 6
		if i == 4 or i == 5 then
			return
		end
		goto _15
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 2, Type = const.ItemType.Scroll_, Id = 0}
::_15::
	evt.Add("MapVar51", 1)
end

evt.hint[457] = evt.str[9]  -- "Bookshelf"
evt.map[457] = function()
	local i
	if evt.Cmp("MapVar53", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		i = Game.Rand() % 6
		if i == 4 or i == 5 then
			return
		end
		goto _15
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 2, Type = const.ItemType.Scroll_, Id = 0}
::_15::
	evt.Add("MapVar53", 1)
end

evt.hint[458] = evt.str[9]  -- "Bookshelf"
evt.map[458] = function()
	if not evt.Cmp("MapVar40", 1) then
		evt.Add("Inventory", 747)         -- "Page Torn from a Book"
		evt.Add("MapVar40", 1)
	end
end

evt.hint[459] = evt.str[9]  -- "Bookshelf"
evt.hint[460] = evt.str[9]  -- "Bookshelf"
evt.hint[461] = evt.str[9]  -- "Bookshelf"
evt.hint[462] = evt.str[9]  -- "Bookshelf"
evt.hint[463] = evt.str[9]  -- "Bookshelf"
evt.hint[464] = evt.str[9]  -- "Bookshelf"
evt.hint[465] = evt.str[9]  -- "Bookshelf"
evt.hint[466] = evt.str[9]  -- "Bookshelf"
evt.hint[467] = evt.str[9]  -- "Bookshelf"
evt.hint[468] = evt.str[9]  -- "Bookshelf"
evt.hint[469] = evt.str[9]  -- "Bookshelf"
evt.hint[470] = evt.str[9]  -- "Bookshelf"
evt.hint[471] = evt.str[9]  -- "Bookshelf"
evt.hint[501] = evt.str[1]  -- "Leave Merchant House of Alvar"
evt.map[501] = function()
	evt.MoveToMap{X = 12894, Y = -12153, Z = 257, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out02.odm"}
end

evt.hint[502] = evt.str[1]  -- "Leave Merchant House of Alvar"
evt.map[502] = function()
	evt.MoveToMap{X = 11284, Y = -11009, Z = 258, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "Out02.odm"}
end
