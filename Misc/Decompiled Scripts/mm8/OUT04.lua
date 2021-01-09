local TXT = Localize{
	[0] = " ",
	[1] = "Ironsand Desert",
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
	[12] = "thornskey",
	[13] = "",
	[14] = "",
	[15] = "The door is locked",
	[16] = "",
	[17] = "",
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
	[39] = "Destroyed Building",
	[40] = "Cactus",
	[41] = "Rock",
	[42] = "",
	[43] = "",
	[44] = "Tomb Stone",
	[45] = "Troll Tomb",
	[46] = "Cyclops Larder",
	[47] = "Chain of Fire",
	[48] = "A Cave",
	[49] = "Gate to the Plane of Fire",
	[50] = "Enter the Troll Tomb",
	[51] = "Enter the Cyclops Larder",
	[52] = "Enter the Chain of Fire",
	[53] = "Enter the Cave",
	[54] = "Enter the Plane of Fire",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Endurance +2 (Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(327)
Game.LoadSound(325)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 60) then         -- Party visits Ironsand After QuestBit 25 set.
		if evt.Cmp("QBits", 25) then         -- "Find a witness to the lake of fire's formation. Bring him back to the merchant guild in Alvar."
			evt.Set("QBits", 60)         -- Party visits Ironsand After QuestBit 25 set.
		end
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(11, 177)  -- "Overdune's House"
evt.house[12] = 177  -- "Overdune's House"
evt.HouseDoor(13, 337)  -- "Pole's Hovel"
evt.house[14] = 337  -- "Pole's Hovel"
evt.HouseDoor(15, 336)  -- "Hovel of Greenstorm"
evt.house[16] = 336  -- "Hovel of Greenstorm"
evt.HouseDoor(17, 335)  -- "Hobert's Hovel"
evt.house[18] = 335  -- "Hobert's Hovel"
evt.HouseDoor(19, 334)  -- "Hovel of Mist"
evt.house[20] = 334  -- "Hovel of Mist"
evt.HouseDoor(21, 333)  -- "Talion's Hovel"
evt.house[22] = 333  -- "Talion's Hovel"
evt.HouseDoor(23, 331)  -- "Stone's Hovel"
evt.house[24] = 331  -- "Stone's Hovel"
evt.HouseDoor(25, 332)  -- "Hearthsworn Hovel"
evt.house[26] = 332  -- "Hearthsworn Hovel"
evt.HouseDoor(27, 339)  -- "Schmecker's Hovel"
evt.house[28] = 339  -- "Schmecker's Hovel"
evt.HouseDoor(29, 338)  -- "Tarent Hovel"
evt.house[30] = 338  -- "Tarent Hovel"
evt.HouseDoor(31, 479)  -- "Thistlebone Residence"
evt.house[32] = 479  -- "Thistlebone Residence"
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

evt.hint[92] = evt.str[41]  -- "Rock"
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
	evt.OpenChest(18)
end

evt.hint[100] = evt.str[3]  -- "Chest"
evt.map[100] = function()
	evt.OpenChest(19)
end

evt.hint[101] = evt.str[6]  -- "Drink from the well"
evt.map[101] = function()
	if evt.Cmp("BaseEndurance", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseEndurance", 2)
		evt.StatusText(60)         -- "Endurance +2 (Permanent)"
		evt.Add("AutonotesBits", 254)         -- "Well in the village of Rust gives a permanent Endurance bonus up to an Endurance of 16."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if not evt.Cmp("MapVar29", 2) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("BankGold", 99) then
				evt.Add("Gold", 200)
				evt.Add("MapVar29", 1)
				evt.Add("AutonotesBits", 255)         -- "Fountain in the village of Rust in the Ironsand Desert gives 200 gold if the total gold on party and in the bank is less than 100."
				return
			end
		end
	end
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[103] = evt.str[6]  -- "Drink from the well"
evt.map[103] = function()
	evt.StatusText(9)         -- "Refreshing"
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 189) then         -- Obelisk Area 4
		evt.StatusText(12)         -- "thornskey"
		evt.Add("AutonotesBits", 19)         -- "Obelisk message #3: thornskey"
		evt.Add("QBits", 189)         -- Obelisk Area 4
	end
end

evt.HouseDoor(179, 141)  -- "Self Study"
evt.house[180] = 141  -- "Self Study"
evt.HouseDoor(181, 56)  -- "Guild Caravans"
evt.house[182] = 56  -- "Guild Caravans"
evt.HouseDoor(189, 104)  -- "Placeholder"
evt.house[190] = 104  -- "Placeholder"
evt.HouseDoor(191, 110)  -- "Parched Throat"
evt.house[192] = 110  -- "Parched Throat"
evt.hint[401] = evt.str[45]  -- "Troll Tomb"
evt.hint[402] = evt.str[46]  -- "Cyclops Larder"
evt.hint[403] = evt.str[47]  -- "Chain of Fire"
evt.hint[404] = evt.str[48]  -- "A Cave"
evt.hint[405] = evt.str[49]  -- "Gate to the Plane of Fire"
evt.hint[406] = evt.str[39]  -- "Destroyed Building"
evt.hint[479] = evt.str[100]  -- ""
evt.map[479] = function()  -- Timer(<function>, 10*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 327, X = -8128, Y = -2496}
	elseif i == 2 then
		evt.PlaySound{Id = 327, X = -2048, Y = 1344}
	elseif i == 3 then
		evt.PlaySound{Id = 327, X = -1216, Y = -7680}
	elseif i == 4 then
		evt.PlaySound{Id = 327, X = -10528, Y = -15168}
	elseif i == 5 then
		evt.PlaySound{Id = 327, X = 3520, Y = -14112}
	end
end

Timer(evt.map[479].last, 10*const.Minute)

evt.hint[490] = evt.str[100]  -- ""
evt.map[490] = function()  -- Timer(<function>, 7.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		evt.PlaySound{Id = 325, X = -6848, Y = 3776}
	end
end

Timer(evt.map[490].last, 7.5*const.Minute)

evt.hint[494] = evt.str[40]  -- "Cactus"
evt.map[494] = function()
	local i
	if evt.Cmp("QBits", 278) then         -- Reagant spout area 4
		return
	end
	if not evt.Cmp("PerceptionSkill", 3) then
		return
	end
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Item = 200, X = -7616, Y = -4160, Z = 504, Speed = 1000, Count = 1, RandomAngle = true}         -- "Widowsweep Berries" : "Widowsweep Berries"
	elseif i == 2 then
		evt.SummonObject{Item = 205, X = -7616, Y = -4160, Z = 504, Speed = 1000, Count = 1, RandomAngle = true}         -- "Phima Root" : "Phima Root"
	elseif i == 3 then
		evt.SummonObject{Item = 210, X = -7616, Y = -4160, Z = 504, Speed = 1000, Count = 1, RandomAngle = true}         -- "Poppy Pod" : "Poppy Pod"
	elseif i == 4 then
		evt.SummonObject{Item = 215, X = -7616, Y = -4160, Z = 504, Speed = 1000, Count = 1, RandomAngle = true}         -- "Mushroom" : "Mushroom"
	else
		evt.SummonObject{Item = 220, X = -7616, Y = -4160, Z = 504, Speed = 1000, Count = 1, RandomAngle = true}         -- "Potion Bottle" : "Potion Bottle"
	end
	evt.Add("QBits", 278)         -- Reagant spout area 4
end

evt.hint[495] = evt.str[41]  -- "Rock"
evt.map[495] = function()
	local i
	if evt.Cmp("QBits", 277) then         -- Reagant spout area 4
		return
	end
	if not evt.Cmp("PerceptionSkill", 5) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{-- ERROR: Not found
Item = 2138, X = 1728, Y = -3776, Z = 1008, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gold Ring"
	elseif i == 2 then
		evt.SummonObject{-- ERROR: Not found
Item = 2139, X = 1728, Y = -3776, Z = 1008, Speed = 1000, Count = 1, RandomAngle = true}         -- "Pearl Ring"
	elseif i == 3 then
		evt.SummonObject{-- ERROR: Not found
Item = 2140, X = 1728, Y = -3776, Z = 1008, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gemstone Ring"
	else
		evt.SummonObject{-- ERROR: Not found
Item = 2141, X = 1728, Y = -3776, Z = 1008, Speed = 1000, Count = 1, RandomAngle = true}         -- "Amethyst Ring"
	end
	evt.Add("QBits", 277)         -- Reagant spout area 4
end

evt.hint[501] = evt.str[50]  -- "Enter the Troll Tomb"
evt.map[501] = function()
	evt.MoveToMap{X = -672, Y = 768, Z = -28, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 199, Icon = 1, Name = "d13.blv"}         -- "Troll Tomb"
end

evt.hint[502] = evt.str[51]  -- "Enter the Cyclops Larder"
evt.map[502] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 200, Icon = 1, Name = "d14.blv"}         -- "Cyclops Larder"
end

evt.hint[503] = evt.str[52]  -- "Enter the Chain of Fire"
evt.map[503] = function()
	evt.MoveToMap{X = -288, Y = -768, Z = 0, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 201, Icon = 1, Name = "d15.blv"}         -- "Chain of Fire"
end

evt.hint[504] = evt.str[54]  -- "Enter the Plane of Fire"
evt.map[504] = function()
	evt.MoveToMap{X = 99, Y = -22056, Z = 3057, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 220, Icon = 1, Name = "ElemF.odm"}         -- "Gateway to the Plane of Fire"
end

evt.hint[505] = evt.str[52]  -- "Enter the Chain of Fire"
evt.map[505] = function()
	evt.MoveToMap{X = -12423, Y = 4347, Z = -135, Direction = 1544, LookAngle = 0, SpeedZ = 0, HouseId = 201, Icon = 1, Name = "d15.blv"}         -- "Chain of Fire"
end

evt.hint[506] = evt.str[53]  -- "Enter the Cave"
evt.map[506] = function()
	evt.MoveToMap{X = 2116, Y = 9631, Z = 1, Direction = 1296, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D48.blv"}
end

