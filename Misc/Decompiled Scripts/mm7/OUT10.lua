local TXT = Localize{
	[0] = " ",
	[1] = "Chest ",
	[2] = "Barrel",
	[3] = "Well",
	[4] = "Drink from the Well",
	[5] = "Fountain",
	[6] = "Drink from the Fountain",
	[7] = "House",
	[8] = "",
	[9] = "Tent",
	[10] = "Hut",
	[11] = "Refreshing!",
	[12] = "Boat",
	[13] = "Dock",
	[14] = "Drink",
	[15] = "Button",
	[16] = "",
	[17] = "",
	[18] = "",
	[19] = "",
	[20] = "",
	[21] = "This Door is Locked",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "Thunderfist Mountain",
	[26] = "The Maze",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "Enter Thunderfist Mountain",
	[31] = "Enter The Maze",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "Temple",
	[36] = "Guilds",
	[37] = "Stables",
	[38] = "Docks",
	[39] = "Shops",
	[40] = "",
	[41] = "Castle Harmondy",
	[42] = "East ",
	[43] = "North ",
	[44] = "West",
	[45] = "South ",
	[46] = "Harmondale",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "fi_eo_od",
	[52] = "Shrine",
	[53] = "Altar",
	[54] = "You Pray",
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
	[70] = "+50 Intellect and Personality (Temporary)",
	[71] = "+2 Skill Points",
	[72] = "+2 Personality (Permanent)",
	[73] = "+20 All Resistances (Temporary)",
	[74] = "+50 Spell Points",
	[75] = "+50 Hit Points",
	[76] = "+10 Personality and Intellect(Permanent)",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 211) then         -- Nighon - Town Portal
		evt.Add("QBits", 211)         -- Nighon - Town Portal
	end
	evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	evt.ChangeGroupAlly{NPCGroup = 26, Ally = 74}         -- "Peasents in main town of nighon"
	evt.ChangeGroupAlly{NPCGroup = 27, Ally = 74}         -- "Peasents in western town of Nighon"
end

events.LoadMap = evt.map[1].last

evt.HouseDoor(3, 21)  -- "The Tannery"
evt.house[4] = 21  -- "The Tannery"
evt.HouseDoor(5, 37)  -- "Arcane Items"
evt.house[6] = 37  -- "Arcane Items"
evt.HouseDoor(7, 82)  -- "Offerings and Blessings"
evt.house[8] = 82  -- "Offerings and Blessings"
evt.HouseDoor(9, 95)  -- "Applied Instruction"
evt.house[10] = 95  -- "Applied Instruction"
evt.HouseDoor(11, 116)  -- "Fortune's Folly"
evt.house[12] = 116  -- "Fortune's Folly"
evt.HouseDoor(13, 142)  -- "Paramount Guild of Fire"
evt.house[14] = 142  -- "Paramount Guild of Fire"
evt.HouseDoor(15, 7)  -- "The Blooded Dagger"
evt.house[16] = 7  -- "The Blooded Dagger"
evt.hint[51] = evt.str[7]  -- "House"
evt.HouseDoor(52, 352)  -- "Whitesky Residence"
evt.HouseDoor(53, 357)  -- "Evander's Home"
evt.HouseDoor(54, 358)  -- "Anwyn Residence"
evt.HouseDoor(55, 359)  -- "Silk's Home"
evt.HouseDoor(56, 364)  -- "Dusk's Home"
evt.HouseDoor(57, 353)  -- "Elmo's House"
evt.HouseDoor(58, 507)  -- "Roggen Residence"
evt.HouseDoor(59, 508)  -- "Elzbet's House"
evt.HouseDoor(60, 509)  -- "Aznog's Place"
evt.HouseDoor(61, 510)  -- "Hollis' Home"
evt.HouseDoor(62, 511)  -- "Lanshee's House"
evt.HouseDoor(63, 512)  -- "Neldon Residence"
evt.HouseDoor(64, 513)  -- "Hawthorne Residence"
evt.hint[151] = evt.str[1]  -- "Chest "
evt.map[151] = function()
	evt.OpenChest(1)
