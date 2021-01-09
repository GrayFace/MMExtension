local TXT = Localize{
	[0] = " ",
	[1] = "Ravenshore",
	[2] = "",
	[3] = "Chest",
	[4] = "",
	[5] = "Well",
	[6] = "Drink from the well",
	[7] = "Fountain",
	[8] = "Drink from the fountain",
	[9] = "Refreshing",
	[10] = "That was not so refreshing",
	[11] = "",
	[12] = "ethesunsh",
	[13] = "The Vault of Time",
	[14] = "Door",
	[15] = "The door is locked",
	[16] = "Sealed Crate",
	[17] = "Open Crate",
	[18] = "",
	[19] = "",
	[20] = "Fruit Tree",
	[21] = "You receive an apple",
	[22] = "Berry Bush",
	[23] = "You receive some berries",
	[24] = "",
	[25] = "North",
	[26] = "West",
	[27] = "East",
	[28] = "South",
	[29] = "",
	[30] = "Shrine",
	[31] = "Altar",
	[32] = "You Pray",
	[33] = "Obelisk",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "Tree",
	[41] = "Rock",
	[42] = "Buoy",
	[43] = "Chapel of Eep",
	[44] = "Enter the Chapel of Eep",
	[45] = "Smuggler's Cove",
	[46] = "Dire Wolf Den",
	[47] = "Merchant House of Alvar",
	[48] = "Escaton's Crystal",
	[49] = "The Tomb of Lord Brinne",
	[50] = "Enter Smuggler's Cove",
	[51] = "Enter the Dire Wolf Den",
	[52] = "Enter the Merchant House of Alvar",
	[53] = "Enter Escaton's Crystal",
	[54] = "Enter the Tomb of Lord Brinne",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Might +25 (Temporary)",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "You have killed all of the Dire Wolves",
	[71] = "The Invaders have been defeated!",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(325)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 93) then         -- You have entered out02.odm, this is your new starting place
		evt.Set("QBits", 93)         -- You have entered out02.odm, this is your new starting place
		evt.Subtract("QBits", 212)         -- Power Stone - I lost it
		evt.Subtract("QBits", 213)         -- Power Stone - I lost it
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 10) then         -- Letter from Q Bit 9 delivered.
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = false}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = false}
		evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Untouchable, On = false}
	else
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
		evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Untouchable, On = true}
	end
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[100]  -- ""
evt.map[3] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 228) then         -- You have seen the Endgame movie
		goto _60
	end
	if not evt.Cmp("QBits", 56) then         -- All Lords from quests 48, 50, 52, 54 rescued.
		return
	end
	evt.Add("QBits", 228)         -- You have seen the Endgame movie
	evt.Add("History18", 0)
	evt.EnterHouse(600)         -- Win
	evt.SetNPCTopic{NPC = 53, Index = 1, Event = 115}         -- "Elgar Fellmoon" : "Merchant House"
	evt.SetNPCGreeting{NPC = 53, Greeting = 38}         -- "Elgar Fellmoon" : "Hail, Heroes of Jadame!"
	evt.SetNPCTopic{NPC = 68, Index = 0, Event = 143}         -- "Masul" : "Keys to the City"
	evt.MoveNPC{NPC = 68, HouseId = 183}         -- "Masul" -> "Minotaur Leader's Room"
	evt.SetNPCGreeting{NPC = 68, Greeting = 42}         -- "Masul" : "Hail, Saviors of Balthazar Lair!"
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetNPCTopic{NPC = 66, Index = 0, Event = 129}         -- "Deftclaw Redreaver" : "Great Deeds"
		evt.SetNPCGreeting{NPC = 66, Greeting = 40}         -- "Deftclaw Redreaver" : "Welcome. My cave is open to you."
		evt.MoveNPC{NPC = 66, HouseId = 178}         -- "Deftclaw Redreaver" -> "Dragon Leader's Cavern "
	else
		evt.SetNPCTopic{NPC = 65, Index = 0, Event = 122}         -- "Sir Charles Quixote" : "Dragon Hunting"
		evt.SetNPCGreeting{NPC = 65, Greeting = 39}         -- "Sir Charles Quixote" : "Hello again."
		evt.MoveNPC{NPC = 65, HouseId = 179}         -- "Sir Charles Quixote" -> "Charles Quixote's House"
		evt.MoveNPC{NPC = 64, HouseId = 0}         -- "Garret Deverro"
	end
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 150}         -- "Sandro" : "Safety"
		evt.SetNPCGreeting{NPC = 69, Greeting = 43}         -- "Sandro" : "Greetings, heroes."
		evt.MoveNPC{NPC = 69, HouseId = 180}         -- "Sandro" -> "Sandro/Thant's Throne Room"
		evt.MoveNPC{NPC = 76, HouseId = 0}         -- "Thant"
	else
		evt.SetNPCTopic{NPC = 67, Index = 0, Event = 136}         -- "Oskar Tyre" : "Servants of the Light"
		evt.SetNPCGreeting{NPC = 67, Greeting = 41}         -- "Oskar Tyre" : "Yes, friends?"
		evt.MoveNPC{NPC = 67, HouseId = 182}         -- "Oskar Tyre" -> "Temple of the Sun Leader Room"
	end
	evt.SetNPCTopic{NPC = 23, Index = 0, Event = 0}         -- "Xanthor"
	evt.SetNPCTopic{NPC = 23, Index = 1, Event = 157}         -- "Xanthor" : "Leaving"
	evt.SetNPCGreeting{NPC = 23, Greeting = 47}         -- "Xanthor" : "How can I help you, friends?"
	evt.SetNPCGroupNews{NPCGroup = 1, NPCNews = 10}         -- "Peasants on Main Island of Dagger Wound" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 3, NPCNews = 10}         -- "Peasants on smaller islands of Dagger Wound" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 5, NPCNews = 10}         -- "Peasants in Ravenshore city" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 6, NPCNews = 10}         -- "Peasants in Ravenshore city" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 7, NPCNews = 10}         -- "Peasants in Ravenshore city" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 16, NPCNews = 10}         -- "Peasants in Alvar" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 17, NPCNews = 10}         -- "Peasants in Alvar" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 18, NPCNews = 10}         -- "Peasants in Alvar" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 19, NPCNews = 10}         -- "Trolls in Ironsand/Rust" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 20, NPCNews = 10}         -- "Trolls in Ironsand/Rust" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 21, NPCNews = 10}         -- "Trolls in Ironsand/Rust" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 25, NPCNews = 10}         -- "Peasants in Shadowspire" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 26, NPCNews = 10}         -- "Peasants in Shadowspire" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 27, NPCNews = 10}         -- "Peasants in Shadowspire" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 28, NPCNews = 10}         -- "Peasants in Murmurwoods" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 29, NPCNews = 10}         -- "Peasants in Murmurwoods" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 30, NPCNews = 10}         -- "Ogres in Ravage Roaming by Zog's fort" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 31, NPCNews = 10}         -- "Ogres in Ravage Roaming by boat dock" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 32, NPCNews = 10}         -- "Peasant Pirates of Regna" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 33, NPCNews = 10}         -- "Peasant Pirates of Regna" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 34, NPCNews = 10}         -- "Peasant Pirates of Regna" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.SetNPCGroupNews{NPCGroup = 35, NPCNews = 10}         -- "Peasant Minotaurs in Balzathar Lair" : "We will be forever in your debt!  You have saved Ravenshore and all of Jadame!"
	evt.ForPlayer("All")
	evt.Add("Experience", 100000)
	evt.Subtract("QBits", 220)         -- Ring of Keys - I lost it
	evt.MoveNPC{NPC = 24, HouseId = 0}         -- "Queen Catherine"
	evt.MoveNPC{NPC = 25, HouseId = 0}         -- "King Roland"
