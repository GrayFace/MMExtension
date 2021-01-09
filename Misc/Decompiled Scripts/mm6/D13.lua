local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Druid statue",
	[3] = "Strange tree",
	[4] = "Monolith",
	[5] = "Sacred Pool",
	[6] = "Evil Altar",
	[7] = "Chest",
	[8] = "Nice Flower",
	[9] = "The door will not budge.",
	[10] = "You search the tree and find something.",
	[11] = "+5 Personality permanent to Druids and Clerics.",
	[12] = "The statue shifts as your touch it.",
	[13] = "The rock shifts at your touch.",
	[14] = "The pool shimmers as you touch it.",
	[15] = "The monolith feels strange to the touch.",
	[16] = "You find nothing.",
	[17] = "The tree shakes at your touch.",
	[18] = "The flowers smell nice.",
	[19] = "Exit",
	[20] = "Strange rock",
	[21] = "Silver Helm Stronghold",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

evt.MazeInfo = evt.str[21]  -- "Silver Helm Stronghold"

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

evt.hint[3] = evt.str[4]  -- "Monolith"
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

evt.hint[7] = evt.str[4]  -- "Monolith"
evt.map[7] = function()
	evt.StatusText(15)         -- "The monolith feels strange to the touch."
	evt.SetDoorState{Id = 7, State = 2}         -- switch state
end

evt.hint[8] = evt.str[8]  -- "Nice Flower"
evt.map[8] = function()
	evt.StatusText(18)         -- "The flowers smell nice."
	evt.SetDoorState{Id = 8, State = 1}
end

evt.hint[9] = evt.str[2]  -- "Druid statue"
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

evt.hint[22] = evt.str[4]  -- "Monolith"
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

evt.hint[24] = evt.str[6]  -- "Evil Altar"
evt.map[24] = function()
	if evt.Cmp("QBits", 23) then         -- 23 D13, Given when Altar is desecrated
		return
	end
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
	evt.StatusText(11)         -- "+5 Personality permanent to Druids and Clerics."
	evt.ForPlayer(0)
	if not evt.Cmp("ClassIs", const.Class.Cleric) then
		if evt.Cmp("MapVar7", 0) then
			goto _17
		end
	end
	evt.Add("BasePersonality", 5)
::_17::
	evt.ForPlayer(1)
	if not evt.Cmp("ClassIs", const.Class.Cleric) then
		if evt.Cmp("MapVar7", 0) then
			goto _21
		end
	end
	evt.Add("BasePersonality", 5)
::_21::
	evt.ForPlayer(2)
	if not evt.Cmp("ClassIs", const.Class.Cleric) then
		if evt.Cmp("MapVar7", 0) then
			goto _25
		end
	end
	evt.Add("BasePersonality", 5)
::_25::
	evt.ForPlayer(3)
	if not evt.Cmp("ClassIs", const.Class.Cleric) then
		if evt.Cmp("MapVar7", 0) then
			goto _29
		end
	end
	evt.Add("BasePersonality", 5)
::_29::
	evt.ForPlayer(0)
	if not evt.Cmp("ClassIs", const.Class.Druid) then
		if evt.Cmp("MapVar7", 0) then
			goto _33
		end
	end
	evt.Add("BasePersonality", 5)
::_33::
	evt.ForPlayer(1)
	if not evt.Cmp("ClassIs", const.Class.Druid) then
		if evt.Cmp("MapVar7", 0) then
			goto _37
		end
	end
	evt.Add("BasePersonality", 5)
::_37::
	evt.ForPlayer(2)
	if not evt.Cmp("ClassIs", const.Class.Druid) then
		if evt.Cmp("MapVar7", 0) then
			goto _41
		end
	end
	evt.Add("BasePersonality", 5)
::_41::
	evt.ForPlayer(3)
	if not evt.Cmp("ClassIs", const.Class.Druid) then
		if evt.Cmp("MapVar7", 0) then
			goto _46
		end
	end
	evt.Add("BasePersonality", 5)
	evt.ForPlayer("All")
::_46::
	evt.Set("QBits", 23)         -- 23 D13, Given when Altar is desecrated
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
	evt.MoveToMap{X = -17658, Y = -12361, Z = 257, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 6, Name = "OutD1.Odm"}
end

evt.hint[51] = evt.str[20]  -- "Strange rock"
evt.map[51] = function()
	if not evt.Cmp("MapVar20", 1) then
		if evt.Cmp("MapVar19", 1) then
			evt.GiveItem{Strength = 6, Type = const.ItemType.Shield_, Id = 0}
			evt.GiveItem{Strength = 6, Type = const.ItemType.Boots_, Id = 0}
			evt.Add("Inventory", 375)         -- "Flying Fist"
			evt.Set("MapVar20", 1)
		elseif evt.Cmp("MapVar17", 1) then
			evt.Set("MapVar18", 1)
		elseif evt.Cmp("MapVar15", 1) then
			evt.Set("MapVar16", 1)
		elseif evt.Cmp("MapVar13", 1) then
			evt.Set("MapVar14", 1)
		elseif evt.Cmp("MapVar11", 1) then
			evt.Set("MapVar12", 1)
		elseif evt.Cmp("MapVar9", 1) then
			evt.Set("MapVar10", 1)
		end
	end
end

evt.hint[52] = evt.str[20]  -- "Strange rock"
evt.map[52] = function()
	if evt.Cmp("MapVar18", 1) then
		evt.Set("MapVar19", 1)
	elseif evt.Cmp("MapVar16", 1) then
		evt.Set("MapVar17", 1)
	elseif evt.Cmp("MapVar14", 1) then
		evt.Set("MapVar15", 1)
	elseif evt.Cmp("MapVar12", 1) then
		evt.Set("MapVar13", 1)
	elseif evt.Cmp("MapVar10", 1) then
		evt.Set("MapVar11", 1)
	else
		evt.Set("MapVar9", 1)
	end
end

