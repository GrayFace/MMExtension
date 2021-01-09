local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
	[2] = "Orpheus’s Gateway",
	[3] = "Drink from Fountain",
	[4] = "+2 Endurance permenant.",
	[5] = "Refreshing!",
	[6] = "No one is here.  The Circus has moved.",
	[7] = "Bog of Tuonela",
	[8] = "Shrine of Personality",
	[9] = "You pray at the shrine.",
	[10] = "+15 Personality permanent",
	[11] = "+5 Personality permanent",
	[12] = "Pedestal",
	[13] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            odah_yoyto_su_th_",
	[14] = "Obelisk",
	[15] = "You cannot enter this dwelling.",
	[16] = "You cannot enter at this time.",
	[17] = "Haldegarn's Lair",
	[18] = "The entrance is magically warded.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[7]  -- "Bog of Tuonela"
-- ERROR: Duplicate label: 68:0
-- ERROR: Duplicate label: 261:0
-- ERROR: Duplicate label: 261:1
-- ERROR: Duplicate label: 261:2
-- ERROR: Duplicate label: 261:3
-- ERROR: Duplicate label: 261:4
-- ERROR: Duplicate label: 261:5
-- ERROR: Duplicate label: 261:6
-- ERROR: Duplicate label: 261:7
-- ERROR: Duplicate label: 261:8
-- ERROR: Duplicate label: 261:9

evt.house[2] = 6  -- "Weapons to Pummel "
evt.map[2] = function()
	evt.EnterHouse(6)         -- "Weapons to Pummel "
end

evt.house[3] = 6  -- "Weapons to Pummel "
evt.map[3] = function()
end

evt.house[4] = 19  -- "Sheath of Protection"
evt.map[4] = function()
	evt.EnterHouse(19)         -- "Sheath of Protection"
end

evt.house[5] = 19  -- "Sheath of Protection"
evt.map[5] = function()
end

evt.house[6] = 34  -- "Slight of Hand"
evt.map[6] = function()
	evt.EnterHouse(34)         -- "Slight of Hand"
end

evt.house[7] = 34  -- "Slight of Hand"
evt.map[7] = function()
end

evt.house[8] = 52  -- "Tuonela Tours"
evt.map[8] = function()
	evt.EnterHouse(52)         -- "Tuonela Tours"
end

evt.house[9] = 52  -- "Tuonela Tours"
evt.map[9] = function()
end

evt.house[10] = 102  -- "The Banshee"
evt.map[10] = function()
	evt.EnterHouse(102)         -- "The Banshee"
end

evt.house[11] = 102  -- "The Banshee"
evt.map[11] = function()
end

evt.house[12] = 103  -- "Sorceress’ Brew"
evt.map[12] = function()
	evt.EnterHouse(103)         -- "Sorceress’ Brew"
end

evt.house[13] = 103  -- "Sorceress’ Brew"
evt.map[13] = function()
end

evt.house[14] = 166  -- "Circus"
evt.map[14] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[15] = 532  -- "Tent"
evt.map[15] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[16] = 534  -- "Tent"
evt.map[16] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[17] = 537  -- "Tent"
evt.map[17] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[18] = 533  -- "Wagon"
evt.map[18] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[19] = 535  -- "Wagon"
evt.map[19] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[20] = 536  -- "Wagon"
evt.map[20] = function()
	if not evt.Cmp("DayOfYearIs", 196) then
		if not evt.Cmp("DayOfYearIs", 197) then
			if not evt.Cmp("DayOfYearIs", 198) then
				if not evt.Cmp("DayOfYearIs", 199) then
					if not evt.Cmp("DayOfYearIs", 200) then
						if not evt.Cmp("DayOfYearIs", 201) then
							if not evt.Cmp("DayOfYearIs", 202) then
								if not evt.Cmp("DayOfYearIs", 203) then
									if not evt.Cmp("DayOfYearIs", 204) then
										if not evt.Cmp("DayOfYearIs", 205) then
											if not evt.Cmp("DayOfYearIs", 206) then
												if not evt.Cmp("DayOfYearIs", 207) then
													if not evt.Cmp("DayOfYearIs", 208) then
														if not evt.Cmp("DayOfYearIs", 209) then
															if not evt.Cmp("DayOfYearIs", 210) then
																if not evt.Cmp("DayOfYearIs", 211) then
																	if not evt.Cmp("DayOfYearIs", 212) then
																		if not evt.Cmp("DayOfYearIs", 213) then
																			if not evt.Cmp("DayOfYearIs", 214) then
																				if not evt.Cmp("DayOfYearIs", 215) then
																					if not evt.Cmp("DayOfYearIs", 216) then
																						if not evt.Cmp("DayOfYearIs", 217) then
																							if not evt.Cmp("DayOfYearIs", 218) then
																								if not evt.Cmp("DayOfYearIs", 219) then
																									if not evt.Cmp("DayOfYearIs", 220) then
																										if not evt.Cmp("DayOfYearIs", 221) then
																											if not evt.Cmp("DayOfYearIs", 222) then
																												if not evt.Cmp("DayOfYearIs", 223) then
																													evt.StatusText(6)         -- "No one is here.  The Circus has moved."
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