::_60::
	evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 30, Bit = const.FacetBits.Invisible, On = true}
end

events.LoadMap = evt.map[3].last

evt.hint[4] = evt.str[100]  -- ""
evt.map[4] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 58) then         -- The Pirates that invaded Ravenshore are all dead now )
		if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
			if not evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
				if evt.Cmp("Counter1", 1344) then
					evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = false}         -- "Misc Group for Riki"
					evt.Add("QBits", 57)         -- The Pirates invaded Ravenshore
					evt.Set("BankGold", 0)
					return
				end
			end
		end
	end
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Misc Group for Riki"
end

events.LoadMap = evt.map[4].last

evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.house[11] = 244  -- "Wilburt's Hovel"
evt.map[11] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(244)         -- "Wilburt's Hovel"
	end
end

evt.house[12] = 244  -- "Wilburt's Hovel"
evt.house[13] = 245  -- "Jack's Hovel"
evt.map[13] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(245)         -- "Jack's Hovel"
	end
end

evt.house[14] = 245  -- "Jack's Hovel"
evt.house[15] = 246  -- "Iver's Estate"
evt.map[15] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(246)         -- "Iver's Estate"
	end
end

evt.house[16] = 246  -- "Iver's Estate"
evt.house[17] = 247  -- "Pederton Place"
evt.map[17] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(247)         -- "Pederton Place"
	end
end

