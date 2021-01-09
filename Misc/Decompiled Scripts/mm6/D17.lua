local TXT = Localize{
	[0] = " ",
	[1] = "Wooden Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "You find a Pearl.",
	[6] = "Wolf Altar",
	[7] = "After 7 days.",
	[8] = "Crate",
	[9] = "Magic Door",
	[10] = "The door is locked.",
	[11] = "Deleted",
	[12] = "The Werewolves butchered us.  Will you avenge us - so our souls may rest in peace?",
	[13] = "Reply?",
	[14] = "Yes",
	[15] = "Y",
	[16] = "Found Scroll",
	[17] = "Empty",
	[18] = "Lair of the Wolf",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[18]  -- "Lair of the Wolf"
Game.LoadSound(233)

evt.hint[2] = evt.str[1]  -- "Wooden Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Wooden Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Wooden Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Wooden Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[1]  -- "Wooden Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[1]  -- "Wooden Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[9]  -- "Magic Door"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 1}
end

evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[1]  -- "Wooden Door"
evt.map[11] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.map[12] = function()
	evt.SetDoorState{Id = 12, State = 1}
end

evt.map[13] = function()
	evt.SetDoorState{Id = 13, State = 1}
end

evt.hint[14] = evt.str[1]  -- "Wooden Door"
evt.map[14] = function()
	evt.SetDoorState{Id = 14, State = 1}
end

evt.hint[15] = evt.str[1]  -- "Wooden Door"
evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[1]  -- "Wooden Door"
evt.map[16] = function()
	evt.SetDoorState{Id = 16, State = 1}
end

evt.hint[17] = evt.str[1]  -- "Wooden Door"
evt.map[17] = function()
	evt.SetDoorState{Id = 17, State = 1}
end

evt.hint[18] = evt.str[1]  -- "Wooden Door"
evt.map[18] = function()
	evt.SetDoorState{Id = 18, State = 1}
end

evt.hint[19] = evt.str[1]  -- "Wooden Door"
evt.map[19] = function()
	evt.SetDoorState{Id = 19, State = 1}
end

evt.hint[20] = evt.str[1]  -- "Wooden Door"
evt.map[20] = function()
	evt.SetDoorState{Id = 20, State = 1}
end

evt.hint[21] = evt.str[1]  -- "Wooden Door"
evt.map[21] = function()
	evt.SetDoorState{Id = 21, State = 1}
end

evt.hint[22] = evt.str[1]  -- "Wooden Door"
evt.map[22] = function()
	evt.SetDoorState{Id = 22, State = 1}
end

evt.hint[23] = evt.str[1]  -- "Wooden Door"
evt.map[23] = function()
	evt.SetDoorState{Id = 23, State = 1}
end

evt.hint[24] = evt.str[1]  -- "Wooden Door"
evt.map[24] = function()
	evt.SetDoorState{Id = 24, State = 1}
end

evt.hint[25] = evt.str[1]  -- "Wooden Door"
evt.map[25] = function()
	evt.SetDoorState{Id = 25, State = 1}
end

evt.map[26] = function()
	evt.SetDoorState{Id = 9, State = 0}
	evt.SetDoorState{Id = 34, State = 0}
end

evt.map[27] = function()
	evt.SetDoorState{Id = 12, State = 0}
end

evt.map[28] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.map[29] = function()
	local i
	evt.SetDoorState{Id = 8, State = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = -3019, Y = -7145, Z = 1313}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 4, X = -3019, Y = -7391, Z = 1313}
	evt.PlaySound{Id = 233, X = 0, Y = 0}
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 3, State = 0}
	i = Game.Rand() % 4
	if i == 1 then
		evt.FaceExpression{Player = "Random", Frame = 29}
	elseif i == 2 then
		evt.FaceExpression{Player = "Random", Frame = 30}
	elseif i == 3 then
		evt.FaceExpression{Player = "Random", Frame = 39}
	else
		evt.FaceExpression{Player = "All", Frame = 13}
	end
end

evt.hint[30] = evt.str[1]  -- "Wooden Door"
evt.map[30] = function()
	evt.SetDoorState{Id = 30, State = 1}
end

evt.map[31] = function()
	evt.SetDoorState{Id = 32, State = 0}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.map[32] = function()
	evt.SetDoorState{Id = 32, State = 1}
