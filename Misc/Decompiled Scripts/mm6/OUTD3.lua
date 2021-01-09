local TXT = Localize{
	[0] = " ",
	[1] = "Castle Ironfist",
	[2] = "Enter at Own Risk.",
	[3] = "Keep Off!",
	[4] = "Ironfist Castle",
	[5] = "New Sorpigal",
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
	[18] = "Shrine of Electricity",
	[19] = "You pray at the shrine.",
	[20] = "+10 Electricity resistance permanent",
	[21] = "+3 Electricity resistance permanent",
	[22] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _t_staoi_on_oiz_",
	[23] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[1]  -- "Castle Ironfist"
-- ERROR: Duplicate label: 71:0

evt.HouseDoor(2, 3)  -- "Fine Blades"
evt.house[3] = 3  -- "Fine Blades"
evt.HouseDoor(4, 17)  -- "Metalweave Armory"
evt.house[5] = 17  -- "Metalweave Armory"
evt.HouseDoor(6, 33)  -- "Eye of Newt"
evt.house[7] = 33  -- "Eye of Newt"
evt.HouseDoor(8, 49)  -- "Royal Lines "
evt.house[9] = 49  -- "Royal Lines "
evt.HouseDoor(10, 85)  -- "Royal Gymnasium"
evt.house[11] = 85  -- "Royal Gymnasium"
evt.HouseDoor(12, 96)  -- "The King's Crown"
evt.house[13] = 96  -- "The King's Crown"
evt.HouseDoor(14, 119)  -- "Initiate Guild of Fire"
evt.house[15] = 119  -- "Initiate Guild of Fire"
evt.HouseDoor(16, 155)  -- "Castle Newton"
evt.house[17] = 155  -- "Castle Newton"
evt.HouseDoor(18, 169)  -- "The Seer"
evt.HouseDoor(19, 76)  -- "King's Temple"
evt.hint[40] = evt.str[5]  -- "New Sorpigal"
evt.map[40] = function()
	evt.StatusText(5)         -- "New Sorpigal"
end

evt.hint[41] = evt.str[4]  -- "Ironfist Castle"
evt.map[41] = function()
	evt.StatusText(4)         -- "Ironfist Castle"
end

evt.house[42] = 168  -- "King's Library"
evt.map[42] = function()
	if evt.Cmp("QBits", 177) then         -- NPC
		evt.EnterHouse(554)         -- "King's Library"
	else
		evt.EnterHouse(168)         -- "King's Library"
	end
end

evt.house[43] = 154  -- "Throne Room"
evt.map[43] = function()
	if evt.Cmp("QBits", 90) then         -- "Entertain Nicolai."
		if evt.Cmp("NPCs", 13) then         -- "Nicolai Ironfist"
			goto _13
		end
		goto _17
	end
	if evt.Cmp("QBits", 95) then         -- "Find and return Prince Nicolai to Castle Ironfist."
		if not evt.Cmp("NPCs", 13) then         -- "Nicolai Ironfist"
			goto _17
		end
		evt.MoveNPC{NPC = 13, HouseId = 154}         -- "Nicolai Ironfist" -> "Throne Room"
		evt.Subtract("NPCs", 13)         -- "Nicolai Ironfist"
		evt.Subtract("QBits", 95)         -- "Find and return Prince Nicolai to Castle Ironfist."
		evt.SetMessage(13)         -- "Well, thanks for sneaking me out of the Castle.  Sorry about the circus thing—I hope I wasn’t too much trouble to find.  I’ll go in myself so no one will see that it was you who kidnapped me.  Thanks again, and goodbye.  I’ll remember this, and I owe you a favor! "
		evt.ForPlayer("All")
		evt.Add("Experience", 7500)
		evt.SetNPCTopic{NPC = 13, Index = 0, Event = 24}         -- "Nicolai Ironfist" : "The Circus"
		evt.SimpleMessage()
	end
::_13::
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 153, Icon = 2, Name = "0"}         -- "Castle Ironfist"
	evt.EnterHouse(154)         -- "Throne Room"
	do return end
::_17::
	evt.SetMessage(9)         -- "The prince has been kidnapped!  No visitors will be admitted until this crisis has been resolved!"
	evt.SimpleMessage()
end

