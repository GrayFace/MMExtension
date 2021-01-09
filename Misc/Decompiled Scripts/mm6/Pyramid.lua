local TXT = Localize{
	[0] = " ",
	[1] = "Warning!  Sensor array controls are strictly off limits to unauthorized personnel!  Use of the Sign of Sight is restricted to communications technicians only!  A mild electric shock will be transmitted to violators.",
	[2] = "Warning!  Cargo lift controls are strictly off limits to unauthorized personnel!  Use of the Sign of the Scarab is restricted to supply officers only!  A mild electric shock will be transmitted to violators.",
	[3] = "Trap!",
	[4] = "Radiation Damage!",
	[5] = "Plaque",
	[6] = "The entrance to the central pyramid lies to the South.",
	[7] = "The door is locked",
	[8] = "CleansingPool",
	[9] = "Flame Door",
	[10] = "Radiation Damage!",
	[11] = "The chest is locked",
	[12] = "Door won't budge.",
	[13] = "Radiation Damage!",
	[14] = "Radiation Damage!",
	[15] = "The waters part.",
	[16] = "Warning!  Power Fluctuations!  Alert Engineering immediately!",
	[17] = "In case of energy leak, bathe in one of the medicated pools placed for your safety and convenience.",
	[18] = "Crystal Skull absorbs radiation damage.",
	[19] = "Door",
	[20] = "Only the one bearing the key may speak the code.",
	[21] = "Well of VARN",
	[22] = "Picture Door",
	[23] = "Back Door",
	[24] = "Switch",
	[25] = "Water Temple",
	[26] = "Cleansing Pool",
	[27] = "The Well of VARN must be keyed last.",
	[28] = "Control Room Entry",
	[29] = "Chest",
	[30] = "Picture",
	[31] = "Exit",
	[32] = "What is the first mate's code?",
	[33] = "kcopS",
	[34] = "What is the navigator's code?",
	[35] = "uluS",
	[36] = "What is the communication officer's code?",
	[37] = "aruhU",
	[38] = "What is the engineer's code?",
	[39] = "yttocS",
	[40] = "What is the doctor's code?",
	[41] = "yoccM",
	[42] = "What is the Captain's code?",
	[43] = "kriK",
	[44] = "Answer?  ",
	[45] = "Incorrect.",
	[46] = "Access Denied.  All codes must be entered first.",
	[47] = "Main Power failed.  Emergency power on.",
	[48] = "Main Power restored.",
	[49] = "Books",
	[50] = "Tomb of Varn",
	[51] = "Bookcase",
	[52] = "Tapestry",
	[53] = "With painstaking care, you are able to decipher the message of the hieroglyphs:                                                                                                                                                     Though the Crossing of the Void be a long and arduous journey, the land you find at the end will be sweet and unspoiled by ancestors or the Enemy.  Take heart that your children's children will live in a perfect world free of war, free of famine, and free of fear.  Remember your sacred duty to care for the Ship on her long Voyage and ensure her safe arrival in the Promised Land.  Tend well the Guardian and house it securely away from the ship lest both be lost in a single misfortune.",
	[54] = "With painstaking care, you are able to decipher the message of the hieroglyphs, intermixed with diagrams of devils:                                                                                          Remember our Enemy, children, and never underestimate the danger they pose.  Though you will never see one during your journey, you must be forever vigilant against invasion from the Void once the Voyage has ended.  Mighty beyond words, the Enemy is nonetheless vulnerable after a Crossing, for their numbers are small and their defenses weak.  Use the energy weapons carried on the Ship to defeat them, and never, ever engage the Enemy with lesser weapons, or you will surely perish.",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[50]  -- "Tomb of Varn"

evt.hint[1] = evt.str[21]  -- "Well of VARN"
evt.map[1] = function()
	evt.Set("MapVar0", 0)
	if evt.Cmp("Inventory", 537) then         -- "Captain's Code"
		if not evt.Cmp("MapVar27", 1) then
			evt.StatusText(46)         -- "Access Denied.  All codes must be entered first."
			evt.Subtract("HP", 25)
			evt.FaceExpression{Player = "Current", Frame = 35}
		else
			evt.SetMessage(42)         -- "What is the Captain's code?"
			if evt.Question{Question = 44, Answer1 = 43, Answer2 = 43} then         -- "Answer?  " ("kriK")
				evt.Set("MapVar15", 1)
				evt.Subtract("Inventory", 537)         -- "Captain's Code"
				evt.Subtract("QBits", 231)         -- Quest item bits for seer
				evt.SetDoorState{Id = 1, State = 1}
				evt.StatusText(15)         -- "The waters part."
			else
				evt.StatusText(45)         -- "Incorrect."
				evt.FaceExpression{Player = "Current", Frame = 44}
				evt.Subtract("HP", 5)
			end
		end
	end
end

evt.hint[2] = evt.str[22]  -- "Picture Door"
evt.map[2] = function()
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[23]  -- "Back Door"
evt.map[3] = function()
	if not evt.Cmp("Inventory", 575) then         -- "Back Door Key"
		evt.StatusText(7)         -- "The door is locked"
	elseif evt.Cmp("CurrentMight", 35) then
		evt.Subtract("Inventory", 575)         -- "Back Door Key"
		evt.SetDoorState{Id = 3, State = 1}
	else
		evt.StatusText(12)         -- "Door won't budge."
	end
end

evt.hint[4] = evt.str[22]  -- "Picture Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
end

evt.hint[5] = evt.str[19]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[22]  -- "Picture Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[22]  -- "Picture Door"
evt.map[7] = function()
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[8] = evt.str[24]  -- "Switch"
evt.map[8] = function()
	evt.SetDoorState{Id = 8, State = 2}         -- switch state
	evt.StatusText(3)         -- "Trap!"
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Fire, Damage = 200}
end