end

evt.hint[152] = evt.str[1]  -- "Chest "
evt.map[152] = function()
	evt.OpenChest(2)
end

evt.hint[153] = evt.str[1]  -- "Chest "
evt.map[153] = function()
	evt.OpenChest(3)
end

evt.hint[154] = evt.str[1]  -- "Chest "
evt.map[154] = function()
	evt.OpenChest(4)
end

evt.hint[155] = evt.str[1]  -- "Chest "
evt.map[155] = function()
	evt.OpenChest(5)
end

evt.hint[156] = evt.str[1]  -- "Chest "
evt.map[156] = function()
	evt.OpenChest(6)
end

evt.hint[157] = evt.str[1]  -- "Chest "
evt.map[157] = function()
	evt.OpenChest(7)
end

evt.hint[158] = evt.str[1]  -- "Chest "
evt.map[158] = function()
	evt.OpenChest(8)
end

evt.hint[159] = evt.str[1]  -- "Chest "
evt.map[159] = function()
	evt.OpenChest(9)
end

evt.hint[160] = evt.str[1]  -- "Chest "
evt.map[160] = function()
	evt.OpenChest(10)
end

evt.hint[161] = evt.str[1]  -- "Chest "
evt.map[161] = function()
	evt.OpenChest(11)
end

evt.hint[162] = evt.str[1]  -- "Chest "
evt.map[162] = function()
	evt.OpenChest(12)
end

evt.hint[163] = evt.str[1]  -- "Chest "
evt.map[163] = function()
	evt.OpenChest(13)
end

evt.hint[164] = evt.str[1]  -- "Chest "
evt.map[164] = function()
	evt.OpenChest(14)
end

evt.hint[165] = evt.str[1]  -- "Chest "
evt.map[165] = function()
	evt.OpenChest(15)
end

evt.hint[166] = evt.str[1]  -- "Chest "
evt.map[166] = function()
	evt.OpenChest(16)
end

evt.hint[167] = evt.str[1]  -- "Chest "
evt.map[167] = function()
	evt.OpenChest(17)
end

evt.hint[168] = evt.str[1]  -- "Chest "
evt.map[168] = function()
	evt.OpenChest(18)
end

evt.hint[169] = evt.str[1]  -- "Chest "
evt.map[169] = function()
	evt.OpenChest(19)
end

evt.hint[170] = evt.str[1]  -- "Chest "
evt.map[170] = function()
	evt.OpenChest(0)
end

evt.hint[201] = evt.str[3]  -- "Well"
evt.hint[202] = evt.str[4]  -- "Drink from the Well"
evt.map[202] = function()
	if evt.Cmp("PlayerBits", 15) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 21) then         -- ""
		evt.Add("AutonotesBits", 21)         -- ""
	end
	evt.Add("SkillPoints", 2)
	evt.Add("PlayerBits", 15)
	evt.StatusText(71)         -- "+2 Skill Points"
end

evt.hint[203] = evt.str[4]  -- "Drink from the Well"
evt.map[203] = function()
	if evt.Cmp("PlayerBits", 16) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 22) then         -- ""
		evt.Add("AutonotesBits", 22)         -- ""
	end
	evt.Add("BasePersonality", 2)
	evt.Add("PlayerBits", 16)
	evt.StatusText(72)         -- "+2 Personality (Permanent)"
end

evt.hint[204] = evt.str[4]  -- "Drink from the Well"
evt.map[204] = function()
	if evt.Cmp("PlayerBits", 17) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 23) then         -- ""
		evt.Add("AutonotesBits", 23)         -- ""
	end
	evt.Add("FireResBonus", 20)
	evt.Add("WaterResBonus", 20)
	evt.Add("BodyResBonus", 20)
	evt.Add("AirResBonus", 20)
	evt.Add("EarthResBonus", 20)
	evt.Add("MindResBonus", 20)
	evt.Add("PlayerBits", 17)
	evt.StatusText(73)         -- "+20 All Resistances (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 17)
