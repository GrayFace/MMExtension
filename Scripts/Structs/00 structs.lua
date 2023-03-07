local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, r4, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.r4, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end
local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

local PatchDll = offsets.PatchDll
local PatchOptionsPtr = PatchDll.GetOptions
PatchOptionsPtr = PatchOptionsPtr and PatchOptionsPtr()

local function Dialogs_Find(a, p)
	local i = (p - a["?ptr"])/0x54
	if i >= 0 and i <= 19 then
		return a[i]
	end
end

function events.StructsLoaded()
	Game = structs.GameStructure:new(0)
	rawset(Game, "Dll", PatchDll)
	rawset(Game, "IsD3D", mmver > 6 and i4[mm78(0xDF1A68, 0xEC1980)] ~= 0)
	rawset(Game, "Version", offsets.MMVersion)
	Party = Game.Party
	Map = Game.Map
	Mouse = Game.Mouse
	Screen = Game.Screen
	rawset(Party, '?ptr', Party['?ptr'])
	rawset(Map, '?ptr', Map['?ptr'])
	rawset(Game.DialogsArray, "Find", Dialogs_Find)
	Game.PauseCount =  Game.PauseCount or 0
	Game.PauseCount2 = Game.PauseCount2 or 0
end

local _KNOWNGLOBALS, DecListBuf

local function SetLenRealloc(obj, v, ps, lenA, size, o)
	local old = lenA[ps]
	if v ~= old then
		local p = obj['?ptr'] + o
		u4[p] = mem.reallocMM(u4[p], old*size, v*size)
		lenA[ps] = v
	end
end
structs.aux.SetLenRealloc = SetLenRealloc

local MissileLim = mmv(0, 9110, 12110)

local SetLenReallocMissile = mmver == 6 and SetLenRealloc or function(obj, v, ps, lenA, size, o)
	local old = lenA[ps]
	SetLenRealloc(obj, v, ps, lenA, size, o)
	if old < MissileLim then
		old = MissileLim
	end
	if v > old then
		assert(size == 1)
		local p = obj['?ptr'] + o
		mem.fill(u4[p] + old, v - old, 3)
	end
end

function structs.aux.i4_plus(d, a)
	a = a or i4
	return function(o, obj, name, val)
		o = obj["?ptr"] + o
		if val == nil then
			return a[o] + d
		else
			a[o] = val - d
		end
	end
end

local function i4_CurrentPlayer(o, obj, name, val)
	if val == nil then
		return u4[o] - 1
	else
		u4[o] = val + 1
	end
end

function structs.aux.PDialog(o, obj, name, val)
	if val == nil then
		local v = u4[obj["?ptr"] + o]
		if v ~= 0 then
			return Game.DialogsArray:Find(v)
		end
	else
		i4[obj["?ptr"] + o] = val["?ptr"]
	end
end

