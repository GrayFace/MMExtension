local TXT = Localize{
	[0] = " ",
	[1] = "Tree",
	[2] = "There doesn't seem to be anymore apples.",
	[3] = "Chest",
	[4] = "Drink from Well.",
	[5] = "Drink from Fountain.",
	[6] = "Drink from Trough.",
	[7] = "Refreshing!",
	[8] = "+10 Spell points restored.",
	[9] = "+10 Intellect and Personality temporary.",
	[10] = "+5 Elemental resistance temporary.",
	[11] = "+20 Luck temporary.",
	[12] = "Poison!",
	[13] = "Welcome to Misty Islands",
	[14] = "Misty Islands",
	[15] = "Shrine of Intellect",
	[16] = "You pray at the shrine.",
	[17] = "+10 Intellect permanent",
	[18] = "+3 Intellect permanent",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            f_oteh__fe_h__e_",
	[20] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[14]  -- "Misty Islands"

evt.hint[1] = evt.str[1]  -- "Tree"
evt.HouseDoor(2, 5)  -- "Arm's Length Spear Shop"
evt.house[3] = 5  -- "Arm's Length Spear Shop"
evt.HouseDoor(4, 16)  -- "Armor Emporium"
evt.house[5] = 16  -- "Armor Emporium"
evt.HouseDoor(6, 30)  -- "Witch's Brew"
evt.hint[7] = evt.str[30]
evt.HouseDoor(8, 43)  -- "Lock, Stock, and Barrel"
evt.house[9] = 43  -- "Lock, Stock, and Barrel"
evt.HouseDoor(10, 60)  -- "Adventure"
evt.HouseDoor(11, 86)  -- "Island Testing Center"
evt.house[12] = 86  -- "Island Testing Center"
evt.HouseDoor(13, 90)  -- "Town Hall"
evt.HouseDoor(14, 74)  -- "Mist Island Temple"
evt.HouseDoor(15, 93)  -- "The Imp Slapper"
evt.house[16] = 93  -- "The Imp Slapper"
evt.HouseDoor(17, 114)  -- "The Reserves"
evt.house[18] = 114  -- "The Reserves"
evt.HouseDoor(19, 119)  -- "Initiate Guild of Fire"
evt.house[20] = 119  -- "Initiate Guild of Fire"
evt.HouseDoor(21, 121)  -- "Initiate Guild of Air"
evt.house[22] = 121  -- "Initiate Guild of Air"
evt.HouseDoor(23, 123)  -- "Initiate Guild of Water"
evt.house[24] = 123  -- "Initiate Guild of Water"
evt.HouseDoor(25, 142)  -- "Duelists' Edge"
evt.house[26] = 142  -- "Duelists' Edge"
evt.HouseDoor(27, 148)  -- "Buccaneers' Lair"
evt.house[28] = 148  -- "Buccaneers' Lair"
evt.house[29] = 90  -- "Town Hall"
evt.house[30] = 156  -- "Throne Room"
evt.map[30] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 155, Icon = 2, Name = "0"}         -- "Castle Newton"
	evt.EnterHouse(156)         -- "Throne Room"
end

evt.hint[31] = evt.str[13]  -- "Welcome to Misty Islands"
evt.HouseDoor(50, 455)  -- "House"
evt.HouseDoor(51, 456)  -- "House"
evt.HouseDoor(52, 457)  -- "House"
evt.HouseDoor(53, 458)  -- "House"
evt.HouseDoor(54, 459)  -- "House"
evt.HouseDoor(55, 460)  -- "House"
evt.HouseDoor(56, 461)  -- "House"
evt.HouseDoor(57, 462)  -- "House"
evt.HouseDoor(58, 463)  -- "House"
evt.HouseDoor(59, 464)  -- "House"
evt.HouseDoor(60, 538)  -- "House"
evt.house[61] = 539  -- "House"
evt.map[61] = function()
	evt.EnterHouse(539)         -- "House"
	if not evt.Cmp("QBits", 301) then         -- NPC
		evt.Set("QBits", 301)         -- NPC
	end
end

evt.HouseDoor(62, 540)  -- "House"
evt.hint[75] = evt.str[3]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[3]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[3]  -- "Chest"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.hint[78] = evt.str[3]  -- "Chest"
evt.map[78] = function()
	evt.OpenChest(4)
end

evt.hint[79] = evt.str[3]  -- "Chest"
evt.map[79] = function()
	evt.OpenChest(5)
end

evt.house[90] = 177  -- "Silver Helm Outpost"
evt.map[90] = function()
	evt.MoveToMap{X = 4427, Y = 3061, Z = 769, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 177, Icon = 5, Name = "D07.Blv"}         -- "Silver Helm Outpost"
end

