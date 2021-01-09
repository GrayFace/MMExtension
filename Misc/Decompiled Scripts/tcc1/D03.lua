local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "(removed) White Wine",
	[6] = "(removed) +1 Luck Permanent",
	[7] = "(removed) +4 Endurance Temporary",
	[8] = "(removed) Hic",
	[9] = "The door is locked.",
	[10] = "(removed) Suspicious Floor",
	[11] = "(removed) Deleted",
	[12] = "(removed) +10 Hit Points Temporary",
	[13] = "(removed) Stout Malt Ale",
	[14] = "(removed) You're too drunk to find the barrel!",
	[15] = "Door",
	[16] = "Tortuga Hall",
	[17] = "Brianna's Brandy",
	[18] = "The cauldron is empty",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[16]  -- "Tortuga Hall"

evt.hint[1] = evt.str[17]  -- "Brianna's Brandy"
evt.map[1] = function()
	if evt.Cmp("QBits", 484) then         -- Brianna's Brandy Once
		evt.StatusText(18)         -- "The cauldron is empty"
	else
		evt.ForPlayer("All")
		evt.Set("IdentifyItemSkill", 68)
		evt.Set("QBits", 484)         -- Brianna's Brandy Once
	end
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[3]  -- "Switch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.hint[4] = evt.str[15]  -- "Door"
evt.map[4] = function()
	if evt.Cmp("Inventory", 560) then         -- "Guild Key"
		evt.Subtract("Inventory", 560)         -- "Guild Key"
		evt.SetDoorState{Id = 4, State = 1}
	else
		evt.StatusText(9)         -- "The door is locked."
	end
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[3]  -- "Switch"
evt.map[8] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
end

evt.hint[9] = evt.str[1]  -- "Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[12] = evt.str[3]  -- "Switch"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[13] = evt.str[3]  -- "Switch"
evt.map[13] = function()
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
	evt.SetDoorState{Id = 13, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[14] = evt.str[1]  -- "Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[1]  -- "Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[2]  -- "Chest"
evt.map[17] = function()
	evt.OpenChest(1)
end

evt.hint[18] = evt.str[2]  -- "Chest"
evt.map[18] = function()
	evt.OpenChest(2)
end

evt.hint[19] = evt.str[2]  -- "Chest"
evt.map[19] = function()
	evt.OpenChest(3)
end

evt.hint[20] = evt.str[4]  -- "Exit"
evt.map[20] = function()
	evt.MoveToMap{X = -18400, Y = -14982, Z = 1600, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE3.Odm"}
end

evt.map[21] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 560) then         -- "Guild Key"
			evt.CastSpell{Spell = 6, Mastery = const.Novice, Skill = 3, FromX = -52, FromY = 1162, FromZ = 128, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
			return
		end
	end
	evt.Set("MapVar0", 1)
end

evt.map[25] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 12) then         -- 12 D3, given when you save Mom.
		evt.SetSprite{SpriteId = 52, Visible = 1, Name = "0"}
		evt.SetSprite{SpriteId = 53, Visible = 1, Name = "0"}
		evt.SetSprite{SpriteId = 54, Visible = 1, Name = "0"}
		evt.SetSprite{SpriteId = 55, Visible = 1, Name = "0"}
		evt.SetSprite{SpriteId = 56, Visible = 1, Name = "0"}
		evt.SetSprite{SpriteId = 57, Visible = 1, Name = "0"}
	end
end

events.LoadMap = evt.map[25].last

evt.map[26] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.GiveItem{Strength = 4, Type = const.ItemType.Ring_, Id = 0}
	end
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 496) then         -- Tortuga Hall Reload
		if evt.Cmp("QBits", 508) then         -- Warrior
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = -130, Y = 630, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -1408, Y = -269, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -127, Y = 2225, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 8, X = 592, Y = 4115, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -2452, Y = 4191, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = -1213, Y = 3613, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -3876, Y = 1048, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = -1731, Y = 1357, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 5, X = -1411, Y = 1133, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -1213, Y = 3610, Z = 1}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -2452, Y = 4180, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 592, Y = 4110, Z = -255}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -125, Y = 2220, Z = -255}
			if evt.Cmp("QBits", 507) then         -- Death Wish
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -1352, Y = -605, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -156, Y = 5931, Z = -255}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -1622, Y = 5582, Z = -255}
				evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = -1555, Y = 3556, Z = -255}
				evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 7, X = -2481, Y = -522, Z = 1}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -1070, Y = 13591, Z = 1}
				evt.Set("QBits", 496)         -- Tortuga Hall Reload
			else
				evt.Set("QBits", 496)         -- Tortuga Hall Reload
			end
		end
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

