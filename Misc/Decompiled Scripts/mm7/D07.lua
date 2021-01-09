local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Thunderfist Mountain",
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


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.map[7] = function()
	evt.SetDoorState{Id = 9, State = 0}
end

evt.map[151] = function()
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 11, State = 1}
end

evt.map[152] = function()
	evt.SetDoorState{Id = 10, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if evt.Cmp("Awards", 80) then         -- "Retrieved Soul Jars"
		evt.OpenChest(0)
	else
		evt.OpenChest(1)
		evt.Add("QBits", 231)         -- Lich Jar Case - I lost it
		evt.Add("QBits", 149)         -- Got Lich Jar from Thunderfist Mountain
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

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[196] = evt.str[10]  -- "Bookcase"
evt.map[196] = function()
	local i
	if evt.Cmp("MapVar49", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add("MapVar49", 1)
end

evt.hint[197] = evt.str[10]  -- "Bookcase"
evt.map[197] = function()
	local i
	if evt.Cmp("MapVar50", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		goto _14
	elseif i == 5 then
		goto _15
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_14::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_15::
	evt.Add("MapVar50", 1)
end

evt.hint[198] = evt.str[10]  -- "Bookcase"
evt.map[198] = function()
	evt.StatusText(19)         -- ""
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.ForPlayer("All")
	evt.Set("Dead", 0)
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	local i
	if not evt.Cmp("FireResBonus", 50) then
		if not evt.Cmp("FireResistance", 50) then
			evt.ForPlayer("All")
			evt.Set("Dead", 0)
			return
		end
	end
	i = Game.Rand() % 2
	if i == 1 then
		evt.ForPlayer("All")
		evt.Set("Dead", 0)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()  -- Timer(<function>, 1*const.Minute)
	local i
	i = Game.Rand() % 6
	if i == 2 or i == 3 then
		return
	elseif i == 4 then
		goto _3
	elseif i == 5 then
		goto _6
	end
	evt.CastSpell{Spell = 41, Mastery = const.GM, Skill = 15, FromX = -1536, FromY = -896, FromZ = 0, ToX = -1536, ToY = -896, ToZ = 5376}         -- "Rock Blast"
::_3::
	evt.CastSpell{Spell = 41, Mastery = const.GM, Skill = 15, FromX = -128, FromY = -704, FromZ = 0, ToX = -128, ToY = -704, ToZ = 5376}         -- "Rock Blast"
	i = Game.Rand() % 6
	if i >= 1 and i <= 4 then
		return
	elseif i == 5 then
		goto _6
	end
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 20, FromX = -128, FromY = -1216, FromZ = 0, ToX = -128, ToY = -1216, ToZ = 5376}         -- "Death Blossom"
::_6::
	evt.CastSpell{Spell = 43, Mastery = const.GM, Skill = 20, FromX = -128, FromY = -704, FromZ = 0, ToX = -128, ToY = -704, ToZ = 1576}         -- "Death Blossom"
end

Timer(evt.map[453].last, 1*const.Minute)

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()  -- Timer(<function>, 3*const.Minute)
	local i
	evt.Set("MapVar1", 1)
	i = Game.Rand() % 6
	if i == 3 then
		goto _4
	elseif i == 4 then
		goto _6
	elseif i == 5 then
		goto _8
	end
	evt.Set("MapVar1", 0)
	i = Game.Rand() % 3
	if i == 1 then
		goto _4
	elseif i == 2 then
		goto _6
	end
::_8::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 1275, FromY = -1022, FromZ = 4200, ToX = 762, ToY = -1022, ToZ = 4200}         -- "Fireball"
	do return end
::_4::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 1293, FromY = -2315, FromZ = 4200, ToX = 777, ToY = -2315, ToZ = 4200}         -- "Fireball"
	if evt.Cmp("MapVar1", 1) then
		return
	end
::_6::
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 743, FromY = -1675, FromZ = 4200, ToX = 1306, ToY = -1675, ToZ = 4200}         -- "Fireball"
	if evt.Cmp("MapVar1", 1) then
		return
	end
	goto _8
end

Timer(evt.map[454].last, 3*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[501] = function()
	evt.MoveToMap{X = -7673, Y = -7957, Z = 3201, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out10.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[502] = function()
	evt.MoveToMap{X = -14395, Y = 3771, Z = 3201, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out10.odm"}
end

evt.hint[503] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[503] = function()
	evt.MoveToMap{X = 6138, Y = 3063, Z = 2406, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out10.odm"}
end

evt.hint[504] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[504] = function()
	evt.MoveToMap{X = 11623, Y = -11083, Z = 3840, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out10.odm"}
end

evt.hint[505] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[505] = function()
	evt.MoveToMap{X = 9350, Y = -1010, Z = 1, Direction = 744, LookAngle = 0, SpeedZ = 0, HouseId = 222, Icon = 3, Name = "D35.blv"}         -- "Nighon Tunnels"
end

evt.hint[506] = evt.str[2]  -- "Leave Thunderfist Mountain"
evt.map[506] = function()
	evt.MoveToMap{X = -437, Y = -1078, Z = 1, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 220, Icon = 3, Name = "D36.blv"}         -- "Tunnels to Eeofol"
end

