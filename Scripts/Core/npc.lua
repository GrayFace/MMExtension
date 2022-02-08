local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion


local function mmv(...)
	return (select(mmver - 5, ...))
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

local Conditional = internal.Conditional
local GetPlayer, GetMonster = internal.GetPlayer, internal.GetMonster

local _KNOWNGLOBALS_F = Party, Game, Map, VFlipUnfixed, structs, GameInitialized1, GameInitialized2

local CurrentNPC, CurrentAnyNPC, FirstEnterNPC
local RefillNPCTopics
local pItemsCount = mmv(0x9DDDFC, 0xF8B060, 0xFFD450)

mem.IgnoreProtection(true)

-- fix NPCs with action having 1 non-interactive dialog item
if mmver == 7 and mem.u1[0x445F76] == 4 then
	mem.u1[0x445F76] = 3
end

--!(NPC:structs.NPC) Finds the prototype NPC in Game.NPC array for the supplied hired NPC. Returns 'nil' if it's a street NPC.
function FindHiredNPC(npc)
	local s = npc.Name
	for i, a in Game.NPC do
		if a.Hired and a.Name == s then
			return i
		end
	end
end
local FindHiredNPC = FindHiredNPC

-- EnterAnyNPC - called before any NPC topics are populated
local function EnterAnyNPC(p, npc, i, kind)
	local start = not CurrentAnyNPC
	CurrentAnyNPC = p
	local npc, i, kind = Game.GetNPCFromPtr(p)
	if start then
		FirstEnterNPC = true
		CurrentNPC = kind == 'NPC' and i or nil
		local t = {NPC = npc, Index = i, Kind = kind}
		--!k{NPC :structs.NPC} Happens before #events.EnterNPC:#. 'Kind' ("NPC", "HiredNPC", "StreetNPC") defines the array NPC belongs to and 'Index' is index in that array.
		events.cocalls("EnterAnyNPC", t, npc)
	end
	return npc, i, kind
end

-- ShowNPCTopics - called when NPC topics list is about to be shown
local function NPCTopicsHook(p)
	local npc, i, kind = EnterAnyNPC(p)
	if kind == 'NPC' then
		CurrentNPC = i
		if FirstEnterNPC then
			FirstEnterNPC = nil
			--!(Index) Only called for NPCs from Game.NPC array, not for street or hired NPCs
			events.cocalls("EnterNPC", i)
		end
		--!(Index) NPC topics are about to be shown and you can update them here
		events.cocalls("ShowNPCTopics", i)
	elseif kind == 'HiredNPC' then
		--!(Index, RealNPC) Happens only in MM6 when you talk to a hired NPC.
		-- 'Index' is the index in Party.HiredNPC array.
		-- 'RealNPC' is the index of the prototype NPC in Game.NPC array or 'nil'.
		events.cocalls("ShowHiredNPCTopics", i, FindHiredNPC(npc))
	end
end

mem.autohook(mmv(0x4195E6, 0x41C5ED, 0x41BCD9), |d| EnterAnyNPC(Game.GetCurrentNPCPtr()))  -- street NPC enter
mem.autohook(mmv(0x419774, 0x41C633, 0x41BD22), |d| NPCTopicsHook(d[mmv('ebp', 'ebp', 'eax')]))  -- street NPC
mem.autohook(mmv(0x499B3A, 0x4B43CD, 0x4B2E7E), |d| NPCTopicsHook(d[mmv('ebp', 'eax', 'eax')]))  -- house NPC


-- DrawNPCGreeting - called when NPC greeting is about to be shown
local CurNPCGreet

local function NPCGreetingHook(eax, p)
	local t = {Text = mem.pchar[Game.NPCGreet["?ptr"] + eax*4], Seen = (eax % 2 ~= 0)}
	t.NPC = (p - Game.NPC["?ptr"])/Game.NPC[0]["?size"]
	if t.NPC >= 0 and t.NPC < Game.NPC.Length then
		events.cocall("DrawNPCGreeting", t)
	end
	CurNPCGreet = tostring(t.Text)
	return CurNPCGreet ~= "" and mem.topointer(CurNPCGreet) or 0
