local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Cabinet",
	[3] = "Evil Crystal",
	[4] = "Full sack",
	[5] = "Switch",
	[6] = "Flickering Torch",
	[7] = "Empty barrel",
	[8] = "The skulls seem to sap your might",
	[9] = "You have destroyed the evil crystal",
	[10] = "You pull the torch and it shifts in your hand",
	[11] = "The door won't budge",
	[12] = "(removed) The keg is empty",
	[13] = "Exit",
	[14] = "(removed) Keg",
	[15] = "Temple of the Fist",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[15]  -- "Temple of the Fist"

evt.hint[1] = evt.str[1]  -- "Door"
evt.map[1] = function()
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[1]  -- "Door"
evt.hint[3] = evt.str[6]  -- "Flickering Torch"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
	evt.StatusText(10)         -- "You pull the torch and it shifts in your hand"
end

evt.hint[4] = evt.str[5]  -- "Switch"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[5] = evt.str[2]  -- "Cabinet"
evt.map[5] = function()
	evt.OpenChest(0)
end

evt.hint[6] = evt.str[2]  -- "Cabinet"
evt.map[6] = function()
	evt.OpenChest(1)
end

evt.hint[7] = evt.str[4]  -- "Full sack"
evt.map[7] = function()
	evt.OpenChest(2)
end

evt.map[8] = function()
	evt.ForPlayer("All")
	evt.Subtract("MightBonus", 10)
	evt.StatusText(8)         -- "The skulls seem to sap your might"
end

evt.hint[9] = evt.str[3]  -- "Evil Crystal"
evt.map[9] = function()
	if not evt.Cmp("QBits", 21) then         -- 21 T2, Given when evil crystal is destroyed
		evt.SetSprite{SpriteId = 25, Visible = 0, Name = "0"}
		evt.Add("QBits", 21)         -- 21 T2, Given when evil crystal is destroyed
		evt.StatusText(9)         -- "You have destroyed the evil crystal"
	end
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.StatusText(11)         -- "The door won't budge"
end

evt.map[11] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 21) then         -- 21 T2, Given when evil crystal is destroyed
		evt.SetSprite{SpriteId = 25, Visible = 0, Name = "0"}
	end
end

events.LoadMap = evt.map[11].last

evt.hint[50] = evt.str[13]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -21001, Y = -4653, Z = 257, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD2.Odm"}
end

evt.map[55] = function()
	if not evt.Cmp("MapVar0", 1) then
		evt.Set("MapVar0", 1)
		evt.Add("Inventory", 275)         -- "Flying Fist"
	end
end

evt.map[56] = function()
	if not evt.Cmp("MapVar1", 1) then
		evt.Set("MapVar1", 1)
		evt.Add("Inventory", 275)         -- "Flying Fist"
	end
end

evt.map[57] = function()
	if not evt.Cmp("MapVar2", 1) then
		evt.Set("MapVar2", 1)
		evt.Add("Inventory", 275)         -- "Flying Fist"
	end
end

evt.map[58] = function()
	if not evt.Cmp("MapVar3", 1) then
		evt.Set("MapVar3", 1)
		evt.Add("Inventory", 275)         -- "Flying Fist"
	end
end
