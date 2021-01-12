offsets = nil

-- log all
do
	local LogPath = AppPath
	local function backup()
		for s in path.find(LogPath.."consoleLog.txt") do
			os.remove(LogPath.."consoleLog3.txt", NoLogsInTrash)
			os.rename(LogPath.."consoleLog2.txt", LogPath.."consoleLog3.txt")
			os.rename(s, LogPath.."consoleLog2.txt")
		end
		backup = function() end
	end
	
	local DebugConsole, myprint = internal.DebugConsole, PrintToFile(LogPath.."consoleLog.txt", true, true)
	local LastPath = LogPath.."consoleInput.txt"

	function internal.DebugConsole(s, _, branch, ...)
		if not s or branch and branch ~= "" then
			return DebugConsole(s, _, branch, ...)
		end
		backup()
		pcall(myprint, s)
		s = DebugConsole(s, _, branch, ...) or ""
		local last = s
		if s ~= "" then
			pcall(myprint, "> "..s)
		else
			last = internal.DebugConsoleLastResult() or ""
		end
		if last ~= "" then
			pcall(io.save, LastPath, last, true)
		end
		return s
	end
	
	for s in path.find(LastPath) do
		local ok, s = pcall(io.load, LastPath, true)
		if ok then
			internal.DebugConsoleLastResult(s)
		end
	end
end

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
