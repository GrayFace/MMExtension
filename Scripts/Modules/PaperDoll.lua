--[=[!File
To use, first place the PaperDol.txt file #[[https://github.com/GrayFace/MMExtension/tree/master/Misc/Paper%20Doll]]from here# corresponding to your game of choice into DataFiles folder (create it right next to Data folder of the game if it doesn't exist). Modify it as needed. You'll later distribute this file inside a LOD achive of your mod.

Including the module:
!LUA[[
require"PaperDoll"
]]

How it works:
#PaperDollDrawOrder:# defines the order in which pieces of body and clothing are drawn. #PaperDollHiddenPieces:events.PaperDollHiddenPieces# event can be used to change which pieces would be drawn. PaperDol.txt can specify custom graphics and coordinates for any piece. Lines further in the table take precedence. If 'Doll' includes current player, 'Piece' matches piece being drawn and 'ItemPicture' matches picture of the item being drawn (or ":Player" for a piece of player body), specified 'Image', 'X' and 'Y' values are used.
A special case is when you specify item slot as 'ItemPicture', e.g. ":Armor". In this case 'X' and 'Y' act as offsets added to whatever coordinates are specified for the item in #Armor:structs.Player.ItemArmor# slot. If you specify 'Mul' for a slot, coordinates of the item are multiplied by it. It can also contain 4 values "a1,a2,a3,a4" that work this way: !Lua[[x = a1*X + a2*Y; y = a3*X + a4*Y]]. Setting 'Mul' to "0,-1,1,0" or similar 90 degree rotation matrices would cause the item to be drawn rotated in MM8.

Special 'ItemPicture' values:
item1 - override "item1" graphics
:Player - override piece of the body
:Player:Armor - override piece of the body if any Armor is equipped
:Player.item1 - override piece of the body if "item1" is equipped
:Player:Armor.item1 - override piece of the body if "item1" is equipped as Armor
:Belt:Armor.item1 - override any belt if "item1" if equipped as Armor
item2:Belt:Armor - override "item2" equipped as Belt if anything is equipped as Armor
item2:Belt.item1 - override "item2" equipped as Belt if "item1" is equipped
item2:Belt:Armor.item1 - override "item2" equipped as Belt if "item1" is equipped as Armor

]=]
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar

local mmver = Game.Version
local function mmv(...)
	return (select(mmver - 5, ...))
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

--!v Maps category name to a !lua[[function(i)]] that returns 'true' if player face number 'i' belongs to the category. Use #PaperDollAddBodies:# or #PaperDollAddRace:# to populate in a custom way.
PaperDollCategories = {}
PaperDollGraphics = {}
--!v Specifies which pieces inherit item graphics by default. Default:
-- !Lua[[{ItemExtraHand = {hand2 = true, shield = true}}]]
-- For slots not specified here piece with empty name is the main one.
PaperDollMainPieces = {ExtraHand = {hand2 = true, shield = true}}
local PaperDollMainPiecesStd = {[''] = true}
local CurDollGraphics

-- populate categories:

local sex = {[0] = 'm', 'f', [false] = ''}

local function GetSexRace(i)
	local pl = Party.PlayersArray[0]
	local GetSex, GetRace = pl.GetSex, pl.GetRace
	if not GetSex then
		return i > 7
	end
	local old1, old2 = pl.Face, pl.Voice
	pl.Face, pl.Voice = i, i
	local s, r = GetSex(pl), GetRace and GetRace(pl)
	pl.Face, pl.Voice = old1, old2
	return s, r
end

function PaperDollAddRace(name, races)
	name = name:lower()
	for sex, ssex in pairs(sex) do
		PaperDollCategories[ssex..name] = function(i)
			local s, r = GetSexRace(i)
			return (not sex or (s == sex)) and (not races or races[r])
		end
	end
end

-- Defines doll categories for 'bodies' array together with male and female variations of each.
-- If 'bodies' table isn't specified, uses #PaperDollSpecialBodies:# table and defines the "Base" paper dolls as well.
function PaperDollAddBodies(bodies)
	local t = bodies and {} or {base = true}
	bodies = bodies or PaperDollSpecialBodies
	for i, s in pairs(bodies) do
		t[s:lower()] = true
	end
	for sex, ssex in pairs(sex) do
		for s in pairs(t) do
			PaperDollCategories[ssex..s] = |i| (bodies[i] or 'base'):lower() == s and (not sex or GetSexRace(i) == sex)
		end
	end
