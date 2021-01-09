local TXT = Localize{
	[0] = " ",
	[1] = "Switch.",
	[2] = "With some muscle you move the switch down.",
	[3] = "The switch is stuck, you need someone stronger to move it.",
	[4] = "Crates.",
	[5] = "The crates are all empty.",
	[6] = "Door.",
	[7] = "You need a special key to open this door.",
	[8] = "",
	[9] = "Light red liquid filled keg.",
	[10] = "Your muscles expand as you take a drink.",
	[11] = "The liquid has lost its effectiveness.",
	[12] = "You flip the switch and hear grating off in the distance.",
	[13] = "A skeletal knight steps out of a forming mist and says -To let you pass I will need you to say a prayer over my bones found close by, when this is done you can pass-",
	[14] = "Old bones.",
	[15] = "The bones feel incredibly cold to the touch.",
	[16] = "You say a prayer over the bones. ",
	[17] = "The skeletal knight appears from the mist, nods and disappears into the mist again.",
	[18] = "Something slimey moves behind this brick wall.",
	[19] = "Wall with missing bricks.",
	[20] = "You find a grey key where one of the bricks used to be.",
	[21] = "You find a silver key where one of the bricks used to be.",
	[22] = "Chest.",
	[23] = "You need a key to open this chest.",
	[24] = "A skeletal looking cleric steps out of a quick forming mist and says - I was tortured down here long ago and my bones were scattered throughout this level, I will let you pass only when you have destroyed what remains of me and return here, you will feel which bones they are when you see them...-  He fades away.",
	[25] = "You find and destroy one of the clerics bones. ",
	[26] = "The cleric appears again and nods at you -Thank you I will never forget your kindness I can rest in peace at last -  He then fades away.",
	[27] = "You get a bad feeling from the bones.",
	[28] = "Iron Maiden",
	[29] = "There's nothing but spikes in the Iron maiden.",
	[30] = "You search the Burial niche and find some gold.",
	[31] = "The bones seems to charge with electricity !!.",
	[32] = "These are really old bones...really old.",
	[33] = "You gain knowledge from these ancient bones.",
	[34] = "Long dead adventurer.",
	[35] = "You search the body and find some gold.",
	[36] = "Button",
	[37] = "A mist forms and a shadowy figure of a skeletal noblemen steps in front of you saying -The undead are restless in this tomb, before I can let you leave you must visit each one of them- the noblemen shoves you back and then vanishes.",
	[38] = "The skeletal noblemen appears from the mist, nods his head, then vanishes.",
	[39] = "Burial niche",
	[40] = "Skeleton in a cage.",
	[41] = "The skeleton grabs for you.",
	[42] = "A strange force reaches out of the wall and grabs you.",
	[43] = "The door will not budge.",
	[44] = "Sack",
	[45] = "You find some half decent food in the sack.",
	[46] = "A scrawled message on the brick reads   2=1  3=2  1=3",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[1]  -- "Switch."
evt.map[1] = function()
	evt.StatusText(2)         -- "With some muscle you move the switch down."
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[2] = evt.str[1]  -- "Switch."
evt.map[2] = function()
	evt.StatusText(2)         -- "With some muscle you move the switch down."
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[3] = evt.str[4]  -- "Crates."
evt.map[3] = function()
	evt.StatusText(5)         -- "The crates are all empty."
end

evt.hint[4] = evt.str[6]  -- "Door."
evt.map[4] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Switch."
evt.map[6] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.StatusText(12)         -- "You flip the switch and hear grating off in the distance."
		evt.SetTexture{Facet = 1392, Name = "d8s2on"}
		evt.SetDoorState{Id = 6, State = 2}         -- switch state
		evt.Add("MapVar5", 1)
	end
end

evt.hint[8] = evt.str[14]  -- "Old bones."
evt.map[8] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Elec, Damage = 10}
end

evt.hint[9] = evt.str[19]  -- "Wall with missing bricks."
evt.map[9] = function()
	evt.SetMessage(18)         -- "Something slimey moves behind this brick wall."
	evt.SimpleMessage()
	evt.Add("Afraid", 1)
end

evt.hint[10] = evt.str[19]  -- "Wall with missing bricks."
evt.map[10] = function()
	evt.StatusText(18)         -- "Something slimey moves behind this brick wall."
	evt.Add("Afraid", 2)
end

evt.hint[11] = evt.str[19]  -- "Wall with missing bricks."
evt.map[11] = function()
	evt.StatusText(18)         -- "Something slimey moves behind this brick wall."
	evt.Add("Afraid", 2)
end

evt.hint[12] = evt.str[22]  -- "Chest."
evt.map[12] = function()
	evt.OpenChest(0)
end

evt.hint[13] = evt.str[22]  -- "Chest."
evt.map[13] = function()
	evt.OpenChest(1)
end

evt.map[14] = function()
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[19] = evt.str[14]  -- "Old bones."
evt.map[19] = function()
	evt.StatusText(27)         -- "You get a bad feeling from the bones."
	evt.ForPlayer("Random")
	evt.Add("Cursed", 1)
end

evt.hint[20] = evt.str[28]  -- "Iron Maiden"
evt.map[20] = function()
	evt.StatusText(29)         -- "There's nothing but spikes in the Iron maiden."
end

evt.hint[21] = evt.str[36]  -- "Button"
evt.map[21] = function()
	if evt.Cmp("MapVar19", 2) then
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
	else
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetDoorState{Id = 11, State = 0}
		evt.SetDoorState{Id = 9, State = 1}
		evt.Set("MapVar19", 0)
		evt.Set("MapVar18", 0)
		evt.Add("MapVar16", 1)
	end