end

if mmver == 7 then
	mem.i4[0x4455C2 + 2] = 0
	mem.hook(0x4455D9, function(d)
		d.eax = NPCGreetingHook(d.eax, d.ebx)
		if d.eax == 0 then
			u4[d.esp] = 0x4456FA
		end
	end, 7)
	mem.i4[0x4B2B73 + 2] = 0
	mem.hook(0x4B2BA1, function(d)
		d.edx = NPCGreetingHook(d.eax, d.esi)
		if d.edx == 0 then
			d.esp = d.esp + 12
			d:push(0x4B2C3C)
		end
	end, 7)
elseif mmver == 8 then
	mem.i4[0x44274E + 2] = 0
	mem.hook(0x442765, function(d)  d.eax = NPCGreetingHook(d.eax, d.edi)  end, 7)
	mem.i4[0x4B1389 + 2] = 0
	mem.hook(0x4B13A3, function(d)
		d.edx = NPCGreetingHook(d.eax, d.esi)
		if d.edx == 0 then
			d.esp = d.esp + 12
			d:push(0x4B1450)
		end
	end, 7)
end

-- speak with guards
if mmver > 6 then
	local function SpeakWithMonster(d)
		local t = {Result = nil}
		t.MonsterIndex, t.Monster = GetMonster(d.esi)
		--!k{Monster :structs.MapMonster, MonsterIndex} [MM7+] Called when you speak with a guard or any other monster with a generic message from NPCGroup.txt. Assign 'Result' a string to override default monster group message. Assign an empty string to show no message. Initially 'Result' is 'nil'.
		events.cocalls("SpeakWithMonster", t)
		if t.Result == "" then
			d.eax = 0
		elseif t.Result then
			Game.TextBuffer = t.Result
			d.eax = structs.o.GameStructure.TextBuffer
		end
	end
	mem.autohook2(mm78(0x46A586, 0x4688F8), SpeakWithMonster)
	mem.autohook2(mm78(0x422509, 0x4216EE), SpeakWithMonster)
end

-- make all peasants hireable
if mmver == 7 then
	local hooks
	-- [MM7] Normally first level peasants just tall you the news and can't be hired. Pass 'on' = 'true' to this function to make all peasants hireable.
	function HireAllPeasants(on)
		if hooks then
			hooks.Switch(on)
		elseif on then
			hooks = HookManager()
			hooks.asmpatch(0x4611DC, [[jmp absolute 0x461382]])
		end
	end
end

-- OnAction
local ExitAnyNPC
local screensNPC = {[4] = true, [19] = true}  -- SpeakNPC, street NPC, separate processing for house

internal.OnActionNPC = |t| if CurrentAnyNPC and (t.Action == 113 and screensNPC[Game.CurrentScreen] or t.Action == 491) then
	local allow = true
	if CurrentNPC then
		local t = {NPC = CurrentNPC, Allow = true, Must = false}
		-- If 'Must' is 'true', the handler can still set 'Allow' to 'false', but can't fully cancel the exit. After 'CanExitNPC' cancels it 100 times, the exit will happen unconditionally.
		events.cocalls("CanExitNPC", t)
		allow = t.Allow
	elseif CurrentAnyNPC then
		local t = {Allow = true, Must = false}
		t.NPC, t.Index, t.Kind = Game.GetNPCFromPtr(CurrentAnyNPC)
		if t.Kind ~= 'HiredNPC' then
			--!k{NPC :structs.NPC}
			events.cocalls("CanExitStreetNPC", t)
		else
			t.RealNPC = FindHiredNPC(t.NPC)
			--!k{NPC :structs.NPC} 'RealNPC' is the index of the prototype NPC in Game.NPC array or 'nil'.
			events.cocalls("CanExitHiredNPC", t)
		end
		allow = t.Allow
	end
	if allow then
		ExitAnyNPC()
	else
		RefillNPCTopics()
		return true
	end
