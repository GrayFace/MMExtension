local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Cave",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "Strange Torch",
	[13] = "The exit is sealed!",
	[14] = "You Successfully disarm the trap",
	[15] = "The chest is locked",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 303) then         -- Reward
		if not evt.Cmp("QBits", 302) then         -- Small House only Once
			if evt.Cmp("QBits", 99) then         -- Chose the path of Light
				evt.Set("QBits", 302)         -- Small House only Once
				evt.SpeakNPC(423)         -- "Maximus"
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
			else
				if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
					evt.Set("QBits", 302)         -- Small House only Once
					evt.SpeakNPC(385)         -- "Sir Carneghem"
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = 3, Y = 3042, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 718, Y = 2956, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -646, Y = 2889, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = 0, Y = 3500, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 10, X = -31, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = 597, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
					evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 10, X = -624, Y = 1900, Z = 0, -- ERROR: Not found
NPCGroup = 1536, unk = 0}
				end
			end
		end
	end
end

events.LoadMap = evt.map[1].last

evt.map[2] = function()
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		evt.Set("QBits", 118)         -- Killed Good MM3 Person
	else
		if evt.CheckMonstersKilled{CheckType = 3, Id = 1, Count = 0} then
			evt.Set("QBits", 119)         -- Killed Evil MM3 Person
		end
	end
	evt.Add("QBits", 234)         -- Control Cube - I lost it
end

evt.hint[5] = evt.str[12]  -- "Strange Torch"
evt.map[5] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "nwc.blv"}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	if evt.Cmp("QBits", 303) then         -- Reward
		evt.OpenChest(1)
	else
		evt.StatusText(15)         -- "The chest is locked"
	end
end

evt.hint[177] = evt.str[1]  -- "Door"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[1]  -- "Door"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[1]  -- "Door"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[1]  -- "Door"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[1]  -- "Door"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[1]  -- "Door"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[1]  -- "Door"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[1]  -- "Door"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[1]  -- "Door"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[1]  -- "Door"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[1]  -- "Door"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[1]  -- "Door"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[1]  -- "Door"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[1]  -- "Door"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[1]  -- "Door"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[1]  -- "Door"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[1]  -- "Door"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[1]  -- "Door"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[1]  -- "Door"
evt.map[195] = function()
	if evt.Cmp("QBits", 303) then         -- Reward
		evt.OpenChest(0)
	else
		evt.StatusText(15)         -- "The chest is locked"
	end
end

evt.map[501] = function()
	evt.StatusText(13)         -- "The exit is sealed!"
end

evt.map[502] = function()
	if not evt.Cmp("QBits", 367) then         -- 0
		evt.MoveNPC{NPC = 85, HouseId = 434}         -- "Maximus" -> "Hostel"
		evt.SetNPCTopic{NPC = 85, Index = 0, Event = 0}         -- "Maximus"
		evt.SetNPCTopic{NPC = 85, Index = 1, Event = 128}         -- "Maximus" : "Congratulations!"
		evt.Set("QBits", 367)         -- 0
	end
	evt.MoveToMap{X = -7745, Y = -6673, Z = 65, Direction = 2047, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "D26.blv"}
end

