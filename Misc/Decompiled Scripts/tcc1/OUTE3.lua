local TXT = Localize{
	[0] = " ",
	[1] = "Sutter's Bay",
	[2] = "Welcome to Suttervillel",
	[3] = "Sutterville Temple",
	[4] = "Tortuga Hall",
	[5] = "Temple of Babzot",
	[6] = "Crate",
	[7] = "Drink from Fountain",
	[8] = "Refreshing!",
	[9] = "Your purse feels much lighter as you foolishly throw your money into the well.",
	[10] = "Well",
	[11] = "There doesn't seem to be anymore apples.",
	[12] = "You pick an apple.",
	[13] = "Tree",
	[14] = "+5 Hit points restored.",
	[15] = "+5 Spell points restored.",
	[16] = "+10 Might temporary.",
	[17] = "Rock",
	[18] = "The door is locked.",
	[19] = "The Sword won't budge!",
	[20] = "+2 Luck permanent",
	[21] = "It's your Lucky Day!  +100 gold.",
	[22] = "The Underwald",
	[23] = "Shrine of Ignis Resistance",
	[24] = "You pray at the shrine.",
	[25] = "+10 Ignis Resistance permanent",
	[26] = "+3 Ignis Resistance permanent",
	[27] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           sitWnsoi__saeiltu",
	[28] = "Obelisk",
	[29] = "The entrance is magically warded.",
	[30] = "Whom the gods bless they first curse!",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[1]  -- "Sutter's Bay"
-- ERROR: evt.house[101] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[102] not assigned for hint, because Hint command is missing
Game.LoadSound(26)

evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 511) then         -- SOG Sorpigal
		evt.Set("QBits", 511)         -- SOG Sorpigal
		evt.Add("QBits", 382)         -- NPC
		evt.MoveToMap{X = 0, Y = -100, Z = -400, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD3.Odm"}
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[2]  -- "Welcome to Suttervillel"
evt.house[3] = 69  -- "Sutter's  Bay Sanctuary"
evt.map[3] = function()
	evt.EnterHouse(69)         -- "Sutter's  Bay Sanctuary"
end

evt.house[4] = 69  -- "Sutter's  Bay Sanctuary"
evt.map[4] = function()
end

evt.house[5] = 15  -- "Wiseman's Protection"
evt.map[5] = function()
	evt.EnterHouse(15)         -- "Wiseman's Protection"
end

evt.house[6] = 15  -- "Wiseman's Protection"
evt.map[6] = function()
end

evt.house[7] = 113  -- "Booty's Hold"
evt.map[7] = function()
	evt.EnterHouse(113)         -- "Booty's Hold"
end

evt.house[8] = 113  -- "Booty's Hold"
evt.map[8] = function()
end

evt.house[9] = 42  -- "Wayfarer's Trade"
evt.map[9] = function()
	evt.EnterHouse(42)         -- "Wayfarer's Trade"
end

evt.house[10] = 42  -- "Wayfarer's Trade"
evt.map[10] = function()
end

evt.house[11] = 92  -- "Ocean's Howl"
evt.map[11] = function()
	evt.EnterHouse(92)         -- "Ocean's Howl"
end

evt.house[12] = 92  -- "Ocean's Howl"
evt.map[12] = function()
end

evt.house[13] = 29  -- "Anne Bonney's Cauldron"
evt.map[13] = function()
	evt.EnterHouse(29)         -- "Anne Bonney's Cauldron"
end

evt.house[14] = 29  -- "Anne Bonney's Cauldron"
evt.map[14] = function()
end

evt.house[15] = 48  -- "Sutter's Bay Coach Company"
evt.map[15] = function()
	if not evt.Cmp("QBits", 490) then         -- Sutters Bay Tarvel Scroll Once
		evt.Set("QBits", 490)         -- Sutters Bay Tarvel Scroll Once
		evt.ForPlayer("Current")
		evt.Add("Inventory", 507)         -- "Sutters Bay Travel Schedule"
	end
	evt.EnterHouse(48)         -- "Sutter's Bay Coach Company"
end

evt.house[16] = 48  -- "Sutter's Bay Coach Company"
evt.map[16] = function()
end

evt.house[17] = 1  -- "Dagger's Tip"
evt.map[17] = function()
	evt.EnterHouse(1)         -- "Dagger's Tip"
end

evt.house[18] = 1  -- "Dagger's Tip"
evt.map[18] = function()
end

evt.house[19] = 141  -- "Dagger's Tip"
evt.map[19] = function()
	evt.EnterHouse(141)         -- "Dagger's Tip"
end

evt.house[20] = 141  -- "Dagger's Tip"
evt.map[20] = function()
end

evt.house[21] = 137  -- "Creation Magic for Neophytes"
evt.map[21] = function()
	evt.EnterHouse(137)         -- "Creation Magic for Neophytes"
end

evt.house[22] = 137  -- "Creation Magic for Neophytes"
evt.map[22] = function()
end

evt.house[23] = 79  -- "Cutthoat's Gauntlet"
evt.map[23] = function()
	evt.EnterHouse(79)         -- "Cutthoat's Gauntlet"
end

evt.house[24] = 79  -- "Cutthoat's Gauntlet"
evt.map[24] = function()
end

evt.house[25] = 139  -- "Magic of Being for Neophytes"
evt.map[25] = function()
	evt.EnterHouse(139)         -- "Magic of Being for Neophytes"
end

evt.house[26] = 139  -- "Magic of Being for Neophytes"
evt.map[26] = function()
end

evt.house[27] = 147  -- "Buccaneers' Lair"
evt.map[27] = function()
	evt.EnterHouse(147)         -- "Buccaneers' Lair"
end

evt.house[28] = 89  -- "Town Hall"
evt.map[28] = function()
	evt.EnterHouse(89)         -- "Town Hall"
end

evt.house[29] = 57  -- "Cursed Barnacle"
evt.map[29] = function()
	evt.EnterHouse(57)         -- "Cursed Barnacle"
end

evt.house[50] = 465  -- "House"
evt.map[50] = function()
	evt.EnterHouse(465)         -- "House"
end

evt.house[51] = 466  -- "House"
evt.map[51] = function()
	evt.EnterHouse(466)         -- "House"
end

evt.house[52] = 467  -- "House"
evt.map[52] = function()
	evt.EnterHouse(467)         -- "House"
end

evt.house[53] = 468  -- "House"
evt.map[53] = function()
	evt.EnterHouse(468)         -- "House"
end

evt.house[54] = 469  -- "House"
evt.map[54] = function()
	evt.EnterHouse(469)         -- "House"
end

evt.house[55] = 477  -- "House"
evt.map[55] = function()
	evt.EnterHouse(477)         -- "House"
end

evt.house[56] = 478  -- "House"
evt.map[56] = function()
	evt.EnterHouse(478)         -- "House"
end

evt.house[57] = 480  -- "House"
evt.map[57] = function()
	evt.EnterHouse(480)         -- "House"
end

evt.house[58] = 481  -- "House"
evt.map[58] = function()
	evt.EnterHouse(481)         -- "House"
end

evt.house[59] = 482  -- "House"
evt.map[59] = function()
	evt.EnterHouse(482)         -- "House"
end

evt.house[60] = 483  -- "House"
evt.map[60] = function()
	evt.EnterHouse(483)         -- "House"
end

evt.house[61] = 484  -- "House"
evt.map[61] = function()
	evt.EnterHouse(484)         -- "House"
end

evt.house[62] = 485  -- "House"
evt.map[62] = function()
	evt.EnterHouse(485)         -- "House"
end

evt.house[63] = 486  -- "House"
evt.map[63] = function()
	evt.EnterHouse(486)         -- "House"
end

evt.house[64] = 487  -- "House"
evt.map[64] = function()
	evt.EnterHouse(487)         -- "House"
end

evt.house[65] = 470  -- "House"
evt.map[65] = function()
	evt.EnterHouse(470)         -- "House"
end

evt.house[66] = 471  -- "House"
evt.map[66] = function()
	evt.EnterHouse(471)         -- "House"
end

evt.house[67] = 472  -- "House"
evt.map[67] = function()
	evt.EnterHouse(472)         -- "House"
end

evt.house[68] = 473  -- "House"
evt.map[68] = function()
	evt.EnterHouse(473)         -- "House"
end

evt.house[69] = 474  -- "House"
evt.map[69] = function()
	evt.EnterHouse(474)         -- "House"
end

evt.house[70] = 475  -- "House"
evt.map[70] = function()
	evt.EnterHouse(475)         -- "House"
end

evt.house[71] = 476  -- "House"
evt.map[71] = function()
	evt.EnterHouse(476)         -- "House"
end

evt.hint[75] = evt.str[6]  -- "Crate"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[6]  -- "Crate"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[6]  -- "Crate"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.hint[78] = evt.str[6]  -- "Crate"
evt.map[78] = function()
	evt.OpenChest(4)
end

evt.hint[79] = evt.str[6]  -- "Crate"
evt.map[79] = function()
	evt.OpenChest(5)
end

evt.hint[80] = evt.str[6]  -- "Crate"
evt.map[80] = function()
	evt.OpenChest(6)
end

evt.hint[81] = evt.str[6]  -- "Crate"
evt.map[81] = function()
	evt.OpenChest(7)
end

evt.hint[82] = evt.str[6]  -- "Crate"
evt.map[82] = function()
	evt.OpenChest(8)
end

evt.hint[83] = evt.str[6]  -- "Crate"
evt.map[83] = function()
	evt.OpenChest(9)
end

evt.hint[84] = evt.str[6]  -- "Crate"
evt.map[84] = function()
	evt.OpenChest(10)
end

evt.hint[85] = evt.str[6]  -- "Crate"
evt.map[85] = function()
	evt.OpenChest(11)
end

evt.hint[86] = evt.str[6]  -- "Crate"
evt.map[86] = function()
	evt.OpenChest(12)
end

evt.hint[87] = evt.str[6]  -- "Crate"
evt.map[87] = function()
	evt.OpenChest(13)
end

evt.hint[88] = evt.str[6]  -- "Crate"
evt.map[88] = function()
	evt.OpenChest(14)
end

evt.hint[89] = evt.str[6]  -- "Crate"
evt.map[89] = function()
	evt.OpenChest(15)
end

evt.hint[90] = evt.str[6]  -- "Crate"
evt.map[90] = function()
	evt.OpenChest(16)
end

evt.hint[91] = evt.str[17]  -- "Rock"
evt.map[91] = function()
	evt.OpenChest(17)
end

evt.hint[92] = evt.str[6]  -- "Crate"
evt.map[92] = function()
	evt.OpenChest(18)
end

evt.map[101] = function()
	if not evt.Cmp("QBits", 300) then         -- Peter
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 489) then         -- "Key to Tortuga Hall"
			evt.StatusText(18)         -- "The door is locked."
			return
		end
		evt.Subtract("Inventory", 489)         -- "Key to Tortuga Hall"
		evt.Set("QBits", 300)         -- Peter
	end
	evt.MoveToMap{X = -130, Y = -1408, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 173, Icon = 2, Name = "D03.Blv"}         -- "Tortuga Hall"
