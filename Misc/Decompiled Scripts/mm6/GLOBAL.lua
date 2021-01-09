Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events


-- "The Letter"
evt.global[1] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 505) then         -- "The Letter"
		evt.SetMessage(1)         -- "Oh!  The Seal.  Here, I'm supposed to give you this money.  Now, go away before we're seen together!  Someone will get suspicious."
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.SetNPCTopic{NPC = 1, Index = 0, Event = 2}         -- "Andover Potbello" : "The Letter"
		evt.Subtract("QBits", 81)         -- "Show Sulman's letter to Andover Potbello in New Sorpigal."
		evt.Set("QBits", 82)         -- "Bring Sulman's letter to Regent Wilbur Humphrey at Castle Ironfist."
	else
		evt.SetMessage(3)         -- "My instructions are quite clear.  I am to pay the person carrying the letter that bears the Seal.  Since you don't have a letter with a Seal, you get no money!"
	end
end

-- "The Letter"
evt.global[2] = function()
	evt.SetMessage(2)         -- "Don't try to say I didn't pay you!  You got your gold!  "
end

-- "Goblinwatch"
evt.global[3] = function()
	evt.SetMessage(4)         -- "Just south of town is an old keep called Goblinwatch.  It was originally built to help keep the town safe from goblin raids, but times have been so peaceful recently that we haven't been taking care of it.  You can imagine our embarrassment when we realized that the very monsters we were guarding against have moved into the keep!  They also changed the lock on a very important door leading to the caves below the dungeon level.  We have a standing reward of 2000 gold pieces to the ones who can figure out the combination and tell us what it is."
	evt.SetNPCTopic{NPC = 291, Index = 0, Event = 4}         -- "Janice" : "Goblinwatch"
	evt.Set("QBits", 83)         -- "Find the Combination to the vault door in Goblinwatch and return to the Town Hall in New Sorpigal."
	evt.Add("Inventory", 489)         -- "Key to Goblinwatch"
end

-- "Goblinwatch"
evt.global[4] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 543) then         -- "Goblinwatch Code"
		evt.SetMessage(6)         -- "Ah, thank you for taking care of that little detail for us.  Here's your gold!  Feel free to return to Goblinwatch any time to finish clearing out the rest of the monsters.  We can't pay you, but you can have anything you find there.  "
		evt.Set("Awards", 53)         -- "Solved the Goblinwatch Combination"
		evt.Add("Experience", 2000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 2000)
		evt.Add("ReputationIs", 50)
		evt.Subtract("QBits", 83)         -- "Find the Combination to the vault door in Goblinwatch and return to the Town Hall in New Sorpigal."
		evt.SetNPCTopic{NPC = 291, Index = 0, Event = 5}         -- "Janice" : "Evil Cults"
		evt.MoveNPC{NPC = 296, HouseId = 0}         -- "Urok"
		evt.MoveNPC{NPC = 43, HouseId = 486}         -- "Samson Tess" -> "House"
	else
		evt.SetMessage(5)         -- "How can you find the combination to that lock by standing around here?  Get going!"
	end
end

-- "Evil Cults"
evt.global[5] = function()
	evt.SetMessage(7)         -- "You did such a fine job with the Goblinwatch assignment that we would like to employ you again.  A cult has moved into an old abandoned temple a few day's journey west of here.  To pay for their blasphemous activities, they've been robbing travelers using the road that leads to Castle Ironfist.  We've appealed to the regent to do something about these horrible cultists, but he says all his forces are occupied in the west, or some such nonsense.  We want it gone now, so we're willing to pay you 5000 gold pieces to get rid of them and bring us back the Chime of Harmony as proof you've done the deed."
	evt.SetNPCTopic{NPC = 291, Index = 0, Event = 6}         -- "Janice" : "Evil Cults"
	evt.Add("QBits", 84)         -- "Get the Chime of Harmony from the Temple of Baa and return to the New Sorpigal Town Hall."
end

-- "Evil Cults"
evt.global[6] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 475) then         -- "Chime of Harmony"
		evt.SetMessage(9)         -- "Good work!  Here's your gold!  I can't thank you enough for ruining that temple.  Now the road to Ironfist will be safe for travel again."
		evt.Subtract("Inventory", 475)         -- "Chime of Harmony"
		evt.Add("Experience", 10000)
		evt.Add("Awards", 54)         -- "Returned with the Chime of Harmony"
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 50)
		evt.Subtract("QBits", 84)         -- "Get the Chime of Harmony from the Temple of Baa and return to the New Sorpigal Town Hall."
		evt.SetNPCTopic{NPC = 291, Index = 0, Event = 7}         -- "Janice" : "Evil Cults"
	else
		evt.SetMessage(8)         -- "Without the Chime of Harmony, I'm not authorized to pay the reward money.  "
	end
end

-- "Evil Cults"
evt.global[7] = function()
	evt.SetMessage(10)         -- "The road to Ironfist is much safer thanks to you.  You have our gratitude."
end

-- "The Howling Moon"
evt.global[8] = function()
	evt.SetMessage(11)         -- "The proprietor of the Howling Moon is George Caniss.  It's a wonderful place.  Tell him I said hi!"
end

-- "The Letter"
evt.global[9] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 505) then         -- "The Letter"
		evt.SetMessage(12)         -- "Thank you so much for bringing me these letters! <Wilbur begins reading the letters> I’ve been so worried…I see… This is not good news…Oh, no.  Traitors!  Traitors and conspirators everywhere!  I must organize an expedition at once! <Wilbur lowers his voice> I trust you will not speak to the prince about these letters– he is already too depressed and unhappy to hear more bad news.  And now I must see to the organization of the expedition.  Here is a bag of gold as a reward– you’ve earned it and my gratitude.  Now, if only I could find someone to finish looking for Lord Kilburn…"
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.ForPlayer("All")
		evt.Set("Awards", 58)         -- "Delivered 6th Letter to Wilbur Humphry"
		evt.Subtract("Inventory", 505)         -- "The Letter"
		evt.Subtract("QBits", 181)         -- Quest item bits for seer
		evt.Subtract("QBits", 82)         -- "Bring Sulman's letter to Regent Wilbur Humphrey at Castle Ironfist."
		evt.Subtract("QBits", 81)         -- "Show Sulman's letter to Andover Potbello in New Sorpigal."
		evt.Add("Experience", 3000)
		evt.SetNPCTopic{NPC = 4, Index = 0, Event = 10}         -- "Wilbur Humphrey" : "Lord Kilburn"
	else
		evt.SetMessage(199)         -- "Welcome, adventurers!  Did you have something for me?  I'm a very busy man, you know.  "
	end
end

-- "Lord Kilburn"
evt.global[10] = function()
	evt.SetMessage(13)         -- "<Wilbur snaps his fingers> Say, you wouldn’t happen to be interested in taking care of a little detail for me, would you?  Lord Kilburn disappeared near Blackshire.  Find out what you can and return to me with the information.  If it is true that he has been slain by devils, return his shield to me if at all possible.  I will grant you my favor with the High Council, should you require it, and you can rest assured your compensation will be generous."
	evt.Set("QBits", 86)         -- "Find Lord Kilburn's Shield and return to Wilbur Humphrey in Castle Ironfist to report."
	evt.SetNPCTopic{NPC = 4, Index = 0, Event = 11}         -- "Wilbur Humphrey" : "Lord Kilburn"
end

-- "Lord Kilburn"
evt.global[11] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 499) then         -- "Lord Kilburn's Shield"
		evt.SetMessage(14)         -- "Hmm.  No luck finding the shield yet, eh?  Well, do keep looking, will you?  It really is important that someone accounts for his whereabouts."
	else
		evt.SetMessage(16)         -- "Ah.  ‘Tis a sad day when so noble a Knight should fall to such foul monsters!  You have done a good thing, bringing his shield to me.  I shall ensure that he and his men receive all the honors due them.  I am in your debt, and you have my favor with the council.  Here is your reward."
		evt.Subtract("Inventory", 499)         -- "Lord Kilburn's Shield"
		evt.Subtract("QBits", 182)         -- Quest item bits for seer
		evt.Add("Experience", 40000)
		evt.Add("Awards", 2)         -- "Retrieved Lord Kilburn's Shield"
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 200)
		evt.SetNPCTopic{NPC = 4, Index = 0, Event = 12}         -- "Wilbur Humphrey" : "The High Council"
		evt.Subtract("QBits", 86)         -- "Find Lord Kilburn's Shield and return to Wilbur Humphrey in Castle Ironfist to report."
		evt.ForPlayer("All")
		if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
			if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
				if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
					if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
						if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
							if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
								if evt.Cmp("Awards", 7) then         -- "Ended Winter"
									evt.Set("QBits", 167)         -- NPC
								end
							end
						end
					end
				end
			end
		end
	end
end

-- "The High Council"
evt.global[12] = function()
	if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
		evt.SetMessage(18)         -- "I cannot thank you enough for uncovering that horrible traitor and his crimes against the throne.  I understand you are on a mission of some importance, so for Services Rendered to the Crown, it behooves me to offer you free use of the royal yacht for your travels.  It will take you as far as Hermit's Isle, if you need it to.  Once again, thank you!"
		evt.ForPlayer("All")
		evt.Set("Awards", 59)         -- "Allowed to use the Royal Yacht"
	else
		evt.SetMessage(17)         -- "Well, you have my vote on the High Council.  I trust you implicitly.  I've sent a messenger instructing Slicker Silvertongue to vote for you on my behalf.  Now I'm quite busy, and must attend to other duties.  I'm sure you can take care of any problems and miscommunications that may arise in this matter.  Yes.  Quite right."
	end
end

-- "Crusaders"
evt.global[13] = function()
	evt.SetMessage(19)         -- "I am the Foremost Paladin, and as such, I am the one charged with the promotion and keeping of the titles and responsibilities of paladinhood.  Those paladins who wish to perform a quest for the official promotion to crusader must rescue a damsel in distress.  Those of you who are not paladins will be awarded the title of honorary crusader, and all will be given a sizeable gold reward.  Return to me with said damsel and I will promote any paladins aiding in her rescue to the status of crusader."
	evt.Add("QBits", 88)         -- "Rescue a Damsel in Distress and return with her to Wilbur Humphrey in Castle Ironfist."
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 14}         -- "Wilbur Humphrey" : "Crusaders"
end

-- "Crusaders"
evt.global[14] = function()
	if not evt.Cmp("NPCs", 11) then         -- "Melody Silver"
		evt.SetMessage(20)         -- "I know there is a shortage of damsels in distress, but this quest is the traditional test.  I really can’t bend the rules here.  Keep looking– I’m sure you’ll find someone.  If it helps, I hear Melody Silver, daughter of the noble John Silver, is being held captive by ruffians on the Island of Mist."
		return
	end
	evt.SetMessage(21)         -- "I have heard stories of the daring rescue, and I am delighted that you have returned with Miss Silver.  I shall arrange to have her returned to her family at once.  Exemplary work!  I hereby officially promote all paladins to the status of crusader, and all non-paladins to honorary crusaders!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Crusader"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Crusader"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Crusader"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Crusader"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Crusader"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Crusader"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 8)         -- "Received Promotion to Crusader"
	else
		evt.Add("Awards", 9)         -- "Received Promotion to Honorary Crusader"
	end
	evt.Add("Gold", 5000)
	evt.Subtract("NPCs", 11)         -- "Melody Silver"
	evt.Subtract("QBits", 88)         -- "Rescue a Damsel in Distress and return with her to Wilbur Humphrey in Castle Ironfist."
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 15}         -- "Wilbur Humphrey" : "Heroes"
end

-- "Heroes"
evt.global[15] = function()
	evt.SetMessage(22)         -- "Well, then!  It is a fine thing to be promoted to crusader, but even finer a thing to be promoted to hero.  As you may have guessed by now, the condition for hero status is to slay a dragon.  I know this seems difficult, but tradition has its demands.  What’s worse, you can’t slay just any dragon, but must slay a named dragon.  Your task is to slay Longfang Witherhide and return with a claw or tooth as proof.  Fortunately, we know that Longfang lives in a cave in the mountains behind Castle Darkmoor.  He has slain at least twelve would-be heroes, so be careful!"
	evt.Add("QBits", 89)         -- "Slay Longfang Witherhide in his cave near Castle Darkmoor and return to Wilbur Humphrey in Castle Ironfist."
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 16}         -- "Wilbur Humphrey" : "Heroes"
end

-- "Heroes"
evt.global[16] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 455) then         -- "Dragon Claw"
		evt.SetMessage(23)         -- "There is no use returning to me to talk about your quest.  I cannot change the rules or your quest.  Longfang awaits your avenging sword.  Now get to it!"
		return
	end
	evt.SetMessage(24)         -- "Well done!  One less horrible monster in the world is a good thing.  I hereby officially promote all crusaders to heroes, and all honorary crusaders to the status of honorary hero! May you long continue to live up to the title!"
	evt.Add("Experience", 30000)
	evt.Subtract("Inventory", 455)         -- "Dragon Claw"
	evt.Subtract("QBits", 185)         -- Quest item bits for seer
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Hero"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Hero"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Hero"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Hero"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Hero"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Hero"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 10)         -- "Received Promotion to Hero"
	else
		evt.Add("Awards", 11)         -- "Received Promotion to Honorary Hero"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 89)         -- "Slay Longfang Witherhide in his cave near Castle Darkmoor and return to Wilbur Humphrey in Castle Ironfist."
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 17}         -- "Wilbur Humphrey" : "Heroes"
end

-- "Heroes"
evt.global[17] = function()
	evt.SetMessage(25)         -- "It is always good to speak with heroes of the realm!  Come back in some less troubled time and we'll swap tales of honor and courage by the fire!"
end

-- "Boredom"
evt.global[18] = function()
	evt.SetMessage(26)         -- "The palace is deadly dull, and everyone tells me what to do.  Being royalty isn’t really worth much and no one will let me go outside the walls while my father is gone.  I haven’t left the castle for months!  Anyway, you people look pretty important.  What if you helped me sneak out and stay with you for a couple of days?  I can’t give you much in return yet, but I’ll owe you a favor.  Someday I’ll be able to repay you.  I am the prince, after all!  I’ll go out the secret door and meet you outside."
	evt.Add("QBits", 90)         -- "Entertain Nicolai."
	evt.Add("NPCs", 13)         -- "Nicolai Ironfist"
	evt.SetNPCTopic{NPC = 13, Index = 0, Event = 19}         -- "Nicolai Ironfist" : "The Circus"
end

-- "The Circus"
evt.global[19] = function()
	evt.SetMessage(27)         -- "Let’s go see the circus!"
end

-- "Missing Text 20"
evt.global[20] = function()
	evt.MoveNPC{NPC = 13, HouseId = 166}         -- "Nicolai Ironfist" -> "Circus"
	evt.Subtract("NPCs", 13)         -- "Nicolai Ironfist"
	evt.SetMessage(28)         -- "It seems that Prince Nicolai disappeared while you were resting."
	evt.Subtract("QBits", 90)         -- "Entertain Nicolai."
	evt.Set("QBits", 95)         -- "Find and return Prince Nicolai to Castle Ironfist."
	evt.SetNPCTopic{NPC = 13, Index = 0, Event = 21}         -- "Nicolai Ironfist" : "Excuse me, your Highness…"
	evt.SimpleMessage()
end

-- "Excuse me, your Highness…"
evt.global[21] = function()
	evt.SetMessage(29)         -- "Um.  Hi. <smiling weakly> Would you believe I got lost and these nice people were taking me home?  No?  I guess I wouldn’t either.  I suppose it’s time we got back to the castle, then."
	evt.Set("NPCs", 13)         -- "Nicolai Ironfist"
	evt.SetNPCTopic{NPC = 13, Index = 0, Event = 22}         -- "Nicolai Ironfist" : "Excuse me, your Highness…"
end

-- "Excuse me, your Highness…"
evt.global[22] = function()
	evt.SetMessage(30)         -- "We should go back to Castle Ironfist."
end

-- "The Circus"
evt.global[24] = function()
	evt.SetMessage(32)         -- "Thanks for bringing me home.  I owe you a favor!"
end

-- "Uncle Archibald"
evt.global[25] = function()
	evt.SetMessage(33)         -- "Everyone says that my Uncle Archibald wasn’t a very nice person, and that he almost usurped the throne from my father, but we defeated him.  Father had Tanir turn him to stone and then locked him in the library.  Nobody’s been in there for years. "
end

-- "The Third Eye"
evt.global[26] = function()
	evt.SetMessage(34)         -- "You want to free Archibald?!  If the Oracle told you to do it, I guess we should, but he’ll be trouble once he’s loose, that’s for sure.  I know where the bell is that turned him to stone, but I can’t open the family vault that it’s in without the Third Eye.  It’s one of three gems you need to put into the door of the vault in order to open it.  I’ve got two of them– one in my father’s crown and one in his scepter, but my father hid the third one, and he didn’t tell me where it is.  If you could find it, I could open the vault and get the bell."
	evt.Add("QBits", 96)         -- "Find the Third Eye and bring it to Prince Nicolai in Castle Ironfist."
	evt.SetNPCTopic{NPC = 13, Index = 1, Event = 27}         -- "Nicolai Ironfist" : "Uncle Archibald"
	evt.SetNPCTopic{NPC = 8, Index = 1, Event = 0}         -- "Oracle"
end

-- "Uncle Archibald"
evt.global[27] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 446) then         -- "The Third Eye"
		evt.SetMessage(36)         -- "You found the Third Eye!  All right, wait here– the bell should be in the vault.  <Nicolai runs out of the throne room, returning a short while later> Ok, here it is! "
		evt.Subtract("Inventory", 446)         -- "The Third Eye"
		evt.Subtract("QBits", 196)         -- Quest item bits for seer
		evt.Subtract("QBits", 96)         -- "Find the Third Eye and bring it to Prince Nicolai in Castle Ironfist."
		evt.ForPlayer("Current")
		evt.Add("Inventory", 461)         -- "Tanir's Bell"
		evt.Set("QBits", 197)         -- Quest item bits for seer
		evt.SetNPCTopic{NPC = 13, Index = 1, Event = 28}         -- "Nicolai Ironfist" : "Uncle Archibald"
	else
		evt.SetMessage(35)         -- "Without the Third Eye, I can’t get into the vault to get you the bell that will release Archibald.  He must have hidden it near the castle, because he used to just go right outside and fetch it whenever he needed to open the vault."
	end
end

-- "Uncle Archibald"
evt.global[28] = function()
	evt.SetMessage(37)         -- "I hope you know what you're doing.  Everyone says my uncle is quite treacherous."
end

