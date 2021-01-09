local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "+10 Elemental resistance permanent.",
	[3] = "+10 Seven statistics permanent.",
	[4] = "+50 Hit points temporary.",
	[5] = "Refreshing!",
	[6] = "Chest",
	[7] = "+20 to all stats permanent.",
	[8] = "Dragonsand",
	[9] = "Shrine of Magic",
	[10] = "You pray at the shrine.",
	[11] = "+10 Magic resistance permanent",
	[12] = "+3 Magic resistance permanent",
	[13] = "Pedestal",
	[14] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            erbthieaeuu,_o'd",
	[15] = "Obelisk",
	[16] = "Shrine of the Gods",
	[17] = "rock",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[8]  -- "Dragonsand"
Game.LoadSound(14050)

evt.hint[1] = evt.str[17]  -- "rock"
evt.HouseDoor(50, 260)  -- "House"
evt.HouseDoor(51, 261)  -- "House"
evt.HouseDoor(52, 262)  -- "House"
evt.HouseDoor(53, 263)  -- "House"
evt.HouseDoor(54, 264)  -- "House"
evt.HouseDoor(55, 265)  -- "House"
evt.HouseDoor(56, 266)  -- "Tent"
evt.HouseDoor(57, 267)  -- "Tent"
evt.HouseDoor(58, 555)  -- "Tent"
evt.HouseDoor(59, 556)  -- "Tent"
evt.HouseDoor(60, 557)  -- "Tent"
evt.hint[75] = evt.str[6]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[6]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[6]  -- "Chest"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.hint[78] = evt.str[6]  -- "Chest"
evt.map[78] = function()
	evt.OpenChest(4)
end

evt.hint[79] = evt.str[6]  -- "Chest"
evt.map[79] = function()
	evt.OpenChest(5)
end

evt.house[90] = 202  -- "Tomb of VARN"
evt.map[90] = function()
	evt.MoveToMap{X = -9734, Y = -19201, Z = 772, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 202, Icon = 5, Name = "Pyramid.Blv"}         -- "Tomb of VARN"
end

evt.map[91] = function()
	evt.MoveToMap{X = 0, Y = 0, Z = 0, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutE3.Odm"}
end

evt.map[92] = function()
	evt.MoveToMap{X = -640, Y = 512, Z = -416, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "zNWC.Blv"}
end

evt.hint[100] = evt.str[1]  -- "Drink from Fountain"
evt.map[100] = function()
	if evt.Cmp("PlayerBits", 3) then
		evt.Set("Eradicated", 0)
	else
		evt.Add("FireResistance", 10)
		evt.Add("ElecResistance", 10)
		evt.Add("ColdResistance", 10)
		evt.Add("PoisonResistance", 10)
		evt.Set("PlayerBits", 3)
		evt.Set("Eradicated", 0)
		evt.StatusText(2)         -- "+10 Elemental resistance permanent."
		evt.Set("AutonotesBits", 38)         -- "10 Points of permanent fire, electricity, cold, and poison resistance from the fountain on the east island in Dragonsand."
	end
end

evt.hint[101] = evt.str[1]  -- "Drink from Fountain"
evt.map[101] = function()
	if evt.Cmp("PlayerBits", 4) then
		evt.Set("Eradicated", 0)
	else
		evt.Add("BaseMight", 10)
		evt.Add("BaseIntellect", 10)
		evt.Add("BasePersonality", 10)
		evt.Add("BaseEndurance", 10)
		evt.Add("BaseSpeed", 10)
		evt.Add("BaseAccuracy", 10)
		evt.Add("BaseLuck", 10)
		evt.Set("PlayerBits", 4)
		evt.Set("Eradicated", 0)
		evt.StatusText(3)         -- "+10 Seven statistics permanent."
		evt.Set("AutonotesBits", 39)         -- "10 Points of permanent might, accuracy, speed, endurance, personality, intellect, and luck from the fountain on the south island in Dragonsand."
	end
end

evt.hint[102] = evt.str[1]  -- "Drink from Fountain"
evt.map[102] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("HP", 50)
		evt.StatusText(4)         -- "+50 Hit points temporary."
	else
		evt.StatusText(5)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 40)         -- "50 Hit points restored from fountain on the northwest island in Dragonsand."