evt.house[18] = 247  -- "Pederton Place"
evt.house[19] = 248  -- "Puddle's Hovel"
evt.map[19] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(248)         -- "Puddle's Hovel"
	end
end

evt.house[20] = 248  -- "Puddle's Hovel"
evt.house[21] = 249  -- "Forgewright Estate"
evt.map[21] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(249)         -- "Forgewright Estate"
	end
end

evt.house[22] = 249  -- "Forgewright Estate"
evt.house[23] = 250  -- "Apple Home"
evt.map[23] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(250)         -- "Apple Home"
	end
end

evt.house[24] = 250  -- "Apple Home"
evt.house[25] = 251  -- "Treblid's Home"
evt.map[25] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(251)         -- "Treblid's Home"
	end
end

evt.house[26] = 251  -- "Treblid's Home"
evt.house[27] = 252  -- "Holden's Hovel"
evt.map[27] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(252)         -- "Holden's Hovel"
	end
end

evt.house[28] = 252  -- "Holden's Hovel"
evt.house[29] = 253  -- "Aznog's Hovel"
evt.map[29] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(253)         -- "Aznog's Hovel"
	end
end

evt.house[30] = 253  -- "Aznog's Hovel"
evt.house[31] = 254  -- "Luodrin House"
evt.map[31] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(254)         -- "Luodrin House"
	end
end

evt.house[32] = 254  -- "Luodrin House"
evt.house[33] = 255  -- "Applebee Estate"
evt.map[33] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(255)         -- "Applebee Estate"
	end
end

evt.house[34] = 255  -- "Applebee Estate"
evt.house[35] = 256  -- "Archibald's Home"
evt.map[35] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(256)         -- "Archibald's Home"
	end
end

evt.house[36] = 256  -- "Archibald's Home"
evt.house[37] = 257  -- "Arius' House"
evt.map[37] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(257)         -- "Arius' House"
	end
end

evt.house[38] = 257  -- "Arius' House"
evt.house[39] = 258  -- "Deerhunter's House"
evt.map[39] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(258)         -- "Deerhunter's House"
	end
end

evt.house[40] = 258  -- "Deerhunter's House"
evt.house[41] = 259  -- "Townsaver Hall"
evt.map[41] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(259)         -- "Townsaver Hall"
	end
end

evt.house[42] = 259  -- "Townsaver Hall"
evt.house[43] = 260  -- "Jobber's Home"
evt.map[43] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(260)         -- "Jobber's Home"
	end
end

evt.house[44] = 260  -- "Jobber's Home"
evt.house[45] = 261  -- "Maylander's House"
evt.map[45] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(261)         -- "Maylander's House"
	end
end

evt.house[46] = 261  -- "Maylander's House"
evt.house[47] = 262  -- "Bluesawn Home"
evt.map[47] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(262)         -- "Bluesawn Home"
	end
end

evt.house[48] = 262  -- "Bluesawn Home"
evt.house[49] = 263  -- "Quicktongue Estate"
evt.map[49] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(263)         -- "Quicktongue Estate"
	end
end

evt.house[50] = 263  -- "Quicktongue Estate"
evt.house[51] = 264  -- "Laraselle Estate"
evt.map[51] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(264)         -- "Laraselle Estate"
	end
end

evt.house[52] = 264  -- "Laraselle Estate"
evt.house[53] = 265  -- "Hillsman Cottage"
evt.map[53] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(265)         -- "Hillsman Cottage"
	end
end

evt.house[54] = 265  -- "Hillsman Cottage"
evt.house[55] = 266  -- "Caverhill Estate"
evt.map[55] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(266)         -- "Caverhill Estate"
	end
end

evt.house[56] = 266  -- "Caverhill Estate"
evt.house[57] = 267  -- "Reaver's Home"
evt.map[57] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(267)         -- "Reaver's Home"
	end
end

evt.house[58] = 267  -- "Reaver's Home"
evt.house[59] = 268  -- "Temper Hall"
evt.map[59] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(268)         -- "Temper Hall"
	end
end

evt.house[60] = 268  -- "Temper Hall"
evt.house[61] = 269  -- "Putnam's Home"
evt.map[61] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(269)         -- "Putnam's Home"
	end
end

evt.house[62] = 269  -- "Putnam's Home"
evt.house[63] = 270  -- "Karrand's Cottage"
evt.map[63] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(270)         -- "Karrand's Cottage"
	end
end

evt.house[64] = 270  -- "Karrand's Cottage"
evt.house[65] = 271  -- "Lathius' Home"
evt.map[65] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(271)         -- "Lathius' Home"
	end
end

evt.house[66] = 271  -- "Lathius' Home"
evt.house[67] = 272  -- "Guild of Bounty Hunters"
evt.map[67] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(272)         -- "Guild of Bounty Hunters"
	end
