local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
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
	[16] = "Fire",
	[17] = "Hatch",
	[18] = "Chest",
	[19] = "Harmondale Teleportal Hub",
	[20] = "You need a key to use this hub!",
	[21] = "This Door is Locked",
	[22] = "Signal Fire Pit",
	[23] = "It's too dangerous to enter the cave at this time.",
	[24] = "Closed for repairs.  Open again in 2 weeks.",
	[25] = "Castle Harmondale",
	[26] = "White Cliff Caves",
	[27] = "As you arrive in Harmondale, the streets are teaming with cheerful people.  The Erathian Festival of the Five Moons has just begun!",
	[28] = "As you return to Harmondale, the Festival of the Five Moons has just ended and life is returning to normal.",
	[29] = "",
	[30] = "Enter Castle Harmondale",
	[31] = "Enter the White Cliff Caves",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondale",
	[42] = "East",
	[43] = "North to the Tularean Forest",
	[44] = "West to Erathia",
	[45] = "South to Barrow Downs",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "pohuwwba",
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
	[70] = "+ 10 Might (Temporary)",
	[71] = "+2 Accuracy (Permanent)",
	[72] = "Maybe that wasn't such a good idea.",
	[73] = "You probably shouldn't do that.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 284) then         -- Beginning of Festival
		evt.Subtract("QBits", 284)         -- Beginning of Festival
		evt.Set("QBits", 294)         -- Return to EI
		evt.SpeakNPC(6)         -- "Wren Wilder"
	end
end

events.LoadMap = evt.map[1].last

evt.house[2] = 173  -- "Castle Harmondale"
evt.map[2] = function()
end

evt.house[3] = 2  -- "Tempered Steel"
evt.map[3] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(2)         -- "Tempered Steel"
	end
end

evt.house[4] = 2  -- "Tempered Steel"
evt.map[4] = function()
end

evt.house[5] = 16  -- "The Peasant's Smithy"
evt.map[5] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(16)         -- "The Peasant's Smithy"
	end
end

evt.house[6] = 16  -- "The Peasant's Smithy"
evt.map[6] = function()
end

evt.house[7] = 30  -- "Otto's Oddities"
evt.map[7] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(30)         -- "Otto's Oddities"
	end
end

evt.house[8] = 30  -- "Otto's Oddities"
evt.map[8] = function()
end

evt.house[9] = 43  -- "Philters and Elixirs"
evt.map[9] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(43)         -- "Philters and Elixirs"
	end
end

evt.house[10] = 43  -- "Philters and Elixirs"
evt.map[10] = function()
end

evt.house[11] = 75  -- "WelNin Cathedral"
evt.map[11] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(75)         -- "WelNin Cathedral"
	end
end

evt.house[12] = 75  -- "WelNin Cathedral"
evt.map[12] = function()
end

evt.house[13] = 90  -- "Basic Principles"
evt.map[13] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(90)         -- "Basic Principles"
	end
end

evt.house[14] = 90  -- "Basic Principles"
evt.map[14] = function()
end

evt.house[15] = 108  -- "On the House"
evt.map[15] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(108)         -- "On the House"
	end
end

evt.house[16] = 108  -- "On the House"
evt.map[16] = function()
end

evt.house[17] = 140  -- "Adept Guild of Fire"
evt.map[17] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(140)         -- "Adept Guild of Fire"
	end
end

evt.house[18] = 140  -- "Adept Guild of Fire"
evt.map[18] = function()
end

evt.house[19] = 144  -- "Adept Guild of Air"
evt.map[19] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(144)         -- "Adept Guild of Air"
	end
end

evt.house[20] = 144  -- "Adept Guild of Air"
evt.map[20] = function()
end

evt.house[21] = 156  -- "Adept Guild of Spirit"
evt.map[21] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(156)         -- "Adept Guild of Spirit"
	end
end

evt.house[22] = 156  -- "Adept Guild of Spirit"
evt.map[22] = function()
end

evt.house[23] = 164  -- "Adept Guild of Body"
evt.map[23] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(164)         -- "Adept Guild of Body"
	end
end

evt.house[24] = 164  -- "Adept Guild of Body"
evt.map[24] = function()
end

evt.house[25] = 147  -- "Initiate Guild of Water"
evt.map[25] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(147)         -- "Initiate Guild of Water"
	end
end

evt.house[26] = 147  -- "Initiate Guild of Water"
evt.map[26] = function()
end

evt.house[27] = 151  -- "Initiate Guild of Earth"
evt.map[27] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(151)         -- "Initiate Guild of Earth"
	end