end

RefillTimer(function()
	evt.Set("MapVar0", 20)
end, const.Week)

evt.hint[103] = evt.str[16]  -- "Shrine of the Gods"
evt.map[103] = function()
	if not evt.Cmp("PlayerBits", 10) then
		evt.Add("FireResistance", 20)
		evt.Add("ElecResistance", 20)
		evt.Add("ColdResistance", 20)
		evt.Add("PoisonResistance", 20)
		evt.Add("MagicResistance", 20)
		evt.Add("BaseMight", 20)
		evt.Add("BaseIntellect", 20)
		evt.Add("BasePersonality", 20)
		evt.Add("BaseEndurance", 20)
		evt.Add("BaseSpeed", 20)
		evt.Add("BaseAccuracy", 20)
		evt.Add("BaseLuck", 20)
		evt.Set("PlayerBits", 10)
		evt.Set("MainCondition", const.Condition.Cursed)
		evt.PlaySound{Id = 14050, X = 0, Y = 0}
		evt.StatusText(7)         -- "+20 to all stats permanent."
	end
end

evt.hint[105] = evt.str[13]  -- "Pedestal"
evt.map[105] = function()
	if not evt.Cmp("Inventory", 453) then         -- "Eagle Statuette"
		if not evt.Cmp("Inventory", 452) then         -- "Wolf Statuette"
			return
		end
		if not evt.Cmp("QBits", 225) then         -- NPC
			return
		end
		evt.Subtract("Inventory", 452)         -- "Wolf Statuette"
	else
		evt.Subtract("Inventory", 453)         -- "Eagle Statuette"
	end
	evt.SetSprite{SpriteId = 321, Visible = 1, Name = "ped03"}
	evt.Set("QBits", 224)         -- NPC
	if evt.Cmp("QBits", 223) then         -- NPC
		if evt.Cmp("QBits", 222) then         -- NPC
			if evt.Cmp("QBits", 225) then         -- NPC
				if evt.Cmp("QBits", 226) then         -- NPC
					evt.MoveNPC{NPC = 87, HouseId = 0}         -- "Twillen"
					evt.MoveNPC{NPC = 41, HouseId = 253}         -- "Twillen" -> "House"
				end
			end
		end
	end
end

evt.map[106] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 224) then         -- NPC
		evt.SetSprite{SpriteId = 321, Visible = 1, Name = "ped03"}
	end
end

events.LoadMap = evt.map[106].last

evt.hint[107] = evt.str[15]  -- "Obelisk"
evt.map[107] = function()
	evt.SetMessage(14)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            erbthieaeuu,_o'd"
	evt.SimpleMessage()
	evt.Set("QBits", 365)         -- NPC
	evt.Set("AutonotesBits", 84)         -- "Obelisk Message # 6:  erbthieaeuu,_o'd"
end

evt.hint[108] = evt.str[17]  -- "rock"
evt.map[108] = function()
	if not evt.Cmp("MapVar1", 1) then
		if evt.Cmp("QBits", 375) then         -- NPC
			evt.OpenChest(7)
		elseif evt.Cmp("QBits", 361) then         -- NPC
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
													if not evt.Cmp("QBits", 372) then         -- NPC
														return
													end
													if not evt.Cmp("QBits", 373) then         -- NPC
														return
													end
													if not evt.Cmp("QBits", 374) then         -- NPC
														return
													end
													goto _30
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		return
	end
::_30::
	evt.OpenChest(6)
	if not evt.Cmp("QBits", 375) then         -- NPC
		evt.Add("Gold", 250000)
		evt.Set("MapVar1", 1)
		evt.Set("QBits", 375)         -- NPC
	end
end

