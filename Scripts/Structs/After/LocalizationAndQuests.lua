local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = Game.Version

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is67 = mmver < 8 or nil
local is78 = mmver > 6 or nil

local TXT = {}
TXT.Quests = TXT.Quests or {}

--!v
-- Should be either "Add" or "Set". This determines the overlay flash on character face when a quest is taken.
-- [MM6, MM8] Defaults to "Add".
-- [MM7] Defaults to "Set".
TakeQuestOperation = (mmver == 7 and "Set" or "Add")
--!v
Quests = {}

local _KNOWNGLOBALS_F = QuestNPC, vars, LocalizeAll, curry, GenerateLocalization_BakFiles, GameLocalizationIgnore, GameLocalizationSchema

-----------------------------------------------------
-- LocalizeAll
-----------------------------------------------------

local LocalizeIsTmp = setmetatable({}, {__index = function(t, k)
	local t1 = {}
	t[k] = t1
	return t1
end})

-- over = true:      permanent setup - overwrite all
-- over = false:     temporary setup - overwrite temporary setup only
-- over = "update":  remove all previous temporary setup, overwrite temporary setup only
local function CopyLoc(loc, t, over)
	local tmp = LocalizeIsTmp[t]
	if over == "update" then
		for k in pairs(tmp) do
			rawset(t, k, nil)
		end
		over = nil
	end
	for k, v in pairs(loc) do
		if rawget(t, k) == nil then
			rawset(t, k, v)
			tmp[k] = not over or nil
		elseif type(v) == "table" then
			assert(type(t[k]) == "table", "type mismatch")
			CopyLoc(v, t[k], over)
			tmp[k] = nil
		elseif over or tmp[k] then
			t[k] = v
			tmp[k] = not over or nil
		end
	end
end

local function NewLoc(t)
	return setmetatable({}, {
		__index = function(_, k, v)
			local t1 = rawget(t, k) or {}
			rawset(t, k, t1)
			return NewLoc(t1)
		end,
		__call = function(_, t1, over)
			if t1 then
				CopyLoc(t1, t, over)
			end
			return t
		end,
		__newindex = function(_, k, t2)
			local t1 = rawget(t, k) or {}
			rawset(t, k, t1)
			CopyLoc(t2, t1, true)
		end,
	})
end

--!vt(function)(t, over) See #Localization:#.
-- Possible values of 'over':
--   true:  permanent setup - overwrite all (used in !b[[Localization]] scripts only)
--   false:  temporary setup - overwrite temporary setup only
--   "update":  remove all previous temporary setup, overwrite temporary setup only
LocalizeAll = NewLoc(TXT)

--!(t, over, lev = 1) See #Localization:#.
-- Possible values of 'over':
--   true:  permanent setup - overwrite all (used in !b[[Localization]] scripts only)
--   false:  temporary setup - overwrite temporary setup only
--   "update":  remove all previous temporary setup, overwrite temporary setup only
function Localize(t, over, lev)
	if type(lev) == "number" then
		lev = lev + 1
	end
	local name = path.GetRelativePath(AppPath.."Scripts", debug.FunctionFile(lev or 2)):lower()
	if over == nil then
		over = "update"
	end
	t = LocalizeAll[name](t, over)
	return setmetatable(t, {__index = TXT})
end

-----------------------------------------------------
-- GenerateLocalization
-----------------------------------------------------
-- some black magic to generate localization for all files...

--!v Set it to 'false' in a General script to turn off *.bak files creation when generating localization
GenerateLocalization_BakFiles = true

local function SaveWithBak(fname, s)
	if GenerateLocalization_BakFiles then
		for fname in path.find(fname) do
			local fbak = fname..'.bak'
			os.remove(fbak)
			os.rename(fname, fbak)
		end
	else
		os.remove(fname)
	end
	io.save(fname, s)
end

-- Generates localization file for quests created with functions from this file.
function GenerateQuestsLocalization(IsLua)  -- do nothing until quests are added
end

local Keywords = {}
do
	local t = {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "goto"}
	for k, v in pairs(t) do
		Keywords[v] = k
	end
end

local function LocalizationTableKey(k)
	if type(k) ~= "string" then
		return "["..tostring(k).."]"
	elseif not k:match("^[%a_][%w_]*$") or Keywords[k] then
		return ("[%q]"):format(k):gsub("\t", "\\t"):gsub("\r", "\\r")
	end
	return k
end

local function LocalizationTableStr(k, v)
	k = LocalizationTableKey(k)
	if type(v) == "string" then
		return ("%s\t%s"):format(k, v:gsub("[\t\r]", ""))
	else
		return ("%s#\t%s"):format(k, dump(v, nil, true):gsub("\t", "\\t"):gsub("\r", "\\r"))
	end
end


local function RunLocalizationInFile(fname)
	local f = loadfile(fname)
	local glob = internal.NoGlobals.GetLastUsedGlobals()
	local HasLoc, HasLocS = glob.LocalizeAll, glob.Localize
	if not HasLoc and not HasLocS then
		return
	end
	
	-- run the script until it does localization
	local env = setmetatable({}, {__index = _G})
	setfenv(f, env)
	
	local LastCopyLoc = CopyLoc
	local Inside
	CopyLoc = not HasLoc and CopyLoc or function(...)
		local WasIn = Inside
		Inside, HasLoc = true, HasLoc and Inside
		LastCopyLoc(...)
		Inside = WasIn
		assert(Inside or HasLoc or HasLocS)
	end
	env.Localize = HasLocS and function(t, over, lev)
		Inside, HasLocS = true, false
		if type(lev) == "number" then
			lev = lev + 1
		else
			lev = lev or 2
		end
		local t = Localize(t, over, lev)
		Inside = nil
		assert(HasLoc or HasLocS)
		return t
	end
	xpcall(f, function(s) return s end)
	CopyLoc = LastCopyLoc
end

local function RunLocalizationInFiles()
	for f in path.find(AppPath.."Scripts/Maps/*.lua") do
		if not f:match("%.[Gg][Ll][Oo][Bb][Aa][Ll]%.[^%.\\/:]*$") then
			RunLocalizationInFile(f)
		end
	end
	for f in path.find(AppPath.."Scripts/Modules/*.lua") do
		if not package.loaded[path.setext(path.name(f), '')] then
			RunLocalizationInFile(f)
		end
	end
