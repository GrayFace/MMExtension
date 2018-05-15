--[[----------------------------------------------------------------------------

RSPersist v0.1
Copyright(c) 2009 - 2010 Sergey Rozhenko aka GrayFace (sergroj@mail.ru)
http://sites.google.com/site/sergroj/
Distributed AS IS under the same license as Lua 5.

Pure Lua persistance library. Stores Lua data in a binary string.
- Only pure Lua is required, with standard libraries.
- May work without debug library, but won't persist protected metatables.
- Supports permanent objects table.
- Output string size is very small.
- Presisely stores any number. Correctly handles infinities and NAN, but doesn't distinguish between kinds of NAN.
- Supports unusual lua_Number types, like (long double) and (long long).
- Can persist functions without upvalues.
- Can persist functions with upvalues if debug.upvalueid and debug.upvaluejoin are present.
- Doesn't persist C functions, threads and userdata.
- Persistance can be controlled by __persist value in metatable, but custom persistance functions aren't supported

Persist:
Stores the given object in a string.
Usage: string, [error string] = persist(object, [inversed permanents table])
"inversed permanents table" is a table with permanents as keys and their meppings as values

Unpersist:
Loads stored object from string.
object, [errors] = unpersist(string, [permanents table], [offset])
"permanents table" is a table with mapped values as keys and permanents as values
offset defines the offset from the beginning of string at which the data is stored (1 by default)

__persist values in metatables of tables and userdata:
nil, true = normal persistance,
false = report an error,
0 = persist as nil.

Example:

PermanentsLoad = {_G, pairs, ipairs, ["string.format"] = string.format}
for k, v in pairs(PermanentsLoad) do
	PermanentsSave[v] = k
end

local data, e = persist({example = "table"}, PermanentsSave)
if e then
  print("persist error: "..e)
end

data, e = unpersist(data, PermanentsLoad)
if e then
  print("unpersist error: "..e)
end
assert(data.example == "table")

Advices:

- If you want to persist several objects, create a table for them and persist it in a single call.
- Add all standard functions to permanents table.
- Even if you think a function can only be accessed internally, it won't hurt to add it to permanents table.
- Be careful not to change order of numerical indexes in permanents table when you update it.
- When you need to create keys consisting of two or more strings, an easy way to do this is by concatinating
  format("%q") representations of them. This will lead to 1-to-1 correspondence between the key and the strings.

--]]----------------------------------------------------------------------------

-- numbers: 1 - 56
local type_str = 57

local concat = table.concat
local insert = table.insert
local type = type
local getmetatable = debug and debug.getmetatable or getmetatable
local setmetatable = setmetatable
local next = next
local rawget = rawget
local rawset = rawset
local rawequal = rawequal
local tostring = tostring
local ldexp, frexp = math.ldexp, math.frexp
local char, byte = string.char, string.byte
local string_sub = string.sub
local format = string.format
local f_dump, loadstring = string.dump, loadstring
local setfenv = debug.setfenv or setfenv
local getfenv = debug.getfenv or getfenv
local setupvalue = debug.setupvalue
local upvaluejoin = setupvalue and debug.upvaluejoin
local getupvalue = debug.getupvalue
local upvalueid = upvaluejoin and getupvalue and debug.upvalueid
local HUGE = math.huge
local NAN = HUGE - HUGE

------------ Persist ------------

