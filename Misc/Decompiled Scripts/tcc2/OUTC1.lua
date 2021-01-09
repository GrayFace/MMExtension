local TXT = Localize{
	[0] = " ",
	[1] = "Au",
	[2] = "Look Out!",
	[3] = "Autonote added.",
	[4] = "+20 Accuracy and Speed temporary.",
	[5] = "+20 Armor class temporary.",
	[6] = "Lenny 2",
	[7] = "Lenny 3",
	[8] = "Lenny Msg #2.  The Squiggies are not like us Lennies, fancy and dandy.  They are common Stones, plain and unattractive.",
	[9] = "Lenny Msg #3.  They live in the Valley of  Stones.",
	[10] = "Refreshing!",
	[11] = "Norseland",
	[12] = "Shrine of Accuracy",
	[13] = "You pray at the shrine.",
	[14] = "+10 Accuracy permanent",
	[15] = "+3 Accuracy permanent",
	[16] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _a,uef;re_oottg_l",
	[17] = "Obelisk",
	[18] = "Castle Birka",
	[19] = "Jorgsborg",
	[20] = "Cumbria/Port Sleigon",
	[21] = "Locked.  The proprietor has fled to the mountains.",
	[22] = "The Lord is in council and cannot be disturbed.",
	[23] = "You need the proper key to enter the keep.",
	[24] = "You cannot enter at this time",
	[25] = "This entrance is magically warded.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 262:34
-- ERROR: Duplicate label: 263:10
-- ERROR: Duplicate label: 265:0

evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

evt.hint[10] = evt.str[6]  -- "Lenny 2"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 502)         -- Campfire
		evt.SetMessage(8)         -- "Lenny Msg #2.  The Squiggies are not like us Lennies, fancy and dandy.  They are common Stones, plain and unattractive."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 11)         -- "Lenny Msg #2.  The Squiggies are not like us Lennies, fancy and dandy.  They are common Stones, plain and unattractive."
		evt.StatusText(3)         -- "Autonote added."
	else
		evt.StatusText(10)         -- "Refreshing!"
	end
end

evt.hint[11] = evt.str[7]  -- "Lenny 3"
evt.map[11] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 501)         -- Campfire
		evt.SetMessage(9)         -- "Lenny Msg #3.  They live in the Valley of  Stones."
		evt.SimpleMessage()
		evt.Set("AutonotesBits", 12)         -- "Lenny Msg #3.  They live in the Valley of  Stones."
		evt.StatusText(3)         -- "Autonote added."
	else
		evt.StatusText(10)         -- "Refreshing!"
	end
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 406) then         -- Birka Timer1
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = -4725, Y = 15551, Z = 1400}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -3735, Y = 16118, Z = 650}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -7467, Y = 18362, Z = 900}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -10662, Y = 13523, Z = 1250}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 6283, Y = 17094, Z = 555}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = 10328, Y = 22523, Z = 1235}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = 7978, Y = 21373, Z = 435}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 12506, Y = -3215, Z = 1635}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 21291, Y = -1044, Z = 1865}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = 18936, Y = -3352, Z = 765}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = 8520, Y = 3859, Z = 3100}
		evt.Set("QBits", 406)         -- Birka Timer1
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 12441, Y = -2439, Z = 1542}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 20828, Y = -8961, Z = 442}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 16776, Y = -21566, Z = 1342}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 10200, Y = 11400, Z = 850}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -11349, Y = 17574, Z = 650}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -8253, Y = 15583, Z = 1400}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -10548, Y = 15711, Z = 876}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -7717, Y = 12574, Z = 1950}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -8888, Y = 17907, Z = 2100}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 5600, Y = 20403, Z = 2867}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = 6460, Y = 15697, Z = 1900}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -259, Y = 5153, Z = 1800}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -5932, Y = 12049, Z = 1700}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -13143, Y = 17068, Z = 550}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 12557, Y = -3827, Z = 1225}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 20524, Y = -10570, Z = 950}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -8989, Y = 13803, Z = 2312}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 5690, Y = 11714, Z = 1650}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 18798, Y = -1443, Z = 1800}
	end
end

events.LoadMap = evt.map[262].last

evt.map[264] = function()  -- Timer(<function>, 95*const.Minute)
	if not evt.Cmp("QBits", 85) then         -- Paul
		if not evt.Cmp("QBits", 485) then         -- LG 2nd Jorgsburg
			evt.Add("QBits", 86)         -- Paul
		end
	end
end

Timer(evt.map[264].last, 95*const.Minute)

evt.map[265] = function()  -- Timer(<function>, 45*const.Minute)
	if evt.Cmp("QBits", 406) then         -- Birka Timer1
		evt.Add("QBits", 485)         -- LG 2nd Jorgsburg
	end
end

Timer(evt.map[265].last, 45*const.Minute)

evt.map[266] = function()  -- function events.LoadMap()
	evt.SetSnow{EffectId = 0, On = true}
end

events.LoadMap = evt.map[266].last

evt.map[271] = function()  -- function events.LoadMap()
	evt.SetSnow{EffectId = 0, On = true}
end

events.LoadMap = evt.map[271].last

