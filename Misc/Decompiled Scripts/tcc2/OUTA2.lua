local TXT = Localize{
	[0] = " ",
	[1] = "Strange Stone",
	[2] = "Stone Marker",
	[3] = "\
\
                         Warning!\
\
Passage to the Garden of Stones is forbidden!\
\
                Enter at your own risk.",
	[4] = "How dare you disturb our rest!!",
	[5] = "",
	[6] = "You must talk with all of the Squiggies first.",
	[7] = "You may now use the Tunnel to Desolation's End.",
	[8] = "Tree of Passage",
	[9] = "Autonote added.",
	[10] = "Healing Pedestal",
	[11] = "You have depleted the pedestal",
	[12] = "Aw shucks, I was just kiddin'.  Here's your  message.  Squiggie Msg#1.  To enter The Pyramid, you'll need the key.",
	[13] = "Heh Heh. I was just pullin' your leg.  Here's your  message.  Squiggie Msg#2.  The key is in the shape of a pyramid.",
	[14] = "Gotcha, huh? Here's your  message.  Squiggie Msg#3.  The key is guarded by the Matron Symlac.",
	[15] = "Bingo! I was just stringin' ya along.  Here's your  message.  Squiggie Msg#4.  The Matron Symlac rules Desolation's End.",
	[16] = "Funny, huh? I was just joshin' with ya.    Here's your  message.  Squiggie Msg#5.  You must now talk with the Tree of Passage to activate the Tunnel to Desolation's End.",
	[17] = "Stoned Pedestal",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[5]  -- ""
-- ERROR: Duplicate label: 18:4

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

evt.house[2] = 11  -- "Singing Steel"
evt.map[2] = function()
	evt.EnterHouse(11)         -- "Singing Steel"
end

evt.hint[3] = evt.str[10]  -- "Healing Pedestal"
evt.map[3] = function()
	if evt.Cmp("MapVar16", 5) then
		evt.StatusText(11)         -- "You have depleted the pedestal"
	else
		evt.Add("MapVar16", 1)
		evt.ForPlayer("All")
		evt.Set("HasFullHP", 0)
		evt.Set("HasFullSP", 0)
	end
end

evt.hint[4] = evt.str[17]  -- "Stoned Pedestal"
evt.map[4] = function()
	evt.ForPlayer("All")
	evt.Subtract("Stoned", 0)
end

evt.hint[10] = evt.str[1]  -- "Strange Stone"
evt.map[10] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20012, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18412, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = 17761, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = 16161, Z = 3009}
end

evt.hint[11] = evt.str[1]  -- "Strange Stone"
evt.map[11] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SetMessage(12)         -- "Aw shucks, I was just kiddin'.  Here's your  message.  Squiggie Msg#1.  To enter The Pyramid, you'll need the key."
	evt.SimpleMessage()
	evt.Add("QBits", 490)         -- Sutters Bay Tarvel Scroll Once
	evt.Add("AutonotesBits", 97)         -- "Squiggie Msg#1.  To enter The Pyramid, you'll need the key."
	evt.StatusText(9)         -- "Autonote added."
end

evt.hint[12] = evt.str[1]  -- "Strange Stone"
evt.map[12] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20012, Y = -17493, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18412, Y = -17493, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -18273, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -16673, Z = 3009}
end

evt.hint[13] = evt.str[1]  -- "Strange Stone"
evt.map[13] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20012, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18412, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -19297, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -17697, Z = 3009}
end

evt.hint[14] = evt.str[1]  -- "Strange Stone"
evt.map[14] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20012, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18412, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -19809, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19212, Y = -18209, Z = 3009}
end

evt.hint[15] = evt.str[1]  -- "Strange Stone"
evt.map[15] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SetMessage(13)         -- "Heh Heh. I was just pullin' your leg.  Here's your  message.  Squiggie Msg#2.  The key is in the shape of a pyramid."
	evt.SimpleMessage()
	evt.Add("QBits", 489)         -- Kat'an Travel Once
	evt.Add("AutonotesBits", 98)         -- "Squiggie Msg#2.  The key is in the shape of a pyramid."
	evt.StatusText(9)         -- "Autonote added."
end

evt.hint[16] = evt.str[1]  -- "Strange Stone"
evt.map[16] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20524, Y = -17473, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18924, Y = -17473, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19724, Y = -18273, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19724, Y = -16673, Z = 3009}
end

evt.hint[17] = evt.str[1]  -- "Strange Stone"
evt.map[17] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20524, Y = -17985, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18924, Y = -17985, Z = 2009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19724, Y = -17185, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19724, Y = -18785, Z = 3009}
end

evt.hint[18] = evt.str[1]  -- "Strange Stone"
evt.map[18] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20524, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -18924, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -19724, Y = -19297, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19724, Y = -17697, Z = 3009}
end

evt.hint[19] = evt.str[1]  -- "Strange Stone"
evt.map[19] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20524, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18924, Y = -19009, Z = 3009}
end

evt.hint[20] = evt.str[1]  -- "Strange Stone"
evt.map[20] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21036, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -19436, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -17761, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -16161, Z = 3009}
end

evt.hint[21] = evt.str[1]  -- "Strange Stone"
evt.map[21] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -21036, Y = -17473, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -18924, Y = -17473, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -20236, Y = -18273, Z = 0}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -20236, Y = -16673, Z = 0}
end

evt.hint[22] = evt.str[1]  -- "Strange Stone"
evt.map[22] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21036, Y = -17985, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18924, Y = -17985, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -17185, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -18785, Z = 3009}
end

