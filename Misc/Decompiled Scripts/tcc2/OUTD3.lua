local TXT = Localize{
	[0] = " ",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "Stone of Revelation",
	[6] = "You cannot read the inscription.",
	[7] = "Revelation Msg#3.  Once inside, follow the Path of Lights.",
	[8] = "Autonote added.",
	[9] = "",
	[10] = "",
	[11] = "",
	[12] = "",
	[13] = "Well, thanks for sneaking me out of the Castle.  Sorry about the circus thing—I hope I wasn’t too much trouble to find.  I’ll go in myself so no one will see that it was you who kidnapped me.  Thanks again, and goodbye.  I’ll remember this, and I owe you a favor! ",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 511) then         -- SOG Void Teleport
		if evt.Cmp("QBits", 330) then         -- NPC
			return
		end
	end
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

evt.hint[10] = evt.str[5]  -- "Stone of Revelation"
evt.map[10] = function()
	if evt.Cmp("QBits", 505) then         -- Stone of Translation
		evt.Add("QBits", 494)         -- Tamara Once
		evt.SetMessage(7)         -- "Revelation Msg#3.  Once inside, follow the Path of Lights."
		evt.SimpleMessage()
		evt.Add("AutonotesBits", 81)         -- "Revelation Msg#3.  Once inside, follow the Path of Lights."
		evt.StatusText(8)         -- "Autonote added."
	else
		evt.StatusText(6)         -- "You cannot read the inscription."
	end
end

