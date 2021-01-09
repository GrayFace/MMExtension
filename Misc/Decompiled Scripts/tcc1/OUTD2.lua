local TXT = Localize{
	[0] = " ",
	[1] = "+5 Spell points restored",
	[2] = "Refreshing!",
	[3] = "Place Holder for Prince of Thieves.  Paul needs to provide this.",
	[4] = "Chest",
	[5] = "Drink from Well.",
	[6] = "+20 Might temporary.",
	[7] = "Poison!",
	[8] = "Drink from Fountain of Boons",
	[9] = "+2 Intellect permanent.",
	[10] = "+2 Personality permanent.",
	[11] = "+20 Spell points restored.",
	[12] = "No one is here.  The Circus has moved.",
	[13] = "Kastution Waters",
	[14] = "Shrine of Intellect",
	[15] = "You pray at the shrine.",
	[16] = "+10 Intellect permanent",
	[17] = "+3 Intellectt permanent",
	[18] = "Pedestal",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                          tota_uruNkiuhiy_r",
	[20] = "Obelisk",
	[21] = "Kat'an",
	[22] = "Kastutia",
	[23] = "Circus (Winter)",
	[24] = "Drink from Fountain",
	[25] = "You cannot enter at this time.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[13]  -- "Kastution Waters"
-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing

evt.house[2] = 2  -- "Hammer and Tongs"
evt.map[2] = function()
	evt.EnterHouse(2)         -- "Hammer and Tongs"
end

evt.house[3] = 2  -- "Hammer and Tongs"
evt.map[3] = function()
end

evt.house[4] = 18  -- "Abraham's Metalworks"
evt.map[4] = function()
	evt.EnterHouse(18)         -- "Abraham's Metalworks"
end

evt.house[5] = 18  -- "Abraham's Metalworks"
evt.map[5] = function()
end

evt.house[6] = 31  -- "The Little Magic Shop"
evt.map[6] = function()
	evt.EnterHouse(31)         -- "The Little Magic Shop"
end

evt.house[7] = 31  -- "The Little Magic Shop"
evt.map[7] = function()
end

evt.house[8] = 83  -- "Training-by-the-Sea"
evt.map[8] = function()
	evt.EnterHouse(83)         -- "Training-by-the-Sea"
end

evt.house[9] = 83  -- "Training-by-the-Sea"
evt.map[9] = function()
end

evt.house[10] = 98  -- "The Goblin's Tooth"
evt.map[10] = function()
	evt.EnterHouse(98)         -- "The Goblin's Tooth"
end

evt.house[11] = 98  -- "The Goblin's Tooth"
evt.map[11] = function()
end

evt.house[12] = 99  -- "The Broken Cutlass"
evt.map[12] = function()
	evt.EnterHouse(99)         -- "The Broken Cutlass"
end

evt.house[13] = 99  -- "The Broken Cutlass"
evt.map[13] = function()
end

evt.house[14] = 166  -- "Circus"
evt.map[14] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[15] = 77  -- "House of Healing"
evt.map[15] = function()
	evt.EnterHouse(77)         -- "House of Healing"
end

evt.house[16] = 67  -- "Valkyrie"
evt.map[16] = function()
	evt.EnterHouse(67)         -- "Valkyrie"
end

evt.house[17] = 66  -- "Tsunami"
evt.map[17] = function()
	evt.EnterHouse(66)         -- "Tsunami"
end

evt.house[18] = 532  -- "Tent"
evt.map[18] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[19] = 534  -- "Tent"
evt.map[19] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[20] = 537  -- "Tent"
evt.map[20] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[21] = 533  -- "Wagon"
evt.map[21] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[22] = 535  -- "Wagon"
evt.map[22] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.house[23] = 536  -- "Wagon"
evt.map[23] = function()
	if not evt.Cmp("DayOfYearIs", 308) then
		if not evt.Cmp("DayOfYearIs", 309) then
			if not evt.Cmp("DayOfYearIs", 310) then
				if not evt.Cmp("DayOfYearIs", 311) then
					if not evt.Cmp("DayOfYearIs", 312) then
						if not evt.Cmp("DayOfYearIs", 313) then
							if not evt.Cmp("DayOfYearIs", 314) then
								if not evt.Cmp("DayOfYearIs", 315) then
									if not evt.Cmp("DayOfYearIs", 316) then
										if not evt.Cmp("DayOfYearIs", 317) then
											if not evt.Cmp("DayOfYearIs", 318) then
												if not evt.Cmp("DayOfYearIs", 319) then
													if not evt.Cmp("DayOfYearIs", 320) then
														if not evt.Cmp("DayOfYearIs", 321) then
															if not evt.Cmp("DayOfYearIs", 322) then
																if not evt.Cmp("DayOfYearIs", 323) then
																	if not evt.Cmp("DayOfYearIs", 324) then
																		if not evt.Cmp("DayOfYearIs", 325) then
																			if not evt.Cmp("DayOfYearIs", 326) then
																				if not evt.Cmp("DayOfYearIs", 327) then
																					if not evt.Cmp("DayOfYearIs", 328) then
																						if not evt.Cmp("DayOfYearIs", 329) then
																							if not evt.Cmp("DayOfYearIs", 330) then
																								if not evt.Cmp("DayOfYearIs", 331) then
																									if not evt.Cmp("DayOfYearIs", 332) then
																										if not evt.Cmp("DayOfYearIs", 333) then
																											if not evt.Cmp("DayOfYearIs", 334) then
																												if not evt.Cmp("DayOfYearIs", 335) then
																													evt.StatusText(12)         -- "No one is here.  The Circus has moved."
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

evt.hint[24] = evt.str[21]  -- "Kat'an"
evt.map[24] = function()
	evt.StatusText(21)         -- "Kat'an"
end

evt.hint[25] = evt.str[22]  -- "Kastutia"
evt.map[25] = function()
	evt.StatusText(22)         -- "Kastutia"
end

evt.hint[26] = evt.str[23]  -- "Circus (Winter)"
evt.map[26] = function()
	evt.StatusText(23)         -- "Circus (Winter)"
end

evt.house[50] = 414  -- "House"
evt.map[50] = function()
	evt.EnterHouse(414)         -- "House"
end

evt.house[51] = 415  -- "House"
evt.map[51] = function()
	evt.EnterHouse(415)         -- "House"
end

evt.house[52] = 416  -- "House"
evt.map[52] = function()
	evt.EnterHouse(416)         -- "House"
end

evt.house[53] = 417  -- "House"
evt.map[53] = function()
	evt.EnterHouse(417)         -- "House"
end

evt.house[54] = 418  -- "House"
evt.map[54] = function()
	evt.EnterHouse(418)         -- "House"
end

evt.house[55] = 419  -- "House"
evt.map[55] = function()
	evt.EnterHouse(419)         -- "House"
end

evt.house[56] = 420  -- "House"
evt.map[56] = function()
	evt.EnterHouse(420)         -- "House"
end

evt.house[57] = 421  -- "House"
evt.map[57] = function()
	evt.EnterHouse(421)         -- "House"
end

evt.house[58] = 422  -- "House"
evt.map[58] = function()
	evt.EnterHouse(422)         -- "House"
end

evt.house[59] = 423  -- "House"
evt.map[59] = function()
	evt.EnterHouse(423)         -- "House"
end

evt.hint[60] = evt.str[4]  -- "Chest"
evt.map[60] = function()
	evt.OpenChest(1)
end

evt.hint[61] = evt.str[4]  -- "Chest"
evt.map[61] = function()
	evt.OpenChest(2)
end

evt.hint[62] = evt.str[4]  -- "Chest"
evt.map[62] = function()
	evt.OpenChest(3)
end

evt.hint[63] = evt.str[4]  -- "Chest"
evt.map[63] = function()
	evt.OpenChest(4)
end

evt.hint[64] = evt.str[4]  -- "Chest"
evt.map[64] = function()
	evt.OpenChest(5)
end

evt.map[90] = function()
	evt.MoveToMap{X = 601, Y = 6871, Z = 177, Direction = 1400, LookAngle = 0, SpeedZ = 0, HouseId = 174, Icon = 5, Name = "D01.Blv"}         -- "Forbidden Vault"
end

evt.house[91] = 192  -- "Wrenford's Retreat"
evt.map[91] = function()
	evt.MoveToMap{X = 0, Y = -2231, Z = 513, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 192, Icon = 5, Name = "T2.Blv"}         -- "Wrenford's Retreat"
end

evt.house[92] = 194  -- "Ooze Pit"
evt.map[92] = function()
	evt.MoveToMap{X = -2688, Y = 1216, Z = 1153, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 188, Icon = 5, Name = "D18.Blv"}         -- "Underwald"
end

evt.house[93] = 193  -- "Lunatic Vault"
evt.map[93] = function()
	evt.MoveToMap{X = 2817, Y = -4748, Z = -639, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 193, Icon = 5, Name = "T3.Blv"}         -- "Lunatic Vault"
end

evt.house[94] = 78  -- "Temple Carmen"
evt.map[94] = function()
	evt.EnterHouse(78)         -- "Temple Carmen"
end

evt.hint[100] = evt.str[5]  -- "Drink from Well."
evt.map[100] = function()
	if not evt.Cmp("MightBonus", 20) then
		evt.Set("MightBonus", 20)
		evt.StatusText(6)         -- "+20 Might temporary."
		evt.Set("AutonotesBits", 22)         -- "20 Points of temporary might from the well near the Goblin's Tooth in Kastution Waters."
	end
end

evt.hint[101] = evt.str[5]  -- "Drink from Well."
evt.map[101] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Cold, Damage = 40}
	evt.Set("PoisonedGreen", 1)
	evt.StatusText(7)         -- "Poison!"
