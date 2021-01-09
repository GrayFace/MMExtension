local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Stone City",
	[3] = "Chest",
	[4] = "Button",
	[5] = "Lever",
	[6] = "Vault",
	[7] = "Cabinet",
	[8] = "Switch",
	[9] = "House",
	[10] = "Bookcase",
	[11] = "Nothing Here",
	[12] = "Ore Vein",
	[13] = "Cave In !",
	[14] = "You Successfully disarm the trap",
	[15] = "",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "The Door is Locked",
	[20] = "Enter the Throne Room",
	[21] = "",
	[22] = "",
	[23] = "",
	[24] = "",
	[25] = "",
	[26] = "",
	[27] = "",
	[28] = "",
	[29] = "",
	[30] = "",
	[31] = "",
	[32] = "",
	[33] = "",
	[34] = "",
	[35] = "",
	[36] = "",
	[37] = "",
	[38] = "",
	[39] = "",
	[40] = "",
	[41] = "",
	[42] = "",
	[43] = "",
	[44] = "",
	[45] = "",
	[46] = "",
	[47] = "",
	[48] = "",
	[49] = "",
	[50] = "Obelisk",
	[51] = "___d___d",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[4] = evt.str[1]  -- "Door"
evt.map[4] = function()
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[6] = evt.str[1]  -- "Door"
evt.map[6] = function()
	evt.SetDoorState{Id = 7, State = 0}
	evt.SetDoorState{Id = 8, State = 0}
end

evt.hint[151] = evt.str[4]  -- "Button"
evt.map[151] = function()
	evt.SetDoorState{Id = 10, State = 1}
end

evt.hint[152] = evt.str[4]  -- "Button"
evt.map[152] = function()
	evt.SetDoorState{Id = 10, State = 0}
end

evt.hint[153] = evt.str[4]  -- "Button"
evt.map[153] = function()
	evt.SetDoorState{Id = 11, State = 1}
end

evt.hint[154] = evt.str[4]  -- "Button"
evt.map[154] = function()
	evt.SetDoorState{Id = 11, State = 0}
end

evt.hint[176] = evt.str[7]  -- "Cabinet"
evt.map[176] = function()
	evt.OpenChest(0)
end

evt.hint[177] = evt.str[7]  -- "Cabinet"
evt.map[177] = function()
	evt.OpenChest(1)
end

evt.hint[178] = evt.str[7]  -- "Cabinet"
evt.map[178] = function()
	evt.OpenChest(2)
end

evt.hint[179] = evt.str[7]  -- "Cabinet"
evt.map[179] = function()
	evt.OpenChest(3)
end

evt.hint[180] = evt.str[7]  -- "Cabinet"
evt.map[180] = function()
	evt.OpenChest(4)
end

evt.hint[181] = evt.str[7]  -- "Cabinet"
evt.map[181] = function()
	evt.OpenChest(5)
end

evt.hint[182] = evt.str[7]  -- "Cabinet"
evt.map[182] = function()
	evt.OpenChest(6)
end

evt.hint[183] = evt.str[7]  -- "Cabinet"
evt.map[183] = function()
	evt.OpenChest(7)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	evt.OpenChest(8)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	evt.OpenChest(9)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	evt.OpenChest(10)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	evt.OpenChest(11)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	evt.OpenChest(12)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	evt.OpenChest(13)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	evt.OpenChest(14)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	evt.OpenChest(15)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	evt.OpenChest(16)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	evt.OpenChest(17)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	evt.OpenChest(18)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	evt.OpenChest(19)
end

evt.hint[196] = evt.str[16]  -- "Take a Drink"
evt.map[196] = function()
	evt.StatusText(18)         -- "Refreshing"
end

evt.hint[197] = evt.str[16]  -- "Take a Drink"
evt.map[197] = function()
	evt.StatusText(18)         -- "Refreshing"
end

evt.hint[198] = evt.str[16]  -- "Take a Drink"
evt.map[198] = function()
	evt.StatusText(18)         -- "Refreshing"
end

evt.hint[199] = evt.str[10]  -- "Bookcase"
evt.map[199] = function()
	evt.StatusText(11)         -- "Nothing Here"
end

evt.hint[200] = evt.str[12]  -- "Ore Vein"
evt.map[200] = function()
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
	evt.SetTexture{Facet = 2, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 688)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar14", 1) then
		evt.SetTexture{Facet = 2, Name = "cwb1"}
	end