end

PaperDollAddRace('')
if mmver == 7 then
	for k, v in pairs(const.Race) do
		PaperDollAddRace(k, {[v] = true})
	end
	--!v [MM7] Races that share the "Base" paper doll. Default:
	-- !Lua[[{[const.Race.Human] = true, [const.Race.Goblin] = true, [const.Race.Elf] = true}]]
	-- After altering it, call this command:
	-- !Lua[[PaperDollAddRace('Base', PaperDollBaseRace)]]
	PaperDollBaseRace = PaperDollBaseRace or {[0] = true, true, true}
	-- [MM7]
	PaperDollAddRace('base', PaperDollBaseRace)
elseif mmver == 8 then
	--!v After altering it, call #PaperDollAddBodies:#. Here are default MM8 values:
	-- !Lua[[{[20] = 'Minotaur', [21] = 'Minotaur', [22] = 'Troll', [23] = 'Troll', [24] = 'Dragon', [25] = 'Dragon'}]]
	PaperDollSpecialBodies = PaperDollSpecialBodies or {[20] = 'Minotaur', [21] = 'Minotaur', [22] = 'Troll', [23] = 'Troll', [24] = 'Dragon', [25] = 'Dragon'}
	PaperDollAddBodies()
end
PaperDollSpecialBodies = PaperDollSpecialBodies or {}

local function GetCats(s)
	local q = s:lower():split(', *')
	local t = {}
	for i, s in ipairs(q) do
		local n = tonumber(s)
		if n then
			q[i] = nil
			t[n - 1] = true
		else
			q[i] = PaperDollCategories[s]
		end
	end
	for i = 0, Game.PlayerFaces.high do
		for _, f in pairs(q) do
			if f(i) then
				t[i] = true
			end
		end
	end
	return t
end

-- 't' can be a string following the "PaperDol.txt" convention or a table that's similar to the result of calling #ParseNamedColTable:# for such file.
-- Example - loading additional paper doll file for mods:
-- !Lua[[events.ReloadPaperDollGraphics = || AddPaperDollGraphics(Game.LoadTextFileFromLod'PaperMod.txt')]]
function AddPaperDollGraphics(t)
	if type(t) == 'string' then
		t = ParseNamedColTable(t)
	end
	for _, a in ipairs(t) do
		local a1 = {X = tonumber(a.X), Y = tonumber(a.Y)}
		if (a.Mul or '') ~= '' then
			local t = (a.Mul or ''):split(', *')
			if not t[2] then
				t = {t[1], 0, 0, t[1]}
			end
			for i = 1, #t do
				t[i] = tonumber(t[i])
			end
			a1.Mul = t
		end
		for i in pairs(GetCats(a.Doll or '')) do
			local a1 = table.copy(a1)
			a1.Image = a.Image and a.Image:format(i+1) or ''
			local move, piece = (a.Piece or ''):match('^(>?)(.*)')
			tget(tget(PaperDollGraphics, i), piece)[(a.ItemPicture or ''):lower()] = a1
			if move ~= '' then
				local a2 = table.copy(a1)
				a2.Image = ''
				tget(tget(PaperDollGraphics, i), '')[(a.ItemPicture or ''):lower()] = a2
			end
		end
	end
end

-- Reloads "PaperDol.txt" and calls #ReloadPaperDollGraphics:events.ReloadPaperDollGraphics# event. Very handy while tweaking "PaperDol.txt"
function ReloadPaperDollGraphics()
	PaperDollGraphics = {}
	AddPaperDollGraphics(Game.LoadTextFileFromLod'PaperDol.txt')
	-- When corresponding #ReloadPaperDollGraphics:# function is called
	events.cocall('ReloadPaperDollGraphics')
end

if GameInitialized2 then
	ReloadPaperDollGraphics()
else
	events.GameInitialized2 = ReloadPaperDollGraphics
end

--!v Defaults to #Game.Version:#. If set to '8', spears aren't treated as 2-handed weapons.
PaperDollMode = PaperDollMode or mmver

