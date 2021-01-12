--[==[
Templates. Simple, but flexible.
(c) 2018 Sergey Rozhenko, MIT license

Rules are described in RSParse module. Default setup is for general case of a file with unknown format.

Let's start by applying RSTemplates to Lua code. Although not very practical, it is a good demonstration:

local P = require'RSTemplates'
-- use Lua syntax, so that -[ sequence would be ignored when commented out
P.rules.main = {
	{import = "check"},  -- check opening sequence
	{import = "lua"},    -- check Lua comments and strings
}
-- this is the template:
print(P.run[=[
	-[for i = 1, 2 do]
		print(-[(i)])
	-[end]
]=])

The example results in: (whitespace trimmed for clarity)

print(1)
print(2)

Meta code inside the template translates into: (simpified, in reality strings are fetched from a table by calling _WRITE with 2 arguments)

_WRITE("")
for i = 1, 2 do
	_WRITE("print(")(i)
	_WRITE(")")
end
_WRITE("")

When called with 1 argument, the _WRITE function works like this:

local function _WRITE(s)
	t[#t+1] = tostring(s)
	return _WRITE
end

You can manipulate the 't' table used by _WRITE function directly, just write:
-[local params, t = ...]
The 'params' table is the one you pass to the 'run' function.


Let's get back to the general case of unknown syntax. In this case the only way to comment out meta code would be from within the meta code. E.g.
-[--[=[
Anything here that doesn't contain "]=]". It could contain -[ and ] without problems.
]=]]

You can escape the template start sequence like this:
-["-["]


Here's how you can look up meta code:
local P = require'RSTemplates'
local t = P.prepare[=[
	-[for i = 1, 2 do]
		print(-[(i)])
	-[end]
]=]
print(t.code0.." "..t.code)


Rules example for HTML: (I didn't look up the html syntax for this, so it's probably incomplete)

local r = P.rules
r.main = {
	{import = "checkmain"},
	{"<style>", call = "style"},
	{"<style ", call = {"attribs", "style"}},
	{"<script>", call = "script"},
	{"<script ", call = {"attribs", "script"}},
}
r.checkmain = {
	{import = "check"},
	"<!%-%-.-%-%->",
}
r.attribs = {
	{import = "checkmain"},
	ret = ">",
}
r.style = {
	{import = "check"},
	ret = "</style>",
	"/%*.-%*/",
}
r.script = {
	{import = "check"},
	ret = "</script>",
	"/%*.-%*/",
	"//[^\r\n]*",
	{"'", call = "str1"},
	{'"', call = "str2"},
}


You can call P.new() to create a new instanse of RSTemplates.

Here's an example of extending RSTemplates rules with another command:
local P = require'RSTemplates'
-- make $[ ] add parentheses around the meta code
local r = P.rules
r.check = {
	{"%-%[", call = "gcode", gsub = ""},
	{"%$%[", call = "gcode2", gsub = "("},
}
r.gcode2 = {
	{"%]", ret = true, gsub = ")"},
	{import = "code"},
}
-- use Lua syntax again for this example
r.main = {
	{import = "check"},  -- check opening sequence
	{import = "lua"},    -- check Lua comments and strings
}
-- new it's a bit easier to insert stuff:
print(P.run[=[
	-[for i = 1, 2 do]
		print($[i])
	-[end]
]=])


Another example of extending RSTemplates, this would work similar to MetaLua's +{} within -{} blocks:

local P = require'RSTemplates'
-- first, support on the code side
P.args = {table.concat}
P.code0 = [[local _WRITE
do
	local _, t, Write, concat = ...
	function _WRITE(s, n, ...)
		if n ~= true then
			return Write(s, n, ...)
		end
		local n = #t
		s()
		local q = {}
		for i = n + 1, #t do
			q[i-n], t[i] = t[i], nil
		end
		return concat(q)
	end
end]]
-- additional rules
local r = P.rules
r.main = {
	{import = "check"},
	{import = "lua"},
}
table.insert(r.code, 1, 
	{"%+%[", call = "gplus", gsub = " _WRITE(function()"}
)
r.plus = {
	{import = "check"},
	{import = "lua"},
	{"%[", call = "plus"},
	ret = "%]",
}
r.gplus = {
	{"%]", ret = true, gsub = "end, true)"},
	{import = "plus"},
}
-- now, let's test
print(P.run[=[
-[
	function SwapOrder(s1, s2)
		_WRITE(s2)("\n")(s1)
	end
	SwapOrder(+[print(2)], +[print("Compiled on LuaJIT: "..-[(jit and 1 or 0)])])
]
]=])


Speaking of MetaLua, the choice of -{ and +{ in it is very strange, because it interferes with code like this:
vec2 = vec1-{1,1}
That's why I lended at -[ for opening marker.

--]==]

local type = type
local pairs = pairs
local pcall = pcall
local tostring = tostring
local load = load
local loadstring = loadstring
local setfenv = setfenv
local unpack = unpack or table.unpack
local string_format = string.format
local table_concat = table.concat
local Lua52 = not loadstring or (_VERSION ~= "Lua 5.1") and loadstring("::a::")
local mysplit = require("RSParse").gsplit

local P = {
	new = debug.getinfo and debug.getinfo(1, "f").func,
	rules = {
		main = {
			{import = "check"},
		},
		check = {
			{"%-%[", call = "gcode", gsub = ""},
		},
		code = {
			{import = "lua"},
			{"%[", call = "code"},
			ret = "%]",
		},
		gcode = {
			{"%]", ret = true, gsub = ""},
			{import = "code"},
		},
		lua = {
			"%[(=*)%[.-%]%1%]",     -- long string
			"%-%-%[(=*)%[.-%]%1%]", -- long comment
			"%-%-[^\r\n]*",         -- line comment
			{"'", call = "str1"},
			{'"', call = "str2"},
		},
		str1 = {"\\.", ret = "'"},
		str2 = {"\\.", ret = '"'},
	},
	code0 = "local _WRITE=({...})[3]",
	args = {},
	globals = nil,
}

----------- No globals from this point ------------

local _NOGLOBALS

----------- Templates support ------------

local function LoadCode(t, params)
	local s, f, err = {t.code0}, nil, nil
	for k in pairs(params) do
		s[#s+1] = string_format("local %s=(...).%s", k, k)
	end
	s[#s+1] = t.code
	local code = table_concat(s, " ")
	if not Lua52 then
		f, err = loadstring(code)
		if f and t.globals then
			setfenv(f, t.globals)
		end
	elseif t.globals then
		f, err = load(code, nil, nil, t.globals)
	else
		f, err = load(code)
	end
	return f, err
end

-- 'params' table is only used for param names here
local function prepare(q, params)
	-- make code
	if type(q) ~= "table" then
		local t = mysplit(q, P.rules)
		q = {code0 = P.code0 or ""}
		for i = 1, #t/4 + 1, 1 do
			q[i] = t[i*4 - 3]
			t[i*4 - 3] = string_format("\n_WRITE(_WRITE,%s)", i)
		end
		q.code = table_concat(t)
		q.globals = P.globals
	end
	-- load code
	if params then
		local f, err = LoadCode(q, params)
		q.code, q.code0 = f, nil
		if not f then
			return nil, err
		end
	end
	return q
end
P.prepare = prepare

-- 'params' table specifies parameter values.
-- 'all' (= 'params' if not specified) table specifies parameter names, because values might be nil. Params are accessible as local variables.
-- 'res' is the results table, specifying which is useful in special cases.
function P.run(t, params, all, res)
	if type(t) == "string" then
		t = prepare(t)
	end
	params = params or {}
	-- load code
	local f, err = t.code, nil
	if t.code0 then
		f, err = LoadCode(t, all or params)
		if not f then
			return nil, err
		end
	end
	-- Write function
	local res, rn = res or {}, 0
	local function Write(s, num)
		rn = res[rn] and not res[rn + 1] and rn + 1 or #res + 1
		res[rn] = (s == Write and num and t[num] or tostring(s))
		return Write
	end
	-- execute
	local ok, err = pcall(f, params, res, Write, unpack(P.args))
	if not ok then
		return nil, err
	end
	
	return table_concat(res)
end

return P