local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Red Dwarf Mines",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "Mine Car",
	[10] = "Bookcase",
	[11] = "Statue",
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "Professor Dumbledore’s Grog ",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 58) then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
		evt.Set("MapVar0", 1)
	end
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetSprite{SpriteId = 1, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 3, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 4, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 5, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 6, Visible = 0, Name = "0"}
		evt.SetSprite{SpriteId = 7, Visible = 0, Name = "0"}
	end
end

events.LoadMap = evt.map[1].last

-- ERROR: Invalid command size: 2565:0 (Cmd00)
evt.hint[10] = evt.str[15]  -- "Professor Dumbledore’s Grog "
evt.map[10] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 335) then         -- BDJ 1
		evt.Set("QBits", 335)         -- BDJ 1
		evt.Set("LearningSkill", 70)
	end
end

evt.map[151] = function()
	if not evt.Cmp("Counter4", 1) then
		evt.SetDoorState{Id = 1, State = 2}         -- switch state
		evt.SetDoorState{Id = 2, State = 2}         -- switch state
	end
end

evt.hint[176] = evt.str[9]  -- "Mine Car"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[9]  -- "Mine Car"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[9]  -- "Mine Car"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[9]  -- "Mine Car"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[9]  -- "Mine Car"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[9]  -- "Mine Car"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[9]  -- "Mine Car"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[9]  -- "Mine Car"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[9]  -- "Mine Car"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[9]  -- "Mine Car"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[9]  -- "Mine Car"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[9]  -- "Mine Car"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[9]  -- "Mine Car"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[196] = evt.str[12]  -- "Ore Vein"
evt.map[196] = function()
	local i
	if evt.Cmp("MapVar14", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 687)         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 686)         -- "Iron-laced ore"
::_9::
	evt.Set("MapVar14", 1)
	evt.SetTexture{Facet = 1, Name = "c2b"}
	do return end
::_8::
	evt.Add("Inventory", 688)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar14", 1) then
		evt.SetTexture{Facet = 1, Name = "c2b"}
	end
end

evt.hint[197] = evt.str[12]  -- "Ore Vein"
evt.map[197] = function()
	local i
	if evt.Cmp("MapVar15", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 687)         -- "Siertal-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 686)         -- "Iron-laced ore"
::_9::
	evt.Set("MapVar15", 1)
	evt.SetTexture{Facet = 5, Name = "c2b"}
	do return end
::_8::
	evt.Add("Inventory", 688)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 5, Name = "c2b"}
	end
end

evt.hint[198] = evt.str[12]  -- "Ore Vein"
evt.map[198] = function()
	local i
	if evt.Cmp("MapVar16", 1) then
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		evt.Add("Inventory", 688)         -- "Phylt-laced ore"
		goto _9
	elseif i == 4 then
		evt.DamagePlayer{Player = "All", DamageType = const.Damage.Fire, Damage = 50}
		evt.StatusText(13)         -- "Cave In !"
		goto _8
	elseif i == 5 then
		goto _8
	end
	evt.Add("Inventory", 687)         -- "Siertal-laced ore"
::_9::
	evt.Set("MapVar16", 1)
	evt.SetTexture{Facet = 6, Name = "c2b"}
	do return end
::_8::
	evt.Add("Inventory", 689)         -- "Kergar-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar16", 1) then
		evt.SetTexture{Facet = 6, Name = "c2b"}
	end
end

evt.hint[376] = evt.str[11]  -- "Statue"
evt.map[376] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 1, Visible = 0, Name = "0"}
		evt.Set("NPCs", 61)         -- "Jaycen Keldin"
		evt.SpeakNPC(61)         -- "Jaycen Keldin"
	end
end

evt.hint[377] = evt.str[11]  -- "Statue"
evt.map[377] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.Set("NPCs", 62)         -- "Yarrow Keldin"
		evt.SpeakNPC(62)         -- "Yarrow Keldin"
	end
end

evt.hint[378] = evt.str[11]  -- "Statue"
evt.map[378] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 3, Visible = 0, Name = "0"}
		evt.Set("NPCs", 63)         -- "Fausil Keldin"
		evt.SpeakNPC(63)         -- "Fausil Keldin"
	end
end

evt.hint[379] = evt.str[11]  -- "Statue"
evt.map[379] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 4, Visible = 0, Name = "0"}
		evt.Set("NPCs", 64)         -- "Red Keldin"
		evt.SpeakNPC(64)         -- "Red Keldin"
	end
end

evt.hint[380] = evt.str[11]  -- "Statue"
evt.map[380] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 5, Visible = 0, Name = "0"}
		evt.Set("NPCs", 65)         -- "Thom Keldin"
		evt.SpeakNPC(65)         -- "Thom Keldin"
	end
end

evt.hint[381] = evt.str[11]  -- "Statue"
evt.map[381] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 6, Visible = 0, Name = "0"}
		evt.Set("NPCs", 66)         -- "Arvin Keldin"
		evt.SpeakNPC(66)         -- "Arvin Keldin"
	end
end

evt.hint[382] = evt.str[11]  -- "Statue"
evt.map[382] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 629) then         -- "Elixir"
		evt.SetSprite{SpriteId = 7, Visible = 0, Name = "0"}
		evt.Set("NPCs", 60)         -- "Drathen Keldin"
		evt.SpeakNPC(60)         -- "Drathen Keldin"
	end
end

evt.map[383] = function()
	if evt.Cmp("QBits", 31) then         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
		if not evt.Cmp("QBits", 58) then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 649) then         -- "Worn Belt"
				evt.Set("QBits", 58)         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
				evt.Subtract("Inventory", 649)         -- "Worn Belt"
				evt.Subtract("QBits", 216)         -- Worn Belt - I lost it
				evt.Set("Counter4", 0)
				evt.FaceAnimation{Player = "Current", Animation = 47}
			end
		end
	end
end

evt.map[51] = function()  -- Timer(<function>, 0.5*const.Minute)
	if not evt.Cmp("Counter4", 1) then
		evt.SetDoorState{Id = 3, State = 2}         -- switch state
		evt.SetDoorState{Id = 4, State = 2}         -- switch state
	end
end

Timer(evt.map[51].last, 0.5*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Red Dwarf Mines"
evt.map[501] = function()
	evt.MoveToMap{X = 20980, Y = 14802, Z = 1, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "Out06.odm"}
end

