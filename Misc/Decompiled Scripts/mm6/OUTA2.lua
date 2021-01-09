local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "+100 Power temporary.",
	[3] = "Refreshing!",
	[4] = "Chest",
	[5] = "Paradise Valley",
	[6] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            nhrh_aherheatvdi",
	[7] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[5]  -- "Paradise Valley"
-- ERROR: Duplicate label: 65:0

evt.HouseDoor(2, 11)  -- "Singing Steel"
evt.house[3] = 11  -- "Singing Steel"
evt.HouseDoor(4, 28)  -- "The Enchanted Hauberk"
evt.house[5] = 28  -- "The Enchanted Hauberk"
evt.HouseDoor(6, 41)  -- "Mighty Magicks"
evt.house[7] = 41  -- "Mighty Magicks"
evt.HouseDoor(8, 82)  -- "The Sparring Ground"
evt.house[9] = 82  -- "The Sparring Ground"
evt.HouseDoor(10, 112)  -- "The Last Chance"
evt.house[11] = 112  -- "The Last Chance"
evt.HouseDoor(50, 211)  -- "House"
evt.HouseDoor(51, 212)  -- "House"
evt.HouseDoor(52, 213)  -- "House"
evt.HouseDoor(53, 214)  -- "House"
evt.HouseDoor(54, 215)  -- "House"
evt.HouseDoor(55, 216)  -- "House"
evt.HouseDoor(56, 217)  -- "House"
evt.HouseDoor(57, 218)  -- "House"
evt.HouseDoor(58, 219)  -- "House"
evt.HouseDoor(59, 220)  -- "House"
evt.HouseDoor(60, 221)  -- "House"
evt.HouseDoor(61, 222)  -- "House"
evt.HouseDoor(62, 223)  -- "House"
evt.HouseDoor(63, 224)  -- "House"
evt.HouseDoor(64, 225)  -- "House"
evt.HouseDoor(65, 226)  -- "House"
evt.hint[75] = evt.str[4]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[4]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.hint[77] = evt.str[4]  -- "Chest"
evt.map[77] = function()
	evt.OpenChest(3)
end

evt.HouseDoor(90, 78)  -- "Temple Baa"
evt.hint[100] = evt.str[1]  -- "Drink from Fountain"
evt.map[100] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.Subtract("MapVar0", 1)
		evt.Add("SP", 100)
		evt.Add("HP", 100)
		evt.StatusText(2)         -- "+100 Power temporary."
	else
		evt.StatusText(3)         -- "Refreshing!"
	end
	evt.Set("AutonotesBits", 52)         -- "100 Hit points and spell points from fountain in the desert in Paradise Valley."
end

RefillTimer(function()
	evt.Set("MapVar0", 10)
end, const.Week)

evt.hint[200] = evt.str[7]  -- "Obelisk"
evt.map[200] = function()
	evt.SetMessage(6)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            nhrh_aherheatvdi"
	evt.SimpleMessage()
	evt.Set("QBits", 361)         -- NPC
	evt.Set("AutonotesBits", 80)         -- "Obelisk Message # 2:  nhrh_aherheatvdi"
end

