local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Your packs are full!",
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
	[22] = "You need the Home Key to use this teleporter.",
	[23] = "",
	[24] = "",
	[25] = "Titan Stronghold",
	[26] = "Temple of Baa",
	[27] = "Hall under the Hill",
	[28] = "",
	[29] = "",
	[30] = "Enter the The Titan Stronghold",
	[31] = "Enter the Temple of Baa",
	[32] = "Enter the Hall under the Hill",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "",
	[42] = "East to the Tularean Forest",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Avlee",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "__dn_r_n",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
	[55] = "Home Portal",
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
	[70] = "+2 Endurance (Permanent)",
	[71] = "+20 Water Resistance (Temporary)",
	[72] = "+25 Hit Points",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 370) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.SetNPCTopic{NPC = 208, Index = 1, Event = 452}         -- "Lucid Apple" : "We need your help!"
	end
end

events.LoadMap = evt.map[1].last

evt.house[3] = 23  -- "Avlee Outpost"
evt.map[3] = function()
	evt.EnterHouse(23)         -- "Avlee Outpost"
end

evt.house[4] = 23  -- "Avlee Outpost"
evt.map[4] = function()
end

evt.house[5] = 60  -- "Plush Coaches"
evt.map[5] = function()
	evt.EnterHouse(60)         -- "Plush Coaches"
end

evt.house[6] = 60  -- "Plush Coaches"
evt.map[6] = function()
end

evt.house[7] = 70  -- "Wind Runner"
evt.map[7] = function()
	evt.EnterHouse(70)         -- "Wind Runner"
end

evt.house[8] = 70  -- "Wind Runner"
evt.map[8] = function()
end

evt.house[9] = 84  -- "Temple of Tranquility"
evt.map[9] = function()
	evt.EnterHouse(84)         -- "Temple of Tranquility"
end

evt.house[10] = 84  -- "Temple of Tranquility"
evt.map[10] = function()
end

evt.house[11] = 97  -- "Avlee Gymnaisium"
evt.map[11] = function()
	evt.EnterHouse(97)         -- "Avlee Gymnaisium"
end

evt.house[12] = 97  -- "Avlee Gymnaisium"
evt.map[12] = function()
end

evt.house[13] = 119  -- "The Potted Pixie"
evt.map[13] = function()
	evt.EnterHouse(119)         -- "The Potted Pixie"
end

evt.house[14] = 119  -- "The Potted Pixie"
evt.map[14] = function()
end

evt.house[15] = 134  -- "Halls of Gold"
evt.map[15] = function()
	evt.EnterHouse(134)         -- "Halls of Gold"
end

evt.house[16] = 134  -- "Halls of Gold"
evt.map[16] = function()
end

evt.house[17] = 162  -- "Paramount Guild of Mind"
evt.map[17] = function()
	evt.EnterHouse(162)         -- "Paramount Guild of Mind"
end

evt.house[18] = 162  -- "Paramount Guild of Mind"
evt.map[18] = function()
end

evt.house[19] = 166  -- "Paramount Guild of Body"
evt.map[19] = function()
	evt.EnterHouse(166)         -- "Paramount Guild of Body"
end

evt.house[20] = 166  -- "Paramount Guild of Body"
evt.map[20] = function()
end

evt.house[21] = 9  -- "The Knocked Bow"
evt.map[21] = function()
	evt.EnterHouse(9)         -- "The Knocked Bow"
end

evt.house[22] = 9  -- "The Knocked Bow"
evt.map[22] = function()
end

evt.hint[30] = evt.str[55]  -- "Home Portal"
evt.map[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 670) then         -- "Home Key"
		evt.MoveToMap{X = -9853, Y = 8656, Z = -1024, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out03.Odm"}
	else
		evt.StatusText(22)         -- "You need the Home Key to use this teleporter."
	end
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 376  -- "Featherwind Residence"
evt.map[52] = function()
	evt.EnterHouse(376)         -- "Featherwind Residence"
end

evt.house[53] = 377  -- "Ravenhair Residence"
evt.map[53] = function()
	evt.EnterHouse(377)         -- "Ravenhair Residence"
end

evt.house[54] = 382  -- "Condemned Dwelling"
evt.map[54] = function()
	evt.EnterHouse(382)         -- "Condemned Dwelling"
end

evt.house[55] = 383  -- "Alice's Restaurant"
evt.map[55] = function()
	evt.EnterHouse(383)         -- "Alice's Restaurant"
end

evt.house[56] = 384  -- "Deerhunter Residence"
evt.map[56] = function()
	evt.EnterHouse(384)         -- "Deerhunter Residence"
end

evt.house[57] = 385  -- "Swiftfoot's House"
evt.map[57] = function()
	evt.EnterHouse(385)         -- "Swiftfoot's House"
end

evt.house[58] = 504  -- "Tempus' House"
evt.map[58] = function()
	evt.EnterHouse(504)         -- "Tempus' House"
end

evt.house[59] = 505  -- "Kaine's"
evt.map[59] = function()
	evt.EnterHouse(505)         -- "Kaine's"
end

evt.house[60] = 506  -- "Apple Residence"
evt.map[60] = function()
	evt.EnterHouse(506)         -- "Apple Residence"
end

evt.hint[61] = evt.str[9]  -- "Tent"
evt.house[63] = 378  -- "Jillian's House"
evt.map[63] = function()
	evt.EnterHouse(378)         -- "Jillian's House"
end

evt.house[64] = 379  -- "Greenstorm Residence"
evt.map[64] = function()
	evt.EnterHouse(379)         -- "Greenstorm Residence"
end

evt.house[67] = 370  -- "Brightspear Residence"
evt.map[67] = function()
	evt.EnterHouse(370)         -- "Brightspear Residence"
end

evt.house[68] = 371  -- "Holden Residence"
evt.map[68] = function()
	evt.EnterHouse(371)         -- "Holden Residence"
end

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
	if not evt.Cmp("QBits", 69) then         -- Placed Golem left arm
		if not evt.Cmp("QBits", 222) then         -- Left arm - I lost it
			evt.Add("QBits", 222)         -- Left arm - I lost it
		end
	end
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
evt.map[202] = function()
	if evt.Cmp("HasFullHP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("HP", 25)
		evt.StatusText(72)         -- "+25 Hit Points"
	end
end

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
evt.map[203] = function()
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

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 23) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 31) then         -- "20 points of temporary Water resistance from the well in the northwest section of Spaward in Avlee."
		evt.Add("AutonotesBits", 31)         -- "20 points of temporary Water resistance from the well in the northwest section of Spaward in Avlee."
	end
	evt.Add("WaterResBonus", 20)
	evt.Add("PlayerBits", 23)
	evt.StatusText(71)         -- "+20 Water Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 23)