evt.HouseDoor(44, 58)  -- "Zephyr"
evt.HouseDoor(45, 59)  -- "Queen Catherine"
evt.HouseDoor(46, 4)  -- "The Eagle's Eye"
evt.house[47] = 4  -- "The Eagle's Eye"
evt.HouseDoor(48, 21)  -- "Iron Defense"
evt.house[49] = 21  -- "Iron Defense"
evt.HouseDoor(50, 97)  -- "The Will o' Wisp"
evt.house[51] = 97  -- "The Will o' Wisp"
evt.HouseDoor(52, 127)  -- "Initiate Guild of Spirit"
evt.house[53] = 127  -- "Initiate Guild of Spirit"
evt.HouseDoor(54, 129)  -- "Initiate Guild of Mind"
evt.house[55] = 129  -- "Initiate Guild of Mind"
evt.HouseDoor(56, 131)  -- "Initiate Guild of Body"
evt.house[57] = 131  -- "Initiate Guild of Body"
evt.HouseDoor(82, 146)  -- "Berserkers' Fury"
evt.HouseDoor(58, 424)  -- "House"
evt.HouseDoor(59, 425)  -- "House"
evt.HouseDoor(60, 426)  -- "House"
evt.HouseDoor(61, 428)  -- "House"
evt.HouseDoor(62, 429)  -- "House"
evt.HouseDoor(63, 430)  -- "House"
evt.HouseDoor(64, 431)  -- "House"
evt.HouseDoor(65, 434)  -- "House"
evt.HouseDoor(66, 435)  -- "House"
evt.HouseDoor(67, 436)  -- "House"
evt.HouseDoor(68, 437)  -- "House"
evt.HouseDoor(69, 439)  -- "House"
evt.HouseDoor(70, 440)  -- "House"
evt.HouseDoor(71, 427)  -- "House"
evt.HouseDoor(72, 433)  -- "House"
evt.HouseDoor(73, 438)  -- "House"
evt.HouseDoor(74, 441)  -- "House"
evt.HouseDoor(75, 442)  -- "House"
evt.HouseDoor(83, 257)  -- "House"
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

evt.house[90] = 173  -- "Shadow Guild Hideout"
evt.map[90] = function()
	evt.MoveToMap{X = -130, Y = -1408, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 173, Icon = 5, Name = "D03.Blv"}         -- "Shadow Guild Hideout"
end

evt.house[91] = 175  -- "Snergle's Caverns"
evt.map[91] = function()
	evt.MoveToMap{X = 1664, Y = -1896, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 175, Icon = 5, Name = "D05.Blv"}         -- "Snergle's Caverns"
end

evt.house[92] = 176  -- "Dragoons' Caverns"
evt.map[92] = function()
	evt.MoveToMap{X = 2716, Y = -256, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 176, Icon = 5, Name = "D06.Blv"}         -- "Dragoons' Caverns"
end

evt.house[93] = 181  -- "Corlagon's Estate"
evt.map[93] = function()
	evt.MoveToMap{X = 128, Y = -151, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 181, Icon = 5, Name = "D11.Blv"}         -- "Corlagon's Estate"
end

evt.house[94] = 191  -- "Temple of Baa"
evt.map[94] = function()
	evt.MoveToMap{X = -15592, Y = 120, Z = -191, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 5, Name = "T1.Blv"}         -- "Temple of Baa"
end

evt.HouseDoor(97, 78)  -- "Temple Baa"
evt.hint[100] = evt.str[15]  -- "Drink from Fountain"
evt.map[100] = function()
	if evt.Cmp("SpeedBonus", 10) then
		evt.StatusText(8)         -- "Refreshing!"
	else
		evt.Set("SpeedBonus", 10)
		evt.StatusText(6)         -- "+10 Speed temporary."
		evt.Set("AutonotesBits", 20)         -- "10 Points of temporary speed from the east fountain at Castle Ironfist."
	end
end

evt.hint[101] = evt.str[15]  -- "Drink from Fountain"
evt.map[101] = function()
	if not evt.Cmp("AccuracyBonus", 10) then
		evt.Set("AccuracyBonus", 10)
		evt.StatusText(16)         -- "+10 Accuracy temporary."
		evt.Set("AutonotesBits", 19)         -- "10 Points of temporary accuracy from the west fountain at Castle Ironfist."
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

RefillTimer(function()
	evt.Set("MapVar24", 30)
end, const.Day)

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
		if evt.Cmp("QBits", 96) then         -- "Find the Third Eye and bring it to Prince Nicolai in Castle Ironfist."
			evt.Add("Inventory", 446)         -- "The Third Eye"
			evt.Set("QBits", 305)         -- NPC
			evt.Set("QBits", 196)         -- Quest item bits for seer
		end
	end
end

evt.hint[232] = evt.str[23]  -- "Obelisk"
evt.map[232] = function()
	evt.SetMessage(22)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _t_staoi_on_oiz_"
	evt.SimpleMessage()
	evt.Set("QBits", 371)         -- NPC
	evt.Set("AutonotesBits", 90)         -- "Obelisk Message # 12: _t_staoi_on_oiz_"
end

evt.hint[261] = evt.str[18]  -- "Shrine of Electricity"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 8) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 215) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("ElecResistance", 3)
				evt.StatusText(21)         -- "+3 Electricity resistance permanent"
			else
				evt.Set("QBits", 215)         -- NPC
				evt.ForPlayer("All")
				evt.Add("ElecResistance", 10)
				evt.StatusText(20)         -- "+10 Electricity resistance permanent"
			end
			return
		end
	end
	evt.StatusText(19)         -- "You pray at the shrine."
end