--!v Default (depending on #PaperDollMode:#):
-- !Lua[[{'BackDoll', 'BackDoll.menu', 'BackDoll.game',
-- 	'Bow', 'Cloak',
-- 	'Armor.back', 'Belt.back',
-- 	'Player', 'Player.arm1', 'Player.arm1f', 'Player.arm2b', 'Player.arm2hb', 'Player.arm2fb', 'Player.shield', 'Player.hair2', 'Player.hair',
-- 	'Armor.back2',
-- 	'Helm.back', 'Boots.back',
-- 	'Armor',
-- 	'Boots',
-- 	'Armor.front', 'Armor.arm1', 'Armor.arm1f',
-- 	'Belt',
-- 	'Player.arm2', 'Player.arm2h', 'Armor.arm2', 'Armor.arm2h', 'Player.arm2f',
-- 	'Cloak.scarf', 'Player.scarf', 'Helm', 'Cloak.scarf2',
-- 	'MainHand',
-- 	'Player.hand1a', 'Player.hand1', 'Player.hand1f', 'Armor.hand1a', 'Armor.hand1', 'Armor.hand1f',
-- 	'ExtraHand.hand2', 'ExtraHand.shield',
-- 	'Player.hand2', 'Player.hand2f', 'Player.hand2h', 'Armor.hand2', 'Armor.hand2f', 'Armor.hand2h',
-- }]]
--
-- See #PaperDollHiddenPieces:events.PaperDollHiddenPieces# event for conditions under which each piece is visible.
PaperDollDrawOrder = {'BackDoll', 'BackDoll.menu', 'BackDoll.game',
	'Bow', 'Cloak',
	'Armor.back', 'Belt.back',
	'Player', 'Player.arm1', 'Player.arm1f', 'Player.arm2b', 'Player.arm2hb', 'Player.arm2fb', 'Player.shield', 'Player.hair2', 'Player.hair',
	'Armor.back2',
	'Helm.back', 'Boots.back',
	'Armor',
	'Boots',
	'Armor.front', 'Armor.arm1', 'Armor.arm1f',
	'Belt',
	'Player.arm2', 'Player.arm2h', 'Armor.arm2', 'Armor.arm2h', 'Player.arm2f',
	'Cloak.scarf', 'Player.scarf', 'Helm', 'Cloak.scarf2',
	'MainHand',
	'Player.hand1a', 'Player.hand1', 'Player.hand1f', 'Armor.hand1a', 'Armor.hand1', 'Armor.hand1f',
	'ExtraHand.hand2', 'ExtraHand.shield',
	'Player.hand2', 'Player.hand2f', 'Player.hand2h', 'Armor.hand2', 'Armor.hand2f', 'Armor.hand2h',
}

local function Is2Handed(it)
	local a = it:T()
	return a.EquipStat == 1 or (PaperDollMode ~= 8) and a.Skill == 4
end

local function IsShield(it)
	return it:T().EquipStat == 4
end

local function GetItemGraphics(it, i)
	local a = it:T()
	return {Image = a.Picture:lower(), X = a.EquipX, Y = a.EquipY, Item = it, Index = i}
end

local DrawCache
local DrawStyles = {[0] = 'green', false, 'red', 'red'}  -- unid, norm, brk, brk
local RingsShown = mmv(0x4D50F0, 0x511760, 0x523040)
local EffectItem
local InMenu
local DrawOffsetX, DrawOffsetY = 0, 0

local function draw(a, it, idx, off, style)
	if not a or a.Image == '' then
		return
	end
	off = off or {}
	local m = a.Mul or off.Mul or {}
	local x = a.X*(m[1] or 1) + a.Y*(m[2] or 0) + (off.X or 0)
	local y = a.X*(m[3] or 0) + a.Y*(m[4] or 1) + (off.Y or 0)
	local rot = m[3] or 0
	if mmver > 6 then
		local p = mm78(0x4E4BF8, 0x4F5890)
		x = x + i4[p] + DrawOffsetX
		y = y + i4[p + 4] + DrawOffsetY
	end
	x = x + (PaperDollOffsetX or 0)
	y = y + (PaperDollOffsetY or 0)
	-- DrawLog[#DrawLog+1] = table.concat({a.Image, x, y}, ", ")
	local pic = DrawCache[a.Image] or Game.IconsLod:LoadBitmap(a.Image)
	DrawCache[a.Image] = pic
	if rot ~= 0 then
		y = y - Game.IconsLod.Bitmaps[pic].Width
	end
	local cond = it and it.Condition or 1
	local ef = cond:And(0xf0)
	if ef ~= 0 and mmver > 6 then
		local s = ef == 32 and "sp28a" or ef == 64 and "sp30a" or ef == 128 and "sp91a" or "sptext01"
		Screen:DrawItemEffect(x, y, pic, s, nil, nil, nil, rot)
		EffectItem = it
	else
		Screen:Draw(x, y, pic, style or DrawStyles[cond:And(3)], rot)
	end
	if idx and i4[RingsShown] == 0 then
		Screen:DrawToObjectByPixel(x, y, pic, idx, rot)
	end
end

-- only used in MM7
local function draw2(x, y, img)
	draw(tget(CurDollGraphics, '')[img:lower()] or {X = x - 481, Y = y, Image = img})
end

local function GetHiddenPieces(pl)
	local hide = {}
	-- 2nd arm for 2-handed weapon
	hide.arm2h = true  -- dual wield off by default
	if pl.ItemExtraHand == 0 then
		-- 2nd hand for dual-wielding
		hide.hand2 = true  -- 2nd hand off
		-- drawn when holding a shield
		hide.shield = true  -- hand under shield off
		local n = pl.ItemMainHand
		if n ~= 0 and Is2Handed(pl.Items[n]) then
			-- 2nd arm without 2-handed weapon
			hide.arm2 = true
			hide.arm2h = nil
			-- 2nd arm when not holding anything
			hide.arm2f = true  -- no free hand
		end
	else
		hide.arm2f = true  -- no free hand
		hide.hand2 = IsShield(pl.Items[pl.ItemExtraHand])  -- 2nd hand
		hide.shield = not hide.hand2  -- hand under shield
	end
	hide[InMenu and 'game' or 'menu'] = true
	-- 2nd arm without 2-handed weapon, drawn behind armor
	hide.arm2b = hide.arm2
	-- 2nd arm when not holding anything, drawn behind armor
	hide.arm2fb = hide.arm2f
	-- 2nd hand when not holding anything
	hide.hand2f = hide.arm2f
	-- 2nd hand for 2-handed weapon
	hide.hand2h = hide.arm2h
	-- 2nd arm for 2-handed weapon, drawn behind armor
	hide.arm2hb = hide.arm2h
	-- 1st arm when holding a weapon
	hide.arm1 = pl.ItemMainHand == 0
	-- 1st arm without a weapon
	hide.arm1f = not hide.arm1
	-- 1st hand when holding a weapon
	hide.hand1 = hide.arm1
	-- 1st hand when not holding a weapon
	hide.hand1f = not hide.arm1
	local player = pl
	--!k{hand1a 1st hand (always drawn), menu in new game menu (for BackDoll in MM8), game in game (for BackDoll in MM8)} Here I've described pieces that 'PaperDoll' module handles automatically. You can define your own pieces through #PaperDollDrawOrder:# array and hide them conditionally here.
	events.cocall('PaperDollHiddenPieces', hide, player)
	hide.Player = nil
	return hide
end

local function GetItems(pl)
	local t = {BackDoll = 'solid', Player = true}
	for k, v in pairs(const.ItemSlot) do
		t[k] = pl.EquippedItems[v]
	end
	--!(t, player) Lets you modify weared items, such as add new weared item slots. E.g. setting !Lua[[t.My = 1]] would draw !Lua[[pl.Items[1]]]. Setting !Lua[[t.My = true]] would make ":My" drawn the same way ":Player" is drawn. You'll also need to add "My" to #PaperDollDrawOrder:#. If you set !Lua[[t.My = "solid"]], ":My" would be drawn without transparency, just like ":BackDoll".
	events.cocall('PaperDollGetItems', t, pl)
	for k, i in pairs(t) do
		t[k] = (i == true and {} or i == 'solid' and {DrawStyle = true} or i ~= 0 and GetItemGraphics(pl.Items[i], i) or nil)
	end
	return t
end

local function DrawDoll(pl)
	-- DrawLog = {P = || table.concat(DrawLog, "\n")}
	CurDollGraphics = tget(PaperDollGraphics, pl.Face)
	EffectItem = nil
	local hide = GetHiddenPieces(pl)
	local wear = GetItems(pl)
	local face = pl.Face
	local function Override(t, s, fmt, fmt2)
		fmt, fmt2 = fmt or ':%s', fmt2 or '.%s'
		for k, a in pairs(wear) do
			a = a.Image and t[s..fmt:format(k:lower())..fmt2:format(a.Image)]
			if a then
				return a
			end
		end
	end

	for _, s in ipairs(PaperDollDrawOrder) do
		local s, piece = s:match('^([^.]*)%.?([^.]*)$')
		local a = wear[s]
		if a and not hide[piece] then
			local style = a.DrawStyle
			local class, t = ':'..s:lower(), tget(CurDollGraphics, piece)
			local it, idx = a.Item, a.Index
			local over = it and (Override(t, a.Image..class) or Override(t, a.Image..class, '') or Override(t, a.Image..class, nil, '') or Override(t, a.Image, '', ''))
					or Override(t, class) or Override(t, class, '') or Override(t, class, nil, '')
			if over then
				a = table.copy(over, {Image = a.Image, X = a.X, Y = a.Y}, true)
			end
			if not a.Item then       -- :Player or override
				a = a.Image and a or t[class]
			elseif not (PaperDollMainPieces[s] or PaperDollMainPiecesStd)[piece] then
				a = nil                -- only draw item as the main piece
			end
			draw(a, it, idx, it and t[class], style)
		end
	end
	
	-- decrease effect time
	if EffectItem then
		local EffectTime = mm78(0x50C828, 0x51E100)
		local time = max(i4[EffectTime] - Game.TimeDelta, 0)
		i4[EffectTime] = time
		if time == 0 then
			i4[mm78(0x50C824, 0x51E0FC)] = 0
			EffectItem.Condition = EffectItem.Condition:AndNot(0xf0)
		end
	end
end

if mmver == 6 then
	mem.hook(0x4123A6, |d| do
		DrawDoll(Party[i4[d.esp + 0x28 - 4] - 1])
		d.ebx = u4[0x9B108C]
		u4[d.esp] = 0x412D24
	end)
	
	-- don't load old graphics
	mem.autohook2(0x411ED8, || DrawCache = {})
	mem.nop2(0x411EDD, 0x411F50)
	mem.nop2(0x411FAF, 0x4120E7)
	mem.nop2(0x4121BE, 0x41235C)
elseif mmver == 7 then
	mem.hook(0x43CD55, |d| do
		DrawDoll(Party[d.eax - 1])
		if i4[RingsShown] == 0 then
			draw2(603, 299, "MAGNIF-B")
			if PaperDollDrawCustomBorder then
				draw2(PaperDollDrawCustomBorder())
			else
				Screen:Draw(468, 0, i4[0x507984])
			end
		end
		u4[d.esp] = 0x43E840
	end)

	if PaperDollDrawCustomBorder then
		mem.nop2(0x43E8A2, 0x43E8C9)
		mem.hook(0x43E8A2, |d| do
			draw2(PaperDollDrawCustomBorder())
		end)
	end

	-- don't load old graphics
	mem.nop2(0x43BD56, 0x43BE9D)  -- wetsuit
	mem.nop2(0x43BEA9, 0x43C009)  -- no wetsuit
	mem.nop2(0x43C0C6, 0x43C938)  -- rest of graphics

	mem.hook(0x43C0C6, || DrawCache = {})
else
	local function DrawDollMem(p, x, y, menu)
		InMenu = menu
		DrawOffsetX, DrawOffsetY = x, y
		DrawDoll(Party.PlayersArray[(p - Party.PlayersArray['?ptr']):div(0x1D28)])
	end
	
	mem.asmpatch(0x43A499, 'add esp, 0xC')  -- don't draw backdoll
	mem.hook(0x43A4D9, |d| do
		DrawDollMem(d.eax, 0, 0)
		u4[d.esp] = 0x43BAD8
	end)
	
	-- don't load old graphics
	mem.asmpatch(0x439966, 'xor eax, eax')  -- load 1st backdoll
	mem.nop2(0x43999D, 0x43A073)

	mem.hook(0x43999D, || DrawCache = {})
	
	-- new game menu
	mem.nop2(0x4C4EE1, 0x4C50CB)
	mem.hook(0x4C4EE1, |d| do
		DrawCache = {}
		DrawDollMem(d.eax, -13, 31, true)
	end)
end