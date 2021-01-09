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
	[16] = "Brianna's Brandy",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "Door",
	[21] = "This Door is Locked",
	[22] = "You need a town portal pass!",
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
	[55] = "Harmondale Town Portal",
	[56] = "Pierpont Town Portal",
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

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

Game.LoadSound(509)
Game.LoadSound(510)
Game.LoadSound(511)
Game.LoadSound(512)
Game.LoadSound(513)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.MoveNPC{NPC = 380, HouseId = 109}         -- "Tony Tunes" -> "Griffin's Rest"
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

evt.house[3] = 17  -- "Queen Catherine's Smithy"
evt.map[3] = function()
	evt.EnterHouse(17)         -- "Queen Catherine's Smithy"
end

evt.house[4] = 17  -- "Queen Catherine's Smithy"
evt.map[4] = function()
end

evt.house[5] = 31  -- "Her Majesty's Magics"
evt.map[5] = function()
	evt.EnterHouse(31)         -- "Her Majesty's Magics"
end

evt.house[6] = 31  -- "Her Majesty's Magics"
evt.map[6] = function()
end

evt.house[7] = 44  -- "Lead Transformations"
evt.map[7] = function()
	evt.EnterHouse(44)         -- "Lead Transformations"
end

evt.house[8] = 44  -- "Lead Transformations"
evt.map[8] = function()
end

evt.house[9] = 55  -- "Royal Steeds"
evt.map[9] = function()
	evt.EnterHouse(55)         -- "Royal Steeds"
end

evt.house[10] = 55  -- "Royal Steeds"
evt.map[10] = function()
end

evt.house[11] = 64  -- "Lady Catherine"
evt.map[11] = function()
	evt.EnterHouse(64)         -- "Lady Catherine"
end

evt.house[12] = 64  -- "Lady Catherine"
evt.map[12] = function()
end

evt.house[13] = 76  -- "House of Solace"
evt.map[13] = function()
	evt.EnterHouse(76)         -- "House of Solace"
end

evt.house[14] = 76  -- "House of Solace"
evt.map[14] = function()
end

evt.house[15] = 91  -- "In Her Majesty's Service"
evt.map[15] = function()
	evt.EnterHouse(91)         -- "In Her Majesty's Service"
end

evt.house[16] = 91  -- "In Her Majesty's Service"
evt.map[16] = function()
end

evt.house[17] = 103  -- "Steadwick Townhall"
evt.map[17] = function()
	evt.EnterHouse(103)         -- "Steadwick Townhall"
end

evt.house[18] = 103  -- "Steadwick Townhall"
evt.map[18] = function()
end

evt.house[19] = 109  -- "Griffin's Rest"
evt.map[19] = function()
	evt.EnterHouse(109)         -- "Griffin's Rest"
end

evt.house[20] = 109  -- "Griffin's Rest"
evt.map[20] = function()
end

evt.house[21] = 129  -- "Bank of Erathia"
evt.map[21] = function()
	evt.EnterHouse(129)         -- "Bank of Erathia"
end

evt.house[22] = 129  -- "Bank of Erathia"
evt.map[22] = function()
end

evt.house[23] = 158  -- "Paramount Guild of Spirit"
evt.map[23] = function()
	evt.EnterHouse(158)         -- "Paramount Guild of Spirit"
end

evt.house[24] = 158  -- "Paramount Guild of Spirit"
evt.map[24] = function()
end

evt.house[25] = 160  -- "Adept Guild of Mind"
evt.map[25] = function()
	evt.EnterHouse(160)         -- "Adept Guild of Mind"
end

evt.house[26] = 160  -- "Adept Guild of Mind"
evt.map[26] = function()
end

evt.house[27] = 165  -- "Master Guild of Body"
evt.map[27] = function()
	evt.EnterHouse(165)         -- "Master Guild of Body"
end

evt.house[28] = 165  -- "Master Guild of Body"
evt.map[28] = function()
end

evt.house[29] = 3  -- "The Queen's Forge"
evt.map[29] = function()
	evt.EnterHouse(3)         -- "The Queen's Forge"
end

evt.house[30] = 3  -- "The Queen's Forge"
evt.map[30] = function()
end

