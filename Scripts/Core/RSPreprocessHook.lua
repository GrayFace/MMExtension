--[[
RSPreprocessHook v0.1
(c) 2019 Sergey Rozhenko, MIT license

Allows preprocessing any Lua code before it's loaded.

Activate() substitutes standard functions with ones that call preprocessing callbacks.

You can define either of the 2 callbacks:

ProcessCallback(str, name for errors, name passed to loadstring) returns:
a) processed_str - processed_str is passed to loadstring
b) nil, error_str - error_str is returned as an error
c) processed_str, error_str - an error returned by loadstring(processed_str) is used. If loadstring succeds, error_str is returned as an error.

LoadCallback has the same semantic as loadstring. By default it calls ProcessCallback, but you can instead redifine itself if you wish.

LuaJIT or Lua 5.2+ required. Compatibility with newer versions of Lua isn't guaranteed (I only test on LuaJIT, which is by all means the golden standard version of Lua).

--]]
local type = type
local tostring = tostring
local assert = assert
local error = error
local concat = table.concat
local io_open = io.open
local sub = string.sub
local match = string.match
local format = string.format
local s_find = string.find
local _load = load
local _loadstring = loadstring or _load
local _loadfile = loadfile
local package = package
local searchpath = package and package.searchpath
local debug_getinfo = debug and debug.getinfo
local HasGoto = _loadstring("::a::") and true
local Lua52 = HasGoto and (_VERSION ~= "Lua 5.1")
local LuaJIT = _loadstring("#") and true  -- jit.* might be hidden
local LOADERS = Lua52 and "searchers" or "loaders"

----------- Activate ------------

local P = {}

function P.Activate()
	load = P.load
	loadstring = loadstring and P.loadstring
	loadfile = P.loadfile
	dofile = P.dofile
	if package and package[LOADERS] then
		package[LOADERS][2] = P.loader_lua or package[LOADERS][2]
	end
end

local _NOGLOBALS  -- no globals from this point

----------- Other module functions ------------

P.new = debug_getinfo and debug_getinfo(1, "f").func

function P.ProcessCallback(str)
	return str
end

function P.LoadCallback(s, ...)
	local s, err = P.ProcessCallback(s, match(... or "", "^@?.*"), (...))
	if s then
		local f, err2 = _loadstring(s, ...)
		if not f then
			return nil, err2
		elseif not err then
			return f
		end
	end
	return nil, err
end

local function myloadstring(s, ...)
	return P.LoadCallback(s, ...)
end

local function myload(ld, src, ...)
	local t, i = {}, 1
	local s = ld()
	while s do
		t[i], i = s, i + 1
		s = ld()
	end
	return P.LoadCallback(concat(t), src or "=(load)", ...)
end

if HasGoto then  -- LuaJIT or Lua 5.2+ - load accepts strings, loadstring is an alias or doesn't exist
	function P.load(ld, ...)
		return (type(ld) == "string" and P.LoadCallback or myload)(ld, ...)
	end
	P.loadstring = P.load
else
	P.load = myload
	P.loadstring = myloadstring
end

local function myloadfile(fname, ...)
	if not fname then
		return _loadfile(fname, ...)
	end
	local f, err = io_open(fname, LuaJIT and "rb" or "r")
	if not f then
		return f, err
	end
	local c = f:read(1)
	if c == "#" then  -- # - Unix exec. file?
		repeat  -- skip line
			c = f:read(1)
		until c == "\r" or c == "\n" or not c
		c = c and c..(f:read(1) or "") or ""
		c = (c == "\r\n" and c..(f:read(1) or "") or c)
		f:seek(-#c)  -- keep line ending
		c = sub(c, -1)  -- still may meet binary data after it
	else
		f:seek("set")
	end
	if c == "!" then
		f:close()
		return _loadfile(fname, ...)  -- binary
	end
	local s = f:read("*a")
	f:close()
	return P.LoadCallback(s, "@"..fname, ...)
end
P.loadfile = myloadfile

function P.dofile(fname)
	local f, err = myloadfile(fname)
	if f then
		return f()
	else
		error(err, 0)
	end
end

if not searchpath then
	return P  -- LuaJIT or Lua 5.2 required (I didn't bother to reimplementing searchpath in Lua)
end

-- In addition to checking package.preload, 'preload loader' secretely calls dlsym()
-- for some Linux magic and then tries to luaL_loadbuffer the returned address.
-- This can't be replicated in Lua, so it's left unchanged.

function P.loader_lua(name)
	local path = assert(tostring(package.path), "'package.path' must be a string")
	local fname, err = searchpath(name, path)
	if not fname then
		return err
	end
	local f, err = myloadfile(fname)
	if f then
		return f, fname
	end
	return error(format("error loading module '%s' from file '%s':\n\t%s", name, fname, err), 1)  -- must be a tailcall
end

return P