local TXT = Localize{
	[0] = " ",
	[1] = "Shadowspire",
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
	[12] = "inesonmid",
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
	[39] = "",
	[40] = "Rune post",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "Necromancers' Guild",
	[46] = "Mad Necromancer's Lab",
	[47] = "A Cave",
	[48] = "Vampire Crypt",
	[49] = "",
	[50] = "Enter the Necromancers' Guild",
	[51] = "Enter the Mad Necromancer's Lab",
	[52] = "Enter the Cave",
	[53] = "Enter the Vampire Crypt",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Intellect +2 (permanent)",
	[61] = "You mind clears, and you recover some Mana",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(347)
Game.LoadSound(325)

evt.hint[1] = evt.str[100]  -- ""
evt.hint[2] = evt.str[100]  -- ""
evt.hint[3] = evt.str[100]  -- ""
evt.hint[4] = evt.str[100]  -- ""
evt.map[4] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = true}         -- "Misc Group for Riki"
end

events.LoadMap = evt.map[4].last

evt.hint[6] = evt.str[100]  -- ""
evt.hint[7] = evt.str[100]  -- ""
evt.hint[8] = evt.str[100]  -- ""
evt.hint[9] = evt.str[100]  -- ""
evt.hint[10] = evt.str[100]  -- ""
evt.HouseDoor(13, 355)  -- "Taleshire Hall"
evt.house[14] = 355  -- "Taleshire Hall"
evt.HouseDoor(15, 356)  -- "Nightcrawler Estate"
evt.house[16] = 356  -- "Nightcrawler Estate"
evt.HouseDoor(17, 357)  -- "Mistspring Residence"
evt.house[18] = 357  -- "Mistspring Residence"
evt.HouseDoor(19, 358)  -- "House Arachnia"
evt.house[20] = 358  -- "House Arachnia"
evt.HouseDoor(21, 359)  -- "Dirthmoore Cottage"
evt.house[22] = 359  -- "Dirthmoore Cottage"
evt.HouseDoor(23, 360)  -- "House of Lathaen"
evt.house[24] = 360  -- "House of Lathaen"
evt.HouseDoor(25, 361)  -- "Brightsprear Hall"
evt.house[26] = 361  -- "Brightsprear Hall"
evt.HouseDoor(27, 362)  -- "Nightwood Estate"
evt.house[28] = 362  -- "Nightwood Estate"
evt.HouseDoor(29, 363)  -- "House Shador"
evt.house[30] = 363  -- "House Shador"
evt.HouseDoor(31, 364)  -- "House Mercutura"
evt.house[32] = 364  -- "House Mercutura"
evt.HouseDoor(33, 365)  -- "Roggen Hall"
evt.house[34] = 365  -- "Roggen Hall"
evt.HouseDoor(35, 366)  -- "Hallien's Cottage"
evt.house[36] = 366  -- "Hallien's Cottage"
evt.HouseDoor(37, 367)  -- "Roberts Residence"
evt.house[38] = 367  -- "Roberts Residence"
evt.HouseDoor(39, 368)  -- "Infaustus' House"
evt.house[40] = 368  -- "Infaustus' House"
evt.HouseDoor(41, 369)  -- "House of Journey"
evt.house[42] = 369  -- "House of Journey"
evt.HouseDoor(43, 370)  -- "Whisper Hall"
evt.house[44] = 370  -- "Whisper Hall"
evt.HouseDoor(45, 371)  -- "Steeleye Estate"
evt.house[46] = 371  -- "Steeleye Estate"
evt.HouseDoor(47, 372)  -- "House of Benefice"
evt.house[48] = 372  -- "House of Benefice"
evt.HouseDoor(49, 373)  -- "House Umberpool"
evt.house[50] = 373  -- "House Umberpool"
evt.HouseDoor(51, 374)  -- "Kelvin's Home"
evt.house[52] = 374  -- "Kelvin's Home"
evt.HouseDoor(53, 375)  -- "Caverhill Hall"
evt.house[54] = 375  -- "Caverhill Hall"
evt.HouseDoor(55, 376)  -- "Veritas Estate"
evt.house[56] = 376  -- "Veritas Estate"
evt.HouseDoor(57, 377)  -- "Stillwater Estate"
evt.house[58] = 377  -- "Stillwater Estate"
evt.HouseDoor(59, 378)  -- "Crane Cottage"
evt.house[60] = 378  -- "Crane Cottage"
evt.HouseDoor(61, 379)  -- "Bith Estate"
evt.house[62] = 379  -- "Bith Estate"
evt.HouseDoor(63, 380)  -- "Fellburn Residence"
evt.house[64] = 380  -- "Fellburn Residence"
evt.HouseDoor(65, 381)  -- "Gallowswell Manor"
evt.house[66] = 381  -- "Gallowswell Manor"
evt.HouseDoor(67, 382)  -- "House Fiddlebone"
evt.house[68] = 382  -- "House Fiddlebone"
evt.HouseDoor(69, 383)  -- "Deverbero Residence"
evt.house[70] = 383  -- "Deverbero Residence"
evt.HouseDoor(71, 384)  -- "Tantilion's House"
evt.house[72] = 384  -- "Tantilion's House"
evt.HouseDoor(73, 385)  -- "Fist Residence"
evt.house[74] = 385  -- "Fist Residence"
evt.HouseDoor(75, 386)  -- "Wargreen's Lab"
evt.house[76] = 386  -- "Wargreen's Lab"
evt.HouseDoor(77, 387)  -- "House Wallace"
evt.house[78] = 387  -- "House Wallace"
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