end

evt.house[28] = 151  -- "Initiate Guild of Earth"
evt.map[28] = function()
end

evt.house[29] = 159  -- "Initiate Guild of Mind"
evt.map[29] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(159)         -- "Initiate Guild of Mind"
	end
end

evt.house[30] = 159  -- "Initiate Guild of Mind"
evt.map[30] = function()
end

evt.house[31] = 128  -- "The Vault"
evt.map[31] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(128)         -- "The Vault"
	end
end

evt.house[32] = 128  -- "The Vault"
evt.map[32] = function()
end

evt.house[33] = 102  -- "Harmondale Townhall"
evt.map[33] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(102)         -- "Harmondale Townhall"
	end
end

evt.house[34] = 102  -- "Harmondale Townhall"
evt.map[34] = function()
end

evt.house[35] = 54  -- "The J.V.C Corral"
evt.map[35] = function()
	if evt.Cmp("Awards", 26) then         -- "Reopened Harmondale Stables"
		evt.EnterHouse(54)         -- "The J.V.C Corral"
	else
		evt.SpeakNPC(461)         -- "Christian the Stablemaster"
	end
end

evt.house[36] = 54  -- "The J.V.C Corral"
evt.map[36] = function()
end

evt.house[37] = 189  -- "Arbiter"
evt.map[37] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		goto _40
	end
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		goto _75
	end
	if evt.Cmp("NPCs", 77) then         -- "Judge Fairweather"
		if evt.Cmp("QBits", 80) then         -- Gave plans to elfking
			if evt.Cmp("QBits", 81) then         -- Gave Loren to Catherine
				goto _19
			end
			if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
				goto _24
			end
			if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
				goto _24
			end
		else
			if evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
				if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
					goto _19
				end
			else
				if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
					if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
						goto _24
					end
				end
			end
		end
		goto _22
	end
	if not evt.Cmp("NPCs", 78) then         -- "Judge Sleen"
		if not evt.Cmp("QBits", 134) then         -- Arbiter Messenger only happens once
			evt.EnterHouse(189)         -- "Arbiter"
		end
		return
	end
	if evt.Cmp("QBits", 80) then         -- Gave plans to elfking
		if evt.Cmp("QBits", 81) then         -- Gave Loren to Catherine
			goto _54
		end
		if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
			goto _59
		end
		if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
			goto _59
		end
	else
		if evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
			if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
				goto _54
			end
		else
			if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
				if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
					goto _59
				end
			end
		end
	end
::_57::
	evt.Add("History14", 0)
::_62::
	evt.Set("QBits", 100)         -- Chose the path of Dark
	evt.Subtract("QBits", 153)         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
	evt.Set("QBits", 151)         -- "Enter the Pit from the Hall of the Pit in the Deyja Moors, then talk to Archibald in Castle Gloaming in the Pit."
	evt.Set("Counter5", 0)
	evt.SetNPCGreeting{NPC = 78, Greeting = 103}         -- "Judge Sleen" : "I am happy to see you again, my lords.  Deyja is very pleased with the way things have turned out.  Is there anything I can do for you?"
	evt.Subtract("NPCs", 78)         -- "Judge Sleen"
	evt.MoveNPC{NPC = 75, HouseId = 0}         -- "Ambassador Wright"
	evt.MoveNPC{NPC = 77, HouseId = 0}         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 76, HouseId = 0}         -- "Ambassador Scale"
	evt.MoveNPC{NPC = 78, HouseId = 190}         -- "Judge Sleen" -> "Arbiter"
	evt.SetNPCTopic{NPC = 78, Index = 1, Event = 142}         -- "Judge Sleen" : "Hint"
	evt.SetNPCTopic{NPC = 78, Index = 2, Event = 139}         -- "Judge Sleen" : "I lost it"
	evt.ShowMovie{DoubleSize = 1, Name = "\"arbiter evil\" "}
::_75::
	evt.EnterHouse(190)         -- "Arbiter"
	do return end
::_40::
	evt.EnterHouse(188)         -- "Arbiter"
	do return end
::_19::
	if evt.Cmp("QBits", 147) then         -- Gave artifact to arbiter
		evt.Add("History9", 0)
		goto _27
	end
	if not evt.Cmp("QBits", 84) then         -- Gave artifact to humans
		if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
			goto _24
		end
	end
::_22::
	evt.Add("History7", 0)
