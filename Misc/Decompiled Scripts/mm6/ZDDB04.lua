local TXT = Localize{
	[0] = " ",
	[1] = "Bench",
	[2] = "You find a small wooden dowl.",
	[3] = "Crate",
	[4] = "There seems to be a small hole in the crate.",
	[5] = "You fit the dowl into the hole and a small key pops out.",
	[6] = "The crate is padlocked - you need a key.",
	[7] = "You fit the key into the padlock and it pops open.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[1]  -- "Bench"
evt.map[1] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Add("MapVar0", 1)
		evt.StatusText(2)         -- "You find a small wooden dowl."
	end
end

evt.hint[2] = evt.str[3]  -- "Crate"
evt.map[2] = function()
	evt.OpenChest(1)
end

evt.hint[3] = evt.str[3]  -- "Crate"
evt.map[3] = function()
	evt.OpenChest(0)
end

