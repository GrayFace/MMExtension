local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "Trash Heap",
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
	[25] = "Castle Navan",
	[26] = "Tularean Caves",
	[27] = "Clanker's Laboratory",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Navan",
	[31] = "Enter the Tularean Caves",
	[32] = "Enter Clanker's Laboratory",
	[33] = "",
	[34] = "The entrance has been sealed by a rockslide",
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
	[51] = "redditoh",
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
	[70] = "+50 Earth Resistance (Temporary)",
	[71] = "",
	[72] = "",
	[73] = "",
	[74] = "",
	[75] = "",
	[76] = "+10 Water, Fire, and Air Resistance(Permanent)",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.MoveNPC{NPC = 188, HouseId = 321}         -- "Gretchin Fiddlebone" -> "Fiddlebone Residence"
	if not evt.Cmp("QBits", 41) then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Southern Village Group in Harmondy"
	end
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
end

events.LoadMap = evt.map[1].last

evt.house[3] = 18  -- "Buckskins and Bucklers"
evt.map[3] = function()
	evt.EnterHouse(18)         -- "Buckskins and Bucklers"
end

evt.house[4] = 18  -- "Buckskins and Bucklers"
evt.map[4] = function()
end

evt.house[5] = 32  -- "Natural Magic"
evt.map[5] = function()
	evt.EnterHouse(32)         -- "Natural Magic"
end

evt.house[6] = 32  -- "Natural Magic"
evt.map[6] = function()
end

evt.house[7] = 45  -- "The Bubbling Cauldron"
evt.map[7] = function()
	evt.EnterHouse(45)         -- "The Bubbling Cauldron"
end

evt.house[8] = 45  -- "The Bubbling Cauldron"
evt.map[8] = function()
end

evt.house[9] = 56  -- "Hu's Stallions"
evt.map[9] = function()
	evt.EnterHouse(56)         -- "Hu's Stallions"
end

evt.house[10] = 56  -- "Hu's Stallions"
evt.map[10] = function()
end

evt.house[11] = 65  -- "Sea Sprite"
evt.map[11] = function()
	evt.EnterHouse(65)         -- "Sea Sprite"
end

evt.house[12] = 65  -- "Sea Sprite"
evt.map[12] = function()
end

evt.house[13] = 77  -- "Nature's Remedies"
evt.map[13] = function()
	evt.EnterHouse(77)         -- "Nature's Remedies"
end

evt.house[14] = 77  -- "Nature's Remedies"
evt.map[14] = function()
end

evt.house[15] = 92  -- "The Proving Grounds"
evt.map[15] = function()
	evt.EnterHouse(92)         -- "The Proving Grounds"
end

evt.house[16] = 92  -- "The Proving Grounds"
evt.map[16] = function()
end

evt.house[17] = 104  -- "Pierpont Townhall"
evt.map[17] = function()
	evt.EnterHouse(104)         -- "Pierpont Townhall"
end

evt.house[18] = 104  -- "Pierpont Townhall"
evt.map[18] = function()
end

evt.house[19] = 110  -- "Emerald Inn"
evt.map[19] = function()
	evt.EnterHouse(110)         -- "Emerald Inn"
end

evt.house[20] = 110  -- "Emerald Inn"
evt.map[20] = function()
end

evt.house[21] = 130  -- "Nature's Stockpile"
evt.map[21] = function()
	evt.EnterHouse(130)         -- "Nature's Stockpile"
end

evt.house[22] = 130  -- "Nature's Stockpile"
evt.map[22] = function()
end

evt.house[23] = 141  -- "Master Guild of Fire"
evt.map[23] = function()
	evt.EnterHouse(141)         -- "Master Guild of Fire"
end

evt.house[24] = 141  -- "Master Guild of Fire"
evt.map[24] = function()
end

evt.house[25] = 145  -- "Master Guild of Air"
evt.map[25] = function()
	evt.EnterHouse(145)         -- "Master Guild of Air"
end

evt.house[26] = 145  -- "Master Guild of Air"
evt.map[26] = function()
end

