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
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Sewer",
	[26] = "Castle Gryphonheart",
	[27] = "Fort Riverstride",
	[28] = "",
	[29] = "",
	[30] = "Enter The Erathian Sewer",
	[31] = "Enter Castle Gryphonheart",
	[32] = "Enter Fort Riverstride",
	[33] = "Enter",
	[34] = "Shops",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Plaza",
	[40] = "Fort Riverstride",
	[41] = "Castle Gryphonheart",
	[42] = "East to Harmondale",
	[43] = "North to Deyja Moors",
	[44] = "West to Tatalia",
	[45] = "South to the Bracada Desert",
	[46] = "City of Steadwick",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "ininhil_",
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
	[70] = "+10 Accuracy (Temporary)",
	[71] = "+2 Might (Permanent)",
	[72] = "+20 Body Resistance (Temporary)",
	[73] = "Disease Cured",
	[74] = "+50 Might (Temporary)",
	[75] = "+5 Personality (Temporary)",
	[76] = "+10 Luck(Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(509)
Game.LoadSound(510)
Game.LoadSound(511)
Game.LoadSound(512)
Game.LoadSound(513)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 207) then         -- Erathia - Town Portal
		evt.Add("QBits", 207)         -- Erathia - Town Portal
	end
	evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
	evt.SetMonGroupBit{NPCGroup = 7, Bit = const.MonsterBits.Hostile, On = true}         -- "Group fo M2"
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 188) then         -- Killed all Erathian Griffins
		if evt.CheckMonstersKilled{CheckType = 2, Id = 81, Count = 0} then
			if evt.CheckMonstersKilled{CheckType = 2, Id = 82, Count = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 83, Count = 0} then
					evt.ForPlayer("All")
					evt.Set("QBits", 188)         -- Killed all Erathian Griffins
				end
			end
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.HouseDoor(3, 17)  -- "Queen Catherine's Smithy"
evt.house[4] = 17  -- "Queen Catherine's Smithy"
evt.HouseDoor(5, 31)  -- "Her Majesty's Magics"
evt.house[6] = 31  -- "Her Majesty's Magics"
evt.HouseDoor(7, 44)  -- "Lead Transformations"
evt.house[8] = 44  -- "Lead Transformations"
evt.HouseDoor(9, 55)  -- "Royal Steeds"
evt.house[10] = 55  -- "Royal Steeds"
evt.HouseDoor(11, 64)  -- "Lady Catherine"
evt.house[12] = 64  -- "Lady Catherine"
evt.HouseDoor(13, 76)  -- "House of Solace"
evt.house[14] = 76  -- "House of Solace"
evt.HouseDoor(15, 91)  -- "In Her Majesty's Service"
evt.house[16] = 91  -- "In Her Majesty's Service"
evt.HouseDoor(17, 103)  -- "Steadwick Townhall"
evt.house[18] = 103  -- "Steadwick Townhall"
evt.HouseDoor(19, 109)  -- "Griffin's Rest"
evt.house[20] = 109  -- "Griffin's Rest"
evt.HouseDoor(21, 129)  -- "Bank of Erathia"
evt.house[22] = 129  -- "Bank of Erathia"
evt.HouseDoor(23, 158)  -- "Paramount Guild of Spirit"
evt.house[24] = 158  -- "Paramount Guild of Spirit"
evt.HouseDoor(25, 160)  -- "Adept Guild of Mind"
evt.house[26] = 160  -- "Adept Guild of Mind"
evt.HouseDoor(27, 165)  -- "Master Guild of Body"
evt.house[28] = 165  -- "Master Guild of Body"
evt.HouseDoor(29, 3)  -- "The Queen's Forge"
evt.house[30] = 3  -- "The Queen's Forge"
evt.hint[51] = evt.str[7]  -- "House"
evt.HouseDoor(52, 269)  -- "Guthwulf's Home"
evt.HouseDoor(53, 270)  -- "Wolverton Residence"
evt.HouseDoor(54, 271)  -- "House 271"
evt.HouseDoor(55, 272)  -- "House 272"
evt.HouseDoor(56, 273)  -- "House 273"
evt.HouseDoor(57, 274)  -- "Castro's House"
evt.HouseDoor(59, 276)  -- "Laraselle Residence"
evt.HouseDoor(60, 277)  -- "Sourbrow Home"
evt.HouseDoor(62, 279)  -- "Agraynel Residence"
evt.HouseDoor(65, 282)  -- "House 282"
evt.HouseDoor(66, 283)  -- "Tish Residence"
evt.HouseDoor(67, 284)  -- "Talion House"
evt.HouseDoor(68, 285)  -- "Ravenhill Residence"
evt.HouseDoor(69, 286)  -- "Cardrin Residence"
evt.HouseDoor(71, 288)  -- "Gareth's Home"
evt.HouseDoor(72, 289)  -- "Forgewright Residence"
evt.HouseDoor(73, 290)  -- "Pretty House"
evt.HouseDoor(74, 291)  -- "Lotts Familly Home"
evt.HouseDoor(76, 293)  -- "Julian's Home"
evt.HouseDoor(77, 294)  -- "Eversmyle Residence"
evt.HouseDoor(78, 295)  -- "Dirthmoore Residence"
evt.HouseDoor(81, 298)  -- "Heartsworn Home"
evt.HouseDoor(82, 299)  -- "Cardron Residence"
evt.HouseDoor(84, 301)  -- "Thrush Residence"
evt.HouseDoor(85, 302)  -- "Hillier Residence"
evt.HouseDoor(86, 303)  -- "Quixote Residence"
evt.HouseDoor(87, 304)  -- "Org House"
evt.HouseDoor(88, 305)  -- "Talreish Residence"
evt.HouseDoor(89, 306)  -- "Barnes Home"
evt.HouseDoor(90, 307)  -- "Havest Residence"
evt.hint[91] = evt.str[9]  -- "Tent"
evt.hint[92] = evt.str[10]  -- "Hut"
evt.HouseDoor(93, 492)  -- "Ravenswood Residence"
evt.HouseDoor(94, 493)  -- "Blayze's"
evt.HouseDoor(95, 494)  -- "Norris' House"
evt.HouseDoor(495, 495)  -- "Dreamwright Residence"
evt.HouseDoor(496, 496)  -- "Wain Manor"
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

