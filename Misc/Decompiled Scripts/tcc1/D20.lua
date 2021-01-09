local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
	[3] = "Barrel",
	[4] = "Lair of Koschei",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[4]  -- "Lair of Koschei"

evt.hint[1] = evt.str[1]  -- "Chest"
evt.map[1] = function()
	evt.OpenChest(1)
end

evt.hint[2] = evt.str[1]  -- "Chest"
evt.map[2] = function()
	evt.OpenChest(2)
end

evt.hint[3] = evt.str[1]  -- "Chest"
evt.map[3] = function()
	evt.OpenChest(3)
end

evt.hint[4] = evt.str[1]  -- "Chest"
evt.map[4] = function()
	evt.OpenChest(4)
end

evt.hint[5] = evt.str[1]  -- "Chest"
evt.map[5] = function()
	evt.OpenChest(5)
end

evt.hint[6] = evt.str[1]  -- "Chest"
evt.map[6] = function()
	evt.OpenChest(6)
end

evt.hint[7] = evt.str[1]  -- "Chest"
evt.map[7] = function()
	evt.OpenChest(7)
end

evt.hint[9] = evt.str[1]  -- "Chest"
evt.map[9] = function()
	evt.OpenChest(8)
end

evt.map[10] = function()
	evt.OpenChest(9)
end

evt.hint[11] = evt.str[1]  -- "Chest"
evt.map[11] = function()
	evt.OpenChest(10)
end

evt.hint[12] = evt.str[1]  -- "Chest"
evt.map[12] = function()
	evt.OpenChest(11)
end

evt.hint[13] = evt.str[1]  -- "Chest"
evt.map[13] = function()
	evt.OpenChest(12)
end

evt.hint[14] = evt.str[1]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(13)
end

evt.hint[15] = evt.str[3]  -- "Barrel"
evt.map[15] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Sword, Id = 5}         -- "Lionheart Sword"
	end
end

evt.hint[16] = evt.str[3]  -- "Barrel"
evt.map[16] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 78}         -- "Golden Plate Armor"
	end
end

evt.hint[17] = evt.str[3]  -- "Barrel"
evt.map[17] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Sword, Id = 8}         -- "Heroic Sword"
	end
end

evt.hint[18] = evt.str[3]  -- "Barrel"
evt.map[18] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 78}         -- "Golden Plate Armor"
	end
end

evt.hint[19] = evt.str[3]  -- "Barrel"
evt.map[19] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Axe, Id = 30}         -- "Grand Poleax"
	end
end

evt.hint[20] = evt.str[3]  -- "Barrel"
evt.map[20] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.Set("MapVar5", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Spear, Id = 41}         -- "Titanic Trident"
	end
end

evt.hint[50] = evt.str[2]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -13100, Y = 2028, Z = 161, Direction = 640, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "outb2.odm"}
end

evt.map[100] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -49, Y = 222, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -49, Y = 789, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 363, Y = 641, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -733, Y = 1025, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -284, Y = 3002, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 744, Y = 4180, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 139, Y = 6463, Z = -2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 414, Y = 8399, Z = 2}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 1549, Y = 8982, Z = -2}
		evt.ForPlayer("All")
		evt.Set("Cursed", 0)
	end
end

events.LoadMap = evt.map[100].last

