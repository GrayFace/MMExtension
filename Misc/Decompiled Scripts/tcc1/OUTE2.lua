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
	[13] = "Welcome to Ellesia",
	[14] = "Ellesia",
	[15] = "Shrine of Might",
	[16] = "You pray at the shrine.",
	[17] = "+10 Might permanent",
	[18] = "+3 Might permanent",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           iNs_u_t_rfesh_'ns",
	[20] = "Obelisk",
	[21] = "The Barrel is empty.",
	[22] = "Green Super Barrel",
	[23] = "Thank you!",
	[24] = "A caged Prisoner!",
	[25] = "Closed for repairs.",
	[26] = "You need a key to enter the temple.",
	[27] = "Campfire",
	[28] = "Elixir of Revelation",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[14]  -- "Ellesia"

evt.hint[1] = evt.str[1]  -- "Tree"
evt.house[2] = 5  -- "Arm's Length Spear Shop"
evt.map[2] = function()
	evt.EnterHouse(5)         -- "Arm's Length Spear Shop"
end

evt.house[3] = 5  -- "Arm's Length Spear Shop"
evt.map[3] = function()
end

evt.house[4] = 16  -- "Armor Emporium"
evt.map[4] = function()
	evt.EnterHouse(16)         -- "Armor Emporium"
end

evt.house[5] = 16  -- "Armor Emporium"
evt.map[5] = function()
end

evt.house[6] = 30  -- "Witch's Brew"
evt.map[6] = function()
	evt.EnterHouse(30)         -- "Witch's Brew"
end

evt.hint[7] = evt.str[30]
evt.house[8] = 43  -- "Lock, Stock, and Barrel"
evt.map[8] = function()
	evt.EnterHouse(43)         -- "Lock, Stock, and Barrel"
end

evt.house[9] = 43  -- "Lock, Stock, and Barrel"
evt.map[9] = function()
end

evt.house[10] = 60  -- "Wyvern's Wind"
evt.map[10] = function()
	evt.EnterHouse(60)         -- "Wyvern's Wind"
end

evt.house[11] = 86  -- "Island Testing Center"
evt.map[11] = function()
	evt.EnterHouse(86)         -- "Island Testing Center"
end

evt.house[12] = 86  -- "Island Testing Center"
evt.map[12] = function()
end

evt.house[13] = 90  -- "Town Hall"
evt.map[13] = function()
	evt.StatusText(25)         -- "Closed for repairs."
end

evt.house[14] = 74  -- "Ellesian Ministries"
evt.map[14] = function()
	evt.ForPlayer("All")
	if evt.Cmp("NPCs", 110) then         -- "Tobin"
		evt.Subtract("NPCs", 110)         -- "Tobin"
		evt.MoveNPC{NPC = 175, HouseId = 74}         -- "Tobin" -> "Ellesian Ministries"
		evt.Subtract("QBits", 83)         -- "Escourt Tobin back to the Misty Island Temple."
		evt.Set("Awards", 63)         -- "Returned Tobin to the Ellesian Ministries."
		evt.Add("Experience", 3000)
		evt.Add("Gold", 1000)
		evt.Add("ReputationIs", 25)
		evt.StatusText(23)         -- "Thank you!"
		evt.SetNPCTopic{NPC = 154, Index = 0, Event = 328}         -- "Graham" : "Have you seen Tamara?"
	end
	evt.EnterHouse(74)         -- "Ellesian Ministries"
end

evt.house[15] = 93  -- "The Orc Slayer"
evt.map[15] = function()
	evt.EnterHouse(93)         -- "The Orc Slayer"
end

evt.house[16] = 93  -- "The Orc Slayer"
evt.map[16] = function()
end

evt.house[17] = 114  -- "The Reserves"
evt.map[17] = function()
	evt.EnterHouse(114)         -- "The Reserves"
end

evt.house[18] = 114  -- "The Reserves"
evt.map[18] = function()
end

evt.house[19] = 119  -- "Initiate Guild of Ignis"
evt.map[19] = function()
	evt.EnterHouse(119)         -- "Initiate Guild of Ignis"
end

evt.house[20] = 119  -- "Initiate Guild of Ignis"
evt.map[20] = function()
end

evt.house[21] = 121  -- "Initiate Guild of Aeros"
evt.map[21] = function()
	evt.EnterHouse(121)         -- "Initiate Guild of Aeros"
end

evt.house[22] = 121  -- "Initiate Guild of Aeros"
evt.map[22] = function()
end

evt.house[23] = 123  -- "Initiate Guild of Aqua Magics"
evt.map[23] = function()
	evt.EnterHouse(123)         -- "Initiate Guild of Aqua Magics"
end

evt.house[24] = 123  -- "Initiate Guild of Aqua Magics"
evt.map[24] = function()
end

