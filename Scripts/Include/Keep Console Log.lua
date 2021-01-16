-- log all
local LogPath = DevPath..'Scripts/my/Logs/'
local LogCount = 9
os.mkdir(LogPath)
PrintToFile(LogPath..'mm'..offsets.MMVersion..'.txt')  -- optional. To avoid opening particular game folder every time.

local function backup()
	local log = LogPath.."consoleLog"
	for s in path.find(log..'.txt') do
		os.remove(log..LogCount..'.txt', NoLogsInTrash)
		for i = LogCount, 3, -1 do
			os.rename(log..(i-1)..'.txt', log..i..'.txt')
		end
		os.rename(s, log..'2.txt')
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
