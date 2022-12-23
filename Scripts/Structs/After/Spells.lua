local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

local GetPlayer, GetMonster = internal.GetPlayer, internal.GetMonster

local _KNOWNGLOBALS

local changeSnd

local PlaySoundHook = |t| if changeSnd then
	t.Sound = changeSnd
end

-- DoSummonObject - record all summoned objects

local grab = mem.StaticAlloc(2004)
local grabStart, grabEnd = grab + 4, grab + 2004
i4[grab] = grabEnd

HookManager{
	wreg = mmv('dx', 'ax', 'ax'),
	reg = mmv('edx', 'eax', 'eax'),
	p = grab,
	p2 = grabEnd,
}['asmhook'..mmv('',2,2)](mmv(0x42A9DD, 0x42F7A8, 0x42E226), [[
	mov ecx, [%p%]
	cmp ecx, %p2%
	jz @f
	mov [ecx], %wreg%
	add ecx, 2
	mov [%p%], ecx
@@:
]])

-- replace objType, sound etc.

local lastSpell, lastType

local DoReplace = |sp, ot| if sp and sp > 0 and ot then
	lastSpell, lastType, Game.SpellObjId[sp] = sp, Game.SpellObjId[sp], ot
else
	lastSpell = nil
end

local function ReplaceProj(sp, sp0, otype, snd)
	if sp then
		if otype == nil then
			otype = Game.SpellObjId[sp0]
		end
		if snd == nil then
			snd = Game.SpellSounds[sp0]
		end
	else
		sp = sp0
	end
	changeSnd = snd
	if snd and PlaySoundHook then
		events.InternalPlaySound, PlaySoundHook = PlaySoundHook, nil
	end
	DoReplace(lastSpell, lastType)  -- safeguard
	DoReplace(sp, otype)
	i4[grab] = grabStart
end

local function DoGrab(p, p2, sp, sk, mas)
	if p < p2 then
		local i = i2[p]
		local o = Map.Objects[i]
		if sp then
			o.Spell = sp
		end
		if sk then
			o.SpellSkill = sk
		end
		if mas then
			o.SpellMastery = mas
		end
		return o, DoGrab(p + 2, p2, sp, sk, mas)
	end
end

local function CollectProj(done, spell, skill, mas)
	changeSnd = nil
	DoReplace(lastSpell, lastType)
	lastSpell, lastType = nil
	if skill and mas == nil then
		skill, mas = SplitSkill(skill)
	end
	local p2 = done and grabStart or i4[grab]
	i4[grab] = grabEnd
	return DoGrab(grabStart, p2, spell, skill, mas)
end


-- MonsterCastSpell
local spellDir

mem.hookfunction(mmv(0x405130, 0x404AC7, 0x404D67), 2, mmv(2, 3, 3), function(d, def, monIdx, pdir, spell, action, skill)
	if spellDir then
		spellDir['?ptr'] = pdir
	else
		spellDir = structs.MissileDirection:new(pdir)
	end
	
	local t = {
		Handled = false,
		MonsterIndex = monIdx,
		-- :structs.MapMonster
		Monster = Map.Monsters[monIdx],
		-- :structs.MissileDirection
		Direction = spellDir,
		Spell = spell,
		-- [MM7+]
		Skill = skill,
		Action = action,
		ObjectType = nil,
		Sound = nil,
	}
	local done
	local function callDef(sp, sk)
		t.Handled = true
		ReplaceProj(sp, t.Spell, t.ObjectType, t.Sound)
		def(t.MonsterIndex, pdir, sp or t.Spell, t.Action, sk or t.Skill)
		return CollectProj(done, sp and t.Spell, sk and t.Skill)
	end
	t.CallDefault = callDef
	-- Can be used to change how a spell works when cast by a monster.
	-- 'Sound' and 'ObjectType' aren't assigned initially, you can set them to change what sound the spell makes and what projectiles it has.
	-- !Lua[[CallDefault(FakeSpell, FakeSkill)]] would use logic from 'FakeSpell' with 'FakeSkill', but change sound and any created projectiles to match what you've defined in the table.
	-- !\ Example:!Lua[[
	-- -- allow Poison Spray to be cast by monsters
	-- events.MonsterCastSpell = |t| if t.Spell == 24 then
	-- 	local sk, mas = SplitSkill(t.Skill)
	-- 	if mas >= const.Expert then
	-- 		t.CallDefault(15, JoinSkill(sk, mas - 1))  -- use Sparks as a template
	-- 	else
	-- 		t.CallDefault(2)  -- use Fire Bolt as a template
	-- 	end
	-- end]]
	events.cocall("MonsterCastSpell", t)
	if not t.Handled then
		done = true
		callDef()
	end
end)

-- Monster_RangedAttack

