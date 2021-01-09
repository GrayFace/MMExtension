local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Erathian Sewer",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "",
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


evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 22, State = 1}
	evt.Set("MapVar1", 1)
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 23, State = 1}
	evt.Set("MapVar1", 1)
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
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

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
	evt.Set("MapVar1", 0)
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 2}         -- switch state
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 2}         -- switch state
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
	evt.Set("MapVar1", 0)
end

evt.map[151] = function()
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 2, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.map[152] = function()
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Invisible, On = false}
	evt.SetFacetBit{Id = 1, Bit = const.FacetBits.Untouchable, On = false}
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 0}
end

evt.map[153] = function()
	evt.MoveToMap{X = 768, Y = 10880, Z = 1, Direction = -1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[154] = function()
	evt.MoveToMap{X = 768, Y = 10400, Z = 0, Direction = -1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
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

evt.HouseDoor(376, 185)  -- "Master Thief"
evt.map[451] = function()
	evt.SetDoorState{Id = 24, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 2}         -- switch state
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
end

evt.map[452] = function()
	evt.SetDoorState{Id = 25, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
end

evt.map[453] = function()
	evt.SetDoorState{Id = 26, State = 2}         -- switch state
	evt.SetDoorState{Id = 30, State = 0}
	evt.SetDoorState{Id = 31, State = 0}
	evt.SetDoorState{Id = 32, State = 0}
	evt.SetDoorState{Id = 33, State = 0}
	evt.SetDoorState{Id = 34, State = 0}
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
	evt.SetDoorState{Id = 27, State = 0}
	evt.SetDoorState{Id = 28, State = 0}
	evt.SetDoorState{Id = 29, State = 0}
end

evt.map[454] = function()
	evt.SetDoorState{Id = 27, State = 2}         -- switch state
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.map[455] = function()
	evt.SetDoorState{Id = 28, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
end

evt.map[456] = function()
	evt.SetDoorState{Id = 29, State = 2}         -- switch state
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
end

evt.hint[457] = evt.str[100]  -- ""
evt.map[457] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 10, FromX = 5632, FromY = 4736, FromZ = 542, ToX = 5632, ToY = 12352, ToZ = 542}         -- "Blades"
	end
end

evt.hint[458] = evt.str[100]  -- ""
evt.map[458] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 10, FromX = -5632, FromY = 4736, FromZ = 542, ToX = -5632, ToY = 12352, ToZ = 542}         -- "Blades"
	end
end

evt.hint[459] = evt.str[100]  -- ""
evt.map[459] = function()
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 10, FromX = 0, FromY = 4736, FromZ = 368, ToX = 0, ToY = 5632, ToZ = 64}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 10, FromX = 0, FromY = 6528, FromZ = 368, ToX = 0, ToY = 5632, ToZ = 64}         -- "Poison Spray"
end

evt.hint[501] = evt.str[2]  -- "Leave the Erathian Sewer"
evt.map[501] = function()
	evt.MoveToMap{X = 2727, Y = -9254, Z = 164, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out03.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Erathian Sewer"
evt.map[502] = function()
	evt.MoveToMap{X = -2184, Y = 14886, Z = 25, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out03.odm"}
end

evt.hint[503] = evt.str[2]  -- "Leave the Erathian Sewer"
evt.map[503] = function()
	evt.MoveToMap{X = -18356, Y = 15481, Z = 158, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out03.odm"}
end

