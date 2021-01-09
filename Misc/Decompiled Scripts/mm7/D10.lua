local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Breeding Zone",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[3] = evt.str[4]  -- "Button"
evt.map[3] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
end

evt.hint[4] = evt.str[4]  -- "Button"
evt.map[4] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
end

evt.hint[5] = evt.str[4]  -- "Button"
evt.map[5] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 16, State = 2}         -- switch state
end

evt.hint[6] = evt.str[16]  -- "Take a Drink"
evt.map[6] = function()
	evt.SetDoorState{Id = 31, State = 2}         -- switch state
end

evt.hint[7] = evt.str[4]  -- "Button"
evt.map[7] = function()
	evt.SetDoorState{Id = 32, State = 2}         -- switch state
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 40, State = 2}         -- switch state
end

evt.hint[9] = evt.str[4]  -- "Button"
evt.map[9] = function()
	evt.SetDoorState{Id = 53, State = 2}         -- switch state
	evt.SetDoorState{Id = 50, State = 2}         -- switch state
end

evt.hint[10] = evt.str[4]  -- "Button"
evt.map[10] = function()
	evt.SetDoorState{Id = 52, State = 2}         -- switch state
	evt.SetDoorState{Id = 51, State = 2}         -- switch state
end

evt.hint[11] = evt.str[1]  -- "Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[12] = evt.str[1]  -- "Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	if not evt.Cmp("MapVar0", 1) then
		if evt.Cmp("QBits", 239) then         -- Got the Divine Intervention
			evt.OpenChest(19)
			return
		end
	end
	evt.OpenChest(0)
	evt.Add("QBits", 239)         -- Got the Divine Intervention
	evt.Add("QBits", 226)         -- Book of Divine Intervention - I lost it
	evt.Set("MapVar0", 1)
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 7, FromX = -4686, FromY = 3674, FromZ = -447, ToX = -4686, ToY = 1445, ToZ = -447}         -- "Blades"
	evt.CastSpell{Spell = 39, Mastery = const.GM, Skill = 7, FromX = -4686, FromY = 1445, FromZ = -447, ToX = -4686, ToY = 3674, ToZ = -447}         -- "Blades"
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 8, FromX = -768, FromY = 2432, FromZ = 257, ToX = 1664, ToY = 2432, ToZ = 257}         -- "Fireball"
end

evt.hint[501] = evt.str[2]  -- "Leave the Breeding Zone"
evt.map[501] = function()
	evt.MoveToMap{X = -5376, Y = 474, Z = -415, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D26.blv"}
end

evt.hint[502] = evt.str[2]  -- "Leave the Breeding Zone"
evt.map[502] = function()
	evt.Set("QBits", 129)         -- Completed Breeding Pit.
	evt.MoveToMap{X = -5376, Y = 474, Z = -415, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D26.blv"}
end