function structs.f.GameStructure(define)
	define
	 .Info{Name = "Game"}
	 .Info{new = true, Name = "Version", "(6 - 8)"}
	if mmver > 6 then
		define[0].struct(structs.Arcomage)  'Arcomage'
	end
	if mmver == 7 then
		define[0].struct(structs.GameRaces)  'Races'
	end
	define
	[0].struct(structs.GameClasses)  'Classes'
	[0].struct(structs.GameClassKinds)  'ClassKinds'
	[0].struct(structs.GameParty)  'Party'
	[0].struct(structs.GameMap)  'Map'
	[mmv(0x6A6110, 0, 0)].struct(structs.GameMouse)  'Mouse'
	[0].struct(structs.Weather)  'Weather'
	[mmv(0x971068, 0xDF1A68, 0xEC1980)].struct(structs.GameScreen)  'Screen'
	-- [0].struct(structs.GameStrings)  'Strings'
	[PatchOptionsPtr or 0].struct(structs.PatchOptions)  'PatchOptions'
	if PatchDll.GetLodRecords then
		define[PatchDll.GetLodRecords()].struct(structs.CustomLods)  'CustomLods'
	end
	define
	[offsets.MainWindow].u4  'WindowHandle'
	[offsets.Windowed].u4  'Windowed'
	[offsets.CurrentPlayer].CustomType('CurrentPlayer', 4, i4_CurrentPlayer)
	[mmv(0x4C2750, 0x4EDD80, 0x4FDF88)].array(13).i2  'SkillRecoveryTimes'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x42A239, 0x42EFC9, 0x42DA52)].CustomType('MinMeleeRecoveryTime', 1, function(o, obj, name, val)
		if val == nil then
			return i1[o]
		else
			mem.prot(true)
			i1[o] = val
			i1[mmv(0x406886, 0x406498, 0x406BB9) + 2] = val
			;(mmver == 6 and i4 or i1)[mmv(0x40688B, 0x40649D, 0x406BBE) + 1] = val
			mem.prot(false)
		end
	end)
	[mmv(0x4BCDD8, 0x4E28D8, 0x4F37D8)].i4  'CurrentScreen'
	 .Info ":const.Screens"
	[mmv(0x4D4714, 0x506DC8, 0x5185A8)].i4  'CurrentCharScreen'
	 .Info ":const.CharScreens"
	[mmv(0x5F811C, 0x6A0BC4, 0x6CEB24)].i4  'MainMenuCode'
	 .Info "-1 = in game, 0 = in main menu, 1 = show new game, 2 = show credits, 3 = show load menu, 4 = exit, 5 = loading game, 6 = in new game screen, 8 = in credits, 9 = load game, 10 = load level [MM7+]"
	-- 465012(MM8) SetMainMenuCode
	[mmv(0x52D0E4, 0x576CEC, 0x587914)].b4  'LoadingScreen'
	[mmv(0x533EB8, 0x590F10, 0x5A537C)].i4  'DialogNPC'
	[mmv(0x54D040, 0x590F0C, 0x5A5378)].i4  'NPCCommand'
	[mmv(0x9DDD8C, 0xF8B01C, 0xFFD408)].i4  'HouseScreen'
	[mmv(0x551F94, 0x591270, 0x5A56E0)].i4  'HouseNPCSlot'
	 .Info "If #Game.HouseOwnerPic:# isn't '0', the value of '1' refers to the shop keeper and higher value needs to be reduced by 1 before accessing .\nIf #Game.HouseExitMap:# isn't '0', last slot is occupied by map enter icon."
	[mmv(0x53CB60, 0x5912A4, 0x5A5714)].i4  'HouseNPCSlotsCount'
	[mmv(0x9DDD9C, 0xF8B034, 0xFFD420)].i4  'HouseCost'
	[mmv(0x9DDD70, 0xF8B028, 0xFFD414)].i4  'HouseAllowAction'
	[mmv(0x9DDD88, 0xF8B02C, 0xFFD418)].i4  'HouseActionInfo'
	[mmv(0x9DDD98, 0xF8B030, 0xFFD41C)].i4  'HouseTeachMastery'
	[mmv(0x9DDD80, 0xF8B018, 0xFFD404)].i4  'HousePicType'
	[mmv(0x552F48, 0x590F00, 0x5A5384)].i4  'HouseOwnerPic'
	[mmv(0x55BDA4, 0x5C3450, 0x5DB8FC)].i4  'HouseExitMap'
	[mmv(0x54D020, 0x591258, 0x5A56C8)].array(1, 6).i4  'HouseNPCs'
	 .Info "If #Game.HouseExitMap:# isn't '0', last slot is occupied by map enter pseudo-NPC."
	[mmv(0x9DDDFC, 0xF8B060, 0xFFD450)].i4  'HouseItemsCount'
	 .Info "Number of interactive items of the dialog. Items count of the dialog object gets changed to this or 0 depending on selected player being concious."
	
	local DlgLen = setmetatable({}, {
		__index = |_, p| i4[p] + 1,
		__newindex = |_, p, v| i4[p] = v - 1,
	})
	local function DialogByIndex(o, obj, name, val)
		local a = Game.DialogsArray
		if val == nil then
			return a[u4[obj["?ptr"] + o] - 1]
		else
			i4[obj["?ptr"] + o] = (val["?ptr"] - a["?ptr"])/0x54 + 1
		end
	end
	define[mmv(0x4D48F8, 0x506DD0, 0x518608)].array(20).struct(structs.Dlg)  'DialogsArray'
	[mmv(0x4CB5F8, 0x507460, 0x518C98)].alt.array(20).CustomType('DialogIndexes', 4, structs.aux.i4_plus(-1))
	.array{20, lenA = DlgLen, lenP = mmv(0x4D46BC, 0x5074B0, 0x518CE8)}.CustomType('Dialogs', 4, DialogByIndex)
	 .Info{"List of currently open dialogs, from lowest to topmost. Doesn't include object-oriented dialogs in MM8.\nDialog at index '0' contains adventure interface that you see when no dialog is open. Even when you boot into the main menu, this dialog is present.", Type = "structs.Dlg"}
	
	[mmv(0x4D50C0, 0x507A3C, 0x519324)].CustomType('CurrentNPCDialog', 4, structs.aux.PDialog)
	 .Info{Type = "structs.Dlg"}
	.func{name = "ExitHouseScreen", p = mmv(0x4A4AA0, 0x4BD818, 0x4BB3F8), ret = true}
	if mmver == 8 then
		define
		[0x5CCCE4].b1  'InQuestionDialog'
		[0x1006148].struct(structs.OODialogManager)  'OODialogs'
		[0x100614C].u4  'OODialogPtr'
		 .Info "Same as #Game.OODialogs.CurrentDialogPtr:structs.OODialogManager.CurrentDialogPtr#"
		local function d(v, std)
			return v == nil and (std or 0) or v
		end
		function define.f.OODialogProcessKey(key, _1, _2, _3, _4)
			call(0x4D1D6A, 1, 0x1006148, key or 27, d(_1, 1), d(_2), d(_3), d(_4))
		end
		function define.f.GetAdventureInnInfo()
			local p = u4[0x100614C]
			if p ~= 0 and Game.CurrentScreen == 29 then
				local inv = i4[p + 0xC] == 1
				return i4[p + (inv and 0x130 or 0x128)], inv
			end
		end
		define.Info "Returns 'PlayerIndex', 'InInventory' or nothing if Adventure Inn dialog isn't active.\n'PlayerIndex' is the index of currently selected player in #Party.PlayersArray:#. Compare it against !Lua[=[Party.PlayersIndexes[Party.CurrentPlayer]]=] to see if selected player is part of the party.\n'InInventory' is 'true' if player inventory (or Stats, Skills, Awards) screen is open."
	end
	define
	[mmv(0x4C3E10, 0x4F076C, 0x500D30)].array(mmv(17, 11, 11)).i4  'GuildJoinCost'
	[mmv(0x4D5088, 0x5079F8, 0x5192EC)].array(7).EditPChar  'StatsNames'
	 .Info{Sig = "[stat:const.Stats]"}
	[mmv(0x56F27C, 0x5C85F8, 0x5E4990)].array(7).EditPChar  'StatsDescriptions'
	 .Info{Sig = "[stat:const.Stats]"}
	[mmv(0x970C7C, 0xAE3150, 0xBB3060)].array(mmv(31, 37, 39)).EditPChar  'SkillNames'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x56F394, 0x5C88F0, 0x5E4CB0)].array(mmv(31, 37, 39)).EditPChar  'SkillDescriptions'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x56B76C, 0x5C8858, 0x5E4C10)].array(mmv(31, 37, 39)).EditPChar  'SkillDesNormal'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x56F29C, 0x5C87C0, 0x5E4B70)].array(mmv(31, 37, 39)).EditPChar  'SkillDesExpert'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x56F318, 0x5C8728, 0x5E4AD0)].array(mmv(31, 37, 39)).EditPChar  'SkillDesMaster'
	 .Info{Sig = "[skill:const.Skills]"}
	if mmver > 6 then
		define[mm78(0x5C8690, 0x5E4A30)].array(mmv(31, 37, 39)).EditPChar  'SkillDesGM'
	 .Info{Sig = "[skill:const.Skills]"}
	end
	define[mmv(0x970BEC, 0xAE3070, 0xBB2FD0)].array(mmv(18, 36, 36)).EditPChar  'ClassNames'
	 .Info{Sig = "[class:const.Class]"}
	[mmv(0x56B6C0, 0x5C8560, 0x5E48F0)].array(mmv(18, 36, 36)).EditPChar  'ClassDescriptions'
	 .Info{Sig = "[class:const.Class]"}
	[mmv(0x4D5F4C, 0x50CA54, 0x51E334)].array{40, lenA = i4, lenP = mmv(0x4D5F48, 0x50CA50, 0x51E330)}.struct(structs.ActionItem)  'Actions'
	if mmver > 6 then
		define[mm78(0x50C86C, 0x51E14C)].array{40, lenA = i4, lenP = mm78(0x50C868, 0x51E148)}.struct(structs.ActionItem)  'ActionsNext'
	end
	define.func{name = "ProcessActions", p = mmv(0x42ADA0, 0x4304D6, 0x42EDD8)}
	[mmv(0x6199C0, 0x6A0BC8, 0x6CEB28)].i4  'ExitMapAction'
	 .Info ":const.ExitMapAction"
	if mmver == 7 then
		define[0x5077C8]
		.b1  'FlashHistoryBook'
		.b1  'FlashAutonotesBook'
		.b1  'FlashQuestBook'
	end
	define
	[mmv(0x52D29C, 0x576EAC, 0x587ADC)].b4  'NeedRedraw'
	[mmv(0x55BC04, 0x5C32A8, 0x5DB758)].string(200)  'StatusMessage'
	.string(200)  'MouseOverStatusMessage'
	.i4  'StatusDisappearTime'
	if mmver > 6 then
		define.b4  'NeedUpdateStatusBar'
	end
	if mmver == 7 then
		define[internal.FoodGoldVisible or 0].b1  'FoodGoldVisible'
		 .Info "Set it to 'false' to skip 1 draw call of drawing food and gold"
	end
	define
	[mmv(0x4CB6A0, 0x506D8C, 0x51856C)].i4  'EscMessageLastScreen'
	[mmv(0x4D50DC, 0x507A5C, 0x519340)].CustomType('EscMessageDialog', 4, structs.aux.PDialog)
	 .Info{Type = "structs.Dlg"}
	
	[mmv(0x9DDE04, 0xF8B068, 0xFFD458)].EditPChar  'NPCMessage'
	 .Info "Current message displayed in a dialog with some NPC"
	[mmv(0x55276C, 0x5B07B8, 0x5C6848)].string(2000)  'StreetMessage'
	 .Info "Message displayed by #Message:#, #Question:#, #evt.SimpleMessage:# and #evt.Question:# when not talking to NPC."
	[mmv(0x970BE0, 0xA74F58, 0xAB3000)].union 'DelayedFaceAnimation'
		.i8  'Delay'
		.i2  'Animation'
		.i2  'PlayerIndex'
	.union()
	-- (MM6)
	-- 54F060 Timers
	-- 552F50 TimersCount
	-- 5F883C ; char SaveSlotsFiles[40][280]
	-- 5FB9B4 SaveSlotsCount
	-- 6296EC dist_mist

	[mmv(0x560C14, 0x5D2864, 0x5EFBCC)].array{mmv(581, 800, 803), lenA = i4, lenP = mmv(0x560C10, 0x5D2860, 0x5EFBC8)}.struct(structs.ItemsTxtItem)  'ItemsTxt'
	.array(mmv(14, 24, 24)).struct(structs.StdItemsTxtItem)  'StdItemsTxt'
	.array(mmv(59, 72, 72)).struct(structs.SpcItemsTxtItem)  'SpcItemsTxt'
	[mmv(0x6A86A8, 0x723BB8, 0x761500)].array(mmv({500, 586}, {700, 781}, {700, 781})).EditPChar  'ScrollTxt'
	-- rnditems

	local i, j = mmv(160, 222, 222), mmv(188, 271, 271)
	define[mmv(0x56A780, 0x5E17C4, 0x5FEC10)].array(i, j).array(i, j)[mmv('u1','i2','i2')]  'PotionTxt'
	if mmver > 6 then
		define.array(i, j).array(i, j).i2  'PotNotesTxt'
	end
	
	if mmver == 6 then
		define[0x56C188].array{174, lenA = i4, lenP = 0x56C188 + structs.MonstersTxtItem["?size"]*174}.struct(structs.MonstersTxtItem)  'MonstersTxt'
	elseif mmver == 7 then
		define[0x5CCCC0].array{265, lenA = i4, lenP = 0x5CCCC0 + 23444}.struct(structs.MonstersTxtItem)  'MonstersTxt'
		[0x5D27D8].array{31, lenA = i4, lenP = 0x5CCCC0 + 23448}.EditPChar  'PlaceMonTxt'
	else
		define[0x5E9530].array{268, lenA = i4, lenP = 0x5E9530 + 6563*4}.struct(structs.MonstersTxtItem)  'MonstersTxt'
		[0x5EF9B0].array{131, lenA = i4, lenP = 0x5E9530 + 6564*4}.EditPChar  'PlaceMonTxt'
	end
	if mmver == 6 then
		define[0x55F628].array{100, lenA = i4, lenP = 0x55F628 + 5600}.struct(structs.MapStatsItem)  'MapStats'
	else
		define[mm78(0x5CAA38, 0x5E6E00)].array{77, lenA = i4, lenP = mm78(0x5CAA38, 0x5E6E00) + 0x44*77}.struct(structs.MapStatsItem)  'MapStats'
	end
	define
	[mmv(0x4C3B74, 0x4EFEC8, 0x5004E8)].array(mmv(68, 78, 78)).i2  'MapDoorSound'
	[mmv(0x4C1F18, 0x4EC9B8, 0x4FC9EC)].array(16).struct(structs.FogChances)  'MapFogChances'
	if mmver < 8 then
		define[mmv(0x465243, 0x473C64)].CustomType('FlyCeiling', 4, function(o, obj, _, val)
			if val == nil then
				return i4[o]
			else
				mem.IgnoreProtection(true)
				i4[o] = val
				mem.IgnoreProtection(false)
			end
		end)
		 .Info "3000 in MM6, 4000 in MM7+, in MM8 it's configured per map (!Lua[[Map.OutdoorExtra.Ceiling]])"
	end
	
	define
	[mmv(0x551D20, 0x5B6428, 0x5CCCB8)].struct(structs.MoveToMap) 'MoveToMap'
	[mmv(0x52D0A8, 0x576CB0, 0x5878D8)].struct(structs.ProgressBar)  'ProgressBar'
	[0].struct(structs.DialogLogic)  'DialogLogic'
	[mmv(0x55BDB4, 0x5C346C, 0x5DB91C)].alt.i4  'Lucida_fnt'
	.pstruct(structs.Fnt)  'FontLucida'
	[mmv(0x55BDB8, 0x5C3488, 0x5DB938)].alt.i4  'Smallnum_fnt'
	.pstruct(structs.Fnt)  'FontSmallnum'
	[mmv(0x55BDC4, 0x5C3468, 0x5DB918)].alt.i4  'Arrus_fnt'
	.pstruct(structs.Fnt)  'FontArrus'
	[mmv(0x55BDC8, 0x5C347C, 0x5DB92C)].alt.i4  'Create_fnt'
	.pstruct(structs.Fnt)  'FontCreate'
	[mmv(0x55BDCC, 0x5C3484, 0x5DB934)].alt.i4  'Comic_fnt'
	.pstruct(structs.Fnt)  'FontComic'
	[mmv(0x55BDBC, 0x5C3474, 0x5DB924)].alt.i4  'Book_fnt'
	.pstruct(structs.Fnt)  'FontBook'
	[mmv(0x55BDD4, 0x5C3470, 0x5DB920)].alt.i4  'Book2_fnt'
	.pstruct(structs.Fnt)  'FontBook2'
	if mmver < 8 then
		define[mmv(0x55BDDC, 0x5C3480, nil)].alt.i4  'Cchar_fnt'
		.pstruct(structs.Fnt)  'FontCchar'
	end
	define
	[mmv(0x55BDD0, 0x5C3460, 0x5DB910)].alt.i4  'Autonote_fnt'
	.pstruct(structs.Fnt)  'FontAutonote'
	[mmv(0x55BDC0, 0x5C3464, 0x5DB914)].alt.i4  'Spell_fnt'  -- Autonote_fnt2
	.pstruct(structs.Fnt)  'FontSpell'
	[mmv(0x55CDE0, 0x5C5C30, 0x5DF0E0)].alt.string(2000)  'TextBuffer'
	.array(2000).u1  'TextBufferBytes'
	 .Info "Lets you get address of 'TextBuffer' or access it byte by byte"
	[mmv(0x55D5B0, 0x5C6400, 0x5E1020)].alt.string(2000)  'TextBuffer2'
	.array(2000).u1  'TextBuffer2Bytes'
	 .Info "Lets you get address of 'TextBuffer2' or access it byte by byte"
	[mmv(0x55BDE0, 0x5C4430, 0x5DC8E0)].alt.string(2048)  'WordWrappedText'
	.array(2048).u1  'WordWrappedTextBytes'
	 .Info "Lets you get address of 'WordWrappedText' or access it byte by byte"
	[mmv(0x5F6E0C, 0x69AC8C, 0x6C8BC4)].array(mmv(12, 30, 30)).i4  'KeyCodes'
	[mmv(0x5F6E3C, 0x69AD04, 0x6C8C3C)].array(mmv(12, 30, 30)).i4  'KeyTypes'
	[mmv(0x908D08, 0xACCE64, 0xB20EBC)].i8  'Time'
	 .Info "Since 00 AM, January 1st, 1165/1168/1172"
	[mmv(0x908D10, 0xACD544, 0xB215AC)].i4  'Year'
	 .Info "Actual value, like 1172"
	[mmv(0x908D14, 0xACD548, 0xB215B0)].i4  'Month'  -- (0 - 11)
	 .Info "(0 - 11)"
	[mmv(0x908D18, 0xACD54C, 0xB215B4)].i4  'WeekOfMonth'  -- (0 - 3)
	 .Info "(0 - 3)"
	[mmv(0x908D1C, 0xACD550, 0xB215B8)].i4  'DayOfMonth'  -- (0 - 27), add 1 to it
	 .Info "(0 - 27)"
	[mmv(0x908D20, 0xACD554, 0xB215BC)].i4  'Hour'  -- (0 - 23)
	 .Info "(0 - 23)"
	[mmv(0x908D24, 0xACD558, 0xB215C0)].i4  'Minute'  -- (0 - 59)
	 .Info "(0 - 59)"
	[mmv(0x908D28, 0xACD55C, 0xB215C4)].i4  'Second'  -- (0 - 59)
	 .Info "(0 - 59)"
	[mmv(0x45031C, 0x460465, 0x45DEBB)].CustomType('BaseYear', 0, function(o, obj, _, val)
		if val == nil then
			return i4[o]
		else
			local t = mmv(
				{0x45031C, 0x47D9DC, 0x47DB1C, 0x47DC5C, 0x47DD9C, 0x47DEDC, 0x47E01C, 0x47E1A1, 0x47E2EB, 0x47E6EB, 0x47E8B4, 0x47FC27, 0x481D06, 0x481F3D, 0x4825EB, 0x48277B, 0x482914, 0x482998, 0x483FBC, 0x484E96, 0x4881C0, 0x4962BD}, 
				{0x460465, 0x48E71F, 0x49401D, 0x494115, 0x4B1C3C},
				{0x45DEBB, 0x48DB8A, 0x492253, 0x49234B, 0x4B0428}
			)
			local t1 = mmv({}, {0x41E0DE}, {0x41D689})
			local t2 = mmv(
				{0x4A3056, 0x4A3201}, 
				{0x4BBB16, 0x4BCCDE},
				{0x4B9CC3, 0x4BAD71}
			)
			mem.IgnoreProtection(true)
			for _, p in ipairs(t) do
				i4[p] = val
			end
			for _, p in ipairs(t1) do
				i4[p] = -val
			end
			for _, p in ipairs(t2) do
				i4[p] = val*12 - 1
			end
			mem.IgnoreProtection(false)
		end
	end)
	[mmv(0x483E62, 0x4902C2, 0x4904EB) - 4].CustomType('MaxBirthYear', 4, function(o, obj, _, val)
		if val == nil then
			return i4[o]
		else
			mem.IgnoreProtection(true)
			i4[o] = val
			mem.IgnoreProtection(false)
		end
	end)
	[mmv(0x90E838, 0xAD45B0, 0xB7CA88)].bit ('NeedRender', 2)
	 .Info "Same as Party.NeedRender"
	[mmv(0x908E30, 0xACD6B4, 0xB21728)].b4  'TurnBased'
	[mmv(0x4C7DF4, 0x4F86DC, 0x509C9C)].i4  'TurnBasedPhase'
	 .Info "1 = monsters move, 2 = combat, 3 = party walking"
	[mmv(0x4C6CA8, 0xAE2F7C, 0xBB2E0C)].array(mmv(4, 4, 5)).i4  'TurnBasedDelays'
	-- [mmv(0x9CF598, 0xF78F58, 0xFEB360)].i4  'PlaySoundStruct'
	[mmv(0x9CF5A0, 0xF791FC, 0xFEB604)].i4  'RedbookHandle'
	[mmv(0x9CF5A4, 0xF79200, 0xFEB608)].i4  'MSSHandle'
	-- [mmv(0x9CF5C0, 0xF7921C, 0xFEB624)].i4  'MasterVolume'
	if mmver > 6 then
		define[mm78(0xF8BA08, 0xFFDE00)].i4  'BinkVideo'
		[mm78(0x4b440e, 0x4b2ebc)].CustomType('DialogTopicsLimit', 1, function(o, obj, _, val)
			if val == nil then
				return i1[o]
			else
				local t = mm78(
					{0x4b440e, 0x4b445d, 0x4b44ac, 0x4b44fb, 0x4b454a, 0x4b4599, 0x41c67a, 0x41c6cd, 0x41c720, 0x41c773, 0x41c7c6, 0x41c81d},
					{0x4b2ebc, 0x4b2f0b, 0x4b2f5a, 0x4b2fa9, 0x4b2ff8, 0x4b3047, 0x41bd66, 0x41bdb9, 0x41be0c, 0x41be5f, 0x41beb2, 0x41bf09}
				)
				mem.IgnoreProtection(true)
				for _, p in ipairs(t) do
					i1[p] = min(val, 127)
				end
				mem.IgnoreProtection(false)
			end
		end)
	end
	define
	[mmv(0x9DE364, 0xF8B9B0, 0xFFDDA8)].i4  'SmackVideo'
	[mmv(0x4BF8A0, 0x4E8348, 0x4F7F4C)].array(20).u1  'EquipStat2ItemSlot'  -- (24) ?
	if mmver == 6 then
		define.array(1, 180).b1  'MonsterSex'
	elseif mmver == 7 then
		define
		.array(1, 88).b1  'MonsterClassSex'
		 .Info "!Lua[[MonClass = (Id + 2):div(3)]]"
		.array(1, 88).u1  'MonsterClassRace'
		 .Info "!Lua[[MonClass = (Id + 2):div(3)]]"
	end
	define
	[mmv(0x4BD10C, 0x4E2B50, 0x4F3A80)].array(mmv(60, 88, 66)).i1  'MonsterClassInfoY'
	[offsets.TimeStruct1 + 4].b4  'Paused'
	 .Info "Game logic is paused"
	[offsets.TimeStruct2 + 4].b4  'Paused2'
	 .Info "Updates of 3D view are paused"
	[offsets.TimeStruct1 + 28].i4  'TimeDelta'
	 .Info "Time since last tick"
	[offsets.TimeStruct2 + 28].i4  'TimeDelta2'
	 .Info "Time since last tick of updating 3D view"
	.Info{new = true, Name = "PauseCount", "See #Game.Pause:# and #Game.Resume:#"}
	.Info{new = true, Name = "PauseCount2", "See #Game.Pause2:# and #Game.Resume2:#"}
	[mmv(internal.FrameCounter or 0, 0x5C6C70, 0x5E3000)].u4  'FrameCounter'
	[mmv(0x90EADC, 0xAD45B4, 0xB7CA8C)].array(0, mmv(47, 52, 52)).array(12).struct(structs.Item)  'ShopItems'
	 .Info{Sig = "[house][slot]"}
	[mmv(0x9129DC, 0xAD9F24, 0xB823FC)].array(mmv(1, 0, 0), mmv(46, 52, 52)).array(12).struct(structs.Item)  'ShopSpecialItems'
	 .Info{Sig = "[house][slot]"}  -- in reality it starts with index 0, but ShopItems overflows, just like ShopSpecialItems overflows into GuildItems
	[mmv(0x91663C, 0xADF894, 0xB87D6C)].array(mmv(119, 139, 139), mmv(140, 170, 172)).array(mmv(1, 1, 12)).array(12).struct(structs.Item)  'GuildItems'
	 .Info{Sig = "[house][school][slot]"; "In MM8 in each guild items for all 12 schools of magic are generated. In MM6 and MM7 'school' can only be 0."}
	[mmv(0x4C3E94, 0x4F07B0, 0x500D78)].array(mmv(119, 139, 139), mmv(152, 170, 170)).i4  'GuildAwards'
	[mmv(0x9DDDA4, 0xF8AFE8, 0xFFD3D4)].array(12).i4  'GuildItemIconPtr'
	 .Info{Sig = "[slot]"; [[Loaded icons for current guild's items.
!\ Example:!Lua[=[
function events.GuildItemsGenerated(t)
	local a = Game.GuildItems[t.House][0]   -- items array for this guild (for MM6 and MM7)
	a[0]:Randomize(5, const.ItemType.Book)  -- put random powerful book into first slot
	a[0].Identified = true
	Game.GuildItemIconPtr[0] = Game.IconsLod:LoadBitmapPtr(a[0]:T().Picture)
end]=]
]]}
	[mmv(0x90E894, 0xACCEC4, 0xB20F1C)].array(mmv(0, 0, 0), mmv(46, 52, 52)).i8  'ShopNextRefill'
	 .Info{Sig = "[house]"}
	[mmv(0x90EA0C, 0xACD06C, 0xB210C4)].array(mmv(119, 139, 139), mmv(140, 170, 172)).i8  'GuildNextRefill'
	 .Info{Sig = "[house]"}
	[mmv(0x4C43DC, 0x4F0288, 0x5007F0)].array(1, 14).struct(structs.ShopItemKind)  'ShopWeaponKinds'
	[mmv(0x4C45F8, 0x4F04C8, 0x500A30)].array(1, 14).struct(structs.ShopItemKind)  'ShopWeaponKindsSpecial'
	[mmv(0x4C4468, 0x4F0318, 0x500880)].array(15, 28).array(1,2).struct(structs.ShopItemKind)  'ShopArmorKinds'
	[mmv(0x4C4684, 0x4F0558, 0x500AC0)].array(15, 28).array(1,2).struct(structs.ShopItemKind)  'ShopArmorKindsSpecial'
	[mmv(0x4C4580, 0x4F0430, 0x500998)].array(29, 41).i2  'ShopMagicLevels'
	[mmv(0x4C479C, 0x4F0670, 0x500BD8)].array(29, 41).i2  'ShopMagicLevelsSpecial'
	[mmv(0x4C3E80, 0x4F0798, 0x500D5C)].array(mmv(79, 89, 89), mmv(88, 98, 101)).i2  'TrainingLevels'
	[mmv(0x4C48B0, 0x4F0DB0, 0x501238)].array(mmv(119, 139, 139), mmv(140, 170, 172)).i2  'GuildSpellLevels'
	if mmver > 6 then
		define
		[mm78(0x4F044C, 0x50099E)].array(42, 53).i2  'ShopAlchemistLevels'
		[mm78(0x4F068C, 0x500BF4)].array(42, 53).i2  'ShopAlchemistLevelsSpecial'
		[mm78(0xACD16C, 0xB211D4)].array(53).i8  'ShopTheftExpireTime'
	else
		define
		[0x4C459C].array(42, 47).struct(structs.GeneralStoreItemKind)  'GeneralStoreItemKinds'
		[0x4C47B8].array(42, 47).struct(structs.GeneralStoreItemKind)  'GeneralStoreItemKindsSpecial'
		 .Info "Yes, MM6 generates special items in general stores, but doesn't support buying them."
	end
	define
	[mmv(0x4C3D60, 0x4F0238, 0x5007A0)].array(19).EditConstPChar  'ShopBackgroundByType'
	
	if mmver < 8 then
		define[mmv(0x4CA718, 0x505828)].array(480).i4  'ScanlineOffset'
	end
	define
	[mmv(0x9B1090, 0xE31A9C, 0xF019B4)].parray(480).array(640).struct(structs.ObjectRef)  'ObjectByPixel'
	 .Info{Sig = "[y][x]"}
	[mmv(0x918938, 0xAE2F74, 0xBB2E04)].i4  'ArmageddonTimeLeft'
	 .Info "maximum is 417"
	[mmv(0x91893C, 0xAE2F78, 0xBB2E08)].i4  'ArmageddonSkill'
	 .Info "damage is 50 + skill"
	[mmv(0x6296F4, 0x6BDF04, 0x6F300C)].i4  'OutdoorViewMul'
	 .Info "Acts as the opposite of FOV"
	.i4  'OutdoorViewDiv'
	 .Info "!Lua[[= math.floor(0x10000/Game.OutdoorViewMul)]]"
	[mmv(0x56B830, 0x5E4000, 0x601448)].array(mmv(596, 677, 750)).EditPChar  'GlobalTxt'
	[mmv(0x52D530, 0x5912B8, 0x5A5728)].array(mmv(558, 526, 526)).struct(structs.Events2DItem)  'Houses'  -- 2DEvents
	 .Info "2DEvents.txt"
	[mmv(0x4BE888, 0x4E5F40, 0x4F66D8)].array(mmv(119, 196, 161)).struct(structs.HouseMovie)  'HouseMovies'
	[mmv(0x4C1048, 0x4EAF3C, 0x4FADE4)].array(1, mmv(234, 464, 500)).EditPChar  'TransTxt'
	[mmv(0x4BE3B8, 0x4E4540, 0x4F53F0)].array(1, 6).i4  'SpecialEnterX'
	 .Info "Used for Free Haven Sewer entrances in MM6. Negative Questbit Restrictions field in '2DEvents.txt' corresponds to array index"
	.array(1, 6).i4  'SpecialEnterY'
	.array(1, 6).i4  'SpecialEnterZ'
	.array(1, 6).i4  'SpecialEnterDirection'
	[mmv(0x6A7680, 0x7214E8, 0x75E450)].array{1, mmv(517, 789, 1000), ItemSize = 8}.EditPChar  'NPCTopic'
	[mmv(0x6A7684, 0x7214EC, 0x75E454)].array{1, mmv(517, 789, 1000), ItemSize = 8}.EditPChar  'NPCText'
	if mmver > 6 then
		define
		[mm78(0x73B8D4, 0x7798B8)].array(0, 205).array(0, 1).EditPChar  'NPCGreet'
		[mm78(0x73BFAA, 0x779F8E)].array(0, 50).i2  'NPCGroup'
		[mm78(0x739CF4, 0x778F50)].array(0, 50).EditPChar  'NPCNews'
		[mm78(0x5C89E0, 0x5E4DA8)].array(1, 29).struct(structs.HistoryTxtItem)  'HistoryTxt'
	else
		define
		[0x6B8C60].array{0, 279}.struct(structs.NPCNewsItem)  'NPCNews'
		[0x6BA568].array(96).i2  'NPCNewsCountByMap'
	end
	if mmver < 8 then
		define[mmv(0x6A9168, 0x724050)]
		.array(mmv(400, 501)).struct(structs.NPC)  'NPCDataTxt'
		.array{mmv(400, 501), lenA = i4, lenP = mmv(0x6BA534, 0x73C014)}.struct(structs.NPC)  'NPC'
		[mmv(0x6BA85C, 0x73C110)].array(mmv(78, 59)).EditPChar  'NPCProfNames'
		[mmv(0x6B5DC8, 0x737AA8)].array(mmv(78, 59)).struct(structs.NPCProfTxtItem)  'NPCProfTxt'
		[mmv(0x6B4CE8, 0x7369C8)].array(540).array(2).EditPChar  'NPCNames'
		[mmv(0x6BA540, 0x73C020)].array(2).i4  'NPCNamesCount'
	else
		define[0x761998]
		.array(551).struct(structs.NPC)  'NPCDataTxt'
		.array(551).struct(structs.NPC)  'NPC'
	end
	define
	[mmv(0x6B74F0, 0x737F44, 0x7771A0)].array{100, lenA = i4, lenP = mmv(0x6BA530, 0x73C010, 0x779FF4)}.struct(structs.NPC)  'StreetNPC'
	[mmv(0x4BDD70, 0x4E3C48, 0x4F4870)].array(0, mmv(99, 99, 132)).struct(structs.SpellInfo)  'Spells'
	[mmv(0x56ABD0, 0x5CBEB0, 0x5E8278)].array(0, mmv(99, 99, 132)).struct(structs.SpellsTxtItem)  'SpellsTxt'
	[mmv(0x4C28E2, 0x4EDF32, 0x4FE12A)].array(1, mmv(99, 99, 132)).i2  'SpellSounds'
	[mmv(0x4BDBD8, 0x4E3AB0, 0x4F4648)].array(1, mmv(99, 99, 132)).CustomType('SpellObjId', 4, function(o, obj, name, val)
		if val == nil then
			return i2[obj["?ptr"] + o]
		else
			i2[obj["?ptr"] + o] = val
		end
	end)
	[mmv(0x4A6C1A, 0x4BF832, 0x4BD38D)].CustomType('TitleTrack', 1, function(o, obj, _, val)
		if val == nil then
			return u1[o]
		else
			mem.IgnoreProtection(true)
			u1[o] = val
			u1[mmv(0x453768, 0x4630B1, 0x46103C)] = val
			mem.IgnoreProtection(false)
		end
	end)
	[internal.TrackOffsetBuf or 0x4A6C31].CustomType('TitleTrackOffset', 4, function(o, obj, _, val)
		if val == nil then
			return i4[o]
		elseif mmver ~= 6 then
			i4[o] = val
		else
			mem.IgnoreProtection(true)
			i4[o] = val
			i4[0x45377F] = val
			mem.IgnoreProtection(false)
		end
	end)
	if mmver == 6 then
		define[0x452FDE].CustomType('NarratorTrack', 1, function(o, obj, _, val)
			if val == nil then
				return u1[o]
			else
				mem.IgnoreProtection(true)
				u1[o] = val
				mem.IgnoreProtection(false)
			end
		end)
	end
	
	local pmis = mem.StaticAlloc(8)
	mem.fill(pmis, 8)
	define[pmis].parray{lenA = i4, lenP = pmis + 4, lenSet = SetLenReallocMissile}.struct(structs.MissileSetup)  'MissileSetup'
	if mmver > 6 then
		define
		[mm78(0x44FA9D, 0x44D1FB)].EditConstPChar  'SummonElementalA'
		[mm78(0x44FA96, 0x44D1F4)].EditConstPChar  'SummonElementalB'
		[mm78(0x44FA8A, 0x44D1DD)].EditConstPChar  'SummonElementalC'
	end
	define
	[mmv(0x6A8804, 0x722D90, 0x760390)].array(0, 512).EditPChar  'QuestsTxt'
	if mmver == 6 then
		define[0x6A9008].array{0, 87}.EditPChar  'AwardsTxt'
		define[internal.AwardCategoriesPtr or 0].parray{lenA = i4, lenP = (internal.AwardCategoriesPtr or 0) + 4, lenSet = SetLenRealloc}.i4  'AwardsSort'
	else
		define
		[mm78(0x723D00, 0x761648)].array{0, 104, ItemSize = 8}.EditPChar  'AwardsTxt'
		[mm78(0x723D04, 0x76164C)].array{0, 104, ItemSize = 8}.i4  'AwardsSort'
	end
	if mmver == 6 then
		define
		[0x6BA628].array{0, 128}.EditPChar  'AutonoteTxt'
		[0x4BC1F8].array(5).array(48).i2  'AutonotesByCategory'
	else
		define
		[mm78(0x723598, 0x760B98)].array{0, mm78(195, 300), ItemSize = 8}.EditPChar  'AutonoteTxt'
		[mm78(0x72359C, 0x760B9C)].array{0, mm78(195, 300), ItemSize = 8}.i4  'AutonoteCategory'
		 .Info "0 = potion\n1 = stat\n2 = obelisk\n3 = seer\n4 = misc\n5 = teacher"
	end
	define
	[mmv(0x6BA9A0, 0x73C208, 0x77A1E0)].array(4).array(mmv(6, 7, 7)).EditPChar  'MerchantTxt'
	[mmv(0x4D50A8, 0x507A18, 0x51930C)].b4  'CtrlPressed'
	[mmv(0x4D50EC, 0x507A70, 0x519354)].b1  'RightButtonPressed'
	[mmv(0x4C1F98, 0x4ECA60, 0x4FCA88)].array(6).struct(structs.TownPortalTownInfo)  'TownPortalInfo'
	[mmv(0x4BCAE4, 0x4E1D2C, 0x501BC8)].array(6).i2  'TownPortalX'
	 .Info "(Town portal picture: townport)"
	[mmv(0x4BCAF0, 0x4E1D38, 0x501BD4)].array(6).i2  'TownPortalY'
	 .Info "(Town portal icons [MM7+]: tpharmndy, tpelf, tpwarlock, tpisland, tpheaven, tphell)"
	if mmver < 8 then
		define
		[mmv(0x4BCB08, 0x4E1D50)].array(6).i2  'TownPortalHeight'
		[mmv(0x4BCAFC, 0x4E1D44)].array(6).i2  'TownPortalWidth'
	end
	define
	[mmv(0x4C3F20, 0x4F0830, 0x500DF8)].array(mmv(36, 35, 25)).struct(structs.TravelInfo)  'TransportLocations'
	[mmv(0x4C43A0, 0x4F0C90, 0x501118)].array(mmv(48, 54, 54), mmv(68, 73, 73)).array(1, mmv(3, 4, 4)).i1  'TransportIndex'
	if mmver > 6 then
		define[mm78(0x5C8B40, 0x5E4F08)].array(89).array(89).u1  'HostileTxt'
		 .Info{Sig = "[mon1][mon2]"; "0 - 4. Attitude of 'mon1' towards 'mon2'. 'mon2' = 0 is party. 'mon1' and 'mon2' are monster classes: !Lua[[mon1 = (Id1 + 2):div(3)]]"}
	end
	define
	[mmv(0x457F52, 0x46627F, 0x46462C)].CustomType('NewGameMap', 4, function(o, obj, name, val)
		if val == nil then
			return pchar[o]
		else
			assert(#val < 14)
			mem.IgnoreProtection(true)
			structs.EditablePChar(o, obj, name, val)
			u4[mmv(0x458844, 0x460A0D, 0x45E322)] = u4[o]
			mem.IgnoreProtection(false)
			mem.copy(mmv(0x4D6B14, 0x510604, 0x521EE4), val, #val + 1)
		end
	end)
	[mmv(0x42F187, 0x433B0C, 0x43132C)].EditConstPChar  'WinMapIndex'
	 .Info "Number represented as a string.\n[MM6] Index in games.lod\n[MM7+] Index in mapstats.txt"
	[mmv(0x53CB6C, 0x598570, 0x5AC9E0)].array{mmv(3000, 4400, 5000), lenA = i4, lenP = mmv(0x54D038, 0x5A53B0, 0x5BB440)}.struct(structs.EventLine)  'GlobalEvtLines'
	[mmv(0x552F58, 0x5B6458, 0x5CCCE8)].array{mmv(3000, 4400, 5000), lenA = i4, lenP = mmv(0x533EB4, 0x5B0F90, 0x5C7020)}.struct(structs.EventLine)  'MapEvtLines'
	[mmv(0x55DD88, 0x5C6C40, 0x5E2FD0)].struct(structs.SFT)  'SFTBin'
	[mmv(0x5E2188, 0x69AC54, 0x6C8B5C) + 4].parray{lenA = i4, lenP = mmv(0x5E2188, 0x69AC54, 0x6C8B5C)}.struct(structs.DecListItem)  'DecListBin'
	[mmv(0x970BD8, 0xA74F6C, 0xAB3014) + 4].parray{lenA = i4, lenP = mmv(0x970BD8, 0xA74F6C, 0xAB3014)}.struct(structs.PFTItem)  'PFTBin'
	[mmv(0x944C58, 0xA74F64, 0xAB300C) + 4].parray{lenA = i4, lenP = mmv(0x944C58, 0xA74F64, 0xAB300C)}.struct(structs.IFTItem)  'IFTBin'
	[mmv(0x55DDA0, 0x5C6C38, 0x5E2FC8) + 4].parray{lenA = i4, lenP = mmv(0x55DDA0, 0x5C6C38, 0x5E2FC8)}.struct(structs.TFTItem)  'TFTBin'
	[mmv(0x5B22F0, 0x5FEFC4, 0x61C52C) + 4].parray{lenA = i4, lenP = mmv(0x5B22F0, 0x5FEFC4, 0x61C52C)}.struct(structs.DChestItem)  'ChestBin'
	[mmv(0x5C6BE8, 0x5E4FC8, 0x602530) + 4].parray{lenA = i4, lenP = mmv(0x5C6BE8, 0x5E4FC8, 0x602530)}.struct(structs.OverlayItem)  'OverlayBin'
	[mmv(0x5F6DF0, 0x680630, 0x6AE538) + 4].parray{lenA = i4, lenP = mmv(0x5F6DF0, 0x680630, 0x6AE538)}.struct(structs.ObjListItem)  'ObjListBin'
	[mmv(0x5E2178, 0x5FEFCC, 0x61C534) + 4].parray{1, 0xFFFFFFFF, lenA = i4, lenP = mmv(0x5E2178, 0x5FEFCC, 0x61C534)}.struct(structs.MonListItem)  'MonListBin'
	[mmv(0x9CF700, 0xF79BDC, 0xFEBFE4) + 4].parray{lenA = i4, lenP = mmv(0x9CF700, 0xF79BDC, 0xFEBFE4)}.struct(structs.SoundsItem)  'SoundsBin'
	[mmv(0x610740, 0x6BDEC8, 0x6F2FCC) + 4].parray{lenA = i4, lenP = mmv(0x610740, 0x6BDEC8, 0x6F2FCC)}.struct(structs.TileItem)  'TileBin'
	if mmver == 8 then
		define
		[0x6F2FC4 + 4].parray{lenA = i4, lenP = 0x6F2FC4}.struct(structs.TileItem)  'Tile2Bin'
		[0x6F2FBC + 4].parray{lenA = i4, lenP = 0x6F2FBC}.struct(structs.TileItem)  'Tile3Bin'
		[0x6F2FD4].pstruct(structs.CurrentTileBin)  'CurrentTileBin'
	elseif mmver == 6 then
		define.goto(0x6199C0)
	end
	define.i4  'ExitLevelCode'
	 .Info "0 = in game, 2 = load other map, 8 = death"
	[mmv(0x6107E3, 0x6BE1EF, 0x6F39AF)].i4  'SoundVolume'
	[mmv(0x4C2010, 0x4ECAD8, 0x4FCB78)].array(mmv(12, 25, 30)).EditConstPChar  'PlayerFaces'
	[mmv(0x4C22F0, 0x4ED280, 0x4FD660)].array(mmv(103, 110, 110)).struct(structs.FaceAnimationInfo)  'StandardFaceAnimations'
	[mmv(0x4C20DC, 0x4ECDB0, 0x4FD0A0)].array(1, mmv(44, 49, 49)).array(mmv(12, 25, 30)).u1  'StandardPlayerSoundsCount'
	
	define
	[mmv(0x6104F8, 0x6A08E0, 0x6CE838)].struct(structs.Lod)  'GamesLod'
	[mmv(0x4CB6D0, 0x6D0490, 0x70D3E8)].struct(structs.BitmapsLod)  'IconsLod'
	[mmv(0x610AB8, 0x6F0D00, 0x72DC60)].struct(structs.BitmapsLod)  'BitmapsLod'
	[mmv(0x61AA10, 0x6E2048, 0x71EFA8)].struct(structs.SpritesLod)  'SpritesLod'
	[mmv(0x610830, 0x6A06A0, 0x6CE5F8)].struct(structs.Lod)  'SaveGameLod'
	if mmver == 7 then
		define[0x6BE8D8].struct(structs.Lod)  'EventsLod'
	elseif mmver == 8 then
		define
		[0x6F30D0].struct(structs.LanguageLod)  'EnglishTLod'
		[0x6F330C].struct(structs.LanguageLod)  'EnglishDLod'
	end
	define.Info{Name = "IsD3D", new = true}
	if mmver > 6 then
		define[mm78(0xE31AF0, 0xF01A08)].alt.u4  'RendererD3D'
		.Info{Name = "IsD3D", new = true}
		[mm78(0x474913, 0x4737ED)].CustomType('ModelClimbRequirement', 4, function(o, obj, name, val)
			if val == nil then
				return i4[o]
			else
				mem.prot(true)
				i4[o] = val
				mem.prot(false)
			end
		end)
		 .Info "Minimum required Z coordinate of the normal to climb a building surface. MM6 default is 1 (any non-vertical surface), MM7+ default is 46378, which corresponds to Lua[[46378/0x10000 = 0.7]]."
	end
	define[0].CustomType('RandSeed', 0, function(o, obj, name, val)
		local p = (mmver > 6 and call(mmv(0, 0x4CECD2, 0x4DDD52), 0) + 5*4 or 0x4C5354)
		if val then
			i4[p] = val
		else
			return i4[p]
		end
	end)
	.func{name = "Rand", p = mmv(0x4AE22B, 0x4CAAC2, 0x4D99F2), cc = 0}
	local function Pauses(s, time, info, infoR, info2)
		local var, bool, pause, resume = "PauseCount"..s, "Paused"..s, "DoPause"..s, "DoResume"..s
		local backup = "Backup"..bool
		define
		.func{name = pause, p = offsets.PauseTime, cc = 1; time}
		 .Info{Sig = "", info..info2}
		.func{name = resume, p = offsets.ResumeTime, cc = 1; time}
		 .Info{Sig = "", "Resumes "..infoR}
		 
		define.f["Pause"..s] = function()
			local n = Game[var]
			Game[var] = n + 1
			local b = Game[bool]
			if not b then
				Game[backup] = false
				Game[pause]()
			elseif n == 0 then
				Game[backup] = true
			end
			return b
		end
		define.Info(info..", increments 'Game."..var.."' by '1' and updates 'Game."..backup.."'"..info2)
		define.f["Resume"..s] = function()
			local n = max(0, Game[var] - 1)
			Game[var] = n
			if n == 0 then
				if not Game[backup] then
					Game[resume]()
				end
				Game[backup] = nil
			end
		end
		define.Info("Subtracts '1' from 'Game."..var.."' and resumes "..infoR.." upon reaching '0' if the the game wasn't paused before #Game.Pause"..s..":# was called")
	end
	Pauses("", offsets.TimeStruct1, "Pauses game logic", "game logic", "")
	Pauses("2", offsets.TimeStruct2, "Pauses updating 3D view", "updating 3D view", " (honored by the game only if logic is also paused)")
	if mmver == 7 then
		define.func{name = "SetInterfaceColor", p = 0x422698, cc = 2, must = 1; 1, 1}  -- 0 - good, 1 - neutral, 2 - evil
		 .Info{Sig = "Color, Unk = 1"; "0 = good, 1 = neutral, 2 = evil"}
	end
	define
	.func{name = "DoShowMovie", p = mmv(0x4A59A0, 0x4BE671, 0x4BC1F1), cc = 2, must = 1; "", 0, true, true}
	 .Info{Sig = "Name, Y, DoubleSize, ExitCurrentScreen"; "Only call from #events.ShowMovie:#, use #evt.ShowMovie:# otherwise."}
	if mmver > 6 then
		define.func{name = "IsMoviePlaying", p = mm78(0x4BF35F, 0x4BCFA0), cc = 1; mmv(0x9DE330, 0xF8B988, 0xFFDD80)}
		 .Info{Sig = ""}
	end
	define
	.func{name = "LoadHouseMovie", p = mmv(0x4A63E0, 0x4BF1F5, 0x4BCE28), cc = 1, fixed = {mmv(0x9DE330, 0xF8B988, 0xFFDD80)}, must = 1; "", true}
	 .Info{Sig = "Name, Loop = true"}
	.func{name = "EndMovie", p = mmv(0x4A5D10, 0x4BEB3A, 0x4BC755), cc = 1; mmv(0x9DE330, 0xF8B988, 0xFFDD80)}
	 .Info{Sig = ""}
	[mmv(0x9DE330 + 16, 0xF8B988 + 100, 0xFFDD80 + 100)].b4  'IsMovieLooped'
	[mmv(0x9DE330, 0xF8B988 + 156, 0xFFDD80 + 156)].i4  'MovieKind'
	 .Info "0 - No movie, 1 - Smack, 2 - Bink"
	.func{name = "RestartHouseMovie", p = mmv(0x4A68B0, 0x4BF518, 0x4BD165), cc = 1; mmv(0x9DE330, 0xF8B988, 0xFFDD80)}
	 .Info{Sig = ""}
	.func{name = "PlayShopSound", p = mmv(0x496520, 0x4B1DF5, 0x4B065F), cc = 2, must = 2}
	 .Info{Sig = "House, SoundIndex"}
	if mmver == 6 then
		define.func{name = "GetCurrentNPCPtr", p = 0x43BCF0}
	else
		define.func{name = "GetNPCPtrFromIndex", p = mm78(0x445A1C, 0x442BCE), cc = 2, must = 1}
		 .Info{Sig = "Index"}
	end
	define
	.func{name = "CalcSpellDamage", p = mmv(0x47F0A0, 0x43B006, 0x438B05), cc = mmv(0, 2, 2), must = 4}
	 .Info{Sig = "Spell, Skill, Mastery, MonsterHP"}
	.func{name = "GetSpellDamageType", p = mmv(0x481A60, 0x48E189, 0x48D618), cc = 0, must = 1}
	 .Info{Sig = "Spell"}
	.func{name = "GetStatisticEffect", p = mmv(0x482DC0, 0x48EA13, 0x48E18E), cc = 0, must = 1}
	 .Info{Sig = "Stat"}
	.func{name = "SummonMonster", p = mmv(0x4A35F0, 0x4BBEC4, 0x4BA076), cc = 2, must = 4}
	 .Info{Sig = "Id, X, Y, Z"}
	.func{name = "SummonObjects", p = mmv(0x42AA10, 0x42F7C7, 0x42E245), cc = 2, must = 4; 0, 0,0,0, 0,1,false, 0, 0}
	 .Info{Sig = "Type, X, Y, Z, Speed, Count = 1, RandomAngle = false, Bits = 0, pItem:structs.Item [MM7+]"; "This function is called by #evt.SummonObject:# internally. If you specify the 'pItem' parameter, it will only work properly in MM8."}
	.func{name = "GenerateChests", p = mmv(0x456300, 0x450244, 0x44D96C), cc = 0}
	 .Info "You can add random items (Number = -1 to -6 for different power or -7 for artifact) to some chests and then call this function to generate them"
	if mmver > 6 then
		define[internal.MonsterKindPtr].parray{lenA = i4, lenP = internal.MonsterKindPtr + 4, lenSet = SetLenRealloc}.struct(structs.MonsterKind)  'MonsterKinds'
		.func{name = "IsMonsterOfKind", p = mm78(0x438BCE, 0x436542), cc = 2, must = 2}
		 .Info{Sig = "Id, Kind:const.MonsterKind"}
	end
	define
	.func{name = "FileRead", p = offsets.fread, cc = 0; 0, 1, 0, 0}
	 .Info{Sig = "pTarget, Size, Count, FileStream"; "Reads 'Size'*'Count' bytes from 'FileStream' into 'pTarget' buffer. The 'FileStream' can be obtained by calling #FindFile:structs.Lod.FindFile# method of a Lod archive."}
	.func{name = "FileSeek", p = mmv(0x4AE5B0, 0x4CB7EC, 0x4DA588), cc = 0; 0, 0, 0}
	 .Info{Sig = "FileStream, Offset, Origin = 0"; "Sets current position of 'FileStream'.\n\t'Origin' = '0' sets absolute position to 'Offset'.\n\t'Origin' = '1' adds 'Offset' to current position.\n\t'Origin' = '2' sets position to end of file plus 'Offset'."}
	.func{name = "FileTell", p = mmv(0x4AE458, 0x4CB669, 0x4DA405), cc = 0; 0}
	 .Info{Sig = "FileStream"; "Returns current position of 'FileStream'."}
	.func{name = "Uncompress", p = mmv(0x4A7AA0, 0x4C2F60, 0x4D1EC0), cc = 2, must = 4}
	 .Info{Sig = "pTarget, pTargetSize, pSrc, SrcSize"; "'pTargetSize' must point to a 4-byte buffer specifying unpacked size."}
	.func{name = "Compress", p = mmv(0x4A7B20, 0x4C2FF0, 0x4D1F50), cc = 2, must = 4, ret = 'u1'; 0,0,0,0, -1}
	 .Info{Sig = "pTarget, pTargetSize, pSrc, SrcSize, Compression[MM7+] = -1"; "'pTargetSize' must point to a 4-byte buffer specifying max size. The function sets it to actual size it has used up. If successful, returns '0'."}
	.func{name = "PlayMapTrack", p = mmv(0x454F90, 0x4ABF53, 0x4AA3E7)}
	
	local SoundStru = mmv(0x9CF598, 0xF78F58, 0xFEB360)
	function define.f.PlayTrack(id)
		mem.call(mmv(0x48EA30, 0x4AA0CF, 0x4A862D), 1, SoundStru, assert(id))
	end
	define.Info{Sig = "Index"}
	function define.f.LoadSound(soundId, unk, unk2)
		call(mmv(0x48E2D0, 0x4A99F7, 0x4A7F22), 1, mmv(0x9CF700, 0xF79BDC, 0xFEBFE4), soundId, unk or 0, unk2 or 0)
	end
	define.Info{Sig = "SoundId, Unk = 0, Unk2 = 0"; "'Unk2' is present only in MM8"}
	function define.f.PlaySound(soundId, object, loops, x, y, unk, volume, playbackRate)
		call(mmv(0x48EB40, 0x4AA29B, 0x4A87DC), 1, SoundStru, soundId, object or -1, loops or 0, x or -1, y or 0, unk or 0, volume or 0, playbackRate or 0)
	end
	define.Info{Sig = "SoundId, Object = -1, Loops = 0, X = -1, Y = 0, Unk = 0, Volume = 0, PlaybackRate = 0"}
	function define.f.StopAllSounds(keepMin, keepMax)
		call(mmv(0x48FB40, 0x4AB69F, 0x4A9BF7), 1, SoundStru, keepMin, keepMax)
	end
	define.Info{Sig = "KeepMin = -1, KeepMax = -1"}
	function define.f.LoadDecSprite(name, justFind)
		local id, pDecList = 0, mmv(0x5E2188, 0x69AC54, 0x6C8B5C)
		if mmver == 6 then
			name = name:lower()
			for i, a in Game.DecListBin do
				if i > 0 and a.Name:lower() == name then
					id = i
					break
				end
			end
		else  -- gotta copy the constant, because MM7 does that
			DecListBuf = DecListBuf or mmver > 6 and mem.malloc(32)
			assert(#name < 32, 'DecList name too long')
			mem.copy(DecListBuf, name, #name + 1)
			id = i2(call(mm78(0x4488D9, 0x445C59), 1, pDecList, DecListBuf))
		end
		if not justFind then
			call(mmv(0x44AC80, 0x4586CC, 0x455F4A), 1, pDecList, id)
		end
		return id
	end
	define.Info{Sig = "Name";  "Loads a sprite and returns its ID."}
	function define.f.LoadBitmap(name)
		local i = Game.BitmapsLod:LoadBitmap(name or "pending")
		if i >= 0 then
			Game.BitmapsLod.Bitmaps[i]:LoadBitmapPalette()
		end
		return i
	end
	define.Info{Sig = "Name";  "Loads a texture and returns its ID."}
	function define.f.UpdateDialogTopics()
		if Game.CurrentScreen == 13 then
			if Game.HouseNPCSlot > (Game.HouseOwnerPic ~= 0 and 1 or 0) then
				Game.HouseScreen = -1
				call(mmv(0x4998A0, 0x4B4187, 0x4B2C36), 1, Game.HouseNPCSlot - 1)
			end
		elseif Game.CurrentNPCDialog['?ptr'] ~= 0 then
			internal.RefillNPCTopics()
		end
	end
	local function FindFreeDlg()
		for _, a in Game.DialogsArray do
			if a.DlgID == 0 then
				return a
			end
		end
	end
	function define.f.NewDialog(x, y, w, h, id, param, str, init, initParam)
		local dlg = FindFreeDlg()
		if not dlg then
			return
		elseif str then
			dlg.StrParam = str
			str = u4[dlg['?ptr'] + 0x48]
		end
		if init then
			internal.InitDlg = || init(dlg, initParam)
		end
		call(mmv(0x419320, 0x41C3DB, 0x41BAF1), 2, x, y, w, h, tonumber(id) or 1, param, str)
		return dlg
	end
	define.Info{Sig = "Left, Top, Width, Height, DlgID, Param, StrParam, InitProc, InitParam"; "If specified, !Lua[[InitProc(dlg, InitParam)]] is called before any calls to the #NewDialog:events.NewDialog# event."}
	function define.f.GetDialogFromPoint(x, y)
		if x < 0 or x >= 640 or y < 0 or y >= 480 then
			return
		end
		local dialogs = Game.Dialogs
		for i = dialogs.High, 0, -1 do
			local dlg = dialogs[i]
			if dlg:GetRelativePoint(x, y) then
				return dlg
			end
		end
	end	
	define.Info{Sig = "Returns the #dialog:structs.Dlg# that the mouse is over."}
	function define.f.GetButtonFromPoint(x, y)
		if x < 0 or x >= 640 or y < 0 or y >= 480 then
			return
		end
		local dialogs = Game.Dialogs
		for i = dialogs.High, 0, -1 do
			local dlg = dialogs[i]
			local a = dlg:GetFromPoint(x, y, true)
			if a or dlg.Height == 480 then  -- logic of UpdateMouseHint function
				return a, dlg
			end
		end
	end	
	define.Info{Sig = "Returns #item:structs.Button#, #dialog:structs.Dlg# that the mouse is over. Uses the logic of hint updates rather than clicks. That is, stops iteration upon finding an item in specified position or encountering a dialog with #Height:structs.Dlg.Height# equal to '480', beyond which it wouldn't go.\nNote that the logic of clicks is generally less permissive: it's 'GetDialogFromPoint' followed by #GetFromPoint:structs.Dlg.GetFromPoint# of said dialog."}
	function define.f.GetTopDialog()
		local a = Game.Dialogs
		local n = a.High
		if n >= 0 then
			return Game.Dialogs[n]
		end
	end	
	define.Info{Sig = "Returns the #dialog:structs.Dlg# that the mouse is over."}
	function define.f.ShowStatusText(text, time, NoRedraw)
		call(mmv(0x442BD0, 0x44C1A1, 0x4496C5), 2, tostring(text), time or 2)
		if not NoRedraw then
			Game[mmver == 6 and "NeedRedraw" or "NeedUpdateStatusBar"] = true
		end
	end
	define.Info{Sig = "Text, Seconds = 2, NoRedraw"}
	function define.f.ShowStatusHint(text, AcceptEmpty)
		if text == "" and AcceptEmpty then
			if mmver == 6 then
				text = " "
			elseif Game.StatusDisappearTime == 0 then
				Game.MouseOverStatusMessage = ""
				Game.NeedUpdateStatusBar = true
				return
			end
		end
		call(mmv(0x418F40, 0x41C061, 0x41B711), 2, tostring(text))
	end
	define.Info{Sig = "Text, AcceptEmpty"; "Unless 'AcceptEmpty' is 'true', passing an empty string won't do anything."}
	function define.f.EscMessage(text, act)
		local dlg = FindFreeDlg()
		if dlg then
			dlg.StrParam = text
			call(mmv(0x40F480, 0x4141D5, 0x41365A), 2, dlg.StrParamPtr, act)
			return dlg
		end
	end
	define.Info{Sig = "Text, ActionOnClose = 0"}
	function define.f.StartTextInput(lim, numberic, dlg)
		call(mmv(0x44C8A0, 0x459E93, 0x45775A), 1, mmv(0x5F6E00, 0x69AC80, 0x6C8BB8), numberic, dlg or Game.GetTopDialog() or Game.DialogsArray[0])
	end
	define.Info{Sig = "MaxLength = 50, Numerical = false, Dialog = nil"}
	.func{name = "EndTextInput", p = mmv(0x44C920, 0x459F0A, 0x4577D1), cc = 1, fixed = {mmv(0x5F6E00, 0x69AC80, 0x6C8BB8)}; 0}
	 .Info{Sig = "State"}
	function define.f.LoadPalette(PalNum)
		return call(mmv(0x47CBC0, 0x48A3A2, 0x489C9F), 1, mmv(0x762D80, 0x80D018, 0x84AFE0), PalNum)
	end
	define.Info{Sig = "PalNum"}
	function define.f.LoadDataFileFromLod(name, UseMalloc)
		local p = call(mmv(0x40C1A0, 0x410897, 0x411C9B), 1, mmv(0x4CB6D0, 0x6BE8D8, 0x6FB828), name, UseMalloc or 0)
		return p ~= 0 and p, Game.PatchOptions.LastLoadedFileSize
	end
	define.Info{Sig = "Name, UseMalloc"}
	function define.f.LoadTextFileFromLod(name)
		local p, n = Game.LoadDataFileFromLod(name)
		if p then
			local s = (n and mem.string(p, n, true) or mem.string(p))
			mem.freeMM(p)
			return s
		end
	end
	define.Info{Sig = "Name"}
	local checkLods = mmv({'IconsLod'}, {'EventsLod'}, {'EnglishDLod', 'EnglishTLod'})
	function define.f.CanLoadFileFromLod(name)
		for _, s in ipairs(checkLods) do
			if Game[s]:FindFile(name) ~= 0 then
				return true
			end
		end
		if Game.PatchOptions.DataFiles ~= false then
			local f = io.open((Game.PatchOptions.DataFilesDir or 'DataFiles\\')..name, "rb")
			if f then
				f:close()
				return true
			end
		end
	end
	define.Info{Sig = "Name"; "Returns 'true' if specified file exists in LOD archives that 'LoadTextFileFromLod' and 'LoadTextFileFromLod' functions use.\nThe archives are: !b[[icons.lod]] in MM6, !b[[events.lod]] in MM7, !b[[EnglishD.lod]] and !b[[EnglishT.lod]] in MM8."}

	function define.f.LoadPcx(name, pcx, EnglishD, AllocKind)
		pcx = pcx or mem.allocMM(0x28)  -- relies on my patch zeroing it out
		if mmver < 8 then
			call(mmv(0x409E50, 0x40F420), 1, pcx, name, AllocKind)
		else
			call(0x4106F3, 1, pcx, name, EnglishD, AllocKind)
		end
		return pcx['?ptr'] and pcx or structs.LodPcx:new(pcx)
	end
	define.Info{Sig = "Name, PcxBuffer, FromEnglishD = false, LoadKind = 0"; "Returns #loaded pcx:structs.LodPcx#. 'PcxBuffer' can be 'nil', a #pcx strucutre:structs.LodPcx# or a pointer to the buffer. If it's 'nil', the buffer gets allocated and must freed via a call to #Destroy:structs.LodPcx.Destroy# function."}
	
	function define.f.GetCurrentHouse()
		local p = u4[mmv(0x4D50C4, 0x507A40, 0x519328)]
		if p ~= 0 then
			return (mmver == 6 and i2 or i4)[p + 0x1C]
		end
	end
	local function FromArray(p, kind, a, ...)
		local i = p - a['?ptr']
		local sz = i >= 0 and a.size
		i = sz and i < sz and i*a.count/sz + a.low
		if i then
			return a[i], i, kind
		elseif ... then
			return FromArray(p, ...)
		end
	end
	local NPCFromPtr = |p| FromArray(p, 'NPC', Game.NPC, 'StreetNPC', Game.StreetNPC, mmver < 8 and 'HiredNPC', mmver < 8 and Party.HiredNPC)
	local GetCurrentNPC = || NPCFromPtr(mmver == 6 and Game.GetCurrentNPCPtr() or Game.GetNPCPtrFromIndex(Game.DialogNPC))
	define.f.GetCurrentNoHouseNPC = GetCurrentNPC
	define.f.GetNPCFromPtr = NPCFromPtr
	if mmver ~= 6 then
		define.f.GetCurrentNPCPtr = || Game.GetNPCPtrFromIndex(Game.DialogNPC)
	end
	function define.f.GetNPCFromIndex(n)
		if mmver == 8 then
			return NPCFromPtr(Game.GetNPCPtrFromIndex(n))
		end
		local old = Game.DialogNPC
		Game.DialogNPC = n
		local v, i, k = GetCurrentNPC()
		Game.DialogNPC = old
		return v, i, k
	end
end

if mmver == 6 then

	function structs.f.GameClasses(define)
		define
		[0x4C2640].array(18).u1  'HPFactor'
		[0x4C2654].array(18).u1  'SPFactor'
		[internal.SPStatKinds].array(18).u1  'SPStats'
	end

	function structs.f.GameClassKinds(define)
		define
		[0x4C2630].array(6).u1  'HPBase'
		[0x4C2638].array(6).u1  'SPBase'
		[0x4C2668].array(6).array(7).u1  'StartingStats'
		 .Info{Sig = "[][stat:const.Stats]"}
		[0x4C2694].array(6).array(31).u1  'StartingSkills'
		 .Info{Sig = "[][skill:const.Skills]";
		 	"[MM6]  0 = not available,  1 = given on start,  2 = can choose on start,  3 = can learn\n"..
		  "[MM7+]  0 = can't choose,  1 = can choose on start,  2 = given on start"}
	end

elseif mmver == 7 then

	function structs.f.GameClasses(define)
		define
		[0x4ED610].array(36).u1  'HPFactor'
		[0x4ED634].array(36).u1  'SPFactor'
		[0x4ED818].array(36).array(37).u1  'Skills'
		 .Info "Same as in 'SplitSkill' function: 0 - none, 1 - normal, 2 - expert, 3 - master, 4 - GM"
		[internal.SPStatKinds].array(36).u1  'SPStats'
		 .Info "0 - no SP, 1 - intellect, 2 - personality, 3 - both"
	end

	function structs.f.GameClassKinds(define)
		define
		[0x4ED5F8].array(9).u1  'HPBase'
		[0x4ED604].array(9).u1  'SPBase'
		[0x4ED6C8].array(9).array(37).u1  'StartingSkills'
	end

	function structs.f.GameRaces(define)
		-- human, elf, goblin, dwarf
		define
		[0x4ED658].array(4).array(7).struct(structs.StartStat)  'StartingStats'
		 .Info{Sig = "[race:const.Race][stat:const.Stats]"}
	end

elseif mmver == 8 then

	function structs.f.CurrentTileBin(define)
		define
		[4].parray{lenA = i4, lenP = 0}.struct(structs.TileItem)  'Items'
		.indexmember  'Items'
		.newindexmember  'Items'
	end

	function structs.f.GameClasses(define)
		define
		[0x4FD9FC].array(16).u1  'HPFactor'
		 .Info{Sig = "[class:const.Class]"}
		[0x4FDA0C].array(16).u1  'SPFactor'
		 .Info{Sig = "[class:const.Class]"}
		[0x4FD9DC].array(16).u1  'HPBase'
		 .Info{Sig = "[class:const.Class]"}
		[0x4FD9EC].array(16).u1  'SPBase'
		 .Info{Sig = "[class:const.Class]"}
		[0x4FDD18].array(16).array(39).u1  'Skills'
		 .Info{Sig = "[class:const.Class][skill:const.Skills]"; "0 = not available,  1 = Basic,  2 = Expert,  3 = Master,  4 = GM"}
		[0x4FDA20].array(16).array(7).struct(structs.StartStat)  'StartingStats'
		 .Info{Sig = "[class:const.Class]"}
		[internal.SPStatKinds].array(16).u1  'SPStats'
		 .Info{Sig = "[class:const.Class]"; "0 = no SP, 1 = Intellect, 2 = Personality, 3 = both"}
	end

	function structs.f.GameClassKinds(define)
		define
		[0x4FDBE0].array(8).array(39).u1  'StartingSkills'
	end

end

function structs.f.StartStat(define)
	define
	.i1  'Base'
	.i1  'Max'
	.i1  'Spend'
	 .Info "how much you spend on it to add a point"
	.i1  'Add'
	 .Info "how much is added when you spend a point"
end

local function PrepareCountItems(items)
	local t = {}
	if type(items) == "table" then
		for _, v in ipairs(items) do
			t[v] = 1
		end
	else
		t[items] = 1
	end
	return t
end

local function DoCountPlayerItems(t, pl)
	local n = 0
	for _, i in pl.Inventory do
		n = n + (i > 0 and t[pl.Items[i].Number] or 0)
	end
	for _, i in pl.EquippedItems do
		n = n + (i > 0 and t[pl.Items[i].Number] or 0)
	end
	return n
end

function structs.f.GameParty(define)
	define
	 .Info{Name = "Party"}
	[mmv(0x908C98, 0xACD4EC, 0xB21554)].alt.array(3).i4  'Pos'
	.i4  'X'
	.i4  'Y'
	.i4  'Z'
	.i4  'Direction'
	 .Info "0 - 2047. 0 is East, 512 is North and so on."
	.i4  'LookAngle'
	 .Info "-512 - 512. Values allowed with mouse look: -240 - 300 (prior to patch 2.5: -200 - 200). Without mouse look: -128 - 128"
	.i4  'LastX'
	.i4  'LastY'
	.i4  'LastZ'
	.i4  'LastDirection'
	.i4  'LastLookAngle'
	.i4  'LastEyeLevel'
	.i4  'SpeedX'
	.i4  'SpeedY'
	.i4  'SpeedZ'
	.skip(4)
	.i4  'StableZ'
	 .Info "'Z' changes up and down while flying, 'StableZ' stays the same"
	.i4  'LastStandFacet'
	.skip(8)
	.i4  'FallStartZ'
	.b4  'Flying'
	if mmver < 8 then
		define
		[mmv(0x908F34, 0xACD804)].array(4).struct(structs.Player)  'PlayersArray'
		 .Info "Array of all players"
		[mmv(0x944C68, 0xA74F48)].array(4).CustomType('Players', 4, function(o, obj, _, val)
			if val then
				i4[obj["?ptr"] + o] = val["?ptr"]  -- to be used at your own risk!
			else
				local a = Party.PlayersArray
				return a[(i4[obj["?ptr"] + o] - a["?ptr"])/structs.Player["?size"]]
			end
		end)
		 .Info "Array of players corresponding to each player slot"
		[mmv(0x90E7A4, 0xAD44F4)].array(1, 2).struct(structs.NPC)  'HiredNPC'
		[mmv(0x91886E, 0xAE2EAC)].array(1, 2).string(100)  'HiredNPCName'
	else
		define
		[0xB20E90 + 2540].array(50).struct(structs.Player)  'PlayersArray'
		[0xB20E90 + 375740].alt.array(5).i4  'PlayersIndexes'
		 .Info "Array of players indexes in #PlayersArray:structs.GameParty.PlayersArray# corresponding to each player slot"
		.array{5, lenA = i4, lenP = 0xB7CA60}.CustomType('Players', 4, function(o, obj, _, val)
			local a = Party.PlayersArray
			if val then
				local i = (val["?ptr"] - a["?ptr"])/structs.Player["?size"]
				i4[obj["?ptr"] + o] = a[i] and i
			else
				local i = i4[obj["?ptr"] + o]
				return a[i < 0 and 0 or i]
			end
		end)
	end
	define
	.indexmember  'Players'
	.newindexmember  'Players'
	[mmv(0x90E83C, 0xACCE6C, 0xB20EC4)].i8  'LastRegenerationTime'
	[mmv(0x908E34, 0xACD6C4, 0xB21738)].array(mmv(16, 20, 20)).struct(structs.SpellBuff)  'SpellBuffs'
	 .Info{Sig = "[buff:const.PartyBuff]"}
	[mmv(0x908D50, 0xACD56C, 0xB215D4)].i4  'Gold'
	[mmv(0x908D54, 0xACD570, 0xB215D8)].i4  'BankGold'
	[mmv(0x908D2C, 0xACD560, 0xB215C8)].i4  'Food'
	[mmv(0x908D58, 0xACD574, 0xB215DC)].i4  'Deaths'
	[mmv(0x908D60, 0xACD57C, 0xB215E4)].i4  'PrisonTerms'
	[mmv(0x908D60, 0xACD57C, 0xB215E4)].i4  'PritsonTerms' .Info(false)  -- backward compatibility
	[mmv(0x908D64, 0xACD580, 0xB215E8)].i4  'BountiesCollected'
	if mmver > 6 then
		define
		[mm78(0xAE3060, 0xBB2EF4)].i4  'Fine'
		[mm78(0xACD588, 0xB215F0)].alt.array(5).i2  'BountyHuntTarget'
		 .Info "Only index 0 is normally used in MM8"
		.array(5).i2  'MonsHuntTarget'
		 .Info "(deprecated old name)"
		[mm78(0xACD592, 0xB215FA)].alt.array(5).b2  'BountyHuntKilled'
		 .Info "Only index 0 is normally used in MM8"
		.array(5).i2  'MonsHuntKilled'
		 .Info "(deprecated old name, integer in MM7+ instead of boolean)"
		[mm78(0xACCE74, 0xB20ECC)].alt.array(5).i8  'NextBountyHunt'
		.array(5).i8  'MonsHuntReset'  -- for some reason 10 values fit there
		 .Info "(deprecated old name)"
	else
		define
		[0x908DC5].alt.array(3).u1  'BountyHuntTarget'
		.array(3).u1  'MonsHuntTarget'
		[0x908DC8].alt.array(3).b1  'BountyHuntKilled'
		.array(3).b1  'MonsHuntKilled'
		[0x90E844].alt.array(3).i8  'NextBountyHunt'
		.array(3).i8  'MonsHuntReset'  -- for some reason 9 values fit there
	end
	define
	[mmv(0x908D6D, 0xACD59D, 0xB2160F)].array(mmv(0, 1, 1), mmv(511, 512, 512)).abit  'QBits'
	[mmv(0x908DAD, 0xACD636, 0xB216A8)].array(1, mmv(128, 195, 300)).abit  'AutonotesBits'
	[mmv(0x908DBD, 0xACD5ED, 0xB2165F)].i1  'InArenaQuest'
	.i1  'ArenaWinsPage'
	.i1  'ArenaWinsSquire'
	.i1  'ArenaWinsKnight'
	.i1  'ArenaWinsLord'
	define[mmv(0x908DCB, 0xACD5F2, 0xB21664)].array(mmv(400, 500, 500), mmv(429, 567, 567)).b1  'ArtifactsFound'
	if mmver == 7 then
		define[0xACD6C0].i4  'Alignment'
		 .Info "0 = good, 1 = neutral, 2 = evil"
	end
	if mmver == 6 then
		define[0x908D48].i4  'Reputation'
	else
		define.CustomType('Reputation', 0, function(o, obj, name, val)
			if val == nil then
				return Map.Reputation
			else
				Map.Reputation = val
			end
		end)
		[mm78(0xACD364, 0xB213CC)].array(1, 29).i8  'History'
		.array(1, 20).i8  'SpecialDates'
		 .Info 'E.g. set date 1:!Lua[[\nevt.Add("SpecialDate1", 0)]]\nUse date 1: "%51" in any NPC message'
		[mm78(0xACD5DD, 0xB2164F)].array(mm78(108, 107), mm78(108, 107) + 15).b1  'ArcomageWins'
	end
	define[offsets.CurrentPlayer].CustomType('CurrentPlayer', 4, i4_CurrentPlayer)	
	[mmv(0x90E838, 0xAD45B0, 0xB7CA88)].alt.i4  'StateBits'
	.bit ('NeedRender', 2)
	.bit ('Drowning', 4)
	.bit ('InAir', 8)
	.bit ('EnemyDetectorRed', 0x10)
	.bit ('EnemyDetectorYellow', 0x20)
	.bit ('FlyingBit', 0x40)
	.bit ('WaterWalkingBit', 0x80)
	.bit ('InJumpSpell', 0x100)
	.bit ('InLava', 0x200)
	
	local c = define.class
	c.ptr = mmv(0x908C70, 0xACCE38, 0xB20E90)  -- start of Party.bin structure
	function define.f.RestAndHeal(mins)
		if mins then
			call(mmv(0x496180, 0x4B1B3E, 0x4B0341), 0, mins % 0x100000000, mins:div(0x100000000))
			Game.Weather.New()
		else
			call(mmv(0x484D40, 0x490CFA, 0x48FE9C), 1, mmv(0x908C70, 0xACCE38, 0xB20E90))
		end
	end
	define
	.func{name = "Wait", p = mmv(0x487980, 0x4938C9, 0x491C65), cc = 2, must = 1}
	 .Info{Sig = "Minutes"}
	.func{name = "FindActivePlayer", p = mmv(0x487780, 0x493707, 0x491A55), cc = 1; c.ptr}
	.func{name = "GetFame", p = mmv(0x485510, 0x491356, 0x49039B), cc = 1; c.ptr}
	.func{name = "GetReputation", p = mmv(0x47D600, 0x47752F, 0x47603F), cc = 1; c.ptr}
	.func{name = "GetRepuataion ", p = mmv(0x47D600, 0x47752F, 0x47603F), cc = 1; c.ptr} .Info(false)  -- backward compat
	.func{name = "AddGold", p = mmv(0x41EDE0, 0x420BAE, 0x420131), cc = 2, must = 1; 0, 0}
	 .Info{Sig = "Gold, Kind = 0";  "'Kind' values:\n"..
	 "0 = increase by Banker, give some part to followers\n"..
	 "1 = take exect amount, ignore followers\n"..
	 "2 = [MM7+] take all and don't show message, just clear status message\n"..
	 "3 = [MM7+] take all and don't change status message"}
	.func{name = "AddKillExp", p = mmv(0x421520, 0x42694B, 0x424D5B), cc = 2, must = 1}
	 .Info{Sig = "Experience";  "'Experience' is shared among conscious players and effected by Learning skill"}
	if mmver < 8 then
		define.func{name = "HasNPCProfession", p = mmv(0x467F30, 0x476399, nil), cc = 1, must = 1, ret = true}
	else
		define.method{p = 0x4903C0, name = "ResetStartingPlayer", false, false}
	end
	function define.f.CountItems(items)
		local t = PrepareCountItems(items)
		local n = t[Mouse.Item.Number] or 0
		for _, pl in Party.Players do
			n = n + DoCountPlayerItems(t, pl)
		end
		return n
	end
	define.Info{Sig = "{item1, item2, ...}"}
	function define.f.GetCurrentPlayer()
		return Party[max(0, u4[offsets.CurrentPlayer] - 1)]
	end
end

-- Character_GetInventoryItemIndex

--[[
	const.BonusStat
	
Character_FindFreeItemSlot
SimpleEquipItem
Character_CheckSkillToWear

hook 467722(mm8) - CanDualWield
	
]]

function structs.f.Player(define)
	if mmver < 8 then
		define[mmv(0x11, 0xB8)].b1  'Sex'
	else
		define[0xC8].string(256)  'Biography'  -- length is unknown
	end
	if mmver > 6 then
		define.method{p = mm78(0x490139, 0x48F5CE), name = "GetSex"; mm78(nil, false)}
		 .Info{Sig = "BasedOnVoice[MM8] = false"; "Determines sex based on Face or Voice"}
	end
	for name, i in pairs(const.Condition) do
		define[mmv(0x1380, 0x0, 0x0) + 8*i].i8 (name)
	end
	define
	[mmv(0x1380, 0x0, 0x0)].array(mmv(17, 20, 20)).i8  'Conditions'
	 .Info{Sig = "[cond:const.Condition]"}
	[mmv(0x1420, 0xA0, 0xA0)].alt.i8  'Exp'
	.i8  'Experience'
	[mmv(0x1, 0xA8, 0xA8)].string(mmv(16, 16, 32))  'Name'
	[mmv(0x12, 0xB9, 0x352)].u1  'Class'
	[mmv(0x0, 0xBA, 0x353)].u1  'Face'
	[mmv(0x14, 0xBC, 0x354)].union  'Stats'
		.struct(structs.BaseBonus)(const.Stats.Might)
		.struct(structs.BaseBonus)(const.Stats.Intellect)
		.struct(structs.BaseBonus)(const.Stats.Personality)
		.struct(structs.BaseBonus)(const.Stats.Endurance)
		.struct(structs.BaseBonus)(const.Stats.Speed)
		.struct(structs.BaseBonus)(const.Stats.Accuracy)
		.struct(structs.BaseBonus)(const.Stats.Luck)
	.union().Info{Sig = "[stat:const.Stats]"}
	[mmv(0x14, 0xBC, 0x354)].i2  'MightBase'
	.i2  'MightBonus'
	.i2  'IntellectBase'
	.i2  'IntellectBonus'
	.i2  'PersonalityBase'
	.i2  'PersonalityBonus'
	.i2  'EnduranceBase'
	.i2  'EnduranceBonus'
	.i2  'SpeedBase'
	.i2  'SpeedBonus'
	.i2  'AccuracyBase'
	.i2  'AccuracyBonus'
	.i2  'LuckBase'
	.i2  'LuckBonus'
	.i2  'ArmorClassBonus'
	.i2  'LevelBase'
	.i2  'LevelBonus'
	.i2  'AgeBonus'
	[mmv(0x60, 0x108, 0x378)].array(mmv(31, 37, 39))[mmv("u1", "i2", "i2")]  'Skills'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x7F, 0x152, 0x3C6)].array(mmv(0, 1, 1), mmv(87, 104, 104)).abit  'Awards'
	[mmv(0xBF, 0x192, 0x406)].array(1, mmv(100, 100, 132)).b1  'Spells'
	 .Info{Sig = "[spell:const.Spells]"}
	.skip(mmv(5, 2, 2))
	.array(mmv(181, 264, 264), mmv(187, 270, 270)).b4  'UsedBlackPotions'
	[mmv(0x144, 0x214, 0x4A8)].array(1, 138).struct(structs.Item)  'Items'
	[mmv(0x105C, 0x157C, 0x1810)].array(126).i4  'Inventory'
	 .Info "('Items' index) for main item cell,  -(1 + main 'Inventory' cell index) for other cells"
	if mmver == 6 then
		define
		[0x1254].union  'Resistances'
			.struct(structs.BaseBonus)(const.Damage.Fire)
			.struct(structs.BaseBonus)(const.Damage.Cold)
			.struct(structs.BaseBonus)(const.Damage.Elec)
			.struct(structs.BaseBonus)(const.Damage.Poison)
			.struct(structs.BaseBonus)(const.Damage.Magic)
		.union().Info{Sig = "[kind:const.Damage]"}
		[0x1254].i2  'FireResistanceBase'
		[0x1256].i2  'FireResistanceBonus'
		[0x1258].i2  'ColdResistanceBase'
		[0x125A].i2  'ColdResistanceBonus'
		[0x125C].i2  'ElecResistanceBase'
		[0x125E].i2  'ElecResistanceBonus'
		[0x1260].i2  'PoisonResistanceBase'
		[0x1262].i2  'PoisonResistanceBonus'
		[0x1264].i2  'MagicResistanceBase'
		[0x1266].i2  'MagicResistanceBonus'
	else
		define
		[mm78(0x1774, 0x1A08)].array(11).struct(structs.PlayerResistanceBaseBonus)  'Resistances'
		 .Info{Sig = "[kind:const.Damage]"}
		[mm78(0x1774, 0x1A08)].i2  'FireResistanceBase'
		.i2  'AirResistanceBase'
		.i2  'WaterResistanceBase'
		.i2  'EarthResistanceBase'
		.i2  ''  -- UnusedResistance1Base
		.i2  ''  -- UnusedResistance2Base
		.i2  'SpiritResistanceBase'
		.i2  'MindResistanceBase'
		.i2  'BodyResistanceBase'
		.i2  ''  -- UnusedResistance3Base
		.i2  ''  -- UnusedResistance4Base
		.i2  'FireResistanceBonus'
		.i2  'AirResistanceBonus'
		.i2  'WaterResistanceBonus'
		.i2  'EarthResistanceBonus'
		.i2  ''  -- UnusedResistance1Bonus
		.i2  ''  -- UnusedResistance2Bonus
		.i2  'SpiritResistanceBonus'
		.i2  'MindResistanceBonus'
		.i2  'BodyResistanceBonus'
		.i2  ''  -- UnusedResistance3Bonus
		.i2  ''  -- UnusedResistance4Bonus
		[mm78(0x1920, 0x1BE4)].i4  'Voice'
	end
	define
	[mmv(0x1268, 0x17A0, 0x1A34)].array(mmv(16, 24, 27)).struct(structs.SpellBuff)  'SpellBuffs'
	 .Info{Sig = "[buff:const.PlayerBuff]"}
	[mmv(0x137C, 0x1934, 0x1BF2)].i2  'RecoveryDelay'
	[mmv(0x1410, 0x1938, 0x1BF4)].i4  'SkillPoints'
	[mmv(0x1414, 0x193C, 0x1BF8)].alt.i4  'HP'
	.i4  'HitPoints'
	[mmv(0x1418, 0x1940, 0x1BFC)].alt.i4  'SP'
	.i4  'SpellPoints'
	[mmv(0x141C, 0x1944, 0x1C00)].i4  'BirthYear'
	[mmv(0x1428, 0x1948, 0x1C04)].array(16).i4  'EquippedItems'
	 .Info{Sig = "[slot:const.ItemSlot]"}
	[mmv(0x1428, 0x1948, 0x1C04)].i4  'ItemExtraHand'
	.i4  'ItemMainHand'
	.i4  'ItemBow'
	.i4  'ItemArmor'
	.i4  'ItemHelm'
	.i4  'ItemBelt'
	.i4  'ItemCloak'
	.i4  'ItemGountlets'
	.i4  'ItemBoots'
	.i4  'ItemAmulet'
	.i4  'ItemRing1'
	.i4  'ItemRing2'
	.i4  'ItemRing3'
	.i4  'ItemRing4'
	.i4  'ItemRing5'
	.i4  'ItemRing6'
	[mmv(0x152E, 0x1A4E, 0x1C44)].i1  'SpellBookPage'
	[mmv(0x152F, 0x1A4F, 0x1C45)].u1  'QuickSpell'
	[mmv(0x137E, 0x1936, 0x1C8E)].u1  'AttackSpell'
	 .Info "Added in version 2.5 of my patches"
	[mmv(0x1530, 0x1A50, 0x1C46)].array(mmv(0, 1, 1), mmv(511, 512, 512)).abit  'PlayerBits'
	if mmver < 8 then
		define
		[mmv(0x1570, 0x1A90)].i1  'MeleeAttackBonus'
		[mmv(0x1572, 0x1A92)].i1  'MeleeDamageBonus'
		[mmv(0x1574, 0x1A94)].i1  'RangedAttackBonus'
		[mmv(0x1576, 0x1A96)].i1  'RangedDamageBonus'
		[mmv(0x1578, 0x1A98)].i1  'FullHPBonus'
		[mmv(0x1578, 0x1A98)].i1  'FullHitPointsBonus'
		[mmv(0x157A, 0x1A9A)].i1  'FullSPBonus'
		[mmv(0x157A, 0x1A9A)].i1  'FullSpellPointsBonus'
	else
		define[0x1BF0].i2  'RosterBitIndex'
	end
	define
	[mmv(0x157C, 0x1A9C, 0x1C86)].i2  'Expression'
	[mmv(0x157E, 0x1A9E, 0x1C88)].i2  'ExpressionTimePassed'
	[mmv(0x1580, 0x1AA0, 0x1C8A)].i2  'ExpressionLength'
	[mmv(0x158C, 0x1AAC, 0x1C98)].array(5).struct(structs.LloydBeaconSlot)  'Beacons'
	[mmv(0x1618, 0x1B38, 0x1D24)].u1  'DevineInterventionCasts'
	[mmv(0x1619, 0x1B39, 0x1D25)].u1  'ArmageddonCasts'
	.size = mmv(0x161C, 0x1B3C, 0x1D28)
	if mmver == 7 then
		define[0x1924].alt.i4  'FaceBeforeZombie'
		.i4  'OriginalFace'
		.alt.i4  'VoiceBeforeZombie'
		.i4  'OriginalVoice'
	end

	define
	.method{p = mmv(0x47D830, 0x48C83B, 0x48C31F), name = "GetBaseMight"}
	.method{p = mmv(0x47D850, 0x48C852, 0x48C336), name = "GetBaseIntellect"}
	.method{p = mmv(0x47D870, 0x48C869, 0x48C34D), name = "GetBasePersonality"}
	.method{p = mmv(0x47D890, 0x48C880, 0x48C364), name = "GetBaseEndurance"}
	.method{p = mmv(0x47D8B0, 0x48C897, 0x48C37B), name = "GetBaseAccuracy"}
	.method{p = mmv(0x47D8D0, 0x48C8AE, 0x48C392), name = "GetBaseSpeed"}
	.method{p = mmv(0x47D8F0, 0x48C8C5, 0x48C3A9), name = "GetBaseLuck"}
	.method{p = mmv(0x47D910, 0x48C8DC, 0x48C3C0), name = "GetBaseLevel"}
	.method{p = mmv(0x47D930, 0x48C8F3, 0x48C3D7), name = "GetLevel"}
	.method{p = mmv(0x47D960, 0x48C922, 0x48C406), name = "GetMight"}
	.method{p = mmv(0x47DAA0, 0x48C9A8, 0x48C462), name = "GetIntellect"}
	.method{p = mmv(0x47DBE0, 0x48CA25, 0x48C4BF), name = "GetPersonality"}
	.method{p = mmv(0x47DD20, 0x48CAA2, 0x48C51C), name = "GetEndurance"}
	.method{p = mmv(0x47DE60, 0x48CB1F, 0x48C579), name = "GetAccuracy"}
	.method{p = mmv(0x47DFA0, 0x48CB9C, 0x48C5D6), name = "GetSpeed"}
	.method{p = mmv(0x47E0E0, 0x48CC19, 0x48C633), name = "GetLuck"}
	.method{p = mmv(0x47E270, 0x48CCDB, 0x48C690), name = "GetMeleeAttack"; false}
	 .Info{Sig = "IgnoreExtraHand [MM7+] = false"}
	.method{p = mmv(0x47E410, 0x48CDC1, 0x48C759), name = "CalcMeleeDamage";  false, false, -1}
	 .Info{Sig = "JustWeaponDamage = false, IgnoreExtraHand = false, MonsterId = -1"}
	.method{p = mmv(0x47E810, 0x48D09F, 0x48C9FE), name = "GetRangedAttack"}
	.method{p = mmv(0x47EAD0, 0x48D1E4, 0x48CB07), name = "CalcRangedDamage";  -1}
	 .Info{Sig = "MonsterId = -1"}
	.method{p = mmv(0x421CB0, 0x4272AC, 0x4256DB), name = "CalcHitOrMiss", cc = 0, must = 1, ret = true;  0, 0, 0}
	 .Info{Sig = "Monster:structs.MapMonster, Range = 0, Bonus = 0"; "'AttackType': 0 - melee, 1 - less than 1024, 2 - less then 2560, 3 - 2560 or more. See the Mechanics page on my site for more info on the formula."}
	 
	.method{p = mmv(0x47EB80, 0x48D2D0, 0x48CBFB), name = "GetMeleeDamageRangeText", ret = ""}
	.method{p = mmv(0x47EEB0, 0x48D37C, 0x48CC98), name = "GetRangedDamageRangeText", ret = ""}
	.method{p = mmv(0x47F010, 0x48D440, 0x48CD4D), name = "CanTrain"}
	.method{p = mmv(0x47FB60, 0x48DB9F, 0x48D026), name = "AddHP", must = 1}
	 .Info{Sig = "Amount"}
	.method{p = mmv(0x47FEE0, 0x48DC04, 0x48D078), name = "DoDamage", must = 1;  0, const.Damage.Phys}
	 .Info{Sig = "Damage, DamageKind:const.Damage = const.Damage.Phys"}
	.method{p = mmv(0x480010, 0x48DCDC, 0x48D166), name = "DoBadThing", must = 1; 0, 0}
	 .Info{Sig = "Thing:const.MonsterBonus, Monster:structs.MapMonster[MM7+]";  "'Monster' must be specified for stealing in MM7+"}
	.method{p = mmv(0x481A80, 0x48E19B, 0x48D62A), name = "GetAttackDelay"; false}
	 .Info{Sig = "Shoot = false"}
	.method{p = mmv(0x481EA0, 0x48E4F0, 0x48D9B4), name = "GetFullHP"}
	.method{p = mmv(0x482090, 0x48E55D, 0x48DA18), name = "GetFullSP"}
	define.class.GetFullHitPoints = define.class.GetFullHP
	define.class.GetFullSpellPoints = define.class.GetFullSP
	define.class.AddHitPoints = define.class.AddHP
	if mmver > 6 then
		define
		.method{p = mm78(0x48CD2B, 0x48C6D5), name = "GetMeleeDamageMin"}
		.method{p = mm78(0x48CD76, 0x48C717), name = "GetMeleeDamageMax"}
		.method{p = mm78(0x48D10A, 0x48CA37), name = "GetRangedDamageMin"}
		.method{p = mm78(0x48D177, 0x48CA9F), name = "GetRangedDamageMax"}
		.method{p = mm78(0x48E737, 0x48DBA2), name = "GetBaseResistance", must = 1}
		 .Info{Sig = "Res:const.Damage"}
		.method{p = mm78(0x48E7C8, 0x48DD6B), name = "GetResistance", must = 1}
		 .Info{Sig = "Res:const.Damage"}
		.method{p = mm78(0x48D6B6, 0x48CF8A), name = "HasItemBonus", must = 1}
		 .Info{Sig = "Bonus2";  "Checks whether the player is wearing an item with specified Bonus2:structs.Item.Bonus2. See SPCITEMS.TXT for more info about each bonus."}
		.method{p = mm78(0x48D6EF, 0x48CFC3), name = "WearsItem", must = 1, ret = true; 0, 16}
		 .Info{Sig = "ItemNum, Slot:const.ItemSlot = 16"; "If 'Slot' isn't specified, searches all slots for the item"}
	else
		define
		.method{p = 0x4829A0, name = "GetBaseFireResistance"}
		.method{p = 0x4829C0, name = "GetBaseElectricityResistance"}
		.method{p = 0x4829E0, name = "GetBaseColdResistance"}
		.method{p = 0x482A00, name = "GetBasePoisonResistance"}
		.method{p = 0x482A20, name = "GetBaseMagicResistance"}
		.method{p = 0x482A40, name = "GetFireResistance"}
		.method{p = 0x482A90, name = "GetElectricityResistance"}
		.method{p = 0x482AE0, name = "GetColdResistance"}
		.method{p = 0x482B30, name = "GetPoisonResistance"}
		.method{p = 0x482B80, name = "GetMagicResistance"}
		function define.m:WearsItem(n, slot)
			if slot < 16 then
				local it = self:GetActiveItem(slot)
				return it and it.Number == n
			end
			for it in self:EnumActiveItems() do
				if it.Number == n then
					return true
				end
			end
			return false
		end
	end
	define
	.method{p = mmv(0x4873F0, 0x492A2E, 0x49133B), name = "RemoveFromInventory", must = 1}
	 .Info{Sig = "Slot"}
	if mmver == 6 then
		define.method{p = 0x4852D0, name = "GetDiplomacyTotalSkill"}
		-- 486CF0 Character_CanTakeItemInPos
		-- 486DF0 Character_PutItemInPos
	elseif mmver == 7 then
		define.method{p = 0x490101, name = "GetRace"}
	elseif mmver == 8 then
		define.method{p = 0x48F552, name = "GetStartingClass"}
	end
	define
	.method{p = mmv(0x482570, 0x48E64E, 0x48DAB9), name = "GetBaseArmorClass"}
	.method{p = mmv(0x482700, 0x48E687, 0x48DAF2), name = "GetArmorClass"}
	.method{p = mmv(0x4828A0, 0x48E6D4, 0x48DB3F), name = "GetBaseAge"}
	.method{p = mmv(0x482920, 0x48E724, 0x48DB8F), name = "GetAge"}
	.method{p = mmv(0x482BB0, 0x48E8ED, 0x48DF81), name = "Recover", must = 1}
	 .Info{Sig = "ByAmount"}
	.method{p = mmv(0x482C80, 0x48E962, 0x48DFF8), name = "SetRecoveryDelayRaw", must = 1}
	 .Info{Sig = "Delay"}
	-- 482E6E (MM6) Character_CalcSpecialBonusByItems
	.method{p = mmv(0x482E80, 0x48EAA6, 0x48E213), name = "CalcStatBonusByItems", must = 1;  0, false}
	 .Info{Sig = "Stat:const.Stats, IgnoreExtraHand [MM7+] = false"}
	.method{p = mmv(0x483800, 0x48F734, 0x48EE09), name = "CalcStatBonusByMagic", must = 1}
	 .Info{Sig = "Stat:const.Stats"}
	.method{p = mmv(0x483930, 0x48FBF8, 0x48F084), name = "CalcStatBonusBySkills", must = 1}
	 .Info{Sig = "Stat:const.Stats"}
	.method{p = mmv(0x485340, 0x4911EB, 0x49028F), name = "GetMerchantTotalSkill"}
	.method{p = mmv(0x4853E0, 0x4912A8, 0x49031C), name = "GetDisarmTrapTotalSkill"}
	.method{p = mmv(0x488F50, 0x494A1D, 0x492D6A), name = "ShowFaceExpression", must = 1;  0, 0}
	 .Info{Sig = "Expression, Time = 0"}
	.method{p = mmv(0x488CA0, 0x4948A9, 0x492BCD), name = "ShowFaceAnimation", must = 1;  0, 0}
	 .Info{Sig = "Animation:const.FaceAnimation"}
	.method{p = mmv(0x4876E0, 0x492C03, 0x491514), name = "IsConscious", ret = true}
	if mmver > 6 then
		define
		.method{p = mm78(0x48F87A, 0x48EF4F), name = "GetSkill", must = 1}
		 .Info{Sig = "Skill:const.Skills"}
		.method{p = mm78(0x491252, 0x4902DF), name = "GetPerceptionTotalSkill"}
		.method{p = mm78(0x49130F, 0x49036E), name = "GetLearningTotalSkill"}
		.method{p = mm78(0x492D5D, 0x49165D), name = "AddCondition", must = 1; 0, false}
		 .Info{Sig = "Condition:const.Condition, CanResist = false";  "Passing 'const.Condition.Good' isn't supported.\n'CanResist' only affects application of Protection from Magic spell. If it's 'true' and the spell protects the player, spell strength is decreased instead of condition being applied."}
		.method{p = mmv(0x482D30, 0x48E9EC, 0x48E127), name = "GetMainCondition"}
		 .Info{Type = "const.Condition";  "Returns the condition that affects character stats. Also see #GetDisplayedCondition:structs.Player.GetDisplayedCondition#."}
	end
	if mmver < 8 then
		define.method{p = mmv(0x483D90, 0x490242), name = "ResetToClass", must = 1}
	end
	
	function define.m:GetDisplayedCondition()
		local p = mmv(0x4145C0, 0x418A04, 0x4181A3)
		return call(i4[p + 1] + p + 5, 1, self)
	end
	define.Info{Type = "const.Condition";  "Returns the condition displayed on character face and in character properties. Since pacth 2.5 it can differ from #GetMainCondition:structs.Player.GetMainCondition#."}
	function define.m:EnumActiveItems(includeBroken)
		local i = -1
		return function()
			while i < 15 do
				i = i + 1
				local slot = self.EquippedItems[i]
				local item = (slot ~= 0 and self.Items[slot])
				if item and (includeBroken or item.Condition:And(2) == 0) then
					return item, i
				end
			end
		end
	end
	define.Info{Sig = "includeBroken"}
	function define.m:GetActiveItem(slot, includeBroken)
		slot = self.EquippedItems[slot]
		local item = (slot ~= 0 and self.Items[slot])
		if item and (includeBroken or item.Condition:And(2) == 0) then
			return item
		end
	end
	define.Info{Sig = "slot, includeBroken"}
	function define.m:CountItems(items)
		return DoCountPlayerItems(PrepareCountItems(items), self)
	end
	define.Info{Sig = "{item1, item2, ...}"}
	function define.m:SetRecoveryDelay(delay)
		if Game.TurnBased then
			self:SetRecoveryDelayRaw(delay)
			local ppl = self['?ptr']
			for i, a in Party do
				if a['?ptr'] == ppl then
					Game.TurnBasedDelays[i] = max(delay, Game.TurnBasedDelays[i])
					local p = mmv(0x4C7DF0, 0x4F86D8, 0x509C98)
					if i*8 + 4 == i4[p + 4*8] then
						call(mmv(0x404EB0, 0x40471C, 0x4049BA), 1, p)
					end
					break
				end
			end
		else
			self:SetRecoveryDelayRaw(delay*2.1333333333333333333333*mem.r4[mmv(0x61080C, 0x6BE224, 0x6F39E4)])
		end
	end
	define.Info{Sig = "Delay"}
	function define.m:GetIndex()
		local a = Party.PlayersArray
		local i = (self["?ptr"] - a["?ptr"])/self["?size"]
		if i % 1 == 0 and i >= 0 and i < a.Count then
			return i
		end
	end
	define.Info "Returns player index in #Party.PlayersArray:structs.GameParty.PlayersArray#"
end

local DrawStyles = {
	opaque = mmv(0x40A1D0, 0x4A5E42, 0x4A3CD5),
	transparent = mmv(0x40A680, 0x4A6204, 0x4A419B),
	red = mmv(0x40A760, 0x4A6706, 0x4A4784),
	green = mmv(0x40A880, 0x4A687F, 0x4A4A1E),
	popaque = -mmv(0x40B000, 0x4A5E42, 0x4A3CD5),
	ptransparent = -mmv(0x40B180, 0x4A6204, 0x4A419B),
	pred = mm78(-0x4A6706, -0x4A4784),
	pgreen = mm78(-0x4A687F, -0x4A4A1E),
}

function structs.f.GameScreen(define)
	define.Info{Name = "Screen"}
	if mmver > 6 then
		define.b4  'IsD3D'
	end
	define[mmv(4, 0x10, 0x10)]
	.i4  'Width'
	.i4  'Height'
	.i4  'Pitch'
	.i4  'cx1'
	.i4  'cy1'
	.i4  'cx2'
	.i4  'cy2'
	[mmv(0x40024, 0x400EC, 0x400EC)].u4  'Buffer'
	[mmv(0x40028, 0x40034, 0x40034)].u4  'ObjectByPixel'
	[mmv(0x400AC, 0x400CC, 0x400CC)].u4  'RedBits'
	.u4  'BlueBits'
	.u4  'GreenBits'
	.u4  'RedMask'
	.u4  'GreenMask'
	.u4  'BlueMask'
	if mmver > 6 then
		define
		[0x400F0].i4  'Pitch2'
		.i4  'ClipTop'
		.i4  'ClipLeft'
		.i4  'ClipBottom'
		.i4  'ClipRight'
	end
	define.method{p = mmv(0x48D130, 0x49F14C, 0x49C7C0), name = "SaveToPcx", must = 1; '', unpack(mmver == 6 and {0, 0, 640, 480} or {})}
	 .Info{Sig = "name, x = 0, y = 0, width = 640, height = 480"; "'x', 'y', 'width', 'height' can only be specified in MM6. MM7 and MM8 save a shot of whole screen area."}
	if mmver > 6 then
		define
		.method{p = mm78(0x49F845, 0x49CEB9), name = "SaveBufferToPcx", must = 2; '', 0, 640, 480}
		 .Info{Sig = "name, buf, width = 640, height = 480"}
		.method{p = mm78(0x4A5B11, 0x4A39A2), name = "SetClipRect"; 0, 0, 640, 480}
		 .Info{Sig = "left = 0, top = 0, right = 640, bottom = 480"}
	end
	
	function define.m:Draw(x, y, pic, style, rotate, EnglishD)
		pic = type(pic) == "number" and pic or Game.IconsLod:LoadBitmap(pic, EnglishD)
		local f = assert(DrawStyles[style == true and 'opaque' or style or 'transparent'], 'unknown draw style')
		if mmver == 6 then
			mem.call(abs(f), 2, self.Buffer + (self.Width*y + x)*2, pic, f < 0 and u4[pic + 64] or 0)
		else
			mem.call(abs(f), 1, self['?ptr'], x, y, f < 0 and pic or Game.IconsLod.Bitmaps[pic], rotate or 0)
		end
	end
	define.Info{Sig = "x, y, pic, style, rotate, EnglishD"; [[
'style':
  "transparent", 'false' - draw treating color index 0 as transparent (default)
  "opaque", 'true' - draw without transparency
  "red" - draw broken item
  "green" - draw unidentified item
	Adding "p" in the beginning of 'style' string signals that 'pic' is a pointer to an image rather than its index. Note that "pred" and "pgreen" aren't supported in MM6.
]]}

	function define.m:DrawItemEffect(x, y, shapePic, efPic, palShift, palFrom, palTo, rotate, EnglishD, efEnglishD)
		assert(mmver > 6)
		shapePic = Game.IconsLod.Bitmaps[type(shapePic) == "number" and shapePic or Game.IconsLod:LoadBitmap(shapePic, EnglishD)]
		efPic = Game.IconsLod.Bitmaps[type(efPic) == "number" and efPic or Game.IconsLod:LoadBitmap(efPic, efEnglishD)]
		mem.call(mm78(0x4A6376, 0x4A4424), 1, self['?ptr'], x, y, shapePic, efPic, palShift or timeGetTime()/10, palFrom or 0, palTo or 255, rotate or 0)
	end
	define.Info{Sig = "x, y, shapePic, effectPic, palShift, palAnimateFrom, palAnimateTo, rotate, EnglishD, effectEnglishD"}
	
	function define.m:DrawToObjectByPixel(x, y, pic, index, rotate, EnglishD)
		pic = type(pic) == "number" and pic or Game.IconsLod:LoadBitmap(pic, EnglishD)
		if mmver == 6 then
			mem.call(0x40A990, 2, self.ObjectByPixel + (self.Width*y + x)*4, pic, index)
		else
			mem.call(mm78(0x4A60BA, 0x4A3F4D), 1, self['?ptr'], x, y, Game.IconsLod.Bitmaps[pic], index, rotate or 0)
		end
	end	
	define.Info{Sig = "x, y, pic, index, rotate, EnglishD"}

	function define.m:DrawPcx(x, y, pcx)
		pcx = assert(pcx['?ptr'] or tonumber(pcx))
		if mmver > 6 then
			call(mm78(0x4A5B73, 0x4A3A04), 1, self['?ptr'], x, y, pcx)
		else
			call(0x4092B0, 1, pcx, self.Buffer + (self.Width*y + x)*2, i2[pcx + 20], i2[pcx + 22])
		end
	end
	define.Info{Sig = "x, y, LoadedPcx"}
	
	local MsgText
	function define.m:DrawMessageBox(t, text, SnapToViewBox)
		local p = structs.aux.TableToDlg(t, text)
		if text then
			MsgText = tostring(text)
			text, u4[p + 0x48] = u4[p + 0x48], mem.topointer(MsgText)
		end
		call(mmv(0x40FAE0, 0x41555C, 0x414A61), 1, p, SnapToViewBox)
		if text then
			u4[p + 0x48], MsgText = text, nil
		end
		if table then
			for i = 0, 3 do
				t[i + 1] = i4[p + i*3]
			end
		end
	end
	define.Info{Sig = "Dialog, Text = nil, SnapToViewBox = false"; "Draws a message box border with optional text inside.\nIn place of 'Dialog' you can pass a table in form of !Lua[[{Left, Top, Width, Height}]].\nThe function modifies the dialog position to make it fit on the screen. If you pass a table with box position and size, it's modified accordingly.\nIf 'Text' is specified or #Dialog.StrParamPtr:structs.Dlg.StrParamPtr# is not '0', the text is drawn in the middle of the dialog and dialog box is drawn with appropriate height, but dialog height is not modified to reflect that."}

	function define.m:DrawMessageBoxBorder(x, y, w, h)
		call(mmv(0x40F710, 0x4151E4, 0x41468F), 2, x, y, w, h)
	end
	define.Info{Sig = "Left, Top, Width, Height"; "Draws a message box border.\nMinimal dimensions for proper display are '64'."}
end

function structs.f.PatchOptions(define)
	local off, n = 0, PatchOptionsPtr and i4[PatchOptionsPtr] or 0
	
	local addr = {}
	local function def(kind, name, sz)
		if off < n then
			addr[name] = PatchOptionsPtr + off
			define[off][kind](name)
		end
		off = off + (sz or 4)
	end
	local function int(name)
		def('i4', name)
	end
	local function uint(name)
		def('u4', name)
	end
	local function bool(name)
		def('b4', name)
	end
	local function single(name)
		def('r4', name)
	end
	local function double(name)
		def('r8', name, 8)
	end
	local function i8(name)
		def('i8', name, 8)
	end
	local function u8(name)
		def('u8', name, 8)
	end
	local function pchar(name)
		def('pchar', name)
	end
	local function epchar(name)
		def('EditPChar', name)
	end
	local Info = define.Info
	
	int  'Size'
	int  'MaxMLookAngle'
	bool  'MouseLook'
	bool  'MouseLookUseAltMode'
	bool  'CapsLockToggleMouseLook'
	bool  'MouseFly'
	bool  'MouseWheelFly'
	int  'MouseLookTempKey'
	int  'MouseLookChangeKey'
	int  'InventoryKey'
	int  'CharScreenKey'
	int  'DoubleSpeedKey'
	int  'QuickLoadKey'
	int  'AutorunKey'
	uint  'HDWTRCount'  Info "[MM7+]"
	uint  'HDWTRDelay'  Info "[MM7+]"
	int  'HorsemanSpeakTime'
	int  'BoatmanSpeakTime'
	single  'RawPaletteSMul'  Info "[MM7+]"
	single  'RawPaletteVMul'  Info "[MM7+]"
	bool  'NoBitmapsHwl'  Info "[MM7+]"
	bool  'PlayMP3'
	int  'MusicLoopsCount'
	bool  'HardenArtifacts'  Info "[MM7+]"
	bool  'ProgressiveDaggerTrippleDamage'
	bool  'FixChests'
	bool  'DataFiles'
	bool  'FixDualWeaponsRecovery'  Info "[MM6]"
	int  'IncreaseRecoveryRateStrength'  Info "[MM6]"
	int  'BlasterRecovery'  Info "[MM6, MM7]"
	bool  'FixSkyBitmap'  Info "[MM8]"
	bool  'NoCD'
	bool  'FixChestsByReorder'
	int  'LastLoadedFileSize'
	bool  'FixTimers'
	bool  'FixMovement'
	int  'MonsterJumpDownLimit'
	bool  'FixHeroismPedestal'  Info "[MM8]"
	bool  'SkipUnsellableItemCheck'  Info "[MM7]"
	bool  'FixGMStaff'  Info "[MM7]"
	bool  'FixObelisks'  Info "[MM8]"
	bool  'BorderlessWindowed'  Info "Actually, it should be read as \"not borderless fulscreen\". It's set to false only when the game is in Borderless Fullscreen mode"
	bool  'CompatibleMovieRender'
	bool  'SmoothMovieScaling'
	bool  'SupportTrueColor'
	int  'RenderRectLeft'
	int  'RenderRectTop'
	int  'RenderRectRight'
	int  'RenderRectBottom'
	bool  'FixUnimplementedSpells'  Info "[MM7+]"
	int  'IndoorMinimapZoomMul'
	int  'IndoorMinimapZoomPower'
	bool  'FixMonsterSummon'  Info "[MM7+]"
	bool  'FixInterfaceBugs'  Info "[MM7]"
	pchar 'UILayout'  Info "[MM7+]"
	int  'PaperDollInChests'
	bool  'HigherCloseRingsButton'  Info "[MM7]"
	int  'RenderBottomPixel'
	bool  'TrueColorTextures'  Info "[MM7+]"
	bool  'ResetPalettes'  Info "[MM7+]"
	bool  'FixSFT'
	bool  'AxeGMFullProbabilityAt'  Info "[MM7+]"
	double 'MouseDX'
	double 'MouseDY'
	bool  'TrueColorSprites'  Info "[MM7+]"
	bool  'FixMonstersBlockingShots'  Info "[MM7+]"
	bool  'FixParalyze'  Info "[MM6] May come to MM7 and MM8 in the future."
	bool  'EnableAttackSpell'
	int  'ShooterMode'
	int  'MaxMLookUpAngle'
	bool  'FixIceBoltBlast'  Info "[MM7+]"
	int  'MonSpritesSizeMul'  Info "Default is 0 - disabled. 0x10000 stands for 1.0."
	bool  'FixMonsterAttackTypes'  Info "[MM7+]"
	bool  'FixMonsterSpells'
	bool  'FixSouldrinker'
	int  'MouseLookPermKey'
	int  'LastSoundSample'
	int  'WaterWalkDamage'  Info "[MM7+]"
	bool  'FixUnmarkedArtifacts'  Info "[MM6, MM7]"
	bool  'FixClubsDelay'  Info "[MM7+]"
	bool  'FixDarkTrainers'  Info "[MM7]"
	bool  'FixLightBolt'  Info "[MM7+]"
	int  'ArmageddonElement'
	bool  'FixKelebrim'  Info "[MM7]"
	bool  'FixBarrels'  Info "[MM7]"
	bool  'ClimbBetter'  Info "[MM7+]"
	bool  'FixWaterWalkManaDrain'
	bool  'KeepEmptyWands'
	bool  'DontSkipSimpleMessage'  Info "[MM6, MM7]"
	bool  'FixItemDuplicates'
	bool  'FixClubsGeneration'  Info "[MM8]"
	bool  'FixAcidBurst'  Info "[MM7+]"
	bool  'EnchantMayFail'
	bool  'TownPortalMayFail'
	bool  'RegenerationIcon'  Info "[MM7+] In MM8 it's used for \"SeparateBuffIcons\" setting."
	int  'SubDirection'
	int  'SubLookAngle'
	int  'TownPortalCost'  Info "Gets set before opening Town Portal dialog, retrieved when the town is chosen."
	int  'MouseFlyKey'
	bool  'ModernStrafe'
	single  'ExtraSMulD3D'  Info "[MM7+]"
	single  'ExtraVMulD3D'  Info "[MM7+]"
	pchar  'DataFilesDir'
	
	function define.f.Present(name)
		return not not addr[name]
	end
	 define.Info{Sig ="name"; "Returns 'true' if the option is supported by patch version being used"}
	function define.f.Ptr(name)
		return addr[name]
	end
	 define.Info{Sig ="name"; "Returns address of an option if it's supported by patch version being used"}
	function define.f.UILayoutActive()
		return (Game.PatchOptions.UILayout or "") ~= "" and Game.Windowed ~= 0
	end
	 define.Info{"Returns 'true' if UILayout mode is currently active"}
	
	if addr.ExtraVMulD3D then
		-- remove legacy support multipliers
		r4[addr.ExtraSMulD3D] = 1
		r4[addr.ExtraVMulD3D] = 1
	end
	if addr.RawPaletteVMul then
		local function PalField(name, mul)
			local p = addr["Raw"..name]
			addr[name] = p
			if addr.ExtraVMulD3D or mmver == 6 or i4[mm78(0xDF1A68, 0xEC1980)] == 0 then
				define[p - PatchOptionsPtr].r4(name)
			else
				define[p - PatchOptionsPtr].CustomType(name, 4, function(o, obj, name, val)
					if val == nil then
						return r4[p]*mul
					else
						r4[p] = val/mul
					end
				end)
			end
			Info "[MM7+]"
		end
		PalField("PaletteSMul", 1.025)
		PalField("PaletteVMul", 246/255)
	end
end

if mmver == 7 then
	function structs.f.MonsterKind(define)
		define
		.b1  'Undead'
		.b1  'Demon'
		.b1  'Dragon'
		.b1  'Elf'
		.b1  'Swimmer'
		.b1  'Immobile'
		.b1  'Titan'
		.b1  'NoArena'
	end
elseif mmver == 8 then
	function structs.f.MonsterKind(define)
		define
		.b1  'Undead'
		.b1  'Dragon'
		.b1  'Swimmer'
		.b1  'Immobile'
		.b1  'Peasant'
		.b1  'NoArena'
		.b1  'Ogre'
		.b1  'Elemental'
	end
end

-- function structs.f.GameStrings(define)
-- 	define
-- end

function structs.f.CustomLods(define)
	define
	.i4  'RecordIndex'
	.array(256).struct(structs.LodRecord)  'Records'
	.f.Load = PatchDll.LoadCustomLod
	 define.Info{Sig = "StdLod, Name"}
	.f.Free = PatchDll.FreeCustomLod
	 define.Info{Sig = "Ptr"}
end

function structs.f.LodRecord(define)
	define
	.u4  'LodPtr'
	.u4  'NamePtr'
	 .Info "Pointer passed to Load* function"
	.string(0x40)  'Name'
end
