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
	[25] = "Colony Zod",
	[26] = "Tunnel Entrance",
	[27] = "Cave",
	[28] = "",
	[29] = "",
	[30] = "Enter Colony Zod",
	[31] = "Enter the Cave",
	[32] = "Enter the Cave",
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
	[51] = "veoseo_l",
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
	[65] = "You make a wish",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 263) then         -- Area 12 Archibald only once
		return
	end
	if not evt.Cmp("QBits", 104) then         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		if evt.Cmp("QBits", 123) then         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Kastore in the Pit."
			evt.SetNPCGreeting{NPC = 123, Greeting = 202}         --[[ "Archibald Ironfist" : "::You receive a telepathic message:: My friends.  I know you are working with my old advisors, but I must ask for your help one more time.

With the aid of equipment I have found in my new laboratory, I have discovered that my brother Roland, husband to Queen Catherine of Erathia, remains imprisoned by the devils in their foul, ah, dwelling.  I overheard that you're on your way to do battle with them (this equipment really is wonderful), and I want to make sure it goes well.  My brother has stolen the key to their leader's chambers, and has hidden it in the beastly cage they're keeping him in.  

Please rescue him!  Not even I can bear to think of my brother in those conditions!  To help you along, I offer this weapon.  It was...found by my loyal servant sergeant Piridak, amongst my advisor's personal belongings.  I hope it helps." ]]
			evt.Add("QBits", 263)         -- Area 12 Archibald only once
			evt.SpeakNPC(123)         -- "Archibald Ironfist"
			evt.Add("Inventory", 64)         -- "Blaster"
			return
		end
	end
	evt.Add("QBits", 263)         -- Area 12 Archibald only once
	evt.SetNPCGreeting{NPC = 123, Greeting = 201}         --[[ "Archibald Ironfist" : "::You receive a telepathic message:: My…Lords.  My name is Archibald Ironfist.  You've probably heard of me--it is I who, up until recently, was the ruler of the Pit.  With my retirement, I find myself no longer concerned with the affairs of state.  I know that we were adversaries, but I am forced to ask for your help.  In return, I think I can help you.

I see that you're on your way to do battle with the devils, and I want to make sure it goes well.  With the aid of equipment I have found in my new laboratory, I have discovered that my brother Roland, husband to Queen Catherine of Erathia, remains imprisoned by the devils in their foul, ah, dwelling.

Please rescue him!  Not even I can bear to think of my brother in those conditions!  To help you along, I offer this weapon.  It was...found by my loyal servant sergeant Piridak, amongst my advisor's personal belongings.  I hope it helps." ]]
	evt.SpeakNPC(123)         -- "Archibald Ironfist"
	evt.Add("Inventory", 64)         -- "Blaster"
end

events.LoadMap = evt.map[1].last

evt.hint[51] = evt.str[7]  -- "House"
evt.house[52] = 514  -- "Lasiter's Home"
evt.map[52] = function()
	evt.EnterHouse(514)         -- "Lasiter's Home"
end

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
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(11)         -- "Refreshing!"
	else
		evt.Add("MightBonus", 100)
		evt.StatusText(60)         -- ""
		evt.Set("MapVar0", 1)
	end
end

Timer(function()
	evt.Set("MapVar0", 0)
end, const.Week)

evt.hint[203] = evt.str[25]  -- "Colony Zod"
evt.hint[204] = evt.str[26]  -- "Tunnel Entrance"
evt.hint[205] = evt.str[3]  -- "Well"
evt.map[205] = function()
	local i
	if evt.Cmp("Gold", 5000) then
		i = Game.Rand() % 3
		if i == 1 then
			i = Game.Rand() % 4
			if i == 1 then
				evt.Set("Eradicated", 0)
			elseif i == 2 then
				evt.Set("AgeBonus", 0)
				evt.Add("Experience", 5000)
			elseif i == 3 then
			else
				evt.Set("Dead", 0)
			end
		elseif i == 2 then
			i = Game.Rand() % 3
			if i == 1 then
				evt.Add("AirResBonus", 50)
			elseif i == 2 then
				evt.Add("FireResBonus", 50)
			else
				evt.Set("Stoned", 0)
			end
		else
			i = Game.Rand() % 3
			if i == 1 then
				evt.Add("Gold", 10000)
			elseif i == 2 then
				evt.Add("SkillPoints", 10)
			else
				evt.Subtract("ArmorClassBonus", 50)
			end
		end
	else
		evt.Subtract("Gold", 4999)
	end
	evt.StatusText(65)         -- "You make a wish"
end

evt.hint[451] = evt.str[52]  -- "Shrine"
evt.hint[452] = evt.str[53]  -- "Altar"
evt.map[452] = function()
	evt.Set("QBits", 246)         -- Visited The Land of the giants
	evt.MoveToMap{X = -13523, Y = 4234, Z = 0, Direction = 256, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "out09.odm"}
end

evt.hint[453] = evt.str[50]  -- "Obelisk"
evt.map[453] = function()
	if not evt.Cmp("QBits", 174) then         -- Visited Obelisk in Area 12
		evt.StatusText(51)         -- "veoseo_l"
		evt.Add("AutonotesBits", 124)         -- "Obelisk message #11: veoseo_l"
		evt.ForPlayer("All")
		evt.Add("QBits", 174)         -- Visited Obelisk in Area 12
	end
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

evt.hint[501] = evt.str[30]  -- "Enter Colony Zod"
evt.map[501] = function()
	evt.MoveToMap{X = 2648, Y = -1372, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 212, Icon = 3, Name = "D27.blv"}         -- "Colony Zod"
end

evt.hint[502] = evt.str[31]  -- "Enter the Cave"
evt.map[502] = function()
	evt.MoveToMap{X = 9165, Y = 15139, Z = -583, Direction = 24, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D36.blv"}
end

evt.hint[503] = evt.str[32]  -- "Enter the Cave"
evt.map[503] = function()
	evt.Set("QBits", 364)         -- 0
	evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "D28.Blv"}
end

evt.hint[504] = evt.str[32]  -- "Enter the Cave"
evt.map[504] = function()
	evt.Set("QBits", 365)         -- 0
	evt.MoveToMap{X = 752, Y = 2229, Z = 1, Direction = 1012, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "D28.Blv"}
end

