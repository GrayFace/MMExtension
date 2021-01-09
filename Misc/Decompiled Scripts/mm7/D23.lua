local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Lincoln",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "Power Restored",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "You must all be wearing your wetsuits to exit the ship",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

-- ERROR: Duplicate label: 153:0

evt.map[1] = function()  -- function events.LoadMap()
	evt.Set("MapVar0", 2)
	evt.Set("MapVar1", 2)
	evt.SetLight{Id = 1, On = false}
	evt.SetLight{Id = 2, On = false}
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetDoorState{Id = 11, State = 0}
	end
end

evt.map[4] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.SetDoorState{Id = 11, State = 1}
	end
end

evt.map[6] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 12, State = 0}
		evt.SetDoorState{Id = 13, State = 0}
	end
end

evt.map[7] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 12, State = 1}
		evt.SetDoorState{Id = 13, State = 1}
	end
end

evt.map[8] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 15, State = 2}         -- switch state
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
	end
end

evt.map[9] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 15, State = 1}
		evt.SetDoorState{Id = 16, State = 1}
	end
end

evt.map[10] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 19, State = 0}
		evt.SetDoorState{Id = 20, State = 0}
	end
end

evt.map[11] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 23, State = 0}
	end
end

evt.map[12] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 23, State = 1}
	end
end

evt.map[13] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 24, State = 0}
		evt.SetDoorState{Id = 25, State = 0}
	end
end

evt.map[14] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 24, State = 1}
		evt.SetDoorState{Id = 25, State = 1}
	end
end

evt.map[15] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 26, State = 0}
	end
end

evt.map[16] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 26, State = 1}
	end
end

evt.map[17] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 27, State = 0}
	end
end

evt.map[18] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 28, State = 1}
		evt.SetDoorState{Id = 37, State = 1}
		evt.SetDoorState{Id = 27, State = 0}
	end
end

evt.map[19] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 28, State = 0}
	end
end

evt.map[20] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 27, State = 1}
		evt.SetDoorState{Id = 37, State = 0}
		evt.SetDoorState{Id = 28, State = 0}
	end
end

evt.map[21] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 29, State = 0}
		evt.SetDoorState{Id = 30, State = 0}
	end
end

evt.map[22] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 29, State = 1}
		evt.SetDoorState{Id = 30, State = 1}
	end
end

evt.map[23] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 31, State = 0}
		evt.SetDoorState{Id = 32, State = 0}
	end
end

evt.map[24] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 31, State = 1}
		evt.SetDoorState{Id = 32, State = 1}
	end
end

evt.map[25] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 33, State = 0}
		evt.SetDoorState{Id = 34, State = 0}
	end
end

evt.map[26] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 33, State = 1}
		evt.SetDoorState{Id = 34, State = 1}
	end
end

evt.map[27] = function()
	evt.SetDoorState{Id = 35, State = 0}
	evt.SetDoorState{Id = 36, State = 0}
end

evt.map[28] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 35, State = 1}
		evt.SetDoorState{Id = 36, State = 1}
	end
end

evt.map[29] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 37, State = 2}         -- switch state
	end
end

evt.map[30] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 39, State = 0}
		evt.SetDoorState{Id = 40, State = 0}
	end
end

evt.map[31] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 39, State = 1}
		evt.SetDoorState{Id = 40, State = 1}
	end
end

evt.map[32] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 45, State = 0}
		evt.SetDoorState{Id = 46, State = 0}
	end
end

evt.map[33] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 45, State = 1}
		evt.SetDoorState{Id = 46, State = 1}
	end
end

evt.map[34] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 48, State = 0}
		evt.SetDoorState{Id = 49, State = 0}
		evt.SetDoorState{Id = 47, State = 1}
	end
end

evt.map[35] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 49, State = 1}
	end
end

evt.map[36] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 51, State = 0}
	end
end

evt.map[37] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 51, State = 0}
	end
end

evt.map[38] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 59, State = 0}
	end
end

evt.map[39] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 59, State = 1}
	end
end

evt.map[40] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 60, State = 0}
	end
end

evt.map[41] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 60, State = 1}
	end
end

evt.map[42] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 61, State = 0}
		evt.SetDoorState{Id = 62, State = 0}
	end
end

evt.map[43] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 61, State = 1}
		evt.SetDoorState{Id = 62, State = 1}
	end
end

evt.map[44] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 63, State = 0}
		evt.SetDoorState{Id = 64, State = 0}
	end
end

evt.map[45] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 63, State = 1}
		evt.SetDoorState{Id = 64, State = 1}
	end
end

evt.map[46] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 65, State = 0}
		evt.SetDoorState{Id = 66, State = 0}
	end
end

evt.map[47] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 65, State = 1}
		evt.SetDoorState{Id = 66, State = 1}
	end
end

evt.map[49] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 67, State = 0}
		evt.SetDoorState{Id = 68, State = 0}
	end
end

evt.map[50] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 67, State = 1}
		evt.SetDoorState{Id = 68, State = 1}
	end
end

evt.map[51] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 73, State = 0}
		evt.SetDoorState{Id = 74, State = 0}
	end
end

evt.map[52] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 75, State = 0}
		evt.SetDoorState{Id = 76, State = 0}
	end
end

evt.map[53] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 69, State = 0}
		evt.SetDoorState{Id = 70, State = 0}
	end
end

evt.map[54] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 71, State = 0}
		evt.SetDoorState{Id = 72, State = 0}
	end
end