end

evt.hint[102] = evt.str[24]  -- "Drink from Fountain"
evt.map[102] = function()
	if not evt.Cmp("BaseIntellect", 15) then
		if evt.Cmp("MapVar1", 1) then
			evt.Subtract("MapVar1", 1)
			evt.Add("BaseIntellect", 2)
			evt.StatusText(9)         -- "+2 Intellect permanent."
			evt.Set("AutonotesBits", 23)         -- "2 Points of permanent intellect from the north fountain in Kastution Waters."
			return
		end
	end
	evt.StatusText(2)         -- "Refreshing!"
end

evt.hint[103] = evt.str[24]  -- "Drink from Fountain"
evt.map[103] = function()
	if not evt.Cmp("BasePersonality", 15) then
		if evt.Cmp("MapVar2", 1) then
			evt.Subtract("MapVar2", 1)
			evt.Add("BasePersonality", 2)
			evt.StatusText(10)         -- "+2 Personality permanent."
			evt.Set("AutonotesBits", 24)         -- "2 Points of permanent personality from the south fountain in Kastution Waters."
			return
		end
	end
	evt.StatusText(2)         -- "Refreshing!"
end

evt.map[104] = function()  -- RefillTimer(<function>, const.Month, true)
	evt.Set("MapVar1", 8)
	evt.Set("MapVar2", 8)
