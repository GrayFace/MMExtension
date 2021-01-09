local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Dwarven Barrow",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Sarcophagus",
	[10] = "Bookcase",
	[11] = "Key Hole",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 193) then         -- Turn on map in mdrXX(Dwarven Barrow)
		evt.SetDoorState{Id = 25, State = 0}
		evt.SetDoorState{Id = 26, State = 0}
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
end

evt.map[4] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[6] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if evt.Cmp("QBits", 193) then         -- Turn on map in mdrXX(Dwarven Barrow)
		evt.OpenChest(1)
	else
		evt.OpenChest(0)
	end
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[376] = evt.str[11]  -- "Key Hole"
evt.map[376] = function()
	if not evt.Cmp("QBits", 193) then         -- Turn on map in mdrXX(Dwarven Barrow)
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 657) then         -- "Barrow Key"
			evt.SetDoorState{Id = 25, State = 0}
			evt.SetDoorState{Id = 26, State = 0}
			evt.Add("QBits", 193)         -- Turn on map in mdrXX(Dwarven Barrow)
			evt.Subtract("Inventory", 657)         -- "Barrow Key"
		end
	end
end

evt.hint[451] = evt.str[5]  -- "Lever"
evt.map[451] = function()
	if evt.Cmp("MapVar0", 2) then
		evt.SetDoorState{Id = 20, State = 1}
		evt.Set("MapVar0", 1)
	else
		evt.SetDoorState{Id = 20, State = 0}
		evt.Set("MapVar0", 2)
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Dwarven Barrow"
evt.map[501] = function()
	evt.MoveToMap{X = -13827, Y = 20039, Z = 961, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out11.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Dwarven Barrow"
evt.map[502] = function()
	if evt.Cmp("MapVar0", 2) then
		evt.MoveToMap{X = -404, Y = -1041, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK05.blv"}
	else
		evt.MoveToMap{X = 407, Y = -1064, Z = 1, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK01.blv"}
	end
end

