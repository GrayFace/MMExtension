local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Well of Experience",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "Not enough gold",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "You need the Home Key to use this teleporter.",
	[23] = "",
	[24] = "",
	[25] = "School of Sorcery",
	[26] = "Red Dwarf Mines",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter the School of Sorcery",
	[31] = "Enter the Red Dwarf Mines",
	[32] = "",
	[33] = "To Main Square",
	[34] = "Tavern",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "School of Sorcery",
	[41] = "Red Dwarf Mines",
	[42] = "East ",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = " ts_rehmu",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Home Portal",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "You make a wish",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "Suddenly, You Don't Feel too Well",
	[71] = "You Make a Wish",
	[72] = "+25 Intellect and Personality (Temporary)",
	[73] = "hmmm, You decide against it.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 303:0
-- ERROR: Duplicate label: 461:0

evt.hint[1] = evt.str[1]  -- "Chest "
evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 189) then         -- Killed all Bracada Desert Griffins
		if evt.CheckMonstersKilled{CheckType = 2, Id = 81, Count = 0} then
			if evt.CheckMonstersKilled{CheckType = 2, Id = 82, Count = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 83, Count = 0} then
					evt.ForPlayer("All")
					evt.Set("QBits", 189)         -- Killed all Bracada Desert Griffins
				end
			end
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[30] = evt.str[55]  -- "Home Portal"
evt.map[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 47) then         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
		evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "nwc.blv"}
	else
		if evt.Cmp("Inventory", 670) then         -- "Home Key"
			evt.MoveToMap{X = -9853, Y = 8656, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out03.Odm"}
		else
			evt.StatusText(22)         -- "You need the Home Key to use this teleporter."
		end
	end
end

evt.hint[35] = evt.str[100]  -- ""
evt.map[35] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 371) then         -- Dwarven Messenger Once
		if evt.Cmp("Awards", 8) then         -- "Completed Coding Wizard Quest"
			evt.SetNPCGreeting{NPC = 27, Greeting = 27}         -- "Messenger" : ""
			evt.SpeakNPC(27)         -- "Messenger"
			evt.Set("QBits", 369)         -- "Raise the siege of Stone City by killing all creatures in the Barrow Downs within one week and then proceed to King Hothffar for your reward."
			evt.Set("QBits", 371)         -- Dwarven Messenger Once
			evt.Subtract("QBits", 368)         -- Barrow Normal
			evt.Set("Counter2", 0)
		end
	end
end

events.LoadMap = evt.map[35].last

evt.hint[50] = evt.str[100]  -- ""
evt.hint[98] = evt.str[13]  -- "Dock"
evt.house[99] = 66  -- "Enchantress"
evt.map[99] = function()
	evt.EnterHouse(66)         -- "Enchantress"
end

evt.house[100] = 66  -- "Enchantress"
evt.map[100] = function()
end

evt.house[101] = 34  -- "Artifacts & Antiquities"
evt.map[101] = function()
	evt.EnterHouse(34)         -- "Artifacts & Antiquities"
end

evt.house[102] = 34  -- "Artifacts & Antiquities"
evt.map[102] = function()
end

evt.house[103] = 47  -- "Edmond's Ampules"
evt.map[103] = function()
	evt.EnterHouse(47)         -- "Edmond's Ampules"
end

evt.house[104] = 47  -- "Edmond's Ampules"
evt.map[104] = function()
end

evt.house[105] = 58  -- "Crystal Caravans"
evt.map[105] = function()
	evt.EnterHouse(58)         -- "Crystal Caravans"
end

evt.house[106] = 58  -- "Crystal Caravans"
evt.map[106] = function()
end

evt.house[107] = 79  -- "Temple of Light"
evt.map[107] = function()
	evt.EnterHouse(79)         -- "Temple of Light"
end

evt.house[108] = 79  -- "Temple of Light"
evt.map[108] = function()
end

evt.house[109] = 112  -- "Familiar Place"
evt.map[109] = function()
	evt.EnterHouse(112)         -- "Familiar Place"
end

evt.house[110] = 112  -- "Familiar Place"
evt.map[110] = function()
end

evt.house[111] = 149  -- "Master Guild of Water"
evt.map[111] = function()
	evt.EnterHouse(149)         -- "Master Guild of Water"
end

evt.house[112] = 149  -- "Master Guild of Water"
evt.map[112] = function()
end

evt.house[113] = 167  -- "Guild of Illumination"
evt.map[113] = function()
	evt.EnterHouse(167)         -- "Guild of Illumination"
end

