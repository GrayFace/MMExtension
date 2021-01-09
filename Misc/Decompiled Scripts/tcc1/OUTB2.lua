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
	[11] = "Chernobog",
	[12] = "Shrine of Fire",
	[13] = "You pray at the shrine.",
	[14] = "+10 Fire resistance permanent",
	[15] = "+3 Fire resistance permanent",
	[16] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            h_uSl_roqh,bdkenw",
	[17] = "Obelisk",
	[18] = "Shrine of Electricity",
	[19] = "You pray at the shrine.",
	[20] = "+10 Electricity Resistance permanent",
	[21] = "+3 Electricity Resistance permanent",
	[22] = "You cannot enter at this time",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[11]  -- "Chernobog"
-- ERROR: evt.house[59] not assigned for hint, because Hint command is missing
-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing

evt.house[2] = 13  -- "Veles’ Sharp Objects"
evt.map[2] = function()
	evt.EnterHouse(13)         -- "Veles’ Sharp Objects"
end

evt.house[3] = 13  -- "Veles’ Sharp Objects"
evt.map[3] = function()
end

evt.house[4] = 24  -- "Viktor’s Protective Apparel"
evt.map[4] = function()
	evt.EnterHouse(24)         -- "Viktor’s Protective Apparel"
end

evt.house[5] = 24  -- "Viktor’s Protective Apparel"
evt.map[5] = function()
end

evt.house[6] = 38  -- "Mokosh’s Frippery"
evt.map[6] = function()
	evt.EnterHouse(38)         -- "Mokosh’s Frippery"
end

evt.house[7] = 38  -- "Mokosh’s Frippery"
evt.map[7] = function()
end

evt.house[8] = 47  -- "Bobbles and Things"
evt.map[8] = function()
	evt.EnterHouse(47)         -- "Bobbles and Things"
end

evt.house[9] = 47  -- "Bobbles and Things"
evt.map[9] = function()
end

evt.house[10] = 56  -- "Chernoburg Conveyance"
evt.map[10] = function()
	evt.EnterHouse(56)         -- "Chernoburg Conveyance"
end

evt.house[11] = 56  -- "Chernoburg Conveyance"
evt.map[11] = function()
end

evt.house[12] = 71  -- "Chernoburg Sanctuary"
evt.map[12] = function()
	evt.EnterHouse(71)         -- "Chernoburg Sanctuary"
end

evt.house[13] = 84  -- "Demon’s Bane"
evt.map[13] = function()
	evt.EnterHouse(84)         -- "Demon’s Bane"
end

evt.house[14] = 84  -- "Demon’s Bane"
evt.map[14] = function()
end

evt.house[15] = 109  -- "The Oasis"
evt.map[15] = function()
	evt.EnterHouse(109)         -- "The Oasis"
end

evt.house[16] = 109  -- "The Oasis"
evt.map[16] = function()
end

evt.house[17] = 110  -- "The Swill and Fill"
evt.map[17] = function()
	evt.EnterHouse(110)         -- "The Swill and Fill"
end

evt.house[18] = 110  -- "The Swill and Fill"
evt.map[18] = function()
end

evt.house[19] = 118  -- "The Hoard"
evt.map[19] = function()
	evt.EnterHouse(118)         -- "The Hoard"
end

evt.house[20] = 118  -- "The Hoard"
evt.map[20] = function()
end

evt.house[21] = 134  -- "Adept Guild of Light"
evt.map[21] = function()
	evt.EnterHouse(134)         -- "Adept Guild of Light"
end

evt.house[22] = 134  -- "Adept Guild of Light"
evt.map[22] = function()
end

evt.house[23] = 136  -- "Adept Guild of Dark"
evt.map[23] = function()
	evt.EnterHouse(136)         -- "Adept Guild of Dark"
end

evt.house[24] = 136  -- "Adept Guild of Dark"
evt.map[24] = function()
end

evt.house[25] = 146  -- "Berserkers' Fury"
evt.map[25] = function()
	evt.EnterHouse(146)         -- "Berserkers' Fury"
end

evt.house[26] = 146  -- "Berserkers' Fury"
evt.map[26] = function()
end

evt.house[27] = 152  -- "Smugglers' Guild"
evt.map[27] = function()
	evt.EnterHouse(152)         -- "Smugglers' Guild"
end

evt.house[28] = 152  -- "Smugglers' Guild"
evt.map[28] = function()
end

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

evt.house[50] = 247  -- "Taija’s House"
evt.map[50] = function()
	evt.EnterHouse(247)         -- "Taija’s House"
end

evt.house[51] = 248  -- "House"
evt.map[51] = function()
	evt.EnterHouse(248)         -- "House"