evt.hint[9] = evt.str[24]  -- "Switch"
evt.map[9] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
	evt.StatusText(3)         -- "Trap!"
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Magic, Damage = 200}
end

evt.hint[10] = evt.str[22]  -- "Picture Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[11] = evt.str[25]  -- "Water Temple"
evt.map[11] = function()
	if evt.Cmp("Inventory", 573) then         -- "Water Temple Key"
		evt.Subtract("Inventory", 573)         -- "Water Temple Key"
		evt.SetDoorState{Id = 11, State = 1}
	else
		evt.StatusText(7)         -- "The door is locked"
	end
end

evt.map[12] = function()  -- Timer(<function>, 1.5*const.Minute)
	local i
	if evt.Cmp("MapVar0", 1) then
		evt.ForPlayer("Random")
		if evt.Cmp("Inventory", 466) then         -- "Crystal Skull"
			evt.StatusText(18)         -- "Crystal Skull absorbs radiation damage."
		else
			i = Game.Rand() % 6
			if i == 1 then
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Cold, Damage = 5}
				evt.StatusText(4)         -- "Radiation Damage!"
			elseif i == 2 then
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 5}
				evt.StatusText(10)         -- "Radiation Damage!"
			elseif i == 3 then
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Elec, Damage = 5}
				evt.StatusText(13)         -- "Radiation Damage!"
			elseif i == 4 then
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Magic, Damage = 5}
				evt.StatusText(14)         -- "Radiation Damage!"
			elseif i == 5 then
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Phys, Damage = 5}
				evt.StatusText(13)         -- "Radiation Damage!"
			else
				evt.DamagePlayer{Player = "All", DamageType = const.Damage.Poison, Damage = 5}
				evt.StatusText(10)         -- "Radiation Damage!"
			end
		end
	end
end

Timer(evt.map[12].last, 1.5*const.Minute)

