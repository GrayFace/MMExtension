local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Pit",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "House",
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
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Castle Gloaming",
	[26] = "Temple of the Dark",
	[27] = "The Breeding Zone",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Gloaming",
	[31] = "Enter The Temple of the Dark",
	[32] = "Enter the Breeding Zone",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "srhtfnut",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 293) then         -- Return to NWC
		goto _16
	end
	if not evt.Cmp("QBits", 210) then         -- The Pit - Town Portal
		evt.Add("QBits", 210)         -- The Pit - Town Portal
	end
	if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		goto _8
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if not evt.Cmp("Counter10", 720) then
			goto _8
		end
		evt.Subtract("QBits", 270)         -- Your friends are mad at you 
		evt.Set("MapVar4", 0)
		goto _16
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_9::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_16::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
	do return end
::_8::
	evt.Set("MapVar4", 2)
	goto _9
end

events.LoadMap = evt.map[1].last

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

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
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

evt.house[376] = 433  -- "Hostel"
evt.map[376] = function()
	if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		if not evt.Cmp("QBits", 302) then         -- Small House only Once
			if evt.Cmp("QBits", 303) then         -- Reward
				evt.MoveToMap{X = -15360, Y = 3808, Z = 129, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
			else
				if evt.Cmp("QBits", 299) then         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
					evt.MoveToMap{X = 0, Y = 3808, Z = 129, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
				end
			end
		end
	end
end

evt.hint[415] = evt.str[50]  -- "Obelisk"
evt.map[415] = function()
	if not evt.Cmp("QBits", 170) then         -- Visited Obelisk in Area 8
		evt.StatusText(51)         -- "srhtfnut"
		evt.Add("AutonotesBits", 120)         -- "Obelisk message #7: srhtfnut"
		evt.ForPlayer("All")
		evt.Add("QBits", 170)         -- Visited Obelisk in Area 8
	end
end

evt.hint[416] = evt.str[9]  -- "House"
evt.house[417] = 20  -- "Shields of Malice"
evt.map[417] = function()
	evt.EnterHouse(20)         -- "Shields of Malice"
end

evt.house[418] = 20  -- "Shields of Malice"
evt.map[418] = function()
end

evt.house[419] = 6  -- "Blades of Spite"
evt.map[419] = function()
	evt.EnterHouse(6)         -- "Blades of Spite"
end

evt.house[420] = 6  -- "Blades of Spite"
evt.map[420] = function()
end

evt.house[421] = 132  -- "Frozen Assets"
evt.map[421] = function()
	evt.EnterHouse(132)         -- "Frozen Assets"
end

evt.house[422] = 132  -- "Frozen Assets"
evt.map[422] = function()
end

evt.house[423] = 36  -- "Eldritch Influences"
evt.map[423] = function()
	evt.EnterHouse(36)         -- "Eldritch Influences"
end

evt.house[424] = 36  -- "Eldritch Influences"
evt.map[424] = function()
end

evt.house[425] = 154  -- "Paramount Guild of Earth"
evt.map[425] = function()
	evt.EnterHouse(154)         -- "Paramount Guild of Earth"
end

evt.house[426] = 154  -- "Paramount Guild of Earth"
evt.map[426] = function()
end

evt.house[427] = 170  -- "Guild of Night"
evt.map[427] = function()
	evt.EnterHouse(170)         -- "Guild of Night"
end

evt.house[428] = 170  -- "Guild of Night"
evt.map[428] = function()
end

evt.house[429] = 49  -- "Infernal Temptations"
evt.map[429] = function()
	evt.EnterHouse(49)         -- "Infernal Temptations"
end

evt.house[430] = 49  -- "Infernal Temptations"
evt.map[430] = function()
end

evt.house[431] = 106  -- "Hall of Midnight"
evt.map[431] = function()
	evt.EnterHouse(106)         -- "Hall of Midnight"
end

evt.house[432] = 106  -- "Hall of Midnight"
evt.map[432] = function()
end

evt.house[433] = 94  -- "Perdition's Flame"
evt.map[433] = function()
	evt.EnterHouse(94)         -- "Perdition's Flame"
end

evt.house[434] = 94  -- "Perdition's Flame"
evt.map[434] = function()
end

evt.house[435] = 114  -- "The Vampyre Lounge "
evt.map[435] = function()
	evt.EnterHouse(114)         -- "The Vampyre Lounge "
end

evt.house[436] = 114  -- "The Vampyre Lounge "
evt.map[436] = function()
end

evt.house[438] = 443  -- "Hostel"
evt.map[438] = function()
	evt.EnterHouse(443)         -- "Hostel"
end

evt.house[439] = 441  -- "Hostel"
evt.map[439] = function()
	evt.EnterHouse(441)         -- "Hostel"
end

evt.house[440] = 434  -- "Hostel"
evt.map[440] = function()
	evt.EnterHouse(434)         -- "Hostel"
end

evt.house[441] = 442  -- "Hostel"
evt.map[441] = function()
	if evt.Cmp("QBits", 198) then         -- Archibald in Clankers Lab now
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(442)         -- "Hostel"
	end
end

evt.house[442] = 435  -- "House Umberpool"
evt.map[442] = function()
	evt.EnterHouse(435)         -- "House Umberpool"
end

evt.house[443] = 437  -- "Sand Residence"
evt.map[443] = function()
	evt.EnterHouse(437)         -- "Sand Residence"
end

evt.house[444] = 436  -- "Darkenmore Residence"
evt.map[444] = function()
	evt.EnterHouse(436)         -- "Darkenmore Residence"
end

evt.house[445] = 438  -- "Hostel"
evt.map[445] = function()
	evt.EnterHouse(438)         -- "Hostel"
end

evt.house[446] = 444  -- "Hostel"
evt.map[446] = function()
	evt.EnterHouse(444)         -- "Hostel"
end

evt.house[447] = 439  -- "Hostel"
evt.map[447] = function()
	evt.EnterHouse(439)         -- "Hostel"
end

evt.house[448] = 440  -- ""
evt.map[448] = function()
	evt.EnterHouse(440)         -- ""
end

evt.map[452] = function()
	evt.MoveToMap{X = -1873, Y = -8516, Z = 64, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[453] = function()
	evt.MoveToMap{X = -1824, Y = -7136, Z = 33, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	evt.MoveToMap{X = -26354, Y = -10440, Z = 689, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[455] = evt.str[100]  -- ""
evt.map[455] = function()
	evt.MoveToMap{X = -2854, Y = -23128, Z = 625, Direction = 541, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[456] = evt.str[100]  -- ""
evt.map[456] = function()
	evt.MoveToMap{X = 6196, Y = -10401, Z = -362, Direction = 832, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[457] = evt.str[100]  -- ""
evt.map[457] = function()
	evt.MoveToMap{X = 9683, Y = -5602, Z = -19, Direction = 1600, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[501] = evt.str[2]  -- "Leave the Pit"
evt.map[501] = function()
	evt.MoveToMap{X = 498, Y = 16198, Z = 161, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "T04.blv"}
end

evt.house[502] = 81  -- "Temple of Dark"
evt.map[502] = function()
	evt.EnterHouse(81)         -- "Temple of Dark"
end

evt.hint[503] = evt.str[32]  -- "Enter the Breeding Zone"
evt.map[503] = function()
	evt.MoveToMap{X = -320, Y = -1216, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 2, Name = "D10.blv"}
end

evt.hint[504] = evt.str[30]  -- "Enter Castle Gloaming"
evt.map[504] = function()
	evt.MoveToMap{X = 96, Y = 3424, Z = 1, Direction = 1088, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end

evt.hint[505] = evt.str[30]  -- "Enter Castle Gloaming"
evt.map[505] = function()
	evt.MoveToMap{X = 874, Y = -261, Z = -377, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end