end

evt.map[33] = function()
	evt.SetDoorState{Id = 33, State = 1}
end

evt.hint[34] = evt.str[3]  -- "Switch"
evt.map[34] = function()
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[35] = evt.str[1]  -- "Wooden Door"
evt.map[35] = function()
	evt.SetDoorState{Id = 35, State = 1}
end

evt.hint[36] = evt.str[1]  -- "Wooden Door"
evt.map[36] = function()
	evt.SetDoorState{Id = 36, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
end

evt.hint[37] = evt.str[1]  -- "Wooden Door"
evt.map[37] = function()
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 39, State = 1}
end

evt.hint[38] = evt.str[1]  -- "Wooden Door"
evt.map[38] = function()
	evt.SetDoorState{Id = 28, State = 1}
	evt.SetDoorState{Id = 29, State = 1}
end

evt.hint[39] = evt.str[1]  -- "Wooden Door"
evt.map[39] = function()
	evt.SetDoorState{Id = 26, State = 1}
	evt.SetDoorState{Id = 27, State = 1}
end

evt.hint[40] = evt.str[2]  -- "Chest"
evt.map[40] = function()
	evt.OpenChest(1)
end

evt.hint[41] = evt.str[2]  -- "Chest"
evt.map[41] = function()
	evt.OpenChest(2)
end

evt.hint[42] = evt.str[2]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(3)
end

evt.hint[43] = evt.str[2]  -- "Chest"
evt.map[43] = function()
	evt.OpenChest(4)
end

evt.hint[44] = evt.str[2]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(5)
end

evt.hint[45] = evt.str[2]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(6)
end

evt.hint[46] = evt.str[2]  -- "Chest"
evt.map[46] = function()
	evt.OpenChest(7)
end