evt.hint[32] = evt.str[100]  -- ""
evt.map[32] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.CheckSeason(1) then
		evt.MoveNPC{NPC = 458, HouseId = 0}         -- "EAO the Lector"
	else
		if evt.Cmp("QBits", 354) then         -- 0
			evt.MoveNPC{NPC = 458, HouseId = 302}         -- "EAO the Lector" -> "Lector's Retreat"
			evt.SetNPCTopic{NPC = 458, Index = 0, Event = 102}         -- "EAO the Lector" : "Can you tell us about The Gauntlet?"
		end
	end
end

events.LoadMap = evt.map[32].last

evt.hint[33] = evt.str[100]  -- ""
evt.map[33] = function()  -- function events.LoadMap()
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

events.LoadMap = evt.map[33].last

evt.hint[34] = evt.str[100]  -- ""
evt.map[34] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 370) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.SetNPCTopic{NPC = 32, Index = 1, Event = 423}         -- "Myrta Bumblebee" : "Buy Speed Boost Potent"
		evt.SetMonGroupBit{NPCGroup = 15, Bit = const.MonsterBits.Invisible, On = false}         -- "Group walkers in the Tularean forest"
	else
		evt.SetNPCTopic{NPC = 32, Index = 1, Event = 0}         -- "Myrta Bumblebee"
	end
end

events.LoadMap = evt.map[34].last

evt.hint[35] = evt.str[55]  -- "Harmondale Town Portal"
evt.map[35] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 737) then         -- "Town Portal Pass"
		evt.Subtract("Inventory", 737)         -- "Town Portal Pass"
		evt.MoveToMap{X = -6731, Y = 14045, Z = -512, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out02.Odm"}
	else
		evt.StatusText(22)         -- "You need a town portal pass!"
	end
end

evt.hint[36] = evt.str[56]  -- "Pierpont Town Portal"
evt.map[36] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 737) then         -- "Town Portal Pass"
		evt.Subtract("Inventory", 737)         -- "Town Portal Pass"
		evt.MoveToMap{X = -15148, Y = -10240, Z = 1312, Direction = 40, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out04.odm"}
	else
		evt.StatusText(22)         -- "You need a town portal pass!"
	end
end

evt.hint[37] = evt.str[16]  -- "Brianna's Brandy"
evt.map[37] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 331) then         -- 1-time Erathia
		evt.Set("QBits", 331)         -- 1-time Erathia
		evt.Set("IdentifyItemSkill", 70)
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end

evt.hint[38] = evt.str[100]  -- ""
evt.map[38] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 331) then         -- 1-time Erathia
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "sp57"}
	end
end

events.LoadMap = evt.map[38].last

evt.hint[39] = evt.str[100]  -- ""
evt.map[39] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 361) then         -- mESSENGER ONE-TIME
		if evt.Cmp("QBits", 207) then         -- Erathia - Town Portal
			evt.SetNPCGreeting{NPC = 73, Greeting = 18}         -- "Messenger" : "Welcome to Emerald Island.  I will be your guide during your stay here.  From time to time I will appear to tell you about something you're about to see to help you understand your New World.  If you tire of my messages (I won't be offended if you do), just click on my portrait to talk to me then click on 'Tour Off' to silence me.  "
			evt.SpeakNPC(73)         -- "Messenger"
			evt.SetNPCTopic{NPC = 69, Index = 0, Event = 196}         -- "Queen Catherine" : "The Kennel"
			evt.SetNPCGreeting{NPC = 69, Greeting = 19}         -- "Queen Catherine" : "Have you returned with the Journal of Experiments?"
			evt.Set("QBits", 361)         -- mESSENGER ONE-TIME
		end
	end
end

events.LoadMap = evt.map[39].last

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 269  -- "Guthwulf's Home"
evt.map[52] = function()
	evt.EnterHouse(269)         -- "Guthwulf's Home"
end

evt.house[53] = 270  -- "Wolverton Residence"
evt.map[53] = function()
	evt.EnterHouse(270)         -- "Wolverton Residence"
end

evt.house[54] = 271  -- "House 271"
evt.map[54] = function()
	evt.EnterHouse(271)         -- "House 271"
end