evt.house[27] = 148  -- "Adept Guild of Water"
evt.map[27] = function()
	evt.EnterHouse(148)         -- "Adept Guild of Water"
end

evt.house[28] = 148  -- "Adept Guild of Water"
evt.map[28] = function()
end

evt.house[29] = 152  -- "Adept Guild of Earth"
evt.map[29] = function()
	evt.EnterHouse(152)         -- "Adept Guild of Earth"
end

evt.house[30] = 152  -- "Adept Guild of Earth"
evt.map[30] = function()
end

evt.house[32] = 4  -- "Hunter's Lodge"
evt.map[32] = function()
	evt.EnterHouse(4)         -- "Hunter's Lodge"
end

evt.house[33] = 4  -- "Hunter's Lodge"
evt.map[33] = function()
end

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 308  -- "Bith Residence"
evt.map[52] = function()
	evt.EnterHouse(308)         -- "Bith Residence"
end

evt.house[53] = 309  -- "Suretrail Home"
evt.map[53] = function()
	evt.EnterHouse(309)         -- "Suretrail Home"
end

evt.house[54] = 310  -- "Silverpoint Residence"
evt.map[54] = function()
	evt.EnterHouse(310)         -- "Silverpoint Residence"
end

evt.house[55] = 311  -- "Miyon's Home"
evt.map[55] = function()
	evt.EnterHouse(311)         -- "Miyon's Home"
end

evt.house[56] = 312  -- "Green House"
evt.map[56] = function()
	evt.EnterHouse(312)         -- "Green House"
end

evt.house[57] = 313  -- "Warlin Residence"
evt.map[57] = function()
	evt.EnterHouse(313)         -- "Warlin Residence"
end

evt.house[58] = 314  -- "Dotes Residence"
evt.map[58] = function()
	evt.EnterHouse(314)         -- "Dotes Residence"
end

evt.house[59] = 315  -- "Blueswan Home"
evt.map[59] = function()
	evt.EnterHouse(315)         -- "Blueswan Home"
end

evt.house[60] = 316  -- "Temper Residence"
evt.map[60] = function()
	evt.EnterHouse(316)         -- "Temper Residence"
end

evt.house[61] = 317  -- "Windsong House"
evt.map[61] = function()
	evt.EnterHouse(317)         -- "Windsong House"
end

evt.house[62] = 318  -- "Whitecap Residence"
evt.map[62] = function()
	evt.EnterHouse(318)         -- "Whitecap Residence"
end

evt.house[63] = 319  -- "Ottin House"
evt.map[63] = function()
	evt.EnterHouse(319)         -- "Ottin House"
end

evt.house[64] = 320  -- "Black House"
evt.map[64] = function()
	evt.EnterHouse(320)         -- "Black House"
end

evt.house[65] = 321  -- "Fiddlebone Residence"
evt.map[65] = function()
	evt.EnterHouse(321)         -- "Fiddlebone Residence"
end

evt.house[66] = 322  -- "Kerrid Residence"
evt.map[66] = function()
	evt.EnterHouse(322)         -- "Kerrid Residence"
end

evt.house[67] = 323  -- "Willowbark's Home"
evt.map[67] = function()
	evt.EnterHouse(323)         -- "Willowbark's Home"
end

evt.house[68] = 324  -- "House 324"
evt.map[68] = function()
	evt.EnterHouse(324)         -- "House 324"
end

evt.house[69] = 325  -- "House 325"
evt.map[69] = function()
	evt.EnterHouse(325)         -- "House 325"
end

evt.house[70] = 326  -- "House 326"
evt.map[70] = function()
	evt.EnterHouse(326)         -- "House 326"
end

evt.house[71] = 327  -- "Benjamin's Home"
evt.map[71] = function()
	evt.EnterHouse(327)         -- "Benjamin's Home"
end

evt.house[72] = 328  -- "Stonewright Residence"
evt.map[72] = function()
	evt.EnterHouse(328)         -- "Stonewright Residence"
end

evt.house[73] = 329  -- "Weatherson's House"
evt.map[73] = function()
	evt.EnterHouse(329)         -- "Weatherson's House"
