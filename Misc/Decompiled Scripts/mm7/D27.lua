local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Hive",
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
	[20] = "The Door is Locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[2] = function()  -- function events.LeaveMap()
	if not evt.Cmp("QBits", 105) then         -- Slayed Xenofex
		if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
			evt.Set("QBits", 105)         -- Slayed Xenofex
			evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"family reunion\" "}
			evt.Add("History25", 0)
		end
	end
end

events.LeaveMap = evt.map[2].last

evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.map[4] = function()
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = false}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.map[6] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.map[7] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.map[8] = function()
	if evt.Cmp("MapVar0", 3) then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
	end
end

evt.map[9] = function()
	if not evt.Cmp("MapVar0", 3) then
		evt.SetDoorState{Id = 15, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
	end
end

evt.map[10] = function()
	if evt.Cmp("MapVar0", 3) then
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
	end
end

evt.map[11] = function()
	if evt.Cmp("MapVar0", 3) then
		evt.SetDoorState{Id = 17, State = 2}         -- switch state
		evt.SetLight{Id = 1, On = false}
		evt.SetFacetBit{Id = 3, Bit = const.FacetBits.Untouchable, On = true}
	else
		evt.SetDoorState{Id = 17, State = 2}         -- switch state
		evt.Add("MapVar0", 1)
	end
end

evt.map[12] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.map[13] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
	evt.SetDoorState{Id = 21, State = 2}         -- switch state
end

evt.map[14] = function()
	evt.SetDoorState{Id = 22, State = 2}         -- switch state
	evt.SetDoorState{Id = 23, State = 2}         -- switch state
end

evt.map[15] = function()
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
end

evt.map[16] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
end

evt.map[17] = function()
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
end

evt.map[18] = function()
	if evt.Cmp("MapVar1", 2) then
		evt.SetDoorState{Id = 30, State = 2}         -- switch state
		evt.SetDoorState{Id = 31, State = 2}         -- switch state
	end
end

evt.map[21] = function()
	if evt.Cmp("Inventory", 287) then         -- "_potion/reagent287"
		evt.SetDoorState{Id = 32, State = 2}         -- switch state
		evt.SetDoorState{Id = 33, State = 2}         -- switch state
	end
end

evt.map[19] = function()
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
	evt.SetDoorState{Id = 35, State = 2}         -- switch state
	evt.SetDoorState{Id = 36, State = 2}         -- switch state
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
end

evt.map[20] = function()
	evt.SetDoorState{Id = 37, State = 2}         -- switch state
	evt.SetDoorState{Id = 38, State = 2}         -- switch state
	evt.SetDoorState{Id = 39, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 1}
	evt.SetDoorState{Id = 31, State = 1}
end

evt.map[23] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 40, State = 2}         -- switch state
		evt.Add("MapVar1", 1)
		evt.Add("MapVar2", 1)
	end
end

evt.map[24] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.SetDoorState{Id = 41, State = 2}         -- switch state
		evt.Add("MapVar1", 1)
		evt.Add("MapVar3", 1)
	end
end

evt.map[25] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.map[26] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[27] = evt.str[100]  -- ""
evt.map[27] = function()
	evt.SetDoorState{Id = 42, State = 2}         -- switch state
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

evt.hint[376] = evt.str[100]  -- ""
evt.map[376] = function()
	if not evt.Cmp("QBits", 240) then         -- Talked to Roland
		evt.SpeakNPC(287)         -- "Roland Ironfist"
		evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
		evt.Add("Inventory", 661)         -- "Colony Zod Key"
		evt.Add("QBits", 240)         -- Talked to Roland
		evt.Add("History24", 0)
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 240) then         -- Talked to Roland
		evt.SetSprite{SpriteId = 20, Visible = 1, Name = "dec05"}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = true}
	end
end

evt.hint[377] = evt.str[1]  -- "Door"
evt.map[377] = function()
	if evt.Cmp("Inventory", 661) then         -- "Colony Zod Key"
		evt.Subtract("Inventory", 661)         -- "Colony Zod Key"
		evt.SetDoorState{Id = 32, State = 0}
		evt.SetDoorState{Id = 33, State = 0}
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
		evt.StatusText(20)         -- "The Door is Locked"
	end
end

evt.hint[501] = evt.str[2]  -- "Leave the Hive"
evt.map[501] = function()
	evt.MoveToMap{X = -18246, Y = -11910, Z = 3201, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out12.odm"}
end

