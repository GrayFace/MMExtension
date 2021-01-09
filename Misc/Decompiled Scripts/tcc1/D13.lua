local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Statue",
	[3] = "Strange tree",
	[4] = "Temple of Agrona's Faithful",
	[5] = "Sacred Pool",
	[6] = "Altar of Agrona",
	[7] = "Chest",
	[8] = "Nice Flower",
	[9] = "The door will not budge.",
	[10] = "You search the tree and find something.",
	[11] = "+75 Personality permanent!",
	[12] = "The statue shifts as your touch it.",
	[13] = "The rock shifts at your touch.",
	[14] = "The pool shimmers as you touch it.",
	[15] = "The monolith feels strange to the touch.",
	[16] = "You find nothing.",
	[17] = "The tree shakes at your touch.",
	[18] = "The flowers smell nice.",
	[19] = "Exit",
	[20] = "Strange rock",
	[21] = "Temple of Agorna's Faithful",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0

evt.MazeInfo = evt.str[21]  -- "Temple of Agorna's Faithful"

evt.hint[1] = evt.str[20]  -- "Strange rock"
evt.map[1] = function()
	evt.StatusText(13)         -- "The rock shifts at your touch."
	evt.SetDoorState{Id = 1, State = 1}
end

evt.hint[2] = evt.str[20]  -- "Strange rock"
evt.map[2] = function()
	evt.StatusText(13)         -- "The rock shifts at your touch."
	evt.SetDoorState{Id = 2, State = 1}
end

evt.hint[3] = evt.str[4]  -- "Temple of Agrona's Faithful"
evt.map[3] = function()
	evt.StatusText(15)         -- "The monolith feels strange to the touch."
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[3]  -- "Strange tree"
evt.map[4] = function()
	evt.StatusText(17)         -- "The tree shakes at your touch."
	evt.SetDoorState{Id = 4, State = 1}
end

evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 1}
end

evt.hint[6] = evt.str[20]  -- "Strange rock"
evt.map[6] = function()
	evt.StatusText(13)         -- "The rock shifts at your touch."
	evt.SetDoorState{Id = 6, State = 1}
end

evt.hint[7] = evt.str[4]  -- "Temple of Agrona's Faithful"
evt.map[7] = function()
	evt.StatusText(15)         -- "The monolith feels strange to the touch."
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[8]  -- "Nice Flower"
evt.map[8] = function()
	evt.StatusText(18)         -- "The flowers smell nice."
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[2]  -- "Statue"
evt.map[9] = function()
	evt.StatusText(12)         -- "The statue shifts as your touch it."
	evt.SetDoorState{Id = 9, State = 1}
end

evt.hint[10] = evt.str[1]  -- "Door"
evt.map[10] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.map[11] = function()
	evt.SetDoorState{Id = 7, State = 0}
end

evt.hint[12] = evt.str[5]  -- "Sacred Pool"
evt.map[12] = function()
	evt.StatusText(14)         -- "The pool shimmers as you touch it."
	evt.SetDoorState{Id = 12, State = 2}         -- switch state
end

evt.hint[13] = evt.str[7]  -- "Chest"
evt.map[13] = function()
	evt.OpenChest(0)
end

evt.hint[14] = evt.str[7]  -- "Chest"
evt.map[14] = function()
	evt.OpenChest(1)
end

evt.hint[15] = evt.str[3]  -- "Strange tree"
evt.map[15] = function()
	evt.StatusText(17)         -- "The tree shakes at your touch."
	evt.SetDoorState{Id = 15, State = 1}
end

evt.hint[16] = evt.str[3]  -- "Strange tree"
evt.map[16] = function()
	if evt.Cmp("MapVar0", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 1000)
		evt.Add("MapVar0", 1)
	end
end

evt.hint[17] = evt.str[3]  -- "Strange tree"
evt.map[17] = function()
	if evt.Cmp("MapVar1", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 1500)
		evt.Add("MapVar1", 1)
	end
end

evt.hint[18] = evt.str[3]  -- "Strange tree"
evt.map[18] = function()
	if evt.Cmp("MapVar2", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 2000)
		evt.Add("MapVar2", 1)
	end
end

evt.hint[19] = evt.str[3]  -- "Strange tree"
evt.map[19] = function()
	if evt.Cmp("MapVar3", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 2500)
		evt.Add("MapVar3", 1)
	end
end

evt.hint[20] = evt.str[3]  -- "Strange tree"
evt.map[20] = function()
	if evt.Cmp("MapVar4", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 3000)
		evt.Add("MapVar4", 1)
	end
end

