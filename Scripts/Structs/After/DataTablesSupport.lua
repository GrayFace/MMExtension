local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar
local mmver = offsets.MMVersion

local function mmv(...)
	return select(mmver - 5, ...)
end

DataTables = {}

local _KNOWNGLOBALS_F

local function SplitToTable(str, startIdx, pattern)
	local t, i, n = {}, startIdx or 1, #str
	for s,m in str:gmatch(pattern) do
		t[i] = s
		i = i + 1
		if m > n then
			break
		end
	end
	return t
end

-- \r\n, \r
function SplitLines(str, startIdx)
	return SplitToTable(str, startIdx, "([^\r]*)()\r?\n?")
end

-- \r\n, \n, \r
function SplitLinesAny(str, startIdx)
	return SplitToTable(str, startIdx, "([^\r\n]*)()\r?\n?")
end

function SplitTabs(str, startIdx)
	return SplitToTable(str, startIdx, "([^\t]*)()\t?")
end


-- local function SplitToTable(str, startIdx, patternMany, patternStart)
	-- local t, i = {}, startIdx or 1
	-- if patternStart then
		-- t[i] = string.match(str, patternStart)
		-- i = i + 1
	-- end
	-- for s in string.gmatch(str, patternMany) do
		-- t[i] = s
		-- i = i + 1
	-- end
	-- return t
-- end

-- function SplitLines(str, startIdx)
	-- return SplitToTable(str, startIdx, "\r\n([^\r]*)", "[^\r]*")
-- end

-- function SplitTabs(str, startIdx)
	-- return SplitToTable(str, startIdx, "\t([^\t]*)", "[^\t]*")
-- end


local lastTime, profName
local function profile(name)
	-- local t = os.clock()
	-- if profName then
	-- 	print("Profiler: "..profName, t - lastTime)
	-- else
	-- 	print("Profiler: ----------------------------")
	-- end
	-- lastTime, profName = t, name
end


