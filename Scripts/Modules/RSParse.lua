--[=[
Pattern-based parser
(c) 2018 Sergey Rozhenko, MIT license

The technique employed is probably equivalent to "pushdown automaton", with addition of patterns and ability to extend it with callbacks. Good for not deep syntax analysis, like syntax highlighting.

See RSTemplates.lua for examples.

Parsing starts with the 'main' rule definition. If it isn't present, the whole rules table itself is assumed to be the only rule.
Each definition consists of a number of patterns. All are checked and the closest one is executed (the first one if multiple patterns matches start at the same position).
For convenience an extra 'ret' pattern can be specified, which is treated like it goes after the others and is equivalent to making a table with "ret" field.
Each pattern is a string, a function or a table with a string or a function as its first element. A function must use string.find protocol (without 'plain' param and capture returns).
A table is used for extra options: call, jmp, ret, import, nocache, capture1, capture2, run, (as well as anything useful for callbacks).
'split' function adds boolean 'split' field.
'gsub' function adds 'gsub' field with the replacement pattern. 'gpattern' is passed to string.gsub instead of normal pattern if specified. 'gcount' is also supported for a case when you specify 'gpattern' and want to process more than 1 match.
capture1, capture2 - capture indexes for start and stop of the match. E.g. {"[^%w]()or()[^%w]", capture1 = 1, capture2 = 2} would match the word "or" within a sentence, but not "orc" or "operator". You can even use bigger index for start capture than the stop one, which can be useful for a lookahead.

Note that importing rules is more efficient than copy-pasting.

Here's an example of parsing the command line:
local RSParse = require'RSParse'
local s = RSParse.gsub(CommandLine, {
	main = {
		{"", jmp = {"space", "param", "space", "params"}},
	},
	space = {
		{"[\1- ]+", gsub = ""},
		{'""', gsub = ""},
		ret = "",
	},
	params = {
		{"$", ret = true},
		{"", gsub = "\0", call = {"param", "space"}},
	},
	param = {
		{'"([^"]*)"?', gsub = "%1"},
		{'[^"\1- ]+'},
		ret = "",
	},
})
arg = RSParse.split(s, {{"%z", split = true}})
arg[0] = table.remove(arg, 1)

--]=]

local type = type
local pairs = pairs
local error = error
local string_find = string.find
local string_sub = string.sub
local string_gsub = string.gsub
local table_concat = table.concat

local P = {}

local _NOGLOBALS

----------- No globals from this point ------------

local nearest

local function GetMode(def, mode)
	return def[mode] or error('mode not found: '..mode, 3)
end

local function myfind(str, t, n, def)
	if t.import then
		local n1, n2, k = nearest(str, t.import, n, def)
		GetMode(def, t.import).found = k
		return n1, n2, t.nocache
	end
	local n1, n2, nocache
	local v, nocache = t[1], t.nocache
	if type(v) ~= "string" then
		n1, n2 = v(str, t, n)
	elseif t.capture1 or t.capture2 then
		local r = {string_find(str, v, n)}
		n1 = r[(t.capture1 or -1) + 2]
		n2 = r[(t.capture2 or 0) + 2]
		n2 = n2 and t.capture2 and n2 - 1 or n2
	else
		n1, n2 = string_find(str, v, n)
	end
	return n1 or 1/0, n2 or 1/0, nocache
end

function nearest(str, mode, n, def)
	local t = GetMode(def, mode)
	local n1, n2, k = 1/0, 1/0, nil
	for i = 1, t[0], 3 do
		local m1, m2, nocache = t[i+1], t[i+2], nil
		if not m1 or m1 < n or m2 < n then
			m1, m2, nocache = myfind(str, t[i], n, def)
			t[i+1], t[i+2] = not nocache and m1, m2
		end
		if m1 < n1 then
			n1, n2, k = m1, m2, i
		end
	end
	return n1, n2, k
end

local function store(stack, i, t)
	if type(t) == "string" then
		stack[i] = t
		return
	end
	for j = #t, 1, -1 do
		stack[i], i = t[j], i + 1
	end