evt.map[55] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 69, State = 1}
		evt.SetDoorState{Id = 70, State = 1}
		evt.SetDoorState{Id = 73, State = 1}
		evt.SetDoorState{Id = 74, State = 1}
	end
end

evt.map[56] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 71, State = 1}
		evt.SetDoorState{Id = 72, State = 1}
		evt.SetDoorState{Id = 75, State = 1}
		evt.SetDoorState{Id = 76, State = 1}
	end
end

evt.map[151] = function()
	if evt.Cmp("MapVar2", 1) then
		if evt.Cmp("MapVar0", 2) then
			evt.SetDoorState{Id = 9, State = 1}
			evt.SetDoorState{Id = 38, State = 1}
			evt.Set("MapVar0", 1)
		else
			evt.SetDoorState{Id = 9, State = 0}
			evt.SetDoorState{Id = 38, State = 0}
			evt.Set("MapVar0", 2)
		end
	end
end

evt.map[152] = function()
	evt.SetDoorState{Id = 17, State = 2}         -- switch state
end

evt.map[153] = function()
	evt.SetDoorState{Id = 18, State = 2}         -- switch state
end

evt.map[154] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 48, State = 1}
		evt.SetDoorState{Id = 49, State = 1}
	end
end

evt.map[155] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 50, State = 1}
		evt.SetDoorState{Id = 51, State = 1}
	end
end

evt.map[156] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 50, State = 0}
		evt.SetDoorState{Id = 26, State = 1}
	end
end

evt.map[157] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 77, State = 0}
	end
end

evt.map[158] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 78, State = 0}
	end
end

evt.map[159] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 79, State = 0}
	end
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
	if not evt.Cmp("QBits", 121) then         -- Got the sci-fi part
		if not evt.Cmp("MapVar2", 1) then
			return
		end
		if not evt.Cmp("Inventory", 605) then         -- "Oscillation Overthruster"
			evt.Add("Inventory", 605)         -- "Oscillation Overthruster"
			evt.Set("QBits", 121)         -- Got the sci-fi part
			evt.Add("QBits", 236)         -- Final Part - I lost it
			evt.SetDoorState{Id = 80, State = 1}
			evt.Set("MapVar3", 1)
		end
	end
	evt.SetLight{Id = 1, On = false}
	evt.SetLight{Id = 2, On = true}
end

evt.map[451] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 1, State = 2}         -- switch state
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
	end
end

evt.map[452] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 2, State = 2}         -- switch state
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
	end
end

evt.map[453] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 3, State = 2}         -- switch state
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
	end
end

evt.map[454] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 4, State = 2}         -- switch state
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
	end
end

evt.map[455] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
	end
end

evt.map[456] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 44, State = 2}         -- switch state
	end
end

evt.map[457] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 7165, Y = -1629, Z = 1037, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[458] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 1536, Y = -1909, Z = 1037, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[459] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 52, State = 0}
	end
end

evt.map[460] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 52, State = 1}
	end
end

evt.map[461] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 53, State = 0}
	end
end

evt.map[462] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 53, State = 1}
	end
end

evt.map[463] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 54, State = 0}
	end
end

evt.map[464] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 54, State = 1}
	end
end

evt.map[465] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 55, State = 0}
	end
end

evt.map[466] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 55, State = 1}
	end
end

evt.map[467] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 56, State = 0}
	end
end

evt.map[468] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 56, State = 1}
	end
end

evt.map[469] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 57, State = 0}
	end
end

evt.map[470] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 57, State = 1}
	end
end

evt.map[471] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 58, State = 0}
	end
end

evt.map[472] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 58, State = 1}
	end
end

evt.map[473] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 50, State = 1}
		evt.SetDoorState{Id = 47, State = 0}
		evt.SetDoorState{Id = 26, State = 0}
	end
end

evt.map[474] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.SetDoorState{Id = 50, State = 0}
		evt.SetDoorState{Id = 51, State = 0}
	end
end

evt.map[475] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.SetLight{Id = 1, On = true}
		evt.SetTexture{Facet = 15, Name = "sfpnlon"}
		evt.StatusText(11)         -- "Power Restored"
	end
end

evt.map[476] = function()  -- Timer(<function>, 2*const.Minute)
	if evt.Cmp("MapVar3", 1) then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 4448, FromY = -9376, FromZ = 2272, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 2816, FromY = -8480, FromZ = 1792, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -5600, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -1888, FromZ = 320, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	end
end

Timer(evt.map[476].last, 2*const.Minute)

evt.map[477] = function()  -- Timer(<function>, 1*const.Minute)
	if evt.Cmp("MapVar3", 1) then
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 224, FromY = 1376, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 5856, FromY = -8512, FromZ = 1792, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 5600, FromY = -5664, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 4896, FromY = -3808, FromZ = 1888, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 3104, FromY = -3680, FromZ = 320, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 512, FromY = -736, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = 512, FromY = 1344, FromZ = 992, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	end
end

Timer(evt.map[477].last, 1*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Lincoln"
evt.map[501] = function()
	evt.ForPlayer(0)
	if evt.Cmp("IsWearingItem", 604) then
		evt.ForPlayer(1)
		if evt.Cmp("IsWearingItem", 604) then
			evt.ForPlayer(2)
			if evt.Cmp("IsWearingItem", 604) then
				evt.ForPlayer(3)
				if evt.Cmp("IsWearingItem", 604) then
					evt.MoveToMap{X = -7005, Y = 7856, Z = 225, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "out15.odm"}
					return
				end
			end
		end
	end
	evt.StatusText(20)         -- "You must all be wearing your wetsuits to exit the ship"
end