evt.hint[92] = evt.str[3]  -- "Chest"
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
	if evt.Cmp("BaseIntellect", 16) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("BaseIntellect", 2)
		evt.StatusText(60)         -- "Intellect +2 (permanent)"
		evt.Add("AutonotesBits", 259)         -- "Will in the city of Twilight under the Shadowspire gives a permanent Intellect bonus up to an Intellect of 16."
	end
end

evt.hint[102] = evt.str[6]  -- "Drink from the well"
evt.map[102] = function()
	if not evt.Cmp("MapVar29", 2) then
		if not evt.Cmp("Gold", 199) then
			if not evt.Cmp("BankGold", 99) then
				evt.Add("Gold", 200)
				evt.Add("MapVar29", 1)
				evt.Add("AutonotesBits", 260)         -- "Well in the city of Twilight under the Shadowspire gives 200 gold if the total gold on party and in the bank is less than 100."
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

evt.hint[104] = evt.str[8]  -- "Drink from the fountain"
evt.map[104] = function()
	if not evt.Cmp("QBits", 182) then         -- Twiling Town Portal
		evt.Add("QBits", 182)         -- Twiling Town Portal
	end
	if evt.Cmp("HasFullSP", 0) then
		evt.StatusText(9)         -- "Refreshing"
	else
		evt.Add("SP", 25)
		evt.StatusText(61)         -- "You mind clears, and you recover some Mana"
		evt.Add("AutonotesBits", 261)         -- "Fountain in the city of Twilight under the Shadowspire restores Spell Points."
	end
end

evt.hint[150] = evt.str[33]  -- "Obelisk"
evt.map[150] = function()
	if not evt.Cmp("QBits", 191) then         -- Obelisk Area 6
		evt.StatusText(12)         -- "inesonmid"
		evt.Add("AutonotesBits", 24)         -- "Obelisk message #8: inesonmid"
		evt.Add("QBits", 191)         -- Obelisk Area 6
	end
end

