local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Exit",
	[3] = "Chest",
	[4] = "Not enough memory to operate.",
	[5] = "Panel",
	[6] = "Oracle",
	[7] = "Power on.  Status:  All systems functional.",
	[8] = "Power off.  Status:  All systems shut down.",
	[9] = "Insert Memory module to activate Melian.",
	[10] = "Memory module restored.",
	[11] = "+100,000 Experience",
	[12] = "Stand by…",
	[13] = "Oracle of Enroth",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[13]  -- "Oracle of Enroth"

evt.hint[1] = evt.str[5]  -- "Panel"
evt.map[1] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar0", 1) then
			evt.SetDoorState{Id = 1, State = 2}         -- switch state
			evt.StatusText(12)         -- "Stand by…"
		end
	end
end

evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetLight{Id = 48, On = true}
	evt.SetLight{Id = 49, On = true}
	evt.SetLight{Id = 50, On = true}
	evt.SetLight{Id = 51, On = true}
	evt.Set("MapVar5", 1)
end

evt.map[18] = function()
	evt.SetLight{Id = 49, On = false}
	evt.SetLight{Id = 50, On = false}
	evt.SetLight{Id = 48, On = false}
	evt.SetLight{Id = 51, On = false}
	evt.Set("MapVar5", 0)
	evt.SetDoorState{Id = 2, State = 0}
end

function events.LoadMap()
	evt.SetLight{Id = 49, On = false}
	evt.SetLight{Id = 50, On = false}
	evt.SetLight{Id = 48, On = false}
	evt.SetLight{Id = 51, On = false}
	evt.Set("MapVar5", 0)
	evt.SetDoorState{Id = 2, State = 0}
end

evt.HouseDoor(3, 170)  -- "The Oracle"
evt.map[4] = function()
	evt.SetDoorState{Id = 2, State = 0}
end

evt.map[5] = function()
	if not evt.Cmp("MapVar6", 1) then
		return
	end
	if evt.Cmp("QBits", 280) then         -- NPC
		goto _10
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 550) then         -- "Memory Crystal Alpha"
		goto _5
	end
	if evt.Cmp("QBits", 100) then         -- Oracle
		goto _5
	end
	evt.Subtract("Inventory", 550)         -- "Memory Crystal Alpha"
	evt.Set("QBits", 100)         -- Oracle
	evt.Subtract("QBits", 191)         -- Quest item bits for seer
	evt.Set("QBits", 280)         -- NPC
::_36::
	evt.SetSprite{SpriteId = 4, Visible = 1, Name = "mcryst01"}
	evt.SetLight{Id = 63, On = true}
	evt.Add("Experience", 100000)
	evt.StatusText(11)         -- "+100,000 Experience"
	if evt.Cmp("QBits", 100) then         -- Oracle
		if evt.Cmp("QBits", 101) then         -- Oracle
			if evt.Cmp("QBits", 102) then         -- Oracle
				if evt.Cmp("QBits", 103) then         -- Oracle
					evt.SetNPCTopic{NPC = 8, Index = 0, Event = 76}         -- "Oracle" : "Control Center"
					evt.SetNPCTopic{NPC = 8, Index = 1, Event = 0}         -- "Oracle"
				end
			end
		end
	end
	do return end
::_10::
	evt.StatusText(10)         -- "Memory module restored."
	do return end
::_5::
	if not evt.Cmp("Inventory", 551) then         -- "Memory Crystal Beta"
		goto _6
	end
	if evt.Cmp("QBits", 101) then         -- Oracle
		goto _6
	end
	evt.Subtract("Inventory", 551)         -- "Memory Crystal Beta"
	evt.Set("QBits", 101)         -- Oracle
	evt.Subtract("QBits", 192)         -- Quest item bits for seer
	evt.Set("QBits", 280)         -- NPC
	goto _36
::_6::
	if not evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
		goto _7
	end
	if evt.Cmp("QBits", 102) then         -- Oracle
		goto _7
	end
	evt.Subtract("Inventory", 552)         -- "Memory Crystal Delta"
	evt.Set("QBits", 102)         -- Oracle
	evt.Subtract("QBits", 193)         -- Quest item bits for seer
	evt.Set("QBits", 280)         -- NPC
	goto _36
