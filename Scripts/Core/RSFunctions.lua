local type = type
local unpack = unpack
local error = error
local assert = assert
local format = string.format
local string_byte = string.byte
local string_sub = string.sub
local string_gsub = string.gsub
local string_find = string.find
local string_lower = string.lower
local string_upper = string.upper

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
local pcall2
local os_time = os.time
local loadfile = loadfile
local loadstring = loadstring
local table_insert = table.insert
local table_remove = table.remove
local table_concat = table.concat
local table_sort = table.sort
local co_yield = coroutine.yield
local co_running = coroutine.running
local io_open = io.open
local select = select
local getmetatable = debug.getmetatable
local d_setmetatable = debug.setmetatable
local d_getinfo = debug.getinfo
local d_getupvalue = debug.getupvalue
local d_setupvalue = debug.setupvalue
local d_getlocal = debug.getlocal

local _KNOWNGLOBALS_F = nil, path

--------- table

-- Swaps order of the array. 'min' and 'max' default to 1 and !'[[#t]] respectively
local function table_swap(t, min, max)
	min = min or 1
	max = max or #t
	for i = 1, (max - min + 1)/2 do
		t[min], t[max] = t[max], t[min]
		min, max = min + 1, max - 1
	end
end
table.swap = table_swap

-- Moves an element from one index to another
local function table_move(t, from, to)
	local it = t[from]
	if from < to then
		for i = from, to - 1 do
			t[i] = t[i+1]
		end
	elseif from > to then
		for i = from, to + 1, -1 do
			t[i] = t[i-1]
		end
	end
	t[to] = it
end
table.move = table_move

-- Performs shallow copy. If 'dest' = 'nil', a new table is created
function table.copy(src, dest, overwrite)
	if not dest or overwrite then
		dest = dest or {}
		for k,v in pairs(src) do
			dest[k] = v
		end
	else
		for k,v in pairs(src) do
			if dest[k] == nil then
				dest[k] = v
			end
		end
	end
	return dest
end

-- Finds value 'v', returns corresponding key
function table.find(t, v)
	for k, v1 in pairs(t) do
		if v1 == v then
			return k
		end
	end
end

-- Finds value 'v' in array part of the table, returns first match. Uses raw access ('rawget')
function table.ifind(t, v, start)
	local k = start or 1
	while true do
		local v1 = rawget(t, k)
		if v1 == v then
			return k
		elseif v1 == nil then
			return
		end
		k = k + 1
	end
end

-- Swaps keys and values
function table.invert(t, out)
	out = out or {}
	for k, v in pairs(t) do
		out[v] = k
	end
	return out
end

-- Removes all elements from the table
function table.clear(t)
	for k in pairs(t) do
		t[k] = nil
	end
end

-- Adds 't1' array to the end of 't'
function table.join(t, t1)
	local n = #t
	for i, v in ipairs(t1) do
		t[i + n] = v
	end
	return t
end

--------- coroutine

-- 'n' times in a raw calls !Lua[[coroutine.yield(...)]]. Returns the result of last call
function coroutine.yieldN(n, ...)
	if n >= 1 then
		for i = 2, n do
			co_yield(...)
		end
		return co_yield(...)
	end
end

--------- path

path = {}

local string_match = string.match

-- Extracts extension (e.g. returns !Lua[[".txt"]] etc.)
function path.ext(s)
	return string_match(s, "%.[^%.\\/:]*$") or ""
end

-- Changes extension (e.g. !Lua[[path.setext("my.txt", "_2.txt") == "my_2.txt"]])
function path.setext(s, ext)
	return (string_match(s, "(.*)%.[^%.\\/:]*$") or s)..ext
end

-- Extracts file name
function path.name(s)
	return string_match(s, "[^\\/:]*$")
end

-- Extracts file path including trailing slash
function path.dir(s)
	return string_match(s, "(.*[\\/:]).-$") or ""
end


local slash1, slash2 = string_byte('/', 1), string_byte('\\', 1)

