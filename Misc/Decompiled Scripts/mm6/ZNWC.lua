local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Lever",
	[3] = "Shelves",
	[4] = "You found something!",
	[5] = "Nothing here",
	[6] = "Not enough gold",
	[7] = "Potions for sale",
	[8] = "Bad Food!",
	[9] = "Hic!",
	[10] = "Pantry",
	[11] = "Counter",
	[12] = "Desk",
	[13] = "New World Computing",
	[14] = "Exit",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "New World Computing"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 41, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
	evt.SetDoorState{Id = 17, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 18, State = 0}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
	evt.SetDoorState{Id = 17, State = 0}
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 1}
	evt.SetDoorState{Id = 19, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 22, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
	evt.SetDoorState{Id = 21, State = 0}
	evt.SetDoorState{Id = 23, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
	evt.SetDoorState{Id = 22, State = 0}
	evt.SetDoorState{Id = 24, State = 0}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 1}
	evt.SetDoorState{Id = 23, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[26] = evt.str[1]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 25, State = 0}
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[27] = evt.str[1]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 27, State = 1}
	evt.SetDoorState{Id = 28, State = 0}
	evt.SetDoorState{Id = 26, State = 0}
end

evt.hint[28] = evt.str[1]  -- "Door"
evt.map[28] = function()
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 27, State = 0}
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[29] = evt.str[1]  -- "Door"
evt.map[29] = function()
	evt.SetDoorState{Id = 29, State = 1}
	evt.SetDoorState{Id = 28, State = 0}
	evt.SetDoorState{Id = 30, State = 0}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 31, State = 1}
	evt.SetDoorState{Id = 30, State = 0}
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[32] = evt.str[1]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 1}
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[33] = evt.str[1]  -- "Door"
evt.map[33] = function()
	evt.SetDoorState{Id = 33, State = 1}
	evt.SetDoorState{Id = 34, State = 0}
	evt.SetDoorState{Id = 32, State = 0}
end

evt.hint[34] = evt.str[1]  -- "Door"
evt.map[34] = function()
	evt.SetDoorState{Id = 34, State = 1}
	evt.SetDoorState{Id = 38, State = 0}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[35] = evt.str[1]  -- "Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 35, State = 1}
end

evt.hint[36] = evt.str[1]  -- "Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 36, State = 1}
end

evt.hint[37] = evt.str[1]  -- "Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 37, State = 1}
end

evt.hint[38] = evt.str[1]  -- "Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 39, State = 0}
	evt.SetDoorState{Id = 34, State = 0}
end

evt.hint[39] = evt.str[1]  -- "Door"
evt.map[39] = function()
	evt.SetDoorState{Id = 39, State = 1}
end

evt.hint[40] = evt.str[1]  -- "Door"
evt.map[40] = function()
	evt.SetDoorState{Id = 40, State = 1}
	evt.SetDoorState{Id = 39, State = 0}
	evt.SetDoorState{Id = 41, State = 0}
end

evt.hint[41] = evt.str[1]  -- "Door"
evt.map[41] = function()
	evt.SetDoorState{Id = 41, State = 1}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 40, State = 0}
end

evt.hint[42] = evt.str[2]  -- "Lever"
evt.map[42] = function()
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[44] = evt.str[1]  -- "Door"
evt.map[44] = function()
	evt.SetDoorState{Id = 44, State = 1}
	evt.SetDoorState{Id = 43, State = 1}
end

evt.hint[45] = evt.str[1]  -- "Door"
evt.map[45] = function()
	evt.SetDoorState{Id = 45, State = 1}
end

evt.hint[46] = evt.str[1]  -- "Door"
evt.map[46] = function()
	evt.SetDoorState{Id = 46, State = 1}
end

evt.hint[47] = evt.str[1]  -- "Door"
evt.map[47] = function()
	evt.SetDoorState{Id = 47, State = 1}
end

evt.hint[48] = evt.str[1]  -- "Door"
evt.map[48] = function()
	evt.SetDoorState{Id = 48, State = 1}
end

evt.hint[49] = evt.str[1]  -- "Door"
evt.map[49] = function()
	evt.SetDoorState{Id = 49, State = 1}
end

evt.hint[50] = evt.str[1]  -- "Door"
evt.map[50] = function()
	evt.SetDoorState{Id = 50, State = 1}
end

evt.hint[51] = evt.str[1]  -- "Door"
evt.map[51] = function()
	evt.SetDoorState{Id = 51, State = 1}
end

evt.hint[52] = evt.str[1]  -- "Door"
evt.map[52] = function()
	evt.SetDoorState{Id = 52, State = 1}
end

evt.hint[53] = evt.str[1]  -- "Door"
evt.map[53] = function()
	evt.SetDoorState{Id = 53, State = 1}
end

evt.hint[54] = evt.str[1]  -- "Door"
evt.map[54] = function()
	evt.SetDoorState{Id = 54, State = 1}
end

evt.hint[55] = evt.str[1]  -- "Door"
evt.map[55] = function()
	evt.SetDoorState{Id = 55, State = 1}
end

evt.hint[56] = evt.str[1]  -- "Door"
evt.map[56] = function()
	evt.SetDoorState{Id = 56, State = 1}
end

evt.hint[57] = evt.str[1]  -- "Door"
evt.map[57] = function()
	evt.SetDoorState{Id = 57, State = 1}
end

evt.hint[58] = evt.str[1]  -- "Door"
evt.map[58] = function()
	evt.SetDoorState{Id = 58, State = 1}
end

evt.hint[59] = evt.str[1]  -- "Door"
evt.map[59] = function()
	evt.SetDoorState{Id = 59, State = 1}
end

