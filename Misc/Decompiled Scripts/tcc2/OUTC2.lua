local TXT = Localize{
	[0] = " ",
	[1] = "Stone of Revelation",
	[2] = "Revelation Msg#2.  To enter the Pyramid, you must possess the Pyramid Key.",
	[3] = "+2 Might permanent",
	[4] = "To Valley of Stones",
	[5] = "To Desolation's End",
	[6] = "To Baal's Garden",
	[7] = "You cannot read the inscription.",
	[8] = "Autonote added.",
	[9] = "",
	[10] = "",
	[11] = "Shrine of Endurance",
	[12] = "You pray at the shrine.",
	[13] = "+25 Endurance permanent",
	[14] = "+5 Endurance permanent",
	[15] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            mnfts_t_srrnoohtl",
	[16] = "Obelisk",
	[17] = "",
	[18] = "",
	[19] = "Temple of Carmen",
	[20] = "",
	[21] = "Guild of Aqua",
	[22] = "Armory",
	[23] = "Temple",
	[24] = "",
	[25] = "",
	[26] = "Temple of Tranquility",
	[27] = "",
	[28] = "Guild of Mentis",
	[29] = "Due to troubles in the North, services are temporarily suspended.",
	[30] = "You hand the Sacred Chalice to the monks of the temple who ensconce it in the main altar.",
	[31] = "The tomb is locked.",
	[32] = "You must be Master Skill Level may use this Guild.",
	[33] = "Sir Zeddicus Z'ul V is in council and cannot be disturbed.",
	[34] = "You cannot enter at this time.",
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

evt.hint[4] = evt.str[4]  -- "To Valley of Stones"
evt.map[4] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 2) then         -- "Gained Access to the Valley of Stones"
		evt.MoveToMap{X = -9488, Y = 18931, Z = 3618, Direction = 2034, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutA2.Odm"}
	else
		evt.StatusText(1)         -- "Stone of Revelation"
	end
end

evt.hint[5] = evt.str[5]  -- "To Desolation's End"
evt.map[5] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 4) then         -- "Gained Access to Desolation's End"
		evt.MoveToMap{X = 1968, Y = 1271, Z = 354, Direction = 1522, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutA1.Odm"}
	end
end

evt.hint[6] = evt.str[6]  -- "To Baal's Garden"
evt.map[6] = function()
	if evt.Cmp("QBits", 496) then         -- Tortuga Hall Reload
		if evt.Cmp("QBits", 491) then         -- Clear Reload Each January
			if evt.Cmp("QBits", 492) then         -- Reload Each December
				if evt.Cmp("QBits", 493) then         -- Seer Tamara Once
					if evt.Cmp("QBits", 494) then         -- Tamara Once
						if evt.Cmp("QBits", 495) then         -- Kastution Reload
							evt.ForPlayer("All")
							if evt.Cmp("Inventory", 532) then         -- "Chalice of Gods"
								evt.MoveToMap{X = 9049, Y = -18370, Z = 224, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC3.Odm"}
							else
								evt.ForPlayer("All")
								evt.Add("Awards", 5)         -- "Entered Baal's Garden"
								evt.MoveToMap{X = 9049, Y = -18370, Z = 224, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB3.Odm"}
							end
						end
					end
				end
			end
		end
	end
end

evt.hint[7] = evt.str[1]  -- "Stone of Revelation"
evt.map[7] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.SetMessage(2)         -- "Revelation Msg#2.  To enter the Pyramid, you must possess the Pyramid Key."
		evt.SimpleMessage()
		evt.Add("QBits", 495)         -- Kastution Reload
		evt.Add("AutonotesBits", 80)         -- "Revelation Msg#2.  To enter the Pyramid, you must possess the Pyramid Key."
		evt.StatusText(8)         -- "Autonote added."
	else
		evt.SetMessage(7)         -- "You cannot read the inscription."
		evt.SimpleMessage()
	end
end

evt.hint[162] = evt.str[2]  -- "Revelation Msg#2.  To enter the Pyramid, you must possess the Pyramid Key."
evt.map[162] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(9)         -- ""
	else
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -13168, Y = 19504, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -13696, Y = 17408, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -10960, Y = 18016, Z = 160}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 2, X = -9840, Y = 19280, Z = 160}
		evt.Set("MapVar4", 1)
		evt.StatusText(4)         -- "To Valley of Stones"
	end
end

RefillTimer(function()
	evt.Set("MapVar4", 0)
end, const.Month, true)

evt.hint[163] = evt.str[5]  -- "To Desolation's End"
evt.map[163] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.Subtract("MapVar1", 1)
		evt.Add("HP", 25)
		evt.StatusText(6)         -- "To Baal's Garden"
	else
		evt.StatusText(9)         -- ""
	end
	evt.Set("AutonotesBits", 31)         -- ""
end

Timer(function()
	evt.Set("MapVar1", 30)
end, const.Day, 1*const.Second)

evt.hint[164] = evt.str[7]  -- "You cannot read the inscription."
evt.map[164] = function()
	evt.Set("Drunk", 0)
	evt.StatusText(8)         -- "Autonote added."
end

evt.map[209] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 159) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = 3823, FromY = 10974, FromZ = 2700, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[209].last, 5*const.Minute)

