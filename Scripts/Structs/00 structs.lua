local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local PatchDll = mem.dll[AppPath.."mm"..internal.MMVersion.."patch"] or {}
local PatchOptionsPtr = PatchDll.GetOptions
PatchOptionsPtr = PatchOptionsPtr and PatchOptionsPtr()

function events.StructsLoaded()
	Game = structs.GameStructure:new(0)
	Party = Game.Party
	Map = Game.Map
	Mouse = Game.Mouse
	Game.Dll = PatchDll
end

local _KNOWNGLOBALS, DecListBuf

function structs.f.GameStructure(define)
	define
	 .Info{Name = "Game"}
	 .Info{new = true, Name = "Version", "(6 - 8)"}
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
	-- [0].struct(structs.GameStrings)  'Strings'
	[PatchOptionsPtr or 0].struct(structs.PatchOptions)  'PatchOptions'
	if PatchDll.GetLodRecords then
		define[PatchDll.GetLodRecords()].struct(structs.CustomLods)  'CustomLods'
	end
	define
	[offsets.MainWindow].u4  'WindowHandle'
	[offsets.Windowed].u4  'Windowed'
	[offsets.CurrentPlayer].CustomType('CurrentPlayer', 4, function(o, obj, name, val)
		if val == nil then
			return u4[o] - 1
		else
			u4[o] = val + 1
		end
	end)
	[mmv(0x4C2750, 0x4EDD80, 0x4FDF88)].array(13).i2  'SkillRecoveryTimes'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x4BCDD8, 0x4E28D8, 0x4F37D8)].i4  'CurrentScreen'
	[mmv(0x4D4714, 0x506DC8, 0x5185A8)].i4  'CurrentCharScreen'
	[mmv(0x52D0E4, 0x576CEC, 0x587914)].b4  'LoadingScreen'
	--[mmv(0x4D48F8, nil, nil)].array{20, lenA = i4, lenP = mmv(0x4D46BC, nil, nil)}.struct(structs.Dlg)  'DialogsStack'
	[mmv(0x9DDD8C, 0xF8B01C, 0xFFD408)].i4  'HouseScreen'
	[mmv(0x551F94, 0x591270, 0x5A56E0)].i4  'HouseNPCSlot'
	[mmv(0x9DDD9C, 0xF8B034, 0xFFD420)].i4  'HouseCost'
	[mmv(0x9DDD70, 0xF8B028, 0xFFD414)].i4  'HouseAllowAction'
	[mmv(0x9DDD88, 0xF8B02C, 0xFFD418)].i4  'HouseActionInfo'
	[mmv(0x9DDD98, 0xF8B030, 0xFFD41C)].i4  'HouseTeachMastery'
	[mmv(0x9DDD80, 0xF8B018, 0xFFD404)].i4  'HousePicType'
	[mmv(0x552F48, 0x590F00, 0x5A5384)].i4  'HouseOwnerPic'
	.func{name = "ExitHouseScreen", p = mmv(0x4A4AA0, 0x4BD818, 0x4BB3F8), ret = true}
	[mmv(0x4C3E10, 0x4F076C, 0x500D30)].array(mmv(17, 11, 11)).i4  'GuildJoinCost'
	[mmv(0x4D5088, 0x5079F8, 0x5192EC)].array(7).EditPChar  'StatsNames'
	 .Info{Sig = "[stat:const.Stats]"}
	[mmv(0x56F27C, 0x5C85F8, 0x5E4990)].array(7).EditPChar  'StatsDescriptions'
	 .Info{Sig = "[stat:const.Stats]"}
	[mmv(0x970C7C, 0xAE3150, 0xBB3060)].array(mmv(31, 37, 39)).EditPChar  'SkillNames'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x56F394, 0x5C88F0, 0x5E4CB0)].array(mmv(31, 37, 39)).EditPChar  'SkillDescriptions'
	 .Info{Sig = "[skill:const.Skills]"}
	[mmv(0x970BEC, 0xAE3070, 0xBB2FD0)].array(mmv(18, 36, 36)).EditPChar  'ClassNames'
	 .Info{Sig = "[class:const.Class]"}
	[mmv(0x56B6C0, 0x5C8560, 0x5E48F0)].array(mmv(18, 36, 36)).EditPChar  'ClassDescriptions'
	 .Info{Sig = "[class:const.Class]"}
	[mmv(0x4D5F4C, 0x50CA54, 0x51E334)].array{40, lenA = i4, lenP = mmv(0x4D5F48, 0x50CA50, 0x51E330)}.struct(structs.ActionItem)  'Actions'
	.func{name = "ProcessActions", p = mmv(0x42ADA0, 0x4304D6, 0x42EDD8)}
	[mmv(0x52D29C, 0x576EAC, 0x587ADC)].b4  'NeedRedraw'
	[mmv(0x55BC04, 0x5C32A8, 0x5DB758)].string(200)  'StatusMessage'
	.string(200)  'MouseOverStatusMessage'
	.i4  'StatusDisappearTime'
	-- (MM6)
	-- 54F060 Timers
	-- 552F50 TimersCount
	-- 5F883C ; char SaveSlotsFiles[40][280]
	-- 5FB9B4 SaveSlotsCount
	-- 6296EC dist_mist

	[mmv(0x560C14, 0x5D2864, 0x5EFBCC)].array{mmv(581, 800, 803), lenA = i4, lenP = mmv(0x560C10, 0x5D2860, 0x5EFBC8)}.struct(structs.ItemsTxtItem)  'ItemsTxt'
	.array(mmv(14, 24, 24)).struct(structs.StdItemsTxtItem)  'StdItemsTxt'
	.array(mmv(59, 72, 72)).struct(structs.SpcItemsTxtItem)  'SpcItemsTxt'
	local i, j = mmv(160, 222, 222), mmv(188, 271, 271)
	define[mmv(0x56A780, 0x5E17C4, 0x5FEC10)].array(i, j).array(i, j)[mmv('u1','i2','i2')]  'PotionTxt'
	
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
		define[mmv(nil, 0x5CAA38, 0x5E6E00)].array{77, lenA = i4, lenP = mmv(nil, 0x5CAA38, 0x5E6E00) + 0x44*77}.struct(structs.MapStatsItem)  'MapStats'
	end
	define
	[mmv(0x4C3B74, 0x4EFEC8, 0x5004E8)].array(mmv(68, 78, 78)).i2  'MapDoorSound'
	[mmv(0x4C1F18, 0x4EC9B8, 0x4FC9EC)].array(16).struct(structs.FogChances)  'MapFogChances'
	
	define.union 'MoveToMap'
		[mmv(0x551D20, 0x5B6428, 0x5CCCB8)].array(3).i4  'Pos'
		[mmv(0x551D20, 0x5B6428, 0x5CCCB8)].i4  'X'
		.i4  'Y'
		.i4  'Z'
		.i4  'Direction'
		 .Info "0 - 2047. 0 is East."
		.i4  'LookAngle'
		.i4  'SpeedZ'
		.b4  'Defined'
	.union()
	[mmv(0x55BDB4, 0x5C346C, 0x5DB91C)].i4  'Lucida_fnt'
	[mmv(0x55BDB8, 0x5C3488, 0x5DB938)].i4  'Smallnum_fnt'
	[mmv(0x55BDC4, 0x5C3468, 0x5DB918)].i4  'Arrus_fnt'
	[mmv(0x55BDC8, 0x5C347C, 0x5DB92C)].i4  'Create_fnt'
	[mmv(0x55BDCC, 0x5C3484, 0x5DB934)].i4  'Comic_fnt'
	[mmv(0x55BDBC, 0x5C3474, 0x5DB924)].i4  'Book_fnt'
	[mmv(0x55BDD4, 0x5C3470, 0x5DB920)].i4  'Book2_fnt'
	if mmver < 8 then
		define[mmv(0x55BDDC, 0x5C3480, nil)].i4  'Cchar_fnt'
	end
	define
	[mmv(0x55BDD0, 0x5C3460, 0x5DB910)].i4  'Autonote_fnt'
	[mmv(0x55BDC0, 0x5C3464, 0x5DB914)].i4  'Spell_fnt'  -- Autonote_fnt2
	[mmv(0x55CDE0, 0x5C5C30, 0x5DF0E0)].string(500)  'TextBuffer'
	[mmv(0x55D5B0, 0x5C6400, 0x5E1020)].string(500)  'TextBuffer2'
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
			local t1 = mmv({}, {0x41E0E2-4}, {0x41D68D-4})
			mem.IgnoreProtection(true)
			for _, p in ipairs(t) do
				i4[p] = val
			end
			for _, p in ipairs(t1) do
				i4[p] = -val
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
		define[mmv(nil, 0xF8BA08, 0xFFDE00)].i4  'BinkVideo'
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
	[offsets.TimeStruct1 + 4].b4  'Paused'  -- checked by event timers
	 .Info "checked by event timers"
	[offsets.TimeStruct2 + 4].b4  'Paused2'  -- checked by water damage
	 .Info "checked by water damage"
	-- MM6: 4C4468 - something related to shop items generation
	[mmv(0x90EC2C, 0xAD45B4, 0xB7CA8C)].array(mmv(1, 0, 0), mmv(47, 52, 52)).array(12).struct(structs.Item)  'ShopItems'
	 .Info{Sig = "[house][slot]"}
	[mmv(0x9129DC, 0xAD9F24, 0xB823FC)].array(mmv(1, 0, 0), mmv(41, 52, 52)).array(12).struct(structs.Item)  'ShopSpecialItems'
	 .Info{Sig = "[house][slot]"}
	[mmv(0x91663C, 0xADF894, 0xB87D6C)].array(mmv(119, 139, 139), mmv(140, 170, 172)).array(mmv(1, 1, 12)).array(12).struct(structs.Item)  'GuildItems'
	 .Info{Sig = "[house][school][slot]"; "In MM8 in each guild items for all 12 schools of magic are generated. In MM6 and MM7 'school' can only be 0."}
	-- if mmver == 6 then
	-- 	define[0x91663C].array(119, 140).array(12).struct(structs.Item)  'GuildItems'
	-- elseif mmver == 7 then
	-- 	define[0xADF894].array(139, 170).array(12).struct(structs.Item)  'GuildItems'
	-- else
	-- 	define[0xB87D6C].array(139, 172).array(12).array(12).struct(structs.Item)  'GuildItems'
	-- 	 .Info{Sig = "[shop][slot]"}
	-- end
	if mmver < 8 then
		define[mmv(0x4CA718, 0x505828)].array(480).i4  'ScanlineOffset'
	end
	define
	[mmv(0x90E894, 0xACCEC4, 0xB20F1C)].array(mmv(1, 0, 0), mmv(47, 52, 52)).i8  'ShopNextRefill'
	 .Info{Sig = "[house]"}
	[mmv(0x9B1090, 0xE31A9C, 0xF019B4)].parray(480).array(640).struct(structs.ObjectRef)  'ObjectByPixel'
	 .Info{Sig = "[y][x]"}
	[mmv(0x918938, 0xAE2F74, 0xBB2E04)].i4  'ArmageddonTimeLeft'  -- maximum is 417
	 .Info "maximum is 417"
	[mmv(0x91893C, 0xAE2F78, 0xBB2E08)].i4  'ArmageddonSkill'  -- damage is 50 + skill
	 .Info "damage is 50 + skill"
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
		[mmv(nil, 0x73B8D4, 0x7798B8)].array(0, 205).array(0, 1).EditPChar  'NPCGreet'
		[mmv(nil, 0x73BFAA, 0x779F8E)].array(0, 50).i2  'NPCGroup'
		[mmv(nil, 0x739CF4, 0x778F50)].array(0, 50).EditPChar  'NPCNews'
		[mmv(nil, 0x5C89E0, 0x5E4DA8)].array(1, 29).struct(structs.HistoryTxtItem)  'HistoryTxt'
	else
		define
		[0x6B8C60].array{0, 279}.struct(structs.NPCNewsItem)  'NPCNews'
		[0x6BA568].array(96).i2  'NPCNewsCountByMap'
	end
	if mmver < 8 then
		define[mmv(0x6A9168, 0x724050)]
		.array(mmv(400, 501)).struct(structs.NPC)  'NPCDataTxt'
		.array{mmv(400, 501), lenA = i4, lenP = mmv(0x6BA534, 0x73C014)}.struct(structs.NPC)  'NPC'
		[mmv(0x6B74F0, 0x737F44)].array{100, lenA = i4, lenP = mmv(0x6BA530, 0x73C010)}.struct(structs.NPC)  'StreetNPC'
		[mmv(0x6BA85C, 0x73C110)].array(mmv(78, 59)).EditPChar  'NPCProfNames'
		[mmv(0x6B4CE8, 0x7369C8)].array(540).array(2).EditPChar  'NPCNames'
		[mmv(0x6BA540, 0x73C020)].array(2).i4  'NPCNamesCount'
	else
		define[0x761998]
		.array(551).struct(structs.NPC)  'NPCDataTxt'
		.array(551).struct(structs.NPC)  'NPC'
	end
	define
	[mmv(0x4BDD6E, 0x4E3C46, 0x4F486E)].array(0, mmv(99, 99, 132)).struct(structs.SpellInfo)  'Spells'
	[mmv(0x56ABD0, 0x5CBEB0, 0x5E8278)].array(0, mmv(99, 99, 132)).struct(structs.SpellsTxtItem)  'SpellsTxt'
	[mmv(0x6A8808, 0x722D94, 0x760394)].array(1, 512).EditPChar  'QuestsTxt'
	if mmver == 6 then
		define[0x6A900C].array{1, 87}.EditPChar  'AwardsTxt'
	else
		define
		[mmv(nil, 0x723D08, 0x761650)].array{1, 104, ItemSize = 8}.EditPChar  'AwardsTxt'
		[mmv(nil, 0x723D0C, 0x761654)].array{1, 104, ItemSize = 8}.i4  'AwardsSort'
	end
	if mmver == 6 then
		define[0x6BA62C].array{1, 128}.EditPChar  'AutonoteTxt'
	elseif mmver == 7 then
		define
		[0x7235A0].array{1, 195, ItemSize = 8}.EditPChar  'AutonoteTxt'
		[0x7235A4].array{1, 195, ItemSize = 8}.i4  'AutonoteCategory'
		 .Info "0 = potion\n1 = stat\n2 = obelisk\n3 = seer\n4 = misc\n5 = teacher"
	else
		define
		[0x760BA0].array{1, 300, ItemSize = 8}.EditPChar  'AutonoteTxt'
		[0x760BA4].array{1, 300, ItemSize = 8}.i4  'AutonoteCategory'
		 .Info "0 = potion\n1 = stat\n2 = obelisk\n3 = seer\n4 = misc\n5 = teacher"
	end
	define
	[mmv(0x6BA9A0, 0x73C208, 0x77A1E0)].array(4).array(mmv(6, 7, 7)).EditPChar  'MerchantTxt'
	[mmv(0x4D50A8, 0x507A18, 0x51930C)].b4  'CtrlPressed'
	[mmv(0x4D50EC, 0x507A70, 0x519354)].b1  'RightButtonPressed'
	[mmv(0x4C1F98, 0x4ECA60, 0x4FCA88)].array(6).struct(structs.TownPortalTownInfo)  'TownPortalInfo'
	[mmv(0x4BCAE4, 0x4E1D2C, 0x501BC8)].array(6).i2  'TownPortalX'
	 .Info "Town portal picture: townport"
	[mmv(0x4BCAF0, 0x4E1D38, 0x501BD4)].array(6).i2  'TownPortalY'
	 .Info "Town portal icons [MM7+]: tpharmndy, tpelf, tpwarlock, tpisland, tpheaven, tphell"
	if mmver < 8 then
		define
		[mmv(0x4BCB08, 0x4E1D50)].array(6).i2  'TownPortalHeight'
		[mmv(0x4BCAFC, 0x4E1D44)].array(6).i2  'TownPortalWidth'
	end
	define
	[mmv(0x4C3F20, 0x4F0830, 0x500DF8)].array(mmv(36, 35, 25)).struct(structs.TravelInfo)  'TransportLocations'
	[mmv(0x4C43A0, 0x4F0C90, 0x501118)].array(mmv(48, 54, 54), mmv(68, 73, 73)).array(1, mmv(3, 4, 4)).i1  'TransportIndex'
	if mmver > 6 then
		define[mmv(nil, 0x5C8B40, 0x5E4F08)].array(89).array(89).u1  'HostileTxt'
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
	 .Info "Number represented as a string.\n[MM6] Index in games.lod\n[MM7,8] Index in mapstats.txt"
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
	end
	define[mmv(0x5F811C, 0x6A0BC4, 0x6CEB24)].i4  'MainMenuCode'
	 .Info "-1 = in game, 1 = show new game, 6 = in new game, 3 = load menu, 4 = exit, 2 = show credits, 8 = in credits, 9 = load game"
	-- 465012(MM8) SetMainMenuCode
	if mmver == 6 then
		define.goto(0x6199C0)
	end
	define.i4  'ExitLevelCode'
	 .Info "0 = in game, 2 = load other map, 8 = death"
	[mmv(0x6107E3, 0x6BE1EF, 0x6F39AF)].i4  'SoundVolume'
	
	-- stditems, spcitems, rnditems

	define
	[mmv(0x6104F8, 0x6A08E0, 0x6CE838)].struct(structs.Lod)  'GamesLod'
	[mmv(0x4CB6D0, 0x6D0490, 0x70D3E8)].struct(structs.BitmapsLod)  'IconsLod'
	[mmv(0x610AB8, 0x6F0D00, 0x72DC60)].struct(structs.BitmapsLod)  'BitmapsLod'
	[mmv(0x61AA10, 0x6E2048, 0x71EFA8)].struct(structs.SpritesLod)  'SpritesLod'
	[mmv(0x610830, 0x6A06A0, 0x6CE5F8)].struct(structs.Lod)  'SaveGameLod'
	if mmver == 7 then
		define[0x6BE8D8].struct(structs.Lod)  'EventsLod'
	end
	if mmver > 6 then
		define[mmv(nil, 0xE31AF0, 0xF01A08)].u4  'RendererD3D'
		.Info{Name = "IsD3D", new = true}
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

	if mmver == 7 then
		define.func{name = "SetInterfaceColor", p = mmv(nil, 0x422698, nil), cc = 2, must = 1; 1, 1}  -- 0 - good, 1 - neutral, 2 - evil
		 .Info{Sig = "Color, Unk = 1"; "0 = good, 1 = neutral, 2 = evil"}
	end
	define
	.func{name = "DoShowMovie", p = mmv(0x4A59A0, 0x4BE671, 0x4BC1F1), cc = 2, must = 1; "", 0, true, true}
	 .Info{Sig = "Name, Y, DoubleSize, ExitCurrentScreen"; "Only call from #events.ShowMovie:#, use #evt.ShowMovie:# otherwise."}
	.func{name = "CalcSpellDamage", p = mmv(0x47F0A0, 0x43B006, 0x438B05), cc = 0, must = 4}
	 .Info{Sig = "Spell, Skill, Mastery, MonsterHP"}
	.func{name = "GetSpellDamageType", p = mmv(0x481A60, 0x48E189, 0x48D618), cc = 0, must = 1}
	 .Info{Sig = "Spell"}
	.func{name = "GetStatisticEffect", p = mmv(0x482DC0, 0x48EA13, 0x48E18E), cc = 0, must = 1}
	 .Info{Sig = "Stat"}
	.func{name = "EscMessage", p = mmv(0x40F480, 0x4141D5, 0x41365A), cc = 2, must = 1; "", 0}
	 .Info{Sig = "Text, Unk = 0"}
	.func{name = "SummonMonster", p = mmv(0x4A35F0, 0x4BBEC4, 0x4BA076), cc = 2, must = 4}
	 .Info{Sig = "Id, X, Y, Z"}
	if mmver > 6 then
		define[internal.MonsterKindPtr].parray{lenA = i4, lenP = internal.MonsterKindPtr + 4}.struct(structs.MonsterKind)  'MonsterKinds'
		.func{name = "IsMonsterOfKind", p = mmv(nil, 0x438BCE, 0x436542), cc = 2, must = 2}
		 .Info{Sig = "Id, Kind:const.MonsterKind"}
	end
	
	function define.f.LoadSound(soundId, unk, unk2)
		call(mmv(0x48E2D0, 0x4A99F7, 0x4A7F22), 1, mmv(0x9CF700, 0xF79BDC, 0xFEBFE4), soundId, unk or 0, unk2 or 0)
	end
	define.Info{Sig = "SoundId, Unk = 0, Unk2 = 0"; "'Unk2' is present only in MM8"}
	function define.f.PlaySound(soundId, object, loops, x, y, unk, volume, playbackRate)
		call(mmv(0x48EB40, 0x4AA29B, 0x4A87DC), 1, mmv(0x9CF598, 0xF78F58, 0xFEB360), soundId, object or -1, loops or 0, x or -1, y or 0, unk or 0, volume or 0, playbackRate or 0)
	end
	define.Info{Sig = "SoundId, Object = -1, Loops = 0, X = -1, Y = 0, Unk = 0, Volume = 0, PlaybackRate = 0"}
	function define.f.StopAllSounds(keepMin, keepMax)
		call(mmv(0x48FB40, 0x4AB69F, 0x4A9BF7), 1, mmv(0x9CF598, 0xF78F58, 0xFEB360), keepMin, keepMax)
	end
	define.Info{Sig = "keepMin = -1, keepMax = -1"}
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
			id = i2(call(mmv(nil, 0x4488D9, 0x445C59), 1, pDecList, DecListBuf))
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
		if Game.CurrentScreen == 13 and Game.HouseNPCSlot > (Game.HouseOwnerPic ~= 0 and 1 or 0) then
			Game.HouseScreen = -1
			call(mmv(0x4998A0, 0x4B4187, 0x4B2C36), 1, Game.HouseNPCSlot - 1)
		end
	end
	function define.f.ShowStatusText(text, time)
		call(mmv(0x442BD0, 0x44C1A1, 0x4496C5), 2, tostring(text), time or 2)
		Game.NeedRedraw = true
	end
	define.Info{Sig = "Text, Seconds = 2"}
	function define.f.LoadPalette(PalNum)
		return call(mmv(0x47CBC0, 0x48A3A2, 0x489C9F), 1, mmv(0x762D80, 0x80D018, 0x84AFE0), PalNum)
	end
	define.Info{Sig = "PalNum"}
	function define.f.LoadDataFileFromLod(name, UseMalloc)
		local p = call(mmv(0x40C1A0, 0x410897, 0x411C9B), 1, mmv(0x4CB6D0, 0x6BE8D8, 0x6FB828), name, UseMalloc)
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
	function define.f.GetCurrentHouse()
		local p = mem.u4[mmv(0x4D50C4, 0x507A40, 0x519328)]
		if p ~= 0 then
			return mem.i4[p + 0x1C]
		end
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
			t[v] = true
		end
	else
		t[items] = true
	end
	return t