end

evt.house[52] = 249  -- "House"
evt.map[52] = function()
	evt.EnterHouse(249)         -- "House"
end

evt.house[53] = 250  -- "House"
evt.map[53] = function()
	evt.EnterHouse(250)         -- "House"
end

evt.house[54] = 251  -- "House"
evt.map[54] = function()
	evt.EnterHouse(251)         -- "House"
end

evt.house[55] = 252  -- "House"
evt.map[55] = function()
	evt.EnterHouse(252)         -- "House"
end

evt.house[56] = 253  -- "Barthold Residence"
evt.map[56] = function()
	evt.EnterHouse(253)         -- "Barthold Residence"
end

evt.house[57] = 254  -- "House"
evt.map[57] = function()
	evt.EnterHouse(254)         -- "House"
end

evt.house[58] = 255  -- "House"
evt.map[58] = function()
	evt.EnterHouse(255)         -- "House"
end

evt.map[59] = function()
	evt.EnterHouse(256)         -- "House"
end

evt.house[60] = 257  -- "House"
evt.map[60] = function()
	evt.MoveToMap{X = -32102, Y = 14013, Z = 1, Direction = 52, LookAngle = 0, SpeedZ = 0, HouseId = 167, Icon = 5, Name = "Sewer.Blv"}         -- "Prison"
end

evt.house[61] = 258  -- "House"
evt.map[61] = function()
	evt.EnterHouse(258)         -- "House"
end

evt.house[62] = 259  -- "House"
evt.map[62] = function()
	evt.EnterHouse(259)         -- "House"
end

evt.house[63] = 494  -- "House"
evt.map[63] = function()
	evt.EnterHouse(494)         -- "House"
end

evt.house[64] = 495  -- "House"
evt.map[64] = function()
	evt.EnterHouse(495)         -- "House"
end

evt.house[65] = 496  -- "House"
evt.map[65] = function()
	evt.EnterHouse(496)         -- "House"
end

evt.house[66] = 497  -- "House"
evt.map[66] = function()
	evt.EnterHouse(497)         -- "House"
end

evt.house[67] = 498  -- "House"
evt.map[67] = function()
	evt.EnterHouse(498)         -- "House"
end

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

evt.map[90] = function()
	evt.MoveToMap{X = -4158, Y = 1792, Z = 1233, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 196, Icon = 5, Name = "T8.Blv"}         -- "Supreme Temple of Baa"
end

evt.house[91] = 190  -- "Lair of Koschei "
evt.map[91] = function()
	evt.MoveToMap{X = -49, Y = -42, Z = -2, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 190, Icon = 5, Name = "D20.Blv"}         -- "Lair of Koschei "
end

evt.house[92] = 78  -- "Temple Carmen"
evt.map[92] = function()
	evt.EnterHouse(78)         -- "Temple Carmen"
end

evt.hint[100] = evt.str[1]  -- "Drink from Well."
evt.map[100] = function()
	if not evt.Cmp("LuckBonus", 50) then
		evt.Set("LuckBonus", 50)
		evt.StatusText(2)         -- "+50 Luck temporary."
		evt.Set("AutonotesBits", 41)         -- "50 Points of temporary luck from the well in the north of Cheronburg."
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
		evt.Set("AutonotesBits", 42)         -- "5 Points of permanent magic resistance from the well in the southeast of Cheronburg."
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
		evt.Set("AutonotesBits", 44)         -- "30 Points of temporary magic resistance from the fountain in the south side of Cheronburg."
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
	evt.Set("AutonotesBits", 45)         -- "50 Spell points restored from the central fountain in Cheronburg."
end

RefillTimer(function()
	evt.Set("MapVar0", 20)
end, const.Week, true)

evt.hint[261] = evt.str[18]  -- "Shrine of Electricity"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 8) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 218) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("ElecResistance", 3)
				evt.StatusText(21)         -- "+3 Electricity Resistance permanent"
			else
				evt.Set("QBits", 218)         -- NPC
				evt.ForPlayer("All")
				evt.Add("ElecResistance", 10)
				evt.StatusText(20)         -- "+10 Electricity Resistance permanent"
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
	evt.SetMessage(16)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            h_uSl_roqh,bdkenw"
	evt.SimpleMessage()
	evt.Set("QBits", 364)         -- NPC
	evt.Set("AutonotesBits", 83)         -- "Obelisk Message # 5:  h_uSl_roqh,bdkenw"
end

evt.map[213] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 160) then         -- NPC
		evt.SetTextureOutdoors{Model = 61, Facet = 42, Name = "T1swBu"}
	end
end

events.LoadMap = evt.map[213].last

