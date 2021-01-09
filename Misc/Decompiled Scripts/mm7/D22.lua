local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Hall Under the Hill",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "Well",
	[12] = "Drink from the Well",
	[13] = "Refreshing !",
	[14] = "You Successfully disarm the trap",
	[15] = "The Door is Locked",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "",
	[31] = "",
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
	[49] = "",
	[50] = "",
	[51] = "",
	[52] = "",
	[53] = "",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "Fruit Tree",
	[61] = "You received an apple",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
end

evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.map[152] = function()
	evt.MoveToMap{X = -1383, Y = 2328, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.SetDoorState{Id = 1, State = 0}
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

evt.hint[196] = evt.str[11]  -- "Well"
evt.hint[197] = evt.str[12]  -- "Drink from the Well"
evt.map[197] = function()
	evt.StatusText(13)         -- "Refreshing !"
end

evt.hint[316] = evt.str[100]  -- ""
evt.map[316] = function()
	if not evt.Cmp("QBits", 37) then         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
		if not evt.Cmp("QBits", 179) then         -- "Take the sealed letter to the Faerie King in the Hall under the Hill in Avlee."
			return
		end
	end
	evt.SpeakNPC(52)         -- "Faerie King"
end

evt.map[451] = function()
	evt.MoveToMap{X = 1233, Y = -34, Z = -1023, Direction = -1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[452] = function()
	evt.MoveToMap{X = -1210, Y = 194, Z = -2047, Direction = -1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[453] = function()
	if evt.Cmp("Inventory", 662) then         -- "Faerie Key"
		evt.SetDoorState{Id = 10, State = 1}
		evt.SetDoorState{Id = 11, State = 1}
		evt.SetDoorState{Id = 12, State = 1}
		evt.SetDoorState{Id = 13, State = 1}
		evt.SetDoorState{Id = 14, State = 1}
		evt.SetDoorState{Id = 15, State = 1}
		evt.SetDoorState{Id = 16, State = 1}
		evt.SetDoorState{Id = 20, State = 1}
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
		evt.StatusText(15)         -- "The Door is Locked"
	end
end

evt.hint[454] = evt.str[60]  -- "Fruit Tree"
evt.map[454] = function()
	if not evt.Cmp("MapVar50", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar50", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
	end
end

evt.hint[455] = evt.str[60]  -- "Fruit Tree"
evt.map[455] = function()
	if not evt.Cmp("MapVar51", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar51", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
	end
end

evt.hint[456] = evt.str[60]  -- "Fruit Tree"
evt.map[456] = function()
	if not evt.Cmp("MapVar52", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar52", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
	end
end

evt.hint[457] = evt.str[60]  -- "Fruit Tree"
evt.map[457] = function()
	if not evt.Cmp("MapVar53", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar53", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
	end
end

evt.hint[458] = evt.str[60]  -- "Fruit Tree"
evt.map[458] = function()
	if not evt.Cmp("MapVar54", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar54", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
	end
end

evt.hint[459] = evt.str[60]  -- "Fruit Tree"
evt.map[459] = function()
	if not evt.Cmp("MapVar55", 1) then
		evt.Add("Inventory", 630)         -- "Red Apple"
		evt.Set("MapVar55", 1)
		evt.StatusText(61)         -- "You received an apple"
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree37"}
	end
end

evt.hint[460] = evt.str[100]  -- ""
evt.map[460] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar50", 1) then
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 51, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar51", 1) then
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar52", 1) then
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar53", 1) then
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar54", 1) then
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree37"}
	else
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "tree38"}
	end
	if evt.Cmp("MapVar55", 1) then
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree"}
	else
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "tree38"}
	end
end

events.LoadMap = evt.map[460].last

evt.hint[501] = evt.str[2]  -- "Leave the Hall Under the Hill"
evt.map[501] = function()
	evt.MoveToMap{X = 1550, Y = 21117, Z = 800, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "Out14.odm"}
end

