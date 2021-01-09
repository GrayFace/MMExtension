local A, B, C, D, E, F = 0, 1, 2, 3, 4, 5
local Q = vars.Quests

--[[
This is an example of a simple quest, dialog topics that depend on quest state and a 'sell item' topic.
Mostly it consists of texts rather than code. Go to the Clan Leader's Hall in Dagger Wound to see it in action.
It also demonstrates short functions syntax addon (see help for more info).
--]]

QuestNPC = 1  -- The lizard in the tavern

-- a simple quest: require item #1 (Longsword), give 1000 exp, 1000 gold and an artifact hat
Quest{
	"ExampleQuest",  -- Same as:  Name = "ExampleQuest",
	Slot = A,
	Texts = {
		FirstGreet = "Hello, world!",
		Greet = "Hi.",
		
		Topic = "Quest!",
		Give = "I need a Longsword!",

		GreetGiven = "How's it going?",
		-- TopicGiven can be set as well, but I keep it at "Quest!" here
		Done = "That's the sword I was looking for! Thank you! I have this hat and some gold coins for you!",
		Undone = "You don't have the sword yet?",
		
		GreetDone = "Greetings to you, The Man Who Gave The Sword!",
		TopicDone = "Thanks!",
		After = "Thank you for the sword!",
		
		Quest = "Bring a Longsword (the most basic of swords) to that lizard in the tavern of Dagger Wound Islands.",
	},
	QuestItem = 1,  -- quest item index (Longsword)
	Gold = 1000,  -- reward: gold
	Exp = 1000,  -- reward: experience
	RewardItem = 536,  -- reward: Lucky Hat
}

-- this will hide the standard topic in slot B
Quest{
	Slot = B,
}

-- this will hide the standard topic in slot C
Quest{
	Slot = C,
}

-- this topic is shown only when the quest is taken
Quest{
	Slot = C,
	CanShow = || Q.ExampleQuest == "Given",  -- a check that the quest is taken (short function!)
	-- Short function syntax language extension translates this into:
	-- CanShow = function()
	-- 	return Q.ExampleQuest == "Given"
	-- end,
	
	Texts = {
		Topic = "Reverse Engineering",
		Ungive = "If you bring me the sword, I can reverse-engineer it and make its copies. To tell you the truth, everything here is reverse-engineered.",
	},
}

-- this topic is shown only when the quest is done in place of the topic above (sell swords)
Quest{
	Slot = C,
	CanShow = || Q.ExampleQuest == "Done",  -- a check that the quest is finished (short function!)
	Texts = {
		Topic = "Buy Longsword for 50 gold",
		Done = "Here's a sword I made for you!",
		Undone = "No money - no Longsword, honey."
	},
	NeverGiven = true,  -- skip "Given" state, perform Done/Undone check immediately
	NeverDone = true,  -- sell any number of swords. This makes the quest completable mutiple times
	QuestGold = 50,  -- pay: 50 gold
	RewardItem = 1,  -- reward: Longsword
}

--[[

Other Quest properties:
 StdTopic                     -- use the standard topic with specified number. For example, a trainer topic or "Join" topic.
 StdTopicGiven, StdTopicDone  -- similarly, standard topics specific to Given and Done states.
 FirstStdTopic                -- standard topics specific to initial (ungiven) state.
 Quest                        -- quest number in quests.txt, by default it's allocated automatically
 BaseName                     -- for quests that require you to go from one NPC to another. Setting BaseName makes two quests share the same quest state defined by BaseName. See "Quest With 2 NPCs.lua".
 GivenState                   -- by default it's "Given". This may be useful in a quest with many stages.
 DoneState                    -- by default it's "Done". This may be useful in a quest with many stages.

If you don't pass Slot, any slot not occupied by an MMExt quest will be chosen. If you pass "same" as Slot value, the last used slot will be reused.


Localization:
To generate localization template for all scripts, press Ctrl+F1, write
 GenerateLocalization()
and press Ctrl+Enter. It will generate the following items in Scripts\Localization folder:
 Quests.txt   -- for quests
 Common.txt   -- for strings passed to LocalizeAll function
 Scripts.txt  -- for strings passed to Localize function
These files should be edited with Txt Tables Editor from my site.
Alternatively, run GenerateLocalization(true) to generate *.lua localization files. Choose whichever format you prefer.
To generate localization for quests only you can use GenerateQuestsLocalization() instead of GenerateLocalization() command.
To generate localization excluding quests you can use GenerateLocalization(false, false) command.
Note that GenerateLocalization function assumes your scripts contain up to 1 use of LocalizeAll and up to 1 use of Localize function, both of which are at the beginning of the script.

To test localization changes without restarting the game you can create a script in Globals folder with this line:
 ReloadLocalization()
Then you'll only need to reload a saved game to refresh localization.


For more complex quests you can set up the following functions:
(here 't' is the table that you passed to the Quest function, it also has some new fields set by Quest function)

Checks (return value is interpreted as true or false):
 CanShow(t)
 CheckGive(t)
 CheckDone(t)

Called on corresponding events:
 Give(t)
 Ungive(t)
 Done(t)
 Undone(t)

For complete control - these will override default behavior:
 GetGreeting(t, NotFirstVisit)
 GetTopic(t)
 Execute(t)
 IsGiven(t)

GetGreeting and GetTopic functions return a string.

Note that you can also make custom quest states. Say, you have a quest called MyQuest. If you set vars.Quests.MyQuest = "MyState", Texts.TopicMyState (or StdTopicMyState) will be displayed. When you click it, Texts.MyState will be displayed and MyState function will be called.

]]
