local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Poisoned Spike",
	[4] = "Unstable rock",
	[5] = "Suspicious Floor",
	[6] = "Dark pit",
	[7] = "Click!",
	[8] = "Exit",
	[9] = "Switch",
	[10] = "Trap!",
	[11] = "Ca-Click!",
	[12] = "Snick!",
	[13] = "Magic Gate Open",
	[14] = "Bag",
	[15] = "Spiral Stuff (Bug if this displays).",
	[16] = "Magic Door",
	[17] = "Bag",
	[18] = "You cannot see me, hear me or touch me.  I lie behind the stars and alter what is real, I am what you really fear, Close your eyes and come I near. What am I?",
	[19] = "dark",
	[20] = "darkness",
	[21] = "Answer?  ",
	[22] = "Incorrect",
	[23] = "I go through an apple, or point out your way, I fit in a bow, then a target, to stay. What am I?",
	[24] = "arrow",
	[25] = "an arrow",
	[26] = "What consumes rocks, levels mountains, destroys wood, pushes the clouds across the sky, and can make a young one old?",
	[27] = "time",
	[28] = "Alive without breath, as cold as death, never thirsty ever drinking, all in mail never clinking, ever travelling, never walking, mouth ever moving, never talking.  What am I? ",
	[29] = "fish",
	[30] = "a fish",
	[31] = "Magical Wall",
	[32] = "Sack",
	[33] = "Empty",
	[34] = "Quedagh Curse",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[34]  -- "Quedagh Curse"
-- ERROR: Duplicate label: 20:11
-- ERROR: Duplicate label: 20:12
-- ERROR: Duplicate label: 20:13
-- ERROR: Duplicate label: 20:14
-- ERROR: Duplicate label: 20:15

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
end

evt.map[2] = function()  -- function events.LoadMap()
	evt.Set("MapVar0", 0)
	evt.Set("MapVar1", 0)
	evt.Set("MapVar2", 0)
	evt.Set("MapVar3", 0)
	evt.Set("MapVar4", 0)
	evt.Set("MapVar5", 0)
	evt.Set("MapVar6", 0)
	evt.Set("MapVar7", 0)
	evt.Set("MapVar8", 0)
	evt.Set("MapVar9", 0)
	evt.Set("MapVar10", 0)
	evt.Set("MapVar11", 0)
	evt.Set("MapVar12", 0)
	evt.Set("MapVar13", 0)
	evt.Set("MapVar14", 0)
	evt.Set("MapVar15", 0)
	evt.Set("MapVar16", 0)
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 11, State = 0}
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 61, State = 0}
	evt.SetDoorState{Id = 62, State = 0}
	evt.SetDoorState{Id = 63, State = 0}
	evt.SetDoorState{Id = 64, State = 0}
	if evt.Cmp("MapVar0", 1) then
		evt.SetTexture{Facet = 833, Name = "T3S1ON"}
	end
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 1079, Name = "mystryB"}
	end
end

events.LoadMap = evt.map[2].last

evt.hint[3] = evt.str[9]  -- "Switch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 1}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 15}
	end
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[5]  -- "Suspicious Floor"
evt.map[13] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 0)
		evt.SetTexture{Facet = 833, Name = "T3S1OFF"}
	else
		evt.Set("MapVar0", 1)
		evt.SetTexture{Facet = 833, Name = "T3S1ON"}
	end
end

evt.hint[14] = evt.str[5]  -- "Suspicious Floor"
evt.map[14] = function()
	if not evt.Cmp("QBits", 408) then         -- Quaddah onc
		evt.Add("QBits", 408)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -1003, Y = 3639, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 1, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -1483, Y = 3374, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -823, Y = 3314, Z = 1}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 1}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 1}
			end
		end
	end
end

evt.hint[15] = evt.str[5]  -- "Suspicious Floor"
evt.map[15] = function()
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1003, Y = 3639, Z = 1}
	if not evt.Cmp("QBits", 409) then         -- Quaddah onc
		evt.Add("QBits", 409)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 2, X = -1483, Y = 3374, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -823, Y = 3314, Z = 1}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 1}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 1}
			end
		end
	end
end

