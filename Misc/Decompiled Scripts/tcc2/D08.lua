local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Chest",
	[3] = "Poisoned Spike",
	[4] = "Unstable rock",
	[5] = "Suspicious Floor",
	[6] = "Dark pit",
	[7] = "Click!",
	[8] = "Exit",
	[9] = "Switch",
	[10] = "Trap!",
	[11] = "Ca-Click!",
	[12] = "Snick!",
	[13] = "Magic Gate Open",
	[14] = "Bag",
	[15] = "Spiral Stuff (Bug if this displays).",
	[16] = "Magic Door",
	[17] = "Bag",
	[18] = "You cannot see me, hear me or touch me.  I lie behind the stars and alter what is real, I am what you really fear, Close your eyes and come I near. What am I?",
	[19] = "dark",
	[20] = "darkness",
	[21] = "Answer?  ",
	[22] = "Incorrect",
	[23] = "I go through an apple, or point out your way, I fit in a bow, then a target, to stay. What am I?",
	[24] = "arrow",
	[25] = "an arrow",
	[26] = "What consumes rocks, levels mountains, destroys wood, pushes the clouds across the sky, and can make a young one old?",
	[27] = "time",
	[28] = "Alive without breath, as cold as death, never thirsty ever drinking, all in mail never clinking, ever travelling, never walking, mouth ever moving, never talking.  What am I? ",
	[29] = "fish",
	[30] = "a fish",
	[31] = "Magical Wall",
	[32] = "Sack",
	[33] = "Empty",
	[34] = "Quedagh Curse",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