evt.house[50] = 334  -- "House of Ilmater"
evt.map[50] = function()
	evt.EnterHouse(334)         -- "House of Ilmater"
end

evt.house[51] = 335  -- "House"
evt.map[51] = function()
	evt.EnterHouse(335)         -- "House"
end

evt.house[52] = 336  -- "House"
evt.map[52] = function()
	evt.EnterHouse(336)         -- "House"
end

evt.house[53] = 337  -- "House"
evt.map[53] = function()
	evt.EnterHouse(337)         -- "House"
end

evt.house[54] = 338  -- "House"
evt.map[54] = function()
	evt.EnterHouse(338)         -- "House"
end

evt.house[55] = 339  -- "House"
evt.map[55] = function()
	evt.EnterHouse(339)         -- "House"
end

evt.house[56] = 340  -- "House"
evt.map[56] = function()
	evt.EnterHouse(340)         -- "House"
end

evt.house[57] = 341  -- "House"
evt.map[57] = function()
	evt.EnterHouse(341)         -- "House"
end

evt.house[58] = 342  -- "House"
evt.map[58] = function()
	evt.EnterHouse(342)         -- "House"
end

evt.house[59] = 343  -- "House"
evt.map[59] = function()
	evt.EnterHouse(343)         -- "House"
end

evt.house[60] = 344  -- "House"
evt.map[60] = function()
	evt.EnterHouse(344)         -- "House"
end

evt.house[61] = 345  -- "House"
evt.map[61] = function()
	evt.EnterHouse(345)         -- "House"
end

evt.house[62] = 346  -- "House"
evt.map[62] = function()
	evt.EnterHouse(346)         -- "House"
end

evt.house[63] = 347  -- "House"
evt.map[63] = function()
	evt.EnterHouse(347)         -- "House"
end

evt.house[64] = 348  -- "Danika's Home"
evt.map[64] = function()
	evt.EnterHouse(348)         -- "Danika's Home"
end

evt.house[65] = 349  -- "House"
evt.map[65] = function()
	evt.EnterHouse(349)         -- "House"
end

evt.house[66] = 350  -- "House"
evt.map[66] = function()
	evt.EnterHouse(350)         -- "House"
end

evt.house[67] = 351  -- "House of Kylliki"
evt.map[67] = function()
	evt.EnterHouse(351)         -- "House of Kylliki"
end

evt.house[68] = 352  -- "Hilda's Home"
evt.map[68] = function()
	if not evt.Cmp("QBits", 448) then         -- Hilda's Once Ring Spawn
		if evt.Cmp("Inventory", 412) then         -- "Ring of Morgana"
			evt.Set("QBits", 448)         -- Hilda's Once Ring Spawn
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -19681, Y = 9693, Z = 265}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = -20380, Y = 14644, Z = 515}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -18109, Y = 11849, Z = 265}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = -18083, Y = 10134, Z = 265}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 6, X = -16289, Y = 18280, Z = 2090}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 8, X = -17811, Y = 19019, Z = 2090}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = 12630, Y = 13059, Z = 235}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = 14657, Y = 12351, Z = 220}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = 5530, Y = -1533, Z = 2500}
			evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 9, X = -16109, Y = -20106, Z = 150}
		end
	end
	evt.EnterHouse(352)         -- "Hilda's Home"
