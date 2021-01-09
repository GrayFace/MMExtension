local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Cave",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
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


evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 247) then         -- Control Cube only once
		evt.SetMonsterItem{Monster = 0, Item = 675, Has = true}         -- "Control Cube"
		evt.SetMonsterItem{Monster = 0, Item = 64, Has = true}         -- "Blaster"
		evt.SetMonsterItem{Monster = 1, Item = 675, Has = true}         -- "Control Cube"
		evt.SetMonsterItem{Monster = 1, Item = 64, Has = true}         -- "Blaster"
		evt.Set("QBits", 247)         -- Control Cube only once
	end
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		evt.Set("QBits", 118)         -- Killed Good MM3 Person
	elseif evt.CheckMonstersKilled{CheckType = 3, Id = 1, Count = 0} then
		evt.Set("QBits", 119)         -- Killed Evil MM3 Person
	end
	evt.Add("QBits", 234)         -- Control Cube - I lost it
end

evt.hint[176] = evt.str[1]  -- "Door"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[1]  -- "Door"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[1]  -- "Door"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[1]  -- "Door"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[1]  -- "Door"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[1]  -- "Door"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[1]  -- "Door"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[1]  -- "Door"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[1]  -- "Door"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[1]  -- "Door"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[1]  -- "Door"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[1]  -- "Door"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[1]  -- "Door"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[1]  -- "Door"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[1]  -- "Door"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[1]  -- "Door"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[1]  -- "Door"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[1]  -- "Door"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[1]  -- "Door"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[1]  -- "Door"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.map[501] = function()
	evt.MoveToMap{X = 5648, Y = 12374, Z = 33, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D25.blv"}
end

evt.map[502] = function()
	evt.MoveToMap{X = -7745, Y = -6673, Z = 65, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D26.blv"}
end

