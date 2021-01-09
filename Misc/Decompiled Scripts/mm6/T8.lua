local TXT = Localize{
	[0] = " ",
	[1] = "Switch",
	[2] = "Chest",
	[3] = "Chest",
	[4] = "Exit",
	[5] = "You easily defeat the lock.",
	[6] = "A teleporter!",
	[7] = "You are unable to pick the lock.",
	[8] = "-50 Speed Temporary",
	[9] = "Cage",
	[10] = "Temple of the Snake",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[10]  -- "Temple of the Snake"

evt.hint[1] = evt.str[1]  -- "Switch"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetTexture{Facet = 635, Name = "t1swbu"}
	evt.Set("MapVar2", 1)
end

evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Switch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.Set("MapVar1", 1)
	evt.SetTexture{Facet = 643, Name = "t1swbu"}
	evt.SetTexture{Facet = 639, Name = "t1swbu"}
end

evt.hint[4] = evt.str[1]  -- "Switch"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
	evt.SetTexture{Facet = 647, Name = "t1swbu"}
	evt.Set("MapVar3", 1)
end

evt.map[5] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetTexture{Facet = 635, Name = "t1swbd"}
	evt.Set("MapVar4", 1)
end

evt.hint[6] = evt.str[2]  -- "Chest"
evt.map[6] = function()
	evt.OpenChest(1)
end

evt.hint[7] = evt.str[3]  -- "Chest"
evt.map[7] = function()
	evt.OpenChest(2)
end

evt.hint[8] = evt.str[3]  -- "Chest"
evt.map[8] = function()
	evt.OpenChest(3)
end

evt.hint[9] = evt.str[3]  -- "Chest"
evt.map[9] = function()
	evt.OpenChest(4)
end

evt.hint[10] = evt.str[3]  -- "Chest"
evt.map[10] = function()
	evt.OpenChest(5)
end

evt.hint[11] = evt.str[2]  -- "Chest"
evt.map[11] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 200}
		evt.Set("MapVar5", 1)
	end
	evt.OpenChest(6)
end

evt.hint[12] = evt.str[2]  -- "Chest"
evt.map[12] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 200}
		evt.Set("MapVar6", 1)
	end
	evt.OpenChest(7)
end

evt.hint[13] = evt.str[3]  -- "Chest"
evt.map[13] = function()
	evt.OpenChest(8)
end

evt.hint[14] = evt.str[3]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(9)
end

evt.map[16] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Fire, Damage = 40}
end

evt.map[17] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Magic, Damage = 40}
end

evt.map[18] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Magic, Damage = 50}
end

evt.map[19] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Elec, Damage = 50}
end

evt.map[20] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Fire, Damage = 50}
end

evt.map[21] = function()
	evt.StatusText(6)         -- "A teleporter!"
	evt.MoveToMap{X = 3264, Y = -1336, Z = 513, Direction = 192, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[22] = function()  -- Timer(<function>, 2.5*const.Minute)
	if evt.Cmp("MapVar1", 1) then
		evt.SetTexture{Facet = 643, Name = "t1swbd"}
		evt.SetTexture{Facet = 639, Name = "t1swbd"}
	end
end

Timer(evt.map[22].last, 2.5*const.Minute)

evt.map[23] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar2", 1) then
		evt.SetTexture{Facet = 635, Name = "t1swbu"}
	end
	if evt.Cmp("MapVar3", 1) then
		evt.SetTexture{Facet = 647, Name = "t1swbu"}
	end
	if evt.Cmp("MapVar4", 1) then
		evt.SetTexture{Facet = 635, Name = "t1swbd"}
	end
end

events.LoadMap = evt.map[23].last

evt.map[24] = function()  -- Timer(<function>, 2.5*const.Minute)
	if not evt.Cmp("MapVar3", 1) then
		evt.CastSpell{Spell = 32, Mastery = const.Novice, Skill = 7, FromX = -3306, FromY = -1285, FromZ = 640, ToX = -2000, ToY = -1285, ToZ = 640}         -- "Ice Blast"
	end
end

Timer(evt.map[24].last, 2.5*const.Minute)

evt.hint[25] = evt.str[9]  -- "Cage"
evt.map[25] = function()
	if not evt.Cmp("QBits", 203) then         -- NPC
		evt.Set("QBits", 203)         -- NPC
		evt.SpeakNPC(108)         -- "Emmanuel Cravitz"
		evt.Set("NPCs", 108)         -- "Emmanuel Cravitz"
	end
end

evt.hint[50] = evt.str[4]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 9230, Y = 7102, Z = 64, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB2.Odm"}
end