::_7::
	if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
		evt.StatusText(9)         -- "Insert Memory module to activate Melian."
		return
	end
	if evt.Cmp("QBits", 103) then         -- Oracle
		goto _10
	end
	evt.Subtract("Inventory", 553)         -- "Memory Crystal Epsilon"
	evt.Set("QBits", 103)         -- Oracle
	evt.Subtract("QBits", 194)         -- Quest item bits for seer
	evt.Set("QBits", 280)         -- NPC
	goto _36
end

evt.map[6] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.SetTexture{Facet = 436, Name = "trekscon"}
		evt.Set("MapVar0", 1)
	end
end

evt.map[7] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar0", 1) then
			evt.SetTexture{Facet = 436, Name = "trekscrn"}
			evt.Set("MapVar0", 0)
		end
	end
end

evt.map[8] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.SetLight{Id = 1, On = true}
		evt.SetLight{Id = 2, On = true}
		evt.SetLight{Id = 3, On = true}
		evt.SetLight{Id = 4, On = true}
		evt.SetLight{Id = 5, On = true}
		evt.SetLight{Id = 6, On = true}
		evt.SetLight{Id = 7, On = true}
		evt.SetLight{Id = 9, On = true}
		evt.SetLight{Id = 10, On = true}
		evt.SetLight{Id = 11, On = true}
		evt.SetLight{Id = 12, On = true}
		evt.SetLight{Id = 13, On = true}
		evt.SetLight{Id = 14, On = true}
		evt.SetLight{Id = 15, On = true}
		evt.SetLight{Id = 16, On = true}
	end
end

evt.map[9] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.SetLight{Id = 1, On = false}
		evt.SetLight{Id = 2, On = false}
		evt.SetLight{Id = 3, On = false}
		evt.SetLight{Id = 4, On = false}
		evt.SetLight{Id = 5, On = false}
		evt.SetLight{Id = 6, On = false}
		evt.SetLight{Id = 7, On = false}
		evt.SetLight{Id = 9, On = false}
		evt.SetLight{Id = 10, On = false}
		evt.SetLight{Id = 11, On = false}
		evt.SetLight{Id = 12, On = false}
		evt.SetLight{Id = 13, On = false}
		evt.SetLight{Id = 14, On = false}
		evt.SetLight{Id = 15, On = false}
		evt.SetLight{Id = 16, On = false}
	end
end

evt.map[10] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar1", 1) then
			evt.SetLight{Id = 17, On = false}
			evt.SetLight{Id = 18, On = false}
			evt.SetLight{Id = 19, On = false}
			evt.SetLight{Id = 20, On = false}
			evt.SetLight{Id = 21, On = false}
			evt.SetLight{Id = 22, On = false}
			evt.SetLight{Id = 23, On = false}
			evt.SetLight{Id = 24, On = false}
			evt.Set("MapVar1", 0)
		else
			evt.SetLight{Id = 17, On = true}
			evt.SetLight{Id = 18, On = true}
			evt.SetLight{Id = 19, On = true}
			evt.SetLight{Id = 20, On = true}
			evt.SetLight{Id = 21, On = true}
			evt.SetLight{Id = 22, On = true}
			evt.SetLight{Id = 23, On = true}
			evt.SetLight{Id = 24, On = true}
			evt.Set("MapVar1", 1)
		end
	end
end

evt.map[11] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar2", 1) then
			evt.SetLight{Id = 25, On = false}
			evt.SetLight{Id = 26, On = false}
			evt.SetLight{Id = 27, On = false}
			evt.SetLight{Id = 28, On = false}
			evt.SetLight{Id = 29, On = false}
			evt.SetLight{Id = 30, On = false}
			evt.SetLight{Id = 31, On = false}
			evt.SetLight{Id = 32, On = false}
			evt.Set("MapVar2", 0)
		else
			evt.SetLight{Id = 25, On = true}
			evt.SetLight{Id = 26, On = true}
			evt.SetLight{Id = 27, On = true}
			evt.SetLight{Id = 29, On = true}
			evt.SetLight{Id = 29, On = true}
			evt.SetLight{Id = 30, On = true}
			evt.SetLight{Id = 31, On = true}
			evt.SetLight{Id = 32, On = true}
			evt.Set("MapVar2", 1)
		end
	end
end