evt.map[47] = function()
	evt.MoveToMap{X = 4747, Y = -16024, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[48] = function()
	evt.MoveToMap{X = 4439, Y = -9086, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[49] = function()
	evt.MoveToMap{X = 2427, Y = -19303, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[50] = function()
	evt.MoveToMap{X = 2673, Y = -11904, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[51] = function()
	evt.MoveToMap{X = 8583, Y = -16348, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.map[52] = function()
	evt.MoveToMap{X = 8827, Y = -9341, Z = 1825, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
end

evt.hint[54] = evt.str[6]  -- "Wolf Altar"
evt.map[54] = function()
	if not evt.Cmp("Inventory", 459) then         -- "Pearl of Purity"
		if not evt.Cmp("QBits", 20) then         -- 20 D17, given when party digs up tiger statue quest item.
			return
		end
	end
	evt.SetTexture{Facet = 5083, Name = "D7wl1ctr2"}
	evt.SetTexture{Facet = 5084, Name = "D7wl1ctr2"}
	evt.SetTexture{Facet = 5085, Name = "D7wl1ctr2"}
	evt.SetTexture{Facet = 5081, Name = "D7wl1ctr2"}
	evt.SetTexture{Facet = 5082, Name = "D7wl1ctr2"}
	evt.Set("QBits", 17)         -- 17 D17, given when wolf altar is destroyed.
	evt.SetDoorState{Id = 53, State = 1}
end

evt.map[55] = function()
	if not evt.Cmp("QBits", 35) then         -- 35 D17 Brought back Black Pearl and Ghost will no longer show up.
		evt.SetFacetBit{Id = 5290, Bit = const.FacetBits.AnimatedTFT, On = true}
		evt.SetTexture{Facet = 5290, Name = "paladn01"}
	end
end

evt.map[56] = function()
	if not evt.Cmp("QBits", 20) then         -- 20 D17, given when party digs up tiger statue quest item.
		if evt.Cmp("QBits", 142) then         -- NPC
			evt.Add("HourIs", 900)
			evt.StatusText(5)         -- "You find a Pearl."
			evt.Add("Inventory", 459)         -- "Pearl of Purity"
			evt.Set("QBits", 20)         -- 20 D17, given when party digs up tiger statue quest item.
		end
	end
end

evt.hint[58] = evt.str[4]  -- "Exit"
evt.map[58] = function()
	evt.MoveToMap{X = -13100, Y = 2028, Z = 161, Direction = 640, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outb2.odm"}
end

evt.map[59] = function()
	local i
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -130, Y = -2922, Z = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 2, X = 122, Y = -2922, Z = 1}
	evt.PlaySound{Id = 233, X = 0, Y = 0}
	i = Game.Rand() % 4
	if i == 1 then
		evt.FaceExpression{Player = "Random", Frame = 29}
	elseif i == 2 then
		evt.FaceExpression{Player = "Random", Frame = 30}
	elseif i == 3 then
		evt.FaceExpression{Player = "Random", Frame = 39}
	else
		evt.FaceExpression{Player = "All", Frame = 13}
	end
end

evt.map[61] = function()
	local i
	evt.SetDoorState{Id = 14, State = 0}
	evt.SetDoorState{Id = 15, State = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 2, X = 4302, Y = -3134, Z = -511}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 4490, Y = -3087, Z = -511}
	evt.PlaySound{Id = 233, X = 0, Y = 0}
	i = Game.Rand() % 4
	if i == 1 then
		evt.FaceExpression{Player = "Random", Frame = 29}
	elseif i == 2 then
		evt.FaceExpression{Player = "Random", Frame = 30}
	elseif i == 3 then
		evt.FaceExpression{Player = "Random", Frame = 39}
	else
		evt.FaceExpression{Player = "All", Frame = 13}
	end
end

evt.hint[62] = evt.str[8]  -- "Crate"
evt.map[62] = function()
	evt.OpenChest(8)
end

evt.hint[63] = evt.str[8]  -- "Crate"
evt.map[63] = function()
	evt.OpenChest(9)
end

evt.hint[64] = evt.str[8]  -- "Crate"
evt.map[64] = function()
	evt.OpenChest(10)
end

evt.hint[65] = evt.str[8]  -- "Crate"
evt.map[65] = function()
	evt.OpenChest(11)
end

evt.map[67] = function()
	local i
	evt.SetDoorState{Id = 1, State = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -130, Y = -2922, Z = 1}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 6, X = 122, Y = -2922, Z = 1}
	evt.PlaySound{Id = 233, X = 0, Y = 0}
	i = Game.Rand() % 4
	if i == 1 then
		evt.FaceExpression{Player = "Random", Frame = 29}
	elseif i == 2 then
		evt.FaceExpression{Player = "Random", Frame = 30}
	elseif i == 3 then
		evt.FaceExpression{Player = "Random", Frame = 39}
	else
		evt.FaceExpression{Player = "All", Frame = 13}
	end
end

evt.map[68] = function()
	local i
	evt.SetDoorState{Id = 1, State = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -3019, Y = -7145, Z = 1313}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 6, X = -3019, Y = -7391, Z = 1313}
	evt.SetDoorState{Id = 2, State = 0}
	evt.SetDoorState{Id = 3, State = 0}
	evt.PlaySound{Id = 233, X = 0, Y = 0}
	i = Game.Rand() % 4
	if i == 1 then
		evt.FaceExpression{Player = "Random", Frame = 29}
	elseif i == 2 then
		evt.FaceExpression{Player = "Random", Frame = 30}
	elseif i == 3 then
		evt.FaceExpression{Player = "Random", Frame = 39}
	else
		evt.FaceExpression{Player = "All", Frame = 13}
	end
end

evt.hint[73] = evt.str[8]  -- "Crate"
evt.map[73] = function()
	evt.StatusText(17)         -- "Empty"
end

evt.map[74] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 17) then         -- 17 D17, given when wolf altar is destroyed.
		evt.SetTexture{Facet = 5083, Name = "D7wl1ctr2"}
		evt.SetTexture{Facet = 5084, Name = "D7wl1ctr2"}
		evt.SetTexture{Facet = 5085, Name = "D7wl1ctr2"}
		evt.SetTexture{Facet = 5081, Name = "D7wl1ctr2"}
		evt.SetTexture{Facet = 5082, Name = "D7wl1ctr2"}
	end
end

events.LoadMap = evt.map[74].last

evt.map[90] = function()
	if not evt.Cmp("QBits", 35) then         -- 35 D17 Brought back Black Pearl and Ghost will no longer show up.
		evt.Set("QBits", 142)         -- NPC
		evt.SpeakNPC(295)         -- "Ghost of Balthasar"
	end
end