evt.house[55] = 272  -- "House 272"
evt.map[55] = function()
	evt.EnterHouse(272)         -- "House 272"
end

evt.house[56] = 273  -- "House 273"
evt.map[56] = function()
	evt.EnterHouse(273)         -- "House 273"
end

evt.house[57] = 274  -- "Castro's House"
evt.map[57] = function()
	evt.EnterHouse(274)         -- "Castro's House"
end

evt.house[59] = 276  -- "Laraselle Residence"
evt.map[59] = function()
	evt.EnterHouse(276)         -- "Laraselle Residence"
end

evt.house[60] = 277  -- "Sourbrow Home"
evt.map[60] = function()
	evt.EnterHouse(277)         -- "Sourbrow Home"
end

evt.house[62] = 279  -- "Agraynel Residence"
evt.map[62] = function()
	evt.EnterHouse(279)         -- "Agraynel Residence"
end

evt.house[65] = 282  -- "House 282"
evt.map[65] = function()
	evt.EnterHouse(282)         -- "House 282"
end

evt.house[66] = 283  -- "Tish Residence"
evt.map[66] = function()
	evt.EnterHouse(283)         -- "Tish Residence"
end

evt.house[67] = 284  -- "Talion House"
evt.map[67] = function()
	evt.EnterHouse(284)         -- "Talion House"
end

evt.house[68] = 285  -- "Ravenhill Residence"
evt.map[68] = function()
	evt.EnterHouse(285)         -- "Ravenhill Residence"
end

evt.house[69] = 286  -- "Cardrin Residence"
evt.map[69] = function()
	evt.EnterHouse(286)         -- "Cardrin Residence"
end

evt.house[71] = 288  -- "Gareth's Home"
evt.map[71] = function()
	evt.EnterHouse(288)         -- "Gareth's Home"
end

evt.house[72] = 289  -- "Forgewright Residence"
evt.map[72] = function()
	evt.EnterHouse(289)         -- "Forgewright Residence"
end

evt.house[73] = 290  -- "Pretty House"
evt.map[73] = function()
	evt.EnterHouse(290)         -- "Pretty House"
end

evt.house[74] = 291  -- "Lotts Familly Home"
evt.map[74] = function()
	evt.EnterHouse(291)         -- "Lotts Familly Home"
end

evt.house[76] = 293  -- "Julian's Home"
evt.map[76] = function()
	evt.EnterHouse(293)         -- "Julian's Home"
end

evt.house[77] = 294  -- "Eversmyle Residence"
evt.map[77] = function()
	evt.EnterHouse(294)         -- "Eversmyle Residence"
end

evt.house[78] = 295  -- "Dirthmoore Residence"
evt.map[78] = function()
	evt.EnterHouse(295)         -- "Dirthmoore Residence"
end

evt.house[81] = 298  -- "Heartsworn Home"
evt.map[81] = function()
	evt.EnterHouse(298)         -- "Heartsworn Home"
end

evt.house[82] = 299  -- "Cardron Residence"
evt.map[82] = function()
	evt.EnterHouse(299)         -- "Cardron Residence"
end

evt.house[84] = 301  -- "Thrush Residence"
evt.map[84] = function()
	evt.EnterHouse(301)         -- "Thrush Residence"
end

evt.house[85] = 302  -- "Lector's Retreat"
evt.map[85] = function()
	evt.EnterHouse(302)         -- "Lector's Retreat"
end

evt.house[86] = 303  -- "Courier Guild"
evt.map[86] = function()
	evt.EnterHouse(303)         -- "Courier Guild"
end

evt.house[87] = 304  -- "Org House"
evt.map[87] = function()
	evt.EnterHouse(304)         -- "Org House"
end

evt.house[88] = 305  -- "Talreish Residence"
evt.map[88] = function()
	evt.EnterHouse(305)         -- "Talreish Residence"
end

evt.house[89] = 306  -- "Temper Summer Home"
evt.map[89] = function()
	evt.EnterHouse(306)         -- "Temper Summer Home"
end

evt.house[90] = 307  -- "Havest Residence"
evt.map[90] = function()
	evt.EnterHouse(307)         -- "Havest Residence"
end

