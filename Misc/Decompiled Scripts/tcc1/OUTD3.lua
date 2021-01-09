local TXT = Localize{
	[0] = " ",
	[1] = "Kat'an",
	[2] = "Enter at Own Risk.",
	[3] = "Keep Off!",
	[4] = "Kat'an Castle",
	[5] = "Sutter's Bay",
	[6] = "+10 Speed temporary.",
	[7] = "All Hit points restored.",
	[8] = "Refreshing!",
	[9] = "The prince has been kidnapped!  No visitors will be admitted until this crisis has been resolved!",
	[10] = "Crate",
	[11] = "Well",
	[12] = "Chest",
	[13] = "Well, thanks for sneaking me out of the Castle.  Sorry about the circus thing—I hope I wasn’t too much trouble to find.  I’ll go in myself so no one will see that it was you who kidnapped me.  Thanks again, and goodbye.  I’ll remember this, and I owe you a favor! ",
	[14] = "The Sword won't budge!",
	[15] = "Drink from Fountain",
	[16] = "+10 Accuracy temporary.",
	[17] = "+10 Hit Points restored.",
	[18] = "Shrine of Magic",
	[19] = "You pray at the shrine.",
	[20] = "+20 Magic resistance permanent",
	[21] = "+5 Magic resistance permanent",
	[22] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _fhnftete_cn_foce_",
	[23] = "Obelisk",
	[24] = "The Seer is deep in meditation and cannot be  disturbed.",
	[25] = "You cannot enter here at this time.",
	[26] = "The Refuge",
	[27] = "On vacation.  Try again later.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 1:0
evt.MazeInfo = evt.str[1]  -- "Kat'an"
-- ERROR: Duplicate label: 71:0
-- ERROR: Duplicate label: 90:10
-- ERROR: Duplicate label: 90:11
-- ERROR: evt.house[91] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[92] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[93] not assigned for hint, because Hint command is missing
-- ERROR: Duplicate label: 94:10
-- ERROR: Duplicate label: 94:11
-- ERROR: Duplicate label: 94:2

evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 510) then         -- SOG Ironfist
		evt.MoveToMap{X = 17350, Y = 6300, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		evt.Set("QBits", 510)         -- SOG Ironfist
		evt.ForPlayer("Current")
		evt.Set("Gold", 1000)
		evt.Subtract("Inventory", 505)         -- "Royal Land Grant "
		evt.ForPlayer(0)
		evt.Set("BowSkill", 1)
		evt.Set("Experience", 500)
		evt.ForPlayer(1)
		evt.Set("BowSkill", 1)
		evt.Set("Experience", 500)
		evt.ForPlayer(2)
		evt.Set("BowSkill", 1)
		evt.Set("Experience", 500)
		evt.ForPlayer(3)
		evt.Set("BowSkill", 1)
		evt.Set("Experience", 500)
		evt.ForPlayer("All")
		evt.Subtract("QBits", 493)         -- Seer Tamara Once
		evt.MoveNPC{NPC = 9, HouseId = 169}         -- "The Seer" -> "The Seer"
	end
end

events.LoadMap = evt.map[1].last

evt.house[2] = 3  -- "Fine Blades"
evt.map[2] = function()
	evt.EnterHouse(3)         -- "Fine Blades"
end

evt.house[3] = 3  -- "Fine Blades"
evt.map[3] = function()
end

evt.house[4] = 17  -- "Metalweave Armory"
evt.map[4] = function()
	evt.EnterHouse(17)         -- "Metalweave Armory"
end

evt.house[5] = 17  -- "Metalweave Armory"
evt.map[5] = function()
end

evt.house[6] = 33  -- "Eye of Newt"
evt.map[6] = function()
	evt.EnterHouse(33)         -- "Eye of Newt"
end

evt.house[7] = 33  -- "Eye of Newt"
evt.map[7] = function()
end

evt.house[8] = 49  -- "Royal Lines "
evt.map[8] = function()
	if not evt.Cmp("QBits", 489) then         -- Kat'an Travel Once
		evt.Set("QBits", 489)         -- Kat'an Travel Once
		evt.ForPlayer("Current")
		evt.Add("Inventory", 508)         -- "Kat'an Travel Schedule"
	end
	evt.EnterHouse(49)         -- "Royal Lines "
end

evt.house[9] = 49  -- "Royal Lines "
evt.map[9] = function()
end

evt.house[10] = 85  -- "Royal Gymnasium"
evt.map[10] = function()
	evt.EnterHouse(85)         -- "Royal Gymnasium"
end

evt.house[11] = 85  -- "Royal Gymnasium"
evt.map[11] = function()
end

evt.house[12] = 96  -- "The Lamb and Flag"
evt.map[12] = function()
	if evt.Cmp("QBits", 509) then         -- Mini Me Once
		evt.EnterHouse(96)         -- "The Lamb and Flag"
	else
		evt.SetNPCTopic{NPC = 18, Index = 1, Event = 1}         -- "The Seer" : "Greetings!"
		evt.SetNPCTopic{NPC = 18, Index = 2, Event = 1}         -- "The Seer" : "Greetings!"
		evt.SetNPCTopic{NPC = 18, Index = 0, Event = 1}         -- "The Seer" : "Greetings!"
		evt.SpeakNPC(18)         -- "The Seer"
	end
end

evt.house[13] = 96  -- "The Lamb and Flag"
evt.map[13] = function()
end

evt.house[14] = 119  -- "Initiate Guild of Ignis"
evt.map[14] = function()
	evt.EnterHouse(119)         -- "Initiate Guild of Ignis"
end

evt.house[15] = 119  -- "Initiate Guild of Ignis"
evt.map[15] = function()
end

evt.house[16] = 155  -- "Enchanted Bastion"
evt.map[16] = function()
	evt.EnterHouse(155)         -- "Enchanted Bastion"
end

evt.house[17] = 155  -- "Enchanted Bastion"
evt.map[17] = function()
end

evt.house[18] = 169  -- "The Seer"
evt.map[18] = function()
	if evt.Cmp("Awards", 2) then         -- "Resued Tamara"
		evt.EnterHouse(169)         -- "The Seer"
	else
		evt.StatusText(24)         -- "The Seer is deep in meditation and cannot be  disturbed."
	end
end

evt.house[19] = 76  -- "King's Temple"
evt.map[19] = function()
	evt.EnterHouse(76)         -- "King's Temple"
end

evt.hint[40] = evt.str[5]  -- "Sutter's Bay"
evt.map[40] = function()
	evt.StatusText(5)         -- "Sutter's Bay"
end

evt.hint[41] = evt.str[4]  -- "Kat'an Castle"
evt.map[41] = function()
	evt.StatusText(4)         -- "Kat'an Castle"
end

evt.house[42] = 168  -- "King's Library"
evt.map[42] = function()
	if evt.Cmp("QBits", 177) then         -- NPC
		evt.EnterHouse(554)         -- "King's Library"
	else
		evt.EnterHouse(168)         -- "King's Library"
	end
end

evt.house[43] = 154  -- "Castle Kat'an"
evt.map[43] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("DiplomacySkill", 136) then
		evt.EnterHouse(154)         -- "Castle Kat'an"
	else
		evt.SetNPCTopic{NPC = 183, Index = 0, Event = 349}         -- "Guard" : "Audience with the King"
		evt.SpeakNPC(183)         -- "Guard"
	end
end

evt.house[44] = 58  -- "Tropical Whisper"
evt.map[44] = function()
	evt.EnterHouse(58)         -- "Tropical Whisper"
end

evt.house[45] = 59  -- "Queen Hro'mela"
evt.map[45] = function()
	evt.EnterHouse(59)         -- "Queen Hro'mela"
end

evt.house[46] = 4  -- "The Eagle's Eye"
evt.map[46] = function()
	evt.EnterHouse(4)         -- "The Eagle's Eye"
end

evt.house[47] = 4  -- "The Eagle's Eye"
evt.map[47] = function()
end

evt.house[48] = 21  -- "Iron Defense"
evt.map[48] = function()
	evt.EnterHouse(21)         -- "Iron Defense"
end

evt.house[49] = 21  -- "Iron Defense"
evt.map[49] = function()
end

evt.house[50] = 97  -- "The Will o' Wisp"
evt.map[50] = function()
	evt.EnterHouse(97)         -- "The Will o' Wisp"
end

evt.house[51] = 97  -- "The Will o' Wisp"
evt.map[51] = function()
end

evt.house[52] = 127  -- "Animus Magic for the Proficient"
evt.map[52] = function()
	evt.EnterHouse(127)         -- "Animus Magic for the Proficient"
end

evt.house[53] = 127  -- "Animus Magic for the Proficient"
evt.map[53] = function()
end

evt.house[54] = 129  -- "Mentis Magic for the Proficient"
evt.map[54] = function()
	evt.EnterHouse(129)         -- "Mentis Magic for the Proficient"
end

evt.house[55] = 129  -- "Mentis Magic for the Proficient"
evt.map[55] = function()
end

evt.house[56] = 131  -- "Corpus Magic for the Proficient"
evt.map[56] = function()
	evt.EnterHouse(131)         -- "Corpus Magic for the Proficient"
end

evt.house[57] = 131  -- "Corpus Magic for the Proficient"
evt.map[57] = function()
end

evt.house[82] = 146  -- "Berserkers' Fury"
evt.map[82] = function()
	evt.EnterHouse(146)         -- "Berserkers' Fury"
end

evt.house[58] = 424  -- "House"
evt.map[58] = function()
	evt.EnterHouse(424)         -- "House"
end

evt.house[59] = 425  -- "House"
evt.map[59] = function()
	evt.EnterHouse(425)         -- "House"
end

evt.house[60] = 426  -- "House"
evt.map[60] = function()
	evt.EnterHouse(426)         -- "House"
end

evt.house[61] = 428  -- "House"
evt.map[61] = function()
	evt.EnterHouse(428)         -- "House"
end

evt.house[62] = 429  -- "House"
evt.map[62] = function()
	evt.EnterHouse(429)         -- "House"
end

evt.house[63] = 430  -- "House"
evt.map[63] = function()
	evt.EnterHouse(430)         -- "House"
end

evt.house[64] = 431  -- "House"
evt.map[64] = function()
	evt.EnterHouse(431)         -- "House"
end

evt.house[65] = 434  -- "House"
evt.map[65] = function()
	evt.EnterHouse(434)         -- "House"
end

evt.house[66] = 435  -- "House"
evt.map[66] = function()
	evt.EnterHouse(435)         -- "House"
end

evt.house[67] = 436  -- "House"
evt.map[67] = function()
	evt.EnterHouse(436)         -- "House"
end

evt.house[68] = 437  -- "House"
evt.map[68] = function()
	evt.EnterHouse(437)         -- "House"
end

evt.house[69] = 439  -- "House"
evt.map[69] = function()
	evt.EnterHouse(439)         -- "House"
end

evt.house[70] = 440  -- "House"
evt.map[70] = function()
	evt.EnterHouse(440)         -- "House"
end

evt.house[71] = 427  -- "House"
evt.map[71] = function()
	evt.EnterHouse(427)         -- "House"
end

evt.house[72] = 433  -- "House"
evt.map[72] = function()
	evt.EnterHouse(433)         -- "House"
end

evt.house[73] = 438  -- "House"
evt.map[73] = function()
	evt.EnterHouse(438)         -- "House"
end

evt.house[74] = 441  -- "House"
evt.map[74] = function()
	evt.EnterHouse(441)         -- "House"
end

evt.house[75] = 442  -- "House"
evt.map[75] = function()
	evt.EnterHouse(442)         -- "House"
end

evt.house[83] = 257  -- "House"
evt.map[83] = function()
	evt.EnterHouse(257)         -- "House"
end

evt.hint[81] = evt.str[10]  -- "Crate"
evt.map[81] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[10]  -- "Crate"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[10]  -- "Crate"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.hint[78] = evt.str[10]  -- "Crate"
evt.map[78] = function()
	evt.OpenChest(4)
end

evt.hint[79] = evt.str[10]  -- "Crate"
evt.map[79] = function()
	evt.OpenChest(5)
end

evt.hint[80] = evt.str[10]  -- "Crate"
evt.map[80] = function()
	evt.OpenChest(6)
end

evt.house[90] = 362  -- "Cavern of the Rogue"
evt.map[90] = function()
	evt.MoveToMap{X = -622, Y = 239, Z = 1, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "ZDDB01.Blv"}
end

evt.map[91] = function()
	evt.MoveToMap{X = 1893, Y = 122, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "ZDwj02.Blv"}
end

evt.map[92] = function()
	evt.MoveToMap{X = 2716, Y = -256, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "D06.Blv"}
end

evt.map[93] = function()
	evt.MoveToMap{X = 128, Y = -151, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 181, Icon = 5, Name = "D11.Blv"}         -- "Luftka's Estate"
end

evt.house[94] = 206  -- "Maiva's Finishing School"
evt.map[94] = function()
	if not evt.Cmp("QBits", 90) then         -- "Gain the trust of the  Lords and The Ladies of Nimradur.  Then return to The Seer in Kat'an."
		evt.StatusText(27)         -- "On vacation.  Try again later."
		if not evt.Cmp("Awards", 32) then         -- "Gained the trust of the Lords and Ladies"
			return
		end
	end
	evt.EnterHouse(206)         -- "Maiva's Finishing School"
end

evt.house[97] = 78  -- "Temple Carmen"
evt.map[97] = function()
	evt.EnterHouse(78)         -- "Temple Carmen"
end

evt.hint[100] = evt.str[15]  -- "Drink from Fountain"
evt.map[100] = function()
	if evt.Cmp("SpeedBonus", 10) then
		evt.StatusText(8)         -- "Refreshing!"
	else
		evt.Set("SpeedBonus", 10)
		evt.StatusText(6)         -- "+10 Speed temporary."
		evt.Set("AutonotesBits", 20)         -- "10 Points of temporary speed from the east fountain at Castle Kat'an."
	end
end

evt.hint[101] = evt.str[15]  -- "Drink from Fountain"
evt.map[101] = function()
	if not evt.Cmp("AccuracyBonus", 10) then
		evt.Set("AccuracyBonus", 10)
		evt.StatusText(16)         -- "+10 Accuracy temporary."
		evt.Set("AutonotesBits", 19)         -- "10 Points of temporary accuracy from the west fountain at Castle Kat'an."
	end
end

evt.hint[102] = evt.str[15]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("MapVar24", 1) then
		evt.Subtract("MapVar24", 1)
		evt.Add("HP", 10)
		evt.StatusText(17)         -- "+10 Hit Points restored."
	else
		evt.StatusText(8)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 21)         -- "10 Hit points restored from the fountain in the Arena."
