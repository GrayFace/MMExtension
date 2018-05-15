for f in path.find(DevPath..[[Scripts\General\my\*.lua]]) do
	dofile(f)
end

local GlobalScripts = {}

local function DoLoadScripts(fpath, t)
	for f in path.find(fpath) do
		local chunk, err = loadfile(f)
		if chunk == nil then
			debug.ErrorMessage(err)
		else
			t[debug.FunctionFile(chunk)] = true
			cocall2(chunk)
		end
	end
end

events.BeforeLoadMap = |was| if not was then
	GlobalScripts = {}
	DoLoadScripts(DevPath..[[Scripts\Global\my\*.lua]], GlobalScripts)
end

events.LeaveGame = || events.RemoveFiles(GlobalScripts)