-- "Release Archibald"
evt.global[30] = function()
	if not evt.Cmp("QBits", 177) then         -- NPC
		evt.SetMessage(39)         -- "Now wait just a minute Tanir, and I’ll make it worth your while to let me…Oh. <Archibald is silent for a long while> I guess I have you people to thank for releasing me from my prison of stone.  Thank you!  You say you need a spell that I've created?  <reaching to the shelves and removing a library scroll> Well, as a reward, I’ll give you the Ritual of the Void.  Use it in good health.  Now, I’m sure you’re very busy, as am I…<Archibald waves his arms and fades away>"
		evt.Add("Inventory", 544)         -- "Ritual of the Void"
		evt.Subtract("QBits", 197)         -- Quest item bits for seer
		evt.Add("QBits", 177)         -- NPC
		evt.Subtract("QBits", 97)         -- Walt
		evt.Subtract("QBits", 235)         -- "Obtain Arcane Magic from Archibald in the Royal Library in Castle Ironfist"
		evt.Add("QBits", 198)         -- Quest item bits for seer
		evt.ForPlayer("All")
		evt.Subtract("ReputationIs", 1000)
		evt.Add("Experience", 50000)
		evt.MoveNPC{NPC = 12, HouseId = 0}         -- "Archibald Ironfist"
	end
end

-- "Silver Helms"
evt.global[31] = function()
	evt.SetMessage(40)         -- "Thank you for rescuing me from the clutches of those ruffians!  Oh, I wish there was some way for me to reward you!"
	evt.Set("NPCs", 11)         -- "Melody Silver"
	evt.Set("QBits", 127)         -- NPC
end

-- "The Prince of Thieves"
evt.global[32] = function()
	evt.SetMessage(41)         -- "Mine is the traditional duty to oversee the, um, less than upright business in the Kingdom.  My House has done this for centuries under the philosophy that such business will always exist and is better watched and regulated than not.  Recently, a man styling himself the 'Prince of Thieves' has begun to usurp my authority in Free Haven.  Not only does he challenge my authority, he cooperates with that loathsome new cult that’s sprung up recently…what’s it called?  Moo, or Yak, or Bark…no…whatever.  Some sort of animal sound.  Anyway, my sources tell me that this cult plots to overthrow the King and assume power in Enroth.  This is a bad business, and needs to be stopped.  You can start by arresting the Prince of Thieves and returning him to me in chains.  I will, of course, reward you richly.  "
	evt.Set("QBits", 98)         -- "Capture the Prince of Thieves and bring him to Lord Anthony Stone at Castle Stone."
	evt.SetNPCTopic{NPC = 16, Index = 0, Event = 33}         -- "Anthony Stone" : "The Prince of Thieves"
end

-- "The Prince of Thieves"
evt.global[33] = function()
	if not evt.Cmp("NPCs", 17) then         -- "The Prince of Thieves"
		evt.SetMessage(43)         -- "I have no information on his whereabouts, so it will do you no good to talk to me about it.  Try going to Free Haven and asking around.  He must have a hideout somewhere in or near that town.  <Smiling> if you find where he’s living, be sure to check under the bed and in the closet– you’ll probably find him hiding under a pile of clothes."
	else
		evt.Subtract("QBits", 98)         -- "Capture the Prince of Thieves and bring him to Lord Anthony Stone at Castle Stone."
		evt.SetMessage(44)         -- "Ah!  My friends, you have returned with the package!  Well done!  Here is your reward money.  You have my full support at the council. <looking at the Prince> Welcome to my humble home, mighty Prince.  I have a room prepared just for you.  Guards!  Take him away."
		evt.SetNPCTopic{NPC = 16, Index = 0, Event = 34}         -- "Anthony Stone" : "The High Council"
		evt.Add("Gold", 10000)
		evt.Add("ReputationIs", 200)
		evt.ForPlayer("All")
		evt.Add("Experience", 30000)
		evt.Add("Awards", 5)         -- "Captured the Prince of Thieves"
		evt.Subtract("NPCs", 17)         -- "The Prince of Thieves"
		evt.SetNPCTopic{NPC = 17, Index = 0, Event = 34}         -- "The Prince of Thieves" : "The High Council"
		evt.ForPlayer("All")
		if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
			if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
				if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
					if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
						if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
							if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
								if evt.Cmp("Awards", 7) then         -- "Ended Winter"
									evt.Set("QBits", 167)         -- NPC
								end
							end
						end
					end
				end
			end
		end
	end
end

-- "The High Council"
evt.global[34] = function()
	evt.SetMessage(45)         -- "Your work in capturing the Prince of Thieves has been quite beneficial to me.  You have my full support on the High Council."
end

-- "Priests"
evt.global[35] = function()
	evt.SetMessage(46)         -- "In addition to my duties as overseer of unlicensed business, I am the High Priest of Enroth.  It is my job to promote clerics to priests, and if warranted, priests to high priests.  Right now, the rolls are full of priests, and I am unable to promote new ones without creating new positions.  To do so would be highly irregular, but if someone were to perform an extraordinary service for the kingdom, the promotion would be acceptable.  <Rubbing his temples> Come to think of it, there is a service I need.  A temple in Free Haven was destroyed by fire a few months ago.  If you could get it rebuilt, I would have a reason to promote any clerics among you to priest status.  Since I really want this job done, I am even willing to promote non-priests to an honorary priest status, and I will pay you well for your service.  You’ll need to hire a stonecutter and a carpenter and show them the temple you want them to work on."
	evt.Add("QBits", 105)         -- "Hire a Stonecutter and a Carpenter, bring them to Temple Stone in Free Haven to repair the Temple, and then return to Lord Anthony Stone at Castle Stone."
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 36}         -- "Anthony Stone" : "Priests"
end

-- "Priests"
evt.global[36] = function()
	if not evt.Cmp("QBits", 106) then         -- NPC
		evt.SetMessage(47)         -- "The temple I asked you to rebuild still stands in ruins.  The people are deprived of their rightful religious solace, and you return to me empty-handed.  Leave here and complete your mission!  "
		return
	end
	evt.SetMessage(48)         -- "Excellent work!  The temple has been rebuilt and the affront to the gods eased.  For this service, I am happy to promote all clerics to priests, and I grant honorary priest status to all non-clerics.  Congratulations! "
	evt.Subtract("QBits", 105)         -- "Hire a Stonecutter and a Carpenter, bring them to Temple Stone in Free Haven to repair the Temple, and then return to Lord Anthony Stone at Castle Stone."
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 37}         -- "Anthony Stone" : "High Priests"
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Priest"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Priest"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Priest"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Priest"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Priest"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Priest"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 20)         -- "Received Promotion to Priest"
	else
		evt.Add("Awards", 21)         -- "Received Promotion to Honorary Priest"
	end
end

-- "High Priests"
evt.global[37] = function()
	evt.SetMessage(49)         -- "It seems a bit quick to promote anyone to high priest, given that the promotion to priest has been so recent.  Why, many wait their entire lives to receive such a promotion, only to be granted it posthumously.  However, an extraordinary service could possibly accelerate that promotion to, well, right now for instance… and I do have such a service in mind.  The heretical monks that live on the islands east of Free Haven have stolen our sacred chalice.  Retrieve it from the monks and put it in the temple you rebuilt.  Then return to me."
	evt.Add("QBits", 107)         -- "Take the Sacred Chalice from the monks in their island temple east of Free Haven, return it to Temple Stone in Free Haven, and then return to Lord Stone at Castle Stone."
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 38}         -- "Anthony Stone" : "High Priests"
end

-- "High Priests"
evt.global[38] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 108) then         -- NPC
		if evt.Cmp("Inventory", 434) then         -- "Sacred Chalice"
			evt.SetMessage(51)         -- "I see that you have recovered the chalice!  Good work, but you still need to ensconce it in the temple.  Take it there at once and return to me for your promotion!"
		else
			evt.SetMessage(50)         -- "The monks still have the chalice, and our temple is still without it.  Why do you delay?"
		end
		return
	end
	evt.SetMessage(52)         -- "You are successful!  It looks like I will have to keep my promise and make more irregular, early promotions.  I do so with pleasure.  I hereby promote all priests to high priests, and all honorary priests to honorary high priests"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to High Priest"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary High Priest"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to High Priest"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary High Priest"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to High Priest"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary High Priest"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.HighPriest)
		evt.Add("Awards", 22)         -- "Received Promotion to High Priest"
	else
		evt.Add("Awards", 23)         -- "Received Promotion to Honorary High Priest"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 107)         -- "Take the Sacred Chalice from the monks in their island temple east of Free Haven, return it to Temple Stone in Free Haven, and then return to Lord Stone at Castle Stone."
	evt.ForPlayer("All")
	evt.Add("Experience", 30000)
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 39}         -- "Anthony Stone" : "High Priests"
end

-- "High Priests"
evt.global[39] = function()
	evt.SetMessage(53)         -- "Though your rise to high priest status was almost unseemly quick, I have never seen finer high priests in all my years.  I am grateful for all you've done for myself and for Enroth."
end

-- "Arch Mages"
evt.global[40] = function()
	evt.SetMessage(121)         -- "Hello there!  Are you here to tile the floors?  Oh!  Sorry, for a moment I forgot who you were!  Welcome again, arch mages!  Perhaps you can assist me in an experiment or two when you’re less busy?"
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

-- "Hint"
evt.global[46] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 81) then         -- "Show Sulman's letter to Andover Potbello in New Sorpigal."
		evt.SetMessage(435)         -- "You should probably show The Letter to Andover Potbello in New Sorpigal."
		evt.Set("AutonotesBits", 116)         -- "You should probably show the sixth letter to Andover Potbello in New Sorpigal."
		return
	end
	if evt.Cmp("QBits", 82) then         -- "Bring Sulman's letter to Regent Wilbur Humphrey at Castle Ironfist."
		evt.SetMessage(427)         -- "You need to give The Letter to Regent Wilbur Humphrey in Ironfist Castle."
		evt.Set("AutonotesBits", 115)         -- "You need to give The Letter to Regent Wilbur Humphrey in Ironfist Castle."
		return
	end
	if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
		if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
			if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
				if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
					if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
						if not evt.Cmp("Awards", 7) then         -- "Ended Winter"
							goto _63
						end
						if not evt.Cmp("QBits", 168) then         -- NPC
							evt.SetMessage(432)         -- "It appears that Slicker Silvertongue is a traitor on the Council.  You will need proof to convince Regent Humphrey and have Slicker removed from the Council.  Go to the Superior Temple of Baa in Kriegspire and return with proof associating Slicker with the Temple of Baa."
							evt.Set("AutonotesBits", 112)         -- "It appears that Slicker Silvertongue is a traitor on the Council.  You will need proof to convince Regent Humphrey and have Slicker removed from the Council.  Go to the Superior Temple of Baa in Kriegspire and return with proof associating Slicker with the Temple of Baa."
							return
						end
						if not evt.Cmp("Awards", 33) then         -- "Awakened the Oracle"
							evt.SetMessage(433)         -- "The Oracle has been asleep since Archibald performed his mischief on it.  You will need the four memory crystals to revive the Oracle.  They can be found on Hermit's Isle, in Castle Alamos, in Castle Kriegspire, and in Castle Darkmoor."
							evt.Set("AutonotesBits", 111)         -- "The Oracle has been asleep since Archibald performed his mischief on it.  You will need the four memory crystals to revive the Oracle.  They can be found on Hermit's Isle, in Castle Alamos, in Castle Kriegspire, and in Castle Darkmoor."
							return
						end
						if evt.Cmp("Awards", 36) then         -- "Destroyed the Hive and Saved Enroth"
							evt.SetMessage(439)         -- "You have no more need of my advice."
							return
						end
						if evt.Cmp("Inventory", 544) then         -- "Ritual of the Void"
							evt.SetMessage(438)         -- "Now you must destroy the Kreegan Hive.  Destroy the reactor, defeat their queen, and make sure to escape with the Ritual of the Void and you will succeed in your task."
							evt.Set("AutonotesBits", 108)         -- "Now you must destroy the Kreegan Hive.  Destroy the reactor, defeat their queen, and make sure to escape with the Ritual of the Void and you will succeed in your task."
							return
						end
						if not evt.Cmp("Inventory", 64) then         -- "Blaster"
							if not evt.Cmp("Inventory", 65) then         -- "Blaster Rifle"
								evt.SetMessage(434)         -- "To gain access to the Control Center, you will need the Control Cube located in the Temple of VARN in Dragonsand.  Bring the Cube back to the Oracle to gain admittance into the Control Center.  The Kreegan reactor is immune to all attacks.  Only the ancient weapons from the Control Center will harm the reactor.  Make sure you have these weapons and the skill to use them."
								evt.Set("AutonotesBits", 110)         -- "To gain access to the Control Center, you will need the Control Cube located in the Temple of VARN in Dragonsand.  Bring the Cube back to the Oracle to gain admittance into the Control Center.  The Kreegan reactor is immune to all attacks.  Only the ancient weapons from the Control Center will harm the reactor.  Make sure you have these weapons and the skill to use them."
								return
							end
						end
						evt.SetMessage(437)         -- "Before you destroy the reactor, you will need a spell capable of containing the resulting explosions.  You must free Archibald from his stone prison.  Talk to Nicolai and bring him the Third Eye– he will allow you to use Tanir's Bell to turn Archibald back to normal.  From there, you should be able to convince Archibald to give you the knowledge you need."
						evt.Set("AutonotesBits", 109)         -- "Before you destroy the reactor, you will need a spell capable of containing the resulting explosions.  You must free Archibald from his stone prison.  Talk to Nicolai and bring him the Third Eye– he will allow you to use Tanir's Bell to turn Archibald back to normal.  From there, you should be able to convince Archibald to give you the knowledge you need."
						return
					end
				end
			end
		end
	end
::_63::
	if evt.Cmp("BaseLevel", 25) then
		evt.SetMessage(430)         -- "You must satisfy the six High Council members in Free Haven to visit the Oracle.  Each lord will request a task of you to earn their favor.  Perform each of these tasks and then talk to the Council member of that Lord to gain their approval.  Once all the members of the High Council give their permission, you will be allowed to visit the Oracle."
		evt.Set("AutonotesBits", 113)         -- "You must satisfy the six High Council members in Free Haven to visit the Oracle.  Each lord will request a task of you to earn their favor.  Perform each of these tasks and then talk to the Council member of that Lord to gain their approval.  Once all the members of the High Council give their permission, you will be allowed to visit the Oracle."
	else
		evt.SetMessage(428)         -- "I would advise that you perform the promotion quests for the six lords of Enroth until you have advanced a little further."
		evt.Set("AutonotesBits", 114)         -- "I would advise that you perform the promotion quests for the six lords of Enroth until you have advanced a little further."
	end
end

-- "Divine Intervention"
evt.global[47] = function()
	evt.SetMessage(58)         -- "1"
	evt.Add("QBits", 109)         -- NPC
	evt.SetNPCTopic{NPC = 10, Index = 0, Event = 48}         -- "Marton Ferris" : "Divine Intervention"
end

-- "Divine Intervention"
evt.global[48] = function()
	evt.SetMessage(59)         -- "2"
end

-- "Divine Intervention"
evt.global[49] = function()
	evt.SetMessage(60)         -- "3"
end

-- "Council Quest"
evt.global[51] = function()
	evt.SetMessage(61)         -- "I sometimes have the worst trouble trying to remember things I’ve learned.  I’m not sure why this is, but I’ve discovered a way around the problem.  I am going to create a mirror that will allow me to look back in time, so that I can remember what it is I’ve forgotten.  To do this, I need the Hourglass of Time, but my duties and research prevent me from searching for the hourglass on my own.  The hourglass is said to be in a dark cavern up near area… <pauses a moment>  No, that was the Spear of Darkness…  where is the hourglass?  <pauses again>  I should be able to remember this.  <snaps his fingers>  Of course!  It’s buried in an old fort to the south of here.  I can offer you my support in the council if you will help me in creating my mirror."
	evt.SetNPCTopic{NPC = 5, Index = 0, Event = 52}         -- "Albert Newton" : "Council Quest"
	evt.Add("QBits", 110)         -- "Find and return the Hourglass of Time to Lord Albert Newton in Mist."
end

-- "Council Quest"
evt.global[52] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 433) then         -- "Hourglass of Time"
		evt.SetMessage(64)         -- "Now all I have to do is remember how to create the mirror.  I wrote down all the important parts so I wouldn’t forget how to do it.  <stops> Where did I put those notes?  <ponders for a minute> I must have left them somewhere obvious, maybe in the laboratory.  Anyway, your part in this is done, and again I thank you.  You will have my complete support in the council for this.  What were your names again? "
		evt.Add("Experience", 50000)
		evt.Add("Awards", 3)         -- "Retrieved the Hourglass of Time"
		evt.Subtract("Inventory", 433)         -- "Hourglass of Time"
		evt.Subtract("QBits", 183)         -- Quest item bits for seer
		evt.ForPlayer("Current")
		evt.Add("ReputationIs", 200)
		evt.Subtract("QBits", 110)         -- "Find and return the Hourglass of Time to Lord Albert Newton in Mist."
		evt.SetNPCTopic{NPC = 5, Index = 0, Event = 54}         -- "Albert Newton" : "Council Quest"
		evt.ForPlayer("All")
		if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
			if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
				if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
					if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
						if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
							if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
								if evt.Cmp("Awards", 7) then         -- "Ended Winter"
									evt.Set("QBits", 167)         -- NPC
								end
							end
						end
					end
				end
			end
		end
	elseif evt.Cmp("Inventory", 487) then         -- "Key to Gharik's Laboratory"
		evt.SetMessage(65)         -- "The hourglass wasn’t there?  Oh, that’s right!  I knew I forgot something!  The key is in there!  You use the key to open the Forge of… <pauses>  Well, I can’t remember whose forge it is, but that is the resting place of the Hourglass of Time...I think.  It can’t hurt to look there, especially now that you’ve found the key.  <pauses>  At least I THINK that’s what the key opens.  Anyway, that forge or laboratory or whatever it is can be found on the islands north of New Sorpigal.  Good Luck!"
	else
		evt.SetMessage(63)         -- "I’m still looking for the mirror. <pauses> I mean Hourglass… I keep getting those mixed up.  Did you try the dark cavern– no wait, it was the old fort south of here.  I always seem to mix those up."
	end
end

-- "Put Text Here"
evt.global[53] = function()
	evt.SetMessage(65)         -- "The hourglass wasn’t there?  Oh, that’s right!  I knew I forgot something!  The key is in there!  You use the key to open the Forge of… <pauses>  Well, I can’t remember whose forge it is, but that is the resting place of the Hourglass of Time...I think.  It can’t hurt to look there, especially now that you’ve found the key.  <pauses>  At least I THINK that’s what the key opens.  Anyway, that forge or laboratory or whatever it is can be found on the islands north of New Sorpigal.  Good Luck!"
end

