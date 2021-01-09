local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the School of Sorcery",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "",
	[10] = "Bookcase",
	[11] = "",
	[12] = "",
	[13] = "",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "There are no items that interest you",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Hostile, On = true}         -- "Group for M1"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[5]  -- "Lever"
evt.map[3] = function()
	evt.SetDoorState{Id = 3, State = 1}
end

evt.hint[4] = evt.str[5]  -- "Lever"
evt.map[4] = function()
	evt.SetDoorState{Id = 4, State = 1}
	evt.SetDoorState{Id = 5, State = 1}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[5] = evt.str[5]  -- "Lever"
evt.map[5] = function()
	evt.SetDoorState{Id = 8, State = 1}
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 5, State = 0}
end

evt.hint[6] = evt.str[5]  -- "Lever"
evt.map[6] = function()
	evt.SetDoorState{Id = 9, State = 2}         -- switch state
end

evt.hint[7] = evt.str[100]  -- ""
evt.map[7] = function()
	evt.SetDoorState{Id = 10, State = 2}         -- switch state
	evt.SetDoorState{Id = 11, State = 2}         -- switch state
end

evt.hint[8] = evt.str[5]  -- "Lever"
evt.map[8] = function()
	evt.SetDoorState{Id = 1, State = 1}
	evt.SetDoorState{Id = 6, State = 1}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[9] = evt.str[5]  -- "Lever"
evt.map[9] = function()
	evt.SetDoorState{Id = 2, State = 1}
	evt.SetDoorState{Id = 7, State = 1}
end

evt.hint[10] = evt.str[8]  -- "Switch"
evt.map[10] = function()
	evt.SetDoorState{Id = 24, State = 0}
	evt.SetDoorState{Id = 20, State = 0}
	evt.SetDoorState{Id = 21, State = 0}
end

evt.map[11] = function()
	evt.SetDoorState{Id = 22, State = 0}
end

evt.map[12] = function()
	evt.SetDoorState{Id = 23, State = 0}
end

evt.hint[176] = evt.str[3]  -- "Chest"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[3]  -- "Chest"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
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

evt.hint[196] = evt.str[10]  -- "Bookcase"
evt.map[196] = function()
	local i
	if evt.CheckMonstersKilled{CheckType = 3, Id = 0, Count = 0} then
		return
	end
	if not evt.Cmp("QBits", 145) then         -- Membership to the School of Sorcery Scroll Shop
		return
	end
	if evt.Cmp("MapVar2", 3) then
		evt.StatusText(19)         -- "There are no items that interest you"
		return
	end
	i = Game.Rand() % 6
	if i == 3 then
		return
	elseif i == 4 then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 401)         -- "Fire Bolt"
		elseif i == 2 then
			evt.Add("Inventory", 412)         -- "Feather Fall"
		elseif i == 3 then
			evt.Add("Inventory", 414)         -- "Sparks"
		elseif i == 4 then
			evt.Add("Inventory", 479)         -- "Dispel Magic"
		elseif i == 5 then
			evt.Add("Inventory", 467)         -- "Heal"
		end
		goto _17
	elseif i == 5 then
		goto _18
	end
	evt.GiveItem{Strength = 5, Type = const.ItemType.Scroll_, Id = 0}
::_17::
	i = Game.Rand() % 6
	if i == 4 or i == 5 then
		return
	end
::_18::
	evt.Add("MapVar2", 1)
end

RefillTimer(function()
	evt.Set("MapVar2", 0)
end, const.Week)

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("QBits", 145)         -- Membership to the School of Sorcery Scroll Shop
	evt.SetNPCTopic{NPC = 281, Index = 1, Event = 176}         -- "Eric Swarrel" : "Book Shop"
end, const.Year)

RefillTimer(function()
	evt.ForPlayer("All")
	evt.Subtract("QBits", 145)         -- Membership to the School of Sorcery Scroll Shop
	evt.SetNPCTopic{NPC = 281, Index = 1, Event = 176}         -- "Eric Swarrel" : "Book Shop"
end, const.Year)

evt.hint[197] = evt.str[10]  -- "Bookcase"
evt.map[197] = function()
	if not evt.Cmp("QBits", 154) then         -- Got Scroll of Waves
		evt.Add("Inventory", 702)         -- "Scroll of Waves"
		evt.Set("QBits", 214)         -- Scroll of Waves - I lost it
		evt.Add("QBits", 154)         -- Got Scroll of Waves
	end
end

evt.hint[416] = evt.str[1]  -- "Door"
evt.map[416] = function()
	evt.SpeakNPC(48)         -- "Thomas Grey"
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.SpeakNPC(282)         -- "Guard"
		evt.Set("MapVar4", 1)
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 0)
	end
end

evt.hint[454] = evt.str[100]  -- ""
evt.map[454] = function()
	if evt.Cmp("MapAlert", 0) then
		evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 15, FromX = 1074, FromY = 1870, FromZ = 1, ToX = 1074, ToY = 293, ToZ = 1}         -- "Lightning Bolt"
		evt.CastSpell{Spell = 18, Mastery = const.GM, Skill = 15, FromX = -1106, FromY = 1882, FromZ = 1, ToX = -1106, ToY = 293, ToZ = 1}         -- "Lightning Bolt"
		evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = -1220, FromY = 427, FromZ = 1, ToX = 1209, ToY = 427, ToZ = 1}         -- "Fireball"
		evt.CastSpell{Spell = 6, Mastery = const.GM, Skill = 10, FromX = 1209, FromY = 427, FromZ = 1, ToX = -1220, ToY = 427, ToZ = 1}         -- "Fireball"
	end
end

evt.hint[455] = evt.str[1]  -- "Door"
evt.map[455] = function()
	evt.DamagePlayer{Player = "Current", DamageType = const.Damage.Water, Damage = 10}
end

evt.hint[501] = evt.str[2]  -- "Leave the School of Sorcery"
evt.map[501] = function()
	evt.MoveToMap{X = 1530, Y = -16578, Z = 1377, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out06.odm"}
end

