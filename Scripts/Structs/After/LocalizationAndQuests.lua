local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
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
			CopyLoc(t1, t, over)
			return t
		end,
		__newindex = function(_, k, t2)
			local t1 = rawget(t, k) or {}
			rawset(t, k, t1)
			CopyLoc(t2, t1, true)
		end,
	})
end

--!vt(function)(t, over) Possible values of 'over':
--   true:  permanent setup - overwrite all (used in !b[[Localization]] scripts only)
--   false:  temporary setup - overwrite temporary setup only
--   "update":  remove all previous temporary setup, overwrite temporary setup only
LocalizeAll = NewLoc(TXT)

--!(t, over, lev = 1) Possible values of 'over':
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
					ev[i] = 0
				end
			elseif BackupNPC[i] and ev[i] == FreeEvents[i] then
				Game.NPC[npc].Events[i] = BackupNPC[i]
				BackupNPC[i] = nil
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
			local old = CurrentQuests
			UpdateCurrentQuests(CurrentNPC)
			for k, v in pairs(table.copy(old, table.copy(CurrentQuests))) do
				if old[k] == nil or CurrentQuests[k] == nil then
					Game.UpdateDialogTopics()
				end
			end
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
			if Game.NPC[CurrentNPC].Events[i] == FreeEvents[i] then
				Game.NPC[CurrentNPC].Events[i] = s
			end
		end
		BackupNPC = {}
		internal.SaveGameData.SeenNPC = internal.SaveGameData.SeenNPC or {}
		internal.SaveGameData.SeenNPC[CurrentNPC] = true
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

local function NewQuestNumber(t)
	local QuestNumbers = {}
	local QuestLog = {}
	local QuestNumberIndex = 0
	for i, s in Game.QuestsTxt do
		if s == "0" then
			QuestNumbers[#QuestNumbers + 1] = i
		end
	end
	
	function events.LeaveGame()
		QuestNumberIndex = 0
		QuestLog = {}
	end
	
	-- update automatic quest log entries when quest log is opened
	function events.Action(t)
		if t.Action == 200 then
			for i, n in ipairs(QuestNumbers) do
				Party.QBits[n] = QuestLog[i] and QuestLog[i]:IsGiven() or false
			end
		end
	end
	
	function NewQuestNumber()
		QuestNumberIndex = QuestNumberIndex + 1
		local i = QuestNumbers[QuestNumberIndex]
		t.Quest = assert(i, 'no free quest indeces left. Free indeces are those with "0" set as Quest Note Text in quests.txt')
		QuestLog[QuestNumberIndex] = t
	end
	
	return NewQuestNumber()
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
	Quests[t.Name] = t
	--!v([name])
	-- Quest states: nil, "Given", "Done" or a custom state.
	vars.Quests = vars.Quests or {}
	t.BaseName = t.BaseName or t.Name
	t.GivenState = t.GivenState or "Given"
	t.DoneState = t.DoneState or "Done"

	t.IsGiven = t.IsGiven or function(t)
		return vars.Quests[t.BaseName] == t.GivenState
	end
	
	if t.Quest == true then
		NewQuestNumber(t)
	end

	t.SetTexts = t.SetTexts or function(t1, texts)
		t.Texts = LocalizeAll.Quests[t.Name](texts or t1)
		if t.Texts.Quest then
			if not t.Quest then
				NewQuestNumber(t)
			end
			Game.QuestsTxt[t.Quest] = t.Texts.Quest
		end
		return t
	end
	LocalizeAll.Quests[t.Name]({}, "update")
	t:SetTexts(t.Texts or {})
	
	t.TakeQuestOperation = t.TakeQuestOperation or TakeQuestOperation or "Add"

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
			if (t.CheckGive == nil and (t.Give or t.Texts.Give or t.Quest)) or t.CheckGive and t.CheckGive(t) then
				if t.Quest and t.TakeQuestOperation then
					evt[t.TakeQuestOperation]("QBits", t.Quest)
				end
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
					if t.Quest then
						evt.Sub("QBits", t.Quest)
					end
					vars.Quests[t.BaseName] = t.DoneState
				end
				AddGoldExp((t.Gold or 0) - (t.QuestGold or 0), t.Experience or t.Exp)
				if t.RewardItem then
					evt.Add("Inventory", t.RewardItem)
				end
				if t.Awards then
					evt.Add("Awards", t.Awards)
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
		ShowQuestEffect()
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
	
	local function OnLoadMap()
		CurMap = Map.Name:lower()
		CurTasks = {}
		MaySleep = true
		local _, a = Game.MapStats.Find(CurMap)
		RefillDays = a and a.RefillDays or 1/0
		
		local state = vars.Quests[t.BaseName]
		if state == t.DoneState then
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