evt.hint[13] = evt.str[26]  -- "Cleansing Pool"
evt.map[13] = function()
	evt.Set("MapVar0", 0)
end

evt.map[14] = function()  -- Timer(<function>, 2*const.Minute)
	if evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 0)
		if evt.Cmp("MapVar3", 1) then
			evt.Add("MapVar3", 1)
			evt.StatusText(48)         -- "Main Power restored."
		end
		evt.SetLight{Id = 35, On = true}
		evt.SetLight{Id = 43, On = true}
		evt.SetLight{Id = 34, On = true}
		evt.SetLight{Id = 36, On = true}
		evt.SetLight{Id = 37, On = true}
		evt.SetLight{Id = 33, On = true}
		evt.SetLight{Id = 42, On = false}
		evt.SetLight{Id = 41, On = false}
		evt.SetLight{Id = 38, On = false}
		evt.SetLight{Id = 40, On = false}
		evt.SetLight{Id = 39, On = false}
		if evt.Cmp("MapVar3", 3) then
			evt.Set("MapVar3", 0)
		end
		return
	end
	evt.Set("MapVar2", 1)
	if evt.Cmp("MapVar3", 1) then
		evt.StatusText(47)         -- "Main Power failed.  Emergency power on."
	end
	evt.SetLight{Id = 35, On = false}
	evt.SetLight{Id = 43, On = false}
	evt.SetLight{Id = 34, On = false}
	evt.SetLight{Id = 36, On = false}
	evt.SetLight{Id = 37, On = false}
	evt.SetLight{Id = 33, On = false}
	evt.SetLight{Id = 42, On = true}
	evt.SetLight{Id = 41, On = true}
	evt.SetLight{Id = 38, On = true}
	evt.SetLight{Id = 40, On = true}
	evt.SetLight{Id = 39, On = true}
end

Timer(evt.map[14].last, 2*const.Minute)

evt.map[15] = function()
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[22]  -- "Picture Door"
evt.map[16] = function()
	if evt.Cmp("CurrentMight", 25) then
		evt.SetDoorState{Id = 16, State = 1}
	else
		evt.StatusText(12)         -- "Door won't budge."
	end
end

evt.hint[17] = evt.str[31]  -- "Exit"
evt.map[17] = function()
	evt.MoveToMap{X = -6647, Y = 13018, Z = 1761, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB3.Odm"}
end

evt.hint[18] = evt.str[31]  -- "Exit"
evt.map[18] = function()
	evt.MoveToMap{X = -6611, Y = 11408, Z = 480, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutB3.Odm"}
end

evt.hint[19] = evt.str[30]  -- "Picture"
evt.map[20] = function()
	evt.SetDoorState{Id = 16, State = 0}
end

evt.hint[21] = evt.str[26]  -- "Cleansing Pool"
evt.map[21] = function()
	evt.Set("MapVar0", 0)
	if not evt.Cmp("Inventory", 538) then         -- "First Mate's Code"
		return
	end
	evt.SetMessage(32)         -- "What is the first mate's code?"
	if not evt.Question{Question = 44, Answer1 = 33, Answer2 = 33} then         -- "Answer?  " ("kcopS")
		evt.StatusText(45)         -- "Incorrect."
		evt.FaceExpression{Player = "Current", Frame = 48}
		evt.Subtract("HP", 5)
		return
	end
	if evt.Cmp("MapVar11", 1) then
		if evt.Cmp("MapVar12", 1) then
			if evt.Cmp("MapVar13", 1) then
				if evt.Cmp("MapVar14", 1) then
					evt.Set("MapVar27", 1)
				end
			end
		end
	end
	evt.Set("MapVar10", 1)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 538)         -- "First Mate's Code"
	evt.Subtract("QBits", 229)         -- Quest item bits for seer
end

evt.hint[22] = evt.str[26]  -- "Cleansing Pool"
evt.map[22] = function()
	evt.Set("MapVar0", 0)
	if not evt.Cmp("Inventory", 539) then         -- "Navigator's Code"
		return
	end
	evt.SetMessage(34)         -- "What is the navigator's code?"
	if not evt.Question{Question = 44, Answer1 = 35, Answer2 = 35} then         -- "Answer?  " ("uluS")
		evt.StatusText(45)         -- "Incorrect."
		evt.FaceExpression{Player = "Current", Frame = 33}
		evt.Subtract("HP", 5)
		return
	end
	if evt.Cmp("MapVar10", 1) then
		if evt.Cmp("MapVar12", 1) then
			if evt.Cmp("MapVar13", 1) then
				if evt.Cmp("MapVar14", 1) then
					evt.Set("MapVar27", 1)
				end
			end
		end
	end
	evt.Set("MapVar11", 1)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 539)         -- "Navigator's Code"
	evt.Subtract("QBits", 232)         -- Quest item bits for seer
