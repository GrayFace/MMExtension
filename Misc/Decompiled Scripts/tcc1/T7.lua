local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Sign",
	[5] = "Scroll",
	[6] = "Expert Perception is the key and the doors of Chaos will let you be.                                                                                                                                                                                                                  The Spiral then each head, talk to Baa or you'll be dead.",
	[7] = "Chaos Idol",
	[8] = "You've defaced the idol!",
	[9] = "Chaos Idol",
	[10] = "You've defaced the idol!",
	[11] = "Chaos Idol",
	[12] = "You've defaced the idol!",
	[13] = "Chaos Idol",
	[14] = "You've defaced the idol!",
	[15] = "Chaos laughs at you!",
	[16] = "Almighty Idol of Chaos.",
	[17] = "Chaos laughs at you!",
	[18] = "You defaced the idol!  +250,000 Experience.",
	[19] = "The Idol is defaced!",
	[20] = "Book Case",
	[21] = "Podium",
	[22] = "Chest Is locked.",
	[23] = "Lava pool",
	[24] = "The Temple of Chaos",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[24]  -- "The Temple of Chaos"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.ForPlayer("Current")
	if evt.CheckSkill{const.Skills.Perception, Mastery = const.Novice, Level = 8} then
		evt.SetDoorState{Id = 1, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 2, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 3, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 4, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 5, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 6, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 7, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 8, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 9, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 10, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 11, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 12, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 13, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 14, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[15] = evt.str[1]  -- "Door"
evt.map[15] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 15, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 16, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 17, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 18, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[19] = evt.str[1]  -- "Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
	if evt.Cmp("MapVar12", 1) then
		evt.Set("MapVar14", 1)
	else
		evt.Set("MapVar8", 1)
	end
end

evt.hint[20] = evt.str[1]  -- "Door"
evt.map[20] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 20, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[21] = evt.str[1]  -- "Door"
evt.map[21] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("PerceptionSkill", 4) then
		evt.SetDoorState{Id = 21, State = 1}
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 50}
	end
end

evt.hint[27] = evt.str[3]  -- "Chest"
evt.map[27] = function()
	evt.OpenChest(1)
end

evt.hint[28] = evt.str[3]  -- "Chest"
evt.map[28] = function()
	evt.OpenChest(5)
end

evt.hint[29] = evt.str[3]  -- "Chest"
evt.map[29] = function()
	evt.OpenChest(6)
end

evt.hint[34] = evt.str[9]  -- "Chaos Idol"
evt.hint[36] = evt.str[21]  -- "Podium"
evt.map[36] = function()
	evt.SetMessage(6)         -- "Expert Perception is the key and the doors of Chaos will let you be.                                                                                                                                                                                                                  The Spiral then each head, talk to Baa or you'll be dead."
	evt.SimpleMessage()
end

evt.hint[38] = evt.str[3]  -- "Chest"
evt.map[38] = function()
	evt.OpenChest(2)
end

evt.hint[39] = evt.str[3]  -- "Chest"
evt.map[39] = function()
	if evt.Cmp("PerceptionSkill", 2) then
		evt.OpenChest(3)
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 200}
	end
end

evt.hint[40] = evt.str[3]  -- "Chest"
evt.map[40] = function()
	if evt.Cmp("MapVar19", 1) then
		goto _16
	end
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 567) then         -- "High Cleric's Key"
		if evt.Cmp("Inventory", 492) then         -- "High Sorcerer's Key"
			if evt.Cmp("QBits", 8) then         --  8 T7, given when you find the smoking gun
				evt.OpenChest(8)
				return
			end
			evt.Set("MapVar19", 1)
			goto _16
		end
		evt.StatusText(22)         -- "Chest Is locked."
	else
		evt.StatusText(22)         -- "Chest Is locked."
	end
	if not evt.Cmp("MapVar10", 1) then
		evt.Set("MapVar10", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -2240, Y = -3168, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -320, Y = -3232, Z = 0}
	end
	do return end
::_16::
	evt.OpenChest(7)
	evt.Subtract("Inventory", 567)         -- "High Cleric's Key"
	evt.Subtract("Inventory", 492)         -- "High Sorcerer's Key"
	evt.Set("QBits", 8)         --  8 T7, given when you find the smoking gun
	evt.Set("QBits", 190)         -- Quest item bits for seer
end

