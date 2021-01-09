local TXT = Localize{
	[0] = " ",
	[1] = "Wooden Door",
	[2] = "Chest",
	[3] = "Switch",
	[4] = "Exit",
	[5] = "You find a Pearl.",
	[6] = "Wolf Altar",
	[7] = "After 7 days.",
	[8] = "Crate",
	[9] = "Magic Door",
	[10] = "The door is locked.",
	[11] = "Deleted",
	[12] = "The Werewolves butchered us.  Will you avenge us - so our souls may rest in peace?",
	[13] = "Reply?",
	[14] = "Yes",
	[15] = "Y",
	[16] = "Found Scroll",
	[17] = "Empty",
	[18] = "Norse Lair",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

