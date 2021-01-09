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


evt.map[3] = function()
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

evt.hint[196] = evt.str[100]  -- ""
evt.map[196] = function()
	if not evt.Cmp("QBits", 228) then         -- Dwarf Bones - I lost it
		evt.Add("Inventory", 626)         -- "Zokarr IV's Skull"
		evt.Add("QBits", 228)         -- Dwarf Bones - I lost it
	end
end

evt.hint[197] = evt.str[12]  -- ""
evt.map[197] = function()
	local i
	if evt.Cmp("MapVar14", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 688)         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- ""
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 687)         -- "Siertal-laced ore"
::_9::
	evt.Set("MapVar14", 1)
	evt.SetTexture{Facet = 2, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 689)         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar14", 1) then
		evt.SetTexture{Facet = 2, Name = "cwb1"}
	end
end

evt.hint[198] = evt.str[12]  -- ""
evt.map[198] = function()
	local i
	if evt.Cmp("MapVar15", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 688)         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- ""
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 687)         -- "Siertal-laced ore"
::_9::
	evt.Set("MapVar15", 1)
	evt.SetTexture{Facet = 3, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 689)         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 3, Name = "cwb1"}
	end
end

evt.hint[199] = evt.str[12]  -- ""
evt.map[199] = function()
	local i
	if evt.Cmp("MapVar16", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 688)         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- ""
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 687)         -- "Siertal-laced ore"
::_9::
	evt.Set("MapVar16", 1)
	evt.SetTexture{Facet = 4, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 689)         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar16", 1) then
		evt.SetTexture{Facet = 4, Name = "cwb1"}
	end
end

evt.map[451] = function()
	evt.MoveToMap{X = 1168, Y = 9584, Z = -143, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[452] = function()
	evt.MoveToMap{X = 1232, Y = 6896, Z = -384, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 7, FromX = 13891, FromY = 229, FromZ = 161, ToX = 13891, ToY = 4912, ToZ = 161}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 7, FromX = 14618, FromY = 857, FromZ = 161, ToX = 9284, ToY = 857, ToZ = 161}         -- "Fireball"
end

Timer(function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 7, FromX = 13891, FromY = 229, FromZ = 161, ToX = 13891, ToY = 4912, ToZ = 161}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 7, FromX = 14618, FromY = 857, FromZ = 161, ToX = 9284, ToY = 857, ToZ = 161}         -- "Fireball"
end, 2.5*const.Minute)

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()  -- Timer(<function>, 4*const.Minute)
	evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 8, FromX = -9861, FromY = -3949, FromZ = -479, ToX = -9861, ToY = -106, ToZ = -479}         -- "Lightning Bolt"
end

Timer(evt.map[454].last, 4*const.Minute)

evt.hint[455] = evt.str[100]  -- ""
evt.map[455] = function()
	evt.CastSpell{Spell = 15, Mastery = const.GM, Skill = 4, FromX = -10624, FromY = 3456, FromZ = -639, ToX = -10624, ToY = 3456, ToZ = -639}         -- "Sparks"
end

evt.hint[456] = evt.str[100]  -- ""
evt.map[456] = function()  -- Timer(<function>, 3.5*const.Minute)
	if not evt.CheckSkill{const.Skills.DisarmTraps, Mastery = const.GM, Level = 40} then
		evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 5, FromX = 12023, FromY = 15154, FromZ = -639, ToX = 11704, ToY = 15854, ToZ = -479}         -- "Poison Spray"
		evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 5, FromX = 11398, FromY = 15726, FromZ = -639, ToX = 11673, ToY = 15051, ToZ = -479}         -- "Poison Spray"
		evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 5, FromX = 11066, FromY = 15649, FromZ = -639, ToX = 11360, ToY = 14922, ToZ = -479}         -- "Poison Spray"
		evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 5, FromX = 11179, FromY = 14849, FromZ = -639, ToX = 11047, ToY = 15637, ToZ = -479}         -- "Poison Spray"
		evt.CastSpell{Spell = 24, Mastery = const.GM, Skill = 5, FromX = 10704, FromY = 15259, FromZ = -639, ToX = 11620, ToY = 15422, ToZ = -479}         -- "Poison Spray"
	end
end

Timer(evt.map[456].last, 3.5*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Cave"
evt.map[501] = function()
	evt.MoveToMap{X = -4324, Y = 1811, Z = 3905, Direction = 172, LookAngle = 0, SpeedZ = 0, HouseId = 221, Icon = 3, Name = "D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[502] = evt.str[2]  -- "Leave the Cave"
evt.map[502] = function()
	evt.MoveToMap{X = -7766, Y = 7703, Z = -1535, Direction = 1792, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D24.blv"}
end

