local A, B, C, D, E, F = 0, 1, 2, 3, 4, 5
local Q = vars.Quests

--[[
This is an example of a quest that requires you to go from one NPC to another.
Also demonstrates usage of StdTopic to make NPC join the party.
Like in Quest Example.lua, short function syntax addon is utilized.
--]]


QuestNPC = 1  -- The lizard in the tavern

-- quest start: take the quest in the tavern
Quest{
	"PowerStone",
	Slot = D,
	GivenItem = 617,  -- gives Power Stone upon giving the task
	CheckDone = false,  -- the quest can't be completed here
}
.SetTexts{
	Topic = "Frederick Talimere",
	TopicDone = false,  -- don't show if it's done
	Give = "Show this stone to Frederick Talimere. He will be interested.",
	Undone = "Yes, just a stone. Frederick is obsessed with these stones. What a fool...",
	
	Quest = "Show a stone to Frederick Talimere in Dagger Wound Islands.",
}



QuestNPC = 32  -- Frederick Talimere

-- quest end: talk to Frederick to get the stone
Quest{
	BaseName = "PowerStone",
	Slot = D,
	Exp = 1000,  -- reward: experience
	QuestItem = 617,  -- need Power Stone
	KeepQuestItem = true,  -- don't take power stone away
}
.SetTexts{
	-- no Topic - don't show the topic if the quest isn't taken
	TopicGiven = "Power Stone",
	TopicDone = "Power Stone",
	Done = "Wow, this is a stone! I love stones!",
	Undone = "One lizard told me you have a stone, and so do I. Why don't you show me yours and I'll show you mine?",
	After = "I have about 30 of these stones. You know what, let's go looking for stones together! But I need to get a sword first. Because who knows, we might meet some enemies on our way. With a sword in my hands I'll look more persuasive and will calm down any enemy. Trust me, negotiations are my thing!",
}

-- show Join topic when both example quests are completed
Quest{
	Slot = D,
	StdTopic = 602,  -- Join topic of Frederick Talimere
	CanShow = || Q.PowerStone == "Done" and Q.SimpleExampleQuest == "Done",
}