evt.hint[21] = evt.str[3]  -- "Strange tree"
evt.map[21] = function()
	if evt.Cmp("MapVar5", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("GoldAddRandom", 3500)
		evt.Add("MapVar5", 1)
	end
end

evt.hint[22] = evt.str[4]  -- "Temple of Agrona's Faithful"
evt.map[22] = function()
	evt.StatusText(15)         -- "The monolith feels strange to the touch."
	evt.CastSpell{Spell = 91, Mastery = const.Expert, Skill = 3, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Mass Curse"
end

evt.hint[23] = evt.str[3]  -- "Strange tree"
evt.map[23] = function()
	if evt.Cmp("MapVar6", 1) then
		evt.StatusText(16)         -- "You find nothing."
	else
		evt.StatusText(10)         -- "You search the tree and find something."
		evt.Add("Gold", 5000)
		evt.Add("MapVar6", 1)
	end
end

evt.hint[24] = evt.str[6]  -- "Altar of Agrona"
evt.map[24] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 23) then         -- 23 D13, Given when Altar is desecrated
		if evt.Cmp("Inventory", 528) then         -- "Ceridwen’s Elixir of Wisdom"
			evt.SetTexture{Facet = 949, Name = "d6florA"}
			evt.SetTexture{Facet = 947, Name = "d6florA"}
			evt.SetTexture{Facet = 927, Name = "d6florA"}
			evt.SetTexture{Facet = 928, Name = "d6florA"}
			evt.SetTexture{Facet = 929, Name = "d6florA"}
			evt.SetTexture{Facet = 948, Name = "d6florA"}
			evt.SetTexture{Facet = 945, Name = "d6florA"}
			evt.SetTexture{Facet = 946, Name = "d6florA"}
			evt.SetTexture{Facet = 944, Name = "d6florA"}
			evt.SetTexture{Facet = 943, Name = "d6florA"}
			evt.SetTexture{Facet = 942, Name = "d6florA"}
			evt.StatusText(11)         -- "+75 Personality permanent!"
			evt.Subtract("Inventory", 528)         -- "Ceridwen’s Elixir of Wisdom"
			evt.Subtract("QBits", 139)         -- "Purify the Alter of Agrona."
			evt.Set("Awards", 47)         -- "Purified Alter of Agrona"
			evt.Add("BasePersonality", 75)
			evt.Set("QBits", 23)         -- 23 D13, Given when Altar is desecrated
		end
	end
end

evt.hint[25] = evt.str[1]  -- "Door"
evt.map[25] = function()
	evt.StatusText(9)         -- "The door will not budge."
end

evt.map[26] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 23) then         -- 23 D13, Given when Altar is desecrated
		evt.SetTexture{Facet = 949, Name = "d6florA"}
		evt.SetTexture{Facet = 947, Name = "d6florA"}
		evt.SetTexture{Facet = 927, Name = "d6florA"}
		evt.SetTexture{Facet = 928, Name = "d6florA"}
		evt.SetTexture{Facet = 929, Name = "d6florA"}
		evt.SetTexture{Facet = 948, Name = "d6florA"}
		evt.SetTexture{Facet = 945, Name = "d6florA"}
		evt.SetTexture{Facet = 946, Name = "d6florA"}
		evt.SetTexture{Facet = 944, Name = "d6florA"}
		evt.SetTexture{Facet = 943, Name = "d6florA"}
		evt.SetTexture{Facet = 942, Name = "d6florA"}
	end
end

events.LoadMap = evt.map[26].last

evt.hint[50] = evt.str[19]  -- "Exit"
evt.map[50] = function()
	evt.MoveToMap{X = -533, Y = -2681, Z = 944, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD1.Odm"}
end

evt.hint[51] = evt.str[20]  -- "Strange rock"
evt.map[51] = function()
	if not evt.Cmp("MapVar20", 1) then
		if evt.Cmp("MapVar19", 1) then
			evt.GiveItem{Strength = 6, Type = const.ItemType.Shield_, Id = 0}
			evt.GiveItem{Strength = 6, Type = const.ItemType.Boots_, Id = 0}
			evt.Add("Inventory", 375)         -- "Flying Fist"
			evt.Set("MapVar20", 1)
		else
			if evt.Cmp("MapVar17", 1) then
				evt.Set("MapVar18", 1)
			else
				if evt.Cmp("MapVar15", 1) then
					evt.Set("MapVar16", 1)
				else
					if evt.Cmp("MapVar13", 1) then
						evt.Set("MapVar14", 1)
					else
						if evt.Cmp("MapVar11", 1) then
							evt.Set("MapVar12", 1)
						else
							if evt.Cmp("MapVar9", 1) then
								evt.Set("MapVar10", 1)
							end
						end
					end
				end
			end
		end
	end
end

evt.hint[52] = evt.str[20]  -- "Strange rock"
evt.map[52] = function()
	if evt.Cmp("MapVar18", 1) then
		evt.Set("MapVar19", 1)
	else
		if evt.Cmp("MapVar16", 1) then
			evt.Set("MapVar17", 1)
		else
			if evt.Cmp("MapVar14", 1) then
				evt.Set("MapVar15", 1)
			else
				if evt.Cmp("MapVar12", 1) then
					evt.Set("MapVar13", 1)
				else
					if evt.Cmp("MapVar10", 1) then
						evt.Set("MapVar11", 1)
					else
						evt.Set("MapVar9", 1)
					end
				end
			end
		end
	end
end

