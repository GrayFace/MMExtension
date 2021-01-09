local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Well.",
	[2] = "+50 Luck temporary.",
	[3] = "+5 Magic resistance permanent.",
	[4] = "Drink from Fountain",
	[5] = "+5 Intellect and Personality permanent.",
	[6] = "+30 Magic resistance temporary.",
	[7] = "+50 Spell points restored.",
	[8] = "Refreshing!",
	[9] = "No one is here.  The Circus has moved.",
	[10] = "Chest",
	[11] = "Blackshire",
	[12] = "Shrine of Fire",
	[13] = "You pray at the shrine.",
	[14] = "+10 Fire resistance permanent",
	[15] = "+3 Fire resistance permanent",
	[16] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            hd_scawehSfdewee",
	[17] = "Obelisk",
	[18] = "Shrine of Magic",
	[19] = "You pray at the shrine.",
	[20] = "+10 Magic permanent",
	[21] = "+3 Magic permanent",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[11]  -- "Blackshire"

evt.HouseDoor(2, 13)  -- "Stout Heart Staff and Spear"
evt.house[3] = 13  -- "Stout Heart Staff and Spear"
evt.HouseDoor(4, 24)  -- "Mail and Greaves"
evt.house[5] = 24  -- "Mail and Greaves"
evt.HouseDoor(6, 38)  -- "Ty's Trinkets"
evt.house[7] = 38  -- "Ty's Trinkets"
evt.HouseDoor(8, 47)  -- "Outland Trading Post"
evt.house[9] = 47  -- "Outland Trading Post"
evt.HouseDoor(10, 56)  -- "Blackshire Coach and Buggy"
evt.house[11] = 56  -- "Blackshire Coach and Buggy"
evt.HouseDoor(12, 71)  -- "Blackshire Temple"
evt.HouseDoor(13, 84)  -- "Wolf's Den"
evt.house[14] = 84  -- "Wolf's Den"
evt.HouseDoor(15, 109)  -- "The Oasis"
evt.house[16] = 109  -- "The Oasis"
evt.HouseDoor(17, 110)  -- "The Howling Moon"
evt.house[18] = 110  -- "The Howling Moon"
evt.HouseDoor(19, 118)  -- "The Depository"
evt.house[20] = 118  -- "The Depository"
evt.HouseDoor(21, 134)  -- "Adept Guild of Light"
evt.house[22] = 134  -- "Adept Guild of Light"
evt.HouseDoor(23, 136)  -- "Adept Guild of Dark"
evt.house[24] = 136  -- "Adept Guild of Dark"
evt.HouseDoor(25, 146)  -- "Berserkers' Fury"
evt.house[26] = 146  -- "Berserkers' Fury"
evt.HouseDoor(27, 152)  -- "Smugglers' Guild"
evt.house[28] = 152  -- "Smugglers' Guild"
evt.house[30] = 166  -- "Circus"
evt.map[30] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(166)         -- "Circus"
end

evt.house[31] = 532  -- "Tent"
evt.map[31] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(532)         -- "Tent"
end

evt.house[32] = 534  -- "Tent"
evt.map[32] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(534)         -- "Tent"
end

evt.house[33] = 537  -- "Tent"
evt.map[33] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(537)         -- "Tent"
end

evt.house[34] = 533  -- "Wagon"
evt.map[34] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(533)         -- "Wagon"
end

evt.house[35] = 535  -- "Wagon"
evt.map[35] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(535)         -- "Wagon"
end