end

evt.house[68] = 272  -- "Guild of Bounty Hunters"
evt.house[69] = 273  -- "Botham Hall"
evt.map[69] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(273)         -- "Botham Hall"
	end
end

evt.house[70] = 273  -- "Botham Hall"
evt.house[71] = 274  -- "Neblick's House"
evt.map[71] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(274)         -- "Neblick's House"
	end
end

evt.house[72] = 274  -- "Neblick's House"
evt.house[73] = 275  -- "Stonecleaver Hall"
evt.map[73] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(275)         -- "Stonecleaver Hall"
	end
end

evt.house[74] = 275  -- "Stonecleaver Hall"
evt.house[75] = 276  -- "Hostel"
evt.map[75] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
		return
	end
	if not evt.Cmp("QBits", 286) then         -- Did the conflux key quest
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 606) then         -- "Heart of Fire"
			if evt.Cmp("Inventory", 607) then         -- "Heart of Water"
				if evt.Cmp("Inventory", 608) then         -- "Heart of Air"
					if evt.Cmp("Inventory", 609) then         -- "Heart of Earth"
						evt.ShowMovie{DoubleSize = 1, Name = "\"confluxkey\" "}
						evt.ForPlayer("Current")
						evt.Subtract("Inventory", 606)         -- "Heart of Fire"
						evt.Subtract("Inventory", 607)         -- "Heart of Water"
						evt.Subtract("Inventory", 608)         -- "Heart of Air"
						evt.Subtract("Inventory", 609)         -- "Heart of Earth"
						evt.Add("Inventory", 610)         -- "Conflux Key"
						evt.Add("QBits", 46)         -- "Find the cause of the cataclysm through the Crystal Gateway."
						evt.Subtract("QBits", 41)         -- "Bring the Heart of Water from the Plane of Water to Xanthor."
						evt.Subtract("QBits", 42)         -- "Bring the Heart of Air from the Plane of Air to Xanthor."
						evt.Subtract("QBits", 43)         -- "Bring the Heart of Earth from the Plane of Earth to Xanthor."
						evt.Subtract("QBits", 44)         -- "Bring the Heart of Fire from the Plane of Fire to Xanthor."
						evt.Add("QBits", 45)         -- Quests 41-44 done. Items from 41-44 given to XANTHOR.
						evt.ForPlayer("All")
						evt.Add("Experience", 250000)
						evt.Add("Awards", 13)         -- "Built the Conflux Key."
						evt.SetNPCTopic{NPC = 23, Index = 0, Event = 0}         -- "Xanthor"
						evt.SetNPCTopic{NPC = 23, Index = 1, Event = 0}         -- "Xanthor"
						evt.SetNPCGreeting{NPC = 23, Greeting = 46}         -- "Xanthor" : "You must go through the crystal gateway! It leads to the plane between planes. The cause of the cataclysm lies through it--seek out the source!"
						evt.SetNPCTopic{NPC = 53, Index = 1, Event = 113}         -- "Elgar Fellmoon" : "Plane Between Planes"
						evt.SetNPCTopic{NPC = 65, Index = 0, Event = 120}         -- "Sir Charles Quixote" : "Plane Between Planes"
						evt.SetNPCTopic{NPC = 66, Index = 0, Event = 127}         -- "Deftclaw Redreaver" : "Crystal Dragons"
						evt.SetNPCTopic{NPC = 67, Index = 0, Event = 134}         -- "Oskar Tyre" : "Source of the Crisis"
						evt.SetNPCTopic{NPC = 68, Index = 0, Event = 141}         -- "Masul" : "Iron Rations"
						evt.SetNPCTopic{NPC = 69, Index = 0, Event = 148}         -- "Sandro" : "Nightmares"
						evt.Add("History15", 0)
						evt.Add("QBits", 209)         -- Conflux Key - I lost it
						evt.Subtract("QBits", 205)         -- Heart of Fire - I lost it
						evt.Subtract("QBits", 206)         -- Heart of Water - I lost it
						evt.Subtract("QBits", 207)         -- Heart of Air - I lost it
						evt.Subtract("QBits", 208)         -- Heart of Earth - I lost it
						evt.Add("QBits", 286)         -- Did the conflux key quest
					end
				end
			end
		end
	end
	evt.EnterHouse(276)         -- "Hostel"
end

evt.house[76] = 276  -- "Hostel"
evt.house[77] = 277  -- "Hostel"
evt.map[77] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(277)         -- "Hostel"
	end
end

evt.house[78] = 277  -- "Hostel"
evt.house[79] = 278  -- "Brigham's Home"
evt.map[79] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(278)         -- "Brigham's Home"
	end
