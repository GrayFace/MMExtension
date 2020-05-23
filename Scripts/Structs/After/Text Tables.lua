local type = type
local unpack = unpack
local assert = assert
local format = string.format
local string_byte = string.byte
local string_sub = string.sub
local string_match = string.match
local string_split = string.split
local io_load = io.load
local io_save = io.save

local next = next
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local tostring = tostring
local rawget = rawget
local rawset = rawset
local getfenv = getfenv
local setfenv = setfenv
local pcall = pcall
local xpcall = xpcall
local getmetatable = debug.getmetatable
local setmetatable = setmetatable
local d_setmetatable = debug.setmetatable
local os_time = os.time
local debug_getinfo = debug.getinfo
local loadfile = loadfile
local loadstring = loadstring
local table_insert = table.insert
local table_remove = table.remove
local table_concat = table.concat
local table_copy = table.copy
local table_invert = table.invert
local min = math.min
local max = math.max
local abs = math.abs
local dofile = dofile
local tget = tget

local _G = _G

----------- No globals from this point ------------

local _NOGLOBALS

---------------------------------------------------

local function ParseAny(s, t, ...)
	local f = assert(loadstring(s))
	setfenv(f, t or {})
	return f(...)
end

local SpecSymbols = table_invert{"$", "#", "-", "=", "{", "*"}
local function SpecSym(s)
	local t = {}
	for i = -1, -1/0, -1 do
		local c = string_sub(s, i, i)
		if SpecSymbols[c] then
			t[c] = true
		elseif t["-"] then
			return "", t
		else
			return string_sub(s, 1, i), t
		end
	end
end

local function ParseVal(v, sym, t)
	if sym["*"] then
		return ParseAny(v, t)
	elseif sym["$"] and not sym["#"] then
		return v
	elseif not sym["-"] then
		return tonumber(v) or ParseAny("return "..v)
	end
end

local function AssignToName(t, s, v, fmt)
	if s == "" then
		return
	elseif string_sub(s, 1, 1) ~= "[" then
		s = "."..s
	end
	return ParseAny(format(fmt or "local t, v = ...; t%s = v", s, s, s), {}, t, v)
end

local function AssignVal(k, v, sym, t)
	v = ParseVal(v, sym, t)
	AssignToName(t, k, v)
end

