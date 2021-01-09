local TXT = Localize{
	[0] = " ",
	[1] = "Pedestal Msg#1.  The Chalice of Gods dwells high upon the Mountain of Ash.",
	[2] = "Pedestal Msg#2.  The Mountain of Ash lies in the sea in the Land that Time Forgot.",
	[3] = "Pedestal Msg#3.  To reach this land, you must use the Flashing Tunnel inside the pyramid.",
	[4] = "Pedestal Msg#4.  The Chalice of Gods can only be destroyed by casting it into the Sacred Fire  that dwells within the pyramid.",
	[5] = "Assur",
	[6] = "Chest",
	[7] = "Pedestal Msg#5.  The Sacred Fire will not appear until the Chalice enters the Pyramid.",
	[8] = "Baal's Garden",
	[9] = "The entrance is sealed.",
	[10] = "Pedestal",
	[11] = "Autonote added.",
	[12] = "Super Fig Tree",
	[13] = "There are no more figs on the tree.",
	[14] = "\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
!!!!!!!!\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
",
	[15] = "Resurrection Pedestal",
	[16] = "Raise Dead Pedestal",
	[17] = "rock",
	[18] = "You cannot enter at this time",
	[19] = "Nothing happens.",
	[20] = "Whom the gods bless, they first curse!",
	[21] = "Abrakadabra",
	[22] = "What is the 1st word of the incantation?",
	[23] = "Wrong, Moose Brains!",
	[24] = "What is the 2nd word of the incantation?",
	[25] = "What is the 3rd word of the incantation?",
	[26] = "What is the 4th word of the incantation?",
	[27] = "What is the 5th word of the incantation?",
	[28] = "What is the 6th word of the incantation?",
	[29] = "What is the last word of the incantation?",
	[30] = "Wam",
	[31] = "Allakhazam",
	[32] = "Bam",
	[33] = "Mam",
	[34] = "Thank",
	[35] = "you",
	[36] = "Correct!",
	[37] = "Correct!  You may now open the chest!",
	[38] = "The Danu Tree",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

-- ERROR: evt.house[90] not assigned for hint, because Hint command is missing
-- ERROR: Duplicate label: 100:2
-- ERROR: Duplicate label: 100:3
-- ERROR: Duplicate label: 100:4
-- ERROR: Duplicate label: 100:5

evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 532) then         -- "Chalice of Gods"
				evt.Add("QBits", 485)         -- LG 2nd Jorgsburg
				evt.MoveToMap{X = 9049, Y = -18370, Z = 224, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC3.Odm"}
			end
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

Timer(function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 532) then         -- "Chalice of Gods"
		evt.Add("QBits", 485)         -- LG 2nd Jorgsburg
		evt.MoveToMap{X = 9049, Y = -18370, Z = 224, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "OutC3.Odm"}
	end
end, 0.5*const.Minute)

evt.house[2] = 82  -- "Assur"
evt.map[2] = function()
	evt.EnterHouse(82)         -- "Assur"
end

evt.hint[4] = evt.str[10]  -- "Pedestal"
evt.map[4] = function()
	evt.SetMessage(1)         -- "Pedestal Msg#1.  The Chalice of Gods dwells high upon the Mountain of Ash."
	evt.SimpleMessage()
	evt.Add("AutonotesBits", 108)         -- "Pedestal Msg#1.  The Sacred Challice dwells within the Mountain of Ash."
	evt.StatusText(11)         -- "Autonote added."
end

evt.hint[5] = evt.str[10]  -- "Pedestal"
evt.map[5] = function()
	evt.SetMessage(2)         -- "Pedestal Msg#2.  The Mountain of Ash lies in the sea in the Land that Time Forgot."
	evt.SimpleMessage()
	evt.Add("AutonotesBits", 109)         -- "Pedestal Msg#2.  The Mountain of Ash lies in the sea in the Land that Time Forgot."
	evt.StatusText(11)         -- "Autonote added."
end

evt.hint[6] = evt.str[10]  -- "Pedestal"
evt.map[6] = function()
	evt.SetMessage(3)         -- "Pedestal Msg#3.  To reach this land, you must use the Flashing Tunnel inside the pyramid."
	evt.SimpleMessage()
	evt.Add("AutonotesBits", 110)         -- "Pedestal Msg#3.  To reach this land, you must use the Flashing Tunnel inside the pyramid."
	evt.StatusText(11)         -- "Autonote added."
end

evt.hint[7] = evt.str[10]  -- "Pedestal"
evt.map[7] = function()
	evt.SetMessage(4)         -- "Pedestal Msg#4.  The Chalice of Gods can only be destroyed by casting it into the Sacred Fire  that dwells within the pyramid."
	evt.SimpleMessage()
	evt.Add("AutonotesBits", 111)         -- "Pedestal Msg#4.  The Sacred Challice can only be destroyed by casting it into the Sacred Fire  that dwells within the pyramid."
	evt.StatusText(11)         -- "Autonote added."
end

evt.hint[8] = evt.str[10]  -- "Pedestal"
evt.map[8] = function()
	evt.SetMessage(7)         -- "Pedestal Msg#5.  The Sacred Fire will not appear until the Chalice enters the Pyramid."
	evt.SimpleMessage()
	evt.Add("AutonotesBits", 112)         -- "Pedestal Msg#5.  The Sacred Fire will not appear until the Chalice enters the Pyramid."
	evt.StatusText(11)         -- "Autonote added."
end

evt.hint[9] = evt.str[12]  -- "Super Fig Tree"
evt.map[9] = function()
	if evt.Cmp("MapVar15", 50) then
		evt.StatusText(13)         -- "There are no more figs on the tree."
	else
		evt.Add("MapVar15", 1)
		evt.Add("Food", 1)
	end
end

evt.map[90] = function()
	if evt.Cmp("Inventory", 533) then         -- "Pyramid Key"
		evt.MoveToMap{X = -8987, Y = -202, Z = 8034, Direction = 1017, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Hive.Blv"}
	else
		evt.StatusText(9)         -- "The entrance is sealed."
	end
end

evt.map[100] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 414) then         -- Quaddah onc
		evt.Add("QBits", 414)         -- Quaddah onc
		evt.ForPlayer("All")
		evt.Add("Experience", 2000000)
	end
end

events.LoadMap = evt.map[100].last

evt.hint[101] = evt.str[15]  -- "Resurrection Pedestal"
evt.map[101] = function()
	evt.ForPlayer("All")
	evt.Subtract("Eradicated", 0)
end

evt.hint[102] = evt.str[16]  -- "Raise Dead Pedestal"
evt.map[102] = function()
	evt.ForPlayer("All")
	evt.Subtract("Dead", 0)
end