end

evt.house[80] = 278  -- "Brigham's Home"
evt.hint[81] = evt.str[3]  -- "Chest"
evt.map[81] = function()
	evt.OpenChest(0)
end

evt.hint[82] = evt.str[3]  -- "Chest"
evt.map[82] = function()
	evt.OpenChest(1)
end

evt.hint[83] = evt.str[3]  -- "Chest"
evt.map[83] = function()
	evt.OpenChest(2)
end

evt.hint[84] = evt.str[3]  -- "Chest"
evt.map[84] = function()
	evt.OpenChest(3)
end

evt.hint[85] = evt.str[3]  -- "Chest"
evt.map[85] = function()
	evt.OpenChest(4)
end

evt.hint[86] = evt.str[3]  -- "Chest"
evt.map[86] = function()
	evt.OpenChest(5)
end

evt.hint[87] = evt.str[3]  -- "Chest"
evt.map[87] = function()
	evt.OpenChest(6)
end

evt.hint[88] = evt.str[3]  -- "Chest"
evt.map[88] = function()
	evt.OpenChest(7)
end

evt.hint[89] = evt.str[3]  -- "Chest"
evt.map[89] = function()
	evt.OpenChest(8)
end

evt.hint[90] = evt.str[3]  -- "Chest"
evt.map[90] = function()
	evt.OpenChest(9)
end

evt.hint[91] = evt.str[3]  -- "Chest"
evt.map[91] = function()
	evt.OpenChest(10)
end

evt.hint[92] = evt.str[40]  -- "Tree"
evt.map[92] = function()
	evt.OpenChest(11)
end

evt.hint[93] = evt.str[3]  -- "Chest"
evt.map[93] = function()
	evt.OpenChest(12)
end

evt.hint[94] = evt.str[3]  -- "Chest"
evt.map[94] = function()
	evt.OpenChest(13)
end

evt.hint[95] = evt.str[3]  -- "Chest"
evt.map[95] = function()
	evt.OpenChest(14)
end

evt.hint[96] = evt.str[3]  -- "Chest"
evt.map[96] = function()
	evt.OpenChest(15)
end

evt.hint[97] = evt.str[3]  -- "Chest"
evt.map[97] = function()
	evt.OpenChest(16)
end

evt.hint[98] = evt.str[3]  -- "Chest"
evt.map[98] = function()
	evt.OpenChest(17)
end

evt.hint[99] = evt.str[3]  -- "Chest"
evt.map[99] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 41) then         -- "Arcomage Champion."
		evt.OpenChest(18)
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[100] = evt.str[13]  -- "The Vault of Time"
evt.map[100] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 661) then         -- "Emperor Thorn's Key"
		if not evt.Cmp("MapVar1", 1) then
			evt.FaceAnimation{Player = "Current", Animation = 18}
			return
		end
	end
	evt.OpenChest(19)
	evt.Subtract("Inventory", 661)         -- "Emperor Thorn's Key"
	evt.Set("MapVar1", 1)
end

evt.hint[101] = evt.str[6]  -- "Drink from the well"
evt.map[101] = function()
	if evt.Cmp("MightBonus", 25) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("MightBonus", 25)
		evt.StatusText(60)         -- "Might +25 (Temporary)"
		evt.Add("AutonotesBits", 249)         -- "Well in the city of Ravenshore gives a temporary Strength bonus of 25."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	evt.StatusText(10)         -- "That was not so refreshing"
	evt.Set("PoisonedYellow", 0)
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[104] = evt.str[8]  -- "Drink from the fountain"
evt.map[104] = function()
	if not evt.Cmp("QBits", 180) then         -- Ravenshore Town Portal
		evt.Add("QBits", 180)         -- Ravenshore Town Portal
	end
	if not evt.Cmp("MapVar29", 2) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("BankGold", 99) then
				evt.Add("MapVar29", 1)
				evt.Add("Gold", 200)
				evt.Add("AutonotesBits", 250)         -- "Fountain in the city of Ravenshore gives 200 gold if the total gold on party and in the bank is less than 100."
				return
			end
		end
	end
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[131] = evt.str[100]  -- ""
evt.map[131] = function()  -- Timer(<function>, 7.5*const.Minute)
	if not evt.Cmp("QBits", 58) then         -- The Pirates that invaded Ravenshore are all dead now )
		if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
			if evt.CheckMonstersKilled{CheckType = 1, Id = 10, Count = 0, InvisibleAsDead = 1} then
				evt.Add("QBits", 58)         -- The Pirates that invaded Ravenshore are all dead now )
				evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
				evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
				evt.StatusText(71)         -- "The Invaders have been defeated!"
				evt.Subtract("QBits", 57)         -- The Pirates invaded Ravenshore
			end
		end
	end
