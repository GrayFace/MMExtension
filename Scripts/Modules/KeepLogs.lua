-- log all
return function(LogPath, LogCount, NoTrash)

os.mkdir(LogPath)

local function backup()
	local log = LogPath.."consoleLog"
	for s in path.find(log..'.txt') do
		local maxLog = log..(LogCount > 1 and LogCount or '')..'.txt'
		local time1, time2
		for _, a in path.find(maxLog) do
			time1, time2 = a.LastWriteTimeLow, a.LastWriteTimeHigh
		end
		if time1 then
			local del = log..time2..'-'..time1..'.txt'
			os.rename(maxLog, del)
			os.remove(del, NoTrash or NoLogsInTrash)
		end
		for i = LogCount, 2, -1 do
			os.rename(log..(i > 2 and i-1 or '')..'.txt', log..i..'.txt')
		end
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

local function ShowLogInConsole(s, name)
	local timestate = internal.PauseGame()
	local s = internal.DebugConsole(s, (internal.IsTopmost or internal.IsFullScreen)(), name) or ""
	DebugConsole(nil, false, name)
	internal.ResumeGame(timestate)
	internal.DebugConsoleAnswer(s, 1)
end

local OutputLogs = {}

local function ViewOutputLog()
	local ok, name = internal.LogFileInfo()
	if not ok then
		return 'log file is empty'
	end
	local n = OutputLogs[name]
	local s = n and "" or '['..name..']\n'..("—"):rep(internal.DebugConsoleCharsInLine()).."\n"
	local f = io.open(name, 'rb')
	if f then
		f:seek('set', n or 0)
		s = s..f:read('*a'):gsub('\r\n', '\n')
		OutputLogs[name] = f:seek()
		f:close()
	else
		OutputLogs[name] = 0
	end
	ShowLogInConsole(s, name)
end

local GotLogs = {}

-- Shows contents of console log from previous run of the game.
-- 'n' is the log index or '0' to show current output log.
function ViewLog(n)
	if (n or 2) <= 1 then
		return ViewOutputLog()
	end
	backup()
	local name = "consoleLog"..(n or 2)..'.txt'
	local s = GotLogs[name] or path.FindFirst(LogPath..name) and '['..name..']\n'..io.load(LogPath..name)
	if not s then
		return name..' not found'
	end
	GotLogs[name] = ""
	ShowLogInConsole(s, name)
end

for s in path.find(LastPath) do
	local ok, s = pcall(io.load, LastPath, true)
	if ok then
		internal.DebugConsoleLastResult(s)
	end
end

end