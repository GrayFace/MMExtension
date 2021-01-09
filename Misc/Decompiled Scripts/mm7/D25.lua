local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "Leave Celeste",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "House",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Castle Lambent",
	[26] = "Temple of the Light",
	[27] = "Walls of Mist",
	[28] = "",
	[29] = "",
	[30] = "Enter Castle Lambent",
	[31] = "Enter The Temple of the Light",
	[32] = "Enter the Walls of Mist",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "eut__i_n",
	[52] = "",
	[53] = "",
	[54] = "",
	[55] = "",
	[56] = "",
	[57] = "",
	[58] = "",
	[59] = "",
	[60] = "",
	[61] = "",
	[62] = "",
	[63] = "",
	[64] = "",
	[65] = "",
	[66] = "",
	[67] = "",
	[68] = "",
	[69] = "",
	[70] = "+25 to all Stats(Temporary)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.Add("QBits", 209)         -- Celeste - Town Portal
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		goto _7
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if evt.Cmp("Counter10", 720) then
			evt.Subtract("QBits", 270)         -- Your friends are mad at you 
			evt.Set("MapVar4", 0)
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
			return
		end
		goto _7
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_8::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_7::
	evt.Set("MapVar4", 2)
	goto _8
end

events.LoadMap = evt.map[1].last

evt.map[3] = function()
	evt.SetDoorState{Id = 5, State = 2}         -- switch state
end

evt.map[4] = function()
	evt.SetDoorState{Id = 1, State = 2}         -- switch state
	evt.SetDoorState{Id = 2, State = 2}         -- switch state
end

evt.map[5] = function()
	evt.SetDoorState{Id = 3, State = 2}         -- switch state
	evt.SetDoorState{Id = 4, State = 2}         -- switch state
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

evt.house[376] = 428  -- "Hostel"
evt.map[376] = function()
	if evt.Cmp("QBits", 127) then         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
		evt.MoveToMap{X = 0, Y = 3808, Z = 129, Direction = 270, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 9, Name = "MDT15.blv"}
		return
	end
	if evt.Cmp("QBits", 114) then         -- Finished Wizard Proving Grounds
		if evt.Cmp("QBits", 115) then         -- Finished Wizard Task 2 - Temple of Dark
			if evt.Cmp("QBits", 116) then         -- Finished Wizard Task 3 - Wine Cellar
				if evt.Cmp("QBits", 117) then         -- Finished Wizard Task 4 - Soul Jars
					if evt.Cmp("QBits", 119) then         -- Killed Evil MM3 Person
						evt.MoveNPC{NPC = 80, HouseId = 182}         -- "Resurectra" -> "Throne Room"
					elseif not evt.Cmp("QBits", 198) then         -- Archibald in Clankers Lab now
						evt.SetNPCGreeting{NPC = 83, Greeting = 121}         -- "Robert the Wise" : "I'm glad you're back, friends.  "
						evt.Set("QBits", 198)         -- Archibald in Clankers Lab now
					end
				end
			end
		end
	end
	evt.EnterHouse(428)         -- "Hostel"
end

evt.hint[377] = evt.str[100]  -- ""
evt.map[377] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 21) then         -- "Go to the Celestial Court in Celeste and kill Lady Eleanor Carmine.  Return with proof to Seknit Undershadow in the Deyja Moors."
		evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Invisible, On = false}         -- ""
		evt.SetMonGroupBit{NPCGroup = 1, Bit = const.MonsterBits.Hostile, On = true}         -- ""
		evt.Set("MapVar0", 1)
	end
end

events.LoadMap = evt.map[377].last

evt.hint[378] = evt.str[100]  -- ""
evt.map[378] = function()  -- function events.LeaveMap()
	if evt.Cmp("MapVar0", 1) then
		if evt.CheckMonstersKilled{CheckType = 1, Id = 1, Count = 0} then
			evt.Set("QBits", 213)         -- Dagger - I lost it
		end
	end
end

events.LeaveMap = evt.map[378].last

evt.hint[415] = evt.str[50]  -- "Obelisk"
evt.map[415] = function()
	if not evt.Cmp("QBits", 169) then         -- Visited Obelisk in Area 7
		evt.StatusText(51)         -- "eut__i_n"
		evt.Add("AutonotesBits", 119)         -- ""
		evt.Add("QBits", 169)         -- Visited Obelisk in Area 7
	end
end