evt.house[25] = 142  -- "Duelists' Edge"
evt.map[25] = function()
	evt.EnterHouse(142)         -- "Duelists' Edge"
end

evt.house[26] = 142  -- "Duelists' Edge"
evt.map[26] = function()
end

evt.house[27] = 148  -- "Buccaneers' Lair"
evt.map[27] = function()
	evt.EnterHouse(148)         -- "Buccaneers' Lair"
end

evt.house[28] = 148  -- "Buccaneers' Lair"
evt.map[28] = function()
end

evt.house[29] = 90  -- "Town Hall"
evt.map[29] = function()
end

evt.house[30] = 156  -- "Enchanted Bastion"
evt.map[30] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("DiplomacySkill", 136) then
		evt.EnterHouse(156)         -- "Enchanted Bastion"
	else
		evt.SetNPCTopic{NPC = 183, Index = 0, Event = 354}         -- "Guard" : "Audience with the Beneficent One"
		evt.SpeakNPC(183)         -- "Guard"
	end
end

evt.hint[31] = evt.str[13]  -- "Welcome to Ellesia"
evt.hint[32] = evt.str[22]  -- "Green Super Barrel"
evt.map[32] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 506) then         -- Green Super Barrel
		evt.StatusText(21)         -- "The Barrel is empty."
	else
		evt.Add("BaseEndurance", 10)
		evt.Set("BodybuildingSkill", 68)
		evt.Set("QBits", 506)         -- Green Super Barrel
	end
end

evt.hint[33] = evt.str[24]  -- "A caged Prisoner!"
evt.map[33] = function()
	if not evt.Cmp("QBits", 500) then         -- Tobin Cage
		evt.StatusText(23)         -- "Thank you!"
		evt.Set("NPCs", 110)         -- "Tobin"
		evt.Set("QBits", 500)         -- Tobin Cage
	end
end

evt.hint[34] = evt.str[27]  -- "Campfire"
evt.map[34] = function()
	if not evt.Cmp("QBits", 501) then         -- Campfire
		evt.Add("Food", 2)
		evt.Set("QBits", 501)         -- Campfire
		evt.GiveItem{Strength = 5, Type = const.ItemType.Misc, Id = 0}
	end
end

evt.hint[35] = evt.str[27]  -- "Campfire"
evt.map[35] = function()
	if not evt.Cmp("QBits", 502) then         -- Campfire
		evt.Add("Food", 1)
		evt.Set("QBits", 502)         -- Campfire
		evt.GiveItem{Strength = 5, Type = const.ItemType.Sword, Id = 0}
	end
end

evt.hint[36] = evt.str[27]  -- "Campfire"
evt.map[36] = function()
	if not evt.Cmp("QBits", 503) then         -- Campfire
		evt.Add("Food", 1)
		evt.Set("QBits", 503)         -- Campfire
		evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
	end
end

evt.house[50] = 455  -- "House"
evt.map[50] = function()
	evt.EnterHouse(455)         -- "House"
end

evt.house[51] = 456  -- "House"
evt.map[51] = function()
	evt.EnterHouse(456)         -- "House"
end

evt.house[52] = 457  -- "House"
evt.map[52] = function()
	evt.EnterHouse(457)         -- "House"
end

evt.house[53] = 458  -- "House"
evt.map[53] = function()
	evt.EnterHouse(458)         -- "House"
end

evt.house[54] = 459  -- "House"
evt.map[54] = function()
	evt.EnterHouse(459)         -- "House"
end

evt.house[55] = 460  -- "House"
evt.map[55] = function()
	evt.EnterHouse(460)         -- "House"
end

evt.house[56] = 461  -- "House"
evt.map[56] = function()
	evt.EnterHouse(461)         -- "House"
end

evt.house[57] = 462  -- "House"
evt.map[57] = function()
	evt.EnterHouse(462)         -- "House"
end

evt.house[58] = 463  -- "House"
evt.map[58] = function()
	evt.EnterHouse(463)         -- "House"
end

evt.house[59] = 464  -- "House"
evt.map[59] = function()
	evt.EnterHouse(464)         -- "House"
end

evt.house[60] = 538  -- "House of  Magnus"
evt.map[60] = function()
	evt.EnterHouse(538)         -- "House of  Magnus"
end

evt.house[61] = 539  -- "Tamara's House"
evt.map[61] = function()
	evt.EnterHouse(539)         -- "Tamara's House"
	if not evt.Cmp("QBits", 301) then         -- NPC
		evt.Set("QBits", 301)         -- NPC
	end
end

evt.house[62] = 540  -- "House"
evt.map[62] = function()
	evt.EnterHouse(540)         -- "House"
end

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

