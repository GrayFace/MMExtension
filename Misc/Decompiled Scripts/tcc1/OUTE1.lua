local TXT = Localize{
	[0] = " ",
	[1] = "The Sword won't budge!",
	[2] = "Refreshing",
	[3] = "+20 Elemental resistance permanent.",
	[4] = "+20 Magic resistance permanent.",
	[5] = "Drink from Fountain.",
	[6] = "Mystic Isles",
	[7] = "Shrine of Cold",
	[8] = "You pray at the shrine.",
	[9] = "+10 Cold resistance permanent",
	[10] = "+3 Cold resistance permanent",
	[11] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand: d_edohshaohmttuoa",
	[12] = "Fountain of Enchantment",
	[13] = "oon_htfdorstusl_",
	[14] = "Creation's Fount",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[6]  -- "Mystic Isles"

evt.house[2] = 40  -- "Little Charms"
evt.map[2] = function()
	evt.EnterHouse(40)         -- "Little Charms"
end

evt.house[3] = 40  -- "Little Charms"
evt.map[3] = function()
end

evt.house[4] = 72  -- "Abdul's Discount House of Worship"
evt.map[4] = function()
	evt.EnterHouse(72)         -- "Abdul's Discount House of Worship"
end

evt.house[5] = 94  -- "An Arrow's Flight"
evt.map[5] = function()
	evt.EnterHouse(94)         -- "An Arrow's Flight"
end

evt.house[6] = 94  -- "An Arrow's Flight"
evt.map[6] = function()
end

evt.house[7] = 95  -- "A Stone's Throw"
evt.map[7] = function()
	evt.EnterHouse(95)         -- "A Stone's Throw"
end

evt.house[8] = 95  -- "A Stone's Throw"
evt.map[8] = function()
end

evt.house[9] = 65  -- "Tigershark"
evt.map[9] = function()
	evt.EnterHouse(65)         -- "Tigershark"
end

evt.house[10] = 64  -- "Cirrus"
evt.map[10] = function()
	evt.EnterHouse(64)         -- "Cirrus"
end

evt.house[50] = 444  -- "House"
evt.map[50] = function()
	evt.EnterHouse(444)         -- "House"
end

evt.house[51] = 445  -- "House"
evt.map[51] = function()
	evt.EnterHouse(445)         -- "House"
end

evt.house[52] = 446  -- "House"
evt.map[52] = function()
	evt.EnterHouse(446)         -- "House"
end

evt.house[53] = 447  -- "House"
evt.map[53] = function()
	evt.EnterHouse(447)         -- "House"
end

evt.house[54] = 448  -- "House"
evt.map[54] = function()
	evt.EnterHouse(448)         -- "House"
end

evt.house[55] = 449  -- "House"
evt.map[55] = function()
	evt.EnterHouse(449)         -- "House"
end

evt.house[56] = 450  -- "House"
evt.map[56] = function()
	evt.EnterHouse(450)         -- "House"
end

evt.house[57] = 451  -- "House"
evt.map[57] = function()
	evt.EnterHouse(451)         -- "House"
end

evt.map[58] = function()
	evt.OpenChest(1)
end

evt.map[59] = function()
	evt.OpenChest(2)
end

evt.house[90] = 452  -- "School of Light"
evt.map[90] = function()
	evt.EnterHouse(452)         -- "School of Light"
end

evt.hint[100] = evt.str[14]  -- "Creation's Fount"
evt.map[100] = function()
	if evt.Cmp("QBits", 478) then         -- Creations Fount  (Mystic Isles)
		evt.StatusText(2)         -- "Refreshing"
	else
		evt.ForPlayer("All")
		evt.Add("FireResistance", 20)
		evt.Add("ElecResistance", 20)
		evt.Add("ColdResistance", 20)
		evt.Add("PoisonResistance", 20)
		evt.StatusText(3)         -- "+20 Elemental resistance permanent."
		evt.Set("AutonotesBits", 17)         -- "20 Points of temporary fire, electricity, cold, and poison resistance from the southwest fountain in the Mystic Isles."
		evt.Set("QBits", 478)         -- Creations Fount  (Mystic Isles)
	end
end

evt.hint[101] = evt.str[12]  -- "Fountain of Enchantment"
evt.map[101] = function()
	if evt.Cmp("QBits", 499) then         -- Fountain of Enchantment once
		evt.StatusText(2)         -- "Refreshing"
	else
		evt.ForPlayer("All")
		evt.Add("MagicResistance", 20)
		evt.StatusText(4)         -- "+20 Magic resistance permanent."
		evt.Set("AutonotesBits", 18)         -- "20 Points of temporary magic resistance from the southeast fountain in the Mystic Isles."
		evt.Set("QBits", 499)         -- Fountain of Enchantment once
	end
end

evt.map[226] = function()
	if not evt.Cmp("QBits", 313) then         -- NPC
		if evt.Cmp("CurrentMight", 200) then
			evt.Set("QBits", 313)         -- NPC
			evt.Add("Inventory", 403)         -- "The Sword of Ripley"
			evt.SetSprite{SpriteId = 99, Visible = 1, Name = "swrdstx"}
		else
			evt.FaceExpression{Player = "Current", Frame = 51}
			evt.StatusText(1)         -- "The Sword won't budge!"
		end
	end
end

function events.LoadMap()
	if evt.Cmp("QBits", 313) then         -- NPC
		evt.SetSprite{SpriteId = 99, Visible = 1, Name = "swrdstx"}
	end
end

evt.hint[227] = evt.str[12]  -- "Fountain of Enchantment"
evt.map[227] = function()
	evt.SetMessage(11)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand: d_edohshaohmttuoa"
	evt.SimpleMessage()
	evt.Set("QBits", 372)         -- NPC
	evt.Set("AutonotesBits", 91)         -- "Obelisk Message # 13: d_edohshaohmttuoa"
end

evt.hint[261] = evt.str[7]  -- "Shrine of Cold"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 9) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 217) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("ColdResistance", 3)
				evt.StatusText(10)         -- "+3 Cold resistance permanent"
			else
				evt.Set("QBits", 217)         -- NPC
				evt.ForPlayer("All")
				evt.Add("ColdResistance", 10)
				evt.StatusText(9)         -- "+10 Cold resistance permanent"
			end
			return
		end
	end
	evt.StatusText(8)         -- "You pray at the shrine."
end