end

evt.hint[22] = evt.str[36]  -- "Button"
evt.map[22] = function()
	if not evt.Cmp("MapVar16", 1) then
		if not evt.Cmp("MapVar18", 1) then
			evt.Add("MapVar19", 1)
			evt.SetDoorState{Id = 10, State = 1}
			return
		end
	end
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 10, State = 1}
	evt.SetDoorState{Id = 11, State = 0}
	evt.Set("MapVar16", 0)
	evt.Set("MapVar18", 0)
end

evt.hint[23] = evt.str[36]  -- "Button"
evt.map[23] = function()
	if evt.Cmp("MapVar19", 1) then
		evt.Add("MapVar19", 1)
		evt.SetDoorState{Id = 11, State = 1}
	else
		evt.SetDoorState{Id = 9, State = 0}
		evt.SetDoorState{Id = 10, State = 0}
		evt.SetDoorState{Id = 11, State = 1}
		evt.Add("MapVar18", 1)
		evt.Set("MapVar19", 0)
		evt.Set("MapVar16", 0)
	end
end

evt.hint[25] = evt.str[39]  -- "Burial niche"
evt.map[25] = function()
	local i
	if evt.Cmp("MapVar22", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar22", 1)
end

evt.hint[26] = evt.str[39]  -- "Burial niche"
evt.map[26] = function()
	local i
	if evt.Cmp("MapVar23", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.SimpleMessage()
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar23", 1)
end

evt.hint[27] = evt.str[39]  -- "Burial niche"
evt.map[27] = function()
	local i
	if evt.Cmp("MapVar24", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar24", 1)
end

evt.hint[28] = evt.str[39]  -- "Burial niche"
evt.map[28] = function()
	local i
	if evt.Cmp("MapVar25", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 800)
	end
	evt.Add("MapVar25", 1)
end

evt.hint[29] = evt.str[39]  -- "Burial niche"
evt.map[29] = function()
	local i
	if evt.Cmp("MapVar26", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar26", 1)
end

evt.hint[30] = evt.str[39]  -- "Burial niche"
evt.map[30] = function()
	local i
	if evt.Cmp("MapVar27", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar27", 1)
end

evt.hint[31] = evt.str[39]  -- "Burial niche"
evt.map[31] = function()
	local i
	if evt.Cmp("MapVar28", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 300)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar28", 1)
end

evt.hint[32] = evt.str[39]  -- "Burial niche"
evt.map[32] = function()
	local i
	if evt.Cmp("MapVar29", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 500)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 900)
	end
	evt.Add("MapVar29", 1)
end

evt.hint[33] = evt.str[39]  -- "Burial niche"
evt.map[33] = function()
	local i
	if evt.Cmp("MapVar30", 1) then
		return
	end
	i = Game.Rand() % 4
	if i == 1 then
		evt.StatusText(30)         -- "You search the Burial niche and find some gold."
		evt.Add("GoldAddRandom", 400)
	elseif i == 2 then
		evt.StatusText(31)         -- "The bones seems to charge with electricity !!."
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 10}
	elseif i == 3 then
		evt.StatusText(32)         -- "These are really old bones...really old."
		evt.Add("AgeBonus", 5)
	else
		evt.StatusText(33)         -- "You gain knowledge from these ancient bones."
		evt.Add("Experience", 400)
	end
	evt.Add("MapVar30", 1)
end

evt.hint[34] = evt.str[34]  -- "Long dead adventurer."
evt.map[34] = function()
	if not evt.Cmp("MapVar31", 1) then
		evt.StatusText(35)         -- "You search the body and find some gold."
		evt.Add("GoldAddRandom", 300)
		evt.Add("MapVar31", 1)
	end
end

evt.hint[35] = evt.str[40]  -- "Skeleton in a cage."
evt.map[35] = function()
	evt.StatusText(41)         -- "The skeleton grabs for you."
	evt.Add("Afraid", 1)
end

evt.map[37] = function()
	evt.StatusText(42)         -- "A strange force reaches out of the wall and grabs you."
	evt.MoveToMap{X = 12416, Y = 3200, Z = -2304, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[38] = evt.str[6]  -- "Door."
evt.map[38] = function()
	evt.StatusText(43)         -- "The door will not budge."
	evt.SimpleMessage()
end

evt.hint[39] = evt.str[44]  -- "Sack"
evt.map[39] = function()
	if not evt.Cmp("MapVar39", 1) then
		evt.StatusText(45)         -- "You find some half decent food in the sack."
		evt.Add("Food", 5)
		evt.Add("MapVar39", 1)
	end
end

evt.hint[40] = evt.str[44]  -- "Sack"
evt.map[40] = function()
	if not evt.Cmp("MapVar40", 1) then
		evt.StatusText(45)         -- "You find some half decent food in the sack."
		evt.Add("Food", 5)
		evt.Add("MapVar40", 1)
	end
end

evt.hint[41] = evt.str[44]  -- "Sack"
evt.map[41] = function()
	if not evt.Cmp("MapVar41", 1) then
		evt.StatusText(45)         -- "You find some half decent food in the sack."
		evt.Add("Food", 5)
		evt.Add("MapVar41", 1)
	end
end

evt.hint[42] = evt.str[6]  -- "Door."
evt.map[42] = function()
	evt.StatusText(43)         -- "The door will not budge."
end

evt.hint[43] = evt.str[6]  -- "Door."
evt.map[43] = function()
	evt.SetMessage(46)         -- "A scrawled message on the brick reads   2=1  3=2  1=3"
	evt.SimpleMessage()
end

