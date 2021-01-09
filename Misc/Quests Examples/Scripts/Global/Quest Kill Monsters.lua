
--[[
These are 2 example quests that require killing multiple kinds of monsters.
Go to the Clan Leader's Hall in Dagger Wound to see the quests in action.
--]]

QuestNPC = 182  -- Dirthic, an empty NPC in a house on an island

evt.MoveNPC(QuestNPC, 173)  -- move him to Clan Leader's Hall


-- Quest 1: Kill all pirates
KillMonstersQuest{
	-- quest name is optional
	{Map = "out01.odm", Monster = {181, 182, 183}},
	
	Exp = 2000,
	Gold = 2000,
}
.SetTexts{
	Greet = "Hi there!",
	
	Topic = "Pirates!",
	Give = "Kill all da Pirates on Dagger Wound Islands.",
	Done = "It's great that you've killed them! 2000 gold for you.",
	Undone = "Just kill 'em, ok?",
	TopicDone = false,  -- hide the topic when the quest is completed
	
	Quest = "Kill all Pirates on Dagger Wound Islands. Return to Dirthic in Clan Leader's Hall.",
	Killed = "You have killed all Pirates!",  -- completion message
}


-- Quest 2: Kill all creatures in Abandoned Temple
KillMonstersQuest{
	"ClearAbandonedTemple",  -- quest name
	
	{Map = "d05.blv", Monster = {7, 8, 9}},
	"You have killed all Couatls! Serpentmen are yet to be killed.",  -- partial completion message (optional)
	{Map = "d05.blv", Monster = {94, 95, 96}},
	"You have killed all Serpentmen! Some Couatls are alive.",  -- partial completion message (optional)

	Exp = 5000,
	Gold = 5000,
}
.SetTexts{
	Topic = "Snakes!",
	Give = "Kill all of them creatures in Abandoned Temple.",
	Done = "It's great that you've killed them! 5000 gold for you.",
	Undone = "Just kill 'em, ok?",
	TopicDone = false,  -- hide the topic when the quest is completed
	
	Quest = "Kill all creatures in Abandoned Temple. Return to Dirthic in Clan Leader's Hall.",
	Killed = "You have killed all Couatls and Serpentmen!",  -- completion message
}

--[[
KillMonstersQuest function takes a list of tasks that it checks with CheckMonstersKilled.
Here are ways of using CheckMonstersKilled:
 CheckMonstersKilled{}                  -- killed all monsters on the map?
 CheckMonstersKilled{Group = 1}         -- killed all monsters belonging to group 1?
 CheckMonstersKilled{Monster = 7}       -- killed all monsters of kind 7 (Young Couatl)?
 CheckMonstersKilled{NameId = 3}        -- killed all monsters with NameId = 3 in placemon.txt (Dragon Hunter Pet)?
 CheckMonstersKilled{MonsterIndex = 5}  -- killed monster with index 5 in Map.Monsters array?
Instead of a single number you can pass a table with numbers, like I do in this example.
Additonal parameters:
 Count             -- need to kill at least this many monsters
 InvisibleAsDead   -- treat invisible (that is, currently disabled) monsters as dead when counting (MM8 only. 'true' by default)

MM6 currently isn't supported, because it doesn't have evt.CheckMonstersKilled command. InvisibleAsDead = false is only supported in MM8.

KillMonstersQuest tasks have an extra required Map parameter. A quest can span across multiple maps.

You can specify partial completion messages. They are placed after a group of tasks. For example:
{task1},
{task2},
{task3},
"first 3 tasks done",
{task4},
{task5},
"tasks 4 and 5 done",
{task6},
"task 6 done",

KillMonstersQuest adds completion messages to Texts under names Killed1, Killed2, Killed3 and so on, for localization.

KillMonstersQuest supports all parameters of Quest function. It sets Quest parameter to 'true' if it isn't specified.
]]