-- Adds trailing slash
function path.addslash(s)
	local c = string_byte(s, #s)
	if c == slash1 or c == slash2 then
		return s
	end
	return s.."/"
end

-- Removes trailing slash (or multiple slashes)
function path.noslash(s)
	for i = #s, 0, -1 do
		local c = string_byte(s, i)
		if c ~= slash1 and c ~= slash2 then
			return string_sub(s, 1, i)
		end
	end
end

--------- io

-- Saves a string into a file (overwrites it)
function io.save(path, s, translate)
	local f = assert(io_open(path, translate and "wt" or "wb"))
	f:setvbuf("no")
	f:write(s)
	f:close()
end

-- Loads a file as a string
function io.load(path, translate)
	local f = assert(io_open(path, translate and "rt" or "rb"))
	local s = f:read("*a")
	f:close()
	return s
end

local function print1(t, n, arg, ...)
	if n ~= 0 then
		t[#t + 1] = tostring(arg)
		if n ~= 1 then
			t[#t + 1] = "\t"
			return print1(t, n - 1, ...)
		end
	end
end

-- Makes 'print' function write into a file specified by 'fname'. Specifying 'Windows = true' forces use of \r\n and speeds it up a bit on Windows. Returns a function that returns current state of the log when called: 'SomethingWritten', 'fname'
function PrintToFile(fname, Windows, preserve)

	local opened
	
	local function doprint(...)
		local f = assert(io_open(fname, (opened and "a" or "w")..(Windows and "b" or "t")))
		opened = true
		local t = {}
		print1(t, select('#', ...), ...)
		t[#t + 1] = "\n"
		f:write((string_gsub(table_concat(t), "\r?\n", Windows and "\r\n" or "\n")))
		f:close()
	end
	if not preserve then
		print = doprint
	end
	
	return doprint, function()
		return opened, fname
	end
end

-- string

-- returns the string that 'print' function would normally print out
function string.print(...)
	local t = {}
	print1(t, select('#', ...), ...)
	return table_concat(t)
end

-- Returns a table of strings. 'delim' can be a plain string ('plain' = 'true') or a pattern
function string.split(str, delim, plain)
	local t, i, n = {}, 1, 1
	repeat
		local n1, n2 = string_find(str, delim, n, plain)
		t[i] = string_sub(str, n, n1 and n1 - 1)
		n, i = n2 and n2 + 1, i + 1
	until n == n1
	return t
end

do
	local string_split = string.split
	local compiled = {}

	-- Any character from 'charlist' string is a delimiter
	function string.csplit(str, charlist)
		local d = charlist or " "
		local delim = compiled[d]
		if delim == nil then
			delim = format("[%s]", string_gsub(d, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0"))
			compiled[d] = delim
		end
		return string_split(str, delim)
	end
end

-- Parameters are treated as plain strings, not patterns
function string.replace(str, old, new, IgnoreCase)
	old = string_gsub(old, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
	if IgnoreCase then
		old = string_gsub(old, "%a", function(c)
			return format("[%s%s]", string_lower(c), string_upper(c))
		end)
	end
	old = string_gsub(old, "%z", "%%%z")
	local tp = type(new)
	if tp == "string" or tp == "number" then
		new = string_gsub(new, "%%", "%%%%")
	end
	return string_gsub(str, old, new)
end

-- sortpairs

do
	local types = {
		number = 1,
		boolean = 2,
		string = 3,
		userdata = 4,
		table = 5,
		["function"] = 6,
		thread = 7,
	}

	local function rawcompare(a, b)
		return a < b
	end

	local function compare(a, b)
		local t1, t2 = type(a), type(b)
		if t1 ~= t2 then
			return types[t1] < types[t2]
		elseif t1 == "number" or t1 == "string" then
			return a < b
		else
			local ok, ret = pcall(rawcompare, a, b)
			if ok then
				return ret
			else
				return tostring(a) < tostring(b)
			end
		end
	end

	-- Returns 'pairs' in ascending order with the following comparison rule:  number < boolean < string < userdata < table < function < thread
	function sortpairs(t)
		local order = {}
		local i = 1
		for k in next, t do -- pairs(t) do
			order[i] = k
			i = i + 1
		end
		table_sort(order, compare)
		i = 0
		return function()
			i = i + 1
			local k = order[i]
			return k, rawget(t, k) -- t[k]
		end
	end
end

-- debug

local function DebugFind(Name, f, param)
	local name, val
	local up = 0
	repeat
		up = up + 1
		name, val = f(param, up)
	until name == Name or name == nil
	return name and up, val
end

-- Returns 'index', 'value' of an upvalue with the given name, or 'nil' if it doesn't exist
function debug.findupvalue(f, name)
	return DebugFind(name, d_getupvalue, f)
end

-- Returns 'index', 'value' of a local variable with the given name, or 'nil' if it doesn't exist
function debug.findlocal(thread, lev, name)
	if name then  -- 'thread' parameter specified
		if co_running() == thread then
			lev = lev + 3
		end
		local function f(thread, n)
			local n, v = d_getlocal(thread, lev, n)
			return n, v  -- because tail calls may or may not change stack level depending on version
		end
		local n, v = DebugFind(name, f, thread)
		return n, v
	end
	local n, v = DebugFind(lev, d_getlocal, thread + 2)
	return n, v
end

-- If 'cache' = 'true', upvalue indexes are cached.
-- Usage:
-- 1) !Lua[[v = debug.upvalues(f).upvalue_name]]
-- 2) !Lua[[debug.upvalues(f).upvalue_name = v]]
-- 3) !Lua[[for k, v in debug.upvalues(f) do  print(k, v)  end]]
function debug.upvalues(f, cache)
	local t, last, lastN = cache and {}, nil, nil
	return setmetatable({}, {
		__index = function(_, k)
			local n, v = t and t[k]
			if n then
				v = d_getupvalue(f, n)
			else
				n, v = DebugFind(k, d_getupvalue, f)
				if t and n then
					t[k] = n
				end
			end
			return v
		end,
		__newindex = function(_, k, v)
			local n = t and t[k]
			if not n then
				n = DebugFind(k, d_getupvalue, f)
				if t then
					t[k] = n
				end
			end
			d_setupvalue(f, n, v)
		end,
		__call = function(_, __, k)
			local n = (k == nil and 0 or k == last and lastN or t[k] or DebugFind(k, d_getupvalue, f)) + 1
			local k, v = d_getupvalue(f, n)
			last, lastN = k, n
			if t and k then
				t[k] = n
			end
			return k, v
		end
	})
end