end

Timer(function()
	evt.Set("MapVar24", 30)
end, const.Day, 1*const.Second)

evt.map[200] = function()  -- Timer(<function>, 30*const.Minute)
	if not evt.Cmp("MapVar1", 8) then
		if evt.Cmp("MapVar0", 1) then
			evt.SummonObject{Type = 8080, X = -12024, Y = -3784, Z = 400, Speed = 512, Count = 1, RandomAngle = true}         -- Paralyze
			evt.SummonObject{Type = 8080, X = -12032, Y = -4744, Z = 400, Speed = 512, Count = 1, RandomAngle = true}         -- Paralyze
			evt.SummonObject{Type = 8080, X = -12040, Y = -2712, Z = 640, Speed = 750, Count = 1, RandomAngle = true}         -- Paralyze
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -13040, Y = -2424, Z = 645}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -10392, Y = -2224, Z = 645}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -12752, Y = -3856, Z = 640}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -11328, Y = -3808, Z = 640}
			evt.Add("MapVar1", 1)
		end
	end
end

Timer(evt.map[200].last, 30*const.Minute)

evt.hint[201] = evt.str[3]  -- "Keep Off!"
evt.map[201] = function()
	evt.Set("MapVar0", 1)
	evt.MoveToMap{X = -12045, Y = -6073, Z = 2, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[202] = evt.str[3]  -- "Keep Off!"
evt.map[202] = function()
	evt.Set("MapVar0", 0)
end

evt.hint[203] = evt.str[3]  -- "Keep Off!"
evt.map[203] = function()
	evt.SetSnow{EffectId = 1, On = false}
	evt.MoveToMap{X = 17920, Y = 14344, Z = 2080, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[210] = function()
	if evt.Cmp("MapVar4", 0) then
		return
	end
	evt.CastSpell{Spell = 98, Mastery = const.Novice, Skill = 1, FromX = 5784, FromY = 11584, FromZ = 512, ToX = 5784, ToY = 11584, ToZ = 0}         -- "Armageddon"
	evt.CastSpell{Spell = 98, Mastery = const.Novice, Skill = 1, FromX = 4312, FromY = 11600, FromZ = 512, ToX = 4312, ToY = 11600, ToZ = 0}         -- "Armageddon"
	evt.SetMessage(7)         -- "All Hit points restored."
	evt.SimpleMessage()
	evt.SetMessage(12)         -- "Chest"
	evt.SimpleMessage()
	if evt.Question{Question = 8, Answer1 = 9, Answer2 = 9} then         -- "Refreshing!" ("The prince has been kidnapped!  No visitors will be admitted until this crisis has been resolved!")
		goto _9
	end
	if not evt.Question{Question = 8, Answer1 = 10, Answer2 = 10} then         -- "Refreshing!" ("Crate")
		goto _9
	end
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = 4920, Y = 12976, Z = 0}
::_18::
	evt.Set("MapVar4", 0)
	do return end
::_9::
	if not evt.Cmp("Gold", 100) then
		evt.SetMessage(11)         -- "Well"
		evt.SimpleMessage()
		evt.MoveToMap{X = 4856, Y = 10288, Z = 0, Direction = 500, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		return
	end
	evt.Subtract("Gold", 100)
	goto _18
end

evt.map[220] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 0)
		evt.SetFacetBitOutdoors{Model = 1, Facet = -1, Bit = const.FacetBits.Invisible, On = false}
	else
		evt.Set("MapVar9", 1)
		evt.SetFacetBitOutdoors{Model = 1, Facet = -1, Bit = const.FacetBits.Invisible, On = true}
	end
end

evt.map[221] = function()
	if evt.Cmp("MapVar14", 1) then
		evt.Set("MapVar14", 0)
		evt.SetFacetBitOutdoors{Model = 1, Facet = -1, Bit = const.FacetBits.Untouchable, On = false}
	else
		evt.Set("MapVar14", 1)
		evt.SetFacetBitOutdoors{Model = 1, Facet = -1, Bit = const.FacetBits.Untouchable, On = true}
	end
end

evt.map[225] = function()
	if not evt.Cmp("QBits", 303) then         -- NPC
		if evt.Cmp("CurrentMight", 40) then
			evt.Set("QBits", 303)         -- NPC
			evt.GiveItem{Strength = 4, Type = const.ItemType.Sword, Id = 7}         -- "Great Sword"
			evt.SetSprite{SpriteId = 232, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(14)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 303) then         -- NPC
		evt.SetSprite{SpriteId = 232, Visible = 1, Name = "swrdstx"}
	end
end

evt.map[230] = function()
	if not evt.Cmp("MapVar19", 1) then
		evt.Add("Inventory", 208)         -- "Meteor Shower"
		evt.Set("MapVar19", 1)
	end
end

evt.hint[231] = evt.str[11]  -- "Well"
evt.map[231] = function()
	if not evt.Cmp("QBits", 305) then         -- NPC
		if evt.Cmp("QBits", 96) then         -- "Enter the Den of Iniquity in Port Sleigon, recover the Sacred Chalice and return to Lord Godwinson."
			evt.Add("Inventory", 446)         -- "Sorcerer's Eye"
			evt.Set("QBits", 305)         -- NPC
			evt.Set("QBits", 196)         -- Quest item bits for seer
		end
	end
end

evt.hint[232] = evt.str[23]  -- "Obelisk"
evt.map[232] = function()
	evt.SetMessage(22)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _fhnftete_cn_foce_"
	evt.SimpleMessage()
	evt.Set("QBits", 371)         -- NPC
	evt.Set("AutonotesBits", 90)         -- "Obelisk Message # 12: _fhnftete_cn_foce"
end

evt.hint[261] = evt.str[18]  -- "Shrine of Magic"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 11) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 215) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("MagicResistance", 5)
				evt.StatusText(21)         -- "+5 Magic resistance permanent"
			else
				evt.Set("QBits", 215)         -- NPC
				evt.ForPlayer("All")
				evt.Add("MagicResistance", 20)
				evt.StatusText(20)         -- "+20 Magic resistance permanent"
			end
			return
		end
	end
	evt.StatusText(19)         -- "You pray at the shrine."
end

evt.map[263] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 467) then         -- Approval Once
		if evt.Cmp("Awards", 5) then         -- "Destroyed Lufkta and recovered Talisman"
			if evt.Cmp("Awards", 6) then         -- "Delivered letter to Gilbert Hammer"
				if evt.Cmp("QBits", 468) then         -- Klaravoiya Approval
					if evt.Cmp("QBits", 469) then         -- Soiret Approval
						if evt.Cmp("QBits", 470) then         -- Jaffar Approval
							evt.Set("QBits", 467)         -- Approval Once
							evt.SetNPCTopic{NPC = 9, Index = 1, Event = 29}         -- "The Seer" : "I see you were successful"
						end
					end
				end
			end
		end
	end
end

events.LoadMap = evt.map[263].last