evt.hint[16] = evt.str[5]  -- "Suspicious Floor"
evt.map[16] = function()
	if not evt.Cmp("QBits", 410) then         -- Quaddah onc
		evt.Add("QBits", 410)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1003, Y = 3639, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1483, Y = 3374, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -823, Y = 3314, Z = 1}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 1}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 1}
			end
		end
	end
end

evt.hint[17] = evt.str[5]  -- "Suspicious Floor"
evt.map[17] = function()
	if not evt.Cmp("QBits", 411) then         -- Quaddah onc
		evt.Add("QBits", 411)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -1003, Y = 3639, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -823, Y = 3314, Z = 1}
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 0}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 0}
	end
end

evt.hint[18] = evt.str[5]  -- "Suspicious Floor"
evt.map[18] = function()
	if not evt.Cmp("QBits", 412) then         -- Quaddah onc
		evt.Add("QBits", 412)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1003, Y = 3639, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1483, Y = 3374, Z = 1}
	end
	if evt.Cmp("QBits", 508) then         -- Warrior
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 0}
		if evt.Cmp("QBits", 507) then         -- Death Wish
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 0}
		end
	end
end

evt.hint[19] = evt.str[5]  -- "Suspicious Floor"
evt.map[19] = function()
	if not evt.Cmp("QBits", 413) then         -- Quaddah onc
		evt.Add("QBits", 413)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1483, Y = 3374, Z = 1}
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 0}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 7, X = -1019, Y = 3031, Z = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 9, X = -999, Y = 4319, Z = 0}
			end
		end
	end
end

evt.hint[20] = evt.str[5]  -- "Suspicious Floor"
evt.map[20] = function()
	if not evt.Cmp("QBits", 414) then         -- Quaddah onc
		evt.Add("QBits", 414)         -- Quaddah onc
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1003, Y = 3639, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -582, Y = 3772, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -1445, Y = 3836, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1483, Y = 3374, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -823, Y = 3314, Z = 1}
	end
	if evt.Cmp("QBits", 508) then         -- Warrior
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 0}
		if evt.Cmp("QBits", 507) then         -- Death Wish
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -1019, Y = 3031, Z = 0}
			evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = -999, Y = 4319, Z = 0}
		end
	end
end

evt.hint[21] = evt.str[5]  -- "Suspicious Floor"
evt.map[21] = function()
	if evt.Cmp("QBits", 415) then         -- Quaddah onc
		if not evt.Cmp("QBits", 507) then         -- Death Wish
			return
		end
	else
		evt.Add("QBits", 415)         -- Quaddah onc
	end
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1003, Y = 3639, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -582, Y = 3772, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1445, Y = 3836, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -1483, Y = 3374, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 1, X = -823, Y = 3314, Z = 0}
end

evt.hint[22] = evt.str[5]  -- "Suspicious Floor"
evt.map[22] = function()
	if not evt.Cmp("MapVar15", 1) then
		evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -400, FromY = 3072, FromZ = 190, ToX = -1664, ToY = 4416, ToZ = 120}         -- "Flame Arrow"
		evt.CastSpell{Spell = 13, Mastery = const.Novice, Skill = 2, FromX = -8, FromY = 3456, FromZ = 120, ToX = -1664, ToY = 4416, ToZ = 120}         -- "Static Charge"
		evt.Set("MapVar13", 1)
		if evt.Cmp("MapVar14", 1) then
			evt.Set("MapVar15", 1)
			evt.StatusText(11)         -- "Ca-Click!"
		end
	end
end

evt.hint[23] = evt.str[5]  -- "Suspicious Floor"
evt.map[23] = function()
	if not evt.Cmp("MapVar15", 1) then
		evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -1776, FromY = 3072, FromZ = 120, ToX = -384, ToY = 4416, ToZ = 120}         -- "Flame Arrow"
		evt.CastSpell{Spell = 13, Mastery = const.Novice, Skill = 2, FromX = -2040, FromY = 3456, FromZ = 120, ToX = -384, ToY = 4416, ToZ = 120}         -- "Static Charge"
		evt.Set("MapVar14", 1)
		if evt.Cmp("MapVar13", 1) then
			evt.Set("MapVar15", 1)
			evt.StatusText(11)         -- "Ca-Click!"
		end
	end