end

local function DoCountPlayerItems(t, pl)
	local n = 0
	for _, i in pl.Inventory do
		if i > 0 and t[pl.Items[i].Number] then
			n = n + 1
		end
	end
	for _, i in pl.EquippedItems do
		if i > 0 and t[pl.Items[i].Number] then
			n = n + 1
		end
	end
	-- Note: evt.CheckItemsCount is buggy (doesn't contain i > 0 check), but the bug has never been spotted! Strange...
	return n
end

-- bounties, deaths, prisons, Page Victories, Squire, Knight, Lord, Bounty Creature, Killed bounty creature,  "unknown coords", Artifacts found
function structs.f.GameParty(define)
	define
	 .Info{Name = "Party"}
	[mmv(0x908C98, 0xACD4EC, 0xB21554)].alt.array(3).i4  'Pos'
	.i4  'X'
	.i4  'Y'
	.i4  'Z'
	.i4  'Direction'
	 .Info "0 - 2047. 0 is East."
	.i4  'LookAngle'
	 .Info "-512 - 512. Values allowed with mouse look: -200 - 200. Without mouse look: -128 - 128"
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
		[mmv(0x944C68, 0xA74F48)].array(4).pstruct(structs.Player)  'Players'
		[mmv(0x90E7A4, 0xAD44F4)].array(1, 2).struct(structs.NPC)  'HiredNPC'
	else
		define
		[0xB20E90 + 2540].array(50).struct(structs.Player)  'PlayersArray'
		[0xB20E90 + 375740].array(5).i4  'PlayersIndexes'
		[0xB20E90 + 375740].array{5, lenA = i4, lenP = 0xB7CA60}.CustomType('Players', 4, function(o, obj, name, val)
			if val then
				local i = (val["?ptr"] - Party.PlayersArray["?ptr"])/structs.Player["?size"]
				Party.PlayersIndexes[name] = Party.PlayersArray[i] and val
			else
				local i = Party.PlayersIndexes[name]
				if i < 0 or i >= 50 then
					i = 0
				end
				return Party.PlayersArray[i]
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
		[mmv(nil, 0xAE3060, 0xBB2EF4)].i4  'Fine'
		[mmv(nil, 0xACD588, 0xB215F0)].array(5).i2  'MonsHuntTarget'  -- only index 0 is used in MM8
		[mmv(nil, 0xACD592, 0xB215FA)].array(5).i2  'MonsHuntKilled'  -- only index 0 is used in MM8
		[mmv(nil, 0xACCE74, 0xB20ECC)].array(5).i8  'MonsHuntReset'  -- for some reason 10 values fit there
	else
		define
		[0x908DC5].array(3).u1  'MonsHuntTarget'
		[0x908DC8].array(3).b1  'MonsHuntKilled'
		[0x90E844].array(3).i8  'MonsHuntReset'  -- for some reason 9 values fit there
	end
	define
	[mmv(0x908D6D, 0xACD59D, 0xB2160F)].array(mmv(0, 1, 1), mmv(511, 512, 512)).abit  'QBits'
	[mmv(0x908DAD, 0xACD636, 0xB216A8)].array(1, mmv(128, 255, 300)).abit  'AutonotesBits'
	[mmv(0x908DBD, 0xACD5ED, 0xB2165F)].i1  'InArenaQuest'
	.i1  'ArenaWinsPage'
	.i1  'ArenaWinsSquire'
	.i1  'ArenaWinsKnight'
	.i1  'ArenaWinsLord'
	[mmv(0x908DBE, 0xACD5DD, 0xB2164F)].array(16).b1  'ArcomageWins'
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
		[mmv(nil, 0xACD364, 0xB213CC)].array(1, 29).i8  'History'
	end
	define[offsets.CurrentPlayer].CustomType('CurrentPlayer', 4, function(o, obj, name, val)
		if val == nil then
			return u4[o] - 1
		else
			u4[o] = val + 1
		end
	end)	
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
	end
	function define.f.CountItems(items)
		local t = PrepareCountItems(items)
		local n = (t[Mouse.Item.Number] and 1 or 0)
		for _, pl in Party.Players do
			n = n + DoCountPlayerItems(t, pl)
		end
		return n
	end
	define.Info{Sig = "{item1, item2, ...}"}
end

-- Character_GetInventoryItemIndex

--[[
	const.BonusStat
	-- stditems, spcitems
	
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
		.method{p = 0x48F5CE, name = "GetSex"; false}
		 .Info{Sig = "BasedOnVoice = false"; "Determines sex based on Face or Voice"}
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
	[mmv(0x7F, 0x152, 0x3C6)].array(mmv(100, 104, 104)).abit  'Awards'
	[mmv(0xBF, 0x192, 0x406)].array(mmv(100, 100, 138)).b1  'Spells'
	.skip(mmv(5, 0, 0))
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
		[mmv(nil, 0x1774, 0x1A08)].array(11).struct(structs.PlayerResistanceBaseBonus)  'Resistances'
		 .Info{Sig = "[kind:const.Damage]"}
		[mmv(nil, 0x1774, 0x1A08)].i2  'FireResistanceBase'
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
		[mmv(nil, 0x1920, 0x1BE4)].i4  'Voice'
	end
	define
	[mmv(0x1268, 0x17A0, 0x1A34)].array(mmv(16, 24, 27)).struct(structs.SpellBuff)  'SpellBuffs'
	 .Info{Sig = "[buff:const.PlayerBuff]"}
	[mmv(0x137C, 0x1934, 0x1BF2)].i2  'RecoveryDelay'
	[mmv(0x1410, 0x1938, 0x1BF4)].i4  'SkillPoints'
	[mmv(0x1414, 0x193C, 0x1BF8)].i4  'HP'
	[mmv(0x1414, 0x193C, 0x1BF8)].i4  'HitPoints'
	[mmv(0x1418, 0x1940, 0x1BFC)].i4  'SP'
	[mmv(0x1418, 0x1940, 0x1BFC)].i4  'SpellPoints'
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
	[mmv(0x1468, 0x1988, 0x1C44)].i4  'SpellBookPage'
	[mmv(0x152F, 0x1A4F, 0x1C45)].u1  'QuickSpell'
	[mmv(0x1530, 0x1A50, 0x1C46)].array(512).abit  'PlayerBits'
	if mmver < 8 then
		define
		[mmv(0x1570, 0x1A90)].i1  'MeleeAttackBonus'
		[mmv(0x1572, 0x1A92)].i1  'MeleeDamageBonus'
		[mmv(0x1574, 0x1A94)].i1  'RangedAttackBonus'
		[mmv(0x1576, 0x1A96)].i1  'RangedDamageBonus'
		[mmv(0x1578, 0x1A98)].i1  'FullHPBonus'
		[mmv(0x1578, 0x1A98)].i1  'FullHitPointsBonus'
		[mmv(0x157A, 0x159A)].i1  'FullSPBonus'
		[mmv(0x157A, 0x159A)].i1  'FullSpellPointsBonus'
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
	if mmver > 6 then
		define[mmv(nil, 0x1B3A, 0x1D26)].u1  'FireSpikeCasts'
	end
	if mmver == 7 then
		define[0x1924].i4  'FaceBeforeZombie'
		.i4  'VoiceBeforeZombie'
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
	.method{p = mmv(0x47EB80, 0x48D2D0, 0x48CBFB), name = "GetMeleeDamageRangeText", ret = ""}
	.method{p = mmv(0x47EEB0, 0x48D37C, 0x48CC98), name = "GetRangedDamageRangeText", ret = ""}
	.method{p = mmv(0x47F010, 0x48D440, 0x48CD4D), name = "CanTrain"}
	.method{p = mmv(0x47FB60, 0x48DB9F, 0x48D026), name = "AddHP", must = 1}
	 .Info{Sig = "Amount"}
	.method{p = mmv(0x47FEE0, 0x48DC04, 0x48D078), name = "DoDamage", must = 1;  0, const.Damage.Phys}
	 .Info{Sig = "Damage, DamageKind:const.Damage = const.Damage.Phys"}
	.method{p = mmv(0x480010, 0x48DCDC, 0x48D166), name = "DoBadThing", must = 1}
	 .Info{Sig = "Thing:const.MonsterBonus"}
	.method{p = mmv(0x481A80, 0x48E19B, 0x48D62A), name = "GetAttackDelay"; false}
	 .Info{Sig = "Shoot = false"}
	.method{p = mmv(0x481EA0, 0x48E4F0, 0x48D9B4), name = "GetFullHP"}
	.method{p = mmv(0x482090, 0x48E55D, 0x48DA18), name = "GetFullSP"}
	define.class.GetFullHitPoints = define.class.GetFullHP
	define.class.GetFullSpellPoints = define.class.GetFullSP
	define.class.AddHitPoints = define.class.AddHP
	if mmver > 6 then
		define
		.method{p = mmv(nil, 0x48CD2B, 0x48C6D5), name = "GetMeleeDamageMin"}
		.method{p = mmv(nil, 0x48CD76, 0x48C717), name = "GetMeleeDamageMax"}
		.method{p = mmv(nil, 0x48D10A, 0x48CA37), name = "GetRangedDamageMin"}
		.method{p = mmv(nil, 0x48D177, 0x48CA9F), name = "GetRangedDamageMax"}
		.method{p = mmv(nil, 0x48D6B6, 0x48CF8A), name = "HasItemBonus"}
		.method{p = mmv(nil, 0x48D6EF, 0x48CFC3), name = "WearsItem", must = 1, ret = true; 0, 16}
		 .Info{Sig = "ItemNum, Slot = 16"; "If 'Slot' isn't specified, searches all slots for the item"}
		.method{p = mmv(nil, 0x48E737, 0x48DBA2), name = "GetBaseResistance", must = 1}
		.method{p = mmv(nil, 0x48E7C8, 0x48DD6B), name = "GetResistance", must = 1}
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
	.method{p = mmv(0x482570, 0x48E64E, 0x48DAB9), name = "GetBaseArmorClass"}
	.method{p = mmv(0x482700, 0x48E687, 0x48DAF2), name = "GetArmorClass"}
	.method{p = mmv(0x4828A0, 0x48E6D4, 0x48DB3F), name = "GetBaseAge"}
	.method{p = mmv(0x482920, 0x48E724, 0x48DB8F), name = "GetAge"}
	.method{p = mmv(0x482BB0, 0x48E8ED, 0x48DF81), name = "Recover"}
	.method{p = mmv(0x482C80, 0x48E962, 0x48DFF8), name = "SetRecoveryDelayRaw", must = 1}
	 .Info{Sig = "Delay"}
	.method{p = mmv(0x482D30, 0x48E9EC, 0x48E127), name = "GetMainCondition"}
	 .Info{Type = "const.Condition"}
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
	.method{p = mmv(0x4876E0, 0x492C03, 0x491514), name = "IsConscious", ret = true}
	if mmver == 6 then
		define.method{p = 0x4852D0, name = "GetDiplomacyTotalSkill"}
	-- 486CF0 Character_CanTakeItemInPos
	-- 486DD0 Character_ItemsCount
	-- 486DF0 Character_PutItemInPos
	else
		define
		.method{p = mmv(nil, 0x48F87A, 0x48EF4F), name = "GetSkill", must = 1}
		.method{p = mmv(nil, 0x4948A9, 0x492BCD), name = "ShowFaceAnimation", must = 1;  0, 0}
		 .Info{Sig = "Animation"}
		.method{p = mmv(nil, 0x491252, 0x4902DF), name = "GetPerceptionTotalSkill"}
		.method{p = mmv(nil, 0x49130F, 0x49036E), name = "GetLearningTotalSkill"}
		.method{p = mmv(nil, 0x492D5D, 0x49165D), name = "AddCondition", must = 1; 0, false}
	end
	if mmver == 7 then
		define.method{p = 0x490101, name = "GetRace"}
	end
	
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
	function define.m:GetActiveItem(slot, includeBroken)
		slot = self.EquippedItems[slot]
		local item = (slot ~= 0 and self.Items[slot])
		if item and (includeBroken or item.Condition:And(2) == 0) then
			return item
		end
	end
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
end

-- function structs.f.Screen(define)
-- 	function define.f.Draw(x, y, pic, opaque)
-- 		pic = type(pic) == "number" and pic or Game.IconsLod:LoadBitmap(pic)
-- 		local f = opaque and mmv(0x40B000, 0x4A5E42, 0x4A3CD5) or mmv(0x40B180, 0x4A6204, 0x4A419B)
-- 		-- Game.IconsLod.Bitmaps[pic]
-- 	end
-- end

function structs.f.PatchOptions(define)
	local off, n = 0, PatchOptionsPtr and i4[PatchOptionsPtr] or 0
	
	local present = {}
	local function def(kind, name, sz)
		if off < n then
			present[name] = true
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
	single  'PaletteSMul'  Info "[MM7+]"
	single  'PaletteVMul'  Info "[MM7+]"
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
	bool  'FixUnimplementedSpells'  Info "[MM8]"
	int  'IndoorMinimapZoomMul'
	int  'IndoorMinimapZoomPower'
	bool  'FixMonsterSummon'  Info "[MM7+]"
	bool  'FixInterfaceBugs'  Info "[MM7]"
	pchar 'UILayout'  Info "[MM7+]"
	int  'PaperDollInChests'
	bool  'HigherCloseRingsButton'
	int  'RenderBottomPixel'
	bool  'TrueColorTextures'  Info "[MM7+]"
	bool  'ResetPalettes'  Info "[MM7+]"
	bool  'FixSFT'
	bool  'AxeGMFullProbabilityAt'  Info "[MM7+]"
	double 'MouseDX'
	double 'MouseDY'
	bool  'TrueColorSprites'  Info "[MM7+]"
	
	function define.f.Present(name)
		return present[name]
	end
	 define.Info{Sig ="name"; "Returns 'true' if the option is supported by patch version being used"}
	function define.f.UILayoutActive()
		return (Game.PatchOptions.UILayout or "") ~= "" and Game.Windowed ~= 0
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