evt.hint[91] = evt.str[9]  -- "Tent"
evt.hint[92] = evt.str[10]  -- "Hut"
evt.house[93] = 492  -- "Ravenswood Residence"
evt.map[93] = function()
	evt.EnterHouse(492)         -- "Ravenswood Residence"
end

evt.house[94] = 493  -- "Blayze's"
evt.map[94] = function()
	evt.EnterHouse(493)         -- "Blayze's"
end

evt.house[95] = 494  -- "Norris' House"
evt.map[95] = function()
	evt.EnterHouse(494)         -- "Norris' House"
end

evt.house[495] = 495  -- "Dreamwright Residence"
evt.map[495] = function()
	evt.EnterHouse(495)         -- "Dreamwright Residence"
end

evt.house[496] = 496  -- "Wain Manor"
evt.map[496] = function()
	evt.EnterHouse(496)         -- "Wain Manor"
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
end, const.Week, true)

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 3) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 8) then         -- "2 points of permanent Might from the well in the northwest section of Steadwick."
		evt.Add("AutonotesBits", 8)         -- "2 points of permanent Might from the well in the northwest section of Steadwick."
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
	if not evt.Cmp("AutonotesBits", 10) then         -- "20 points of temporary Body Resistance from the well south of the Steadwick Town Hall."
		evt.Add("AutonotesBits", 10)         -- "20 points of temporary Body Resistance from the well south of the Steadwick Town Hall."
	end
	evt.Add("BodyResBonus", 20)
	evt.Add("PlayerBits", 5)
	evt.StatusText(72)         -- "+20 Body Resistance (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 5)
end, const.Day, 1*const.Hour)

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
	if not evt.Cmp("AutonotesBits", 9) then         -- "Disease cured at the eastern well in Steadwick."
		evt.Add("AutonotesBits", 9)         -- "Disease cured at the eastern well in Steadwick."
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
	if not evt.Cmp("AutonotesBits", 11) then         -- "50 points of temporary Might from the central fountain in Steadwick."
		evt.Add("AutonotesBits", 11)         -- "50 points of temporary Might from the central fountain in Steadwick."
	end
	evt.Add("MightBonus", 50)
	evt.Add("PlayerBits", 6)
	evt.StatusText(74)         -- "+50 Might (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 6)
end, const.Day, 1*const.Hour)

evt.hint[209] = evt.str[4]  -- "Drink from the Well"
evt.map[209] = function()
	if evt.Cmp("PlayerBits", 4) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 7) then         -- "10 points of temporary Accuracy from the well in the village northeast of Steadwick."
		evt.Add("AutonotesBits", 7)         -- "10 points of temporary Accuracy from the well in the village northeast of Steadwick."
	end
	evt.Add("AccuracyBonus", 10)
	evt.Add("PlayerBits", 4)
	evt.StatusText(70)         -- "+10 Accuracy (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 4)
end, const.Day, 1*const.Hour)

evt.hint[210] = evt.str[6]  -- "Drink from the Fountain"
evt.map[210] = function()
	if evt.Cmp("PlayerBits", 7) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 12) then         -- "5 points of temporary Personality from the trough in front of the Steadwick Town Hall."
		evt.Add("AutonotesBits", 12)         -- "5 points of temporary Personality from the trough in front of the Steadwick Town Hall."
	end
	evt.Add("PersonalityBonus", 5)
	evt.Add("PlayerBits", 7)
	evt.StatusText(75)         -- "+5 Personality (Temporary)"
end

Timer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 7)
end, const.Day, 1*const.Hour)

evt.hint[401] = evt.str[100]  -- ""
evt.map[401] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 29) then         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
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
		evt.Add("AutonotesBits", 115)         -- "Obelisk message #2: ininhil_"
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
	else
		if evt.CheckSeason(0) then
			evt.StatusText(60)         -- "Fruit Tree"
		else
			evt.StatusText(64)         -- ""
		end
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

evt.map[510] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 117440712) then
		evt.Add(-- ERROR: Not found
"Inventory", 83886817)
	else
		evt.SetMessage(125)
	end
end

-- ERROR: Invalid command size: 510:1 (Cmp)
-- ERROR: Invalid command size: 510:4 (Subtract)
-- ERROR: Invalid command size: 510:5 (Add)
