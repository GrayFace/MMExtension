local co_running = coroutine.running
local co_wrap = coroutine.wrap
local co_yield = coroutine.yield
local s_rep = string.rep
local pcall = pcall
local type = type
local select = select
local loadstring = loadstring
local u4 = mem.u4
local internal = debug.getregistry()
local io_open = io.open
local PauseGame = internal.PauseGame
local ResumeGame = internal.ResumeGame
internal.EnterDebug = internal.EnterDebug or function() end  -- called before a non-game window is shown and after it's hidden

local _KNOWNGLOBALS

local function DebugRet(ok, ...)
	return {ok and select('#', ...), ...}
end

local ConsoleVisible
local function HideConsole()
	if ConsoleVisible then
		ConsoleVisible = false
		internal.DebugConsole(nil, false)
		ResumeGame()
		internal.EnterDebug(false)
	end
end
debug.HideConsole = HideConsole

local LogFileName, LogOffset, LogSeparator
local function MeasureLog()
	LogOffset, LogFileName = internal.LogFileInfo()
	local f = LogOffset and io_open(LogFileName, "rb")
	LogOffset = f and f:seek("end") or 0
	if f then
		f:close()
	end
end

local function IncludeLog(str)
	local f = internal.LogFileInfo() and io_open(LogFileName, "rb")
	if not f then
		return str
	end
	f:seek("set", LogOffset)
	local s = f:read("*a")
	f:close()
	if s == "" then
		return str
	end
	if not LogSeparator then
		local sym = "-"
		LogSeparator = s_rep(sym, 4).." Log File Output: "
		local n = internal.DebugConsoleCharsInLine()
		LogSeparator = LogSeparator..s_rep(sym, n - #LogSeparator).."\n"
	end
	return str..LogSeparator..s
end

local function DoDebug(str)
	local state = PauseGame(true)
	str = internal.DebugConsole(str, internal.IsTopmost and internal.IsTopmost()) or ""
	ConsoleVisible = (str ~= "")
	ResumeGame(state)
	if str == "" then
		internal.EnterDebug(false)
		return
	end
	local f, err = loadstring("return "..str, "")
	if f == nil then
		f, err = loadstring(str, "")
	end
	if f == nil then
		return DoDebug(err.."\n")
	end
	-- assert(type(f) == "function")

	local oldOnWait = internal.OnWaitMessage
	local function hide()
		internal.OnWaitMessage = oldOnWait
		HideConsole()
	end
	internal.OnWaitMessage = hide

	MeasureLog()
	local ret = DebugRet(pcall(f))
	
	if internal.OnWaitMessage == hide then
		internal.OnWaitMessage = oldOnWait
	end
	if not ConsoleVisible then
		internal.EnterDebug(true)
	end
	if ret[1] then
		str = ""
		for i = 2, ret[1] + 1 do
			str = str..'  '..tostring2(ret[i])..'\n'
		end
	else
		str = ret[2].."\n"
	end
	return DoDebug(IncludeLog(str))
end

local DebugModeWritten, Line1, Line2

function debug.debug(str)
	if str or not DebugModeWritten then
		DebugModeWritten = not str
		if not Line1 then
			local n = internal.DebugConsoleCharsInLine()
			Line1 = s_rep("—", n).."\n"
			Line2 = "\n"..s_rep("-", n).."\n"
		end
		str = Line1..(str or "Debug Mode Started. Press Ctrl+Enter to execute commands.")..Line2
	else
		str = ""
	end

	internal.EnterDebug(true)
	if co_running() then
		DoDebug(str)
	else
		co_wrap(DoDebug)(str)
		HideConsole()
	end
end