evt.house[36] = 536  -- "Wagon"
evt.map[36] = function()
	if not evt.Cmp("DayOfYearIs", 84) then
		if not evt.Cmp("DayOfYearIs", 85) then
			if not evt.Cmp("DayOfYearIs", 86) then
				if not evt.Cmp("DayOfYearIs", 87) then
					if not evt.Cmp("DayOfYearIs", 88) then
						if not evt.Cmp("DayOfYearIs", 89) then
							if not evt.Cmp("DayOfYearIs", 90) then
								if not evt.Cmp("DayOfYearIs", 91) then
									if not evt.Cmp("DayOfYearIs", 92) then
										if not evt.Cmp("DayOfYearIs", 93) then
											if not evt.Cmp("DayOfYearIs", 94) then
												if not evt.Cmp("DayOfYearIs", 95) then
													if not evt.Cmp("DayOfYearIs", 96) then
														if not evt.Cmp("DayOfYearIs", 97) then
															if not evt.Cmp("DayOfYearIs", 98) then
																if not evt.Cmp("DayOfYearIs", 99) then
																	if not evt.Cmp("DayOfYearIs", 100) then
																		if not evt.Cmp("DayOfYearIs", 101) then
																			if not evt.Cmp("DayOfYearIs", 102) then
																				if not evt.Cmp("DayOfYearIs", 103) then
																					if not evt.Cmp("DayOfYearIs", 104) then
																						if not evt.Cmp("DayOfYearIs", 105) then
																							if not evt.Cmp("DayOfYearIs", 106) then
																								if not evt.Cmp("DayOfYearIs", 107) then
																									if not evt.Cmp("DayOfYearIs", 108) then
																										if not evt.Cmp("DayOfYearIs", 109) then
																											if not evt.Cmp("DayOfYearIs", 110) then
																												if not evt.Cmp("DayOfYearIs", 111) then
																													evt.StatusText(9)         -- "No one is here.  The Circus has moved."
																													return
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
	evt.EnterHouse(536)         -- "Wagon"
end

evt.HouseDoor(50, 247)  -- "House"
evt.HouseDoor(51, 248)  -- "House"
evt.HouseDoor(52, 249)  -- "House"
evt.HouseDoor(53, 250)  -- "House"
evt.HouseDoor(54, 251)  -- "House"
evt.HouseDoor(55, 252)  -- "House"
evt.HouseDoor(56, 253)  -- "House"
evt.HouseDoor(57, 254)  -- "House"
evt.HouseDoor(58, 255)  -- "House"
evt.HouseDoor(59, 256)  -- "House"
evt.HouseDoor(60, 257)  -- "House"
evt.HouseDoor(61, 258)  -- "House"
evt.HouseDoor(62, 259)  -- "House"
evt.HouseDoor(63, 494)  -- "House"
evt.HouseDoor(64, 495)  -- "House"
evt.HouseDoor(65, 496)  -- "House"
evt.HouseDoor(66, 497)  -- "House"
evt.HouseDoor(67, 498)  -- "House"
evt.hint[68] = evt.str[10]  -- "Chest"
evt.map[68] = function()
	if not evt.Cmp("MapVar1", 1) then
		if evt.Cmp("QBits", 304) then         -- NPC
			evt.OpenChest(2)
			return
		end
		evt.Set("MapVar1", 1)
	end
	evt.OpenChest(1)
	evt.Set("QBits", 304)         -- NPC
	evt.Set("QBits", 182)         -- Quest item bits for seer
end

evt.hint[69] = evt.str[10]  -- "Chest"
evt.map[69] = function()
	evt.OpenChest(3)
end

evt.hint[70] = evt.str[10]  -- "Chest"
evt.map[70] = function()
	evt.OpenChest(4)
end

evt.hint[71] = evt.str[10]  -- "Chest"
evt.map[71] = function()
	evt.OpenChest(5)
end

evt.hint[72] = evt.str[10]  -- "Chest"
evt.map[72] = function()
	evt.OpenChest(6)
end

evt.hint[73] = evt.str[10]  -- "Chest"
evt.map[73] = function()
	if evt.Cmp("QBits", 221) then         -- NPC
		evt.OpenChest(9)
		return
	end
	if not evt.Cmp("QBits", 220) then         -- NPC
		goto _2
	end
	if not evt.Cmp("MapVar2", 1) then
		if evt.Cmp("QBits", 227) then         -- NPC
			goto _2
		end
		evt.Set("MapVar2", 1)
	end
	evt.OpenChest(7)
	evt.Set("QBits", 227)         -- NPC
	do return end
::_2::
	evt.OpenChest(8)
end

evt.house[90] = 198  -- "Temple of the Snake"
evt.map[90] = function()
	evt.MoveToMap{X = -4158, Y = 1792, Z = 1233, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 198, Icon = 5, Name = "T8.Blv"}         -- "Temple of the Snake"
end

evt.house[91] = 187  -- "Lair of the Wolf"
evt.map[91] = function()
	evt.MoveToMap{X = -9600, Y = 22127, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 187, Icon = 5, Name = "D17.Blv"}         -- "Lair of the Wolf"