-- EventCastSpell
mem.hookfunction(mmv(0x43EAF0, 0x448E1B, 0x44622C), 2, 7, function(d, def, spell, mastery, skill, x1, y1, z1, x2, y2, z2)
	local t = {
		Handled = false,
		Spell = spell,
		-- :const
		Mastery = mastery,
		Skill = skill,
		FromX = x1,
		FromY = y1,
		FromZ = z1,
		ToX = x2,
		ToY = y2,
		ToZ = z2,
		ObjectType = nil,
		Sound = nil,
	}
	local done
	local function callDef(sp, mas, sk, x, y, z, xx, yy, zz)
		t.Handled = true
		ReplaceProj(sp, t.Spell, t.ObjectType, t.Sound)
		def(sp or t.Spell, mas or t.Mastery, sk or t.Skill, x or t.FromX, y or t.FromY, z or t.FromZ, xx or t.ToX, yy or t.ToY, zz or t.ToZ)
		return CollectProj(done, sp and t.Spell, sk and t.Skill, mas and t.Mastery or false)
	end
	t.CallDefault = callDef
	-- Can be used to change how a spell works when cast by #evt.CastSpell:evt.CastSpell#.
	-- 'Sound' and 'ObjectType' aren't assigned initially, you can set them to change what sound the spell makes and what projectiles it has.
	-- !Lua[[CallDefault(FakeSpell, FakeMastery, FakeSkill, x1, y1, z1, x2, y2, z2)]] would use logic from 'FakeSpell' with 'FakeMastery' and 'FakeSkill', but change sound and any created projectiles to match what you've defined in the table. Coordinates can also be changed.
	-- !\ Complex example:!Spoiler[=[!Lua[[
	-- -- Enables Paralyze spell to be used by monsters and evt.CastSpell
	-- -- You would also need to add the projectiles to ObjList.txt and SFT.txt in Data\Tables\
	-- local spPara = const.Spells.Paralyze
	-- local objPara = Game.SpellObjId[spPara]
	--
	-- local handler = |t| if t.Spell == spPara then
	-- 	t.CallDefault(2)  -- Fire Bolt, because it simply plays a sound and creates a projectile
	-- end
	-- events.MonsterCastSpell = handler
	-- events.EventCastSpell = handler
	-- 
	-- events.ReadMonsterSpell = |t| if t.Name == "paralyze" then
	-- 	t.Result = spPara
	-- end
	-- 
	-- events.PlayerAttacked = |t| if not t.Handled then
	-- 	local o = t.Attacker.Object
	-- 	if o and o.Type == objPara then
	-- 		t.Handled = true
	-- 		t.Player:DoBadThing(const.MonsterBonus.Paralyze, t.Attacker.Monster or Map.Monsters[0])
	-- 	end
	-- end
	--
	-- events.MonsterAttacked = |t| if not t.Handled then
	-- 	local o, mon = t.Attacker.Object, t.Monster
	-- 	if o and o.Type == objPara then
	-- 		t.Handled = true
	-- 		if mon:CalcHitByEffect(Game.SpellsTxt[spPara].DamageType) then
	-- 			mon.CurrentActionLength = 128
	-- 			mon.AIState = 0
	-- 			mon.SpeedX = 0
	-- 			mon.SpeedY = 0
	-- 			mon.SpeedZ = 0
	-- 			mon:UpdateGraphicState()
	-- 			mon.SpellBuffs[const.MonsterBuff.Paralyze]:Set(Game.Time + 3*const.Minute*o.SpellSkill, o.SpellLevel)
	-- 			mon:ShowSpellEffect()
	-- 		end
	-- 	end
	-- end]]]=]
	events.cocall("EventCastSpell", t)
	if not t.Handled then
		done = true
		callDef()
	end
end)

-- MissileSetup

local hooks = HookManager{
	p = Game.MissileSetup.pptr,
	sz = Game.MissileSetup.lenP,
	elSz = structs.MissileSetup['?size'],
}

-- collide
hooks.asmhook(mmv(0x45C7A7, 0x46C0C2, 0x46A702), [[
	mmdef go1, 0x45CD5D, 0x46C420, 0x46AC28
	mm7cmd movsx eax, cx
	cmp eax, [%sz%]
	jnb @std
	mov ecx, [%p%]
	test byte [ecx + eax*%elSz%], 4
	mov ecx, eax
	jnz absolute go1
@std:
]])

-- display
if mmver > 6 then
	hooks.asmhook(mm78(0x4A815A, 0x4A673D), [[
		mov edx, [esp+4]
		movsx edx, word [edx]
		cmp edx, [%sz%]
		jnb @std
		mov eax, [%p%]
		mov al, [eax + edx*%elSz%]
		test al, 3  ; is changed?
		jz @std
		test al, 2  ; hide spc effect?
		jnz @cond
	;spc effect with SW over it:
		push dword [esp+4]
		call @std
	@show:
		mov eax, 1
		ret 4
	@cond:
	;no spc effect:
		and eax, 1
		ret 4
	@std:
		cmp edx, mm7*9120 + mm8*12120
		jnb @show
	]])
end

-- Read Spells

mem.autohook(mmv(0x448026, 0x454924, 0x452087), |d| if events.exists'ReadMonsterSpell' then
	local t = {Result = nil}
	local ebp = mmver == 6 and d.esp + 0x168
	local p = mmver == 6 and ebp - 0xF8 or d.edi
	for i = 1, i4[p] do
		t[i] = mem.pchar[p + i*4]:lower()
	end
	local n = #t - 2
	for i = 2, n do
		if #t[i] <= 2 and tonumber(t[i+1]) then
			n = i - 1
			break
		end
	end
	for i = n + 1, #t do
		t[i] = nil
	end
	t.Name = table.concat(t, ' ')
	--!a{word1, word2, ...} If spell name is "Hour of Power", the table passed to event would be !Lua[[{"hour", "of", "power", Name = "hour of power"}]], all in lower case.
	-- !\ Example:!Lua[[
	-- -- allow Poison Spray to be read from Monsters.txt
	-- events.ReadMonsterSpell = |t| if t.Name == "poison spray" then
	-- 	t.Result = 24
	-- end]]
	events.cocalls("ReadMonsterSpell", t)
	if t.Result then
		d.esi = n
		if mmver == 6 then
			u1[u4[ebp - 0x158] + 71*d.ebx + 0x22] = t.Result
		else
			d.eax = t.Result
		end
		d:push(mmv(0x448311, 0x454CDC, 0x4524C0))
		return true
	end
end)