evt.map[12] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar3", 1) then
			evt.SetLight{Id = 33, On = false}
			evt.SetLight{Id = 34, On = false}
			evt.SetLight{Id = 35, On = false}
			evt.SetLight{Id = 36, On = false}
			evt.SetLight{Id = 37, On = false}
			evt.SetLight{Id = 38, On = false}
			evt.SetLight{Id = 39, On = false}
			evt.SetLight{Id = 40, On = false}
			evt.Set("MapVar3", 0)
		else
			evt.SetLight{Id = 33, On = true}
			evt.SetLight{Id = 34, On = true}
			evt.SetLight{Id = 35, On = true}
			evt.SetLight{Id = 36, On = true}
			evt.SetLight{Id = 37, On = true}
			evt.SetLight{Id = 38, On = true}
			evt.SetLight{Id = 39, On = true}
			evt.SetLight{Id = 40, On = true}
			evt.Set("MapVar3", 1)
		end
	end
end

evt.map[13] = function()
	if evt.Cmp("MapVar6", 1) then
		if evt.Cmp("MapVar4", 1) then
			evt.SetLight{Id = 41, On = false}
			evt.SetLight{Id = 42, On = false}
			evt.SetLight{Id = 43, On = false}
			evt.SetLight{Id = 44, On = false}
			evt.SetLight{Id = 45, On = false}
			evt.SetLight{Id = 46, On = false}
			evt.Set("MapVar4", 0)
		else
			evt.SetLight{Id = 41, On = true}
			evt.SetLight{Id = 42, On = true}
			evt.SetLight{Id = 43, On = true}
			evt.SetLight{Id = 44, On = true}
			evt.SetLight{Id = 45, On = true}
			evt.SetLight{Id = 46, On = true}
			evt.Set("MapVar4", 1)
		end
	end
end

evt.hint[14] = evt.str[5]  -- "Panel"
evt.map[14] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.SetLight{Id = 52, On = false}
		evt.SetLight{Id = 53, On = false}
		evt.SetLight{Id = 54, On = false}
		evt.SetLight{Id = 55, On = false}
		evt.SetLight{Id = 56, On = false}
		evt.SetLight{Id = 57, On = false}
		evt.SetLight{Id = 58, On = false}
		evt.SetLight{Id = 59, On = false}
		evt.SetLight{Id = 60, On = false}
		evt.SetLight{Id = 61, On = false}
		evt.SetLight{Id = 62, On = false}
		evt.StatusText(8)         -- "Power off.  Status:  All systems shut down."
		evt.Set("MapVar6", 0)
	else
		evt.SetLight{Id = 52, On = true}
		evt.SetLight{Id = 53, On = true}
		evt.SetLight{Id = 54, On = true}
		evt.SetLight{Id = 55, On = true}
		evt.SetLight{Id = 56, On = true}
		evt.SetLight{Id = 57, On = true}
		evt.SetLight{Id = 58, On = true}
		evt.SetLight{Id = 59, On = true}
		evt.SetLight{Id = 60, On = true}
		evt.SetLight{Id = 61, On = true}
		evt.SetLight{Id = 62, On = true}
		evt.Set("MapVar6", 1)
		evt.StatusText(7)         -- "Power on.  Status:  All systems functional."
	end
end

evt.map[15] = function()
	if not evt.Cmp("MapVar6", 1) then
		return
	end
	if evt.Cmp("QBits", 281) then         -- NPC
		goto _10
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 550) then         -- "Memory Crystal Alpha"
		goto _5
	end
	if evt.Cmp("QBits", 100) then         -- Oracle
		goto _5
	end
	evt.Subtract("Inventory", 550)         -- "Memory Crystal Alpha"
	evt.Set("QBits", 100)         -- Oracle
	evt.Subtract("QBits", 191)         -- Quest item bits for seer
	evt.Set("QBits", 281)         -- NPC
::_36::
	evt.SetSprite{SpriteId = 3, Visible = 1, Name = "mcryst01"}
	evt.SetLight{Id = 64, On = true}
	evt.Add("Experience", 100000)
	evt.StatusText(11)         -- "+100,000 Experience"
	if evt.Cmp("QBits", 100) then         -- Oracle
		if evt.Cmp("QBits", 101) then         -- Oracle
			if evt.Cmp("QBits", 102) then         -- Oracle
				if evt.Cmp("QBits", 103) then         -- Oracle
					evt.SetNPCTopic{NPC = 8, Index = 0, Event = 76}         -- "Oracle" : "Control Center"
					evt.SetNPCTopic{NPC = 8, Index = 1, Event = 0}         -- "Oracle"
				end
			end
		end
	end
	do return end