evt.hint[60] = evt.str[3]  -- "Shelves"
evt.map[60] = function()
	local i
	if evt.Cmp("MapVar0", 4) then
		evt.StatusText(5)         -- "Nothing here"
	else
		evt.Add("MapVar0", 1)
		evt.StatusText(4)         -- "You found something!"
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 1)         -- "Longsword"
		elseif i == 2 then
			evt.Add("Inventory", 15)         -- "Dagger"
		elseif i == 3 then
			evt.Add("Inventory", 58)         -- "Club"
		elseif i == 4 then
			evt.Add("Inventory", 161)         -- "Phirna Root"
		elseif i == 5 then
			evt.Add("Inventory", 309)         -- "Inferno"
		else
			evt.Add("Inventory", 94)         -- "Cloth Hat"
		end
	end
end

evt.hint[61] = evt.str[7]  -- "Potions for sale"
evt.map[61] = function()
	local i
	if not evt.Cmp("Gold", 100) then
		evt.StatusText(6)         -- "Not enough gold"
	else
		evt.StatusText(4)         -- "You found something!"
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 163)         -- "Potion Bottle"
			evt.Subtract("Gold", 50)
		elseif i == 2 then
			evt.Add("Inventory", 164)         -- "Cure Wounds"
			evt.Subtract("Gold", 20)
		elseif i == 3 then
			evt.Add("Inventory", 164)         -- "Cure Wounds"
			evt.Subtract("Gold", 100)
		elseif i == 4 then
			evt.Add("Inventory", 165)         -- "Magic Potion"
			evt.Subtract("Gold", 50)
		elseif i == 5 then
			evt.Add("Inventory", 166)         -- "Energy"
			evt.Subtract("Gold", 20)
		else
			evt.Add("Inventory", 164)         -- "Cure Wounds"
			evt.Subtract("Gold", 50)
		end
	end
end

evt.hint[62] = evt.str[10]  -- "Pantry"
evt.map[62] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.Add("Food", 1)
	elseif i == 2 then
		evt.Add("Food", 2)
	elseif i == 3 then
		evt.Add("Food", 1)
	elseif i == 4 then
		evt.StatusText(8)         -- "Bad Food!"
		evt.Set("PoisonedGreen", 1)
	elseif i == 5 then
		evt.StatusText(9)         -- "Hic!"
		evt.Set("Drunk", 1)
	else
		evt.Add("Inventory", 163)         -- "Potion Bottle"
	end
end

evt.hint[63] = evt.str[11]  -- "Counter"
evt.map[63] = function()
	evt.Add("Inventory", 163)         -- "Potion Bottle"
end

evt.map[64] = function()
	local i
	if not evt.Cmp("MapVar1", 16) then
		evt.Add("MapVar1", 1)
		evt.StatusText(4)         -- "You found something!"
		i = Game.Rand() % 3
		if i == 1 then
			evt.Add("Inventory", 160)         -- "Poppysnaps"
		elseif i == 2 then
			evt.Add("Inventory", 161)         -- "Phirna Root"
		else
			evt.Add("Inventory", 162)         -- "Widoweeps Berries"
		end
	end
end

evt.map[65] = function()  -- function events.LoadMap()
	evt.SummonObject{-- ERROR: Not found
Type = 36, X = 2944, Y = 1920, Z = 1, Speed = 1000, Count = 5, RandomAngle = false}
end

events.LoadMap = evt.map[65].last

evt.hint[66] = evt.str[12]  -- "Desk"
evt.map[66] = function()
	local i
	if not evt.Cmp("MapVar3", 1) then
		evt.Add("MapVar3", 1)
		evt.StatusText(4)         -- "You found something!"
		i = Game.Rand() % 5
		if i == 1 then
			evt.Add("Inventory", 71)         -- "Chain Mail"
		elseif i == 2 then
			evt.Add("Inventory", 72)         -- "Steel Chain Mail"
		elseif i == 3 then
			evt.Add("Inventory", 73)         -- "Noble Chain Mail"
		elseif i == 4 then
			evt.Add("Inventory", 74)         -- "Royal Chain Mail"
		else
			evt.Add("Inventory", 75)         -- "Majestic Chain Mail"
		end
	end
end

evt.map[67] = function()
	evt.ForPlayer("All")
	evt.Add("Afraid", 10)
end

evt.map[68] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Afraid", 10) then
		evt.Subtract("Afraid", 10)
	end
end

evt.hint[69] = evt.str[12]  -- "Desk"
evt.map[69] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.StatusText(4)         -- "You found something!"
		evt.Add("Inventory", 117)         -- "Armored Boots"
	end
end

evt.hint[70] = evt.str[12]  -- "Desk"
evt.map[70] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.StatusText(4)         -- "You found something!"
		evt.Add("Inventory", 58)         -- "Club"
	end
end

evt.hint[71] = evt.str[12]  -- "Desk"
evt.hint[72] = evt.str[12]  -- "Desk"
evt.map[72] = function()
	if not evt.Cmp("MapVar5", 4) then
		evt.StatusText(4)         -- "You found something!"
		evt.Add("Inventory", 106)         -- "Phantom Cloak"
		evt.Add("MapVar5", 1)
	end
end

evt.hint[73] = evt.str[12]  -- "Desk"
evt.map[73] = function()
	evt.CastSpell{Spell = 83, Mastery = const.Master, Skill = 64, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Day of the Gods"
end

evt.hint[74] = evt.str[12]  -- "Desk"
evt.map[74] = function()
	if not evt.Cmp("Gold", 10000) then
		evt.Add("Gold", 500)
		evt.StatusText(4)         -- "You found something!"
	end
end

evt.hint[75] = evt.str[14]  -- "Exit"
evt.map[75] = function()
	evt.MoveToMap{X = 12808, Y = 6832, Z = 64, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB3.Odm"}
end

