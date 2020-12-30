local _G = _G
local table_insert = table.insert
local table_remove = table.remove
local abs = math.abs
local type = type
local ipairs = ipairs
local next = next
local assert = assert
local setmetatable = setmetatable
local d_getinfo = debug.getinfo
local FunctionFile = debug.FunctionFile
local pcall2 = pcall2
local co_create = coroutine.create
local co_resume2 = coroutine.resume2
local cocall2 = cocall2

----------- No globals from this point ------------

local _NOGLOBALS

--------- events

-- Logic:
-- 'remove' should prevent currently running events from executing the removed function, but keep processing going
-- newly added functions shouldn't be executed by currently running events
-- So:
-- no table.remove/table.insert, instead build a new event table when there are too many gaps
-- invalidate the old event table (with false's), redirect(reloc) handlers stuck with it to the newer table
-- (the old table otherwise stays in the state from which the newer one was created, which is important for reloc)

local function remake_list(f)
	local n = 0
	local t = {from = 1}
	for i = f.from, f.to do
		local v = f[i]
		if v then
			n = n + 1
			t[n] = v
			f[i] = false
		end
	end
	t.to = n
	f.Next = t
	return t
end

local function ProcessReloc(f, index, to)
	local from1, to1 = 1, 0
	for i = f.from, to do
		if f[i] == false then
			to1 = to1 + 1
			if i == index then
				from1 = to1
			end
		end
	end
	return f.Next, from1, to1
end

local function docall(f, i, to, ...)
	local ret
	while i <= to do
		local v = f[i]
		i = i + 1
		if v then
			local tmp = v(...)
			if tmp ~= nil then
				ret = tmp
			end
		elseif v == false then
			f, i, to = ProcessReloc(f, i - 1, to)
		end
	end
	return ret
end

local function speccall(call, f, i, to, ...)
	local ret
	while i <= to do
		local v = f[i]
		i = i + 1
		if v then
			local ok, tmp = call(v, ...)
			if tmp ~= nil and ok then
				ret = tmp
			end
		elseif v == false then
			f, i, to = ProcessReloc(f, i - 1, to)
		end
	end
	return ret
end

-- try using 1 coroutine for all event handlers. If yeild is used, create another.
local function cocallPart(ret, f, i, to, ...)
	local ok = cocall2(function(...)
		while i <= to do
			local v = f[i]
			i = i + 1
			if v then
				local tmp = v(...)
				if tmp ~= nil then
					ret = tmp
				end
			elseif v == false then
				f, i, to = ProcessReloc(f, i - 1, to)
			end
		end
	end, ...)
	local i2 = i
	i = to + 1
	return ret, f, i2, to, ok
end

local function make_events(evt)
	evt = evt or {}
	local t = {}
	local onset
	local function setup(t)
		onset = t.EventUsed == nil and onset or t.EventUsed
		return t
	end
	
	local function call(a, ...)
		local f = t[a]
		return f and docall(f, f.from, f.to, ...)
	end
	evt.call, evt.Call = call, call

	-- pcall for each event handler
	local function pcalls(a, ...)
		local f = t[a]
		return f and speccall(pcall2, f, f.from, f.to, ...)
	end
	evt.pcalls = pcalls

	-- process all event handlers in a single pcall
	local function _pcall(a, ...)
		local f = t[a]
		if f then
			local ok, tmp = pcall2(docall, f, f.from, f.to, ...)
			if ok then
				return tmp
			end
		end
	end
	evt.pcall = _pcall
	
	-- if some event handler fails, continues execution of other handlers
	local function cocalls(a, ...)
		local f = t[a]
		if f then
			local ret, i, to = nil, f.from, f.to
			repeat
				ret, f, i, to = cocallPart(ret, f, i, to, ...)
			until i >= to
			return ret
		end
	end
	evt.cocalls = cocalls

	-- if some event handler fails, execution stops
	local function cocall(a, ...)
		local f = t[a]
		if f then
			local ret, i, to, ok = nil, f.from, f.to, true
			repeat
				ret, f, i, to, ok = cocallPart(ret, f, i, to, ...)
			until i >= to or not ok
			return ret
		end
	end
	evt.cocall = cocall
	
	local function newindex(_, a, v)
		if v then
			local f = t[a]
			if f then
				f.to = f.to + 1
				f[f.to] = v
			else
				t[a] = {v, from = 1, to = 1}
				if onset then
					onset(a, true, evt)
				end
			end
		end
	end

	local function add(a, v)
		newindex(nil, a, v)
	end
	evt.add, evt.Add = add, add

	local function addfirst(a, v)
		if v then
			local f = t[a]
			if f then
				f.from = f.from - 1
				f[f.from] = v
			else
				t[a] = {v, from = 1, to = 1}
				if onset then
					onset(a, true, evt)
				end
			end
		end
	end
	evt.addfirst, evt.AddFirst = addfirst, addfirst

	local function check_gaps(a, f)
		local d = f.to - f.from
		if d < 0 then
			t[a] = nil
			if onset then
				onset(a, false, evt)
			end
		elseif (f.gaps or 0)*3 + abs(f.from - 1)*1.5 > d then  -- allow 1/3 to be filled with gaps
			t[a] = remake_list(f)
		end
	end
	
	local function removed(f, i)
		if i == f.from then
			f.from = f.from + 1
			while not f[f.from] and f.from <= f.to do
				f.from = f.from + 1
				f.gaps = f.gaps - 1
			end
		elseif i == f.to then
			f.to = f.to - 1
			while not f[f.to] and f.from <= f.to do
				f.to = f.to - 1
				f.gaps = f.gaps - 1
			end
		else
			f.gaps = (f.gaps or 0) + 1
		end
	end
	
	local function replace(a, func, f2)
		if type(func) == "number" then
			func = assert(d_getinfo(func + 1, 'f').func)
		end
		if type(f2) == "number" then
			f2 = assert(d_getinfo(f2 + 1, 'f').func)
		end
		local f = t[a]
		if f and func then
			for i = f.from, f.to do
				if f[i] == func then
					f[i] = f2
					if not f2 then
						removed(f, i)
						check_gaps(a, f)
					end
					return func
				end
			end
		end
	end
	evt.replace, evt.Replace, evt.remove, evt.Remove = replace, replace, replace, replace

	local function clear(a)
		-- stop currently running handler enumerators
		local f = t[a]
		if f then
			for i = f.from, f.to do
				f[i] = nil
			end
		end
		t[a] = nil
		if onset then
			onset(a, false, evt)
		end
	end
	evt.clear, evt.Clear = clear, clear

	local function exists(a, func)
		local f = t[a]
		if f then
			if not func then
				return true
			end
			for i = f.from, f.to do
				if f[i] == func then
					return true
				end
			end
		end
		return false
	end
	evt.exists, evt.Exists = exists, exists

	local function callUnload(f, files, ...)
		if files[FunctionFile(f)] then
			return cocall2(f, ...)
		end
	end
	
	local function RemoveFiles(files)
		-- call Unload
		local un = t.Unload
		if un then
			speccall(callUnload, un, un.from, un.to, files)
		end
		-- remove
		for a, f in next, t do
			for i = f.from, f.to do
				if f[i] and files[FunctionFile(f[i])] then
					f[i] = nil
					removed(f, i)
				end
			end
			check_gaps(a, f)
		end
	end
	evt.RemoveFiles = RemoveFiles
	
	function evt.RemoveFile(f)
		f = f or FunctionFile(2)
		RemoveFiles{[f] = true}
	end
	
	function evt.RemoveAll()
		cocalls("Unload")
		-- stop currently running handlers
		for a, f in next, t do
			for i = f.from, f.to do
				f[i] = nil
			end
			t[a] = nil
			if onset then
				onset(a, false, evt)
			end
		end
	end
	
	local function index(_, a)
		local function forward(f)
			return function(...)
				return f(a, ...)
			end
		end
		local call = function(_, ...)
			return call(a, ...)
		end
		local add = function(func)
			newindex(nil, a, func)
		end
		local replace = function(func, f2)
			if type(func) == "number" then
				func = assert(d_getinfo(func + 1, 'f').func)
			end
			if type(f2) == "number" then
				f2 = assert(d_getinfo(f2 + 1, 'f').func)
			end
			return replace(a, func, f2)
		end
		local function evIndex(_, k)
			if k ~= "last" and k ~= "Last" then
				return
			end
			local f = t[a]
			if f then
				for i = f.to, f.from, -1 do
					if f[i] then
						return f[i]
					end
				end
			end
		end
		local remove = replace
		local pcalls = forward(pcalls)
		local _pcall = forward(_pcall)
		local cocalls = forward(cocalls)
		local cocall = forward(cocall)
		local exists = forward(exists)
		local clear = forward(clear)

		local t1 = {add = add, Add = add, remove = remove, Remove = remove,
			replace = replace, Replace = replace, exists = exists, Exists = exists,
			clear = clear, Clear = clear,
			__call = call, pcalls = pcalls, pcall = _pcall, cocalls = cocalls, cocall = cocall, __index = evIndex}
		return setmetatable(t1, t1)
	end

	return setmetatable(evt, {__index = index, __newindex = newindex}), t, setup
end

local ev, t, setup = make_events{new = make_events, setup = true}
_G.events, ev.setup = ev, setup