-- "Council Quest"
evt.global[54] = function()
	evt.SetMessage(66)         -- "Thanks again for getting the hourglass for me!  If only I could remember where I put it.  <sighs>  You have my support in the council for as long as you need it."
end

-- "Wizards"
evt.global[55] = function()
	evt.Add("QBits", 111)         -- "Drink from the Fountain of Magic and return to Lord Albert Newton in Mist."
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 56}         -- "Albert Newton" : "Wizards"
	evt.ForPlayer("All")
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.SetMessage(67)         -- "I am the magus in charge of training and promoting sorcerers.  Though powerful, sorcerer is not the pinnacle of the elemental magician.  Wizards take the knowledge and ability of a sorcerer, and hone those abilities to a sharper level.  They have greater magical potential than the sorcerer, and demand greater respect.  The way to earn this training, however, is not easy.  Find the Fountain of Magic, drink from its waters, and return here.  If you are able to do this, I will train you in the ways of the wizard."
	else
		evt.SetMessage(68)         -- "I am the magus responsible for  the promotion of sorcerers.  Though none of you are sorcerers, I’m a fair man.  If you are able to locate the Fountain of Magic, I’ll grant you honorary wizard status.  You won’t receive any benefits of the wizards’ training, but you will gain more respect in the eyes of sorcerers and wizards.  "
	end
end

-- "Wizards"
evt.global[56] = function()
	evt.SetMessage(69)         -- "Don’t ask me for hints, I’ve already forgotten where the Fountain is.  I know this isn’t an easy task, but if it were not difficult, every sorcerer would already BE a wizard."
end

-- "Wizards"
evt.global[58] = function()
	evt.SetMessage(70)         -- "You have done well in finding the Fountain.  It’s location and powers are a secret, do not spread its location around.  Now, let me show you the secrets of the wizard."
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Wizard"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Wizard"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Wizard"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Wizard"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Wizard"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Wizard"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 12)         -- "Received Promotion to Wizard"
	else
		evt.Add("Awards", 13)         -- "Received Promotion to Honorary Wizard"
	end
	evt.Add("ReputationIs", 50)
	evt.Subtract("QBits", 111)         -- "Drink from the Fountain of Magic and return to Lord Albert Newton in Mist."
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 59}         -- "Albert Newton" : "Arch Mages"
end

-- "Arch Mages"
evt.global[59] = function()
	evt.SetMessage(71)         -- "Your training does not end with what you have learned as a wizard, one final step remains.  Arch mage status completes your mastery of elemental magic.  Building on your wizard training, arch mages have vast magical ability– the most efficient and skilled use of magic anywhere.  Earning this training requires a powerful artifact, owned by the powerful Arch Mage Drael-.. no, it was Frundir-… no, that’s not right either.  Actually, I can’t seem to remember what the artifact was or who owned it.  I'd remember it if I saw it, though.  I know it can be found in Corlagon’s Estate near the Mire of the Damned.  Search for it there and return it; I must have it to train you to become an arch mage."
	evt.Add("QBits", 112)         -- "Retrieve the Crystal of Terrax and return to Lord Albert Newton in Mist."
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 60}         -- "Albert Newton" : "Arch Mages"
end

-- "Arch Mages"
evt.global[60] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 457) then         -- "Crystal of Terrax"
		evt.SetMessage(72)         -- "I’m sorry, but I still haven’t remembered exactly what it is you need.  I know you need to search Corlagon’s Estate.   "
		return
	end
	evt.SetMessage(73)         -- "Great news!  I remember what you need to find!  The Crystal of Terrax!  Oh, you seem to have found it already.  Well, perfect!  I can train you to arch mage, then.  The first arch mage, Terrax, used this Crystal to master the elements.  Fire, earth, water, and air all formed together to make it, and from analyzing it he learned a great deal about elemental magic.  In addition, its effect on light led him to his discoveries of light and dark magic.  Since that time, the study of this crystal has guided every new arch mage.  Let me show you the secrets of the crystal, arch magi. "
	evt.Add("Experience", 30000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Archmage"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Archmage"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Archmage"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Archmage"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Archmage"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Archmage"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 14)         -- "Received Promotion to Archmage"
	else
		evt.Add("Awards", 15)         -- "Received Promotion to Honorary Archmage"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 112)         -- "Retrieve the Crystal of Terrax and return to Lord Albert Newton in Mist."
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 457)         -- "Crystal of Terrax"
	evt.Subtract("QBits", 186)         -- Quest item bits for seer
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 40}         -- "Albert Newton" : "Arch Mages"
end

-- "Council Quest"
evt.global[61] = function()
	evt.SetMessage(74)         -- "I don’t have much time to talk right now– I have a lot to do.  I’m in the process of organizing a few campaigns to attack the devils along the western coast.  You must realize, as I do, that nothing in all of Enroth poses as much of a threat to our safety as they do.  I only wish the other Lords would assist me by contributing supplies and troops, or just helping in the planning of these attacks.  They spend more time bickering amongst themselves over borders and laws and trade than in helping me deal with the REAL threat.  The devils have an advance post in Kriegspire near the Sentinels.  From here, they are able to base small raids and gather intelligence on our forces.  I need you to sneak in and attack it, find what information you can on the location of any devil strongholds and patrol patterns, and destroy the place.  Do not let any of the devils escape!  Surprise and secrecy are our greatest weapons."
	evt.Add("QBits", 113)         -- "Destroy the Devil's Outpost and return to Lord Osric Temper at Castle Temper."
	evt.SetNPCTopic{NPC = 6, Index = 0, Event = 62}         -- "Osric Temper" : "Council Quest"
end

-- "Council Quest"
evt.global[62] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 506) then         -- "Devil Plans"
		evt.SetMessage(76)         -- "Did you fail in your mission?  You didn’t allow the demons to escape, did you?  That post MUST be destroyed for any large attack against them to be successful.  As long as that post exists, your mission still stands. "
	else
		evt.SetMessage(77)         -- "Good job!  With the information you’ve brought back, we now have the intelligence we need to stage an attack on the devils, and with that post out of the way, we can hit them when they won’t expect it. I give you my full support in the council– hopefully the council will actually DO something for once."
		evt.Add("Experience", 40000)
		evt.Add("Awards", 4)         -- "Destroyed the Devil's Post"
		evt.Subtract("Inventory", 506)         -- "Devil Plans"
		evt.Subtract("QBits", 184)         -- Quest item bits for seer
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 113)         -- "Destroy the Devil's Outpost and return to Lord Osric Temper at Castle Temper."
		evt.Add("ReputationIs", 200)
		evt.SetNPCTopic{NPC = 6, Index = 0, Event = 64}         -- "Osric Temper" : "Council Quest"
		evt.ForPlayer("All")
		if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
			if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
				if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
					if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
						if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
							if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
								if evt.Cmp("Awards", 7) then         -- "Ended Winter"
									evt.Set("QBits", 167)         -- NPC
								end
							end
						end
					end
				end
			end
		end
	end
end

-- "Council Quest"
evt.global[64] = function()
	evt.SetMessage(78)         -- "Excellent work in dispatching those devils!  Again, you have my thanks.  My support in the council is yours, at least until the threat of the devils is past.  Hopefully you can spur the council into action.  By the way, the information that you brought back has confirmed our suspicion about the enemy base.  It is definitely near the town of Sweet Water in Paradise Valley."
end

-- "Cavaliers"
evt.global[65] = function()
	evt.Add("QBits", 114)         -- "Get Knight's nomination from Chadwick and return to Lord Osric Temper at Castle Temper."
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 66}         -- "Chadwick Blackpoole" : "Nomination"
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 68}         -- "Osric Temper" : "Cavaliers"
	evt.ForPlayer("All")
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.SetMessage(79)         -- "I am the Armsmaster in charge of the promotion of all knights in Enroth.  Worthy knights can be promoted to cavaliers.  Cavaliers embody the spirit of action and the power of purpose.  Behind their courageous example, armies charge into battle and enemies flee in terror. However, to become a cavalier, you need to be nominated by a person of authority.  If you could get the nomination of a cavalier, that would be good enough for me.   "
	else
		evt.SetMessage(80)         -- "I am the Armsmaster in charge of the promotion of knights.  Unfortunately, none of you are knights, and therefore the skills I would teach you would be worthless.  However, if you so desire, you can attempt the task of a would-be cavalier.  Seek the nomination of a person of authority, a cavalier, for example, and return to me."
	end
end

-- "Nomination"
evt.global[66] = function()
	evt.SetMessage(81)         -- "Well there, you’re looking for a nomination to become cavaliers?  I was once a valiant knight in my day.  I fought with Roland in the Succession wars, though now I’m too old to do much good on the battlefield.  It’s good to see Osric keeping the traditions of the knights alive.  Tell him that I proudly nominate you to become cavaliers, and if he gives you any trouble tell him to come see me himself."
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 69}         -- "Osric Temper" : "Cavaliers"
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 0}         -- "Chadwick Blackpoole"
end

-- "Cavaliers"
evt.global[67] = function()
	evt.SetMessage(82)         -- "Congratulations!  I know you’ll make fine cavaliers.  I only wish I had my youth again to serve with Osric in a campaign against the devils."
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 0}         -- "Chadwick Blackpoole"
end

-- "Cavaliers"
evt.global[68] = function()
	evt.SetMessage(83)         -- "Come now!  A person of your fame and stature should have no problem being nominated.  Don’t tell me your fame is contrived– are you sure you deserve to be as famous as you are?  <laughs>  I’m jesting, calm down.  Seriously, I'd suggest looking in Free Haven or the village of Rockham.  I've heard a few cavaliers frequent the taverns there."
end

-- "Cavaliers"
evt.global[69] = function()
	evt.SetMessage(84)         -- "Congratulations!  The nomination may not seem important, but we have a tradition that must be followed for this promotion.  As a cavalier, you need to understand that the traditions and values of the people need to be defended.  I gladly promote you to the rank of cavalier!"
	evt.Subtract("QBits", 114)         -- "Get Knight's nomination from Chadwick and return to Lord Osric Temper at Castle Temper."
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Cavalier"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Cavalier"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Cavalier"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Cavalier"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Cavalier"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Cavalier"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Received Promotion to Cavalier"
	else
		evt.Add("Awards", 17)         -- "Received Promotion to Honorary Cavalier"
	end
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 70}         -- "Osric Temper" : "Champions"
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 67}         -- "Chadwick Blackpoole" : "Cavaliers"
end

-- "Champions"
evt.global[70] = function()
	evt.SetMessage(85)         -- "Ah, worthy cavaliers, the final step in your training is to become a champion.  A cavalier is a brave and noble warrior, but a champion is a power to behold.  No force can stand between the champion and victory.  Entire campaigns are decided on the bravery, decisiveness, and powerful example of the champion.  The task to complete this promotion, however, is difficult.  You must defeat a powerful enemy to prove your ability and determination.  The only enemy worthy of this task is a man known only as the Warlord, a dangerous and powerful warrior.  He commands a legion of evil knights, normally based to the northeast of  Icewind Pass.  Defeat him, bring back proof of your victory, and your promotion to champion is assured."
	evt.Add("QBits", 115)         -- "Defeat the Warlord and bring proof to Osric Temper"
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 71}         -- "Osric Temper" : "Champions"
end

-- "Champions"
evt.global[71] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 508) then         -- "Discharge Papers"
		evt.SetMessage(86)         -- "You’re not scared of the Warlord, are you?  His terror needs to be put to an end.  You can’t become champion hiding underneath your bed or standing around looking at the walls– you need to go out and DO it!"
		return
	end
	evt.SetMessage(87)         -- "Good job!  Excellent!  I wasn’t sure you’d make it back alive.  Kergmond had more potential than I realized, but you’re certainly more than a match for an army of Kergmonds.  You’ve proven yourselves worthy of the rank of champion. You must not be afraid to take up arms to defend what is right.  May your enemies fear your approach and your allies rally behind your courage. And now, I promote you to the rank of champion! "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Champion"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Champion"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Champion"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Champion"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Champion"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Champion"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Received Promotion to Champion"
	else
		evt.Add("Awards", 19)         -- "Received Promotion to Honorary Champion"
	end
	evt.Add("ReputationIs", 100)
	evt.Subtract("QBits", 115)         -- "Defeat the Warlord and bring proof to Osric Temper"
	evt.ForPlayer("All")
	evt.Add("Experience", 40000)
	evt.Subtract("Inventory", 508)         -- "Discharge Papers"
	evt.Subtract("QBits", 187)         -- Quest item bits for seer
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 72}         -- "Osric Temper" : "Champions"
end

-- "Champions"
evt.global[72] = function()
	evt.SetMessage(120)         -- "Well met, champions!  Please, don’t waste your valuable time or mine in times like this.  Use your skills for the good of Enroth and leave me to my planning!  When this battle is over, THEN we can share tales of valor and skill."
end

