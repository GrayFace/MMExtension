local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local mmver = Game.Version

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local _KNOWNGLOBALS_F = SimpleMessage, HouseMessageVisible


function SplitSkill(val)
	local n = val % 0x40
	local mast
	if val >= 0x100 then
		mast = 4
	elseif val >= 0x80 then
		mast = 3
	elseif val >= 0x40 then
		mast = 2
	elseif val >= 1 then
		mast = 1
	else
		mast = 0
	end
	return n, mast
end

local ConvertMastery = {[0] = 0, [1] = 0, [2] = 0x40, [3] = 0x80, [4] = mmv(0x80, 0x100, 0x100)}

--!(skill, mastery:const)
function JoinSkill(skill, mastery)
	return skill + (ConvertMastery[mastery] or 0)
end

-- Get X,Y,Z fields:!Lua[[
-- local x, y, z = XYZ(Party)
-- ]]
-- Set X,Y,Z fields:!Lua[[
-- XYZ(Party, x, y, z)
-- ]]
-- Enumerate "X", "Y", "Z" strings:!Lua[[
-- for X in XYZ do
--   print(Party[X])
-- end
-- ]]
function XYZ(t, x, y, z)
	if z then
		t.X, t.Y, t.Z = x, y, z
	elseif t then
		return t.X, t.Y, t.Z
	elseif not x then  -- act as enumerator
		return "X"
	elseif x == "X" then
		return "Y"
	elseif x == "Y" then
		return "Z"
	end
end

function ClearConsoleEvents()
	local t = {['<console>'] = true}
	events.RemoveFiles(t)
	evt.map.RemoveFiles(t)
	evt.global.RemoveFiles(t)
	Keys.RemoveFiles(t)
end

local function LastMessage(text, forceGlobal)
	local t, i
	if forceGlobal or forceGlobal ~= false and evt.InGlobal() then
		t = Game.NPCText
		i = t.high
	else
		t = evt.str
		i = 499
	end
	t[i] = text
	return i
end

function Message(text, KeepSound, global)
	evt.SetMessage{LastMessage(text, global), Global = global}
	if Game.CurrentScreen == 0 and not global then
		evt.SimpleMessage{KeepSound = KeepSound}
	end
end
-- for backward compatibility
SimpleMessage = Message

-- Returns the reply. 'text' is shown as message, 'qtext' is shown at the beginning of reply field.
-- Doesn't work in houses in MM7.
function Question(text, qtext)
	text = (mmver == 8 and qtext and text.."\n\n"..qtext or text)
	if mmver < 8 then
		evt.SetMessage(LastMessage(text))
		evt.Question(LastMessage(qtext or "", false), 0, 0)
		Game.NPCMessage = false
		if mmver == 7 then
			local r = Game.StatusMessage
			Game.ShowStatusText("", 0)
			return r
		end
	elseif Game.CurrentScreen == 0 then
		local old1, old2 = Game.Paused, Game.Paused2
		Game.CurrentScreen = const.Screens.SimpleMessage
		evt.Question(LastMessage(text, true), 0, 0)
		if not old1 then
			mem.call(offsets.ResumeTime, 1, offsets.TimeStruct1)
		end
		if not old2 then
			mem.call(offsets.ResumeTime, 1, offsets.TimeStruct2)
		end
	else
		evt.Question(LastMessage(text, true), 0, 0)
	end
	return Game.StatusMessage
end

-- Searches through all NPC topics and replaces one topic with another
function ReplaceNPCTopic(old, new)
	for i,npc in Game.NPC do
		for j, ev in npc.Events do
			if ev == old then
				npc.Events[j] = new
			end
		end
	end
end

local SuppressCount, OnSuppress = 0, |t| t.Allow = false

function SuppressSound(on)
	SuppressCount = SuppressCount + (on and 1 or -1)
	if on and SuppressCount == 1 then
		events.InternalPlaySound = OnSuppress
	elseif SuppressCount == 0 then
		events.remove('InternalPlaySound', OnSuppress)
	elseif SuppressCount < 0 then
		SuppressCount = 0
	end
	return SuppressCount > 0
end

