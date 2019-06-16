--[=[!File
'/Examples:/'

Damage selected player every minute:
!LUA[[
Timer(function()
	evt.DamagePlayer{Damage = 1}
end, const.Minute)
]]

Check some condition (e.g. that you killed all monsters) every 5 minutes, including the moment you enter the map:
!LUA[[
Timer(CheckCondition, 5*const.Minute, true)
]]

Refill a well every week on Tuesday at 3 AM:
!LUA[[
RefillTimer(RefillWell, const.Week, const.Day + 3*const.Hour)
]]

Make "eat" sound at 3 AM every day:
!LUA[[
Timer(function()
	evt.PlaySound(Game.Version == 8 and 144 or 211)
end, const.Day, 3*const.Hour, false)
]]
]=]
local FunctionFile = debug.FunctionFile

local _KNOWNGLOBALS_F = Game, Party, Map, Keys, keys

local timeGetTime_add = 0
local timeGetTime_last = 0
-- Returns time since Windows has started in milliseconds
function timeGetTime()
	local ret = mem.call(internal.timeGetTime, 0)
	if ret < timeGetTime_last then
		timeGetTime_add = timeGetTime_add + 4294967296
	end
	timeGetTime_last = ret
	return ret + timeGetTime_add
end

local LastTick
local timers -- function, period, start, next_time
local sleeps -- coroutine, wake time, realtime wake time, screens
local CurTimer, CurTotal = 1, 0

local function NextExact(time, period, LastTick, IsInit)
	local cur = LastTick + 1
	if cur - time < period then
		return time + period
	end
	return cur - (cur - time) % period + period
end

local function NextPeriod(time, period, LastTick, IsInit)
	return Game.Time + period
end

--!(f, Period = const.Minute, [Start,] [PastAware,] [Exact])
-- 'f' = !LUA[[function(TriggerTime, Period, LastTick, Tick)]]:
--   Function to call when the timer is triggered.
-- 'Start' is !LUA[[Game.Time + Period]] if not specified (or !LUA[[Game.Time]] if 'PastAware' = 'true').
-- 'PastAware' = remember last visit time and fire right away if timer condition was met in the period of your absence.
--   If not specified, it's 'true' if 'Start' is specified, 'false' otherwise.
-- Possible 'Exact' values:
--   false:  re-fires after 'Period' passes since last invocation (this is the default if 'Start' is not specified).
--   true:  fires whenever (start + period*N) line is crossed (this is the default if 'Start' is specified).
--   !LUA[[function(TriggerTime, Period, LastTick, IsInit)]]:  returns next trigger time when called.
--     'IsInit' = 'true' if it's called by Timer function itself which happens if 'Start' has already passed.
-- Note that the timer remembers last time you were in the location, so for example,
-- an exact weekly timer would fire right away if you haven't visited the map for a week.
function Timer(f, period, start, PastAware, exact)
	period = period or const.Minute
	if start == nil or tonumber(start) then
		start = tonumber(start)
	else
		start, PastAware, exact = nil, start, PastAware
	end
	if type(PastAware) == "function" or type(PastAware) == "table" then
		PastAware, exact = nil, PastAware
	end
	if exact == nil then
		exact = not not start
	end
	if exact == true then
		exact = NextExact
	elseif not exact then
		exact = NextPeriod
	end
	local last = (PastAware and start and LastTick or LastTick - 1 or Game.Time)
	start = start or Game.Time
	if start <= Game.Time and start <= last then
		start = exact(start, period, last, true)
	end
	timers[#timers+1] = {f, period, start, exact} -- Game.Map.LastRefillDay*0x5A000})
end


local function GetRefills()
	return tget(internal.SaveGameData, "TimerPassed", Map.Name)
end

local function NextRefill(time, period, LastTick, IsInit)
	if IsInit then
		return time
	end
	time = Game.Time + period
	GetRefills()[period] = time
	return time
end

local function NextRefillExact(time, period, LastTick, IsInit)
	return IsInit and time or NextExact(time, period, LastTick)
end

--!(f, Period = const.Day, Start)
-- 'f' = !LUA[[function(TriggerTime, Period, LastTick, Tick)]]:
--   Called when the timer is triggered.
-- If 'Start' is not specified, triggers when 'Period' passes since last time it was triggered and on map refill.
-- If 'Start' is specified, acts like exact Timer, but also fires at map refills.
function RefillTimer(f, period, start)
	if not start or start == true then  -- check 'true' for backward compatibility and similarity with Timer
		Timer(f, period, not Map.Refilled and GetRefills()[period] or Game.Time, NextRefill)
	elseif Map.Refilled and start < period then
		Timer(f, period, start - period, NextRefillExact)
	else
		Timer(f, period, start)
	end
end


local function DoSleep(c, time, realtime, screens)
	if realtime then
		realtime = timeGetTime() + time  -- 7.8125 = 1 / 0.128
		time = 0
	else
		time = Game.Time + time
		realtime = 0
	end
	screens = table.invert(screens or {0, Game.CurrentScreen})
	table.insert(sleeps, {c, time, realtime, screens})--, FunctionFile(2)})
