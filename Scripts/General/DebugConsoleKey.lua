-- Activate debug console by Ctrl+F1

function events.KeyDown(t)
	if t.Key == const.Keys.F1 and Keys.IsPressed(const.Keys.CTRL) then
		t.Key = 0
		debug.debug()
	end
end