end

evt.map[102] = function()
	evt.MoveToMap{X = -3258, Y = 483, Z = 49, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 172, Icon = 5, Name = "T4.Blv"}         -- "Abandoned Temple"
end

evt.house[103] = 208  -- "Underwald"
evt.map[103] = function()
	if evt.Cmp("Inventory", 456) then         -- "Amulet of Entrance"
		evt.MoveToMap{X = 16406, Y = -19669, Z = 865, Direction = 500, LookAngle = 0, SpeedZ = 0, HouseId = 208, Icon = 5, Name = "D02.blv"}         -- "Underwald"
	else
		evt.StatusText(29)         -- "The entrance is magically warded."
	end
end

evt.map[104] = function()
	evt.MoveToMap{X = 12808, Y = 6832, Z = 64, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB3.Odm"}
end

evt.hint[109] = evt.str[10]  -- "Well"
evt.map[109] = function()
	if not evt.Cmp("MapVar69", 1) then
		if not evt.Cmp("Gold", 1) then
			evt.Add("MapVar69", 1)
			evt.Add("Gold", 100)
			return
		end
	end
	evt.StatusText(8)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar69", 0)
end, const.Week, true)

evt.hint[110] = evt.str[10]  -- "Well"
evt.map[110] = function()
	if not evt.Cmp("BaseLuck", 15) then
		if evt.Cmp("MapVar70", 1) then
			evt.Subtract("MapVar70", 1)
			evt.Add("BaseLuck", 2)
			evt.StatusText(20)         -- "+2 Luck permanent"
			return
		end
	end
	evt.StatusText(8)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar70", 8)
