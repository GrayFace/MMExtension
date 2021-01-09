local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave to tower",
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
	[19] = "",
	[20] = "",
	[21] = "The Door is Locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 24) then         -- "Rescue Alice Hargreaves from William's Tower in the Deyja Moors then talk to Sir Charles Quixote."
		evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Invisible, On = false}         -- "Group for M1"
		evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.map[5] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
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

evt.hint[376] = evt.str[1]  -- "Door"
evt.map[376] = function()
	if not evt.Cmp("QBits", 25) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		if evt.Cmp("NPCs", 54) then         -- "Alice Hargreaves"
			return
		end
		if evt.Cmp("QBits", 24) then         -- "Rescue Alice Hargreaves from William's Tower in the Deyja Moors then talk to Sir Charles Quixote."
			if evt.Cmp("Inventory", 659) then         -- "William's Tower Key"
				evt.SpeakNPC(54)         -- "Alice Hargreaves"
				return
			end
		end
	end
	evt.FaceAnimation{Player = "Current", Animation = 18}
	evt.StatusText(21)         -- "The Door is Locked"
end

evt.hint[501] = evt.str[2]  -- "Leave to tower"
evt.map[501] = function()
	evt.MoveToMap{X = -5066, Y = -19323, Z = 3073, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "out05.odm"}
end

