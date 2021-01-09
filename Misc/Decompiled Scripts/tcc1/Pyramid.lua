local TXT = Localize{
	[0] = " ",
	[1] = "How dare you approach the Sacred Fire without The Chalice!",
	[2] = "Sacred Fire",
	[3] = "",
	[4] = "",
	[5] = "Plaque",
	[6] = "The entrance to the central pyramid lies to the South.",
	[7] = "The door is locked",
	[8] = "CleansingPool",
	[9] = "Flame Door",
	[10] = "Radiation Damage!",
	[11] = "The chest is locked",
	[12] = "Door won't budge.",
	[13] = "Radiation Damage!",
	[14] = "Radiation Damage!",
	[15] = "The waters part.",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "Door",
	[20] = "",
	[21] = "",
	[22] = "Picture Door",
	[23] = "Back Door",
	[24] = "Switch",
	[25] = "Water Temple",
	[26] = "Cleansing Pool",
	[27] = "",
	[28] = "",
	[29] = "Chest",
	[30] = "Picture",
	[31] = "Exit",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "Books",
	[50] = "",
	[51] = "Bookcase",
	[52] = "Tapestry",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[50]  -- ""
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
			evt.StatusText(4)         -- ""
			evt.Add("MapVar3", 1)
		end
	end
end

Timer(evt.map[12].last, 1.5*const.Minute)

evt.hint[13] = evt.str[26]  -- "Cleansing Pool"
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
	evt.MoveToMap{X = -6647, Y = 13018, Z = 1761, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC3.Odm"}
end

evt.hint[18] = evt.str[31]  -- "Exit"
evt.map[18] = function()
	evt.MoveToMap{X = -6611, Y = 11408, Z = 480, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC3.Odm"}
end

evt.hint[19] = evt.str[30]  -- "Picture"
evt.map[20] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[21] = evt.str[26]  -- "Cleansing Pool"
evt.map[21] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[22] = evt.str[26]  -- "Cleansing Pool"
evt.map[22] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[23] = evt.str[26]  -- "Cleansing Pool"
evt.map[23] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[24] = evt.str[26]  -- "Cleansing Pool"
evt.map[24] = function()
	evt.Set("MapVar3", 0)
	evt.Set("MapVar0", 1)
end

evt.hint[25] = evt.str[26]  -- "Cleansing Pool"
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
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9617, Y = -10847, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -9555, Y = -10500, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -9717, Y = -10947, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -9227, Y = -10652, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -9327, Y = -10552, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -9127, Y = -10752, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -10253, Y = -10463, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -10353, Y = -10563, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = -10153, Y = -10363, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -9836, Y = -9356, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -9936, Y = -9456, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -9736, Y = -9256, Z = 389}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -10016, Y = -8382, Z = 460}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -11016, Y = -8482, Z = 460}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -9016, Y = -8282, Z = 460}
end

evt.hint[32] = evt.str[24]  -- "Switch"
evt.map[33] = function()
	evt.MoveToMap{X = -9344, Y = -192, Z = 8034, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[35] = evt.str[28]  -- ""
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
evt.hint[100] = evt.str[2]  -- "Sacred Fire"
evt.map[100] = function()
	evt.MoveToMap{X = -1905, Y = 20660, Z = 161, Direction = 1488, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutA3.Odm"}
end

evt.hint[101] = evt.str[1]  -- "How dare you approach the Sacred Fire without The Chalice!"
evt.map[101] = function()
	evt.MoveToMap{X = -4949, Y = 326, Z = 94, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[102] = evt.str[2]  -- "Sacred Fire"
evt.map[102] = function()
	evt.MoveToMap{X = -5504, Y = -7977, Z = -481, Direction = 248, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[103] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 413) then         -- Quaddah onc
		evt.Add("QBits", 413)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 1371, Y = 2517, Z = 1919}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 1372, Y = 2519, Z = 1919}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 1371, Y = 5282, Z = 1628}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 1369, Y = 5278, Z = 1628}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -13807, Y = 13054, Z = 1680}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -14982, Y = 13760, Z = 1680}
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
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -16192, Y = 11677, Z = 1680}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -16763, Y = 14638, Z = 1680}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -9620, Y = 6561, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -9820, Y = 4819, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -9920, Y = 4919, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -10020, Y = 5019, Z = 389}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -17506, Y = 5569, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -17606, Y = 5469, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -17539, Y = 6529, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17439, Y = 6629, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -17563, Y = -1640, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17463, Y = -1740, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = -17663, Y = -1540, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -17504, Y = -8638, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -17604, Y = -8638, Z = 811}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -17404, Y = -8638, Z = 811}
	end
end

events.LoadMap = evt.map[103].last

evt.hint[104] = evt.str[2]  -- "Sacred Fire"
evt.map[104] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 532) then         -- "Loose Page"
		evt.ForPlayer("All")
		evt.Subtract("QBits", 82)         -- "Find Tamara"
		evt.Subtract("Inventory", 532)         -- "Loose Page"
		evt.Add("Awards", 7)         -- "Destroyed the Norse Lair"
		evt.EnterHouse(600)         -- Win
	else
		evt.Set("Eradicated", 0)
	end
end

evt.map[105] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 532) then         -- "Loose Page"
		evt.Set("Eradicated", 0)
	end
end

events.LoadMap = evt.map[105].last