end

evt.hint[24] = evt.str[5]  -- "Suspicious Floor"
evt.map[24] = function()
	evt.StatusText(13)         -- "Magic Gate Open"
	evt.Set("MapVar16", 1)
	evt.SetTexture{Facet = 1079, Name = "mystryB"}
	evt.MoveToMap{X = 2179, Y = 4314, Z = 1, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[25] = evt.str[5]  -- "Suspicious Floor"
evt.map[25] = function()
	evt.StatusText(10)         -- "Trap!"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -1024, ToY = 2816, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -1024, ToY = 4864, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = 0, ToY = 3480, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -2048, ToY = 3480, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -256, ToY = 4608, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -256, ToY = 3072, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -1792, ToY = 3072, ToZ = 120}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 3, FromX = -1024, FromY = 3840, FromZ = 120, ToX = -1792, ToY = 4608, ToZ = 120}         -- "Sparks"
	evt.Set("MapVar3", 0)
	evt.Set("MapVar6", 0)
	evt.Set("MapVar9", 0)
	evt.Set("MapVar12", 0)
	evt.Set("MapVar15", 0)
	if not evt.Cmp("QBits", 417) then         -- Quaddah once
		evt.Add("QBits", 417)         -- Quaddah once
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -1003, Y = 3639, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -1445, Y = 3836, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 3, X = -823, Y = 3314, Z = 0}
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 2, X = -999, Y = 4319, Z = 0}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -1019, Y = 3031, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 7, X = -999, Y = 4319, Z = 0}
	end
end

evt.map[26] = function()
	if evt.Cmp("MapVar16", 1) then
		evt.MoveToMap{X = 8832, Y = -4992, Z = 87, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.hint[31] = evt.str[14]  -- "Bag"
evt.map[31] = function()
	evt.OpenChest(1)
end

evt.hint[32] = evt.str[3]  -- "Poisoned Spike"
evt.map[32] = function()
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Phys, Damage = 16}
	evt.DamagePlayer{Player = "Random", DamageType = const.Damage.Phys, Damage = 11}
end

evt.hint[34] = evt.str[5]  -- "Suspicious Floor"
evt.map[34] = function()
	evt.CastSpell{Spell = 35, Mastery = const.Novice, Skill = 2, FromX = -1632, FromY = 2544, FromZ = 120, ToX = -1632, ToY = 768, ToZ = 120}         -- "Magic Arrow"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[35] = evt.str[5]  -- "Suspicious Floor"
evt.map[35] = function()
	evt.CastSpell{Spell = 35, Mastery = const.Novice, Skill = 3, FromX = 768, FromY = -1528, FromZ = 120, ToX = 768, ToY = -1280, ToZ = 120}         -- "Magic Arrow"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[36] = evt.str[4]  -- "Unstable rock"
evt.map[36] = function()
	evt.CastSpell{Spell = 41, Mastery = const.Novice, Skill = 8, FromX = 1728, FromY = 1152, FromZ = 240, ToX = 2176, ToY = 1152, ToZ = 32}         -- "Rock Blast"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[39] = evt.str[5]  -- "Suspicious Floor"
evt.map[39] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 13, FromX = 2432, FromY = 3576, FromZ = 120, ToX = 2432, ToY = 2824, ToZ = 120}         -- "Sparks"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[40] = evt.str[5]  -- "Suspicious Floor"
evt.map[40] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Expert, Skill = 10, FromX = 2056, FromY = 3200, FromZ = 120, ToX = 2800, ToY = 3200, ToZ = 120}         -- "Sparks"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[41] = evt.str[5]  -- "Suspicious Floor"
evt.map[41] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Novice, Skill = 13, FromX = 2432, FromY = 2824, FromZ = 120, ToX = 2432, ToY = 3576, ToZ = 120}         -- "Sparks"
	evt.StatusText(10)         -- "Trap!"
end

