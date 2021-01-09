local TXT = Localize{
	[0] = " ",
	[1] = "Land's Gateway",
	[2] = "Hungry Rock",
	[3] = "You cannot understand the creature.",
	[4] = "Hungry!  Feed me coconut!",
	[5] = "Lennie the Elder",
	[6] = "You cannot understand The Lennie.",
	[7] = "Visit my five brothers and then return to me.                                                                                                                                                         They can be found in the frozen lands of the North.",
	[8] = "The Rock creature takes a coconut from you and begins to chew it.  In a brief moment he spits out a perfectly 'shelled' coconut.  Apparently, all the creatures wants is the rock shell.  You pick up the coconut and add it to your food supply!",
	[9] = "OK.  You may now use the Tunnel to  the Valley of Stones.",
	[10] = "Well",
	[11] = "Banana Plant",
	[12] = "There are no more bananas on this plant.",
	[13] = "Tree",
	[14] = "+5 Hit points restored.",
	[15] = "+5 Spell points restored.",
	[16] = "+10 Might temporary.",
	[17] = "Rock",
	[18] = "The door is locked.",
	[19] = "The Sword won't budge!",
	[20] = "+2 Luck permanent",
	[21] = "It's your Lucky Day!  +100 gold.",
	[22] = "The Underwald",
	[23] = "Shrine of Ignis Resistance",
	[24] = "You pray at the shrine.",
	[25] = "+10 Ignis Resistance permanent",
	[26] = "+3 Ignis Resistance permanent",
	[27] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           sitWnsoi__saeiltu",
	[28] = "Obelisk",
	[29] = "The entrance is magically warded.",
	[30] = "Whom the gods bless they first curse!",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[2]  -- "Hungry Rock"
evt.map[2] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("Inventory", 484) then         -- "Rock-shell Coconut"
		evt.Subtract("Inventory", 484)         -- "Rock-shell Coconut"
		evt.Add("Food", 1)
		evt.SetMessage(8)         -- "The Rock creature takes a coconut from you and begins to chew it.  In a brief moment he spits out a perfectly 'shelled' coconut.  Apparently, all the creatures wants is the rock shell.  You pick up the coconut and add it to your food supply!"
		evt.SimpleMessage()
	else
		if evt.Cmp("QBits", 505) then         -- Stone of Translation
			evt.StatusText(4)         -- "Hungry!  Feed me coconut!"
		else
			evt.StatusText(3)         -- "You cannot understand the creature."
		end
	end
end

evt.hint[3] = evt.str[11]  -- "Banana Plant"
evt.map[3] = function()
	if evt.Cmp("MapVar9", 4) then
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("MapVar9", 1)
		evt.Add("Food", 1)
	end
end

RefillTimer(function()
	evt.Set("MapVar9", 0)
end, const.Week, true)

evt.hint[4] = evt.str[11]  -- "Banana Plant"
evt.map[4] = function()
	if evt.Cmp("QBits", 350) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 350)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 350)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[5] = evt.str[11]  -- "Banana Plant"
evt.map[5] = function()
	if evt.Cmp("MapVar10", 5) then
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("MapVar10", 1)
		evt.Add("Food", 1)
	end
end

RefillTimer(function()
	evt.Set("MapVar10", 0)
end, const.Week, true)

evt.hint[6] = evt.str[11]  -- "Banana Plant"
evt.map[6] = function()
	if evt.Cmp("QBits", 351) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 351)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 351)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[7] = evt.str[11]  -- "Banana Plant"
evt.map[7] = function()
	if evt.Cmp("MapVar11", 3) then
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("MapVar11", 1)
		evt.Add("Food", 1)
	end
end

RefillTimer(function()
	evt.Set("MapVar11", 0)
end, const.Week, true)

evt.hint[8] = evt.str[11]  -- "Banana Plant"
evt.map[8] = function()
	if evt.Cmp("QBits", 352) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 352)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 352)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[9] = evt.str[11]  -- "Banana Plant"
evt.map[9] = function()
	if evt.Cmp("QBits", 353) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 353)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 353)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[10] = evt.str[11]  -- "Banana Plant"
evt.map[10] = function()
	if evt.Cmp("QBits", 354) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 354)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 354)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[11] = evt.str[11]  -- "Banana Plant"
evt.map[11] = function()
	if evt.Cmp("QBits", 355) then         -- NPC
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("QBits", 355)         -- NPC
		evt.Add("Food", 1)
	end
end

Timer(function()
	evt.Subtract("QBits", 355)         -- NPC
end, const.Day, 1*const.Second)

evt.hint[12] = evt.str[11]  -- "Banana Plant"
evt.map[12] = function()
	if evt.Cmp("MapVar14", 3) then
		evt.StatusText(12)         -- "There are no more bananas on this plant."
	else
		evt.Add("MapVar14", 1)
		evt.Add("Food", 1)
	end
end

RefillTimer(function()
	evt.Set("MapVar14", 0)
end, const.Week, true)

evt.hint[50] = evt.str[5]  -- "Lennie the Elder"
evt.map[50] = function()
	if evt.Cmp("Awards", 2) then         -- "Gained Access to the Valley of Stones"
		goto _23
	end
	if evt.Cmp("QBits", 83) then
		if evt.Cmp("QBits", 503) then         -- Campfire
			if evt.Cmp("QBits", 502) then         -- Campfire
				if evt.Cmp("QBits", 501) then         -- Campfire
					if not evt.Cmp("QBits", 500) then         -- Tobin Cage
						goto _5
					end
					if not evt.Cmp("QBits", 499) then         -- Fountain of Enchantment once
						goto _5
					end
					evt.Subtract("QBits", 83)
					evt.ForPlayer("All")
					evt.Add("Experience", 1500000)
					evt.Set("Awards", 2)         -- "Gained Access to the Valley of Stones"
					goto _23
				end
			end
		end
	else
		if not evt.Cmp("QBits", 505) then         -- Stone of Translation
			evt.StatusText(6)         -- "You cannot understand The Lennie."
			return
		end
	end
::_5::
	evt.SetMessage(7)         -- "Visit my five brothers and then return to me.                                                                                                                                                         They can be found in the frozen lands of the North."
	evt.SimpleMessage()
	evt.Set("QBits", 83)
	do return end
::_23::
	evt.SetMessage(9)         -- "OK.  You may now use the Tunnel to  the Valley of Stones."
	evt.SimpleMessage()
	evt.Add("QBits", 498)         -- Flame of Might once
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 497) then         -- Sutter's Bay Reload
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -8442, Y = -10496, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -9670, Y = -12905, Z = 1200}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 10, X = -11011, Y = -15233, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -14595, Y = -14177, Z = 2200}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 10, X = -18458, Y = -14646, Z = 2600}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -15439, Y = -4060, Z = 700}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17338, Y = -4929, Z = 500}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 3, X = -17957, Y = 4743, Z = 600}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -2050, Y = 3288, Z = 400}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 4, X = 10777, Y = -13092, Z = 450}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -22329, Y = -10583, Z = 540}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -8440, Y = -9496, Z = 560}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 6, X = -17950, Y = 4700, Z = 350}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -17738, Y = -4500, Z = 700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -2040, Y = 3200, Z = 600}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 5, X = -22300, Y = -10580, Z = 480}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -9570, Y = -12700, Z = 1346}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -18450, Y = -14550, Z = 2500}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -9295, Y = -9626, Z = 700}
	end
	evt.Add("QBits", 497)         -- Sutter's Bay Reload
end

events.LoadMap = evt.map[262].last

