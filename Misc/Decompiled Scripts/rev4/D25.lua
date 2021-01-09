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

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	evt.Add("QBits", 209)         -- Celeste - Town Portal
	if evt.Cmp("QBits", 293) then         -- Return to NWC
		goto _15
	end
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		goto _7
	end
	if evt.Cmp("QBits", 270) then         -- Your friends are mad at you 
		if not evt.Cmp("Counter10", 720) then
			goto _7
		end
		evt.Subtract("QBits", 270)         -- Your friends are mad at you 
		evt.Set("MapVar4", 0)
		goto _15
	end
	if not evt.Cmp("MapVar4", 2) then
		return
	end
::_8::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
	do return end
::_15::
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = false}         -- "Generic Monster Group for Dungeons"
	evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = false}         -- "Guards"
	do return end
::_7::
	evt.Set("MapVar4", 2)
	goto _8
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 325) then         -- Resurectra
		if evt.Cmp("BlasterSkill", 1) then
			evt.Set("QBits", 325)         -- Resurectra
			evt.SetNPCGreeting{NPC = 19, Greeting = 21}         --[[ "Resurectra" : "Ah, our Heroes have returned!  Excellent accomplishment!  Erathia will always be in your debt.

However, we still have work to do in order to triumph in our endeavors.  After you have healed and rested, see Robert the Wise for you next assignment.  He can be found in the Hostel across the way from Sir Caneghem." ]]
			evt.SpeakNPC(19)         -- "Resurectra"
			evt.MoveNPC{NPC = 83, HouseId = 428}         -- "Robert the Wise" -> "Hostel"
			evt.SetNPCTopic{NPC = 83, Index = 0, Event = 197}         -- "Robert the Wise" : "Control Cube"
		end
	end
end

events.LoadMap = evt.map[2].last

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

evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 105) then         -- Slayed Xenofex
		evt.ForPlayer("All")
		evt.SetNPCTopic{NPC = 80, Index = 1, Event = 133}         -- "Resurectra" : "Most Excellent!!"
	end
end

events.LoadMap = evt.map[6].last

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
		evt.Add("AutonotesBits", 119)         -- "Obelisk message #6: eut__i_n"
		evt.Add("QBits", 169)         -- Visited Obelisk in Area 7
	end
end

evt.hint[416] = evt.str[9]  -- "House"
evt.house[417] = 422  -- "House Devine"
evt.map[417] = function()
	evt.EnterHouse(422)         -- "House Devine"
end

evt.house[418] = 423  -- "Morningstar Residence"
evt.map[418] = function()
	evt.EnterHouse(423)         -- "Morningstar Residence"
end

evt.house[419] = 424  -- "House Winterbright"
evt.map[419] = function()
	evt.EnterHouse(424)         -- "House Winterbright"
end

evt.house[420] = 425  -- "Hostel"
evt.map[420] = function()
	if evt.Cmp("QBits", 119) then         -- Killed Evil MM3 Person
		evt.StatusText(21)         -- "This Door is Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(425)         -- "Hostel"
	end
end

evt.house[421] = 426  -- "Hostel"
evt.map[421] = function()
	evt.EnterHouse(426)         -- "Hostel"
end

evt.house[422] = 427  -- "Hostel"
evt.map[422] = function()
	evt.EnterHouse(427)         -- "Hostel"
end

evt.house[423] = 430  -- "Ramiez Residence"
evt.map[423] = function()
	evt.EnterHouse(430)         -- "Ramiez Residence"
end

evt.house[424] = 429  -- "Tarent Residence"
evt.map[424] = function()
	evt.EnterHouse(429)         -- "Tarent Residence"
end

evt.house[426] = 431  -- "Hostel"
evt.map[426] = function()
	evt.EnterHouse(431)         -- "Hostel"
end

evt.house[427] = 432  -- "Hostel"
evt.map[427] = function()
	evt.EnterHouse(432)         -- "Hostel"
end

evt.house[428] = 5  -- "The Hallowed Sword"
evt.map[428] = function()
end

evt.house[429] = 5  -- "The Hallowed Sword"
evt.map[429] = function()
	evt.EnterHouse(5)         -- "The Hallowed Sword"
end

evt.house[430] = 19  -- "Armor of Honor"
evt.map[430] = function()
end

evt.house[431] = 19  -- "Armor of Honor"
evt.map[431] = function()
	evt.EnterHouse(19)         -- "Armor of Honor"
end

evt.house[432] = 93  -- "Trial of Honor"
evt.map[432] = function()
end

evt.house[433] = 93  -- "Trial of Honor"
evt.map[433] = function()
	evt.EnterHouse(93)         -- "Trial of Honor"
end

evt.house[434] = 113  -- "The Blessed Brew"
evt.map[434] = function()
end

evt.house[435] = 113  -- "The Blessed Brew"
evt.map[435] = function()
	evt.EnterHouse(113)         -- "The Blessed Brew"
end

evt.house[436] = 131  -- "Material Wealth"
evt.map[436] = function()
end

evt.house[437] = 131  -- "Material Wealth"
evt.map[437] = function()
	evt.EnterHouse(131)         -- "Material Wealth"
end

evt.house[438] = 48  -- "Phials of Faith"
evt.map[438] = function()
end

evt.house[439] = 48  -- "Phials of Faith"
evt.map[439] = function()
	evt.EnterHouse(48)         -- "Phials of Faith"
end

evt.house[440] = 146  -- "Paramount Guild of Air"
evt.map[440] = function()
end

evt.house[441] = 146  -- "Paramount Guild of Air"
evt.map[441] = function()
	evt.EnterHouse(146)         -- "Paramount Guild of Air"
end

evt.house[442] = 168  -- "Guild of Enlightenment"
evt.map[442] = function()
end

evt.house[443] = 168  -- "Guild of Enlightenment"
evt.map[443] = function()
	evt.EnterHouse(168)         -- "Guild of Enlightenment"
end

evt.house[444] = 35  -- "Esoteric Indulgences"
evt.map[444] = function()
end

evt.house[445] = 35  -- "Esoteric Indulgences"
evt.map[445] = function()
	evt.EnterHouse(35)         -- "Esoteric Indulgences"
end

evt.house[446] = 105  -- "Hall of Dawn"
evt.map[446] = function()
end

evt.house[447] = 105  -- "Hall of Dawn"
evt.map[447] = function()
	evt.EnterHouse(105)         -- "Hall of Dawn"
end

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

Timer(function()
	evt.Subtract("PlayerBits", 30)
end, const.Day, 1*const.Hour)

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

evt.house[504] = 80  -- "Temple of Light"
evt.map[504] = function()
	evt.EnterHouse(80)         -- "Temple of Light"
end