evt.hint[42] = evt.str[5]  -- "Suspicious Floor"
evt.map[42] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Expert, Skill = 10, FromX = 2800, FromY = 3200, FromZ = 120, ToX = 2056, ToY = 3200, ToZ = 120}         -- "Sparks"
	evt.StatusText(10)         -- "Trap!"
end

evt.map[43] = function()  -- Timer(<function>, 4.5*const.Minute)
	if not evt.Cmp("MapVar3", 1) then
		evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -1776, FromY = 3072, FromZ = 190, ToX = -400, ToY = 3072, ToZ = 120}         -- "Flame Arrow"
		evt.CastSpell{Spell = 2, Mastery = const.Novice, Skill = 2, FromX = -400, FromY = 3072, FromZ = 190, ToX = -1648, ToY = 3072, ToZ = 120}         -- "Flame Arrow"
	end
end

Timer(evt.map[43].last, 4.5*const.Minute)

evt.map[44] = function()  -- Timer(<function>, 4*const.Minute)
	if not evt.Cmp("MapVar6", 1) then
		evt.CastSpell{Spell = 13, Mastery = const.Novice, Skill = 2, FromX = -2040, FromY = 3456, FromZ = 120, ToX = -8, ToY = 3456, ToZ = 120}         -- "Static Charge"
		evt.CastSpell{Spell = 13, Mastery = const.Novice, Skill = 2, FromX = -8, FromY = 3456, FromZ = 120, ToX = -2040, ToY = 3456, ToZ = 120}         -- "Static Charge"
	end
end

Timer(evt.map[44].last, 4*const.Minute)

evt.map[45] = function()  -- Timer(<function>, 3.5*const.Minute)
	if not evt.Cmp("MapVar9", 1) then
		evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 2, FromX = -2040, FromY = 3840, FromZ = 120, ToX = -8, ToY = 3840, ToZ = 120}         -- "Cold Beam"
		evt.CastSpell{Spell = 24, Mastery = const.Novice, Skill = 2, FromX = -8, FromY = 3840, FromZ = 120, ToX = -2040, ToY = 3840, ToZ = 120}         -- "Cold Beam"
	end
end

Timer(evt.map[45].last, 3.5*const.Minute)

evt.map[46] = function()  -- Timer(<function>, 3*const.Minute)
	if not evt.Cmp("MapVar12", 1) then
		evt.CastSpell{Spell = 35, Mastery = const.Novice, Skill = 2, FromX = -2040, FromY = 4096, FromZ = 120, ToX = -8, ToY = 4096, ToZ = 120}         -- "Magic Arrow"
		evt.CastSpell{Spell = 35, Mastery = const.Novice, Skill = 2, FromX = -8, FromY = 4096, FromZ = 120, ToX = -2040, ToY = 4096, ToZ = 120}         -- "Magic Arrow"
	end
end

Timer(evt.map[46].last, 3*const.Minute)