end

evt.house[70] = 354  -- "House"
evt.map[70] = function()
	evt.EnterHouse(354)         -- "House"
end

evt.house[71] = 355  -- "House"
evt.map[71] = function()
	evt.EnterHouse(355)         -- "House"
end

evt.house[72] = 356  -- "House"
evt.map[72] = function()
	evt.EnterHouse(356)         -- "House"
end

evt.house[73] = 357  -- "House"
evt.map[73] = function()
	evt.EnterHouse(357)         -- "House"
end

evt.house[74] = 358  -- "House"
evt.map[74] = function()
	evt.EnterHouse(358)         -- "House"
end

evt.house[75] = 359  -- "House"
evt.map[75] = function()
	evt.EnterHouse(359)         -- "House"
end

evt.house[76] = 360  -- "Condemned Dwelling"
evt.map[76] = function()
	evt.StatusText(15)         -- "You cannot enter this dwelling."
end

evt.hint[77] = evt.str[1]  -- "Crate"
evt.map[77] = function()
	evt.OpenChest(1)
end

evt.hint[78] = evt.str[1]  -- "Crate"
evt.map[78] = function()
	evt.OpenChest(2)
end

evt.hint[79] = evt.str[1]  -- "Crate"
evt.map[79] = function()
	evt.OpenChest(3)
end

evt.house[90] = 207  -- "Haldegarn's Lair"
evt.map[90] = function()
	if evt.Cmp("NPCs", 112) then         -- "Hodge Podge"
		evt.MoveToMap{X = -4724, Y = 1494, Z = 127, Direction = 1920, LookAngle = 0, SpeedZ = 0, HouseId = 207, Icon = 5, Name = "D16.Blv"}         -- "Haldegarn's Lair"
	else
		evt.StatusText(18)         -- "The entrance is magically warded."
	end
end

evt.house[91] = 361  -- "Temple of Dark"
evt.map[91] = function()
	evt.EnterHouse(361)         -- "Temple of Dark"
end

evt.house[92] = 78  -- "Temple Carmen"
evt.map[92] = function()
	evt.EnterHouse(78)         -- "Temple Carmen"
end

evt.hint[93] = evt.str[2]  -- "Orpheus’s Gateway"
evt.map[93] = function()
	evt.MoveToMap{X = 1664, Y = -1896, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 5, Name = "D05.Blv"}
end

evt.hint[100] = evt.str[3]  -- "Drink from Fountain"
evt.map[100] = function()
	if not evt.Cmp("BaseEndurance", 15) then
		if evt.Cmp("MapVar4", 1) then
			evt.Subtract("MapVar4", 1)
			evt.Add("BaseEndurance", 2)
			evt.StatusText(4)         -- "+2 Endurance permenant."
			evt.Set("AutonotesBits", 29)         -- "2 Points of permanent endurance from the fountain in the south of the Bog of Tuonella."
			return
		end
	end
	evt.StatusText(5)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar4", 8)
end, const.Month, true)

evt.map[210] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = -304, Y = 9904, Z = 3000}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = 480, Y = 7904, Z = 256}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = -1200, Y = 6480, Z = 2500}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = -4336, Y = 8552, Z = 1750}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 4, X = -2784, Y = 10000, Z = 1945}
	end
end

evt.map[220] = function()
	if evt.Cmp("MapVar9", 1) then
		evt.Set("MapVar9", 0)
		evt.SetFacetBitOutdoors{Model = 4, Facet = -1, Bit = const.FacetBits.Invisible, On = true}
	else
		evt.Set("MapVar9", 1)
		evt.SetFacetBitOutdoors{Model = 4, Facet = -1, Bit = const.FacetBits.Invisible, On = false}
	end
end