local function ParseTextTable(s, r, SkipEmpty, AssignTables)
	r = r or {}
	local t1 = string_split(s, "\r\n", true)
	local ht = string_split(t1[1], "\t", true)
	local BaseR = r
	local LastR = {}
	for i = 1, #t1 - 1 do
		local t = string_split(t1[i + 1], "\t", true)
		local rt = {}
		local KeySym
		for j = 1, min(#ht, #t) do
			local v, k, sym = t[j], SpecSym(ht[j])
			if sym["="] then
				if type(i) == "number" then
					i, KeySym = SpecSym(v)
				else
					table_copy(KeySym, sym, true)
					if sym["{"] then
						if sym["#"] or sym["*"] then
							AssignVal(i, v, sym, r)
						end
						LastR[#LastR + 1] = r
						if AssignTables then
							r = AssignToName(r, i, nil, "local t = ...; local v = {}; t%s = v; return v")
						else
							r = AssignToName(r, i, nil, "local t = ...; local v = t%s;  if v == nil then  v = {}; t%s = v;  end; return v")
						end
						-- for k = j, #t do
						-- 	AssignVal(k - j + 1, t[k], sym, rt)
						-- end
					elseif i == "}" then
						r = LastR[#LastR]
						LastR[#LastR] = nil
					else
						AssignVal(i, v, sym, r)
					end
					i = ""
					break
				end
			else
				AssignVal(k, v, sym, rt)
			end
		end
		if type(i) ~= "number" then
			AssignToName(r, i, rt)
		elseif not SkipEmpty or next(r) then
			r[i] = rt
		end
	end
	return BaseR
end
_G.ParseTextTable = ParseTextTable

function _G.LoadTextTable(s, r, SkipEmpty, AssignTables)
	return ParseTextTable(io_load(s), r, SkipEmpty, AssignTables)
end


local function ParseBasicTextTable(s, StartingLinesCount)
	local t, s = string_split(s, "\r\n", true), nil
	for i = (StartingLinesCount or 0) + 1, #t do
		s = t[i]
		t[i] = string_split(s, "\t", true)
	end
	if s == '' then
		t[#t] = nil
	end
	return t
end
_G.ParseBasicTextTable = ParseBasicTextTable

function _G.LoadBasicTextTable(s, StartingLinesCount)
	return ParseBasicTextTable(io_load(s), StartingLinesCount)
end

local function WriteBasicTextTable(t, fname)
	if fname then
		return io_save(fname, WriteBasicTextTable(t))
	end
	local q, s = {}, ''
	for i = 1, #t do
		s = (type(t[i]) == "table" and table_concat(t[i], "\t") or t[i])
		q[i] = s
	end
	if s ~= '' then
		q[#q + 1] = ''
	end
	return table_concat(q, "\r\n")
end
_G.WriteBasicTextTable = WriteBasicTextTable


local function ParseNumbersTextTable(s, StartingLinesCount)
	local t = string_split(s, "\r\n", true)
	for i = (StartingLinesCount or 0) + 1, #t do
		local t1 = string_split(t[i], "\t", true)
		for k, v in ipairs(t1) do
			t1[k] = tonumber(v) or ParseAny("return "..v)
		end
		t[i] = t1
	end
	return t
end
_G.ParseNumbersTextTable = ParseNumbersTextTable

function _G.LoadNumbersTextTable(s, StartingLinesCount)
	return ParseNumbersTextTable(io_load(s), StartingLinesCount)
end


local function ParseNamedColTable(s)
	local t, s = string_split(s, "\r\n", true), nil
	local names = string_split(t[1], "\t", true)
	t[0] = string_split(t[1], "\t", true)
	for i = 1, #t - 1 do
		s = t[i + 1]
		local q = string_split(s, "\t", true)
		local q2 = {}
		for i, k in ipairs(names) do
			q2[k] = q[i]
		end
		t[i] = q2
	end
	t[#t] = nil
	if s == '' then
		t[#t] = nil
	end
	return t
end
_G.ParseNamedColTable = ParseNamedColTable

function _G.LoadNamedColTable(s)
	return ParseNamedColTable(io_load(s))
end

local function WriteNamedColTable(t, fname)
	if fname then
		return io_save(fname, WriteNamedColTable(t))
	end
	local names = t[0]
	local a = {}
	local q = {table_concat(names, "\t")}
	for i, v in ipairs(t) do
		if type(v) == "table" then
			for j, s in ipairs(names) do
				a[j] = v[s] or ""
			end
			q[i+1] = table_concat(a, "\t")
		else
			q[i+1] = v
		end
	end
	if q[#q] ~= '' then
		q[#q + 1] = ''
	end
	return table_concat(q, "\r\n")
end
_G.WriteNamedColTable = WriteNamedColTable


function _G.TransposeTextTable(t)
	local new = {}
	for k1, _t in pairs(t) do
		for k, v in pairs(_t) do
			tget(new, k)[k1] = v
		end
	end
	return new
end


local LodTextTables = setmetatable({}, {__index = function(t, fname)
	local s = _G.Game.LoadTextFileFromLod(fname)
	local v = s and ParseBasicTextTable(s) or {}
	for _, t in pairs(v) do
		for i, s in pairs(t) do
			s = string_match(s, '^"(.*)"$')
			if s then
				t[i] = s
			end
		end
	end
	t[fname] = v
	return v
end})

function _G.ReadLodTextTable(fname, row, col)
	local t = LodTextTables[fname:lower()]
	if row and t then
		t = t[row]
		if col and t then
			t = t[col]
		end
	end
	return t
end	

