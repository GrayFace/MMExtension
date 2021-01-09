local TXT = Localize{
	[0] = " ",
	[1] = "Guiding Light",
	[2] = "To the Land that Time Forgot",
	[3] = "Trap!",
	[4] = "Healing",
	[5] = "Plaque",
	[6] = "The entrance to the central pyramid lies to the South.",
	[7] = "The door is locked",
	[8] = "Healing Pool",
	[9] = "Flame Door",
	[10] = "Healing",
	[11] = "The chest is locked",
	[12] = "Door won't budge.",
	[13] = "Healing",
	[14] = "Healing",
	[15] = "The waters part.",
	[16] = "Warning!  Power Fluctuations!  Alert Engineering immediately!",
	[17] = "In case of energy leak, bathe in one of the medicated pools placed for your safety and convenience.",
	[18] = "Crystal Skull absorbs radiation damage.",
	[19] = "Door",
	[20] = "Only the one bearing the key may speak the code.",
	[21] = "",
	[22] = "Picture Door",
	[23] = "Back Door",
	[24] = "Switch",
	[25] = "Water Temple",
	[26] = "Healing Pool",
	[27] = "The Well of VARN must be keyed last.",
	[28] = "Control Room Entry",
	[29] = "Chest",
	[30] = "Picture",
	[31] = "Exit",
	[32] = "What is the first mate's code?",
	[33] = "kcopS",
	[34] = "What is the navigator's code?",
	[35] = "uluS",
	[36] = "What is the communication officer's code?",
	[37] = "aruhU",
	[38] = "What is the engineer's code?",
	[39] = "yttocS",
	[40] = "What is the doctor's code?",
	[41] = "yoccM",
	[42] = "What is the Captain's code?",
	[43] = "kriK",
	[44] = "Answer?  ",
	[45] = "Incorrect.",
	[46] = "Access Denied.  All codes must be entered first.",
	[47] = "Main Power failed.  Emergency power on.",
	[48] = "Main Power restored.",
	[49] = "Books",
	[50] = "Pyramid",
	[51] = "Bookcase",
	[52] = "Tapestry",
	[53] = "With painstaking care, you are able to decipher the message of the hieroglyphs:                                                                                                                                                     Though the Crossing of the Void be a long and arduous journey, the land you find at the end will be sweet and unspoiled by ancestors or the Enemy.  Take heart that your children's children will live in a perfect world free of war, free of famine, and free of fear.  Remember your sacred duty to care for the Ship on her long Voyage and ensure her safe arrival in the Promised Land.  Tend well the Guardian and house it securely away from the ship lest both be lost in a single misfortune.",
	[54] = "With painstaking care, you are able to decipher the message of the hieroglyphs, intermixed with diagrams of devils:                                                                                          Remember our Enemy, children, and never underestimate the danger they pose.  Though you will never see one during your journey, you must be forever vigilant against invasion from the Void once the Voyage has ended.  Mighty beyond words, the Enemy is nonetheless vulnerable after a Crossing, for their numbers are small and their defenses weak.  Use the energy weapons carried on the Ship to defeat them, and never, ever engage the Enemy with lesser weapons, or you will surely perish.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[50]  -- "Pyramid"
-- ERROR: Duplicate label: 1:0
-- ERROR: Duplicate label: 12:3
-- ERROR: Duplicate label: 12:4
-- ERROR: Duplicate label: 12:5
-- ERROR: Duplicate label: 12:6
-- ERROR: Duplicate label: 12:7
-- ERROR: Duplicate label: 12:8
-- ERROR: Duplicate label: 24:2
-- ERROR: Duplicate label: 25:2

evt.hint[1] = evt.str[21]  -- ""
evt.hint[2] = evt.str[22]  -- "Picture Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[23]  -- "Back Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[22]  -- "Picture Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[19]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[22]  -- "Picture Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[22]  -- "Picture Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[24]  -- "Switch"
evt.hint[9] = evt.str[24]  -- "Switch"
evt.hint[10] = evt.str[22]  -- "Picture Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[25]  -- "Water Temple"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.map[12] = function()  -- Timer(<function>, 1.5*const.Minute)
	if evt.Cmp("MapVar0", 1) then
		if not evt.Cmp("MapVar3", 15) then
			evt.ForPlayer("All")
			evt.Add("HP", 50)
			evt.StatusText(4)         -- "Healing"
			evt.Add("MapVar3", 1)
		end
	end
end

Timer(evt.map[12].last, 1.5*const.Minute)

evt.hint[13] = evt.str[26]  -- "Healing Pool"
evt.map[13] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[22]  -- "Picture Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[31]  -- "Exit"
evt.map[17] = function()
	evt.MoveToMap{X = -6647, Y = 13018, Z = 1761, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB3.Odm"}
end

evt.hint[18] = evt.str[31]  -- "Exit"
evt.map[18] = function()
	evt.MoveToMap{X = -6611, Y = 11408, Z = 480, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB3.Odm"}
end

evt.hint[19] = evt.str[30]  -- "Picture"
evt.map[20] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[21] = evt.str[26]  -- "Healing Pool"
evt.map[21] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[22] = evt.str[26]  -- "Healing Pool"
evt.map[22] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[23] = evt.str[26]  -- "Healing Pool"
evt.map[23] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[24] = evt.str[26]  -- "Healing Pool"
evt.map[24] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[25] = evt.str[26]  -- "Healing Pool"
evt.map[25] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[26] = evt.str[49]  -- "Books"
evt.hint[27] = evt.str[49]  -- "Books"
evt.map[28] = function()
	evt.Set("MapVar3", 1)
end

evt.hint[29] = evt.str[24]  -- "Switch"
evt.map[29] = function()
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
end

evt.hint[30] = evt.str[22]  -- "Picture Door"
evt.map[30] = function()
	if evt.Cmp("CurrentMight", 20) then
		evt.SetDoorState{Id = 35, State = 1}
		evt.SetDoorState{Id = 36, State = 1}
	else
		evt.StatusText(12)         -- "Door won't budge."
	end
end

evt.hint[31] = evt.str[9]  -- "Flame Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -9617, Y = -10847, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9555, Y = -10500, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -9717, Y = -10947, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -9227, Y = -10652, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -9327, Y = -10552, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -9127, Y = -10752, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -10253, Y = -10463, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -10353, Y = -10563, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -10153, Y = -10363, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -9836, Y = -9356, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -9936, Y = -9456, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -9736, Y = -9256, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -10016, Y = -8382, Z = 460}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -11016, Y = -8482, Z = 460}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -9016, Y = -8282, Z = 460}
end

evt.hint[32] = evt.str[24]  -- "Switch"
evt.map[33] = function()
	evt.MoveToMap{X = -9344, Y = -192, Z = 8034, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[35] = evt.str[28]  -- "Control Room Entry"
evt.map[35] = function()
	evt.SetDoorState{Id = 39, State = 1}
	evt.SetDoorState{Id = 40, State = 1}
end

evt.hint[41] = evt.str[29]  -- "Chest"
evt.hint[42] = evt.str[29]  -- "Chest"
evt.hint[43] = evt.str[29]  -- "Chest"
evt.hint[44] = evt.str[29]  -- "Chest"
evt.hint[45] = evt.str[29]  -- "Chest"
evt.hint[46] = evt.str[5]  -- "Plaque"
evt.hint[47] = evt.str[5]  -- "Plaque"
evt.hint[48] = evt.str[5]  -- "Plaque"
evt.hint[49] = evt.str[29]  -- "Chest"
evt.map[51] = function()
	evt.Set("MapVar0", 0)
end

evt.hint[52] = evt.str[5]  -- "Plaque"
evt.hint[53] = evt.str[5]  -- "Plaque"
evt.hint[54] = evt.str[5]  -- "Plaque"
evt.hint[55] = evt.str[5]  -- "Plaque"
evt.map[56] = function()  -- RefillTimer(<function>, const.Week, true)
	evt.Set("MapVar0", 0)
end

RefillTimer(evt.map[56].last, const.Week, true)

evt.map[57] = function()
	evt.Set("MapVar3", 0)
end

evt.hint[60] = evt.str[51]  -- "Bookcase"
evt.hint[61] = evt.str[51]  -- "Bookcase"
evt.hint[62] = evt.str[51]  -- "Bookcase"
evt.hint[63] = evt.str[51]  -- "Bookcase"
evt.hint[64] = evt.str[51]  -- "Bookcase"
evt.hint[65] = evt.str[51]  -- "Bookcase"
evt.hint[66] = evt.str[51]  -- "Bookcase"
evt.hint[67] = evt.str[51]  -- "Bookcase"
evt.hint[68] = evt.str[51]  -- "Bookcase"
evt.hint[69] = evt.str[51]  -- "Bookcase"
evt.hint[70] = evt.str[51]  -- "Bookcase"
evt.hint[71] = evt.str[51]  -- "Bookcase"
evt.hint[72] = evt.str[52]  -- "Tapestry"
evt.hint[73] = evt.str[52]  -- "Tapestry"
evt.hint[100] = evt.str[2]  -- "To the Land that Time Forgot"
evt.map[100] = function()
	evt.MoveToMap{X = -1905, Y = 20660, Z = 161, Direction = 1488, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutA3.Odm"}
end

evt.hint[101] = evt.str[1]  -- "Guiding Light"
evt.map[101] = function()
	evt.MoveToMap{X = -4949, Y = 326, Z = 94, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[102] = evt.str[2]  -- "To the Land that Time Forgot"
evt.map[102] = function()
	evt.MoveToMap{X = -5504, Y = -7977, Z = -481, Direction = 248, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[103] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 412) then         -- Quaddah onc
		evt.Add("QBits", 412)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 1371, Y = 2517, Z = 1919}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = 1372, Y = 2519, Z = 1919}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 1371, Y = 5282, Z = 1628}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 1369, Y = 5278, Z = 1628}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = 1980, Y = 4847, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = 1880, Y = 4747, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 2080, Y = 4947, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 1980, Y = 3435, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 2080, Y = 3535, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 2180, Y = 3635, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 1980, Y = 2249, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 1970, Y = 2249, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 1960, Y = 2249, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 1980, Y = -1897, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 2080, Y = -1797, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = 2180, Y = -1997, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = -151, Y = -2664, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -251, Y = -2564, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = -7940, Y = -9281, Z = 1543}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -9820, Y = 6751, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -9720, Y = 6651, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -9620, Y = 6561, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -9820, Y = 4819, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -9920, Y = 4919, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -10020, Y = 5019, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = -17506, Y = 5569, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -17606, Y = 5469, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -17539, Y = 6529, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17439, Y = 6629, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -17563, Y = -1640, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -17463, Y = -1740, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -17663, Y = -1540, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = -17504, Y = -8638, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -17604, Y = -8638, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -17404, Y = -8638, Z = 811}
	end
end

events.LoadMap = evt.map[103].last