end

evt.hint[201] = evt.str[12]  -- "Ore Vein"
evt.map[201] = function()
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
	evt.SetTexture{Facet = 3, Name = "cwb1"}
	do return end
::_8::
	evt.Add("Inventory", 688)         -- "Phylt-laced ore"
	goto _9
end

function events.LoadMap()
	if evt.Cmp("MapVar15", 1) then
		evt.SetTexture{Facet = 3, Name = "cwb1"}
	end
end

evt.hint[415] = evt.str[50]  -- "Obelisk"
evt.map[415] = function()
	if not evt.Cmp("QBits", 177) then         -- Visited Obelisk in Area 39
		evt.StatusText(51)         -- "___d___d"
		evt.Add("AutonotesBits", 127)         -- ""
		evt.ForPlayer("All")
		evt.Add("QBits", 177)         -- Visited Obelisk in Area 39
	end
end

evt.house[416] = 421  -- "Throne Room"
evt.map[416] = function()
	if evt.Cmp("Awards", 4) then         -- "Removed goblins from Castle Harmondale"
		evt.EnterHouse(421)         -- "Throne Room"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
		evt.StatusText(19)         -- "The Door is Locked"
	end
end

evt.HouseDoor(417, 10)  -- "The Balanced Axe"
evt.house[418] = 10  -- "The Balanced Axe"
evt.HouseDoor(419, 24)  -- "The Polished Pauldron"
evt.house[420] = 24  -- "The Polished Pauldron"
evt.HouseDoor(421, 38)  -- "Delicate Things"
evt.house[422] = 38  -- "Delicate Things"
evt.HouseDoor(423, 50)  -- "Potent Potions & Brews"
evt.house[424] = 50  -- "Potent Potions & Brews"
evt.HouseDoor(425, 85)  -- "Temple of Stone"
evt.house[426] = 85  -- "Temple of Stone"
evt.HouseDoor(427, 98)  -- "War College"
evt.house[428] = 98  -- "War College"
evt.HouseDoor(429, 120)  -- "Grogg's Grog"
evt.house[430] = 120  -- "Grogg's Grog"
evt.HouseDoor(431, 135)  -- "Mineral Wealth"
evt.house[432] = 135  -- "Mineral Wealth"
evt.HouseDoor(433, 153)  -- "Master Guild of Earth"
evt.house[434] = 153  -- "Master Guild of Earth"
evt.HouseDoor(435, 413)  -- "Keenedge Residence"
evt.HouseDoor(436, 414)  -- "Seline's House"
evt.HouseDoor(437, 415)  -- "Welman Residence"
evt.HouseDoor(438, 416)  -- "Thain's House"
evt.HouseDoor(439, 417)  -- "Gizmo's"
evt.HouseDoor(440, 418)  -- "Spark's House"
evt.HouseDoor(441, 419)  -- "Thorinson Residence"
evt.HouseDoor(442, 420)  -- "Urthsmite Residence"
evt.HouseDoor(443, 421)  -- "Throne Room"
evt.hint[444] = evt.str[9]  -- "House"
evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 1) then
			evt.SpeakNPC(441)         -- "Guard"
			evt.Set("MapVar4", 1)
		end
	end
end

evt.hint[452] = evt.str[100]  -- ""
evt.map[452] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 2) then
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
			evt.SetMonGroupBit{NPCGroup = 4, Bit = const.MonsterBits.Hostile, On = true}         -- "Guards"
			evt.Set("MapVar4", 2)
		end
	end
end

evt.hint[453] = evt.str[100]  -- ""
evt.map[453] = function()
	if not evt.Cmp("Invisible", 0) then
		if not evt.Cmp("MapVar4", 2) then
			evt.Set("MapVar4", 0)
		end
	end
end

evt.hint[501] = evt.str[2]  -- "Leave Stone City"
evt.map[501] = function()
	evt.MoveToMap{X = -2384, Y = 3064, Z = 2091, Direction = 0, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out11.odm"}
end

evt.hint[502] = evt.str[2]  -- "Leave Stone City"
evt.map[502] = function()
	evt.MoveToMap{X = 522, Y = -808, Z = 1, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 3, Name = "D35.blv"}
end