evt.hint[169] = evt.str[1]  -- "Chest "
evt.map[169] = function()
	if evt.Cmp("QBits", 244) then         -- Finished ArcoMage Quest - Get the treasure
		evt.OpenChest(19)
	else
		evt.OpenChest(18)
	end
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
end, const.Week)

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 3) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 8) then         -- ""
		evt.Add("AutonotesBits", 8)         -- ""
	end
	evt.Add("BaseMight", 2)
	evt.Add("PlayerBits", 3)
	evt.StatusText(71)         -- "+2 Might (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 5) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 10) then         -- ""
		evt.Add("AutonotesBits", 10)         -- ""
	end
	evt.Add("BodyResBonus", 20)
	evt.Add("PlayerBits", 5)
	evt.StatusText(72)         -- "+20 Body Resistance (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 5)
end, const.Day)

evt.hint[205] = evt.str[4]  -- "Drink from the Well"
evt.map[205] = function()
	if not evt.Cmp("DiseasedGreen", 0) then
		if not evt.Cmp("DiseasedYellow", 0) then
			if not evt.Cmp("DiseasedRed", 0) then
				evt.StatusText(11)         -- "Refreshing!"
				return
			end
		end
	end
	if not evt.Cmp("AutonotesBits", 9) then         -- ""
		evt.Add("AutonotesBits", 9)         -- ""
	end
	evt.Set("MainCondition", const.Condition.Cursed)
	evt.StatusText(73)         -- "Disease Cured"
end