::_27::
	evt.Set("QBits", 99)         -- Chose the path of Light
	evt.Subtract("QBits", 153)         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
	evt.Set("QBits", 152)         -- "Enter Celeste from the grand teleporter in the Bracada Desert, then talk to Gavin Magnus in Castle Lambent in Celeste."
	evt.Set("Counter5", 0)
	evt.SetNPCGreeting{NPC = 77, Greeting = 106}         -- "Judge Fairweather" : "I am happy to see you again, my lords.  Bracada is very pleased with the way things have turned out.  Is there anything I can do for you?"
	evt.Subtract("NPCs", 77)         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 77, HouseId = 188}         -- "Judge Fairweather" -> "Arbiter"
	evt.MoveNPC{NPC = 78, HouseId = 0}         -- "Judge Sleen"
	evt.MoveNPC{NPC = 75, HouseId = 0}         -- "Ambassador Wright"
	evt.MoveNPC{NPC = 76, HouseId = 0}         -- "Ambassador Scale"
	evt.SetNPCTopic{NPC = 77, Index = 1, Event = 144}         -- "Judge Fairweather" : "Hint"
	evt.SetNPCTopic{NPC = 77, Index = 2, Event = 139}         -- "Judge Fairweather" : "I lost it"
	evt.ShowMovie{DoubleSize = 1, Name = "\"arbiter good\" "}
	goto _40
::_24::
	evt.Add("History8", 0)
	goto _27
::_54::
	if evt.Cmp("QBits", 147) then         -- Gave artifact to arbiter
		evt.Add("History16", 0)
		goto _62
	end
	if not evt.Cmp("QBits", 84) then         -- Gave artifact to humans
		if evt.Cmp("QBits", 85) then         -- Gave artifact to elves
			goto _59
		end
	end
	goto _57
::_59::
	evt.Add("History15", 0)
	goto _62
end

evt.hint[38] = evt.str[100]  -- ""
evt.map[38] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 363) then         -- Eradicated
		evt.SpeakNPC(25)         -- "Operator"
	end
end

events.LoadMap = evt.map[38].last

evt.hint[39] = evt.str[100]  -- ""
evt.map[39] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("Awards", 15) then         -- "Completed the MM7Rev4mod Game!!"
		if evt.Cmp("QBits", 374) then         -- End Game
			evt.SetNPCGreeting{NPC = 26, Greeting = 32}         -- "Count ZERO" : "Magic Shop"
			evt.SpeakNPC(26)         -- "Count ZERO"
			evt.Set("Awards", 15)         -- "Completed the MM7Rev4mod Game!!"
			evt.Subtract("QBits", 130)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
		end
	end
end

events.LoadMap = evt.map[39].last

evt.hint[50] = evt.str[100]  -- ""
evt.map[50] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 14) then         -- Accepted Fireball wand from Malwick
		return
	end
	if evt.Cmp("QBits", 190) then         -- Finished with Malwick & Assc.
		return
	end
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		goto _20
	end
	if not evt.Cmp("QBits", 182) then         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		if not evt.Cmp("QBits", 181) then         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
			if evt.Cmp("Counter5", 1008) then
				evt.Set("Counter5", 0)
				evt.Add("Inventory", 704)         -- "Message from Mr. Stantley"
				evt.SpeakNPC(98)         -- "Messenger"
				evt.Add("QBits", 181)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
			end
			return
		end
		if not evt.Cmp("Counter5", 336) then
			return
		end
	else
		if not evt.Cmp("Counter5", 672) then
			return
		end
	end
	evt.Add("QBits", 183)         -- Failed either goto or do guild quest
	evt.SpeakNPC(98)         -- "Messenger"