end

Timer(evt.map[131].last, 7.5*const.Minute)

evt.hint[132] = evt.str[100]  -- ""
evt.map[132] = function()  -- Timer(<function>, 10*const.Minute)
	if not evt.Cmp("QBits", 140) then         -- Killed all Dire Wolves in Ravenshore
		if evt.CheckMonstersKilled{CheckType = 2, Id = 84, Count = 0, InvisibleAsDead = 0} then
			if evt.CheckMonstersKilled{CheckType = 2, Id = 85, Count = 0, InvisibleAsDead = 0} then
				if evt.CheckMonstersKilled{CheckType = 2, Id = 86, Count = 0, InvisibleAsDead = 0} then
					if evt.Cmp("QBits", 141) then         -- Dire Wolf Questbit for Riki
						evt.Set("QBits", 140)         -- Killed all Dire Wolves in Ravenshore
						evt.StatusText(70)         -- "You have killed all of the Dire Wolves"
						evt.Add("QBits", 225)         -- dead questbit for internal use(bling)
						evt.Subtract("QBits", 225)         -- dead questbit for internal use(bling)
					else
						evt.Set("QBits", 141)         -- Dire Wolf Questbit for Riki
						evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -18208, Y = 16256, Z = 8, NPCGroup = 1, unk = 0}         -- "Peasants on Main Island of Dagger Wound"
						evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = true}         -- "Peasants on Main Island of Dagger Wound"
					end
				end
			end
		end
	end
end

Timer(evt.map[132].last, 10*const.Minute)

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 187) then         -- Obelisk Area 2
		evt.StatusText(12)         -- "ethesunsh"
		evt.Add("AutonotesBits", 23)         -- "Obelisk message #7: ethesunsh"
		evt.Add("QBits", 187)         -- Obelisk Area 2
	end
end

evt.house[171] = 2  -- "Keen Edge"
evt.map[171] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(2)         -- "Keen Edge"
	end
end

evt.house[172] = 2  -- "Keen Edge"
evt.house[173] = 16  -- "The Polished Shield"
evt.map[173] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(16)         -- "The Polished Shield"
	end
end

evt.house[174] = 16  -- "The Polished Shield"
evt.house[175] = 30  -- "Needful Things"
evt.map[175] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(30)         -- "Needful Things"
	end
end

evt.house[176] = 30  -- "Needful Things"
evt.house[177] = 43  -- "Apothecary"
evt.map[177] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(43)         -- "Apothecary"
	end
end

evt.house[178] = 43  -- "Apothecary"
evt.house[179] = 140  -- "Vexation's Hexes"
evt.map[179] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(140)         -- "Vexation's Hexes"
	end
end

evt.house[180] = 140  -- "Vexation's Hexes"
evt.house[181] = 54  -- "Guild Caravans"
evt.map[181] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(54)         -- "Guild Caravans"
	end
end

evt.house[182] = 54  -- "Guild Caravans"
evt.house[183] = 64  -- "The Dauntless"
evt.map[183] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(64)         -- "The Dauntless"
	end
end

evt.house[184] = 64  -- "The Dauntless"
evt.house[185] = 75  -- "Sanctum"
evt.map[185] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(75)         -- "Sanctum"
	end
end

evt.house[186] = 75  -- "Sanctum"
evt.house[187] = 90  -- "Gymnasium"
evt.map[187] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(90)         -- "Gymnasium"
	end
end

evt.house[188] = 90  -- "Gymnasium"
evt.house[191] = 108  -- "Kessel's Kantina"
evt.map[191] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(108)         -- "Kessel's Kantina"
	end
end

evt.house[192] = 108  -- "Kessel's Kantina"
evt.house[193] = 129  -- "Steele's Vault"
evt.map[193] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(129)         -- "Steele's Vault"
	end
end

evt.house[194] = 129  -- "Steele's Vault"
evt.house[195] = 36  -- "Caori's Curios"
evt.map[195] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(36)         -- "Caori's Curios"
	end
end

evt.house[196] = 36  -- "Caori's Curios"
evt.house[197] = 116  -- "The Dancing Ogre"
evt.map[197] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(116)         -- "The Dancing Ogre"
	end
end

evt.house[198] = 116  -- "The Dancing Ogre"
evt.house[199] = 67  -- "Wind"
evt.map[199] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(67)         -- "Wind"
	end
end

evt.house[200] = 67  -- "Wind"
evt.house[201] = 148  -- "Self Guild"
evt.map[201] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(148)         -- "Self Guild"
	end
end

