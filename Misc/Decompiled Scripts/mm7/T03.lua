local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Grand Temple of the Sun",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Altar",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "You have Desecrated the altar",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 2}         -- switch state
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[1]  -- "Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.hint[10] = evt.str[4]  -- "Button"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.Subtract("MapVar0", 1)
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[11] = evt.str[4]  -- "Button"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
	evt.Subtract("MapVar0", 1)
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[12] = evt.str[4]  -- "Button"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.Subtract("MapVar0", 1)
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[13] = evt.str[4]  -- "Button"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.Subtract("MapVar0", 1)
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[14] = evt.str[4]  -- "Button"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 2}         -- switch state
	evt.Set("MapVar0", 1)
end

evt.hint[15] = evt.str[4]  -- "Button"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 2}         -- switch state
	evt.Subtract("MapVar0", 1)
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[16] = evt.str[4]  -- "Button"
evt.map[16] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.SetDoorState{Id = 16, State = 2}         -- switch state
		evt.SetDoorState{Id = 9, State = 2}         -- switch state
	end
end

evt.hint[17] = evt.str[1]  -- "Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[18] = evt.str[1]  -- "Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
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

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[376] = evt.str[9]  -- "Altar"
evt.map[376] = function()
	if not evt.Cmp("QBits", 63) then         -- Defaced the Altar of Good.  Priest of Dark promo quest.
		if evt.Cmp("QBits", 44) then         -- "Deface the Altar of Good in the Temple of the Sun on Evenmorn Isle then return to Daedalus Falk in the Deyja Moors."
			evt.SetTexture{Facet = 20, Name = "Cfb1"}
			evt.Set("QBits", 63)         -- Defaced the Altar of Good.  Priest of Dark promo quest.
			evt.ForPlayer("All")
			evt.Add("QBits", 245)         -- "Congratulations"
			evt.Subtract("QBits", 245)         -- "Congratulations"
			evt.StatusText(15)         -- "You have Desecrated the altar"
		end
	end
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -5, FromY = 3919, FromZ = 288, ToX = 0, ToY = 1044, ToZ = 289}         -- "Fireball"
end

evt.hint[501] = evt.str[2]  -- "Leave the Grand Temple of the Sun"
evt.map[501] = function()
	evt.MoveToMap{X = -7166, Y = 11033, Z = 185, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "Out09.odm"}
end