::_20::
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for Malwick's Assc."
	evt.Set("BankGold", 0)
	evt.Subtract("QBits", 181)         -- "Go to the Mercenary Guild in Tatalia and talk to Niles Stantley within two weeks."
	evt.Subtract("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
end

events.LoadMap = evt.map[50].last

evt.hint[51] = evt.str[100]  -- ""
evt.map[51] = function()  -- Timer(<function>, 7.5*const.Minute)
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		if not evt.Cmp("QBits", 185) then         -- Killed all outdoor monsters
			if evt.CheckMonstersKilled{CheckType = 1, Id = 9, Count = 0} then
				evt.ForPlayer("All")
				evt.Add("QBits", 185)         -- Killed all outdoor monsters
				if evt.Cmp("QBits", 184) then         -- Killed all castle monsters
					evt.ForPlayer("All")
					evt.Add("QBits", 190)         -- Finished with Malwick & Assc.
					evt.Subtract("QBits", 183)         -- Failed either goto or do guild quest
				end
			end
		end
	end
end

Timer(evt.map[51].last, 7.5*const.Minute)

evt.hint[52] = evt.str[100]  -- ""
evt.map[52] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 376) then         -- LG 1-time
		if evt.Cmp("QBits", 356) then         -- 0
			evt.SetNPCGreeting{NPC = 18, Greeting = 148}         -- "Lord Godwinson" : "Let us press on,my friends!"
			evt.SpeakNPC(18)         -- "Lord Godwinson"
			evt.Set("NPCs", 18)         -- "Lord Godwinson"
			evt.MoveNPC{NPC = 460, HouseId = 0}         -- "Lord Godwinson"
			evt.SetNPCTopic{NPC = 18, Index = 0, Event = 96}         -- "Lord Godwinson" : "Coding Wizard Quest"
			evt.Set("QBits", 376)         -- LG 1-time
		end
	end
end

events.LoadMap = evt.map[52].last

evt.map[110] = function()
	if not evt.Cmp("QBits", 133) then         -- Player castle timer only happens once
		evt.Set("Counter3", 0)
		evt.Set("QBits", 133)         -- Player castle timer only happens once
	end
	evt.SetTexture{Facet = 1, Name = "chb1dl"}
	evt.SetTexture{Facet = 2, Name = "chb1dr"}
	evt.SetTexture{Facet = 3, Name = "CHB1EL"}
	evt.SetTexture{Facet = 4, Name = "chb1er"}
	evt.SetTexture{Facet = 5, Name = "chb1s"}
	evt.SetTexture{Facet = 6, Name = "chb1"}
	evt.SetTexture{Facet = 11, Name = "chb1el"}
	evt.SetTexture{Facet = 12, Name = "chb1"}
	evt.SetTexture{Facet = 13, Name = "chb1er"}
	evt.SetTexture{Facet = 14, Name = "chb1s"}
	evt.SetTexture{Facet = 15, Name = "chbw"}
	evt.SetTexture{Facet = 7, Name = "chbw"}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = false}
	evt.SetSprite{SpriteId = 1, Visible = 1, Name = "tree07"}
	evt.SetSprite{SpriteId = 2, Visible = 1, Name = "tree01"}
	if not evt.Cmp("History5", 0) then
		evt.Add("History5", 0)
	end
end

function events.LoadMap()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		return
	end
	if not evt.Cmp("QBits", 133) then         -- Player castle timer only happens once
		evt.Set("Counter3", 0)
		evt.Set("QBits", 133)         -- Player castle timer only happens once
	end
	evt.SetTexture{Facet = 1, Name = "chb1dl"}
	evt.SetTexture{Facet = 2, Name = "chb1dr"}
	evt.SetTexture{Facet = 3, Name = "CHB1EL"}
	evt.SetTexture{Facet = 4, Name = "chb1er"}
	evt.SetTexture{Facet = 5, Name = "chb1s"}
	evt.SetTexture{Facet = 6, Name = "chb1"}
	evt.SetTexture{Facet = 11, Name = "chb1el"}
	evt.SetTexture{Facet = 12, Name = "chb1"}
	evt.SetTexture{Facet = 13, Name = "chb1er"}
	evt.SetTexture{Facet = 14, Name = "chb1s"}
	evt.SetTexture{Facet = 15, Name = "chbw"}
	evt.SetTexture{Facet = 7, Name = "chbw"}
	evt.SetFacetBit{Id = 10, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = false}
	evt.SetSprite{SpriteId = 1, Visible = 1, Name = "tree07"}
	evt.SetSprite{SpriteId = 2, Visible = 1, Name = "tree01"}
	if not evt.Cmp("History5", 0) then
		evt.Add("History5", 0)
	end
end

evt.map[111] = function()
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
end

function events.LoadMap()
	if not evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		if not evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
			return
		end
	end
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 20, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 11, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 12, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 13, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 14, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 15, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 16, Bit = const.FacetBits.Invisible, On = true}
end

evt.hint[112] = evt.str[1]  -- "Crate"
evt.map[112] = function()
	evt.OpenChest(1)
end

evt.hint[113] = evt.str[1]  -- "Crate"
evt.map[113] = function()
	evt.OpenChest(2)
end

evt.hint[114] = evt.str[1]  -- "Crate"
evt.map[114] = function()
	evt.OpenChest(3)
end

evt.hint[115] = evt.str[1]  -- "Crate"
evt.map[115] = function()
	evt.OpenChest(4)