evt.house[114] = 167  -- "Guild of Illumination"
evt.map[114] = function()
end

evt.hint[150] = evt.str[7]  -- "House"
evt.house[151] = 474  -- "Smiling Jack's"
evt.map[151] = function()
	evt.EnterHouse(474)         -- "Smiling Jack's"
end

evt.house[152] = 475  -- "Pederton Residence"
evt.map[152] = function()
	evt.EnterHouse(475)         -- "Pederton Residence"
end

evt.house[153] = 476  -- "Applebee Manor"
evt.map[153] = function()
	evt.EnterHouse(476)         -- "Applebee Manor"
end

evt.house[154] = 477  -- "Lightsworn Residence"
evt.map[154] = function()
	evt.EnterHouse(477)         -- "Lightsworn Residence"
end

evt.house[155] = 478  -- "Alashandra's Home"
evt.map[155] = function()
	evt.EnterHouse(478)         -- "Alashandra's Home"
end

evt.house[156] = 479  -- "Gayle's"
evt.map[156] = function()
	evt.EnterHouse(479)         -- "Gayle's"
end

evt.house[157] = 480  -- "Brigham's Home"
evt.map[157] = function()
	evt.EnterHouse(480)         -- "Brigham's Home"
end

evt.house[158] = 481  -- "Rowan's House"
evt.map[158] = function()
	evt.EnterHouse(481)         -- "Rowan's House"
end

evt.house[159] = 482  -- "Brand's Home"
evt.map[159] = function()
	evt.EnterHouse(482)         -- "Brand's Home"
end

evt.house[160] = 483  -- "Benson Residence"
evt.map[160] = function()
	evt.EnterHouse(483)         -- "Benson Residence"
end

evt.house[161] = 484  -- "Zimm's House"
evt.map[161] = function()
	evt.EnterHouse(484)         -- "Zimm's House"
end

evt.house[162] = 500  -- "Stone House"
evt.map[162] = function()
	evt.EnterHouse(500)         -- "Stone House"
end

evt.house[163] = 501  -- "Watershed Residence"
evt.map[163] = function()
	evt.EnterHouse(501)         -- "Watershed Residence"
end

evt.house[164] = 502  -- "Hollyfield Residence"
evt.map[164] = function()
	evt.EnterHouse(502)         -- "Hollyfield Residence"
end

evt.house[165] = 503  -- "Sweet Residence"
evt.map[165] = function()
	evt.EnterHouse(503)         -- "Sweet Residence"
end

evt.hint[201] = evt.str[1]  -- "Chest "
evt.map[201] = function()
	evt.OpenChest(1)
end

evt.hint[202] = evt.str[1]  -- "Chest "
evt.map[202] = function()
	evt.OpenChest(2)
end

evt.hint[203] = evt.str[1]  -- "Chest "
evt.map[203] = function()
	evt.OpenChest(3)
end

evt.hint[204] = evt.str[1]  -- "Chest "
evt.map[204] = function()
	evt.OpenChest(4)
end

evt.hint[205] = evt.str[1]  -- "Chest "
evt.map[205] = function()
	evt.OpenChest(5)
end

evt.hint[206] = evt.str[1]  -- "Chest "
evt.map[206] = function()
	evt.OpenChest(6)
end

evt.hint[207] = evt.str[1]  -- "Chest "
evt.map[207] = function()
	evt.OpenChest(7)
end

evt.hint[208] = evt.str[1]  -- "Chest "
evt.map[208] = function()
	evt.OpenChest(8)
end

evt.hint[209] = evt.str[1]  -- "Chest "
evt.map[209] = function()
	evt.OpenChest(9)
end

evt.hint[210] = evt.str[1]  -- "Chest "
evt.map[210] = function()
	evt.OpenChest(10)
end

evt.hint[211] = evt.str[1]  -- "Chest "
evt.map[211] = function()
	evt.OpenChest(11)
end

evt.hint[212] = evt.str[1]  -- "Chest "
evt.map[212] = function()
	evt.OpenChest(12)
end

evt.hint[213] = evt.str[1]  -- "Chest "
evt.map[213] = function()
	evt.OpenChest(13)
end

evt.hint[214] = evt.str[1]  -- "Chest "
evt.map[214] = function()
	evt.OpenChest(14)
end

evt.hint[215] = evt.str[1]  -- "Chest "
evt.map[215] = function()
	evt.OpenChest(15)
end

evt.hint[216] = evt.str[1]  -- "Chest "
evt.map[216] = function()
	evt.OpenChest(16)
end

