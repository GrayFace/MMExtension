local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "Rejuvination!",
	[3] = "Refreshing!",
	[4] = "Chest",
	[5] = "The Far Reaches",
	[6] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           _naotip_s_edro_ftd",
	[7] = "Obelisk",
	[8] = "Rock of Ages",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[5]  -- "The Far Reaches"

evt.hint[1] = evt.str[7]  -- "Obelisk"
evt.hint[2] = evt.str[8]  -- "Rock of Ages"
evt.map[2] = function()
	if evt.Cmp("QBits", 360) then         -- NPC
		if evt.Cmp("QBits", 361) then         -- NPC
			if evt.Cmp("QBits", 362) then         -- NPC
				if evt.Cmp("QBits", 363) then         -- NPC
					if evt.Cmp("QBits", 364) then         -- NPC
						if evt.Cmp("QBits", 365) then         -- NPC
							if evt.Cmp("QBits", 366) then         -- NPC
								if evt.Cmp("QBits", 367) then         -- NPC
									if evt.Cmp("QBits", 368) then         -- NPC
										if evt.Cmp("QBits", 369) then         -- NPC
											if evt.Cmp("QBits", 370) then         -- NPC
												if evt.Cmp("QBits", 371) then         -- NPC
													if evt.Cmp("QBits", 372) then         -- NPC
														if evt.Cmp("QBits", 373) then         -- NPC
															if evt.Cmp("QBits", 374) then         -- NPC
																evt.ForPlayer("All")
																evt.Add("Experience", 300000)
																evt.Add("Awards", 41)         -- "One Tin Solder Award"
																evt.OpenChest(3)
																evt.Subtract("QBits", 374)         -- NPC
																evt.Subtract("QBits", 368)         -- NPC
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

evt.hint[75] = evt.str[4]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[4]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.house[90] = 198  -- "Temple of Chaos"
evt.map[90] = function()
	evt.MoveToMap{X = 2034, Y = -36, Z = 177, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 198, Icon = 5, Name = "T7.Blv"}         -- "Temple of Chaos"
end

evt.hint[100] = evt.str[1]  -- "Drink from Fountain"
evt.map[100] = function()
	evt.Set("AgeBonus", 0)
	evt.StatusText(2)         -- "Rejuvination!"
	evt.Set("AutonotesBits", 51)         -- "Unnatural aging cured at fountain to the east of the Far Reaches."
end

evt.hint[210] = evt.str[7]  -- "Obelisk"
evt.map[210] = function()
	evt.SetMessage(6)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                           _naotip_s_edro_ftd"
	evt.SimpleMessage()
	evt.Set("QBits", 362)         -- NPC
	evt.Set("AutonotesBits", 81)         -- "Obelisk Message # 3:  _naotip_s_edro_ftd"
end

evt.hint[211] = evt.str[8]  -- "Rock of Ages"
evt.map[211] = function()
	evt.OpenChest(1)
end