end

evt.hint[116] = evt.str[1]  -- "Crate"
evt.map[116] = function()
	evt.OpenChest(5)
end

evt.hint[117] = evt.str[18]  -- "Chest"
evt.map[117] = function()
	evt.OpenChest(6)
end

evt.hint[118] = evt.str[18]  -- "Chest"
evt.map[118] = function()
	evt.OpenChest(7)
end

evt.hint[119] = evt.str[18]  -- "Chest"
evt.map[119] = function()
	evt.OpenChest(8)
end

evt.hint[120] = evt.str[18]  -- "Chest"
evt.map[120] = function()
	evt.OpenChest(9)
end

evt.hint[121] = evt.str[1]  -- "Crate"
evt.map[121] = function()
	evt.OpenChest(10)
end

evt.hint[122] = evt.str[1]  -- "Crate"
evt.map[122] = function()
	evt.OpenChest(11)
end

evt.hint[123] = evt.str[1]  -- "Crate"
evt.map[123] = function()
	evt.OpenChest(12)
end

evt.hint[150] = evt.str[60]  -- "Fruit Tree"
evt.map[150] = function()
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

evt.hint[151] = evt.str[60]  -- "Fruit Tree"
evt.map[151] = function()
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

evt.hint[152] = evt.str[60]  -- "Fruit Tree"
evt.map[152] = function()
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

evt.hint[153] = evt.str[60]  -- "Fruit Tree"
evt.map[153] = function()
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

evt.hint[154] = evt.str[60]  -- "Fruit Tree"
evt.map[154] = function()
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

evt.hint[155] = evt.str[60]  -- "Fruit Tree"
evt.map[155] = function()
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

evt.hint[156] = evt.str[60]  -- "Fruit Tree"
evt.map[156] = function()
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

evt.hint[157] = evt.str[60]  -- "Fruit Tree"
evt.map[157] = function()
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

evt.map[211] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 134) then         -- Arbiter Messenger only happens once
		if evt.Cmp("Counter3", 2272) then
			evt.SpeakNPC(91)         -- "Messenger"
			evt.Add("QBits", 153)         -- "Choose a judge to succeed Judge Grey as Arbiter in Harmondale."
			evt.Add("History6", 0)
			evt.MoveNPC{NPC = 67, HouseId = 0}         -- "Ellen Rockway"
			evt.MoveNPC{NPC = 68, HouseId = 0}         -- "Alain Hani"
			evt.MoveNPC{NPC = 75, HouseId = 174}         -- "Ambassador Wright" -> "Throne Room"
			evt.MoveNPC{NPC = 77, HouseId = 112}         -- "Judge Fairweather" -> "Familiar Place"
			evt.Set("QBits", 134)         -- Arbiter Messenger only happens once
		end
	end
end

events.LoadMap = evt.map[211].last

evt.hint[212] = evt.str[43]  -- "North to the Tularean Forest"
evt.hint[213] = evt.str[44]  -- "West to Erathia"
evt.hint[214] = evt.str[45]  -- "South to Barrow Downs"
evt.hint[215] = evt.str[42]  -- "East"
evt.hint[216] = evt.str[46]  -- "Harmondale"
evt.hint[217] = evt.str[3]  -- "Well"
evt.hint[218] = evt.str[19]  -- "Harmondale Teleportal Hub"
evt.map[218] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 665) then         -- "Tatalia Teleportal Key"
		evt.MoveToMap{X = 6604, Y = -8941, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 226, Icon = 4, Name = "Out13.odm"}         -- "Harmondale Teleportal Hub"
		goto _9
	end
	if evt.Cmp("Inventory", 667) then         -- "Avlee Teleportal Key"
		goto _9
	end
	if evt.Cmp("Inventory", 666) then         -- "Deja Teleportal Key"
		goto _10
	end
	if evt.Cmp("Inventory", 669) then         -- "Bracada Teleportal Key"
		goto _11
	end
	if not evt.Cmp("Inventory", 668) then         -- "Evenmorn Teleportal Key"
		evt.StatusText(20)         -- "You need a key to use this hub!"
		return
	end
::_12::
	evt.MoveToMap{X = 17161, Y = -10827, Z = 0, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 226, Icon = 4, Name = "Out09.odm"}         -- "Harmondale Teleportal Hub"
	do return end
::_9::
	evt.MoveToMap{X = 14414, Y = 12615, Z = 0, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 226, Icon = 4, Name = "Out14.odm"}         -- "Harmondale Teleportal Hub"