evt.hint[207] = evt.str[5]  -- "Fountain"
evt.hint[208] = evt.str[6]  -- "Drink from the Fountain"
evt.map[208] = function()
	if evt.Cmp("PlayerBits", 6) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 11) then         -- ""
		evt.Add("AutonotesBits", 11)         -- ""
	end
	evt.Add("MightBonus", 50)
	evt.Add("PlayerBits", 6)
	evt.StatusText(74)         -- "+50 Might (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 6)
end, const.Day)

evt.hint[209] = evt.str[4]  -- "Drink from the Well"
evt.map[209] = function()
	if evt.Cmp("PlayerBits", 4) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 7) then         -- ""
		evt.Add("AutonotesBits", 7)         -- ""
	end
	evt.Add("AccuracyBonus", 10)
	evt.Add("PlayerBits", 4)
	evt.StatusText(70)         -- "+10 Accuracy (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 4)
end, const.Day)

evt.hint[210] = evt.str[6]  -- "Drink from the Fountain"
evt.map[210] = function()
	if evt.Cmp("PlayerBits", 7) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 12) then         -- ""
		evt.Add("AutonotesBits", 12)         -- ""
	end
	evt.Add("PersonalityBonus", 5)
	evt.Add("PlayerBits", 7)
	evt.StatusText(75)         -- "+5 Personality (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 7)
end, const.Day)

evt.hint[401] = evt.str[100]  -- ""
evt.map[401] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 29) then         -- "Crack the code in the School of Sorcery in the Bracada Desert to reveal the location of the Tomb of Ashwar Nog'Nogoth.  Discover the tomb's location, enter it, and then return it to Stephan Sand in the Pit."
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	end
end

events.LoadMap = evt.map[401].last

evt.hint[402] = evt.str[15]  -- "Button"
evt.map[402] = function()
	evt.Set("MapVar9", 1)
	evt.PlaySound{Id = 509, X = 14328, Y = -21624}
end

evt.hint[403] = evt.str[15]  -- "Button"
evt.map[403] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 2)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 510, X = 14328, Y = -21624}
end

evt.hint[404] = evt.str[15]  -- "Button"
evt.map[404] = function()
	if evt.Cmp("MapVar9", 2) then
		evt.Set("MapVar9", 3)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 511, X = 14328, Y = -21624}
end

evt.hint[405] = evt.str[15]  -- "Button"
evt.map[405] = function()
	if evt.Cmp("MapVar9", 3) then
		evt.Set("MapVar9", 4)
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 512, X = 14328, Y = -21624}
end

evt.hint[406] = evt.str[15]  -- "Button"
evt.map[406] = function()
	if evt.Cmp("MapVar9", 5) then
		return
	end
	if evt.Cmp("MapVar9", 4) then
		evt.Set("MapVar9", 5)
		evt.ForPlayer("All")
		evt.Set("QBits", 57)         -- Solved the code puzzle.  Ninja promo quest
		evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 17, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
		evt.Subtract("QBits", 214)         -- Scroll of Waves - I lost it
		evt.Subtract("QBits", 215)         -- Cipher - I lost it
	else
		evt.Set("MapVar9", 0)
	end
	evt.PlaySound{Id = 513, X = 14328, Y = -21624}
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 24) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BaseLuck", 10)
		evt.StatusText(76)         -- "+10 Luck(Permanent)"
		evt.Add("PlayerBits", 24)
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 165) then         -- Visited Obelisk in Area 3
		evt.StatusText(51)         -- "ininhil_"
		evt.Add("AutonotesBits", 115)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 165)         -- Visited Obelisk in Area 3
	end
end

