
--[[
This is the simplest quest example. Go to the Clan Leader's Hall in Dagger Wound to see it in action.
It utilises new NPCTopic function for more convenient creation of simple text-only topics.
It also uses new Quest function ability to automatically find free quest slot if the Slot parameter isn't specified.
Texts are set using SetTexts function to reduce indentation level.
--]]

QuestNPC = 32  -- Frederick Talimere

-- another way to make a greeting
Greeting{
	"Hello, world!",
	"Hi.",
}

-- a simple text topic
NPCTopic{
	"Blah 1",
	"Blah Blah Blah",
}

-- a simple quest: require item #1 (Longsword), give 1000 exp, 1000 gold and an artifact hat
Quest{
	"SimpleExampleQuest",
	QuestItem = 1,  -- quest item index (Longsword)
	Gold = 1000,  -- reward: gold
	Exp = 1000,  -- reward: experience
	RewardItem = 536,  -- reward: Lucky Hat
}
.SetTexts{
	Topic = "Quest",
	Give = "I need a Longsword!",
	
	Done = "That's the sword I was looking for! Thank you! I have this hat and some gold coins for you!",
	Undone = "You don't have the sword yet?",

	After = "Thank you for the sword!",
	
	Quest = "Bring a Longsword (the most basic of swords) to Frederick Talimere on Dagger Wound Islands.",
}

-- another simple text topic
NPCTopic{
	"Blah 2",
	"Second Blah Blah Blah!",
}

--[[
NPCTopic{topic, text} and Greeting{firstGreet, greet} functions just call Quest function with appropriate parameters.
You can specify any parameters you would normally pass to Quest function, like Slot, CanShow etc.
Note that if you pass a number as topic to NPCTopic function, it will set StdTopic to that number.
See Quest Example.lua for details on StdTopic and other parameters of Quest function.


The call of Greeting function in this script is equivalent to this:
Quest{
	Slot = -1,
	Texts = {
		FirstGreet = "Hello, world!",
		Greet = "Hi.",
	}
}

The first call of NPCTopic function is equivalent to this:
Quest{
	Texts = {
		Topic = "Blah 1",
		Ungive = "Blah Blah Blah",
	}
}
]]