end, const.Day)

evt.hint[205] = evt.str[5]  -- "Fountain"
evt.hint[206] = evt.str[6]  -- "Drink from the Fountain"
evt.map[206] = function()
	if evt.Cmp("PlayerBits", 14) then
		evt.StatusText(11)         -- "Refreshing!"
		return
	end
	if not evt.Cmp("AutonotesBits", 20) then         -- ""
		evt.Add("AutonotesBits", 20)         -- ""
	end
	evt.Add("PersonalityBonus", 50)
	evt.Add("IntellectBonus", 50)
	evt.Add("PlayerBits", 14)
	evt.StatusText(70)         -- "+50 Intellect and Personality (Temporary)"
end

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("PlayerBits", 14)
end, const.Day)

evt.hint[207] = evt.str[4]  -- "Drink from the Well"
evt.map[207] = function()
	if evt.Cmp("HasFullSP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("SP", 25)
		evt.StatusText(74)         -- "+50 Spell Points"
		evt.Add("AutonotesBits", 24)         -- ""
	end
end

evt.hint[208] = evt.str[4]  -- "Drink from the Well"
evt.map[208] = function()
	if evt.Cmp("HasFullHP", 0) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("HP", 25)
		evt.StatusText(75)         -- "+50 Hit Points"
		evt.Add("AutonotesBits", 25)         -- ""
	end
end

evt.hint[209] = evt.str[25]  -- "Thunderfist Mountain"
evt.hint[210] = evt.str[26]  -- "The Maze"
evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	if evt.Cmp("PlayerBits", 28) then
		evt.StatusText(54)         -- "You Pray"
	else
		evt.Add("BasePersonality", 10)
		evt.Add("BaseIntellect", 10)
		evt.Add("PlayerBits", 28)
		evt.StatusText(76)         -- "+10 Personality and Intellect(Permanent)"
	end
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 172) then         -- Visited Obelisk in Area 10
		evt.StatusText(51)         -- "fi_eo_od"
		evt.Add("AutonotesBits", 122)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 172)         -- Visited Obelisk in Area 10
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	evt.ForPlayer("All")
	evt.Set("Dead", 0)
end

evt.hint[500] = evt.str[100]  -- ""
evt.map[500] = function()
	if not evt.CheckSeason(3) then
		if not evt.CheckSeason(2) then
			if not evt.CheckSeason(1) then
				evt.CheckSeason(0)
			end
		end
	end
end

evt.hint[501] = evt.str[30]  -- "Enter Thunderfist Mountain"
evt.map[501] = function()
	evt.MoveToMap{X = -1024, Y = 768, Z = 4097, Direction = 1792, LookAngle = 0, SpeedZ = 0, HouseId = 209, Icon = 9, Name = "D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[502] = evt.str[31]  -- "Enter The Maze"
evt.map[502] = function()
	evt.MoveToMap{X = 1536, Y = -8614, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 210, Icon = 2, Name = "D02.blv"}         -- "The Maze"
end

evt.hint[503] = evt.str[30]  -- "Enter Thunderfist Mountain"
evt.map[503] = function()
	evt.MoveToMap{X = 9960, Y = 1443, Z = 390, Direction = 1936, LookAngle = 0, SpeedZ = 0, HouseId = 209, Icon = 9, Name = "D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[504] = evt.str[30]  -- "Enter Thunderfist Mountain"
evt.map[504] = function()
	evt.MoveToMap{X = -11058, Y = 4858, Z = 3969, Direction = 148, LookAngle = 0, SpeedZ = 0, HouseId = 209, Icon = 9, Name = "D07.blv"}         -- "Thunderfist Mountain"
end

evt.hint[505] = evt.str[30]  -- "Enter Thunderfist Mountain"
evt.map[505] = function()
	evt.MoveToMap{X = 11471, Y = -3498, Z = 2814, Direction = 414, LookAngle = 0, SpeedZ = 0, HouseId = 209, Icon = 9, Name = "D07.blv"}         -- "Thunderfist Mountain"
end