evt.hint[454] = evt.str[38]  -- "Docks"
evt.hint[455] = evt.str[39]  -- "Plaza"
evt.hint[456] = evt.str[41]  -- "Castle Gryphonheart"
evt.hint[457] = evt.str[40]  -- "Fort Riverstride"
evt.hint[458] = evt.str[42]  -- "East to Harmondale"
evt.hint[459] = evt.str[43]  -- "North to Deyja Moors"
evt.hint[460] = evt.str[44]  -- "West to Tatalia"
evt.hint[461] = evt.str[45]  -- "South to the Bracada Desert"
evt.hint[462] = evt.str[46]  -- "City of Steadwick"
evt.hint[463] = evt.str[35]  -- "Temple"
evt.hint[464] = evt.str[36]  -- "Guilds"
evt.hint[465] = evt.str[37]  -- "Stables"
evt.hint[466] = evt.str[25]  -- "Sewer"
evt.hint[500] = evt.str[100]  -- ""
evt.map[500] = function()  -- function events.LoadMap()
	if evt.CheckSeason(2) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree20"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree26"}
		evt.StatusText(62)         -- ""
		goto _23
	end
	if evt.CheckSeason(3) then
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree21"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree27"}
		evt.StatusText(63)         -- ""
		goto _23
	end
	evt.SetSprite{SpriteId = 5, Visible = 1, Name = "tree19"}
	evt.SetSprite{SpriteId = 6, Visible = 1, Name = "tree25"}
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree28"}
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
	if evt.CheckSeason(1) then
		evt.StatusText(61)         -- "You received an apple"
	elseif evt.CheckSeason(0) then
		evt.StatusText(60)         -- "Fruit Tree"
	else
		evt.StatusText(64)         -- ""
	end
	do return end
::_23::
	evt.SetSprite{SpriteId = 7, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 10, Visible = 0, Name = "0"}
	evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 57, Visible = 1, Name = "tree30"}
	evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree30"}
end

events.LoadMap = evt.map[500].last

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

evt.hint[257] = evt.str[60]  -- "Fruit Tree"
evt.map[257] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.Cmp("MapVar56", 1) then
				evt.Add("Inventory", 630)         -- "Red Apple"
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
				evt.Add("Inventory", 630)         -- "Red Apple"
				evt.Set("MapVar57", 1)
				evt.StatusText(61)         -- "You received an apple"
				evt.SetSprite{SpriteId = 58, Visible = 1, Name = "tree37"}
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter The Erathian Sewer"
evt.map[501] = function()
	evt.MoveToMap{X = 28, Y = -217, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[502] = evt.str[32]  -- "Enter Fort Riverstride"
evt.map[502] = function()
	evt.MoveToMap{X = 64, Y = -448, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 196, Icon = 9, Name = "D31.blv"}         -- "Fort Riverstride"
end

evt.hint[503] = evt.str[31]  -- "Enter Castle Gryphonheart"
evt.map[503] = function()
	evt.MoveToMap{X = 768, Y = 0, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 175, Icon = 9, Name = "D33.blv"}         -- "Castle Gryphonheart"
end

evt.hint[504] = evt.str[20]  -- "Door"
evt.map[504] = function()
	if evt.Cmp("Inventory", 660) then         -- "Catherine's Key"
		evt.MoveToMap{X = -6314, Y = -618, Z = 1873, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 175, Icon = 9, Name = "D33.blv"}         -- "Castle Gryphonheart"
	else
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[505] = evt.str[32]  -- "Enter Fort Riverstride"
evt.map[505] = function()
	evt.MoveToMap{X = -1262, Y = 587, Z = -1215, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 196, Icon = 9, Name = "D31.blv"}         -- "Fort Riverstride"
end

evt.hint[506] = evt.str[30]  -- "Enter The Erathian Sewer"
evt.map[506] = function()
	evt.MoveToMap{X = 6647, Y = 3511, Z = -511, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[507] = evt.str[30]  -- "Enter The Erathian Sewer"
evt.map[507] = function()
	evt.MoveToMap{X = -6507, Y = 10205, Z = -383, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 5, Name = "D01.blv"}         -- "Erathian Sewer"
end

evt.hint[508] = evt.str[33]  -- "Enter"
evt.map[508] = function()
	evt.MoveToMap{X = -111, Y = -25, Z = 1, Direction = 640, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 2, Name = "mdt11.blv"}
end

evt.hint[509] = evt.str[33]  -- "Enter"
evt.map[509] = function()
	evt.MoveToMap{X = -104, Y = 128, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "mdt14.blv"}
end

