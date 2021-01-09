local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Guano Rock",
	[5] = "You've Rescued a child!  How patriarchal of you",
	[6] = "This Rock is covered in bat guano",
	[7] = "You harvest the guano and put it in your pouch",
	[8] = "You pick up some guano, but have nowhere to put it.",
	[9] = "Cage",
	[10] = "You open the cage and remove the bones.",
	[11] = "Teleporter",
	[12] = "Underwald",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[12]  -- "Underwald"

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
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[11] = evt.str[11]  -- "Teleporter"
evt.map[11] = function()
	evt.MoveToMap{X = 247, Y = 2331, Z = -740, Direction = 1088, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[12] = function()
	evt.OpenChest(1)
end

evt.map[14] = function()
	if not evt.Cmp("QBits", 443) then         -- Underwald Special Once
		evt.Set("QBits", 443)         -- Underwald Special Once
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = 3350, Y = 6328, Z = -1234}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 3305, Y = 6481, Z = -1227}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 2942, Y = 6113, Z = -1211}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 3282, Y = 5171, Z = -1080}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 2587, Y = 4985, Z = -1080}
	end
end

evt.hint[16] = evt.str[9]  -- "Cage"
evt.map[16] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.GiveItem{Strength = 1, Type = const.ItemType.Ring_, Id = 0}
	end
end

evt.hint[17] = evt.str[9]  -- "Cage"
evt.map[17] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.GiveItem{Strength = 1, Type = const.ItemType.Amulet_, Id = 0}
	end
end

evt.hint[18] = evt.str[9]  -- "Cage"
evt.map[18] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
	end
end

evt.hint[19] = evt.str[9]  -- "Cage"
evt.map[19] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.GiveItem{Strength = 2, Type = const.ItemType.Ring_, Id = 0}
	end
end

evt.hint[20] = evt.str[9]  -- "Cage"
evt.map[20] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.GiveItem{Strength = 2, Type = const.ItemType.Amulet_, Id = 0}
	end
end

evt.hint[21] = evt.str[9]  -- "Cage"
evt.map[21] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
	end
end

evt.hint[22] = evt.str[9]  -- "Cage"
evt.map[22] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.Set("MapVar6", 1)
		evt.GiveItem{Strength = 2, Type = const.ItemType.Scroll_, Id = 0}
		evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 8, FromX = 7808, FromY = 8960, FromZ = -1768, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	end
end

evt.hint[23] = evt.str[9]  -- "Cage"
evt.map[23] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.Set("MapVar7", 1)
		evt.GiveItem{Strength = 2, Type = const.ItemType.Scroll_, Id = 0}
		evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 8, FromX = 7808, FromY = 8960, FromZ = -1768, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	end
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.StatusText(5)         -- "You've Rescued a child!  How patriarchal of you"
end

evt.hint[26] = evt.str[3]  -- "Chest"
evt.map[26] = function()
	if not evt.Cmp("MapVar1", 1) then
		if evt.Cmp("QBits", 34) then         -- 34 D02, given when temple of Baa relic is found
			evt.OpenChest(4)
			return
		end
		evt.Set("MapVar1", 1)
	end
	evt.OpenChest(2)
	evt.Set("QBits", 34)         -- 34 D02, given when temple of Baa relic is found
end

evt.hint[27] = evt.str[3]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(3)
end

evt.hint[28] = evt.str[3]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(5)
end

evt.hint[29] = evt.str[3]  -- "Chest"
evt.map[29] = function()
	evt.OpenChest(6)
end

evt.map[30] = function()  -- Timer(<function>, 5*const.Minute)
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 10, FromX = 11040, FromY = 6384, FromZ = -176, ToX = 11040, ToY = 6384, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 10, FromX = 11040, FromY = 6384, FromZ = -192, ToX = 15033, ToY = 5785, ToZ = -256}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 10, FromX = 11040, FromY = 6384, FromZ = -200, ToX = 11188, ToY = 4279, ToZ = -256}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 10, FromX = 11040, FromY = 6485, FromZ = -369, ToX = 7967, ToY = 6446, ToZ = -256}         -- "Sparks"
end

Timer(evt.map[30].last, 5*const.Minute)

evt.hint[31] = evt.str[11]  -- "Teleporter"
evt.map[31] = function()
	evt.MoveToMap{X = 16519, Y = -18589, Z = 753, Direction = 1024, LookAngle = 50, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[35] = function()
	if not evt.Cmp("MapVar29", 1) then
		evt.Set("MapVar29", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Ring_, Id = 0}
	end
end

evt.hint[50] = evt.str[2]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 15585, Y = 11125, Z = 97, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutE3.odm"}
end

evt.map[60] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 444) then         -- Underwald Once
		evt.Set("QBits", 444)         -- Underwald Once
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 11177, Y = 5872, Z = -432}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 729, Y = 2612, Z = -740}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = 11372, Y = 6295, Z = -432}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -10644, Y = -5944, Z = -1234}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 10473, Y = 6854, Z = -432}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 7, X = 183, Y = 2476, Z = -432}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 7, X = -10640, Y = -5950, Z = -1234}
			end
		end
	end
end

events.LoadMap = evt.map[60].last

