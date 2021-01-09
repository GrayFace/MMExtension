local TXT = Localize{
	[0] = " ",
	[1] = "New Sorpigal",
	[2] = "Welcome to New Sorpigal",
	[3] = "New Sorpigal Temple",
	[4] = "GoblinWatch",
	[5] = "Abbey of the Sun",
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
	[22] = "Gharik's Forge",
	[23] = "Shrine of Luck",
	[24] = "You pray at the shrine.",
	[25] = "+10 Luck permanent",
	[26] = "+3 Luck permanent",
	[27] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _nrh__tf__cehr__",
	[28] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[1]  -- "New Sorpigal"
Game.LoadSound(26)

evt.hint[2] = evt.str[2]  -- "Welcome to New Sorpigal"
evt.HouseDoor(3, 69)  -- "New Sorpigal Temple"
evt.house[4] = 69  -- "New Sorpigal Temple"
evt.HouseDoor(5, 15)  -- "The Common Defense"
evt.house[6] = 15  -- "The Common Defense"
evt.HouseDoor(7, 113)  -- "Savings House"
evt.house[8] = 113  -- "Savings House"
evt.HouseDoor(9, 42)  -- "Traveler's Supply"
evt.house[10] = 42  -- "Traveler's Supply"
evt.HouseDoor(11, 92)  -- "A Lonely Knight"
evt.house[12] = 92  -- "A Lonely Knight"
evt.HouseDoor(13, 29)  -- "The Seeing Eye"
evt.house[14] = 29  -- "The Seeing Eye"
evt.HouseDoor(15, 48)  -- "New Sorpigal Coach Company"
evt.house[16] = 48  -- "New Sorpigal Coach Company"
evt.HouseDoor(17, 1)  -- "The Knife Shoppe"
evt.house[18] = 1  -- "The Knife Shoppe"
evt.HouseDoor(19, 141)  -- "Blades' End"
evt.house[20] = 141  -- "Blades' End"
evt.HouseDoor(21, 137)  -- "Initiate Guild of the Elements"
evt.house[22] = 137  -- "Initiate Guild of the Elements"
evt.HouseDoor(23, 79)  -- "New Sorpigal Training Grounds"
evt.house[24] = 79  -- "New Sorpigal Training Grounds"
evt.HouseDoor(25, 139)  -- "Initiate Guild of the Self"
evt.house[26] = 139  -- "Initiate Guild of the Self"
evt.HouseDoor(27, 147)  -- "Buccaneers' Lair"
evt.HouseDoor(28, 89)  -- "Town Hall"
evt.HouseDoor(29, 57)  -- "Odyssey"
evt.HouseDoor(50, 465)  -- "House"
evt.HouseDoor(51, 466)  -- "House"
evt.HouseDoor(52, 467)  -- "House"
evt.HouseDoor(53, 468)  -- "House"
evt.HouseDoor(54, 469)  -- "House"
evt.HouseDoor(55, 477)  -- "House"
evt.HouseDoor(56, 478)  -- "House"
evt.HouseDoor(57, 480)  -- "House"
evt.HouseDoor(58, 481)  -- "House"
evt.HouseDoor(59, 482)  -- "House"
evt.HouseDoor(60, 483)  -- "House"
evt.HouseDoor(61, 484)  -- "House"
evt.HouseDoor(62, 485)  -- "House"
evt.HouseDoor(63, 486)  -- "House"
evt.HouseDoor(64, 487)  -- "House"
evt.HouseDoor(65, 470)  -- "House"
evt.HouseDoor(66, 471)  -- "House"
evt.HouseDoor(67, 472)  -- "House"
evt.HouseDoor(68, 473)  -- "House"
evt.HouseDoor(69, 474)  -- "House"
evt.HouseDoor(70, 475)  -- "House"
evt.HouseDoor(71, 476)  -- "House"
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

evt.house[101] = 171  -- "Goblinwatch"
evt.map[101] = function()
	if not evt.Cmp("QBits", 300) then         -- Peter
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 489) then         -- "Key to Goblinwatch"
			evt.StatusText(18)         -- "The door is locked."
			return
		end
		evt.Subtract("Inventory", 489)         -- "Key to Goblinwatch"
		evt.Set("QBits", 300)         -- Peter
	end
	evt.MoveToMap{X = 601, Y = 6871, Z = 177, Direction = 1400, LookAngle = 0, SpeedZ = 0, HouseId = 171, Icon = 5, Name = "D01.blv"}         -- "Goblinwatch"
