-- Deactivate all standard events
Game.GlobalEvtLines.Count = 0

-- ERROR: Duplicate label: 352:8

-- "Greetings!"
evt.global[1] = function()
	local i
	evt.SetMessage(3)         --[[ "Greetings!  I am the one known as The Seer and I will be your guide through much of your adventure. But before we can begin, you must select the type of game you'd like to play.  Here are your choices; 

(1) Adventurer. You will traverse the lands to solve quests and gain bounty, while encountering moderate opposition.  
(2) Warrior. You will hone your tactical skills against much tougher opponents as you journey through The Game. 
(3) Should you be so foolish to select the Meanest Mother Fracker, you will indeed fulfill your Death Wish, as you develop into the ultimate Connoisseur of Fine Carnage, constantly battling your way to The End.

Choose wisely, my little heroes! Which one will it be?" ]]
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 2}         -- "The Seer" : "Adventurer"
	evt.SetNPCTopic{NPC = 18, Index = 1, Event = 3}         -- "The Seer" : "Warrior"
	evt.SetNPCTopic{NPC = 18, Index = 2, Event = 4}         -- "The Seer" : "Meanest Mother  Fracker in the Valley"
	i = Game.Rand() % 6
	if i == 3 then
		evt.MoveNPC{NPC = 162, HouseId = 106}         -- "Dexter  D. Fraud" -> "Rockham's Pride"
		evt.MoveNPC{NPC = 104, HouseId = 117}         -- "Thomas A. Varice" -> "Secure Trust"
	elseif i == 4 then
		evt.MoveNPC{NPC = 104, HouseId = 117}         -- "Thomas A. Varice" -> "Secure Trust"
		evt.MoveNPC{NPC = 51, HouseId = 85}         -- "Thornton Thuggly" -> "Royal Gymnasium"
		evt.MoveNPC{NPC = 195, HouseId = 75}         -- "Monsignor Hyppo Krit" -> "Avalon Ministries"
	elseif i == 5 then
		evt.MoveNPC{NPC = 51, HouseId = 80}         -- "Thornton Thuggly" -> "The Academy"
		evt.MoveNPC{NPC = 195, HouseId = 76}         -- "Monsignor Hyppo Krit" -> "King's Temple"
		evt.MoveNPC{NPC = 65, HouseId = 94}         -- "Laura Lucious" -> "An Arrow's Flight"
	end
end

-- "Adventurer"
evt.global[2] = function()
	local i
	evt.SetMessage(2)         --[[ "As you have chosen, so shall it be!

Oh! And your friend Tamara, she's not likely to show up here.

So here's your first Quest; Find Tamara.

You might start looking for her in her home in Ellesia.  You can book passage to these islands on the Tropical Whisper.  She's docked over there to your right.

Before you leave for Ellesia, you might want to purchase some equipment.  Might I suggest bows?  There's a weapons shop behind you, right around the corner.  You should be able to find what you need there.

Good Luck!" ]]
	evt.Set("QBits", 82)         -- "Find and destroy the Chalice of the Gods"
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 1, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 2, Event = 0}         -- "The Seer"
	evt.Add("QBits", 509)         -- Void Fountain1
	i = Game.Rand() % 6
	if i == 1 or i == 2 then
		evt.MoveNPC{NPC = 162, HouseId = 106}         -- "Dexter  D. Fraud" -> "Rockham's Pride"
		evt.MoveNPC{NPC = 104, HouseId = 117}         -- "Thomas A. Varice" -> "Secure Trust"
	elseif i == 3 or i == 4 then
		evt.MoveNPC{NPC = 104, HouseId = 117}         -- "Thomas A. Varice" -> "Secure Trust"
		evt.MoveNPC{NPC = 51, HouseId = 85}         -- "Thornton Thuggly" -> "Royal Gymnasium"
		evt.MoveNPC{NPC = 195, HouseId = 75}         -- "Monsignor Hyppo Krit" -> "Avalon Ministries"
	elseif i == 5 then
		evt.MoveNPC{NPC = 51, HouseId = 80}         -- "Thornton Thuggly" -> "The Academy"
		evt.MoveNPC{NPC = 195, HouseId = 76}         -- "Monsignor Hyppo Krit" -> "King's Temple"
		evt.MoveNPC{NPC = 65, HouseId = 94}         -- "Laura Lucious" -> "An Arrow's Flight"
	end
end

-- "Warrior"
evt.global[3] = function()
	evt.SetMessage(2)         --[[ "As you have chosen, so shall it be!

Oh! And your friend Tamara, she's not likely to show up here.

So here's your first Quest; Find Tamara.

You might start looking for her in her home in Ellesia.  You can book passage to these islands on the Tropical Whisper.  She's docked over there to your right.

Before you leave for Ellesia, you might want to purchase some equipment.  Might I suggest bows?  There's a weapons shop behind you, right around the corner.  You should be able to find what you need there.

Good Luck!" ]]
	evt.Set("QBits", 82)         -- "Find and destroy the Chalice of the Gods"
	evt.Set("QBits", 508)         -- Void Fountain2
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 1, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 2, Event = 0}         -- "The Seer"
	evt.Add("QBits", 509)         -- Void Fountain1
	evt.MoveNPC{NPC = 104, HouseId = 117}         -- "Thomas A. Varice" -> "Secure Trust"
	evt.MoveNPC{NPC = 51, HouseId = 85}         -- "Thornton Thuggly" -> "Royal Gymnasium"
	evt.MoveNPC{NPC = 195, HouseId = 75}         -- "Monsignor Hyppo Krit" -> "Avalon Ministries"
end

-- "Meanest Mother  Fracker in the Valley"
evt.global[4] = function()
	evt.SetMessage(2)         --[[ "As you have chosen, so shall it be!

Oh! And your friend Tamara, she's not likely to show up here.

So here's your first Quest; Find Tamara.

You might start looking for her in her home in Ellesia.  You can book passage to these islands on the Tropical Whisper.  She's docked over there to your right.

Before you leave for Ellesia, you might want to purchase some equipment.  Might I suggest bows?  There's a weapons shop behind you, right around the corner.  You should be able to find what you need there.

Good Luck!" ]]
	evt.Set("QBits", 82)         -- "Find and destroy the Chalice of the Gods"
	evt.Set("QBits", 508)         -- Void Fountain2
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 1, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 18, Index = 2, Event = 0}         -- "The Seer"
	evt.Set("QBits", 507)         -- Void Fountain3
	evt.Add("QBits", 509)         -- Void Fountain1
	evt.MoveNPC{NPC = 162, HouseId = 106}         -- "Dexter  D. Fraud" -> "Rockham's Pride"
	evt.MoveNPC{NPC = 104, HouseId = 113}         -- "Thomas A. Varice" -> "Booty's Hold"
	evt.MoveNPC{NPC = 51, HouseId = 80}         -- "Thornton Thuggly" -> "The Academy"
	evt.MoveNPC{NPC = 195, HouseId = 76}         -- "Monsignor Hyppo Krit" -> "King's Temple"
	evt.MoveNPC{NPC = 65, HouseId = 94}         -- "Laura Lucious" -> "An Arrow's Flight"
end

-- "Audience with the Baroness"
evt.global[5] = function()
	evt.SetMessage(455)         -- "Away with you, beggars!  Only those high diplomats who are honorable in their deportment may see the Baroness!!"
end

-- "Thank you!"
evt.global[6] = function()
	evt.ForPlayer("All")
	evt.SetMessage(1)         --[[ "“Thank you for freeing me from that cage!  Oh, I’m so hungry.  You don’t mind if I partake of your food, do you?  Ummm.  Good.

I’m Tobin, Acolyte of the Ellesian Temple.  I was harmlessly gathering some herbs on these outer islands when these fanatics grabbed me and imprisoned me in that cage!  I suspect that they were going to ransom me for gold.  If you could safely return me to my temple, I could offer you a reward fitting of your services.

Oh!  I can also heal your party of all wounds while we travel, but I can only perform this service twice.  So use me sparingly.  Let’s get going, ok?”" ]]
	evt.Set("Food", 0)
	evt.Set("QBits", 83)
	evt.SetNPCTopic{NPC = 110, Index = 0, Event = 7}         -- "Tobin" : "Do you know Tamara?"
end

-- "Do you know Tamara?"
evt.global[7] = function()
	evt.SetMessage(5)         -- "Of course I know her!  Quite the adventurer, that one!  Last time I saw her, she was off to the Mainland to visit her brother in Sutter's Bay. I don’t know if she’s returned to Ellesia yet, though."
	evt.SetNPCTopic{NPC = 110, Index = 0, Event = 8}         -- "Tobin" : "Heal Party"
end

-- "Heal Party"
evt.global[8] = function()
	evt.SetMessage(456)         -- "As you wish!"
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 504) then         -- Tobin Heal
		evt.Set("HasFullHP", 0)
		evt.Set("HasFullSP", 0)
		evt.Subtract("Unconscious", 0)
		evt.SetNPCTopic{NPC = 110, Index = 0, Event = 398}         -- "Tobin" : "Heal Party"
	else
		evt.Set("HasFullHP", 0)
		evt.Set("QBits", 504)         -- Tobin Heal
		evt.Set("HasFullSP", 0)
		evt.Subtract("Unconscious", 0)
	end
end

-- "Quest"
evt.global[9] = function()
	evt.ForPlayer("All")
	evt.SetMessage(4)         --[[ "Welcome young adventurers, I have a proposition to make.  In my younger days I was quite the brigand. I captured many ships, pillaged countless villages and gained enormous wealth.  Ah but those good old days are gone, aren't they?

Now to the proposition.  My former associates, in a most uncharitable act, procured two items of treasure from me.  I would like you to 'reacquire' them for me.  These items are the Sorcerer’s Eye and the Jeweled Egg. I know one is hidden in Tortuga Hall, and the other I have heard is hidden somewhere in the Abandoned Temple.  If you manage to get them bring them to me for your reward." ]]
	evt.Set("QBits", 84)         -- Paul
	evt.SetNPCTopic{NPC = 288, Index = 0, Event = 10}         -- "Aithei Taeyalme " : "We've found the items!"
end

-- "We've found the items!"
evt.global[10] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 480) then         -- "Jeweled Egg"
		if evt.Cmp("Inventory", 446) then         -- "Sorcerer's Eye"
			evt.SetMessage(7)         -- "I thought your group had the look of the Swashbuckler and look at that my prizes.  Well I won’t bore you with all of the details of my exploits and valiant deeds needed to acquire these in the first place.  Sea monsters, challenging the gods themselves, but I digress, here is your reward.  Go with my thanks."
			evt.Subtract("Inventory", 446)         -- "Sorcerer's Eye"
			evt.Subtract("Inventory", 480)         -- "Jeweled Egg"
			evt.Subtract("QBits", 84)         -- Paul
			evt.Add("Awards", 1)         -- "Entered The VOID"
			evt.Add("Experience", 5000)
			evt.Add("Gold", 500)
			evt.SetNPCTopic{NPC = 288, Index = 0, Event = 0}         -- "Aithei Taeyalme "
			return
		end
	end
	evt.SetMessage(6)         -- "Sorry I don’t pay for jobs not done and I don’t extend credit, come back for your reward after you have both items, not before."
end

-- "Can ya do me a favor?"
evt.global[11] = function()
	evt.SetMessage(8)         -- "I have a job for a group of adventurers that will require some travel.  You may have heard of troubles in the north?  Well I represent some individuals involved in, well let’s call it ‘research’.  I need to get a report on my findings to Svartkel Jorgen.  He can be found in the city of Jorgsborg in the Demonclaw.  He will reward you for your time, and may have another job for you."
	evt.Set("QBits", 88)         -- Paul
	evt.SetNPCTopic{NPC = 1, Index = 1, Event = 0}         -- "Will Rackham"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 501)         -- "Letter to Svartkel"
end

-- "Letter?"
evt.global[12] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 501) then         -- "Letter to Svartkel"
		evt.SetMessage(9)         --[[ "Come in and shut the door, I’ll draw the blinds.  [He opens the letter, reads it, and then placed it down on a table.]  I assume you have read this.

[You reply] Rackham said nothing of it being confidential.

True, well our employers are looking to branch out and we are always on the lookout for good help.  I need to see if you have what it takes.  There is an artifact that has special significance to my employer.  They want the Crystal of Mana, and will pay a sizable sum for its retrieval.  You are not the first I’ve sent to find it.  The last one thought he was on the right track.  His body was found in The Underground by one of my operatives, this key was found among his possessions.  Maybe it’s important, maybe not.  Bring me the crystal and I’ll pay you well." ]]
		evt.Subtract("Inventory", 501)         -- "Letter to Svartkel"
		evt.Subtract("QBits", 88)         -- Paul
		evt.Add("Awards", 4)         -- "Gained Access to Desolation's End"
		evt.Add("Gold", 1000)
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 353, Index = 0, Event = 49}         -- "Svarktel Jorgen" : "Crystal of Mana"
		evt.Set("QBits", 124)         -- "."
		evt.ForPlayer("Current")
		evt.Add("Inventory", 574)         -- "Common Chest Key"
	else
		evt.SetMessage(28)         -- "Who are you, I’m not expecting anyone.  Now get out!"
	end
end

-- "Paladin"
evt.global[13] = function()
	evt.SetMessage(19)         -- "So you wish to earn promotion to Paladin?  Well you’re in luck.  With the siege broken I am changing my strategy from defense to offense and I will need warriors.  Anyone who thinks the orcs and goblins planned this assault is foolish.  There is a more powerful and evil force behind all of this and I need trained allies.  Prove to me that you can defeat evil by entering the Den of Iniquity in Port Sleigon; this old sanctuary is now home to the Iniquitous Order of Flesh.  Inside is the Sacred Chalice.  Return it to me and those squires that survive will be promoted to Paladin, and the rest will receive an honorary title."
	evt.Add("QBits", 96)         -- Walt
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 14}         -- "Lord Godwinson" : "Sacred Chalice"
end

-- "Sacred Chalice"
evt.global[14] = function()
	if not evt.Cmp("Inventory", 434) then         -- "Sacred Chalice"
		evt.SetMessage(20)         -- "If you cannot do the simple task assigned to you, I will do you a favor and not promote you.  To promote you before you are skilled enough to handle yourself in battle would only ensure your premature death.  You have proven to be a disappointment, now leave before I lose my temper."
		return
	end
	evt.SetMessage(21)         -- "Ah the Sacred Chalice!  You have done well.  The squires are promoted to Paladin and the rest will be known as Honorary Paladins.  My friends you have taken an important first step.  There is a coming battle with dark forces and I need skilled warriors.  Take what time you need to develop your new skills, and when the time is right, come to me and we will talk about further promotion."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Paladin"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Paladin"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Paladin"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Paladin"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Paladin"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Paladin"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Paladin"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Paladin"
	end
	evt.Add("Gold", 5000)
	evt.Subtract("Inventory", 434)         -- "Sacred Chalice"
	evt.Subtract("QBits", 96)         -- Walt
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.Subtract("Inventory", 434)         -- "Sacred Chalice"
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 15}         -- "Lord Godwinson" : "Avenger"
end

-- "Avenger"
evt.global[15] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(22)         -- "My Paladins, I am glad to see you.  I have heard of your exploits and know that the time to give for the test of promotion to Avenger is now.  The evil enemy has yet to reveal itself, but I have my suspicions.  The enemy is enlisting mercenaries to disrupt the resupply convoys between Castle Birka and Port Sleigon.  My offense is being delayed by these repeated attacks.  Go to the Mercenary Stronghold in Port Sleigon, clear it out, kill their leader and bring me his Krukow’s Armor as proof.  I will then promoted the Paladin to Avenger, and the rest will receive the honorary title."
		evt.Add("QBits", 98)         -- NPC
		evt.SetNPCTopic{NPC = 15, Index = 0, Event = 16}         -- "Lord Godwinson" : "Krukow's Armor"
	else
		evt.SetMessage(43)         -- "You are not yet qualified for this second promotion.  Get some experience in you current class and then return to me.  We'll talk then."
	end
end

-- "Krukow's Armor"
evt.global[16] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 407) then         -- "Krukow's Armor"
		evt.SetMessage(23)         -- "Paladins do not show that I was wrong giving you that earlier promotion, everyday you delay increases the loses suffered by my convoys.  Now get out of here and complete your task or we will talk demotion not promotion."
		return
	end
	evt.SetMessage(24)         -- "Well done!  The armor of an important opponent is laid before me.  Well it is neater than a head on a platter isn’t it.  Promotion is granted to the Paladins and the Honorary title to the rest.  Go forth and attack the evil wherever you encounter it, and do all you can to disrupt evil’s plans."
	evt.Add("Experience", 30000)
	evt.Subtract("Inventory", 455)         -- "Demon Claw"
	evt.Subtract("QBits", 98)         -- NPC
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Avenger"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Avenger"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Avenger"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Avenger"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Avenger"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Avenger"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Avenger"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Avenger"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 98)         -- NPC
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 17}         -- "Lord Godwinson" : "Avengers"
	evt.SetNPCTopic{NPC = 14, Index = 2, Event = 30}         -- "Lady Kathryn" : "The Bane of the Sisterhood"
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 89}         -- "The Seer" : "Lady Kathryn"
end

-- "Avengers"
evt.global[17] = function()
	evt.SetMessage(25)         -- "It is always good to speak with Avengers of the realm!  Come back in some less troubled time and we'll swap tales of honor and courage by the fire!"
end

-- "We must hurry!"
evt.global[18] = function()
	if evt.Cmp("QBits", 488) then         -- Tamara Dialog
		evt.SetMessage(13)         -- "We must, with all haste, travel to Kat'an and inform the Seer.  Hurry!"
	else
		evt.SetMessage(12)         --[[ "You sure took your sweet time finding me! [Tamara smiles] But seriously, it's good to see you, my friends!  Thanks for rescuing me!  

There's trouble brewing in the North, my friends. [Tamara relates the rumors of foul creatures invading the lands to the North and to the West].

Quickly!  we must travel to Kat'an and tell the Seer this news!  Perhaps he can verify these rumors and provide us with some direction.

We don't have a moment to spare!  " ]]
		evt.Set("QBits", 488)         -- Tamara Dialog
	end
end

-- "Alarming News!"
evt.global[19] = function()
	evt.SetMessage(11)         --[[ "[Tamara relates the rumors to The Seer] Unfortunately Tamara, they’re more than just rumors.  Several months ago, unnatural and foul creatures began to appear in Demonclaw.  At first their numbers were small and they preyed on helpless merchants and unsuspecting travelers.  But their numbers multiplied, and they became strong, and they laid waste to the land, driving the people into hiding.  The retinue of Lord Godwinson they defeated and drove all to the safety of the castle walls.  Castle Birka is now under siege!

You must, with all haste, travel to the Demonclaw, break through the besieging forces, and gain audience with Lord Godwinson.   Here, take this letter of introduction as your ‘bona fide’. See what you can do to assist the troubled lord.   Return to me when you are done.

Tamara, please remain here.  I have something else in mind for you."" ]]
	evt.Subtract("NPCs", 8)         -- "Tamara"
	evt.Set("QBits", 85)         -- Paul
	evt.ForPlayer("Current")
	evt.Add("Inventory", 515)         -- "Bona  Fide"
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
end

-- "Temple and Tavern"
evt.global[20] = function()
	evt.SetMessage(14)         -- "Because of the seige, Lord Godwinson has setup a Tavern and a Temple within the walls of Castle Birka.  The tavern is in the building accross the way from here, and the temple is around back of that building."
	evt.SetNPCTopic{NPC = 93, Index = 2, Event = 0}         -- "Jed Morrison"
end

-- "Audience"
evt.global[21] = function()
	evt.SetMessage(15)         -- "And what have we here?  [You hand Lord Godwinson the message from The Seer] I see.  You don't look like much, but out of respect to my old friend, The Seer, I'll place you into my service."
	evt.Subtract("QBits", 85)         -- Paul
	evt.Subtract("Inventory", 515)         -- "Bona  Fide"
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 22}         -- "Lord Godwinson" : "Service"
end

-- "Service"
evt.global[22] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 485) then         -- LG 2nd Jorgsburg
		evt.Subtract("QBits", 86)         -- Paul
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 15, Index = 0, Event = 23}         -- "Lord Godwinson" : "The Barracks Keep"
	else
		if evt.Cmp("QBits", 86) then         -- Paul
			evt.SetMessage(16)         -- "There may still be more Orcs to the west of Jorgsborg.  Return to me when you have dispatched them."
			evt.Set("QBits", 406)         -- Birka Timer1
		else
			evt.SetMessage(18)         --[[ "The first order of business is to raise the siege of my castle and then clear the town of Jorgsborg of these foul creatures.

When you have accomplished this return to me for a far more dangerous task."" ]]
		end
	end
end