end

function ExitAnyNPC()
	if CurrentNPC then
		events.cocalls("ExitNPC", CurrentNPC)
	end
	local npc, i, kind = Game.GetNPCFromPtr(CurrentAnyNPC)
	local t = {NPC = npc, Index = i, Kind = kind}
	--!k{NPC :structs.NPC}
	events.cocalls("ExitAnyNPC", t)
	CurrentNPC, CurrentAnyNPC = nil, nil
end

-- exit house screen
mem.autohook(mmv(0x4A4AA0, 0x4BD818, 0x4BB3F8), function()
	local i = Game.HouseScreen
	if CurrentNPC and (i == 0 or i == 1) then  -- i == 0 happens with "Enter Temple of Light/Dark"
		local i = CurrentNPC
		local t = {NPC = i, Allow = true, Must = (Game.HouseNPCSlot <= 0)}
		events.cocalls("CanExitNPC", t)
		if Game.HouseNPCSlot <= 0 then  -- can't talk anymore
			t.Must = true
			local _ = 0
			while not t.Allow and (_ < 100) do
				events.cocalls("CanExitNPC", t)
				_ = _ + 1
			end
			t.Allow = true
		end
		if t.Allow then
			ExitAnyNPC()
		else
			Game.HouseScreen = -1
		end
	else
		events.cocalls("ExitHouseScreen", Game.HouseScreen)
	end
end)

-- Returns NPC index
function GetCurrentNPC()
	return CurrentNPC
end

-- Returns NPC:structs.NPC, Index, Kind
function GetCurrentAnyNPC()
	if CurrentAnyNPC then
		return Game.GetNPCFromPtr(CurrentAnyNPC)
	end
end


