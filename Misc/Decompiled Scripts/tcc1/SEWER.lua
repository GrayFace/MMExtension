local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Bed",
	[3] = "Chest",
	[4] = "Cabinet",
	[5] = "Sewer Grate",
	[6] = "Someone's hiding under the bed!",
	[7] = "Torch",
	[8] = "Trash",
	[9] = "Something's stashed here!",
	[10] = "Ouch!",
	[11] = "The door is locked.",
	[12] = "Exit",
	[13] = "Cylinder",
	[14] = "+10 Hit points restored.",
	[15] = "Refreshing!",
	[16] = "Well",
	[17] = "The Underground",
	[18] = "Strange Light",
	[19] = "The ladder is broken!",
	[20] = "Caged Prisoner",
	[21] = "What took you so long?",
	[22] = "Antonio's Venetian Tea",
	[23] = "The chest is locked!",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[17]  -- "The Underground"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.map[8] = function()
	if not evt.Cmp("QBits", 170) then         -- NPC
		if evt.Cmp("QBits", 98) then         -- "Clear out the Mercenary Stronghold in Port Sleigon, kill their leader and return Krukow’s Armor to Lord Godwinson."
			evt.SpeakNPC(17)         -- "Aelwen"
			evt.Set("NPCs", 17)         -- "Aelwen"
			evt.Set("QBits", 170)         -- NPC
		end
	end
end

evt.hint[9] = evt.str[7]  -- "Torch"
evt.map[9] = function()
	evt.SetSprite{SpriteId = 112, Visible = 1, Name = "torch"}
	evt.SetLight{Id = 0, On = true}
end

evt.hint[10] = evt.str[3]  -- "Chest"
evt.map[10] = function()
	evt.OpenChest(0)
end

evt.hint[11] = evt.str[4]  -- "Cabinet"
evt.map[11] = function()
	evt.OpenChest(1)
end

evt.hint[12] = evt.str[5]  -- "Sewer Grate"
evt.map[12] = function()
	local i
	if not evt.Cmp("MapVar3", 1) then
		evt.Add("Inventory", 578)         -- "Underground Key"
		evt.StatusText(9)         -- "Something's stashed here!"
		evt.Set("MapVar3", 1)
	else
		if not evt.Cmp("MapVar0", 12) then
			i = Game.Rand() % 5
			if i == 2 then
				evt.Add("MapVar0", 1)
				i = Game.Rand() % 3
				if i == 2 then
					evt.Add("MapVar0", 1)
				else
					evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 30}
					evt.StatusText(10)         -- "Ouch!"
					evt.Add("MapVar0", 1)
				end
			elseif i == 3 then
				evt.Add("MapVar0", 2)
				evt.Add("GoldAddRandom", 2000)
				evt.StatusText(9)         -- "Something's stashed here!"
			elseif i == 4 then
				evt.Add("GoldAddRandom", 1000)
				evt.StatusText(9)         -- "Something's stashed here!"
				evt.Add("MapVar0", 1)
			end
		end
	end
end

evt.hint[13] = evt.str[1]  -- "Door"
evt.map[13] = function()
	if evt.Cmp("Inventory", 578) then         -- "Underground Key"
		evt.SetDoorState{Id = 8, State = 1}
		evt.Subtract("Inventory", 578)         -- "Underground Key"
	else
		evt.StatusText(11)         -- "The door is locked."
	end
end

evt.hint[14] = evt.str[3]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(2)
end

evt.hint[15] = evt.str[3]  -- "Chest"
evt.map[15] = function()
	evt.OpenChest(3)
end

evt.hint[16] = evt.str[3]  -- "Chest"
evt.map[16] = function()
	if evt.Cmp("Inventory", 574) then         -- "Common Chest Key"
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 574)         -- "Common Chest Key"
		evt.OpenChest(4)
	else
		evt.StatusText(23)         -- "The chest is locked!"
	end
end

evt.hint[17] = evt.str[3]  -- "Chest"
evt.map[17] = function()
	evt.OpenChest(5)
end

evt.hint[18] = evt.str[3]  -- "Chest"
evt.map[18] = function()
	evt.OpenChest(6)
end

evt.hint[19] = evt.str[16]  -- "Well"
evt.map[19] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.Subtract("MapVar2", 1)
		evt.Add("HP", 10)
		evt.StatusText(14)         -- "+10 Hit points restored."
	else
		evt.StatusText(15)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 96)         -- "+10 Hit points restored south west of the main Sewer chamber."
	evt.Set("MapVar2", 20)
end

Timer(function()
	evt.Set("MapVar2", 20)
end, const.Day, 1*const.Second)