evt.HouseDoor(171, 5)  -- "Blooded Daggers and Blades"
evt.house[172] = 5  -- "Blooded Daggers and Blades"
evt.HouseDoor(173, 19)  -- "Supple Leather"
evt.house[174] = 19  -- "Supple Leather"
evt.HouseDoor(175, 33)  -- "Mystical Mayhem"
evt.house[176] = 33  -- "Mystical Mayhem"
evt.HouseDoor(177, 45)  -- "Wolves' Bane"
evt.house[178] = 45  -- "Wolves' Bane"
evt.HouseDoor(181, 58)  -- "Guild Caravans"
evt.house[182] = 58  -- "Guild Caravans"
evt.HouseDoor(183, 65)  -- "Smoke"
evt.house[184] = 65  -- "Smoke"
evt.HouseDoor(185, 78)  -- "Cathedral of Night"
evt.house[186] = 78  -- "Cathedral of Night"
evt.HouseDoor(187, 93)  -- "Assassin's School"
evt.house[188] = 93  -- "Assassin's School"
evt.HouseDoor(191, 112)  -- "Black Company"
evt.house[192] = 112  -- "Black Company"
evt.HouseDoor(193, 131)  -- "The Blood Bank"
evt.house[194] = 131  -- "The Blood Bank"
evt.HouseDoor(201, 143)  -- "Guild of Dark"
evt.house[202] = 143  -- "Guild of Dark"
evt.hint[401] = evt.str[45]  -- "Necromancers' Guild"
evt.hint[402] = evt.str[46]  -- "Mad Necromancer's Lab"
evt.hint[403] = evt.str[48]  -- "Vampire Crypt"
evt.hint[404] = evt.str[47]  -- "A Cave"
evt.hint[449] = evt.str[7]  -- "Fountain"
evt.hint[450] = evt.str[100]  -- ""
evt.house[454] = 45  -- "Wolves' Bane"
evt.map[454] = function()
	if not evt.Cmp("QBits", 239) then         -- for riki
		evt.Add("Inventory", 332)         -- "Lloyd's Beacon"
		evt.Add("QBits", 239)         -- for riki
	end
end