::_10::
	evt.StatusText(10)         -- "Memory module restored."
	do return end
::_5::
	if not evt.Cmp("Inventory", 551) then         -- "Memory Crystal Beta"
		goto _6
	end
	if evt.Cmp("QBits", 101) then         -- Oracle
		goto _6
	end
	evt.Subtract("Inventory", 551)         -- "Memory Crystal Beta"
	evt.Set("QBits", 101)         -- Oracle
	evt.Subtract("QBits", 192)         -- Quest item bits for seer
	evt.Set("QBits", 281)         -- NPC
	goto _36
::_6::
	if not evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
		goto _7
	end
	if evt.Cmp("QBits", 102) then         -- Oracle
		goto _7
	end
	evt.Subtract("Inventory", 552)         -- "Memory Crystal Delta"
	evt.Set("QBits", 102)         -- Oracle
	evt.Subtract("QBits", 193)         -- Quest item bits for seer
	evt.Set("QBits", 281)         -- NPC
	goto _36
::_7::
	if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
		evt.StatusText(9)         -- "Insert Memory module to activate Melian."
		return
	end
	if evt.Cmp("QBits", 103) then         -- Oracle
		goto _10
	end
	evt.Subtract("Inventory", 553)         -- "Memory Crystal Epsilon"
	evt.Set("QBits", 103)         -- Oracle
	evt.Subtract("QBits", 194)         -- Quest item bits for seer
	evt.Set("QBits", 281)         -- NPC
	goto _36
end

evt.map[16] = function()
	if not evt.Cmp("MapVar6", 1) then
		return
	end
	if evt.Cmp("QBits", 282) then         -- NPC
		goto _10
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 550) then         -- "Memory Crystal Alpha"
		goto _5
	end
	if evt.Cmp("QBits", 100) then         -- Oracle
		goto _5
	end
	evt.Subtract("Inventory", 550)         -- "Memory Crystal Alpha"
	evt.Set("QBits", 100)         -- Oracle
	evt.Subtract("QBits", 191)         -- Quest item bits for seer
	evt.Set("QBits", 282)         -- NPC
::_36::
	evt.SetSprite{SpriteId = 2, Visible = 1, Name = "mcryst01"}
	evt.SetLight{Id = 65, On = true}
	evt.Add("Experience", 100000)
	evt.StatusText(11)         -- "+100,000 Experience"
	if evt.Cmp("QBits", 100) then         -- Oracle
		if evt.Cmp("QBits", 101) then         -- Oracle
			if evt.Cmp("QBits", 102) then         -- Oracle
				if evt.Cmp("QBits", 103) then         -- Oracle
					evt.SetNPCTopic{NPC = 8, Index = 0, Event = 76}         -- "Oracle" : "Control Center"
					evt.SetNPCTopic{NPC = 8, Index = 1, Event = 0}         -- "Oracle"
				end
			end
		end
	end
	do return end
::_10::
	evt.StatusText(10)         -- "Memory module restored."
	do return end
::_5::
	if not evt.Cmp("Inventory", 551) then         -- "Memory Crystal Beta"
		goto _6
	end
	if evt.Cmp("QBits", 101) then         -- Oracle
		goto _6
	end
	evt.Subtract("Inventory", 551)         -- "Memory Crystal Beta"
	evt.Set("QBits", 101)         -- Oracle
	evt.Subtract("QBits", 192)         -- Quest item bits for seer
	evt.Set("QBits", 282)         -- NPC
	goto _36
::_6::
	if not evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
		goto _7
	end
	if evt.Cmp("QBits", 102) then         -- Oracle
		goto _7
	end
	evt.Subtract("Inventory", 552)         -- "Memory Crystal Delta"
	evt.Set("QBits", 102)         -- Oracle
	evt.Subtract("QBits", 193)         -- Quest item bits for seer
	evt.Set("QBits", 282)         -- NPC
	goto _36