-- "Crystal Locations"
evt.global[73] = function()
	evt.SetMessage(88)         --[[ "Memory Crystal Alpha – Hermit’s Isle.
Memory Crystal Beta – Alamos.
Memory Crystal Delta – Darkmoor.
Memory Crystal Epsilon – Kriegspire." ]]
	if not evt.Cmp("QBits", 162) then         -- "Find Memory Crystal Alpha in the Supreme Temple of Baa and restore it to a module altar at the Oracle beneath the High Council.."
		evt.Add("QBits", 162)         -- "Find Memory Crystal Alpha in the Supreme Temple of Baa and restore it to a module altar at the Oracle beneath the High Council.."
		evt.Add("QBits", 163)         -- "Find Memory Crystal Beta in Castle Alamos and restore it to a module altar at the Oracle beneath the High Council."
		evt.Add("QBits", 164)         -- "Find Memory Crystal Delta in Castle Darkmoor and restore it to a module altar at the Oracle beneath the High Council."
		evt.Add("QBits", 165)         -- "Find Memory Crystal Epsilon in Castle Kriegspire and restore it to a module altar at the Oracle beneath the High Council."
	end
end

-- "Memory Crystal"
evt.global[74] = function()
	evt.SetMessage(89)         -- "Place the memory Crystals into the modules above.  All four Crystals are necessary to activate the Oracle."
end

-- "Control Center"
evt.global[76] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 166) then         -- "Retrieve the Control Cube from the Tomb of Varn in Dragonsand and return to the Oracle beneath the High Council."
		if evt.Cmp("Inventory", 456) then         -- "Control Cube"
			evt.Add("Experience", 500000)
			evt.Add("Awards", 34)         -- "Gained Access to the Control Center"
			evt.Subtract("QBits", 166)         -- "Retrieve the Control Cube from the Tomb of Varn in Dragonsand and return to the Oracle beneath the High Council."
			evt.Subtract("Inventory", 456)         -- "Control Cube"
			evt.Subtract("QBits", 195)         -- Quest item bits for seer
			evt.SetNPCTopic{NPC = 8, Index = 0, Event = 77}         -- "Oracle" : "Kreegan"
			evt.SetNPCTopic{NPC = 8, Index = 1, Event = 78}         -- "Oracle" : "Ancients"
			evt.SetMessage(91)         -- "You now have access to the Control Center.  Simply ask to be transported and I will oblige.  One warning however– the guardians of the Control Center are no longer under my control, so please exercise caution while visiting the Center."
			return
		end
	else
		evt.Add("Awards", 33)         -- "Awakened the Oracle"
		evt.Add("QBits", 166)         -- "Retrieve the Control Cube from the Tomb of Varn in Dragonsand and return to the Oracle beneath the High Council."
		evt.Subtract("QBits", 162)         -- "Find Memory Crystal Alpha in the Supreme Temple of Baa and restore it to a module altar at the Oracle beneath the High Council.."
		evt.Subtract("QBits", 163)         -- "Find Memory Crystal Beta in Castle Alamos and restore it to a module altar at the Oracle beneath the High Council."
		evt.Subtract("QBits", 164)         -- "Find Memory Crystal Delta in Castle Darkmoor and restore it to a module altar at the Oracle beneath the High Council."
		evt.Subtract("QBits", 165)         -- "Find Memory Crystal Epsilon in Castle Kriegspire and restore it to a module altar at the Oracle beneath the High Council."
	end
	evt.SetMessage(90)         --[[ "I am Melian, Guardian of Enroth.  Thank you for replacing my memory modules.  Archibald took them from here when I refused to give him any help in his battle for succession.  Your timing is impeccable.  The Kreegan have invaded our world, and you must try and stop them.  Unfortunately, Archibald’s attempts at extracting information from me have damaged me enough that I cannot help you directly now.  Instead, I can only give you advice.

While most of the Kreegan can be slain with ordinary weapons and spells, the elite guards and upper echelon breeders have tougher skin and natural defenses that protect them from anything but very powerful weapons.  In the planetary control center beneath me are the weapons and armor you will need to survive battle with the enemy.  My orders, however, will only permit passage to someone with a Control Cube.  My instruments tell me that the only Control Cube left in Enroth can be found somewhere underground in Dragonsand.  " ]]
end

-- "Kreegan"
evt.global[77] = function()
	if not evt.Cmp("QBits", 305) then         -- NPC
		if not evt.Cmp("QBits", 96) then         -- "Find the Third Eye and bring it to Prince Nicolai in Castle Ironfist."
			evt.Set("QBits", 235)         -- "Obtain Arcane Magic from Archibald in the Royal Library in Castle Ironfist"
			evt.SetNPCTopic{NPC = 13, Index = 1, Event = 26}         -- "Nicolai Ironfist" : "The Third Eye"
			evt.Add("QBits", 169)         -- NPC
		end
	end
	evt.SetMessage(92)         -- "As I said, the Kreegan are resistant to most of the weapons available in Enroth, but not all.  To rid the world of them, you will need to find where their vessel crashed and destroy the main reactor.  The only problem is that the resulting explosions from the reactor will destroy this planet.  You will need a powerful spell to prevent the explosion from damaging the planet, but no spell like that exists in the world today.  The only person I can think of that would know of such a spell is Archibald, but he is in no condition to teach you.  To make matters worse, the reactor cannot be harmed by normal weapons or spells– you will need the ancient weapons in the Control Center to destroy the reactor."
end

-- "Ancients"
evt.global[78] = function()
	evt.SetMessage(93)         -- "Though my memory has been damaged by Archibald, I can still remember the danger that our ancient enemy, the Kreegan, pose to our world.  The Kreegan first appeared roughly 1500 years ago, attacking outlying colonies and stealing their resources.  It was thought at the time they simply needed certain minerals, and could be reasoned with, but this was not the case.  Their life cycle forces them to breed until the world cannot support their numbers, then they send ships off to other worlds to renew the cycle.  Their attacks against the empire of the Ancients disrupted the network of shipping and communications that held us all together, causing the Silence that marks the first year of our modern calendar.  Without support from the homeworlds, our fledgling technology failed, bringing us to this sorry state.  I would help rebuild our technology, but I seem to have become a religious figure in the minds of many people, and very few visit me or understand what I have to offer.  Perhaps this Kreegan crisis we face will bring people to their senses--as long as we survive it."
end

-- "Money"
evt.global[79] = function()
	evt.SetMessage(94)         -- "I happen to know that you are amongst a short list of adventurers looking to receive favor from the High Council.  What you want it for I don’t know, nor do I care.  I’ll be blunt:  I love money, and I want more.  Much more.  I have a plan to fix the price of shipping in my favor for a time and I need competent agents to carry it out.  Perform this task well and I will give you my support, not to mention a lot of money.  Here is the plan:  Each of the nine shipping companies in the Kingdom must be convinced to charge at least 48 gold per pound per mile of material they transport.  They are all in competition and they know it, so none will want to make a move before the others.  I don’t care how you convince them– just get the job done and report back to me."
	evt.Add("QBits", 116)         -- "Fix the prices of all 9 stables in the Kingdom and return to Lady Fleise in Silver Cove."
	evt.Set(216, 0)
	evt.SetNPCTopic{NPC = 14, Index = 0, Event = 80}         -- "Loretta Fleise" : "Money"
end

-- "Money"
evt.global[80] = function()
	if not evt.Cmp("QBits", 117) then         -- NPC
		evt.SetMessage(95)         -- "Not all of the companies have agreed to raise their prices!  Why do you return only to report incompetence?  There are large profits I could be reaping if you had done your job and convinced these idiots to raise their prices!  MUST I DO THIS MYSELF?  Should I send someone else?  Why do I surround myself with MORONS?!  So far I have lost a lot of gold because you haven’t finished your job!  I’ll deduct these losses from your final payment, you can be sure of that!"
		return
	end
	evt.SetMessage(96)         -- "At last!  Thought you would never finish.  Maybe you’re good for something after all.  You have won my support in the council, and of course, your payment. "
	if evt.Cmp(216, 31) then
		evt.Add("Gold", 5000)
	else
		evt.Add("Gold", 25000)
	end
	evt.Subtract("QBits", 116)         -- "Fix the prices of all 9 stables in the Kingdom and return to Lady Fleise in Silver Cove."
	evt.Subtract("ReputationIs", 200)
	evt.ForPlayer("All")
	evt.Add("Awards", 6)         -- "Fixed the Stable Prices"
	evt.Add("Experience", 25000)
	evt.SetNPCTopic{NPC = 14, Index = 0, Event = 81}         -- "Loretta Fleise" : "Money"
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
		if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
			if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
				if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
					if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
						if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
							if evt.Cmp("Awards", 7) then         -- "Ended Winter"
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
	evt.SetMessage(97)         -- "If you're concerned about the suffering of the peasants over my price increase, don't be.  I did it all for a good cause.  I needed to raise money for granaries to store the excess grain we are harvesting this year.  The shipping prices are back down, and the availability of cheap, high quality grain more than makes up for it.  There!  I'm not so horrible, am I?"
end

-- "Great Druids"
evt.global[82] = function()
	evt.SetMessage(98)         -- "Although it may be hard to believe, I happen to be one of the top druids in the land.  As such I am empowered to promote druids to great and arch druid status, provided they prove themselves worthy.  To be promoted to great druid status, you must perform the Ceremony of the Sun.  Pray at the center of the Circle of Stone during any equinox or solstice– March 20th, June 21st, September 23rd, or December 21st.  If you are there at that time, I will contact you magically and lead you through the Ceremony, thus promoting you to great druid.  Those among you who are not druids will be granted honorary great druid status, and I am sure the experience will be worthwhile."
	evt.Add("QBits", 118)         -- "Visit the Altar of the Sun in the circle of stones north of Silver Cove on an equinox or solstice (HINT:  March 20th is an equinox)."
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 83}         -- "Loretta Fleise" : "Great Druids"
end

-- "Great Druids"
evt.global[83] = function()
	evt.SetMessage(99)         -- "You must pray at the center of the Circle of Stone during an equinox or solstice to complete the Ceremony of the Sun and be promoted to great druid.  There is nothing I can do for you to be promoted until then."
end

-- "Arch Druids"
evt.global[84] = function()
	evt.SetMessage(101)         -- "So, you believe you are deserving of the title of arch druid.  You must complete the Ceremony of the Moon to achieve arch druid status.  This used to be rather easy before the factional split amongst the last generation of druids, but now you must fight your way to the sacred altar.  It is in the Temple of the Moon, currently controlled by the evil heretic Cedric Druthers.  There is no way they will just let you complete the ceremony peacefully, so you will probably have to fight your way in.  Like the Ceremony of the Sun, the Ceremony of the Moon must be performed at a certain place and time.  Pray at the Altar of the Moon in the Temple of the Moon at midnight during any full moon.  If you are there at that time, I will contact you magically and lead you through the Ceremony."
	evt.Add("QBits", 119)         -- "Visit the Altar of the Moon in the Temple of the Moon at midnight of a full moon."
	evt.SetNPCTopic{NPC = 305, Index = 1, Event = 85}         -- "Loretta Fleise" : "Arch Druids"
end

-- "Arch Druids"
evt.global[85] = function()
	evt.SetMessage(103)         -- "You must be standing before the altar of the Moon at midnight on any full moon to complete the Ceremony of the Moon and be promoted to arch druid.  There is nothing I can do for you to be promoted until then."
end

-- "Arch Druids"
evt.global[86] = function()
	evt.SetMessage(104)         -- "The earth is wounded in the west.  I can feel it, my fellow druids, and if you put your hand to the ground and listen with your heart, you'll feel it, too.  I am bound here with my responsibilities, but I urge you to investigate the source of this pain.  I am sure the wound and the Night of Shooting Stars are related.  "
end

-- "Winter"
evt.global[87] = function()
	evt.SetMessage(105)         -- "I grow tired of winter.  In my lands, winter seems to last year round.  As a matter of fact, for the last few years, summer didn’t arrive at all.  I have come to believe that something is wrong with the weather, and I want something done about it.  I know your reputation, and I hear you can do anything.  I have a deal for you.  End the winter in my land and I will give you my support in the High Council when it comes time for you to ask for it.  If it's any help at all, I hear there is hermit on a mountaintop somewhere west of here who has studied the weather in detail."
	evt.Add("QBits", 120)         -- "End winter for Lord Stromgard at Castle Stromgard, and return to him with the good news."
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 88}         -- "Erik Von Stromgard" : "Winter"
	evt.SetNPCTopic{NPC = 19, Index = 0, Event = 96}         -- "The Hermit on the Mountain" : "Winter"
end

-- "Winter"
evt.global[88] = function()
	evt.SetMessage(106)         -- "Do you think you could hurry this miracle thing along?  The snow on the ground is building up, and we are going to have to start putting buildings on stilts!"
end

-- "Winter"
evt.global[89] = function()
	evt.SetMessage(107)         -- "I was looking out my window when the weather broke and the snow vanished!  A miracle!  A genuine miracle!  You have done my people and me a great service.  <Slapping his chest> Count Erik Von Stromgard as your friend forever!  "
	evt.Subtract("QBits", 120)         -- "End winter for Lord Stromgard at Castle Stromgard, and return to him with the good news."
	evt.Set("QBits", 175)         -- NPC
	evt.Add("ReputationIs", 200)
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 90}         -- "Erik Von Stromgard" : "Winter"
	evt.ForPlayer("All")
	evt.Add("Awards", 7)         -- "Ended Winter"
	evt.Add("Experience", 50000)
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 32) then         -- "Exposed the Traitor on the High Council"
		if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
			if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
				if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
					if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
						if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
							if evt.Cmp("Awards", 7) then         -- "Ended Winter"
								evt.Set("QBits", 167)         -- NPC
							end
						end
					end
				end
			end
		end
	end
end

-- "Winter"
evt.global[90] = function()
	evt.SetMessage(108)         -- "For your services, I grant you my favor in the High Council!  Long may you live, O enemies of Winter!"
end

-- "Battle Mages"
evt.global[91] = function()
	evt.SetMessage(109)         -- "20 years ago, I won the annual archery competition held at Castle Ironfist, and I have held the championship ever since.  This gives me the right to promote archers to the title of battle mage and warrior mage as I see fit.  I’ll grant the title of battle mage to all the archers amongst you if you do me a little favor. I need the key to the old Dragon Towers set up near every major settlement in Enroth to shoot down flying creatures.  I think that they can be set to shoot down only monsters, instead of shooting anything flying through the air. Since this is something of a pet project, I will reward honorary battle mage status to the rest of you.  The key is in my old keep near the southern entrance to my lands.  I had to leave it there when the ogres and their companions took it from me a few years ago.  Return with that key and be rewarded.  And I won’t be crying in my beer if you kill a lot of those monsters while you’re at it.  They took my keep!"
	evt.Add("QBits", 121)         -- "Retrieve the key to the Dragon Towers from Icewind Keep south of Whitecap, and bring it to Lord Stromgard at Castle Stromgard."
	evt.SetNPCTopic{NPC = 15, Index = 1, Event = 92}         -- "Erik Von Stromgard" : "Battle Mages"
end

-- "Battle Mages"
evt.global[92] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 486) then         -- "Dragon Tower Keys"
		evt.SetMessage(110)         -- "No key—No reward.  Our deal is simple and straightforward.  Fetch the key from my old keep and return once you have it.  "
		return
	end
	evt.SetMessage(111)         -- "Very good!  You got the key, and hopefully slew a large number of those loathsome beasts.  I hereby promote all archers to the status of battle mage, and all non-archers to honorary battle mage."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Battle Mage"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Battle Mage"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Battle Mage"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Battle Mage"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Battle Mage"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Battle Mage"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.BattleMage)
		evt.Add("Awards", 28)         -- "Received Promotion to Battle Mage"
	else
		evt.Add("Awards", 29)         -- "Received Promotion to Honorary Battle Mage"
	end
	evt.Subtract("QBits", 121)         -- "Retrieve the key to the Dragon Towers from Icewind Keep south of Whitecap, and bring it to Lord Stromgard at Castle Stromgard."
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.SetNPCTopic{NPC = 15, Index = 1, Event = 93}         -- "Erik Von Stromgard" : "Warrior Mages"
end

-- "Warrior Mages"
evt.global[93] = function()
	evt.SetMessage(112)         -- "The reason I wanted the key was to open the Dragon Towers and make the adjustments to prevent them from shooting flyers indiscriminately.  There is a way to adjust the towers to shoot at only large objects, and I want all of them adjusted for the good of the Kingdom.  Magic is becoming more common, as are stories of young Sorcerers getting shot from the sky because they didn’t know the function of the towers.  You have the key.  If you adjust all of the towers to shoot at only large objects, I will promote all battle mages amongst you to warrior mages and promote any honorary battle Mages to honorary warrior mages."
	evt.Add("QBits", 122)         -- "Reset all of the Dragon Towers at each town and return to Lord Stromgard in Castle Stromgard."
	evt.SetNPCTopic{NPC = 15, Index = 1, Event = 100}         -- "Erik Von Stromgard" : "Warrior Mages"
end

-- "Warrior Mages"
evt.global[100] = function()
	if evt.Cmp("QBits", 156) then         -- NPC
		if evt.Cmp("QBits", 157) then         -- NPC
			if evt.Cmp("QBits", 158) then         -- NPC
				if evt.Cmp("QBits", 159) then         -- NPC
					if not evt.Cmp("QBits", 160) then         -- NPC
						goto _11
					end
					if not evt.Cmp("QBits", 161) then         -- NPC
						goto _11
					end
					evt.SetMessage(115)         -- "I knew my faith in you was well placed!  You have fixed a major problem in our kingdom, not to mention doing yourself a favor—It’s now safe to fly above towns.  It is my pleasure to promote all battle mages to warrior mages, and all honorary battle mages to honorary warrior mages.  "
					evt.Add("ReputationIs", 100)
					evt.Subtract("QBits", 122)         -- "Reset all of the Dragon Towers at each town and return to Lord Stromgard in Castle Stromgard."
					evt.ForPlayer("All")
					evt.Add("Experience", 40000)
					evt.ForPlayer(0)
					if evt.Cmp("ClassIs", const.Class.BattleMage) then
						evt.Set("ClassIs", const.Class.WarriorMage)
						evt.Add("Awards", 30)         -- "Received Promotion to Warrior Mage"
					else
						evt.Add("Awards", 31)         -- "Received Promotion to Honorary Warrior Mage"
					end
					goto _24
				end
			end
		end
	end
::_11::
	evt.SetMessage(113)         -- "Hmm.  Not all of the towers have been reset.  They are easy to find, if a bit long in getting to.  The easiest is in Whitecap to the west of us."
	do return end
::_24::
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Warrior Mage"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Warrior Mage"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Warrior Mage"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Warrior Mage"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.BattleMage) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 30)         -- "Received Promotion to Warrior Mage"
	else
		evt.Add("Awards", 31)         -- "Received Promotion to Honorary Warrior Mage"
	end
	evt.SetNPCTopic{NPC = 15, Index = 1, Event = 94}         -- "Erik Von Stromgard" : "Warrior Mages"
end

-- "Warrior Mages"
evt.global[94] = function()
	evt.SetMessage(116)         -- "Welcome, warrior mages!  You may warm yourself by my hearth any time!"
end

-- "Winter"
evt.global[95] = function()
	evt.SetMessage(117)         -- "I like it up here.  It’s as though I can watch the world turn from up high and all alone.  Serene.  Untouchable.  Almost…Prophetic.  I can see the clouds churn and travel, break apart and mix together.  I can predict the weather almost perfectly.  <Smiling> Right now, I predict more snow."
end

-- "Winter"
evt.global[96] = function()
	evt.SetMessage(118)         -- "So, Stromgard needs a miracle with the weather, eh?  All this time I thought he was the one responsible for making it snow continually.  I can break the enchantment on the weather easily, and if you hurry back to him, I’m sure you can claim responsibility."
	evt.Set("QBits", 228)         -- NPC
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 89}         -- "Erik Von Stromgard" : "Winter"
	evt.SetNPCTopic{NPC = 19, Index = 0, Event = 97}         -- "The Hermit on the Mountain" : "Winter"
end

-- "Winter"
evt.global[97] = function()
	evt.SetMessage(119)         -- "As grateful as I am for your company, I am, in fact, a hermit.  I'm sure you have plenty of important things to do and don't need to be cluttering up my house any longer."
end

-- "My Capture"
evt.global[98] = function()
	evt.SetMessage(135)         -- "Curses!  Foiled again!"
end

-- "Silvertongue's Refusal"
evt.global[101] = function()
	evt.SetMessage(177)         -- "Slicker Silvertongue refused my order?  This must be treason!  Still, I've known him so long, and he's never disobeyed an order before…perhaps he is suffering from delusions.  Yes, that's it.  He's been spending so much time investigating that horrible Baa cult that it's affected his mind– I even found one of their cloaks in his room.  Perhaps you can find a cure for him.  They must surely know what they've done to him!  I would start at their headquarters east of Castle Kriegspire.  Here, take the cloak– perhaps you can find some use for it."
	evt.Set("QBits", 200)         -- "Find a cure for Slicker Silvertongue in the Superior Temple of Baa east of Castle Kriegspire and return to Wilbur Humphrey with the good news."
	evt.Add("Inventory", 485)         -- "Cloak of Baa"
	evt.SetNPCTopic{NPC = 4, Index = 0, Event = 102}         -- "Wilbur Humphrey" : "Silvertongue's Cure"
end

-- "Silvertongue's Cure"
evt.global[102] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 502) then         -- "Letter from Zenofex"
		evt.SetMessage(178)         -- "Oh, my!  It appears that Slicker Silvertongue really is a traitor!  Who ever would have guessed it?  You've done a good thing, bringing this letter to me.  Take it to High Council immediately so we can be rid of this wicked traitor for once and for all!"
		evt.Subtract("QBits", 200)         -- "Find a cure for Slicker Silvertongue in the Superior Temple of Baa east of Castle Kriegspire and return to Wilbur Humphrey with the good news."
		evt.Set("QBits", 201)         -- "Bring the the letter detailing Silvertongue's treason to the High Council in Free Haven."
		return
	end
	if not evt.Cmp("Inventory", 485) then         -- "Cloak of Baa"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 485)         -- "Cloak of Baa"
	end
	evt.SetMessage(179)         -- "Please hurry in your quest to find Slicker Silvertongue's cure!  I am sure the poor man must be suffering horribly under their dreadful mind control spell!"
end

-- "Service to the Crown"
evt.global[103] = function()
	evt.SetMessage(18)         -- "I cannot thank you enough for uncovering that horrible traitor and his crimes against the throne.  I understand you are on a mission of some importance, so for Services Rendered to the Crown, it behooves me to offer you free use of the royal yacht for your travels.  It will take you as far as Hermit's Isle, if you need it to.  Once again, thank you!"
end

-- "Rules"
evt.global[104] = function()
	evt.SetMessage(180)         -- "Welcome to the Circus of the Sun!  We have a variety of games for your amusement.  You can take the prizes you win from the various games and trade them in here for either kegs of wine or golden pyramids.  You need at least 10 points to get a keg of wine, and 30 or more points will win you a golden pyramid.  In case you didn't know, each lodestone is worth 1 point, each harpy feather is worth 3 points, and each four leaf clover is worth 5 points.  "
end

-- "Prizes"
evt.global[105] = function()
	if evt.Cmp("TotalCircusPrize", 30) then
		evt.Set("MapVar70", 40)
		evt.Add("Inventory", 472)         -- "Golden Pyramid"
		evt.SetMessage(184)         -- "Congratulations!  You win a golden pyramid!  Good work– remember there are no limits on the prizes, so keep playing!"
	else
		if not evt.Cmp("TotalCircusPrize", 10) then
			evt.SetMessage(182)         -- "I'm sorry, but you don't have 10 points yet.  Why don't you try a few more games?"
			return
		end
		evt.Set("MapVar70", 20)
		evt.Add("Inventory", 473)         -- "Keg of Wine"
		evt.SetMessage(183)         -- "Congratulations!  You win a keg of wine!  There are no limits on the prizes here, so keep playing!"
	end
::_11::
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 470) then         -- "Lodestone"
		goto _20
	end
	evt.ForPlayer(1)
	if evt.Cmp("Inventory", 470) then         -- "Lodestone"
		goto _20
	end
	evt.ForPlayer(2)
	if evt.Cmp("Inventory", 470) then         -- "Lodestone"
		goto _20
	end
	evt.ForPlayer(3)
	if evt.Cmp("Inventory", 470) then         -- "Lodestone"
		goto _20
	end
::_24::
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		goto _33
	end
	evt.ForPlayer(1)
	if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		goto _33
	end
	evt.ForPlayer(2)
	if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		goto _33
	end
	evt.ForPlayer(3)
	if evt.Cmp("Inventory", 471) then         -- "Harpy Feather"
		goto _33
	end
