local TXT = Localize{
	[0] = " ",
	[1] = "The Sword won't budge!",
	[2] = "Refreshing",
	[3] = "+20 Elemental resistance temporary.",
	[4] = "+20 Magic resistance temporary.",
	[5] = "Drink from Fountain.",
	[6] = "Eel-Infested Waters",
	[7] = "Shrine of Poison",
	[8] = "You pray at the shrine.",
	[9] = "+10 Poison resistance permanent",
	[10] = "+3 Poison resistance permanent",
	[11] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            oon_htfdorstusl_",
	[12] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[6]  -- "Eel-Infested Waters"

evt.HouseDoor(2, 40)  -- "Little Charms"
evt.house[3] = 40  -- "Little Charms"
evt.HouseDoor(4, 72)  -- "Abdul's Discount House of Worship"
evt.HouseDoor(5, 94)  -- "An Arrow's Flight"
evt.house[6] = 94  -- "An Arrow's Flight"
evt.HouseDoor(7, 95)  -- "A Stone's Throw"
evt.house[8] = 95  -- "A Stone's Throw"
evt.HouseDoor(9, 65)  -- "Tigershark"
evt.HouseDoor(10, 64)  -- "Cirrus"
evt.HouseDoor(50, 444)  -- "House"
evt.HouseDoor(51, 445)  -- "House"
evt.HouseDoor(52, 446)  -- "House"
evt.HouseDoor(53, 447)  -- "House"
evt.HouseDoor(54, 448)  -- "House"
evt.HouseDoor(55, 449)  -- "House"
evt.HouseDoor(56, 450)  -- "House"
evt.HouseDoor(57, 451)  -- "House"
evt.map[58] = function()
	evt.OpenChest(1)
end

evt.map[59] = function()
	evt.OpenChest(2)
end

evt.house[90] = 199  -- "Castle Alamos"
evt.map[90] = function()
	evt.MoveToMap{X = -2921, Y = 13139, Z = 225, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 199, Icon = 5, Name = "CD1.Blv"}         -- "Castle Alamos"
end

evt.hint[100] = evt.str[5]  -- "Drink from Fountain."
evt.map[100] = function()
	if evt.Cmp("FireResBonus", 20) then
		evt.StatusText(2)         -- "Refreshing"
	else
		evt.Set("FireResBonus", 20)
		evt.Set("ElecResBonus", 20)
		evt.Set("ColdResBonus", 20)
		evt.Set("PoisonResBonus", 20)
		evt.StatusText(3)         -- "+20 Elemental resistance temporary."
		evt.Set("AutonotesBits", 17)         -- "20 Points of temporary fire, electricity, cold, and poison resistance from the southwest fountain in the Eel Infested Waters."
	end
end

evt.hint[101] = evt.str[5]  -- "Drink from Fountain."
evt.map[101] = function()
	if evt.Cmp("MagicResBonus", 20) then
		evt.StatusText(2)         -- "Refreshing"
	else
		evt.Set("MagicResBonus", 20)
		evt.StatusText(4)         -- "+20 Magic resistance temporary."
		evt.Set("AutonotesBits", 18)         -- "20 Points of temporary magic resistance from the southeast fountain in the Eel Infested Waters."
	end
end

evt.map[226] = function()
	if not evt.Cmp("QBits", 313) then         -- NPC
		if evt.Cmp("CurrentMight", 200) then
			evt.Set("QBits", 313)         -- NPC
			evt.Add("Inventory", 403)         -- "Excalibur"
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

evt.hint[227] = evt.str[12]  -- "Obelisk"
evt.map[227] = function()
	evt.SetMessage(11)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            oon_htfdorstusl_"
	evt.SimpleMessage()
	evt.Set("QBits", 372)         -- NPC
	evt.Set("AutonotesBits", 91)         -- "Obelisk Message # 13: oon_htfdorstusl_"
end

evt.hint[261] = evt.str[7]  -- "Shrine of Poison"
evt.map[261] = function()
	if evt.Cmp("MonthIs", 10) then
		if not evt.Cmp("QBits", 206) then         -- NPC
			evt.Set("QBits", 206)         -- NPC
			if evt.Cmp("QBits", 217) then         -- NPC
				evt.ForPlayer("All")
				evt.Add("PoisonResistance", 3)
				evt.StatusText(10)         -- "+3 Poison resistance permanent"
			else
				evt.Set("QBits", 217)         -- NPC
				evt.ForPlayer("All")
				evt.Add("PoisonResistance", 10)
				evt.StatusText(9)         -- "+10 Poison resistance permanent"
			end
			return
		end
	end
	evt.StatusText(8)         -- "You pray at the shrine."
end

