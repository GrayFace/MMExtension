local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Wine Cellar",
	[26] = "The Mercenary Guild ",
	[27] = "Tidewater Caverns",
	[28] = "Lord Markham's Manor",
	[29] = "",
	[30] = "Enter the Wine Cellar",
	[31] = "Enter the Mercenary Guild",
	[32] = "Enter the Tidewater Caverns",
	[33] = "Enter Lord Markham's Manor",
	[34] = "Enter the Cave",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Wharf",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East to Steadwick",
	[43] = "North ",
	[44] = "Tatalia",
	[45] = "South ",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "e_laru_a",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Stone",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "You do not feel well.",
	[71] = "+2 Speed (Permanent)",
	[72] = "+20 Air Resistance (Temporary)",
	[73] = "+20 AC (Temporary)",
	[74] = "You decide it would be a bad idea to try that again.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	end
end

events.LoadMap = evt.map[1].last

evt.HouseDoor(3, 22)  -- "The Missing Link"
evt.house[4] = 22  -- "The Missing Link"
evt.HouseDoor(5, 59)  -- "Dry Saddles"
evt.house[6] = 59  -- "Dry Saddles"
evt.HouseDoor(7, 69)  -- "Narwhale"
evt.house[8] = 69  -- "Narwhale"
evt.HouseDoor(9, 83)  -- "The Order of Tatalia"
evt.house[10] = 83  -- "The Order of Tatalia"
evt.HouseDoor(11, 96)  -- "Training Essentials"
evt.house[12] = 96  -- "Training Essentials"
evt.HouseDoor(13, 118)  -- "The Loyal Mercenary"
evt.house[14] = 118  -- "The Loyal Mercenary"
evt.HouseDoor(15, 133)  -- "The Depository"
evt.house[16] = 133  -- "The Depository"
evt.HouseDoor(17, 161)  -- "Master Guild of Mind"
evt.house[18] = 161  -- "Master Guild of Mind"
evt.HouseDoor(19, 8)  -- "Vander's Blades & Bows"
evt.house[20] = 8  -- "Vander's Blades & Bows"
evt.HouseDoor(21, 12)  -- "Alloyed Weapons"
evt.house[22] = 12  -- "Alloyed Weapons"
evt.HouseDoor(23, 26)  -- "Alloyed Armor and Shields"
evt.house[24] = 26  -- "Alloyed Armor and Shields"
evt.hint[51] = evt.str[7]  -- "House"
evt.HouseDoor(52, 387)  -- "Steele Residence"
evt.HouseDoor(53, 388)  -- "Conscience Home"
evt.HouseDoor(54, 389)  -- "Everil's House"
evt.HouseDoor(57, 392)  -- "Tricia's House"
evt.HouseDoor(58, 393)  -- "Isram's House"
evt.HouseDoor(59, 394)  -- "Stonecleaver Residence"
evt.HouseDoor(61, 396)  -- "Calindra's Home"
evt.HouseDoor(62, 397)  -- "Brother Bombah's"
evt.HouseDoor(63, 398)  -- "Redding Residence"
evt.HouseDoor(65, 400)  -- "Fist's House"
evt.HouseDoor(66, 401)  -- "Wacko's"
evt.HouseDoor(67, 402)  -- "Weldric's Home"
evt.HouseDoor(69, 404)  -- "Visconti Residence"
evt.HouseDoor(70, 405)  -- "Arin Residence"
evt.HouseDoor(73, 408)  -- "Sampson Residence"
evt.HouseDoor(75, 410)  -- "Taren's House"
evt.HouseDoor(76, 411)  -- "Moore Residence"
evt.HouseDoor(77, 412)  -- "Rothham's House"
evt.HouseDoor(78, 367)  -- "Greydawn Residence"
evt.HouseDoor(79, 368)  -- "Stormeye's House"
evt.HouseDoor(80, 369)  -- "Bremen Residence"
evt.HouseDoor(81, 351)  -- "Riverstone House"
evt.hint[151] = evt.str[1]  -- "Chest "
evt.map[151] = function()
	evt.OpenChest(1)
end

evt.hint[152] = evt.str[1]  -- "Chest "
evt.map[152] = function()
	evt.OpenChest(2)
end

evt.hint[153] = evt.str[1]  -- "Chest "
evt.map[153] = function()
	evt.OpenChest(3)
end

evt.hint[154] = evt.str[1]  -- "Chest "
evt.map[154] = function()
	evt.OpenChest(4)
end

evt.hint[155] = evt.str[1]  -- "Chest "
evt.map[155] = function()
	evt.OpenChest(5)
end

