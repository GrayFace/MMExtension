local A, B, C, D, E, F = 0, 1, 2, 3, 4, 5

--[[
This is an example of an alchemic quest like those seen in MM8. It works smarter by removing weaker ingredients first.
It replaces default quest of Thistle that normally makes a Potion of Pure Speed.
Like the example with 2 NPCs, it uses BaseName property to make a cross-topic quest easily.
Then there is some stuff just for fun: I reinitiate a conversation 2 minutes after the quest is completed and show some text.
--]]

QuestNPC = 88  -- Thistle


Quest{  -- Get quest
	"StreetAlchemy",
}
.SetTexts{
	FirstTopic = "Street Alchemy",  -- only show if it isn't given
	Give = "Hey! Hey fellas! I'm chronicling a Street Alchemy special. You wanna see some alchemy?",
	Quest = "Bring Thistle on the Dagger Wound Islands the basic ingredients for a Potion of Disappearance.",
}


NPCTopic{  -- Ingredients topic
	"Ingredients",
	"Ultimate Potions are made of a complex blending of the three basic ingredients: Swords, Boots and Armor. Potion of Disappearance requires 6 Longswords, 2 pairs of boots and 2 leather armors."
}


Quest{  -- Finish quest
	BaseName = "StreetAlchemy",
	QuestItem = {
		{1,2,3,4,5, Count = 6},            -- all kinds of Longswords, 6 in total
		{132,133,134,135,136, Count = 2},  -- all kinds of Boots, 2 in total
		{84,85,86,87,88, Count = 2},       -- all kinds of Leather Armor, 2 in total
	},
	Exp = 1000,
	RewardItem = 535,  -- Ring of Fusion
	Done = function(t)
		evt.Add("Inventory", 220)  -- add an empty bottle to make it appear as if it's the reward
		
		-- now make him speak to us again after some time
		local npc = QuestNPC  -- QuestNPC is set to NPC being spoken to in a dialog
		Sleep(const.Minute*3, nil, {0})  -- sleep for 3 minutes and only wake up when no dialog is active (hence, the 3rd parameter)
		evt.SpeakNPC(npc)
	end
}
.SetTexts{
	TopicGiven = "Do you have the Ingredients?",  -- only show if it's given
	Done = "Hey look, the Potion of Disappearance has disappeared! Take this empty bottle, it's yours now.",
	Undone = "You are missing all or some of the needed ingredients. Remember, to make a Potion of Disappearance I need 6 Longswords, 2 pairs of boots and 2 leather armors.",
}


Quest{  -- Instead of Ingredients topic
	Slot = B,
	CanShow = |t| Game.CurrentScreen ~= const.Screens.House,  -- only show if NPC was met on the street
}
.SetTexts{
	Greet = "I think there's something in your backpack...",
}