::_37::
	evt.ForPlayer(0)
	if not evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
		evt.ForPlayer(1)
		if not evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
			evt.ForPlayer(2)
			if not evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
				evt.ForPlayer(3)
				if not evt.Cmp("Inventory", 477) then         -- "Four Leaf Clover"
					return
				end
			end
		end
	end
	evt.Subtract("Inventory", 477)         -- "Four Leaf Clover"
	evt.Subtract("MapVar70", 5)
	if not evt.Cmp("MapVar70", 11) then
		return
	end
	goto _37
::_20::
	evt.Subtract("Inventory", 470)         -- "Lodestone"
	evt.Subtract("MapVar70", 1)
	if not evt.Cmp("MapVar70", 11) then
		return
	end
	goto _11
::_33::
	evt.Subtract("Inventory", 471)         -- "Harpy Feather"
	evt.Subtract("MapVar70", 3)
	if not evt.Cmp("MapVar70", 11) then
		return
	end
	goto _24
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
	elseif evt.Cmp("CurrentMight", 150) then
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
	elseif evt.Cmp("CurrentMight", 100) then
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
	elseif evt.Cmp("CurrentMight", 75) then
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
	elseif evt.Cmp("CurrentMight", 50) then
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
	elseif evt.Cmp("CurrentEndurance", 150) then
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
	elseif evt.Cmp("CurrentEndurance", 100) then
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
	elseif evt.Cmp("CurrentEndurance", 75) then
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
	elseif evt.Cmp("CurrentEndurance", 50) then
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
	elseif evt.Cmp("CurrentSpeed", 150) then
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
	elseif evt.Cmp("CurrentSpeed", 100) then
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
	elseif evt.Cmp("CurrentSpeed", 75) then
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
	elseif evt.Cmp("CurrentSpeed", 50) then
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
	elseif evt.Cmp("CurrentAccuracy", 150) then
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
	elseif evt.Cmp("CurrentAccuracy", 100) then
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
	elseif evt.Cmp("CurrentAccuracy", 75) then
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
	elseif evt.Cmp("CurrentAccuracy", 50) then
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
	elseif evt.Cmp("CurrentLuck", 150) then
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
	elseif evt.Cmp("CurrentLuck", 100) then
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
	elseif evt.Cmp("CurrentLuck", 75) then
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
	elseif evt.Cmp("CurrentLuck", 50) then
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
	elseif evt.Cmp("CurrentIntellect", 150) then
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
	elseif evt.Cmp("CurrentIntellect", 100) then
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
	elseif evt.Cmp("CurrentIntellect", 75) then
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
	elseif evt.Cmp("CurrentIntellect", 50) then
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

-- "Gongs"
evt.global[113] = function()
	evt.Set("AutonotesBits", 98)         -- "Lawrence Aleman will buy temple gongs for 2000 gold each in Free Haven."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 462) then         -- "Temple Gong"
		evt.Subtract("Inventory", 462)         -- "Temple Gong"
		evt.Add("Gold", 2000)
		evt.SetMessage(191)         -- "This one's a little dirty, but I suppose it will do.  Here is the gold I promised you for it.  Thanks for your help!"
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 462) then         -- "Temple Gong"
			evt.Subtract("Inventory", 462)         -- "Temple Gong"
			evt.Add("Gold", 2000)
			evt.SetMessage(191)         -- "This one's a little dirty, but I suppose it will do.  Here is the gold I promised you for it.  Thanks for your help!"
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 462) then         -- "Temple Gong"
				evt.Subtract("Inventory", 462)         -- "Temple Gong"
				evt.Add("Gold", 2000)
				evt.SetMessage(191)         -- "This one's a little dirty, but I suppose it will do.  Here is the gold I promised you for it.  Thanks for your help!"
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 462) then         -- "Temple Gong"
					evt.Subtract("Inventory", 462)         -- "Temple Gong"
					evt.Add("Gold", 2000)
					evt.SetMessage(191)         -- "This one's a little dirty, but I suppose it will do.  Here is the gold I promised you for it.  Thanks for your help!"
				else
					evt.SetMessage(190)         -- "As part of the effort to rebuild the Temple here in Free Haven, I'm collecting temple gongs.  If you have any gongs, I'll pay you 2000 gold for each of them."
				end
			end
		end
	end
end

-- "Bones"
evt.global[114] = function()
	evt.Set("AutonotesBits", 99)         -- "Lon Miller will buy bones for 1000 gold each in Free Haven."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 465) then         -- "Bone"
		evt.Subtract("Inventory", 465)         -- "Bone"
		evt.Add("Gold", 1000)
		evt.Subtract("ReputationIs", 50)
		evt.SetMessage(193)         -- "Hmm...  A leg bone of a human?  This will do nicely.  This bone is certainly worth 1000 gold.  "
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 465) then         -- "Bone"
			evt.Subtract("Inventory", 465)         -- "Bone"
			evt.Add("Gold", 1000)
			evt.Subtract("ReputationIs", 50)
			evt.SetMessage(193)         -- "Hmm...  A leg bone of a human?  This will do nicely.  This bone is certainly worth 1000 gold.  "
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 465) then         -- "Bone"
				evt.Subtract("Inventory", 465)         -- "Bone"
				evt.Add("Gold", 1000)
				evt.Subtract("ReputationIs", 50)
				evt.SetMessage(193)         -- "Hmm...  A leg bone of a human?  This will do nicely.  This bone is certainly worth 1000 gold.  "
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 465) then         -- "Bone"
					evt.Subtract("Inventory", 465)         -- "Bone"
					evt.Add("Gold", 1000)
					evt.Subtract("ReputationIs", 50)
					evt.SetMessage(193)         -- "Hmm...  A leg bone of a human?  This will do nicely.  This bone is certainly worth 1000 gold.  "
				else
					evt.SetMessage(192)         -- "I'm looking for bones to use in my rituals.  I prefer bones from humans or humanoids, but I suppose I can make do with whatever you find.  I'm willing to pay up to 1000 gold for bones that I can use."
				end
			end
		end
	end
end

-- "Lodestones"
evt.global[115] = function()
	evt.Set("AutonotesBits", 100)         -- "Davis Carp will buy lodestones for 5 gold each in Free Haven."
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
	evt.Set("AutonotesBits", 101)         -- "Bonnie Rotterdam will buy feathers for 10 gold each in Free Haven."
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
	evt.Set("AutonotesBits", 102)         -- "Renee Blackburn will buy pyramids for 1000 gold each in Free Haven."
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
	evt.Set("AutonotesBits", 103)         -- "Nick Fenstar will buy kegs of wine for 300 gold each in Free Haven."
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

-- "Teeth"
evt.global[119] = function()
	evt.Set("AutonotesBits", 104)         -- "Sy Roth will buy teeth for 500 gold each in Free Haven."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 476) then         -- "Tooth"
		evt.Subtract("Inventory", 476)         -- "Tooth"
		evt.Add("Gold", 500)
		evt.SetMessage(397)         -- "I don't believe I have a tooth like this one yet, here's 500 gold."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 476) then         -- "Tooth"
			evt.Subtract("Inventory", 476)         -- "Tooth"
			evt.Add("Gold", 500)
			evt.SetMessage(397)         -- "I don't believe I have a tooth like this one yet, here's 500 gold."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 476) then         -- "Tooth"
				evt.Subtract("Inventory", 476)         -- "Tooth"
				evt.Add("Gold", 500)
				evt.SetMessage(397)         -- "I don't believe I have a tooth like this one yet, here's 500 gold."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 476) then         -- "Tooth"
					evt.Subtract("Inventory", 476)         -- "Tooth"
					evt.Add("Gold", 500)
					evt.SetMessage(397)         -- "I don't believe I have a tooth like this one yet, here's 500 gold."
				else
					evt.SetMessage(396)         -- "I have an incredible teeth collection, but I'm always looking for more.  If you find a tooth I don't have in my collection, I'll pay you 500 gold for it."
				end
			end
		end
	end
end

-- "Four Leaf Clovers"
evt.global[120] = function()
	evt.Set("AutonotesBits", 105)         -- "Geoff Southy will buy clovers for 25 gold each in Free Haven."
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

-- "Amber"
evt.global[121] = function()
	evt.Set("AutonotesBits", 106)         -- "Dillan Robinson will buy amber for 500 gold each in Free Haven."
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 482) then         -- "Amber"
		evt.Subtract("Inventory", 482)         -- "Amber"
		evt.Add("Gold", 500)
		evt.SetMessage(406)         -- "This will do nicely!  Thank you for the amber, here is the 500 gold I promised you."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 482) then         -- "Amber"
			evt.Subtract("Inventory", 482)         -- "Amber"
			evt.Add("Gold", 500)
			evt.SetMessage(406)         -- "This will do nicely!  Thank you for the amber, here is the 500 gold I promised you."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 482) then         -- "Amber"
				evt.Subtract("Inventory", 482)         -- "Amber"
				evt.Add("Gold", 500)
				evt.SetMessage(406)         -- "This will do nicely!  Thank you for the amber, here is the 500 gold I promised you."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 482) then         -- "Amber"
					evt.Subtract("Inventory", 482)         -- "Amber"
					evt.Add("Gold", 500)
					evt.SetMessage(406)         -- "This will do nicely!  Thank you for the amber, here is the 500 gold I promised you."
				else
					evt.SetMessage(405)         -- "I've heard it's possible to find large chunks of amber in a series of caves north of Castle Ironfist.  I never have the time to leave Free Haven, but I'd love to get my hands on some of that amber.  I'll pay 500 gold for any piece of amber."
				end
			end
		end
	end
end

-- "Quest"
evt.global[122] = function()
	evt.SetMessage(375)         -- "As you may know, the last members of the Necromancers' Guild in Enroth fled to Castle Darkmoor after their defeat in the Succession War.  Who knows what foul magics they're concocting while we wait around.  I'm certain that the book containing the Ritual of Endless Night, known as the Book of Liches, has been moved into that castle.  If the book were to be destroyed, it would deal a severe blow to whatever evil plans they have.  I've tried a few times to get to the book, but the castle is too well defended.  If you are able to destroy the book, come back to me and I'll reward you personally."
	evt.Add("QBits", 204)         -- "Find and destroy the Book of Liches in Castle Darkmoor and return to Terry Ros in Darkmoor village."
	evt.SetNPCTopic{NPC = 330, Index = 0, Event = 123}         -- "Terry Ros" : "Quest"
end

-- "Quest"
evt.global[123] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 9) then         --  9, CD2, given when you destroy Lich book
		evt.SetMessage(377)         -- "Incredible!  I didn't expect you'd be able to do it.  Now that the Book of Liches is gone, the Necromancers' Guild here in Enroth will slowly fade away.  This is all thanks to you!  Here, take this as a reward and accept my gratitude as well."
		evt.Add("Awards", 60)         -- "Destroyed the Book of Liches"
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 100)
		evt.Subtract("QBits", 204)         -- "Find and destroy the Book of Liches in Castle Darkmoor and return to Terry Ros in Darkmoor village."
		evt.SetNPCTopic{NPC = 330, Index = 0, Event = 0}         -- "Terry Ros"
		evt.MoveNPC{NPC = 330, HouseId = 0}         -- "Terry Ros"
	else
		evt.SetMessage(376)         -- "There's no rush in destroying the book.  If you manage it, come back and talk to me.  I'm not sure it's even possible to get to the book and destroy it– there are far too many evil creatures in that castle."
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
	evt.Set("AutonotesBits", 107)         -- "Bandar Jahrom will trade gems for lamps in Abul's Desert Resort in Dragonsand."
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

-- "Jasper Rice"
evt.global[260] = function()
	evt.SetMessage(267)         -- "The best staff teacher in the land, Jasper Rice, lives up near Silver Cove.  You'll want to talk to him if you wish to continue your training with the staff."
end

-- "Guy Hampton"
evt.global[261] = function()
	evt.SetMessage(268)         -- "Guy Hampton in Blackshire taught me everything I know about the sword.  If you're looking to master the blade, he's the one to train under."
end

-- "Jules Miles"
evt.global[262] = function()
	evt.SetMessage(269)         -- "I'm only a novice when compared to someone like Jules Miles.  He lives near Castle Stone, and he can teach anyone how to improve their dagger skills."
end

-- "Avinril Smythers"
evt.global[263] = function()
	evt.SetMessage(270)         -- "Avinril Smythers mastered the axe before most of us were even born, but he doesn't train humans.  I'm sure if you could do something special for him, he might consider teaching a human how to really swing an axe.  He spends most of his time in the Haunt in the Mire of the Damned."
end

-- "Burton Rutherford"
evt.global[264] = function()
	evt.SetMessage(271)         -- "The best spearman in Enroth, Burton Rutherford, lives in Darkmoor.  I'm not sure why he picks such a remote place to call his home.  Maybe he doesn't like being bothered with students?"
end

-- "Desmond Weller"
evt.global[265] = function()
	evt.SetMessage(272)         -- "As good as Lord Stromgard is with a bow, he won't accept students.  To master the bow, you need to talk to Desmond Weller in Kriegspire."
end

-- "Errol Ostermann"
evt.global[266] = function()
	evt.SetMessage(273)         -- "If you want to master the mace, you need to speak to Errol Ostermann in Blackshire."
end

-- "Rexella"
evt.global[267] = function()
	evt.SetMessage(274)         -- "Very few people even know that these weapons exist.  The only other person I've ever seen using an ancient weapon is Rexella, but she was last living in Paradise Valley– I'm not sure she's even there anymore."
end

-- "Bronwyn Meck"
evt.global[268] = function()
	evt.SetMessage(275)         -- "No one can use a shield like Bronwyn Meck in Blackshire.  That's the person to talk to if you want to master the shield."
end

-- "Arlen Sailor"
evt.global[269] = function()
	evt.SetMessage(276)         -- "Arlen Sailor runs the best school in the art of wearing leather armor.  He normally holds his classes near Castle Stone."
end

-- "David Feather"
evt.global[270] = function()
	evt.SetMessage(277)         -- "Darkmoor is the home of David Feather, the only person I know of that can teach you to master your skill in chain armor."
end

-- "Forrest Suthers"
evt.global[271] = function()
	evt.SetMessage(278)         -- "Forrest Suthers, one of the head Paladins in Enroth, teaches how to master plate near Castle Temper."
end

-- "Jezebel"
evt.global[272] = function()
	evt.SetMessage(279)         -- "To master the fire skill you need to speak to Jezebel in Mist."
end

-- "Caao Salem"
evt.global[273] = function()
	evt.SetMessage(280)         -- "Caao Salem can show you even more tricks with air magic in Mist."
end

-- "Harper Collins"
evt.global[274] = function()
	evt.SetMessage(281)         -- "To gain mastery of the water skill you need to train under Harper Collins in Mist."
end

-- "Revee Botania"
evt.global[275] = function()
	evt.SetMessage(282)         -- "Revee Botania can train you to master the earth skill in Silver Cove."
end

-- "Bishop Inquisitorio"
evt.global[276] = function()
	evt.SetMessage(283)         -- "Spirit can be mastered with the help of Bishop Inquisitorio.  He lives right behind Castle Ironfist, you can't miss him."
end

-- "Thane Roper"
evt.global[277] = function()
	evt.SetMessage(284)         -- "Thane Roper can train you to master the mind skill in Silver Cove."
end

-- "Gilbert Hammer"
evt.global[278] = function()
	evt.SetMessage(285)         -- "If you're looking to master body magic, you need to talk to Gilbert Hammer in Silver Cove."
end

-- "Ki Lo Nee"
evt.global[279] = function()
	evt.SetMessage(286)         -- "Light magic is a difficult skill to learn, and the Great Teacher, Ki Lo Nee, can only be found somewhere around Castle Alamos."
end

-- "Su Lang Manchu"
evt.global[280] = function()
	evt.SetMessage(287)         -- "Su Lang Manchu was my teacher in dark magic.  He maintains a small house in a village in Paradise Valley."
end

-- "Hans Gifford"
evt.global[281] = function()
	evt.SetMessage(288)         -- "Hans Gifford can show you even more neat tricks in identifying items in Free Haven."
end

-- "Will Ottoman"
evt.global[282] = function()
	evt.SetMessage(289)         -- "The smoothest talking merchant I've ever seen is Will Ottoman in Silver Cove.  If you're looking to improve your merchant skill, he's the man to see."
end

-- "Ryan Treacle"
evt.global[283] = function()
	evt.SetMessage(290)         -- "If you think I'm good at repairing things, Ryan Treacle is the best around.  I'm sure he can be convinced to assist you in mastering the skill.  He lives up near Castle Stone the last I heard."
end

-- "Jason Traveler"
evt.global[284] = function()
	evt.SetMessage(291)         -- "Jason Traveler will coach you in the finest points of body-building.  He works in Free Haven, if you can handle his rigorous training."
end

-- "Norio Ariganaka"
evt.global[285] = function()
	evt.SetMessage(292)         -- "If mastering meditation is your goal, you'll need to see Norio Ariganaka in Mist."
end

-- "Macro Caligula"
evt.global[286] = function()
	evt.SetMessage(293)         -- "Perception can be mastered with help from Macro Caligula in Darkmoor."
end

-- "Jacques Kohl"
evt.global[287] = function()
	evt.SetMessage(294)         -- "Jacques Kohl is working with Lord Stromgard to develop the lord's eloquence and tact.  If he has time, perhaps he can assist you as well in mastering the art of diplomacy."
end

-- "Gabe Lester"
evt.global[288] = function()
	evt.SetMessage(295)         -- "The greatest trap disarmer, Gabe Lester, is currently teaching his craft near Castle Stone.  He's the person to talk to if you want to learn all the best tricks."
end

-- "John Tuck"
evt.global[289] = function()
	evt.SetMessage(296)         -- "John Tuck can teach you to master the learning skill.  I believe he's still living in Silver Cove."
end

-- "Quest"
evt.global[290] = function()
	evt.SetMessage(297)         -- "The King of the Dwarves, Snergle, usurped Rocklin for leadership of the dwarven clans.  Now Rocklin is in exile somewhere and Snergle is in charge.  Most dwarves don’t like Snergle and would like to see Rocklin back in power.  Unfortunately, Snergle has claimed both Rocklin’s caverns and the largest dwarven Iron Mine.  Snergle, fearing treachery near home, has removed me, the Dwarven Weaponmaster, from my position.  We need someone to get Snergle out of power by any means necessary.  I’d even consider training you humans how to use an axe like a true dwarf if you’ll help us."
	evt.Add("QBits", 124)         -- "Kill Snergle in Snergle's Caverns and return with his axe to Avinril Smythers at The Haunt tavern in the Mire of the Damned."
	evt.SetNPCTopic{NPC = 32, Index = 0, Event = 291}         -- "Avinril Smythers " : "Quest"