evt.hint[261] = evt.str[8]  -- "Shrine of Personality"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 2) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 212) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BasePersonality", 5)
				evt.StatusText(11)         -- "+5 Personality permanent"
			else
				evt.Set("QBits", 212)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BasePersonality", 15)
				evt.StatusText(10)         -- "+15 Personality permanent"
			end
			return
		end
	end
	evt.StatusText(9)         -- "You pray at the shrine."
end

evt.hint[221] = evt.str[12]  -- "Pedestal"
evt.map[221] = function()
	if not evt.Cmp("Inventory", 452) then         -- "Wolf Statuette"
		if not evt.Cmp("Inventory", 453) then         -- "Statuette of Holy Cleansing"
			return
		end
		if not evt.Cmp("QBits", 224) then         -- NPC
			return
		end
		evt.Subtract("Inventory", 453)         -- "Statuette of Holy Cleansing"
	else
		evt.Subtract("Inventory", 452)         -- "Wolf Statuette"
	end
	evt.SetSprite{SpriteId = 394, Visible = 1, Name = "ped04"}
	evt.Set("QBits", 225)         -- NPC
	if evt.Cmp("QBits", 223) then         -- NPC
		if evt.Cmp("QBits", 224) then         -- NPC
			if evt.Cmp("QBits", 222) then         -- NPC
				if evt.Cmp("QBits", 226) then         -- NPC
					evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Jaana Barthold"
					evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Maikki Barthold" -> "Barthold Residence"
				end
			end
		end
	end
end

evt.map[222] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 225) then         -- NPC
		evt.SetSprite{SpriteId = 394, Visible = 1, Name = "ped04"}
	end
end

events.LoadMap = evt.map[222].last

evt.hint[223] = evt.str[14]  -- "Obelisk"
evt.map[223] = function()
	evt.SetMessage(13)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            odah_yoyto_su_th_"
	evt.SimpleMessage()
	evt.Set("QBits", 368)         -- NPC
	evt.Set("AutonotesBits", 87)         -- "Obelisk Message # 9:  odah_yoyto_su_th_"
end

evt.map[259] = function()  -- Timer(<function>, 2*const.Hour)
	if evt.Cmp("QBits", 452) then         -- Witch spawn one more time (timer1)
		return
	end
	if evt.Cmp("QBits", 453) then         -- Morgana's Ring Delivered (timer)
		evt.Add("QBits", 452)         -- Witch spawn one more time (timer1)
	end
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = -19175, Y = 9124, Z = 257}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 3, X = -18721, Y = 9950, Z = 260}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 16202, Y = -15821, Z = 350}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 2, X = 5669, Y = 6178, Z = 1540}
end

Timer(evt.map[259].last, 2*const.Hour)

evt.map[260] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 454) then         -- Opened the Gateway
		evt.ForPlayer("All")
		evt.Set("Cursed", 0)
	end
end

events.LoadMap = evt.map[260].last

Timer(evt.map[261].last, 90*const.Minute)

evt.map[262] = function()  -- Timer(<function>, 45*const.Minute)
	if evt.Cmp("QBits", 449) then         -- Witch spawn one more time (timer3)
		return
	end
	if evt.Cmp("QBits", 453) then         -- Morgana's Ring Delivered (timer)
		evt.Add("QBits", 449)         -- Witch spawn one more time (timer3)
	end
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 12554, Y = -16437, Z = 1340}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 6748, Y = -2818, Z = 2420}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 6737, Y = -1543, Z = 2500}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 1, X = 4403, Y = 5577, Z = 1485}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 1, X = 13434, Y = 12254, Z = 230}
	evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 15323, Y = 13831, Z = 257}
end

Timer(evt.map[262].last, 45*const.Minute)

evt.map[263] = function()  -- Timer(<function>, 45*const.Minute)
	if evt.Cmp("QBits", 447) then         -- Interim 4-hour Timer
		evt.Add("QBits", 451)         -- 4-hour  timer for quest complete
	else
		if evt.Cmp("QBits", 453) then         -- Morgana's Ring Delivered (timer)
			evt.Add("QBits", 447)         -- Interim 4-hour Timer
		end
	end
end

Timer(evt.map[263].last, 45*const.Minute)

