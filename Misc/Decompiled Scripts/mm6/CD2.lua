local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Sign",
	[5] = "Door ",
	[6] = "There is a hissing sound coming from the wall",
	[7] = "The crimson embers will lead the way",
	[8] = "Lever",
	[9] = "The way has been cleared",
	[10] = "The fires of the dead shall burn forever",
	[11] = "Podium",
	[12] = "The Book is destroyed",
	[13] = "The Book of Liches is destroyed",
	[14] = "Crystal",
	[15] = "Forcefield",
	[16] = "Your way is blocked.",
	[17] = "Castle Darkmoor",
	[18] = "Sarcophagus",
	[19] = "How Clever!  +20 Skill points",
	[20] = "Steal from the dead?",
	[21] = "Steal (Yes/No)?",
	[22] = "Yes",
	[23] = "Y",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[17]  -- "Castle Darkmoor"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
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
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[3]  -- "Chest"
evt.map[10] = function()
	evt.OpenChest(0)
end

evt.map[2] = function()
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 10, FromX = 13819, FromY = -866, FromZ = -180, ToX = 0, ToY = 0, ToZ = 0}         -- "Toxic Cloud"
end

evt.map[3] = function()
	evt.CastSpell{Spell = 32, Mastery = const.Novice, Skill = 8, FromX = 11136, FromY = 3712, FromZ = -80, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Blast"
end

evt.map[19] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 10, FromX = 10417, FromY = 4800, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 10, FromX = 10706, FromY = 2258, FromZ = 150, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 10, FromX = 10706, FromY = 1628, FromZ = 150, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 10, FromX = 9978, FromY = 1914, FromZ = 150, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.hint[20] = evt.str[5]  -- "Door "
evt.map[20] = function()
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 1, FromX = 14925, FromY = 2518, FromZ = -689, ToX = 0, ToY = 0, ToZ = 0}         -- "Toxic Cloud"
end

evt.map[21] = function()
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15217, FromY = 576, FromZ = 528, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15112, FromY = 171, FromZ = 529, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15123, FromY = 405, FromZ = 529, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
end

evt.map[22] = function()
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15217, FromY = 576, FromZ = 528, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15112, FromY = 171, FromZ = 529, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
	evt.CastSpell{Spell = 28, Mastery = const.Novice, Skill = 1, FromX = 15123, FromY = 405, FromZ = 529, ToX = 0, ToY = 0, ToZ = 0}         -- "Ice Bolt"
end

evt.map[23] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 14718, FromY = 2456, FromZ = 541, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.map[24] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18915, FromY = 2035, FromZ = 541, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.map[25] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18111, FromY = 10127, FromZ = 386, ToX = 18111, ToY = 4782, ToZ = 386}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18131, FromY = 10127, FromZ = 386, ToX = 18131, ToY = 4782, ToZ = 386}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18151, FromY = 10127, FromZ = 386, ToX = 18151, ToY = 4782, ToZ = 386}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18171, FromY = 10127, FromZ = 386, ToX = 18171, ToY = 4782, ToZ = 386}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18191, FromY = 10127, FromZ = 386, ToX = 18191, ToY = 4782, ToZ = 386}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 18201, FromY = 10127, FromZ = 386, ToX = 18201, ToY = 4782, ToZ = 386}         -- "Fireball"
end

evt.map[26] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -7522, Y = 14848, Z = -240}
	end
end