evt.hint[479] = evt.str[100]  -- ""
evt.map[479] = function()  -- Timer(<function>, 10*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.PlaySound{Id = 347, X = -6976, Y = -15104}
	elseif i == 2 then
		evt.PlaySound{Id = 347, X = 2176, Y = -11904}
	elseif i == 3 then
		evt.PlaySound{Id = 347, X = -2496, Y = -16480}
	elseif i == 4 then
		evt.PlaySound{Id = 347, X = -10400, Y = -12800}
	elseif i == 5 then
		evt.PlaySound{Id = 347, X = 7872, Y = -9664}
	end
end

Timer(evt.map[479].last, 10*const.Minute)

evt.hint[490] = evt.str[100]  -- ""
evt.map[490] = function()  -- Timer(<function>, 7.5*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		evt.PlaySound{Id = 325, X = 864, Y = -13024}
	end
end

Timer(evt.map[490].last, 7.5*const.Minute)

evt.hint[494] = evt.str[40]  -- "Rune post"
evt.map[494] = function()
	local i
	if evt.Cmp("QBits", 281) then         -- Reagant spout area 6
		return
	end
	if not evt.Cmp("PerceptionSkill", 3) then
		return
	end
	i = Game.Rand() % 5
	if i == 1 then
		evt.SummonObject{Item = 200, X = 5504, Y = -12224, Z = 96, Speed = 1000, Count = 1, RandomAngle = true}         -- "Widowsweep Berries" : "Widowsweep Berries"
	elseif i == 2 then
		evt.SummonObject{Item = 205, X = 5504, Y = -12224, Z = 96, Speed = 1000, Count = 1, RandomAngle = true}         -- "Phima Root" : "Phima Root"
	elseif i == 3 then
		evt.SummonObject{Item = 210, X = 5504, Y = -12224, Z = 96, Speed = 1000, Count = 1, RandomAngle = true}         -- "Poppy Pod" : "Poppy Pod"
	elseif i == 4 then
		evt.SummonObject{Item = 215, X = 5504, Y = -12224, Z = 96, Speed = 1000, Count = 1, RandomAngle = true}         -- "Mushroom" : "Mushroom"
	else
		evt.SummonObject{Item = 220, X = 5504, Y = -12224, Z = 96, Speed = 1000, Count = 1, RandomAngle = true}         -- "Potion Bottle" : "Potion Bottle"
	end
	evt.Add("QBits", 281)         -- Reagant spout area 6
end

evt.hint[495] = evt.str[40]  -- "Rune post"
evt.map[495] = function()
	local i
	if evt.Cmp("QBits", 279) then         -- Reagant spout area 6
		return
	end
	if not evt.Cmp("PerceptionSkill", 5) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.SummonObject{-- ERROR: Not found
Item = 2138, X = -3136, Y = -4032, Z = 348, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gold Ring"
	elseif i == 2 then
		evt.SummonObject{-- ERROR: Not found
Item = 2139, X = -3136, Y = -4032, Z = 348, Speed = 1000, Count = 1, RandomAngle = true}         -- "Pearl Ring"
	elseif i == 3 then
		evt.SummonObject{-- ERROR: Not found
Item = 2140, X = -3136, Y = -4032, Z = 348, Speed = 1000, Count = 1, RandomAngle = true}         -- "Gemstone Ring"
	else
		evt.SummonObject{-- ERROR: Not found
Item = 2141, X = -3136, Y = -4032, Z = 348, Speed = 1000, Count = 1, RandomAngle = true}         -- "Amethyst Ring"
	end
	evt.Add("QBits", 279)         -- Reagant spout area 6
end

evt.hint[496] = evt.str[40]  -- "Rune post"
evt.map[496] = function()
	local i
	if evt.Cmp("QBits", 280) then         -- Reagant spout area 6
		return
	end
	if not evt.Cmp("PerceptionSkill", 7) then
		return
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.SummonObject{Item = 240, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Might Boost" : "Might Boost"
	elseif i == 2 then
		evt.SummonObject{Item = 241, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Intellect Boost" : "Intellect Boost"
	elseif i == 3 then
		evt.SummonObject{Item = 242, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Personality Boost" : "Personality Boost"
	elseif i == 4 then
		evt.SummonObject{Item = 243, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Endurance Boost" : "Endurance Boost"
	elseif i == 5 then
		evt.SummonObject{Item = 244, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Speed Boost" : "Speed Boost"
	else
		evt.SummonObject{Item = 245, X = -12288, Y = 7744, Z = 988, Speed = 1000, Count = 1, RandomAngle = true}         -- "Accuracy Boost" : "Accuracy Boost"
	end
	evt.Add("QBits", 280)         -- Reagant spout area 6
end

evt.hint[501] = evt.str[50]  -- "Enter the Necromancers' Guild"
evt.map[501] = function()
	evt.MoveToMap{X = 0, Y = 64, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 212, Icon = 1, Name = "d19.blv"}         -- "Necromancers' Guild"
end

evt.hint[502] = evt.str[51]  -- "Enter the Mad Necromancer's Lab"
evt.map[502] = function()
	evt.MoveToMap{X = -900, Y = -127, Z = 1, Direction = 520, LookAngle = 0, SpeedZ = 0, HouseId = 213, Icon = 1, Name = "d20.blv"}         -- "Mad Necromancer's Lab"
end

evt.hint[503] = evt.str[53]  -- "Enter the Vampire Crypt"
evt.map[503] = function()
	evt.MoveToMap{X = -457, Y = -1749, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 1, Name = "D21.blv"}
end

evt.hint[504] = evt.str[52]  -- "Enter the Cave"
evt.map[504] = function()
	evt.MoveToMap{X = 9690, Y = 1334, Z = 1176, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D49.blv"}
end