end

evt.house[102] = 172  -- "Abandoned Temple"
evt.map[102] = function()
	evt.MoveToMap{X = 16406, Y = -19669, Z = 865, Direction = 500, LookAngle = 0, SpeedZ = 0, HouseId = 172, Icon = 1, Name = "D02.blv"}         -- "Abandoned Temple"
end

evt.house[103] = 188  -- "Gharik's Forge"
evt.map[103] = function()
	evt.MoveToMap{X = -2688, Y = 1216, Z = 1153, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 188, Icon = 5, Name = "D18.Blv"}         -- "Gharik's Forge"
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
end, const.Week)

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
end, const.Month)

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

evt.map[130] = function()  -- RefillTimer(<function>, const.Day)
	evt.Set("MapVar49", 30)
	evt.Set("MapVar50", 30)
end

RefillTimer(evt.map[130].last, const.Day)

evt.hint[131] = evt.str[7]  -- "Drink from Fountain"
evt.map[131] = function()
	if evt.Cmp("MapVar49", 1) then
		evt.Subtract("MapVar49", 1)
		evt.Add("HP", 5)
		evt.StatusText(14)         -- "+5 Hit points restored."
	else
		evt.StatusText(8)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 1)         -- "5 Hit points cured by the central fountain in New Sorpigal."
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
	evt.Set("AutonotesBits", 2)         -- "5 Spell points restored by the northwest fountain in New Sorpigal."
end

evt.hint[150] = evt.str[7]  -- "Drink from Fountain"
evt.map[150] = function()
	if evt.Cmp("MightBonus", 10) then
		evt.StatusText(8)         -- "Refreshing!"
		evt.Add("AutonotesBits", 3)         -- "10 Points of temporary might from the northeast fountain in New Sorpigal.  "
	else
		evt.Set("MightBonus", 10)
		evt.StatusText(16)         -- "+10 Might temporary."
		evt.Add("AutonotesBits", 3)         -- "10 Points of temporary might from the northeast fountain in New Sorpigal.  "
	end
end

evt.hint[210] = evt.str[10]  -- "Well"
evt.map[210] = function()
	if evt.Cmp("Gold", 10000) then
		evt.Subtract("Gold", 1000)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	elseif evt.Cmp("Gold", 5000) then
		evt.Subtract("Gold", 500)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	elseif evt.Cmp("Gold", 1000) then
		evt.Subtract("Gold", 100)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	elseif evt.Cmp("Gold", 500) then
		evt.Subtract("Gold", 50)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	elseif evt.Cmp("Gold", 100) then
		evt.Subtract("Gold", 10)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	elseif evt.Cmp("Gold", 50) then
		evt.Subtract("Gold", 5)
		evt.SetMessage(9)         -- "Your purse feels much lighter as you foolishly throw your money into the well."
		evt.SimpleMessage()
	else
		evt.Cmp("Gold", 40)
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
		evt.Add("Inventory", 220)         -- "Fly"
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
	evt.SetMessage(27)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _nrh__tf__cehr__"
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 93)         -- "Obelisk Message # 15: _nrh__tf__cehr__"
	evt.Set("QBits", 374)         -- NPC
end

evt.hint[261] = evt.str[23]  -- "Shrine of Luck"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 6) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 213) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseLuck", 3)
				evt.StatusText(26)         -- "+3 Luck permanent"
			else
				evt.Set("QBits", 213)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseLuck", 10)
				evt.StatusText(25)         -- "+10 Luck permanent"
			end
			return
		end
	end
	evt.StatusText(24)         -- "You pray at the shrine."
end