end

-- "Quest"
evt.global[291] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 498) then         -- "Snergle's Axe"
		evt.SetMessage(299)         -- "Oh, glorious day!  With Snergle’s passing, we can now search for Rocklin to put him back in power.  Eternal thanks to you for this, and dwarves everywhere owe you a debt of gratitude."
		evt.Add("Awards", 37)         -- "Killed Snergle"
		evt.Add("Experience", 20000)
		evt.ForPlayer("Current")
		evt.Set("QBits", 27)         -- 27 D05, Given when axe is returned (so door can't be opened)
		evt.Subtract("QBits", 124)         -- "Kill Snergle in Snergle's Caverns and return with his axe to Avinril Smythers at The Haunt tavern in the Mire of the Damned."
		evt.Add("ReputationIs", 100)
		evt.SetNPCTopic{NPC = 32, Index = 0, Event = 207}         -- "Avinril Smythers " : "Master Axe Fighting"
	else
		evt.SetMessage(298)         -- "I need proof that Snergle has been defeated.  I’m sorry, but I just can’t take your word for it.  Bring back some personal item of his, like his axe maybe."
	end
end

-- "Quest"
evt.global[292] = function()
	evt.SetMessage(300)         -- "The Mayor here in Mist is considering allowing the Fraternal Order of Silver to police the town in their battle against evil.  I know the Silver Helm Persecution Squads have murdered innocents in their misguided crusade against ‘evil,’ but there are no living witnesses to their atrocities.  I need you to storm their outpost to the south of here to find proof so that I can convince the mayor to ban them from Mist."
	evt.Add("QBits", 125)         -- "Storm the Silver Helm Outpost near Mist and return with evidence of their corruption to the Constable of Mist."
	evt.SetNPCTopic{NPC = 37, Index = 0, Event = 293}         -- "Charles D'Sorpigal" : "Quest"
end

-- "Quest"
evt.global[293] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 503) then         -- "Enemies List"
		evt.SetMessage(302)         -- "Just as I suspected!  I’m surprised the Mayor was number three on their enemies list.  I suppose he IS a tad incompetent, but he’s not a bad person.  Thanks again, please accept this gold and my gratitude as your reward."
		evt.Subtract("Inventory", 503)         -- "Enemies List"
		evt.Add("Awards", 38)         -- "Saved the Mayor of Mist"
		evt.Add("Experience", 15000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 3000)
		evt.Add("ReputationIs", 50)
		evt.Subtract("QBits", 125)         -- "Storm the Silver Helm Outpost near Mist and return with evidence of their corruption to the Constable of Mist."
		evt.SetNPCTopic{NPC = 37, Index = 0, Event = 0}         -- "Charles D'Sorpigal"
		evt.SetNPCTopic{NPC = 46, Index = 0, Event = 295}         -- "Bertrand Scrivner" : "Silver Helms"
	else
		evt.SetMessage(301)         -- "Keep searching– the lives of the mayor and myself could very well be in your hands.  We can’t take action against them without proof."
	end
end

-- "Silver Helms"
evt.global[294] = function()
	evt.SetMessage(303)         -- "I think I might just allow the Fraternal Order of Silver to police the areas around Mist.  Maybe they’d be able to hunt down all the evil people and leave this island a paradise."
end

-- "Silver Helms"
evt.global[295] = function()
	evt.SetMessage(304)         -- "I can’t believe those Silver Helms wanted to kill me!  I’ve never done anything wrong in my life!  Well, nothing more wrong than any other mayor at least.  Thank you again for stopping them."
end

-- "Quest"
evt.global[296] = function()
	evt.SetMessage(305)         -- "Could you do the Temple of Baa a favor?  It appears that my brethren left the old temple to the northwest of here in a little too much of a hurry, and a candelabra necessary for some of our rituals was left behind.  None of the Baa priests want to go back because they’re afraid of whatever curse has been placed on the temple.  If you were to bring back the candelabra to me, however, I could reward you in their place."
	evt.Add("QBits", 126)         -- "Retrieve the candelabra from the Abandoned Temple for Andover Potbello in New Sorpigal."
	evt.SetNPCTopic{NPC = 1, Index = 1, Event = 297}         -- "Andover Potbello" : "Quest"
end

-- "Quest"
evt.global[297] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 449) then         -- "Candelabra"
		evt.SetMessage(307)         -- "Excellent!  Baa be praised!  I see you were not frightened of the curse after all.  Here is your reward and thank you again for your assistance."
		evt.Subtract("Inventory", 449)         -- "Candelabra"
		evt.Add("Awards", 39)         -- "Retrieved the Baa Candelabra"
		evt.Add("Experience", 2000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("ReputationIs", 200)
		evt.Subtract("QBits", 126)         -- "Retrieve the candelabra from the Abandoned Temple for Andover Potbello in New Sorpigal."
		evt.SetNPCTopic{NPC = 1, Index = 1, Event = 0}         -- "Andover Potbello"
	else
		evt.SetMessage(306)         -- "Did the curse frighten you away as well?  I can understand.  Baa is patient, however.  Should you work up the courage to find the candelabra, I’m still prepared to compensate you for it."
	end
end

-- "Fraternal Order of Silver"
evt.global[298] = function()
	evt.SetMessage(308)         -- "Who would have thought that the evil I sought to fight all across Enroth would be found so close to my own home?  Gerrard Blackames was once my second in command.  Not long before he murdered me he began corresponding with the Temple of Baa, and they began to feed him targets for our Order.  I ended up being one of the targets, and Gerrard took control of the Order.  Now, the Silver Helms are as evil as the people they hunt.  I’m certain the Temple of Baa is responsible for the corruption of our Order.  At the same time, Gerrard’s brother, Marcus the Sorcerer, has been supplying the Silver Helms with high quality equipment.  The last I heard, Marcus was assisting someone in a forge on an island to the southeast."
end

-- "Melody"
evt.global[299] = function()
	if evt.Cmp("QBits", 127) then         -- NPC
		evt.SetMessage(310)         -- "Thank you for saving my niece.  Behind this wall is a secret area I’ve kept hidden from even Gerrard all these years.  You are welcome to take whatever you want; I’d prefer you have this than Gerrard."
	else
		evt.SetMessage(309)         -- "My niece, Melody, has been kidnapped from her home in Mist and locked in a Silver Helm outpost near there.  She’s one of the few people who know that I’ve been murdered.  I’m sure Gerrard has her locked up for that reason, but I believe he wants to force her into marriage to eliminate any opposition to his leadership of the Fraternal Order of Silver."
	end
end

-- "Ankh"
evt.global[300] = function()
	evt.SetMessage(311)         -- "Gerrard has an ankh inscribed with his name given to him by the priests of Baa.  I’m not sure exactly what the ankh is used for, but he may use it to identify himself as a friend of Baa."
	evt.SetNPCTopic{NPC = 14, Index = 2, Event = 362}         -- "Loretta Fleise" : "Ankh"
	evt.SetNPCTopic{NPC = 16, Index = 2, Event = 363}         -- "Anthony Stone" : "Ankh"
end

-- "Snergle's Key"
evt.global[301] = function()
	evt.SetMessage(312)         -- "You want to defeat Snergle, do you?  Well, he knows how he stands among most dwarves.  He’s holed up in Rocklin’s old caverns surrounded by a horde of his loyal dwarves.  If anything were to happen in there, he’d just immediately lock himself in his private room and let his followers handle it.  You’ll need a key to get into his room; there’s no way you’ll bash down a high quality dwarven door.  I was a steward for Rocklin– I know that room well and I happen to still have a key to it hidden on me.  Fortunately for you, I’m in this cell because of Snergle, and there’s nothing I’d rather see than his reign put to a quick end.  Here’s the key– think of it as payment for letting me out of this cell."
	evt.SetNPCTopic{NPC = 66, Index = 0, Event = 0}         -- "Ghim Hammond"
	evt.MoveNPC{NPC = 66, HouseId = 0}         -- "Ghim Hammond"
end

-- "Hidden Passages"
evt.global[302] = function()
	evt.SetMessage(313)         -- "Thank you for releasing me.  The only thing keeping the Silver Helms from killing me was the fact I’m a priest.  Frankly, I’m surprised they would show me any mercy at all.  Listen, I’ve heard some strange sounds coming from around here… I think there might be a hidden passage near here.  In any event, I should probably be leaving now; I don’t want to stay in this cell any longer."
	evt.MoveNPC{NPC = 74, HouseId = 0}         -- "Oliver Wendell"
end

-- "Quest"
evt.global[303] = function()
	evt.SetMessage(314)         -- "The Dragoons that have been plaguing the roads around here recently stole a harp of mine from one of my caravans.  I’m not strong enough to get it back from them, but I’m willing to pay someone capable to do it for me.  Find the harp and return it, and I’ll reward you."
	evt.Add("QBits", 128)         -- "Retrieve the harp from the Dragoon's Caverns south of Castle Ironfist and return it to Andrew Besper in Castle Ironfist."
	evt.SetNPCTopic{NPC = 77, Index = 0, Event = 304}         -- "Andrew Besper" : "Quest"
end

-- "Quest"
evt.global[304] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 479) then         -- "Harp"
		evt.SetMessage(316)         -- "My gratitude!  My wife loves this harp; I’m so glad you were able to recover it!  Here, take this as a reward.  I’ve heard rumors that the Dragoons were working with the Shadow Guild.  If that’s the case, I’m sure the Mayor of New Sorpigal would love to see proof of it.  Thank you again for your assistance."
		evt.Subtract("Inventory", 479)         -- "Harp"
		evt.Add("Awards", 40)         -- "Retrieved Andrew's Harp"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 50)
		evt.Subtract("QBits", 128)         -- "Retrieve the harp from the Dragoon's Caverns south of Castle Ironfist and return it to Andrew Besper in Castle Ironfist."
		evt.SetNPCTopic{NPC = 77, Index = 0, Event = 0}         -- "Andrew Besper"
	elseif evt.Cmp("Inventory", 478) then         -- "Flute"
		evt.SetMessage(317)         -- "Well, this IS a musical instrument, but it’s not a harp.  Let me explain the difference:  You brought back a flute.  A flute is a pipe with holes in it.  A harp has strings.  Does that help?  I’m sure they still have the harp and I will reward you well for its return."
	else
		evt.SetMessage(315)         -- "My harp is still lost, so the reward is still available for it.  I know the Dragoons base their operations to the south of here near the coast.  Please bring back my harp."
	end
end

-- "Quest"
evt.global[305] = function()
	evt.SetMessage(318)         -- "I have a few theories about the undead that I would very much like to prove.  What I really need is the remains of an undead creature, preferably a powerful one.  Actually, what I really need is the remains of the FIRST lich, Ethric the Mad.  I am a scholar, however, and don’t have the means to gain such a specimen.  I do have some money saved up, and I’d be willing to pay you well for Ethric’s remains."
	evt.Add("QBits", 129)         -- "Retrieve Ethric's skull from his tomb west of Free Haven for Gabriel Cartman in Free Haven."
	evt.SetNPCTopic{NPC = 171, Index = 0, Event = 306}         -- "Gabriel Cartman" : "Quest"
end

-- "Quest"
evt.global[306] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 464) then         -- "Ethric's Skull"
		evt.SetMessage(320)         -- "Good work! Now I can conclude my research.  If I can learn how the Ritual of Endless Night works, perhaps I can find a way to reverse the process.  Here is the reward I promised you. "
		evt.Subtract("Inventory", 464)         -- "Ethric's Skull"
		evt.Add("Awards", 41)         -- "Retrieved Ethric's Skull"
		evt.Add("Experience", 15000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 7500)
		evt.Subtract("QBits", 129)         -- "Retrieve Ethric's skull from his tomb west of Free Haven for Gabriel Cartman in Free Haven."
		evt.SetNPCTopic{NPC = 171, Index = 0, Event = 0}         -- "Gabriel Cartman"
		evt.MoveNPC{NPC = 171, HouseId = 0}         -- "Gabriel Cartman"
	else
		evt.SetMessage(319)         -- "I am well aware of the difficulty of the task, believe me.  Take your time but at the least, do the job properly. "
	end
end

-- "Quest"
evt.global[308] = function()
	evt.SetMessage(321)         -- "Our town is periodically plagued by giant spiders.  I’m pretty sure that if the spider queen were killed, the rest of the spiders would go away.  Currently, I’m offering a reward to the person that can kill the spider queen."
	evt.Add("QBits", 130)         -- "Kill the Queen of the Spiders in the Abandoned Temple in New Sorpigal and return with her heart to Buford T. Allman in New Sorpigal."
	evt.SetNPCTopic{NPC = 207, Index = 0, Event = 309}         -- "Buford T. Allman" : "Quest"
end

-- "Quest"
evt.global[309] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 481) then         -- "Spider Queen's Heart"
		evt.SetMessage(323)         -- "What a gruesome trophy!  This heart proves you’ve defeated the wicked spider queen.  Hopefully now the spiders won’t plague New Sorpigal anymore.  Here is the reward I promised."
		evt.Subtract("Inventory", 481)         -- "Spider Queen's Heart"
		evt.Add("Awards", 42)         -- "Killed the Spider Queen"
		evt.Add("Experience", 3000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("QBits", 130)         -- "Kill the Queen of the Spiders in the Abandoned Temple in New Sorpigal and return with her heart to Buford T. Allman in New Sorpigal."
		evt.SetNPCTopic{NPC = 207, Index = 0, Event = 0}         -- "Buford T. Allman"
	else
		evt.SetMessage(322)         -- "No one has returned with proof that they’ve killed the spider queen, so the reward is still available."
	end
end

-- "Quest"
evt.global[310] = function()
	evt.SetMessage(324)         -- "Cedric Druthers and his Celestial Order have taken over the Monolith, an ancient place sacred to druids.  Their dark rituals are corrupting the Monolith and they need to be stopped– whatever altar they use as the center of their ceremonies needs to be defaced.  Do this for us and we will compensate you for your time and services."
	evt.Add("QBits", 131)         -- "Deface the altar in the Monolith west of Silver Cove and return to Eleanor Vanderbilt in Silver Cove."
	evt.SetNPCTopic{NPC = 267, Index = 0, Event = 311}         -- "Eleanor Vanderbilt" : "Quest"
end

-- "Quest"
evt.global[311] = function()
	if evt.Cmp("QBits", 23) then         -- 23 D13, Given when Altar is desecrated
		evt.SetMessage(326)         -- "Thank you for your help!  Please allow me to compensate you for your efforts.  We can rest more safely knowing that Cedric and his renegade druids are no longer polluting that sacred area. "
		evt.Subtract("QBits", 131)         -- "Deface the altar in the Monolith west of Silver Cove and return to Eleanor Vanderbilt in Silver Cove."
		evt.Add("ReputationIs", 50)
		evt.Add("Gold", 3000)
		evt.ForPlayer("All")
		evt.Add("Awards", 43)         -- "Saved the Monolith"
		evt.Add("Experience", 15000)
		evt.SetNPCTopic{NPC = 267, Index = 0, Event = 0}         -- "Eleanor Vanderbilt"
		evt.MoveNPC{NPC = 267, HouseId = 0}         -- "Eleanor Vanderbilt"
	else
		evt.SetMessage(325)         -- "I’m glad to see you again, but the Celestial Order is still in the Monolith."
	end
end

-- "Cobra Eggs"
evt.global[312] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 474) then         -- "Cobra Egg"
		evt.Subtract("Inventory", 474)         -- "Cobra Egg"
		evt.Add("Gold", 300)
		evt.SetMessage(328)         -- "Excellent specimen!  I should be able to hatch this in no time and help my flagging business.  Here is my payment for this wonderful egg.  I’ll buy any more cobra eggs you have as long as they are in demand."
	else
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 474) then         -- "Cobra Egg"
			evt.Subtract("Inventory", 474)         -- "Cobra Egg"
			evt.Add("Gold", 300)
			evt.SetMessage(328)         -- "Excellent specimen!  I should be able to hatch this in no time and help my flagging business.  Here is my payment for this wonderful egg.  I’ll buy any more cobra eggs you have as long as they are in demand."
		else
			evt.ForPlayer(2)
			if evt.Cmp("Inventory", 474) then         -- "Cobra Egg"
				evt.Subtract("Inventory", 474)         -- "Cobra Egg"
				evt.Add("Gold", 300)
				evt.SetMessage(328)         -- "Excellent specimen!  I should be able to hatch this in no time and help my flagging business.  Here is my payment for this wonderful egg.  I’ll buy any more cobra eggs you have as long as they are in demand."
			else
				evt.ForPlayer(3)
				if evt.Cmp("Inventory", 474) then         -- "Cobra Egg"
					evt.Subtract("Inventory", 474)         -- "Cobra Egg"
					evt.Add("Gold", 300)
					evt.SetMessage(328)         -- "Excellent specimen!  I should be able to hatch this in no time and help my flagging business.  Here is my payment for this wonderful egg.  I’ll buy any more cobra eggs you have as long as they are in demand."
				else
					evt.SetMessage(327)         -- "I am a collector of rare and exotic creatures, and I make a living by selling some of these creatures as pets.  Currently, cobras are in great demand, and I don’t have many cobras left to sell.  Therefore, I’m willing to pay handsomely for any cobra eggs you might have.  Remember, if you find any cobra eggs, I’ll give you the best prices."
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

-- "Quest"
evt.global[315] = function()
	evt.SetMessage(332)         -- "Near here is a temple dedicated to the Order of the Fist.  I once belonged to that order, but recently they uncovered a powerful evil crystal.  They hope to use the crystal as a bargaining chip to be accepted into the Temple of Baa.  I don’t want to see the crystal fall into Baa’s hands– it must be destroyed.  Please infiltrate the temple and destroy the crystal."
	evt.Add("QBits", 134)         -- "Destroy the crystal in the Temple of the Fist and return to Winston Schezar in Bootleg Bay."
	evt.SetNPCTopic{NPC = 290, Index = 0, Event = 316}         -- "Winston Schezar" : "Quest"
end

-- "Quest"
evt.global[316] = function()
	if evt.Cmp("QBits", 21) then         -- 21 T2, Given when evil crystal is destroyed
		evt.SetMessage(334)         -- "Good work!  I’m glad you made it in time.  I don’t like to think about what Baa would have done with that crystal.  You have done all of Enroth a great service."
		evt.Subtract("QBits", 134)         -- "Destroy the crystal in the Temple of the Fist and return to Winston Schezar in Bootleg Bay."
		evt.Add("Gold", 3000)
		evt.Add("ReputationIs", 50)
		evt.ForPlayer("All")
		evt.Add("Awards", 45)         -- "Destroyed the Wicked Crystal"
		evt.Add("Experience", 10000)
		evt.SetNPCTopic{NPC = 290, Index = 0, Event = 0}         -- "Winston Schezar"
		evt.MoveNPC{NPC = 290, HouseId = 0}         -- "Winston Schezar"
	else
		evt.SetMessage(333)         -- "You must hurry and destroy the crystal before Baa claims it.  I’m not sure how long it will take, so time is of the essence."
	end
