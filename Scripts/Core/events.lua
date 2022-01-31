local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion


local function mmv(...)
	return (select(mmver - 5, ...))
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

local _KNOWNGLOBALS_F = Party, Game, Map, VFlipUnfixed, structs, GameInitialized1, GameInitialized2

local PatchOptionsSize = offsets.PatchOptionsSize -- Game.PatchOptions.Size

do
	-- HookManager
	
	local procs = {
		hook = false,
		hookjmp = false,
		autohook = true,
		autohook2 = true,
		bytecodehook = true,
		bytecodehook2 = true,
		bytecodepatch = true,
	}

	local asmprocs = {
		asmhook = true,
		asmhook2 = true,
		asmpatch = true,
	}

	local procs_hookfunction = {
		hookfunction = true,
		hookcall = false,
	}

	-- Allows switching all hooks installed by it on/off. 'ref' table is used for substitutions in Asm code: "%key%" is replaced with !Lua[=[ref[key]]=], "%%" is replaced with "%". All hook functions are supported, but memory-editing arrays are supported through 'set' function.
	-- !\ Example 1 - substitution:!Lua[=[
	-- local ArtifactBonus = mem.StaticAlloc(8)
	-- HookManager{
	-- 	buf = ArtifactBonus,
	-- }.asmhook2(0x48F60A, [[
	-- 	mov [%buf%], eax
	-- 	mov [%buf%+4], ecx
	-- ]])]=]
	-- !\ Example 2 - on/off:!Lua[=[
	-- local hooks
	-- function ArcomageRequireDeck(on)
	-- 	if hooks then
	-- 		hooks.Switch(not on)
	-- 	elseif not on then
	-- 		hooks = HookManager()
	-- 		hooks.nop(0x4B3A06)  -- no arcomage deck requirement
	-- 		hooks.nop(0x4B8A31)  -- no arcomage deck requirement
	-- 	end
	-- end]=]
	-- !\ Example 3 - editing memory:!Lua[=[
	-- local hooks = HookManager()
	-- hooks.set('i4', 0x469BBE+1, 0x10000)  -- instead of mem.prot(true);  mem.i4[0x469BBE+1] = 0x10000;  mem.prot(false)
	-- hooks.set('u2', 0x472FB7, 0x9090)  -- instead of mem.prot(true);  mem.u2[0x472FB7] = 0x9090;  mem.prot(false)
	-- hooks.asmpatch(0x472F5E, "add eax, ecx", 2)
	-- DisableVFlipFix = |on| hooks.Switch(not on)]=]
	-- !\ P.S. Don't try to run the code of these examples, they are for illustration.
	function HookManager(ref)
		local t = {ref = ref or {}}
		t.ref[""] = "%"
		function t.AddEx(RetMem, memf, p, hookf, size, ...)
			local size1 = size and size >= 5 and size or mem.GetHookSize(p)
			local std = mem.string(p, size1, true)
			local delmem = memf(p, hookf, size or size1, ...)
			local delhook = mem.hooks[p]
			size = (RetMem and not delmem) and size or size1
			local mine = mem.string(p, size, true)
			t[#t + 1] = function(on)
				if on == "off" then
					if RetMem and delmem then
						mem.hookfree(delmem)
					end
					if delhook then
						mem.hooks[p] = nil
					end
					on = false
				end
				mem.IgnoreProtection(true)
				mem.copy(p, on and mine or std, size)
				mem.IgnoreProtection(false)
			end
			return delmem
		end
		function t.Add(memf, p, hookf, size, ...)
			return t.AddEx(true, memf, p, hookf, size, ...)
		end
		function t.AddMem(p, size)
			local std, mine = mem.string(p, size, true), nil
			t[#t + 1] = function(on)
				mine = mine or mem.string(p, size, true)
				mem.IgnoreProtection(true)
				mem.copy(p, on and on ~= "off" and mine or std, size)
				mem.IgnoreProtection(false)
			end
		end
		function t.Switch(on)
			if on == "off" then
				return t.Clear()
			end
			for i = 1, #t do
				t[i](on)
			end
		end
		function t.Clear()
			for i = 1, #t do
				t[i]("off")
				t[i] = nil
			end
		end
		function t.ProcessAsm(code)
			return code:gsub("%%([%w_]*)%%", t.ref)
		end
		function t.asm(code)
			return mem.asm(t.ProcessAsm(code))
		end
		function t.asmproc(code)
			return mem.asmproc(t.ProcessAsm(code))
		end
		function t.nop(p, n)
			n = n or mem.GetInstructionSize(p)
			t.AddMem(p, n)
			mem.nop(p, n)
		end
		function t.nop2(p, p2)
			t.AddMem(p, p2 - p)
			mem.nop2(p, p2)
		end
		function t.set(a, p, v)
			t.AddMem(p, a:sub(2, -1) + 0)
			mem.prot(true)
			mem[a][p] = v
			mem.prot(false)
		end
		function t.hookalloc(size)
			local p = mem.hookalloc(size)
			t[#t + 1] = |on| if on == "off" then
				mem.hookfree(p)
			end
			return p
		end
		for proc, RetMem in pairs(procs) do
			t[proc] = function(...)
				return t.AddEx(RetMem, mem[proc], ...)
			end
		end
		for proc, RetMem in pairs(asmprocs) do
			t[proc] = function(addr, code, ...)
				return t.AddEx(RetMem, mem[proc], addr, t.ProcessAsm(code), ...)
			end
		end
		for proc, RetMem in pairs(procs_hookfunction) do
			local function reorder(p, f, size, nreg, nstack)
				return mem[proc](p, nreg, nstack, f, size)
			end
			t[proc] = function(p, nreg, nstack, f, size)
				return t.AddEx(RetMem, reorder, p, f, size, nreg, nstack)
			end
		end
		return t
	end

end

local OnEventUsed = {}
internal.OnEventUsed = OnEventUsed

local EventsT = internal.EventsSetup{
	EventUsed = function(name, on)
		local f = OnEventUsed[name]
		if f then
			f(on, name)
		end
	end,
}

local function DoConditional(f, name)
	OnEventUsed[name] = f
	if not EventsT[name] then
		f(false)
	end
end

local function ConditionalEx(f, t)
	local function check(on)
		if on then
			return f(on)
		end
		for _, name in ipairs(t) do
			if EventsT[name] then
				return
			end
		end
		return f(false)
	end
	for _, name in ipairs(t) do
		OnEventUsed[name] = check
	end
	check(false)
end

local function Conditional(hooks, name)
	return (type(name) == 'table' and ConditionalEx or DoConditional)(hooks.Switch, name)
end
internal.Conditional = Conditional

local function GetPlayer(p)
	local i = (p - Party.PlayersArray["?ptr"]) / structs.Player["?size"]
	return i, Party.PlayersArray[i]
end

local function GetMonster(p)
	if p == 0 then
		return
	end
	local i = (p - Map.Monsters["?ptr"]) / structs.MapMonster["?size"]
	return i, Map.Monsters[i]
end

internal.GetPlayer, internal.GetMonster = GetPlayer, GetMonster



mem.IgnoreProtection(true)

-- remove unneeded checks in allocMM
mem.nop2(mmv(0x4213AA, 0x426719, 0x424B65), mmv(0x4213C2, 0x42672E, 0x424B77))

-- internal.OnWaitMessage
local function HookWaitMessage(p)
	local std = u4[p]
	local new = mem.hookalloc()
	mem.hook(new, function(d)
		u4[d.esp] = std
		if internal.OnWaitMessage then
			internal.OnWaitMessage()
		end
	end)
	mem.IgnoreProtection(true)
	u4[p] = new
	mem.IgnoreProtection(false)
end

HookWaitMessage(mmv(0x4B9228, 0x4D8270, 0x4E8290))  -- WaitMessage
if mmver > 6 then
	HookWaitMessage(mm78(0x4D80B8, 0x4E8158))  -- Sleep
end
do
	local std = mmv(0x4A6590, 0x4BF377, 0x4BCFC3)
	mem.hook(mmv(0x4A59DB, 0x4BE6A6, 0x4BC233), function(d)
		d:push(std)
		if internal.OnWaitMessage then
			internal.OnWaitMessage()
		end
	end)
end



function internal.CalcSpellDamage(dmg, spell, skill, mastery, HP)
	local t = {Result = dmg, Spell = spell,
		Skill = skill,
		-- :const
		Mastery = mastery,
		HP = HP, HitPoints = HP}
	events.cocall("CalcSpellDamage", t)
	return t.Result
end


-- WalkToMap
local WorldSides = {'up', 'down', 'left', 'right'}  -- 0 - party start, 1 - north, 2 - south, 3 - east, 4 - west
local SideToNum = table.invert(WorldSides)

function internal.TravelWalk(mapName, x, y, buf, bufsize, result)
	local dir
	if x < -22528 then
		dir = 'left'
	elseif x > 22528 then
		dir = 'right'
	elseif y < -22528 then
		dir = 'down'
	elseif y > 22528 then
		dir = 'up'
	else
		return result
	end
	local oldRes = result == 1 and mem.string(buf):lower() or nil
	local time = mm78(0x6BCEFC, 0x6F2650)
	local side = mm78(0x6BE1DC, 0x6F399C)

	local t = {
		LeaveMap = mem.string(mapName):lower(),
		-- [MM7+]
		LeaveSide = side and dir,
		X = x, Y = y,
		EnterMap = oldRes,
		-- [MM7+]
		EnterSide = side and (WorldSides[i4[side]] or i4[side]),
		-- [MM7+]
		Days = time and i4[time]
	}
	-- Sides:
	--   0, "up", "down", "left", "right".
	--   0 means "party start" sprite.
	events.cocall("WalkToMap", t)
	local res = t.EnterMap and tostring(t.EnterMap)
	if res and res ~= oldRes and assert(#res < bufsize) then
		mem.copy(buf, res, #res + 1)
	end
	if mmver ~= 6 then
		i4[time] = t.Days
		i4[side] = SideToNum[t.EnterSide] or t.EnterSide
	end
	return res and 1 or 0
end

local function SetPosDir(x, y, z, direction, lookAngle, speedZ)
	Party.X = x
	Party.Y = y
	Party.Z = z
	Party.FallStartZ = Party.Z
	Party.Direction = direction
	Party.LookAngle = lookAngle
	Party.SpeedZ = speedZ or 0
end

function internal.DeathMap(p)
	local t = {Name = mem.string(p), Set = SetPosDir}
	events.cocalls("DeathMap", t)
	assert(#t.Name < 0x14)
	mem.copy(p, t.Name, #t.Name + 1)
	Party.FallStartZ = Party.Z
end

function internal.NewGameMap()
	local t = {AutoFallStart = true, Set = nil}
	function t.Set(x, y, z, direction, lookAngle, speedZ)
		SetPosDir(x, y, z, direction, lookAngle, speedZ)
		Game.MoveToMap:Set(x, y, z, direction, lookAngle, speedZ)
	end
	-- 'Set'!Params[[(x, y, z, direction, lookAngle, speedZ)]] function sets both party position (saved in autosave) and map transition (used on start immediately).
	events.cocalls("NewGameMap", t)
	if t.AutoFallStart then
		Party.FallStartZ = Party.Z
	end
	mem.copy(mmv(0x908CAC, 0xACD500, 0xB21568), mmv(0x908C98, 0xACD4EC, 0xB21554), 0x14)
end

-- new game party
if mmver < 8 then
	
	mem.hookfunction(mmv(0x485540, 0x491375), 1, mmv(0, 1), function(d, def, party, items)
		def(party, items)
		events.cocalls("NewGameDefaultParty")
	end)
	
	mem.hookfunction(mmv(0x485F40, 0x4917C6), 1, 0, function(d, def, party)
		def(party)
		events.cocalls("NewGameClearParty")
	end)
	
else
	mem.hookfunction(0x4903C0, 1, 2, function(d, def, party, clearClass, fill)
		def(party, clearClass, fill)
		if clearClass ~= 0 then
			events.cocalls(fill ~= 0 and "NewGameDefaultParty" or "NewGameClearParty")
		end
	end)
end

if mmver > 6 and PatchOptionsSize < 336 then
	-- always invoke LeaveMap event (death and walking fixed by my patches) (fixed in patch 2.5)
	for _, p in ipairs(mm78({0x433324, 0x44C30F, 0x4B6A96}, {0x430BC3, 0x4B52F5})) do
		mem.asmhook(p, 'pushad'..'\ncall absolute '..mm78(0x443FB8, 0x440DBC)..'\npopad')
	end
	-- read Body attack type of monsters
	mem.asmhook(mm78(0x454D9A, 0x452580), [[
		cmp eax, 'b'
		jnz @f
		mov eax, 8
		jmp absolute mm7*0x454DA6 + mm8*0x45258D
	@@:
	]])
end

-- fix savegame loading
if mmver == 6 then
	u1[0x44F03A] = 1
elseif mmver == 7 then
	u1[0x45F1AB] = 1
	u1[0x45F214] = 1
else
	u1[0x45CB47] = 1
	u1[0x45CBB6] = 1	
end

-- fix monsters using 'Spirit Lash', 'Inferno', 'Prismatic Light' (fixed in patch 2.5)
if mmver == 8 and PatchOptionsSize < 336 then
	u2[0x40546F] = 0x9057  -- push edi
end

-- when addind monsters via evt command, leave space for 5 light elementals for each party member
if mmver > 6 then
	i4[mm78(0x44F6FD, 0x44CE1F)] = 500 - (mmver - 3)*5
end

local delayedDefs = {}

local function delayed(f)
	delayedDefs[f] = true
end

function internal.GameInitialized1()
	for f in pairs(delayedDefs) do
		f()
	end
	GameInitialized1 = true
	-- loaded .bin data
	events.cocalls("GameInitialized1")
end

function internal.GameInitialized2()
	GameInitialized2 = true
	-- fix water in maps without a building with WtrTyl texture, also don't turn textures with water bit into water (fixed in patch 2.5)
	if mmver == 7 and Game.IsD3D and PatchOptionsSize < 336 then
		mem.autohook(0x4649B7, function(d)
			i4[0xEF5114] = Game.BitmapsLod:LoadBitmap("WtrTyl")
		end)
	end
	-- loaded .txt data
	events.cocalls("GameInitialized2")
end

local function MapCheckHook(d, ev, t, IsArena)
	local param1, param2 = d:getparams(0, 2)
	local r = call(mmv(0x4AF370, 0x4CAAF0, 0x4DA920), 0, param1, param2)
	t = t or {}
	t.Map = mem.string(param1):lower()
	t.Result = (r ~= 0)
	if IsArena then
		t[IsArena] = (r == 0)
	end
	events.cocalls(ev, t)
	d.eax = t.Result and 1 or 0
	return t
end

-- CanSaveGame
mem.hook(mmv(0x44F378, 0x45F4CA, 0x45CF92), function(d)
--[[!({
  IsArena
  SaveKind
}) 'SaveKind': 0 - normal, 1 - autosave, 2 - quick save
If 'IsArena' is 'true', the "No saving on the Arena" message is displayed]]
	MapCheckHook(d, "CanSaveGame", {SaveKind = (mmver == 6 and d.ebx or u4[d.ebp - 0x24])}, 'IsArena')
end)

if mmver > 6 then
	local isarena
	mem.hook(mm78(0x4600CA, 0x45DB81), function(d)
		isarena = MapCheckHook(d, "CanSaveGame", {SaveKind = 0}, 'IsArena').IsArena
	end)
	mem.hook(mm78(0x4601BE, 0x45DCD1), function(d)
		if isarena then
			d:push(mm78(0x44C1A1, 0x4496C5))
		else
			Game.PlaySound(27)
		end
	end)
end

if mmver == 8 then
	mem.hook(0x42F349, function(d)
		MapCheckHook(d, "CanSaveGame", {SaveKind = 0}, 'IsArena')
	end)
end

-- CanCastLloyd
mem.hook(mmv(0x425FD3, 0x42B54F, 0x4296E6), function(d)
	MapCheckHook(d, "CanCastLloyd")
end)

-- IsUnderwater
local function IsUnderwaterHook(d)
	local param1, param2 = d:getparams(0, 2)
	local r = call(mmv(0x4AF370, 0x4CAAF0, 0x4DA920), 0, param1, param2)
	local t = {Map = mem.string(param1):lower(), Result = (r == 0)}
	-- [MM7+]
	events.cocalls("IsUnderwater", t)
	d.eax = t.Result and 0 or 1
end

if mmver > 6 then
	mem.hook(mm78(0x464880, 0x462BC7), IsUnderwaterHook)
end

if mmver == 7 then
	mem.hook(0x46496C, IsUnderwaterHook)
end

-- FogRange
function internal.SetFogRange()
	events.cocalls("FogRange")
end

-- Don't show error message if .evt or .str doesn't exist
mem.hook(mmv(0x43968E, 0x443D1E, 0x440B1F), function(d)
	local this, name = d:getparams(1, 1)
	local f = call(mmv(0x44CBC0, 0x4615BD, 0x45FCA6), 1, mmv(this, this, 0x6F30D0), name, 0)
	if f ~= 0 then  -- found
		d:push(mmv(0x40C1A0, 0x410897, 0x411C9B))
	else
		d.esp = d.esp + 12
		d[mmv("ebp", "eax", "esi")] = 0
		d:push(mmv(0x43978E, 0x443DBE, 0x440BC0))
	end
end)

-- Fix evt.SimpleMessage in MM8
if mmver == 8 then
	mem.hook(0x44204A, function(d)
		local mon = mem.u4[0xFFD45C]
		if mon == 0 then
			mem.u4[d.esp] = 0x4421D9
		end
		d.ecx = mon
	end, 6)
end

-- MM7 Question - clean screen afterwards
if mmver == 7 and PatchOptionsSize < 364 then
	mem.asmhook(0x4451C1, [[
		cmp dword [eax + 0x1C], 0x1A
		jnz @f
		mov dword [0x576EAC], 1
	@@:
	]])
end

-- MM8 Question - don't react to key presses
if mmver == 8 then
	mem.asmhook2(0x42ED54, [[
		cmp byte [0x5CCCE4], 0
		jz @f
		mov eax, edi
	@@:
	]])
end

-- MM7 Question in house: 0x4B29ED - check esi ~= 0

-- allow Evt calls stacking
do
	-- instead of copying evt lines, store their address in the first 4 bytes of CurrentEvtLines
	if mmver == 6 then
		mem.asmhook2(0x43C8E3, [[
			mov [edi], esi
		]])
		mem.nop(0x43C8E8)
	else
		mem.asmpatch(mm78(0x44690D, 0x443822), [[
			mov eax, [esp]
			mov edx, [esp + 4]
			mov [eax], edx
		]])
	end
	
	-- modify line address by the offset from CurrentEvtLines to stored evt lines address
	HookManager{
		reg = mmv('eax', 'edx', 'ecx'),
		lines = offsets.CurrentEvtLines,
	}.asmhook2(mmv(0x43C905, 0x446945, 0x443864), [[
		add %reg%, [%lines%]
		sub %reg%, %lines%
	]])
end


-- allow indexes over 256 in MM6
local CopyDialogIndexes, CopyDialogIndexesBack = function() end, nil

if mmver == 6 then
	function CopyDialogIndexes()
		local p, n = Game.DialogLogic.List['?ptr'], min(2000, Game.DialogLogic.List.limit)
		for i = 0, n - 1 do
			i4[p + i*4] = u1[0x55D5B0 + i]
		end
	end
	local p = mem.StaticAlloc(12)
	internal.DialogIndexListPtr = p
	u4[p] = mem.allocMM(2000*4)
	local hooks = HookManager{
		p = p,
		code = [[
			macro Code p, reg, idx
			{
				mov reg, [p]
				mov reg, [reg + idx*4]
			}
			Code ]],
	}
	hooks.asmpatch(0x40E2F7, '%code% %p%, edx, edi')  -- quests
	hooks.asmpatch(0x40E842, '%code% %p%, edx, edi')  -- autonotes
	hooks.asmpatch(0x416426, '%code% %p%, ecx, eax')  -- awards
	
	-- award categories
	internal.AwardCategoriesPtr = p + 4
	local sort = mem.allocMM(88*4)
	u4[p + 4] = sort
	u4[p + 8] = 88
	-- fill
	local i = 0
	for v, k in ipairs{8, 32, 37, 64, 81, 88} do
		for i = i, k - 1 do
			i4[sort + 4*i] = v - 1
		end
		i = k
	end
	-- hook
	hooks.asmpatch(0x4164A4, [[
		%code% %p% + 4, eax, esi
		jmp absolute 0x4164DC
	]])
end


if mmver ~= 7 then
	-- populate quest log
	mem.autohook2(mmv(0x40D40F, nil, 0x4CC481), function(d)
		CopyDialogIndexes()
		-- Use this event to add quest indexes to #Game.DialogLogic.List:structs.DialogLogic.List# or rearrange them
		events.cocall("PopulateQuestLog")
	end)
	
	-- populate autonotes list
	mem.autohook2(mmv(0x40D7E9, nil, 0x4CCAB0), function(d)
		CopyDialogIndexes()
		local t = {Category = Game.DialogLogic.AutonotesCategory}
		-- Use this event to add autonote indexes to #Game.DialogLogic.List:structs.DialogLogic.List# or rearrange them
		events.cocall("PopulateAutonotesList", t)
	end)
else
	local p = mem.StaticAlloc(4)
	HookManager{p = p}.asmhook(0x411C71, 'mov [%p%], eax')
	-- populate all
	mem.autohook2(0x4126A8, function(d)
		local k = i4[p]
		if k == 200 then
			events.cocall("PopulateQuestLog")
		elseif k == 201 then
			local t = {Category = Game.DialogLogic.AutonotesCategory}
			events.cocall("PopulateAutonotesList", t)
		end
	end)
end

-- switch autonotes page
mem.autohook2(mmv(0x40E73E, 0x413832, 0x4CCDB6), function(d)
	CopyDialogIndexes()
	local t = {Category = Game.DialogLogic.AutonotesCategory}
	events.cocall("PopulateAutonotesList", t)
end)

-- populate awards list
local function PopulateAwards(d)
	CopyDialogIndexes()
	local a = Game.DialogLogic
	a.ListCount = d.eax
	local pidx = mmver == 8 and i4[i4[d.ebp - 4] + 0x128]
	local pl = pidx and Party.PlayersArray[pidx] or Party:GetCurrentPlayer()
	local t = {
		-- :structs.Player
		Player = pl,
		PlayerIndex = pidx or pl:GetIndex(),
		NoShuffle = mmver == 6,
	}
	-- Use this event to add award indexes to #Game.DialogLogic.List:structs.DialogLogic.List# or rearrange them. Awards would later be arranged into groups of different colors. If 'NoShuffle' is set to 'true', their order within groups would be preserved, otherwise default game code will sort them in an unpredictable manner.
	events.cocall("PopulateAwardsList", t)
	d.eax = a.ListCount
	if mmver == 6 or t.NoShuffle then
		local t, a, sort = {}, Game.DialogLogic.List, Game.AwardsSort
		local n = sort.Count
		for i, v in a do
			t[sort[v]*n + v] = v
		end
		local i = 0
		for _, v in sortpairs(t) do
			a[i], i = v, i + 1
		end
	end
end

mem.autohook(mmv(0x4151D0, 0x419144, 0x418A3A), PopulateAwards)
if mmver == 6 then
	mem.autohook(0x41FE30, PopulateAwards)
	mem.autohook(0x4202C0, PopulateAwards)
end

-- show monster info
mem.autohook(mmv(0x41CF11, 0x41E3CC, 0x41D9B0), function(d)
	--!(MonId) Called when monster kind in monster info dialog changes. #Game.DialogLogic.MonsterInfoMonster:structs.DialogLogic.MonsterInfoMonster# holds the monster prototype being displayed. This is the event you can use to change #Game.PatchOptions.MonSpritesSizeMul:structs.PatchOptions.MonSpritesSizeMul#.
	events.cocall("MonsterInfoPictureChanged", Game.DialogLogic.MonsterInfoMonster.Id)
end)

-- WindowProc
do
	local buf = mem.hookalloc()
	local ptr = mmv(0x45733A+4, 0x4652BB+3, 0x463542+3)
	local std = u4[ptr]
	u4[ptr] = buf
	function CallDefaultWindowProc(Msg, WParam, LParam)
		return call(std, 0, u4[offsets.MainWindow], Msg or 0, WParam or 0, LParam or 0)
	end
	
	mem.hook(buf, function(d)
		d.esp = d.esp + 4
		local wnd, msg, wp, lp = d:getparams(0, 4)
		d:ret(4*4)
		local t = {Window = wnd, Msg = msg, WParam = wp, LParam = lp, Handled = false, Result = 0}
		events.cocall("WindowMessage", t)
		if t.Handled then
			d.eax = t.Result
			return
		end
		msg, wp, lp = t.Msg, t.WParam, t.LParam
		if msg == 0x100 or msg == 0x104 or msg == 0x101 or msg == 0x105 then
			local t = {
				-- :const.Keys
				Key = wp,
				Alt = (msg >= 0x104), ExtendedKey = lp:And(0x1000000) ~= 0,
				WasPressed = lp:And(0x40000000) ~= 0, Handled = false}
			local down = (msg % 2 == 0)
			events.cocall(down and "KeyDown" or "KeyUp", t)
			if down then
				internal.TimersKeyDown(wp, t)
			end
			wp = t.Key
			if wp == 0 or t.Handled then
				d.eax = 0
				return
			end
		end
		d.eax = call(std, 0, wnd, msg, wp, lp)
	end)
end

-- Draw D3D effects
if mmver > 6 then
	local hooks = HookManager()
	hooks.autohook(mm78(0x4A1F92, 0x49FA68), function()
		events.cocall("PostRender")
	end)
	Conditional(hooks, "PostRender")
end


-- OnAction
local function OnAction(InGame, a1, a2, a3)
	local t = {Action = i4[a1], Param = i4[a2], Param2 = a3 and i4[a3] or 0, Handled = false}
	events.cocall(InGame and "Action" or "MenuAction", t)
	if t.Handled or InGame and internal.OnActionNPC(t) then
		i4[a1] = 0
	else
		i4[a1], i4[a2] = t.Action, t.Param
		if a3 then
			i4[a3] = t.Param2
		end
	end
end

if mmver == 6 then
	mem.hook(0x42B348, function(d)
		local a1, a2, a3 = d.esp + 4 + 0x3D8 - 0x3B0, d.esp + 4 + 0x3D8 - 0x3C8, d["?ptr"] + d.offsets.edx
		OnAction(true, a1, a2, a3)
		d.edi = i4[a1]
		d.zf = (d.edi == 0x7F)
		if d.edi > 0x7F then
			u4[d.esp] = 0x42DAAD
		end
	end)
	mem.autohook(0x42FB85, function(d)
		local a1, a2 = d.esp + 0x14 - 4, d["?ptr"] + d.offsets.ebp
		OnAction(false, a1, a2)
	end)
else
	mem.hookcall(mm78(0x430581, 0x42EE8D), 1, 3, function(d, std, this, ...)
		std(this, ...)
		OnAction(true, ...)
	end)
	mem.hookcall(mm78(0x43576F, 0x4331C3), 1, 3, function(d, std, this, ...)
		std(this, ...)
		OnAction(false, ...)
	end)
end

-- exit map action
do
	local reg = mmv('ecx', 'eax', 'eax')
	local p = HookManager{reg = reg}.asmhook2(mmv(0x453B90, 0x46349E, 0x46147F), [[
		test %reg%, %reg%
		jz @f
		call absolute 0
	@@:
	]])
	mem.hook(mem.findcall(p, 0), |d| do
		local t = {
			-- :const.ExitMapAction
			Action = d[reg],
		}
		events.cocall('ExitMapAction', t)
		Game.ExitMapAction = t.NextAction or t.Action  -- just in case someone actually needs a trick like this
		d[reg] = t.Action or Game.ExitMapAction
	end)
end

-- KeysFilter
if mmver > 6 then
	mem.hook(mm78(0x42FCD1, 0x42E616), function(d)
		local on = d.al ~= 0
		local t = {
			-- :const.Keys
			Key = i4[d.esp + 0x1C - 8],
			On = on, Result = on}
		events.cocalls("KeysFilter", t)
		if not t.Result then
			u4[d.esp] = mm78(0x43015B, 0x42EC44)
		end
	end, 6)
else
	local function f(d)
		local on = not d.ZF
		local t = {Key = d.esi, On = on, Result = on}
		events.cocalls("KeysFilter", t)
		if not t.Result then
			u4[d.esp] = 0x42B229
		end
	end
	mem.hook(0x42AE5C, f, 6)
	mem.hook(0x42AE73, f, 6)
end

-- Save/load game
do
	local savehdr = mem.StaticAlloc(0x20)
	mem.copy(savehdr, "luadata.bin\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 0x20)

	local tmp = mem.StaticAlloc(4)
	local compress = false
	
	function EnableLuaDataCompression(on)
		if on == nil then
			return compress
		end
		compress = on
	end
	
	local function TryCompress(dst, p, buf, sz)
		u4[p] = sz
		return Game.Compress(dst, p, buf, #buf) == 0 and u4[p] < sz
	end
	
	function internal.OnSaveGame()
		internal.NewGameAutosave = not internal.SaveGameData
		if internal.SaveGameData then
			internal.TimersSaveGame()
			events.cocalls("BeforeSaveGame")
			--!-
			events.cocalls("InternalBeforeSaveGame")
			-- internal.MonstersRestore(true)
		else
			internal.SaveGameData = {}
			internal.InitVars()
			events.cocalls("BeforeNewGameAutosave")
			--!-
			events.cocalls("InternalBeforeNewGameAutosave")
		end
		local buf, err = internal.persist(internal.SaveGameData) --, permanentsSave)
		if err then
			ErrorMessage(err)
		end
		local p, sz = mem.malloc(#buf + 4), #buf
		if compress and #buf > 16 and TryCompress(p + 9, p, buf, #buf - 5) then
			sz = u4[p] + 5    -- 4 bytes : compressed size
			i1[p + 4] = -1    -- 1 byte  : -1 (if not compressed, RSPersist version goes here)
			u4[p + 5] = #buf  -- 4 bytes : decompressed size
		else
			mem.copy(p + 4, buf)
		end
		u4[p] = sz
		u4[savehdr + 0x14] = sz + 4
		call(offsets.SaveFileToLod, 1, offsets.SaveGameLod, savehdr, p, 0)
		mem.free(p)
	end

	mem.autohook2(mmv(0x44FE3A, 0x4600A7, 0x45DB5F), function()
		if internal.NewGameAutosave then
			events.cocalls("AfterNewGameAutosave")
		else
			events.cocalls("AfterSaveGame")
		end
	end)

	function internal.OnLoadGame()
		internal.OnBeforeLoadGame()
		local f = call(offsets.FindFileInLod, 1, offsets.SaveGameLod, "luadata.bin", 1)
		if f ~= 0 then
			call(offsets.fread, 0, tmp, 4, 1, f)
			local size = u4[tmp]
			if size ~= 0 then
				local buf = mem.malloc(size)
				call(offsets.fread, 0, buf, size, 1, f)
				if i1[buf] == -1 then  -- compressed
					local buf2 = mem.malloc(u4[buf + 1])
					Game.Uncompress(buf2, buf + 1, buf + 5, size - 5)
					size = u4[buf + 1]
					mem.free(buf)
					buf = buf2
				end
				local err
				internal.SaveGameData, err = internal.unpersist(mem.string(buf, size, true)) --, permanentsTable)
				mem.free(buf)
				if err then
					ErrorMessage(err)
				end
			end
		end
	end
end

-- Allow entering completely new maps
do
	local function hookf(d, std, lod, ...)
		local r = std(lod, ...)
		if r == 0 then
			r = std(Game.GamesLod["?ptr"], ...)
		end
		return r
	end

	mem.hookcall(mmv(0x46DA0B, 0x47E3DF, 0x47D8E5), 1, 2, hookf)  -- ddm
	mem.hookcall(mmv(0x48BE10, 0x49A3E3, 0x4978CD), 1, 2, hookf)  -- dlv
	if mmver == 6 then
		mem.asmpatch(0x469DE1, "jmp 0x469DF5 - 0x469DE1")
		mem.asmpatch(0x45534D, "jmp 0x455361 - 0x45534D")
		mem.asmpatch(0x454FB2, "jmp 0x454FC6 - 0x454FB2")
	end
end

-- Allow drawing null pointer text
do
	local p = mmv(0x55BDE0, 0x5C4430, 0x5DC8E0)
	local code = ([[
		test ecx, ecx
		jnz @f
		mov [%d], cl
		mov eax, %d
		ret %%d
	@@:
	]]):format(p, p)

	if mmver == 6 then
		mem.asmhook(0x442F50, code:format(8))
	else
		mem.asmhook(mm78(0x44C794, 0x449ECA), code:format(12))
		mem.asmhook(mm78(0x44C95F, 0x44A058), code:format(16))
	end
	mem.asmpatch(mmv(0x443636, 0x44CE4F, 0x44A52A), ("jmp absolute %d"):format(mmv(0x4438D2, 0x44D0DA, 0x44A7AB)))
	-- 44A253 DrawTextLimited
end

if mmver == 7 then
	-- A bug I once had with SimpleMessage cmd
	mem.asmhook(0x44CE7C, [[
		test edi, edi
		jnz @f
		jmp absolute 0x44D0DA
	@@:
	]])
	-- fix weird temple crash I once experienced that may have happened due to my tinkering (div by 0)
	mem.asmhook(0x4B7792, [[
		jg @f
		mov edi, 1
	@@:
	]])
end

-- Improve doors in D3D mode
if mmver > 6 then
	-- Bitmap-independant door UV calculation in D3D mode (was good for editor when it used to change textures)
	u4[mm78(0x46F7C4, 0x46E2A5)] = 0xC0316690
	u4[mm78(0x46F7C4, 0x46E265)] = 0xC0316690
	-- Don't reset static door texture coordinates in D3D mode
	mem.asmpatch(mm78(0x46F622, 0x46E103), [[
		mov ecx, [ebx + 0x2C]  ; bits
		test ecx, 0x9000
		jz @f
		mov [esi + 0x14], ax   ; BitmapU
	@@:
		test ecx, 0x20008
		jz @f
		mov [esi + 0x16], ax   ; BitmapV
	@@:
	]])
end

-- FindInTFT returns wrong 'not found' value
if mmver > 6 then
	mem.asmpatch(mm78(0x44E1B9, 0x44B8A5), "xor eax, eax", 3)
end

-- fix TFT bitmaps outdoors
if mmver == 6 then
	mem.asmhook(0x4695AF, [[
		mov [esi + 0x3C], ax
	]])
else
	mem.asmhook(mm78(0x478C40, 0x477B71), [[
		mov [ebx + 0x4C], ax
	]])
end

-- allow 64k files in lods instead of 32k
mem.u1[mmv(0x44D0E7, 0x461939, 0x45F354)+1] = 0xB7

-- fix flat and almost flat surfaces V orientation
if mmver > 6 then
	-- need extra work with ScrollUp/ScrollDown
	mem.asmpatch(mm78(0x4792C3, 0x4781F6), [[
		mov dl, [edi + 0x31]
		test dl, 4+8
		jz @ok
		and dl, 255-12
		test byte [esi + 0x1C], 4
		jz @up
		or dl, 8
		jmp @store
	@up:
		or dl, 4
	@store:
		mov [edi + 0x31], dl
	@ok:
		mov edx, 0x10000
	]])
	mem.u2[mm78(0x482D32, 0x4826EA)] = 0x9090
	mem.asmpatch(mm78(0x482CCB, 0x482681), "add eax, [ebp - 0x14]", 3)
else
	-- Questionable in MM6. In MM7, MM8 the bug breaks SW/D3D consistency, thus must be fixed
	-- NWC made models without knowledge that BitmapV of almost-flat surfaces actually gets negated
	-- So, I'm fixing BitmapV negation, but not texture flip in MM6
	-- Modders can call FixVFlip() for their mods
	
	--!v [MM6]  Textures on horizontal outdoor surfaces are flipped vertically. This is default to preserve look of standard maps.
	VFlipUnfixed = true
	local code = [[
		savereg edx
		mov edx, [esi + 0x48]  ; poly->Facet
		mov edx, [edx + 8]     ; NormalZ
		cmp edx, 0xE6CA
		jg @neg
		cmp edx, -0xE6CA
		jnl @std
	@neg:
		neg eax
	@std:
	]]
	local hooks = HookManager()
	hooks.asmhook(0x475A92, code)
	hooks.asmhook(0x47432D, code)
	
	-- [MM6]  Turns off texture flip on horizontal outdoor surfaces. Note that the editor accounts for vertical flip, so you probably shouldn't ever call this function.
	function FixVFlip()
		mem.IgnoreProtection(true)
		if VFlipUnfixed then
			mem.i4[0x469BBE+1] = 0x10000
			mem.u2[0x472FB7] = 0x9090
			mem.asmpatch(0x472F5E, "add eax, ecx", 2)
		else
			mem.i4[0x469BBE+1] = -0x10000
			mem.u2[0x472FB7] = 0xD8F7
			mem.u2[0x472F5E] = 0xC12B
		end
		VFlipUnfixed = not VFlipUnfixed
		hooks.Switch(VFlipUnfixed)
		mem.IgnoreProtection(false)
		Party.NeedRender = true
	end
end

-- Special effects of spells (can't do as Lua hook, they slow things down)
-- if mmver > 6 then
-- 	mem.hookfunction(mm78(0x4A815A, 0x4A673D), 1, 1, function(d, def, this, obj)
-- 		local t = {}
-- 		local function callDef()
-- 	end)
-- end

-- when games.lod index is used make negative indeces refer to mapstats.txt lines, make "Town Portal to" text respect TownPortalInfo
if mmver == 6 then
	local hooks = HookManager{
		MapStats = "[0x40CAC1]",
	}
	-- lloyd games index -> mapstats index
	hooks.asmhook(0x40C850, [[
		cmp ecx, 0
		jnl @f
		mov eax, ecx
		neg eax
		ret
	@@:
	]])
	hooks.asmhook(0x40CA59, [[
		cmp eax, 0
		jnl @f
		neg eax
		mov esi, eax
		jmp absolute 0x40CAA8
	@@:
	]])
	-- lloyd get
	hooks.asmhook(0x42E245, [[
		cmp eax, 0
		jnl @f
		imul eax, -0x38
		add eax, %MapStats%
		mov eax, [eax+4]
		jmp absolute 0x42E250
	@@:
	]])
	hooks.asmhook(0x42E2D8, [[
		cmp edi, 0
		jnl @f
		mov eax, edi
		imul eax, -0x38
		add eax, %MapStats%
		mov edi, [eax+4]
		or ecx, -1
		jmp absolute 0x42E2E5
	@@:
	]])
	-- lloyd set
	hooks.asmhook(0x42E4B1, [[
		push 0x6107BC  ; MapName
		mov ecx, %MapStats%
		call absolute 0x446BD0  ; MapStats_Find
		test eax, eax
		jz @f
		neg eax
		mov [ebp+0x1A], ax
	@@:
	]])
	
	-- town portal
	hooks.asmpatch(0x42E6C9, [[
		movsx eax, word [0x4C1F98 + 0x10 + ebp]
		imul eax, 0x38
		add eax, %MapStats%
		mov ecx, [eax+4]
		mov edx, 0x20
		; std
		or edi, ebx
		xor eax, eax
	]], 0x42E6DC - 0x42E6C9)
	
	-- fix town portal order
	hooks.asmhook(0x42E639, [[
		mov [esp+3D8h-3B8h], al
	]])
	local t, map = {}, {[0] = 3, 2, 4, 1, 0, 5}
	local p, sz = 0x4C1F98, 0x14
	for i = 0, 5 do
		t[i] = mem.string(p + i*sz, sz, true)
	end
	for i = 0, 5 do
		mem.copy(p + i*sz, t[map[i]], sz)
	end
	
	
	-- strange: 42F209 - pyramid.blv
	-- 43BC39 - NPC news, not that important
	
	-- transport (use free byte at +9 offset to indicate map stats)
	-- location names are at 9DDE24, copied from GLOBAL.txt starting at index 545
	local code = [[
		cmp byte [ebp+9], 0
		jz @f
		mov eax, edx
		imul eax, 0x38
		add eax, %MapStats%
		mov %reg%, [eax+4]
		jmp absolute %p%
	@@:
	]]
	hooks.ref.p = 0x49D73A
	hooks.ref.reg = "ecx"
	hooks.asmhook(0x49D733, code)
	hooks.ref.p = 0x49D866
	hooks.ref.reg = "edi"
	hooks.asmhook(0x49D85F, code)
	
	-- make "Town Portal to" text respect TownPortalInfo
	hooks.asmpatch(0x42E4CC, [[
		imul eax, 0x14
		mov eax, [0x4C1F98 + 0x10 + eax]
		imul eax, 0x38
		mov edx, %MapStats%
		mov edx, [edx + eax]
	]], 0x42E4D9 - 0x42E4CC)
else
	local hooks = HookManager{
		MapStats = mm78("[0x410FB2]", "[0x41336B]"),
		MapName = mm78(0x6BE1C4, 0x6F3984),
		MapStats_Find = mm78(0x4547CF, 0x451F39),
		TownPortalInfo = mm78(0x4ECA60, 0x4FCA88),
	}
	-- lloyd games index -> mapstats index
	hooks.asmhook(mm78(0x410DA5, 0x4121B6), [[
		cmp ecx, 0
		jnl @f
		mov eax, ecx
		neg eax
		ret
	@@:
	]])
	-- lloyd get
	local code = [[
		cmp eax, 0
		jnl @f
		imul eax, -0x44
		add eax, %MapStats%
		mov eax, [eax+4]
		jmp absolute %p%
	@@:
	]]
	hooks.ref.p = mm78(0x43362F, 0x430F1A)
	hooks.asmhook(mm78(0x433626, 0x430F11), code)
	hooks.ref.p = mm78(0x433699, 0x430F79)
	hooks.asmhook(mm78(0x433690, 0x430F70), code)
	-- lloyd set
	hooks.asmhook2(mm78(0x43385C, 0x4310B3), [[
		jl @f
		push %MapName%
		mov ecx, %MapStats%
		call absolute %MapStats_Find%
		test eax, eax
		jz @f
		neg eax
	if mm7
		mov ecx, [esp + 0x5F8 - 0x5DC]
		mov [ecx+0x1A], ax
	else
		mov [esi+0x1A], ax
	end if
		test esp, esp
	@@:
	]])
	-- strange: 433B65
	
	-- make "Town Portal to" text respect TownPortalInfo
	hooks.asmpatch(mm78(0x433A64, 0x4D1288), [[
		imul eax, 0x14
		mov eax, [%TownPortalInfo% + 0x10 + eax]
		imul eax, 0x44
		mov edx, %MapStats%
		mov eax, [edx + eax]
	]], mm78(0x433A9F - 0x433A64, 0x4D12C8 - 0x4D1288))
end

-- Win map being searched in games.lod
if mmver == 6 then
	-- need more work on this
elseif mmver == 7 then
	mem.asmpatch(0x433BB1, [[
		lea esi, [edi + 4]
		add esi, [0x413C39]
		mov esi, [esi]
		jmp absolute 0x433BF1
	]])
elseif mmver == 8 then
	mem.asmpatch(0x4313CD, [[
		lea esi, [edi + 4]
		add esi, [0x41F936]
		mov esi, [esi]
		jmp absolute 0x431409
	]])
end

-- SkyBitmap
mem.autohook(mmv(0x46E01E, 0x47EB89, 0x47E0D4), function(d)
	local time = Map.OutdoorLastVisitTime
	local first = (time == 0)
	if first or time:div(const.Day) % 28 ~= Game.DayOfMonth then
		local t = {FirstVisit = first, Result = Map.OutdoorExtra.SkyBitmap}
		events.cocalls("SkyBitmap", t)
		Map.OutdoorExtra.SkyBitmap = t.Result
	end
end)

if mmver == 8 then
	mem.u1[0x47E2DA] = 0x47E304 - 0x47E2DB
end

-- automatic MazeInfo
if mmver == 6 then
	mem.autohook2(0x439F35, function(d)
		if Map.MapStatsIndex > 0 then
			d.eax = i4[Game.MapStats[Map.MapStatsIndex]["?ptr"]]
		end
	end)
end

-- internal.MapRefilled (used in evt.lua)
mem.autohook(mmv(0x4554B5, 0x450AD6, 0x44E339), function(d)
	internal.MapRefilled = 1
end)

-- PlayMapTrack
local function PlayMapTrack(d, def, this, track)
	local index = (mmver == 6 and d.esi - Game.MapStats["?ptr"] or d.eax)/structs.MapStatsItem["?size"]
	local t = {
		MapIndex = index,
		Track = mmver == 6 and track or Game.MapStats[index].RedbookTrack
	}
	events.cocall("PlayMapTrack", t)
	if mmver == 6 then
		def(this, t.Track)
	else
		d.eax = t.Track
	end
end

if mmver == 6 then
	for p in mem.enumcalls(0x454FDF, 0x45504D, 0x48EA30) do
		mem.hookcall(p, 1, 1, PlayMapTrack)
	end
else
	mem.hook(mm78(0x4ABF6E, 0x4AA3FD), PlayMapTrack)
	-- allow changing track offset
	local p = mem.StaticAlloc(4)
	i4[p] = 14
	internal.TrackOffsetBuf = p
	local s = [[
		add eax, [%p%]
	]]
	local hooks = HookManager{p = p}
	hooks.asmhook(mm78(0x4630C7, 0x461050), s)
	hooks.asmhook(mm78(0x4BF846, 0x4BD3A1), s)
end

-- allow trainers for unused skills in MM8
if mmver == 8 then
	mem.asmpatch(0x4B0BE1, [[
		lea eax, [ecx - 300]
		mov ecx, 3
		xor edx, edx
		idiv ecx
		ret
	]], true)
end

-- ShowMovie
mem.hookfunction(mmv(0x4A59A0, 0x4BE671, 0x4BC1F1), 2, mmv(1, 2, 2), function(d, def, name, y, DoubleSize, ExitCurrentScreen)
	local t = {
		Name = mem.string(name),
		Y = y,
		DoubleSize = (DoubleSize ~= 0),
		ExitCurrentScreen = (ExitCurrentScreen ~= 0),
		Allow = true,
	}
	-- function!Params[[()]]
	t.CallDefault = function()
		if t.Allow then
			def(t.Name, t.Y, t.DoubleSize, t.ExitCurrentScreen)
			t.Allow = false
		end
	end
	events.cocall("ShowMovie", t)
	t.CallDefault()
end)

-- PlaySound
mem.hookfunction(mmv(0x48EB40, 0x4AA29B, 0x4A87DC), 1, 8, function(d, def, this, snd, obj, loops, x, y, unk, vol, rate)
	local t = {
		Sound = snd,
		ObjRef = obj,
		Loops = loops,
		X = x,
		Y = y,
		UnkParam = unk,
		Volume = vol,
		Speed = rate,
		Allow = true,
	}
	-- function!Params[[()]]
	t.CallDefault = function()
		if t.Allow then
			def(this, t.Sound, t.ObjRef, t.Loops, t.X, t.Y, t.UnkParam, t.Volume, t.Speed)
			t.Allow = false
		end
	end
	--!-
	events.cocall("InternalPlaySound", t)
	if t.Allow then
		events.cocall("PlaySound", t)
	end
	t.CallDefault()
end)

-- FaceAnimation
do
	local p = mem.StaticAlloc(16)
	local hooks = HookManager{
		face = p,
		snd = p + 4,
		scount = p + 8,
		soff = p + 12,
		code = [[
			mmdef a, esp+0x28-0x14, ebp-0x1C, ebp-0x1C
			cmp dword [p], esi
			jl @std
			mov ecx, [p]
			jz @f
			inc esi
			mov [a], ecx
		@@:
			jmp absolute jmp1
		@std:
		]],
	}
	hooks.hookfunction(mmv(0x488CA0, 0x4948A9, 0x492BCD), 1, 2, function(d, def, this, anim, unused)
		local t = {
			Animation = anim,
			Face = nil,
			Sound = nil,
			SoundCount = nil,
			SoundOffset = 0,
			ForceSound = nil,
			Allow = true,
		}
		t.PlayerIndex, t.Player = GetPlayer(this)
		-- function!Params[[()]]
		t.CallDefault = function()
			if t.Allow then
				local snd = t.Sound
				if snd and (anim == 24 and mmver == 8 and not t.ForceSound and Game.Rand()%100 > 10 or mmver == 6 and t.SoundCount == 0) then
					snd = 0
				end
				i4[p] = t.Face or -1
				i4[p + 4] = snd or -1
				i4[p + 8] = t.SoundCount or -1
				i4[p + 12] = t.SoundOffset or 0
				def(t.Player, t.Animation)
				t.Allow = false
			end
		end
		--!-
		events.cocall("InternalFaceAnimation", t)
		if t.Allow then
			--!k{Player :structs.Player}
			events.cocall("FaceAnimation", t)
		end
		t.CallDefault()
	end)
	-- face
	hooks.asmhook2(mmv(0x488DAC, 0x49498C, 0x492CD3), [[
		mmdef jmp1, 0x488DCC, 0x4949A8, 0x492CEF
		p = %face%
		%code%
	]])
	-- sound
	hooks.asmhook2(mmv(0x488D0C, 0x4948E9, 0x492C1A), [[
		mmdef jmp1, 0x488D2E, 0x494906, 0x492C4C
		p = %snd%
		%code%
	]])
	-- sound count
	hooks.asmhook2(mmv(0x488D4D, 0x494921, 0x492C67), [[
		mmdef reg, cl, edi, edi
		cmp dword [%scount%], 0
		jl @f
		mov reg, [%scount%]
	@@:
	]])
	-- sound offset
	hooks.asmhook2(mmv(0x488D61, 0x494946, 0x492C8C), [[
		add esi, [%soff%]
	]])
	-- on/off
	Conditional(hooks, {"FaceAnimation", "InternalFaceAnimation"})
end

-- dungeon enter from house (draw properly)
if mmver == 7 then
	mem.asmpatch(0x4B351C, [[
		jmp absolute 0x4B3563
	]])

	-- mem.asmhook2(0x4B34E7, [[
	-- 	mov eax, [ebx]
	-- 	movzx eax, word [eax + 0x18]
	-- 	sub eax, 63
	-- 	sar eax, 1
	-- 	sub [esp], eax	
	-- ]])
-- elseif mmver == 8 then
	-- also must load and free OK/Cancel...	
end

-- animate monsters casting
if mmver > 6 then
	-- [MM7+] Makes monsters play their regular attack animation rather then idle animation when casting damage spells if 'on' is 'true'.
	function EnableMonstersCastingAnimation(on)
		mem.prot(true)
		local v = on and 13 or 9
		i2[mm78(0x403A44, 0x403C8C) - 2] = v
		i2[mm78(0x403C50, 0x403EA1) - 2] = v
		mem.prot(false)
	end
end

-- fix Special items not getting their bonus in some cases
if mmver > 6 then
	local hooks = HookManager{
		ItemsTxtCount = mm78(0x45064E, 0x44DD98) - 4,
		SetupSpecial = mm78(0x456D51, 0x4545E8),
	}
	local code = [[
		mov eax, [esp]
		push ecx
		push eax
		mov ecx, [%ItemsTxtCount%]
		call absolute %SetupSpecial%
		pop ecx
	]]
	hooks.asmhook(mm78(0x44B366, 0x4488F8), code)  -- evt.Add("Inventory", ...)
	hooks.asmhook(mm78(0x44A94A, 0x447F47), code)  -- evt.Set("Inventory", ...)
end

-- customized summon elemental - no gold/items
if mmver > 6 then
	mem.asmhook2(mm78(0x44FB79, 0x44D2C7), [[
		xor eax, eax
		mov [esi + 9], al
		mov [esi + 0xA], eax
	]])
end

---- Player hooks

-- CalcStatBonusByItems
local ArtifactBonus = mmver > 6 and mem.StaticAlloc(8)
if ArtifactBonus then
	HookManager{
		buf = ArtifactBonus,
	}.asmhook2(mm78(0x48F60A, 0x48ECD8), [[
		mov [%buf%], eax
		mov [%buf%+4], ecx
	]])
end
local function SetArtifactBonus(t, v)
	local old = t.ArtifactBonus
	if v > old then
		t.ArtifactBonus = v
		t.Result = t.Result + v - old
	end
end
local function SetMagicBonus(t, v)
	local old = t.MagicBonus
	if v > old then
		t.MagicBonus = v
		t.Result = t.Result + v - old
	end
end
local function SetBonusMM6(t, v)
	t.Result = t.Result + v
end
mem.hookfunction(mmv(0x482E80, 0x48EAA6, 0x48E213), 1, mmv(1, 2, 2), function(d, def, this, stat, IgnoreExtraHand)
	local t = {
		-- :const.Stats
		Stat = stat,  -- const.Stats
		IgnoreExtraHand = IgnoreExtraHand and IgnoreExtraHand ~= 0,
		Result = def(this, stat, IgnoreExtraHand),
		SetArtifactBonus = ArtifactBonus and SetArtifactBonus or SetBonusMM6,
		SetMagicBonus = ArtifactBonus and SetMagicBonus or SetBonusMM6,
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	-- [MM7+]
	t.ArtifactBonus = ArtifactBonus and i4[ArtifactBonus]
	-- [MM7+]
	t.MagicBonus = ArtifactBonus and i4[ArtifactBonus + 4]
	--!k{Player :structs.Player}
	-- Here's how 'SetArtifactBonus'!Params[[(value)]] method works:
	--   [MM7+] If 'value' is bigger than 'ArtifactBonus', it modifies 'ArtifactBonus' and increases 'Result'.
	--   [MM6] It just adds the 'value' to 'Result'. The game does the same, but only includes one instance of each artifact into consideration.
	--
	-- 'SetMagicBonus' does the same to 'MagicBonus'.
	events.cocall("CalcStatBonusByItems", t)
	return t.Result
end)

-- CalcStatBonusByMagic
mem.hookfunction(mmv(0x483800, 0x48F734, 0x48EE09), 1, 1, function(d, def, this, stat)
	local t = {
		-- :const.Stats
		Stat = stat,  -- const.Stats
		Result = def(this, stat),
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	--!k{Player :structs.Player}
	events.cocall("CalcStatBonusByMagic", t)
	return t.Result
end)

-- CalcStatBonusBySkills
mem.hookfunction(mmv(0x483930, 0x48FBF8, 0x48F084), 1, 1, function(d, def, this, stat)
	local t = {
		-- :const.Stats
		Stat = stat,  -- const.Stats
		Result = def(this, stat),
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	--!k{Player :structs.Player}
	events.cocall("CalcStatBonusBySkills", t)
	return t.Result
end)

-- GetSkill
if mmver > 6 then
	mem.hookfunction(mm78(0x48F87A, 0x48EF4F), 1, 1, function(d, def, this, skill)
		local t = {
			Skill = skill,  -- const.Skills
			Result = def(this, skill),
		}
		t.PlayerIndex, t.Player = GetPlayer(this)
		--!k{Player :structs.Player} [MM7+]
		events.cocall("GetSkill", t)
		return t.Result
	end)
end

-- GetAttackDelay
mem.hookfunction(mmv(0x481A80, 0x48E19B, 0x48D62A), 1, 1, function(d, def, this, ranged)
	local t = {
		Ranged = ranged ~= 0,
		Result = def(this, ranged),
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	--!k{Player :structs.Player}
	events.cocall("GetAttackDelay", t)
	return t.Result
end)

-- CalcDamageToPlayer
mem.hookfunction(mmv(0x47F670, 0x48D499, 0x48CDA6), 1, 2, function(d, def, this, kind, dmg)
	local t = {
		-- :const.Damage
		DamageKind = kind,
		Damage = dmg,
		Result = def(this, kind, dmg),
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	--!k{Player :structs.Player}
	events.cocall("CalcDamageToPlayer", t)
	return t.Result
end)

-- Skill effects
local function SimplePlayerHook(p, name)
	mem.hookfunction(p, 1, 0, function(d, def, this)
		local t = {
			Result = def(this)
		}
		t.PlayerIndex, t.Player = GetPlayer(this)
		--!k{Player :structs.Player}
		events.cocall(name, t)
		return t.Result
	end)
end

SimplePlayerHook(mmv(0x485340, 0x4911EB, 0x49028F), "GetMerchantTotalSkill")
SimplePlayerHook(mmv(0x4853E0, 0x4912A8, 0x49031C), "GetDisarmTrapTotalSkill")

if mmver == 6 then
	SimplePlayerHook(0x4852D0, "GetDiplomacyTotalSkill")
else
	SimplePlayerHook(mm78(0x491252, 0x4902DF), "GetPerceptionTotalSkill")
	SimplePlayerHook(mm78(0x49130F, 0x49036E), "GetLearningTotalSkill")
end
if false then  -- for help
	local t = {
		Result = 1,
		-- :structs.Player
		Player = 1,
		PlayerIndex = 1,
	}
	events.cocall("GetMerchantTotalSkill", t)
	events.cocall("GetDisarmTrapTotalSkill", t)
	-- [MM6]
	events.cocall("GetDiplomacyTotalSkill", t)
	-- [MM7+]
	events.cocall("GetPerceptionTotalSkill", t)
	-- [MM7+]
	events.cocall("GetLearningTotalSkill", t)
end

-- DoBadThingToPlayer
mem.hookfunction(mmv(0x480010, 0x48DCDC, 0x48D166), 1, mmv(1, 2, 2), function(d, def, this, thing, mon)
	local t = {
		-- :const.MonsterBonus
		Thing = thing,
		Allow = true,
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	if mmver > 6 then
		t.MonsterIndex, t.Monster = GetMonster(mon)
	end
	--!k{Player :structs.Player, Monster :structs.MapMonster [MM7+], MonsterIndex [MM7+]}
	events.cocall("DoBadThingToPlayer", t)
	return t.Allow and def(this, thing, mon) or 0
end)

-- GetStatisticEffect
mem.hookfunction(mmv(0x482DC0, 0x48EA13, 0x48E18E), 0, 1, function(d, def, val)
	local t = {
		Value = val,
		Result = def(val),
	}
	events.cocall("GetStatisticEffect", t)
	return t.Result
end)

-- UseMouseItem
do
	local phases = {[1] = true, [3] = true}
	local screens = {[29] = true, [10] = true, [15] = true}
	mem.hookfunction(mmv(0x459040, 0x4680F1, 0x466572), 1, 2, function(d, def, this, player, portrait)
		if mmver > 6 and Game.TurnBased and phases[Game.TurnBasedPhase] or mmver == 8 and screens[Game.CurrentScreen] then
			return def(this, player, portrait)
		end
		local t = {
			Player = Party[player - 1],
			PlayerIndex = player - 1,
			IsPortraitClick = (portrait ~= 0),
			Allow = true,
		}
		-- function!Params[[()]]
		t.CallDefault = function()
			if t.Allow then
				def(t.ActivePlayer, t.PlayerIndex + 1, t.IsPortraitClick)
				t.Allow = false
			end
		end
		t.ActivePlayerIndex, t.ActivePlayer = GetPlayer(this)
		--!k{Player :structs.Player, ActivePlayer :structs.Player}
		events.cocall("UseMouseItem", t)
		t.CallDefault()
	end)
end

-- Regeneration

do
	local hooks = HookManager()
	hooks[mmver == 7 and 'hook' or 'autohook'](mmv(0x487F74, 0x493DC0, 0x49216B), function(d)
		if mmver == 7 and d.zf then
			u4[d.esp] = 0x493E76
		end
		local t = {HP = 0, SP = 0}
		t.PlayerIndex, t.Player = GetPlayer(d.esi)
		local pl, c = t.Player, const.Condition
		if pl.Dead ~= 0 or pl.Eradicated ~= 0 then
			return
		end
		-- 'HP' and 'SP' don't include regeneration values assigned by the game, but setting them takes care of conditions
		--!k{Player :structs.Player}
		events.cocall('Regeneration', t)
		if t.HP ~= 0 then
			local v = pl.HP
			v = min(v + t.HP, max(v, pl:GetFullHP()))
			pl.HP = v
			if v > 0 and pl.Unconscious ~= 0 then
				pl.Unconscious = 0
				Game.NeedRedraw = true
			end
		end
		
		if t.SP > 0 then
			pl.SP = min(pl.SP + t.SP, max(pl.SP, pl:GetFullSP()))
		elseif t.SP < 0 then
			pl.SP = max(pl.SP + t.SP, 0)
		end
	end)
	Conditional(hooks, "Regeneration")
end

-- ModifyItemDamage
local function ModifyItemDamage(dmg, mon, pl, slot)
	local t = {Damage = dmg, Result = dmg, MonsterId = mon, Slot = slot}
	local i = (pl - Party.PlayersArray["?ptr"]):div(Party.PlayersArray[0]["?size"])
	t.PlayerIndex, pl = i, Party.PlayersArray[i]
	t.Player, t.Item = pl, pl:GetActiveItem(slot, true)
	events.cocall("ModifyItemDamage", t)
	return t.Result
end

if mmver == 6 then
	mem.autohook(0x47E4B0, function(d)
		d.edi = ModifyItemDamage(d.edi, i4[d.esp + 0x2C], d.esi, 1)
	end)
	mem.autohook(0x47E5CE, function(d)
		d.edi = ModifyItemDamage(d.edi, i4[d.esp + 0x2C], d.esi, 0)
	end)
	mem.autohook2(0x47EB40, function(d)
		d.edi = ModifyItemDamage(d.edi, i4[d.esp + 0xC], d.ecx, 2)
	end)
elseif mmver == 7 then
	mem.autohook(0x48CE7F, function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.esp + 0x2C], d.edi, 1)
	end)
	mem.autohook(0x48CFAA, function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.esp + 0x2C], d.edi, 0)
	end)
	mem.autohook(0x48D260, function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.ebp + 0x8], d.ebx, 2)
	end)
else
	mem.autohook(0x48C810, function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.esp + 0x28], d.edi, 1)
	end)
	mem.autohook(mm78(0x48CFAA, 0x48C92A), function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.esp + 0x28], d.edi, 0)
	end)
	mem.autohook(mm78(0x48D260, 0x48CB80), function(d)
		d.esi = ModifyItemDamage(d.esi, i4[d.ebp + 0x8], d.ebx, 2)
	end)
end


---- Monster hooks

-- MonsterKilled
mem.hookfunction(mmv(0x403050, 0x402D6E, 0x402E78), 1, 0, function(d, def, index)
	local function callDef()
		def = def and def(index) and nil
	end
	--!(mon:structs.MapMonster, monIndex, defaultHandler)
	events.cocall("MonsterKilled", Map.Monsters[index], index, callDef)
	callDef()
end)


if mmver > 6 then
	-- MonsterKinds
	local KindPtr = mem.StaticAlloc(8)
	local f = mm78(0x438BCE, 0x436542)
	internal.MonsterKindPtr = KindPtr
	do
		local n = mm78(276, 198) + 1
		local p = mem.allocMM(8*n)
		mem.fill(p, 8*n)
		for i = 0, n - 1 do
			for j = 1, 8 do
				if call(f, 2, i, j) ~= 0 then
					u1[p + i*8 + j - 1] = 1
				end
			end
		end
		u4[KindPtr], u4[KindPtr + 4] = p, n
	end
	HookManager{ptr = KindPtr, psize = KindPtr + 4}.asmhook(f, [[
		cmp ecx, [%psize%]
		jnb @std
		lea eax, [edx - 1]
		test eax, 0xFFFFFFF8
		jnz @std
		lea eax, [ecx*8 + eax]
		mov ecx, [%ptr%]
		movzx eax, byte [ecx + eax]
		ret
	@std:
	]])
	
	local ItemAdditionalDamage_ret = table.invert(mm78({0x439930, 0x4399C1}, {0x437336, 0x437449}))
	
	-- ItemAdditionalDamage
	mem.hookfunction(mm78(0x439E16, 0x4378CD), 2, 1, function(d, def, item, kind, vampiric)
		local t = {
			Item = structs.Item:new(item),
			Result = def(item, kind, vampiric),
		}
		-- :const.Damage
		t.DamageKind = i4[kind]
		t.Vampiric = (i4[vampiric] ~= 0)
		-- [MM7+]
		events.cocall("ItemAdditionalDamage", t)
		i4[kind] = t.DamageKind
		i4[vampiric] = (t.Vampiric and 1 or 0)
		return t.Result
	end)
end


-- CalcDamageToMonster
mem.hookfunction(mmv(0x421DC0, 0x427522, 0x425951), 0, 3, function(d, def, mon, kind, dmg)
	local t = {
		-- :const.Damage
		DamageKind = kind,
		Damage = dmg,
		Result = def(mon, kind, dmg),
	}
	t.MonsterIndex, t.Monster = GetMonster(mon)
	--!k{Monster :structs.MapMonster}
	events.cocall("CalcDamageToMonster", t)
	return t.Result
end)

-- PickCorpse
mem.hookfunction(mmv(0x421670, 0x426A03, 0x424E3D), 0, 1, function(d, def, mon)
	local t = {
		Allow = true,
	}
	-- function!Params[[()]]
	t.CallDefault = function()
		if t.Allow then
			def = def and def(mon) and nil
			t.Allow = false
		end
	end
	t.MonsterIndex, t.Monster = GetMonster(mon)
	--!k{Monster :structs.MapMonster}
	events.cocall("PickCorpse", t)
	t.CallDefault()
end)

-- CastTelepathy
if mmver > 6 then
	mem.hookfunction(mm78(0x4086E9, 0x408E89), 1, 0, function(d, def, mon)
		local t = {
			Allow = true,
		}
		-- function!Params[[()]]
		t.CallDefault = function()
			if t.Allow then
				def = def and def(mon) and nil
				t.Allow = false
			end
		end
		t.MonsterIndex, t.Monster = GetMonster(mon)
		--!k{Monster :structs.MapMonster} [MM7+]
		events.cocall("CastTelepathy", t)
		t.CallDefault()
	end)
end

-- CanMonsterCastSpell
delayed(|| if mmver > 6 then
	local hooks = HookManager()
	local p1 = hooks.hookfunction(mm78(0x4270B9, 0x4254BA), 1, mm78(2, 3), function(d, def, ai, mon, spell, dist)
		local t = {
			Spell = spell,
			-- [MM8]
			Distance = dist,
			Allow = def(ai, mon, spell, dist),
		}
		t.MonsterIndex, t.Monster = GetMonster(mon)
		--!k{Monster :structs.MapMonster} [MM7+]
		events.cocall("CanMonsterCastSpell", t)
		return t.Allow
	end)
	Conditional(hooks, "CanMonsterCastSpell")
end)

-- MonsterChooseAction
do
	local hooks = HookManager()
	hooks.hookfunction(mmv(0x421C50, 0x427002, 0x4253DF), 1, mmv(1, 2, 3), function(d, def, ai, mon, monIndex, dist)
		local t = {
			-- :const.MonsterAction
			Action = nil,
			-- :structs.MapMonster
			Monster = mmver > 6 and Map.Monsters[monIndex],
			MonsterIndex = monIndex,
			-- [MM8]
			Distance = dist,
		}
		if mmver == 6 then
			t.MonsterIndex, t.Monster = GetMonster(mon)
		end
		-- function!Params[[()]]
		t.CallDefault = function()
			local r = def(ai, mon, monIndex, dist)
			t.Action = r
			return r
		end
		-- 'Action' starts uninitialized. Each time you call 'CallDefault', it generates new result, assigns it to 'Action' and returns the value.
		events.cocall("MonsterChooseAction", t)
		return t.Action or def(ai, mon, monIndex, dist)
	end)
	Conditional(hooks, "MonsterChooseAction")
end


-- monster/player attacked
do
	local Mon_Who, Mon_Idx, Pl_Who, Pl_Slot

	local function Who(i, action)
		local t, kind = {}, i%8
		i = (i - kind)/8
		if kind == 2 then
			local obj = Map.Objects[i]
			t.ObjectIndex, t.Object = i, obj
			i = obj.Owner
			kind = i%8
			i = (i - kind)/8
		end
		if kind == 4 then
			t.PlayerIndex, t.Player = i, Party.PlayersArray[i]
		elseif kind == 3 then
			t.MonsterIndex, t.Monster, t.MonsterAction = i, Map.Monsters[i], action
		end
		return t
	end

	-- If a monster is being attacked, returns 't', 'TargetMonsterIndex'.
	-- #t.Player:structs.Player# and 't.PlayerIndex' are set if monster is attacked by the party.
	-- #t.Monster:structs.MapMonster#, 't.MonsterIndex' and #t.MonsterAction:const.MonsterAction# fields are set if monster is attacked by another monster.
	-- #t.Object:structs.MapObject# and 't.ObjectIndex' are set if monster is hit by a missile.
	-- Note that 't.Object' can be set at the same time as 't.Monster' or 't.Player'.
	function WhoHitMonster()
		return Mon_Who, Mon_Idx
	end

	local function HitMon(d, def, attackerID, monIndex, speed, action)
		local attacker, old, old2 = Who(attackerID, action), Mon_Who, Mon_Idx
		Mon_Who, Mon_Idx = attacker, monIndex
		local t = {
			-- table returned by #WhoHitMonster:#
			Attacker = attacker,
			MonsterIndex = monIndex,
			-- :structs.MapMonster
			Monster = Map.Monsters[monIndex],
			Handled = false,
		}
		
		-- Called when a player or a projectile tries to hit a monster. Can be used to completely replace what happens.
		events.cocall("MonsterAttacked", t, attacker)
		if not t.Handled then
			def(attackerID, monIndex, speed, action)
		end
		--!k{Handled carried over from #MonsterAttacked:events.MonsterAttacked# event}
		events.cocall("AfterMonsterAttacked", t, attacker)
		Mon_Who, Mon_Idx = old, old2
	end

	mem.hookfunction(mmv(0x430E50, 0x439463, 0x436E26), 2, 1, HitMon)  -- from party
	if mmver > 6 then
		mem.hookfunction(mm78(0x43B07A, 0x438C6E), 2, 1, HitMon)  -- from event
		mem.hookfunction(mm78(0x43B1D3, 0x438DDE), 2, 2, HitMon)  -- from monster
	end
	
	-- If a player is being attacked, returns 't', 'PlayerSlot'.
	-- #t.Monster:structs.MapMonster#, 't.MonsterIndex' and #t.MonsterAction:const.MonsterAction# fields are set if player is attacked by a monster.
	-- #t.Object:structs.MapObject# and 't.ObjectIndex' are set if player is hit by a missile.
	-- Note that 't.Object' and 't.Monster' can be set at the same time if the projectile was fired by a monster.
	function WhoHitPlayer()
		return Pl_Who, Pl_Slot
	end
	
	local function HitPlayer(d, def, attackerID, action, speed, slot)
		local attacker, old, old2 = Who(attackerID, action), Pl_Who, Pl_Slot
		-- choose the player slot the same way the function does it
		if slot == -1 then
			local m = attacker.Monster
			if m then
				slot = m:ChooseTargetPlayer()
			else
				local t = {}
				for i, pl in Party.Players do
					if pl:IsConscious() then
						t[#t + 1] = i
					end
				end
				slot = t[Game.Rand() % #t + 1]
			end
		end
		
		Pl_Who, Pl_Slot = attacker, slot
		local t = {
			-- table returned by #WhoHitPlayer:#
			Attacker = attacker,
			-- :structs.Player
			Player = Party[slot],
			PlayerSlot = slot,
			Handled = false,
		}
		
		-- Called when a monster or a projectile tries to hit a player. Can be used to completely replace what happens.
		events.cocall("PlayerAttacked", t, attacker)
		if not t.Handled then
			def(attackerID, action, speed, slot)
		end
		--!k{Handled carried over from #PlayerAttacked:events.PlayerAttacked# event}
		events.cocall("AfterPlayerAttacked", t, attacker)
		Pl_Who, Pl_Slot = old, old2
	end
	
	mem.hookfunction(mmv(0x431BE0, 0x439FEE, 0x437B06), 2, 2, HitPlayer)  -- from anything
end


mem.IgnoreProtection(false)