::_10::
	evt.MoveToMap{X = 4586, Y = -12681, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 226, Icon = 4, Name = "Out05.odm"}         -- "Harmondale Teleportal Hub"
::_11::
	evt.MoveToMap{X = 8832, Y = 18267, Z = 0, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 226, Icon = 4, Name = "Out06.odm"}         -- "Harmondale Teleportal Hub"
	goto _12
end

evt.hint[219] = evt.str[41]  -- "Castle Harmondale"
evt.hint[220] = evt.str[50]  -- "Obelisk"
evt.map[220] = function()
	if not evt.Cmp("QBits", 164) then         -- Visited Obelisk in Area 2
		evt.StatusText(51)         -- "pohuwwba"
		evt.Add("AutonotesBits", 114)         -- "Obelisk message #1: pohuwwba"
		evt.ForPlayer("All")
		evt.Add("QBits", 164)         -- Visited Obelisk in Area 2
	end
end

evt.hint[221] = evt.str[53]  -- "Altar"
evt.map[221] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 356) then         -- 0
		evt.StatusText(54)         -- "You Pray"
		return
	end
	evt.Subtract("QBits", 206)         -- Harmondale - Town Portal
	evt.Subtract("QBits", 207)         -- Erathia - Town Portal
	evt.Subtract("QBits", 208)         -- Tularean Forest - Town Portal
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
::_8::
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	evt.Subtract("Inventory", 223)         -- "Magic Potion"
	evt.Subtract("Inventory", 332)         -- "Lloyd's Beacon"
	if evt.Cmp("Inventory", 332) then         -- "Lloyd's Beacon"
		goto _8
	end
	if evt.Cmp("Inventory", 223) then         -- "Magic Potion"
		goto _8
	end
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("SP", 0)
	end
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("SP", 0)
	end
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("SP", 0)
	end
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("SP", 0)
	end
	evt.ForPlayer("All")
	evt.CastSpell{Spell = 80, Mastery = const.GM, Skill = 53, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Dispel Magic"
	evt.Subtract("QBits", 206)         -- Harmondale - Town Portal
	evt.MoveToMap{X = -3257, Y = -12544, Z = 833, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D08.blv"}
end

evt.hint[222] = evt.str[52]  -- "Shrine"
evt.hint[223] = evt.str[4]  -- "Drink from the Well"
evt.map[223] = function()
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

evt.hint[227] = evt.str[6]  -- "Drink from the Fountain"
evt.map[227] = function()
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
	evt.StatusText(72)         -- "Maybe that wasn't such a good idea."
	do return end
::_12::
	evt.StatusText(73)         -- "You probably shouldn't do that."
end

evt.hint[228] = evt.str[4]  -- "Drink from the Well"
evt.map[228] = function()
	if evt.Cmp("PlayerBits", 2) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("BaseAccuracy", 2)
		evt.Add("PlayerBits", 2)
		evt.StatusText(71)         -- "+2 Accuracy (Permanent)"
	end
end

evt.hint[229] = evt.str[100]  -- ""
evt.map[229] = function()  -- Timer(<function>, 2.5*const.Minute)
	local i
	if not evt.Cmp("QBits", 248) then         -- Took area 2 hill fort
		i = Game.Rand() % 4
		if i == 1 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 4903, ToY = 7358, ToZ = 1}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 3820, ToY = 6694, ToZ = 1}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5419, ToY = 7931, ToZ = 1}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 1}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 4952, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 512}         -- "Death Blossom"
			end
		elseif i == 2 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11822, ToY = 8132, ToZ = 0}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11218, ToY = 7086, ToZ = 0}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 12054, ToY = 6754, ToZ = 0}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 0}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 4952, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 512}         -- "Death Blossom"
			end
		elseif i == 3 then
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 13002, ToY = 728, ToZ = 64}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11937, ToY = 538, ToZ = 64}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11239, ToY = -167, ToZ = 64}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 47}         -- "Sparks"
			else
				evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 3248, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 512}         -- "Death Blossom"
			end
		else
			i = Game.Rand() % 5
			if i == 1 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5493, ToY = 88, ToZ = 1}         -- "Fireball"
			elseif i == 2 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5452, ToY = 815, ToZ = 1}         -- "Fireball"
			elseif i == 3 then
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 4448, ToY = 1052, ToZ = 1}         -- "Fireball"
			elseif i == 4 then
				evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 1}         -- "Sparks"
			else
				evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 3248, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 512}         -- "Fireball"
			end
		end
	end
end