end

evt.hint[23] = evt.str[26]  -- "Cleansing Pool"
evt.map[23] = function()
	evt.Set("MapVar0", 0)
	if not evt.Cmp("Inventory", 540) then         -- "Communication Officer's Code"
		return
	end
	evt.SetMessage(36)         -- "What is the communication officer's code?"
	if not evt.Question{Question = 44, Answer1 = 37, Answer2 = 37} then         -- "Answer?  " ("aruhU")
		evt.StatusText(45)         -- "Incorrect."
		evt.FaceExpression{Player = "Current", Frame = 50}
		evt.Subtract("HP", 5)
		return
	end
	if evt.Cmp("MapVar11", 1) then
		if evt.Cmp("MapVar10", 1) then
			if evt.Cmp("MapVar13", 1) then
				if evt.Cmp("MapVar14", 1) then
					evt.Set("MapVar27", 1)
				end
			end
		end
	end
	evt.Set("MapVar12", 1)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 540)         -- "Communication Officer's Code"
	evt.Subtract("QBits", 234)         -- Quest item bits for seer
end

evt.hint[24] = evt.str[26]  -- "Cleansing Pool"
evt.map[24] = function()
	evt.Set("MapVar0", 0)
	if not evt.Cmp("Inventory", 541) then         -- "Engineer's Code"
		return
	end
	evt.SetMessage(38)         -- "What is the engineer's code?"
	if not evt.Question{Question = 44, Answer1 = 39, Answer2 = 39} then         -- "Answer?  " ("yttocS")
		evt.StatusText(45)         -- "Incorrect."
		evt.FaceExpression{Player = "Current", Frame = 46}
		evt.Subtract("HP", 5)
		return
	end
	if evt.Cmp("MapVar11", 1) then
		if evt.Cmp("MapVar12", 1) then
			if evt.Cmp("MapVar10", 1) then
				if evt.Cmp("MapVar14", 1) then
					evt.Set("MapVar27", 1)
				end
			end
		end
	end
	evt.Set("MapVar13", 1)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 541)         -- "Engineer's Code"
	evt.Subtract("QBits", 233)         -- Quest item bits for seer
end

evt.hint[25] = evt.str[26]  -- "Cleansing Pool"
evt.map[25] = function()
	evt.Set("MapVar0", 0)
	if not evt.Cmp("Inventory", 542) then         -- "Doctor's Code"
		return
	end
	evt.SetMessage(40)         -- "What is the doctor's code?"
	if not evt.Question{Question = 44, Answer1 = 41, Answer2 = 41} then         -- "Answer?  " ("yoccM")
		evt.StatusText(45)         -- "Incorrect."
		evt.FaceExpression{Player = "Current", Frame = 13}
		evt.Subtract("HP", 5)
		return
	end
	if evt.Cmp("MapVar11", 1) then
		if evt.Cmp("MapVar12", 1) then
			if evt.Cmp("MapVar13", 1) then
				if evt.Cmp("MapVar10", 1) then
					evt.Set("MapVar27", 1)
				end
			end
		end
	end
	evt.Set("MapVar14", 1)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 542)         -- "Doctor's Code"
	evt.Subtract("QBits", 230)         -- Quest item bits for seer