end

-- "Quest"
evt.global[317] = function()
	evt.SetMessage(335)         -- "My husband, Emmanuel, went to Star Island a few weeks ago with a few friends hoping to find some treasure.  I haven’t seen him since, and I’m worried about him.  I don’t dare go to the island; it’s rumored to be the home of medusas!  If you could find him and bring him home, I would be very grateful."
	evt.Add("QBits", 136)         -- "Rescue Emmanuel from the Temple of the Snake near Blackshire and return him to Joanne Cravitz in Blackshire."
	evt.SetNPCTopic{NPC = 118, Index = 0, Event = 318}         -- "Joanne Cravitz" : "Quest"
end

-- "Quest"
evt.global[318] = function()
	if evt.Cmp("NPCs", 108) then         -- "Emmanuel Cravitz"
		evt.SetMessage(337)         -- "Oh, thank you for bringing Emmanuel back to me!  Nothing in this world means as much to me as him!  Please take this as a reward.  I know it’s not much, but you deserve it for bringing him back to me."
		evt.Subtract("NPCs", 108)         -- "Emmanuel Cravitz"
		evt.Subtract("QBits", 136)         -- "Rescue Emmanuel from the Temple of the Snake near Blackshire and return him to Joanne Cravitz in Blackshire."
		evt.Add("Gold", 500)
		evt.ForPlayer("All")
		evt.Add("Awards", 46)         -- "Rescued Emmanuel"
		evt.Add("Experience", 20000)
		evt.MoveNPC{NPC = 108, HouseId = 254}         -- "Emmanuel Cravitz" -> "House"
		evt.SetNPCTopic{NPC = 108, Index = 0, Event = 0}         -- "Emmanuel Cravitz"
		evt.SetNPCTopic{NPC = 118, Index = 0, Event = 0}         -- "Joanne Cravitz"
	else
		evt.SetMessage(336)         -- "No luck?  He must be in grave danger if you did not find him.  If you do happen to find him, please bring him back here.  I’ll be waiting for him."
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

-- "Blackshire"
evt.global[321] = function()
	evt.SetMessage(340)         -- "Could you help me get out of here?  I need to get back to my wife in Blackshire."
	evt.Set("NPCs", 108)         -- "Emmanuel Cravitz"
end

-- "Quest"
evt.global[322] = function()
	evt.SetMessage(341)         -- "An explorer friend of mine recently uncovered a powerful artifact, Mordred, in his travels.  He wanted to sell it to me, and shipped it here for me to decide if I wanted it.  Unfortunately, raiders attacked the caravan it was on and stole the artifact.  They were last seen headed to an area west of Castle Temper; I’m sure they must have some sort of base there.  If you bring back Mordred for me, I’ll give you a cut of what I’m paying my friend for it."
	evt.Add("QBits", 137)         -- "Find the lost artifact in the Dragoons' Keep near Castle Temper and return it to Zoltan Phelps in Free Haven."
	evt.SetNPCTopic{NPC = 76, Index = 0, Event = 323}         -- "Zoltan Phelps" : "Quest"
end

-- "Quest"
evt.global[323] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 400) then         -- "Mordred"
		evt.SetMessage(343)         -- "So this is the legendary Mordred, eh?  Interesting, I was expecting something much grander.  I don’t think I want it, actually.  Why don’t you keep it, and I’ll deal with my friend on the cost."
		evt.Add("Awards", 47)         -- "Found Zoltan's Artifact"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 30000)
		evt.Add("ReputationIs", 100)
		evt.Subtract("QBits", 137)         -- "Find the lost artifact in the Dragoons' Keep near Castle Temper and return it to Zoltan Phelps in Free Haven."
		evt.SetNPCTopic{NPC = 76, Index = 0, Event = 0}         -- "Zoltan Phelps"
		evt.MoveNPC{NPC = 76, HouseId = 0}         -- "Zoltan Phelps"
	else
		evt.SetMessage(342)         -- "Hello again.  No one has found Mordred yet, so our deal is still good.  I’ll give you part of the selling price for the artifact if you return it."
	end
end

-- "Quest"
evt.global[324] = function()
	evt.SetMessage(344)         -- "Members of the Shadow Guild have moved down south recently, and have been trying to exert their influence over merchants in the area.  I refused them access to our town, so they kidnapped Sharry Carnegie, an old healer loved by the townspeople, in an attempt to ‘convince’ me to let them operate here.  I can’t believe that their extortion has moved so far south, I thought I was safe from that down here.  Please rescue Sharry– I can offer you some money as a reward, and I’m sure the townsfolk would appreciate her return."
	evt.Add("QBits", 138)         -- "Rescue Sharry from the Shadow Guild Hideout and return with her to Frank Fairchild in New Sorpigal."
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 325}         -- "Frank Fairchild" : "Quest"
end

-- "Quest"
evt.global[325] = function()
	if evt.Cmp("NPCs", 193) then         -- "Sharry Carnegie"
		evt.SetMessage(346)         -- "Thank you so much for saving Sharry!  I can’t tell you how much this means to both New Sorpigal and myself.  You have our gratitude forever."
		evt.Subtract("NPCs", 193)         -- "Sharry Carnegie"
		evt.Subtract("QBits", 138)         -- "Rescue Sharry from the Shadow Guild Hideout and return with her to Frank Fairchild in New Sorpigal."
		evt.Add("Gold", 2000)
		evt.ForPlayer("All")
		evt.Add("Awards", 48)         -- "Rescued Sharry"
		evt.Add("Experience", 10000)
		evt.SetNPCTopic{NPC = 3, Index = 0, Event = 0}         -- "Frank Fairchild"
	else
		evt.SetMessage(345)         -- "Have you found Sharry yet?  No?  I’m sure she’s wherever the Shadow Guild is hiding out.  Find them and you’ll find her."
	end
end

-- "Shadow Guild"
evt.global[326] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 504) then         -- "Orders from the Shadow Guild"
		evt.SetMessage(347)         -- "Interesting.  The Dragoons were hired by the Shadow Guild.  I’m certain Anthony Stone will want to hear about this.  I’ll present this letter when I see him next. Thank you for this.  I’m sure he will want to take action against the Shadow Guild now that we have some proof of their deeds."
		evt.Subtract("Inventory", 504)         -- "Orders from the Shadow Guild"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Add("ReputationIs", 50)
		evt.SetNPCTopic{NPC = 3, Index = 1, Event = 0}         -- "Frank Fairchild"
	else
		evt.SetMessage(399)         -- "I'm so tired of the Shadow Guild, but I don't have any substantial proof of their activities.  I'd love to have something I could show to Anthony Stone proving the Shadow Guild is up to no good down here."
	end
end

-- "New Sorpigal"
evt.global[327] = function()
	evt.SetMessage(348)         -- "Thank you for rescuing me from these horrible ruffians!  I’d like to go back home to New Sorpigal now."
	evt.Set("NPCs", 193)         -- "Sharry Carnegie"
end

-- "Quest"
evt.global[328] = function()
	evt.SetMessage(349)         -- "Oh dear, can you help me?  My daughter Angela is missing!  I think she may have wandered into the abandoned temple near town, and if she did she could be in terrible danger– who knows what kind of horrible things are lurking in that cursed place!  Please find her and bring her back to me."
	evt.Add("QBits", 139)         -- "Rescue Angela from the Abandoned Temple and return her to Violet Dawson in New Sorpigal."
	evt.SetNPCTopic{NPC = 154, Index = 0, Event = 329}         -- "Violet Dawson" : "Quest"
end

-- "Quest"
evt.global[329] = function()
	if evt.Cmp("NPCs", 195) then         -- "Angela Dawson"
		evt.SetMessage(351)         -- "She’s alive!  Thank you so much for finding Angela!  If I weren’t so happy to see her, she’d be in a lot of trouble.  Please take this as a reward for all you’ve done."
		evt.MoveNPC{NPC = 195, HouseId = 471}         -- "Angela Dawson" -> "House"
		evt.Subtract("NPCs", 195)         -- "Angela Dawson"
		evt.Subtract("QBits", 139)         -- "Rescue Angela from the Abandoned Temple and return her to Violet Dawson in New Sorpigal."
		evt.Add("Gold", 500)
		evt.Add("Food", 10)
		evt.ForPlayer("All")
		evt.Add("Awards", 49)         -- "Rescued Angela"
		evt.Add("Experience", 1000)
		evt.SetNPCTopic{NPC = 154, Index = 0, Event = 0}         -- "Violet Dawson"
		evt.SetNPCTopic{NPC = 195, Index = 0, Event = 0}         -- "Angela Dawson"
	else
		evt.SetMessage(350)         -- "You didn’t find poor Angela?  Something horrible must have happened to her!"
	end
end

-- "Help!"
evt.global[330] = function()
	evt.SetMessage(352)         -- "I think I'm lost…<sob>…I want to go home!"
	evt.Set("NPCs", 195)         -- "Angela Dawson"
end

-- "Quest"
evt.global[331] = function()
	evt.SetMessage(353)         -- "A good friend of mine, Sherell, went with a group of friends to the islands in Bootleg Bay to explore an old temple rumored to be there.  Her friends returned and said she was captured by cannibals on the island and taken to some ancient temple.  I’m sure she doesn’t have much time before they do something dreadful to her, please rescue her!"
	evt.Add("QBits", 140)         -- "Rescue Sherell from the cannibals on the islands east of Free Haven and return with her to Carlo Tormini in Free Haven."
	evt.SetNPCTopic{NPC = 200, Index = 0, Event = 332}         -- "Carlo Tormini" : "Quest"
end

-- "Quest"
evt.global[332] = function()
	if evt.Cmp("NPCs", 155) then         -- "Sherell Ivanaveh"
		evt.SetMessage(355)         -- "Wonderful!  She’s not dead after all!  Thank you for all your trouble.  I hope you will accept this token of my gratitude."
		evt.MoveNPC{NPC = 155, HouseId = 297}         -- "Sherell Ivanaveh" -> "House"
		evt.Subtract("NPCs", 155)         -- "Sherell Ivanaveh"
		evt.Subtract("QBits", 140)         -- "Rescue Sherell from the cannibals on the islands east of Free Haven and return with her to Carlo Tormini in Free Haven."
		evt.SetNPCTopic{NPC = 155, Index = 0, Event = 0}         -- "Sherell Ivanaveh"
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 50)         -- "Rescued Sherell"
		evt.SetNPCTopic{NPC = 200, Index = 0, Event = 0}         -- "Carlo Tormini"
	else
		evt.SetMessage(354)         -- "Oh dear!  You haven’t found her yet?  Surely she must have been sacrificed or eaten or something.  Please try to find her, or at least avenge her death."
	end
end

-- "Escape"
evt.global[333] = function()
	evt.SetMessage(356)         -- "Hello!  Please, oh please, get me out of this temple.  I don’t want to die!"
	evt.Set("NPCs", 155)         -- "Sherell Ivanaveh"
end

-- "Quest"
evt.global[334] = function()
	evt.SetMessage(357)         -- "Our town is under a terrible curse, though most people don’t believe it.  Under a full moon, we all change into werewolves.  Although none of us are truly evil, we don’t really know what sort of horrible things we do as werewolves.  We can’t approach our lord, Acton Spindler about the problem because he doesn’t realize that we are the werewolves.  Please find a way to turn us back to normal!"
	evt.Add("QBits", 141)         -- "Destroy the Werewolf's altar in the Lair of the Wolf and return to Maria Trepan in Blackshire."
	evt.SetNPCTopic{NPC = 212, Index = 0, Event = 335}         -- "Maria Trepan" : "Quest"
end

-- "Quest"
evt.global[335] = function()
	if evt.Cmp("QBits", 17) then         -- 17 D17, given when wolf altar is destroyed.
		evt.SetMessage(359)         -- "Thank you!  We can now sleep at night without worrying about what kinds of foul acts we will commit as monsters!  It’s a tragedy that our lord was a werewolf himself; he’ll be sorely missed.  Please accept this for your help, and for believing in us."
		evt.Subtract("QBits", 141)         -- "Destroy the Werewolf's altar in the Lair of the Wolf and return to Maria Trepan in Blackshire."
		evt.Add("Gold", 4000)
		evt.Add("ReputationIs", 100)
		evt.ForPlayer("All")
		evt.Add("Experience", 20000)
		evt.Add("Awards", 52)         -- "Killed the Werewolf Leader"
		evt.SetNPCTopic{NPC = 212, Index = 0, Event = 0}         -- "Maria Trepan"
		evt.MoveNPC{NPC = 212, HouseId = 0}         -- "Maria Trepan"
	else
		evt.SetMessage(358)         -- "Is there no hope for us?  Please promise me you’ll keep searching for a way to reverse the curse and turn us back to normal people."
	end
end

-- "Werewolves"
evt.global[338] = function()
	evt.SetMessage(362)         -- "I was a guest at Lord Spindler's manor when it was attacked by a band of werewolves that had tunneled in from the mountains.  I fought my way back down the tunnels they had created hoping to escape.  Eventually, they cornered me and I was killed at this very spot. "
end

-- "Pearl of Purity"
evt.global[339] = function()
	evt.SetMessage(363)         -- "In my flight, I managed to hide the Pearl of Purity in these caverns.  The pearl will both protect you from the curse of the werewolves, and will also destroy the Altar of the Wolf if the pearl touches it.  That should free everyone afflicted by the curse these werewolves have caused.  The pearl is at the end of the cavern across from this one.  Please do me one favor, return the Pearl to Wilbur Humphrey.  He is the lord in charge of paladins and the pearl belongs with him."
	evt.Add("QBits", 142)         -- NPC
	evt.SetNPCTopic{NPC = 4, Index = 2, Event = 342}         -- "Wilbur Humphrey" : "Pearl of Purity"
end

-- "Quest"
evt.global[340] = function()
	evt.SetMessage(364)         -- "The werewolf leader possesses the Pearl of Putrescence, the opposite of my Pearl of Purity.  With this pearl, he has been able to cause the curse.  I was never able to kill him in my retreat.  I will be able to rest in peace knowing that he has been defeated."
	evt.Add("QBits", 143)         -- "Find the Pearl of Putrescence in the Lair of the Wolf and bring it to the Ghost of Balthasar, also in the Lair of the Wolf."
	evt.SetNPCTopic{NPC = 295, Index = 2, Event = 341}         -- "Ghost of Balthasar" : "Quest"
end

-- "Quest"
evt.global[341] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 458) then         -- "Pearl of Putrescence"
		evt.SetMessage(366)         -- "Thank you for defeating the werewolf leader.  I wish that I had been strong enough to stop this from happening.  Please accept my thanks for allowing my spirit to move on.  I will take the pearl away so that it may no longer cause any harm to the people of Enroth."
		evt.Subtract("Inventory", 458)         -- "Pearl of Putrescence"
		evt.Add("Experience", 5000)
		evt.Add("Awards", 51)         -- "Broke the Blackshire Curse"
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 143)         -- "Find the Pearl of Putrescence in the Lair of the Wolf and bring it to the Ghost of Balthasar, also in the Lair of the Wolf."
		evt.Add("QBits", 35)         -- 35 D17 Brought back Black Pearl and Ghost will no longer show up.
		evt.SetNPCTopic{NPC = 295, Index = 2, Event = 0}         -- "Ghost of Balthasar"
	else
		evt.SetMessage(365)         -- "The werewolf leader possesses the Pearl of Putrescence, the opposite of my Pearl of Purity.  With this pearl, he has been able to cause the curse.  I was never able to kill him in my retreat.  I will be able to rest in peace knowing that he has been defeated."
	end
end

-- "Pearl of Purity"
evt.global[342] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 459) then         -- "Pearl of Purity"
		evt.SetMessage(367)         -- "What’s this?  You have the Pearl of Purity?  I thought Balthasar– oh, he’s dead is he?  I’ll keep it for now, then, as per his last wishes.  Thank you on behalf of both him and me."
		evt.Subtract("Inventory", 459)         -- "Pearl of Purity"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 142)         -- NPC
		evt.SetNPCTopic{NPC = 4, Index = 2, Event = 0}         -- "Wilbur Humphrey"
	else
		evt.SetMessage(400)         -- "One of the few remaining Paladin artifacts left is the Pearl of Purity.  Balthasar was in possession of the pearl the last I heard.  He was visiting Lord Spindler in Blackshire, but I haven't heard anything from him in months."
	end
end

-- "Humans"
evt.global[347] = function()
	evt.SetMessage(372)         -- "You no goblin!  You leave!  We take castle to watch over humans!  You no more kill us!"
end

-- "Greeting"
evt.global[348] = function()
	evt.SetMessage(373)         -- "Good work removing the goblins from this keep.  We have the situation mostly under control now, though your help is always appreciated."
end

-- "Advice"
evt.global[349] = function()
	evt.SetMessage(374)         -- "Hello again, my pupils!  I'm afraid there is nothing more I can teach you– your experiences must guide you from this point on.  I know nothing more than you do about the devils that destroyed Sweet Water, but I know who you need to ask.  The Oracle in Free Haven will know what to do to rid Enroth of the terrible devils.  Unfortunately, you will need the approval of the six High Council members, each of which represents one of the lords of Enroth.  You must do whatever necessary to speak to the Oracle in Free Haven and rid Enroth of the devils."
end

-- "Quest"
evt.global[351] = function()
	evt.SetMessage(379)         -- "I’ve discovered a way to reverse the effects of time and make myself young again.  This requires a complex magical ritual, which I’ve worked out.  The problem is that I need to place magical statuettes on various pedestals. The tiger statuette goes on the pedestal near Sweet Water, the bear statuette in Kriegspire, the eagle statuette in Dragonsand, the wolf statuette in the Mire of the Damned, and the dragon statuette in Bootleg Bay.  The distances are too far for me to travel in my old age, and in the meantime I need to prepare the ritual itself.  There is no way I can do all of this on my own; I need your help.  The statuettes are in the chest outside my house.  Place them on the pedestals and return to me.  Even if the ritual is a failure, I'll pay you for your efforts."
	evt.Add("QBits", 219)         -- "Place the statuettes in Sweet Water, Kriegspire, Dragonsand, Mire of the Damned, and Bootleg Bay and return to Twillen in Blackshire."
	evt.Add("QBits", 220)         -- NPC
	evt.SetNPCTopic{NPC = 87, Index = 0, Event = 352}         -- "Twillen" : "Quest"
end

-- "Quest"
evt.global[352] = function()
	evt.SetMessage(407)         -- "I have almost prepared the entire ritual– all that is left is to place the statuettes."