evt.map[27] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -2904, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -2432, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1960, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1606, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1134, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -426, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -72, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 400, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1108, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1462, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1934, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 2642, FromY = 16512, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.map[28] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.StatusText(9)         -- "The way has been cleared"
	else
		evt.MoveToMap{X = 22768, Y = 7504, Z = 1170, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[29] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.StatusText(9)         -- "The way has been cleared"
	else
		evt.MoveToMap{X = 10384, Y = 2224, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[30] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.StatusText(9)         -- "The way has been cleared"
	else
		evt.MoveToMap{X = 22768, Y = 7504, Z = 1170, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[31] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.StatusText(9)         -- "The way has been cleared"
	else
		evt.MoveToMap{X = 8608, Y = 128, Z = 630, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[32] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 10, State = 1}
		evt.StatusText(9)         -- "The way has been cleared"
	else
		evt.MoveToMap{X = 22768, Y = 7504, Z = 1170, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[33] = function()
	if evt.Cmp("MapVar1", 1) then
		if not evt.Cmp("MapVar1", 2) then
			evt.Add("MapVar1", 1)
			evt.SetFacetBit{Id = 4522, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 4575, Bit = const.FacetBits.Untouchable, On = true}
			evt.StatusText(9)         -- "The way has been cleared"
			return
		end
	end
	evt.MoveToMap{X = 2560, Y = 3856, Z = -636, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[35] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.SummonObject{Type = 2081, X = 317, Y = 14144, Z = 191, Speed = 1000, Count = 1, RandomAngle = false}         -- explosion
		evt.SummonObject{Type = 1, X = 317, Y = 14144, Z = 320, Speed = 10, Count = 1, RandomAngle = false}         -- long sword
	elseif not evt.Cmp("MapVar1", 2) then
		evt.Add("MapVar1", 1)
		evt.SetFacetBit{Id = 4522, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 4575, Bit = const.FacetBits.Untouchable, On = true}
		evt.StatusText(9)         -- "The way has been cleared"
	end
end

evt.map[36] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.SummonObject{Type = 2081, X = 551, Y = 14144, Z = 191, Speed = 1000, Count = 1, RandomAngle = false}         -- explosion
		evt.SummonObject{Type = 1, X = 551, Y = 14144, Z = 320, Speed = 10, Count = 1, RandomAngle = false}         -- long sword
	elseif not evt.Cmp("MapVar1", 2) then
		evt.Add("MapVar1", 1)
		evt.SetFacetBit{Id = 4522, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 4575, Bit = const.FacetBits.Untouchable, On = true}
		evt.StatusText(9)         -- "The way has been cleared"
	end
end

evt.map[37] = function()
	if evt.Cmp("MapVar1", 1) then
		if not evt.Cmp("MapVar1", 2) then
			evt.Add("MapVar1", 1)
			evt.SetFacetBit{Id = 4522, Bit = const.FacetBits.Untouchable, On = true}
			evt.SetFacetBit{Id = 4575, Bit = const.FacetBits.Untouchable, On = true}
			evt.StatusText(9)         -- "The way has been cleared"
			return
		end
	end
	evt.MoveToMap{X = 16080, Y = 9072, Z = -180, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[38] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 22080, Y = -2192, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -10240, Y = 12144, Z = -240, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[39] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 22080, Y = -2192, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -7328, Y = 10496, Z = 600, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[40] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 22080, Y = -2192, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -6112, Y = 10912, Z = 600, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[41] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 22080, Y = -2192, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -10240, Y = 12144, Z = -240, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[42] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.MoveToMap{X = 22080, Y = -2192, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	else
		evt.MoveToMap{X = -10240, Y = 12144, Z = -240, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[43] = function()
	evt.MoveToMap{X = 13744, Y = 640, Z = -180, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[44] = function()
	evt.MoveToMap{X = 2528, Y = 3568, Z = -635, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[45] = evt.str[4]  -- "Sign"
evt.map[45] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 0)
		evt.SetTexture{Facet = 4298, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4299, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4300, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4301, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4302, Name = "orwtrtyl"}
	else
		evt.Set("MapVar2", 1)
		evt.SetMessage(10)         -- "The fires of the dead shall burn forever"
		evt.SimpleMessage()
		evt.SetTexture{Facet = 4298, Name = "lavatyl"}
		evt.SetTexture{Facet = 4299, Name = "lavatyl"}
		evt.SetTexture{Facet = 4300, Name = "lavatyl"}
		evt.SetTexture{Facet = 4301, Name = "lavatyl"}
		evt.SetTexture{Facet = 4302, Name = "lavatyl"}
		evt.SetFacetBit{Id = 4298, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4299, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4300, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4301, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4302, Bit = const.FacetBits.IsWater, On = true}
	end
end

evt.map[46] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -2904, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -2432, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1960, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1606, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -1134, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -426, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = -72, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 400, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1108, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1462, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 1934, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
	evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 1, FromX = 2642, FromY = 11904, FromZ = 100, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
end

evt.map[47] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -6144, Y = 14720, Z = -240}
	end
end

evt.map[48] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -5120, Y = 14208, Z = -240}
	end
end

evt.map[49] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -5760, Y = 12800, Z = -240}
	end
end

evt.map[50] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -7552, Y = 12800, Z = -240}
	end
end

evt.map[51] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -7808, Y = 13056, Z = -240}
	end
end

evt.map[52] = function()
	if not evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -5376, Y = 11904, Z = -240}
	end
end

evt.hint[53] = evt.str[4]  -- "Sign"
evt.map[53] = function()
	evt.SetMessage(7)         -- "The crimson embers will lead the way"
	evt.SimpleMessage()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
end

evt.hint[54] = evt.str[8]  -- "Lever"
evt.map[54] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.Set("MapVar0", 0)
		evt.SetTexture{Facet = 4219, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4220, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4221, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4222, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4223, Name = "orwtrtyl"}
	else
		evt.Set("MapVar0", 1)
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.SetTexture{Facet = 4219, Name = "lavatyl"}
		evt.SetTexture{Facet = 4220, Name = "lavatyl"}
		evt.SetTexture{Facet = 4221, Name = "lavatyl"}
		evt.SetTexture{Facet = 4222, Name = "lavatyl"}
		evt.SetTexture{Facet = 4223, Name = "lavatyl"}
		evt.SetFacetBit{Id = 4219, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4220, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4221, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4222, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4223, Bit = const.FacetBits.IsWater, On = true}
	end
end

evt.hint[55] = evt.str[4]  -- "Sign"
evt.map[55] = function()
	evt.SetMessage(7)         -- "The crimson embers will lead the way"
	evt.SimpleMessage()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[56] = evt.str[4]  -- "Sign"
evt.map[56] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.SetDoorState{Id = 14, State = 2}         -- switch state
		evt.Set("MapVar1", 0)
		evt.SetTexture{Facet = 4265, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4266, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4267, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4269, Name = "orwtrtyl"}
		evt.SetTexture{Facet = 4269, Name = "orwtrtyl"}
	else
		evt.SetDoorState{Id = 12, State = 2}         -- switch state
		evt.Set("MapVar1", 1)
		evt.SetTexture{Facet = 4265, Name = "lavatyl"}
		evt.SetTexture{Facet = 4266, Name = "lavatyl"}
		evt.SetTexture{Facet = 4267, Name = "lavatyl"}
		evt.SetTexture{Facet = 4268, Name = "lavatyl"}
		evt.SetTexture{Facet = 4269, Name = "lavatyl"}
		evt.SetFacetBit{Id = 4265, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4266, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4267, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4268, Bit = const.FacetBits.IsWater, On = true}
		evt.SetFacetBit{Id = 4269, Bit = const.FacetBits.IsWater, On = true}
	end
end

evt.hint[34] = evt.str[11]  -- "Podium"
evt.map[34] = function()
	if evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.StatusText(12)         -- "The Book is destroyed"
	else
		evt.StatusText(13)         -- "The Book of Liches is destroyed"
		evt.Add("QBits", 9)         --  9, CD2, given when you destroy Lich book
		evt.SetTexture{Facet = 4560, Name = "deskside"}
	end
end

evt.hint[57] = evt.str[14]  -- "Crystal"
evt.map[57] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 102) then         -- Oracle
		if not evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
			evt.SetSprite{SpriteId = 329, Visible = 1, Name = "crysdisc"}
			evt.ForPlayer("Random")
			evt.Add("Inventory", 552)         -- "Memory Crystal Delta"
			evt.Set("QBits", 193)         -- Quest item bits for seer
		end
	end
end

evt.map[58] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 102) then         -- Oracle
		goto _5
	end
	if evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
		goto _5
	end
::_6::
	if evt.Cmp("MapVar2", 1) then
		evt.SetTexture{Facet = 4298, Name = "lavatyl"}
		evt.SetTexture{Facet = 4299, Name = "lavatyl"}
		evt.SetTexture{Facet = 4300, Name = "lavatyl"}
		evt.SetTexture{Facet = 4301, Name = "lavatyl"}
		evt.SetTexture{Facet = 4302, Name = "lavatyl"}
	end
	if evt.Cmp("MapVar0", 1) then
		evt.SetTexture{Facet = 4219, Name = "lavatyl"}
		evt.SetTexture{Facet = 4220, Name = "lavatyl"}
		evt.SetTexture{Facet = 4221, Name = "lavatyl"}
		evt.SetTexture{Facet = 4222, Name = "lavatyl"}
		evt.SetTexture{Facet = 4223, Name = "lavatyl"}
	end
	if evt.Cmp("MapVar1", 1) then
		evt.SetTexture{Facet = 4265, Name = "lavatyl"}
		evt.SetTexture{Facet = 4266, Name = "lavatyl"}
		evt.SetTexture{Facet = 4267, Name = "lavatyl"}
		evt.SetTexture{Facet = 4268, Name = "lavatyl"}
		evt.SetTexture{Facet = 4269, Name = "lavatyl"}
	end
	if evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SetTexture{Facet = 4560, Name = "deskside"}
	end
	if evt.Cmp("MapVar1", 1) then
		evt.SetFacetBit{Id = 4522, Bit = const.FacetBits.Untouchable, On = true}
		evt.SetFacetBit{Id = 4575, Bit = const.FacetBits.Untouchable, On = true}
	end
	do return end
::_5::
	evt.SetSprite{SpriteId = 329, Visible = 1, Name = "crysdisc"}
	goto _6
end

events.LoadMap = evt.map[58].last

evt.hint[59] = evt.str[15]  -- "Forcefield"
evt.map[59] = function()
	evt.StatusText(16)         -- "Your way is blocked."
end

evt.map[60] = function()
	evt.MoveToMap{X = -17281, Y = 17465, Z = 2081, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC3.Odm"}
end

evt.hint[61] = evt.str[18]  -- "Sarcophagus"
evt.map[61] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.SetMessage(20)         -- "Steal from the dead?"
		if evt.Question{Question = 21, Answer1 = 22, Answer2 = 23} then         -- "Steal (Yes/No)?" ("Yes", "Y")
			evt.Set("MapVar9", 1)
			evt.GiveItem{Strength = 6, Type = const.ItemType.Helm_, Id = 0}
			evt.Subtract("ReputationIs", 200)
		end
	end
end

evt.hint[62] = evt.str[18]  -- "Sarcophagus"
evt.map[62] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.SetMessage(20)         -- "Steal from the dead?"
		if evt.Question{Question = 21, Answer1 = 22, Answer2 = 23} then         -- "Steal (Yes/No)?" ("Yes", "Y")
			evt.Set("MapVar10", 1)
			evt.GiveItem{Strength = 6, Type = const.ItemType.Boots_, Id = 0}
			evt.Subtract("ReputationIs", 200)
		end
	end
end

evt.hint[63] = evt.str[18]  -- "Sarcophagus"
evt.map[63] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.SetMessage(20)         -- "Steal from the dead?"
		if evt.Question{Question = 21, Answer1 = 22, Answer2 = 23} then         -- "Steal (Yes/No)?" ("Yes", "Y")
			evt.Set("MapVar11", 1)
			evt.GiveItem{Strength = 6, Type = const.ItemType.Belt_, Id = 0}
			evt.Subtract("ReputationIs", 200)
		end
	end
end

evt.map[64] = function()
	if not evt.Cmp("MapVar12", 1) then
		evt.ForPlayer("Current")
		evt.Set("MapVar12", 1)
		evt.Add("SkillPoints", 20)
		evt.StatusText(19)         -- "How Clever!  +20 Skill points"
	end
end

