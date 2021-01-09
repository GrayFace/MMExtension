local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Fort Riverstride",
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

Game.LoadSound(513)

evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("MapVar4", 2) then
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return
		end
		evt.Set("MapVar4", 2)
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 12, State = 0}
	evt.SetDoorState{Id = 13, State = 0}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 14, State = 0}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 15, State = 0}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 16, State = 0}
	evt.SetDoorState{Id = 17, State = 0}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 18, State = 0}
	evt.SetDoorState{Id = 19, State = 0}
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 22, State = 0}
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 25, State = 0}
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 26, State = 0}
	evt.SetDoorState{Id = 27, State = 0}
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 28, State = 0}
	evt.SetDoorState{Id = 29, State = 0}
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 7, FromX = -3200, FromY = -544, FromZ = -496, ToX = -3200, ToY = -544, ToZ = 0}         -- "Sparks"
	evt.SetDoorState{Id = 30, State = 0}
	evt.SetDoorState{Id = 31, State = 0}
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 32, State = 0}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 34, State = 0}
	evt.SetDoorState{Id = 35, State = 0}
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 36, State = 0}
	evt.SetDoorState{Id = 37, State = 0}
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 38, State = 0}
	evt.SetDoorState{Id = 39, State = 0}
end

evt.hint[22] = evt.str[1]  -- "Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 40, State = 0}
	evt.SetDoorState{Id = 41, State = 0}
end

evt.hint[23] = evt.str[1]  -- "Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 42, State = 0}
end

evt.hint[24] = evt.str[1]  -- "Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 43, State = 0}
	evt.SetDoorState{Id = 44, State = 0}
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 45, State = 0}
	evt.SetDoorState{Id = 46, State = 0}
end

evt.hint[26] = evt.str[1]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 47, State = 1}
	evt.SetDoorState{Id = 49, State = 1}
end

evt.hint[27] = evt.str[1]  -- "Door"
evt.map[27] = function()
	evt.SetDoorState{Id = 48, State = 1}
	evt.SetDoorState{Id = 50, State = 1}
end

evt.hint[30] = evt.str[1]  -- "Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 51, State = 0}
	evt.SetDoorState{Id = 52, State = 0}
end

evt.hint[31] = evt.str[1]  -- "Door"
evt.map[31] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[32] = evt.str[1]  -- "Door"
evt.map[32] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[176] = evt.str[6]  -- "Vault"
evt.map[176] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 94) then         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
		if not evt.Cmp("QBits", 80) then         -- Gave plans to elfking
			if not evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
				if not evt.Cmp("QBits", 92) then         -- Fort Riverstride.  Opened chest with plans
					evt.SetDoorState{Id = 60, State = 0}
					evt.SetDoorState{Id = 61, State = 2}         -- switch state
					evt.ForPlayer("All")
					evt.Set("QBits", 92)         -- Fort Riverstride.  Opened chest with plans
				end
			end
		end
	end
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(1)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(2)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(3)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(4)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(5)
end

evt.hint[182] = evt.str[7]  -- "Cabinet"
evt.map[182] = function()
	evt.OpenChest(6)
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
evt.map[183] = function()
	evt.OpenChest(7)
end

evt.hint[184] = evt.str[7]  -- "Cabinet"
evt.map[184] = function()
	evt.OpenChest(8)
end

evt.hint[185] = evt.str[7]  -- "Cabinet"
evt.map[185] = function()
	evt.OpenChest(9)
end

evt.hint[186] = evt.str[7]  -- "Cabinet"
evt.map[186] = function()
	evt.OpenChest(10)
end

evt.hint[187] = evt.str[7]  -- "Cabinet"
evt.map[187] = function()
	evt.OpenChest(11)
end

evt.hint[188] = evt.str[7]  -- "Cabinet"
evt.map[188] = function()
	evt.OpenChest(12)
end

evt.hint[189] = evt.str[7]  -- "Cabinet"
evt.map[189] = function()
	evt.OpenChest(13)
end

evt.hint[190] = evt.str[7]  -- "Cabinet"
evt.map[190] = function()
	evt.OpenChest(14)
end

evt.hint[191] = evt.str[7]  -- "Cabinet"
evt.map[191] = function()
	evt.OpenChest(15)
end

evt.hint[192] = evt.str[7]  -- "Cabinet"
evt.map[192] = function()
	evt.OpenChest(16)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(17)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(18)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(19)
end

evt.hint[196] = evt.str[3]  -- "Chest"
evt.map[196] = function()
	evt.OpenChest(0)
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 1) then
			evt.SpeakNPC(273)         -- "Guard"
			evt.Set("MapVar4", 1)
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 2) then
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			evt.Set("MapVar4", 2)
			evt.PlaySound{Id = 513, X = -2304, Y = 640}
			evt.PlaySound{Id = 513, X = 256, Y = 256}
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 0)
	end
end

evt.hint[454] = evt.str[5]  -- "Lever"
evt.map[454] = function()
	evt.SetDoorState{Id = 53, State = 2}         -- switch state
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 10, FromX = 448, FromY = 400, FromZ = -208, ToX = 448, ToY = 586, ToZ = -527}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 10, FromX = 0, FromY = 400, FromZ = -208, ToX = 0, ToY = 586, ToZ = -527}         -- "Poison Spray"
	evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 10, FromX = -448, FromY = 400, FromZ = -208, ToX = -448, ToY = 586, ToZ = -527}         -- "Poison Spray"
end

evt.hint[455] = evt.str[100]  -- ""
evt.map[455] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -1152, FromY = 1344, FromZ = -288, ToX = 1152, ToY = 1472, ToZ = -288}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 1152, FromY = 1344, FromZ = -288, ToX = -1152, ToY = 1472, ToZ = -288}         -- "Fireball"
end

evt.hint[501] = evt.str[2]  -- "Leave Fort Riverstride"
evt.map[501] = function()
	evt.MoveToMap{X = 11270, Y = -2144, Z = 1601, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out03.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Fort Riverstride"
evt.map[502] = function()
	evt.MoveToMap{X = 10531, Y = -1536, Z = 513, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out03.odm"}
end

