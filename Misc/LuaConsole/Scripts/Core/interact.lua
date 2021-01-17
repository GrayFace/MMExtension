offsets = nil

-- log all
require'KeepLogs'(AppPath, 9)

-- arg - command line
do
	local RSParse = require'RSParse'
	local s = mem.string(mem.dll.kernel32.GetCommandLineA())
	s = RSParse.gsub(s, {
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
	arg = s:split("\0", true)
	arg[-1] = table.remove(arg, 1)
	arg[0] = table.remove(arg, 1)
end

-- tasks
do
	local t = {}
	local run = {}
	for s in path.find(AppPath.."Scripts/Tasks/*.lua") do
		local name = path.setext(path.name(s), '')
		t[name] = s
		run[#run+1] = "--"..name.."()"
		_G[name] = _G[name] or function(...)
			return dofile(s, ...)
		end
	end
	-- run a task or show console
	function events.ScriptsLoaded()
		if t[arg[0]] then
			Silent = true
			dofile(t[arg[0]], unpack(arg))
		elseif arg[0] then
			Silent = true
			dofile(arg[0], unpack(arg))
		end
		if not Silent then
			internal.DebugConsoleAnswer(table.concat(run, "\n\t"), -1)
			debug.debug()
		end
	end
end
