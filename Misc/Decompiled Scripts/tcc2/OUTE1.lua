local TXT = Localize{
	[0] = " ",
	[1] = "Visit my four sisters and return to me.  Then I will activate the Exit to Creation's Land.",
	[2] = "Andrea",
	[3] = "Juniper",
	[4] = "Xavaria",
	[5] = "Cumin",
	[6] = "Neroli",
	[7] = "Void Msg #1.  You must first find the Rock of Translation.",
	[8] = "Void Msg #2.  It is in the middle of the  Black Diamond of Ash.",
	[9] = "Void Msg#3.  The  Black  Diamond of Ash lies in The Unchartered Seas.",
	[10] = "Void Msg #4.  Once you touch the Rock of Translation  you will then begin to understand. ",
	[11] = "Well done.  You may now use the Exit Fount.",
	[12] = "Exit to Creation's Land",
	[13] = "Autonote added.",
	[14] = "Creation's Fount",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		evt.ForPlayer("All")
		evt.Set("Eradicated", 0)
	else
		evt.ForPlayer("All")
		evt.Set("Awards", 1)         -- "Entered The VOID"
		evt.Set("Food", 0)
		evt.Set("QBits", 82)         -- "Find and destroy the Chalice of the Gods"
		evt.Set("Gold", 0)
		evt.Set("QBits", 330)         -- NPC
		evt.MoveToMap{X = 277, Y = -52, Z = 3000, Direction = 984, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "0"}
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[2]  -- "Andrea"
evt.map[2] = function()
	evt.Set("QBits", 509)         -- Void Fountain1
	evt.SetMessage(7)         -- "Void Msg #1.  You must first find the Rock of Translation."
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 54)         -- "Void Msg #1.  You must first find the Rock of Translation."
	evt.StatusText(13)         -- "Autonote added."
end

evt.hint[3] = evt.str[3]  -- "Juniper"
evt.map[3] = function()
	evt.Set("QBits", 508)         -- Void Fountain2
	evt.SetMessage(8)         -- "Void Msg #2.  It is in the middle of the  Black Diamond of Ash."
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 55)         -- "Void Msg #2.  It is in the middle of the  Black Diamond of Ash."
	evt.StatusText(13)         -- "Autonote added."
end

evt.hint[4] = evt.str[4]  -- "Xavaria"
evt.map[4] = function()
	evt.SetMessage(9)         -- "Void Msg#3.  The  Black  Diamond of Ash lies in The Unchartered Seas."
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 56)         -- "Void Msg#3.  The  Black  Diamond of Ash lies in The Unchartered Seas."
	evt.Set("QBits", 507)         -- Void Fountain3
	evt.StatusText(13)         -- "Autonote added."
end

evt.hint[5] = evt.str[5]  -- "Cumin"
evt.map[5] = function()
	evt.Set("QBits", 506)         -- Void Fountain4
	evt.SetMessage(10)         -- "Void Msg #4.  Once you touch the Rock of Translation  you will then begin to understand. "
	evt.SimpleMessage()
	evt.Set("AutonotesBits", 57)         -- "Void Msg #4.  Once you touch the Rock of Translation  you will then begin to understand. "
	evt.StatusText(13)         -- "Autonote added."
end

evt.hint[6] = evt.str[6]  -- "Neroli"
evt.map[6] = function()
	if evt.Cmp("QBits", 506) then         -- Void Fountain4
		if evt.Cmp("QBits", 507) then         -- Void Fountain3
			if evt.Cmp("QBits", 508) then         -- Void Fountain2
				if evt.Cmp("QBits", 509) then         -- Void Fountain1
					evt.SetMessage(11)         -- "Well done.  You may now use the Exit Fount."
					evt.SimpleMessage()
					evt.Set("QBits", 510)         -- SOG Teleport Authorization
					return
				end
			end
		end
	end
	evt.SetMessage(1)         -- "Visit my four sisters and return to me.  Then I will activate the Exit to Creation's Land."
	evt.SimpleMessage()
end

evt.hint[100] = evt.str[12]  -- "Exit to Creation's Land"
evt.map[100] = function()
	if evt.Cmp("QBits", 510) then         -- SOG Teleport Authorization
		evt.Set("QBits", 511)         -- SOG Void Teleport
		evt.MoveToMap{X = 3669, Y = 16904, Z = 96, Direction = 2040, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Oute3.odm"}
	end
end

