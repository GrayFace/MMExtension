local TXT = Localize{
	[0] = " ",
	[1] = "+5 Spell points restored",
	[2] = "Refreshing!",
	[3] = "Place Holder for Prince of Thieves.  Paul needs to provide this.",
	[4] = "Chest",
	[5] = "Drink from Well.",
	[6] = "+20 Might temporary.",
	[7] = "Poison!",
	[8] = "Drink from Fountain of Magic",
	[9] = "+2 Intellect permanent.",
	[10] = "+2 Personality permanent.",
	[11] = "+20 Spell points restored.",
	[12] = "No one is here.  The Circus has moved.",
	[13] = "Bootleg Bay",
	[14] = "Shrine of Might",
	[15] = "You pray at the shrine.",
	[16] = "+10 Might permanent",
	[17] = "+3 Might permanent",
	[18] = "Pedestal",
	[19] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            d_re_e_Hpfotyhz_",
	[20] = "Obelisk",
	[21] = "Ironfist Castle",
	[22] = "Freehaven",
	[23] = "Circus (Winter)",
	[24] = "Drink from Fountain",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Bootleg Bay"

evt.HouseDoor(2, 2)  -- "Hammer and Tongs"
evt.house[3] = 2  -- "Hammer and Tongs"
evt.HouseDoor(4, 18)  -- "Abraham's Metalworks"
evt.house[5] = 18  -- "Abraham's Metalworks"
evt.HouseDoor(6, 31)  -- "The Little Magic Shop"
evt.house[7] = 31  -- "The Little Magic Shop"
evt.HouseDoor(8, 83)  -- "Training-by-the-Sea"
evt.house[9] = 83  -- "Training-by-the-Sea"
evt.HouseDoor(10, 98)  -- "The Goblin's Tooth"
evt.house[11] = 98  -- "The Goblin's Tooth"
evt.HouseDoor(12, 99)  -- "The Broken Cutlass"
evt.house[13] = 99  -- "The Broken Cutlass"
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

evt.HouseDoor(15, 77)  -- "House of Healing"
evt.HouseDoor(16, 67)  -- "Valkyrie"
evt.HouseDoor(17, 66)  -- "Tsunami"
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

evt.hint[24] = evt.str[21]  -- "Ironfist Castle"
evt.map[24] = function()
	evt.StatusText(21)         -- "Ironfist Castle"
end

evt.hint[25] = evt.str[22]  -- "Freehaven"
evt.map[25] = function()
	evt.StatusText(22)         -- "Freehaven"
end

evt.hint[26] = evt.str[23]  -- "Circus (Winter)"
evt.map[26] = function()
	evt.StatusText(23)         -- "Circus (Winter)"
end

evt.HouseDoor(50, 414)  -- "House"
evt.HouseDoor(51, 415)  -- "House"
evt.HouseDoor(52, 416)  -- "House"
evt.HouseDoor(53, 417)  -- "House"
evt.HouseDoor(54, 418)  -- "House"
evt.HouseDoor(55, 419)  -- "House"
evt.HouseDoor(56, 420)  -- "House"
evt.HouseDoor(57, 421)  -- "House"
evt.HouseDoor(58, 422)  -- "House"
evt.HouseDoor(59, 423)  -- "House"
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

evt.house[90] = 174  -- "Hall of the Fire Lord"
evt.map[90] = function()
	evt.MoveToMap{X = -1792, Y = -19, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 174, Icon = 5, Name = "D04.Blv"}         -- "Hall of the Fire Lord"
end

evt.house[91] = 192  -- "Temple of the Fist"
evt.map[91] = function()
	evt.MoveToMap{X = 0, Y = -2231, Z = 513, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 192, Icon = 5, Name = "T2.Blv"}         -- "Temple of the Fist"
end

evt.house[92] = 194  -- "Temple of the Sun"
evt.map[92] = function()
	evt.MoveToMap{X = -3258, Y = 483, Z = 49, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 194, Icon = 5, Name = "T4.Blv"}         -- "Temple of the Sun"
end

evt.house[93] = 193  -- "Temple of Tsantsa"
evt.map[93] = function()
	evt.MoveToMap{X = 2817, Y = -4748, Z = -639, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 193, Icon = 5, Name = "T3.Blv"}         -- "Temple of Tsantsa"
end

evt.HouseDoor(94, 78)  -- "Temple Baa"
evt.hint[100] = evt.str[5]  -- "Drink from Well."
evt.map[100] = function()
	if not evt.Cmp("MightBonus", 20) then
		evt.Set("MightBonus", 20)
		evt.StatusText(6)         -- "+20 Might temporary."
		evt.Set("AutonotesBits", 22)         -- "20 Points of temporary might from the well near the Goblin's Tooth in Bootleg Bay."
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
			evt.Set("AutonotesBits", 23)         -- "2 Points of permanent intellect from the north fountain in Bootleg Bay."
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
			evt.Set("AutonotesBits", 24)         -- "2 Points of permanent personality from the south fountain in Bootleg Bay."
			return
		end
	end
	evt.StatusText(2)         -- "Refreshing!"
end

evt.map[104] = function()  -- RefillTimer(<function>, const.Month)
	evt.Set("MapVar1", 8)
	evt.Set("MapVar2", 8)
end

RefillTimer(evt.map[104].last, const.Month)

evt.map[219] = function()  -- Timer(<function>, const.Week)
	evt.Set("MapVar9", 0)
end

Timer(evt.map[219].last, const.Week)

evt.hint[220] = evt.str[8]  -- "Drink from Fountain of Magic"
evt.map[220] = function()
	if evt.Cmp("QBits", 111) then         -- "Drink from the Fountain of Magic and return to Lord Albert Newton in Mist."
		evt.SetNPCTopic{NPC = 5, Index = 1, Event = 58}         -- "Albert Newton" : "Wizards"
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

evt.hint[261] = evt.str[14]  -- "Shrine of Might"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 0) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 207) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseMight", 3)
				evt.StatusText(17)         -- "+3 Might permanent"
			else
				evt.Set("QBits", 207)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseMight", 10)
				evt.StatusText(16)         -- "+10 Might permanent"
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
						evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Twillen"
						evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Twillen" -> "House"
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
	evt.SetMessage(19)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            d_re_e_Hpfotyhz_"
	evt.SimpleMessage()
	evt.Set("QBits", 370)         -- NPC
	evt.Set("AutonotesBits", 89)         -- "Obelisk Message # 11: d_re_e_Hpfotyhz_"
end

