local TXT = Localize{
	[0] = " ",
	[1] = "Crate",
	[2] = "Dragon's Lair",
	[3] = "Drink from Fountain",
	[4] = "+2 Endurance permenant.",
	[5] = "Refreshing!",
	[6] = "No one is here.  The Circus has moved.",
	[7] = "Mire of the Damned",
	[8] = "Shrine of Speed",
	[9] = "You pray at the shrine.",
	[10] = "+10 Speed permanent",
	[11] = "+3 Speed permanent",
	[12] = "Pedestal",
	[13] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            aoflo'h.hbtid_p_",
	[14] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[7]  -- "Mire of the Damned"
-- ERROR: Duplicate label: 68:0

evt.HouseDoor(2, 6)  -- "Blunt Trauma Weapons"
evt.house[3] = 6  -- "Blunt Trauma Weapons"
evt.HouseDoor(4, 19)  -- "Mailed fist Armory"
evt.house[5] = 19  -- "Mailed fist Armory"
evt.HouseDoor(6, 34)  -- "Smoke and Mirrors"
evt.house[7] = 34  -- "Smoke and Mirrors"
evt.HouseDoor(8, 52)  -- "Darkmoor Travel"
evt.house[9] = 52  -- "Darkmoor Travel"
evt.HouseDoor(10, 102)  -- "The Haunt"
evt.house[11] = 102  -- "The Haunt"
evt.HouseDoor(12, 103)  -- "The Rusted Shield"
evt.house[13] = 103  -- "The Rusted Shield"
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

evt.HouseDoor(50, 334)  -- "House"
evt.HouseDoor(51, 335)  -- "House"
evt.HouseDoor(52, 336)  -- "House"
evt.HouseDoor(53, 337)  -- "House"
evt.HouseDoor(54, 338)  -- "House"
evt.HouseDoor(55, 339)  -- "House"
evt.HouseDoor(56, 340)  -- "House"
evt.HouseDoor(57, 341)  -- "House"
evt.HouseDoor(58, 342)  -- "House"
evt.HouseDoor(59, 343)  -- "House"
evt.HouseDoor(60, 344)  -- "House"
evt.HouseDoor(61, 345)  -- "House"
evt.HouseDoor(62, 346)  -- "House"
evt.HouseDoor(63, 347)  -- "House"
evt.HouseDoor(64, 348)  -- "House"
evt.HouseDoor(65, 349)  -- "House"
evt.HouseDoor(66, 350)  -- "House"
evt.HouseDoor(67, 351)  -- "House"
evt.HouseDoor(68, 352)  -- "House"
evt.HouseDoor(70, 354)  -- "House"
evt.HouseDoor(71, 355)  -- "House"
evt.HouseDoor(72, 356)  -- "House"
evt.HouseDoor(73, 357)  -- "House"
evt.HouseDoor(74, 358)  -- "House"
evt.HouseDoor(75, 359)  -- "House"
evt.HouseDoor(76, 360)  -- "House"
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

evt.house[90] = 179  -- "Snergle's Iron Mines"
evt.map[90] = function()
	evt.MoveToMap{X = -3714, Y = 1250, Z = 1, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 179, Icon = 5, Name = "D09.Blv"}         -- "Snergle's Iron Mines"
end

evt.house[91] = 200  -- "Castle Darkmoor"
evt.map[91] = function()
	evt.MoveToMap{X = 21169, Y = 1920, Z = -689, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 200, Icon = 5, Name = "CD2.Blv"}         -- "Castle Darkmoor"
end

evt.HouseDoor(92, 78)  -- "Temple Baa"
evt.hint[93] = evt.str[2]  -- "Dragon's Lair"
evt.map[93] = function()
	evt.MoveToMap{X = -622, Y = 239, Z = 1, Direction = 128, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 5, Name = "ZDDB01.Blv"}
end

evt.hint[100] = evt.str[3]  -- "Drink from Fountain"
evt.map[100] = function()
	if not evt.Cmp("BaseEndurance", 15) then
		if evt.Cmp("MapVar4", 1) then
			evt.Subtract("MapVar4", 1)
			evt.Add("BaseEndurance", 2)
			evt.StatusText(4)         -- "+2 Endurance permenant."
			evt.Set("AutonotesBits", 29)         -- "2 Points of permanent endurance from the fountain in the south of the Mire of the Damned."
			return
		end
	end
	evt.StatusText(5)         -- "Refreshing!"
end

RefillTimer(function()
	evt.Set("MapVar4", 8)
end, const.Month)

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

evt.hint[261] = evt.str[8]  -- "Shrine of Speed"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 5) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 212) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseSpeed", 3)
				evt.StatusText(11)         -- "+3 Speed permanent"
			else
				evt.Set("QBits", 212)         -- NPC
				evt.ForPlayer("All")
				evt.Add("BaseSpeed", 10)
				evt.StatusText(10)         -- "+10 Speed permanent"
			end
			return
		end
	end
	evt.StatusText(9)         -- "You pray at the shrine."
end

evt.hint[221] = evt.str[12]  -- "Pedestal"
evt.map[221] = function()
	if not evt.Cmp("Inventory", 452) then         -- "Wolf Statuette"
		if not evt.Cmp("Inventory", 453) then         -- "Eagle Statuette"
			return
		end
		if not evt.Cmp("QBits", 224) then         -- NPC
			return
		end
		evt.Subtract("Inventory", 453)         -- "Eagle Statuette"
	else
		evt.Subtract("Inventory", 452)         -- "Wolf Statuette"
	end
	evt.SetSprite{SpriteId = 394, Visible = 1, Name = "ped04"}
	evt.Set("QBits", 225)         -- NPC
	if evt.Cmp("QBits", 223) then         -- NPC
		if evt.Cmp("QBits", 224) then         -- NPC
			if evt.Cmp("QBits", 222) then         -- NPC
				if evt.Cmp("QBits", 226) then         -- NPC
					evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Twillen"
					evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Twillen" -> "House"
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
	evt.SetMessage(13)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            aoflo'h.hbtid_p_"
	evt.SimpleMessage()
	evt.Set("QBits", 368)         -- NPC
	evt.Set("AutonotesBits", 87)         -- "Obelisk Message # 9:  aoflo'h.hbtid_p_"
end