end

-- "Archibald"
evt.global[353] = function()
	evt.SetMessage(378)         -- "I was once the court magician, long ago.  That all ended when Archibald… disrupted… things.  Archibald had acquired some skill as a sorcerer and had knowledge of spells beyond that taught to magicians today, and therefore didn’t require my services.  Since then, I’ve lived in this little shack, conducted my own research, and have grown old."
end

-- "Quest"
evt.global[354] = function()
	evt.SetMessage(408)         -- "Good work!  I have my youth again, thanks to you– have you ever thought about assisting me full-time?  I could certainly use reliable help.  I've managed to collect a variety of trinkets over the years, so please help yourself to a few of these in the chest outside as payment for your services.  I need to clean up a few things here, but I think I'll head back to Castle Ironfist and see if there's an opening for a court magician."
	evt.Subtract("QBits", 219)         -- "Place the statuettes in Sweet Water, Kriegspire, Dragonsand, Mire of the Damned, and Bootleg Bay and return to Twillen in Blackshire."
	evt.Add("QBits", 221)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Experience", 75000)
	evt.Add("Awards", 56)         -- "Placed Twillen's statuettes"
	evt.SetNPCTopic{NPC = 41, Index = 0, Event = 0}         -- "Twillen"
	evt.MoveNPC{NPC = 41, HouseId = 0}         -- "Twillen"
end

-- "Quest"
evt.global[355] = function()
	evt.SetMessage(380)         -- "I was one of the mages studying at Kriegspire when the creatures there went completely out of control.  In my escape from the castle, I left a valuable item behind, a jeweled egg.  This egg is a family heirloom that goes back in my family as far as the Silence.  I have tried a few times to get it back, but the creatures there are too powerful for me.  I’d gladly trade a generous sum of money to get my egg back."
	evt.Add("QBits", 144)         -- "Retrieve the jewelled egg from Castle Kriegspire and return it to Emil Lime in Kriegspire village."
	evt.SetNPCTopic{NPC = 201, Index = 0, Event = 356}         -- "Emil Lime" : "Quest"
end

-- "Quest"
evt.global[356] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 480) then         -- "Jeweled Egg"
		evt.SetMessage(382)         -- "Thank you for returning this egg to me; it’s the most precious thing I have."
		evt.Subtract("Inventory", 480)         -- "Jeweled Egg"
		evt.Add("Awards", 55)         -- "Retrieved Emil's Egg"
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("ReputationIs", 100)
		evt.Add("Gold", 5000)
		evt.Subtract("QBits", 144)         -- "Retrieve the jewelled egg from Castle Kriegspire and return it to Emil Lime in Kriegspire village."
		evt.SetNPCTopic{NPC = 201, Index = 0, Event = 0}         -- "Emil Lime"
		evt.MoveNPC{NPC = 201, HouseId = 0}         -- "Emil Lime"
	else
		evt.SetMessage(381)         -- "Kriegspire is the castle inside the volcano.  We mages were forced to raise the earth around the castle to try and prevent the creatures from overrunning the surrounding towns.  Now they’re contained inside, and that’s where the egg is."
	end
end

-- "Quest"
evt.global[357] = function()
	evt.SetMessage(383)         -- "I am the Lord of Fire, an immortal earth spirit.  My power is drawn from below the earth.  The channels that I use have been blocked by doors warded with powerful magic in the north.  I need you to unward the doors so that I may awaken again.  Though the enchantments on them are powerful, amber will break the ward on the doors."
	evt.Add("QBits", 145)         -- "Unward the doors in the Hall of the Fire Lord and return to the Lord of Fire, also in the Hall of the Fire Lord."
	evt.SetNPCTopic{NPC = 298, Index = 0, Event = 360}         -- "Lord of Fire" : "Quest"
end

-- "Servants"
evt.global[358] = function()
	evt.SetMessage(384)         -- "If you get lost in the caverns, you may find assistance from my servants.  If you have a piece of amber, they will assume you are under my care and will teleport you back to me if you talk to them.  If you do not have any amber, they will drain with some of your life force as payment for teleporting you back up here.  Don’t worry, they rarely kill anyone."
end

-- "Creature"
evt.global[359] = function()
	evt.SetMessage(385)         -- "The doors became warded when a strange creature came to reside here.  I am not familiar with this type of being, and I’ve seen many types in my long time here in Enroth.  I do not know why it chose this place as its home, or why there is only one, but I would like to see it destroyed for the trouble it has caused me. "
end

-- "Quest"
evt.global[360] = function()
	if not evt.Cmp("QBits", 71) then         -- Walt
		evt.SetMessage(386)         -- "As patient as I am, I would like to see the channels I use to sustain me opened again.  Please do not fail."
	else
		evt.SetMessage(387)         -- "Thank you for your assistance.  I am grateful to you for returning my source of sustenance to me.  I need to recharge what little power I have left now that I am able to again."
		if not evt.Cmp("QBits", 359) then         -- NPC
			evt.Subtract("QBits", 145)         -- "Unward the doors in the Hall of the Fire Lord and return to the Lord of Fire, also in the Hall of the Fire Lord."
			evt.Add("QBits", 359)         -- NPC
			evt.ForPlayer("All")
			evt.Add("Awards", 57)         -- "Aided the Lord of Fire"
			evt.Add("Experience", 10000)
			evt.SetNPCTopic{NPC = 298, Index = 2, Event = 0}         -- "Lord of Fire"
		end
	end
end

-- "Ankh"
evt.global[362] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 448) then         -- "Ankh"
		evt.SetMessage(389)         -- "So, Sir John was murdered and the Silver Helms were bought off by the Temple of Baa?  That explains a great deal.  Good work on bringing this to me, but you’ll need to collect your reward from Anthony Stone."
		evt.Subtract("Inventory", 448)         -- "Ankh"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.SetNPCTopic{NPC = 16, Index = 2, Event = 364}         -- "Anthony Stone" : "Ankh"
		evt.SetNPCTopic{NPC = 14, Index = 2, Event = 0}         -- "Loretta Fleise"
	else
		evt.SetMessage(402)         -- "Recently, the Fraternal Order of Silver has been disrupting my business and my caravans.  I'm not sure why Sir John feels it necessary, but I'd like this to stop.  If you could convince him to leave me alone, I'm sure I could give you a portion of the money you would be saving me."
	end
end

-- "Ankh"
evt.global[363] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 448) then         -- "Ankh"
		evt.SetMessage(390)         -- "I should have known Baa was behind this, they seem to be behind everything.  Thank you for bringing this to me.  It answers the questions I had about the Fraternal Order of Silver."
		evt.Subtract("Inventory", 448)         -- "Ankh"
		evt.Add("Experience", 10000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.SetNPCTopic{NPC = 16, Index = 2, Event = 0}         -- "Anthony Stone"
		evt.SetNPCTopic{NPC = 14, Index = 2, Event = 0}         -- "Loretta Fleise"
	else
		evt.SetMessage(403)         -- "The Fraternal Order of Silver has begun more direct attacks on my legitimate, underworld associates.  I would appreciate it greatly if you could talk to Sir John and learn why he feels these actions are necessary."
	end
end

-- "Ankh"
evt.global[364] = function()
	evt.SetMessage(391)         -- "So Baa was behind the corruption of the Silver Helms and the murder of Sir John Silver?  What a tragedy for Sir John, rest his soul.  <blink> Loretta told you to collect the reward from me?  Greedy witch.  Here, your services should not go unrewarded."
	evt.Add("Gold", 5000)
	evt.SetNPCTopic{NPC = 16, Index = 2, Event = 0}         -- "Anthony Stone"
end

-- "Ceremony of the Sun"
evt.global[365] = function()
	evt.SetMessage(100)         -- "<Loretta Fleise contacts you via a telepathy spell> Welcome to the Ceremony of the Sun.  Stand ye in the circle of life and face the north while no shadows stretch before thee.  Meditate upon this truth:  “Money is everything.  I have no truer a friend than money…” <grinning> Just kidding.  Now, close your eyes, and meditate as you stand at the center of the world and time for just this one, sublime moment… <long, silent pause>  Open your eyes.  I hereby promote all druids to great druids and all non-druids to honorary druids. <Loretta fades away> "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Great Druid"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Great Druid"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Great Druid"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Great Druid"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Great Druid"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Great Druid"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 24)         -- "Received Promotion to Great Druid"
	else
		evt.Add("Awards", 25)         -- "Received Promotion to Honorary Great Druid"
	end
	evt.Add("ReputationIs", 50)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 118)         -- "Visit the Altar of the Sun in the circle of stones north of Silver Cove on an equinox or solstice (HINT:  March 20th is an equinox)."
	evt.Add("QBits", 173)         -- NPC
	evt.Add("Experience", 15000)
	evt.SetNPCTopic{NPC = 305, Index = 0, Event = 0}         -- "Loretta Fleise"
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 84}         -- "Loretta Fleise" : "Arch Druids"
end

-- "Ceremony of the Moon"
evt.global[366] = function()
	evt.SetMessage(102)         -- "<Loretta Fleise contacts you via a telepathy spell> Welcome to the Ceremony of the Moon.  Stand ye before the altar of the Moon facing south.  Close your eyes and meditate upon the Circle of Seasons and the Wheel of Life.  <long, silent pause>  Open your eyes, my friends.  I hereby promote all great druids to arch druids, and all honorary great druids to honorary arch druids.  <Loretta fades away> "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Arch Druid"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Arch Druid"
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Arch Druid"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Arch Druid"
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Arch Druid"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Arch Druid"
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 26)         -- "Received Promotion to Arch Druid"
	else
		evt.Add("Awards", 27)         -- "Received Promotion to Honorary Arch Druid"
	end
	evt.Add("ReputationIs", 100)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 119)         -- "Visit the Altar of the Moon in the Temple of the Moon at midnight of a full moon."
	evt.Add("QBits", 174)         -- NPC
	evt.Add("Experience", 40000)
	evt.SetNPCTopic{NPC = 306, Index = 0, Event = 0}         -- "Loretta Fleise"
	evt.SetNPCTopic{NPC = 14, Index = 1, Event = 86}         -- "Loretta Fleise" : "Arch Druids"
end

-- "Admission to the Oracle"
evt.global[375] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
		evt.SetMessage(123)         -- "Osric has instructed me to vote for your cause.  I give you my full support in his name."
	else
		evt.SetMessage(122)         -- "I am only allowed to vote on the issues that Lord Temper specifically instructs me on.  Garner his approval, and on his recommendation, I will vote in your favor."
	end
end

-- "Admission to the Oracle"
evt.global[376] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
		evt.SetMessage(125)         -- "You have my vote, in Loretta’s name, to visit the Oracle."
	else
		evt.SetMessage(124)         -- "Lady Fleise could not possibly care less about your problems and I will therefore not even consider your request."
	end
end

-- "Admission to the Oracle"
evt.global[377] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
		evt.SetMessage(127)         -- "Anthony backs your request to visit the Oracle, and I give you my vote on his behalf."
	else
		evt.SetMessage(126)         -- "Lord Stone has not authorized me to vote in your behalf.  You will need to take this matter up with him."
	end
end

-- "Admission to the Oracle"
evt.global[378] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 7) then         -- "Ended Winter"
		evt.SetMessage(129)         -- "I vote for you to visit the Oracle, as instructed by Eric von Stromgard himself."
	else
		evt.SetMessage(128)         -- "I cannot vote on matters that do not concern Lord Stromgard.  Until you have his backing, I cannot vote for you."
	end
end

-- "Admission to the Oracle"
evt.global[379] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
		evt.SetMessage(131)         -- "Albert has given me permission to back your request to visit the Oracle. "
	else
		evt.SetMessage(130)         -- "Until I receive favorable word from Lord Newton on your request, I cannot give you my backing."
	end
end

-- "Admission to the Oracle"
evt.global[380] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 502) then         -- "Letter from Zenofex"
		if not evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
			evt.SetMessage(132)         -- "You have not adequately demonstrated your loyalty to my liege, Lord Humphrey, and I cannot give you my vote."
		else
			evt.SetMessage(133)         -- "As long as I am a member of this council, you will not be permitted to visit the Oracle.  I am not convinced of your sincerity and will not grant your request."
			if not evt.Cmp("QBits", 200) then         -- "Find a cure for Slicker Silvertongue in the Superior Temple of Baa east of Castle Kriegspire and return to Wilbur Humphrey with the good news."
				evt.SetNPCTopic{NPC = 4, Index = 0, Event = 101}         -- "Wilbur Humphrey" : "Silvertongue's Refusal"
			end
		end
		return
	end
	evt.MoveNPC{NPC = 304, HouseId = 0}         -- "Slicker Silvertongue"
	evt.Subtract("Inventory", 502)         -- "Letter from Zenofex"
	evt.SetMessage(134)         -- "Do not believe you have won!  Soon the Iron Fist will lose its grip, and I will be your king!  And you can be sure I won't forget you…"
	evt.Add("ReputationIs", 200)
	evt.Set("QBits", 168)         -- NPC
	evt.ForPlayer("All")
	evt.Add("Awards", 32)         -- "Exposed the Traitor on the High Council"
	evt.Subtract("QBits", 190)         -- Quest item bits for seer
	evt.Subtract("QBits", 201)         -- "Bring the the letter detailing Silvertongue's treason to the High Council in Free Haven."
	if evt.Cmp("QBits", 200) then         -- "Find a cure for Slicker Silvertongue in the Superior Temple of Baa east of Castle Kriegspire and return to Wilbur Humphrey with the good news."
		evt.Subtract("QBits", 200)         -- "Find a cure for Slicker Silvertongue in the Superior Temple of Baa east of Castle Kriegspire and return to Wilbur Humphrey with the good news."
	end
	evt.SetNPCTopic{NPC = 4, Index = 0, Event = 103}         -- "Wilbur Humphrey" : "Service to the Crown"
	if evt.Cmp("Awards", 2) then         -- "Retrieved Lord Kilburn's Shield"
		if evt.Cmp("Awards", 3) then         -- "Retrieved the Hourglass of Time"
			if evt.Cmp("Awards", 4) then         -- "Destroyed the Devil's Post"
				if evt.Cmp("Awards", 5) then         -- "Captured the Prince of Thieves"
					if evt.Cmp("Awards", 6) then         -- "Fixed the Stable Prices"
						if evt.Cmp("Awards", 7) then         -- "Ended Winter"
							evt.Set("QBits", 167)         -- NPC
						end
					end
				end
			end
		end
	end
end

-- "Quest"
evt.global[398] = function()
	evt.SetMessage(174)         -- "Followers of Baa and a band of cutpurses have been raiding Mist from the islands to the north.  They come to Mist through a teleporter on the northwest of the island.  I'll activate the teleporter so that you can get to their islands and get rid of them.  I'm sure they have all the things they've stolen on those islands, and you can get back from their teleporter.   "
	evt.Add("QBits", 301)         -- NPC
	evt.SetNPCTopic{NPC = 165, Index = 0, Event = 0}         -- "Kathleen Mester"
end

-- "Empty Barrel"
evt.global[410] = function()
	evt.StatusText(410)         -- "The barrel is empty"
end

-- "Barrel of Red liquid"
evt.global[411] = function()
	evt.StatusText(411)         -- "+1 Might permanent"
	evt.Add("BaseMight", 1)
	evt.Set("AutonotesBits", 117)         -- "Red liquid grants Might."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Yellow liquid"
evt.global[412] = function()
	evt.StatusText(412)         -- "+1 Accuracy permanent"
	evt.Add("BaseAccuracy", 1)
	evt.Set("AutonotesBits", 121)         -- "Yellow liquid grants Accuracy."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Blue liquid"
evt.global[413] = function()
	evt.StatusText(413)         -- "+1 Personality permanent"
	evt.Add("BasePersonality", 1)
	evt.Set("AutonotesBits", 119)         -- "Blue liquid grants Personality."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Orange liquid"
evt.global[414] = function()
	evt.StatusText(414)         -- "+1 Intellect permanent"
	evt.Add("BaseIntellect", 1)
	evt.Set("AutonotesBits", 118)         -- "Orange liquid grants Intellect."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Green liquid"
evt.global[415] = function()
	evt.StatusText(415)         -- "+1 Endurance permanent"
	evt.Add("BaseEndurance", 1)
	evt.Set("AutonotesBits", 120)         -- "Green liquid grants Endurance."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of Purple liquid"
evt.global[416] = function()
	evt.StatusText(416)         -- "+1 Speed permanent"
	evt.Add("BaseSpeed", 1)
	evt.Set("AutonotesBits", 122)         -- "Purple liquid grants Speed."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Barrel of White liquid"
evt.global[417] = function()
	evt.StatusText(417)         -- "+1 Luck permanent"
	evt.Add("BaseLuck", 1)
	evt.Set("AutonotesBits", 123)         -- "White liquid grants Luck."
	evt.ChangeEvent(410)         -- "Empty Barrel"
end

-- "Empty Cauldron"
evt.global[418] = function()
	evt.StatusText(418)         -- "The cauldron is empty"
end

-- "Steaming Brew"
evt.global[419] = function()
	evt.StatusText(419)         -- "+1 Fire resistance permanent"
	evt.Add("FireResistance", 1)
	evt.Set("AutonotesBits", 124)         -- "Steaming liquid grants Fire Resistance."
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Frosty Brew"
evt.global[420] = function()
	evt.StatusText(420)         -- "+1 Cold resistance permanent"
	evt.Add("ColdResistance", 1)
	evt.Set("AutonotesBits", 125)         -- "Frosty liquid grants Cold Resistance."
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Shocking Brew"
evt.global[421] = function()
	evt.StatusText(421)         -- "+1 Electric resistance permanent"
	evt.Add("ElecResistance", 1)
	evt.Set("AutonotesBits", 126)         -- "Shocking liquid grants Electricity Resistance."
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Noxious Brew"
evt.global[422] = function()
	evt.StatusText(422)         -- "+1 Poison resistance permanent"
	evt.Add("PoisonResistance", 1)
	evt.Set("AutonotesBits", 127)         -- "Noxious liquid grants Poison Resistance."
	evt.ChangeEvent(418)         -- "Empty Cauldron"
end

-- "Magical Brew"
evt.global[423] = function()
	evt.StatusText(423)         -- "+1 Magic resistance permanent"
	evt.Add("MagicResistance", 1)
	evt.Set("AutonotesBits", 128)         -- "Magical liquid grants Magic Resistance."
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
		evt.GiveItem{Strength = 1, Type = const.ItemType.Dagger, Id = 0}
		goto _12
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedYellow", 0)
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Dagger, Id = 0}
		goto _12
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedRed", 0)
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Dagger, Id = 0}
::_12::
	evt.ChangeEvent(436)         -- "Trash Heap"
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