evt.hint[217] = evt.str[1]  -- "Chest "
evt.map[217] = function()
	evt.OpenChest(17)
end

evt.hint[218] = evt.str[1]  -- "Chest "
evt.map[218] = function()
	evt.OpenChest(18)
end

evt.hint[219] = evt.str[1]  -- "Chest "
evt.map[219] = function()
	evt.OpenChest(19)
	if not evt.Cmp("QBits", 71) then         -- Placed Golem head
		if not evt.Cmp("QBits", 219) then         -- Golem Head - I lost it
			evt.Add("QBits", 219)         -- Golem Head - I lost it
		end
	end
end

evt.hint[220] = evt.str[1]  -- "Chest "
evt.map[220] = function()
	evt.OpenChest(0)
	if not evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
		if not evt.Cmp("QBits", 220) then         -- Abby normal head - I lost it
			evt.Add("QBits", 220)         -- Abby normal head - I lost it
		end
	end
end

evt.hint[222] = evt.str[100]  -- ""
evt.map[222] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		goto _5
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if not evt.Cmp("Counter10", 720) then
			goto _5
		end
		evt.Subtract("QBits", 270)         -- Your friends are mad at you 
		evt.Set("MapVar4", 0)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	else
		if evt.Cmp("MapVar4", 2) then
			goto _6
		end
	end
::_7::
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Southern Village Group in Harmondy"
	do return end
::_5::
	evt.Set("MapVar4", 2)
::_6::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	goto _7
end

events.LoadMap = evt.map[222].last