evt.house[202] = 148  -- "Self Guild"
evt.HouseDoor(203, 187)  -- "Oracle"
evt.house[204] = 187  -- "Oracle"
evt.house[209] = 185  -- "The Adventurer's Inn"
evt.map[209] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(185)         -- "The Adventurer's Inn"
	end
end

evt.house[210] = 185  -- "The Adventurer's Inn"
evt.hint[401] = evt.str[45]  -- "Smuggler's Cove"
evt.hint[402] = evt.str[46]  -- "Dire Wolf Den"
evt.hint[403] = evt.str[47]  -- "Merchant House of Alvar"
evt.hint[404] = evt.str[48]  -- "Escaton's Crystal"
evt.hint[405] = evt.str[49]  -- "The Tomb of Lord Brinne"
evt.hint[406] = evt.str[43]  -- "Chapel of Eep"
evt.hint[407] = evt.str[16]  -- "Sealed Crate"
evt.hint[408] = evt.str[13]  -- "The Vault of Time"
evt.hint[449] = evt.str[7]  -- "Fountain"
evt.hint[450] = evt.str[5]  -- "Well"
evt.house[451] = 279  -- "House Memoria"
evt.map[451] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(279)         -- "House Memoria"
	end
end

evt.house[452] = 279  -- "House Memoria"
evt.house[453] = 280  -- "House of Hawthorne "
evt.map[453] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(280)         -- "House of Hawthorne "
	end
end

evt.house[454] = 280  -- "House of Hawthorne "
evt.house[455] = 281  -- "Lott's Family Home"
evt.map[455] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(281)         -- "Lott's Family Home"
	end
end

evt.house[456] = 281  -- "Lott's Family Home"
evt.house[457] = 282  -- "House of Nosewort"
evt.map[457] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(282)         -- "House of Nosewort"
	end
end

evt.house[458] = 282  -- "House of Nosewort"
evt.house[459] = 286  -- "Dotes Family Hovel"
evt.map[459] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(286)         -- "Dotes Family Hovel"
	end
end

evt.house[460] = 286  -- "Dotes Family Hovel"
evt.house[461] = 283  -- "Hall of the Tracker"
evt.map[461] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(283)         -- "Hall of the Tracker"
	end
end

evt.house[462] = 283  -- "Hall of the Tracker"
evt.house[463] = 284  -- "Hunter's Hovel"
evt.map[463] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(284)         -- "Hunter's Hovel"
	end
end

evt.house[464] = 284  -- "Hunter's Hovel"
evt.house[465] = 285  -- "Dervish's Cottage"
evt.map[465] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(285)         -- "Dervish's Cottage"
	end
end

evt.house[466] = 285  -- "Dervish's Cottage"
evt.house[467] = 478  -- "House Understone"
evt.map[467] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(478)         -- "House Understone"
	end
end

evt.house[468] = 478  -- "House Understone"
evt.hint[478] = evt.str[100]  -- ""
evt.map[478] = function()  -- Timer(<function>, 7.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		evt.PlaySound{Id = 325, X = 17056, Y = -12512}
	end
end

Timer(evt.map[478].last, 7.5*const.Minute)

evt.hint[479] = evt.str[100]  -- ""
evt.hint[490] = evt.str[40]  -- "Tree"
evt.map[490] = function()
	if evt.CheckItemsCount{MinItemIndex = 221, MaxItemIndex = 271, Count = 1} then         -- "Catalyst"..."Rejuvenation"
		evt.RemoveItems{MinItemIndex = 221, MaxItemIndex = 271, Count = 1}         -- "Catalyst"..."Rejuvenation"
		evt.Add("Inventory", 220)         -- "Potion Bottle"
	end
end

evt.hint[491] = evt.str[100]  -- ""
evt.map[491] = function()
	evt.Jump{Direction = 1024, ZAngle = 300, Speed = 1500}
end

evt.hint[492] = evt.str[100]  -- ""
evt.map[492] = function()
	evt.Jump{Direction = 1536, ZAngle = 300, Speed = 1500}
end

evt.hint[493] = evt.str[100]  -- ""
evt.map[493] = function()
	evt.Jump{Direction = 0, ZAngle = 300, Speed = 1500}
end

evt.hint[494] = evt.str[14]  -- "Door"
evt.map[494] = function()
	evt.FaceAnimation{Player = "Current", Animation = 18}
	evt.StatusText(15)         -- "The door is locked"
end

evt.hint[495] = evt.str[40]  -- "Tree"
evt.map[495] = function()
	local i
	if evt.Cmp("QBits", 272) then         -- Reagant spout area 2
		return
	end
	if not evt.Cmp("PerceptionSkill", 3) then
		return
	end
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Item = 200, X = 1376, Y = 5312, Z = 126, Speed = 1000, Count = 1, RandomAngle = true}         -- "Widowsweep Berries" : "Widowsweep Berries"
	elseif i == 2 then
		evt.SummonObject{Item = 205, X = 1376, Y = 5312, Z = 126, Speed = 1000, Count = 1, RandomAngle = true}         -- "Phima Root" : "Phima Root"
	elseif i == 3 then
		evt.SummonObject{Item = 210, X = 1376, Y = 5312, Z = 126, Speed = 1000, Count = 1, RandomAngle = true}         -- "Poppy Pod" : "Poppy Pod"
	elseif i == 4 then
		evt.SummonObject{Item = 215, X = 1376, Y = 5312, Z = 126, Speed = 1000, Count = 1, RandomAngle = true}         -- "Mushroom" : "Mushroom"
	else
		evt.SummonObject{Item = 220, X = 1376, Y = 5312, Z = 126, Speed = 1000, Count = 1, RandomAngle = true}         -- "Potion Bottle" : "Potion Bottle"
	end
	evt.Add("QBits", 272)         -- Reagant spout area 2