end, const.Month, true)

evt.hint[111] = evt.str[13]  -- "Tree"
evt.map[111] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.StatusText(13)         -- "Tree"
	else
		evt.Set("MapVar9", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
		evt.SetSprite{SpriteId = 298, Visible = 1, Name = "Tree06"}
	end
end

function events.LoadMap()
	if evt.Cmp("MapVar9", 1) then
		evt.SetSprite{SpriteId = 298, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[112] = evt.str[13]  -- "Tree"
evt.map[112] = function()
	if evt.Cmp("MapVar10", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar10", 1) then
			return
		end
	else
		evt.Set("MapVar10", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 299, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar10", 1) then
		evt.SetSprite{SpriteId = 299, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[113] = evt.str[13]  -- "Tree"
evt.map[113] = function()
	if evt.Cmp("MapVar11", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar11", 1) then
			return
		end
	else
		evt.Set("MapVar11", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 300, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar11", 1) then
		evt.SetSprite{SpriteId = 300, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[114] = evt.str[13]  -- "Tree"
evt.map[114] = function()
	if evt.Cmp("MapVar12", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar12", 1) then
			return
		end
	else
		evt.Set("MapVar12", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 301, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar12", 1) then
		evt.SetSprite{SpriteId = 301, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[115] = evt.str[13]  -- "Tree"
evt.map[115] = function()
	if evt.Cmp("MapVar13", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar13", 1) then
			return
		end
	else
		evt.Set("MapVar13", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 467, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar13", 1) then
		evt.SetSprite{SpriteId = 467, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[116] = evt.str[13]  -- "Tree"
evt.map[116] = function()
	if evt.Cmp("MapVar14", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar14", 1) then
			return
		end
	else
		evt.Set("MapVar14", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 303, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar14", 1) then
		evt.SetSprite{SpriteId = 303, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[117] = evt.str[13]  -- "Tree"
evt.map[117] = function()
	if evt.Cmp("MapVar15", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar15", 1) then
			return
		end
	else
		evt.Set("MapVar15", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 302, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar15", 1) then
		evt.SetSprite{SpriteId = 302, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[118] = evt.str[13]  -- "Tree"
evt.map[118] = function()
	if evt.Cmp("MapVar16", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar16", 1) then
			return
		end
	else
		evt.Set("MapVar16", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 305, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar16", 1) then
		evt.SetSprite{SpriteId = 305, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[119] = evt.str[13]  -- "Tree"
evt.map[119] = function()
	if evt.Cmp("MapVar17", 1) then
		evt.StatusText(13)         -- "Tree"
		if not evt.Cmp("MapVar17", 1) then
			return
		end
	else
		evt.Set("MapVar17", 1)
		evt.Add("Food", 1)
		evt.StatusText(12)         -- "You pick an apple."
	end
	evt.SetSprite{SpriteId = 304, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar17", 1) then
		evt.SetSprite{SpriteId = 304, Visible = 1, Name = "Tree06"}
	end
end

evt.map[130] = function()  -- Timer(<function>, const.Day, 1*const.Second)
	evt.Set("MapVar49", 30)
	evt.Set("MapVar50", 30)
end

Timer(evt.map[130].last, const.Day, 1*const.Second)

evt.hint[131] = evt.str[7]  -- "Drink from Fountain"
evt.map[131] = function()
	if evt.Cmp("MapVar49", 1) then
		evt.Subtract("MapVar49", 1)
		evt.Add("HP", 5)
		evt.StatusText(14)         -- "+5 Hit points restored."
	else
		evt.StatusText(8)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 1)         -- "5 Hit points cured by the central fountain in Sutter's Bay."
end

evt.hint[140] = evt.str[7]  -- "Drink from Fountain"
evt.map[140] = function()
	if evt.Cmp("MapVar50", 1) then
		evt.Subtract("MapVar50", 1)
		evt.Add("SP", 5)
		evt.StatusText(15)         -- "+5 Spell points restored."
	else
		evt.StatusText(8)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 2)         -- "5 Spell points restored by the northwest fountain in Sutter's Bay."
end

evt.hint[150] = evt.str[7]  -- "Drink from Fountain"
evt.map[150] = function()
	if evt.Cmp("MightBonus", 10) then
		evt.StatusText(8)         -- "Refreshing!"
		evt.Add("AutonotesBits", 3)         -- "10 Points of temporary might from the northeast fountain in Sutter's Bay.  "
	else
		evt.Set("MightBonus", 10)
		evt.StatusText(16)         -- "+10 Might temporary."
		evt.Add("AutonotesBits", 3)         -- "10 Points of temporary might from the northeast fountain in Sutter's Bay.  "
	end
end

evt.hint[210] = evt.str[10]  -- "Well"
evt.map[210] = function()
	if evt.Cmp("Gold", 10000) then
		evt.Subtract("Gold", 1000)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	else
		if evt.Cmp("Gold", 5000) then
			evt.Subtract("Gold", 500)
			evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
			evt.SimpleMessage()
		else
			if evt.Cmp("Gold", 1000) then
				evt.Subtract("Gold", 100)
				evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
				evt.SimpleMessage()
			else
				if evt.Cmp("Gold", 500) then
					evt.Subtract("Gold", 50)
					evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
					evt.SimpleMessage()
				else
					if evt.Cmp("Gold", 100) then
						evt.Subtract("Gold", 10)
						evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
						evt.SimpleMessage()
					else
						if evt.Cmp("Gold", 50) then
							evt.Subtract("Gold", 5)
							evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
							evt.SimpleMessage()
						else
							evt.Cmp("Gold", 40)
						end
					end
				end
			end
		end
	end
end

evt.map[220] = function()
	evt.PlaySound{Id = 26, X = -14600, Y = 13500}
	evt.SummonObject{Type = 1050, X = -14320, Y = 16272, Z = 100, Speed = 1000, Count = 15, RandomAngle = true}         -- fireball
	evt.SummonObject{Type = 1050, X = -14096, Y = 15648, Z = 100, Speed = 600, Count = 15, RandomAngle = true}         -- fireball
	evt.SummonObject{Type = 1050, X = -13856, Y = 16448, Z = 100, Speed = 2000, Count = 15, RandomAngle = true}         -- fireball
	evt.SummonObject{Type = 4070, X = -14336, Y = 16228, Z = 100, Speed = 2000, Count = 15, RandomAngle = true}         -- rock blast
	evt.SummonObject{Type = 4070, X = -14272, Y = 16112, Z = 96, Speed = 800, Count = 15, RandomAngle = true}         -- rock blast
	evt.SummonObject{Type = 4070, X = -14496, Y = 15536, Z = 100, Speed = 1500, Count = 15, RandomAngle = true}         -- rock blast
end

evt.map[221] = function()
	if not evt.Cmp("MapVar51", 1) then
		evt.Set("MapVar51", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -16130, Y = -4711, Z = 258}
	end
end

evt.map[222] = function()
	if not evt.Cmp("MapVar52", 1) then
		evt.Set("MapVar52", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 6864, Y = 17056, Z = 452}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 7808, Y = 17984, Z = 333}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 11760, Y = 18784, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 8488, Y = 16768, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 13024, Y = 15360, Z = 257}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 11376, Y = 17472, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 14128, Y = 12464, Z = 97}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 4976, Y = 16528, Z = 97}
	end
end

evt.map[225] = function()
	if not evt.Cmp("MapVar59", 1) then
		evt.Add("Inventory", 547)         -- "Oops!!"
		evt.Set("MapVar59", 1)
	end
end

evt.map[226] = function()
	if not evt.Cmp("QBits", 302) then         -- NPC
		if evt.Cmp("CurrentMight", 25) then
			evt.Set("QBits", 302)         -- NPC
			evt.Add("Inventory", 6)         -- "Two-Handed Sword"
			evt.SetSprite{SpriteId = 339, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(19)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 302) then         -- NPC
		evt.SetSprite{SpriteId = 339, Visible = 1, Name = "swrdstx"}
	end
end

evt.map[230] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 156) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = -6152, FromY = -9208, FromZ = 2700, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[230].last, 5*const.Minute)

evt.map[231] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 156) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 156)         -- NPC
			evt.SetTextureOutdoors{Model = 84, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.map[232] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 156) then         -- NPC
		evt.SetTextureOutdoors{Model = 84, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[232].last

evt.hint[240] = evt.str[28]  -- "Obelisk"
evt.map[240] = function()
	evt.SetMessage(27)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           sitWnsoi__saeiltu"
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 93)         -- "Obelisk Message # 15: sitWnsoi__saeiltu"
	evt.Set("QBits", 374)         -- NPC
end

evt.hint[261] = evt.str[23]  -- "Shrine of Ignis Resistance"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 7) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 213) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("FireResistance", 3)
				evt.StatusText(26)         -- "+3 Ignis Resistance permanent"
			else
				evt.Set("QBits", 213)         -- NPC
				evt.ForPlayer("All")
				evt.Add("FireResistance", 10)
				evt.StatusText(25)         -- "+10 Ignis Resistance permanent"
			end
			return
		end
	end
	evt.StatusText(24)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 497) then         -- Sutter's Bay Reload
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -8442, Y = -10496, Z = 161}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -9670, Y = -12905, Z = 346}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -11011, Y = -15233, Z = 1071}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -14595, Y = -14177, Z = 1000}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -18458, Y = -14646, Z = 1600}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -15439, Y = -4060, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17338, Y = -4929, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -17957, Y = 4743, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -2050, Y = 3288, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = 10777, Y = -13092, Z = 133}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -22329, Y = -10583, Z = 40}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -8440, Y = -9496, Z = 161}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 6, X = -17950, Y = 4700, Z = 1}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -17738, Y = -4500, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -2040, Y = 3200, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -22300, Y = -10580, Z = 40}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -9570, Y = -12700, Z = 346}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -18450, Y = -14550, Z = 1600}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -9295, Y = -9626, Z = 161}
				evt.Set("QBits", 497)         -- Sutter's Bay Reload
			else
				evt.Set("QBits", 497)         -- Sutter's Bay Reload
			end
		end
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

