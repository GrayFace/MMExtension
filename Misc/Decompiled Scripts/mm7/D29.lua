local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Castle Harmondale",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "Enter the Throne Room",
	[21] = "The door is blocked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 206) then         -- Harmondale - Town Portal
		evt.Add("QBits", 206)         -- Harmondale - Town Portal
	end
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetDoorState{Id = 35, State = 0}
		evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
		evt.SetTexture{Facet = 4, Name = "tfb09r1a"}
		evt.SetTexture{Facet = 5, Name = "tfb09r1b"}
		evt.SetTexture{Facet = 6, Name = "tfb09r1c"}
		evt.SetTexture{Facet = 7, Name = "tfb09r1d"}
		evt.SetTexture{Facet = 8, Name = "tfb09r1e"}
		evt.SetTexture{Facet = 9, Name = "tfb09r1f"}
		evt.SetTexture{Facet = 10, Name = "tfb09r1g"}
		evt.SetTexture{Facet = 11, Name = "tfb09r1h"}
		evt.SetTexture{Facet = 12, Name = "tfb09r1i"}
		evt.SetTexture{Facet = 13, Name = "tfb09r1j"}
	else
		evt.SetTexture{Facet = 1, Name = "ch1b1"}
		evt.SetTexture{Facet = 3, Name = "ch1b1"}
		evt.SetTexture{Facet = 14, Name = "ch1b1el"}
		evt.SetTexture{Facet = 15, Name = "ch1b1er"}
		evt.SetTexture{Facet = 16, Name = "ch1b1"}
		evt.SetTexture{Facet = 17, Name = "ch1b1"}
		evt.SetTexture{Facet = 19, Name = "ch1b1"}
		evt.SetTexture{Facet = 20, Name = "ch1b1"}
	end
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return
		end
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			return
		end
		evt.SetTexture{Facet = 19, Name = "nechuma"}
		evt.SetTexture{Facet = 20, Name = "nechumb"}
	elseif not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		return
	else
		evt.SetTexture{Facet = 19, Name = "wizh-a"}
		evt.SetTexture{Facet = 20, Name = "wizh-b"}
	end
	evt.SetDoorState{Id = 36, State = 0}
	evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Invisible, On = false}
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 135) then         -- Player castle goblins are all dead
		if evt.CheckMonstersKilled{CheckType = 1, Id = 5, Count = 0} then
			evt.ForPlayer("All")
			evt.Set("QBits", 135)         -- Player castle goblins are all dead
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[10] = evt.str[100]  -- ""
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.map[15] = function()
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetDoorState{Id = 15, State = 0}
end

evt.map[16] = function()
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetDoorState{Id = 16, State = 0}
end

evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 27, State = 0}
end

evt.map[26] = function()
	evt.SetDoorState{Id = 28, State = 0}
end

evt.hint[27] = evt.str[1]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[28] = evt.str[1]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[29] = evt.str[1]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 31, State = 0}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[32] = evt.str[10]  -- "Bookcase"
evt.map[32] = function()
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[33] = evt.str[1]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.hint[34] = evt.str[1]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[7]  -- "Cabinet"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[7]  -- "Cabinet"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[7]  -- "Cabinet"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[196] = evt.str[10]  -- "Bookcase"
evt.map[196] = function()
	local i
	if not evt.Cmp("QBits", 145) then         -- Membership to the School of Sorcery Scroll Shop
		return
	end
	if evt.Cmp("MapVar2", 3) then
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
		goto _16
	elseif i == 5 then
		goto _17
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_16::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_17::
	evt.Add("MapVar2", 1)
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
evt.map[197] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Add("Inventory", 703)         -- "Basic Cryptography"
		evt.Set("MapVar1", 1)
	end
end

evt.hint[376] = evt.str[100]  -- ""
evt.map[376] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 46) then         -- Player Castle.  Golem should appear in castle bit.
		return
	end
	if evt.Cmp("QBits", 73) then         -- Finished constructing Golem with Abbey normal head
		evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
	elseif not evt.Cmp("QBits", 74) then         -- Finished constructing Golem with normal head
		return
	end
	evt.Subtract("NPCs", 56)         -- "Golem"
	evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
end

events.LoadMap = evt.map[376].last

