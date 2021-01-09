local TXT = Localize{
	[0] = " ",
	[1] = "Shard filled caskets.",
	[2] = "Barrel is filled with crystal shards (worthless).",
	[3] = "Table with implements atop.",
	[4] = "You see a scattered of refining tools and small crystal shavings.",
	[5] = "Sacks.",
	[6] = "The sacks are filled with flawed crystal shards (worthless).",
	[7] = "Crystal.",
	[8] = "You mine the crystal in its raw form (+300 gold).",
	[9] = "You refine the crystal you harvested (+200 to its value).",
	[10] = "Someone has gone to a lot of trouble carving all these murals",
	[11] = " This razor sharp crystal is too immature to harvest.",
	[12] = "You study the mural and get a good feeling inside.",
	[13] = "Carved mural.",
	[14] = "Cabinet",
	[15] = "The cabinet is filled with old and broken harvesting tools.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[1]  -- "Shard filled caskets."
evt.map[1] = function()
	evt.StatusText(2)         -- "Barrel is filled with crystal shards (worthless)."
end

evt.hint[2] = evt.str[5]  -- "Sacks."
evt.map[2] = function()
	evt.StatusText(6)         -- "The sacks are filled with flawed crystal shards (worthless)."
end

evt.hint[3] = evt.str[7]  -- "Crystal."
evt.map[3] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar0", 1)
		evt.SetSprite{SpriteId = 18, Visible = 0, Name = "0"}
	end
end

evt.hint[4] = evt.str[7]  -- "Crystal."
evt.map[4] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar1", 1)
		evt.SetSprite{SpriteId = 19, Visible = 0, Name = "0"}
	end
end

evt.hint[5] = evt.str[7]  -- "Crystal."
evt.map[5] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar2", 1)
		evt.SetSprite{SpriteId = 45, Visible = 0, Name = "0"}
	end
end

evt.hint[6] = evt.str[7]  -- "Crystal."
evt.map[6] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar3", 1)
		evt.SetSprite{SpriteId = 30, Visible = 0, Name = "0"}
	end
end

evt.hint[7] = evt.str[7]  -- "Crystal."
evt.map[7] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar4", 1)
		evt.SetSprite{SpriteId = 32, Visible = 0, Name = "0"}
	end
end

evt.hint[8] = evt.str[7]  -- "Crystal."
evt.map[8] = function()
	if not evt.Cmp("MapVar5", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar5", 1)
		evt.SetSprite{SpriteId = 31, Visible = 0, Name = "0"}
	end
end

evt.hint[9] = evt.str[7]  -- "Crystal."
evt.map[9] = function()
	if not evt.Cmp("MapVar6", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar6", 1)
		evt.SetSprite{SpriteId = 26, Visible = 0, Name = "0"}
	end
end

evt.hint[10] = evt.str[7]  -- "Crystal."
evt.map[10] = function()
	if not evt.Cmp("MapVar7", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar7", 1)
		evt.SetSprite{SpriteId = 27, Visible = 0, Name = "0"}
	end
end

evt.hint[11] = evt.str[7]  -- "Crystal."
evt.map[11] = function()
	if not evt.Cmp("MapVar8", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar8", 1)
		evt.SetSprite{SpriteId = 25, Visible = 0, Name = "0"}
	end
end

evt.hint[12] = evt.str[7]  -- "Crystal."
evt.map[12] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar9", 1)
		evt.SetSprite{SpriteId = 43, Visible = 0, Name = "0"}
	end
end

evt.hint[13] = evt.str[7]  -- "Crystal."
evt.map[13] = function()
	if not evt.Cmp("MapVar10", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar10", 1)
		evt.SetSprite{SpriteId = 22, Visible = 0, Name = "0"}
	end
end

evt.hint[19] = evt.str[7]  -- "Crystal."
evt.map[19] = function()
	if not evt.Cmp("MapVar11", 1) then
		evt.StatusText(8)         -- "You mine the crystal in its raw form (+300 gold)."
		evt.Add("Gold", 300)
		evt.Set("MapVar11", 1)
		evt.SetSprite{SpriteId = 44, Visible = 0, Name = "0"}
	end
end

evt.hint[14] = evt.str[3]  -- "Table with implements atop."
evt.map[14] = function()
	evt.Set("MapVar24", 0)
	if evt.Cmp("MapVar0", 1) then
		if not evt.Cmp("MapVar12", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar12", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar1", 1) then
		if not evt.Cmp("MapVar13", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar13", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar2", 1) then
		if not evt.Cmp("MapVar14", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar14", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar3", 1) then
		if not evt.Cmp("MapVar15", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar15", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar4", 1) then
		if not evt.Cmp("MapVar16", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar16", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar5", 1) then
		if not evt.Cmp("MapVar17", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar17", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar6", 1) then
		if not evt.Cmp("MapVar18", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar18", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar7", 1) then
		if not evt.Cmp("MapVar19", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar19", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar8", 1) then
		if not evt.Cmp("MapVar20", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar20", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar9", 1) then
		if not evt.Cmp("MapVar21", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar21", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar10", 1) then
		if not evt.Cmp("MapVar22", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 100)
			evt.Add("MapVar22", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if evt.Cmp("MapVar11", 1) then
		if not evt.Cmp("MapVar23", 1) then
			evt.SetMessage(9)         -- "You refine the crystal you harvested (+200 to its value)."
			evt.Add("Gold", 200)
			evt.Add("MapVar23", 1)
			evt.SimpleMessage()
			evt.Set("MapVar24", 1)
		end
	end
	if not evt.Cmp("MapVar24", 1) then
		evt.StatusText(4)         -- "You see a scattered of refining tools and small crystal shavings."
	end
end

evt.hint[15] = evt.str[7]  -- "Crystal."
evt.map[15] = function()
	evt.StatusText(11)         -- " This razor sharp crystal is too immature to harvest."
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Phys, Damage = 2}
end

evt.map[16] = function()
	if not evt.Cmp("MapVar25", 1) then
		evt.StatusText(10)         -- "Someone has gone to a lot of trouble carving all these murals"
		evt.Add("MapVar25", 1)
	end
end

evt.hint[17] = evt.str[13]  -- "Carved mural."
evt.map[17] = function()
	evt.StatusText(12)         -- "You study the mural and get a good feeling inside."
	evt.CastSpell{Spell = 46, Mastery = const.Expert, Skill = 1, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Bless"
end

evt.hint[18] = evt.str[14]  -- "Cabinet"
evt.map[18] = function()
	evt.StatusText(15)         -- "The cabinet is filled with old and broken harvesting tools."
end