end

evt.hint[26] = evt.str[49]  -- "Books"
evt.map[26] = function()
	if not evt.Cmp("MapVar25", 1) then
		evt.Set("QBits", 234)         -- Quest item bits for seer
		evt.Add("Inventory", 540)         -- "Communication Officer's Code"
		evt.Set("MapVar25", 1)
	end
end

evt.hint[27] = evt.str[49]  -- "Books"
evt.map[27] = function()
	if not evt.Cmp("MapVar26", 1) then
		evt.Set("QBits", 233)         -- Quest item bits for seer
		evt.Add("Inventory", 541)         -- "Engineer's Code"
		evt.Set("MapVar26", 1)
	end
end

evt.map[28] = function()
	evt.Set("MapVar3", 1)
end

evt.hint[29] = evt.str[24]  -- "Switch"
evt.map[29] = function()
	evt.SetDoorState{Id = 38, State = 1}
	evt.SetDoorState{Id = 37, State = 1}
end

evt.hint[30] = evt.str[22]  -- "Picture Door"
evt.map[30] = function()
	if evt.Cmp("CurrentMight", 20) then
		evt.SetDoorState{Id = 35, State = 1}
		evt.SetDoorState{Id = 36, State = 1}
	else
		evt.StatusText(12)         -- "Door won't budge."
	end
end

evt.hint[31] = evt.str[9]  -- "Flame Door"
evt.map[31] = function()
	if not evt.Cmp("Inventory", 574) then         -- "Flame Door Key"
		evt.StatusText(7)         -- "The door is locked"
	elseif evt.Cmp("CurrentMight", 25) then
		evt.Subtract("Inventory", 574)         -- "Flame Door Key"
		evt.SetDoorState{Id = 32, State = 1}
		evt.SetDoorState{Id = 31, State = 1}
	else
		evt.StatusText(12)         -- "Door won't budge."
	end
end

evt.hint[32] = evt.str[24]  -- "Switch"
evt.map[32] = function()
	evt.SetDoorState{Id = 33, State = 2}         -- switch state
	evt.SetDoorState{Id = 34, State = 2}         -- switch state
end

