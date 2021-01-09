local A, B, C, D, E, F = 0, 1, 2, 3, 4, 5

--[[
This example demonstrates a complex branched dialog.
It isn't too easy to understand, but it's elegant.
It also shows how you can have item name as topic name and some other bells and whistles.
Go to the Clan Leader's Hall in Dagger Wound to see it in action.
--]]

local MyNPC = 2  -- Dadeross in the lizards tavern

-- For fun: play sound when entering the conversation
function events.EnterNPC(npc)
	if npc == MyNPC then
		Game.PlaySound(130)  
	end
end

local function SetBranch(t)
	QuestBranch(t.NewBranch)
end

local function ItemTopic(t)
	-- return 'false' if the quest is given, which means the item is given away
	return not vars.Quests[t.Name] and Game.ItemsTxt[t.MyItem].Name
end

local function GiveItem(t)
	evt.ForPlayer().Add("Inventory", t.MyItem)  -- give item
	-- Game.PlaySound(205)  -- make only sound
	evt.Add("Experience", 0)  -- make sound and animation
	evt.FaceAnimation(Game.CurrentPlayer, const.FaceAnimation.SmileHuge)  -- a happy face
	QuestBranch("Thanks")
end

-- sipmlify similar quests creation
local QuestBase = {}
local function MyQuest(t)
	table.copy(QuestBase, t)  -- copy common values
	QuestBase.Slot = QuestBase.Slot and QuestBase.Slot + 1  -- auto-increment Slot
	return Quest(t)
end

--[[
Now, let's get to the quests themselves.

Dialog structure:

- Weapons
  - Swords
    - Sword 1
    - Sword 2
    - Sword 3
  - Daggers
    - Dagger 1
  - Axes
    - Axe 1
    - Axe 2
    - Axe 3
  - Blasters
- Magic
  - Book 1
  - Book 2
  - Book 3
  - Book 4
- Dadeross' Letter to Fellmoon
- Certificate of Authentication (for Axe of Balthazar)
(+ Thanks screen)
]]

QuestNPC = MyNPC

-- greeting

Greeting{
	"I'm placed here to give you free stuff.",
	"Please choose your free stuff.",
}

-- default topics

QuestBase = {Slot = A}

-- get rid of standard topics of this NPC
MyQuest{}
MyQuest{}
MyQuest{}
MyQuest{}
MyQuest{}
-- A topic that's shown when there are no items left. This one is a bit hackish.
-- Since the quest-matching function goes from slot A to slot F, by the time it
-- asks for topic in slot F it has done all other slots. So, I check that these
-- slots have no topics and then enable the topic of this slot
MyQuest{
	Ungive = SetBranch,
	NewBranch = "",
	GetTopic = function(t)
		for i = 0, 4 do
			if Game.NPC[MyNPC].Events[i] ~= 0 then
				return
			end
		end
		return t.Texts.Topic
	end,
	Texts = {
		Topic = "Sorry, I don't have any of these",
		Ungive = "Sorry, I don't have any of these. Maybe you want something else?"
	}
}

-- base branch topics

QuestBase = {Branch = "", Slot = A, Ungive = SetBranch}

MyQuest{
	NewBranch = "Weapons",
	Texts = {
		Topic = "Weapons",
		Ungive = "Choose which you prefer."
	}
}
MyQuest{
	NewBranch = "Magic",
	Texts = {
		Topic = "Magic",
		Ungive = "I have a few books."
	}
}

-- Weapons branch

QuestBase = {Branch = "Weapons", Slot = A, Ungive = SetBranch}

MyQuest{
	NewBranch = "Swords",
	Texts = {
		Topic = "Swords",
	}
}
MyQuest{
	NewBranch = "Daggers",
	Texts = {
		Topic = "Daggers",
	}
}
MyQuest{
	NewBranch = "Axes",
	Texts = {
		Topic = "Axes",
	}
}
MyQuest{
	NewBranch = "Blasters",
	Texts = {
		Topic = "Blasters",
	}
}

-- Swords branch

QuestBase = {
	Branch = "Swords", Slot = A,
	GetTopic = ItemTopic,
	Give = GiveItem,
	Texts = {
		Give = "Use it well!"
	}
}

MyQuest{MyItem = 1}
MyQuest{MyItem = 10}
MyQuest{MyItem = 502}

-- Daggers branch

QuestBase = table.copy(QuestBase, {
	Branch = "Daggers", Slot = A,
})

MyQuest{MyItem = 508}

-- Axes branch

QuestBase = table.copy(QuestBase, {
	Branch = "Axes", Slot = A,
})

MyQuest{MyItem = 34}
MyQuest{MyItem = 37}
MyQuest{MyItem = 541}

-- Magic branch

QuestBase = table.copy(QuestBase, {
	Branch = "Magic", Slot = A,
})

MyQuest{MyItem = 460}
MyQuest{MyItem = 430}
MyQuest{MyItem = 444}
MyQuest{MyItem = 404}

-- Letter and Certificate of Authentication items in main branch

QuestBase = table.copy(QuestBase, {
	Branch = "", Slot = C,
})

MyQuest{MyItem = 741}  -- Dadeross' Letter to Fellmoon
MyQuest{MyItem = 732,  -- Certificate of Authentication
	CanShow = function()
		return evt.All.Cmp("Inventory", 541)  -- check for Axe of Balthazar
	end
}

-- Thanks branch

NPCTopic{
	Branch = "Thanks", Slot = A,
	Ungive = SetBranch,
	NewBranch = "",
	"Thanks!",
	"Maybe you want something else?",
}

--[[
Here's how dialog branches work:

A quest with Branch field is only shown if that's the current branch.

Current branch can be set with QuestBranch function:
 QuestBranch("BranchName")
You can also make the branch persist after you reenter NPC dialog:
 QuestBranch("BranchName", true)
Or you can obtain current branch:
 local branch = QuestBranch()

If there is no persisted branch name, when you enter NPC dialog the branch is set to "".

Branches support is really simple. Previous version of this example implemented it manually.
]]