end

local function stackcmd(t, k, stack)
	if k == "ret" or t.ret then
		stack[#stack] = nil
		if t.ret and t.ret ~= true then
			stack[#stack] = t.ret  -- such hack might prove useful in rare cases
		end
	elseif t.call then
		store(stack, #stack + 1, t.call)
	elseif t.jmp then
		store(stack, #stack, t.jmp)
	end
end

local function PrepRules(rules)
	local def = {}
	if not rules.main then
		rules = {main = rules}
	end
	for k, rule in pairs(rules) do
		local t, i = {}
		def[k] = t
		for i = 1, 1/0 do
			local v = rule[i] or rule.ret
			t[i*3 - 2] = (v ~= nil and type(v) ~= "table" and {v} or v)
			if not rule[i] then
				t[0] = rule.ret and i*3 - 2 or i*3 - 4  -- i*3 - 4 would give correct length, but won't match pattern index
				break
			end
		end
	end
	return def
end

-- Parses 'str' according to 'rules', calling 'f' for every match.
-- 'f' = function(n1, n2, pattern, pattern_index, rule_name, stack, n0)
-- If 'f' returns 'true', parsing stops.
-- 'i' is the starting index within the 'str'.
function P.parse(str, rules, f, i)
	local stack, def = {"main"}, PrepRules(rules)
	local n1, n2, k
	i = i or 1
	local function parsed(k, mode)
		local t = GetMode(def, mode)[k]
		local k0 = (k == def[mode][0] and "ret" or (k+2)/3)
		local r = f(n1, n2, t, k0, mode, stack, i) or t.run and t.run(n1, n2, t, k0, mode, stack, i) or stackcmd(t, k0, stack)
		return r or t.import and parsed(GetMode(def, t.import).found, t.import)
	end
	repeat
		local mode = stack[#stack]
		n1, n2, k = nearest(str, mode, i, def)
		if not k or parsed(k, mode) then
			return
		end
		i = n2 + 1
	until not stack[1]
end

-- Returns a table with strings that were separated by given delimiters.
-- Patterns in 'rules' table that serve as delimiters have 'split' field set to 'true'.
function P.split(str, rules)
	local t, j, n = {}, 1, 1
	P.parse(str, rules, function(n1, n2, q)
		if n1 >= n and q.split then
			t[j] = string_sub(str, n, n1 - 1)
			n, j = n2 + 1, j + 1
		end
	end)
	t[j] = string_sub(str, n)
	return t
end

-- Returns a table, which would become the result of 'gsub' if concatinated.
-- Table structure: {str1, gsub1, str2, gsub2, ..., strN}
-- gsub1, gsub2, ... are results of replacements within the string.
-- Patterns in 'rules' table can have an extra 'gsub' field for replacement strings.
-- 'n' is the same as in 'string.gsub'.
-- 'i' is the index from which the search starts.
function P.gsplit(str, rules, n, i)
	n = n and n*2 or 1/0
	if n <= 0 then
		return {str}
	end
	local t, j, n0, cur = {}, 1, 1, nil
	P.parse(str, rules, function(n1, n2, q)
		cur = cur or n1 >= n0 and q.gsub
		if cur and not q.import then
			t[j] = string_sub(str, n0, n1 - 1)
			local s1 = q.gpattern or type(q[1]) == "string" and q[1] or ".*"
			t[j+1] = string_gsub(string_sub(str, n1, n2), s1, cur, q.gcount or 1)
			n0, j, cur = n2 + 1, j + 2, nil
			if j > n then
				return true
			end
		end
	end, i)
	t[j] = string_sub(str, n0)
	return t
end

-- Patterns in 'rules' table can have an extra 'gsub' field for replacement strings.
-- 'n' is the total number of replacements, like in 'string.gsub'.
-- 'i' is the index from which the search starts.
function P.gsub(str, rules, n, i)
	return table_concat(P.gsplit(str, rules, n, i))
end

return P