-- skill teacher
do
	local buf, cant
	mem.hookfunction(mmv(0x496C90, 0x4B24B0, 0x4B0DC1), 1, 0, function(d, def, topic)
		cant = true
		local r = def(topic)
		if cant then
			return r
		end
		local s = mem.string(r)
		local t = {Text = s, Cost = Game.HouseCost, Skill = Game.HouseActionInfo, Mastery = Game.HouseTeachMastery, Allow = Game.HouseAllowAction ~= 0}
		events.cocalls("CanTeachSkillMastery", t)
		if t.Text ~= s then
			s = t.Text
			buf = buf or mem.allocMM(500)
			mem.copy(buf, s, min(#s+1, 499))
			r = buf
		end
		Game.HouseCost = t.Cost
		Game.HouseActionInfo = t.Skill
		Game.HouseTeachMastery = t.Mastery
		Game.HouseAllowAction = t.Allow and 1 or 0
		return r
	end)
	mem.autohook(mmv(0x496D4F, 0x4B2660, 0x4B0F2E), function(d)
		cant = false
	end)
end

-- CanTempleHealPlayer
mem.hookfunction(mmv(0x49DAD0, 0x4B6F5C, 0x4B57BD), 1, 0, function(d, def, this)
	local t = {
		House = Game.GetCurrentHouse(),
		Result = def(this) ~= 0,
	}
	t.PlayerIndex, t.Player = GetPlayer(this)
	--!k{Player :structs.Player}
	events.cocall("CanTempleHealPlayer", t)
	return t.Result and 1 or 0
end)

-- GetShopItemTreatment
local ShopAction = {nil, 'buy', 'sell', 'identify', 'repair'}

mem.hookfunction(mmv(0x485120, 0x490EE6, 0x49000D), 1, 4, function(d, def, pl, item, housetype, house, action)
	local t = {
		House = house,
		-- :const.HouseType
		HouseType = housetype,
		Action = ShopAction[action] or action,
		-- :structs.Item
		Item = structs.Item:new(item),
		Result = def(pl, item, housetype, house, action),
	}
	t.PlayerIndex, t.Player = GetPlayer(pl)
	function t.GetDefault(HouseType, House, Item, Action, Player)
		return def(Player or pl, Item or item, HouseType or housetype, House or house, Action or action)
	end
	--!k{Player :structs.Player}
	-- 'Action': "buy", "sell", "identify", "repair"
	-- 'Result': 0-based option from merchant.txt
	-- 'GetDefault'!Params[[(HouseType, House, Item, Action, Player)]] function lets you get item treatment by another shop type (all parameters are optional)
	events.cocall("GetShopItemTreatment", t)
	return t.Result
end)

-- CanShopOperateOnItem
mem.hookfunction(mmv(0x4A4C30, 0x4BDA12, 0x4BB612), 2, 0, function(d, def, item, house)
	local t = {
		House = house,
		-- :const.HouseType
		HouseType = Game.Houses[house].Type,
		Action = ShopAction[Game.HouseScreen],
		-- :structs.Item
		Item = structs.Item:new(item),
		Result = def(item, house) ~= 0,
	}
	function t.GetDefault(House, Item)
		return def(Item or item, House or house) ~= 0
	end
	-- 'Action': "buy", "sell", "identify", "repair"
	-- 'GetDefault'!Params[[(House, Item)]] function lets you get item treatment by another shop type (all parameters are optional)
	events.cocall("CanShopOperateOnItem", t)
	return t.Result and 1 or 0
end)

-- ShopItemsGenerated
mem.hookfunction(mmv(0x49FD40, 0x4B8EF7, 0x4B74B6), 0, 0, function(d, def)
	def()
	local house = Game.GetCurrentHouse()
	local t = {
		House = house,
		-- :const.HouseType
		HouseType = Game.Houses[house].Type,
	}
	events.cocall("ShopItemsGenerated", t)
end)

-- GuildItemsGenerated
mem.autohook(mmv(0x4A465D, 0x4BD307, 0x4BB2B6), function(d)
	local house = Game.GetCurrentHouse()
	local t = {
		House = house,
		-- :const.HouseType
		HouseType = Game.Houses[house].Type,
	}
	-- Note that you'll have to update #Game.GuildItemIconPtr:# if you change items in this event (see an example there).
	events.cocall("GuildItemsGenerated", t)
end)

-- HouseMovieFrame
do
	local hooks = HookManager()
	hooks.autohook(mmv(0x4A6113, 0x4BF09B, 0x4BCCCE), function(d)
		local t = {
			House = Game.GetCurrentHouse(),
		}
		events.cocall("HouseMovieFrame", t)
	end)
	Conditional(hooks, "HouseMovieFrame")
end

-- Arcomage
if mmver > 6 then
	mem.autohook2(mm78(0x40A005, 0x40AB7D), function(d)
		--!(arcomage:structs.Arcomage, house)
		events.cocalls("ArcomageSetup", Game.Arcomage, Game.GetCurrentHouse())
	end)

	mem.hook(mm78(0x4B8BFD, 0x4B7143), function(d)
		local t = {
			House = Game.GetCurrentHouse(),
			Result = pchar[d.esp + 8],
		}
		-- Lets you modify Victory Conditions text
		events.cocalls("ArcomageText", t)
		Game.TextBuffer = t.Result
	end)
end

if mmver == 7 then
	local hooks
	-- [MM7] Pass 'false' to remove the deck requirement.
	function ArcomageRequireDeck(on)
		if hooks then
			hooks.Switch(not on)
		elseif not on then
			hooks = HookManager()
			hooks.nop(0x4B3A06)  -- no arcomage deck requirement
			hooks.nop(0x4B8A31)  -- no arcomage deck requirement
		end
	end
	
	-- draw Arcomage text depending on presense of 4th dialog item
	HookManager{Count = pItemsCount}.asmpatch(0x4B8887, [[
		mov eax, 4
		cmp eax, [%Count%]
	]])
elseif mmver == 8 then
	HookManager{Count = pItemsCount}.asmhook2(0x4B6DEE, [[
		cmp dword [%Count%], 4
		jnl @std
		xor eax, eax
		pop ecx
		jmp absolute 0x4B6E3E
	@std:
	]])
end

-- NewBountyHunt
local function BountyReset(d, skip, index)
	local t = {
		Index = index,
		House = Game.GetCurrentHouse(),
		Result = nil,
	}
	-- Assign 'Result' to specify the target monster for the hunt
	events.cocall("NewBountyHunt", t)
	if t.Result then
		Party.MonsHuntTarget[index] = t.Result
		d:push(skip)
		return true
	end
end

mem.autohook2(mmv(0x4A3231, 0x4BBB43, 0x4BADCC), |d| BountyReset(d, mmv(0x4A3277, 0x4BBBA6, 0x4BADD4), d[mmv('esi', 'edi', 'ebp')]))
if mmver > 6 then
	mem.autohook2(mm78(0x4BCD02, 0x4B9CF5), |d| BountyReset(d, mm78(0x4BD1BF, 0x4B9D26), mmver == 8 and 0 or d.esi/2))
end

-- BountyHuntDone
local function BountyDone(d, index)
	local t = {
		Index = index,
		House = Game.GetCurrentHouse(),
		Gold = d.ecx,
	}
	-- If you modify 'Gold' here, it wouldn't be in line with the promised sum, but you may introduce other rewards for example
	events.cocall("BountyHuntDone", t)
	d.ecx = t.Gold
end

mem.autohook(mmv(0x4A32B9, 0x4BBBD5, 0x4BAE10), |d| BountyDone(d, mmver == 8 and d.ebp/2 or d[mmv('esi', 'edi')]))
if mmver > 6 then
	mem.autohook(mm78(0x4BD1F6, 0x4B9D59), |d| BountyDone(d, mmver == 8 and 0 or d.esi/2))
end

-- Training
if mmver > 6 then
	local levels

	-- [MM7+] Set number of levels the party can train per training session. '0' means any number of levels, as in MM6. '1' is MM7+ default. If 'n' isn't specified, returns current setting.
	function TrainPerWeek(n)
		if not n then
			return levels or 1
		elseif not levels then
			local reg = mm78('ecx', 'edx')
			mem.autohook(mm78(0x4B4BA5, 0x4B360C), |d| if (levels > 0 and d[reg] % levels or d[reg]) > 0 then
				d:push(mm78(0x4B4BF4, 0x4B3640))
				return true
			end)
			levels = 1
		end
		levels = n + 0
	end
end

-- SetMapNoNPC
if mmver == 7 then
	mem.autohook(0x460B45, function(d)
		-- [MM7] Use this event if you need to set #Map.NoNPC:structs.GameMap.NoNPC#
		events.cocalls("SetMapNoNPC")
	end, 7)
	mem.autohook(0x432FE3, function(d)
		events.cocalls("SetMapNoNPC")
	end)
end



-- Populate dialogs

-- 136: ActionStreetNPCTopic
-- 175: ActionHouseNPCTopic
-- 405: ActionHouseTopic
local CommandActions = mmver == 8 and {
	[79] = 175,  -- teach
	[82] = 175,  -- join guild
} or {}

local function ArrToHouseScreen(t1, extra)
	local t, extra = {}, {}
	for i = 1, table.maxn(t1) do
		local v = t1[i]
		if type(v) == 'table' then
			extra[#t + 1] = v
			v, v[1] = v[1] or false, nil
		end
		t[#t + 1] = const.HouseScreens[v] or v
	end
	return t, extra
end

local function ReadPopulatedDialog(action, NoTopics)
	local dlg = Game.CurrentNPCDialog
	local x, y, w, h = 480, 160, 140, 30
	local t, items = {}, {}
	local it = structs.Button:new(dlg.LastItemPtr)
	local n0 = dlg.KeyboardItemsCount
	local n = n0 == 0 and 0 or dlg.ItemsCount - dlg.KeyboardItemsStart
	if n < n0 then
		-- unused house PicType produces boken keyboard items count (1 instead of 0)
		n0 = n
		dlg:SetKeyboardNavigation(n, 1, 0, dlg.KeyboardItemsStart)
	elseif NoTopics and n == 1 and it.ActionType ~= action then
		-- Seer Pilgrimage
		n, n0 = 0, 0
	end
	if n ~= 0 then
		x, y, w, h = it.Left, it.Top, it.Width, it.Height
		for i = n, 1, -1 do
			if it.ActionType ~= (CommandActions[it.ActionParam] or action) then
				return  -- alien items detected
			end
			items[i] = it['?ptr']
			t[i] = it.ActionParam
			it['?ptr'] = it.PrevItemPtr
		end
	end
	items[0] = it['?ptr']
	-- temple bug - each healing adds inactive invisible items to the list
	for i = n0 + 1, n do
		t[i] = nil
	end
	
	-- after
	return t, function(t)
		local t, extra = ArrToHouseScreen(t or {})
		-- create
		for i = n + 1, #t do
			items[i] = dlg:AddButton(x, y + h*(i - n), w, h)
		end
		-- delete
		for i = #t + 1, n do
			it['?ptr'] = items[i]
			it:Destroy()
		end
		-- assign
		for i, v in ipairs(t) do
			it['?ptr'] = items[i]
			it.ActionType = CommandActions[v] or action
			it.ActionParam = v
			if extra[i] then
				table.copy(extra[i], it, true)
			end
		end
		-- done
		if #t ~= n0 then
			dlg:SetKeyboardNavigation(#t, 1, 0, dlg.ItemsCount - #t)
		end
		return t, extra
	end, dlg
end

local HouseScreenInv = table.invert(const.HouseScreens)

local function PopulateNPCDlg(dlgKind, extraItem)
	local t, modify, dlg = ReadPopulatedDialog(Game.CurrentScreen == 13 and 175 or 136, dlgKind == 'SeerPilgrimage' or dlgKind == 'BountyHuntNPC')
	if not t then
		return
	end
	t[#t + 1] = extraItem
	local npc, i, kind = Game.GetNPCFromPtr(CurrentAnyNPC)
	if not dlgKind then
		dlgKind = dlg.Param
		if mmver == 7 and dlgKind ~= 01 then
			dlgKind = t[1] == 77 and 0 or 4
		end
		dlgKind = dlgKind + 200
		dlgKind = dlgKind == 204 and 'Main' or HouseScreenInv[dlgKind] or dlgKind
	end
	local t = {NPC = npc, Index = i, Kind = kind, DlgKind = dlgKind, Result = t}
	
	--!k{NPC :structs.NPC} Change topics of an NPC dialog. 'Result' is an array of NPC commands from #const.HouseScreens:#. Names from #const.HouseScreens:# as text are also allowed. You can also add a table with extra parameters, see the example below. 'Kind' ("NPC", "HiredNPC", "StreetNPC") defines the array NPC belongs to and 'Index' is index in that array.
	-- !\ The following 'DlgKind' values are possible:
	-- !Lua[["Main"]] - Regular NPC conversation. In MM6 this is also the Dismiss conversation with a hired NPC.
	-- !Lua[["StreetNPC"]] - Conversation with a street NPC that you can hire. In MM7 this is also the Dismiss conversation with a hired NPC. In MM6 it ratains items you add to beg/threat/bribe menu.
	-- !Lua[["LackFame"]] - Not enough fame to communicate with a street NPC. Unused.
	-- !Lua[["BegThreatBribe"]] - Beg/Threat/Bribe menu in MM6.
	-- !Lua[["ThreatBribe"]] - Beg/Threat/Bribe menu, but "Beg" option won't do anything, because you've already begged the NPC before.
	-- !Lua[["JoinMenu"]] - Join party menu in MM6, MM7.
	-- !Lua[["JoinRoster"]] - Join party menu in MM8.
	-- !Lua[["TeachSkill"]] - Expert/Master/GM teaching.
	-- !Lua[["JoinGuild"]] - Join a guild.
	-- !Lua[["BountyHuntNPC"]] - Bounty Hunt NPC topic. Only utilized by MM6.
	-- !Lua[["ArenaMenu"]] - Any Arena menu.
	-- !Lua[["SeerPilgrimage"]] - Pilgrimage in MM6.
	events.cocall("PopulateNPCDialog", t, npc)
	local t, extra = modify(t.Result)
	local t = {NPC = npc, Index = i, Kind = kind, DlgKind = dlgKind, Result = t, ExtraParams = extra}
	--!k{NPC :structs.NPC}
	events.cocall("AfterPopulateNPCDialog", t, npc)
end

mem.autohook(mmv(0x43C075, 0x445F7C, 0x442DB0), || PopulateNPCDlg())
mem.autohook(mmv(0x4995FD, 0x4B3F3E, 0x4B2802), || PopulateNPCDlg'JoinGuild')
mem.autohook(mmv(0x49971A, 0x4B403E, 0x4B2902), || PopulateNPCDlg'TeachSkill')
mem.autohook(mmv(0x499CE5, 0x4B45EC, 0x4B309F), || PopulateNPCDlg'Main')
mem.autohook(mmv(0x4A31A5, 0x4BBAC3, 0x4B9C89), || PopulateNPCDlg'BountyHuntNPC')
mem.autohook2(mmv(0x4A35E7, 0x4BBEB9, 0x4BA06B), || PopulateNPCDlg'ArenaMenu')
if mmver == 6 then
	mem.autohook(0x4A3ED4, || PopulateNPCDlg'StreetNPC')  -- begged
	mem.autohook(0x4A3FBB, || PopulateNPCDlg'StreetNPC')  -- threatened
	mem.autohook(0x4A4186, || PopulateNPCDlg'StreetNPC')  -- bribed
	mem.autohook(0x4A3007, || PopulateNPCDlg'SeerPilgrimage')
end
if mmver < 8 then
	mem.autohook(mmv(0x499496, 0x4B3E4D), || PopulateNPCDlg'JoinMenu')  -- street
	mem.autohook(mmv(0x499886, 0x4B417B), || PopulateNPCDlg'JoinMenu')  -- house
else
	mem.autohook(0x4B2B30, || PopulateNPCDlg'JoinRoster')
	mem.autohook(0x4B2C2B, || PopulateNPCDlg'TeachSkill')  -- street
end

function RefillNPCTopics()
	local dlg = Game.CurrentNPCDialog
	local extraItem  -- <use NPC> item
	if mmver < 8 then
		local it = structs.Button:new(dlg.LastItemPtr)
		while it['?ptr'] ~= 0 do
			if it.ActionType == 136 and it.ActionParam == 9 then
				extraItem = 9
				break
			end
			it['?ptr'] = it.PrevItemPtr
		end
	end
	dlg.DlgID = 1  -- "JoinMenu" does it this way
	dlg:Destroy(true)
	dlg['?ptr'] = mem.call(mmv(0x419320, 0x41C3DB, 0x41BAF1), 2, 0, 0, 640, 480, 10, 4, 0)  -- ShowDialog
	PopulateNPCDlg('Main', extraItem)
end
internal.RefillNPCTopics = RefillNPCTopics


-- house dialogs
local function PopulateHouseDlg(eventName, type)
	local t, modify, dlg = ReadPopulatedDialog(405)
	if not t then
		return
	end
	local t = {PicType = type or Game.HousePicType, House = Game.GetCurrentHouse(), Result = t}
	if false then  -- just for help
		--!k{PicType :const.HouseType} Change topics in the main dialog menu in a house, unless isn't an NPC conversation. Unfortunately, the captions displayed won't change as they are hard-coded in various places. 'Result' is an array of topic numbers from #const.HouseScreens:#. Names from #const.HouseScreens:# as text are also supported.
		-- !\ Example:!LUA[[
		-- events.PopulateHouseDialog = |t| if t.PicType == const.HouseType.Training then
		-- 	t.Result = {"Train"}  -- disable learning skills at training halls
		-- end]]
		events.cocall("PopulateHouseDialog", t)
		events.cocall("PopulateArcomageDialog", t)
		events.cocall("PopulateDisplayInventoryDialog", t)
		t.ExtraParams = nil
		--!k{PicType :const.HouseType} There are also similar AfterPopulateArcomageDialog and PopulateDisplayInventoryDialog events
		events.cocall("AfterPopulateHouseDialog", t)
	end
	events.cocall(eventName, t)
	local t, extra = modify(t.Result)
	local t = {PicType = type, House = Game.GetCurrentHouse(), Result = t, ExtraParams = extra}
	--!-
	events.cocall("After"..eventName, t)
	i4[pItemsCount] = dlg.KeyboardItemsCount
end

if mmver == 7 then  -- make room for PopulateHouseDialog hook
	mem.asmpatch(0x4B3AA9, [[nop]])
	mem.asmpatch(0x4B3AAA, [[
		jng @f
		jmp absolute 0x4B3B8F
	@@:
	]])
end

mem.hookfunction(mmv(0x498490, 0x4B3AA5, 0x4B250A), 1, 0, function(d, def, type)
	def(type)
	PopulateHouseDlg("PopulateHouseDialog", type)
end)

if mmver > 6 then
	mem.autohook(mm78(0x4B3A28, 0x4B248D), |d| PopulateHouseDlg"PopulateArcomageDialog")
	mem.autohook(mm78(0x4B3A97, 0x4B24FC), |d| PopulateHouseDlg"PopulateDisplayInventoryDialog")
end

-- learn skill dialogs

function _G.SkillToHouseTopic(i)
	return i + 36
end

function _G.HouseTopicToSkill(i)
	return i >= 36 and i <= 36 + const.Skills.Learning and i - 36 or nil
end

if mmver > 6 then
	local bufLim = mm78(37, 39)
	local buf
	mem.nop(mm78(0x4B381C, 0x4B21B6))
	mem.autohook2(mm78(0x4B3825, 0x4B21BF) - 5, function(d)
		local p, pn = d.esi, d.ebp - 4
		local t = {}
		for i = 1, i4[pn] do
			t[i] = i4[p + i*4 - 4] - 36
		end
		local t = {PicType = Game.HousePicType, House = Game.GetCurrentHouse(), Result = t}
		--!k{PicType :const.HouseType} [MM7+] Change skills in Learn Skills dialog. 'Result' is an array of skill numbers. Skill names from #const.Skills:# are also allowed.
		-- !\ Example:!LUA[[
		-- events.PopulateLearnSkillsDialog = |t| if t.PicType == const.HouseType.Tavern then
		-- 	t.Result[#t.Result + 1] = "Blaster"  -- devs apperently forgot to make taverns teach you Blaster skill
		-- end]]
		events.cocalls("PopulateLearnSkillsDialog", t)
		t = t.Result
		if #t > mm78(3, 5) then
			buf = buf or mem.allocMM(bufLim*4)
			p, d.esi = buf, buf
		end
		local n = min(#t, bufLim)
		i4[pn] = n
		for i = 1, n do
			i4[p + i*4 - 4] = (const.Skills[t[i]] or t[i]) + 36
		end
		if n == 0 then
			d:push(mm78(0x4B39AF, 0x4B23B6))
			return true
		end
	end)
end

mem.IgnoreProtection(false)