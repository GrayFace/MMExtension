local TXT = Localize{
	[0] = " ",
	[1] = "The mine shakes and shifts around you.",
	[2] = "Looks like an earthquake hit this mine.",
	[3] = "Water filled barrel.",
	[4] = "Sack filled with mining equipment.",
	[5] = "Mine",
	[6] = "This room looks really unstable.",
	[7] = "Switch",
	[8] = "As you pull the lever rocks fall from above.",
	[9] = "You mine the gold with no problem.",
	[10] = "Some loose debris overhead falls on you.",
	[11] = "The vein dried up.",
	[12] = "You were fast enough to dodge the bigger rocks.",
	[13] = "Even though the water is dirty it still refreshes.",
	[14] = "The dirty water leaves a bad taste in your mouth.",
	[15] = "The doors seem stuck.",
	[16] = "The switch is locked in place.",
	[17] = "Boulders.",
	[18] = "This cave-in blocks any further access into the mine.",
	[19] = "Small rocks and debris fall from above. ",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()  -- function events.LoadMap()
	evt.StatusText(2)         -- "Looks like an earthquake hit this mine."
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()  -- Timer(<function>, 20*const.Minute)
	evt.StatusText(1)         -- "The mine shakes and shifts around you."
	evt.FaceExpression{Player = "Random", Frame = 14}
end

Timer(evt.map[2].last, 20*const.Minute)

evt.hint[3] = evt.str[3]  -- "Water filled barrel."
evt.map[3] = function()
	if evt.Cmp("MapVar0", 6) then
		evt.StatusText(14)         -- "The dirty water leaves a bad taste in your mouth."
	else
		evt.StatusText(13)         -- "Even though the water is dirty it still refreshes."
		evt.Add("HP", 2)
		evt.Add("MapVar0", 1)
	end
end

evt.hint[4] = evt.str[3]  -- "Water filled barrel."
evt.map[4] = function()
	if evt.Cmp("MapVar1", 6) then
		evt.StatusText(14)         -- "The dirty water leaves a bad taste in your mouth."
	else
		evt.StatusText(13)         -- "Even though the water is dirty it still refreshes."
		evt.Add("HP", 2)
		evt.Add("MapVar1", 1)
	end
end

evt.hint[5] = evt.str[2]  -- "Looks like an earthquake hit this mine."
evt.map[5] = function()
	evt.StatusText(15)         -- "The doors seem stuck."
end

evt.hint[6] = evt.str[7]  -- "Switch"
evt.map[6] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(16)         -- "The switch is locked in place."
	else
		evt.StatusText(8)         -- "As you pull the lever rocks fall from above."
		evt.SetDoorState{Id = 2, State = 1}
		evt.SetDoorState{Id = 1, State = 1}
		if evt.Cmp("SpeedBonus", 25) then
			evt.StatusText(12)         -- "You were fast enough to dodge the bigger rocks."
			evt.FaceExpression{Player = "All", Frame = 33}
		else
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 15}
			evt.Set("MapVar2", 1)
		end
	end
end

evt.hint[7] = evt.str[5]  -- "Mine"
evt.map[7] = function()
	local i
	if evt.Cmp("MapVar3", 4) then
		evt.SetTexture{Facet = 166, Name = "d3ll6"}
		evt.StatusText(11)         -- "The vein dried up."
		return
	end
	i = Game.Rand() % 2
	if i == 1 then
		evt.StatusText(9)         -- "You mine the gold with no problem."
		evt.Add("GoldAddRandom", 350)
	else
		evt.StatusText(10)         -- "Some loose debris overhead falls on you."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 18}
	end
	evt.Add("MapVar3", 1)
end

evt.hint[8] = evt.str[5]  -- "Mine"
evt.map[8] = function()
	local i
	if evt.Cmp("MapVar4", 4) then
		evt.SetTexture{Facet = 54, Name = "d3ll6"}
		evt.StatusText(11)         -- "The vein dried up."
		return
	end
	i = Game.Rand() % 2
	if i == 1 then
		evt.StatusText(9)         -- "You mine the gold with no problem."
		evt.Add("GoldAddRandom", 350)
	else
		evt.StatusText(10)         -- "Some loose debris overhead falls on you."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 18}
	end
	evt.Add("MapVar4", 1)
end

evt.hint[9] = evt.str[5]  -- "Mine"
evt.map[9] = function()
	local i
	if evt.Cmp("MapVar5", 4) then
		evt.SetTexture{Facet = 164, Name = "d3ll6"}
		evt.StatusText(11)         -- "The vein dried up."
		return
	end
	i = Game.Rand() % 2
	if i == 1 then
		evt.StatusText(9)         -- "You mine the gold with no problem."
		evt.Add("GoldAddRandom", 350)
	else
		evt.StatusText(10)         -- "Some loose debris overhead falls on you."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 18}
	end
	evt.Add("MapVar5", 1)
end

evt.hint[10] = evt.str[17]  -- "Boulders."
evt.map[10] = function()
	evt.StatusText(18)         -- "This cave-in blocks any further access into the mine."
end

evt.map[11] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.StatusText(19)         -- "Small rocks and debris fall from above. "
		evt.FaceExpression{Player = "All", Frame = 31}
		evt.Add("MapVar6", 1)
		if evt.Cmp("SpeedBonus", 25) then
			evt.StatusText(12)         -- "You were fast enough to dodge the bigger rocks."
			evt.FaceExpression{Player = "All", Frame = 33}
		else
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 8}
		end
	end
end

evt.map[12] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.StatusText(19)         -- "Small rocks and debris fall from above. "
		evt.FaceExpression{Player = "All", Frame = 31}
		evt.Add("MapVar7", 1)
		if evt.Cmp("SpeedBonus", 25) then
			evt.StatusText(12)         -- "You were fast enough to dodge the bigger rocks."
			evt.FaceExpression{Player = "All", Frame = 33}
		else
			evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 8}
		end
	end
end