local function dopersist(t, perm)
	local _NOGLOBALS
	perm = perm or {[getfenv(dopersist)] = 1}
	local list, listN = {}, 0
	local tables, tablesN = {}, 0
	local funcs, funcsN = {}, 0
	local firsterror
	local nanId
	
	-- First construct objects lists
	
	local function needpersist(o)
		local m = getmetatable(o)
		local per
		if type(m) == "table" then
			per = m.__persist
		end
		if per == nil or per == true then
			return true
		elseif per == false then
			firsterror = firsterror or 'attempt to persist an object with __persist = false'
		elseif per ~= 0 then
			firsterror = firsterror or 'custom persistance is not supported yet'
		end
	end

	local function newval(t, a, v)
		local tp = type(a)
		if tp ~= "table" and tp ~= "function" and tp ~= "userdata" or perm[a] ~= nil then
			listN = listN + 1
			list[listN] = a
		elseif tp == "table" then
			if needpersist(a) then
				tablesN = tablesN + 1
				tables[tablesN] = a
			end
		elseif tp == "function" then
			funcsN = funcsN + 1
			funcs[funcsN] = a
		else
			if needpersist(a) then
				listN = listN + 1
				list[listN] = a
			end
		end
		return rawset(t, a, v)
	end

	local vals = setmetatable({}, {__newindex = newval})

	-- Also construct list of upvalues:
	-- 'uplist' will be array of upvalue values
	-- 'upvals' will map upvelue to index in the 'uplist'
	-- 'nups' will keep upvalues count for functions
	
	local uplist, uplistN = {}, 0
	local nups = {}
	
	local function newupval(t, a)
		uplistN = uplistN + 1
		rawset(t, a, uplistN)
		return uplistN
	end
	
	local upvals = setmetatable({}, {__index = newupval})
	
	-- traverse tables and functions
	if t then
		vals[t] = true
	end

	local n, m = 1, 1
	
	while true do
		if n <= tablesN then
			local t = tables[n]
			local v = getmetatable(t)
			if type(v) == "table" then
				vals[v] = 0
			end
			for k, v in next, t do
				vals[k] = 0
				if v == nil then
					-- do nothing
				elseif rawequal(v, v) or type(v) ~= "number" then
					vals[v] = 0
				elseif nanId == nil then  -- NAN
					listN = listN + 1
					list[listN] = v
					nanId = listN
				end
			end
			n = n + 1
		elseif m <= funcsN then
			local f = funcs[m]
			local v = getfenv(f)
			if v ~= nil then
				vals[v] = 0
			end
			if getupvalue then
				local i = 1
				local a
				a, v = getupvalue(f, i)
				if a == nil then
					-- do nothing
				elseif not upvalueid then
					firsterror = firsterror or "cannot persist a function with upvalues due to absense of debug.upvalueid"
				else
					repeat
						if v == nil then
							-- do nothing
						elseif rawequal(v, v) or type(v) ~= "number" then
							vals[v] = 0
						elseif nanId == nil then  -- NAN
							listN = listN + 1
							list[listN] = v
							nanId = listN
						end
						uplist[upvals[upvalueid(f, i)]] = v
						i = i + 1
						a, v = getupvalue(f, i)
					until a == nil
				end
				nups[f] = i - 1
			end
			m = m + 1
		else
			break
		end
	end

	setmetatable(vals, nil)
	
	for i = 1, listN do
		if i ~= nanId then
			vals[list[i]] = i
		end
	end
	for i = 1, funcsN do
		vals[funcs[i]] = i + listN
	end
	for i = 1, tablesN do
		vals[tables[i]] = i + listN + funcsN
	end

	-- Now 'vals' table maps object to its place in the objects list
	-- 'list' and 'tables' are lists of objects to persist
	
	-- Prepare to persist everything
	
	local function UintSize(n)
		local b = 1
		local ret = 0
		while n >= b do
			b = b*256
			ret = ret + 1
		end
		return ret
	end

	local totalN = listN + funcsN + tablesN
	local idxsize = UintSize(totalN)
	local upsize = UintSize(uplistN)
	
	local function UintToBytes(i, n)
		if n > 0 then
			local b = i % 256
			return b, UintToBytes((i - b) / 256, n - 1)
		end
	end
	
	local function UintToStr(i, n)
		return char(UintToBytes(i, n or idxsize))
	end
	
	-- Persist

	local data = {
		char(0),                        -- Version
		char(idxsize),                  -- idxsize
		UintToStr(t and vals[t] or 0),  -- ResultIndex
		UintToStr(listN),               -- SimpleCount
		UintToStr(funcsN),              -- FunctionsCount
		UintToStr(tablesN),             -- TablesCount
		UintToStr(0),                   -- SpecialsCount
		char(upsize)                    -- upidxSize
	}
	local dataN = #data
	local isPerm

	local function WriteType(t)
		dataN = dataN + 1
		data[dataN] = char(t + isPerm)
	end
	
	local function WriteUint(i, n)
		if n ~= 0 then
			dataN = dataN + 1
			data[dataN] = UintToStr(i, n)
		end
	end

	local function WriteObjIdx(v)
		if v ~= nil then
			v = vals[v]
			if v == nil then
				v = nanId
			end
		else
			v = 0
		end
		WriteUint(v)
	end
	
	local function WriteBasicType(tp)
		WriteType(0)
		WriteType(tp)
	end
	
	local function WriteNumber(n)
		if n == 0 then
			return WriteBasicType(0)
		elseif n == HUGE then
			return WriteBasicType(4)
		elseif n == -HUGE then
			return WriteBasicType(5)
		elseif n ~= n then  -- NAN
			return WriteBasicType(6)
		end
		
		local m, e
		if frexp then
			m, e = frexp(n)
			while m % 1 ~= 0 do
				m = m*256
				e = e - 8
			end
			while e < 0 and m % 2 == 0 do  -- minimize exp (if it's 0, we'll get integer)
				m = m / 2
				e = e + 1
			end
			e = e*2
			if e < 0 then
				e = -e - 1
			end
		else
			-- in case lua_Number is integer
			m, e = n, 0
		end
		local sign = m < 0
		if sign then
			m = -m
		end
		m = m - 1
		local mn, en = UintSize(m), UintSize(e)
		if mn == 0 then
			mn = 1
		end
		WriteType(mn + en*8 + (sign and 32 or 0))
		WriteUint(m, mn)
		WriteUint(e, en)
	end

	local function WriteString(s)
		local len = #s
		local tp = type_str + len
		if tp > 127 then
			WriteType(type_str)
			WriteUint(len, 4)
		else
			WriteType(tp)
		end
		dataN = dataN + 1
		data[dataN] = s
	end
	
	local function WriteNormalType(v)
		if v == false then
			return WriteBasicType(1)
		elseif v == true then
			return WriteBasicType(2)
		elseif v == "" then
			return WriteBasicType(3)
		end
		local t = type(v)
		if t == "number" then
			WriteNumber(v)
		elseif t == "string" then
			WriteString(v)
		else
			WriteBasicType(255)
			firsterror = firsterror or format('cannot persist%s objects of type "%s"', isPerm == 0 and "" or " permanent", t)
		end
	end

	-- write arbitary types
	for i = 1, listN do
		local v = list[i]
		isPerm = perm[v]
		if isPerm ~= nil then
			v = isPerm
			isPerm = 128
		else
			isPerm = 0
		end
		WriteNormalType(v)
	end

	-- write functions
	for i = 1, funcsN do
		local f = funcs[i]
		local s = f_dump(f)
		WriteUint(#s, 4)
		dataN = dataN + 1
		data[dataN] = s
		WriteObjIdx(getfenv(f))
		if upsize ~= 0 then
			local n = nups[f]
			WriteUint(n, upsize)
			for i = 1, n do
				WriteUint(upvals[upvalueid(f, i)], upsize)
			end
		end
	end
	
	-- write upvalues
	for i = 1, uplistN do
		WriteObjIdx(uplist[i])
	end
	
	-- write tables
	isPerm = 0
	for i = 1, tablesN do
		local t = tables[i]
		dataN = dataN + 1
		local tpn = dataN
		local tp = 0
		
		-- write array part
		local n, v = 1, rawget(t, 1)
		if v then
			repeat
				WriteObjIdx(v)
				n = n + 1
				v = rawget(t, n)
			until v == nil
			WriteUint(0)
			tp = tp + 1
		end
		n = n - 1
		
		-- write <key,value> part
		local HasPairs
		for k, v in next, t do
			if type(k) ~= "number" or k < 1 or k > n or k % 1 ~= 0 then
				WriteObjIdx(k)
				WriteObjIdx(v)
				HasPairs = true
			end
		end
		if HasPairs then
			WriteUint(0)
			tp = tp + 2
		end

		-- write metatable
		local m = getmetatable(t)
		if type(m) == "table" then
			WriteUint(vals[m])
			tp = tp + 4
		end
		
		data[tpn] = char(tp)
	end

	return concat(data), firsterror
end

persist = dopersist



------------ Unpersist ------------



function unpersist(buf, perm, data)
	local _NOGLOBALS
	local errors = {}
	perm = perm or {getfenv(dopersist)}
	data = data or 1  -- data is index of current read position
	local upvals = {}
	local upvalsN = 0

	local idxsize
	
	local function ReadUint(n)
		n = n or idxsize
		local b = 1
		local ret = 0
		for i = data, data + n - 1 do
			ret = ret + byte(buf, i)*b
			b = b*256
		end
		data = data + n
		return ret
	end
	
	local version = ReadUint(1) -- Version
	idxsize = ReadUint(1)       -- idxsize
	local mainIdx = ReadUint()  -- ResultIndex
	local listN = ReadUint()    -- SimpleCount
	local funcsN = ReadUint()   -- FunctionsCount
	local tablesN = ReadUint()  -- TablesCount
	local specN = ReadUint()    -- SpecialsCount
	local upsize = ReadUint(1)  -- upidxSize
	if version ~= 0 or specN ~= 0 then  insert(errors, "data was saved with a newer version of RSPersist")  end

	local firstTable = listN + funcsN + 1

	local function vals_index(t, a)
		if a >= firstTable then
			local v = {}
			t[a] = v
			return v
		end
	end
	local vals = setmetatable({}, {__index = vals_index})

	
	local function ReadBasicType()
		local v = ReadUint(1)
		if v == 0 then
			return 0
		elseif v == 1 then
			return false
		elseif v == 2 then
			return true
		elseif v == 3 then
			return ""
		elseif v == 4 then
			return HUGE
		elseif v == 5 then
			return -HUGE
		elseif v == 6 then
			return NAN
		elseif v ~= 255 then
			insert(errors, format("unknown basic type (%s) found", v))
		end
	end
	
	local function ReadNumber(tp)
		tp = tp - 1
		local mn, en
		if frexp then
			mn = tp % 8
			en = (tp % 32 - mn)/8
		else
			-- in case lua_Number is integer
			mn = tp % 32
			en = 0
		end
		local m = ReadUint(mn + 1) + 1
		if tp >= 32 then
			m = -m
		end
		local e = ReadUint(en)
		if e == 0 then
			return m
		end
		if e % 2 == 0 then
			e = e*(1/2)
		else
			e = -(e + 1)*(1/2)
		end
		return ldexp(m, e)
	end	
	
	local function ReadString(len)
		if len == 0 then
			len = ReadUint(4)
		end
		local s = string_sub(buf, data, data + len - 1)
		data = data + len
		return s
	end
	
	-- read simple types
	for i = 1, listN do
		local t = ReadUint(1)
		local isPerm = (t >= 128)
		if isPerm then
			t = t - 128
		end
		local v
		if t == 0 then
			v = ReadBasicType(t)
		elseif t < type_str then
			v = ReadNumber(t)
		else
			v = ReadString(t - type_str)
		end
		if isPerm and v ~= nil then
			local oldv = v
			v = perm[v]
			if v == nil then
				insert(errors, format("permanent object wasn't found: %s", type(oldv) == "string" and '"'..oldv..'"' or tostring(oldv)))
			end
		end
		vals[i] = v
	end
	local vbase = listN
	
	-- read functions
	local wasUpErr
	for i = 1, funcsN do
		local len = ReadUint(4)
		local s = string_sub(buf, data, data + len - 1)
		data = data + len
		local f = loadstring(s)
		vals[vbase + i] = f
		local v = vals[ReadUint()]
		if v ~= nil then
			setfenv(f, v)
		end
		local n = ReadUint(upsize)
		for i = 1, n do
			local k = ReadUint(upsize)
			local j = upvals[k*2]
			if j == nil then
				upvals[k*2 - 1] = f
				upvals[k*2] = i
				if upvalsN < k then
					upvalsN = k
				end
			elseif upvaluejoin then
				upvaluejoin(f, i, upvals[k*2 - 1], j)  -- assign the known upvalue for the function
			elseif not wasUpErr then
				wasUpErr = true
				insert(errors, "failed to set upvalues due to absense of debug.upvaluejoin")
			end
		end
	end
	vbase = vbase + funcsN

	-- read upvalues
	for i = 1, upvalsN do
		local v = ReadUint()
		if setupvalue then
			setupvalue(upvals[i*2 - 1], upvals[i*2], vals[v])
		end
	end
	
	-- read tables
	for i = 1, tablesN do
		local tp = ReadUint(1)
		local t = vals[vbase + i]
		if tp % 2 >= 1 then  -- read array part
			local v, n = ReadUint(), 1
			while v ~= 0 do
				t[n] = vals[v]
				v = ReadUint()
				n = n + 1
			end
		end
		if tp % 4 >= 2 then  -- read <key,value> part
			local k = ReadUint()
			while k ~= 0 do
				k = vals[k]
				if k ~= nil then
					t[k] = vals[ReadUint()]
				else
					ReadUint()
				end
				k = ReadUint()
			end
		end
		if tp % 8 >= 4 then  -- read metatable
			local m = vals[ReadUint()]
			if m ~= nil then
				setmetatable(t, m)
			end
		end
	end
	
	return vals[mainIdx], errors[1] and "Lua data loaded with errors:\n"..concat(errors, "\n") or nil
end


--[[

Format:

byte               Version
byte               idxsize
idx                ResultIndex
idx                SimpleCount
idx                FunctionsCount
idx                TablesCount
idx                SpecialsCount (reserved)
byte               upidxSize

simple types...
functions...
upvalues...
function environments...
tables...

idx is unsigned number of size (idxsize)
upidx is unsigned number of size (upidxsize)

==== simple types ====

byte type:
  0 :         0 - number 0, 1 - false, 2 - true, 3 - empty string, 4 - HUGE, 5 - -HUGE, 6 - NAN, 255 - nil
  1 - 56 :    number (not 0): sign*32 + (exp size)*8 + (mantiss size - 1) + 1
  57 :        variable length string
  58 - 127 :  string of length (type - 57)

---- number (not 0) ----
mantiss, exp. Both are unsigned integers.

converting from real mantiss, exp to stored:
if mantiss < 0 then  mantiss = abs(mantiss) - 1

if exp < 0 then  exp = abs(exp)*2 - 1     = (abs(exp) - 1)*2 + 1 
else             exp = exp*2

takes from 1 to 9 bytes
special numbers:
 infinity: mantiss = 0, exp = 1
 NAN: mantiss = 0, exp = 2

---- string ----
string of fixed length:
  string(Size)  String

length + string:
  u4            Size
  string(Size)  String

==== function ====



==== table ====

byte bits
  0 - 7:  +1 - has array part, +2 - has key/value part, +4 - has metatable

table array:
  for
    idx     Value
  end
  idx       Ending = 0

table key/value:
  for
    idx     Key
    idx     Value
  end
  idx       Ending = 0
	
table metatable:
  idx       Metatable

---- upvalues ----
upvalues are written right before the first table


]]