evt.hint[301] = evt.str[100]  -- ""
evt.map[301] = function()
	evt.MoveToMap{X = -9711, Y = 8872, Z = 2400, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[302] = evt.str[100]  -- ""
evt.map[302] = function()
	evt.MoveToMap{X = -5648, Y = 15992, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[303] = evt.str[100]  -- ""
evt.map[303] = function()
	evt.MoveToMap{X = 3000, Y = 17248, Z = 1600, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[304] = evt.str[100]  -- ""
evt.map[304] = function()
	evt.MoveToMap{X = -4608, Y = 16032, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[305] = evt.str[100]  -- ""
evt.map[305] = function()
	evt.MoveToMap{X = -6664, Y = 15040, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[306] = evt.str[100]  -- ""
evt.map[306] = function()
	evt.MoveToMap{X = -17624, Y = 20360, Z = 800, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[307] = evt.str[100]  -- ""
evt.map[307] = function()
	evt.MoveToMap{X = -5616, Y = 14992, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[308] = evt.str[100]  -- ""
evt.map[308] = function()
	evt.MoveToMap{X = -16064, Y = 8944, Z = 800, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[309] = evt.str[100]  -- ""
evt.map[309] = function()
	evt.MoveToMap{X = -4592, Y = 15000, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[310] = evt.str[100]  -- ""
evt.map[310] = function()
	evt.MoveToMap{X = 6464, Y = -19280, Z = 1376, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[311] = evt.str[100]  -- ""
evt.map[311] = function()
	evt.MoveToMap{X = -7160, Y = 13976, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[312] = evt.str[100]  -- ""
evt.map[312] = function()
	evt.MoveToMap{X = 17656, Y = -20704, Z = 800, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[313] = evt.str[100]  -- ""
evt.map[313] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.MoveToMap{X = -3040, Y = 992, Z = 1120, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 2 then
		evt.MoveToMap{X = -14848, Y = -18144, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 3 then
		evt.MoveToMap{X = 18112, Y = -8736, Z = 182, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 4 then
		evt.MoveToMap{X = 16288, Y = 17504, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	elseif i == 5 then
		evt.MoveToMap{X = -16192, Y = 10752, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -8192, Y = -64, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.hint[314] = evt.str[100]  -- ""
evt.map[314] = function()
	evt.MoveToMap{X = -7360, Y = 13504, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[315] = evt.str[100]  -- ""
evt.map[315] = function()
	evt.MoveToMap{X = 9208, Y = 18608, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[316] = evt.str[100]  -- ""
evt.map[316] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 664) then         -- "Emerald Is. Teleportal Key"
		evt.MoveToMap{X = 12409, Y = 4917, Z = -64, Direction = 1040, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out01.Odm"}
	else
		evt.MoveToMap{X = -4800, Y = 14552, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.hint[317] = evt.str[100]  -- ""
evt.map[317] = function()
	evt.MoveToMap{X = -6192, Y = 12744, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if not evt.Cmp("QBits", 203) then         -- Place item 619 in out06(statue)
		if evt.Cmp("QBits", 200) then         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 619) then         -- "Angel Statuette"
				evt.SetSprite{SpriteId = 25, Visible = 1, Name = "0"}
				evt.Subtract("Inventory", 619)         -- "Angel Statuette"
				evt.Set("QBits", 203)         -- Place item 619 in out06(statue)
			end
		end
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 168) then         -- Visited Obelisk in Area 6
		evt.StatusText(51)         -- " ts_rehmu"
		evt.Add("AutonotesBits", 118)         -- "Obelisk message #5: ts_rehmu"
		evt.ForPlayer("All")
		evt.Add("QBits", 168)         -- Visited Obelisk in Area 6
	end
end

evt.hint[454] = evt.str[40]  -- "School of Sorcery"
evt.hint[455] = evt.str[41]  -- "Red Dwarf Mines"
evt.hint[456] = evt.str[3]  -- "Well"
evt.hint[457] = evt.str[4]  -- "Drink from the Well"
evt.map[457] = function()
	if not evt.Cmp("BankGold", 99) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("MapVar19", 1) then
				evt.Add("Gold", 200)
				evt.Set("MapVar19", 1)
			end
		end
	end
	evt.StatusText(11)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar19", 0)
end, const.Week, true)

evt.hint[458] = evt.str[4]  -- "Drink from the Well"
evt.map[458] = function()
	evt.StatusText(11)         -- "Refreshing!"
end

evt.hint[459] = evt.str[8]  -- "Well of Experience"
evt.map[459] = function()
	if evt.Cmp("Gold", 10000) then
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.ForPlayer("Current")
		evt.Add("Experience", 10000)
	else
		evt.StatusText(16)         -- "Not enough gold"
	end
end

evt.hint[460] = evt.str[14]  -- "Drink"
evt.map[460] = function()
	local i
	if evt.Cmp("PoisonedGreen", 0) then
		goto _12
	end
	if evt.Cmp("PoisonedYellow", 0) then
		goto _12
	end
	if evt.Cmp("PoisonedRed", 0) then
		goto _12
	end
	i = Game.Rand() % 3
	if i == 1 then
		evt.Set("PoisonedGreen", 0)
	elseif i == 2 then
		evt.Set("PoisonedYellow", 0)
	else
		evt.Set("PoisonedRed", 0)
	end
	evt.StatusText(70)         -- "Suddenly, You Don't Feel too Well"
	do return end
::_12::
	evt.StatusText(73)         -- "hmmm, You decide against it."
end

evt.hint[461] = evt.str[6]  -- "Drink from the Fountain"
evt.map[461] = function()
	evt.MoveToMap{X = 3844, Y = 2906, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "d05.blv"}
	if not evt.Cmp("AutonotesBits", 18) then         -- "25 points of temporary Intellect and Personality from the fountain outside the School of Sorcery in the Bracada Desert."
		evt.Add("AutonotesBits", 18)         -- "25 points of temporary Intellect and Personality from the fountain outside the School of Sorcery in the Bracada Desert."
	end
	evt.Add("PersonalityBonus", 25)
	evt.Add("IntellectBonus", 25)
	evt.Add("PlayerBits", 13)
	evt.StatusText(72)         -- "+25 Intellect and Personality (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 13)
end, const.Day, 1*const.Hour)

evt.hint[462] = evt.str[35]  -- "Temple"
evt.hint[463] = evt.str[39]  -- "Shops"
evt.hint[464] = evt.str[34]  -- "Tavern"
evt.hint[465] = evt.str[36]  -- "Guilds"
evt.hint[466] = evt.str[25]  -- "School of Sorcery"
evt.hint[467] = evt.str[38]  -- "Docks"
evt.hint[468] = evt.str[37]  -- "Stables"
evt.hint[469] = evt.str[33]  -- "To Main Square"
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

evt.hint[501] = evt.str[30]  -- "Enter the School of Sorcery"
evt.map[501] = function()
	evt.MoveToMap{X = 2, Y = -1341, Z = -159, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 201, Icon = 9, Name = "D14.blv"}         -- "School of Sorcery"
end

evt.hint[502] = evt.str[31]  -- "Enter the Red Dwarf Mines"
evt.map[502] = function()
	evt.MoveToMap{X = 26, Y = 6, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 202, Icon = 3, Name = "D34.blv"}         -- "Red Dwarf Mines"
end

evt.hint[503] = evt.str[100]  -- ""
evt.map[503] = function()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return
		end
	end
	evt.MoveToMap{X = -6781, Y = 792, Z = 57, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

