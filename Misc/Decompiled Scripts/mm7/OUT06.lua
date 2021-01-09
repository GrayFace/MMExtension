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
	[55] = "",
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

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

-- ERROR: Duplicate label: 303:0

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

evt.hint[50] = evt.str[100]  -- ""
evt.hint[98] = evt.str[13]  -- "Dock"
evt.HouseDoor(99, 66)  -- "Enchantress"
evt.house[100] = 66  -- "Enchantress"
evt.HouseDoor(101, 34)  -- "Artifacts & Antiquities"
evt.house[102] = 34  -- "Artifacts & Antiquities"
evt.HouseDoor(103, 47)  -- "Edmond's Ampules"
evt.house[104] = 47  -- "Edmond's Ampules"
evt.HouseDoor(105, 58)  -- "Crystal Caravans"
evt.house[106] = 58  -- "Crystal Caravans"
evt.HouseDoor(107, 79)  -- "Temple of Light"
evt.house[108] = 79  -- "Temple of Light"
evt.HouseDoor(109, 112)  -- "Familiar Place"
evt.house[110] = 112  -- "Familiar Place"
evt.HouseDoor(111, 149)  -- "Master Guild of Water"
evt.house[112] = 149  -- "Master Guild of Water"
evt.HouseDoor(113, 167)  -- "Guild of Illumination"
evt.house[114] = 167  -- "Guild of Illumination"
evt.hint[150] = evt.str[7]  -- "House"
evt.HouseDoor(151, 474)  -- "Smiling Jack's"
evt.HouseDoor(152, 475)  -- "Pederton Residence"
evt.HouseDoor(153, 476)  -- "Applebee Manor"
evt.HouseDoor(154, 477)  -- "Lightsworn Residence"
evt.HouseDoor(155, 478)  -- "Alashandra's Home"
evt.HouseDoor(156, 479)  -- "Gayle's"
evt.HouseDoor(157, 480)  -- "Brigham's Home"
evt.HouseDoor(158, 481)  -- "Rowan's House"
evt.HouseDoor(159, 482)  -- "Brand's Home"
evt.HouseDoor(160, 483)  -- "Benson Residence"
evt.HouseDoor(161, 484)  -- "Zimm's House"
evt.HouseDoor(162, 500)  -- "Stone House"
evt.HouseDoor(163, 501)  -- "Watershed Residence"
evt.HouseDoor(164, 502)  -- "Hollyfield Residence"
evt.HouseDoor(165, 503)  -- "Sweet Residence"
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
	elseif evt.Cmp("MapVar4", 2) then
		goto _6
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
	evt.MoveToMap{X = -4800, Y = 14552, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
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
		evt.Add("AutonotesBits", 118)         -- ""
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
end, const.Week)

evt.hint[458] = evt.str[4]  -- "Drink from the Well"
evt.map[458] = function()
	evt.StatusText(11)         -- "Refreshing!"
end

evt.hint[459] = evt.str[3]  -- "Well"
evt.map[459] = function()
	local i
	if evt.Cmp("Gold", 100) then
		evt.Subtract("Gold", 100)
		i = Game.Rand() % 2
		if i == 1 then
			i = Game.Rand() % 4
			if i == 1 then
				evt.Set("Insane", 0)
			elseif i == 2 then
				evt.Add("EarthResBonus", 20)
			elseif i == 3 then
				evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Air, Damage = 50}
			else
				evt.Set("Cursed", 0)
			end
		else
			i = Game.Rand() % 3
			if i == 1 then
				evt.Add("Gold", 250)
			elseif i == 2 then
				evt.Set("Dead", 0)
			else
				i = Game.Rand() % 2
				if i == 1 then
					i = Game.Rand() % 4
					if i == 1 then
						evt.Add("MightBonus", 20)
					elseif i == 2 then
						evt.Add("IntellectBonus", 20)
					elseif i == 3 then
						evt.Add("PersonalityBonus", 20)
					else
						evt.Add("EnduranceBonus", 20)
					end
				else
					i = Game.Rand() % 3
					if i == 1 then
						evt.Add("AccuracyBonus", 20)
					elseif i == 2 then
						evt.Add("SpeedBonus", 20)
					else
						evt.Add("LuckBonus", 20)
					end
				end
			end
		end
	else
		evt.Subtract("Gold", 99)
	end
	evt.StatusText(65)         -- "You make a wish"
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
	if evt.Cmp("PlayerBits", 13) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 18) then         -- ""
		evt.Add("AutonotesBits", 18)         -- ""
	end
	evt.Add("PersonalityBonus", 25)
	evt.Add("IntellectBonus", 25)
	evt.Add("PlayerBits", 13)
	evt.StatusText(72)         -- "+25 Intellect and Personality (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 13)
end, const.Day)

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

