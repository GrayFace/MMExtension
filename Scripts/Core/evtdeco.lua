local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local _KNOWNGLOBALS = vars, Vars, mapvars, MapVars, Game, Party, Map, ReadLodTextTable, path, table

local P = ...
local CmdStructs = P.CmdStructs
local CmdNames = P.CmdNames
local CmdInfo = P.CmdInfo

local function JoinStr(s1, s2, sep)
	return (s1 and s2 and s1..sep..s2 or s1 or s2)
end

local function PrettifyElseIf(str, unindent)
	if unindent then
		str = str:gsub("\n\t(\t*)", "\n%1")
	end
	return str:gsub("else\r\n\t(\t*)(if .-\r\n\t%1end)(.-)(\r\n%1end)", |tab, cond, after, post|
		if after == "" then
			return ("else%s"):format(PrettifyElseIf(cond, true))
		elseif cond:match("^[^\t]+\t+goto [^\t]+\t+end$") or cond:match("^[^\t]+\t+return[^\t]+\t+end$") then
			-- This case:
			--   else
			--     if not evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
			--       goto _18
			--     end
			--     evt.Subtract("MapVar3", 1)
			--   end
			-- Convert to:
			--   elseif not evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
			--     goto _18
			--   else
			--     evt.Subtract("MapVar3", 1)
			--   end
			return ("else%s%s"):format(cond:gsub("end$", ""):gsub("\n\t", "\n"), PrettifyElseIf("else"..after..post))
		else
			return ("else\r\n\t%s%s%s"):format(tab, PrettifyElseIf(cond..after), post)
		-- else
		end
	)
end