evt.map[91] = function()
	if evt.Cmp("QBits", 301) then         -- NPC
		evt.MoveToMap{X = -18176, Y = -1072, Z = 96, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[92] = function()
	evt.MoveToMap{X = 4688, Y = -2944, Z = 96, Direction = 1400, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[101] = evt.str[1]  -- "Tree"
evt.map[101] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar0", 1) then
			return
		end
	else
		evt.Set("MapVar0", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 134, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar0", 1) then
		evt.SetSprite{SpriteId = 134, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[102] = evt.str[1]  -- "Tree"
evt.map[102] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar1", 1) then
			return
		end
	else
		evt.Set("MapVar1", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 135, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar1", 1) then
		evt.SetSprite{SpriteId = 135, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[103] = evt.str[1]  -- "Tree"
evt.map[103] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar2", 1) then
			return
		end
	else
		evt.Set("MapVar2", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 136, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar2", 1) then
		evt.SetSprite{SpriteId = 136, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[104] = evt.str[1]  -- "Tree"
evt.map[104] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar3", 1) then
			return
		end
	else
		evt.Set("MapVar3", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 137, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar3", 1) then
		evt.SetSprite{SpriteId = 137, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[105] = evt.str[1]  -- "Tree"
evt.map[105] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar4", 1) then
			return
		end
	else
		evt.Set("MapVar4", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 138, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar4", 1) then
		evt.SetSprite{SpriteId = 138, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[106] = evt.str[1]  -- "Tree"
evt.map[106] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar5", 1) then
			return
		end
	else
		evt.Set("MapVar5", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 139, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar5", 1) then
		evt.SetSprite{SpriteId = 139, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[107] = evt.str[1]  -- "Tree"
evt.map[107] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar6", 1) then
			return
		end
	else
		evt.Set("MapVar6", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 140, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar6", 1) then
		evt.SetSprite{SpriteId = 140, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[108] = evt.str[1]  -- "Tree"
evt.map[108] = function()
	if evt.Cmp("MapVar7", 1) then
		evt.StatusText(2)         -- "There doesn't seem to be anymore apples."
		if not evt.Cmp("MapVar7", 1) then
			return
		end
	else
		evt.Set("MapVar7", 1)
		evt.Add("Food", 1)
		evt.StatusText(1)         -- "Tree"
	end
	evt.SetSprite{SpriteId = 141, Visible = 1, Name = "Tree06"}
end

function events.LoadMap()
	if evt.Cmp("MapVar7", 1) then
		evt.SetSprite{SpriteId = 141, Visible = 1, Name = "Tree06"}
	end
end

evt.hint[109] = evt.str[5]  -- "Drink from Fountain."
evt.map[109] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Subtract("MapVar9", 1)
		evt.Add("SP", 10)
		evt.StatusText(8)         -- "+10 Spell points restored."
		evt.Set("AutonotesBits", 11)         -- "10 Spell points restored by the central fountain in Mist."
	else
		evt.StatusText(7)         -- "Refreshing!"
	end
end

RefillTimer(function()
	evt.Set("MapVar9", 20)
end, const.Day)

evt.hint[110] = evt.str[5]  -- "Drink from Fountain."
evt.map[110] = function()
	if evt.Cmp("IntellectBonus", 10) then
		evt.StatusText(7)         -- "Refreshing!"
	else
		evt.Set("IntellectBonus", 10)
		evt.Set("PersonalityBonus", 10)
		evt.StatusText(9)         -- "+10 Intellect and Personality temporary."
		evt.Set("AutonotesBits", 13)         -- "10 Points of temporary intellect and personality from the west fountain at Castle Newton."
	end
end

evt.hint[111] = evt.str[5]  -- "Drink from Fountain."
evt.map[111] = function()
	if evt.Cmp("FireResBonus", 5) then
		evt.StatusText(7)         -- "Refreshing!"
	else
		evt.Set("FireResBonus", 5)
		evt.Set("ElecResBonus", 5)
		evt.Set("ColdResBonus", 5)
		evt.Set("PoisonResBonus", 5)
		evt.StatusText(10)         -- "+5 Elemental resistance temporary."
		evt.Set("AutonotesBits", 14)         -- "5 Points of temporary fire, electricity, cold, and poison resistance from the east fountain at Castle Newton."
	end
end

evt.hint[112] = evt.str[4]  -- "Drink from Well."
evt.map[112] = function()
	if evt.Cmp("LuckBonus", 20) then
		evt.StatusText(7)         -- "Refreshing!"
	else
		evt.Set("LuckBonus", 20)
		evt.StatusText(11)         -- "+20 Luck temporary."
		evt.Set("AutonotesBits", 12)         -- "20 Points of temporary luck from the fountain west of the Imp Slapper in Mist."
	end
end

evt.hint[113] = evt.str[6]  -- "Drink from Trough."
evt.map[113] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Cold, Damage = 20}
	evt.Set("PoisonedGreen", 1)
	evt.StatusText(12)         -- "Poison!"
end

evt.hint[114] = evt.str[6]  -- "Drink from Trough."
evt.map[114] = function()
	evt.StatusText(7)         -- "Refreshing!"
end

evt.map[210] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 157) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = 3039, FromY = -9201, FromZ = 2818, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[210].last, 5*const.Minute)

evt.map[211] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 157) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 157)         -- NPC
			evt.SetTextureOutdoors{Model = 53, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.hint[212] = evt.str[20]  -- "Obelisk"
evt.map[212] = function()
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            f_oteh__fe_h__e_"
	evt.SimpleMessage()
	evt.Set("QBits", 373)         -- NPC
	evt.Set("AutonotesBits", 92)         -- "Obelisk Message # 14: f_oteh__fe_h__e_"
end

evt.map[213] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 157) then         -- NPC
		evt.SetTextureOutdoors{Model = 53, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[213].last

evt.hint[261] = evt.str[15]  -- "Shrine of Intellect"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 1) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 208) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseIntellect", 3)
				evt.StatusText(18)         -- "+3 Intellect permanent"
			else
				evt.Set("QBits", 208)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseIntellect", 10)
				evt.StatusText(17)         -- "+10 Intellect permanent"
			end
			return
		end
	end
	evt.StatusText(16)         -- "You pray at the shrine."
end