evt.hint[416] = evt.str[9]  -- "House"
evt.HouseDoor(417, 422)  -- "House Devine"
evt.HouseDoor(418, 423)  -- "Morningstar Residence"
evt.HouseDoor(419, 424)  -- "House Winterbright"
evt.house[420] = 425  -- "Hostel"
evt.map[420] = function()
	if evt.Cmp("QBits", 119) then         -- Killed Evil MM3 Person
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(425)         -- "Hostel"
	end
end

evt.HouseDoor(421, 426)  -- "Hostel"
evt.HouseDoor(422, 427)  -- "Hostel"
evt.HouseDoor(423, 430)  -- "Ramiez Residence"
evt.HouseDoor(424, 429)  -- "Tarent Residence"
evt.HouseDoor(426, 431)  -- "Hostel"
evt.HouseDoor(427, 432)  -- "Hostel"
evt.house[428] = 5  -- "The Hallowed Sword"
evt.HouseDoor(429, 5)  -- "The Hallowed Sword"
evt.house[430] = 19  -- "Armor of Honor"
evt.HouseDoor(431, 19)  -- "Armor of Honor"
evt.house[432] = 93  -- "Trial of Honor"
evt.HouseDoor(433, 93)  -- "Trial of Honor"
evt.house[434] = 113  -- "The Blessed Brew"
evt.HouseDoor(435, 113)  -- "The Blessed Brew"
evt.house[436] = 131  -- "Material Wealth"
evt.HouseDoor(437, 131)  -- "Material Wealth"
evt.house[438] = 48  -- "Phials of Faith"
evt.HouseDoor(439, 48)  -- "Phials of Faith"
evt.house[440] = 146  -- "Paramount Guild of Air"
evt.HouseDoor(441, 146)  -- "Paramount Guild of Air"
evt.house[442] = 168  -- "Guild of Enlightenment"
evt.HouseDoor(443, 168)  -- "Guild of Enlightenment"
evt.house[444] = 35  -- "Esoteric Indulgences"
evt.HouseDoor(445, 35)  -- "Esoteric Indulgences"
evt.house[446] = 105  -- "Hall of Dawn"
evt.HouseDoor(447, 105)  -- "Hall of Dawn"
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	local i
	i = Game.Rand() % 6
	if i == 1 then
		goto _6
	elseif i == 2 then
		goto _2
	elseif i == 3 then
		goto _3
	elseif i == 4 then
		goto _4
	elseif i == 5 then
		goto _5
	end
	evt.MoveToMap{X = 8146, Y = 4379, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
::_2::
	evt.MoveToMap{X = -2815, Y = 1288, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out06.odm"}
::_3::
	evt.MoveToMap{X = -11883, Y = 8667, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out06.odm"}
::_4::
	evt.MoveToMap{X = -22231, Y = 13145, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out06.odm"}
::_5::
	evt.MoveToMap{X = -12770, Y = 18344, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out06.odm"}
::_6::
	evt.MoveToMap{X = 9185, Y = 18564, Z = 3700, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out06.odm"}
end

evt.hint[452] = evt.str[16]  -- "Take a Drink"
evt.map[452] = function()
	if not evt.Cmp("PlayerBits", 30) then
		evt.Add("MightBonus", 25)
		evt.Add("IntellectBonus", 25)
		evt.Add("PersonalityBonus", 25)
		evt.Add("EnduranceBonus", 25)
		evt.Add("AccuracyBonus", 25)
		evt.Add("SpeedBonus", 25)
		evt.Add("LuckBonus", 25)
		evt.StatusText(70)         -- "+25 to all Stats(Temporary)"
		evt.Add("PlayerBits", 30)
	end
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 30)
end, const.Day)

evt.hint[501] = evt.str[2]  -- "Leave Celeste"
evt.map[501] = function()
	evt.MoveToMap{X = -9718, Y = 10097, Z = 2449, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "out06.odm"}
end

evt.hint[502] = evt.str[32]  -- "Enter the Walls of Mist"
evt.map[502] = function()
	evt.MoveToMap{X = -896, Y = -4717, Z = 161, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 203, Icon = 9, Name = "D11.blv"}         -- "Walls of Mist"
end

evt.hint[503] = evt.str[30]  -- "Enter Castle Lambent"
evt.map[503] = function()
	evt.MoveToMap{X = 64, Y = -640, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 181, Icon = 9, Name = "D30.blv"}         -- "Castle Lambent"
end

evt.HouseDoor(504, 80)  -- "Temple of Light"