evt.house[90] = 191  -- "Harbor Grace"
evt.map[90] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 426) then         -- Harbor Grace once.
		if not evt.Cmp("Inventory", 525) then         -- "Harbor Grace Key"
			evt.StatusText(26)         -- "You need a key to enter the temple."
			return
		end
	end
	evt.MoveToMap{X = -15592, Y = 120, Z = -191, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 5, Name = "T1.Blv"}         -- "Harbor Grace"
end

evt.map[91] = function()
	if not evt.Cmp("QBits", 301) then         -- NPC
		return
	end
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -18160, Y = -1072, Z = 96}
	if evt.Cmp("QBits", 508) then         -- Warrior
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -18144, Y = -1079, Z = 96}
		if evt.Cmp("QBits", 507) then         -- Death Wish
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -18176, Y = -950, Z = 96}
		end
	end
	evt.MoveToMap{X = -18176, Y = -1072, Z = 96, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[92] = function()
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 200, Y = -14700, Z = -50}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = 200, Y = -14700, Z = -50}
	if evt.Cmp("QBits", 508) then         -- Warrior
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 190, Y = -14500, Z = -50}
		if evt.Cmp("QBits", 507) then         -- Death Wish
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 210, Y = -14750, Z = -50}
		end
	end
	evt.MoveToMap{X = 200, Y = -14600, Z = -50, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
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
		evt.Set("AutonotesBits", 11)         -- "10 Spell points restored by the central fountain in Ellesia."
	else
		evt.StatusText(7)         -- "Refreshing!"
	end
end

Timer(function()
	evt.Set("MapVar9", 20)
end, const.Day, 1*const.Second)

evt.hint[110] = evt.str[5]  -- "Drink from Fountain."
evt.map[110] = function()
	if evt.Cmp("IntellectBonus", 10) then
		evt.StatusText(7)         -- "Refreshing!"
	else
		evt.Set("IntellectBonus", 10)
		evt.Set("PersonalityBonus", 10)
		evt.StatusText(9)         -- "+10 Intellect and Personality temporary."
		evt.Set("AutonotesBits", 13)         -- "10 Points of temporary intellect and personality from the west fountain at the Enchanted Bastion."
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
		evt.Set("AutonotesBits", 14)         -- "5 Points of temporary fire, electricity, cold, and poison resistance from the east fountain at the Enchanted Bastion."
	end
end

evt.hint[112] = evt.str[4]  -- "Drink from Well."
evt.map[112] = function()
	if evt.Cmp("LuckBonus", 20) then
		evt.StatusText(7)         -- "Refreshing!"
	else
		evt.Set("LuckBonus", 20)
		evt.StatusText(11)         -- "+20 Luck temporary."
		evt.Set("AutonotesBits", 12)         -- "20 Points of temporary luck from the fountain west of the Imp Slapper in Ellesia."
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

evt.hint[115] = evt.str[28]  -- "Elixir of Revelation"
evt.map[115] = function()
	if not evt.Cmp("QBits", 401) then         -- Elixir  of Revelation once
		evt.ForPlayer("All")
		evt.Set("PerceptionSkill", 68)
		evt.Add("QBits", 401)         -- Elixir  of Revelation once
	end
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
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           iNs_u_t_rfesh_'ns"
	evt.SimpleMessage()
	evt.Set("QBits", 373)         -- NPC
	evt.Set("AutonotesBits", 92)         -- "Obelisk Message # 14: iNs_u_t_rfesh_'ns"
end

evt.map[213] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 157) then         -- NPC
		evt.SetTextureOutdoors{Model = 53, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[213].last

evt.hint[261] = evt.str[15]  -- "Shrine of Might"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 0) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 208) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseMight", 3)
				evt.StatusText(18)         -- "+3 Might permanent"
			else
				evt.Set("QBits", 208)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseMight", 10)
				evt.StatusText(17)         -- "+10 Might permanent"
			end
			return
		end
	end
	evt.StatusText(16)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 505) then         -- Misty Reload
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 9550, Y = 10200, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 9555, Y = 10220, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 10100, Y = 11400, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 10200, Y = 11400, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = 5450, Y = 17050, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5460, Y = 17050, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -8166, Y = -7000, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -8155, Y = -6990, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 13700, Y = 8450, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -4670, Y = -18620, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 7, X = -4670, Y = -18620, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = -7960, Y = -12220, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 10, X = -7955, Y = -12230, Z = 0}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -7950, Y = -12210, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -265, Y = 11000, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -11765, Y = 6880, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -9130, Y = 12060, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -5630, Y = -6620, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -5125, Y = -6583, Z = 0}
				evt.Set("QBits", 505)         -- Misty Reload
			else
				evt.Set("QBits", 505)         -- Misty Reload
			end
		end
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