evt.hint[23] = evt.str[1]  -- "Strange Stone"
evt.map[23] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21036, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -18924, Y = -18497, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -19297, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -17697, Z = 3009}
end

evt.hint[24] = evt.str[1]  -- "Strange Stone"
evt.map[24] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21036, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19436, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -19809, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20236, Y = -18209, Z = 3009}
end

evt.hint[25] = evt.str[1]  -- "Strange Stone"
evt.map[25] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -21548, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -19948, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -20748, Y = -17761, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -20748, Y = -16161, Z = 3009}
end

evt.hint[26] = evt.str[1]  -- "Strange Stone"
evt.map[26] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21548, Y = -17743, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19948, Y = -17743, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20748, Y = -16943, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20748, Y = -18543, Z = 3009}
end

evt.hint[27] = evt.str[1]  -- "Strange Stone"
evt.map[27] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SetMessage(14)         -- "Gotcha, huh? Here's your  message.  Squiggie Msg#3.  The key is guarded by the Matron Symlac."
	evt.SimpleMessage()
	evt.Add("QBits", 488)         -- Tamara Dialog
	evt.Add("AutonotesBits", 99)         -- "Squiggie Msg#3.  The key is guarded by the Matron Symlac."
	evt.StatusText(9)         -- "Autonote added."
end

evt.hint[28] = evt.str[1]  -- "Strange Stone"
evt.map[28] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SetMessage(15)         -- "Bingo! I was just stringin' ya along.  Here's your  message.  Squiggie Msg#4.  The Matron Symlac rules Desolation's End."
	evt.SimpleMessage()
	evt.Add("QBits", 487)         -- Demonclaw Reload
	evt.Add("AutonotesBits", 100)         -- "Squiggie Msg#4.  The Matron Symlac rules Desolation's End."
	evt.StatusText(9)         -- "Autonote added."
end

evt.hint[29] = evt.str[1]  -- "Strange Stone"
evt.map[29] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21548, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -19948, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20748, Y = -19809, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20748, Y = -18209, Z = 3009}
end

evt.hint[30] = evt.str[1]  -- "Strange Stone"
evt.map[30] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -22060, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -20460, Y = -16961, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -21260, Y = -17761, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 2, Count = 1, X = -21260, Y = -16161, Z = 3009}
end

evt.hint[31] = evt.str[1]  -- "Strange Stone"
evt.map[31] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -22060, Y = -17473, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20460, Y = -17473, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -18273, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -16673, Z = 3009}
end

evt.hint[32] = evt.str[1]  -- "Strange Stone"
evt.map[32] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -22060, Y = -17985, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20460, Y = -17985, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -18785, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -17185, Z = 3009}
end

evt.hint[33] = evt.str[1]  -- "Strange Stone"
evt.map[33] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SetMessage(16)         -- "Funny, huh? I was just joshin' with ya.    Here's your  message.  Squiggie Msg#5.  You must now talk with the Tree of Passage to activate the Tunnel to Desolation's End."
	evt.SimpleMessage()
	evt.Add("QBits", 486)         -- Birka Entrance after Bona Fide
	evt.Add("AutonotesBits", 101)         -- "Squiggie Msg#5.  You must now talk with the Tree of Passage to activate the Flashing Tunnel to Desolation's End."
	evt.StatusText(9)         -- "Autonote added."
end

evt.hint[34] = evt.str[1]  -- "Strange Stone"
evt.map[34] = function()
	evt.SetMessage(4)         -- "How dare you disturb our rest!!"
	evt.SimpleMessage()
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -22060, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -20460, Y = -19009, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -19809, Z = 3009}
	evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 1, Count = 1, X = -21260, Y = -18209, Z = 3009}
end

evt.map[100] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 410) then         -- Quaddah onc
		evt.Add("QBits", 410)         -- Quaddah onc
		evt.ForPlayer("All")
		evt.Add("Experience", 2000000)
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -18929, Y = -16686, Z = 3009}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -18929, Y = -19554, Z = 3009}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -21664, Y = -19554, Z = 3009}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -21664, Y = -16686, Z = 3009}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17197, Y = -6934, Z = 3137}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -17767, Y = -7801, Z = 3137}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -16656, Y = -9487, Z = 3137}
		evt.SummonMonsters{TypeIndexInMapStats = 1, Level = 3, Count = 1, X = -16693, Y = -11161, Z = 3137}
	end
end

events.LoadMap = evt.map[100].last

evt.hint[101] = evt.str[2]  -- "Stone Marker"
evt.map[101] = function()
	evt.SetMessage(3)         --[[ "\
\
                         Warning!\
\
Passage to the Garden of Stones is forbidden!\
\
                Enter at your own risk." ]]
	evt.SimpleMessage()
end

evt.hint[102] = evt.str[8]  -- "Tree of Passage"
evt.map[102] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 490) then         -- Sutters Bay Tarvel Scroll Once
		if evt.Cmp("QBits", 489) then         -- Kat'an Travel Once
			if evt.Cmp("QBits", 488) then         -- Tamara Dialog
				if evt.Cmp("QBits", 487) then         -- Demonclaw Reload
					if evt.Cmp("QBits", 486) then         -- Birka Entrance after Bona Fide
						evt.SetMessage(7)         -- "You may now use the Tunnel to Desolation's End."
						evt.SimpleMessage()
						evt.ForPlayer("All")
						evt.Add("Awards", 4)         -- "Gained Access to Desolation's End"
						return
					end
				end
			end
		end
	end
	evt.SetMessage(6)         -- "You must talk with all of the Squiggies first."
	evt.SimpleMessage()
end