-- Simulates Esc press
function ExitScreen(process)
	if mmver ~= 8 or Game.CurrentScreen == 13 and not Game.InQuestionDialog then
		Game.Actions.Add(113, Game.GetCurrentHouse() and 1 or 0)
	elseif Game.InOODialog then
		Game.OODialogProcessKey()
	end
	if process then
		Game.Actions.Process()
	end
end

-- Rebuilds house dialog, e.g. after you've moved an NPC to or from this house
-- Can seemlessly transition between different houses if 'id' is specified.
function ReloadHouse(id)
	id = id or Game.GetCurrentHouse()
	SuppressSound(true)
	while Game.CurrentScreen ~= 0 do
		ExitScreen(true)
	end
	evt.EnterHouse(id)
	SuppressSound(false)
end

-- Exits currently playing movie and loads the specified one
function SwitchHouseMovie(s, loop)
	Game.EndMovie()
	Game.LoadHouseMovie(s, loop)
end

do
	local DummyDlg

	-- Draw simple message in screens where it isn't normally supposed to be
	function DrawSimpleMessage()
		local p = mmv(0x4D50E4, 0x507A64, 0x519348)
		local old, old2 = mem.u4[p], mmver == 8 and Game.CurrentScreen
		if old == 0 and not DummyDlg then
			local s = "\0\0\0\0\0\0\0\0\128\2\0\0\224\1\0\0\127\2\0\0\223\1\0\0\19\0\0\0\33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
			DummyDlg = mem.malloc(#s)
			mem.copy(DummyDlg, s, #s)
		end
		mem.u4[p] = old ~= 0 and old or DummyDlg
		if mmver == 8 then
			local old2, old3 = Game.CurrentScreen, mem.u4[0xFFD45C]
			Game.CurrentScreen, mem.u4[0xFFD45C] = 19, 0
			mem.call(0x441EFD, 0)
			Game.CurrentScreen, mem.u4[0xFFD45C] = old2, old3
		else
			mem.call(mmv(0x43A890, 0x444FE1), 0)
		end
		mem.u4[p] = old
	end
	
	local closers = {[113] =  true, [405] = true, [410] = true, [495] = true}
	
	local function OnAction(t)
		if not t.Handled and (closers[t.Action] or not HouseMessageVisible) then
			HouseMessageVisible = nil
			if t.Action == 410 then
				Game.NPCMessage = false
			end
			events.remove('HouseMovieFrame', DrawSimpleMessage)
			events.remove('Action', OnAction)
		end
	end

	-- show a message in houses in screens that don't normally support it
	function HouseMessage(text)
		if text then
			evt.SetMessage(LastMessage(text))
		end
		if not HouseMessageVisible then
			HouseMessageVisible = true
			events.HouseMovieFrame = DrawSimpleMessage
			events.Action = OnAction
		end
	end
end

function AddGoldExp(gold, exp)
	if gold and gold ~= 0 then
		evt[0][gold > 0 and "Add" or "Sub"]("Gold", abs(gold))
	end
	if exp and exp ~= 0 then
		evt.All.Add("Experience", exp)	
	end
end

-- 'id' can also be a table or a table of tables. See !'[[Quest Alchemy.lua]] from #quest examples:Quests#
function TakeItemFromParty(id, keep)
	if type(id) ~= "table" then  -- take 1 item
		
		for i = 0, Party.Count - 1 do
			if evt[i].Cmp("Inventory", id) then
				if not keep then
					evt[i].Sub("Inventory", id)
				end
				return true
			end
		end
		
	elseif id.Count or id.count then  -- count all items from the list and remove in given order
		
		local n = id.Count or id.count
		if Party.CountItems(id) < n then
			return
		end
		if not keep then
			local i = 1
			for _ = 1, n do
				while not TakeItemFromParty(id[i]) do
					i = i + 1
				end
			end
		end
		return true
		
	else  -- iterate individual items or tables with items
		
		for _, v in ipairs(id) do
			if not TakeItemFromParty(v, true) then
				return
			end
		end
		if not keep then
			for _, v in ipairs(id) do
				TakeItemFromParty(v)
			end
		end
		return true
	end
end

local CheckType = {"Group", "Monster", "MonsterIndex", "NameId"}
local CheckDelta = {[0] = 0, 0, -1, 0, 0}

--[[!a{
  Group
  Monster
  MonsterIndex
  NameId
} See !'[=[Quest Kill Monsters.lua]=] from #quest examples:Quests#]]
function CheckMonstersKilled(t)
	for i = #CheckType, 0, -1 do
		local id = t[CheckType[i]] or i == 0 and 0
		if id then
			local t1 = {i, 0, t.Count, t.InvisibleAsDead ~= false and 1 or 0}
			if type(id) ~= "table" then
				t1[2] = id + CheckDelta[i]
				return evt.CheckMonstersKilled(t1)
			end
			local b = true
			for j = 1, #id do
				t1[2] = id[j] + CheckDelta[i]
				b = b and evt.CheckMonstersKilled(t1)
			end
			return b
		end
	end
end

local function NextAvailableSkillMM6(t, i)
	for i = (i or -1) + 1, t.high do
		if t[i] > 0 then
			return i, const.Master
		end
	end
end

local function NextAvailableSkill(t, i)
	for i = (i or -1) + 1, t.high do
		local v = t[i]
		if v > 0 then
			return i, v
		end
	end
end

-- Returns Skill:const.Skills, #MaxMastery:const#
function EnumAvailableSkills(class)
	if mmver == 6 then
		return NextAvailableSkillMM6, Game.ClassKinds.StartingSkills[class:div(3)]
	end
	return NextAvailableSkill, Game.Classes.Skills[class]
end

-----------------------------------------------------
-- String special chars
-----------------------------------------------------

do
	local i4, gbits = mem.i4, mmv(0x9B1118, 0xA74AF4, 0xAB2ABC)

	-- function ColorToRGB(v)
	-- 	local r, g, b
	-- 	if mem.i4[gbits] == 6 then
			
	-- 	else
	-- 	end
	-- end
	function RGB(r, g, b)
		r, b = r:And(0xF8), b:And(0xF8)
		if i4[gbits] == 6 then
			return (b + 0x40*(g:And(0xFC) + 0x20*r))/8
		end
		return (b + 0x20*(g:And(0xF8) + 0x20*r))/8
	end
end

function StrLeft(v)
	return ('\t%.3d'):format(v)
end
function StrRight(v)
	return ('\r%.3d'):format(v)
end
function StrColor(r, g, b, s)
	return ('\f%.5d'):format(b and RGB(r, g, b) or r)..((s or not b and g) and (s or g)..StrColor(0) or '')
end

-----------------------------------------------------
-- Summon*
-----------------------------------------------------

local MonTxtProps = {
	TreasureItemPercent = true,
	TreasureDiceCount = true,
	TreasureDiceSides = true,
	TreasureItemLevel = true,
	TreasureItemType = true,
	Item = true,
}

-- Unless 'treasure' is 'true', the monster doesn't have any items or gold.
-- 'place' defines monster index in #Map.Monsters:# array if specified.
function SummonMonster(id, x, y, z, treasure, place)
	local n = Map.Monsters.Count
	mem.call(offsets.SummonMonster, 2, id, x or Party.X, y or Party.Y, z or Party.Z)
	if Map.Monsters.Count == n + 1 then
		local mon = Map.Monsters[n]
		mon.Hostile = false
		if treasure then
			local a = Game.MonstersTxt[id]
			for k in pairs(MonTxtProps) do
				mon[k] = a[k]
			end
		end
		if not place then
			for i = 0, n - 1 do
				if Map.Monsters[i].AIState == 11 then  -- const.AIState.Removed
					place = i
					break
				end
			end
		end
		if place then
			local a = Map.Monsters[place]
			mem.copy(a["?ptr"], mon["?ptr"], mon["?size"])
			Map.Monsters.Count = n
			return a, place
		end
		return mon, n
	end
end

function SummonItem(number, x, y, z, speed)
	local n = Map.Objects.Count
	for i,o in Map.Objects do
		if o.TypeIndex == 0 then
			n = i
			break
		end
	end
	evt.SummonObject(mmver == 8 and number or Game.ItemsTxt[number].SpriteIndex, x, y, z, speed)
	local obj = (n < Map.Objects.Count and Map.Objects[n])
	if obj and obj.TypeIndex ~= 0 then
		obj.Item.Number = number
		return obj
	end
end

local function IsSpriteSquare(sx, sy, x, y)
	x, y = (x - 64 + 0.5)*512, (64 - y + 0.5)*512
	x, y = sx - x, sy - y
	return x*x + y*y <= 1024*1024
end

function RebildIDList()
	local cells = {}
	local sprites = Map.Sprites
	local max = math.max
	local min = math.min
	for i = 0, sprites.high do
		local sx, sy = sprites[i].X, sprites[i].Y
		local cx, cy = 64 + (sx / 512):floor(), 64 - (sy / 512):floor()
		for y = max(cy - 2, 0), min(cy + 2, 127) do
			for x = max(cx - 2, 0), min(cx + 2, 127) do
				if IsSpriteSquare(sx, sy, x, y) then
					local j = y*128 + x
					local t = cells[j] or {}
					cells[j] = t
					t[#t+1] = i*8 + 5
				end
			end
		end
	end
	local n = 128*128
	for i = 0, 128*128 - 1 do
		local t = cells[i]
		n = n + (t and #t or 0)
	end
	local list = mem.allocMM(n*2)
	local off = Map.IDOffsets
	n = 0
	for y = 0, 127 do
		for x = 0, 127 do
			off[y][x] = n
			local t = cells[y*128 + x]
			if t then
				for i = 1, #t do
					mem.u2[list + n*2] = t[i]
					n = n + 1
				end
			end
			mem.u2[list + n*2] = 0
			n = n + 1
		end
	end
	mem.freeMM(Map.IDList["?ptr"])
	Map.IDList["?ptr"] = list
	Map.IDList.Count = n
end

function ChangeSprite(n, name)
	Map.Sprites[n].DecName = name
	-- also need to do sound: 45E6EE (MM8)
end

--!a{name, x, y, z}
function CreateSprite(t)
	local n = Map.Sprites.Count
	if n < Map.Sprites.Limit then
		Map.Sprites.Count = n + 1
		local sp = Map.Sprites[n]
		mem.fill(sp)
		local name = t[1]
		t.X = t.X or t[2]
		t.Y = t.Y or t[3]
		t.Z = t.Z or t[4]
		t[1], t[2], t[3], t[4] = nil, nil, nil, nil
		local bits = t.Bits
		t.Bits = nil
		sp.Bits = bits or 0
		table.copy(t, sp, true)
		if name then
			ChangeSprite(n, name)
		end
		return sp, n
	end
end

-----------------------------------------------------
-- MoveModel
-----------------------------------------------------

-- local function MovePartyByModel(m, dx, dy, dz)
-- 	local px, py, pz = XYZ(Party)
-- 	if px >= m.MinX + min(dx, 0) - 1 and px <= m.MaxX + max(dx, 0) + 1 and
-- 		 py >= m.MinY + min(dy, 0) - 1 and py <= m.MaxY + max(dy, 0) + 1 and
-- 		 pz >= m.MinZ + min(dz, 0) - 1 and pz <= m.MaxZ + max(dz, 0) + 1 then
-- 	else
-- 		return
-- 	end
-- 	local fz, fid = Map.GetFloorLevel(px, py, pz)
-- 	-- print(px, py, pz, fz, fid)
-- 	-- ride check
-- 	if Map.Models[fid:div(64)] == m and fz <= pz and pz <= fz + max(dz, 0) + 1 then
-- 		local a = m.Facets[fid % 64]
-- 		local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
-- 		print(nz, nx*dz + ny*dy + nz*dz)
-- 		if nz >= 0xB569 or nx*dz + ny*dy + nz*dz > 0 then
-- 			Party.X = px + dx
-- 			Party.Y = py + dy
-- 			Party.Z = fz + 1 + dz
-- 			return
-- 		end
-- 	end
-- 	-- Very primitive collision detection. May work only for rectangular facets.
-- 	for i, a in m.Facets do
-- 		if a.VertexesCount > 0 then
-- 			local v = m.Vertexes[a.VertexIds[0]]
-- 			local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
-- 			local n = - (nx * v.X + ny * v.Y + nz * v.Z)  -- new normal distance
-- 			local oldn = a.NormalDistance
-- 			local px, py, pz = Party.X, Party.Y, Party.Z
-- 			local PartyDist = nx*px + ny*py + nz*pz + oldn
-- 			if PartyDist*(PartyDist - oldn + n) < 0
-- 					and px >= a.MinX + min(dx, 0) - 1 and px <= a.MaxX + max(dx, 0) + 1
-- 					and py >= a.MinY + min(dy, 0) - 1 and py <= a.MaxY + max(dy, 0) + 1
-- 					and pz >= a.MinZ + min(dz, 0) - 1 and pz <= a.MaxZ + max(dz, 0) + 1 then
-- 				-- push away
-- 				Party.X = px + dx*2
-- 				Party.Y = py + dy*2
-- 				Party.Z = pz + dz*2
-- 				return
-- 			end
-- 		end
-- 	end
-- end

local function MovePartyByModel(m, dx, dy, dz)
	local px, py, pz = XYZ(Party)
	if px >= m.MinX + min(dx, 0) - 1 and px <= m.MaxX + max(dx, 0) + 1 and
		 py >= m.MinY + min(dy, 0) - 1 and py <= m.MaxY + max(dy, 0) + 1 and
		 pz >= m.MinZ + min(dz, 0) - 1 and pz <= m.MaxZ + max(dz, 0) + 1 then
	else
		return
	end
	local fz, fid = Map.GetFloorLevel(px, py, pz)
	-- print(px, py, pz, fz, fid)
	-- ride check
	if Map.Models[fid:div(64)] == m and fz <= pz and pz <= fz + max(dz, 0) + 1 then
		local a = m.Facets[fid % 64]
		local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
		-- print(nz, nx*dz + ny*dy + nz*dz)
		if nz >= 0xB569 or nx*dz + ny*dy + nz*dz > 0 then
			Party.X = px + dx
			Party.Y = py + dy
			Party.Z = fz + 1 + dz
			return
		end
	end
	-- Very primitive collision detection. May work only for rectangular facets.
	for i, a in m.Facets do
		if a.VertexesCount > 0 then
			local v = m.Vertexes[a.VertexIds[0]]
			local nx, ny, nz = a.NormalX, a.NormalY, a.NormalZ
			local n = - (nx * v.X + ny * v.Y + nz * v.Z)  -- new normal distance
			local oldn = a.NormalDistance
			local px, py, pz = Party.X, Party.Y, Party.Z
			local PartyDist = nx*px + ny*py + nz*pz + oldn
			if PartyDist*(PartyDist - oldn + n) < 0
					and px >= a.MinX + min(dx, 0) - 1 and px <= a.MaxX + max(dx, 0) + 1
					and py >= a.MinY + min(dy, 0) - 1 and py <= a.MaxY + max(dy, 0) + 1
					and pz >= a.MinZ + min(dz, 0) - 1 and pz <= a.MaxZ + max(dz, 0) + 1 then
				-- push away
				Party.X = px + dx*2
				Party.Y = py + dy*2
				Party.Z = pz + dz*2
				return
			end
		end
	end
end



-- local MoveModelProc = mem.dll[DevPath.."ExeMods/MMExtension/MMExtDialogs.dll"].MoveModel

local DoMoveModel = io.load(DevPath.."Scripts/Structs/After/MoveModel.asm")
DoMoveModel = DoMoveModel:gsub("%%(%w*)%%", {[""] = "%", GetU = mmv(0x4790A0, 0x44C38E, 0x449AD7)})
DoMoveModel = mem.asmproc(DoMoveModel)

-- 'MoveParty' isn't supported yet
function MoveModel(m, dx, dy, dz, MoveParty)
	dx = round(dx)
	dy = round(dy)
	dz = round(dz)
	if dx == 0 and dy == 0 and dz == 0 then
		return
	end
	local pm = m["?ptr"]
	if MoveParty then
		-- MovePartyByModel uses a crude approximation... and doesn't work yet :)
		MovePartyByModel(m, dx, dy, dz)
	end
	mem.call(DoMoveModel, 0, pm, dx, dy, dz, (mmver == 6 and 0 or 4))
	--MoveModelProc(pm, dx, dy, dz, (mmver == 6 and 0 or 4))
	Game.NeedRender = true
end