-- "The Barracks Keep"
evt.global[23] = function()
	if evt.Cmp("Inventory", 545) then         -- "Right Hand Sword of Grish'nak"
		evt.SetMessage(27)         --[[ "Ahh, the Sword of Grish'nak!  She is a beauty, isn't She?

Well done, adventurers!  I hereby release you from your service and declare you the Saviors of Demonclaw!  Keep the sword as a fitting reward for your service not only to me, but to the people of the Demonclaw, as well.  You are always welcome here.  " ]]
		evt.Subtract("QBits", 87)         -- Paul
		evt.ForPlayer("All")
		evt.Add("Experience", 40000)
		evt.Add("Awards", 3)         -- "Touched the Rock of Translation"
		evt.Add("Gold", 2500)
		evt.SetNPCTopic{NPC = 15, Index = 0, Event = 13}         -- "Lord Godwinson" : "Paladin"
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 28}         -- "The Seer" : "Welcome Back"
		evt.Add("ReputationIs", 100)
		evt.Subtract("Inventory", 515)         -- "Bona  Fide"
	else
		if evt.Cmp("QBits", 87) then         -- Paul
			evt.SetMessage(26)         -- "You must return with the Sword of Grish'nak before I can release you from my service."
		else
			evt.SetMessage(17)         --[[ "Is the town now safe?  OK, I'll trust your word on this.  Now, onto that more 'dangerous' task.

A few months ago, the Orcs and their lesser kin, the Goblins, began to plague Demonclaw.  Nothing that my retinue couldn’t handle, though.  We kept them well at-bay.  Last week, a large, well organized force of Orcs, lead by Grish'nak the Terrible, entered Demonclaw, fell upon my guards, and slaughtered my forces in the dead of night.  Cowards!  They have established their stronghold in The Barracks south of the castle.

Here's what I need you to do.  Rid The Barracks of these foul creatures and kill Grish’nak.  Bring me his sword as proof of your deeds and I shall release you from my service.  You'll need this key to enter The Barracks.

Good luck adventurers!" ]]
			evt.Set("QBits", 87)         -- Paul
			evt.ForPlayer("Current")
			evt.Add("Inventory", 490)         -- "Barracks Key"
		end
	end
end

-- "Buy Disarm Skill for 200 gold"
evt.global[24] = function()
	if not evt.Cmp("Gold", 200) then
		evt.SetMessage(260)         -- "You don't have enough gold!"
	else
		if evt.Cmp("DisarmTrapsSkill", 1) then
			evt.SetMessage(29)         -- "You already know this skill!"
		else
			evt.ForPlayer("Current")
			evt.Subtract("Gold", 200)
			evt.Set("DisarmTrapsSkill", 1)
			evt.SetMessage(30)         -- "Done!"
		end
	end
end

-- "Problems in the North"
evt.global[25] = function()
	evt.SetMessage(31)         --[[ "[You relate your recent encounters in Demonclaw to Sir Zeddicus Z'ul the Fifth and your need for his watchfulness]

You waste my time! You problem not my problem. My problem more important! You fix my problem then I help you." ]]
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 26}         -- "Zeddicus Z'ul The Fifth" : "Luftka"
end

-- "Luftka"
evt.global[26] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 448) then         -- "Talisman of Life"
		evt.Subtract("Inventory", 448)         -- "Talisman of Life"
		evt.SetMessage(33)         -- "You found the thing! You killed Luftka good. Now I help you."
		evt.Add("Experience", 15000)
		evt.Set("Awards", 5)         -- "Entered Baal's Garden"
		evt.Subtract("QBits", 89)         -- Paul
		evt.SetNPCTopic{NPC = 6, Index = 1, Event = 65}         -- "Zeddicus Z'ul The Fifth" : "Battle Ragers"
	else
		if evt.Cmp("QBits", 89) then         -- Paul
			evt.SetMessage(32)         -- "You want me help you, you kill Luftka forever and bring back magic thing."
		else
			evt.SetMessage(34)         --[[ "Before me was Luftka the Kruel. She Queen of Dead and evil and locked in tomb. Tomb here in Sleigon. Entrance sealed. Her power from thing called Talisman of Life. It locked with her.

You want me help you, you kill Luftka forever and bring back the thing.

You go her house in king’s land, get key, enter tomb, kill Luftka.  Bring magic thing back.

Go!" ]]
			evt.Set("QBits", 89)         -- Paul
		end
	end
end

-- "Problems in the North"
evt.global[27] = function()
	evt.SetMessage(36)         --[[ "[You relate your recent encounters in Demonclaw to Lady Kathryn and your need for her watchfulness]

Well, Godwinson is one of the better lords of Nimradur, and I suppose I could help.  But first you must deliver this letter to Gilbert Hammer in the Mystic Isles.  He's on the Southern Island.  You can book passage on the Kraken to the Southern Island on Thursday, or you can book passage directly to the Northern Island on the Wind Dancer on Wednesday.  Both ships are harbored here in Avalon.

Return to me after the delivery and I will keep my eyes open for strange events in Nimradur. " ]]
	evt.Set("QBits", 95)         -- Walt
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 51}         -- "Lady Kathryn" : "We've delivered the letter!"
	evt.SetNPCTopic{NPC = 55, Index = 1, Event = 46}         -- "Gilbert Hammer" : "Delivery from Lady Kathryn"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 516)         -- "Letter to Gilbert Hammer"
end

-- "Welcome Back"
evt.global[28] = function()
	evt.SetMessage(35)         --[[ "[You relate your successful service to Lord Godwinson in Demonclaw and the encounter with Grish’nak]

Good work, adventurers!  Avenger Godwinson and I go back a long while.  Thanks for helping him out.

Unfortunately, Tamara has not returned yet, so I have no further news for you.  However, during this lull, you should visit the other Lords and the Ladies in their castles, gain their trust, and inform them of the troubled North.  Convince them to be alert to any and all unusual occurrences.  Unfortunately, I cannot give you a letter of introduction.  Many of the lords are less than cordial to me.  I’d begin by visiting Sir Zeddicus Z'ul the Fifth in Port Sleigon and the Lady Kathryn in The Citadel of Avalon.  To gain access to the other courts, you must have Mastery in the Diplomacy Skill, Level 8.  Gaining this mastery should be one of your prime goals.

Return to me after you have their trust." ]]
	evt.Set("QBits", 90)         -- Paul
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 509)         -- "Lord's Rhyme"
end

-- "I see you were successful"
evt.global[29] = function()
	evt.SetMessage(74)         --[[ "I see that you have gained the trust of the Lords and Ladies of Nimradur, and none too soon!  We have other problems brewing in our lands and I fear that you are the only ones who can deal with them.

Our friend Lord Godwinson has sent me some disturbing news about the Norse in Norseland.  Please travel to the Demonclaw and gain audience with The Lord.  He’ll provide the details.  The Coach Service in Port Sleigon should now be working so your journey should be much easier this time.

Good luck adventurers!" ]]
	evt.ForPlayer("All")
	evt.Subtract("QBits", 90)         -- Paul
	evt.Add("Awards", 32)         -- ""
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 15, Index = 2, Event = 64}         -- "Lord Godwinson" : "Trouble in Norseland"
end

-- "The Bane of the Sisterhood"
evt.global[30] = function()
	evt.SetMessage(89)         --[[ "Some of my sisters have forsaken the Path of The Mother and have turned to Sorcery and the worship of Aeron, the Goddess of Pestilence. This threatens the very balance of our world.  They have already desecrated the Temple of Tranquility, have confiscated the Bell of Summoning, and are holding their perverse worship at the Alters of The Mother. You must stop them!

Proceed to the Temple of Tranquility directly west of Avalon, rid the land of Aeron’s Minions, purge the temple of the foul worshippers, and bring the Bell of Summoning to me for safekeeping.

Hurry!   … before it is too late!" ]]
	evt.Set("QBits", 110)         -- NPC
	evt.SetNPCTopic{NPC = 14, Index = 2, Event = 88}         -- "Lady Kathryn" : "Bell of Summoning"
end

-- "Lady Kathryn's Message"
evt.global[31] = function()
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 536)         -- "Seled Parchment"
	evt.SetMessage(118)         --[[ "[You hand the Seer the sealed scroll from Lady Kathryn. As he reads the scroll, a troubled look comes over his face.] A Dark Shadow now covers the once bright future of this land. The Lords of Chaos have returned!  And they are Hades-bent on the upheaval of The Natural Balance of The Universal Order!

As we speak, the Clerics of Chaos are conjuring their Dark Minions and The Lords of Chaos are assembling their armies to sweep the land like locusts!  They must be stopped!

Your journey will be difficult and fraught with great perils.  The clerics have established their temple on an isolated island in The Far Reaches, at the ends of our lands.  Travel to this temple, deface the Idols of Chaos, and kill these perverted worshippers. Then we’ll deal with The Lords of Chaos." ]]
	evt.Set("QBits", 125)         -- NPC
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
end

-- "Welcome back, adventurers!"
evt.global[32] = function()
	evt.SetMessage(119)         --[[ "[You tell the Seer of your success in the Temple of Chaos and then show him the Crystal Skull that you received when you defaced the final Idol of Chaos. The Seer takes the skull and examines it. His demeanor grows more serious than usual, and then he speaks.]

First an old enemy, the Drow have returned as key players intertwined with the actions of Chaos.  Now you return with one of the ancient skulls.  If these events are connected then the threat could be far worse than I anticipated.  Take this skull to my friend Magus Emeritus in Ellesia; trust him as you would me.  He is an expert on ancient artifacts and can determine if this is one of the true skulls.  While there, perform any task he may have for you.  Once you have finished return to me." ]]
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
	evt.MoveNPC{NPC = 46, HouseId = 538}         -- "Magnus" -> "House of  Magnus"
	evt.SetNPCTopic{NPC = 46, Index = 0, Event = 119}         -- "Magnus" : "Crystal Skull"
end

-- "It's time to deal with Chaos."
evt.global[33] = function()
	evt.SetMessage(135)         --[[ "In the Second Age of Nimradur, the Ancients banished Chaos and His Lords into the Ether World using a unique teleporter that was activated by the Jewel of Power.  You must find this jewel to defeat Chaos.

The Jewel of Power is locked away in the Fortress of the Ancients in Norseland.  I have been able to unward the entrance so that you may enter.

But before you proceed to Norseland, you’ll need to obtain Mastery in the Dark Magics. Go see Master Su Lang Manchu in the Temple of Dark in Tuonela and he will assist you.

Oh yes!  Before I forget.  Should you find any Weapons of the Gods in the Fortress, you might gather them.  Creatures in the Ether World are immune to certain attacks, but these weapons will damage any and all that dwell in that realm.

Return to me when you have the jewel." ]]
	evt.Set("QBits", 131)         -- NPC
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 34}         -- "The Seer" : "Jewel of Power"
end

-- "Jewel of Power"
evt.global[34] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 481) then         -- "Jewel of Power"
		evt.SetMessage(174)         -- "I see that you have found the Jewel of Power.  Good work, adventurers.  Now it's time to enter the Ether Realm and face Chaos!"
		evt.Add("Experience", 500000)
		evt.Subtract("QBits", 131)         -- NPC
		evt.Add("ReputationIs", 500)
		evt.Add("Awards", 42)         -- ""
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 292}         -- "The Seer" : "The Ether World"
	else
		evt.SetMessage(136)         -- "You must return with the Jewel of Power."
	end
end

-- "Promotion to Inquisitor"
evt.global[35] = function()
	evt.SetMessage(46)         --[[ "What do we have here, loyal servants of the Realm? I see, I see. Indeed, your loyalty could make you worthy of the title of Inquisitors.  But you must understand that the Inquisitor must learn to carefully balance Mercy with Justice in the name of the gods and goddesses.  Therefore, I have a task for you.

To prove your abilities as Inquisitor candidates, find and judge the following transgressions; (1) Avarice, (2) Oppression, (3) Adultery, (4) Lying, and  (5) Self-Righteousness.

Once you have accomplished this, return to me." ]]
	evt.Add("QBits", 105)         -- NPC
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 36}         -- "King Jaffar" : "Judgement"
end

-- "Judgement"
evt.global[36] = function()
	if evt.Cmp("QBits", 459) then         -- Self Righteous Judged
		if evt.Cmp("QBits", 458) then         -- Bully Judged
			if evt.Cmp("QBits", 457) then         -- Liar Judged
				if not evt.Cmp("QBits", 461) then         -- Avarcie Judged
					goto _9
				end
				if not evt.Cmp("QBits", 460) then         -- Adulteress Judged
					goto _9
				end
				evt.SetMessage(48)         --[[ "[King Jaffar looks at you and smiles]

You have done well, candidates.  You have found your balance and are now worthy of promotion.

Therefore, I hereby promote all Priests to Inquisitors, and all others to Honorary Inquisitors." ]]
				evt.Subtract("QBits", 105)         -- NPC
				evt.SetNPCTopic{NPC = 4, Index = 1, Event = 37}         -- "King Jaffar" : "Exorcist"
				evt.Add("ReputationIs", 50)
				evt.ForPlayer("All")
				evt.Add("Experience", 15000)
				evt.ForPlayer(0)
				if evt.Cmp("ClassIs", const.Class.Cleric) then
					evt.Set("ClassIs", const.Class.Priest)
					evt.Add("Awards", 20)         -- "Received Promotion to Inquisitor"
				else
					evt.Add("Awards", 21)         -- "Received Promotion to Honorary Inquisitor"
				end
				goto _23
			end
		end
	end
::_9::
	evt.SetMessage(47)         -- "Your task is not yet completed, candidates.  Find and judge ; (1) Avarice, (2) Oppression, (3) Adultery, (4) Lying, and  (5) Self-Righteousness.  "
	do return end
::_23::
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Inquisitor"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Inquisitor"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Inquisitor"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Inquisitor"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Inquisitor"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Inquisitor"
	end
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 37}         -- "King Jaffar" : "Exorcist"
end

-- "Exorcist"
evt.global[37] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(49)         --[[ "So you think it’s time to become Exorcists?  [King Jaffar pauses for a moment and then continues]

Well, I agree.  Your recent accomplishments have become well known throughout the Realm, and you have conducted yourselves in an honorable way.

An Exorcist is one who serves the people by purging the Realm of evil.  The exorcist ‘exorcises’ the evil doers, often by force.   There is a heretical sect that worships the foul god ‘Baal’.  They dwell in the Disordered Sanctum in Norseland.  To qualify as Exorcists, you must purge their temple of all foul worshippers and return to me with the cloak of their High Priestess.  When you have accomplished this task, I will promote you.

Good  Luck, Inquisitors." ]]
		evt.Add("QBits", 107)         -- NPC
		evt.SetNPCTopic{NPC = 4, Index = 1, Event = 38}         -- "King Jaffar" : "High Priest's Cloak"
	else
		evt.SetMessage(43)         -- "You are not yet qualified for this second promotion.  Get some experience in you current class and then return to me.  We'll talk then."
	end
end

-- "High Priest's Cloak"
evt.global[38] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 485) then         -- "Cloak of the High Priestess"
		evt.SetMessage(50)         -- "You must purge the Disordered Sanctum of all evil and return to me with the High Priest's cloak."
		return
	end
	evt.SetMessage(51)         --[[ "[As you enter the Throne Room, King Jaffar sees the cloak and smiles approvingly] Yes,that's the cloak alright.

You have served The Realm well this day, adventurers.  By the power invested in me as both King of Nimradur and High Exorcist of The Realm, I hereby promote all Inquisitors amoung you to Exorcists, and all others to Honorary Exorcist. " ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to Exorcist"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary Exorcist"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to Exorcist"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary Exorcist"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to Exorcist"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary Exorcist"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to Exorcist"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary Exorcist"
	end
	evt.Add("ReputationIs", 200)
	evt.Subtract("QBits", 107)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Experience", 30000)
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 39}         -- "King Jaffar" : "Welcome fellow Exorcists!"
	evt.Subtract("Inventory", 485)         -- "Cloak of the High Priestess"
end

-- "Welcome fellow Exorcists!"
evt.global[39] = function()
	evt.SetMessage(53)         -- "Good to see you again, Exorcists of the Realm!  Sit at my feet and we can chat a-bit."
end

-- "Welcome Adepts!"
evt.global[40] = function()
	evt.SetMessage(121)         -- "Welcome again, fellow Adepts!  Perhaps you can assist me in an experiment or two when you’re less busy?""
end

-- "Pilgrimage"
evt.global[41] = function()
	evt.SetMessage(54)         -- "This is %s, the month of %s.  Journey to the Shrine of %s and pray there to be rewarded."
	evt.SetNPCTopic{NPC = 9, Index = 0, Event = 42}         -- "The Seer" : "Quest"
end

-- "Quest"
evt.global[42] = function()
	evt.SetMessage(55)         -- "You must wait until the new month to undergo a pilgrimage."
end

-- "Quest"
evt.global[43] = function()
	evt.SetMessage(56)         -- "performed daring deeds"
end

-- "Delivery from Lady Kathryn"
evt.global[46] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 516) then         -- "Letter to Gilbert Hammer"
		evt.Subtract("Inventory", 516)         -- "Letter to Gilbert Hammer"
		evt.Set("QBits", 480)         -- Lady K
		evt.SetMessage(40)         --[[ "[You hand Gilbert the letter from Lady Kathryn]

Hmmm.  I see.  Yes, she's correct.  Oh my!  this is alarming.

Well, you've discharged your service to The Lady faithfully.  You may now return to her in Avalon." ]]
		evt.SetNPCTopic{NPC = 55, Index = 1, Event = 0}         -- "Gilbert Hammer"
	else
		evt.SetMessage(39)         -- "Sorry.  I thought you were delivering a letter from Lady Kathryn."
	end
end

-- "Plight of the Undead Virgins"
evt.global[47] = function()
	evt.SetMessage(84)         -- "“Adventurers, I’m Danika.  Please understand that this land is cursed by many evils.  The land is inhabited with the restless spirits of undead virgins; their souls gather here before proceeding on to the after life.  Unfortunately a great evil sealed the gateway to the netherworld.  Trapped, unable to control themselves, they prey on the local people.  Find the Horn of Vainen which was lost in an island temple in Chernoburg.  Then enter Orpheus’s Gateway, go to the locked portal; there the horn will sound the song of the dead unlocking the portal and releasing the virgins from their torment.  Return to me for your reward.  Remember treat them gently, they are the victims through no fault of their own.”"
	evt.Add("QBits", 113)         -- NPC
	evt.SetNPCTopic{NPC = 159, Index = 0, Event = 48}         -- "Danika" : "Orpheus’s Gateway"
end

-- "Orpheus’s Gateway"
evt.global[48] = function()
	if evt.Cmp("QBits", 454) then         -- Opened the Gateway
		evt.SetMessage(96)         -- "Thank you my friends, a source of great sadness has been removed from the Bog.  It may be that the souls of those poor girls will continue to wander here in the Bog, but at least their path to eternal rest is now unblocked.  Accept this payment with my thanks."
		evt.ForPlayer("All")
		evt.Subtract("QBits", 113)         -- NPC
		evt.Add("Awards", 35)         -- ""
		evt.Add("Experience", 12500)
		evt.Add("Gold", 1250)
		evt.SetNPCTopic{NPC = 159, Index = 0, Event = 0}         -- "Danika"
	else
		evt.SetMessage(95)         -- "Oh, those poor girls, you must hurry.  It is heartbreaking just watching them wander aimlessly."
	end
end

-- "Crystal of Mana"
evt.global[49] = function()
	if evt.Cmp("Inventory", 457) then         -- "Crystal of Mana"
		evt.SetMessage(107)         -- "My friends, you found it!  I can’t tell you how happy you’ve made me.  My employer’s will be very generous to me and I shall be to you.  Here is your reward. "
		evt.ForPlayer("All")
		evt.Subtract("QBits", 124)         -- "."
		evt.Subtract("Inventory", 457)         -- "Crystal of Mana"
		evt.Add("Awards", 37)         -- ""
		evt.Add("Gold", 1250)
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 353, Index = 0, Event = 0}         -- "Svarktel Jorgen"
	else
		evt.SetMessage(106)         -- "Look if it was easy I’d do it myself and cut my costs.  Now get out there and don’t come back without the Crystal of Mana!"
	end
end

-- "We've delivered the letter!"
evt.global[51] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 480) then         -- Lady K
		evt.SetMessage(38)         --[[ "I see you've finally returned!  Did you have a pleasant journey?

Since you have served me well in delivering the letter, I will join your cause and be watchful." ]]
		evt.Add("Experience", 15000)
		evt.Set("Awards", 6)         -- "Gained Access to The Land that Time Forgot"
		evt.Subtract("QBits", 95)         -- Walt
		evt.Add("ReputationIs", 100)
		evt.SetNPCTopic{NPC = 14, Index = 1, Event = 91}         -- "Lady Kathryn" : "Marksman"
		evt.SetNPCTopic{NPC = 44, Index = 1, Event = 0}         -- "Harper Collins"
	else
		evt.SetMessage(37)         -- "You must first deliver the letter to Gilbert Hammer in the Mystic Isles."
	end
end

-- "Principles of Wealth"
evt.global[52] = function()
	evt.SetMessage(41)         --[[ "I love the jingle-jangle sounds of spare coins in my pockets.  It sounds like ….. wealth!  And wealth is what life is all about.

I love to toss a few coins into the middle of a group of beggars and watch them fight each other just to get the gold.  Sweet entertainment!

So I’ll let ya in on my secret for obtaining wealth.  The three keys to successfully becoming wealthy are;

1.  Start off with a large ‘nest-egg’.  I inherited mine from my family.
2.  Never let a crisis go by without taking advantage of its opportunities.  People are always willing to make ‘bad’ deals and give up lands just to get out from under a crisis.
3.  Leverage.  Yes, leverage.  Take your depositors gold and loan it out at 40-to-one.  Give your depositors a pittance of interest and charge the borrowers a massive usury fee.

You can read more about these principles in my book “How to Fleece the Flock”." ]]
	if evt.Cmp("QBits", 105) then         -- NPC
		evt.SetNPCTopic{NPC = 104, Index = 0, Event = 73}         -- "Thomas A. Varice" : "Judged!"
	end
end

-- "Put Text Here"
evt.global[53] = function()
	evt.SetMessage(65)         --[[ "[Lady Kathryn looks upon the Bell of Summoning that you carry and approaches you.]

You have performed a great service both to me and to my sisters and I am proud to call you Friends of The Sisterhood.

[Lady Kathryn takes the Bell of Summoning from you and examines it.]

No!  This cannot be! Our worst fears have been realized!

[Lady Kathryn calls for the court scribe and whispers something to her.  The scribe disappears and, in a few minutes, reappears with a sealed scroll in-hand.  Lady Kathryn takes the scroll and hands it to you.]

You must deliver this scroll to The Seer immediately.  He will know how to handle this.

Quickly now, my friends.  Begone!" ]]
end

-- "Problems in the North"
evt.global[54] = function()
	evt.SetMessage(44)         --[[ "[You relate your recent encounters in Demonclaw to King Jaffar and your need for his watchfulness.  Your highly refined diplomatic skills impress the King]

Well put, adventurers!  Well put, indeed!  I’ll immediately issue a decree to all of my subjects to be watchful for anything ‘unusual’.

Is there anything else I can do for you?" ]]
	evt.Set("QBits", 470)         -- Jaffar Approval
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 35}         -- "King Jaffar" : "Promotion to Inquisitor"
end

-- "Enchanter"
evt.global[55] = function()
	evt.SetMessage(67)         --[[ "I see you are seeking to learn the finer points of High Magicks. Well, if you would do me one small favor, I would be delighted to promote all Mages to Enchanter and all others to the prestigious position of Honorary Enchanter.

While I was collecting endoplasm from the Ooze Pits located in the Kastution Waters region, I carelessly lost my Staff of Merlin. I desperately need my staff back, as I am constantly being disturbed by those pesky acolytes. A good thumping with my trusty Staff of Merlin should keep them in line.

Please hurry and retrieve my Staff so I can get on with my work without being bothered and you can get on with your adventuring as newly promoted Enchanters." ]]
	evt.Add("QBits", 111)         -- NPC
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 58}         -- "Soiret The Adept" : "Staff of Merlin"
end

-- "Weaklings!"
evt.global[56] = function()
	evt.SetMessage(91)         --[[ "[Thornton Thuggly deliberately bumps into you, then gives you a shove as you approach]

Hah! So you think training will make you bunch of weaklings any stronger? I could smash all four of you puny pipsqueaks, with just my pinky finger! C'mon you cowards, I dare you!

[Thuggly give you another shove as you depart in the opposite direction.]" ]]
	if evt.Cmp("QBits", 105) then         -- NPC
		evt.SetNPCTopic{NPC = 51, Index = 0, Event = 101}         -- "Thornton Thuggly" : "Judged!"
	end
end

-- "Staff of Merlin"
evt.global[58] = function()
	if not evt.Cmp("Inventory", 404) then         -- "Staff of Merlin"
		evt.SetMessage(69)         --[[ "[Soiret the Adept suddenly appears in the doorway as you are about to enter. He looks lofty and dignified. He sees that you are not carrying his Staff of Merlin and you can see the disappointment and disapproval in his eyes.]

So you still have not found my Staff of Merlin? I hoped to have it back by now. Please continue your search and bring me my Staff! You cannot be promoted to Enchanter until this task is completed." ]]
		return
	end
	evt.SetMessage(70)         -- "Since you are now carrying the Staff of Merlin, Soiret the Adept welcomes you into the Enchanted Bastion and offers to magically clean all of your armor and items from the gooey ooze and putrid odor which has stuck to your party since visiting the Ooze Pits. You hand off the staff to Soiret. He thanks you for your trouble and sacrifice, then eloquently speaks the incantation which promotes all Mages to Enchanter and all others to Honorary Enchanter."
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Enchanter"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Enchanter"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Enchanter"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Enchanter"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Enchanter"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Enchanter"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Enchanter"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Enchanter"
	end
	evt.Add("ReputationIs", 50)
	evt.Subtract("QBits", 111)         -- NPC
	evt.Subtract("Inventory", 404)         -- "Staff of Merlin"
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 59}         -- "Soiret The Adept" : "Adept"
end

-- "Adept"
evt.global[59] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(71)         --[[ "I thought I's see you again.  Back for the Adept promotion? Well, listen up.

Many ages ago, a sorcerer named Zorankus wanted to be the only powerful Adept in the land of Nimradur. He became so jealous of anyone who desired to become an Adept and learn High Magick, that he hid the Fountain of Enchantment so no one else could drink thereof. Then he conjured up monstrous creatures to guard the fountain from all seekers.

After Zorankus' death, many mages decided to continue keeping the location of Fountain of Enchantment a secret and set up residence in the Halls of the Adept.

To be promoted to the high level of Adept, you must travel to the Halls of the Adept in Kastutia. Find the hidden cave complex within where a pair of Blue Torches are located. If you activate both torches, you will be transported to the Fountain of Enchantment. Drink from this fountain and return to me. Here, you may need this Scroll of Walk on Water to complete the journey." ]]
		evt.ForPlayer("All")
		evt.Add("QBits", 126)         -- NPC
		evt.Add("Inventory", 226)         -- "Water Walk"
		evt.SetNPCTopic{NPC = 5, Index = 1, Event = 60}         -- "Soiret The Adept" : "Fountain of  Enchantment"
	else
		evt.SetMessage(43)         -- "You are not yet qualified for this second promotion.  Get some experience in you current class and then return to me.  We'll talk then."
	end
end

-- "Fountain of  Enchantment"
evt.global[60] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 499) then         -- Fountain of Enchantment once
		evt.SetMessage(72)         -- "[Soiret the Adept speaks]  I see you are still thirsty for the knowledge of High Magicks. You must find the Fountain of Enchantment and drink thereof before you can be promoted to Adept."
		return
	end
	evt.SetMessage(73)         --[[ "[When you enter the Enchanted Bastion, Soiret the Adept is glowing with an ethereal light.]   I have read in the heavens that you have succeeded in your quest to find and drink from the Fountain of Enchantment. I am happy to see you've all achieved this task and are still alive. A difficult mission indeed.

[With a wave of his wand and a few mysterious words, Soiret declares]  "I hereby promote all Enchanters to Adept and all Honorary Enchanters to Honorary Adept." ]]
	evt.Add("Experience", 50000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Adept"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Adept"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Adept"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Adept"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Adept"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Adept"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Adept"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Adept"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 126)         -- NPC
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 457)         -- "Crystal of Mana"
	evt.Subtract("QBits", 126)         -- NPC
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 40}         -- "Soiret The Adept" : "Welcome Adepts!"
end

-- "Problems in the North"
evt.global[61] = function()
	evt.SetMessage(57)         --[[ "[You relate your recent encounters in Demonclaw to Soiret and your need for his watchfulness.  Your highly refined diplomatic skills impress the Adept]

Well put, adventurers!  Well put, indeed!  I’ll immediately direct my people to be watchful for anything ‘unusual’.

Is there anything else I can do for you?" ]]
	evt.Set("QBits", 469)         -- Soiret Approval
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 55}         -- "Soiret The Adept" : "Enchanter"
end

-- "Problems in the North"
evt.global[62] = function()
	evt.SetMessage(45)         --[[ "[You relate your recent encounters in Demonclaw to Elder Klaravoyia and your need for her watchfulness.  Your highly refined diplomatic skills impress the Elder]

Well put, adventurers!  Well put, indeed!  I’ll immediately alert my Order to be watchful for anything ‘unusual’.

Is there anything else I can do for you?" ]]
	evt.Set("QBits", 468)         -- Klaravoiya Approval
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 82}         -- "Baroness Klaravoyia" : "Sylvan"
end

-- "Trouble in Norseland"
evt.global[64] = function()
	evt.SetMessage(75)         --[[ "It’s good to see you again, my friends.  I have received reports form my neighbors to the West in that the Norse have become hostile and are planning an invasion of the lands to the south.

What I need you to do is to proceed to Norseland using the road the runs to the West of Jorgsborg, breach their garrison outpost, find the plans for the invasion and return them to me post haste.

But be careful! The Norsemen are a fierce warrior-race and a formidable opponent for even the mightiest of adventurers.  Their shape-shifting Were Berserkers are the most courageous fighters known to mankind!

Good Luck!" ]]
	evt.ForPlayer("All")
	evt.Set("QBits", 163)         -- NPC
	evt.SetNPCTopic{NPC = 15, Index = 2, Event = 76}         -- "Lord Godwinson" : "Invasion Plans"
end

-- "Battle Ragers"
evt.global[65] = function()
	evt.SetMessage(79)         --[[ "[As you enter the throne room, Z’ul looks down on you with a gaze that penetrates you very soul.  Fearing that his gaze might split you asunder, you quickly break eye contact and look away.  Zu’l grunts with laughter and then speaks]

So you wannabe Battlerager?  Z’ul help.  First thing Battlerager must conquer is fear.  From this might, and from might ... courage.  Courage is mark of Battlerager.

What you fear, adventurers?  Darkness?  Death? Or maybe Undead?  Yes, that so.  Undead.  You conquer this fear, gain might, prove courage.

Go to Kastuia.  Find Lunatic Vault.  Enter.  You conquer fears there!  Touch Flame of Might and return to Z’ul.  He’ll then promote you Battlerager." ]]
	evt.Add("QBits", 114)         -- NPC
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 69}         -- "Zeddicus Z'ul The Fifth" : "Flame of Might"
end

-- "Doom Knights"
evt.global[66] = function()
	evt.SetMessage(62)         --[[ "[Agnitum greets you warmly.  You can’t help but think that you have found the wrong Agnitum.  Can this **really** be the teacher of the dreaded Sir Zeddicus Z’ul the Fifth, Doom Knight of The Realm?  All doubts quickly fade as Agnitum begins to speak.]  Z’ul sent ya, huh?  How is the Green Skin?  I trust he’s faring well.

So it’s Doom Knight you seek?  Well let me tell you what really makes a Doom Knight.  No, not courage, not might, not head-bashing abilities.  The answer if far more reaching than these things.  It’s wisdom!

You heard me correctly … wisdom!  Know your enemy’s strengths and weaknesses.  Know when to stand and fight, know when to skirmish,  and know when to get the Hades out of Dodge.  Once you learn this, then you shall truly become Doom Knights.  Think on this, and reutrn to Z’ul." ]]
	evt.SetNPCTopic{NPC = 19, Index = 0, Event = 0}         -- "Agnitum"
	evt.Set("QBits", 456)         -- Agnitum once
end

-- "Buy Kegs of Wine for 200 gold"
evt.global[67] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
		evt.Add("Gold", 200)
		evt.Subtract("Inventory", 473)         -- "Keg of Wine"
		evt.SetMessage(30)         -- "Done!"
	else
		evt.SetMessage(63)         -- "Well you look just the type I’m looking for, you ever wonder how we maintain such low prices around here, well I’ll tell you we have little overhead and we get our supplies cheap, real cheap if you catch my drift.  Now some vandals hijacked a shipment of wine kegs.  It is rumored they are now strewn about Sutter’s Bay.  If you find any of 'em, bring them to me and I’ll pay 200 in gold for each keg."
	end
end

-- "Mabon’s Cave"
evt.global[68] = function()
	if not evt.Cmp("QBits", 112) then         -- NPC
		evt.SetMessage(52)         -- "Have you met King Jaffar, the despot of Kat'an?  He’s a fraud and swindler.  His great-great-grandfather his namesake in fact, deeded to my family a large tract of land.  This current ‘King’ refuses to honor my rights to the land unless I produce the deed.  My great-great-grandfather had it in his possession when he went on a treasure hunt from which he never returned.  Here is a letter explaining everything you need to know about the cave which held the treasure perhaps you will find the deed inside.  Take all the treasure all I want is the deed.  Bring that to me and we both will be rewarded."
		evt.Set("QBits", 112)         -- NPC
		evt.ForPlayer("Current")
		evt.Add("Inventory", 504)         -- "Mabon’s Cave"
	else
		if evt.Cmp("Inventory", 505) then         -- "Royal Land Grant "
			evt.ForPlayer("All")
			evt.Subtract("Inventory", 505)         -- "Royal Land Grant "
			evt.SetMessage(83)         -- "Great you have returned with the deed, here’s your payment now let me see the deed.  What’s this 20,000 acres in the southern portion of Baal’s Garden.  The royal family has no jurisdiction there and even if they did who in their right mind would want to own land there, it’s nothing but desert.  Even the first Jaffar was a crook, I should have known.  Well you did as I asked and unlike the king I am a man of my word, the payment is yours.  Now if you don’t mind I need to see if I can get anything for this land grant."
			evt.Add("Awards", 34)         -- ""
			evt.Add("Experience", 5000)
			evt.SetNPCTopic{NPC = 77, Index = 0, Event = 0}         -- "Jack Slagg"
			evt.Subtract("Inventory", 504)         -- "Mabon’s Cave"
			evt.Subtract("QBits", 112)         -- NPC
			evt.Add("Gold", 1250)
		else
			evt.SetMessage(82)         -- "I see you haven’t found the deed yet, well keep at it I want the pleasure of showing it to that snob sitting on the throne."
		end
	end
end

-- "Flame of Might"
evt.global[69] = function()
	if not evt.Cmp("QBits", 498) then         -- Flame of Might once
		evt.SetMessage(80)         --[[ "What this?  You too timid to reach Flame of Might.  You overcome fears.  Must do!  Do as told!  Only return when done.

Go!" ]]
		return
	end
	evt.SetMessage(81)         --[[ "[Once again Z’ul looks down on you with a gaze that penetrates you very soul.  Only this time you determine not to look away, but to fix you eyes on his.  Zu’l grins, grunts with laughter, and then speaks]

Good.  You no more fear.  You mighty.  Courage found.  You Battleragers now." ]]
	evt.Subtract("QBits", 114)         -- NPC
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Battlerager"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Battlerager"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Battlerager"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Battlerager"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Battlerager"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Battlerager"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Battlerager"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Battlerager"
	end
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 70}         -- "Zeddicus Z'ul The Fifth" : "Doom Knight"
end

-- "Doom Knight"
evt.global[70] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(85)         --[[ "[Z’ul greets you with that familiar, piercing gaze, and then grins.  A fleeting thought crosses your mind that perhaps he’s starting to like you.  But naw, that aint gonna happen.]

You now ready.  Brave deeds done.  Many lie dead in own blood.  Your sword cause much wailing, make many widows.

Now seek Agnitum, Z’ul teacher.  He dwell with tent people faraway.  He teach you good.  Come back and Z’ul promote.

Go now!" ]]
		evt.Add("QBits", 115)         -- NPC
		evt.SetNPCTopic{NPC = 6, Index = 1, Event = 71}         -- "Zeddicus Z'ul The Fifth" : "Doom Knight"
		evt.SetNPCTopic{NPC = 19, Index = 0, Event = 66}         -- "Agnitum" : "Doom Knights"
		evt.MoveNPC{NPC = 19, HouseId = 263}         -- "Agnitum" -> "House"
	else
		evt.SetMessage(61)         -- "You no ready.  Brave deeds must perform. Go!"
	end
end

-- "Doom Knight"
evt.global[71] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 456) then         -- Agnitum once
		evt.SetMessage(86)         -- "You find Agnitum amoung tent people.  Not return until done!"
		return
	end
	evt.SetMessage(87)         --[[ "[Z’ul rises from his throne, a maasive hulk of an Orc looming over you.  He draws his sword and raises it overhead.]

You find Agnitum.  He teach you good.  You learn good.  I now take you as Brothas.  Doom Knights you are!

[You kneel before Sir Zeddicus Z’ul the Fifth as he touches your shoulder with his blade and pronounces you Doom Knights of The Realm!]" ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Doom Knight"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Doom Knight"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Doom Knight"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Doom Knight"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Doom Knight"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Doom Knight"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Doom Knight"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Doom Knight"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 115)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Experience", 40000)
	evt.Subtract("Inventory", 508)         -- "Kat'an Travel Schedule"
	evt.Subtract("QBits", 187)         -- Quest item bits for seer
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 72}         -- "Zeddicus Z'ul The Fifth" : "Doom Knights"
end

-- "Doom Knights"
evt.global[72] = function()
	evt.SetMessage(120)         -- "Brotha Doom Knights, Z'ul bids welcome!  Stay.  Tell brave deeds.  Drink ale.  Share meat.  "
end

-- "Judged!"
evt.global[73] = function()
	evt.SetMessage(68)         -- "Because of your transgressions against the gods and goddesses,  and by the authority of King Jaffar High Exorcist of The Realm, you are hereby judged as guilty and are henceforth exiled from the lands of Nimradur forever."
	evt.MoveNPC{NPC = 104, HouseId = 0}         -- "Thomas A. Varice"
	evt.Set("QBits", 461)         -- Avarcie Judged
end

-- "Judged!"
evt.global[74] = function()
	evt.SetMessage(89)         --[[ "Some of my sisters have forsaken the Path of The Mother and have turned to Sorcery and the worship of Aeron, the Goddess of Pestilence. This threatens the very balance of our world.  They have already desecrated the Temple of Tranquility, have confiscated the Bell of Summoning, and are holding their perverse worship at the Alters of The Mother. You must stop them!

Proceed to the Temple of Tranquility directly west of Avalon, rid the land of Aeron’s Minions, purge the temple of the foul worshippers, and bring the Bell of Summoning to me for safekeeping.

Hurry!   … before it is too late!" ]]
end

-- "Invasion Plans"
evt.global[76] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 534) then         -- "Norse Invasion Plans"
		evt.Subtract("Inventory", 534)         -- "Norse Invasion Plans"
		evt.Subtract("QBits", 163)         -- NPC
		evt.Set("QBits", 120)         -- NPC
		evt.SetMessage(77)         --[[ "This is not good, not good at all. The Norse are attempting to transmute their Berserkers into Were Beasts. The Norse plan to form an entire force of Were Beasts to spearhead their attack to the south!  This effort must be destroyed before it is successful.

You must return to Norseland, locate the Lair of the Norse, and destroy all within that foul place.  Kill the Norse Warlord and return to me with his flute, which he will use as a ‘call-to-arms’ for the Were Beasts.

Hurry!  Time is of the essence." ]]
		evt.SetNPCTopic{NPC = 15, Index = 2, Event = 77}         -- "Lord Godwinson" : "Destroy the Lair!"
	else
		evt.SetMessage(76)         -- "You must return with the plans before we can deal with this problem."
	end
end

-- "Destroy the Lair!"
evt.global[77] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 478) then         -- "Call-to-Arms Flute"
		evt.SetMessage(88)         --[[ "The flute!  Well I’ll be …  I must say that I was somewhat worried about you, my friends. This is indeed a grand display or your valor and abilities!  Congratulations on a task well done!

Word of your victory has already spread throughout the civilized lands on Nimradur. You are becoming quite famous.  I think that you’ll now be able to obtain your second promotions from the Lords and Ladies of Nimradur.

Good luck my friends." ]]
		evt.Subtract("QBits", 120)         -- NPC
		evt.Add("Awards", 7)         -- "Destroyed the Sacred Chalice of Gods"
		evt.Add("Experience", 100000)
		evt.SetNPCTopic{NPC = 15, Index = 2, Event = 0}         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 89}         -- "The Seer" : "Lady Kathryn"
		evt.MoveNPC{NPC = 16, HouseId = 452}         -- "Baroness Klaravoyia" -> "School of Light"
		evt.MoveNPC{NPC = 305, HouseId = 162}         -- "Vice-Elder Grummond" -> "Leannor Hall"
		evt.Subtract("Inventory", 478)         -- "Call-to-Arms Flute"
	else
		evt.SetMessage(78)         -- "You must destroy the Norse Lair with all haste and return to me with the flute."
	end
end

-- "Ceridwen's Elixir"
evt.global[78] = function()
	evt.SetMessage(298)         --[[ "Travelers welcome. I am Aelwen and I am in need of help from heroes.  Perhaps you could be those heroes?  We druids are in a desperate war with the followers of Agrona.  If we lose, the land will be overrun by pestilence.  I seek the ingredients for Ceridwen’s Elixir of Wisdom.  I require you to find the following; a potion of essence of Personality and a potion of essence of Intellect.  Bring them to me so I can mix the elixir.  It may give us the edge we need to end this conflict.

You may be able to find the two potions in the shops of Nimradur, or you could mix them yourself from other potions.  Take this scroll.  It provides the recipe for mixing the potions.

I do have a third alternative to finding these ingredients.  There is a merchant named Trader Joe who dwells among the tent people of Baal’s Garden.  You may be able to purchase these potions from him.  But be warned, he charges exorbitant prices for his wares!" ]]
	evt.Set("QBits", 138)         -- NPC
	evt.ForPlayer("Current")
	evt.Add("Inventory", 503)         -- "Mixing Recipe"
	evt.SetNPCTopic{NPC = 17, Index = 0, Event = 298}         -- "Aelwen" : "We have the Ingredients!"
end

-- ""
evt.global[79] = function()
	evt.SetMessage(94)         --[[ "Those who say I'm an adulteress are twisting the truth! I've never committed any sin! Here's my story:

When we met, my husband Georgeton fell in love with me immediately. He was wise, sensitive and cared for me as if I were a lonely, beautiful flower. Care? Hah! He was lucky to be married to the most alluring woman in Nimradur. While his words were filled with caresses and his touch gentle, he lacked the burning passion I longed for.

One morning Georgeton went to chop lumber. As I watched him disappear, I noticed a strikingly handsome man. With one wink from me, he approached my door and introduced himself as Wilkit. At that moment, this dazzling man was the only thing I cared about or wanted.

Georgeton was furious when he came home - with that horrible axe, he killed Wilkit. One chop - and his head fell to the floor. Blood splattered everywhere. Georgeton, just looked at me painfully and left forever. Is it my fault that Georgeton went mad and left because of a meaningless rendezvous?" ]]
	evt.Add("QBits", 116)         -- NPC
	evt.Set(216, 0)
	evt.SetNPCTopic{NPC = 14, Index = 0, Event = 80}         -- "Lady Kathryn" : "Judged!"
end

-- "Judged!"
evt.global[80] = function()
	if not evt.Cmp("QBits", 117) then         -- NPC
		evt.SetMessage(95)         -- "Oh, those poor girls, you must hurry.  It is heartbreaking just watching them wander aimlessly."
		return
	end
	evt.SetMessage(96)         -- "Thank you my friends, a source of great sadness has been removed from the Bog.  It may be that the souls of those poor girls will continue to wander here in the Bog, but at least their path to eternal rest is now unblocked.  Accept this payment with my thanks."
	if evt.Cmp(216, 31) then
		evt.Add("Gold", 5000)
	else
		evt.Add("Gold", 25000)
	end
	evt.Subtract("QBits", 116)         -- NPC
	evt.Subtract("ReputationIs", 200)
	evt.ForPlayer("All")
	evt.Add("Awards", 6)         -- "Gained Access to The Land that Time Forgot"
	evt.Add("Experience", 25000)
	evt.SetNPCTopic{NPC = 14, Index = 0, Event = 81}         -- "Lady Kathryn" : "Money"
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 32) then         -- ""
		if evt.Cmp("Awards", 2) then         -- "Gained Access to the Valley of Stones"
			if evt.Cmp("Awards", 3) then         -- "Touched the Rock of Translation"
				if evt.Cmp("Awards", 4) then         -- "Gained Access to Desolation's End"
					if evt.Cmp("Awards", 5) then         -- "Entered Baal's Garden"
						if evt.Cmp("Awards", 6) then         -- "Gained Access to The Land that Time Forgot"
							if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
								evt.Set("QBits", 167)         -- NPC
							end
						end
					end
				end
			end
		end
	end
end

-- "Money"
evt.global[81] = function()
	evt.SetMessage(97)         --[[ "Oh I see you have finally come to collect your reward.  I cannot tell you how happy I am you succeeded.  Why in the last hour no less than three men have come calling.  Real good looking ones, how will I ever make up my mind?  I know perhaps ...

[This time you made it to the door.] That’s quite alright.  Thank you for the reward, but we really must be going." ]]
end

-- "Sylvan"
evt.global[82] = function()
	evt.SetMessage(98)         --[[ "[The Great Lady of the Forest, Klaravoyia greets you warmly]  Well met my dears, how good of you to visit. I have need of a small favor; and if you do this for me I will promote all Druids in your party to the status of Sylvan and the rest will be promoted to honorary Sylvan.

Recently, due to the trouble in Nimradur, the bright colored plumage on my flock of Red-breasted Warblers has become dull. I need you to retrieve the Last Rose of Winter so I can concoct a tincture which will restore the former beauty of my beloved birds.

Finding and obtaining the Last Rose of Winter may well be a treacherous journey indeed, for it only grows in the high snowy altitudes of Demonclaw, not easily accessible by foot. Therefore, I give you this Scroll of Fly to assist you in reaching those heights. Return to me as soon as you have found the Last Rose of Winter. I would be eternally grateful and delighted to welcome all of you into the great family of Sylvans … and please be sure to dress warmly my dears." ]]
	evt.Add("QBits", 118)         -- NPC
	evt.ForPlayer("Current")
	evt.Add("Inventory", 220)         -- "Fly"
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 365}         -- "Baroness Klaravoyia" : "Last Rose of  Winter"
end

-- "Judged!"
evt.global[83] = function()
	evt.SetMessage(99)         -- "[Klaravoyia is holding one of her birds that has turned completely gray]  Good day adventurers, have you retrieved the Last Rose of Winter yet? As you can see, my birds are losing all their color and may soon lose their song. Please hurry and find the Rose so I can mix the tincture and bring my flock back to their full beauty."
end

-- "Elder"
evt.global[84] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(101)         --[[ "[Elder Klaravoyia offers you a cup of warm, aromatic herbal tea as she softly speaks]  My dear Sylvan friends, you may have heard of the Creations Fount, sacred to all who follow the Druid's path. It may be found on one of the southern islands of the Mystic Isles region. Whenever a Sylvan drinks from the Creations Fount, he or she will be given enhanced knowledge concerning the Wheel of Life and how all living things are connected to one another.

Drink from the Creations Fount so you can better understand how to protect the forests and all life in Nimradur. Then when your Mind's Eye is enlightened to the wonders of Nature, return to me and I will promote all Sylvans to Elder and all honorary Sylvans to honorary Elders." ]]
		evt.Add("QBits", 119)         -- NPC
		evt.SetNPCTopic{NPC = 16, Index = 1, Event = 366}         -- "Baroness Klaravoyia" : "Creations Fount"
	else
		evt.SetMessage(43)         -- "You are not yet qualified for this second promotion.  Get some experience in you current class and then return to me.  We'll talk then."
	end
end

-- "Elder Klaravoiya"
evt.global[85] = function()
	evt.SetMessage(90)         -- "[Vice-Elder Grummond greets you as you enter.]   Welcome friends to Leannor Hall. I see you have  advanced in experience and wisdom. Now you are ready to seek the highest path in the Druidic Order. Elder Klaravoyia is the only one authorized to promote Sylvans to the status of Elder and I'm sorry to say that you have just missed her. She left for the Mystic Isles to visit her friend and celebrate the annual Feast of the Frolicking Faeries. Travel to the Mystic Isles and seek Elder Klaravoyia there. She will let you know what is required before you can be promoted to Elder."
end

-- "Welcome Elders!"
evt.global[86] = function()
	evt.SetMessage(122)         -- "Welcome, fellow Elders!  Let us meditate together to attune of life force with the Blessed Mother.."
end

-- "Judged!"
evt.global[87] = function()
	evt.SetMessage(105)         -- "This is glorious news; Jaana is happily distracted by all of the attention the men are paying her.  I can now accompany you to Port Sleigon.  We best hurry in case none of the men are serious."
	evt.Add("QBits", 120)         -- NPC
	evt.SetNPCTopic{NPC = 14, Index = 0, Event = 88}         -- "Lady Kathryn" : "Bell of Summoning"
end

-- "Bell of Summoning"
evt.global[88] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 461) then         -- "Bell of Summoning"
		evt.ForPlayer("All")
		evt.Subtract("QBits", 110)         -- NPC
		evt.Subtract("Inventory", 461)         -- "Bell of Summoning"
		evt.SetMessage(65)         --[[ "[Lady Kathryn looks upon the Bell of Summoning that you carry and approaches you.]

You have performed a great service both to me and to my sisters and I am proud to call you Friends of The Sisterhood.

[Lady Kathryn takes the Bell of Summoning from you and examines it.]

No!  This cannot be! Our worst fears have been realized!

[Lady Kathryn calls for the court scribe and whispers something to her.  The scribe disappears and, in a few minutes, reappears with a sealed scroll in-hand.  Lady Kathryn takes the scroll and hands it to you.]

You must deliver this scroll to The Seer immediately.  He will know how to handle this.

Quickly now, my friends.  Begone!" ]]
		evt.Set("Awards", 33)         -- ""
		evt.Add("Experience", 150000)
		evt.SetNPCTopic{NPC = 14, Index = 2, Event = 0}         -- "Lady Kathryn"
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 31}         -- "The Seer" : "Lady Kathryn's Message"
		evt.Add("ReputationIs", 200)
		evt.ForPlayer("Current")
		evt.Add("Inventory", 536)         -- "Seled Parchment"
	else
		evt.SetMessage(64)         -- "Please rid the temple of Aeron and her minions and return to me with the Bell of Summoning."
	end
end

-- "Lady Kathryn"
evt.global[89] = function()
	evt.SetMessage(66)         -- "[As you enter, The Seer has a troubled look on his face.]  I'm afraid that we have more troubles in Nimradur, adventurers.  Please go to The Citadel in Avalon and speak with the Lady Kathryn.  She'll provide you with the details."
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
	evt.SetNPCTopic{NPC = 14, Index = 2, Event = 30}         -- "Lady Kathryn" : "The Bane of the Sisterhood"
end

-- "Master of the Dark"
evt.global[90] = function()
	if evt.Cmp("QBits", 131) then         -- NPC
		evt.SetMessage(134)         --[[ "[You explain to Su Lang Manchu that the Seer has sent you to him for the Dark Magic promotions.]  I’m sure that you realize the risk I am taking in offering you this promotion.  But I do trust the Seer and owe him a favor or two.  So here’s how it works.

I can only promote one character at a time; your ‘active’ character.  I will promote your Elders to Expert Level Four, and your Adepts and Exorcists who are already Expert Level 4 to Master Level 11.

Let’s get start." ]]
		evt.SetNPCTopic{NPC = 255, Index = 0, Event = 291}         -- "Su Lang Manchu" : "Promotion to Dark Master"
	else
		evt.SetMessage(117)         -- "Teaching this sacred skill has been forbidden by King Jaffar under penalty of death.  Now begone!"
	end
end

-- "Marksman"
evt.global[91] = function()
	evt.SetMessage(109)         -- " “Welcome.   Since you have already gained my trust,  I can now offer the archers among you the chance to be promoted to marksman, and the rest of your party will gain an honorary title.  Years ago I studied under my mentor Sir Guy Wrenford, First Stalker of Nimradur.  Those were good days, but alas all things must pass.  There was a sacred shrine within his residence called the Crystal of Accuracy.  His home was called Wrenford’s Retreat, and after his passing his relatives did not maintain it.  It has since fallen into ruin and occupied by vile creatures; go there and free the crystal then return to me for promotion.”"
	evt.Add("QBits", 121)         -- NPC
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 92}         -- "Lady Kathryn" : "Marksman"
end

-- "Marksman"
evt.global[92] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 473) then         -- Accuracy Crystal once
		evt.SetMessage(110)         --[[ "[Lady Kathryn is angry]

Why are you here? Perhaps my trust of you was miss-placed. I reluctantly granted you the opportunity for promotion and you dare show up here before the defilers of my mentor’s old home have been dealt with.

Leave me at once before I reconsider the quest and your chance at promotion." ]]
		return
	end
	evt.SetMessage(111)         -- "“Well done young adventurers!  Long have I wished to clean out the home of Sir Guy, and now it has been done.  A debt to my old friend has been repaid, thanks to you.  Promotion to Marksman for the Archers in your party is granted, and to the rest I gladly bestow the title of Honorary Marksman.”"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Marksman"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Marksman"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Marksman"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Marksman"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Marksman"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Marksman"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Marksman"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Marksman"
	end
	evt.Subtract("QBits", 121)         -- NPC
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 30000)
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 93}         -- "Lady Kathryn" : "Stalker"
end

-- "Stalker"
evt.global[93] = function()
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(112)         --[[ "[Lady Kathryn casts a doubtful eye on the party]

Back so soon?  You were only promoted to Marksman a short time ago.  It usually takes almost a decade to earn promotion to stalker.  You however are in luck, I do have a task that has needed my attention for sometime; the Bow of Artemis was recently found by some of my informants.  They report that it is hidden in the Cavern of Timbol.  Unfortunately the creatures inside the cavern are far too strong for them to deal with.  Bring me the bow and I will overlook your inexperience and promote the Marksman to Stalker and as before the rest will be given an honorary title." ]]
		evt.Add("QBits", 122)         -- NPC
		evt.SetNPCTopic{NPC = 14, Index = 1, Event = 100}         -- "Lady Kathryn" : "Bow of Artemis"
	else
		evt.SetMessage(43)         -- "You are not yet qualified for this second promotion.  Get some experience in you current class and then return to me.  We'll talk then."
	end
end

-- "Bow of Artemis"
evt.global[100] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 420) then         -- "Bow of Artemis"
		evt.SetMessage(113)         --[[ "[Lady Kathryn glances at you]

I knew it was a mistake to fast track your party to promotion, but I have only myself to blame putting trust in a group of novices.  Go before I have the guards throw you out." ]]
		return
	end
	evt.SetMessage(115)         -- "“Well done young marksman, I had only heard stories of how magnificent the Bow of Artemis was, and now I can see it with my own eyes.  Promotion is immediately granted to the rank of Stalker and Honorary Stalker to those not a marksman.  Now I must beg your leave, as I have affairs of state to deal with.”"
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 122)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Experience", 50000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Stalker"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Stalker"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Stalker"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Stalker"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Stalker"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Stalker"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Stalker"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Stalker"
	end
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 94}         -- "Lady Kathryn" : "Stalker"
end

-- "Stalker"
evt.global[94] = function()
	evt.SetMessage(116)         -- "Welcome, Stalkers!  You may warm yourself by my hearth any time!"
end

-- "Adultery!"
evt.global[95] = function()
	evt.SetMessage(94)         --[[ "Those who say I'm an adulteress are twisting the truth! I've never committed any sin! Here's my story:

When we met, my husband Georgeton fell in love with me immediately. He was wise, sensitive and cared for me as if I were a lonely, beautiful flower. Care? Hah! He was lucky to be married to the most alluring woman in Nimradur. While his words were filled with caresses and his touch gentle, he lacked the burning passion I longed for.

One morning Georgeton went to chop lumber. As I watched him disappear, I noticed a strikingly handsome man. With one wink from me, he approached my door and introduced himself as Wilkit. At that moment, this dazzling man was the only thing I cared about or wanted.

Georgeton was furious when he came home - with that horrible axe, he killed Wilkit. One chop - and his head fell to the floor. Blood splattered everywhere. Georgeton, just looked at me painfully and left forever. Is it my fault that Georgeton went mad and left because of a meaningless rendezvous?" ]]
	if evt.Cmp("QBits", 105) then         -- NPC
		evt.SetNPCTopic{NPC = 65, Index = 0, Event = 98}         -- "Laura Lucious" : "Judged!"
	end
end

-- "True Righteousness!"
evt.global[96] = function()
	evt.SetMessage(93)         --[[ "[Monsignor Hyppo Krit, the pretentious priest, looks down his nose; and in a smug tone of voice says:]

Well, what is it you want?  Understand that you will never achieve the level of holiness that I possess. Therefore, you are disqualified from even being in my presence. I don't have time to waste with such wretched riff-raff. Begone! Or my guards will have you thrown in prison!

[Wishing to get out from under his disdainful stare, you leave as quickly as possible.]" ]]
	if evt.Cmp("QBits", 105) then         -- NPC
		evt.SetNPCTopic{NPC = 195, Index = 0, Event = 113}         -- "Monsignor Hyppo Krit" : "Judged!"
	end
end

-- "I am the Greatest!"
evt.global[97] = function()
	evt.SetMessage(92)         --[[ "[Dexter D. Fraud begins to brag before you can even get a word in edgewise]

So you're the famous adventurers I've heard about. That's nothing! I personally killed a dozen cyclopes with just a stroke of my dagger. Then I killed all the other monsters surrounding these parts in just one hour. Not only that, but later, for my astounding bravery, I was proclaimed a glorious knight and given all these lands as far as the eye can see. I single-handedly saved Nimradur from a plague of invading barbarians, stopped the ocean from causing a flood, prevented a herd of wild unicorns from trampling the town, married a beautiful, royal and massively rich princess, outwitted a band of Archangels at difficult mathematical puzzles, found the pot of gold at the end of the rainbow, and ... 

[You roll your eyes and quickly walk away.]" ]]
	if evt.Cmp("QBits", 105) then         -- NPC
		evt.SetNPCTopic{NPC = 162, Index = 0, Event = 102}         -- "Dexter  D. Fraud" : "Judged!"
	end
end

-- "Judged!"
evt.global[98] = function()
	evt.SetMessage(68)         -- "Because of your transgressions against the gods and goddesses,  and by the authority of King Jaffar High Exorcist of The Realm, you are hereby judged as guilty and are henceforth exiled from the lands of Nimradur forever."
	evt.MoveNPC{NPC = 65, HouseId = 0}         -- "Laura Lucious"
	evt.Set("QBits", 460)         -- Adulteress Judged
end

-- "Judged!"
evt.global[101] = function()
	evt.SetMessage(68)         -- "Because of your transgressions against the gods and goddesses,  and by the authority of King Jaffar High Exorcist of The Realm, you are hereby judged as guilty and are henceforth exiled from the lands of Nimradur forever."
	evt.MoveNPC{NPC = 51, HouseId = 0}         -- "Thornton Thuggly"
	evt.Set("QBits", 458)         -- Bully Judged
end

-- "Judged!"
evt.global[102] = function()
	evt.SetMessage(68)         -- "Because of your transgressions against the gods and goddesses,  and by the authority of King Jaffar High Exorcist of The Realm, you are hereby judged as guilty and are henceforth exiled from the lands of Nimradur forever."
	evt.MoveNPC{NPC = 162, HouseId = 0}         -- "Dexter  D. Fraud"
	evt.Set("QBits", 457)         -- Liar Judged
end

-- "Service to the Crown"
evt.global[103] = function()
	evt.SetMessage(18)         --[[ "The first order of business is to raise the siege of my castle and then clear the town of Jorgsborg of these foul creatures.

When you have accomplished this return to me for a far more dangerous task."" ]]
end

-- "Rules"
evt.global[104] = function()
	evt.SetMessage(180)         -- "Welcome to the Circus of the Sun!  We have a variety of games for your amusement.  You can take the prizes you win from the various games and trade them in here for either kegs of wine or golden pyramids.  You need at least 10 points to get a keg of wine, and 30 or more points will win you a golden pyramid.  In case you didn't know, each lodestone is worth 1 point, each harpy feather is worth 3 points, and each four leaf clover is worth 5 points.  "
end

-- "Prizes"
evt.global[105] = function()
	if evt.Cmp("TotalCircusPrize", 30) then
		evt.Add("Inventory", 472)         -- "Golden Pyramid"
		evt.SetMessage(184)         -- "Congratulations!  You win a golden pyramid!  Good work– remember there are no limits on the prizes, so keep playing!"
		evt.ForPlayer("All")
	else
		if not evt.Cmp("TotalCircusPrize", 10) then
			evt.SetMessage(182)         -- "I'm sorry, but you don't have 10 points yet.  Why don't you try a few more games?"
			return
		end
		evt.Add("Inventory", 473)         -- "Keg of Wine"
		evt.SetMessage(183)         -- "Congratulations!  You win a keg of wine!  There are no limits on the prizes here, so keep playing!"
		evt.ForPlayer("All")
	end
::_14::
	if not evt.Cmp("Inventory", 470) then         -- "Lodestone"
		goto _18
	end
	evt.Subtract("Inventory", 470)         -- "Lodestone"
	goto _14
::_18::
	if not evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		goto _22
	end
	evt.Subtract("Inventory", 471)         -- "Harpy Feather"
	goto _18
::_22::
	if not evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
		return
	end
	evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
	goto _22
end

-- "Instructions"
evt.global[106] = function()
	evt.SetMessage(185)         -- "Welcome!  To play my game, simply pay 50 gold and step right up to compete against me.  Depending on how well you do you can win either a lodestone, a harpy feather, or a four leaf clover.  If you do poorly, you win nothing.  You can trade in your lodestones, feathers, and clovers in the main tent."
end

-- "Play Might Game for 50 Gold"
evt.global[107] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentMight", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentMight", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentMight", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentMight", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentMight", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Play Endurance Game for 50 Gold"
evt.global[108] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentEndurance", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentEndurance", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentEndurance", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentEndurance", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentEndurance", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Play Speed Game for 50 Gold"
evt.global[109] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentSpeed", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentSpeed", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentSpeed", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentSpeed", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentSpeed", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Play Accuracy Game for 50 Gold"
evt.global[110] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentAccuracy", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentAccuracy", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentAccuracy", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentAccuracy", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentAccuracy", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Play Luck Game for 50 Gold"
evt.global[111] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentLuck", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentLuck", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentLuck", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentLuck", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentLuck", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Play  Intellect Game for 50 Gold"
evt.global[112] = function()
	local i
	evt.Subtract("Gold", 50)
	if evt.Cmp("CurrentIntellect", 200) then
		i = Game.Rand() % 6
		if i == 1 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 2 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 3 then
			evt.Add("Inventory", 477)         -- "Four Leaf Clover"
			evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
		elseif i == 4 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		elseif i == 5 then
			evt.Add("Inventory", 471)         -- "Harpy Feather"
			evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
		else
			evt.Add("Inventory", 470)         -- "Lodestone"
			evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
		end
	else
		if evt.Cmp("CurrentIntellect", 150) then
			i = Game.Rand() % 6
			if i == 1 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 2 then
				evt.Add("Inventory", 477)         -- "Four Leaf Clover"
				evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
			elseif i == 3 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 4 then
				evt.Add("Inventory", 471)         -- "Harpy Feather"
				evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
			elseif i == 5 then
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			else
				evt.Add("Inventory", 470)         -- "Lodestone"
				evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
			end
		else
			if evt.Cmp("CurrentIntellect", 100) then
				i = Game.Rand() % 6
				if i == 1 then
					evt.Add("Inventory", 477)         -- "Four Leaf Clover"
					evt.SetMessage(189)         -- "Incredible!  Are you sure you didn't cheat?  Well, a rule's a rule.  Here's your prize– a four leaf clover!"
				elseif i == 2 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 3 then
					evt.Add("Inventory", 471)         -- "Harpy Feather"
					evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
				elseif i == 4 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				elseif i == 5 then
					evt.Add("Inventory", 470)         -- "Lodestone"
					evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
				else
					evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
				end
			else
				if evt.Cmp("CurrentIntellect", 75) then
					i = Game.Rand() % 6
					if i == 1 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 2 then
						evt.Add("Inventory", 471)         -- "Harpy Feather"
						evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
					elseif i == 3 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 4 then
						evt.Add("Inventory", 470)         -- "Lodestone"
						evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
					elseif i == 5 then
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					else
						evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
					end
				else
					if evt.Cmp("CurrentIntellect", 50) then
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 471)         -- "Harpy Feather"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					else
						i = Game.Rand() % 6
						if i == 1 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(188)         -- "Excellent work, you win a harpy feather!"
						elseif i == 2 then
							evt.Add("Inventory", 470)         -- "Lodestone"
							evt.SetMessage(187)         -- "Good job, I thought I had you there.  You win a lodestone!"
						elseif i == 3 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 4 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						elseif i == 5 then
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						else
							evt.SetMessage(186)         -- "Too bad!  You came pretty close.  For 50 gold, I'll give you another chance."
						end
					end
				end
			end
		end
	end
end

-- "Judged!"
evt.global[113] = function()
	evt.SetMessage(68)         -- "Because of your transgressions against the gods and goddesses,  and by the authority of King Jaffar High Exorcist of The Realm, you are hereby judged as guilty and are henceforth exiled from the lands of Nimradur forever."
	evt.MoveNPC{NPC = 195, HouseId = 0}         -- "Monsignor Hyppo Krit"
	evt.Set("QBits", 459)         -- Self Righteous Judged
end

-- "Pearl of Turmoil"
evt.global[114] = function()
	evt.SetMessage(301)         -- "[A striking warrior-like lady greets you]   I am Mallt, a follower of the Agrona and I have chosen you to fulfill a most important quest.  Even though you are a motley group of adventurers, I can change your status to that of heroes!  But you first must retrieve the Pearl of Turmoil for me.  It is currently hidden in Orpheus’s Gateway in Tuonela.  Go there and bring it to me and the heralds will sing your praises and I will fill your packs with gold."
	evt.Set("QBits", 141)         -- NPC
	evt.SetNPCTopic{NPC = 37, Index = 0, Event = 299}         -- "Mallt" : "We've found the Pearl of Turmoil!"
end

-- "Lodestones"
evt.global[115] = function()
	evt.Set("AutonotesBits", 100)         -- "Squiggie Msg#4.  The Matron Symlac rules Desolation's End."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 470) then         -- "Lodestone"
		evt.Subtract("Inventory", 470)         -- "Lodestone"
		evt.Add("Gold", 5)
		evt.SetMessage(195)         -- "Thank you!  You're too generous– this will make a lovely gift.  Here's the 5 gold I owe you."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 470) then         -- "Lodestone"
			evt.Subtract("Inventory", 470)         -- "Lodestone"
			evt.Add("Gold", 5)
			evt.SetMessage(195)         -- "Thank you!  You're too generous– this will make a lovely gift.  Here's the 5 gold I owe you."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 470) then         -- "Lodestone"
				evt.Subtract("Inventory", 470)         -- "Lodestone"
				evt.Add("Gold", 5)
				evt.SetMessage(195)         -- "Thank you!  You're too generous– this will make a lovely gift.  Here's the 5 gold I owe you."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 470) then         -- "Lodestone"
					evt.Subtract("Inventory", 470)         -- "Lodestone"
					evt.Add("Gold", 5)
					evt.SetMessage(195)         -- "Thank you!  You're too generous– this will make a lovely gift.  Here's the 5 gold I owe you."
				else
					evt.SetMessage(194)         -- "Many people aren't able to visit the circus, so I'm collecting circus prizes to give away to those not able to visit it themselves.  I'll buy lodestones for 5 gold each if you want to part with them."
				end
			end
		end
	end
end

-- "Harpy Feathers"
evt.global[116] = function()
	evt.Set("AutonotesBits", 101)         -- "Squiggie Msg#5.  You must now talk with the Tree of Passage to activate the Flashing Tunnel to Desolation's End."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		evt.Subtract("Inventory", 471)         -- "Harpy Feather"
		evt.Add("Gold", 10)
		evt.SetMessage(197)         -- "Thanks!  Don't tell my daughter about this, I want to surprise her.  Here's the 10 gold."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
			evt.Subtract("Inventory", 471)         -- "Harpy Feather"
			evt.Add("Gold", 10)
			evt.SetMessage(197)         -- "Thanks!  Don't tell my daughter about this, I want to surprise her.  Here's the 10 gold."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
				evt.Subtract("Inventory", 471)         -- "Harpy Feather"
				evt.Add("Gold", 10)
				evt.SetMessage(197)         -- "Thanks!  Don't tell my daughter about this, I want to surprise her.  Here's the 10 gold."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
					evt.Subtract("Inventory", 471)         -- "Harpy Feather"
					evt.Add("Gold", 10)
					evt.SetMessage(197)         -- "Thanks!  Don't tell my daughter about this, I want to surprise her.  Here's the 10 gold."
				else
					evt.SetMessage(196)         -- "My daughter wants to go to the circus, but we never have the time when the circus is near here.  I'd love to give her a bunch of the pretty harpy feathers for her.  I'll take any harpy feathers you have for 10 gold each."
				end
			end
		end
	end
end

-- "Golden Pyramids"
evt.global[117] = function()
	evt.Set("AutonotesBits", 102)         -- ""
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
		evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
		evt.Add("Gold", 1000)
		evt.SetMessage(393)         -- "Thanks!  I can't wait to take this to Abdul's Desert Resort and see what I get!  Oh, here's the money I owe you."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
			evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
			evt.Add("Gold", 1000)
			evt.SetMessage(393)         -- "Thanks!  I can't wait to take this to Abdul's Desert Resort and see what I get!  Oh, here's the money I owe you."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
				evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
				evt.Add("Gold", 1000)
				evt.SetMessage(393)         -- "Thanks!  I can't wait to take this to Abdul's Desert Resort and see what I get!  Oh, here's the money I owe you."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
					evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
					evt.Add("Gold", 1000)
					evt.SetMessage(393)         -- "Thanks!  I can't wait to take this to Abdul's Desert Resort and see what I get!  Oh, here's the money I owe you."
				else
					evt.SetMessage(198)         -- "I've heard that you can get really nifty things from Abdul's Desert Resort if you pay with golden pyramids.  I'm hoping to go there one day, and I want to stock up on the pyramids now.  I'll take any golden pyramids you have for 1000 gold."
				end
			end
		end
	end
end

-- "Kegs of Wine"
evt.global[118] = function()
	evt.Set("AutonotesBits", 103)         -- ""
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
		evt.Subtract("Inventory", 473)         -- "Keg of Wine"
		evt.Add("Gold", 300)
		evt.SetMessage(395)         -- "My favorite!  Thanks for the wine!  Here's 300 gold, it's well worth the price."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
			evt.Subtract("Inventory", 473)         -- "Keg of Wine"
			evt.Add("Gold", 300)
			evt.SetMessage(395)         -- "My favorite!  Thanks for the wine!  Here's 300 gold, it's well worth the price."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
				evt.Subtract("Inventory", 473)         -- "Keg of Wine"
				evt.Add("Gold", 300)
				evt.SetMessage(395)         -- "My favorite!  Thanks for the wine!  Here's 300 gold, it's well worth the price."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
					evt.Subtract("Inventory", 473)         -- "Keg of Wine"
					evt.Add("Gold", 300)
					evt.SetMessage(395)         -- "My favorite!  Thanks for the wine!  Here's 300 gold, it's well worth the price."
				else
					evt.SetMessage(394)         -- "My favorite wine is the stuff they give you for winning at the circus.  I'll pay 300 gold for any keg of wine from the circus that you can bring me."
				end
			end
		end
	end
end

-- "Crystal Skull"
evt.global[119] = function()
	evt.SetMessage(123)         -- "Welcome.  The Seer sent you to me so I can examine the skull in your possession.  While doing so I have a task for you.  On the chance this skull is real and the Drow seek the four skulls for the worshipers of Chaos, then we must be the first to secure them.  I know of a second skull’s location. This scroll will give what information I have.  My operatives hopefully will uncover the locations of the other two soon.  The warding on the dungeon holding the second skull has been broken, so you should be able to enter without difficulty.  I will take the Crystal skull.  Return to me after the second has been recovered."
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 466)         -- "Crystal Skull"
	evt.Set("QBits", 128)         -- NPC
	evt.SetNPCTopic{NPC = 46, Index = 0, Event = 121}         -- "Magnus" : "Bronze Skull"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 517)         -- "Skull Scroll 1"
end

-- "Four Leaf Clovers"
evt.global[120] = function()
	evt.Set("AutonotesBits", 105)         -- ""
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
		evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
		evt.Add("Gold", 25)
		evt.SetMessage(404)         -- "Hurray!  This is much easier and much less embarrasing than going to the circus and losing!  Here's 25 gold!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
			evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
			evt.Add("Gold", 25)
			evt.SetMessage(404)         -- "Hurray!  This is much easier and much less embarrasing than going to the circus and losing!  Here's 25 gold!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
				evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
				evt.Add("Gold", 25)
				evt.SetMessage(404)         -- "Hurray!  This is much easier and much less embarrasing than going to the circus and losing!  Here's 25 gold!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
					evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
					evt.Add("Gold", 25)
					evt.SetMessage(404)         -- "Hurray!  This is much easier and much less embarrasing than going to the circus and losing!  Here's 25 gold!"
				else
					evt.SetMessage(398)         -- "I have been to the circus three times, and I can't win anything.  All I really want are the nifty four leaf clovers they use as prizes there.  I'll pay 25 gold for any four leaf clover you bring me."
				end
			end
		end
	end
end

-- "Bronze Skull"
evt.global[121] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 469) then         -- "Bronze Skull"
		evt.SetMessage(125)         -- "You succeeded in your first task, good.  I have been able to determine the first skull was in fact the true Crystal Skull.  I also have confirmed the Drow are attempting to secure them for some unknown purpose.  Fortunately, my operatives have found the locations of the last two skulls so you can now finish this task.  The information you need and the method of entry you require is in the possession of my most trusted operative, HodgePodge.  She is very sensitive to the vibrations of nature and its creatures.  The protectors of the last two skulls have violated the laws of nature.  Your mission has become personal to her and she wishes to speak to you personally.  She can be found in Avalon."
		evt.Subtract("Inventory", 469)         -- "Bronze Skull"
		evt.Subtract("QBits", 128)         -- NPC
		evt.Set("QBits", 129)         -- NPC
		evt.SetNPCTopic{NPC = 46, Index = 0, Event = 0}         -- "Magnus"
		evt.SetNPCTopic{NPC = 112, Index = 0, Event = 267}         -- "Hodge Podge" : "Magnus sent us to see you."
		evt.MoveNPC{NPC = 112, HouseId = 406}         -- "Hodge Podge" -> "Home of HodgePodge"
		evt.Subtract("Inventory", 517)         -- "Skull Scroll 1"
	else
		evt.SetMessage(124)         -- "Why come back now, you don’t have the second skull and I have not heard from my operatives?  Complete your task then come back to me."
	end
end

-- "The Coven of Dalhar Caluss"
evt.global[122] = function()
	evt.SetMessage(375)         --[[ "[Hilda sizes you up as you enter her home.] You are a motely group, but I am in need of assistance.  The Coven of Dalhar Caluss, lead by the infamous Witch-crone Morgana, is gathering to conquer the skies above the Bog and gain control of all Tuonela.  Once a month during what the locals call Hexennacht, they venture out and take as many children as they can find.  I hope to remove the curse and create a land as good and fertile as any in the realm, but without the young these efforts will be useless.  If these witches continue the monthly hunts, all that will be left will be the old and infirm.

You must clear the skies of all witches, slay Morgana and her Hag Prophetess, and return with Morgana’s Ring.  Morgana draws more of these foul hags to herself by the hour, so time is of the essence or they will replace their losses rapidly.  Return to me once you have succeeded." ]]
	evt.Add("QBits", 204)         -- NPC
	evt.SetNPCTopic{NPC = 330, Index = 0, Event = 123}         -- "Hilda" : "Destroy the Coven"
end

-- "Destroy the Coven"
evt.global[123] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 451) then         -- 4-hour  timer for quest complete
		evt.SetMessage(377)         -- "You have performed a great service, the witches may or may not return but you have broken the cycle of terror.  It seems they had help of a dark ally, but when you cleared the skies their ally has now lost confidence in them and has withdrawn their support.  The residents have seen they can be beaten no longer live in fear of them.  The children will be safe from their predatory nature.  You have earned your reward."
		evt.Add("Awards", 60)         -- ""
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 100)
		evt.Subtract("QBits", 204)         -- NPC
		evt.SetNPCTopic{NPC = 330, Index = 0, Event = 0}         -- "Hilda"
		evt.MoveNPC{NPC = 330, HouseId = 0}         -- "Hilda"
	else
		if evt.Cmp("Inventory", 412) then         -- "Ring of Morgana"
			evt.Set("QBits", 453)         -- Morgana's Ring Delivered (timer)
			evt.SetMessage(381)         -- "You have done well to slay Morgana but the foul hags continue to rule the skies.  Please rid Tuonela of these witches and then return to me."
		else
			evt.SetMessage(376)         -- "The witches still terroize the children of the bog and Morgana still rules.  Clear our lands of these foul hags and return with the Ring of Morgana."
		end
	end
end

-- "Welcome"
evt.global[124] = function()
	evt.SetMessage(440)         -- "Welcome to my Desert Resort!  You'll notice we don't have the riff-raff associated with the towns and villages of the lands here.  Take a moment to relax and enjoy the serenity of the desert, my friends.  If you're interested, we have a few traders here that will trade rare items for weapons and armor– it may be worth your while to check them out."
end

-- "Fountain of Youth"
evt.global[125] = function()
	evt.SetMessage(441)         -- "It seems rumors abound about my little Resort.  Alas, the Fountain of Youth everyone seems to be talking about is not here, it's a few days journey to the west."
end

-- "Instructions"
evt.global[126] = function()
	evt.SetMessage(442)         -- "Hello!  I've got great suits of armor that I'll trade for golden pyramids or kegs of wine."
end

-- "Instructions"
evt.global[127] = function()
	evt.SetMessage(444)         -- "I'll trade high quality weapons for golden pyramids or kegs of wine."
end

-- "Instructions"
evt.global[128] = function()
	evt.SetMessage(445)         -- "I have a wide variety of magical accessories I'll gladly trade for golden pyramids or kegs of wine."
end

-- "Trade Pyramid for Armor"
evt.global[129] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
		evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
			evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
			evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
			evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
				evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
				evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
				evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
					evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
					evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
					evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
				else
					evt.SetMessage(448)         -- "I'm afraid you don't have a golden pyramid, so I can't make a deal with you."
				end
			end
		end
	end
end

-- "Trade Pyramid for Weapon"
evt.global[130] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
		evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
			evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
			evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
			evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
				evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
				evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
				evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
					evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
					evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
					evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
				else
					evt.SetMessage(448)         -- "I'm afraid you don't have a golden pyramid, so I can't make a deal with you."
				end
			end
		end
	end
end

-- "Trade Pyramid for Accessory"
evt.global[131] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
		evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
			evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
			evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
			evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
				evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
				evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
				evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 472) then         -- "Golden Pyramid"
					evt.Subtract("Inventory", 472)         -- "Golden Pyramid"
					evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
					evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
				else
					evt.SetMessage(448)         -- "I'm afraid you don't have a golden pyramid, so I can't make a deal with you."
				end
			end
		end
	end
end

-- "Trade Keg for Armor"
evt.global[132] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
		evt.Subtract("Inventory", 473)         -- "Keg of Wine"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
			evt.Subtract("Inventory", 473)         -- "Keg of Wine"
			evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
			evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
				evt.Subtract("Inventory", 473)         -- "Keg of Wine"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
				evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
					evt.Subtract("Inventory", 473)         -- "Keg of Wine"
					evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
					evt.SetMessage(446)         -- "Great to do business with you, here's your armor!"
				else
					evt.SetMessage(449)         -- "You don't have a keg of wine to trade!"
				end
			end
		end
	end
end

-- "Trade Keg for Weapon"
evt.global[133] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
		evt.Subtract("Inventory", 473)         -- "Keg of Wine"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
			evt.Subtract("Inventory", 473)         -- "Keg of Wine"
			evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
			evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
				evt.Subtract("Inventory", 473)         -- "Keg of Wine"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
				evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
					evt.Subtract("Inventory", 473)         -- "Keg of Wine"
					evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
					evt.SetMessage(450)         -- "Great to do business with you, here's your weapon!"
				else
					evt.SetMessage(449)         -- "You don't have a keg of wine to trade!"
				end
			end
		end
	end
end

-- "Trade Keg for Accessory"
evt.global[134] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
		evt.Subtract("Inventory", 473)         -- "Keg of Wine"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
			evt.Subtract("Inventory", 473)         -- "Keg of Wine"
			evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
			evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
				evt.Subtract("Inventory", 473)         -- "Keg of Wine"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
				evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 473) then         -- "Keg of Wine"
					evt.Subtract("Inventory", 473)         -- "Keg of Wine"
					evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
					evt.SetMessage(451)         -- "Great to do business with you, here's your accessory!"
				else
					evt.SetMessage(449)         -- "You don't have a keg of wine to trade!"
				end
			end
		end
	end
end

-- "Trade Lamp for Gems"
evt.global[135] = function()
	local i
	evt.Set("AutonotesBits", 107)         -- ""
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 483) then         -- "Magic Lamp"
		evt.Subtract("Inventory", 483)         -- "Magic Lamp"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 483) then         -- "Magic Lamp"
			evt.Subtract("Inventory", 483)         -- "Magic Lamp"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 483) then         -- "Magic Lamp"
				evt.Subtract("Inventory", 483)         -- "Magic Lamp"
			else
				evt.ForPlayer(3)
				if not evt.Cmp("Inventory", 483) then         -- "Magic Lamp"
					evt.SetMessage(452)         -- "I'm collecting used magic lamps, but I don't have any money.  I'll trade you some of these pretty stones for the lamps, though."
					return
				end
				evt.Subtract("Inventory", 483)         -- "Magic Lamp"
			end
		end
	end
	i = Game.Rand() % 6
	if i == 1 then
		evt.Add("Inventory", 436)         -- "Diamond"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	elseif i == 2 then
		evt.Add("Inventory", 445)         -- "Sapphire"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	elseif i == 3 then
		evt.Add("Inventory", 444)         -- "Emerald"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	elseif i == 4 then
		evt.Add("Inventory", 443)         -- "Sunstone"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	elseif i == 5 then
		evt.Add("Inventory", 439)         -- "Ruby"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	else
		evt.Add("Inventory", 442)         -- "Purple Topaz"
		evt.SetMessage(453)         -- "Thanks for the lamp!  Here are your stones."
	end
end

-- "Drow Skulls"
evt.global[136] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 466) then         -- "Crystal Skull"
		if evt.Cmp("Inventory", 469) then         -- "Bronze Skull"
			if evt.Cmp("Inventory", 447) then         -- "Gold Skull"
				if evt.Cmp("Inventory", 464) then         -- "White Skull"
					evt.SetMessage(131)         --[[ "You have done well to recover all four skulls, my friends.  I'll take these and keep them safe.

The Drow have become somewhat problematic as of late, and we have alarming reports coming from the Elves concerning them.  Please journey to Castle Birka and talk with Indis Nénharma, a regal Elf of high standing in her nation.  Obey her as you would me." ]]
					evt.Subtract("Inventory", 464)         -- "White Skull"
					evt.Subtract("Inventory", 447)         -- "Gold Skull"
					evt.Subtract("Inventory", 469)         -- "Bronze Skull"
					evt.Subtract("Inventory", 466)         -- "Crystal Skull"
					evt.Subtract("QBits", 130)         -- NPC
					evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
					evt.Add("Experience", 50000)
					evt.Add("Awards", 40)         -- ""
					evt.Subtract("Inventory", 456)         -- "Amulet of Entrance"
					evt.Set("QBits", 165)         -- NPC
					evt.MoveNPC{NPC = 299, HouseId = 518}         -- "Indis Nénharma" -> "Royal Guest Chambers"
					evt.SetNPCTopic{NPC = 299, Index = 0, Event = 333}         -- "Indis Nénharma" : "Ched Rhinn"
					evt.SetNPCTopic{NPC = 300, Index = 0, Event = 317}         -- "Tanfana" : "Fimbulvetr"
					return
				end
			end
		end
	end
	evt.SetMessage(130)         -- "You must retrieve all four Drow skulls to complete this quest."
end

-- "Jasper Rice"
evt.global[260] = function()
	evt.SetMessage(267)         -- "The best staff teacher in the land, Jasper Rice, lives up in Avalon.  You'll want to talk to him if you wish to continue your training with the staff."
end

-- "Guy Hampton"
evt.global[261] = function()
	evt.SetMessage(268)         -- "Guy Hampton in Cheroburg taught me everything I know about the sword.  If you're looking to master the blade, he's the one to train under."
end

-- "Jules Miles"
evt.global[262] = function()
	evt.SetMessage(269)         -- "I'm only a novice when compared to someone like Jules Miles.  He lives near the Temple of Tranquility, and he can teach anyone how to improve their dagger skills."
end

-- "Avinril Smythers"
evt.global[263] = function()
	evt.SetMessage(270)         -- "Avinril Smythers mastered the axe before most of us were even born, but he doesn't train humans.  I'm sure if you could do something special for him, he might consider teaching a human how to really swing an axe.  He spends most of his time in the Haunt in the Bog of Tuonella."
end

-- "Burton Rutherford"
evt.global[264] = function()
	evt.SetMessage(271)         -- "The best spearman in Enroth, Burton Rutherford, lives in Kopelinori .  I'm not sure why he picks such a remote place to call his home.  Maybe he doesn't like being bothered with students?"
end

-- "Desmond Weller"
evt.global[265] = function()
	evt.SetMessage(272)         -- "To master the bow, you need to talk to Desmond Weller in the Town of Akershaven, Norseland.""
end

-- "Errol Ostermann"
evt.global[266] = function()
	evt.SetMessage(273)         -- "If you want to master the mace, you need to speak to Errol Ostermann in Cheroburg."
end

-- "Magnus sent us to see you."
evt.global[267] = function()
	evt.SetMessage(126)         -- "Welcome.  I have been awaiting your arrival.  We have little time; the final two skulls must be recovered quickly.  I have reason to believe the Drow know of their locations.  Both have been hidden in dungeons long forgotten.  The abominations that protect them are a sin against nature, retrieving them will serve a duel purpose.  We not only make the realm safe from the Drow, but also smite the violators of nature in one stroke.  I’ve written in this scroll the location of each skull.  Now to enter these dungeons I must accompany you.  The rituals necessary to break the protective wards are too complicated to teach you in the short amount of time we have.  So I’m packed, let’s get moving."
	evt.SetNPCTopic{NPC = 112, Index = 0, Event = 0}         -- "Hodge Podge"
	evt.Add("NPCs", 112)         -- "Hodge Podge"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 518)         -- "Skull Scroll 2"
	evt.MoveNPC{NPC = 112, HouseId = 0}         -- "Hodge Podge"
	evt.SetNPCTopic{NPC = 46, Index = 0, Event = 287}         -- "Magnus" : "We've found the two skulls!"
end

-- "Bronwyn Meck"
evt.global[268] = function()
	evt.SetMessage(275)         -- "No one can use a shield like Bronwyn Meck in Cheroburg.  That's the person to talk to if you want to master the shield."
end

-- "Arlen Sailor"
evt.global[269] = function()
	evt.SetMessage(276)         -- "Arlen Sailor runs the best school in the art of wearing leather armor.  He normally holds his classes near thd Temple of Tranquility, east of the mountains in Demonclaw."
end

-- "David Feather"
evt.global[270] = function()
	evt.SetMessage(277)         -- "The village of Kopelinori in the Bog of Tuonella is the home of David Feather, the only person I know of that can teach you to master your skill in chain armor."
end

-- "Forrest Suthers"
evt.global[271] = function()
	evt.SetMessage(278)         -- "Forrest Suthers, one of the head Paladins in Nimradur, teaches how to master plate in Port Sleigon."
end

-- "Veleda Kenny"
evt.global[272] = function()
	evt.SetMessage(279)         -- "To master the ignis skill you need to speak to Veleda Kennyin the Mystic Isles."
end

-- "Caao Salem"
evt.global[273] = function()
	evt.SetMessage(280)         -- "Caao Salem can show you even more tricks with aeros magic in Ellesia."
end

-- "Harper Collins"
evt.global[274] = function()
	evt.SetMessage(281)         -- "To gain mastery of the aqua skill you need to train under Harper Collins in the Mystic Isles."
end

-- "Dryde Fauna"
evt.global[275] = function()
	evt.SetMessage(282)         -- "Dryde Fauna can train you to master the terra skill in the Mystic Isles."
end

-- "Amergin McGrath"
evt.global[276] = function()
	evt.SetMessage(283)         -- "Animus can be mastered with the help of Amergin McGrath.  He lives on the Mystic Isles."
end

-- "Sitchenn Jones"
evt.global[277] = function()
	evt.SetMessage(284)         -- "Sitchenn Jones can train you to master the mentis skill on the Mystic Isles."
end

-- "Gilbert Hammer"
evt.global[278] = function()
	evt.SetMessage(285)         -- "If you're looking to master corpus magic, you need to talk to Gilbert Hammer on the Mystic Isles."
end

-- "Ki Lo Nee"
evt.global[279] = function()
	evt.SetMessage(286)         -- "Light magic is a difficult skill to learn, and the Great Teacher, Ki Lo Nee, can only be found somewhere in the Mystic Isles."
end

-- "Su Lang Manchu"
evt.global[280] = function()
	evt.SetMessage(287)         -- "Su Lang Manchu was my teacher in dark magic.  He may be found in the Temple of Darkness."
end

-- "Hans Gifford"
evt.global[281] = function()
	evt.SetMessage(288)         -- "Hans Gifford can show you even more neat tricks in identifying items in Port Sleigon."
end

-- "Will Ottoman"
evt.global[282] = function()
	evt.SetMessage(289)         -- "The smoothest talking merchant I've ever seen is Will Ottoman in Port Sleigon.  If you're looking to improve your merchant skill, he's the man to see."
end

-- "Ryan Treacle"
evt.global[283] = function()
	evt.SetMessage(290)         -- "If you think I'm good at repairing things, Ryan Treacle is the best around.  I'm sure he can be convinced to assist you in mastering the skill.  He lives up near the Temple of Tranquility the last I heard."
end

-- "Jason Traveler"
evt.global[284] = function()
	evt.SetMessage(291)         -- "Jason Traveler will coach you in the finest points of body-building.  He works in Avalonn, if you can handle his rigorous training."
end

-- "Norio Ariganaka"
evt.global[285] = function()
	evt.SetMessage(292)         -- "If mastering meditation is your goal, you'll need to see Norio Ariganaka in Ellesia."
end

-- "Macro Caligula"
evt.global[286] = function()
	evt.SetMessage(293)         -- "Perception can be mastered with help from Macro Caligula in the Bog of Tuonella."
end

-- "We've found the two skulls!"
evt.global[287] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 447) then         -- "Gold Skull"
		evt.SetMessage(127)         -- "Recovering two skulls has been helpful, but no one will be safe until all four have been properly dealt with.  Bring them to me as soon as they have been recovered."
	else
		if evt.Cmp("Inventory", 464) then         -- "White Skull"
			evt.Subtract("Inventory", 447)         -- "Gold Skull"
			evt.Subtract("Inventory", 464)         -- "White Skull"
			evt.Subtract("NPCs", 112)         -- "Hodge Podge"
			evt.Subtract("QBits", 129)         -- NPC
			evt.SetMessage(128)         --[[ "You have done well.  Your task is complete and now mine begins.  The skulls are protected by powerful magic and their destruction is probably impossible.  It is for me to hide them in a secure and secret location, so that they are permanently locked away.

Return to the Seer as he is not yet done with you.

It has been a pleasure doing business with you, but I doubt that our paths will ever cross again, goodbye." ]]
			evt.Add("Experience", 50000)
			evt.Add("Awards", 39)         -- ""
			evt.MoveNPC{NPC = 46, HouseId = 0}         -- "Magnus"
			evt.SetNPCTopic{NPC = 46, Index = 0, Event = 0}         -- "Magnus"
			evt.SetNPCTopic{NPC = 9, Index = 1, Event = 290}         -- "The Seer" : "Sad and Alarming News."
			evt.Subtract("Inventory", 518)         -- "Skull Scroll 2"
		else
			evt.SetMessage(127)         -- "Recovering two skulls has been helpful, but no one will be safe until all four have been properly dealt with.  Bring them to me as soon as they have been recovered."
		end
	end
end

-- "Gabe Lester"
evt.global[288] = function()
	evt.SetMessage(295)         -- "The greatest trap disarmer, Gabe Lester, is currently teaching his craft near The Temple of Tranquility in Demonclaw.  He's the person to talk to if you want to learn all the best tricks."
end

-- "John Tuck"
evt.global[289] = function()
	evt.SetMessage(296)         -- "John Tuck can teach you to master the learning skill.  I believe he's still living in Port Sleigon."
end

-- "Sad and Alarming News."
evt.global[290] = function()
	evt.SetMessage(129)         --[[ "[The Seer looks at you with sadness.]  I wish I had good news for you but I don’t.  The body of Magnus was found outside of the town of Ellesia, and the skulls were nowhere to be found.  He was stabbed in the back.  Whether this was a traitor receiving a traitor’s payment or he was ambushed, I cannot say.  I prefer to believe the Drow struck him down, and have taken back the skulls.  We must retrieve them within a week or the Drow will be able to reinforce their main fortresses, making them more difficult or even impossible to defeat.

Proceed to Sutters Bay immediately.  On an island off the northern shore of Suttersville, there is a cave called Underwald.  I believe this is where the Drow are holding the skulls.  The entrance is magically warded, but this necklace will allow you to gain entry.

Rid the Underwald of the Drow presence, retrieve the skulls, and bring them to me.  Hurry!" ]]
	evt.Add("QBits", 130)         -- NPC
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 136}         -- "The Seer" : "Drow Skulls"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 456)         -- "Amulet of Entrance"
end

-- "Promotion to Dark Master"
evt.global[291] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("ClassIs", const.Class.ArchDruid) then
		evt.Set("DarkSkill", 68)
		evt.SetMessage(133)         -- "Done!  Let's move on."
	else
		if evt.Cmp("DarkSkill", 68) then
			evt.Set("DarkSkill", 139)
			evt.SetMessage(133)         -- "Done!  Let's move on."
		else
			evt.SetMessage(132)         -- "Sorry.  You don't qualify.  Let's move on."
		end
	end
end

-- "The Ether World"
evt.global[292] = function()
	evt.SetMessage(177)         --[[ "You have done well, my friends.  The Moment of Truth has arrived.  Now you must enter Creation’s Land through The Void and destroy the Chalice of the Gods to reset the Fabric of Time.  The only access to The Void is through the Fortress of Anarchy, which resides in the Ether of Darkness.

Chaos and His Lords dwell in the Fortress of Anarchy.  Until recently, there was no way to reach it. However, Tamara has discovered a way to access this fortress through the Drow Hive.

The Lesser Drow Goddess Kiaransalee has created an Ether Portal that disrupts the fabric of existence and can transport you to the Fortress of Anarchy.  To reach this device you must violate the Drow Hive in Glacier’s End, traverse a series of dark, dank tunnels, and find the Ether Jewel.  Tamara will meet you at the Ether Portal to provide you with additional information.

Good luck!" ]]
	evt.Add("QBits", 134)         -- NPC
	evt.SetNPCTopic{NPC = 9, Index = 1, Event = 0}         -- "The Seer"
end

-- "The Fortress of Anarchy"
evt.global[293] = function()
	evt.SetMessage(178)         --[[ "This portal takes you to the Fortress of Anarchy in the Ether of Darkness. You must exit this fortress by opening the ‘EXIT’ with four Ether Keys.  The Chaos Lord guards one of these keys, the Greater Drow Goddess Lolth and her three daughters guard a second key, and the God Chaos, Himself, guards the third key.  I haven’t been able to discover the location of the fourth key, so you’ll have to work that out yourselves.

The Captains of the Chaos Lord wield powerful Ether Weapons that may allow you to triumph over the God Chaos and his spawn.  You must, however, possess the proper skill to use these Ether Weapons, available only to the fighting classes of Doom Knight, Stalker, and Avenger. Based upon a special dispensation granted to me by Sir Zeddicus Z’ul the Fifth, I will grant you this skill.

Now it’s time to go through the portal.  Good luck, my friends!" ]]
	evt.Subtract("QBits", 134)         -- NPC
	evt.Add("Awards", 43)         -- ""
	evt.ForPlayer("All")
	evt.Add("Experience", 500000)
	evt.Set("QBits", 136)         -- NPC
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Champion) then
		goto _11
	end
	if evt.Cmp("ClassIs", const.Class.Hero) then
		goto _11
	end
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		goto _11
	end
::_12::
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Champion) then
		goto _17
	end
	if evt.Cmp("ClassIs", const.Class.Hero) then
		goto _17
	end
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		goto _17
	end
::_18::
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Champion) then
		goto _23
	end
	if evt.Cmp("ClassIs", const.Class.Hero) then
		goto _23
	end
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		goto _23
	end
::_24::
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Champion) then
		goto _29
	end
	if evt.Cmp("ClassIs", const.Class.Hero) then
		goto _29
	end
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		goto _29
	end
::_30::
	evt.SetNPCTopic{NPC = 8, Index = 0, Event = 0}         -- "Tamara"
	do return end
::_11::
	evt.Set("BlasterSkill", 136)
	goto _12
::_17::
	evt.Set("BlasterSkill", 136)
	goto _18
::_23::
	evt.Set("BlasterSkill", 136)
	goto _24
::_29::
	evt.Set("BlasterSkill", 136)
	goto _30
end

-- "1,000,000 EXP Boost Reward!"
evt.global[294] = function()
	evt.SetMessage(192)         --[[ "Greetings, adventurers! The town council of Chernobog is offering a One Million Experience ‘boost’ Award for slaying the Warrior-Lich Koschei and bringing his Soul Egg back to me.

To the south of town there is a cave inhabited by Koschei the Deathless, a merciless Warrior of unparalleled power.  The people live in continual fear of his midnight forays into the town.  Many young men have died useless deaths defending the town only to be turned into his personal retinue of undead guardians.  He must be stopped!

Unfortunately, if you ‘dispatch’ Koschei, he will simply return in time because his soul no longer resides in his body,but in a Soul Egg.  This egg is guarded by his ‘pet’ Falspar, a  Bone Dragon of terrible power.  So to qualify for the reward you must not only defeat Koschei but also acquire his Soul Egg from Falspar.  Slay Koschei and then return with his Soul Egg to me and the award will be yours." ]]
	evt.Set("QBits", 137)         -- NPC
	evt.SetNPCTopic{NPC = 54, Index = 0, Event = 295}         -- "Taija" : "Koschei and Soul Egg"
end

-- "Koschei and Soul Egg"
evt.global[295] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 474) then         -- "Soul Egg"
		evt.SetMessage(297)         -- "Ahhh!  You’ve got the  Soul Egg!  That’s quite an accomplishment, adventurers!  You most certainly have earned your reward!  "
		evt.Subtract("QBits", 137)         -- NPC
		evt.Add("Awards", 46)         -- ""
		evt.Add("Experience", 1000000)
		evt.Subtract("Inventory", 474)         -- "Soul Egg"
		evt.SetNPCTopic{NPC = 54, Index = 0, Event = 0}         -- "Taija"
	else
		evt.SetMessage(193)         --[[ "Adventurers why have you returned to me with the task incomplete?  Everyday Koschei lives is another night he will ride through the streets claiming more souls.

Just remember the 1,000,000 experience you’ll get for completing this task!" ]]
	end
end

-- "Personality Potion for 10,000 gold!"
evt.global[296] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 10000) then
		evt.SetMessage(30)         -- "Done!"
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.Add("Inventory", 183)         -- "Essence of Personality"
		evt.SetNPCTopic{NPC = 165, Index = 0, Event = 0}         -- "Trader Joe"
	else
		evt.SetMessage(260)         -- "You don't have enough gold!"
	end
end

-- "Intellect Potion for 10,000 gold!"
evt.global[297] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 10000) then
		evt.SetMessage(30)         -- "Done!"
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.Add("Inventory", 182)         -- "Essence of Intellect"
		evt.SetNPCTopic{NPC = 165, Index = 1, Event = 0}         -- "Trader Joe"
	else
		evt.SetMessage(260)         -- "You don't have enough gold!"
	end
end

-- "We have the Ingredients!"
evt.global[298] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 183) then         -- "Essence of Personality"
		if evt.Cmp("Inventory", 182) then         -- "Essence of Intellect"
			evt.SetMessage(300)         --[[ "Praise the godesses of nature, you have acquired the necessary ingredients!  Thank you.  Now I ask you to wait but a moment for me to mix the potion.

[After disappearing in the back of the hut for a few moments, Aelwen returns holding a potion bottle.] Here is the Elixir of Wisdom.  I ask one more favor.  Enter the Temple of Agrona's Faithful make your way deep inside and apply the elixir to the altar inside the temple.  Once it has been applied, the leader of the cult will have her hold on her followers broken.  This should weaken them and allow us to bring this civil war to an end.  Before you go here is the reward for bringing the ingredients." ]]
			evt.Subtract("Inventory", 183)         -- "Essence of Personality"
			evt.Subtract("Inventory", 182)         -- "Essence of Intellect"
			evt.Subtract("QBits", 138)         -- NPC
			evt.Set("Awards", 45)         -- ""
			evt.Set("QBits", 139)         -- NPC
			evt.ForPlayer("Current")
			evt.Add("Inventory", 528)         -- "Ceridwen’s Elixir of Wisdom"
			evt.ForPlayer("All")
			evt.Add("Experience", 12500)
			evt.SetNPCTopic{NPC = 17, Index = 0, Event = 0}         -- "Aelwen"
			return
		end
	end
	evt.SetMessage(299)         -- "Maybe I wasn’t clear.  I cannot make Ceridwen’s Elixir without both potions.  Now get out there and bring them to me."
end

-- "We've found the Pearl of Turmoil!"
evt.global[299] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 458) then         -- "Pearl of Turmoil"
		evt.SetMessage(303)         --[[ "Well look at you, you have managed to collect the Pearl of Turmoil.  I’ll be honest I didn’t think you had it in you.  You have proved your mettle and the reward is yours of course.

Now I offer you a chance of even greater reward.  This war is not going well for us. The druids have a pearl of their own, the Pearl of Fertility.  Now if you could break into their temple and switch pearls, that would disrupt their infernal magic and give my troops an upper hand on the battlefield.  Bring the Pearl of Fertility back to me as proof of your success.

So what are you waiting for?  Get going!" ]]
		evt.Subtract("QBits", 141)         -- NPC
		evt.Set("Awards", 48)         -- ""
		evt.Set("QBits", 143)         -- NPC
		evt.Add("Gold", 5000)
		evt.Add("Experience", 8500)
		evt.SetNPCTopic{NPC = 37, Index = 0, Event = 300}         -- "Mallt" : "We have the Pearl of Fertility!"
	else
		evt.SetMessage(302)         -- "Why have you come back without the pearl.  I am knee deep in troublesome druids and you come by here and waste my time.  Now get out!"
	end
end

-- "We have the Pearl of Fertility!"
evt.global[300] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 459) then         -- "Pearl of Fertility"
		evt.SetMessage(305)         --[[ "I knew when I first saw you that there were warriors buried somewhere hidden in you.  Now the resistance from those wimpy magic users will crumble and this little disagreement will come to a satisfying end.

Here’s you reward." ]]
		evt.Subtract("Inventory", 459)         -- "Pearl of Fertility"
		evt.Subtract("QBits", 143)         -- NPC
		evt.Set("Awards", 49)         -- ""
		evt.Add("Gold", 8000)
		evt.Subtract("ReputationIs", 1000)
		evt.SetNPCTopic{NPC = 37, Index = 0, Event = 0}         -- "Mallt"
	else
		evt.SetMessage(304)         -- "If you don’t have the stomachs for this task fine just leave the Pearl of Turmoil with me and go.  Otherwise get out and finish the job!"
	end
end

-- "Glastonbury Tor"
evt.global[301] = function()
	evt.SetMessage(306)         --[[ "Welcome travelers, or should I say soldiers of fortune.  I have need of such fellows.   To the south of town is Glastonbury Tor.  Once built to be the home of a lord, it was never occupied.  After years of being abandoned, squatters calling themselves the followers of the goddess Morrigan, have established a base of operation in the Tor.  Followers of a goddess my foot.  They are little more than bandits and it is time to put a stop to them.  I need you to enter the Tor, find the leader, put an end to her reign of thievery, and return to me with her legendary Fire Amulet.

[You look at Trevor and ask] You mean you want her killed?

[Trevor responds] I prefer that you send her to her goddess for punishment.  Do that and you will earn not only my praise but the praise of the council as well." ]]
	evt.Set("QBits", 144)         -- NPC
	evt.SetNPCTopic{NPC = 171, Index = 0, Event = 302}         -- "Trevor O'Farrell" : "Morrigan"
end

-- "Morrigan"
evt.global[302] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 579) then         -- "Fire Amulet"
		evt.SetMessage(308)         -- "I knew I had you pegged when I called you soldiers of fortune.  She is dead and now prosperity will return to the region.  Many thanks travelers.  Take your bounty with my thanks."
		evt.Subtract("Inventory", 579)         -- "Fire Amulet"
		evt.Subtract("QBits", 144)         -- NPC
		evt.Set("Awards", 51)         -- ""
		evt.Add("Experience", 12500)
		evt.Add("Gold", 2500)
		evt.Add("ReputationIs", 200)
		evt.SetNPCTopic{NPC = 171, Index = 0, Event = 0}         -- "Trevor O'Farrell"
	else
		evt.SetMessage(307)         --[[ "As long as the leader is allowed to live the region will suffer.  Go quickly and do the deed.

And don't forget the amulet!" ]]
	end
end

-- "Lemkanen My Son"
evt.global[303] = function()
	evt.SetMessage(309)         --[[ "[Ilmatar, the mother of the warrior Lemkanen laments her son’s death.  Seeing you she makes a proposition,]

My son discovered his wife was unfaithful, so he left the land seeking battle to forget his sorrows.  As he traveled he repaid his wife’s infidelity by seducing dozens of women.  This created many enemies who killed him.  They cremated him and divided the remains into six urns which they scattered throughout the realm.   Find the six urns and return them to me along with a potion of the god Ukko to heal him,.  The potion can only be made by an alchemist in Norseland.  Your reward will be great but beware my son’s wife, Kylliki would do anything to prevent you from succeeding in this venture." ]]
	evt.Add("QBits", 145)         -- "."
	evt.SetNPCTopic{NPC = 130, Index = 0, Event = 304}         -- "Ilmatar" : "We have the urns!"
	evt.SetNPCTopic{NPC = 224, Index = 0, Event = 338}         -- "Bogna" : "Potion of Ukko"
	evt.MoveNPC{NPC = 224, HouseId = 235}         -- "Bogna" -> "Bogna The Alchemist"
end

-- "We have the urns!"
evt.global[304] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 535) then         -- "Potion of the God Ukko "
		if evt.Cmp("Inventory", 467) then         -- "Urn #1"
			if evt.Cmp("Inventory", 550) then         -- "Urn #2"
				if evt.Cmp("Inventory", 551) then         -- "Urn #3"
					if evt.Cmp("Inventory", 552) then         -- "Urn #4"
						if evt.Cmp("Inventory", 553) then         -- "Urn #5"
							if evt.Cmp("Inventory", 548) then         -- "Urn #6"
								evt.SetMessage(311)         --[[ "[You hand the six urns and the Potion of Ukko to the mother.]

I see you have been successful.  Thank you so much!  Now I can restore my son to life and enjoy his company once again!

You have made this mother very happy!  May the gods bless you.  Here's your reward." ]]
								evt.Subtract("Inventory", 535)         -- "Potion of the God Ukko "
								evt.Subtract("Inventory", 467)         -- "Urn #1"
								evt.Subtract("Inventory", 550)         -- "Urn #2"
								evt.Subtract("Inventory", 551)         -- "Urn #3"
								evt.Subtract("Inventory", 552)         -- "Urn #4"
								evt.Subtract("Inventory", 553)         -- "Urn #5"
								evt.Subtract("Inventory", 548)         -- "Urn #6"
								evt.Subtract("QBits", 145)         -- "."
								evt.Set("Awards", 53)         -- ""
								evt.Add("Experience", 20000)
								evt.Add("ReputationIs", 200)
								evt.Add("Gold", 2500)
								evt.SetNPCTopic{NPC = 130, Index = 0, Event = 0}         -- "Ilmatar"
								evt.SetNPCTopic{NPC = 111, Index = 0, Event = 0}         -- "Kylliki"
								evt.Subtract("QBits", 162)         -- NPC
								return
							end
						end
					end
				end
			end
		end
	end
	evt.SetMessage(310)         -- "Adventurers, I hope you are making progress.  Please hurry I have been without my son’s company for too long."
end

-- "Lemkanen My husband"
evt.global[305] = function()
	evt.SetMessage(312)         --[[ "I am Kylliki, wife of Lemkanen and I have a proposition for you.  Long ago my husband saw me dancing with men in a local tavern and he thought I was unfaithful.  Despite my pleas, he left seeking battle to forget his sorrows.  As he traveled he tried to hurt me more by seducing dozens of women.  This created many enemies who killed him.  His body was cremated, then divided into six urns which were scattered throughout the realm..  Return the urns to me, together with a potion of the god Ukko to heal him.  The potion can only be made by an alchemist in Norseland.  Your reward will be great.

But beware! his mother, Ilmatar, would do anything to prevent me from being reunited with my husband." ]]
	evt.Add("QBits", 162)         -- NPC
	evt.SetNPCTopic{NPC = 111, Index = 0, Event = 306}         -- "Kylliki" : "We have the urns!"
	evt.SetNPCTopic{NPC = 224, Index = 0, Event = 338}         -- "Bogna" : "Potion of Ukko"
	evt.MoveNPC{NPC = 224, HouseId = 235}         -- "Bogna" -> "Bogna The Alchemist"
end

-- "We have the urns!"
evt.global[306] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 535) then         -- "Potion of the God Ukko "
		if evt.Cmp("Inventory", 467) then         -- "Urn #1"
			if evt.Cmp("Inventory", 550) then         -- "Urn #2"
				if evt.Cmp("Inventory", 551) then         -- "Urn #3"
					if evt.Cmp("Inventory", 552) then         -- "Urn #4"
						if evt.Cmp("Inventory", 553) then         -- "Urn #5"
							if evt.Cmp("Inventory", 548) then         -- "Urn #6"
								evt.SetMessage(314)         --[[ "[You hand the six urns and the Potion of Ukko to his wife.]

I see you have been successful.  Good. And now I have finally stopped Ilana from bringing her son back to life!  He was a scoundrel and a whore-monger and shall never again walk this earth!

Here, take your reward and leave me!  Let me savor my final revenge!" ]]
								evt.Subtract("Inventory", 535)         -- "Potion of the God Ukko "
								evt.Subtract("Inventory", 467)         -- "Urn #1"
								evt.Subtract("Inventory", 550)         -- "Urn #2"
								evt.Subtract("Inventory", 551)         -- "Urn #3"
								evt.Subtract("Inventory", 552)         -- "Urn #4"
								evt.Subtract("Inventory", 553)         -- "Urn #5"
								evt.Subtract("Inventory", 548)         -- "Urn #6"
								evt.Subtract("QBits", 162)         -- NPC
								evt.Set("Awards", 54)         -- ""
								evt.Add("Experience", 20000)
								evt.Subtract("ReputationIs", 200)
								evt.Add("Gold", 2500)
								evt.SetNPCTopic{NPC = 111, Index = 0, Event = 0}         -- "Kylliki"
								evt.SetNPCTopic{NPC = 130, Index = 0, Event = 0}         -- "Ilmatar"
								evt.Subtract("QBits", 145)         -- "."
								return
							end
						end
					end
				end
			end
		end
	end
	evt.SetMessage(313)         -- "Adventurers, I hope you are making progress.  Please hurry I have been without my husband’s company for too long.  The nights can be long and cold when you are alone."
end

-- "The Treasures of Danu"
evt.global[308] = function()
	evt.SetMessage(315)         -- "To receive the Goddess Danu’s blessing, her followers offered many great treasures.  As her following diminished Her High Priest carefully hid the best artifacts in Baal’s Garden in a chest buried under The Tree of Danu.  He warded the treasure with an incantation known only to him.  He encoded the incantation within five scrolls.  He selected his five most trusted disciples and gave each a scroll to hide in one of the various ‘dungeons’ of Nimradur.  It is said that should the Goddess return, the faithful could gather the scrolls and decode the incantation to unlock the Tree of Danu.  The finest artifacts in Nimradur would then be returned to her temples.  At least that’s how the story is told."
	evt.Add("QBits", 164)         -- NPC
	evt.SetNPCTopic{NPC = 137, Index = 0, Event = 0}         -- "Aoifa O'Malley"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 541)         -- "The Story of Danu's Treasure"
end

-- "Can you recover my property?"
evt.global[309] = function()
	evt.SetMessage(316)         -- "After my Mum’s passing, a family heirloom was shipped to me from Avalon in keeping with her last requests.  The shipment was intercepted by bandits operating out of the Cavern of the Rogue here in Kat’an.  Could you please recover this heirloom for me?  It is a simple yet valuable Hourglass that has been in my family for years.  Please help me."
	evt.Set("QBits", 146)         -- NPC
	evt.SetNPCTopic{NPC = 155, Index = 0, Event = 310}         -- "Thomalina Thumb" : "Hourglass"
end

-- "Hourglass"
evt.global[310] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 433) then         -- "Hourglass"
		evt.SetMessage(318)         --[[ "[Thomalina’s face lights up with joy as she spies the Hourglass]  Thank you!  Thank you!  Thank you so much for returning the Hourglass to me!   Hugs and kisses to you all, my brave heroes!

Please take this gold as your reward. I know it’s not much, but it’s all I can afford." ]]
		evt.Add("Awards", 56)         -- ""
		evt.Add("Experience", 5000)
		evt.Add("Gold", 1250)
		evt.Subtract("Inventory", 433)         -- "Hourglass"
		evt.Subtract("QBits", 146)         -- NPC
		evt.Add("ReputationIs", 50)
		evt.SetNPCTopic{NPC = 155, Index = 0, Event = 0}         -- "Thomalina Thumb"
	else
		evt.SetMessage(317)         -- "Please return the Hourglass to me."
	end
end

-- "Quest"
evt.global[311] = function()
	if evt.Cmp("QBits", 23) then         -- 23 D13, Given when Altar is desecrated
		evt.SetMessage(326)         -- "What is the delay?  Dagr grows weaker, the snow gets deeper, and you stop in for tea?  Please, with all haste, bring me the Statue of Holy Cleansing."
		evt.Subtract("QBits", 131)         -- NPC
		evt.Add("ReputationIs", 50)
		evt.Add("Gold", 3000)
		evt.ForPlayer("All")
		evt.Add("Awards", 43)         -- ""
		evt.Add("Experience", 15000)
		evt.SetNPCTopic{NPC = 267, Index = 0, Event = 0}         -- "Eleanor Vanderbilt"
		evt.MoveNPC{NPC = 267, HouseId = 0}         -- "Eleanor Vanderbilt"
	else
		evt.SetMessage(325)         -- "Hello.  Indis said to expect you.  I am Tanfana.  You must have noticed the continual snow fall in the Demonclaw.  It has gone on now for two years without relief.  It is said if the snow continues for three years, Fimbulvetr will end and Ragnorak will begin.  The Sun Goddess Sol has been prevented from casting her warmth on the region.  Her horse Dagr was poisoned and cannot pull the Trundholm Sun Chariot.  Only the Statue of Holy Cleansing can cure it.  Find and bring it here so this eternal winter can end and Ragnorak can be stopped.  Take this key and scroll, it will explain much that I have not.  Bring me the statue and I will see its curative power is invoked."
	end
end

-- "Cobra Eggs"
evt.global[312] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 474) then         -- "Soul Egg"
		evt.Subtract("Inventory", 474)         -- "Soul Egg"
		evt.Add("Gold", 300)
		evt.SetMessage(328)         -- "Away with you, beggars!  The King grants audience only to those high diplomats who are honorable in their deportment!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 474) then         -- "Soul Egg"
			evt.Subtract("Inventory", 474)         -- "Soul Egg"
			evt.Add("Gold", 300)
			evt.SetMessage(328)         -- "Away with you, beggars!  The King grants audience only to those high diplomats who are honorable in their deportment!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 474) then         -- "Soul Egg"
				evt.Subtract("Inventory", 474)         -- "Soul Egg"
				evt.Add("Gold", 300)
				evt.SetMessage(328)         -- "Away with you, beggars!  The King grants audience only to those high diplomats who are honorable in their deportment!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 474) then         -- "Soul Egg"
					evt.Subtract("Inventory", 474)         -- "Soul Egg"
					evt.Add("Gold", 300)
					evt.SetMessage(328)         -- "Away with you, beggars!  The King grants audience only to those high diplomats who are honorable in their deportment!"
				else
					evt.SetMessage(327)         --[[ "Well it took you long enough.  Dagr is almost dead.  However this statue can still cure him.  You have done well.  The winter will now end and for now at least, Ragnorak has been averted.  I think you will find your payment generous.

After you have conducted any remaining business, you should return to the Seer." ]]
				end
			end
		end
	end
end

-- "Quest"
evt.global[313] = function()
	evt.SetMessage(329)         -- "Removed Bat Guano Message"
	evt.Add("QBits", 133)         -- NPC
	evt.SetNPCTopic{NPC = 289, Index = 0, Event = 314}         -- "Barrad Unter" : "Quest"
	evt.Add("Inventory", 430)         -- "Leather Pouch"
end

-- "Harbor Grace"
evt.global[315] = function()
	evt.SetMessage(319)         --[[ "My late uncle, Re’al Goode, was the Bishop of Harbor Grace in Ellesia.  After his death, the Goode Order of the Temple eventually faded, and Harbor Grace was finally abandoned.  I would like to obtain the Sacred Candelabra from the temple as a momento of my uncle’s selfless work.  I will reward you handsomely upon it’s return.

Oh! and here’s the Harbor Grace key.  You’ll  need it to gain entrance to the old place." ]]
	evt.Add("QBits", 166)         -- NPC
	evt.SetNPCTopic{NPC = 298, Index = 0, Event = 316}         -- "Kinda Goode" : "Sacred Candelabra"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 525)         -- "Harbor Grace Key"
end

-- "Sacred Candelabra"
evt.global[316] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 449) then         -- "Sacred Candelabra"
		evt.SetMessage(321)         --[[ "The Candelabra!  Thanks for returning this me.  You have no idea how many fond memories of my late uncle this item brings to my mind.  Now I can proudly lay his memory to rest and get on with my life.

Thank you. Here’s your reward." ]]
		evt.Subtract("QBits", 166)         -- NPC
		evt.Add("Gold", 3000)
		evt.Add("ReputationIs", 50)
		evt.ForPlayer("All")
		evt.Add("Awards", 57)         -- ""
		evt.Add("Experience", 20000)
		evt.Subtract("Inventory", 525)         -- "Harbor Grace Key"
		evt.Subtract("Inventory", 449)         -- "Sacred Candelabra"
		evt.SetNPCTopic{NPC = 298, Index = 0, Event = 0}         -- "Kinda Goode"
	else
		evt.SetMessage(320)         -- "I cannot reward you until you’ve returned with the Sacred Candelabra."
	end
end

-- "Fimbulvetr"
evt.global[317] = function()
	evt.SetMessage(325)         -- "Hello.  Indis said to expect you.  I am Tanfana.  You must have noticed the continual snow fall in the Demonclaw.  It has gone on now for two years without relief.  It is said if the snow continues for three years, Fimbulvetr will end and Ragnorak will begin.  The Sun Goddess Sol has been prevented from casting her warmth on the region.  Her horse Dagr was poisoned and cannot pull the Trundholm Sun Chariot.  Only the Statue of Holy Cleansing can cure it.  Find and bring it here so this eternal winter can end and Ragnorak can be stopped.  Take this key and scroll, it will explain much that I have not.  Bring me the statue and I will see its curative power is invoked."
	evt.Add("QBits", 201)         -- NPC
	evt.SetNPCTopic{NPC = 300, Index = 0, Event = 318}         -- "Tanfana" : "We have the Statue!"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 502)         -- "Tanfan's Scroll"
	evt.Add("Inventory", 514)         -- "Chest Key"
end

-- "We have the Statue!"
evt.global[318] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 453) then         -- "Statuette of Holy Cleansing"
		evt.SetMessage(327)         --[[ "Well it took you long enough.  Dagr is almost dead.  However this statue can still cure him.  You have done well.  The winter will now end and for now at least, Ragnorak has been averted.  I think you will find your payment generous.

After you have conducted any remaining business, you should return to the Seer." ]]
		evt.Subtract("Inventory", 453)         -- "Statuette of Holy Cleansing"
		evt.Subtract("QBits", 201)         -- NPC
		evt.Add("Gold", 10000)
		evt.Subtract("Inventory", 502)         -- "Tanfan's Scroll"
		evt.ForPlayer("All")
		evt.Add("Awards", 59)         -- ""
		evt.Add("Experience", 50000)
		evt.MoveNPC{NPC = 300, HouseId = 0}         -- "Tanfana"
		evt.SetNPCTopic{NPC = 300, Index = 0, Event = 0}         -- "Tanfana"
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 33}         -- "The Seer" : "It's time to deal with Chaos."
		evt.Add("QBits", 228)         -- NPC
	else
		evt.SetMessage(326)         -- "What is the delay?  Dagr grows weaker, the snow gets deeper, and you stop in for tea?  Please, with all haste, bring me the Statue of Holy Cleansing."
	end
end

-- "Greeting"
evt.global[319] = function()
	evt.SetMessage(338)         -- "Thank you for turning me back to normal. I’d love to stay and chat, but I really should be getting out of here."
end

-- "Greeting"
evt.global[320] = function()
	evt.SetMessage(339)         -- "Thank you for turning me back to normal. I’d love to stay and chat, but I really should be getting out of here."
end

-- "Thank you!"
evt.global[321] = function()
	evt.SetMessage(340)         --[[ "Thank you for the rescue.  Unfortunately I have nothing to offer for your deed.  You see I was traveling to the east, well running away actually.  There is a woman in Chernobog named Jaana Barthold who has been chasing after me for months trying to get me to marry her.  I don’t know if you’ve met her or not but she is crazy.  Well I got caught by the Rusalki and lost all of my possession.  Only the gods know what they intended; so please except my thanks and don’t tell Jaana you saw me.

As he leaves you chuckle, well Jaana that’s one that got away." ]]
end

-- "Divine Cure for 10,000 gold!"
evt.global[322] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 10000) then
		evt.SetMessage(30)         -- "Done!"
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.Add("Inventory", 179)         -- "Divine Cure"
		evt.SetNPCTopic{NPC = 165, Index = 2, Event = 340}         -- "Trader Joe" : "Rejuvenation for 10,000 gold!"
	else
		evt.SetMessage(260)         -- "You don't have enough gold!"
	end
end

-- "Quest"
evt.global[323] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 400) then         -- "Mordred"
		evt.SetMessage(343)         -- "So this is the legendary Mordred, eh?  Interesting, I was expecting something much grander.  I don’t think I want it, actually.  Why don’t you keep it, and I’ll deal with my friend on the cost."
		evt.Add("Awards", 47)         -- ""
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 30000)
		evt.Add("ReputationIs", 100)
		evt.Subtract("QBits", 137)         -- NPC
		evt.SetNPCTopic{NPC = 76, Index = 0, Event = 0}         -- "Zoltan Phelps"
		evt.MoveNPC{NPC = 76, HouseId = 0}         -- "Zoltan Phelps"
	else
		evt.SetMessage(342)         -- "Hello again.  No one has found Mordred yet, so our deal is still good.  I’ll give you part of the selling price for the artifact if you return it."
	end
end

-- "Quest"
evt.global[324] = function()
	evt.SetMessage(344)         -- "Members of the Shadow Guild have moved down south recently, and have been trying to exert their influence over merchants in the area.  I refused them access to our town, so they kidnapped Sharry Carnegie, an old healer loved by the townspeople, in an attempt to ‘convince’ me to let them operate here.  I can’t believe that their extortion has moved so far south, I thought I was safe from that down here.  Please rescue Sharry– I can offer you some money as a reward, and I’m sure the townsfolk would appreciate her return."
	evt.Add("QBits", 138)         -- NPC
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 325}         -- "Fernando Calabar" : "Quest"
end

-- "Quest"
evt.global[325] = function()
	if evt.Cmp("NPCs", 193) then         -- "FREE"
		evt.SetMessage(346)         -- "Thank you so much for saving Sharry!  I can’t tell you how much this means to both New Sorpigal and myself.  You have our gratitude forever."
		evt.Subtract("NPCs", 193)         -- "FREE"
		evt.Subtract("QBits", 138)         -- NPC
		evt.Add("Gold", 2000)
		evt.ForPlayer("All")
		evt.Add("Awards", 48)         -- ""
		evt.Add("Experience", 10000)
		evt.SetNPCTopic{NPC = 3, Index = 0, Event = 0}         -- "Fernando Calabar"
	else
		evt.SetMessage(345)         -- "Have you found Sharry yet?  No?  I’m sure she’s wherever the Shadow Guild is hiding out.  Find them and you’ll find her."
	end
end

-- "Shadow Guild"
evt.global[326] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 504) then         -- "Mabon’s Cave"
		evt.SetMessage(347)         -- "Interesting.  The Dragoons were hired by the Shadow Guild.  I’m certain Anthony Stone will want to hear about this.  I’ll present this letter when I see him next. Thank you for this.  I’m sure he will want to take action against the Shadow Guild now that we have some proof of their deeds."
		evt.Subtract("Inventory", 504)         -- "Mabon’s Cave"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 50)
		evt.SetNPCTopic{NPC = 3, Index = 1, Event = 0}         -- "Fernando Calabar"
	else
		evt.SetMessage(399)         -- "I'm so tired of the Shadow Guild, but I don't have any substantial proof of their activities.  I'd love to have something I could show to Anthony Stone proving the Shadow Guild is up to no good down here."
	end
end

-- "Suttersville"
evt.global[327] = function()
	evt.SetMessage(348)         -- "Thank you for rescuing me from these horrible ruffians!  I’d like to go back home to New Sorpigal now."
	evt.Set("NPCs", 193)         -- "FREE"
end

-- "Have you seen Tamara?"
evt.global[328] = function()
	evt.SetMessage(10)         --[[ "Long time no-see, friends!  On another one of your 'grand adventures'?

Tamara? Yes, she stopped by here a couple of weeks ago for a visit.  One morning last week, she said that she  was going to Tortuga Hall in search of information, and never returned.  I am somewhat worried about her.

Please see if she's OK." ]]
	evt.SetNPCTopic{NPC = 154, Index = 0, Event = 0}         -- "Graham"
end

-- "Quest"
evt.global[329] = function()
	if evt.Cmp("NPCs", 195) then         -- "Monsignor Hyppo Krit"
		evt.SetMessage(351)         -- "She’s alive!  Thank you so much for finding Angela!  If I weren’t so happy to see her, she’d be in a lot of trouble.  Please take this as a reward for all you’ve done."
		evt.MoveNPC{NPC = 195, HouseId = 471}         -- "Monsignor Hyppo Krit" -> "House"
		evt.Subtract("NPCs", 195)         -- "Monsignor Hyppo Krit"
		evt.Subtract("QBits", 139)         -- NPC
		evt.Add("Gold", 500)
		evt.Add("Food", 10)
		evt.ForPlayer("All")
		evt.Add("Awards", 49)         -- ""
		evt.Add("Experience", 1000)
		evt.SetNPCTopic{NPC = 154, Index = 0, Event = 0}         -- "Graham"
		evt.SetNPCTopic{NPC = 195, Index = 0, Event = 0}         -- "Monsignor Hyppo Krit"
	else
		evt.SetMessage(350)         -- "You didn’t find poor Angela?  Something horrible must have happened to her!"
	end
end

-- "Help!"
evt.global[330] = function()
	evt.SetMessage(352)         -- "I think I'm lost…<sob>…I want to go home!"
	evt.Set("NPCs", 195)         -- "Monsignor Hyppo Krit"
end

-- "Cursed!"
evt.global[331] = function()
	evt.SetMessage(353)         --[[ "Who is it that dares to enters the home of one cursed by Branwen?

Cursed by whom?  Branwen, the goddess of love.  She has forsaken me.

My fiancée Maikki Barthold went to visit her older sister Jaana to tell her of our engagement.  She lives in Chernoburg, and it seems there is a shortage of men there, Being older, she will not allow Maikki to marry until she is betroved.

Please go to Chernoburg and bring Maikki back to me." ]]
	evt.Add("QBits", 140)         -- NPC
	evt.SetNPCTopic{NPC = 200, Index = 0, Event = 332}         -- "Tierney Quinn" : "Maikki Barthold"
end

-- "Maikki Barthold"
evt.global[332] = function()
	if evt.Cmp("NPCs", 41) then         -- "Maikki Barthold"
		evt.SetMessage(355)         --[[ "[Tierney addresses his love] Maikki, thank Branwen for relenting and letting you rejoin me!  Come, the wedding arrangements have all been made just as you wanted.  We can be married immediately.

[You interrupt the conversation] Ah, excuse me; there is the small matter of our payment.

What?  Oh yes of course.  Here, take it and leave.  Can’t you see we want to be alone." ]]
		evt.MoveNPC{NPC = 41, HouseId = 297}         -- "Maikki Barthold" -> "Tierney Quinn's Place"
		evt.Subtract("NPCs", 41)         -- "Maikki Barthold"
		evt.Subtract("QBits", 140)         -- NPC
		evt.SetNPCTopic{NPC = 155, Index = 0, Event = 0}         -- "Thomalina Thumb"
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 50)         -- ""
		evt.SetNPCTopic{NPC = 200, Index = 0, Event = 0}         -- "Tierney Quinn"
	else
		evt.SetMessage(354)         -- "Please, you can not begin to grasp the heartache caused by this forced separation.  Hurry and bring my love to me."
	end
end

-- "Ched Rhinn"
evt.global[333] = function()
	evt.SetMessage(322)         --[[ "I’m Indis Nénharma. My name means Drow Slayer, and I earned this name in the war where we drove the Drow underground.  But now they’ve returned and are expanding their presence.  They’ve created Driders and the priestesses of Lolth are attempting to create Draegloths; done by a priestess mating with a summoned demon.  My sources tell me there is still time to prevent this.  Enter Ched Rhinn through a secret entrance that is found by placing this statuette on a pedestal in the northwest of Norseland and kill the Demon Breeder.  I will ensure the city’s warding is broken before you arrive.  Bring proof of the kill and you will be rewarded.

I urge you to see Tanfana before you enter Ched Rhinn.  She can be found in Norseland and has another task in that same city." ]]
	evt.Set("QBits", 200)         -- Wilbur Humphrey
	evt.Subtract("QBits", 165)         -- NPC
	evt.SetNPCTopic{NPC = 299, Index = 0, Event = 334}         -- "Indis Nénharma" : "We have slain the Breeder!"
	evt.MoveNPC{NPC = 300, HouseId = 239}         -- "Tanfana" -> "Home of Tanfana"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 451)         -- "Bear Statuette"
end

-- "We have slain the Breeder!"
evt.global[334] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 455) then         -- "Demon Claw"
		evt.SetMessage(324)         --[[ "[Seeing the Demon Claw and hearing your report Indis Nénharma’s heart sank.]  I had hoped I was wrong, but your report convinces me I was right.

[Upon which you speak] Why so forlorn, we have killed all that were present in their city?    And the Breeder will no longer spread his foul seed.

[Indis takes a deep breath ans speaks in a low tone] Never under estimate the Drow.  I’m sure other priestesses are pregnant with the Draegloth.  They are too devious to allow any single group from destroying all of them.  It is true you succeeded here and set their timeline back, but it may also be true they have succeeded elsewhere.  Thank you for your service and take your reward along with my thanks.  I must leave and return to my elfin brethren." ]]
		evt.Subtract("Inventory", 455)         -- "Demon Claw"
		evt.Subtract("QBits", 200)         -- Wilbur Humphrey
		evt.Add("Awards", 58)         -- ""
		evt.SetNPCTopic{NPC = 9, Index = 1, Event = 33}         -- "The Seer" : "It's time to deal with Chaos."
		evt.SetNPCTopic{NPC = 299, Index = 0, Event = 0}         -- "Indis Nénharma"
		evt.Add("Experience", 100000)
		evt.Add("Gold", 10000)
		evt.MoveNPC{NPC = 299, HouseId = 0}         -- "Indis Nénharma"
	else
		evt.SetMessage(323)         -- "I know you have not finished, and the news is grave.  The Drow have nearly succeeded in birthing a Draegloth.  You must hurry before they create one."
	end
end

-- "Quest"
evt.global[335] = function()
	if evt.Cmp("QBits", 17) then         -- 17 D17, given when wolf altar is destroyed.
		evt.SetMessage(359)         -- "Thank you!  We can now sleep at night without worrying about what kinds of foul acts we will commit as monsters!  It’s a tragedy that our lord was a werewolf himself; he’ll be sorely missed.  Please accept this for your help, and for believing in us."
		evt.Subtract("QBits", 141)         -- NPC
		evt.Add("Gold", 4000)
		evt.Add("ReputationIs", 100)
		evt.ForPlayer("All")
		evt.Add("Experience", 20000)
		evt.Add("Awards", 52)         -- ""
		evt.SetNPCTopic{NPC = 212, Index = 0, Event = 0}         -- "Taija Borsa"
		evt.MoveNPC{NPC = 212, HouseId = 0}         -- "Taija Borsa"
	else
		evt.SetMessage(358)         -- "Is there no hope for us?  Please promise me you’ll keep searching for a way to reverse the curse and turn us back to normal people."
	end
end

-- "Potion of Ukko"
evt.global[338] = function()
	evt.SetMessage(332)         --[[ "[Bogna speaks.]  Adventurers why do you enter my home?

[You reply.]  We seek a potion of Ukko to heal the body of Lemkanen.

[Bogna continues.]  I am not sure he is worthy, he ruined the reputation of many women.  His death could be considered justice.  However, mine is not to reason the good or bad of the man but to render aid to those who seek it.  Against my better judgement I will create one for you.  Bring me a Potion of Divine Cure and a Potion of Rejuvenation and you will have your potion." ]]
	evt.Set("QBits", 235)         -- NPC
	evt.SetNPCTopic{NPC = 224, Index = 0, Event = 339}         -- "Bogna" : "We have the Ingredients!"
end

-- "We have the Ingredients!"
evt.global[339] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 179) then         -- "Divine Cure"
		if evt.Cmp("Inventory", 188) then         -- "Rejuvenation"
			evt.SetMessage(334)         --[[ "So, you return at last.   Give me a moment.

Well mixing black potions takes not only skill but patience.  Here is your potion.  Bring him back if you wish, but your actions will be judged by whatever god you follow." ]]
			evt.Subtract("QBits", 235)         -- NPC
			evt.Subtract("Inventory", 179)         -- "Divine Cure"
			evt.Subtract("Inventory", 188)         -- "Rejuvenation"
			evt.ForPlayer("Current")
			evt.Add("Inventory", 535)         -- "Potion of the God Ukko "
			evt.SetNPCTopic{NPC = 224, Index = 0, Event = 0}         -- "Bogna"
			return
		end
	end
	evt.SetMessage(333)         -- "Back again, but without the potions?  Well there is nothing I can do for you until you bring them to me."
end

-- "Rejuvenation for 10,000 gold!"
evt.global[340] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 10000) then
		evt.SetMessage(30)         -- "Done!"
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 10000)
		evt.Add("Inventory", 188)         -- "Rejuvenation"
		evt.SetNPCTopic{NPC = 165, Index = 2, Event = 0}         -- "Trader Joe"
	else
		evt.SetMessage(260)         -- "You don't have enough gold!"
	end
end

-- "Quest"
evt.global[341] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 458) then         -- "Pearl of Turmoil"
		evt.SetMessage(366)         -- "Thank you for defeating the werewolf leader.  I wish that I had been strong enough to stop this from happening.  Please accept my thanks for allowing my spirit to move on.  I will take the pearl away so that it may no longer cause any harm to the people of Enroth."
		evt.Subtract("Inventory", 458)         -- "Pearl of Turmoil"
		evt.Add("Experience", 5000)
		evt.Add("Awards", 51)         -- ""
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 143)         -- NPC
		evt.Add("QBits", 35)         -- 35 D17 Brought back Black Pearl and Ghost will no longer show up.
		evt.SetNPCTopic{NPC = 295, Index = 2, Event = 0}         -- "Ghost of Balthasar"
	else
		evt.SetMessage(365)         -- "The werewolf leader possesses the Pearl of Putrescence, the opposite of my Pearl of Purity.  With this pearl, he has been able to cause the curse.  I was never able to kill him in my retreat.  I will be able to rest in peace knowing that he has been defeated."
	end
end

-- "Pearl of Purity"
evt.global[342] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 459) then         -- "Pearl of Fertility"
		evt.SetMessage(367)         -- "What’s this?  You have the Pearl of Purity?  I thought Balthasar– oh, he’s dead is he?  I’ll keep it for now, then, as per his last wishes.  Thank you on behalf of both him and me."
		evt.Subtract("Inventory", 459)         -- "Pearl of Fertility"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 142)         -- NPC
		evt.SetNPCTopic{NPC = 4, Index = 2, Event = 0}         -- "King Jaffar"
	else
		evt.SetMessage(400)         -- "One of the few remaining Paladin artifacts left is the Pearl of Purity.  Balthasar was in possession of the pearl the last I heard.  He was visiting Lord Spindler in Blackshire, but I haven't heard anything from him in months."
	end
end

-- "Have I got a deal fer YOU!"
evt.global[347] = function()
	evt.SetMessage(372)         -- "Ahoy there, Mateys!  Have I got a deal fer you.  Fer jus' 500 pieces o' gold booty, I will give each of ya 10 points o' Magic Resistance!  Whadoya say, land lubbers?"
	evt.SetNPCTopic{NPC = 296, Index = 0, Event = 348}         -- "Scurvey McGinnis" : "Buy Magic Resistance"
end

-- "Buy Magic Resistance"
evt.global[348] = function()
	if evt.Cmp("Gold", 500) then
		evt.ForPlayer("All")
		evt.Subtract("Gold", 125)
		evt.Add("MagicResistance", 10)
		evt.SetMessage(373)         -- "It's a deal!  Here ya go!"
		evt.Subtract("ReputationIs", 200)
		evt.SetNPCTopic{NPC = 296, Index = 0, Event = 0}         -- "Scurvey McGinnis"
	else
		evt.SetMessage(260)         -- "You don't have enough gold!"
	end
end

-- "Audience with the King"
evt.global[349] = function()
	evt.SetMessage(328)         -- "Away with you, beggars!  The King grants audience only to those high diplomats who are honorable in their deportment!"
end

-- "We need your help!"
evt.global[351] = function()
	evt.SetMessage(379)         --[[ "Well hello.   Answer me this question.  What is a young attractive lady like me and several others in this town to do if all of the young men fall victim to a Rusalka?

[You start to back up out of the hut.]  Well it’s not something we’ve given much thought.

[Dismissing your answer, Jaana continues.]  It is said that Rusalki like to seduce men.  They can do so by enticing men with their singing and then drowning them.  I don’t believe it, I mean why drown them?  I believe they have captured them and are keeping them for their own uses in the Temple on the island to the east of here.  You go free the men and return and I’ll reward you for your efforts." ]]
	evt.Add("QBits", 219)         -- NPC
	evt.SetNPCTopic{NPC = 87, Index = 0, Event = 352}         -- "Jaana Barthold" : "Men of Chernobog"
end

-- "Men of Chernobog"
evt.global[352] = function()
	if evt.Cmp("QBits", 203) then         -- NPC
		evt.SetMessage(97)         --[[ "Oh I see you have finally come to collect your reward.  I cannot tell you how happy I am you succeeded.  Why in the last hour no less than three men have come calling.  Real good looking ones, how will I ever make up my mind?  I know perhaps ...

[This time you made it to the door.] That’s quite alright.  Thank you for the reward, but we really must be going." ]]
		evt.SetNPCTopic{NPC = 87, Index = 0, Event = 0}         -- "Jaana Barthold"
		evt.ForPlayer("All")
		evt.Subtract("QBits", 219)         -- NPC
		evt.Add("Awards", 36)         -- ""
		evt.Add("Experience", 10000)
	else
		evt.SetMessage(407)         -- "Why are you here, I’ve not seen any of the men return, trust me I’d be one of the first to notice.  Then again, they would have been lining up to knock on my door.  Now get back out there, I’m not getting any younger.  Besides I think my sister want to leave, but she is my only company."
	end
end

-- "Hello"
evt.global[353] = function()
	if evt.Cmp("QBits", 140) then         -- NPC
		if evt.Cmp("QBits", 203) then         -- NPC
			evt.SetMessage(105)         -- "This is glorious news; Jaana is happily distracted by all of the attention the men are paying her.  I can now accompany you to Port Sleigon.  We best hurry in case none of the men are serious."
			evt.Add("NPCs", 41)         -- "Maikki Barthold"
			evt.SetNPCTopic{NPC = 41, Index = 0, Event = 0}         -- "Maikki Barthold"
			evt.MoveNPC{NPC = 41, HouseId = 0}         -- "Maikki Barthold"
		else
			evt.SetMessage(104)         -- "You say Tierney sent you to escort me back to Port Sleigon?  that’s wonderful!  Alas, unless Jaana has prospects for marriage, she will never agree to let me leave.  Please help her and then escort me to him."
		end
	else
		if evt.Cmp("QBits", 203) then         -- NPC
			evt.SetMessage(190)         -- "I am happy for my sister; Jaana is lavishing in all of the attention the men are paying her.  It seems the Rusalk had an affect on them and all the bachelors are seeking mates.  I on the other hand can not have true happiness until I can get Port Sleigon.  If you happen to meet Tierney Quinn tell him I am anxiously awaiting the arrival of the escort he promised.  You might mention with all of the men returning to Chernobog, he might not want to wait too long."
		else
			evt.SetMessage(378)         -- "Both my sister and I are forlorn; she can’t get a man and I have one but can’t get to him until Jaana has a chance at betrothal.  My fiancée has promised me an escort, but even if it arrived I’d couldn’t go with them."
		end
	end
end

-- "Audience with the Beneficent One"
evt.global[354] = function()
	evt.SetMessage(458)         -- "Away with you, beggars!  Only those high diplomats who are honorable in their deportment may see the Beneficent One!!"
end

-- "FREE"
evt.global[355] = function()
	evt.SetMessage(380)         -- "I was one of the mages studying at Kriegspire when the creatures there went completely out of control.  In my escape from the castle, I left a valuable item behind, a jeweled egg.  This egg is a family heirloom that goes back in my family as far as the Silence.  I have tried a few times to get it back, but the creatures there are too powerful for me.  I’d gladly trade a generous sum of money to get my egg back."
	evt.Add("QBits", 144)         -- NPC
	evt.SetNPCTopic{NPC = 201, Index = 0, Event = 356}         -- "Emil Lime" : "Quest"
end

-- "Quest"
evt.global[356] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 480) then         -- "Jeweled Egg"
		evt.SetMessage(382)         -- "You are courageous, indeed, adventurers.  But I don't think that you have enough experience yet to assist me.  However, if you are foolish enough to attempt to help me at this time, please select the topic again.  And Good Luck! "
		evt.Subtract("Inventory", 480)         -- "Jeweled Egg"
		evt.Add("Awards", 55)         -- ""
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("ReputationIs", 100)
		evt.Add("Gold", 5000)
		evt.Subtract("QBits", 144)         -- NPC
		evt.SetNPCTopic{NPC = 201, Index = 0, Event = 0}         -- "Emil Lime"
		evt.MoveNPC{NPC = 201, HouseId = 0}         -- "Emil Lime"
	else
		evt.SetMessage(381)         -- "You have done well to slay Morgana but the foul hags continue to rule the skies.  Please rid Tuonela of these witches and then return to me."
	end
end

-- "The Void"
evt.global[357] = function()
	evt.SetMessage(432)         --[[ "[The Seer contacts you telepathically]

You are about to enter The VOID, my friends.  It is through The VOID that you will go back in-timeto enter Creation's Land shortly after the Chalice of the Gods became corrupt.  You must find this chalice and destroy it.  This is the only way to 'set things right' in Nimradur.

Unfortunately, I cannot tell you where the Chalice is or how to destroy it.  Hopefully you can discover these things as you journey through the land." ]]
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 358}         -- "The Seer" : "Your Journey"
end

-- "Your Journey"
evt.global[358] = function()
	evt.SetMessage(433)         --[[ "I must be honest, adventurers.  This is a one-way journey.  Once you enter The VOID, you can not return to Nimradur.  However, if you are sucessful, your deads will become legend in Nimradur and your names will be immortalized.

Good Luck!" ]]
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 359}         -- "The Seer" : "SAVE your game!"
end

-- "SAVE your game!"
evt.global[359] = function()
	evt.SetMessage(434)         --[[ "[SAVE your game in the first SAVED Game slot.   Do this NOW.

Then INSTALL Part 2 of TCC and LOAD the SAVED Game.]" ]]
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 0}         -- "The Seer"
end

-- "Quest"
evt.global[360] = function()
	if not evt.Cmp("QBits", 71) then         -- Walt
		evt.SetMessage(386)         -- "As patient as I am, I would like to see the channels I use to sustain me opened again.  Please do not fail."
	else
		evt.SetMessage(387)         -- "Thank you for your assistance.  I am grateful to you for returning my source of sustenance to me.  I need to recharge what little power I have left now that I am able to again."
		if not evt.Cmp("QBits", 359) then         -- NPC
			evt.Subtract("QBits", 145)         -- "."
			evt.Add("QBits", 359)         -- NPC
			evt.ForPlayer("All")
			evt.Add("Awards", 57)         -- ""
			evt.Add("Experience", 10000)
			evt.SetNPCTopic{NPC = 298, Index = 2, Event = 0}         -- "Kinda Goode"
		end
	end
end

-- "Ankh"
evt.global[362] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 448) then         -- "Talisman of Life"
		evt.SetMessage(389)         -- "So, Sir John was murdered and the Silver Helms were bought off by the Temple of Baa?  That explains a great deal.  Good work on bringing this to me, but you’ll need to collect your reward from Anthony Stone."
		evt.Subtract("Inventory", 448)         -- "Talisman of Life"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.SetNPCTopic{NPC = 16, Index = 2, Event = 364}         -- "Baroness Klaravoyia" : "Ankh"
		evt.SetNPCTopic{NPC = 14, Index = 2, Event = 0}         -- "Lady Kathryn"
	else
		evt.SetMessage(402)         -- "Recently, the Fraternal Order of Silver has been disrupting my business and my caravans.  I'm not sure why Sir John feels it necessary, but I'd like this to stop.  If you could convince him to leave me alone, I'm sure I could give you a portion of the money you would be saving me."
	end
end

-- "Ankh"
evt.global[363] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 448) then         -- "Talisman of Life"
		evt.SetMessage(390)         -- "I should have known Baa was behind this, they seem to be behind everything.  Thank you for bringing this to me.  It answers the questions I had about the Fraternal Order of Silver."
		evt.Subtract("Inventory", 448)         -- "Talisman of Life"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.SetNPCTopic{NPC = 16, Index = 2, Event = 0}         -- "Baroness Klaravoyia"
		evt.SetNPCTopic{NPC = 14, Index = 2, Event = 0}         -- "Lady Kathryn"
	else
		evt.SetMessage(403)         -- "The Fraternal Order of Silver has begun more direct attacks on my legitimate, underworld associates.  I would appreciate it greatly if you could talk to Sir John and learn why he feels these actions are necessary."
	end
end

-- "Ankh"
evt.global[364] = function()
	evt.SetMessage(391)         -- "So Baa was behind the corruption of the Silver Helms and the murder of Sir John Silver?  What a tragedy for Sir John, rest his soul.  <blink> Loretta told you to collect the reward from me?  Greedy witch.  Here, your services should not go unrewarded."
	evt.Add("Gold", 5000)
	evt.SetNPCTopic{NPC = 16, Index = 2, Event = 0}         -- "Baroness Klaravoyia"
end

-- "Last Rose of  Winter"
evt.global[365] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 460) then         -- "Last Rose of Winter"
		evt.SetMessage(99)         -- "[Klaravoyia is holding one of her birds that has turned completely gray]  Good day adventurers, have you retrieved the Last Rose of Winter yet? As you can see, my birds are losing all their color and may soon lose their song. Please hurry and find the Rose so I can mix the tincture and bring my flock back to their full beauty."
		return
	end
	evt.Subtract("Inventory", 460)         -- "Last Rose of Winter"
	evt.SetMessage(100)         --[[ "[When you enter her home, Klaravoyia is delighted to see you holding the Rose]

You have found the Last Rose of Winter! My birds and I will be forever grateful. I hereby promote all Druids to the position of Sylvan and all others to honorary Sylvans. Thank you so much.

[As you are leaving, the Rose's fragrance wafts throughout the house. You notice that Klaravoyia's flock of birds has begun to perk up and sing melodiously.]" ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Sylvan"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Sylvan"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Sylvan"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Sylvan"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Sylvan"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Sylvan"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Sylvan"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Sylvan"
	end
	evt.Add("ReputationIs", 100)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 118)         -- NPC
	evt.Add("QBits", 173)         -- NPC
	evt.Add("Experience", 15000)
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 84}         -- "Baroness Klaravoyia" : "Elder"
end

-- "Creations Fount"
evt.global[366] = function()
	if not evt.Cmp("QBits", 478) then         -- Creations Fount  (Mystic Isles)
		evt.SetMessage(102)         -- "[Baroness Klaravoyia, High Elder of the Druidic Order and Earth Mother of Nimradur meets you as you are about to enter the house.]   I do not yet see the Light of Understanding Life's Mysteries in your eyes. Please visit the Creations Fount located on one of the islands in the southern region of the Mystic Isles to gain this knowledge, then return to me for your promotion to Elder."
		return
	end
	evt.SetMessage(103)         -- "[Now when Elder Klaravoyia's sees you, she beams with joy.]   I see you have been to the Creations Fount. There is no doubt about it, as the glorious Light of Understanding Life's Mysteries is shining brightly from your eyes. You are now ready to reach the highest level in the Druidic Order, with all its benefits and responsibilities. I hereby promote all Sylvans to Elder and all others to honorary Elder. May peace and light go with you wherever you travel."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Elder"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Elder"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Elder"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Elder"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Elder"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Elder"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Elder"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Elder"
	end
	evt.Add("ReputationIs", 100)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 119)         -- NPC
	evt.Add("QBits", 174)         -- NPC
	evt.Add("Experience", 40000)
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 86}         -- "Baroness Klaravoyia" : "Welcome Elders!"
	evt.MoveNPC{NPC = 16, HouseId = 162}         -- "Baroness Klaravoyia" -> "Leannor Hall"
	evt.MoveNPC{NPC = 305, HouseId = 0}         -- "Vice-Elder Grummond"
	evt.Add("QBits", 402)         -- Vice-Elder Dissappear
end

-- "FREE"
evt.global[375] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 4) then         -- "Gained Access to Desolation's End"
		evt.SetMessage(123)         -- "Welcome.  The Seer sent you to me so I can examine the skull in your possession.  While doing so I have a task for you.  On the chance this skull is real and the Drow seek the four skulls for the worshipers of Chaos, then we must be the first to secure them.  I know of a second skull’s location. This scroll will give what information I have.  My operatives hopefully will uncover the locations of the other two soon.  The warding on the dungeon holding the second skull has been broken, so you should be able to enter without difficulty.  I will take the Crystal skull.  Return to me after the second has been recovered."
	else
		evt.SetMessage(122)         -- "Welcome, fellow Elders!  Let us meditate together to attune of life force with the Blessed Mother.."
	end
end

-- "FREE"
evt.global[376] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 6) then         -- "Gained Access to The Land that Time Forgot"
		evt.SetMessage(125)         -- "You succeeded in your first task, good.  I have been able to determine the first skull was in fact the true Crystal Skull.  I also have confirmed the Drow are attempting to secure them for some unknown purpose.  Fortunately, my operatives have found the locations of the last two skulls so you can now finish this task.  The information you need and the method of entry you require is in the possession of my most trusted operative, HodgePodge.  She is very sensitive to the vibrations of nature and its creatures.  The protectors of the last two skulls have violated the laws of nature.  Your mission has become personal to her and she wishes to speak to you personally.  She can be found in Avalon."
	else
		evt.SetMessage(124)         -- "Why come back now, you don’t have the second skull and I have not heard from my operatives?  Complete your task then come back to me."
	end
end

-- "FREE"
evt.global[377] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 5) then         -- "Entered Baal's Garden"
		evt.SetMessage(127)         -- "Recovering two skulls has been helpful, but no one will be safe until all four have been properly dealt with.  Bring them to me as soon as they have been recovered."
	else
		evt.SetMessage(126)         -- "Welcome.  I have been awaiting your arrival.  We have little time; the final two skulls must be recovered quickly.  I have reason to believe the Drow know of their locations.  Both have been hidden in dungeons long forgotten.  The abominations that protect them are a sin against nature, retrieving them will serve a duel purpose.  We not only make the realm safe from the Drow, but also smite the violators of nature in one stroke.  I’ve written in this scroll the location of each skull.  Now to enter these dungeons I must accompany you.  The rituals necessary to break the protective wards are too complicated to teach you in the short amount of time we have.  So I’m packed, let’s get moving."
	end
end

-- "FREE"
evt.global[378] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
		evt.SetMessage(129)         --[[ "[The Seer looks at you with sadness.]  I wish I had good news for you but I don’t.  The body of Magnus was found outside of the town of Ellesia, and the skulls were nowhere to be found.  He was stabbed in the back.  Whether this was a traitor receiving a traitor’s payment or he was ambushed, I cannot say.  I prefer to believe the Drow struck him down, and have taken back the skulls.  We must retrieve them within a week or the Drow will be able to reinforce their main fortresses, making them more difficult or even impossible to defeat.

Proceed to Sutters Bay immediately.  On an island off the northern shore of Suttersville, there is a cave called Underwald.  I believe this is where the Drow are holding the skulls.  The entrance is magically warded, but this necklace will allow you to gain entry.

Rid the Underwald of the Drow presence, retrieve the skulls, and bring them to me.  Hurry!" ]]
	else
		evt.SetMessage(128)         --[[ "You have done well.  Your task is complete and now mine begins.  The skulls are protected by powerful magic and their destruction is probably impossible.  It is for me to hide them in a secure and secret location, so that they are permanently locked away.

Return to the Seer as he is not yet done with you.

It has been a pleasure doing business with you, but I doubt that our paths will ever cross again, goodbye." ]]
	end
end

-- "FREE"
evt.global[379] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 3) then         -- "Touched the Rock of Translation"
		evt.SetMessage(131)         --[[ "You have done well to recover all four skulls, my friends.  I'll take these and keep them safe.

The Drow have become somewhat problematic as of late, and we have alarming reports coming from the Elves concerning them.  Please journey to Castle Birka and talk with Indis Nénharma, a regal Elf of high standing in her nation.  Obey her as you would me." ]]
	else
		evt.SetMessage(130)         -- "You must retrieve all four Drow skulls to complete this quest."
	end
end

-- "FREE"
evt.global[380] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 502) then         -- "Tanfan's Scroll"
		if evt.Cmp("Awards", 2) then         -- "Gained Access to the Valley of Stones"
			evt.SetMessage(133)         -- "Done!  Let's move on."
			evt.SetNPCTopic{NPC = 4, Index = 0, Event = 101}         -- "King Jaffar" : "Judged!"
		else
			evt.SetMessage(132)         -- "Sorry.  You don't qualify.  Let's move on."
		end
		return
	end
	evt.MoveNPC{NPC = 304, HouseId = 0}         -- "FREE"
	evt.Subtract("Inventory", 502)         -- "Tanfan's Scroll"
	evt.SetMessage(134)         --[[ "[You explain to Su Lang Manchu that the Seer has sent you to him for the Dark Magic promotions.]  I’m sure that you realize the risk I am taking in offering you this promotion.  But I do trust the Seer and owe him a favor or two.  So here’s how it works.

I can only promote one character at a time; your ‘active’ character.  I will promote your Elders to Expert Level Four, and your Adepts and Exorcists who are already Expert Level 4 to Master Level 11.

Let’s get start." ]]
	evt.Add("ReputationIs", 200)
	evt.Set("QBits", 168)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Awards", 32)         -- ""
	evt.Subtract("QBits", 190)         -- Quest item bits for seer
	evt.Subtract("QBits", 201)         -- NPC
	if evt.Cmp("QBits", 200) then         -- Wilbur Humphrey
		evt.Subtract("QBits", 200)         -- Wilbur Humphrey
	end
	evt.SetNPCTopic{NPC = 4, Index = 0, Event = 103}         -- "King Jaffar" : "Service to the Crown"
	if evt.Cmp("Awards", 2) then         -- "Gained Access to the Valley of Stones"
		if evt.Cmp("Awards", 3) then         -- "Touched the Rock of Translation"
			if evt.Cmp("Awards", 4) then         -- "Gained Access to Desolation's End"
				if evt.Cmp("Awards", 5) then         -- "Entered Baal's Garden"
					if evt.Cmp("Awards", 6) then         -- "Gained Access to The Land that Time Forgot"
						if evt.Cmp("Awards", 7) then         -- "Destroyed the Sacred Chalice of Gods"
							evt.Set("QBits", 167)         -- NPC
						end
					end
				end
			end
		end
	end
end

-- "Heal Party"
evt.global[398] = function()
	evt.SetMessage(457)         -- "Sorry, I can no longer perform any healing."
end

-- "Empty Barrel"
evt.global[410] = function()
	evt.StatusText(410)         -- "The barrel is empty"
end

-- "Barrel of Red liquid"
evt.global[411] = function()
	evt.StatusText(411)         -- "+5 Might permanent"
	evt.Add("BaseMight", 5)
	evt.Set("AutonotesBits", 117)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Yellow liquid"
evt.global[412] = function()
	evt.StatusText(412)         -- "+5 Accuracy permanent"
	evt.Add("BaseAccuracy", 5)
	evt.Set("AutonotesBits", 121)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Blue liquid"
evt.global[413] = function()
	evt.StatusText(413)         -- "+5 Personality permanent"
	evt.Add("BasePersonality", 5)
	evt.Set("AutonotesBits", 119)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Orange liquid"
evt.global[414] = function()
	evt.StatusText(414)         -- "+5 Intellect permanent"
	evt.Add("BaseIntellect", 5)
	evt.Set("AutonotesBits", 118)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Green liquid"
evt.global[415] = function()
	evt.StatusText(415)         -- "+5 Endurance permanent"
	evt.Add("BaseEndurance", 5)
	evt.Set("AutonotesBits", 120)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Purple liquid"
evt.global[416] = function()
	evt.StatusText(416)         -- "+5 Speed permanent"
	evt.Add("BaseSpeed", 5)
	evt.Set("AutonotesBits", 122)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of White liquid"
evt.global[417] = function()
	evt.StatusText(417)         -- "+5 Luck permanent"
	evt.Add("BaseLuck", 5)
	evt.Set("AutonotesBits", 123)         -- ""
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Empty Cauldron"
evt.global[418] = function()
	evt.StatusText(418)         -- "The cauldron is empty"
end

-- "Steaming Brew"
evt.global[419] = function()
	evt.StatusText(419)         -- "+5 Ignis resistance permanent"
	evt.Add("FireResistance", 7)
	evt.Set("AutonotesBits", 124)         -- ""
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Frosty Brew"
evt.global[420] = function()
	evt.StatusText(420)         -- "+5 Cold resistance permanent"
	evt.Add("ColdResistance", 7)
	evt.Set("AutonotesBits", 125)         -- ""
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Shocking Brew"
evt.global[421] = function()
	evt.StatusText(421)         -- "+5 Electric resistance permanent"
	evt.Add("ElecResistance", 7)
	evt.Set("AutonotesBits", 126)         -- ""
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Noxious Brew"
evt.global[422] = function()
	evt.StatusText(422)         -- "+5 Poison resistance permanent"
	evt.Add("PoisonResistance", 7)
	evt.Set("AutonotesBits", 127)         -- ""
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Magical Brew"
evt.global[423] = function()
	evt.StatusText(423)         -- "+5 Magic resistance permanent"
	evt.Add("MagicResistance", 7)
	evt.Set("AutonotesBits", 128)         -- ""
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Cook Pot"
evt.global[424] = function()
	evt.StatusText(424)         -- "The cook pot is empty"
end

-- "Cook Pot"
evt.global[425] = function()
	evt.Add("FoodAddRandom", 3)
	evt.ChangeEvent(424)         -- "Cook Pot"
end

-- "Cook Pot"
evt.global[426] = function()
	evt.GiveItem{Strength = 1, Type = const.ItemType.Ring_, Id = 0}
	evt.Add("FoodAddRandom", 3)
	evt.ChangeEvent(424)         -- "Cook Pot"
end

-- "Cook Pot"
evt.global[427] = function()
	evt.GiveItem{Strength = 2, Type = const.ItemType.Ring_, Id = 0}
	evt.Add("FoodAddRandom", 3)
	evt.ChangeEvent(424)         -- "Cook Pot"
end

-- "Cook Pot"
evt.global[428] = function()
	evt.GiveItem{Strength = 3, Type = const.ItemType.Ring_, Id = 0}
	evt.Add("FoodAddRandom", 3)
	evt.ChangeEvent(424)         -- "Cook Pot"
end

-- "Flour Sack"
evt.global[429] = function()
	evt.StatusText(429)         -- "Empty sack"
	evt.ChangeEvent(0)
end

-- "Flour Sack"
evt.global[430] = function()
	evt.Add("Food", 2)
	evt.ChangeEvent(0)
end

-- "Large Bag"
evt.global[431] = function()
	evt.StatusText(431)         -- "Empty bag"
	evt.ChangeEvent(0)
end

-- "Large Bag"
evt.global[432] = function()
	evt.GiveItem{Strength = 1, Type = const.ItemType.Any, Id = 0}
	evt.ChangeEvent(0)
end

-- "Large Bag"
evt.global[433] = function()
	evt.GiveItem{Strength = 2, Type = const.ItemType.Any, Id = 0}
	evt.ChangeEvent(0)
end

-- "Large Bag"
evt.global[434] = function()
	evt.GiveItem{Strength = 3, Type = const.ItemType.Any, Id = 0}
	evt.ChangeEvent(0)
end

-- "Bag of Gold"
evt.global[435] = function()
	evt.Add("Gold", 50)
	evt.Add("GoldAddRandom", 200)
	evt.ChangeEvent(0)
end

-- "Trash Heap"
evt.global[436] = function()
	local i
	i = Game.Rand() % 2
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(425)         -- "Disease!"
			return
		end
	end
	evt.StatusText(436)         -- "Nothing here"
end

-- "Trash Heap"
evt.global[437] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
		end
		goto _3
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedYellow", 0)
		end
		goto _7
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedRed", 0)
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Dagger, Id = 0}
::_12::
	evt.ChangeEvent(436)         -- "Trash Heap"
	do return end
::_3::
	evt.GiveItem{Strength = 1, Type = const.ItemType.Dagger, Id = 0}
	goto _12
::_7::
	evt.GiveItem{Strength = 2, Type = const.ItemType.Dagger, Id = 0}
	goto _12
end

-- "Skull Pile"
evt.global[438] = function()
	evt.StatusText(436)         -- "Nothing here"
end

-- "Skull Pile of Weakness"
evt.global[439] = function()
	if evt.Cmp("PerceptionSkill", 5) then
		evt.GiveItem{Strength = 1, Type = const.ItemType.Scroll_, Id = 0}
		evt.ChangeEvent(438)         -- "Skull Pile"
	else
		evt.Set("Weak", 0)
		evt.StatusText(426)         -- "Search Failed!"
	end
end

-- "Skull Pile of Curses"
evt.global[440] = function()
	if evt.Cmp("PerceptionSkill", 6) then
		evt.GiveItem{Strength = 2, Type = const.ItemType.Scroll_, Id = 0}
		evt.ChangeEvent(438)         -- "Skull Pile"
	else
		evt.Set("Cursed", 0)
		evt.StatusText(426)         -- "Search Failed!"
	end
end

-- "Skull Pile of Insanity"
evt.global[441] = function()
	if evt.Cmp("PerceptionSkill", 7) then
		evt.GiveItem{Strength = 3, Type = const.ItemType.Scroll_, Id = 0}
		evt.ChangeEvent(438)         -- "Skull Pile"
	else
		evt.Set("Insane", 0)
		evt.StatusText(426)         -- "Search Failed!"
	end
end

-- "Skull Pile of Death"
evt.global[442] = function()
	if evt.Cmp("PerceptionSkill", 8) then
		evt.GiveItem{Strength = 4, Type = const.ItemType.Scroll_, Id = 0}
		evt.ChangeEvent(438)         -- "Skull Pile"
	else
		evt.Set("Dead", 0)
		evt.StatusText(426)         -- "Search Failed!"
	end
end

-- "Bucket"
evt.global[443] = function()
	evt.StatusText(443)         -- "Empty bucket"
end

-- "Bucket"
evt.global[444] = function()
	evt.Add("Inventory", 160)         -- "Poppysnaps"
	evt.ChangeEvent(443)         -- "Bucket"
end

-- "Bucket"
evt.global[445] = function()
	evt.Add("Inventory", 161)         -- "Phirna Root"
	evt.ChangeEvent(443)         -- "Bucket"
end

-- "Bucket"
evt.global[446] = function()
	evt.Add("Inventory", 162)         -- "Widoweeps Berries"
	evt.ChangeEvent(443)         -- "Bucket"
end

-- "Crystals"
evt.global[447] = function()
	evt.StatusText(447)         -- "Useless Crystal"
end

-- "Crystals"
evt.global[448] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 436)         -- "Diamond"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[449] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 437)         -- "Moonstone"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[450] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 438)         -- "Topaz"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[451] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 439)         -- "Ruby"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[452] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 440)         -- "Amethyst"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[453] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 441)         -- "Emerald"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[454] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 442)         -- "Purple Topaz"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[455] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 443)         -- "Sunstone"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[456] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 444)         -- "Emerald"
		evt.ChangeEvent(0)
	end
end

-- "Crystals"
evt.global[457] = function()
	if evt.Cmp("PerceptionSkill", 10) then
		evt.Add("Inventory", 445)         -- "Sapphire"
		evt.ChangeEvent(0)
	end
end

