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
	[25] = "Stone City",
	[26] = "Dwarven Barrow",
	[27] = "Mansion",
	[28] = "",
	[29] = "",
	[30] = "Enter Stone City",
	[31] = "Enter Dwarven Barrow",
	[32] = "Enter Mansion",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East ",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "ivg_whn_",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Fruit Tree",
	[61] = "You received an apple",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "+25 Fire Resistance (Temporary)",
	[71] = "Paralysis Relieved",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "+10 Endurance and Might(Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.HouseDoor(3, 117)  -- "Miner's Only"
evt.house[4] = 117  -- "Miner's Only"
evt.hint[100] = evt.str[7]  -- "House"
evt.HouseDoor(101, 515)  -- "Dallia's Home"
evt.HouseDoor(102, 516)  -- "Gemstone Residence"
evt.HouseDoor(103, 517)  -- "Feldspar's Home"
evt.HouseDoor(104, 518)  -- "Fissure Residence"
evt.HouseDoor(105, 519)  -- "Garnet House"
evt.HouseDoor(106, 520)  -- "Rivenrock Residence"
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
	evt.MoveToMap{X = 3072, Y = -416, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
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
end

evt.hint[220] = evt.str[1]  -- "Chest "
evt.map[220] = function()
	evt.OpenChest(0)
	if not evt.Cmp("QBits", 66) then         -- Placed Golem torso
		if not evt.Cmp("QBits", 225) then         -- Torso - I lost it
			evt.Add("QBits", 225)         -- Torso - I lost it
		end
	end
end

evt.hint[317] = evt.str[25]  -- "Stone City"
evt.hint[318] = evt.str[26]  -- "Dwarven Barrow"
evt.hint[319] = evt.str[27]  -- "Mansion"
evt.hint[320] = evt.str[3]  -- "Well"
evt.hint[321] = evt.str[4]  -- "Drink from the Well"
evt.map[321] = function()
	if evt.Cmp("PlayerBits", 18) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 26) then         -- ""
		evt.Add("AutonotesBits", 26)         -- ""
	end
	evt.Add("FireResBonus", 25)
	evt.Add("PlayerBits", 18)
	evt.StatusText(70)         -- "+25 Fire Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 18)
end, const.Day)

evt.hint[322] = evt.str[4]  -- "Drink from the Well"
evt.map[322] = function()
	if evt.Cmp("Paralysed", 0) then
		evt.Set("MainCondition", const.Condition.Cursed)
		evt.StatusText(71)         -- "Paralysis Relieved"
	else
		evt.StatusText(11)         -- "Refreshing!"
	end
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 29) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BaseEndurance", 10)
		evt.Add("BaseMight", 10)
		evt.Add("PlayerBits", 29)
		evt.StatusText(76)         -- "+10 Endurance and Might(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 173) then         -- Visited Obelisk in Area 11
		evt.StatusText(51)         -- "ivg_whn_"
		evt.Add("AutonotesBits", 123)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 173)         -- Visited Obelisk in Area 11
	end
end

evt.hint[250] = evt.str[100]  -- ""
evt.map[250] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree14"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree17"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree15"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree18"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree13"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree16"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree22"}
	evt.SetSprite{SpriteId = 10, Visible = 1, Name = "0"}
	if evt.Cmp("MapVar50", 1) then
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar51", 1) then
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar52", 1) then
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar53", 1) then
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar54", 1) then
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar55", 1) then
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree38"}
	end
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	elseif evt.CheckSeason(0) then
		evt.StatusText(60)         -- "Fruit Tree"
	else
		evt.StatusText(64)         -- ""
	end
	do return end
::_23::
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree24"}
	evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
	evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree30"}
end

events.LoadMap = evt.map[250].last

evt.hint[251] = evt.str[60]  -- "Fruit Tree"
evt.map[251] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar50", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar50", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[252] = evt.str[60]  -- "Fruit Tree"
evt.map[252] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar51", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar51", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[253] = evt.str[60]  -- "Fruit Tree"
evt.map[253] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar52", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar52", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[254] = evt.str[60]  -- "Fruit Tree"
evt.map[254] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar53", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar53", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[255] = evt.str[60]  -- "Fruit Tree"
evt.map[255] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar54", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar54", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[256] = evt.str[60]  -- "Fruit Tree"
evt.map[256] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar55", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar55", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter Stone City"
evt.map[501] = function()
	evt.MoveToMap{X = 256, Y = -4992, Z = 33, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 211, Icon = 2, Name = "D24.blv"}         -- "Stone City"
end

evt.hint[502] = evt.str[32]  -- "Enter Mansion"
evt.map[502] = function()
	evt.MoveToMap{X = 2, Y = -1096, Z = -31, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "D37.blv"}
end

evt.hint[503] = evt.str[31]  -- "Enter Dwarven Barrow"
evt.map[503] = function()
	evt.MoveToMap{X = 382, Y = 324, Z = -15, Direction = 1280, LookAngle = 0, SpeedZ = 0, HouseId = 189, Icon = 2, Name = "MDT01.blv"}         -- "Arbiter"
end

evt.hint[504] = evt.str[31]  -- "Enter Dwarven Barrow"
evt.map[504] = function()
	evt.MoveToMap{X = 106, Y = -666, Z = 49, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 189, Icon = 2, Name = "MDR01.blv"}         -- "Arbiter"
end

evt.hint[505] = evt.str[31]  -- "Enter Dwarven Barrow"
evt.map[505] = function()
	evt.MoveToMap{X = -384, Y = -983, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 189, Icon = 2, Name = "MDK01.blv"}         -- "Arbiter"
end