evt.hint[53] = evt.str[8]  -- "Exit"
evt.map[53] = function()
	evt.MoveToMap{X = -17413, Y = -869, Z = 178, Direction = 1520, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB1.Odm"}
end

evt.hint[54] = evt.str[14]  -- "Bag"
evt.map[54] = function()
	evt.OpenChest(2)
end

evt.hint[55] = evt.str[14]  -- "Bag"
evt.map[55] = function()
	evt.OpenChest(3)
end

evt.hint[56] = evt.str[14]  -- "Bag"
evt.map[56] = function()
	evt.OpenChest(4)
end

evt.hint[57] = evt.str[14]  -- "Bag"
evt.map[57] = function()
	evt.OpenChest(5)
end

evt.hint[58] = evt.str[14]  -- "Bag"
evt.map[58] = function()
	evt.OpenChest(6)
end

evt.hint[61] = evt.str[16]  -- "Magic Door"
evt.map[61] = function()
	evt.SetMessage(18)         -- "You cannot see me, hear me or touch me.  I lie behind the stars and alter what is real, I am what you really fear, Close your eyes and come I near. What am I?"
	if evt.Question{Question = 21, Answer1 = 19, Answer2 = 20} then         -- "Answer?  " ("dark", "darkness")
		evt.SetDoorState{Id = 61, State = 1}
	else
		evt.StatusText(22)         -- "Incorrect"
	end
end

evt.hint[62] = evt.str[16]  -- "Magic Door"
evt.map[62] = function()
	evt.SetMessage(23)         -- "I go through an apple, or point out your way, I fit in a bow, then a target, to stay. What am I?"
	if evt.Question{Question = 21, Answer1 = 24, Answer2 = 25} then         -- "Answer?  " ("arrow", "an arrow")
		evt.SetDoorState{Id = 62, State = 1}
	else
		evt.StatusText(22)         -- "Incorrect"
	end
end

evt.hint[63] = evt.str[16]  -- "Magic Door"
evt.map[63] = function()
	evt.SetMessage(26)         -- "What consumes rocks, levels mountains, destroys wood, pushes the clouds across the sky, and can make a young one old?"
	if evt.Question{Question = 21, Answer1 = 27, Answer2 = 27} then         -- "Answer?  " ("time")
		evt.SetDoorState{Id = 63, State = 1}
	else
		evt.StatusText(22)         -- "Incorrect"
	end
end

evt.hint[64] = evt.str[16]  -- "Magic Door"
evt.map[64] = function()
	evt.SetMessage(28)         -- "Alive without breath, as cold as death, never thirsty ever drinking, all in mail never clinking, ever travelling, never walking, mouth ever moving, never talking.  What am I? "
	if evt.Question{Question = 21, Answer1 = 29, Answer2 = 30} then         -- "Answer?  " ("fish", "a fish")
		evt.SetDoorState{Id = 64, State = 1}
	else
		evt.StatusText(22)         -- "Incorrect"
	end
end

evt.map[65] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "d03.blv"}
	evt.Subtract("Food", 5)
end

evt.map[66] = function()
	evt.MoveToMap{X = 1408, Y = -1664, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[67] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "d06.blv"}
	evt.Subtract("Food", 5)
end

evt.map[68] = function()
	evt.MoveToMap{X = 11407, Y = 18074, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "outc2.odm"}
	evt.Subtract("Food", 5)
end

evt.hint[69] = evt.str[31]  -- "Magical Wall"
evt.hint[70] = evt.str[32]  -- "Sack"
evt.map[70] = function()
	if evt.Cmp("MapVar50", 1) then
		evt.StatusText(33)         -- "Empty"
	else
		evt.Set("MapVar50", 1)
		evt.Add("FoodAddRandom", 4)
	end
end

evt.hint[71] = evt.str[32]  -- "Sack"
evt.map[71] = function()
	if evt.Cmp("MapVar51", 1) then
		evt.StatusText(33)         -- "Empty"
	else
		evt.Set("MapVar51", 1)
		evt.Add("FoodAddRandom", 4)
	end
end

evt.hint[72] = evt.str[32]  -- "Sack"
evt.map[72] = function()
	if evt.Cmp("MapVar52", 1) then
		evt.StatusText(33)         -- "Empty"
	else
		evt.Set("MapVar52", 1)
		evt.Add("FoodAddRandom", 4)
	end
end

evt.hint[73] = evt.str[32]  -- "Sack"
evt.map[73] = function()
	if not evt.Cmp("MapVar53", 1) then
		evt.Set("MapVar53", 1)
		evt.Add("FoodAddRandom", 3)
	end
end

evt.hint[74] = evt.str[17]  -- "Bag"
evt.map[74] = function()
	evt.OpenChest(7)
end

evt.hint[75] = evt.str[17]  -- "Bag"
evt.map[75] = function()
	evt.OpenChest(8)
end

evt.hint[76] = evt.str[17]  -- "Bag"
evt.map[76] = function()
	evt.OpenChest(9)
end

evt.hint[77] = evt.str[17]  -- "Bag"
evt.map[77] = function()
	evt.OpenChest(10)
end

evt.hint[78] = evt.str[17]  -- "Bag"
evt.map[78] = function()
	evt.OpenChest(11)
end

evt.hint[79] = evt.str[17]  -- "Bag"
evt.map[79] = function()
	evt.OpenChest(12)
end

evt.hint[80] = evt.str[17]  -- "Bag"
evt.map[80] = function()
	evt.StatusText(33)         -- "Empty"
end

