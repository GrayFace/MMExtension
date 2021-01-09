local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Watchtower 6",
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
	if evt.Cmp("QBits", 20) then         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
		evt.SetDoorState{Id = 13, State = 1}
		evt.SetDoorState{Id = 12, State = 1}
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.map[4] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.map[151] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.map[152] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
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

evt.map[376] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 20)         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
	evt.SetDoorState{Id = 13, State = 1}
	evt.SetDoorState{Id = 12, State = 1}
end

evt.map[451] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		evt.SetDoorState{Id = 5, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 2 then
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 3 then
		evt.SetDoorState{Id = 7, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 4 then
		evt.SetDoorState{Id = 8, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	elseif i == 5 then
		evt.SetDoorState{Id = 5, State = 0}
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
		evt.SetDoorState{Id = 6, State = 0}
		evt.SetDoorState{Id = 7, State = 0}
		evt.SetDoorState{Id = 8, State = 0}
	else
		evt.SetDoorState{Id = 5, State = 1}
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	end
	evt.Set("MapVar1", 1)
	i = Game.Rand() % 6
	if i == 1 or i == 2 then
		return
	elseif i == 3 then
		goto _27
	elseif i == 4 then
		goto _29
	elseif i == 5 then
		goto _31
	end
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -3584, FromY = 9984, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp("MapVar1", 1) then
		return
	end
::_27::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 2560, FromY = 4096, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp("MapVar1", 1) then
		return
	end
::_29::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 2816, FromY = 9984, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
	if evt.Cmp("MapVar1", 1) then
		return
	end
::_31::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -3584, FromY = 4352, FromZ = 2721, ToX = -376, ToY = 7228, ToZ = 2721}         -- "Fireball"
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.SpeakNPC(274)         -- "Guard"
		evt.Set("MapVar4", 1)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	evt.Set("MapVar4", 0)
end

evt.hint[455] = evt.str[100]  -- ""
evt.map[455] = function()  -- function events.LoadMap()
	if not evt.Cmp("MapVar4", 2) then
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return
		end
		evt.Set("MapVar4", 2)
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[455].last

evt.hint[501] = evt.str[2]  -- "Leave Watchtower 6"
evt.map[501] = function()
	evt.MoveToMap{X = -16449, Y = -18181, Z = 6401, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out05.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Watchtower 6"
evt.map[502] = function()
	evt.MoveToMap{X = -20388, Y = -17503, Z = 4193, Direction = 1828, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "out05.odm"}
end