end

function Sleep(time, realtime, screens)
	local c = coroutine.running()
	if c then
		DoSleep(c, time, realtime, screens)
		return coroutine.yield(c)
	elseif realtime then
		mem.dll.kernel32.Sleep(time)
	end
end

function Sleep2(f, time, realtime, screens)
	DoSleep(coroutine.create(f), time, realtime, screens)
end

local function DoRemoveTimer(i)
	table.remove(timers, i)
	CurTotal = CurTotal - 1
	if CurTimer >= i then
		CurTimer = CurTimer - 1
	end
	return true				
end

-- You can remove the timer being executed by calling this function without a parameter
function RemoveTimer(f)
	if not f then
		return CurTimer <= CurTotal and DoRemoveTimer(CurTimer)
	end
	for i = 1, #timers do
		if timers[i][1] == f then
			return DoRemoveTimer(i)
		end
	end
end

function internal.StartTimers()
	timers = {}
	sleeps = sleeps or {}
	local s = Map.Name
	local sgd = internal.SaveGameData
	LastTick = tget(sgd, "TimerTick")[s] or -1
	if Map.Refilled and sgd.TimerPassed then
		sgd.TimerPassed[s] = nil
	end
end

function internal.TimersSaveGame()
	internal.SaveGameData.TimerTick[Map.Name] = LastTick
end

function internal.TimersLeaveMap(t)
	timers = {}
	sleeps = {}
	CurTotal = 0
	internal.TimersSaveGame()
end

function internal.TimersLeaveGame()
	timers = nil
	sleeps = nil
	CurTotal = 0
end

--------- keys

--!v([key:const.Keys]) Example 1 (recommended):
-- !LUA[[
-- function Keys.F2(t)
--   Message("F2 pressed")
-- end
-- ]]
-- Example 2 (not recommended):
-- !LUA[[
-- Keys[const.Keys.F2] = function()
--   Message("F2 pressed")
-- end
-- ]]
-- These examples are actually handled differently. The first one is equivalent to using #events.KeyDown:# and checking 't.Key'.
-- The second is mostly for backward compatibility. Instead of relying on messages, it checks key state on every frame and calls the function if the key was pressed. It may miss a very short key press.
Keys = Keys or {}
local cKeys = const.Keys
local keyInv = {}
local keyInv2 = {}
for k, v in pairs(cKeys) do
	if keyInv[k] then
		keyInv2[k] = v
	else
		keyInv[k] = v
	end
end

--!(key:const.Keys) String representations of #const.Keys:# are also supported, e.g. !LUA[[Keys.IsPressed"SHIFT"]]
function Keys.IsPressed(key)
	return mem.call(internal.GetKeyState, 0, assertnum(cKeys[key] or key, 2)):And(0x8000) ~= 0
end

--!(key:const.Keys) String representations of #const.Keys:# are also supported, e.g. !LUA[[Keys.IsToggled"CAPSLOCK"]]
function Keys.IsToggled(key)
	return mem.call(internal.GetKeyState, 0, assertnum(cKeys[key] or key, 2)):And(1) ~= 0
end

local _, keyHandlers = events.new(Keys)
local pressedKeys = {}


function internal.TimersKeyDown(key, t)
	local s = keyInv[key]
	if s then
		Keys.cocall(s, t)
		s = keyInv2[key]
		if s then
			Keys.cocall(s, t)
		end
	end
end

--------- OnTick

local function CallTimers(tick, last)
	LastTick = tick
	CurTimer, CurTotal = 1, #timers
	while CurTimer <= CurTotal do
		local v = timers[CurTimer]
		if tick >= v[3] then
			local period, time, next_time = v[2], v[3], v[4]
			coroutine.resume2(coroutine.create(v[1]), time, period, last, tick)
			if timers[CurTimer] == v then
				v[3] = next_time(time, period, last)
				if not v[3] then
					table.remove(timers, CurTimer)
					CurTimer = CurTimer - 1
				end
			end
		end
		CurTimer = CurTimer + 1
	end
end

function internal.OnTimer()
	local tick = Game.Time
	if sleeps then
		local rtick = timeGetTime()
		local screen = Game.CurrentScreen
		for i = #sleeps, 1, -1 do
			local v = sleeps[i]
			if tick >= v[2] and rtick >= v[3] and (v[4][screen] or v[4].All or v[4].all) then
				table.remove(sleeps, i)
				coroutine.resume2(v[1], true)
			end
		end
	end
	if tick ~= LastTick and not Game.Paused and not Game.MoveToMap.Defined and timers then
		CallTimers(tick, LastTick)
	end
	events.cocalls("Tick")
	for k, _ in pairs(keyHandlers) do
		if type(k) == "number" and k > 0 and k <= 255 then
			local wasPressed = pressedKeys[k]
			local pressed = Keys.IsPressed(k)
			pressedKeys[k] = pressed
			if pressed and not wasPressed then
				Keys[k]()
			end
		end
	end
	if internal.OnWaitMessage then
		internal.OnWaitMessage()
	end
end
