local TXT = Localize{
	[0] = " ",
	[1] = "Skull Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "I am Sir John Silver.  I was most foully murdered by my Lieutenant when I discovered that he was involved with his sorcererous brother and a senior priest in the Temple of Baa in a conspiracy against King Roland.  There are no good men left in the order, and it sickens my soul to say so.",
	[6] = "I am Sir John Silver.  I was most foully murdered by my Lieutenant when I discovered that he was involved with his sorcererous brother and a senior priest in the Temple of Baa in a conspiracy against King Roland.  I am grateful for the rescue of my niece, Melody, from my treacherous Lieutenant by you.  I will open a secret door to a nearby treasure room for you as a reward for your heroism.",
	[7] = "Mercenary Stronghold",
	[8] = "Skull Door 1",
	[9] = "Skull Door 2",
	[10] = "Skull Door 3",
	[11] = "Skull Door 4",
	[12] = "Skull Door 5",
	[13] = "Skull Door 6",
	[14] = "Skull Door 7",
	[15] = "Skull Door 8",
	[16] = "Skull Door 9",
	[17] = "Skull Door 10",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[7]  -- "Mercenary Stronghold"

evt.hint[1] = evt.str[1]  -- "Skull Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[2] = evt.str[1]  -- "Skull Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[3] = evt.str[1]  -- "Skull Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[4] = evt.str[1]  -- "Skull Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[5] = evt.str[1]  -- "Skull Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[6] = evt.str[1]  -- "Skull Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.hint[7] = evt.str[1]  -- "Skull Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[1]  -- "Skull Door"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Skull Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[12] = evt.str[1]  -- "Skull Door"
evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.hint[13] = evt.str[1]  -- "Skull Door"
evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[16] = evt.str[2]  -- "Chest"
evt.map[16] = function()
	evt.OpenChest(1)
end

evt.hint[17] = evt.str[2]  -- "Chest"
evt.map[17] = function()
	if not evt.Cmp("MapVar0", 2) then
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 322, Y = 524, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = -740, Y = 717, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -628, Y = 649, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = 617, Y = 1921, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -437, Y = 3194, Z = 1}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = 190, Y = 3217, Z = 1}
		evt.Add("MapVar0", 1)
	end
	evt.OpenChest(2)
end

evt.hint[18] = evt.str[2]  -- "Chest"
evt.map[18] = function()
	evt.OpenChest(3)
end

evt.hint[19] = evt.str[2]  -- "Chest"
evt.map[19] = function()
	evt.OpenChest(4)
end

evt.map[20] = function()
	evt.SetDoorState{Id = 8, State = 0}
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[21] = evt.str[4]  -- "Exit"
evt.map[21] = function()
	evt.MoveToMap{X = -4369, Y = -18311, Z = 161, Direction = 1560, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "outc2.odm"}
end

evt.map[24] = function()
	if not evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 1)
		evt.GiveItem{Strength = 6, Type = const.ItemType.Staff, Id = 0}
	end
end

evt.map[25] = function()  -- function events.LoadMap()
	evt.SetFacetBit{Id = 1420, Bit = const.FacetBits.AnimatedTFT, On = false}
	evt.SetTexture{Facet = 1420, Name = "d5walC"}
end

events.LoadMap = evt.map[25].last

