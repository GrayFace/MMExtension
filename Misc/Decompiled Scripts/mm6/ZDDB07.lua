local TXT = Localize{
	[0] = " ",
	[1] = "There is a strong smell of gas pervading the air.",
	[2] = "Small glittering pool.",
	[3] = "The water cools you down.",
	[4] = "Switch.",
	[5] = "The torches Ignite and so does the swamp gas.",
	[6] = "Hundreds of snakes crawl out of the floor and bite you.",
	[7] = "Swamp gas forces you back couching and gagging.",
	[8] = "You drink the water, with no effect.",
	[9] = "The switch does not work.",
	[10] = "Hundreds of snakes crawl out of the floor and bite you. ",
	[11] = "A voice hisses -Walk the path of the snake-.",
	[12] = "A voice whispers -I am the spirit of the swamp, congratulations, take what you may and leave in peace-",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.StatusText(1)         -- "There is a strong smell of gas pervading the air."
		evt.Add("MapVar0", 1)
	end
end

evt.hint[2] = evt.str[2]  -- "Small glittering pool."
evt.map[2] = function()
	if evt.Cmp("MapVar1", 4) then
		evt.StatusText(8)         -- "You drink the water, with no effect."
	else
		evt.StatusText(3)         -- "The water cools you down."
		evt.Add("FireResBonus", 40)
		evt.Add("MapVar1", 1)
	end
end

evt.hint[3] = evt.str[4]  -- "Switch."
evt.map[3] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(9)         -- "The switch does not work."
	else
		evt.StatusText(5)         -- "The torches Ignite and so does the swamp gas."
		evt.SetTexture{Facet = 225, Name = "d8s2on"}
		evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 0, FromX = -3004, FromY = -2315, FromZ = 120, ToX = -3244, ToY = -2315, ToZ = 120}         -- "Fireball"
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 20}
		evt.SetSprite{SpriteId = 1, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 2, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 3, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 4, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 5, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 6, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 7, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 8, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 9, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 10, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 11, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 12, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 13, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 14, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 15, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 16, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 17, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 18, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 19, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 20, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 21, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 22, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 23, Visible = 1, Name = "torch01"}
		evt.SetSprite{SpriteId = 24, Visible = 1, Name = "torch01"}
		evt.Set("MapVar2", 1)
		evt.Set("MapVar3", 1)
	end
end

evt.map[5] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.StatusText(7)         -- "Swamp gas forces you back couching and gagging."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 8}
		evt.MoveToMap{X = -1328, Y = -704, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[6] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.StatusText(7)         -- "Swamp gas forces you back couching and gagging."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 8}
		evt.MoveToMap{X = -2128, Y = -1152, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[7] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.StatusText(7)         -- "Swamp gas forces you back couching and gagging."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 8}
		evt.MoveToMap{X = -1888, Y = -1600, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

evt.map[8] = function()
	evt.StatusText(6)         -- "Hundreds of snakes crawl out of the floor and bite you."
	evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 15}
end

evt.map[9] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.StatusText(11)         -- "A voice hisses -Walk the path of the snake-."
		evt.Add("MapVar4", 1)
	end
end

evt.map[10] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.SetMessage(12)         -- "A voice whispers -I am the spirit of the swamp, congratulations, take what you may and leave in peace-"
		evt.SimpleMessage()
		evt.ForPlayer("All")
		evt.Add("Experience", 750)
		evt.Add("MapVar5", 1)
	end
end