evt.hint[377] = evt.str[100]  -- ""
evt.map[377] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 14) then         -- Accepted Fireball wand from Malwick
		return
	end
	if evt.Cmp("QBits", 190) then         -- Finished with Malwick & Assc.
		return
	end
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		goto _14
	end
	if not evt.Cmp("QBits", 182) then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		if not evt.Cmp("QBits", 181) then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
			return
		end
		if not evt.Cmp("Counter5", 336) then
			return
		end
	elseif not evt.Cmp("Counter5", 672) then
		return
	end
	evt.ForPlayer("All")
	evt.Add("QBits", 183)         -- Failed either goto or do guild quest
::_14::
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
	evt.Set("BankGold", 0)
	evt.Subtract("QBits", 181)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
end

events.LoadMap = evt.map[377].last

evt.hint[378] = evt.str[100]  -- ""
evt.map[378] = function()  -- Timer(<function>, 10*const.Minute)
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		if not evt.Cmp("QBits", 184) then         -- Killed all castle monsters
			if evt.CheckMonstersKilled{CheckType = 1, Id = 9, Count = 0} then
				evt.ForPlayer("All")
				evt.Add("QBits", 184)         -- Killed all castle monsters
				if evt.Cmp("QBits", 185) then         -- Killed all outdoor monsters
					evt.ForPlayer("All")
					evt.Add("QBits", 190)         -- Finished with Malwick & Assc.
					evt.Subtract("QBits", 183)         -- Failed either goto or do guild quest
				end
			end
		end
	end
end

Timer(evt.map[378].last, 10*const.Minute)

evt.house[416] = 280  -- ""
evt.map[416] = function()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse(280)         -- ""
		return
	end
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			evt.EnterHouse(281)         -- ""
			return
		end
	end
	evt.EnterHouse(86)         -- "Sanctuary"
end

evt.house[417] = 280  -- ""
evt.map[417] = function()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse(280)         -- ""
		return
	end
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			evt.EnterHouse(281)         -- ""
			return
		end
	end
	evt.EnterHouse(51)         -- "Beakers and Bottles"
end

evt.house[418] = 280  -- ""
evt.map[418] = function()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse(280)         -- ""
		return
	end
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			evt.EnterHouse(281)         -- ""
			return
		end
	end
	evt.EnterHouse(25)         -- "Thel's Armor and Shields"
end

evt.house[419] = 280  -- ""
evt.map[419] = function()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse(280)         -- ""
		return
	end
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			evt.EnterHouse(281)         -- ""
			return
		end
	end
	evt.EnterHouse(11)         -- "Swords Inc."
end

evt.house[420] = 174  -- "Throne Room"
evt.map[420] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.EnterHouse(174)         -- "Throne Room"
	else
		evt.StatusText(21)         -- "The door is blocked"
	end
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()  -- function events.LoadMap()
	evt.Set("MapVar3", 10)
	evt.Set("MapVar4", 10)
	if evt.Cmp("QBits", 84) then         -- Gave artifact to humans
		evt.Subtract("MapVar3", 1)
	elseif evt.Cmp("QBits", 85) then         -- Gave artifact to elves
		evt.Add("MapVar3", 1)
	elseif not evt.Cmp("QBits", 147) then         -- Gave artifact to arbiter
		evt.Set("MapVar4", 13)
	end
	if evt.Cmp("QBits", 80) then         -- Gave plans to elfking
		evt.Add("MapVar3", 1)
	elseif not evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
		goto _18
	else
		evt.Subtract("MapVar3", 1)
	end
	evt.Subtract("MapVar4", 1)
::_18::
	if evt.Cmp("QBits", 81) then         -- Gave Loren to Catherine
		evt.Subtract("MapVar3", 1)
	elseif not evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
		goto _25
	else
		evt.Add("MapVar3", 1)
	end
	evt.Subtract("MapVar4", 1)
::_25::
	if not evt.Cmp("MapVar4", 12) then
		if evt.Cmp("MapVar3", 11) then
			evt.SetTexture{Facet = 16, Name = "elfhuma"}
			evt.SetTexture{Facet = 17, Name = "elfhumb"}
		elseif not evt.Cmp("MapVar3", 10) then
			evt.SetTexture{Facet = 16, Name = "chb1p6"}
			evt.SetTexture{Facet = 17, Name = "chb1p7"}
		elseif not evt.Cmp("MapVar4", 11) then
			evt.SetTexture{Facet = 16, Name = "bannwc-a"}
			evt.SetTexture{Facet = 17, Name = "bannwc-b"}
		end
	end
end

events.LoadMap = evt.map[451].last

evt.hint[501] = evt.str[2]  -- "Leave Castle Harmondale"
evt.map[501] = function()
	evt.MoveToMap{X = -18325, Y = 12564, Z = 480, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "out02.odm"}
end