evt.hint[156] = evt.str[1]  -- "Chest "
evt.map[156] = function()
	evt.OpenChest(6)
end

evt.hint[157] = evt.str[1]  -- "Chest "
evt.map[157] = function()
	evt.OpenChest(7)
end

evt.hint[158] = evt.str[1]  -- "Chest "
evt.map[158] = function()
	evt.OpenChest(8)
end

evt.hint[159] = evt.str[1]  -- "Chest "
evt.map[159] = function()
	evt.OpenChest(9)
end

evt.hint[160] = evt.str[1]  -- "Chest "
evt.map[160] = function()
	evt.OpenChest(10)
end

evt.hint[161] = evt.str[1]  -- "Chest "
evt.map[161] = function()
	evt.OpenChest(11)
end

evt.hint[162] = evt.str[1]  -- "Chest "
evt.map[162] = function()
	evt.OpenChest(12)
end

evt.hint[163] = evt.str[1]  -- "Chest "
evt.map[163] = function()
	evt.OpenChest(13)
end

evt.hint[164] = evt.str[1]  -- "Chest "
evt.map[164] = function()
	evt.OpenChest(14)
end

evt.hint[165] = evt.str[1]  -- "Chest "
evt.map[165] = function()
	evt.OpenChest(15)
end

evt.hint[166] = evt.str[1]  -- "Chest "
evt.map[166] = function()
	evt.OpenChest(16)
end

evt.hint[167] = evt.str[1]  -- "Chest "
evt.map[167] = function()
	evt.OpenChest(17)
end

evt.hint[168] = evt.str[1]  -- "Chest "
evt.map[168] = function()
	evt.OpenChest(18)
end

evt.hint[169] = evt.str[1]  -- "Chest "
evt.map[169] = function()
	evt.OpenChest(19)
end

evt.hint[170] = evt.str[1]  -- "Chest "
evt.map[170] = function()
	evt.OpenChest(0)
	if not evt.Cmp("QBits", 70) then         -- Placed Golem left leg
		if not evt.Cmp("QBits", 221) then         -- Right arm - I lost it
			evt.Add("QBits", 221)         -- Right arm - I lost it
		end
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
evt.map[202] = function()
	if evt.Cmp("PlayerBits", 21) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 29) then         -- ""
		evt.Add("AutonotesBits", 29)         -- ""
	end
	evt.Add("ArmorClassBonus", 20)
	evt.Add("PlayerBits", 21)
	evt.StatusText(73)         -- "+20 AC (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 21)
end, const.Day)

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 20) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 28) then         -- ""
		evt.Add("AutonotesBits", 28)         -- ""
	end
	evt.Add("AirResBonus", 20)
	evt.Add("PlayerBits", 20)
	evt.StatusText(72)         -- "+20 Air Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 20)
end, const.Day)

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 19) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 27) then         -- ""
		evt.Add("AutonotesBits", 27)         -- ""
	end
	evt.Add("BaseSpeed", 2)
	evt.Add("PlayerBits", 19)
	evt.StatusText(71)         -- "+2 Speed (Permanent)"
end

evt.hint[205] = evt.str[26]  -- "The Mercenary Guild "
evt.hint[206] = evt.str[27]  -- "Tidewater Caverns"
evt.hint[207] = evt.str[28]  -- "Lord Markham's Manor"
evt.hint[208] = evt.str[44]  -- "Tatalia"
evt.hint[209] = evt.str[42]  -- "East to Steadwick"
evt.hint[210] = evt.str[38]  -- "Wharf"
evt.hint[211] = evt.str[35]  -- "Temple"
evt.hint[212] = evt.str[37]  -- "Stables"
evt.hint[213] = evt.str[55]  -- "Stone"
evt.hint[214] = evt.str[14]  -- "Drink"
evt.map[214] = function()
	local i
	if evt.Cmp("DiseasedGreen", 0) then
		goto _12
	end
	if evt.Cmp("DiseasedYellow", 0) then
		goto _12
	end
	if evt.Cmp("DiseasedRed", 0) then
		goto _12
	end
	i = Game.Rand() % 3
	if i == 1 then
		evt.Set("DiseasedGreen", 0)
	elseif i == 2 then
		evt.Set("DiseasedYellow", 0)
	else
		evt.Set("DiseasedRed", 0)
	end
	evt.StatusText(70)         -- "You do not feel well."
	do return end
::_12::
	evt.StatusText(74)         -- "You decide it would be a bad idea to try that again."
end