end

RefillTimer(evt.map[104].last, const.Month, true)

evt.map[219] = function()  -- Timer(<function>, const.Week)
	evt.Set("MapVar9", 0)
end

Timer(evt.map[219].last, const.Week)

evt.hint[220] = evt.str[8]  -- "Drink from Fountain of Boons"
evt.map[220] = function()
	if evt.Cmp("QBits", 111) then         -- "Find the Staff of Merlin in the Ooze Pit in Kastutia and return to Soiret the Adept in the Enchanted Bastion."
		evt.SetNPCTopic{NPC = 5, Index = 1, Event = 58}         -- "Soiret The Adept" : "Staff of Merlin"
		evt.Set("QBits", 236)         -- NPC
	end
	if evt.Cmp("HasFullSP", 0) then
		evt.StatusText(2)         -- "Refreshing!"
		evt.Add("AutonotesBits", 10)         -- ""
	else
		evt.Add("SP", 20)
		evt.StatusText(11)         -- "+20 Spell points restored."
		evt.Add("AutonotesBits", 10)         -- ""
	end
end

evt.hint[261] = evt.str[14]  -- "Shrine of Intellect"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 1) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 207) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseIntellect", 3)
				evt.StatusText(17)         -- "+3 Intellectt permanent"
			else
				evt.Set("QBits", 207)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseIntellect", 10)
				evt.StatusText(16)         -- "+10 Intellect permanent"
			end
			return
		end
	end
	evt.StatusText(15)         -- "You pray at the shrine."