end

evt.house[74] = 330  -- "Sower Residence"
evt.map[74] = function()
	evt.EnterHouse(330)         -- "Sower Residence"
end

evt.hint[75] = evt.str[9]  -- "Tent"
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
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
evt.map[202] = function()
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

evt.hint[203] = evt.str[5]  -- "Fountain"
evt.hint[204] = evt.str[6]  -- "Drink from the Fountain"
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 8) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 13) then         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
		evt.Add("AutonotesBits", 13)         -- "50 points of temporary Earth resistance from the central fountain in Pierpont."
	end
	evt.Add("EarthResBonus", 50)
	evt.Add("PlayerBits", 8)
	evt.StatusText(70)         -- "+50 Earth Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 8)
end, const.Day, 1*const.Hour)

evt.hint[205] = evt.str[25]  -- "Castle Navan"
evt.hint[401] = evt.str[100]  -- ""
evt.map[401] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 137) then         -- Artifact Messenger only happens once
		if evt.Cmp("Counter3", 1344) then
			if not evt.Cmp("Counter3", 2016) then
				evt.SpeakNPC(73)         -- "Messenger"
				evt.Add("Inventory", 700)         -- "Message from Erathia"
				evt.Set("QBits", 137)         -- Artifact Messenger only happens once
				evt.Set("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
				evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -15752, Y = 21272, Z = 3273, NPCGroup = 0, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -14000, Y = 18576, Z = 4250, NPCGroup = 0, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 0, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 30, X = -15752, Y = 21272, Z = 3273, NPCGroup = 0, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 9, X = -14000, Y = 18576, Z = 4250, NPCGroup = 0, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -16016, Y = 19280, Z = 3284, NPCGroup = 0, unk = 0}
			end
		end
	end
end

events.LoadMap = evt.map[401].last

evt.hint[402] = evt.str[100]  -- ""
evt.map[402] = function()
	evt.SpeakNPC(53)         -- "The Oldest Tree"
end

evt.hint[403] = evt.str[100]  -- ""
evt.map[403] = function()  -- Timer(<function>, 5*const.Minute)
	if evt.Cmp("QBits", 41) then         -- Solved Tree quest
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	end
end

Timer(evt.map[403].last, 5*const.Minute)

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 25) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("WaterResistance", 10)
		evt.Add("FireResistance", 10)
		evt.Add("AirResistance", 10)
		evt.Add("PlayerBits", 25)
		evt.StatusText(76)         -- "+10 Water, Fire, and Air Resistance(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 166) then         -- Visited Obelisk in Area 4
		evt.StatusText(51)         -- "redditoh"
		evt.Add("AutonotesBits", 116)         -- "Obelisk message #3: redditoh"
		evt.ForPlayer("All")
		evt.Add("QBits", 166)         -- Visited Obelisk in Area 4
	end
end

evt.hint[500] = evt.str[100]  -- ""
evt.map[500] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree08"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree26"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree09"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree27"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree07"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree25"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree38"}
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
	if evt.Cmp("MapVar60", 1) then
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree38"}
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
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree40"}
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
	evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree30"}
end

events.LoadMap = evt.map[500].last

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

evt.hint[261] = evt.str[60]  -- "Fruit Tree"
evt.map[261] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar60", 1) then
				evt.Add("Inventory", 630)         -- "Red Delicious Apple"
				evt.Set("MapVar60", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 61, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter Castle Navan"
evt.map[501] = function()
	evt.MoveToMap{X = 0, Y = -1589, Z = 225, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 177, Icon = 1, Name = "D32.blv"}         -- "Castle Navan"
end

evt.hint[502] = evt.str[31]  -- "Enter the Tularean Caves"
evt.map[502] = function()
	evt.StatusText(34)         -- "The entrance has been sealed by a rockslide"
end

evt.hint[503] = evt.str[32]  -- "Enter Clanker's Laboratory"
evt.map[503] = function()
	evt.StatusText(21)         -- "This Door is Locked"
end

