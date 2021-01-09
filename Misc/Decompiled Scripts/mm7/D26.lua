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

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 210) then         -- The Pit - Town Portal
		evt.Add("QBits", 210)         -- The Pit - Town Portal
	end
	if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		goto _8
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if evt.Cmp("Counter10", 720) then
			evt.Subtract("QBits", 270)         -- Your friends are mad at you 
			evt.Set("MapVar4", 0)
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
			return
		end
		goto _8
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_9::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
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
	if evt.Cmp("QBits", 109) then         -- "Assassinate Tolberti in his house in the Pit and return his control cube to Robert the Wise in Celeste."
		evt.MoveToMap{X = -15360, Y = 3808, Z = 129, Direction = 270, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
		return
	end
	if evt.Cmp("QBits", 110) then         -- Finished Necro Proving Grounds
		if evt.Cmp("QBits", 111) then         -- Finished Necro Task 2 - Temple of Light
			if evt.Cmp("QBits", 112) then         -- Finished Necro Task 3 - Soul Jars
				if evt.Cmp("QBits", 113) then         -- Finished Necro Task 4 - Clanker's Lab
					if not evt.Cmp("QBits", 118) then         -- Killed Good MM3 Person
						if not evt.Cmp("QBits", 198) then         -- Archibald in Clankers Lab now
							evt.SetNPCGreeting{NPC = 87, Greeting = 133}         -- "Tolberti" : "Welcome, friends."
							evt.Add("QBits", 198)         -- Archibald in Clankers Lab now
							evt.SetNPCGreeting{NPC = 88, Greeting = 135}         -- "Archibald Ironfist" : "Good to see you again, my friends.  You are welcome to visit anytime."
							evt.MoveNPC{NPC = 88, HouseId = 0}         -- "Archibald Ironfist"
							evt.MoveNPC{NPC = 84, HouseId = 184}         -- "Kastore" -> "Throne Room"
							evt.SetNPCTopic{NPC = 84, Index = 4, Event = 262}         -- "Kastore" : "Dark Magic Grandmaster"
							evt.SetNPCTopic{NPC = 88, Index = 1, Event = 0}         -- "Archibald Ironfist"
						end
					end
				end
			end
		end
	end
	evt.EnterHouse(433)         -- "Hostel"
end

evt.hint[415] = evt.str[50]  -- "Obelisk"
evt.map[415] = function()
	if not evt.Cmp("QBits", 170) then         -- Visited Obelisk in Area 8
		evt.StatusText(51)         -- "srhtfnut"
		evt.Add("AutonotesBits", 120)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 170)         -- Visited Obelisk in Area 8
	end
end

evt.hint[416] = evt.str[9]  -- "House"
evt.HouseDoor(417, 20)  -- "Shields of Malice"
evt.house[418] = 20  -- "Shields of Malice"
evt.HouseDoor(419, 6)  -- "Blades of Spite"
evt.house[420] = 6  -- "Blades of Spite"
evt.HouseDoor(421, 132)  -- "Frozen Assets"
evt.house[422] = 132  -- "Frozen Assets"
evt.HouseDoor(423, 36)  -- "Eldritch Influences"
evt.house[424] = 36  -- "Eldritch Influences"
evt.HouseDoor(425, 154)  -- "Paramount Guild of Earth"
evt.house[426] = 154  -- "Paramount Guild of Earth"
evt.HouseDoor(427, 170)  -- "Guild of Night"
evt.house[428] = 170  -- "Guild of Night"
evt.HouseDoor(429, 49)  -- "Infernal Temptations"
evt.house[430] = 49  -- "Infernal Temptations"
evt.HouseDoor(431, 106)  -- "Hall of Midnight"
evt.house[432] = 106  -- "Hall of Midnight"
evt.HouseDoor(433, 94)  -- "Perdition's Flame"
evt.house[434] = 94  -- "Perdition's Flame"
evt.HouseDoor(435, 114)  -- "The Vampyre Lounge "
evt.house[436] = 114  -- "The Vampyre Lounge "
evt.HouseDoor(438, 443)  -- "Hostel"
evt.HouseDoor(439, 441)  -- "Hostel"
evt.HouseDoor(440, 434)  -- "Hostel"
evt.house[441] = 442  -- "Hostel"
evt.map[441] = function()
	if evt.Cmp("QBits", 198) then         -- Archibald in Clankers Lab now
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(442)         -- "Hostel"
	end
end

evt.HouseDoor(442, 435)  -- "House Umberpool"
evt.HouseDoor(443, 437)  -- "Sand Residence"
evt.HouseDoor(444, 436)  -- "Darkenmore Residence"
evt.HouseDoor(445, 438)  -- "Hostel"
evt.HouseDoor(446, 444)  -- "Hostel"
evt.HouseDoor(447, 439)  -- "Hostel"
evt.HouseDoor(448, 440)  -- ""
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

evt.HouseDoor(502, 81)  -- "Temple of Dark"
evt.hint[503] = evt.str[32]  -- "Enter the Breeding Zone"
evt.map[503] = function()
	evt.MoveToMap{X = -320, Y = -1216, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 205, Icon = 2, Name = "D10.blv"}         -- "Breeding Zone"
end

evt.hint[504] = evt.str[30]  -- "Enter Castle Gloaming"
evt.map[504] = function()
	evt.MoveToMap{X = 96, Y = 3424, Z = 1, Direction = 1088, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end

evt.hint[505] = evt.str[30]  -- "Enter Castle Gloaming"
evt.map[505] = function()
	evt.MoveToMap{X = 874, Y = -261, Z = -377, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 9, Name = "d03.blv"}         -- "Castle Gloaming"
end