end

evt.hint[221] = evt.str[18]  -- "Pedestal"
evt.map[221] = function()
	if evt.Cmp("Inventory", 454) then         -- "Dragon Statuette"
		evt.Subtract("Inventory", 454)         -- "Dragon Statuette"
		evt.SetSprite{SpriteId = 347, Visible = 1, Name = "ped05"}
		evt.Set("QBits", 226)         -- NPC
		if evt.Cmp("QBits", 223) then         -- NPC
			if evt.Cmp("QBits", 224) then         -- NPC
				if evt.Cmp("QBits", 225) then         -- NPC
					if evt.Cmp("QBits", 222) then         -- NPC
						evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Jaana Barthold"
						evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Maikki Barthold" -> "Barthold Residence"
					end
				end
			end
		end
	end
end

evt.map[122] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 226) then         -- NPC
		evt.SetSprite{SpriteId = 347, Visible = 1, Name = "ped05"}
	end
end

events.LoadMap = evt.map[122].last

evt.hint[223] = evt.str[20]  -- "Obelisk"
evt.map[223] = function()
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                          tota_uruNkiuhiy_r"
	evt.SimpleMessage()
	evt.Set("QBits", 370)         -- NPC
	evt.Set("AutonotesBits", 89)         -- "Obelisk Message # 11: tota_uruNkiuhiy_r"
end

evt.map[262] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 495) then         -- Kastution Reload
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 6, X = 224, Y = -19056, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 7, X = 240, Y = -20512, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = -610, Y = -19400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = 1024, Y = -19880, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 9, X = 9216, Y = -15312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -12624, Y = -20896, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = -13728, Y = -19984, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = -18704, Y = -16240, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = -18976, Y = -4656, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = -6096, Y = 3968, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -4464, Y = 4416, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 4, X = 16800, Y = 17296, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 17376, Y = 16736, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 4, X = 15776, Y = 14640, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = 16240, Y = 15248, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 7, X = -21216, Y = -7936, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 3, X = -17856, Y = -4976, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 5, X = -20064, Y = -7904, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = -12352, Y = -20384, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = -18160, Y = -16144, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 8, X = 14576, Y = -16128, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 3, X = 14672, Y = -20192, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 6, X = 6976, Y = -22784, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 7952, Y = -17760, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 8, X = 5168, Y = -6256, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 3, X = 6112, Y = -6416, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 7, X = 15968, Y = -9616, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 5, X = 17776, Y = -9104, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = 14496, Y = 12032, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = -7616, Y = 19232, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 5, X = -2816, Y = 5312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 1, Count = 6, X = -19248, Y = 19008, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 4, X = -18352, Y = 18976, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 6, X = -13680, Y = -20656, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 1, Count = 7, X = -12752, Y = -19536, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 5, X = 17072, Y = -20176, Z = 0}
		evt.Set("QBits", 495)         -- Kastution Reload
		if not evt.Cmp("QBits", 508) then         -- Warrior
			return
		end
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 224, Y = -19050, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 240, Y = -20500, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -600, Y = -19400, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 2, Count = 1, X = 1024, Y = -19880, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 9216, Y = -15312, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -12610, Y = -20890, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -13728, Y = -19900, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -6096, Y = 3968, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 3, Level = 2, Count = 1, X = -18970, Y = -4650, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -4460, Y = 4410, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 16800, Y = 17296, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = 17725, Y = 16736, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -12752, Y = -19524, Z = 0}
	end
	if evt.Cmp("QBits", 507) then         -- Death Wish
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 210, Y = -19040, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 230, Y = -20500, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = -4450, Y = 4420, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 5, X = 17360, Y = 16730, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 5, X = 1015, Y = -19870, Z = 0}
		evt.SummonMonsters{TypeIndexInMapStats = 2, Level = 3, Count = 2, X = 17072, Y = -20170, Z = 0}
		evt.Set("QBits", 495)         -- Kastution Reload
	else
		evt.Set("QBits", 495)         -- Kastution Reload
	end
end

events.LoadMap = evt.map[262].last

evt.map[263] = function()
	evt.Subtract("HasFullSP", 0)
end