Timer(evt.map[229].last, 2.5*const.Minute)

evt.hint[231] = evt.str[16]  -- "Fire"
evt.map[231] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 4903, ToY = 7358, ToZ = 1}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 3820, ToY = 6694, ToZ = 1}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5419, ToY = 7931, ToZ = 1}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 7368, FromY = 4920, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 1}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 4952, FromZ = 416, ToX = 5507, ToY = 6889, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[232] = evt.str[16]  -- "Fire"
evt.map[232] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11822, ToY = 8132, ToZ = 0}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 11218, ToY = 7086, ToZ = 0}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 12054, ToY = 6754, ToZ = 0}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 10, FromX = 9000, FromY = 4920, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 0}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 4952, FromZ = 416, ToX = 10772, ToY = 6539, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[233] = evt.str[16]  -- "Fire"
evt.map[233] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 13002, ToY = 728, ToZ = 64}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11937, ToY = 538, ToZ = 64}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 11239, ToY = -167, ToZ = 64}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 9000, FromY = 3280, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 47}         -- "Sparks"
	else
		evt.CastSpell{Spell = 43, Mastery = const.Master, Skill = 10, FromX = 9032, FromY = 3248, FromZ = 416, ToX = 10486, ToY = 1825, ToZ = 512}         -- "Death Blossom"
	end
end

evt.hint[234] = evt.str[16]  -- "Fire"
evt.map[234] = function()
	local i
	i = Game.Rand() % 5
	if i == 1 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5493, ToY = 88, ToZ = 1}         -- "Fireball"
	elseif i == 2 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5452, ToY = 815, ToZ = 1}         -- "Fireball"
	elseif i == 3 then
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 4448, ToY = 1052, ToZ = 1}         -- "Fireball"
	elseif i == 4 then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 10, FromX = 7368, FromY = 3280, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 1}         -- "Sparks"
	else
		evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 10, FromX = 7336, FromY = 3248, FromZ = 416, ToX = 5319, ToY = 1298, ToZ = 512}         -- "Fireball"
	end
end

evt.hint[235] = evt.str[17]  -- "Hatch"
evt.map[235] = function()
	evt.SetFacetBit{Id = 50, Bit = const.FacetBits.Invisible, On = true}
end

evt.hint[236] = evt.str[100]  -- ""
evt.map[236] = function()
	if not evt.Cmp("QBits", 248) then         -- Took area 2 hill fort
		evt.Add("QBits", 248)         -- Took area 2 hill fort
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 6545, FromY = 10984, FromZ = 4000, ToX = 6545, ToY = 5678, ToZ = 111}         -- "Fire Bolt"
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 13458, FromY = 8781, FromZ = 4000, ToX = 8805, ToY = 5257, ToZ = 204}         -- "Fire Bolt"
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 5232, Y = 1424, Z = 0, NPCGroup = 0, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 10880, Y = 784, Z = 64, NPCGroup = 0, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 5824, Y = 6400, Z = 12, NPCGroup = 0, unk = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = 10832, Y = 6208, Z = 0, NPCGroup = 0, unk = 0}
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 8096, FromY = -3423, FromZ = 4000, ToX = 7952, ToY = 3872, ToZ = 320}         -- "Fire Bolt"
		evt.CastSpell{Spell = 2, Mastery = const.GM, Skill = 10, FromX = 12240, FromY = 7312, FromZ = 0, ToX = 8160, ToY = 5136, ToZ = 314}         -- "Fire Bolt"
	end
end

evt.hint[237] = evt.str[22]  -- "Signal Fire Pit"
evt.map[237] = function()
	if not evt.Cmp("QBits", 267) then         -- South Signal Fire Out02
		evt.Set("QBits", 267)         -- South Signal Fire Out02
		evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec24"}
		if evt.Cmp("QBits", 268) then         -- North Signal Fire Out02
			if evt.Cmp("QBits", 269) then         -- West Siganl Fire Out02
				evt.Set("QBits", 262)         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[238] = evt.str[22]  -- "Signal Fire Pit"
evt.map[238] = function()
	if not evt.Cmp("QBits", 268) then         -- North Signal Fire Out02
		evt.Set("QBits", 268)         -- North Signal Fire Out02
		evt.SetSprite{SpriteId = 21, Visible = 1, Name = "dec24"}
		if evt.Cmp("QBits", 267) then         -- South Signal Fire Out02
			if evt.Cmp("QBits", 269) then         -- West Siganl Fire Out02
				evt.Set("QBits", 262)         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[239] = evt.str[22]  -- "Signal Fire Pit"