evt.map[300] = function()  -- function events.LoadMap()
	if evt.Cmp("MonthIs", 11) then
		if not evt.Cmp("QBits", 492) then         -- Reload Each December
			evt.Subtract("QBits", 491)         -- Clear Reload Each January
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Subtract(-- ERROR: Not found
"QBits", 0)
			evt.Set("QBits", 492)         -- Reload Each December
		end
	end
end

events.LoadMap = evt.map[300].last

evt.map[301] = function()  -- function events.LoadMap()
	if evt.Cmp("MonthIs", 0) then
		if not evt.Cmp("QBits", 491) then         -- Clear Reload Each January
			evt.Subtract("QBits", 492)         -- Reload Each December
			evt.Set("QBits", 491)         -- Clear Reload Each January
		end
	end
end

events.LoadMap = evt.map[301].last

evt.map[302] = function()  -- function events.LoadMap()
	evt.Subtract("NPCs", 193)         -- "FREE"
end

events.LoadMap = evt.map[302].last

evt.map[304] = function()  -- function events.LoadMap()
	evt.Subtract("NPCs", 155)         -- "Thomalina Thumb"
end

events.LoadMap = evt.map[304].last

evt.map[305] = function()  -- function events.LoadMap()
	evt.Add("QBits", 156)         -- NPC
	evt.Add("QBits", 157)         -- NPC
	evt.Add("QBits", 158)         -- NPC
	evt.Add("QBits", 159)         -- NPC
	evt.Add("QBits", 160)         -- NPC
	evt.Add("QBits", 161)         -- NPC
	evt.Add("QBits", 178)         -- NPC
	evt.Add("QBits", 179)         -- NPC
end

events.LoadMap = evt.map[305].last