evt.hint[20] = evt.str[12]  -- "Exit"
evt.map[20] = function()
	evt.MoveToMap{X = 11534, Y = 18156, Z = 193, Direction = 1568, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC1.Odm"}
end

evt.hint[21] = evt.str[12]  -- "Exit"
evt.map[21] = function()
	evt.MoveToMap{X = 18175, Y = -3256, Z = 97, Direction = 1560, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC1.Odm"}
end

evt.hint[22] = evt.str[12]  -- "Exit"
evt.map[22] = function()
	evt.ForPlayer("All")
	evt.Subtract("HP", 15)
	evt.StatusText(19)         -- "The ladder is broken!"
end

evt.hint[23] = evt.str[12]  -- "Exit"
evt.map[23] = function()
	evt.ForPlayer("All")
	evt.Subtract("HP", 15)
	evt.StatusText(19)         -- "The ladder is broken!"
end

evt.hint[24] = evt.str[12]  -- "Exit"
evt.map[24] = function()
	evt.MoveToMap{X = -12831, Y = -11245, Z = 320, Direction = 1048, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutD2.Odm"}
end

evt.hint[25] = evt.str[12]  -- "Exit"
evt.map[25] = function()
	evt.MoveToMap{X = 10592, Y = 16625, Z = 161, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "outc2.odm"}
end

evt.hint[26] = evt.str[1]  -- "Door"
evt.map[26] = function()
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[27] = evt.str[13]  -- "Cylinder"
evt.map[27] = function()
	if evt.Cmp("QBits", 176) then         -- NPC
		evt.SetDoorState{Id = 21, State = 0}
	end
end

evt.map[28] = function()
	if evt.Cmp("QBits", 176) then         -- NPC
		evt.MoveToMap{X = -3078, Y = 2819, Z = 2049, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 5, Name = "t6.blv"}
	end
end

evt.hint[30] = evt.str[5]  -- "Sewer Grate"
evt.map[30] = function()
	if not evt.Cmp("MapVar5", 4) then
		evt.Add("MapVar5", 1)
		evt.Add("Inventory", 163)         -- "Potion Bottle"
	end
end

evt.hint[31] = evt.str[5]  -- "Sewer Grate"
evt.map[31] = function()
	if not evt.Cmp("MapVar6", 4) then
		evt.Add("MapVar6", 1)
		evt.Add("Inventory", 164)         -- "Cure Wounds"
	end
end

evt.hint[32] = evt.str[5]  -- "Sewer Grate"
evt.map[32] = function()
	if not evt.Cmp("MapVar7", 4) then
		evt.Add("MapVar7", 1)
		evt.Add("Inventory", 165)         -- "Magic Potion"
	end
end

evt.hint[33] = evt.str[5]  -- "Sewer Grate"
evt.map[33] = function()
	if not evt.Cmp("MapVar8", 4) then
		evt.Add("MapVar8", 1)
		evt.Add("Inventory", 166)         -- "Energy"
	end
end

evt.map[34] = function()  -- Timer(<function>, 5*const.Minute)
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = -4864, FromY = 3904, FromZ = 200, ToX = -4000, ToY = 3904, ToZ = 200}         -- "Toxic Cloud"
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = -1280, FromY = 1152, FromZ = 142, ToX = -1280, ToY = 3000, ToZ = 142}         -- "Toxic Cloud"
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = 2688, FromY = 5760, FromZ = 142, ToX = 2000, ToY = 5760, ToZ = 142}         -- "Toxic Cloud"
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = 2624, FromY = 1216, FromZ = 142, ToX = -2304, ToY = 6016, ToZ = 142}         -- "Toxic Cloud"
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = 1536, FromY = 6144, FromZ = 142, ToX = 1536, ToY = 4000, ToZ = 142}         -- "Toxic Cloud"
	evt.CastSpell{Spell = 90, Mastery = const.Novice, Skill = 6, FromX = 384, FromY = 3328, FromZ = 1700, ToX = 384, ToY = 3328, ToZ = 0}         -- "Toxic Cloud"
end

Timer(evt.map[34].last, 5*const.Minute)

evt.hint[35] = evt.str[18]  -- "Strange Light"
evt.map[35] = function()
	evt.MoveToMap{X = -13385, Y = 12025, Z = 97, Direction = 504, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutB2.Odm"}
end

evt.hint[36] = evt.str[20]  -- "Caged Prisoner"
evt.map[36] = function()
	if not evt.Cmp("QBits", 494) then         -- Tamara Once
		evt.StatusText(21)         -- "What took you so long?"
		evt.ForPlayer("All")
		evt.Subtract("QBits", 82)         -- "Find Tamara"
		evt.Set("Awards", 2)         -- "Resued Tamara"
		evt.Add("Experience", 20000)
		evt.Add("Gold", 5000)
		evt.StatusText(21)         -- "What took you so long?"
		evt.Set("NPCs", 8)         -- "Tamara"
		evt.Set("QBits", 494)         -- Tamara Once
	end
end