end

local function MakeLocalizationLists()
	local common, scripts = {}, {}
	for k, v in pairs(TXT) do
		local t = common
		if k == "Quests" then
			t = {}
		elseif type(v) == "table" and type(k) == "string" and k:find(".\\", 1, true) == 1 then
			t = scripts
		end
		t[k] = v
	end
	return common, scripts
end

local function GenerateLocalizationFileLua(fname, t, IsCommon)
	local str = {}
	if IsCommon then
		str[1] = ("LocalizeAll(%s, true)\n"):format(dump(t, nil, true))
	else
		for k, v in sortpairs(t) do
			str[#str + 1] = ("LocalizeAll[%q] = %s\n"):format(k, dump(v, nil, true))
		end
	end
	SaveWithBak(AppPath.."Scripts/Localization/"..fname..".lua", table.concat(str, "\n"))
end

local function GenerateLocalizationFile(fname, t, IsLua, IsCommon)
	os.mkdir(AppPath.."Scripts/Localization")
	if IsLua then
		return GenerateLocalizationFileLua(fname, t, IsCommon)
	end
	local str = {"Key=\tValue$=", IsCommon and "" or nil}
	local function WriteTable(t, spaces)
		for k, v in sortpairs(t) do
			if type(v) == "table" then
				str[#str+1] = (spaces and "\r\n%s{\t" or "%s{\t"):format(LocalizationTableKey(k))
				WriteTable(v)
				str[#str+1] = "}\t"
			else
				str[#str+1] = LocalizationTableStr(k, v)
			end
		end
	end
	WriteTable(t, not IsCommon)
	if IsCommon then
		str[#str + 1] = ""
	end
	SaveWithBak(AppPath.."Scripts/Localization/"..fname..".txt", table.concat(str, "\r\n"))
end

-- Generates localization files for scripts that call #Localize:# or #LocalizeAll:# functions.
-- Pass 'IsLua' = 'true' to generate *.lua files instead of *.txt tables. Whichever is more convenient for you.
-- Unless 'IncludeQuests' is 'false', localization for quests is also generated.
function GenerateLocalization(IsLua, IncludeQuests)
	RunLocalizationInFiles()
	local common, scripts = MakeLocalizationLists()
	os.mkdir(AppPath.."Scripts/Localization")
	GenerateLocalizationFile("Common", common, IsLua, true)
	GenerateLocalizationFile("Scripts", scripts, IsLua)
	if IncludeQuests ~= false then
		GenerateQuestsLocalization(IsLua)
	end
end

local function SanitizeLoc(loc)
	local t = {}
	for k, v in pairs(loc) do
		local tp = type(v)
		if tp == "string" then
			t[k] = v
		elseif tp == "table" then
			t[k] = SanitizeLoc(v)
		end
	end
	return t
end

-----------------------------------------------------
-- GenerateGameLocalization
-----------------------------------------------------

local GameLocalizationStart = [[
if not GameInitialized2 then
	local f = debug.getinfo(1, "f").func
	events.GameInitialized2 = f
	events.TxtFilesReloaded = f
	return
end

]]

local GameLocalizationStartRoster = [[
if not GameInitialized2 then
	events.LoadedRosterTxt = debug.getinfo(1, "f").func
	return
end

]]

--!v List of table names in Game structure that shouldn't be included in localization by #GenerateGameLocalization:#
GameLocalizationIgnore = {}
--!v Defines which files contain which names of Game structure tables and more (see in code)
GameLocalizationSchema = {
	{ Name = 'Game',
		'MonstersTxt', 'PlaceMonTxt', 'SpellsTxt',
	},
	{ Name = 'GamePlaces',
		'MapStats', 'Houses', 'TransTxt',
	},
	{ Name = 'GameNotes',
		'AutonoteTxt', 'AwardsTxt', 'HistoryTxt', 'QuestsTxt',
	},
	{ Name = 'GameItems',
		'StdItemsTxt', 'SpcItemsTxt', 'ItemsTxt', 'ScrollTxt',
	},
	{ Name = 'GameNPC',
		'NPCDataTxt', 'NPCNews', 'NPCProfTxt', 'NPCGreet', 'NPCTopic', 'NPCText',
	},
	{ Name = 'GameRoster', Start = GameLocalizationStartRoster,
		'roster',
	},
}

local GameLocalizationParams = {
	-- Unused
	GlobalTxt = {false, 'global', 'Global.txt', {}},  -- requires changing ClassNames, SkillNames, StatsNames, ...
	ClassDescriptions = {false, 'class_desc', 'Class.txt (Description),', Inc = 'Class.txt'},
	SkillDescriptions = {false, 'skill_desc', 'SkillDes.txt (Description),', Inc = 'SkillDes.txt'},
	SkillDesNormal = {false, 'skill_normal', 'SkillDes.txt (Normal),', Inc = 'SkillDes.txt'},
	SkillDesExpert = {false, 'skill_expert', 'SkillDes.txt (Expert),', Inc = 'SkillDes.txt'},
	SkillDesMaster = {false, 'skill_master', 'SkillDes.txt (Master),', Inc = 'SkillDes.txt'},
	SkillDesGM = {false, 'skill_gm', 'SkillDes.txt (Grand Master),', Inc = 'SkillDes.txt'},
	StatsDescriptions = {false, 'stat_desc', 'Stats.txt (Description),', Inc = 'Stats.txt'},
	MerchantTxt = {false, 'merchant', 'Merchant.txt'},
	-- Game
	MonstersTxt = {{'Name'}, 'monster', 'Monsters.txt', {[''] = true, ['0'] = true}},
	PlaceMonTxt = {false, 'place_mon', 'PlaceMon.txt', {[''] = true, ['0'] = true}},
	SpellsTxt = {{'Name', 'ShortName', 'Description', 'Normal', 'Expert', 'Master', is78 and 'GM'}, 'spell', 'Spells.txt'},
	-- GamePlaces
	MapStats = {{'Name'}, 'map', 'MapStats.txt'},
	Houses = {{'Name', 'OwnerName', 'OwnerTitle', 'EnterText'}, 'house', '2DEvents.txt'},
	TransTxt = {false, 'enter', 'Trans.txt'},
	-- GameNotes
	AutonoteTxt = {false, 'note', 'Autonote.txt'},
	AwardsTxt = {false, 'award', 'Awards.txt'},
	HistoryTxt = {{'Text', 'Title'}, 'history', 'History.txt'},
	QuestsTxt = {false, 'quest', 'Quests.txt', {[''] = true, ['0'] = true}},
	-- GameItems
	StdItemsTxt = {{'NameAdd', 'BonusStat'}, 'enchant', 'StdItems.txt'},
	SpcItemsTxt = {{'NameAdd', 'BonusStat'}, 'enchant2', 'SpcItems.txt'},
	ItemsTxt = {{'Name', 'NotIdentifiedName', 'Notes'}, 'item', 'Items.txt', false, {[0] = true}},
	ScrollTxt = {false, 'scroll', 'Scroll.txt'},
	-- GameNPC
	NPCDataTxt = {{'Name'}, 'npc', 'NPCData.txt'},
	NPCNews = {is6 and {'Topic', 'Text'}, 'news', 'NPCNews.txt'},
	NPCProfTxt = {is6 and {'Benefit', 'JoinText', 'ProfNewsTopic', 'ProfNewsText'} or {'Benefit', 'JoinText', 'DismissText', 'ActionText'}, 'prof', 'NPCProf.txt, ProfText.txt', false, {[0] = true}},
	NPCGreet = {false, 'greet', 'NPCGreet.txt', false, {[0] = true}},
	NPCTopic = {false, 'topic', 'NPCTopic.txt'},
	NPCText = {false, 'text', 'NPCText.txt'},
	NPCNames = {false, 'names', 'npcnames.txt'},  -- need to set NPCNamesCount accordingly
	-- GameRoster
	roster = {Inc = 'Roster.txt', Check = is8},
	pcnames = {Inc = 'PCNames.txt', Check = is8},
}

local function GameTableStart(t, comment)
	t[#t+1] = '-----------------------------------------------------'
	t[#t+1] = '-- '..comment
	t[#t+1] = '-----------------------------------------------------'
end

local function GameTableIterate(t, arr, fields, short, skip, skipEx)
	skip = skip or {[''] = true}
	skipEx = skipEx or {}
	local dot = fields and '.' or ''
	local function add(k, field, v)
		if (skipEx[field] or skip)[v] then
			-- skip
		elseif type(v) == 'table' then
			t[#t+1] = ('copy(%s[%s]%s%s, %s)'):format(short, k, dot, field or '', dump(v, nil, true))
			t.copy = true
		else
			local multi = v:find('\n', 1, true)
			local std = not multi and not v:find('"', 1, true) or v:find(']]', 1, true) or v:find('[%z\1-\8\11-\31]') or v:sub(-1) == ']'
			local vfmt = std and '%q' or multi and '[[\n%s]]' or '[[%s]]'
			t[#t+1] = ('%s[%s]%s%s = '..vfmt):format(short, k, dot, field or '', v)
		end
	end
	for k, a in arr do
		if skipEx[k] then
			-- skip
		elseif fields then
			for _, field in ipairs(fields) do
				add(k, field, a[field])
			end
		else
			add(k, nil, a)
		end
	end
	t[#t+1] = ''
end

-- Generates localization files for various game data found in TXT files. Returns(in text form) the list of files not included in the generated localization.
function GenerateGameLocalization()
	local inc = {}
	local t
	
	local function Process(name, fields, short, comment, ...)
		if not Game[name] then
			return
		elseif comment then
			GameTableStart(t, comment)
		end
		t[#t+1] = ('local %s = Game.%s'):format(short, name)
		GameTableIterate(t, Game[name], fields, short, ...)
	end
	
	local function ProcessRoster(name, fields, short, comment, ...)
		if not is8 then
			return
		elseif not t.RosterLoaded and Game.MainMenuCode >= 0 and Game.MainMenuCode ~= 6 then
			call(0x4949BD, 1, Party.ptr)
			t.RosterLoaded = true
		end
		GameTableStart(t, 'roster.txt')
		t[#t+1] = 'local players = Party.PlayersArray'
		t[#t+1] = ('players[0].Biography = %q'):format(Party.PlayersArray[0].Biography)
		GameTableIterate(t, Party.PlayersArray, {'Name', 'Biography'}, 'players', nil, {[0] = true})
	end
	
	for _, list in ipairs(GameLocalizationSchema) do
		t = {Name = assert(list.Name), Start = list.Start or GameLocalizationStart}
		for _, s in ipairs(list) do
			local ignore, par = GameLocalizationIgnore[s], GameLocalizationParams[s]
			if ignore then
				inc[s] = ignore == 'skip'
			elseif s == 'roster' then
				inc[s] = true
				ProcessRoster()
			elseif s == 'pcnames' then
				assert(false)
			elseif par then
				inc[s] = true
				Process(s, unpack(par))
				if s == 'NPCProfTxt' and is67 and Game.NPCProfNames['?ptr'] ~= mmv(0x6BA85C, 0x73C110) then
					Process('NPCProfNames', nil, 'prof_name', 'NPCProf.txt (names)', nil, {[0] = true})
				end
			else
				s(t, inc)
			end
		end
		if t and t[1] then
			if t.copy then
				table.insert(t, 1, 'local copy = |a, b| table.copy(b, a, true)\n')
			end
			SaveWithBak(AppPath.."Scripts/Localization/"..t.Name..".lua", t.Start..table.concat(t, "\n"))
		end
	end
	
	local missing = {}
	
	for s, par in pairs(GameLocalizationParams) do
		if not inc[s] and (par.Check or Game[s]) then
			missing[par.Inc or par[3]] = true
		end
	end
	
	local miss = {}
	for s in sortpairs(missing) do
		miss[#miss + 1] = s
	end
	
	return "Not included: "..table.concat(miss, ', ')
end

-----------------------------------------------------
-- Quests/Awards/Autonotes effect
-----------------------------------------------------

local DummyText = mmv(0x4C1728, 0x4EB6E8, 0x4FB700)

local function ShowEffect(a, vn, p, id, f, book, got)
	local old, olds, oldb = a[id], u4[p], book and mmver == 7 and not Game[book]
	a[id], u4[p] = got, DummyText  -- need a named quest for the effect
	f(vn, id)
	a[id], u4[p] = old, olds
	if oldb then
		Game[book] = false
	end
end

-- Plays sound and shows visual effect on current character's face.
-- If 'flash_book' is 'true', the quest book will start flashing.
function ShowQuestEffect(flash_book, operation)
	local a, id = Game.QuestsTxt, 499
	local p = a['?ptr'] + (id - a.low)*4
	ShowEffect(Party.QBits, "QBits", p, id, evt[operation or TakeQuestOperation or 'Add'], not flash_book and 'FlashQuestBook')
end

-- Plays sound and shows visual effect on all characters' faces.
-- 'exclude' can be a function(player:structs.Player, slot) that returns 'true' if the character should be excluded from the effect.
function ShowAwardEffect(exclude, operation)
	local a, id = Game.AwardsTxt, 1
	local p = a['?ptr'] + (id - a.low)*mmv(4, 8, 8)
	for i, pl in Party do
		if not exclude or not exclude(pl, i) then
			ShowEffect(pl.Awards, "Awards", p, id, evt[i][operation or 'Add'])
		end
	end
end

-- Plays sound and shows visual effect on current character's face
function ShowAutonoteEffect(category, just_sound, operation)
	local a, id = Game.AutonoteTxt, 1
	local p = a['?ptr'] + (id - a.low)*mmv(4, 8, 8)
	local logic = Game.DialogLogic
	local cat = category or logic.AutonotesCategory
	ShowEffect(Party.AutonotesBits, "AutonotesBits", p, id, evt[operation or 'Add'], not category and 'FlashAutonotesBook', just_sound)
	logic.AutonotesCategory = cat
end

-----------------------------------------------------
-- Auto Quests/Awards/Autonotes entries
-----------------------------------------------------

local AutoQuests, AutoAwards, AutoAutonotes

local function AutoIndex(array, ev, f)
	local idx, n, Q = {}, 0, {}
	function events.LeaveGame()
		n = 0
		Q = {}
	end
	events[ev] = |...| do
		local a = Game.DialogLogic.List
		for _, q in ipairs(Q) do
			local v = f(q, ...)
			if v then
				local i = a.high + 1
				a.high = i
				a[i] = v
			end
		end
	end
	local function new_idx()
		local i = array.high + 1
		array.SetHigh(i)
		idx[n] = i
		return i
	end
	return function(t)
		n = n + 1
		Q[n] = t
		return idx[n] or new_idx()
	end
end

local AutoQuestEffect = |t| if not t:IsQuestVisible() then
	ShowQuestEffect(true, t.TakeQuestOperation)
end

-- 't' can be a function(t), which returns 'true' if quest should be visible in the quest log
function AutoQuest(t, text)
	AutoQuests = AutoQuests or AutoIndex(Game.QuestsTxt, 'PopulateQuestLog', |q| q:IsQuestVisible() and q.QuestIndex)
	if type(t) == 'function' then
		t = {IsQuestVisible = t}
	end
	local i = AutoQuests(t)
	t.QuestIndex = i
	t.ShowQuestEffect = t.ShowQuestEffect or AutoQuestEffect
	if text then
		Game.QuestsTxt[i] = text
	end
	return t, i
end

local function AutoAwardEffect(t)
	ShowAwardEffect(|pl| t:IsAwarded(pl:GetIndex(), pl), t.TakeAwardOperation)
end

-- 't' can be a function(t, player_index, player:structs.Player), which returns 'true' if award should be visible on the Awards page
function AutoAward(t, text, sort)
	AutoAwards = AutoAwards or AutoIndex(Game.AwardsTxt, 'PopulateAwardsList', |q, t| q:IsAwarded(t.PlayerIndex, t.Player) and q.AwardIndex)
	if type(t) == 'function' then
		t = {IsAwarded = t}
	end
	local i = AutoAwards(t)
	t.AwardIndex = i
	t.ShowAwardEffect = t.ShowAwardEffect or AutoAwardEffect
	Game.AwardsSort[i] = sort or t.AwardSort or 3
	if text then
		Game.AwardsTxt[i] = text
	end
	return t, i
end

local GetAutonoteCat = |t| is6 and (t.Category or 1) or Game.AutonoteCategory[t.AutonoteIndex]
local function AutoAutonoteEffect(t)
	local cat = GetAutonoteCat(t)
	ShowAutonoteEffect(cat, t:IsAutonoteVisible(), t.TakeAutonoteOperation)
end

-- 't' can be a function(t), which returns 'true' if autonote should be visible
function AutoAutonote(t, text, category)
	AutoAutonotes = AutoAutonotes or AutoIndex(Game.AutonoteTxt, 'PopulateAutonotesList', 
		|q, t| t.Category == GetAutonoteCat(q) and q:IsAutonoteVisible() and q.AutonoteIndex
	)
	if type(t) == 'function' then
		t = {IsAutonoteVisible = t}
	end
	local i = AutoAutonotes(t)
	t.AutonoteIndex = i
	t.ShowAutonoteEffect = t.ShowAutonoteEffect or AutoAutonoteEffect
	if is6 then
		t.Category = category or t.Category or 1
	else
		Game.AutonoteCategory[i] = category or t.Category or 1
	end
	if text then
		Game.AutonoteTxt[i] = text
	end
	return t, i
end

-----------------------------------------------------
-- Autonote
-----------------------------------------------------

local RegNotes = {}
local ClearRegNotes = || RegNotes = {}

local function RegisterAutonote(t)
	if ClearRegNotes then
		events.LeaveGame, ClearRegNotes = ClearRegNotes, nil
	end
	local name = t.Name
	assert(not RegNotes[name], 'autonote with this name already exists')
	RegNotes[name] = t
	t.Text = LocalizeAll.Autonotes{[name] = t.Text}[name]
end

local function DoFindAutonote(name, must)
	return RegNotes[name] or must and error('autonote "'..name..'" not found') or nil
end

local AutonoteProto = {
	IsAutonoteVisible = |t| vars.Autonotes[t.Name],
	AddAutonote = function(t, force)
		t:ShowAutonoteEffect()
		vars.Autonotes[t.Name] = true
	end,
}

function GetLocalName(name, lev)
	name = name..''
	if name:find(':', 1, true) then
		return name
	end
	local s = path.GetRelativePath(AppPath.."Scripts", debug.FunctionFile((lev or 1) + 1)):lower()
	s = path.setext(s, '')
	if path.ext(s) == '.global' then
		s = path.setext(s, '')
	end
	return s:lower()..':'..name
end

-- Creates a named autonote. To operate on global named autonotes, use ":" at the beginning of its name.
function Autonote(name, cat, text)
	local t = {
		Name = GetLocalName(name, 2),
		Category = cat,
		Text = text
	}
	vars.Autonotes = vars.Autonotes or {}
	table.copy(AutonoteProto, t, true)
	RegisterAutonote(t)
	AutoAutonote(t, t.Text)
	return t
end

-- Adds a named autonote to Auto Notes. 'force' = 'true' makes it emit the sound even if autonote is already added
function AddAutonote(name, force)
	local t = DoFindAutonote(GetLocalName(name, 2), true)
	if force or not t:IsAutonoteVisible() then
		t:AddAutonote()
	end
end

-- Returns 'true' if named autonote was added to Auto Notes
function CheckAutonote(name)
	return DoFindAutonote(GetLocalName(name, 2), true):IsAutonoteVisible()
end

function FindAutonote(name, must)
	return DoFindAutonote(GetLocalName(name, 2), must)
end

-----------------------------------------------------
-- Quest
-----------------------------------------------------

local function RegisterQuest(t)
	local RegQuests = {}
	local LastSlot = {}
	local CurrentNPC, HiredNPC
	local CurrentQuests
	local FreeEvents
	local BackupTopics = {}
	local BackupNPC = {}
	local CurrentBranch = ""
	local BranchStack = {}
	local sgd = internal.SaveGameData
	local QuestBranches = tget(sgd, "QuestBranches")
	if mmver == 6 then
		FreeEvents = {[0] = 498, 499, 500}
	elseif mmver == 7 then
		FreeEvents = {[0] = 784, 785, 786, 787, 788, 789}
	else
		FreeEvents = {[0] = 995, 996, 997, 998, 999, 1000}
	end

	local function FindCurrentQuest(npc, i)
		local t = RegQuests[npc*7 + i]
		while t and (t.Branch and t.Branch ~= CurrentBranch or t.CanShow and not t:CanShow()) do
			t = t.LastQuest
		end
		return t
	end
	
	local function UpdateCurrentQuests(npc)
		CurrentQuests = {}
		local ev = Game.NPC[npc].Events
		for i = 0, 5 do
			local t = FindCurrentQuest(-1, i) or FindCurrentQuest(npc, i)
			if t then
				local topic = t:GetTopic()
				if topic then
					BackupNPC[i] = BackupNPC[i] or ev[i]
					if type(topic) == "number" then
						ev[i] = topic
					else
						local k = FreeEvents[i]
						ev[i] = k
						BackupTopics[k] = BackupTopics[k] or Game.NPCTopic[k]
						Game.NPCTopic[k] = topic
						CurrentQuests[k] = t
					end
				else
					BackupNPC[i] = BackupNPC[i] or ev[i]
					ev[i] = 0
				end
			elseif BackupNPC[i] then
				Game.NPC[npc].Events[i] = BackupNPC[i]
				BackupNPC[i] = nil
			end
		end
	end
	
	local function CheckHiredNPC()
		return HiredNPC and HiredNPC.Exist
	end
	
	local function DoRestoreBackupNPC(npc)
		for i, s in pairs(BackupNPC) do
			npc.Events[i] = s
		end
	end
	
	local function RestoreBackupNPC()
		if CurrentNPC then
			DoRestoreBackupNPC(Game.NPC[CurrentNPC])
		end
		if CheckHiredNPC() then
			DoRestoreBackupNPC(HiredNPC)
		end
		BackupNPC = {}
	end
	
	function UpdateNPCQuests()
		if not CurrentNPC then
			return
		end
		local old = CurrentQuests
		UpdateCurrentQuests(CurrentNPC)
		for k, v in pairs(table.copy(old, table.copy(CurrentQuests))) do
			if old[k] == nil or CurrentQuests[k] == nil then
				Game.UpdateDialogTopics()
				return
			end
		end
	end
	
	function events.ShowNPCTopics(npc)
		--!v
		QuestNPC = npc
		UpdateCurrentQuests(npc)
	end
	
	events.ShowHiredNPCTopics = |i, npc| if npc then
		if CheckHiredNPC() then
			DoRestoreBackupNPC(HiredNPC)
		else
			CurrentBranch = QuestBranches[npc] or ""
		end
		QuestNPC, CurrentNPC, HiredNPC = npc, npc, Party.HiredNPC[i]
		UpdateCurrentQuests(npc)
		-- copy events if they were assigned
		for i, v in pairs(BackupNPC) do
			HiredNPC.Events[i] = Game.NPC[CurrentNPC].Events[i]
		end
	end

	function events.EvtGlobal(evtId, seq)
		QuestNPC = CurrentNPC
		local t = CurrentNPC and CurrentQuests and CurrentQuests[evtId]
		if t then
			cocall2(t.Execute, t)
			UpdateNPCQuests()
		end
	end
	
	function events.DrawNPCGreeting(ev)
		QuestNPC = ev.NPC
		local seen = not not tget(internal.SaveGameData, "SeenNPC")[ev.NPC]
		local s, s1
		for i = 5, -1, -1 do
			local t = FindCurrentQuest(ev.NPC, i)
			if t then
				s = s or t:GetGreeting(seen)
				if s then
					break
				elseif not seen then
					s1 = s1 or t:GetGreeting(true)
				end
			end
		end
		ev.Text = s or s1 or ev.Text
	end

	function events.EnterNPC(npc)
		CurrentNPC = npc
		CurrentBranch = QuestBranches[npc] or ""
	end
	
	local ClearQuestBranches = || for i = 1, #BranchStack do
		BranchStack[i] = nil
	end

	events.ExitAnyNPC = |npc| if CurrentNPC then
		CurrentBranch = ""
		ClearQuestBranches()
		for k, s in pairs(BackupTopics) do
			Game.NPCTopic[k] = BackupTopics[k]
		end
		BackupTopics = {}
		RestoreBackupNPC()
		tget(internal.SaveGameData, "SeenNPC")[CurrentNPC] = true
		CurrentNPC, HiredNPC = nil, nil
	end
	
	events.PopulateNPCDialog = |t| if t.DlgKind == "JoinMenu" then
		RestoreBackupNPC()  -- need to initialize the hired NPC with a clean set of topics
	end
	
	-- Sets current dialog branch to 'branch' if it's specified.
	-- 'persist' parameter makes the branch persist after you reenter NPC dialog.
	-- Returns current branch when called without parameters.
	-- If there is no persisted branch name, when you enter NPC dialog the branch is set to "".
	function QuestBranch(branch, persist)
		if not branch then
			return CurrentBranch
		end
		CurrentBranch = branch
		if persist then
			QuestBranches[GetCurrentNPC()] = branch
		end
	end
	
	-- Switches dialog branch to 'branch', but returns to current branch upon pressing Esc.
	function QuestBranchScreen(branch)
		BranchStack[#BranchStack + 1] = CurrentBranch
		CurrentBranch = branch or ""
	end
	
	-- Exits current branch opened with #QuestBranchScreen:#. If no branch screens are left open, simulates Esc press to exit the dialog.
	function ExitQuestBranch(all)
		if all then
			CurrentBranch = BranchStack[1]
			ClearQuestBranches()
		elseif BranchStack[1] then
			CurrentBranch = BranchStack[#BranchStack]
			BranchStack[#BranchStack] = nil
			return #BranchStack
		else
			ExitScreen()
		end
	end

	-- Returns a table with branch names stored by #QuestBranchScreen:# function (on each call it adds previous branch to the end of this table).
	function GetQuestBranchStack()
		return BranchStack
	end

	local CanExitNPC = |t| if t.Allow and BranchStack[1] and Game.NPC[CurrentNPC].Hired ~= not HiredNPC then
		t.Allow = false
		ExitQuestBranch()
	end
	events.CanExitNPC = CanExitNPC
	events.CanExitHiredNPC = CanExitNPC
	
	function events.LeaveGame()
		Quests = {}
		RegQuests = {}
		CurrentNPC, HiredNPC = nil, nil
		ExitQuestBranch(true)
	end
	
	function GenerateQuestsLocalization(IsLua)
		os.mkdir(AppPath.."Scripts/Localization")
		local str = (IsLua and {} or {"Key=\tValue$=", "Quests{\t"})
		local npcs = {}
		local function AddQuest(t, npc)
			while t and not next(t.Texts) do
				t = t.LastQuest
			end
			if not t then
				return
			elseif npc and not npcs[npc] then
				npcs[npc] = true
				local s = ("-"):rep(80)
				local info = npc >= 0 and Game.NPC[npc].Name or 'any NPC'
				if IsLua then
					str[#str+1] = ("%s\n-- (%s) %s\n%s\n"):format(s, npc, info, s)
				else
					str[#str+1] = ("\r\n(%s) %s -\t%s\r\n"):format(npc, info, s)
				end
			end
			AddQuest(t.LastQuest)
			if IsLua then
				str[#str+1] = ("LocalizeAll.Quests[%q] = %s\n"):format(t.Name, dump(SanitizeLoc(t.Texts), nil, true))
			else
				str[#str+1] = ("[%q]{\t"):format(t.Name)
				for k, v in sortpairs(SanitizeLoc(t.Texts)) do
					str[#str+1] = LocalizationTableStr(k, v)
				end
				str[#str+1] = "}\t"
			end
		end
		
		local n, m = -1/0, 1/0
		for i in pairs(RegQuests) do
			n = max(n, i)
			m = min(m, i)
		end
		for i = m, n do
			AddQuest(RegQuests[i], (i + 1):div(7))
		end
		str = table.concat(str, IsLua and "\n" or "\r\n")
		SaveWithBak(AppPath.."Scripts/Localization/Quests"..(IsLua and ".lua" or ".txt"), str)
	end
	
	function RegisterQuest(t)
		if not t.Slot then
			for i = 0, mmv(2, 5, 5) do
				if not RegQuests[t.NPC*7 + i] then
					t.Slot = i
					break
				end
			end
		elseif t.Slot == "same" or t.Slot == "Same" then
			t.Slot = LastSlot[t.NPC] or 0
		end
		assert(t.Slot and t.Slot >= -1 and t.Slot < mmv(3, 6, 6), "invalid slot number")
		LastSlot[t.NPC] = t.Slot
		t.LastQuest = RegQuests[t.NPC*7 + t.Slot]
		RegQuests[t.NPC*7 + t.Slot] = t
	end
	return RegisterQuest(t)
end

local function MyAutoQuest(t)
	-- remove QBits of old version of automatic quests
	if not internal.SaveGameData.NewQuests then
		internal.SaveGameData.NewQuests = 1
		for i, s in Game.QuestsTxt do
			if s == "0" then
				Party.QBits[i] = false
			end
		end
	end
	return AutoQuest(t)
end

local SlotLiterals = {A = 0, B = 1, C = 2, D = 3, E = 4, F = 5}

local QuestProto = {
	IsGiven = |t| vars.Quests[t.BaseName] == t.GivenState,
	IsQuestVisible = |t| t:IsGiven(),
	
	IsAwarded = function(t, idx, pl)
		if not t.StoreAwards then
			return vars.Quests[t.BaseName] == t.DoneState  -- no need to keep track of players that reeceived it
		end
		local a = vars.QuestAwards
		a = a and a[t.BaseName]
		return a and a[idx]
	end,
	
	IsAutonoteVisible = function(t)
		return vars.QuestAutonotes[t.BaseName]
	end,
	
	GetGreeting = function(t, seen)
		if not seen then
			return t.Texts.FirstGreet
		end
		local topic = t.Texts["Greet"..(vars.Quests[t.BaseName] or "")]
		if topic then
			return topic
		elseif topic == nil then
			return t.Texts.Greet
		end
	end,
	
	AddQuestBit = function(t)
		if tonumber(t.Quest) and t.TakeQuestOperation then
			evt[t.TakeQuestOperation]("QBits", t.Quest)
		elseif t.QuestIndex and t.TakeQuestOperation then
			t:ShowQuestEffect()
		end
	end,
	
	AddAward = function(t)
		if tonumber(t.Award) then
			evt.All.Add("Awards", t.Award)
		elseif t.AwardIndex then
			t:ShowAwardEffect()
			if t.StoreAwards then
				local aw = tget(vars.QuestAwards, t.BaseName)
				for _, pl in Party do
					aw[pl:GetIndex()] = true
				end
			end
		end
	end,

	AddAutonote = function(t, force)
		if tonumber(t.Autonote) then
			if force or not evt.Cmp("AutonotesBits", t.Autonote) then
				evt.Add("AutonotesBits", t.Autonote)
			end
		elseif t.AutonoteIndex and (force or not vars.QuestAutonotes[t.BaseName]) then
			t:ShowAutonoteEffect()
			vars.QuestAutonotes[t.BaseName] = true
		end
	end,
}

--!a{name}k{Give,Ungive,Done,Undone,After,StdTopicGiven,StdTopicDone,IsGiven,IsAwarded,GetGreeting} See #quest examples:Quests#
function Quest(t)
	table.copy(QuestProto, t)
	t.Name = t.Name or t[1]
	if Quests[t.Name] then
		error(("Quest called %q already exists"):format(t.Name), 2)
	end
	t.NPC = t.NPC or QuestNPC
	t.Slot = t.Slot or t.Event
	t.Slot = SlotLiterals[t.Slot] or t.Slot
	RegisterQuest(t)  -- assign free slot automatically is it's nil
	if not t.Name then
		t.Name = ("NPC = %d, %sSlot = %s"):format(t.NPC, t.Branch and "Branch = '"..t.Branch.."', " or "", t.Slot)
		while Quests[t.Name] do
			t.Name = t.Name.." +"
		end
	end
	t.Award = t.Award or t.Awards  -- backward compatibility
	Quests[t.Name] = t
	--!++(vars.Quests)v([name])
	-- Quest states: nil, "Given", "Done" or a custom state.
	
	--!v([name])
	vars.QuestAwards = vars.QuestAwards or {}
	--!v([name])
	vars.QuestAutonotes = vars.QuestAutonotes or {}
	t.BaseName = t.BaseName or t.Name
	t.GivenState = t.GivenState or "Given"
	t.DoneState = t.DoneState or "Done"

	t.QuestIndex = t.Quest or nil
	if t.Quest == true then
		MyAutoQuest(t)
	end
	
	t.AwardIndex = t.Award or nil

	t.SetTexts = t.SetTexts or function(t1, texts)
		t.Texts = LocalizeAll.Quests[t.Name](texts or t1)
		if t.Texts.Quest and t.Quest ~= false then
			if not t.QuestIndex then
				t.Quest = true  -- backward compatibility
				MyAutoQuest(t)
			end
			Game.QuestsTxt[t.QuestIndex] = t.Texts.Quest
		end
		if t.Texts.Award and t.Award ~= false then
			if not t.AwardIndex then
				AutoAward(t)
			end
			Game.AwardsTxt[t.AwardIndex] = t.Texts.Award
		end
		return t
	end
	LocalizeAll.Quests[t.Name]({}, "update")
	t:SetTexts(t.Texts or {})
	if t.StoreAwards == nil then
		t.StoreAwards = mmver == 8 or t.NeverDone
	end

	t.TakeQuestOperation = t.TakeQuestOperation or TakeQuestOperation or "Add"

	if t.Slot < 0 then
		return
	end
	
	t.GetTopic = t.GetTopic or function(t)
		--!ParentLocal(t=t)
		local s = vars.Quests[t.BaseName] or ""
		local topic
		if s == "" then
			topic = t.FirstStdTopic or t.Texts.FirstTopic
		else
			topic = t["StdTopic"..s] or t.Texts["Topic"..s]
		end
		if topic == nil then
			return t.StdTopic or t.Texts.Topic
		end
		return topic
	end
	
	t.Execute = t.Execute or function(t)
		--!ParentLocal(t=t)
		local state = vars.Quests[t.BaseName]
		local ev
		if state == nil and not t.NeverGiven then
			if (t.CheckGive == nil and (t.Give or t.Texts.Give or t.QuestIndex)) or t.CheckGive and t.CheckGive(t) then
				t:AddQuestBit(t)
				vars.Quests[t.BaseName] = t.GivenState
				if t.GivenItem then
					evt.Add("Inventory", t.GivenItem)
				end
				ev = "Give"
			else
				ev = "Ungive"
			end
		elseif state == nil or t:IsGiven() then
			if ((t.CheckDone == nil) or t.CheckDone and t.CheckDone(t)) and
					Party.Gold >= (t.QuestGold or 0) and
					(t.QuestItem == nil or TakeItemFromParty(t.QuestItem, t.KeepQuestItem)) then
				AddGoldExp((t.Gold or 0) - (t.QuestGold or 0), t.Experience or t.Exp)
				t:AddAward(t)
				if t.RewardItem then
					evt.Current.Add("Inventory", t.RewardItem)
				end
				if not t.NeverDone then
					if tonumber(t.Quest) then
						evt.Sub("QBits", t.Quest)
					end
					vars.Quests[t.BaseName] = t.DoneState
				end
				ev = "Done"
			else
				ev = "Undone"
			end
		elseif state == t.DoneState then
			ev = "After"
		else
			ev = state
		end
		if not t.CanAddAutonote or t:CanAddAutonote() then
			t:AddAutonote()
		end
		if t.Texts[ev] then
			SimpleMessage(t.Texts[ev])
		end
		if t[ev] then
			t[ev](t)
		end
	end
	
	return t
end

--[[!({text, textSeen;
  Text
  TextSeen
  ... Quest() parameters ...
}) See #quest examples:Quests#]]
function Greeting(t)
	t.Slot = t.Slot or -1
	local greet1 = t[1] or t.Text
	local texts = t.Texts or {}
	t.Texts = texts
	texts.FirstGreet = greet1 or texts.FirstGreet
	texts.Greet = t[2] or t.TextSeen or greet1 or texts.Greet
	t[1], t[2], t.Text, t.TextSeen = nil
	return Quest(t)
end

--[[!({topic, text;
  Topic
  Text
  ... Quest() parameters ...
}) See #quest examples:Quests#]]
function NPCTopic(t)
	local topic = t[1] or t.Topic
	if type(topic) == "number" then
		t.StdTopic = topic
	else
		local texts = t.Texts or {}
		t.Texts = texts
		texts.Topic = topic or texts.Topic
		texts.Ungive = t[2] or t.Text or texts.Ungive
	end
	t[1], t[2], t.Topic, t.Text = nil
	return Quest(t)
end

-----------------------------------------------------
-- KillMonstersQuest
-----------------------------------------------------

--[[!({name = nil, ... A list of either tables with CheckMonstersKilled() parameters or partial completion messages ...;
	... Quest() parameters ...
}) See !'[=[Quest Kill Monsters.lua]=] from #quest examples:Quests#]]
function KillMonstersQuest(t)
	local Interval, SleepDelay = const.Minute*3, const.Minute*2.5
	local sgd = internal.SaveGameData
	local done = sgd.KillMonsterTasksDone or {}
	sgd.KillMonsterTasksDone = done
	local tasks, taskRange = {}, {}
	local CurMap, CurTasks, RefillDays, MaySleep

	-- make tasks
	t.Texts = t.Texts or {}
	for i, task in ipairs(t) do
		if type(task) == "table" then
			tasks[#tasks + 1] = task
			task.Map = task.Map:lower()
			t[i] = nil
		elseif next(tasks) then
			taskRange[#taskRange + 1] = #tasks
			if type(task) == "string" then
				t.Texts["Killed"..#taskRange] = task
			end
			t[i] = nil
		end
	end

	-- Quest
	local function CheckTask(task)
		return (done[task.TaskId] or 0) > Game.Time or task.Map == CurMap and CheckMonstersKilled(task)
	end
	
	function t:CheckKilled(i)
		local a = tasks[i]
		return a and CheckTask(a)
	end
	
	local CheckDone = t.CheckDone
	function t.CheckDone(t)
		for _, task in ipairs(tasks) do
			if not CheckTask(task) then
				return
			end
		end
		return not CheckDone or CheckDone(t)
	end
	if t.Quest == nil then
		t.Quest = true
	end
	Quest(t)

	-- set task ids
	for i, task in ipairs(tasks) do
		task.TaskId = ("%s,%s"):format(i, t.Name)
	end
	
	-- map events
	local function CheckTaskRange(i1, i2)
		local found
		for i = i1, i2 do
			local task = tasks[i]
			found = found or CurTasks[task]
			if not done[task.TaskId] then
				return
			end
		end
		return found
	end
	
	local function ShowKilledMessage(msg)
		if MaySleep then
			Sleep(SleepDelay)
		end
		Game.ShowStatusText(msg)
		ShowQuestEffect(false, 'Add')
	end
	
	local function UpdateTasksState()
		local state = vars.Quests[t.BaseName]
		if state == t.DoneState or not next(CurTasks) then
			return
		end
		local pl = evt.Player
		evt.Player = 0
		-- update tasks
		for task in pairs(CurTasks) do
			if CheckMonstersKilled(task) then
				done[task.TaskId] = (state == t.GivenState and 1/0 or (Map.LastRefillDay + RefillDays)*const.Day)
			else
				done[task.TaskId] = nil
			end
		end
		
		if state == t.GivenState then
			-- show 'killed' message
			if t.Texts.Killed and CheckTaskRange(1, #tasks) then
				ShowKilledMessage(t.Texts.Killed)
			else
				local m = 1
				for i, n in ipairs(taskRange) do
					if CheckTaskRange(m, n) then
						ShowKilledMessage(t.Texts["Killed"..i])
						break
					end
					m = n + 1
				end
			end
			-- remove finished tasks from watched list
			for task in pairs(CurTasks) do
				if done[task.TaskId] then
					CurTasks[task] = nil
				end
			end
		end
		evt.Player = pl
	end
	
	local function OnLoadMap(_, NoScripts)
		CurMap = Map.Name:lower()
		CurTasks = {}
		MaySleep = true
		local _, a = Game.MapStats.Find(CurMap)
		RefillDays = a and a.RefillDays or 1/0
		
		local state = vars.Quests[t.BaseName]
		if state == t.DoneState or NoScripts then
			return
		end
		for _, task in ipairs(tasks) do
			if task.Map == CurMap and (not state or (done[task.TaskId] or 0) < Game.Time) then
				CurTasks[task] = true
			end
		end
		if next(CurTasks) then
			Timer(UpdateTasksState, Interval, true)
		end
	end
	
	local function OnLeaveMap()
		MaySleep = false
		UpdateTasksState()
	end
	
	events.LoadMap = OnLoadMap
	events.LeaveMap = OnLeaveMap
	
	function events.LeaveGame()
		events.Remove("LoadMap", OnLoadMap)
		events.Remove("LeaveMap", OnLeaveMap)
		events.Remove("LeaveGame", 1)
	end
		
	return t
end

-----------------------------------------------------
-- QCheck
-----------------------------------------------------

-- Mostly for backward compatibility.
-- A function to show a topic only when the <name> quest is in <state> state.
-- <name> defaults to current quest name.
function QCheck(name, ...)
	local state = ...
	if select('#', ...) == 0 then
		name, state = nil, name
	end
	return |t| vars.Quests[name or t.BaseName] == state
end
