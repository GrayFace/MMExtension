local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Temple of Baa",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Lift",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "Cleric's Totem",
	[14] = "You Successfully disarm the trap",
	[15] = "Cleric's Totem",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: Duplicate label: 4357:0

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 34, Count = 1} then
		evt.Set("QBits", 243)         -- Killed High Preist of Baa
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[15] = evt.str[13]  -- "Cleric's Totem"
evt.map[15] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 332) then         -- 1-time baa
		evt.Set("QBits", 332)         -- 1-time baa
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add(53, 20)
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch07"}
	end
end

-- ERROR: Invalid command size: 3845:0 (OpenChest)
evt.map[3845] = function()
	evt.OpenChest(1)
end

evt.hint[16] = evt.str[15]  -- "Cleric's Totem"
evt.map[16] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 333) then         -- 1-time baa
		evt.Set("QBits", 333)         -- 1-time baa
		evt.Add("MindResistance", 20)
		evt.Add("BodyResistance", 20)
		evt.Add(53, 20)
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "torch07"}
	end
	evt.Add(1280, 67108881)
end

-- ERROR: Invalid command size: 4101:0 (OpenChest)
evt.map[4101] = function()
	evt.OpenChest(16)
end

-- ERROR: Invalid command size: 16:7 (Add)
evt.hint[17] = evt.str[100]  -- ""
evt.map[17] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 332) then         -- 1-time baa
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch07"}
	end
	if evt.Cmp("QBits", 333) then         -- 1-time baa
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "torch07"}
	end
end

events.LoadMap = evt.map[17].last

-- ERROR: Invalid command size: 4357:0 (MoveToMap)
evt.map[4357] = function()
	evt.MoveToMap{X = 286262052, Y = 252512000, Z = 16777216, Direction = 1668444020, LookAngle = 3616872, SpeedZ = 134222085, HouseId = 1, Icon = 0, Name = "\5—"}         -- "The Knight's Blade"
end

-- ERROR: Invalid command size: 4357:0 (FaceExpression)
evt.hint[151] = evt.str[9]  -- "Lift"
evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
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

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.map[501] = function()
	evt.MoveToMap{X = -9306, Y = -19451, Z = 3361, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out14.odm"}
end

