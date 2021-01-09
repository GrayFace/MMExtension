local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "",
	[3] = "",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Pillar",
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
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.hint[176] = evt.str[3]  -- ""
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- ""
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- ""
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- ""
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- ""
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- ""
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- ""
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- ""
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- ""
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- ""
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- ""
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- ""
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- ""
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- ""
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- ""
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- ""
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- ""
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- ""
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- ""
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- ""
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.map[376] = function()
	if evt.Cmp("QBits", 27) then         -- "Find the lost meditation spot in the Dwarven Barrows."
		evt.SpeakNPC(55)         -- "Bartholomew Hume"
	end
end

evt.map[377] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 65) then         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
		if evt.Cmp("QBits", 54) then         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
			if evt.Cmp("Inventory", 626) then         -- "Zokarr IV's Skull"
				evt.Subtract("Inventory", 626)         -- "Zokarr IV's Skull"
				evt.Set("QBits", 65)         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
				evt.ForPlayer("All")
				evt.Add("QBits", 245)         -- "Congratulations"
				evt.Subtract("QBits", 245)         -- "Congratulations"
				evt.Subtract("QBits", 228)         -- Dwarf Bones - I lost it
			end
		end
	end
end

evt.hint[451] = evt.str[9]  -- "Pillar"
evt.map[451] = function()
	evt.Set("MapVar0", 1)
end

evt.hint[452] = evt.str[9]  -- "Pillar"
evt.map[452] = function()
	evt.Set("MapVar1", 1)
end

evt.hint[453] = evt.str[9]  -- "Pillar"
evt.map[453] = function()
	evt.Set("MapVar2", 1)
end

evt.hint[454] = evt.str[9]  -- "Pillar"
evt.map[454] = function()
	evt.Set("MapVar3", 1)
end

evt.hint[455] = evt.str[1]  -- "Door"
evt.map[455] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.map[456] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[501] = evt.str[2]  -- ""
evt.map[501] = function()
	local i
	i = Game.Rand() % 6
	if i >= 3 and i <= 5 then
		evt.MoveToMap{X = 335, Y = -1064, Z = 1, Direction = 768, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDK02.blv"}
	else
		evt.MoveToMap{X = -426, Y = 281, Z = -15, Direction = 1664, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "MDT02.blv"}
	end
end