evt.hint[42] = evt.str[20]  -- "Book Case"
evt.map[42] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.Set("MapVar4", 1)
		evt.Add("Inventory", 388)         -- "Reanimate"
	end
end

evt.hint[45] = evt.str[3]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(4)
end

evt.map[60] = function()
	evt.MoveToMap{X = -19914, Y = -18118, Z = 65, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutA3.Odm"}
end

evt.map[61] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -6272, FromY = 6272, FromZ = 250, ToX = -6272, ToY = 6272, ToZ = 100}         -- "Sparks"
end

evt.map[62] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -6272, FromY = 6272, FromZ = 250, ToX = -6272, ToY = 6272, ToZ = 100}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -9984, FromY = 5792, FromZ = -50, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[63] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -8768, FromY = 6176, FromZ = -50, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -11552, FromY = 3904, FromZ = -50, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[64] = function()
	evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = -11552, FromY = -3648, FromZ = -125, ToX = -11712, ToY = 2656, ToZ = -126}         -- "Fireball"
end

evt.map[65] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -11488, FromY = -3616, FromZ = -50, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -11904, FromY = -7360, FromZ = -50, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[66] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -11680, FromY = -6140, FromZ = -20, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -11776, FromY = -9824, FromZ = -400, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[67] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -10560, FromY = -11872, FromZ = -520, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -8160, FromY = -11424, FromZ = -540, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[68] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -7744, FromY = -8320, FromZ = -100, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -10496, FromY = -9760, FromZ = 200, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[69] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -8800, FromY = -12864, FromZ = 250, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -5504, FromY = -11520, FromZ = 220, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.map[70] = function()
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -5344, FromY = -10240, FromZ = 250, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 3, FromX = -7232, FromY = -7008, FromZ = 230, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
end

evt.hint[74] = evt.str[7]  -- "Chaos Idol"
evt.map[74] = function()
	evt.StatusText(8)         -- "You've defaced the idol!"
	if not evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 1)
	end
end

evt.hint[72] = evt.str[9]  -- "Chaos Idol"
evt.map[72] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.StatusText(10)         -- "You've defaced the idol!"
		evt.Set("MapVar10", 1)
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 20}
		evt.StatusText(15)         -- "Chaos laughs at you!"
	end
end

evt.hint[73] = evt.str[11]  -- "Chaos Idol"
evt.map[73] = function()
	if evt.Cmp("MapVar10", 1) then
		evt.StatusText(12)         -- "You've defaced the idol!"
		evt.Set("MapVar11", 1)
	else
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 20}
		evt.StatusText(15)         -- "Chaos laughs at you!"
	end
end

evt.hint[71] = evt.str[13]  -- "Chaos Idol"
evt.map[71] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 20}
		evt.StatusText(15)         -- "Chaos laughs at you!"
	else
		evt.StatusText(14)         -- "You've defaced the idol!"
		evt.Set("MapVar12", 1)
		if evt.Cmp("MapVar8", 1) then
			evt.Set("MapVar14", 1)
		else
			evt.Set("MapVar14", 1)
		end
	end
end

evt.hint[75] = evt.str[16]  -- "Almighty Idol of Chaos."
evt.map[75] = function()
	if not evt.Cmp("MapVar14", 1) then
		evt.StatusText(17)         -- "Chaos laughs at you!"
		evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 100}
	else
		if evt.Cmp("PlayerBits", 41) then
			evt.StatusText(19)         -- "The Idol is defaced!"
		else
			evt.StatusText(18)         -- "You defaced the idol!  +250,000 Experience."
			evt.ForPlayer("All")
			evt.Subtract("QBits", 125)         -- "Deface  the Idols in the Temple of Chaos, destroy the inhabitants, and return to The Seer."
			evt.Set("Awards", 38)         -- "Defaced the Idols of Chaos"
			evt.Add("Experience", 250000)
			evt.Add("ReputationIs", 500)
			evt.Set("QBits", 446)         -- Destroyed Chaos Idols
			evt.SetNPCTopic{NPC = 9, Index = 1, Event = 32}         -- "The Seer" : "Welcome back, adventurers!"
			evt.Set("PlayerBits", 41)
			evt.ForPlayer("Current")
			evt.Add("Inventory", 466)         -- "Crystal Skull"
		end
	end
end

evt.hint[76] = evt.str[23]  -- "Lava pool"
evt.map[76] = function()
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 30}
end

