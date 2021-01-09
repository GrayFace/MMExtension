local TXT = Localize{
	[0] = " ",
	[1] = "Drink from Fountain",
	[2] = "Rejuvination!",
	[3] = "Refreshing!",
	[4] = "Chest",
	[5] = "Hermit's Isle",
	[6] = "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _etecpe__ersoede",
	[7] = "Obelisk",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[5]  -- "Hermit's Isle"

evt.hint[1] = evt.str[7]  -- "Obelisk"
evt.hint[75] = evt.str[4]  -- "Chest"
evt.map[75] = function()
	evt.OpenChest(1)
end

evt.hint[76] = evt.str[4]  -- "Chest"
evt.map[76] = function()
	evt.OpenChest(2)
end

evt.house[90] = 196  -- "Supreme Temple of Baa"
evt.map[90] = function()
	evt.MoveToMap{X = -2048, Y = 3453, Z = 2049, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 196, Icon = 5, Name = "T6.Blv"}         -- "Supreme Temple of Baa"
end

evt.hint[100] = evt.str[1]  -- "Drink from Fountain"
evt.map[100] = function()
	evt.Set("AgeBonus", 0)
	evt.StatusText(2)         -- "Rejuvination!"
	evt.Set("AutonotesBits", 51)         -- "Unnatural aging cured at fountain to the east of Hermit's Isle."
end

evt.hint[210] = evt.str[7]  -- "Obelisk"
evt.map[210] = function()
	evt.SetMessage(6)         -- "The surface of the obelisk is blood warm to the touch.  A message swims into view as you remove your hand:                                                                                                                                                            _etecpe__ersoede"
	evt.SimpleMessage()
	evt.Set("QBits", 362)         -- NPC
	evt.Set("AutonotesBits", 81)         -- "Obelisk Message # 3:  _etecpe__ersoede"
end

