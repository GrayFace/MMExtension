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
	[15] = "Shirley's Astral Elixir",
	[16] = "Take a Drink",
	[17] = "Not Very Refreshing",
	[18] = "Refreshing",
	[19] = "The Door is Locked",
	[20] = "Enter the Throne Room",
	[21] = "The Chest is Locked",
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

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 370) then         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Invisible, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("DiseasedRed", 0)
	end
end

events.LoadMap = evt.map[2].last

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

evt.hint[10] = evt.str[15]  -- "Shirley's Astral Elixir"
evt.map[10] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 334) then         -- 1-time stone city
		evt.Set("QBits", 334)         -- 1-time stone city
		evt.Set("PerceptionSkill", 70)
	end
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
	if evt.Cmp("Awards", 21) then         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.OpenChest(9)
	else
		evt.StatusText(21)         -- "The Chest is Locked"
	end
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	if evt.Cmp("Awards", 21) then         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.OpenChest(10)
	else
		evt.StatusText(21)         -- "The Chest is Locked"
	end
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
		evt.Add("AutonotesBits", 127)         -- "Obelisk message #14: ___d___d"
		evt.ForPlayer("All")
		evt.Add("QBits", 177)         -- Visited Obelisk in Area 39
	end
end

evt.house[416] = 421  -- "Throne Room"
evt.map[416] = function()
	if evt.Cmp("Awards", 4) then         -- "Cleared out Castle Harmondale"
		evt.EnterHouse(421)         -- "Throne Room"
	else
		evt.FaceAnimation{Player = "Current", Animation = 18}
		evt.StatusText(19)         -- "The Door is Locked"
	end
end

evt.house[417] = 10  -- "The Balanced Axe"
evt.map[417] = function()
	evt.EnterHouse(10)         -- "The Balanced Axe"
end

evt.house[418] = 10  -- "The Balanced Axe"
evt.map[418] = function()
end

evt.house[419] = 24  -- "The Polished Pauldron"
evt.map[419] = function()
	evt.EnterHouse(24)         -- "The Polished Pauldron"
end

evt.house[420] = 24  -- "The Polished Pauldron"
evt.map[420] = function()
end

evt.house[421] = 38  -- "Delicate Things"
evt.map[421] = function()
	evt.EnterHouse(38)         -- "Delicate Things"
end

evt.house[422] = 38  -- "Delicate Things"
evt.map[422] = function()
end

evt.house[423] = 50  -- "Potent Potions & Brews"
evt.map[423] = function()
	evt.EnterHouse(50)         -- "Potent Potions & Brews"
end

evt.house[424] = 50  -- "Potent Potions & Brews"
evt.map[424] = function()
end

evt.house[425] = 85  -- "Temple of Stone"
evt.map[425] = function()
	evt.EnterHouse(85)         -- "Temple of Stone"
end

evt.house[426] = 85  -- "Temple of Stone"
evt.map[426] = function()
end

evt.house[427] = 98  -- "War College"
evt.map[427] = function()
	evt.EnterHouse(98)         -- "War College"
end

evt.house[428] = 98  -- "War College"
evt.map[428] = function()
end

evt.house[429] = 120  -- "Grogg's Grog"
evt.map[429] = function()
	evt.EnterHouse(120)         -- "Grogg's Grog"
end

evt.house[430] = 120  -- "Grogg's Grog"
evt.map[430] = function()
end

evt.house[431] = 135  -- "Mineral Wealth"
evt.map[431] = function()
	evt.EnterHouse(135)         -- "Mineral Wealth"
end

evt.house[432] = 135  -- "Mineral Wealth"
evt.map[432] = function()
end

evt.house[433] = 153  -- "Master Guild of Earth"
evt.map[433] = function()
	evt.EnterHouse(153)         -- "Master Guild of Earth"
end

evt.house[434] = 153  -- "Master Guild of Earth"
evt.map[434] = function()
end

evt.house[435] = 413  -- "Keenedge Residence"
evt.map[435] = function()
	evt.EnterHouse(413)         -- "Keenedge Residence"
end

evt.house[436] = 414  -- "Seline's House"
evt.map[436] = function()
	evt.EnterHouse(414)         -- "Seline's House"
end

evt.house[437] = 415  -- "Welman Residence"
evt.map[437] = function()
	evt.EnterHouse(415)         -- "Welman Residence"
end

evt.house[438] = 416  -- "Thain's House"
evt.map[438] = function()
	evt.EnterHouse(416)         -- "Thain's House"
end

evt.house[439] = 417  -- "Gizmo's"
evt.map[439] = function()
	evt.EnterHouse(417)         -- "Gizmo's"
end

evt.house[440] = 418  -- "Spark's House"
evt.map[440] = function()
	evt.EnterHouse(418)         -- "Spark's House"
end

evt.house[441] = 419  -- "Thorinson Residence"
evt.map[441] = function()
	evt.EnterHouse(419)         -- "Thorinson Residence"
end

evt.house[442] = 420  -- "Urthsmite Residence"
evt.map[442] = function()
	evt.EnterHouse(420)         -- "Urthsmite Residence"
end

evt.house[443] = 421  -- "Throne Room"
evt.map[443] = function()
	evt.EnterHouse(421)         -- "Throne Room"
end

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

