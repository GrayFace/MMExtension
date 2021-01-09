local TXT = Localize{
	[0] = " ",
	[1] = "Crumbling boulder.",
	[2] = "The vent brings in fresh air.",
	[3] = "Poisonous spores force you back.",
	[4] = "Vent.",
	[5] = "The air smells stale and makes you cough.",
	[6] = "A small nymph comes out of a hole in the floor thanking you for clearing the spores, he shakes your hand vigorously then disappears down the hole (which somehow disappears after him). +500 experience.",
	[7] = "Small switch.",
	[8] = "",
	[9] = "Chest",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.map[1] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.StatusText(5)         -- "The air smells stale and makes you cough."
		evt.Add("MapVar0", 1)
	end
end

evt.map[2] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.StatusText(3)         -- "Poisonous spores force you back."
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 8}
		evt.MoveToMap{X = -128, Y = -1152, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
		evt.Set("MapVar2", 1)
	end
end

evt.hint[3] = evt.str[1]  -- "Crumbling boulder."
evt.map[3] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(2)         -- "The vent brings in fresh air."
		evt.SetSprite{SpriteId = 1, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.Set("MapVar1", 1)
	end
end

evt.hint[4] = evt.str[7]  -- "Small switch."
evt.map[4] = function()
	evt.SetTexture{Facet = 99, Name = "D8s2on"}
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[5] = evt.str[9]  -- "Chest"
evt.map[5] = function()
	evt.OpenChest(0)
end

evt.map[6] = function()
	if not evt.Cmp("MapVar3", 1) then
		if evt.Cmp("MapVar1", 1) then
			evt.SetMessage(6)         -- "A small nymph comes out of a hole in the floor thanking you for clearing the spores, he shakes your hand vigorously then disappears down the hole (which somehow disappears after him). +500 experience."
			evt.SimpleMessage()
			evt.ForPlayer("All")
			evt.Add("Experience", 500)
			evt.Add("MapVar3", 1)
		end
	end
end

