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

for s in path.find(LastPath) do
	local ok, s = pcall(io.load, LastPath, true)
	if ok then
		internal.DebugConsoleLastResult(s)
	end
end

end