::_7::
	if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
		evt.StatusText(9)         -- "Insert Memory module to activate Melian."
		return
	end
	if evt.Cmp("QBits", 103) then         -- Oracle
		goto _10
	end
	evt.Subtract("Inventory", 553)         -- "Memory Crystal Epsilon"
	evt.Set("QBits", 103)         -- Oracle
	evt.Subtract("QBits", 194)         -- Quest item bits for seer
	evt.Set("QBits", 282)         -- NPC
	goto _36
end

evt.map[17] = function()
	if not evt.Cmp("MapVar6", 1) then
		return
	end
	if evt.Cmp("QBits", 283) then         -- NPC
		goto _10
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 550) then         -- "Memory Crystal Alpha"
		goto _5
	end
	if evt.Cmp("QBits", 100) then         -- Oracle
		goto _5
	end
	evt.Subtract("Inventory", 550)         -- "Memory Crystal Alpha"
	evt.Set("QBits", 100)         -- Oracle
	evt.Subtract("QBits", 191)         -- Quest item bits for seer
	evt.Set("QBits", 283)         -- NPC
::_36::
	evt.SetSprite{SpriteId = 1, Visible = 1, Name = "mcryst01"}
	evt.SetLight{Id = 66, On = true}
	evt.Add("Experience", 100000)
	evt.StatusText(11)         -- "+100,000 Experience"
	if evt.Cmp("QBits", 100) then         -- Oracle
		if evt.Cmp("QBits", 101) then         -- Oracle
			if evt.Cmp("QBits", 102) then         -- Oracle
				if evt.Cmp("QBits", 103) then         -- Oracle
					evt.SetNPCTopic{NPC = 8, Index = 0, Event = 76}         -- "Oracle" : "Control Center"
					evt.SetNPCTopic{NPC = 8, Index = 1, Event = 0}         -- "Oracle"
				end
			end
		end
	end
	do return end
::_10::
	evt.StatusText(10)         -- "Memory module restored."
	do return end
::_5::
	if not evt.Cmp("Inventory", 551) then         -- "Memory Crystal Beta"
		goto _6
	end
	if evt.Cmp("QBits", 101) then         -- Oracle
		goto _6
	end
	evt.Subtract("Inventory", 551)         -- "Memory Crystal Beta"
	evt.Set("QBits", 101)         -- Oracle
	evt.Subtract("QBits", 192)         -- Quest item bits for seer
	evt.Set("QBits", 283)         -- NPC
	goto _36
::_6::
	if not evt.Cmp("Inventory", 552) then         -- "Memory Crystal Delta"
		goto _7
	end
	if evt.Cmp("QBits", 102) then         -- Oracle
		goto _7
	end
	evt.Subtract("Inventory", 552)         -- "Memory Crystal Delta"
	evt.Set("QBits", 102)         -- Oracle
	evt.Subtract("QBits", 193)         -- Quest item bits for seer
	evt.Set("QBits", 283)         -- NPC
	goto _36
::_7::
	if not evt.Cmp("Inventory", 553) then         -- "Memory Crystal Epsilon"
		evt.StatusText(9)         -- "Insert Memory module to activate Melian."
		return
	end
	if evt.Cmp("QBits", 103) then         -- Oracle
		goto _10
	end
	evt.Subtract("Inventory", 553)         -- "Memory Crystal Epsilon"
	evt.Set("QBits", 103)         -- Oracle
	evt.Subtract("QBits", 194)         -- Quest item bits for seer
	evt.Set("QBits", 283)         -- NPC
	goto _36
end

evt.map[51] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 280) then         -- NPC
		evt.SetSprite{SpriteId = 4, Visible = 1, Name = "mcryst01"}
	end
	if evt.Cmp("QBits", 281) then         -- NPC
		evt.SetSprite{SpriteId = 3, Visible = 1, Name = "mcryst01"}
	end
	if evt.Cmp("QBits", 282) then         -- NPC
		evt.SetSprite{SpriteId = 2, Visible = 1, Name = "mcryst01"}
	end
	if evt.Cmp("QBits", 283) then         -- NPC
		evt.SetSprite{SpriteId = 1, Visible = 1, Name = "mcryst01"}
	end
end

events.LoadMap = evt.map[51].last

evt.hint[50] = evt.str[2]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = 12182, Y = 5379, Z = 320, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutC2.Odm"}
end