local function ReadWriteTable(f, a, str, onerror)
	local h = a.Header or ""
	local ht = SplitLines(h)
	local hn = #ht
	if ht[hn] == "" then
		hn = hn - 1
	else
		h = h.."\r\n"
	end
	if a.ColHeaders or a.ColHeadersLow then
		hn = hn + 1
	end
	local xn = a.ColCount
	local xl = a.ColLow or 1
	local yn = a.RowCount
	local yl = a.RowLow or 1

	local rh = a.RowHeaders or {}
	local rl = a.RowHeadersLow or yl
	local norh = a.NoRowHeaders
	local rhskip = norh and 1 or 0

	local einfoOld = errorinfo()
	errorinfo((einfoOld ~= "") and einfoOld.." - \001" or "\001")
	-- local einfo = (einfoOld ~= "") and einfoOld.." - " or ""
	local erY, erX, erVal

	local function doit()
		if str then
			-- read
			profile"split lines"
			local lines = SplitLines(str, 1 - hn)
			profile"read"
			for y = 1, yn or #lines do
				local t = SplitTabs(lines[y] or "", rhskip)
				if xn == nil then
					xn = #t
				elseif t[xn] == nil then
					return
				end
				for x = 1, xn do
					local v = t[x]
					erY, erX, erVal = y + hn, x - rhskip + 1, v
					f(x - 1 + xl, y - 1 + yl, v, #lines)
				end
			end
			profile(nil)
		else
			local ss = {h}
			-- write col headers
			if a.ColHeaders or a.ColHeadersLow then
				local ch = a.ColHeaders or {}
				local cl = a.ColHeadersLow or xl
				local t = {}
				t[1] = ch[cl - 1] or ""
				for x = 2, xn + 1 do
					local i = x - 2 + cl
					t[x] = ch[i] or i
				end
				ss[#ss + 1] = table.concat(t, "\t").."\r\n"
			end
			-- write data
			local t = {}
			for y = 1, yn do
				local dx = 0
				if not norh then
					local i = y - 1 + rl
					t[1] = rh[i] or i
					dx = 1
				end
				for x = 1, xn do
					erY, erX = y + hn, x - rhskip + 1
					t[x + dx] = assert(f(x - 1 + xl, y - 1 + yl))
				end
				ss[#ss + 1] = table.concat(t, "\t").."\r\n"
			end
			ss[#ss + 1] = a.Footer or ""
			return table.concat(ss)
		end
	end
	local ok, ret = pcall(doit)
	if not ok then
		local s = str and 'row %s, column %s - value "%s"' or 'row %s - column %s'
		local i = ret:find("\001")
		ret = ret:sub(1, i - 1)..s:format(erY, erX, erVal)..ret:sub(i + 1)
		if onerror then
			onerror()
		end
		error(ret, 0)
	end
	errorinfo(einfoOld)
	return ret
end
DataTables.ReadWriteTable = ReadWriteTable

function DataTables.StructsArray(arr, offs, t, str)
	offs = offs or structs.o[structs.name(arr[arr.low])]
	local boolFalse = {[""] = true, ["0"] = true, ["-"] = true, [" "] = true, ["false"] = true, ["False"] = true, ["FALSE"] = true}
	local boolToStr = {[true] = "x", [false] = "-"}
	local cols = {}
	local hdrRow = arr.low - 1
	local baseCount = arr.count
	local aliases = t.Alias or {}
	local aliasInv = t.AliasInv or {}
	t = t or {}
	t.RowLow = hdrRow
	t.RowHeaders = t.RowHeaders or {[hdrRow] = "#"}
	t.ColLow = 1
	local resisable = t.Resisable and str
	local ignore = t.IgnoreFields or {}
	local ignoreR = t.IgnoreRead or {}
	local struct, LastY, types, TypesY
	local function cleanup()
		if struct then
			struct["?ptr"] = nil  -- /speedup
		end
	end
	
	local function f(x, y, v, lcount)
		if y == hdrRow then
			if v then
				cols[x] = v
			else
				return assert(cols[x])
			end
		else
			local col = cols[x]
			if y ~= LastY then
				if struct then
					struct["?ptr"] = nil  -- /speedup
					rawset(arr, LastY, nil)  -- prevent "not enough memory"
				elseif v then
					types, TypesY = {}, y
				end
				if v and resisable then
					local n = y - hdrRow
					arr.count = n
					if n > baseCount then
						local size = arr[y]["?size"]
						mem.reallocMM(arr, size*baseCount, size*lcount)
						baseCount = lcount
					end
				end
				struct = arr[y]
				rawset(struct, "?ptr", struct["?ptr"])  -- speedup
				LastY = y
			end
			if y == TypesY and not ignoreR[col] then
				local v = struct[col]
				types[x] = (v ~= nil) and type(v)
			end
			local alias = aliases[col]
			local tp = types and types[x]
			if v then
				if alias and alias[v] then
					v = alias[v]
				end
				if tp == "boolean" then
					struct[col] = not boolFalse[v]
				elseif tp == "number" then
					struct[col] = assert(tonumber(v), "not a number")
				elseif tp == "string" then
					struct[col] = v
				else
					assert(false)
				end
			elseif not v then
				local ret = struct[col]
				errorinfo(('%s - value %s'):format(errorinfo(), tostring2(ret)))
				if alias then
					alias = aliasInv[col] or table.invert(alias)
					aliasInv[col] = alias
					ret = alias[ret] or ret
				end
				return tostring(boolToStr[ret] or assert(ret))
			end
		end
	end
	
	if not str then
		-- set up columns in the right order
		local struct = arr[arr.low]
		local max = -1
		local fields = {}
		for a, b in pairs(offs) do
			if b > max then
				max = b
			end
			if ignore[a] then
				-- skip
			elseif type(struct[a]) ~= "table" then
				local ft = fields[b] or {}
				fields[b] = ft
				ft[#ft + 1] = a
			end
		end
		
		local j = 0
		for i = 0, max, 0.125 do
			if fields[i] then
				local t = fields[i]
				table.sort(t)
				for k = #t, 1, -1 do  -- order for R, G, B
					j = j + 1
					cols[j] = t[k]
				end
			end
		end
		t.ColCount = j
	end

	if resisable then
		arr.count = 0
	else
		t.RowCount = baseCount + 1
	end
	
	local ret = ReadWriteTable(f, t, str, cleanup)
	cleanup()
	return ret
end


local ClassKindNames = {}
do
	local cname = table.invert(const.Class)
	local step = mmv(3, 4, 2)
	for i = 0, #cname do
		ClassKindNames[i] = cname[i*step]
	end
end

function DataTables.HPSP(str)
	local SPStatNames = {[0] = "-", "I", "P", "IP"}
	local SPStatNums = {["-"] = 0, I = 1, P = 2, PI = 3, IP = 3}
	local step = mmv(3, 4, 1)
	local function f(x, y, v)
		local t
		local n = step
		local ck = (step == 1) and Game.Classes or Game.ClassKinds
		if x == 1 then
			t = ck.HPBase
		elseif x == 2 then
			n, t = 1, Game.Classes.HPFactor
		elseif x == 3 then
			t = ck.SPBase
		elseif x == 4 then
			n, t = 1, Game.Classes.SPFactor
		elseif x == 5 then
			if v then
				Game.Classes.SPStats[y] = assert(SPStatNums[v:upper()])
				return
			else
				return assert(SPStatNames[Game.Classes.SPStats[y]])
			end
		end
		y = y / n
		if y % 1 ~= 0 then
			assert((v or "") == "")
			return ""
		end
		if v then
			t[y] = assert(tonumber(v))
		else
			return t[y]
		end
	end
	local t = {ColHeaders = {[0] = "Class", "HP Base", "HP Factor", "SP Base", "SP Factor", "SP Stats"}, ColCount = 5,
	           RowHeaders = table.invert(const.Class), RowCount = Game.Classes.HPFactor.count, RowLow = 0}
	return ReadWriteTable(f, t, str)
end

local SkillHeaders = {}
for v, i in pairs(const.Skills) do
	SkillHeaders[i] = v --("%s  %s"):format(i, v)
end

if mmver ~= 6 then
	function DataTables.Skills(str)
		local NumToStr = {[0] = "-", "B", "E", "M", "G"}
		local StrToNum = table.invert(NumToStr)
		local function f(c, sk, v)
			if v then
				Game.Classes.Skills[c][sk] = assert(StrToNum[v:upper()])
			else
				return assert(NumToStr[Game.Classes.Skills[c][sk]])
			end
		end
		local t = {ColHeaders = table.invert(const.Class), ColCount = Game.Classes.Skills.count, ColLow = 0,
		           RowHeaders = SkillHeaders, RowCount = Game.Classes.Skills[0].count, RowLow = 0}
		return ReadWriteTable(f, t, str)
	end
end

function DataTables.StartingSkills(str)
	local NumToStr
	if mmver == 6 then
		NumToStr = {[0] = "-", "F", "C", "a"}
	else
		NumToStr = {[0] = "-", "C", "F"}
	end
	local StrToNum = table.invert(NumToStr)
	local function f(c, sk, v)
		if v then
			Game.ClassKinds.StartingSkills[c][sk] = assert(StrToNum[v])
		else
			return assert(NumToStr[Game.ClassKinds.StartingSkills[c][sk]])
		end
	end
	local t = {ColHeaders = ClassKindNames, ColCount = Game.ClassKinds.StartingSkills.count, ColLow = 0,
						 RowHeaders = SkillHeaders, RowCount = Game.ClassKinds.StartingSkills[0].count, RowLow = 0}
	return ReadWriteTable(f, t, str)
end


if mmver == 6 then
	function DataTables.StartingStats(str)
		local function f(c, s, v)
			if v then
				Game.ClassKinds.StartingStats[c][s] = assert(tonumber(v))
			else
				return Game.ClassKinds.StartingStats[c][s]
			end
		end
		local t = {ColHeaders = ClassKindNames, ColCount = Game.ClassKinds.StartingStats.count, ColLow = 0,
							 RowHeaders = table.invert(const.Stats), RowCount = 7, RowLow = 0}
		return ReadWriteTable(f, t, str)
	end
else
	local ck = (mmver == 7) and Game.Races or Game.Classes
	local names = {[0] = "Base", "Max", "Add", "Spend"}
	function DataTables.StartingStats(str)
		local function f(c, s, v)
			local n = s % 2
			s = (s - n) / 2
			n = n*2
			if v then
				local v1, v2 = string.match(v, "^([^/]*)/([^/]*)$")
				if n ~= 0 and v1 == nil then
					v1, v2 = string.match(v, "^[^/]*$"), 1
				end
				assert(v1)
				ck.StartingStats[c][s][names[n]] = assert(tonumber(v1))
				ck.StartingStats[c][s][names[n+1]] = assert(tonumber(v2))
			else
				local v1, v2 = ck.StartingStats[c][s][names[n]], ck.StartingStats[c][s][names[n+1]]
				if v1 ~= 0 and v2 == 1 then
					return v1
				else
					return ("%s/%s"):format(v1, v2)
				end
			end
		end
		local stat = table.invert(const.Stats)
		local rows = {}
		for i = 0, 6 do
			rows[i*2] = stat[i]
			rows[i*2 + 1] = "+ add"
		end
		local t = {ColHeaders = (mmver == 7 and table.invert(const.Race) or table.invert(const.Class)),
		           ColCount = ck.StartingStats.count, ColLow = 0,
							 RowHeaders = rows, RowCount = 7*2, RowLow = 0}
		return ReadWriteTable(f, t, str)
	end
end

function DataTables.TownPortal(str)
	local ColHeaders = {[0] = "#", "Map", "X", "Y", "Z", "Direction", "LookAngle", "Icon X", "Icon Y", "Icon Width", "Icon Height"}
	local function f(x, y, v)
		if x <= 6 then
			if v then
				Game.TownPortalInfo[y][ColHeaders[x]] = x == 1 and tostring(v) or assert(tonumber(v))
			else
				return Game.TownPortalInfo[y][ColHeaders[x]]
			end
		else
			local t
			if x == 7 then
				t = Game.TownPortalX
			elseif x == 8 then
				t = Game.TownPortalY
			elseif x == 9 then
				t = Game.TownPortalWidth
			elseif x == 10 then
				t = Game.TownPortalHeight
			end
			if v then
				t[y] = assert(tonumber(v))
			else
				return t[y]
			end
		end
	end
	local t = {ColHeaders = ColHeaders, ColCount = (mmver == 8 and 8 or 10), RowCount = 6, RowLow = 0}
	return ReadWriteTable(f, t, str)
end

function DataTables.HouseMovies(str)
	local alias = table.copy(const.HouseType, {[""] = 29})
	local aliasInv = table.copy(const.HouseTypeInv, {[29] = ""})
	local t = {Alias = {HouseType = alias}, AliasInv = {HouseType = aliasInv}}
	if mmver ~= 6 then
		t.IgnoreFields = {Background = true}
	end
	return DataTables.StructsArray(Game.HouseMovies, structs.o.HouseMovie, t, str)
end

-----------------------------------------------------
-- Update
-----------------------------------------------------

function DataTables.UpdateGroupEndBits(a)
	local notEnd = false
	local low = a.low
	for i = a.high, a.low, -1 do
		local el = a[i]
		el.NotGroupEnd = notEnd
		notEnd = not el.GroupStart
	end
end

function DataTables.UpdateGroupTimes(a)
	local sum = 0
	local low = a.low
	local NotGroup
	for i = a.high, low, -1 do
		local el = a[i]
		if el.GroupStart then
			el.TotalTime = sum + el.Time
			sum = 0
		else
			sum = sum + el.Time
			el.TotalTime = 0
		end
	end
end

function DataTables.UpdateSFTGroups()
	local n = 0
	local groups = {}
	local groupId = {}
	local groupPtr = {}
	local SFT = Game.SFTBin
	for i, a in SFT.Frames do
		local name = a.GroupName
		if a.GroupStart then
			name = name:lower()
			groupId[name] = i
			n = n + 1
			groups[n] = name
			groupPtr[name] = a["?ptr"]
		end
	end
	table.sort(groups)
	if n > SFT.Groups.Count then
		local n1 = SFT.Groups.Count
		mem.reallocMM(SFT.Groups, n1*4, n*4)
		mem.reallocMM(SFT.GroupIndex, n1*2, n*2)
	end
	SFT.Groups.Count = n
	for i = 1, n do
		local s = groups[i]
		SFT.GroupIndex[i - 1] = groupId[s]
		SFT.Groups[i - 1]["?ptr"] = groupPtr[s]
	end
	DataTables.UpdateGroupEndBits(SFT.Frames)
	DataTables.UpdateGroupTimes(SFT.Frames)
end

function DataTables.UpdatePFTGroups()
	DataTables.UpdateGroupEndBits(Game.PFTBin)
	DataTables.UpdateGroupTimes(Game.PFTBin)
end

function DataTables.UpdateIFTGroups()
	DataTables.UpdateGroupEndBits(Game.IFTBin)
	DataTables.UpdateGroupTimes(Game.IFTBin)
end

function DataTables.UpdateTFTGroups()
	DataTables.UpdateGroupEndBits(Game.TFTBin)
	DataTables.UpdateGroupTimes(Game.TFTBin)
end

function DataTables.STFToBin()
	local SFT = Game.SFTBin
	local s1 = mem.string(SFT["?ptr"], 8, true)
	local s2 = mem.string(SFT.Frames["?ptr"], SFT.Frames.size, true)
	local s3 = mem.string(SFT.GroupIndex["?ptr"], SFT.GroupIndex.size, true)
	return s1..s2..s3
end

local BinCountBuf = mem.StaticAlloc(4)

function DataTables.ToBin(t)
	mem.u4[BinCountBuf] = t.count
	return mem.string(BinCountBuf, 4, true)..mem.string(t["?ptr"], t.size, true)
end

-----------------------------------------------------
-- ComputeRowCountInPChar
-----------------------------------------------------

local FindSymProc = mem.asmproc[[
	; (p, p2, char)
	; Finds specified symbol at addresses from p to p2-1
	
	; With actual __fastcall:
	; mov eax, ecx
	; pop ecx
	; With LuaJIT's buggy __fastcall and my mem.call(ptr, 3, ...):
	xchg eax, ecx
	
	; eax = p
	; edx = p2
	; cl = symbol
	
	cmp eax, edx
	jz @exit
@loop:
	cmp [eax], cl
	jz @exit
	inc eax
	cmp eax, edx
	jnz @loop
@exit:
	ret
]]
-- FindSymProc = ffi.cast("void*", FindSymProc);
-- FindSymProc = ffi.cast("int (__fastcall *)(int,int,int)", FindSymProc);  -- (p, p2, char)  -- BUGGED in jit.on() mode
local call = mem.call
local function FindSymbol(p, p2, c)
	return call(FindSymProc, 3, p, p2, c)
end

function DataTables.ComputeRowCountInPChar(p, MinCols, NeedCol)
	local function GetCount(p2, c, f)
		local n = 1
		while not f(FindSymbol(p, p2, c), n) and p < p2 do
			n = n + 1
		end
		return n
	end
	
	local HasNeedCol = true
	
	local function TabCountF(p1, n)  -- count tab symbols
		if n == NeedCol then
			HasNeedCol = (p ~= p1)
		end
		p = p1 + 1
	end
	
	local r = 0
	GetCount(FindSymbol(p, 0, 0), 13, function(p1, row)
		local n = GetCount(p1, 9, TabCountF)
		if n < MinCols then  -- can't be read
			return true
		elseif HasNeedCol then  -- has something useful
			r = row
		end
		p = p1 + 2
	end)
	return r
end

-----------------------------------------------------
-- BasicTable
-----------------------------------------------------

function DataTables.ReadBasicTable(s)
	local t = s:split("\r\n", true)
	for i = 1, #t do
		t[i] = t[i]:split("\t", true)
	end
	return t
end

function DataTables.WriteBasicTable(t)
	local q = {}
	for i = 1, #t do
		q[i] = table.concat(t[i], "\t")
	end
	return table.concat(q, "\r\n")
end