evt.map[33] = function()
	evt.MoveToMap{X = -9344, Y = -192, Z = 8034, Direction = 1, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	evt.SetDoorState{Id = 33, State = 0}
end

evt.hint[35] = evt.str[28]  -- "Control Room Entry"
evt.map[35] = function()
	if evt.Cmp("MapVar15", 1) then
		evt.SetDoorState{Id = 39, State = 1}
		evt.SetDoorState{Id = 40, State = 1}
	end
end

evt.hint[41] = evt.str[29]  -- "Chest"
evt.map[41] = function()
	if not evt.Cmp("MapVar28", 1) then
		if evt.Cmp("QBits", 42) then         -- Bruce
			evt.OpenChest(6)
			return
		end
		if not evt.Cmp("Inventory", 577) then         -- "VARN Chest Key"
			evt.StatusText(11)         -- "The chest is locked"
			return
		end
		evt.Subtract("Inventory", 577)         -- "VARN Chest Key"
		evt.Set("MapVar28", 1)
	end
	evt.OpenChest(1)
	evt.Set("QBits", 42)         -- Bruce
	evt.Set("QBits", 195)         -- Quest item bits for seer
end

evt.hint[42] = evt.str[29]  -- "Chest"
evt.map[42] = function()
	evt.OpenChest(2)
	evt.Set("QBits", 229)         -- Quest item bits for seer
end

evt.hint[43] = evt.str[29]  -- "Chest"
evt.map[43] = function()
	if not evt.Cmp("MapVar49", 1) then
		if not evt.Cmp("Inventory", 576) then         -- "Bibliotheca Chest Key"
			evt.StatusText(11)         -- "The chest is locked"
			return
		end
		evt.Subtract("Inventory", 576)         -- "Bibliotheca Chest Key"
		evt.Set("MapVar49", 1)
	end
	evt.OpenChest(3)
	evt.Set("QBits", 230)         -- Quest item bits for seer
end

evt.hint[44] = evt.str[29]  -- "Chest"
evt.map[44] = function()
	evt.OpenChest(4)
	evt.Set("QBits", 231)         -- Quest item bits for seer
end

evt.hint[45] = evt.str[29]  -- "Chest"
evt.map[45] = function()
	evt.OpenChest(5)
	evt.Set("QBits", 232)         -- Quest item bits for seer
end

evt.hint[46] = evt.str[5]  -- "Plaque"
evt.map[46] = function()
	evt.SetMessage(1)         -- "Warning!  Sensor array controls are strictly off limits to unauthorized personnel!  Use of the Sign of Sight is restricted to communications technicians only!  A mild electric shock will be transmitted to violators."
	evt.SimpleMessage()
end

evt.hint[47] = evt.str[5]  -- "Plaque"
evt.map[47] = function()
	evt.SetMessage(2)         -- "Warning!  Cargo lift controls are strictly off limits to unauthorized personnel!  Use of the Sign of the Scarab is restricted to supply officers only!  A mild electric shock will be transmitted to violators."
	evt.SimpleMessage()
end

evt.hint[48] = evt.str[5]  -- "Plaque"
evt.map[48] = function()
	evt.SetMessage(6)         -- "The entrance to the central pyramid lies to the South."
	evt.SimpleMessage()
end

evt.hint[49] = evt.str[29]  -- "Chest"
evt.map[49] = function()
	evt.OpenChest(6)
end

evt.map[51] = function()
	evt.Set("MapVar0", 1)
end

evt.hint[52] = evt.str[5]  -- "Plaque"
evt.map[52] = function()
	evt.SetMessage(20)         -- "Only the one bearing the key may speak the code."
	evt.SimpleMessage()
end

evt.hint[53] = evt.str[5]  -- "Plaque"
evt.map[53] = function()
	evt.SetMessage(27)         -- "The Well of VARN must be keyed last."
	evt.SimpleMessage()
end

evt.hint[54] = evt.str[5]  -- "Plaque"
evt.map[54] = function()
	evt.SetMessage(16)         -- "Warning!  Power Fluctuations!  Alert Engineering immediately!"
	evt.SimpleMessage()
end

evt.hint[55] = evt.str[5]  -- "Plaque"
evt.map[55] = function()
	evt.SetMessage(17)         -- "In case of energy leak, bathe in one of the medicated pools placed for your safety and convenience."
	evt.SimpleMessage()
end

evt.map[56] = function()  -- RefillTimer(<function>, const.Week)
	evt.Set("MapVar0", 0)
end

RefillTimer(evt.map[56].last, const.Week)

evt.map[57] = function()
	evt.Set("MapVar3", 0)
end

evt.hint[60] = evt.str[51]  -- "Bookcase"
evt.map[60] = function()
	if not evt.Cmp("MapVar29", 1) then
		evt.Set("MapVar29", 1)
		evt.Add("Inventory", 308)         -- "Meteor Shower"
	end
end

evt.hint[61] = evt.str[51]  -- "Bookcase"
evt.map[61] = function()
	if not evt.Cmp("MapVar30", 1) then
		evt.Set("MapVar30", 1)
		evt.Add("Inventory", 309)         -- "Inferno"
	end
end

evt.hint[62] = evt.str[51]  -- "Bookcase"
evt.map[62] = function()
	if not evt.Cmp("MapVar31", 1) then
		evt.Set("MapVar31", 1)
		evt.Add("Inventory", 310)         -- "Incinerate"
	end
end

evt.hint[63] = evt.str[51]  -- "Bookcase"
evt.map[63] = function()
	if not evt.Cmp("MapVar32", 1) then
		evt.Set("MapVar32", 1)
		evt.Add("Inventory", 319)         -- "Implosion"
	end
end

evt.hint[64] = evt.str[51]  -- "Bookcase"
evt.map[64] = function()
	if not evt.Cmp("MapVar33", 1) then
		evt.Set("MapVar33", 1)
		evt.Add("Inventory", 320)         -- "Fly"
	end
end

evt.hint[65] = evt.str[51]  -- "Bookcase"
evt.map[65] = function()
	if not evt.Cmp("MapVar34", 1) then
		evt.Set("MapVar34", 1)
		evt.Add("Inventory", 321)         -- "Starburst"
	end
end

evt.hint[66] = evt.str[51]  -- "Bookcase"
evt.map[66] = function()
	if not evt.Cmp("MapVar35", 1) then
		evt.Set("MapVar35", 1)
		evt.Add("Inventory", 330)         -- "Town Portal"
	end
end

evt.hint[67] = evt.str[51]  -- "Bookcase"
evt.map[67] = function()
	if not evt.Cmp("MapVar36", 1) then
		evt.Set("MapVar36", 1)
		evt.Add("Inventory", 331)         -- "Ice Blast"
	end
end

evt.hint[68] = evt.str[51]  -- "Bookcase"
evt.map[68] = function()
	if not evt.Cmp("MapVar37", 1) then
		evt.Set("MapVar37", 1)
		evt.Add("Inventory", 332)         -- "Lloyd's Beacon"
	end
end

evt.hint[69] = evt.str[51]  -- "Bookcase"
evt.map[69] = function()
	if not evt.Cmp("MapVar38", 1) then
		evt.Set("MapVar38", 1)
		evt.Add("Inventory", 341)         -- "Turn to Stone"
	end
end

evt.hint[70] = evt.str[51]  -- "Bookcase"
evt.map[70] = function()
	if not evt.Cmp("MapVar39", 1) then
		evt.Set("MapVar39", 1)
		evt.Add("Inventory", 342)         -- "Death Blossom"
	end
end

evt.hint[71] = evt.str[51]  -- "Bookcase"
evt.map[71] = function()
	if not evt.Cmp("MapVar40", 1) then
		evt.Set("MapVar40", 1)
		evt.Add("Inventory", 343)         -- "Mass Distortion"
	end
end

evt.hint[72] = evt.str[52]  -- "Tapestry"
evt.map[72] = function()
	evt.SetMessage(53)         -- "With painstaking care, you are able to decipher the message of the hieroglyphs:                                                                                                                                                     Though the Crossing of the Void be a long and arduous journey, the land you find at the end will be sweet and unspoiled by ancestors or the Enemy.  Take heart that your children's children will live in a perfect world free of war, free of famine, and free of fear.  Remember your sacred duty to care for the Ship on her long Voyage and ensure her safe arrival in the Promised Land.  Tend well the Guardian and house it securely away from the ship lest both be lost in a single misfortune."
	evt.SimpleMessage()
end

evt.hint[73] = evt.str[52]  -- "Tapestry"
evt.map[73] = function()
	evt.SetMessage(54)         -- "With painstaking care, you are able to decipher the message of the hieroglyphs, intermixed with diagrams of devils:                                                                                          Remember our Enemy, children, and never underestimate the danger they pose.  Though you will never see one during your journey, you must be forever vigilant against invasion from the Void once the Voyage has ended.  Mighty beyond words, the Enemy is nonetheless vulnerable after a Crossing, for their numbers are small and their defenses weak.  Use the energy weapons carried on the Ship to defeat them, and never, ever engage the Enemy with lesser weapons, or you will surely perish."
	evt.SimpleMessage()
end