end, const.Day, 1*const.Hour)

evt.hint[205] = evt.str[4]  -- "Drink from the Well"
evt.map[205] = function()
	if evt.Cmp("PlayerBits", 22) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 30) then         -- "2 points of permanent Endurance from the well in the northeast section of Spaward in Avlee."
		evt.Add("AutonotesBits", 30)         -- "2 points of permanent Endurance from the well in the northeast section of Spaward in Avlee."
	end
	evt.Add("BaseEndurance", 2)
	evt.Add("PlayerBits", 22)
	evt.StatusText(70)         -- "+2 Endurance (Permanent)"
end

evt.hint[206] = evt.str[26]  -- "Temple of Baa"
evt.hint[207] = evt.str[25]  -- "Titan Stronghold"
evt.hint[208] = evt.str[27]  -- "Hall under the Hill"
evt.hint[209] = evt.str[55]  -- "Home Portal"
evt.hint[401] = evt.str[53]  -- "Altar"
evt.map[401] = function()
	if evt.Cmp("QBits", 49) then         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
		if not evt.Cmp("QBits", 50) then         -- Visited all stonehenges
			if not evt.Cmp("QBits", 53) then         -- Visited stonehenge 3 (area 14)
				evt.StatusText(56)         -- ""
				evt.ForPlayer("All")
				evt.Set("QBits", 53)         -- Visited stonehenge 3 (area 14)
				evt.ForPlayer("All")
				evt.Add("QBits", 245)         -- "Congratulations"
				evt.Subtract("QBits", 245)         -- "Congratulations"
				if evt.Cmp("QBits", 51) then         -- Visited stonehenge 1 (area 9)
					if evt.Cmp("QBits", 52) then         -- Visited stonehenge 2 (area 13)
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
	if not evt.Cmp("QBits", 201) then         -- Placed item 617 in out14(statue)
		if evt.Cmp("QBits", 200) then         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 617) then         -- "Knight Statuette"
				evt.SetSprite{SpriteId = 25, Visible = 1, Name = "0"}
				evt.Subtract("Inventory", 617)         -- "Knight Statuette"
				evt.Set("QBits", 201)         -- Placed item 617 in out14(statue)
			end
		end
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 176) then         -- Visited Obelisk in Area 14
		evt.StatusText(51)         -- "__dn_r_n"
		evt.Add("AutonotesBits", 126)         -- "Obelisk message #13: __dn_r_n"
		evt.ForPlayer("All")
		evt.Add("QBits", 176)         -- Visited Obelisk in Area 14
	end
end

evt.hint[454] = evt.str[46]  -- "Avlee"
evt.hint[455] = evt.str[42]  -- "East to the Tularean Forest"
evt.hint[456] = evt.str[38]  -- "Docks"
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
	if evt.Cmp("MapVar56", 1) then
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar57", 1) then
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar58", 1) then
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar59", 1) then
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree38"}
	end
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	else
		if evt.CheckSeason(0) then
			evt.StatusText(60)         -- "Fruit Tree"
		else
			evt.StatusText(64)         -- ""
		end
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
	evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree30"}
end

events.LoadMap = evt.map[250].last

evt.hint[251] = evt.str[60]  -- "Fruit Tree"
evt.map[251] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar50", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar55", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[257] = evt.str[60]  -- "Fruit Tree"
evt.map[257] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar56", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar56", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[258] = evt.str[60]  -- "Fruit Tree"
evt.map[258] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar57", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar57", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[259] = evt.str[60]  -- "Fruit Tree"
evt.map[259] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar58", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar58", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 59, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[260] = evt.str[60]  -- "Fruit Tree"
evt.map[260] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar59", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar59", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 60, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter the The Titan Stronghold"
evt.map[501] = function()
	evt.MoveToMap{X = -1707, Y = -21848, Z = -1007, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 216, Icon = 9, Name = "D09.blv"}         -- "Titan's Stronghold"
end

evt.hint[502] = evt.str[31]  -- "Enter the Temple of Baa"
evt.map[502] = function()
	evt.MoveToMap{X = 1, Y = -2772, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 217, Icon = 9, Name = "D04.blv"}         -- "Temple of Baa"
end

evt.hint[503] = evt.str[32]  -- "Enter the Hall under the Hill"
evt.map[503] = function()
	evt.MoveToMap{X = -1114, Y = 2778, Z = 1, Direction = 1280, LookAngle = 0, SpeedZ = 0, HouseId = 218, Icon = 3, Name = "D22.blv"}         -- "Hall under the Hill"
end