end

evt.HouseDoor(92, 78)  -- "Temple Baa"
evt.hint[100] = evt.str[1]  -- "Drink from Well."
evt.map[100] = function()
	if not evt.Cmp("LuckBonus", 50) then
		evt.Set("LuckBonus", 50)
		evt.StatusText(2)         -- "+50 Luck temporary."
		evt.Set("AutonotesBits", 41)         -- "50 Points of temporary luck from the well in the north of Blackshire."
	end
end

evt.hint[101] = evt.str[1]  -- "Drink from Well."
evt.map[101] = function()
	if evt.Cmp("PlayerBits", 5) then
		evt.Set("DiseasedRed", 0)
	else
		evt.Set("PlayerBits", 5)
		evt.Add("MagicResistance", 5)
		evt.Set("DiseasedRed", 0)
		evt.StatusText(3)         -- "+5 Magic resistance permanent."
		evt.Set("AutonotesBits", 42)         -- "5 Points of permanent magic resistance from the well in the southeast of Blackshire."
	end
end

evt.hint[102] = evt.str[4]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("PlayerBits", 6) then
		evt.Set("DiseasedRed", 0)
	else
		evt.Set("PlayerBits", 6)
		evt.Add("BaseIntellect", 5)
		evt.Add("BasePersonality", 5)
		evt.Set("DiseasedRed", 0)
		evt.StatusText(5)         -- "+5 Intellect and Personality permanent."
		evt.Set("AutonotesBits", 43)         -- "5 Points of permanent intellect and personality from the fountain north of the Temple of the Snake."
	end
end

evt.hint[103] = evt.str[4]  -- "Drink from Fountain"
evt.map[103] = function()
	if evt.Cmp("MagicResBonus", 30) then
		evt.Set("Stoned", 0)
	else
		evt.Set("MagicResBonus", 30)
		evt.Set("Stoned", 0)
		evt.StatusText(6)         -- "+30 Magic resistance temporary."
		evt.Set("AutonotesBits", 44)         -- "30 Points of temporary magic resistance from the fountain in the south side of Blackshire."
	end
end

evt.hint[104] = evt.str[4]  -- "Drink from Fountain"
evt.map[104] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("SP", 50)
		evt.StatusText(7)         -- "+50 Spell points restored."
	else
		evt.StatusText(8)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 45)         -- "50 Spell points restored from the central fountain in Blackshire."
end

RefillTimer(function()
	evt.Set("MapVar0", 20)
end, const.Week)

evt.hint[261] = evt.str[18]  -- "Shrine of Magic"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 11) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 218) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("MagicResistance", 3)
				evt.StatusText(21)         -- "+3 Magic permanent"
			else
				evt.Set("QBits", 218)         -- NPC
				evt.ForPlayer("All")
				evt.Add("MagicResistance", 10)
				evt.StatusText(20)         -- "+10 Magic permanent"
			end
			return
		end
	end
	evt.StatusText(19)         -- "You pray at the shrine."
end

evt.map[210] = function()  -- Timer(<function>, 5*const.Minute)
	if not evt.Cmp("QBits", 160) then         -- NPC
		if evt.Cmp("Flying", 0) then
			evt.CastSpell{Spell = 6, Mastery = const.Master, Skill = 5, FromX = -17921, FromY = 9724, FromZ = 2742, ToX = 0, ToY = 0, ToZ = 0}         -- "Fireball"
		end
	end
end

Timer(evt.map[210].last, 5*const.Minute)

evt.map[211] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 160) then         -- NPC
		if evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
			evt.Set("QBits", 160)         -- NPC
			evt.SetTextureOutdoors{Model = 61, Facet = 42, Name = "T1swBu"}
		end
	end
end

evt.hint[212] = evt.str[17]  -- "Obelisk"
evt.map[212] = function()
	evt.SetMessage(16)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            hd_scawehSfdewee"
	evt.SimpleMessage()
	evt.Set("QBits", 364)         -- NPC
	evt.Set("AutonotesBits", 83)         -- "Obelisk Message # 5:  hd_scawehSfdewee"
end

evt.map[213] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 160) then         -- NPC
		evt.SetTextureOutdoors{Model = 61, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[213].last

