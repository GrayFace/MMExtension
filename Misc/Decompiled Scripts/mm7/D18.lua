local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave Lord Markham's Manor",
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
	[19] = "",
	[20] = "Enter Lord Markham's Chamber",
	[21] = "This Door has Been Locked",
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events

Game.LoadSound(513)

evt.map[1] = function()  -- function events.LoadMap()
	if evt.Cmp("QBits", 104) then         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
	end
	if evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
end

events.LoadMap = evt.map[1].last

evt.hint[2] = evt.str[100]  -- ""
evt.map[2] = function()  -- function events.LeaveMap()
	if evt.CheckMonstersKilled{CheckType = 1, Id = 5, Count = 1} then
		evt.Set("MapVar4", 2)
	end
end

events.LeaveMap = evt.map[2].last

evt.hint[3] = evt.str[1]  -- "Door"
evt.map[3] = function()
	if not evt.Cmp("MapVar4", 2) then
		if not evt.Cmp("MapVar4", 1) then
			evt.SpeakNPC(283)         -- "Guard"
			evt.Set("MapVar4", 1)
			return
		end
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.SetDoorState{Id = 3, State = 0}
	evt.SetDoorState{Id = 4, State = 0}
	evt.SetDoorState{Id = 1, State = 0}
	evt.SetDoorState{Id = 2, State = 0}
end

evt.hint[5] = evt.str[1]  -- "Door"
evt.map[5] = function()
	evt.SetDoorState{Id = 5, State = 0}
	evt.SetDoorState{Id = 6, State = 0}
end

evt.hint[6] = evt.str[100]  -- ""
evt.map[6] = function()
	evt.PlaySound{Id = 513, X = 3, Y = 227}
end

evt.hint[176] = evt.str[7]  -- "Cabinet"
evt.map[176] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[7]  -- "Cabinet"
evt.map[177] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[3]  -- "Chest"
evt.map[178] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[3]  -- "Chest"
evt.map[179] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[3]  -- "Chest"
evt.map[180] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
		evt.Set("MapVar4", 2)
	end
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[3]  -- "Chest"
evt.map[181] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[3]  -- "Chest"
evt.map[182] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[3]  -- "Chest"
evt.map[183] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[3]  -- "Chest"
evt.map[184] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[3]  -- "Chest"
evt.map[185] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[3]  -- "Chest"
evt.map[186] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[3]  -- "Chest"
evt.map[187] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[3]  -- "Chest"
evt.map[188] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[3]  -- "Chest"
evt.map[189] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[3]  -- "Chest"
evt.map[190] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[3]  -- "Chest"
evt.map[191] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[3]  -- "Chest"
evt.map[192] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[3]  -- "Chest"
evt.map[193] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[3]  -- "Chest"
evt.map[194] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[3]  -- "Chest"
evt.map[195] = function()
	if not evt.Cmp("MapVar4", 2) then
		evt.Set("MapVar4", 2)
		evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Hostile, On = true}         -- "Generic Monster Group for Dungeons"
	end
	evt.OpenChest(0)
end

evt.map[376] = function()
	if not evt.Cmp("QBits", 212) then         -- Vase - I lost it
		evt.Set("QBits", 212)         -- Vase - I lost it
	end
	if not evt.Cmp("QBits", 141) then         -- Only give Markham's vase once (Markham's manor, Thief promo).
		evt.Add("Inventory", 624)         -- "Vase"
		evt.Set("QBits", 141)         -- Only give Markham's vase once (Markham's manor, Thief promo).
		evt.SetSprite{SpriteId = 2, Visible = 0, Name = "0"}
		evt.CastSpell{Spell = 15, Mastery = const.Master, Skill = 20, FromX = -1132, FromY = 1001, FromZ = 374, ToX = 0, ToY = 0, ToZ = 0}         -- "Sparks"
	end
end

evt.house[416] = 275  -- "Lord Markham's Chamber"
evt.map[416] = function()
	if evt.Cmp("MapVar4", 2) then
		evt.StatusText(21)         -- "This Door has Been Locked"
		evt.FaceAnimation{Player = "Current", Animation = 18}
	else
		evt.EnterHouse(275)         -- "Lord Markham's Chamber"
	end
end

evt.hint[451] = evt.str[100]  -- ""
evt.map[451] = function()
	if not evt.Cmp("MapVar4", 1) then
		evt.SpeakNPC(283)         -- "Guard"
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

evt.hint[501] = evt.str[2]  -- "Leave Lord Markham's Manor"
evt.map[501] = function()
	evt.MoveToMap{X = 11012, Y = -14936, Z = 384, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 8, Name = "Out13.odm"}
end