evt.map[239] = function()
	if not evt.Cmp("QBits", 269) then         -- West Siganl Fire Out02
		evt.Set("QBits", 269)         -- West Siganl Fire Out02
		evt.SetSprite{SpriteId = 22, Visible = 1, Name = "dec24"}
		if evt.Cmp("QBits", 268) then         -- North Signal Fire Out02
			if evt.Cmp("QBits", 267) then         -- South Signal Fire Out02
				evt.Set("QBits", 262)         -- Time for Gobs to appear in area 2(raiding camp)
			end
		end
	end
end

evt.hint[240] = evt.str[100]  -- ""
evt.map[240] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 262) then         -- Time for Gobs to appear in area 2(raiding camp)
		evt.SetMonGroupBit{NPCGroup = 20, Bit = const.MonsterBits.Invisible, On = false}         -- "Ridge walkers in Bracada"
	end
end

events.LoadMap = evt.map[240].last

evt.hint[249] = evt.str[100]  -- ""
evt.map[249] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[249].last

evt.house[251] = 465  -- "Mist Manor"
evt.map[251] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(465)         -- "Mist Manor"
	end
end

evt.house[252] = 466  -- "Hillsmen Residence"
evt.map[252] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(466)         -- "Hillsmen Residence"
	end
end

evt.house[253] = 467  -- "Stillwater Residence"
evt.map[253] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(467)         -- "Stillwater Residence"
	end
end

evt.house[254] = 468  -- "Mark Manor"
evt.map[254] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(468)         -- "Mark Manor"
	end
end

evt.house[255] = 469  -- "Bowes Residence"
evt.map[255] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(469)         -- "Bowes Residence"
	end
end

evt.house[256] = 470  -- "Godwinson Estate"
evt.map[256] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(470)         -- "Godwinson Estate"
	end
end

evt.house[257] = 471  -- "Krewlen Residence"
evt.map[257] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(471)         -- "Krewlen Residence"
	end
end

evt.house[258] = 472  -- "Withersmythe's Home"
evt.map[258] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(472)         -- "Withersmythe's Home"
	end
end

evt.house[260] = 485  -- "Kern Residence"
evt.map[260] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(485)         -- "Kern Residence"
	end
end

evt.house[261] = 486  -- "Chadric's House"
evt.map[261] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(486)         -- "Chadric's House"
	end
end

evt.house[262] = 487  -- "Weider Residence"
evt.map[262] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(487)         -- "Weider Residence"
	end
end

evt.house[263] = 490  -- "Kinney Residence"
evt.map[263] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(490)         -- "Kinney Residence"
	end
end

evt.house[264] = 491  -- "Farswell Residence"
evt.map[264] = function()
	if evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(491)         -- "Farswell Residence"
	end
end

evt.hint[265] = evt.str[7]  -- "House"
evt.hint[266] = evt.str[10]  -- "Hut"
evt.house[267] = 488  -- "Skinner's House"
evt.map[267] = function()
	evt.EnterHouse(488)         -- "Skinner's House"
end

evt.house[268] = 489  -- "Torrent's"
evt.map[268] = function()
	evt.EnterHouse(489)         -- "Torrent's"
end

evt.hint[301] = evt.str[30]  -- "Enter Castle Harmondale"
evt.map[301] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 173, Icon = 9, Name = "D29.Blv"}         -- "Castle Harmondale"
	else
		if evt.Cmp("QBits", 132) then         -- Butler only shows up once (area 2)
			evt.MoveToMap{X = -5073, Y = -2842, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 193, Icon = 9, Name = "D29.Blv"}         -- "Castle Harmondale"
		else
			evt.Add("History3", 0)
			evt.SpeakNPC(58)         -- "Butler"
			evt.MoveNPC{NPC = 58, HouseId = 108}         -- "Butler" -> "On the House"
			evt.ForPlayer("All")
			evt.Set("QBits", 75)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
			evt.Set("QBits", 132)         -- Butler only shows up once (area 2)
		end
	end
end

evt.hint[302] = evt.str[31]  -- "Enter the White Cliff Caves"
evt.map[302] = function()
	if evt.Cmp("QBits", 324) then         -- White Cliff Cave Permission
		evt.MoveToMap{X = 1344, Y = -256, Z = -107, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 194, Icon = 3, Name = "D21.blv"}         -- "White Cliff Caves"
	else
		evt.StatusText(23)         -- "It's too dangerous to enter the cave at this time."
	end
end