function evt.Decompile(fileName, funcMode, outFile, asTxt)

	local InLua = not asTxt
	local funcMode = funcMode or (InLua and 1 or 0)
	local evtStr
	local evtStrHigh = 0
	local IsGlobal = path.name(fileName):lower() == "global.evt"
	local ds = 1
	local InsertInEvt  -- for automated fixes in *.evt
	
	-- write
	local str, strN = {}, 0
	local function S(s)
		strN = strN + 1
		str[strN] = (s and tostring(s) or "")
		return strN
	end	
	local function SN(s)
		return S((s or "").."\n")
	end
	local function SF(s, ...)
		return S(s:format(...))
	end

	local function Error(s, ...)
		SF(("-- ERROR: "..s.."\n"):format(...))
	end

	local function Comment(comment, space)
		space = space or "  "
		if comment and comment:find("\n") then
			return space.."--[[ "..comment.." ]]"
		end
		return comment and comment ~= "" and space.."-- "..comment or ""
	end
	
	local function AsEvtStr(v)
		return ("evt.str[%s]%s"):format(v, Comment(evtStr[v + ds]))
	end

	local function BaseDecompileStr(str)
		evtStr = str:split("\0", 1, true)
		if not evtStr[2] then
			evtStr = str:split("\r\n", 1, true)  -- #0 are changed into #13#10 by extractors
		end
	end

	local function DecompileStr(str)
		BaseDecompileStr(str)
		for i, v in ipairs(evtStr) do
			if v:sub(1, 1) ~= '"' then
				evtStr[i] = ('"%s"'):format(v)
			end
		end
	end

	local function DecompileStrLua(str)
		BaseDecompileStr(str)
		for i, v in ipairs(evtStr) do
			if v:sub(1, 1) == '"' and v:sub(-1, -1) == '"' then
				v = v:sub(2, -2)
			end
			if v ~= "" then
				evtStrHigh = i
			end
			evtStr[i] = ("%q"):format(v)
		end
	end
	
	local function GetFromArray(arr, n, name)
		if n >= arr.low and n <= arr.high then
			return '"'..(name and arr[n][name] or arr[n])..'"'
		elseif n > 0 and arr ~= Game.SpellsTxt then
			if InLua then
				Error("Not found")
			else
				return "not found!"
			end
		end
	end

	local function GetStr(n)
		return IsGlobal and GetFromArray(Game.NPCText, n) or evtStr[n + ds]
	end

	local function GetFromFile(fname, n, col, quotes, headRows)
		-- if not FromFile[fname] then
		-- 	local t = {}
		-- 	FromFile[fname] = t
		-- 	for s in Game.LoadTextFileFromLod(fname):gmatch("\r\n"..("[^\t]*\t"):rep(col-1).."([^\t]*)") do
		-- 		t[#t+1] = (s:sub(1,1) == '"' and s:sub(2, -2) or s)
		-- 	end
		-- 	for i = 1, (headRows or 1) - 1 do
		-- 		t[i] = nil
		-- 	end
		-- end
		-- local s = FromFile[fname][n]
		local s = (n > 0 and ReadLodTextTable(fname, n + (headRows or 1), col))
		if s then
			return quotes and '"'..s..'"' or s
		elseif InLua then
			Error("Not found")
		else
			return "not found!"
		end
	end

	local function FindConst(name, v)
		local a = table.find(const[name] or {}, v)
		if a then
			return "const."..name.."."..a
		elseif name:match("^.*Bits$") then --if InLua then
			local t = {}
			local _, k = math.frexp(v)
			k = math.ldexp(0.5, k)
			if k ~= v then
				while v ~= 0 and k >= 1 do
					if v >= k then
						t[#t+1] = FindConst(name, k) or ("0x%X"):format(k)
						v = v - k
					end
					k = k/2
				end
			end
			if t[1] then
				return table.concat(t, " + ")
			end
		end
		Error("Const not found")
	end
	
	local function GetVarNumComment(k, v)
		-- for finding fountain bug
		-- if k == "QBits" or k == "PlayerBits" or k == "AutonotesBits" then
		-- 	_G[k] = _G[k] or {}
		-- 	_G[k][v] = _G[k][v] or {}
		-- 	_G[k][v][path.name(fileName)] = true
		-- end
		if k == "ClassIs" then
			-- return GetFromArray(Game.ClassNames, v)
			return nil, FindConst("Class", v)
		elseif k == "Awards" then
			return GetFromArray(Game.AwardsTxt, v)
		elseif k == "QBits" then
			local ret = GetFromArray(Game.QuestsTxt, v)
			local desc = GetFromFile("quests.txt", v, 3)
			return ret ~= '""' and ret or desc ~= "" and desc or nil
		elseif k == "Inventory" then
			return GetFromArray(Game.ItemsTxt, v, 'Name')
		elseif k == "MainCondition" then
			return nil, FindConst("Condition", v)
		elseif k == "AutonotesBits" then
			return GetFromArray(Game.AutonoteTxt, v)
		elseif k == "NPCs" then
			return GetFromArray(Game.NPCDataTxt, v, 'Name')
		elseif k == "HasNPCProfession" then
			return nil, FindConst("NPCProfession", v)
		end
	end
	
	local function CmdComment(num, struct)
		local comment
		if num == 0x02 then
			local i = struct.Id
			if i == 600 then
				comment = (mmver == 7) and "Win Good" or "Win"
			elseif i == 601 then
				comment = (mmver == 7) and "Win Evil" or "Lose"
			else
				comment = GetFromArray(Game.Houses, struct.Id, 'Name')
			end
		elseif num == 0x0F and (struct.State == 2 or struct.State == 3) then
			comment = "switch state"
		elseif num == 0x15 then
			comment = GetFromArray(Game.SpellsTxt, struct.Spell, 'Name')
		elseif num == 0x16 then
			comment = GetFromArray(Game.NPCDataTxt, struct.NPC, 'Name')
		elseif num == 0x1A then
			if mmver == 8 then
				comment = GetStr(struct.Question)  -- answers are in map strings!
			else
				comment = "("..JoinStr(GetStr(struct.Answer1), struct.Answer2 ~= struct.Answer1 and GetStr(struct.Answer2), ", ")..")"
				comment = JoinStr(GetStr(struct.Question), comment, " ")
			end
		elseif num == 0x22 then
			if mmver == 8 then
				comment = GetFromArray(Game.ItemsTxt, struct.Item % 1000, 'Name')
			else
				local _, a = Game.ObjListBin.Find(struct.Type)
				comment = a and a.Name or GetFromArray(Game.ObjListBin, Game.ObjListBin.count)
			end
		elseif num == 0x29 then  -- GiveItem
			if struct.Id ~= 0 then
				comment = GetFromArray(Game.ItemsTxt, struct.Id, 'Name')
			end
		elseif num == 0x40 or num == 0x41 then
			comment = JoinStr(GetFromArray(Game.ItemsTxt, struct.MinItemIndex, 'Name'), GetFromArray(Game.ItemsTxt, struct.MaxItemIndex, 'Name'), "...")
		elseif num == 0x44 then
			comment = GetFromFile("roster.txt", struct.Id + 1, 2, true, 2)
		end
		return comment
	end
	
	local function CmdParams(num, struct, jump)
		local info = CmdInfo[num]
		local order = info.FieldsOrder
		local func = (funcMode == 2 or funcMode == 1 and (#order <= 1 or CmdInfo[num].Simple) or num == 0x23)
		S(func and "(" or "{")
		local comment = CmdComment(num, struct)
		local varValue
		local hasParams
		
		-- command call
		for i = 1, #order + (jump and 1 or 0) do
			local a = order[i] or jump
			local v = struct[a]
			if v and (v ~= 0 or num ~= 0x1F and num ~= 0x26) or a == "On" or a == "Has" or a == "RandomAngle" or a == "Visible" or func then
				if hasParams then
					S(", ")
				end
				hasParams = true
				local vn = -- (a == "VarNum" and (VarNumToStr[v] or v))
								-- or (a == "Player" and PlayerToStr[v])
								(a == "Mastery" and v <= 4 and table.find(const, v) and "const."..table.find(const, v))
								or (info.FieldTypes[a] and FindConst(info.FieldTypes[a], v))
				if a == "VarNum" then
					comment, varValue = GetVarNumComment(v, struct.Value)
				elseif a == "Str" then
					comment = GetStr(v)
				elseif a == "Event" or a == "NewEvent" then
					comment = JoinStr(comment, GetFromArray(Game.NPCTopic, v, "Name"), " : ")
				elseif a == "Greeting" then
					comment = JoinStr(comment, GetFromArray(Game.NPCGreet, v, 1), " : ")
				elseif a == "NPC" then
					comment = GetFromArray(Game.NPCDataTxt, v, 'Name')
				elseif a == "HouseId" then
					comment = JoinStr(comment, v > 0 and GetFromArray(Game.Houses, v, "Name"), " -> ")  -- 2 comments in evt.MoveNPC case
				elseif a == "Item" then
					comment = JoinStr(comment, GetFromArray(Game.ItemsTxt, v, 'Name'), " : ")
				elseif a == "NPCGroup" then
					comment = struct.NPCGroup > 0 and GetFromFile("npcgroup.txt", struct.NPCGroup + 1, 4, true)
				elseif a == "NPCNews" then
					comment = JoinStr(comment, GetFromArray(Game.NPCNews, v), " : ")
				elseif a == "Value" and varValue then
					vn = varValue
				end
				if not func and (not vn and a ~= "VarNum" or i ~= 1) then
					S(a.." = ")
				end
				if vn then
					S(vn)
				elseif type(v) == "string" then
					S(('%q'):format(v))
				elseif a == "Bit" then
					S(("0x%X"):format(v))
				else
					S(tostring(v))
				end
			end
		end
		S(func and ")" or "}")
		return comment and "       "..Comment(comment)
	end
	
	local function DecompileCmd(p, wasShowTopic, firstLine, pend)
		local label = u1[p + 3]
		local num = u1[p + 4]
		local struct = CmdStructs[num]
		if not struct then
			return "unknown command: "..num, false
		elseif p + 5 + struct["?size"] > pend then
		-- elseif 4 + struct["?size"] > u1[p] then
			return "invalid command size ("..CmdNames[num]..")"
		end
		struct = struct:new(p + 5)
		local showTopic = (CmdNames[num]:sub(1, #"CanShowTopic.") == "CanShowTopic.")
		if wasShowTopic ~= nil and showTopic ~= wasShowTopic then
			SN()
		end
		local s = struct.Decompile and struct:Decompile(num)
		if s and not firstLine then
			SN()
		end
		s = nil
		if s then
			if not firstLine then
				SN()
			end
			S("      "..s)
		-- elseif num == 0x23 then
		-- 	S((label < 10 and "  %s:  Player = %s" or "  %s: Player = %s"):format(label, PlayerToStr[struct.Player] or struct.Player))
		elseif (num == 4 or num == 5) and label == 0 then
			local v = struct.Str
			local comment = evtStr[v + ds]
			if comment then
				S(("      %s = str[%s]  -- %s"):format(CmdNames[num], v, comment))
			else
				S(("      %s = str[%s]"):format(CmdNames[num], v))
			end
		else
			S((label < 10 and "  %s:  %s  " or "  %s: %s  "):format(label, CmdNames[num]))
			local comment = CmdParams(num, struct, CmdInfo[num].Jump)
			S(comment)
		end
		SN()
		return num == 1 or num == 0x24, showTopic  -- exit or goto
	end

	local function DecompileBuffer(p, size)
		if evtStr then
			for i, v in ipairs(evtStr) do
				SN(('str[%s] = %q'):format(i - ds, v:sub(2, -2)))
			end
			SN("\n")
		else
			evtStr = {}
		end

		local curEvt
		local s, needLine, showTopic, firstLine
		size = p + size
		while p < size and p + u1[p] < size do
			local evt = u2[p + 1]
			if evt ~= curEvt then
				showTopic = nil
				if curEvt then
					SN("end\n")
				end
				s = "event "..evt
				if IsGlobal and evt >= Game.NPCTopic.low and evt <= Game.NPCTopic.high then
					local s1 = Game.NPCTopic[evt]
					if s1 and s1 ~= "" then
						s = s..(('  -- "%s"'):format(s1))
					end
				end
				SN(s)
				curEvt = evt
				firstLine = true
			elseif needLine then
				SN()
				firstLine = true
			end
			needLine, showTopic = DecompileCmd(p, showTopic, firstLine, size)
			firstLine = false
			p = p + u1[p] + 1
		end
		if curEvt then
			SN("end")
		end
	end
	
	-- Decompilation to Lua

	local EvtCmd = {}
	local EvtHouse = {}
	local EvtHint = {}
	local EvtHouseWritten = {}
	local MazeInfo          -- only used by PrepareCmd
	local SoundLoaded = {}  -- only used by PrepareCmd
	local NExit = {Next = {}}
	local InplaceForPlayer
	
	local function PrepareCmd(p, pend)
		local evtId = u2[p + 1]
		local label = u1[p + 3]
		local i = evtId*256 + label
		local num = u1[p + 4]
		local struct = CmdStructs[num]
		struct = struct and struct:new(p + 5)
		if struct and p + 5 + struct["?size"] > pend then
			return
		end
		if num == 4 then  -- Hint
			EvtHint[evtId] = struct.Str
			return
		elseif num == 5 and MazeInfo then  -- MazeInfo
			return
		elseif num == 5 then
			MazeInfo = struct.Str
			return SN("evt.MazeInfo = "..AsEvtStr(MazeInfo))
		elseif num == 2 and struct.Id < 600 and EvtHint[evtId] then  -- EnterHouse
			EvtHouse[evtId] = EvtHouse[evtId] or struct.Id
		elseif num == 2 and struct.Id < 600 then  -- EnterHouse
			Error("evt.house[%s] not assigned for hint, because Hint command is missing", evtId)
			-- InsertInEvt(p, "\5"..("").char(evtId % 256, evtId:div(256)).."\0\4\0")
		elseif num == 3 and not SoundLoaded[struct.Id] then  -- PlaySound
			SF("Game.LoadSound(%s)\n", struct.Id)
			SoundLoaded[struct.Id] = true
		end
		if EvtCmd[i] then
			Error("Duplicate label: %s:%s", evtId, label)
			if label == 0 or EvtCmd[i - 1] and EvtCmd[i - 1].p < EvtCmd[i].p then
				return
			end
		end
		local info = CmdInfo[num] or {}
		local t = {p = p, evtId = evtId, label = label, num = num, struct = struct, info = info}
		EvtCmd[i] = t
		local cmdName = CmdNames[num] and CmdNames[num]:match("^CanShowTopic.(.*)")
		t.ShowTopic = cmdName and true or false
		t.cmdName = (cmdName or CmdNames[num])
		t.CanEmit = info.CanEmit
		if num == 1 or num == 0x2D then  -- exit
			t.CanEmit = false
			t.Next = {}
		elseif num == 0x24 then  -- GoTo
			t.CanEmit = false
			t.Next = {struct.jump}
		elseif num == 0x19 then  -- RandomGoTo
			local order = info.FieldsOrder
			local jumps = {}
			for i = 1, #order do
				local k = struct[order[i]]
				if k > 0 then
					jumps[#jumps+1] = k
				end
			end
			table.insert(jumps, 1, jumps[#jumps])  -- Next[0] is emitted last
			jumps[#jumps] = nil
			t.Next = jumps
		else
			t.Next = {label + 1}
			if info.Jump then
				t.Next[2] = struct[info.Jump]
			end
			t.FragileLabel = true  -- next label must be placed further in the file, otherwise it's ignored
		end
	end
	
	local function BuildGraph(evtId, label, ShowTopic)
		local Nodes = {}
		local function AddNode(label)
			local cmd = label and label >= 0 and EvtCmd[evtId*256 + label]
			if not cmd then
				return
			end
			local node = Nodes[label] or {cmd = cmd, JumpY = cmd.info.JumpY, ForPlayer = {}}
			if node.Next then
				return
			end
			Nodes[label] = node
			node.CanEmit = (cmd.CanEmit and cmd.ShowTopic == ShowTopic)
			local FragileLabel = cmd.FragileLabel
			if cmd.ShowTopic == ShowTopic then
				node.Next = table.copy(cmd.Next)
			elseif cmd.num == 1 then  -- Exit also works in ShowTopic mode
				node.Next = {}
				FragileLabel = false
			else
				node.Next = {label + 1}
				FragileLabel = true
			end
			if FragileLabel and node.Next[1] >= 0 then
				local c2 = EvtCmd[evtId*256 + node.Next[1]]
				if c2 and c2.p < cmd.p then
					Error("Misplaced label, ignored: %s:%s", evtId, node.Next[1])
					Error("Calling label: %s:%s (%s)", evtId, label, cmd.cmdName)
					node.Next[1] = -1
				end
			end
			for i = 2, #node.Next do
				AddNode(node.Next[i])
			end
			return AddNode(node.Next[1])
		end
		AddNode(label)
		return Nodes
	end
	
	local function N(n1)
		return n1 ~= NExit and n1
	end
	
	local function TraceSingle(n1)
		local start
		while n1 and n1.Ref < 2 and n1 ~= start do
			n1, start = n1.Next[1], start or n1
		end
		return n1
	end
	
	local function Priority(n1, n2)
		local n
		local start
		while N(n1) do
			if n1 == n2 then
				return -1000
			elseif n1.Ref > 1 or n1 == start then
				return 1/0
			elseif n1.Next[2] then
				n = -1
			end
			n1, start = n1.Next[1], start or n1
			n = n or -10
		end
		return n or 0
	end
	
	local function FlipJumps(node)
		node.Next[1], node.Next[2] = node.Next[2], node.Next[1]
		node.JumpY = not node.JumpY
		if node.Dup then
			node.Dup[1], node.Dup[2] = node.Dup[2], node.Dup[1]
		end
		node.Flipped = not node.Flipped
	end
	local function OptimizeNext(node, keepNode)  -- to get rid of some labels
		local n1, n2 = node.Next[1], node.Next[2]
		local p1, p2 = Priority(n1, n2), Priority(n2, n1)
		if p1 < p2 or p1 == p2 and n2 and n1.Ref > 1 and n2.Ref == 1 then
			if keepNode and Priority(n2, keepNode) ~= -1000 then
				return
			end
			FlipJumps(node)
		end
	end

	local function SimplifyGraph(Nodes, label)
		local function ChangeLabel(old, new)
			label = (label == old and new or label)
			for k, node in pairs(Nodes) do
				for i, k in ipairs(node.Next) do
					if k == old then
						node.Next[i] = new
					elseif not Nodes[k] then
						node.Next[i] = -1
					end
				end
			end
		end
		local function DropNodes()
			local found
			for k, node in pairs(Nodes) do
				if not node.CanEmit or InplaceForPlayer and node.cmd.num == 0x23 then
					if node.Next[1] then
						ChangeLabel(k, node.Next[1])
					end
					Nodes[k] = nil
					found = true
				end
			end
			return found
		end
		local function ColapseLabels()
			local found
			ChangeLabel()  -- convert empty labels to -1
			for k, node in pairs(Nodes) do
				if node.Next[2] then
					local t = {}
					local Dup0 = node.Dup or {}
					local Dup = {}
					for i, k in ipairs(node.Next) do
						if Dup[k] then
							Dup[k] = Dup[k] + (Dup0[i] or 1)
						else
							t[#t+1] = k
							Dup[k] = (Dup0[i] or 1)
						end
					end
					if #t ~= #node.Next then
						found = true
						Dup0 = {}
						for i, k in ipairs(t) do
							Dup0[i] = Dup[k]
						end
						node.Next, node.Dup = t, Dup0
						if not t[2] and node.cmd.num == 0x19 then  -- collapse RandomGoTo
							node.CanEmit = false
						end
					end
				end
			end
			return found
		end
		local function CountRefs()
			(Nodes[label] or {}).Ref = 1
			for k, node in pairs(Nodes) do
				for i, k in ipairs(node.Next) do
					local t = Nodes[k] or NExit
					t.Ref = (t.Ref or 0) + 1
					-- t.Refs = t.Refs or {}  -- !!! tmp
					-- t.Refs[#t.Refs + 1] = node.cmd.label  -- !!! tmp
					node.Next[i] = t
				end
			end
			NExit.Ref = 1
		end
		local function OptimizeJumps()
			for _, node in sortpairs(Nodes) do
				if node.Next[2] then
					OptimizeNext(node)
				end
			end
			for _, node in sortpairs(Nodes) do
				if node.Next[2] then
					if node.Flipped then
						FlipJumps(node)
					end
					OptimizeNext(node)
				end
			end
		end
		local function CheckForPlayer(label, pl)
			local node = Nodes[label]
			if not node or not InplaceForPlayer or node.ForPlayer[pl] then
				return
			elseif next(node.ForPlayer) and node.cmd.info.ForPlayer then
				InplaceForPlayer = false
				return
			end
			node.ForPlayer[pl] = true
			if node.cmd.num == 0x23 then
				pl = node.cmd.struct.Player
			end
			for i = 2, #node.Next do
				CheckForPlayer(node.Next[i], pl)
			end
			return CheckForPlayer(node.Next[1], pl)
		end
		
		-- InplaceForPlayer = true
		-- CheckForPlayer(label, "Current")
		while DropNodes() or ColapseLabels() do
		end
		CountRefs()
		OptimizeJumps()
		return Nodes[label]
	end
	
	-- block
	local block
	local Tab = "\t"
	local Tab2 = "\t\t"
	local Queue
	local LastGoto
	local ResultStart
	
	local function BeginBlock(t)
		block = t
		t.NeedLabel = {}
		t.BeginLine = S()
		t.Locals = {}
	end
	
	local function EndBlock()
		for node in pairs(block.NeedLabel) do
			str[block[node]] = ("::_%s::\n\t"):format(node.cmd.label)
		end
		if strN == block.BeginLine then
			strN, str[strN] = strN - 1, nil
		else
			local loc = next(block.Locals)
			str[block.BeginLine] = block.Begin..(loc and "\n\tlocal "..loc or "").."\n"
			-- if block.Locals.result then
			-- 	SN(Tab.."return result")
			-- end
			SN(block.End or "end\n")
		end
		block = nil
	end
	
	local function Goto(node, tab)
		tab = tab or Tab2
		if N(node) then
			block.NeedLabel[node] = true
			Queue[#Queue + 1] = node
			SN(tab.."goto _"..node.cmd.label)
		elseif not block.ShowTopic then
			SN(tab.."return")
		elseif ResultStart then
			str[ResultStart] = "return "
		elseif block.Locals.result then
			SN(tab.."return result")
		else
			SN(tab.."return true")
		end
		ResultStart = nil
		LastGoto = strN
	end
	
	local function Return()
		if not block.ShowTopic then
			SN(Tab.."do return end")
		elseif block.Locals.result then
			SN(Tab.."do return result end")
		else
			SN(Tab.."do return true end")
		end
	end
	
	local EmitIf
	
	local function EmitElse(node, Else)
		if Else and N(node.Next[1]) then
			if node.Next[1] ~= Else then
				SN(Tab.."else")
			end
			node.Next[1] = EmitIf(node.Next[1], nil, Else)
		end
		SN(Tab.."end")
	end
	
	-- local ChestUsed = {}  -- detect chests used by multiple events
	-- local EvtUsedChest = {}  -- detect multiple chests used by the same event (potential problems)
	
	local function EmitCmd(node, keepNode)
		local Else
		if node.Next[2] then
			OptimizeNext(node, keepNode)
			Else = true
			local Same = N(TraceSingle(node.Next[1]))
			for _, n1 in ipairs(node.Next) do
				Else = Else and (Priority(n1) ~= 1/0)
				Same = (TraceSingle(n1) == Same) and Same
			end
			Else = Else or Same
			-- if Same and Else == Same then
			-- 	SF(Tab.."-- Same Cmd: %s", Same.cmd.cmdName)
			-- 	CmdParams(Same.cmd.num, Same.cmd.struct)
			-- 	SN()
			-- end
		end
		
		if ResultStart then
			block.Locals.result, ResultStart = true, nil
		end
		local cmd = node.cmd
		local num = cmd.num
		local struct = cmd.struct
		-- if num == 7 then
		-- 	if ChestUsed[struct.Id] then
		-- 		Error("Shared chest: %s", struct.Id)
		-- 	end
		-- 	ChestUsed[struct.Id] = true
		-- 	if EvtUsedChest[cmd.evtId] then
		-- 		Error("Event uses multiple chests, potential problems")
		-- 	end
		-- 	EvtUsedChest[cmd.evtId] = true
		-- end
		block[node] = S(Tab)
		-- special commands
		if num == 0x19 then  -- RandomGoto
			local Next = node.Next
			local Dup = node.Dup or {1,1,1,1,1,1}
			local n = Dup[1]
			block.Locals.i = true
			SN("i = Game.Rand() % "..#cmd.Next)
			for i = 2, #Next do
				if i == 2 then
					S(Tab.."if ")
				else
					S(Tab.."elseif ")
				end
				local k = Dup[i]
				if k == 1 then
					SF("i == %s then\n", n)
				elseif k == 2 then
					SF("i == %s or i == %s then\n", n, n + 1)
				else
					SF("i >= %s and i <= %s then\n", n, n + k - 1)
				end
				EmitIf(Next[i], Next[1], Else)
				n = n + k
			end
			return EmitElse(node, Else)
		elseif num == 0x2E then  -- CanShowTopic.Set
			ResultStart = S("result = ")
			return SN(tostring(struct.Visible))
		end
		-- normal commands
		local jump = node.Next[2]
		if jump and block.ShowTopic then  -- CanShowTopic optimization
			local n2, n1 = N(jump), N(node.Next[1])
			if n1 and n1.cmd.num == 0x2E and not N(n1.Next[1]) and n2 and n2.cmd.num == 0x2E and not N(n2.Next[1]) and
				 n1.cmd.struct.Visible ~= n2.cmd.struct.Visible then
				n1.Ref = n1.Ref - 1
				n2.Ref = n2.Ref - 1
				jump, node.Next = nil, {}
				ResultStart = S("result = ")
				if n2.cmd.struct.Visible ~= node.JumpY then
					S("not ")
				end
			end
		end
		if jump and node.JumpY then
			S("if ")
		elseif jump then
			S("if not ")
		end
		if InplaceForPlayer and cmd.info.ForPlayer and next(node.ForPlayer) ~= "Current" then
			local s = next(node.ForPlayer)
			if type(s) == "number" then
				s = "["..s.."]"
			else
				s = "."..s
			end
			SF("evt%s.%s", s, cmd.cmdName)
		else
			SF("evt.%s", cmd.cmdName)
		end
		local comment = CmdParams(num, struct)
		if jump then
			S(" then")
		end
		-- S("  -- Refs: "..node.Ref.." (")  -- !!! tmp
		-- for i, lab in ipairs(node.Refs or {}) do
		-- 	S((i > 1 and ", " or "")..lab)
		-- end
		-- S(")")
		SN(comment)
		if jump then
			EmitIf(jump, node.Next[1], Else)
			EmitElse(node, Else)
		end
	end
	
	function EmitIf(node, main, Else)
		node = N(node)
		local Same = (Else ~= true and Else)
		local oldTab, oldTab2 = Tab, Tab2
		if node and node.Ref == 1 then
			Tab, Tab2 = Tab2, Tab2.."\t"
		end
		while node and node.Ref == 1 and node ~= Same do
			EmitCmd(node, Same)
			node = N(node.Next[1])
		end
		Tab, Tab2 = oldTab, oldTab2
		if ResultStart and not node or node ~= main and (not Else or not Same and node) then
			Goto(node)
		elseif node and node == main then
			node.Ref = node.Ref - 1
		end
		return Same and node or nil
	end
	
	local function DecompileEvt(evtId, label)
		-- Sorted by first use:
		Queue = {SimplifyGraph(BuildGraph(evtId, label, block.ShowTopic), label)}
		-- check simple evt.EnterHouse
		if label == 0 and not IsGlobal and not block.ShowTopic and Queue[1] then
			local node = Queue[1]
			local cmd = node.cmd
			if not N(node.Next[1]) and cmd.num == 0x02 and cmd.struct.Id == EvtHouse[evtId] then
				local t = EvtHouseWritten[evtId]
				str[t[0]] = ("evt.HouseDoor(%s, %s)%s\n"):format(unpack(t))
				return EndBlock()
			end
		end
		LastGoto = strN
		local q = 1
		while true do
			while block[Queue[q]] do  -- find what isn't emitted yet
				q = q + 1
			end
			local node = Queue[q]  -- label in need of writing
			if not node then
				break
			elseif LastGoto ~= strN then
				Return()  -- end previous branch
			end
			while N(node) do
				EmitCmd(node)
				assert(block[node])
				node = node.Next[1]
				if block[node] then
					Goto(node, Tab)
					break
				end
			end
			assert(block[Queue[q]])
		end
		for i = 1, q - 1 do
			assert(Queue[i])
		end
		if block.ShowTopic and (ResultStart or block.Locals.result) then
			Goto(NExit, Tab)
		end
		EndBlock()
	end
	
	local function EmitHint(evtId)
		if EvtHouse[evtId] then
			local v = EvtHouse[evtId]
			local comment = Comment(GetFromArray(Game.Houses, v, "Name"))
			SF("evt.house[%s] = %s%s\n", evtId, v, comment)
			EvtHouseWritten[evtId] = {[0] = strN, evtId, v, comment}
		elseif EvtHint[evtId] then
			SF("evt.hint[%s] = %s\n", evtId, AsEvtStr(EvtHint[evtId]))
		end
	end
	
	local evtDone = {[false] = {}, [true] = {}}
	local evtEmpty = {}
	
	local function DecompileCmdLua(p, pend)
		local evtId = u2[p + 1]
		local label = u1[p + 3]
		local num = u1[p + 4]
		local struct = CmdStructs[num]
		if not struct then
			return Error("Unknown command: %s:%s (0x%X)", evtId, label, num)
		elseif 4 + struct["?size"] > u1[p] then
			Error("Invalid command size: %s:%s (%s)",  evtId, label, CmdNames[num])
			if p + 5 + struct["?size"] > pend then
				return
			end
		end
		struct = struct:new(p + 5)
		local ShowTopic = CmdNames[num]:match("^CanShowTopic.(.*)") and true or false
		
		-- emit standard event
		if not evtDone[ShowTopic][evtId] then
			evtDone[ShowTopic][evtId] = true
			if not IsGlobal then
				EmitHint(evtId)
			elseif not evtDone[not ShowTopic][evtId] then
				SN(Comment(GetFromArray(Game.NPCTopic, evtId), ""))
			end
			local s = ShowTopic and "CanShowTopic" or IsGlobal and "global" or "map"
			s = ("evt.%s[%s] = function()"):format(s, evtId)
			local struct = EvtCmd[evtId*256] and EvtCmd[evtId*256].struct
			if not IsGlobal and struct and struct.Decompile then
				s = s..Comment(struct:Decompile(EvtCmd[evtId*256].num))
			end
			BeginBlock{Evt = evtId, ShowTopic = ShowTopic, Begin = s}
			local lastN = strN
			DecompileEvt(evtId, 0)
			evtEmpty[evtId] = (strN <= lastN)
		end
		
		-- emit special event
		local s = struct.Decompile and struct:Decompile(num)
		if s and not IsGlobal then
			local s1, s2 = s:match("^(.*)<function>(.*)")
			if label ~= 0 or evtEmpty[evtId] then
				BeginBlock{Evt = evtId, ShowTopic = ShowTopic,
					Begin = (s1 and s1.."function()" or s),
					End = s2 and "end"..s2.."\n"
				}
				DecompileEvt(evtId, label)
			elseif s1 then
				SF("%sevt.map[%s].last%s\n\n", s1, evtId, s2)
			else
				SF("%s = evt.map[%s].last\n\n", assert(s:match("^function (.*)%(%)$"), evtId))
			end
		elseif s then
			Error("Event in GLOBAL.txt: "..s)
		end
	end
	
	local function PrepareEvtPtr(p, size)
		size = p + size
		while p < size and p + u1[p] < size do
			PrepareCmd(p, size)
			p = p + u1[p] + 1
		end
		SN()
	end

	local function DecompileBufferLua(p, size)
		evtStr = evtStr or {}
		if not IsGlobal then
			SN("local TXT = Localize{")
			for i = 1, evtStrHigh do
				SN(("%s[%s] = %s,"):format(Tab, i - ds, evtStr[i]))
			end
			SN("}")
			SN("table.copy(TXT, evt.str, true)\n")
		end
		-- SN("-- Deactivate all standard events")
		SN("Game."..(IsGlobal and "GlobalEvtLines" or "MapEvtLines")..".Count = 0  -- Deactivate all standard events\n")

		PrepareEvtPtr(p, size)
		
		size = p + size
		while p < size and p + u1[p] < size do
			DecompileCmdLua(p, size)
			p = p + u1[p] + 1
		end
	end
	
	if InLua then
		DecompileStr = DecompileStrLua
		DecompileBuffer = DecompileBufferLua
	end

	-- do it
	local s, size, buf

	for f in path.find(path.setext(fileName, ".str")) do
		DecompileStr(io.load(f))
	end
	s = io.load(fileName)
	if #s < 5 then
		return nil
	end
	size = #s
	buf = mem.malloc(size + 30)
	mem.copy(buf, s, size + 1)  -- +30 and size + 1 are here to be sure no out-of-bounds problems occur
	
	local RepList, RepPlace = {}, buf
	function InsertInEvt(p, new)
		local k = #RepList + 2
		RepList[k-1] = mem.string(RepPlace, p - RepPlace, true)
		RepList[k] = new
		RepPlace = p
	end
	
	DecompileBuffer(buf, size)
	
	if RepList[1] then
		InsertInEvt(buf + size, "")
		io.save(path.setext(outFile, '.evt'), table.concat(RepList))
	end
	
	mem.free(buf)
	s = table.concat(str):gsub("\r?\n", "\r\n")
	if InLua then
		s = PrettifyElseIf(s)
	end
	if outFile then
		io.save(outFile, s)
	end
	return s
end
