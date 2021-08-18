local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = Game.Version

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local TXT = {}
TXT.Quests = TXT.Quests or {}

--!v
-- Should be either "Add" or "Set". This determines the overlay flash on character face when a quest is taken.
-- [MM6, MM8] Defaults to "Add".
-- [MM7] Defaults to "Set".
TakeQuestOperation = (mmver == 7 and "Set" or "Add")
--!v
Quests = {}

local _KNOWNGLOBALS_F = QuestNPC, vars, LocalizeAll, curry

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

local function SaveWithBak(fname, s)
	for fname in path.find(fname) do
		local fbak = fname..'.bak'
		os.remove(fbak)
		os.rename(fname, fbak)
	end
	io.save(fname, s)
end

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
		lev = lev or 2
		if type(lev) == "number" then
			lev = lev + 1
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
		RunLocalizationInFile(f)
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
-- Quest
-----------------------------------------------------

local function RegisterQuest(t)
	local RegQuests = {}
	local LastSlot = {}
	local CurrentNPC
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
	
	function UpdateNPCQuests()
		if not CurrentNPC then
			return
		end
		local old = CurrentQuests
		UpdateCurrentQuests(CurrentNPC)
		for k, v in pairs(table.copy(old, table.copy(CurrentQuests))) do
			if old[k] == nil or CurrentQuests[k] == nil then
				Game.UpdateDialogTopics()
			end
		end
	end
	
	function events.ShowNPCTopics(npc)
		--!v
		QuestNPC = npc
		UpdateCurrentQuests(npc)
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

	function events.ExitNPC(npc)
		CurrentBranch = ""
		for k, s in pairs(BackupTopics) do
			Game.NPCTopic[k] = BackupTopics[k]
		end
		BackupTopics = {}
		for i, s in pairs(BackupNPC) do
			Game.NPC[CurrentNPC].Events[i] = s
		end
		BackupNPC = {}
		tget(internal.SaveGameData, "SeenNPC")[CurrentNPC] = true
		CurrentNPC = nil
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
	function ExitQuestBranch()
		if BranchStack[1] then
			CurrentBranch = BranchStack[#BranchStack]
			BranchStack[#BranchStack] = nil
		else
			Game.Actions.Add(113)
		end
	end

	-- Returns a table with branch names stored by #QuestBranchScreen:# function (on each call it adds previous branch to the end of this table).
	function GetQuestBranchStack()
		return BranchStack
	end

	function events.CanExitNPC(t)
		if BranchStack[1] then
			t.Allow = false
			ExitQuestBranch()
		end
	end
	
	function events.LeaveGame()
		Quests = {}
		RegQuests = {}
	end
	
	function GenerateQuestsLocalization(IsLua)
		os.mkdir(AppPath.."Scripts/Localization")
		local str = (IsLua and {} or {"Key=\tValue$=", "Quests{\t"})
		local npcs = {}
		local function AddQuest(t, npc)
			if not t then
				return
			elseif npc and not npcs[npc] then
				npcs[npc] = true
				local s = ("-"):rep(80)
				if IsLua then
					str[#str+1] = ("%s\n-- (%s) %s\n%s\n"):format(s, npc, Game.NPC[npc].Name, s)
				else
					str[#str+1] = ("\r\n(%s) %s -\t%s\r\n"):format(npc, Game.NPC[npc].Name, s)
				end
			end
			AddQuest(t.LastQuest)
			if next(t.Texts) and IsLua then
				str[#str+1] = ("LocalizeAll.Quests[%q] = %s\n"):format(t.Name, dump(SanitizeLoc(t.Texts), nil, true))
			elseif next(t.Texts) then
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

local AutoQuests, AutoAwards

function AddAutoQuest(t)
	if type(t) == 'function' then
		t = {IsGiven = t}
	end
	AutoQuests = AutoQuests or AutoIndex(Game.QuestsTxt, 'PopulateQuestLog', |q| q:IsGiven() and q.QuestIndex)
	t.QuestIndex = AutoQuests(t)
	return t.QuestIndex
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
	return AddAutoQuest(t)
end

function AddAutoAward(t)
	if type(t) == 'function' then
		t = {IsAwarded = t}
	end
	AutoAwards = AutoAwards or AutoIndex(Game.AwardsTxt, 'PopulateAwardsList', |q, t| q:IsAwarded(t) and q.AwardIndex)
	t.AwardIndex = AutoAwards(t)
	Game.AwardsSort[t.AwardIndex] = 3
	return t.AwardIndex
end

-- Plays sound and shows visual effect on current character's face
function ShowQuestEffect(flash_book, operation)
	local id = 499
	local p = Game.QuestsTxt['?ptr'] + (id - Game.QuestsTxt.low)*4
	local old, olds, oldb = Party.QBits[id], u4[p], mmver == 7 and not flash_book and not Game.FlashQuestBook
	Party.QBits[id], u4[p] = false, mmv(0x4C1728, 0x4EB6E8, 0x4FB700)  -- need a named quest for the effect
	evt[operation or TakeQuestOperation]("QBits", id)
	Party.QBits[id], u4[p] = old, olds
	if oldb then
		Game.FlashQuestBook = false
	end
end

-- Plays sound and shows visual effect on all characters' faces
function ShowAwardEffect(operation)
	local id = 1
	local p = Game.AwardsTxt['?ptr'] + (id - Game.AwardsTxt.low)*mmv(4, 8, 8)
	local t = {}
	for _, a in Party do
		t[a] = a.Awards[id]
		a.Awards[id] = false
	end
	local olds = u4[p]
	u4[p] = mmv(0x4C1728, 0x4EB6E8, 0x4FB700)  -- need a named award for the effect
	evt.All[operation or 'Add']("Awards", id)
	u4[p] = olds
	for _, a in Party do
		a.Awards[id] = t[a]
	end
end

local function AddQuestBit(t)
	if tonumber(t.Quest) and t.TakeQuestOperation then
		evt[t.TakeQuestOperation]("QBits", t.Quest)
	elseif t.QuestIndex and t.TakeQuestOperation then
		ShowQuestEffect(true, t.TakeQuestOperation)
	end
end

local function AddQuestAward(t)
	if tonumber(t.Award) then
		evt.All.Add("Awards", t.Award)
	elseif t.AwardIndex then
		ShowAwardEffect()
		if t.StoreAwards then
			local aw = tget(tget(vars, 'QuestAwards'), t.BaseName)
			for _, pl in Party do
				aw[pl:GetIndex()] = true
			end
		end
	end
end

local SlotLiterals = {A = 0, B = 1, C = 2, D = 3, E = 4, F = 5}

--!a{name}k{Give,Ungive,Done,Undone,After,StdTopicGiven,StdTopicDone} See #quest examples:Quests#
function Quest(t)
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
	--!v([name])
	-- Quest states: nil, "Given", "Done" or a custom state.
	if not vars.Quests then
		vars.Quests = {}
		internal.SaveGameData.NewQuests = 1
	end
	t.BaseName = t.BaseName or t.Name
	t.GivenState = t.GivenState or "Given"
	t.DoneState = t.DoneState or "Done"

	t.IsGiven = t.IsGiven or function(t)
		return vars.Quests[t.BaseName] == t.GivenState
	end

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
				AddAutoAward(t)
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
	if t.AwardSort and t.AwardIndex then
		Game.AwardsSort[t.AwardIndex] = t.AwardSort
	end

	t.IsAwarded = t.IsAwarded or function(t, ev)
		if not t.StoreAwards then
			return vars.Quests[t.BaseName] == t.DoneState  -- no need to keep track of players that reeceived it
		end
		local a = vars.QuestAwards
		a = a and a[t.BaseName]
		return a and a[ev.PlayerIndex]
	end
	
	t.TakeQuestOperation = t.TakeQuestOperation ~= false and (t.TakeQuestOperation or TakeQuestOperation or "Add")

	t.GetGreeting = t.GetGreeting or function(t, seen)
		if not seen then
			return t.Texts.FirstGreet
		end
		local topic = t.Texts["Greet"..(vars.Quests[t.BaseName] or "")]
		if topic then
			return topic
		elseif topic == nil then
			return t.Texts.Greet
		end
	end
	
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
				AddQuestBit(t)
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
				if not t.NeverDone then
					if tonumber(t.Quest) then
						evt.Sub("QBits", t.Quest)
					end
					vars.Quests[t.BaseName] = t.DoneState
				end
				AddGoldExp((t.Gold or 0) - (t.QuestGold or 0), t.Experience or t.Exp)
				if t.RewardItem then
					evt.Current.Add("Inventory", t.RewardItem)
				end
					
				AddQuestAward(t)
				ev = "Done"
			else
				ev = "Undone"
			end
		elseif state == t.DoneState then
			ev = "After"
		else
			ev = state
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