evt.hint[215] = evt.str[43]  -- "North "
evt.hint[401] = evt.str[53]  -- "Altar"
evt.map[401] = function()
	if evt.Cmp("QBits", 49) then         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
		if not evt.Cmp("QBits", 50) then         -- Visited all stonehenges
			if not evt.Cmp("QBits", 52) then         -- Visited stonehenge 2 (area 13)
				evt.StatusText(56)         -- ""
				evt.ForPlayer("All")
				evt.Set("QBits", 52)         -- Visited stonehenge 2 (area 13)
				evt.ForPlayer("All")
				evt.Add("QBits", 245)         -- "Congratulations"
				evt.Subtract("QBits", 245)         -- "Congratulations"
				if evt.Cmp("QBits", 51) then         -- Visited stonehenge 1 (area 9)
					if evt.Cmp("QBits", 53) then         -- Visited stonehenge 3 (area 14)
						evt.ForPlayer("All")
						evt.Set("QBits", 50)         -- Visited all stonehenges
					end
				end
			end
		end
	end
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if not evt.Cmp("QBits", 202) then         -- Place item 618 in out13(statue)
		if evt.Cmp("QBits", 200) then         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 618) then         -- "Eagle Statuette"
				evt.SetSprite{SpriteId = 25, Visible = 1, Name = "0"}
				evt.Subtract("Inventory", 618)         -- "Eagle Statuette"
				evt.Set("QBits", 202)         -- Place item 618 in out13(statue)
			end
		end
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 175) then         -- Visited Obelisk in Area 13
		evt.StatusText(51)         -- "e_laru_a"
		evt.Add("AutonotesBits", 125)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 175)         -- Visited Obelisk in Area 13
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 14) then         -- Accepted Fireball wand from Malwick
		if not evt.Cmp("QBits", 190) then         -- Finished with Malwick & Assc.
			if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
				return
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
			goto _12
		end
	end
	do return end
::_12::
	evt.ForPlayer("All")
	evt.Set("QBits", 183)         -- Failed either goto or do guild quest
	evt.SpeakNPC(98)         -- "Messenger"
end

events.LoadMap = evt.map[454].last

evt.hint[455] = evt.str[8]  -- ""
evt.hint[500] = evt.str[100]  -- ""
evt.map[500] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.CheckSeason(1) then
				evt.CheckSeason(0)
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter the Wine Cellar"
evt.map[501] = function()
	evt.MoveToMap{X = 601, Y = -512, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 215, Icon = 2, Name = "D16.blv"}         -- "Wine Cellar"
end

evt.hint[502] = evt.str[31]  -- "Enter the Mercenary Guild"
evt.map[502] = function()
	if not evt.Cmp("QBits", 14) then         -- Accepted Fireball wand from Malwick
		goto _6
	end
	if evt.Cmp("QBits", 190) then         -- Finished with Malwick & Assc.
		goto _6
	end
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		goto _14
	end
	if evt.Cmp("QBits", 181) then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
		if evt.Cmp("Counter5", 336) then
			goto _12
		end
	elseif not evt.Cmp("QBits", 182) then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		goto _6
	elseif evt.Cmp("Counter5", 672) then
		goto _12
	end
::_17::
	evt.SpeakNPC(99)         -- "Niles Stantley"
	do return end
::_6::
	evt.MoveToMap{X = 886, Y = 2601, Z = 1, Direction = 474, LookAngle = 0, SpeedZ = 0, HouseId = 213, Icon = 9, Name = "D20.blv"}         -- "Mercenary Guild"
	do return end
::_14::
	evt.SetNPCGreeting{NPC = 99, Greeting = 168}         -- "Niles Stantley" : "Your lack of punctuality has cost yourselves and your town grievously.  I think you may find your bank account somewhat… pinched.  Consider this an important lesson learned.  Good day."
	evt.Subtract("QBits", 181)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	goto _17
::_12::
	evt.ForPlayer("All")
	evt.Set("QBits", 183)         -- Failed either goto or do guild quest
	goto _14
end

evt.hint[503] = evt.str[32]  -- "Enter the Tidewater Caverns"
evt.map[503] = function()
	evt.MoveToMap{X = -1944, Y = -2052, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 214, Icon = 9, Name = "D17.blv"}         -- "Tidewater Caverns"
end

evt.hint[504] = evt.str[33]  -- "Enter Lord Markham's Manor"
evt.map[504] = function()
	evt.MoveToMap{X = -33, Y = -600, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "D18.blv"}
end

evt.hint[505] = evt.str[34]  -- "Enter the Cave"
evt.map[505] = function()
	evt.MoveToMap{X = -2568, Y = -143, Z = 97, Direction = 257, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt09.blv"}
end