end

evt.hint[497] = evt.str[41]  -- "Rock"
evt.map[497] = function()
	local i
	if evt.Cmp("QBits", 273) then         -- Reagant spout area 2
		return
	end
	if not evt.Cmp("PerceptionSkill", 7) then
		return
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.SummonObject{Item = 240, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Might Boost" : "Might Boost"
	elseif i == 2 then
		evt.SummonObject{Item = 241, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Intellect Boost" : "Intellect Boost"
	elseif i == 3 then
		evt.SummonObject{Item = 242, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Personality Boost" : "Personality Boost"
	elseif i == 4 then
		evt.SummonObject{Item = 243, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Endurance Boost" : "Endurance Boost"
	elseif i == 5 then
		evt.SummonObject{Item = 244, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Speed Boost" : "Speed Boost"
	else
		evt.SummonObject{Item = 245, X = 11520, Y = 14320, Z = 992, Speed = 1000, Count = 1, RandomAngle = true}         -- "Accuracy Boost" : "Accuracy Boost"
	end
	evt.Add("QBits", 273)         -- Reagant spout area 2
end

evt.hint[499] = evt.str[42]  -- "Buoy"
evt.map[499] = function()
	if not evt.Cmp("QBits", 274) then         -- Area 2 buoy
		if evt.Cmp("BaseLuck", 20) then
			evt.Add("QBits", 274)         -- Area 2 buoy
			evt.Add("SkillPoints", 5)
		end
	end
end

evt.hint[501] = evt.str[50]  -- "Enter Smuggler's Cove"
evt.map[501] = function()
	evt.MoveToMap{X = -3800, Y = 623, Z = 1, Direction = 2000, LookAngle = 0, SpeedZ = 0, HouseId = 193, Icon = 1, Name = "D07.blv"}         -- "Smuggler's Cove"
end

evt.hint[502] = evt.str[51]  -- "Enter the Dire Wolf Den"
evt.map[502] = function()
	evt.MoveToMap{X = 2157, Y = 1003, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 194, Icon = 1, Name = "D08.blv"}         -- "Dire Wolf Den"
end

evt.hint[503] = evt.str[52]  -- "Enter the Merchant House of Alvar"
evt.map[503] = function()
	if evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		evt.MoveToMap{X = 320, Y = -1290, Z = 513, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 1, Name = "D09.blv"}         -- "Merchanthouse of Alvar"
	else
		evt.SpeakNPC(3)         -- "Elgar Fellmoon"
	end
end

evt.hint[504] = evt.str[53]  -- "Enter Escaton's Crystal"
evt.map[504] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 610) then         -- "Conflux Key"
		evt.MoveToMap{X = -1024, Y = -1626, Z = 0, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 196, Icon = 1, Name = "D10.blv"}         -- "Inside the Crystal"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
	end
end

evt.hint[505] = evt.str[52]  -- "Enter the Merchant House of Alvar"
evt.map[505] = function()
	evt.MoveToMap{X = -1752, Y = 1370, Z = 449, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 195, Icon = 1, Name = "D09.blv"}         -- "Merchanthouse of Alvar"
end

evt.hint[506] = evt.str[54]  -- "Enter the Tomb of Lord Brinne"
evt.map[506] = function()
	evt.MoveToMap{X = 0, Y = -448, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D28.blv"}
end

evt.hint[507] = evt.str[44]  -- "Enter the Chapel of Eep"
evt.map[507] = function()
	evt.MoveToMap{X = -481, Y = -2824, Z = 321, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D45.blv"}
end

