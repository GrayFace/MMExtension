local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Leave the Cave",
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
}
table.copy(TXT, evt.str, true)

Game.MapEvtLines.Count = 0  -- Deactivate all standard events


evt.hint[1] = evt.str[100]  -- ""
evt.map[1] = function()  -- function events.LoadMap()
	if not evt.Cmp("QBits", 23) then         -- Killed dragon when on Crusader quest
		if evt.Cmp("NPCs", 17) then         -- "Sir Charles Quixote"
			evt.SetMonGroupBit{NPCGroup = 5, Bit = const.MonsterBits.Invisible, On = false}         -- "Generic Monster Group for Dungeons"
		end
	end
end

events.LoadMap = evt.map[1].last

evt.hint[176] = evt.str[1]  -- "Door"
evt.map[176] = function()
	evt.OpenChest(1)
end

evt.hint[177] = evt.str[1]  -- "Door"
evt.map[177] = function()
	evt.OpenChest(2)
end

evt.hint[178] = evt.str[1]  -- "Door"
evt.map[178] = function()
	evt.OpenChest(3)
end

evt.hint[179] = evt.str[1]  -- "Door"
evt.map[179] = function()
	evt.OpenChest(4)
end

evt.hint[180] = evt.str[1]  -- "Door"
evt.map[180] = function()
	evt.OpenChest(5)
end

evt.hint[181] = evt.str[1]  -- "Door"
evt.map[181] = function()
	evt.OpenChest(6)
end

evt.hint[182] = evt.str[1]  -- "Door"
evt.map[182] = function()
	evt.OpenChest(7)
end

evt.hint[183] = evt.str[1]  -- "Door"
evt.map[183] = function()
	evt.OpenChest(8)
end

evt.hint[184] = evt.str[1]  -- "Door"
evt.map[184] = function()
	evt.OpenChest(9)
end

evt.hint[185] = evt.str[1]  -- "Door"
evt.map[185] = function()
	evt.OpenChest(10)
end

evt.hint[186] = evt.str[1]  -- "Door"
evt.map[186] = function()
	evt.OpenChest(11)
end

evt.hint[187] = evt.str[1]  -- "Door"
evt.map[187] = function()
	evt.OpenChest(12)
end

evt.hint[188] = evt.str[1]  -- "Door"
evt.map[188] = function()
	evt.OpenChest(13)
end

evt.hint[189] = evt.str[1]  -- "Door"
evt.map[189] = function()
	evt.OpenChest(14)
end

evt.hint[190] = evt.str[1]  -- "Door"
evt.map[190] = function()
	evt.OpenChest(15)
end

evt.hint[191] = evt.str[1]  -- "Door"
evt.map[191] = function()
	evt.OpenChest(16)
end

evt.hint[192] = evt.str[1]  -- "Door"
evt.map[192] = function()
	evt.OpenChest(17)
end

evt.hint[193] = evt.str[1]  -- "Door"
evt.map[193] = function()
	evt.OpenChest(18)
end

evt.hint[194] = evt.str[1]  -- "Door"
evt.map[194] = function()
	evt.OpenChest(19)
end

evt.hint[195] = evt.str[1]  -- "Door"
evt.map[195] = function()
	evt.OpenChest(0)
end

evt.hint[376] = evt.str[100]  -- ""
evt.map[376] = function()  -- Timer(<function>, 3.5*const.Minute)
	if evt.Cmp("QBits", 22) then         -- "Kill Wromthrax the Heartless in his cave in Tatalia, then talk to Sir Charles Quixote."
		if not evt.Cmp("QBits", 23) then         -- Killed dragon when on Crusader quest
			if evt.CheckMonstersKilled{CheckType = 1, Id = 5, Count = 1} then
				evt.ForPlayer("All")
				evt.Set("QBits", 23)         -- Killed dragon when on Crusader quest
				evt.SetNPCGreeting{NPC = 17, Greeting = 0}         -- "Sir Charles Quixote" : ""
				evt.SpeakNPC(17)         -- "Sir Charles Quixote"
			end
		end
	end
end

Timer(evt.map[376].last, 3.5*const.Minute)

evt.hint[501] = evt.str[2]  -- "Leave the Cave"
evt.map[501] = function()
	evt.MoveToMap{X = -1037, Y = 21058, Z = 2656, Direction = 1536, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 4, Name = "out13.odm"}
end