evt.map[210] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 159) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 159)         -- NPC
			evt.SetTextureOutdoors{Model = 116, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.house[211] = 179  -- "Glastonbury Tor"
evt.map[211] = function()
	evt.MoveToMap{X = -3714, Y = 1250, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 1, Name = "D09.Blv"}         -- "Glastonbury Tor"
end

evt.map[212] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 178) then         -- NPC
		evt.Set("QBits", 178)         -- NPC
	end
end

events.LoadMap = evt.map[212].last

evt.hint[213] = evt.str[16]  -- "Obelisk"
evt.map[213] = function()
	evt.SetMessage(15)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            mnfts_t_srrnoohtl"
	evt.SimpleMessage()
	evt.Set("QBits", 367)         -- NPC
	evt.Set("AutonotesBits", 86)         -- ""
end

evt.map[214] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 159) then         -- NPC
		evt.SetTextureOutdoors{Model = 116, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[214].last

evt.hint[261] = evt.str[11]  -- "Shrine of Endurance"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 3) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 211) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 5)
				evt.StatusText(14)         -- "+5 Endurance permanent"
			else
				evt.Set("QBits", 211)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseEndurance", 25)
				evt.StatusText(13)         -- "+25 Endurance permanent"
			end
			return
		end
	end
	evt.StatusText(12)         -- "You pray at the shrine."
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 402) then         -- Vice-Elder Dissappear
		evt.Add("QBits", 402)         -- Vice-Elder Dissappear
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = 12510, Y = -22038, Z = 1400}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = -22312, Y = 14554, Z = 1875}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 7, X = 16639, Y = 21844, Z = 450}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 16033, Y = 21693, Z = 1475}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 10472, Y = 22066, Z = 425}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 6, X = 3841, Y = 22180, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 3123, Y = 22012, Z = 1900}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 4, X = 4679, Y = 21731, Z = 1250}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 12630, Y = -20957, Z = 2350}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 13228, Y = -20272, Z = 1350}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = -22024, Y = 14837, Z = 1400}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -22281, Y = 14329, Z = 1450}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 15626, Y = 21471, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 2, X = 14498, Y = 21741, Z = 1550}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 5, X = 4679, Y = 21731, Z = 1550}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 3, Count = 3, X = 6118, Y = 22029, Z = 2000}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 7306, Y = 21402, Z = 700}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -1200, Y = 12542, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -1200, Y = 12542, Z = 2300}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -1200, Y = 12542, Z = 3000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -2000, Y = 12542, Z = 1500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 2, X = -2000, Y = 12542, Z = 2300}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 3, X = -2000, Y = 12542, Z = 3000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -600, Y = 12542, Z = 1000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 4, X = -600, Y = 12542, Z = 2000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -600, Y = 12542, Z = 3000}
	end
end

events.LoadMap = evt.map[262].last

