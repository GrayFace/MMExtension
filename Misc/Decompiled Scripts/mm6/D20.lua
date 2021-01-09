local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
	[3] = "Barrel",
	[4] = "Caves of the Dragon Riders",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[4]  -- "Caves of the Dragon Riders"

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
	evt.MoveToMap{X = -13551, Y = 4864, Z = 161, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB1.Odm"}
end

