--[=[!File
To use, first place the PaperDol.txt file #[[https://github.com/GrayFace/MMExtension/tree/master/Misc/Paper%20Doll]]from here# corresponding to your game of choice into DataFiles folder (create it right next to Data folder of the game if it doesn't exist). Modify it as needed. You'll later distribute this file inside a LOD achive of your mod.

Including the module:
!LUA[[
require"PaperDoll"
]]

How it works:
#PaperDollDrawOrder:# defines the order in which pieces of body and clothing are drawn. #PaperDollHiddenPieces:events.PaperDollHiddenPieces# event can be used to change which pieces would be drawn. PaperDol.txt can specify custom graphics and coordinates for any piece. Lines further in the table take precedence. If 'Doll' includes current player, 'Piece' matches piece being drawn and 'ItemPicture' matches picture of the item being drawn (or ":Player" for a piece of player body), specified 'Image', 'X' and 'Y' values are used.
A special case is when you specify item slot as 'ItemPicture', e.g. ":Armor". In this case 'X' and 'Y' act as offsets added to whatever coordinates are specified for the item in #Armor:structs.Player.ItemArmor# slot. If you specify 'Mul' for a slot, coordinates of the item are multiplied by it. It can also contain 4 values "a1,a2,a3,a4" that work this way: !Lua[[x = a1*X + a2*Y; y = a3*X + a4*Y]]. Setting 'Mul' to "0,-1,1,0" or similar 90 degree rotation matrices would cause the item to be drawn rotated in MM8.

Coordinates are given relative to the following point:
MM6 and MM7 - (481, 0), MM8 - (467, 23).
You can change it by modifying #Game.DialogLogic.PaperDollPositionX:structs.DialogLogic.PaperDollPositionX# and #Game.DialogLogic.PaperDollPositionY:structs.DialogLogic.PaperDollPositionY#, but changing it only affects paper doll position and not BACKDOLL or interface above paper doll.

Options for 'ItemPicture' values:
item1  !--  Override "item1" graphics
:Player  !--  Override piece of the body
:ExtraHand.item1  !--  Override "item1" graphics if equipped in the second hand
:Player:if:Armor  !--  Override piece of the body if any Armor is equipped
:Player:if.item1  !--  Override piece of the body if "item1" is equipped
:Player:if:Armor.item1  !--  Override piece of the body if "item1" is equipped as Armor
:Belt:if:Armor.item1  !--  Override any belt if "item1" if equipped as Armor
:Belt.item2:if:Armor  !--  Override "item2" equipped as Belt if anything is equipped as Armor
:Belt.item2:if.item1  !--  Override "item2" equipped as Belt if "item1" is equipped
:Belt.item2:if:Armor.item1  !--  Override "item2" equipped as Belt if "item1" is equipped as Armor

"insert" command:
'ItemPicture' may start with ":insert" in order to insert a new piece to draw into #PaperDollDrawOrder:#. It's an alternative to doing that in Lua code. TODO: I'll describe it some other day.
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
--!v Specifies which pieces inherit item graphics by default. For slots not specified here piece with empty name is the main one.
-- Default:
-- !Lua[[{ExtraHand = {hand2 = true, shield = true}, Gauntlets = {ring = true}, Amulet = {ring = true}, Ring1 = {ring = true}, Ring2 = {ring = true}, Ring3 = {ring = true}, Ring4 = {ring = true}, Ring5 = {ring = true}, Ring6 = {ring = true}}]]
PaperDollMainPieces = {ExtraHand = {hand2 = true, shield = true}, Gauntlets = {ring = true}, Amulet = {ring = true}, Ring1 = {ring = true}, Ring2 = {ring = true}, Ring3 = {ring = true}, Ring4 = {ring = true}, Ring5 = {ring = true}, Ring6 = {ring = true}}
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

local function AddGraphicsItem(a)
	local a1 = {X = tonumber(a.X), Y = tonumber(a.Y), PivotX = tonumber(a.PivotX), PivotY = tonumber(a.PivotY)}
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
		local a2 = table.copy(a1, {Image = a.Image and a.Image:format(i+1) or ''}, true)
		local move, piece = (a.Piece or ''):match('^(>?)(.*)')
		tget(tget(PaperDollGraphics, i), piece)[(a.ItemPicture or ''):lower()] = a2
		if move ~= '' then
			tget(tget(PaperDollGraphics, i), '')[(a.ItemPicture or ''):lower()] = table.copy(a1, {Image = ''}, true)
		end
	end
end

local function AddDrawOrderPiece(a, part)
	local new = (a.Piece or '') ~= '' and part..'.'..a.Piece or part
	local after = (a.Image or ''):match('^after:(.+)')
	local old = after or a.Image or ''
	local iold = table.ifind(PaperDollDrawOrder, old) or old == '' and (after and #PaperDollDrawOrder or 1)
	assert(iold, 'insert command - insertion point not found')
	local inew = table.ifind(PaperDollDrawOrder, new)
	if iold == inew then
		return
	elseif inew then
		table.remove(PaperDollDrawOrder, inew)
		if iold > inew then
			iold = iold - 1
		end
	end
	table.insert(PaperDollDrawOrder, after and iold + 1 or iold, new)
end

-- 't' can be a string following the "PaperDol.txt" convention or a table that's similar to the result of calling #ParseNamedColTable:# for such file.
-- Example - loading additional paper doll file for mods:
-- !Lua[[events.ReloadPaperDollGraphics = || AddPaperDollGraphics(Game.LoadTextFileFromLod'PaperMod.txt')]]
function AddPaperDollGraphics(t)
	if type(t) == 'string' then
		t = ParseNamedColTable(t)
	end
	for _, a in ipairs(t) do
		local ins = (a.ItemPicture or ''):match('^:insert:(.*)')
		if ins then
			AddDrawOrderPiece(a, ins)
		else
			AddGraphicsItem(a)
		end
	end
end

local function BaseGraphics()
	local dx, dy = mmver == 8 and 481 - 467 or 0, mmver == 8 and -23 or 0
	AddPaperDollGraphics{
		{ItemPicture = ':BackDoll', Image = 'backdoll', X = mmver < 8 and -14 or 0, Y = 0},
		{ItemPicture = ':BackHand', Image = 'backhand', X = mmver == 7 and -8 or 0, Y = 0, Piece = 'ring'},
		{ItemPicture = ':Magnify', Image = 'MAGNIF-B', X = 122 + dx, Y = 299 + dy, Piece = 'noring'},
	}
	for i, x in ipairs{9, 57, 103, 9, 57, 103} do
		AddPaperDollGraphics{{ItemPicture = ':Ring'..i, X = x + dx, Y = (i > 3 and 250 or 202) + dy, Piece = 'ring'}}
	end

	if mmver ~= 8 then
		AddPaperDollGraphics{
			{ItemPicture = ':Amulet', X = 12, Y = 91, Piece = 'ring'},
			{ItemPicture = ':Gauntlets', X = 105, Y = 88, Piece = 'ring'},
		}
		if mmver == 7 then
			AddPaperDollGraphics{
				{ItemPicture = ':Border', Image = 'IB-Mb-A', X = -13, Y = 0, Piece = 'neutral'},
				{ItemPicture = ':Border', Image = 'IB-Mb-B', X = -13, Y = 0, Piece = 'good'},
				{ItemPicture = ':Border', Image = 'IB-Mb-C', X = -13, Y = 0, Piece = 'evil'},
			}
		end
	else
		AddPaperDollGraphics{
			{ItemPicture = ':Amulet', X = 42, Y = 131 + dy, PivotX = 0.5, PivotY = 0.5, Piece = 'ring'},
			{ItemPicture = ':Gauntlets', X = 133, Y = 128 + dy, PivotX = 0.5, PivotY = 0.5, Piece = 'ring'},
			{ItemPicture = ':Magnify', Image = 'MAGNIF-B', X = 122 + dx, Y = 299 + dy, Piece = 'ring'},
		}
	end
end

-- Reloads "PaperDol.txt" and calls #ReloadPaperDollGraphics:events.ReloadPaperDollGraphics# event. Very handy while tweaking "PaperDol.txt"
function ReloadPaperDollGraphics()
	PaperDollGraphics = {}
	BaseGraphics()
	AddPaperDollGraphics(Game.LoadTextFileFromLod'PaperDol.txt')
	-- When corresponding #ReloadPaperDollGraphics:# function is called
	events.cocall('ReloadPaperDollGraphics')
end

if GameInitialized2 then
	ReloadPaperDollGraphics()
else
	events.GameInitialized2 = ReloadPaperDollGraphics
end

--!v If set to 'true' (default in MM6 and MM7), spears are treated as two-handed weapons when used without a second weapon. Gets initialized according to game version.
PaperDollTwoHandedSpear = PaperDollTwoHandedSpear == nil and mmver ~= 8 or PaperDollTwoHandedSpear or false

--!v List of things to draw in the form of "'Slot'.'Piece'.'DrawStyle'" (or "'Slot'.'Piece'", or "'Slot'").
-- 'Slot' is either one of the wearable item slots (e.g. "Bow") or a pseudo-slot like "Player".
-- 'Piece' defines what element of that item gets drawn.
-- 'DrawStyle' can be set to "opaque" for opaque bitmaps ("red" and "green" are also supported) or "rect" to have the whole item rect count as item in regards to clicks.
--
-- Default:
-- !Lua[[{'BackDoll..opaque', 'BackDoll.menu.opaque', 'BackDoll.game.opaque',
-- 	'BeginDoll', 'Bow', 'Cloak',
-- 	'Armor.back', 'Belt.back',
-- 	'Player', 'Player.arm1', 'Player.arm1f', 'Player.arm2b', 'Player.arm2hb', 'Player.arm2fb', 'Player.shield', 'Player.hair',
-- 	'Armor.back2', 'Helm.back', 'Boots.back',
-- 	'Armor', 'Boots',
-- 	'Armor.front', 'Armor.arm1', 'Armor.arm1f',
-- 	'Belt',
-- 	'Player.arm2', 'Player.arm2h', 'Armor.arm2', 'Armor.arm2h', 'Player.arm2f',
-- 	'Cloak.scarf', 'Player.scarf', 'Helm', 'Cloak.scarf2',
-- 	'MainHand',
-- 	'Player.hand1a', 'Player.hand1', 'Player.hand1f', 'Armor.hand1a', 'Armor.hand1', 'Armor.hand1f',
-- 	'ExtraHand.hand2', 'ExtraHand.shield',
-- 	'Player.hand2', 'Player.hand2f', 'Player.hand2h', 'Armor.hand2', 'Armor.hand2f', 'Armor.hand2h',
-- 	'EndDoll', 'Magnify.noring',
-- 	'BackHand.ring', 'Border.good', 'Border.evil', 'Border.neutral',
-- 	'Ring1.ring.rect', 'Ring2.ring.rect', 'Ring3.ring.rect', 'Ring4.ring.rect', 'Ring5.ring.rect', 'Ring6.ring.rect', 'Amulet.ring.rect', 'Gauntlets.ring.rect',
-- 	'Magnify.ring',
-- }]]
--
-- See #PaperDollHiddenPieces:events.PaperDollHiddenPieces# event for conditions under which each piece is visible.
PaperDollDrawOrder = {'BackDoll..opaque', 'BackDoll.menu.opaque', 'BackDoll.game.opaque',
	'BeginDoll', 'Bow', 'Cloak',
	'Armor.back', 'Belt.back',
	'Player', 'Player.arm1', 'Player.arm1f', 'Player.arm2b', 'Player.arm2hb', 'Player.arm2fb', 'Player.shield', 'Player.hair',
	'Armor.back2', 'Helm.back', 'Boots.back',
	'Armor', 'Boots',
	'Armor.front', 'Armor.arm1', 'Armor.arm1f',
	'Belt',
	'Player.arm2', 'Player.arm2h', 'Armor.arm2', 'Armor.arm2h', 'Player.arm2f',
	'Cloak.scarf', 'Player.scarf', 'Helm', 'Cloak.scarf2',
	'MainHand',
	'Player.hand1a', 'Player.hand1', 'Player.hand1f', 'Armor.hand1a', 'Armor.hand1', 'Armor.hand1f',
	'ExtraHand.hand2', 'ExtraHand.shield',
	'Player.hand2', 'Player.hand2f', 'Player.hand2h', 'Armor.hand2', 'Armor.hand2f', 'Armor.hand2h',
	'EndDoll', 'Magnify.noring',
	'BackHand.ring', 'Border.good', 'Border.evil', 'Border.neutral',
	'Ring1.ring.rect', 'Ring2.ring.rect', 'Ring3.ring.rect', 'Ring4.ring.rect', 'Ring5.ring.rect', 'Ring6.ring.rect', 'Amulet.ring.rect', 'Gauntlets.ring.rect',
	'Magnify.ring',
}

local function Is2Handed(it)
	local a = it:T()
	return a.EquipStat == 1 or PaperDollTwoHandedSpear and a.Skill == 4
end

local function IsShield(it)
	return it:T().EquipStat == 4
end

local function GetItemGraphics(it, i)
	local a = it:T()
	local x = a.EquipX
	if mmver == 6 then
		x = (x + 240) % 481 - 240
	end
	return {Image = a.Picture:lower(), X = x, Y = a.EquipY, Item = it, Index = i}
end

local DrawCache
local DrawStyles = {[0] = 'green', false, 'red', 'red'}  -- unid, norm, brk, brk
local KeepStyle = {opaque = true, red = 'red', green = 'green'}
local EffectItem
local InMenu, ClicksOn, InDoll
local DrawOffsetX, DrawOffsetY = 0, 0

local function draw(a, it, idx, off, style)
	if not a or a.Image == '' then
		return
	end
	off = off or {}
	local m = a.Mul or off.Mul or {}
	local x = (a.X or 0)*(m[1] or 1) + (a.Y or 0)*(m[2] or 0) + (off.X or 0)
	local y = (a.X or 0)*(m[3] or 0) + (a.Y or 0)*(m[4] or 1) + (off.Y or 0)
	local rot = m[3] or 0
	if InDoll then
		x = x + Game.DialogLogic.PaperDollPositionX + DrawOffsetX
		y = y + Game.DialogLogic.PaperDollPositionY + DrawOffsetY
	elseif mmver < 8 then
		x = x + 481
	else
		x = x + 467 + DrawOffsetX
		y = y + 23 + DrawOffsetY
	end
	x = x + (PaperDollOffsetX or 0)
	y = y + (PaperDollOffsetY or 0)
	-- DrawLog[#DrawLog+1] = table.concat({a.Image, x, y}, ", ")
	local pic = DrawCache[a.Image] or Game.IconsLod:LoadBitmap(a.Image)
	DrawCache[a.Image] = pic
	local PivotX = a.PivotX or off.PivotX or 0
	local PivotY = a.PivotY or off.PivotY or 0
	if PivotX ~= 0 or PivotY ~= 0 or rot ~= 0 then
		local bmp = Game.IconsLod.Bitmaps[pic]
		if rot == 0 then
			x = x - PivotX*bmp.Width
			y = y - PivotY*bmp.Height
		else
			x = x - PivotX*bmp.Height
			y = y + (PivotY - 1)*bmp.Width
		end
	end
	x, y = x - x%1, y - y%1
	local cond = it and it.Condition or 1
	local ef = cond:And(0xf0)
	if ef ~= 0 and mmver > 6 then
		local s = ef == 32 and "sp28a" or ef == 64 and "sp30a" or ef == 128 and "sp91a" or "sptext01"
		Screen:DrawItemEffect(x, y, pic, s, nil, nil, nil, rot)
		EffectItem = it
	else
		Screen:Draw(x, y, pic, KeepStyle[style] or DrawStyles[cond:And(3)], rot)
	end
	if idx and ClicksOn then
		if (style == 'rect' or style == 'opaque') and mmver > 6 then
			Screen:DrawToObjectByPixelOpaque(x, y, pic, idx)
		else
			Screen:DrawToObjectByPixel(x, y, pic, idx, rot)
		end
	end
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
	hide[not InMenu and Game.DialogLogic.PlayerRingsOpen and 'noring' or 'ring'] = true
	-- good path interface in MM7
	hide.good = true
	-- evil path interface in MM7
	hide.evil = true
	if mmver == 7 then
		-- neutral interface
		hide.neutral = true
		local i = Party.Alignment
		hide[i == 0 and 'good' or i == 2 and 'evil' or 'neutral'] = nil
	end
	local player = pl
	--!k{hand1a 1st hand (always drawn), menu in new game menu (for BackDoll in MM8), game in game (for BackDoll in MM8), ring rings menu open, noring rings menu closed} Here I've described pieces that 'PaperDoll' module handles automatically. You can define when your own pieces are drawn through #PaperDollDrawOrder:# array and hide them conditionally here.
	-- 'InMenu' is 'true' if it's a new game menu in MM8, in which case 'DrawOffsetX' and 'DrawOffsetY' are non-zero.
	events.cocall('PaperDollHiddenPieces', hide, player, InMenu, DrawOffsetX, DrawOffsetY)
	hide.Player = nil
	return hide
end

local function GetItems(pl)
	local t = {Player = true, BackDoll = true, BackHand = true, Border = true, Magnify = not InMenu or nil}
	for k, v in pairs(const.ItemSlot) do
		t[k] = pl.EquippedItems[v]
	end
	--!(t, player:structs.Player, InMenu, DrawOffsetX, DrawOffsetY) Lets you modify weared items, such as add new weared item slots. E.g. setting !Lua[[t.My = 1]] would draw !Lua[[pl.Items[1]]]. Setting !Lua[[t.My = true]] would make ":My" drawn the same way ":Player" is drawn. You'll also need to add "My" to #PaperDollDrawOrder:#.
	-- 'InMenu' is 'true' if it's a new game menu in MM8, in which case 'DrawOffsetX' and 'DrawOffsetY' are non-zero.
	events.cocall('PaperDollGetItems', t, pl, InMenu, DrawOffsetX, DrawOffsetY)
	for k, i in pairs(t) do
		t[k] = (i == true and {} or i ~= 0 and GetItemGraphics(pl.Items[i], i) or nil)
	end
	return t
end

local function DrawDoll(pl)
	-- DrawLog = {P = || table.concat(DrawLog, "\n")}
	CurDollGraphics = tget(PaperDollGraphics, pl.Face)
	EffectItem, ClicksOn, InDoll = nil
	local hide = GetHiddenPieces(pl)
	local wear = GetItems(pl)
	local face = pl.Face
	
	local function DoOverride(t, s, NeedImg, NeedClass)
		if NeedImg or NeedClass then
			local fmt, fmt2 = (NeedClass and ':if:%s' or ':if'), NeedImg and '.%s' or ''
			for k, a in pairs(wear) do
				a = a.Image and t[s..fmt:format(k:lower())..fmt2:format(a.Image)]
				if a then
					return a
				end
			end
		else
			return t[s]
		end
	end
	local function Override(t, img, class, NeedImg, NeedClass)
		return img and class and DoOverride(t, class..'.'..img, NeedImg, NeedClass) or DoOverride(t, img or class, NeedImg, NeedClass)
	end
	local function OverrideIf(t, img, class)
		return Override(t, img, class, true, true) or Override(t, img, class, true) or Override(t, img, class, nil, true)
	end

	for _, s in ipairs(PaperDollDrawOrder) do
		local s, piece, style = s:match('^([^.]*)%.?([^.]*)%.?([^.]*)$')
		local a = wear[s]
		if a and not hide[piece] then
			local class, t = ':'..s:lower(), tget(CurDollGraphics, piece)
			local it, idx = a.Item, a.Index
			local over = it and (OverrideIf(t, a.Image, class) or Override(t, a.Image, class)) or OverrideIf(t, nil, class)
			if over then
				a = table.copy(over, {Image = a.Image, X = a.X, Y = a.Y}, true)
			end
			if not a.Item then       -- :Player or override
				a = a.Image and a or t[class]
			elseif not (PaperDollMainPieces[s] or PaperDollMainPiecesStd)[piece] then
				a = nil                -- only draw item as the main piece
			end
			draw(a, it, idx, it and t[class], style)
		elseif s == 'BeginDoll' and not hide[piece] then
			InDoll, ClicksOn = true, not (InMenu or Game.DialogLogic.PlayerRingsOpen)
			--!(player:structs.Player, InMenu, DrawOffsetX, DrawOffsetY) Called before the paper doll is drawn after drawing the background.
			-- 'InMenu' is 'true' if it's a new game menu in MM8, in which case 'DrawOffsetX' and 'DrawOffsetY' are non-zero.
			events.cocall('PaperDollBeforeDoll', pl, InMenu, DrawOffsetX, DrawOffsetY)
		elseif s == 'EndDoll' and not hide[piece] then
			InDoll, ClicksOn = nil, true
			if mmver > 6 then
				Screen:SetClipRect()
			end
			--!(player:structs.Player, InMenu, DrawOffsetX, DrawOffsetY) Called after the paper doll is drawn before drawing UI elements.
			-- 'InMenu' is 'true' if it's a new game menu in MM8, in which case 'DrawOffsetX' and 'DrawOffsetY' are non-zero.
			events.cocall('PaperDollAfterDoll', pl, InMenu, DrawOffsetX, DrawOffsetY)
		elseif s == 'Clicks' and not hide[piece] then
			ClicksOn = style ~= 'off'
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
	
	--!(player:structs.Player, InMenu, DrawOffsetX, DrawOffsetY) Called after the paper doll is drawn.
	-- 'InMenu' is 'true' if it's a new game menu in MM8, in which case 'DrawOffsetX' and 'DrawOffsetY' are non-zero.
	events.cocall('PaperDollAfterDraw', pl, InMenu, DrawOffsetX, DrawOffsetY)
end

local asmjmp = |p, p2| mem.asmpatch(p, 'jmp absolute '..p2)

if mmver == 6 then
	mem.hook(0x412397, |d| DrawDoll(Party[d.ecx - 1]))
	asmjmp(0x412397+5, 0x412D3E)
	
	-- don't draw rings panel
	asmjmp(0x412DDA, 0x412DEB)
	asmjmp(0x412E0D, 0x413004)
	
	-- don't load old graphics
	mem.autohook2(0x411ED8, || DrawCache = {})
	asmjmp(0x411EDD, 0x411F50)
	asmjmp(0x411FAF, 0x4120E7)
	asmjmp(0x4121BE, 0x41235C)
	
elseif mmver == 7 then
	asmjmp(0x43CD2A, 0x43CD51)  -- don't draw backdoll
	mem.hook(0x43CD55, |d| DrawDoll(Party[d.eax - 1]))
	asmjmp(0x43CD55+5, 0x43E840)
	
	-- don't draw rings panel
	asmjmp(0x43E880, 0x43E8C9)
	asmjmp(0x43E8F3, 0x43ED8A)

	-- don't load old graphics
	asmjmp(0x43BD56, 0x43BE9D)  -- wetsuit
	asmjmp(0x43BEA9, 0x43C009)  -- no wetsuit
	mem.hook(0x43C0C6, || DrawCache = {})
	asmjmp(0x43C0C6+5, 0x43C938)  -- rest of graphics
	
else
	local function DrawDollMem(p, x, y, menu)
		InMenu = menu
		DrawOffsetX, DrawOffsetY = x, y
		DrawDoll(Party.PlayersArray[(p - Party.PlayersArray['?ptr']):div(0x1D28)])
	end
	
	mem.asmpatch(0x43A499, 'add esp, 0xC')  -- don't draw backdoll
	mem.hook(0x43A4D9, |d| DrawDollMem(d.eax, 0, 0))
	asmjmp(0x43A4D9+5, 0x43BB12)
	
	-- don't draw rings panel
	asmjmp(0x43BB64, 0x43C0CF)

	-- don't load old graphics
	mem.asmpatch(0x439966, 'xor eax, eax')  -- load 1st backdoll
	mem.hook(0x43999D, || DrawCache = {})
	asmjmp(0x43999D+5, 0x43A073)
	
	-- new game menu
	mem.hook(0x4C4EE1, |d| do
		DrawCache = {}
		DrawDollMem(d.eax, -13, 31, true)
	end)
	asmjmp(0x4C4EE1+5, 0x4C50CB)
end