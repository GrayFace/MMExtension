local TXT = Localize{
	[0] = " ",
	[1] = "Chest",
	[2] = "Exit",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()
	if not evt.Cmp("MapVar1", 1) then
		if not evt.Cmp("MapVar0", 2) then
			if evt.Cmp("MapVar0", 1) then
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 1, FromY = 64, FromZ = 500, ToX = 0, ToY = 896, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 0, Y = 896, Z = 32}
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 0, ToY = -768, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 0, Y = -768, Z = 32}
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 576, ToY = 448, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = 576, Y = 448, Z = 32}
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = -576, ToY = -320, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -576, Y = -320, Z = 32}
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 576, ToY = -320, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = 576, Y = -320, Z = 32}
				evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = -576, ToY = 448, ToZ = 1}         -- "Fireball"
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -576, Y = 448, Z = 32}
				evt.Add("MapVar0", 1)
				evt.Set("MapVar1", 1)
			else
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 1, FromY = 64, FromZ = 500, ToX = 0, ToY = 896, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 0, Y = 896, Z = 32}
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 0, ToY = -768, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = 0, Y = -768, Z = 32}
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 576, ToY = 448, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = 576, Y = 448, Z = 32}
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = -576, ToY = -320, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -576, Y = -320, Z = 32}
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = 576, ToY = -320, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = 576, Y = -320, Z = 32}
				evt.CastSpell{Spell = 18, Mastery = const.Novice, Skill = 0, FromX = 0, FromY = 64, FromZ = 500, ToX = -576, ToY = 448, ToZ = 1}         -- "Lightning Bolt"
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 3, X = -576, Y = 448, Z = 32}
				evt.Add("MapVar0", 1)
				evt.Set("MapVar1", 1)
			end
		end
	end
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Chest"
evt.map[2] = function()
	if evt.Cmp("MapVar0", 2) then
		evt.OpenChest(2)
	else
		evt.OpenChest(1)
	end
end

evt.hint[3] = evt.str[2]  -- "Exit"
evt.map[3] = function()
	evt.Set("MapVar1", 0)
end

