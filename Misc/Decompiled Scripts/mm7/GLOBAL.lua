Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events


-- "Castle Harmondale"
evt.CanShowTopic[1] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[1] = function()
	evt.SetMessage(6)         -- "If you win, you'll be in charge of one of the most scenic areas in all Erathia!  Harmondale is just outside of the Tularean Forest, right on the edge of the Elf-Human border.  And I'm sure you'll love the castle.  It's a bit of a fixer-upper, but it's quite roomy and has excellent ventilation.  It breaks my heart to part with this property, but I feel that the time has come for me to give something back to the people."
end

-- "The Hunt"
evt.CanShowTopic[2] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[2] = function()
	evt.SetMessage(5)         -- "Isn't this hunt exciting?  I really am grateful you came to my little event, and I hope you have fun, even if you don't win.  I think it's great that everyone is competing in a spirit of good sportsmanship and camaraderie."
end

-- "Congratulations"
evt.CanShowTopic[3] = function()
	return evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[3] = function()
	evt.SetMessage(7)         -- "Congratulations!  You are the new Lords of Harmondale!  Isn't it thrilling?  You can't imagine how good it feels for me to give this property away to you!  All of the benefits and rewards, and of course, the responsibilities of governing the town of Harmondale are now yours.  (Lord Markham produces a deed and contract) Just sign here...And here... And if I could just get your initials here... Yes!  Well, that's that!  You're all set.  And once again, congratulations!!!"
	evt.SetNPCTopic{NPC = 1, Index = 2, Event = 4}         -- "Lord Markham" : "Your ship…"
	evt.Subtract("NPCs", 3)         -- "Margaret the Docent"
	evt.Set("QBits", 17)         -- No more docent babble
	evt.ForPlayer("All")
	evt.Add("Experience", 1000)
	evt.Add("Awards", 2)         -- "Won the Scavenger Hunt on Emerald Island"
	evt.SetNPCGroupNews{NPCGroup = 1, NPCNews = 5}         -- "" : "Congratulations!"
end

-- "Your ship…"
evt.global[4] = function()
	evt.SetMessage(8)         -- "Well, the ship that will take you to your fiefdom awaits you in the harbor.  My entourage and I will be taking a different ship out.  Just board whenever you're ready."
	evt.Add("QBits", 15)         -- Able to use boat to get off Emerald Island
	evt.SetNPCTopic{NPC = 11, Index = 0, Event = 33}         -- "William Darvees" : "Cast off!"
	evt.SetNPCTopic{NPC = 1, Index = 2, Event = 0}         -- "Lord Markham"
	evt.SetNPCGreeting{NPC = 1, Greeting = 0}         -- "Lord Markham" : ""
end

-- "Rules of the Hunt"
evt.global[5] = function()
	evt.SetMessage(25)         -- "Good afternoon.  My duty is to verify that you have all the items necessary to win the contest.  You are required to bring a red potion, a longbow, a floor tile from the Temple of the Moon, a wealthy hat, seashell, and an instrument to me.  You can bring them in any order, just show them to me one at a time so that I may verify them."
end

-- "What do you have?"
evt.global[6] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 8) then         -- Brought red potion
		if evt.Cmp("Inventory", 222) then         -- "Cure Wounds"
			evt.Subtract("QBits", 1)         -- "Return a red potion to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 8)         -- Brought red potion
			evt.Subtract("Inventory", 222)         -- "Cure Wounds"
			evt.SetMessage(31)         -- "What took you so long?  Almost every group has turned in a red potion by now.  This is the easiest item in the hunt to manage, but better late than never.  I will mark it off your list."
			return
		end
	end
	if not evt.Cmp("QBits", 9) then         -- Brought seashell
		if evt.Cmp("Inventory", 635) then         -- "Seashell"
			evt.Subtract("QBits", 2)         -- "Return a seashell to the Judge on Emerald Island."
			evt.Subtract("Inventory", 635)         -- "Seashell"
			evt.Add("QBits", 9)         -- Brought seashell
			evt.Add("Experience", 500)
			evt.SetMessage(30)         -- "A beautiful shell, much like the ones that Sally sells.  This certainly came from Emerald Island- I shall mark the shell off your list."
			return
		end
	end
	if not evt.Cmp("QBits", 10) then         -- Brought longbow
		if evt.Cmp("Inventory", 43) then         -- "Longbow"
			evt.SetMessage(29)         -- "This longbow certainly qualifies for the hunt.  Good work, I shall mark that off your list."
			evt.Subtract("Inventory", 43)         -- "Longbow"
			evt.Subtract("QBits", 3)         -- "Return a longbow to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 10)         -- Brought longbow
			return
		end
	end
	if not evt.Cmp("QBits", 11) then         -- Brought tile
		if evt.Cmp("Inventory", 636) then         -- "Floor Tile (w/ moon insignia)"
			evt.SetMessage(28)         -- "Adventurers indeed!  I didn't expect anyone to bring back a tile so quickly.  This is certainly a tile from the Temple, however so I shall mark the tile off your list."
			evt.Subtract("Inventory", 636)         -- "Floor Tile (w/ moon insignia)"
			evt.Subtract("QBits", 4)         -- "Return a floor tile to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 11)         -- Brought tile
			return
		end
	end
	if not evt.Cmp("QBits", 12) then         -- Brought instrument
		if evt.Cmp("Inventory", 632) then         -- "Lute"
			evt.SetMessage(27)         -- "Hmm, a fine lute this is.  Let me mark off the instrument from your list."
			evt.Subtract("Inventory", 632)         -- "Lute"
			evt.Subtract("QBits", 5)         -- "Return a musical instrument to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 12)         -- Brought instrument
			return
		end
	end
	if evt.Cmp("QBits", 13) then         -- Brought hat
		if not evt.Cmp("QBits", 1) then         -- "Return a red potion to the Judge on Emerald Island."
			if not evt.Cmp("QBits", 2) then         -- "Return a seashell to the Judge on Emerald Island."
				if not evt.Cmp("QBits", 3) then         -- "Return a longbow to the Judge on Emerald Island."
					if not evt.Cmp("QBits", 4) then         -- "Return a floor tile to the Judge on Emerald Island."
						if not evt.Cmp("QBits", 5) then         -- "Return a musical instrument to the Judge on Emerald Island."
							if not evt.Cmp("QBits", 6) then         -- "Return a wealthy hat to the Judge on Emerald Island."
								evt.Add("QBits", 7)         -- Finished Scavenger Hunt
								evt.SetMessage(32)         -- "Well, that's all six items.  You're the winner of the contest!  I suggest you talk to Lord Markham for the details on gaining your fiefdom, my work is done here."
								evt.SetNPCTopic{NPC = 2, Index = 0, Event = 0}         -- "Thomas the Judge"
								evt.SetNPCTopic{NPC = 2, Index = 1, Event = 0}         -- "Thomas the Judge"
								evt.MoveNPC{NPC = 2, HouseId = 0}         -- "Thomas the Judge"
								evt.SetNPCTopic{NPC = 1, Index = 1, Event = 0}         -- "Lord Markham"
								evt.SetNPCGreeting{NPC = 6, Greeting = 9}         -- "Mr. Malwick" : "I don't believe we have anything to talk about."
								return
							end
						end
					end
				end
			end
		end
	elseif evt.Cmp("Inventory", 631) then         -- "Wealthy Hat"
		evt.SetMessage(26)         -- "I see you have found a wealthy hat.  I shall mark this off your list accordingly, good work."
		evt.Subtract("Inventory", 631)         -- "Wealthy Hat"
		evt.Subtract("QBits", 6)         -- "Return a wealthy hat to the Judge on Emerald Island."
		evt.Add("Experience", 500)
		evt.Add("QBits", 13)         -- Brought hat
		return
	end
	evt.SetMessage(33)         -- "I'm sorry, but nothing you have is necessary for the hunt.  I don't mean to belittle what you have, but I'm not looking for any of it."
end

-- "Greetings"
evt.global[7] = function()
	evt.SetMessage(2)         -- "Welcome to Emerald Island!  I'll be your docent for your stay on the island.  It is my duty to see that you understand the rules of both the island and the contest.  For the duration of your stay on Emerald Island please refrain from gross violations of civilized behavior."
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 8}         -- "Margaret the Docent" : "Emerald Island"
end

-- "Emerald Island"
evt.global[8] = function()
	evt.SetMessage(1)         --[[ "Emerald Island is southeast of Erathia, and far away from pirates and other ruffians.  It would be ideal, if not for the constant swarms of dragonflies that infest the island.  Fortunately, the large number of armed and skilled people this contest has attracted should thin their numbers a bit.

Lord Markham has supplemented the normally sparse village with a weapon, armor, and alchemist shop for your convenience during the contest.  A temple and basic magical guilds are also available.  I would suggest making sure that you are completely ready before you start off on the contest." ]]
end

-- "Contest"
evt.CanShowTopic[9] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[9] = function()
	evt.SetMessage(4)         -- "The rules of the contest are simple:  The first person to return with the items is the winner.  All you need to do is collect a wealthy hat, a red potion, a longbow, a seashell, a musical instrument, and a floor tile from the Temple of the Moon and bring them to the judge to win."
end

-- "Scavenger Hunt"
evt.global[10] = function()
	evt.SetMessage(34)         -- "Are you contestants in Lord Markham's Scavenger Hunt?  How neat!  I'm here to provide entertainment to Lord Markham's entourage, the contestants, and to anyone else that would like to hear a song."
end

-- "Instruments"
evt.global[11] = function()
	evt.SetMessage(35)         -- "I own a few instruments, but I only brought my lute with me.  Its old and not quite as well kept as some of the others, but I didn't want one of my good instruments stolen by pirates or damaged from exposure to the humid, salty air."
end

-- "Lute"
evt.global[12] = function()
	evt.ForPlayer("All")
	evt.SetMessage(36)         -- "You say you need an instrument for the Scavenger Hunt?  I suppose you could buy my lute, but I've had it for such a long time.  I guess I'd part with it for 500 gold.  Interested?"
	evt.SetNPCTopic{NPC = 4, Index = 2, Event = 13}         -- "Ailyssa the Bard" : "Buy Lute for 500 gold"
end

evt.CanShowTopic[12] = function()
	if not evt.Cmp("Inventory", 632) then         -- "Lute"
		return not evt.Cmp("QBits", 12)         -- Brought instrument
	end
	return false
end

-- "Buy Lute for 500 gold"
evt.global[13] = function()
	if evt.Cmp("Gold", 500) then
		evt.Subtract("Gold", 500)
		evt.Add("Inventory", 632)         -- "Lute"
		evt.SetMessage(37)         -- "Well, promise to at least take care of it and not use it for firewood.  I suppose I'll have to make do without an instrument for the rest of this trip.  Maybe I should tell stories instead of sing until I get back home."
		evt.SetNPCItem{NPC = 4, Item = 632, On = false}         -- "Ailyssa the Bard" : "Lute"
		evt.SetNPCTopic{NPC = 4, Index = 2, Event = 0}         -- "Ailyssa the Bard"
		evt.SetNPCTopic{NPC = 4, Index = 1, Event = 0}         -- "Ailyssa the Bard"
	else
		evt.SetMessage(38)         -- "It would help if you had the 500 gold pieces.  Please don't try and cheat me out of my instrument."
	end
end

-- "Ocean"
evt.global[14] = function()
	evt.SetMessage(12)         -- "I love being out on this side of the island, the view of the ocean is much better than from town, don't you agree?"
end

-- "Seashell"
evt.global[15] = function()
	evt.SetMessage(13)         -- "I have some nice sea shells for sale, shells that you can only find on Emerald Island.  Can I sell one to you?  They're only a hundred gold pieces each."
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 16}         -- "Sally" : "Buy Seashell for 100 gold"
end

-- "Buy Seashell for 100 gold"
evt.global[16] = function()
	if evt.Cmp("Gold", 100) then
		evt.Subtract("Gold", 100)
		evt.Add("Inventory", 635)         -- "Seashell"
		evt.SetMessage(14)         -- "Here you go, I hope it reminds you of your trip to Emerald Island."
	else
		evt.SetMessage(15)         -- "I really can't go any less than 100 gold; I need to make a living, too."
	end
end

-- "Harmondale"
evt.CanShowTopic[17] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[17] = function()
	evt.SetMessage(10)         -- "We have reason to believe that whoever is in charge of Harmondale in the next few months will have an unprecedented opportunity to shape the future.  That is why I am here today--to make sure the shape of the future is pleasing to my associates.  I'm sure you understand."
end

-- "Proposal"
evt.CanShowTopic[18] = function()
	if not evt.Cmp("QBits", 7) then         -- Finished Scavenger Hunt
		return not evt.Cmp("Inventory", 145)         -- "Alacorn Wand of Fireballs"
	end
	return false
end

evt.global[18] = function()
	evt.SetMessage(9)         -- "Allow me to introduce myself.  My name is Mr. Malwick.  I represent a group of, shall we say, ""investors in the future"".  I have been observing you since you arrived on this island, and I believe your values and goals have much in common with ours.  I am empowered to grant you a fireball wand to help you win the Hunt today, in exchange for a favor in the future.  What do you say?"
	evt.SetNPCTopic{NPC = 6, Index = 0, Event = 19}         -- "Mr. Malwick" : "Accept Wand"
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 20}         -- "Mr. Malwick" : "Decline Wand"
end

-- "Accept Wand"
evt.CanShowTopic[19] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[19] = function()
	evt.SetMessage(11)         -- "Excellent.  Sometime in the future, I or a representative of my group will call on you to return the favor.  I hope you won't disappoint us.  Here is your fireball wand.  We should not be seen talking again, the others might get suspicious."
	evt.Set("QBits", 14)         -- Accepted Fireball wand from Malwick
	evt.Set("AutonotesBits", 1)         -- ""
	evt.Add("Inventory", 145)         -- "Alacorn Wand of Fireballs"
	evt.SetNPCItem{NPC = 6, Item = 145, On = false}         -- "Mr. Malwick" : "Alacorn Wand of Fireballs"
	evt.SetNPCTopic{NPC = 6, Index = 0, Event = 17}         -- "Mr. Malwick" : "Harmondale"
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 0}         -- "Mr. Malwick"
	evt.SetNPCGreeting{NPC = 6, Greeting = 7}         -- "Mr. Malwick" : "Did you need something, stranger?  <whisper> Get away from me, are you trying to get caught on purpose?!"
end

-- "Decline Wand"
evt.CanShowTopic[20] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[20] = function()
	evt.SetMessage(3)         -- "I respect your decision.  I am, however, a patient man, and will offer you this chance until a winner in the contest is proclaimed."
	evt.SetNPCTopic{NPC = 6, Index = 0, Event = 17}         -- "Mr. Malwick" : "Harmondale"
	evt.SetNPCTopic{NPC = 6, Index = 1, Event = 18}         -- "Mr. Malwick" : "Proposal"
end

-- "Your hat, please…"
evt.CanShowTopic[21] = function()
	return evt.Cmp("Inventory", 631)         -- "Wealthy Hat"
end

evt.global[21] = function()
	evt.SetMessage(16)         -- "I see you have a fine hat, there.  How about a deal:  You give me your hat, and we let you keep your lives?"
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 23}         -- "Sal Sharktooth" : "Give Hat to Sal"
	evt.SetNPCTopic{NPC = 7, Index = 1, Event = 24}         -- "Sal Sharktooth" : "Keep Hat"
end

-- "Temple"
evt.global[22] = function()
	evt.SetMessage(19)         -- "This Temple is a pretty nasty place.  You should probably watch your back around here-- you never know what might want to kill you."
end

-- "Give Hat to Sal"
evt.global[23] = function()
	evt.SetMessage(17)         -- "Thanks for the hat, friend!"
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 631)         -- "Wealthy Hat"
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 0}         -- "Sal Sharktooth"
	evt.SetNPCTopic{NPC = 7, Index = 1, Event = 25}         -- "Sal Sharktooth" : "I warned you…"
	evt.SetNPCItem{NPC = 7, Item = 631, On = true}         -- "Sal Sharktooth" : "Wealthy Hat"
end

-- "Keep Hat"
evt.global[24] = function()
	evt.SetMessage(18)         -- "You should have accepted my offer…"
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 0}         -- "Sal Sharktooth"
	evt.SetNPCTopic{NPC = 7, Index = 1, Event = 0}         -- "Sal Sharktooth"
	evt.SetMonGroupBit{NPCGroup = 3, Bit = const.MonsterBits.Hostile, On = true}         -- ""
end

-- "I warned you…"
evt.global[25] = function()
	evt.SetMessage(20)         -- "You should have listened to me; I warned you this was a nasty place.  Now get out of here before I decide to take something else from you."
end

-- "Very well, then…"
evt.CanShowTopic[26] = function()
	return evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[26] = function()
	evt.SetMessage(21)         -- "I take this to mean you don't wish to accept my proposal.  I believe our business is concluded."
	evt.SetNPCTopic{NPC = 6, Index = 2, Event = 0}         -- "Mr. Malwick"
end

-- "Potion for a Hat?"
evt.CanShowTopic[27] = function()
	return evt.Cmp("Inventory", 222)         -- "Cure Wounds"
end

evt.global[27] = function()
	evt.SetMessage(39)         -- "Hello there!  I suppose you're part of the contest?  Good to hear.  We were wondering if you would want to trade a red potion, assuming you have one, for a hat.  We could help each other along a little."
	evt.SetNPCTopic{NPC = 8, Index = 0, Event = 30}         -- "Brent Filiant" : "Trade Potion for Hat"
	evt.SetNPCTopic{NPC = 8, Index = 1, Event = 31}         -- "Brent Filiant" : "Keep Potion"
	evt.SetNPCTopic{NPC = 8, Index = 2, Event = 0}         -- "Brent Filiant"
end

-- "Brigands"
evt.global[28] = function()
	evt.SetMessage(22)         -- "The toughest band of contestants have apparently hid out in the Temple of the Moon.  I think they might be wanting to ambush any group that tries to go there."
end

-- "Blue Potions"
evt.global[29] = function()
	evt.SetMessage(23)         -- "I know how to make a blue potion, but not red ones…Just about any blue herb will do.  Just mix it with an empty bottle and voila!  Instant blue potion.  I guess that making a red potion is similar, but I'm not sure.  They say mixing potions improperly can have really bad effects."
end

-- "Trade Potion for Hat"
evt.global[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 222) then         -- "Cure Wounds"
		evt.SetMessage(40)         -- "Wonderful!  Here's the hat and I'll take the potion.  Thanks so much, now we're almost finished with our list."
		evt.ForPlayer("Current")
		evt.Subtract("Inventory", 222)         -- "Cure Wounds"
		evt.Add("Inventory", 631)         -- "Wealthy Hat"
		evt.SetNPCItem{NPC = 8, Item = 631, On = false}         -- "Brent Filiant" : "Wealthy Hat"
		evt.SetNPCItem{NPC = 8, Item = 222, On = true}         -- "Brent Filiant" : "Cure Wounds"
		evt.SetNPCGroupNews{NPCGroup = 2, NPCNews = 6}         -- "" : "Thanks for trading with us!"
	else
		evt.SetMessage(42)         -- "Is this some sort of trick?  You don't even have a red potion.  You don't think I'll just give you the hat, do you?"
	end
	evt.SetNPCTopic{NPC = 8, Index = 0, Event = 0}         -- "Brent Filiant"
	evt.SetNPCTopic{NPC = 8, Index = 1, Event = 28}         -- "Brent Filiant" : "Brigands"
	evt.SetNPCTopic{NPC = 8, Index = 2, Event = 29}         -- "Brent Filiant" : "Blue Potions"
end

-- "Keep Potion"
evt.global[31] = function()
	evt.SetMessage(41)         -- "What's the matter?  You don't like to work with others?  Fine then, you'll get no help from us."
	evt.SetNPCTopic{NPC = 8, Index = 0, Event = 27}         -- "Brent Filiant" : "Potion for a Hat?"
	evt.SetNPCTopic{NPC = 8, Index = 1, Event = 28}         -- "Brent Filiant" : "Brigands"
	evt.SetNPCTopic{NPC = 8, Index = 2, Event = 29}         -- "Brent Filiant" : "Blue Potions"
end

-- "Boat Travel"
evt.global[32] = function()
	evt.SetMessage(24)         -- "Sorry mates, this vessel's moored until a winner has been declared in the contest."
end

-- "Cast off!"
evt.global[33] = function()
	evt.SetMessage(43)         -- "Good job, mates!  We'll be heading off for Harmondale right now.  Congratulations."
	evt.Subtract("QBits", 16)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
	evt.SetNPCTopic{NPC = 1, Index = 3, Event = 0}         -- "Lord Markham"
	evt.Add("History1", 0)
	evt.Add("History2", 0)
	evt.MoveNPC{NPC = 1, HouseId = 275}         -- "Lord Markham" -> "Lord Markham's Chamber"
	evt.SetNPCGreeting{NPC = 1, Greeting = 205}         -- "Lord Markham" : "Hmmph.  You don't actually expect me to act as though you really were a noble, do you?  Once a peasant, always a peasant, that's what my mother used to say.  Really, could you use the servant's entrance next time you stop by?  It really is embarrassing to have you dusty, mud spattered peasants coming in through the front door.  What will the neighbors think?"
	evt.Add("QBits", 136)         -- Party doesn't come back to Out01 temple anymore
	evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "pcout01 "}
	evt.MoveToMap{X = -17331, Y = 12547, Z = 465, Direction = 1024, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "Out02.odm"}
end

-- "Missing Contestants"
evt.global[34] = function()
	evt.SetMessage(44)         -- "Keep in mind I have a 1000 gold reward for the group to bring back information on the contestants that have disappeared."
	evt.SetNPCTopic{NPC = 1, Index = 3, Event = 35}         -- "Lord Markham" : "Missing Contestants"
	evt.Set("QBits", 16)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
end

-- "Missing Contestants"
evt.global[35] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 658) then         -- "Contestant's Shield"
		evt.SetMessage(46)         -- "There really is a dragon on the island?  I thought everyone was referring to the dragonflies everywhere.  I'll warn everyone to stay away from that cave so we don't lose anyone else."
		evt.Subtract("Inventory", 658)         -- "Contestant's Shield"
		evt.Add("Awards", 3)         -- "Found the missing contestants on Emerald Island"
		evt.Add("Experience", 1000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("Reputation", 5)
		evt.Subtract("QBits", 16)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
		evt.SetNPCTopic{NPC = 1, Index = 3, Event = 0}         -- "Lord Markham"
	else
		evt.SetMessage(45)         -- "No news on the missing people yet?"
	end
end

-- "Missing People"
evt.global[36] = function()
	evt.SetMessage(47)         -- "Hmm… I recall a few strangers poking around the entrance to the Dragon's Cave recently.  I didn't notice if they went inside, but I haven't seen them around since.  They must have realized how dangerous that place is and headed back to town."
end

-- "Abandoned Temple"
evt.global[37] = function()
	evt.SetMessage(48)         -- "The cave right behind my house is not the Abandoned Temple.  It belongs to Morcarack the Pitiless, the Dragon of Emerald Island.  He doesn't appreciate visitors, so I wouldn't advise going there.  The Abandoned Temple is buried in the hill south of my house.  You can get to it by entering the caves at the top of the hill."
end

-- "Dragonflies"
evt.global[38] = function()
	evt.SetMessage(49)         -- "Wild Dragonflies have infested the northwestern side of Emerald Island recently, making it dangerous to store things in our shed out there.  Dragonflies aren't terribly powerful, but they are fast and can even occasionally shoot fire at you.  Don't take them too lightly!"
end

-- "Dragon"
evt.global[39] = function()
	evt.SetMessage(50)         -- "The Dragon of Emerald Island lives in a cave in the northeast.  I wouldn't go there, though, he doesn't like visitors.  He spares our town so that we may pay him tribute, and in return he keeps pirates and undesirables out."
end

-- "Dragon Cave"
evt.global[40] = function()
	evt.SetMessage(51)         -- "You're contestants in the Scavenger Hunt?  If so, I wouldn't wander off to the Dragon Cave, then.  Morcarack doesn't tolerate strangers very well.  I bet the missing people went there thinking his cave was the Abandoned Temple--they're probably long dead."
end

-- "Contestants"
evt.global[41] = function()
	evt.SetMessage(52)         -- "I'd watch those other contestants-- some of them seem ruthless.  One particularly nasty group headed to the north side of the island, and I haven't seen them since.  I'm surprised at the attention this contest has received, apparently people are hoping to get on the good side of the contestants for future favors if they win."
end

-- "Tour Off"
evt.global[42] = function()
	evt.SetMessage(53)         -- "You have decided that you no longer desire my information about the places on Emerald Island.  If you later decide that you'd like to hear what I have to say, then select Tour On."
	evt.Set("QBits", 17)         -- No more docent babble
	evt.SetNPCTopic{NPC = 3, Index = 2, Event = 43}         -- "Margaret the Docent" : "Tour On"
end

-- "Tour On"
evt.global[43] = function()
	evt.SetMessage(54)         -- "You have decided to listen to my tour about the points of interest on Emerald Island.  If you decide that you no longer want me to point out areas of interest then select Tour Off."
	evt.Subtract("QBits", 17)         -- No more docent babble
	evt.SetNPCTopic{NPC = 3, Index = 2, Event = 42}         -- "Margaret the Docent" : "Tour Off"
end

-- "Rogue "
evt.global[44] = function()
	evt.SetMessage(55)         -- "Though the law may decide who is guilty and who is not, I decide who is called Thief, and who is just a criminal.  Bring me that lovely vase I saw on the mantle in Lord Markham’s manor, and I shall call you Rogue."
	evt.Add("QBits", 18)         -- "Go to Lord Markham's estate in Tatalia, steal the vase there, and return it to William Lasker in the Erathian Sewers."
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 45}         -- "William Lasker" : "Rogue "
end

-- "Rogue "
evt.global[45] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 624) then         -- "Vase"
		evt.SetMessage(56)         -- "Common criminals steal whatever catches their eye; Rogues steal what I tell them to steal.  I shall not grant titles to failures.  Return with Lord Markham’s Vase and I will promote all Thieves to Rogues, and all non-thieves to Honorary Rogues."
		return
	end
	evt.SetMessage(57)         -- "Well done.  Stealing that vase took guts and skill.  I grant you the title of Rogue, and a small payment for your services. "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Thief) then
		evt.Set("ClassIs", const.Class.Rogue)
		evt.Add("Awards", 10)         -- "Promoted to Rogue"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 11)         -- "Promoted to Honorary Rogue"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Thief) then
		evt.Set("ClassIs", const.Class.Rogue)
		evt.Add("Awards", 10)         -- "Promoted to Rogue"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 11)         -- "Promoted to Honorary Rogue"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Thief) then
		evt.Set("ClassIs", const.Class.Rogue)
		evt.Add("Awards", 10)         -- "Promoted to Rogue"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 11)         -- "Promoted to Honorary Rogue"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Thief) then
		evt.Set("ClassIs", const.Class.Rogue)
		evt.Add("Awards", 10)         -- "Promoted to Rogue"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 11)         -- "Promoted to Honorary Rogue"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("Inventory", 624)         -- "Vase"
	evt.Subtract("QBits", 212)         -- Vase - I lost it
	evt.ForPlayer("All")
	evt.ForPlayer("Current")
	evt.Add("Gold", 5000)
	evt.Subtract("QBits", 18)         -- "Go to Lord Markham's estate in Tatalia, steal the vase there, and return it to William Lasker in the Erathian Sewers."
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 46}         -- "William Lasker" : "Spy"
end

-- "Spy"
evt.global[46] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(60)         -- "Your next task is somewhat more difficult…more suited for Spies than Rogues.  I have been asked to ensure that Watchtower 6, the only tower to survive the recent wars against the Necromancers, be unable to defend itself the next time it is attacked.  Killing the guards inside won’t help—the Necromancers will just fill it again with more troops.  The tower is on the southern edge of the Necromancers’ land.  I want you to slip inside and move the counterweight in the gatehouse at the top of the tower to the gatehouse at the bottom of the tower.  It is a heavy weight that can be found in a slot against the wall with a rope tied to it.  When the time comes for an attack, the misplaced weights will be noticed too late, and the gate will not close.  If you can do this, you will have proven your status as a Spy."
		evt.Set("QBits", 19)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
		evt.SetNPCTopic{NPC = 15, Index = 0, Event = 47}         -- "William Lasker" : "Spy"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(58)         -- "You have chosen the path of Darkness, and I will promote you no further.  Perhaps an Assassin would have something to teach you.  I hear there is one in Deyja."
	else
		evt.SetMessage(59)         -- "You are not quite ready to take the next step.  The time is fast approaching when you must decide whether to follow the path of light, or the path of darkness.  If you choose the Light, return to me to complete your training."
	end
end

-- "Spy"
evt.global[47] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 20) then         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
		if evt.Cmp(-- ERROR: Not found
"Inventory", 999) then
			evt.SetMessage(61)         -- "Um…The weight needs to go in the box in the lower gatehouse—not here.  Go back to Watchtower 6 and put the weight in the right box!"
		elseif evt.Cmp("QBits", 56) then         -- Watchtower 6.  Taken the weight from the upper gatehouse.  Spy promo quest
			evt.SetMessage(62)         -- "Hmm.  Removing the weight from the upper gatehouse was a start, but where is it now?!?  The plan won’t work unless you put the weight in the lower gatehouse!  Go back to Watchtower 6 and put the weight in the right box!"
		else
			evt.SetMessage(63)         -- "You haven’t done the job yet!  Remember, you must go to Watchtower 6 and move the weight from the box in the upper gatehouse to the lower gatehouse.  I will not promote you until that is done. "
		end
		return
	end
	evt.SetMessage(64)         -- "Good work!  Some day, your sabotage of that watchtower will save hundreds of lives.  For your services, I hereby promote the Rogues among you to the status of Spy, and the Honorary Rogues to Honorary Spies! Oh, and here’s some gold as payment. "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Spy)
		evt.Add("Awards", 12)         -- "Promoted to Spy"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 13)         -- "Promoted to Honorary Spy"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Spy)
		evt.Add("Awards", 12)         -- "Promoted to Spy"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 13)         -- "Promoted to Honorary Spy"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Spy)
		evt.Add("Awards", 12)         -- "Promoted to Spy"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 13)         -- "Promoted to Honorary Spy"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Spy)
		evt.Add("Awards", 12)         -- "Promoted to Spy"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 13)         -- "Promoted to Honorary Spy"
		evt.Add("Experience", 40000)
	end
	evt.Add("Gold", 15000)
	evt.Subtract("QBits", 19)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 15, Index = 0, Event = 0}         -- "William Lasker"
	evt.SetNPCGreeting{NPC = 15, Greeting = 39}         -- "William Lasker" : "Greetings Spies, how may I be of service?"
end

-- "Drink Tea"
evt.global[48] = function()
	if not evt.Cmp("EnduranceBonus", 50) then
		evt.Set("EnduranceBonus", 50)
		evt.StatusText(66)         -- "Refreshing! (+50 Endurance temporary)"
	end
end

-- "Assassin"
evt.global[49] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(68)         -- "You have chosen the path of Light, and therefore can never become an effective Assassin.  I cannot train you.  Perhaps you should continue a softer hearted training with the Spy."
		return
	end
	if not evt.Cmp("Awards", 10) then         -- "Promoted to Rogue"
		if not evt.Cmp("Awards", 11) then         -- "Promoted to Honorary Rogue"
			evt.SetMessage(70)         -- "If you were looking for someone to train you in advanced stealth techniques, I  would be your man.  But you still need someone to teach you basic techniques.  Return to me when you achieve Rogue or Honorary Rogue status.  Then, perhaps, I can further your education.  Seek the Master Thief in the sewers of Erathia."
			return
		end
	end
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(67)         -- "So…you wish to become an Assassin.  Very well.  I can provide the Rogues among you the training necessary, but you must prove both your skill and your loyalty before I will invest time in you.  My superiors inform me that a certain Lady Eleanor Carmine’s life must end.  She used to work for us, but has taken up residence in the Celestial Court with our enemies, and is providing them with information damaging to our cause.  Silence her, and return with a trinket of hers to prove the job is done."
		evt.Set("QBits", 21)         -- "Go to the Celestial Court in Celeste and kill Lady Eleanor Carmine.  Return with proof to Seknit Undershadow in the Deyja Moors."
		evt.SetNPCTopic{NPC = 16, Index = 1, Event = 50}         -- "Seknit Undershadow" : "Assassin"
	else
		evt.SetMessage(69)         -- "I can turn a simple Rogue into a fearsome killer, but only if he has the right kind of temperament for the job.  The time is coming when you must choose to walk in the light, or in the dark.  If you prefer the shadow, come to me and I will complete your training."
	end
end

-- "Assassin"
evt.global[50] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 540) then         -- "Lady Carmine's Dagger"
		evt.SetMessage(71)         -- "Without proof, I cannot assume Lady Carmine is dead.  Bring me proof, and I will honor you with the title of Assassin."
		return
	end
	evt.SetMessage(72)         -- "So, the job is done. [He examines the dagger slowly, then sighs.] She was very dear to me, but emotion is the enemy of reason.  I could not have done the job myself.  Thank you.  Truly now, you are Assassins.  The rogues among you, I will give special training to.  Here is a small payment to help cover the expenses you incurred on the job. "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Assassin)
		evt.Add("Awards", 14)         -- "Promoted to Assassin"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 15)         -- "Promoted to Honorary Assassin"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Assassin)
		evt.Add("Awards", 14)         -- "Promoted to Assassin"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 15)         -- "Promoted to Honorary Assassin"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Assassin)
		evt.Add("Awards", 14)         -- "Promoted to Assassin"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 15)         -- "Promoted to Honorary Assassin"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Rogue) then
		evt.Set("ClassIs", const.Class.Assassin)
		evt.Add("Awards", 14)         -- "Promoted to Assassin"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 15)         -- "Promoted to Honorary Assassin"
		evt.Add("Experience", 40000)
	end
	evt.Add("Gold", 15000)
	evt.Subtract("QBits", 213)         -- Dagger - I lost it
	evt.Subtract("QBits", 21)         -- "Go to the Celestial Court in Celeste and kill Lady Eleanor Carmine.  Return with proof to Seknit Undershadow in the Deyja Moors."
	evt.Add("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 16, Index = 1, Event = 0}         -- "Seknit Undershadow"
	evt.SetNPCGreeting{NPC = 16, Greeting = 42}         -- "Seknit Undershadow" : "Hello again, fellow Assassins.  My tea and company are always yours."
end

-- "Crusader"
evt.global[51] = function()
	evt.SetMessage(74)         -- "Ha! So, thee wishes to take the test to be a crusader?  I cannot blame thee—the sense of pride one feels when one has accomplished a heroic deed is sublime!  The test is simple.  A dragon must be slain.  I know just the one—Wromthrax the Heartless!  He lives in a cave in Tatalia, and terrorizes the peasants who live near him when he’s home.  He should be in the cave this time of year.  Because this is probably thine first dragon, I will travel with thee to give thee pointers.  So, let us go forthwith, and spill this monster’s black blood!"
	evt.SetNPCTopic{NPC = 17, Index = 0, Event = 52}         -- "Sir Charles Quixote" : "Crusader"
	evt.MoveNPC{NPC = 17, HouseId = 0}         -- "Sir Charles Quixote"
	evt.Set("QBits", 22)         -- "Kill Wromthrax the Heartless in his cave in Tatalia, then talk to Sir Charles Quixote."
	evt.SetNPCGreeting{NPC = 17, Greeting = 44}         -- "Sir Charles Quixote" : "Why do we dally?  Even now that monster could be laying waste to the countryside!  Tally Ho!"
	evt.Set("NPCs", 17)         -- "Sir Charles Quixote"
end

-- "Crusader"
evt.global[52] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 23) then         -- Killed dragon when on Crusader quest
		evt.SetMessage(76)         -- "We must finish our quest before I can name thee Crusaders, friends."
		return
	end
	evt.SetMessage(75)         -- "Hurrah!  The Dragon has fallen!  Truly thou art grand Crusaders in good standing, with a fine deed behind thee.  I would stay and sing songs of thy bravery with thee, but duty calls.  Surely we will meet again, Crusaders!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 40)         -- "Promoted to Crusader"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 41)         -- "Promoted to Honorary Crusader"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 40)         -- "Promoted to Crusader"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 41)         -- "Promoted to Honorary Crusader"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 40)         -- "Promoted to Crusader"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 41)         -- "Promoted to Honorary Crusader"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Paladin) then
		evt.Set("ClassIs", const.Class.Crusader)
		evt.Add("Awards", 40)         -- "Promoted to Crusader"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 41)         -- "Promoted to Honorary Crusader"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 22)         -- "Kill Wromthrax the Heartless in his cave in Tatalia, then talk to Sir Charles Quixote."
	evt.Subtract("NPCs", 17)         -- "Sir Charles Quixote"
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 17, HouseId = 303}         -- "Sir Charles Quixote" -> "Quixote Residence"
	evt.SetNPCTopic{NPC = 17, Index = 0, Event = 53}         -- "Sir Charles Quixote" : "Hero"
	evt.SetNPCGreeting{NPC = 17, Greeting = 43}         -- "Sir Charles Quixote" : "Well met, my friends.  How goes the struggle against the forces of evil?"
end

-- "Hero"
evt.global[53] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(77)         -- "I am pleased to see thee chose the path of Light, Crusaders!  A wrong has been committed, friends, and who else but us can put it right?  A wicked villain has kidnapped a fair maiden by the name of Alice Hargreaves.  His name is William Setag, and he has imprisoned her in his tower.  You must ride forthwith to put this villain to the sword and rescue sweet Alice!  If you succeed, you will truly be Heroes of the Land!"
		evt.SetNPCTopic{NPC = 17, Index = 0, Event = 54}         -- "Sir Charles Quixote" : "Hero"
		evt.Set("QBits", 24)         -- "Rescue Alice Hargreaves from William's Tower in the Deyja Moors then talk to Sir Charles Quixote."
		evt.SetNPCGreeting{NPC = 17, Greeting = 43}         -- "Sir Charles Quixote" : "Well met, my friends.  How goes the struggle against the forces of evil?"
		evt.MoveNPC{NPC = 54, HouseId = 522}         -- "Alice Hargreaves" -> "Alice Hargreaves"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(78)         -- "I will not have truck with thee further, scoundrel!  I see now thee hath chosen the path of Darkness.  Mayhaps thee should seek a villain like thyself for training."
	else
		evt.SetMessage(79)         -- "Ah, fellow Crusaders!  I know thee thirsts for another task with which to hone thy Crusading skills, but first thee must pass a far more serious test.  Thee must agree to follow the Path of Light before I can help thee further.  You will know when you have made this choice.  Return to me then."
	end
end

-- "Hero"
evt.global[54] = function()
	if not evt.Cmp("NPCs", 54) then         -- "Alice Hargreaves"
		evt.SetMessage(81)         -- "Though thy deeds remain impressive indeed, crusaders, I cannot declare thee Heroes until you have rescued the girl!"
		return
	end
	evt.SetMessage(80)         -- "Thee’ve done it! I knew thee could do it!  I’m so proud of thee!  Alice has been freed of the clutches of the wicked William Setag, evil has been vanquished, and good upheld.  Where once there was wrong, now there is right! [Charles sighs and smiles broadly] Well.  My work here is done!  Thee have passed the tests and deserve thy reward.  Therefore do I solemnly declare thee Heroes! "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 42)         -- "Promoted to Hero"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 43)         -- "Promoted to Honorary Hero"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 42)         -- "Promoted to Hero"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 43)         -- "Promoted to Honorary Hero"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 42)         -- "Promoted to Hero"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 43)         -- "Promoted to Honorary Hero"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Hero)
		evt.Add("Awards", 42)         -- "Promoted to Hero"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 43)         -- "Promoted to Honorary Hero"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 24)         -- "Rescue Alice Hargreaves from William's Tower in the Deyja Moors then talk to Sir Charles Quixote."
	evt.Subtract("NPCs", 54)         -- "Alice Hargreaves"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 54, HouseId = 303}         -- "Alice Hargreaves" -> "Quixote Residence"
	evt.SetNPCGreeting{NPC = 17, Greeting = 46}         -- "Sir Charles Quixote" : "Salutations Heroes!  I am certain thou hast much to accomplish before we dally about."
	evt.SetNPCTopic{NPC = 17, Index = 0, Event = 0}         -- "Sir Charles Quixote"
end

-- "Hello?"
evt.global[55] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 25) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.SetMessage(85)         -- "Thank you so much for helping me away from William's clutches."
		else
			evt.SetMessage(84)         -- "Help!  William has captured me and imprisoned me in this tower.  Please get me out of here as quickly as possible, I don't want to die."
			evt.Set("QBits", 25)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.Set("NPCs", 54)         -- "Alice Hargreaves"
		end
	elseif not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(83)         -- "It should be impossible for you to see this right now.  If you are reading this, tell Bryan that the event and/or logic of this quest is messed up because you should either be good attempting the Hero quest, or evil attempting the Villain quest and you are apparently neither."
	elseif evt.Cmp("QBits", 25) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		evt.SetMessage(87)         -- "Where do you think you're taking me?  I have a rich family-- you'll be in a lot of trouble if you don't let me go!"
	else
		evt.SetMessage(86)         -- "Excuse me, but who might you be?  Hey!  Get your hands off of me!  Help!"
		evt.Set("QBits", 25)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
		evt.Set("NPCs", 54)         -- "Alice Hargreaves"
	end
end

-- "Villain"
evt.global[56] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(89)         -- "I'd certainly love nothing more than to corrupt your obviously pious soul, but I'm afraid you wouldn't have the stomach to follow through with my teachings.  You have chosen the Path of Light, you will garner no assistance from me."
		return
	end
	if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(90)         -- "Before you make this decision, you have a more pressing, immediate decision you will be forced to make.  If you choose the darker road, you may return to me and complete your training in the Paladins' arts."
		return
	end
	evt.SetMessage(88)         -- "Let's get down to business, shall we?  I know you are well aware of my standing as the blackest Villain in Erathia.  It requires effort and drive to prove to be this evil-- I hope you have the mettle for it.  I would love nothing more than to keep you in my training for years and teach you the finest parts of being a Villain.  Unfortunately, I am under pressure to speed up your tutelage.  To this end, I have a direct way to learn the arts of Villainhood.  There is a woman, Alice Hargreaves, who is of noble blood and pure character.  Capture this woman from her residence in Castle Gryphonheart. Return here and imprison her in my tower.  Complete this, and I shall promote all Crusaders in your group to Villains, and the rest of your group to Honorary Villains."
	if not evt.Cmp("Awards", 40) then         -- "Promoted to Crusader"
		if not evt.Cmp("Awards", 41) then         -- "Promoted to Honorary Crusader"
			evt.SetMessage(99)         -- "I cannot improve upon training you do not already have.  You must be promoted to Crusader before I can train you in the ways of villainy."
			return
		end
	end
	evt.Set("QBits", 26)         -- "Capture Alice Hargreaves from her residence in Castle Gryphonheart and return her to William's Tower in the Deyja Moors."
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 57}         -- "William Setag" : "Villain"
	evt.MoveNPC{NPC = 54, HouseId = 522}         -- "Alice Hargreaves" -> "Alice Hargreaves"
end

-- "Villain"
evt.global[57] = function()
	if not evt.Cmp("NPCs", 54) then         -- "Alice Hargreaves"
		evt.SetMessage(92)         -- "Where's Alice?  I'm not asking for much, just a simple kidnapping.  Is it really that difficult?  I suggest you speed up your efforts."
		return
	end
	evt.SetMessage(91)         -- "Capital!  You have shown dedication, daring, and the power of raw force.  Certainly the imprisonment of such a fair and noble creature in this wicked place earns you the right to be called a Villain-- or Honorary Villain.  Go now upon the world and make all fear your name."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Villain)
		evt.Add("Awards", 44)         -- "Promoted to Villain"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 45)         -- "Promoted to Honorary Villain"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Villain)
		evt.Add("Awards", 44)         -- "Promoted to Villain"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 45)         -- "Promoted to Honorary Villain"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Villain)
		evt.Add("Awards", 44)         -- "Promoted to Villain"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 45)         -- "Promoted to Honorary Villain"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Crusader) then
		evt.Set("ClassIs", const.Class.Villain)
		evt.Add("Awards", 44)         -- "Promoted to Villain"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 45)         -- "Promoted to Honorary Villain"
		evt.Add("Experience", 40000)
	end
	evt.Add("Gold", 10000)
	evt.Subtract("QBits", 26)         -- "Capture Alice Hargreaves from her residence in Castle Gryphonheart and return her to William's Tower in the Deyja Moors."
	evt.Add("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 18, Index = 0, Event = 0}         -- "William Setag"
	evt.SetNPCGreeting{NPC = 18, Greeting = 50}         -- "William Setag" : "Villains!  Welcome!  Too rarely do my villainous friends pay me visits."
	evt.Subtract("NPCs", 54)         -- "Alice Hargreaves"
end

-- "Initiate"
evt.global[58] = function()
	evt.SetMessage(93)         -- "Ah, it is normal for novice Monks to ask for the path of enlightenment.  I shall tell you of the path, though the journey is yours to make.  In the Barrow Downs is a series of tombs-- one of which was constructed on a site of great natural power.  You will know the right barrow because it is different from the rest.  Reach this barrow and meditate by the water, and your promotion to Initiate will be complete."
	evt.Set("QBits", 27)         -- "Find the lost meditation spot in the Dwarven Barrows."
	evt.SetNPCTopic{NPC = 38, Index = 0, Event = 59}         -- "Bartholomew Hume" : "Initiate"
end

-- "Initiate"
evt.global[59] = function()
	evt.SetMessage(95)         -- "You have not finished your journey.  Return to me only when you have completed your task."
end

-- "Initiate"
evt.global[60] = function()
	evt.SetMessage(94)         -- "[Bartholomew Hume contacts you mentally] Congratulations, young ones.  My final lesson given to you as Monks is this:  enlightenment is gained by the journey, not the destination.  In this case, the destination was critical to prove that you were capable of the journey.  I shall now promote all Monks to Initiates and everyone else to Honorary Initiates-- congratulations."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Monk) then
		evt.Set("ClassIs", const.Class.Initiate)
		evt.Add("Awards", 22)         -- "Promoted to Initiate"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 23)         -- "Promoted to Honorary Initiate"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Monk) then
		evt.Set("ClassIs", const.Class.Initiate)
		evt.Add("Awards", 22)         -- "Promoted to Initiate"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 23)         -- "Promoted to Honorary Initiate"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Monk) then
		evt.Set("ClassIs", const.Class.Initiate)
		evt.Add("Awards", 22)         -- "Promoted to Initiate"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 23)         -- "Promoted to Honorary Initiate"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Monk) then
		evt.Set("ClassIs", const.Class.Initiate)
		evt.Add("Awards", 22)         -- "Promoted to Initiate"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 23)         -- "Promoted to Honorary Initiate"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 27)         -- "Find the lost meditation spot in the Dwarven Barrows."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 38, Index = 0, Event = 61}         -- "Bartholomew Hume" : "Master"
	evt.SetNPCTopic{NPC = 55, Index = 0, Event = 0}         -- "Bartholomew Hume"
end

-- "Master"
evt.global[61] = function()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(97)         -- "I am sorry, but I am permitted to train you no longer.  You will need to find a new Master to learn from."
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(96)         -- "I see you wish to continue your journey.  Excellent!  Have no fear, for you are prepared for your next step.  You must extinguish the remnants of an evil order- the Order of Baa.  Defeat their High Priest and return to me and I shall complete your training and promote you to Master."
		evt.Set("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		evt.SetNPCTopic{NPC = 38, Index = 0, Event = 62}         -- "Bartholomew Hume" : "Master"
	else
		evt.SetMessage(98)         -- "A fork approaches in your path.  I will only train you after you've chosen to walk the lighter path."
	end
end

-- "Master"
evt.global[62] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 243) then         -- Killed High Preist of Baa
		evt.SetMessage(135)         -- "The Temple of Baa still stands, their High Priest still lives.  Until this is completed, you are not ready for the title of Master.  Go now and do not fail."
		return
	end
	evt.SetMessage(134)         -- "Good work.  No longer shall the Order of Baa stain the lands of Erathia.  Now, allow me to promote all Initiates to Masters, and all Honorary Initiates to Honorary Masters.  Keep in mind that this is but a stop along the path of enlightenment.  Your journey only ends with your eventual death-- never close your mind."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Master)
		evt.Add("Awards", 24)         -- "Promoted to Master"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 25)         -- "Promoted to Honorary Master"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Master)
		evt.Add("Awards", 24)         -- "Promoted to Master"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 25)         -- "Promoted to Honorary Master"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Master)
		evt.Add("Awards", 24)         -- "Promoted to Master"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 25)         -- "Promoted to Honorary Master"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Master)
		evt.Add("Awards", 24)         -- "Promoted to Master"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 25)         -- "Promoted to Honorary Master"
		evt.Add("Experience", 40000)
	end
	evt.Add("Gold", 7500)
	evt.Subtract("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 38, Index = 0, Event = 0}         -- "Bartholomew Hume"
	evt.SetNPCGreeting{NPC = 38, Greeting = 52}         -- "Bartholomew Hume" : "Greetings again, Masters.  How can Bartholomew aid you?"
end

-- "Ninja"
evt.global[63] = function()
	if not evt.Cmp("Awards", 22) then         -- "Promoted to Initiate"
		if not evt.Cmp("Awards", 23) then         -- "Promoted to Honorary Initiate"
			evt.SetMessage(137)         -- "Ambition is good, but I only train experienced students.  Come back when you've achieved Initiate status, and perhaps I'll teach you…IF you have the right outlook.  If you're looking for someone who is willing to help you become an Initiate, perhaps you should start with that wimp Bartholomew Hume.  I'm sure he'd be willing to give you an elementary education."
			return
		end
	end
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(138)         -- "[Stephan Sand sneers] YOU want ME to teach you something?  You sniveling do-gooders make my knife arm twitch!  Get out of my sight before I REALLY teach you about fighting!"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(136)         -- "An agent of mine has sent me a message I need deciphered.  The cipher relies on knowing which word of which a certain book to match it against.  If you wish to become a Ninja, this is what you must do: Infiltrate the School of Wizardry and find out what the third word of the famed Scroll of Waves is.  Use it to decipher the message, then do what the message tells you to do.  It is the key to enter the Tomb of the Master.  You'll find the tomb in Southern Erathia.  [Stephan hands you a scrap of paper] Here is the encoded message."
		evt.Set("QBits", 29)         -- "Crack the code in the School of Sorcery in the Bracada Desert to reveal the location of the Tomb of Ashwar Nog'Nogoth.  Discover the tomb's location, enter it, and then return it to Stephan Sand in the Pit."
		evt.SetNPCTopic{NPC = 39, Index = 0, Event = 64}         -- "Stephan Sand" : "Ninja"
		evt.Add("Inventory", 701)         -- "Cipher"
		evt.Add("QBits", 215)         -- Cipher - I lost it
	else
		evt.SetMessage(139)         -- "Though you have achieved initiate status, I am uncertain that you can stomach some of my more extreme teachings.  Return to me when you have formally rejected all philosophies that turn people into weaklings and cowards."
	end
end

-- "Ninja"
evt.global[64] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 242) then         -- Opened chest with shadow mask
		if evt.Cmp("QBits", 57) then         -- Solved the code puzzle.  Ninja promo quest
			evt.SetMessage(140)         -- "So you have the key, but you haven't followed the directions in the message.  Remember, the tomb is in Southern Erathia.  Complete your task, and return to me to report success.  If you can't complete your mission, don't bother returning to me.  Failure is pathetic."
		else
			evt.SetMessage(141)         -- "[Sand sighs] Once again, the cipher key is the third word of the first paragraph of the Scroll of Waves.  You can find it somewhere in the School of Wizardry.  I don't care how you get in there--kill anyone who gets in your way, or sneak in.  Whatever you want.  The only thing that matters is success.  Everything else is an excuse for personal weakness."
		end
		return
	end
	evt.SetMessage(142)         -- "Well done.  No one can argue with success except apologists for the weak and the cowardly.  I hereby promote all Initiates to Ninjas, and all non-Initiates to Honorary Ninjas.  Oh yeah, go ahead and keep that little trinket you stole from the tomb.  This was just a training exercise, after all."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Promoted to Ninja"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Promoted to Ninja"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Promoted to Ninja"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Promoted to Ninja"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 29)         -- "Crack the code in the School of Sorcery in the Bracada Desert to reveal the location of the Tomb of Ashwar Nog'Nogoth.  Discover the tomb's location, enter it, and then return it to Stephan Sand in the Pit."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 39, Index = 0, Event = 0}         -- "Stephan Sand"
	evt.SetNPCGreeting{NPC = 39, Greeting = 55}         -- "Stephan Sand" : "Now that you've achieved the exaulted status of Ninja, I have nothing further to give you.  I hope my teachings take you far."
end

-- "Master Archer"
evt.global[65] = function()
	if not evt.Cmp("Awards", 34) then         -- "Promoted to Warrior Mage"
		if not evt.Cmp("Awards", 35) then         -- "Promoted to Honorary Warrior Mage"
			evt.SetMessage(146)         -- "I am the person to see if you want to become Master Archers, but you have come too soon!  You must have the proper background to become a Master, and that means first becoming a warrior mage.  Return when you are ready."
			return
		end
	end
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(143)         -- "A few generations ago, an enchanted bow was created by alchemists in the Tularean Forest to seal another peace treaty between the elves and the humans.  While en route to Erathia, the bow was taken from the couriers by the Titans in Avlee.  They have no use for the thing, so it's probably in their stronghold still.  Strike a blow for our profession, and get that bow back.  It is absolutely the finest thing of its kind ever made.  Oh, and while you're there, feel free to cut some of those bullies down to size--They stole it out of cruelty, not need!  If you are successful, I will promote all Warrior Mages to Master Archers, or honorary Master Archers, as the case may be."
		evt.Add("QBits", 30)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Lawrence Mark in Harmondale."
		evt.SetNPCTopic{NPC = 40, Index = 0, Event = 66}         -- "Lawrence Mark" : "Master Archer"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(145)         -- "You have chosen the path of Darkness.  I will never help you improve, for fear you will use your skills to advance your selfish goals!"
	else
		evt.SetMessage(144)         -- "So, you've achieved the rank of Warrior Mage, and wish to advance to Master Archer!  A worthy goal, but I only promote those who's heart and courage match their skill.  Come back to me when you have firmly committed to the Light.  Then I will help you."
	end
end

-- "Master Archer"
evt.global[66] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 542) then         -- "The Perfect Bow"
		evt.SetMessage(148)         -- "No luck getting the bow?  Well, take your time, and plan your assault against the Titans carefully.  Against such powerful opponents, there is no shame in striking and retreating.  Do what you must to defeat these monsters."
		return
	end
	evt.SetMessage(147)         -- "You found the bow!  Let me take some measurements and adjust it to your specific style of archery. Once I have finished you should keep it, and use it in defense the of the land and the people.  I am happy to promote all Warrior Mages to Master Archers, and all Honorary Warrior Mages to Honorary Master Archers."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.MasterArcher)
		evt.Add("Awards", 36)         -- "Promoted to Master Archer"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 37)         -- "Promoted to Honorary Master Archer"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.MasterArcher)
		evt.Add("Awards", 36)         -- "Promoted to Master Archer"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 37)         -- "Promoted to Honorary Master Archer"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.MasterArcher)
		evt.Add("Awards", 36)         -- "Promoted to Master Archer"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 37)         -- "Promoted to Honorary Master Archer"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.MasterArcher)
		evt.Add("Awards", 36)         -- "Promoted to Master Archer"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 37)         -- "Promoted to Honorary Master Archer"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 30)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Lawrence Mark in Harmondale."
	evt.Add("Inventory", 543)         -- "The Perfect Bow"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 542) then         -- "The Perfect Bow"
		evt.Subtract("Inventory", 542)         -- "The Perfect Bow"
	end
	evt.SetNPCTopic{NPC = 40, Index = 0, Event = 0}         -- "Lawrence Mark"
	evt.SetNPCGreeting{NPC = 40, Greeting = 57}         -- "Lawrence Mark" : "Welcome my friends!  That's a fine weapon you have there, but don't think for a moment you'll best me in this year's Tourney--I'm still the Master!"
end

-- "Warrior Mage"
evt.global[67] = function()
	evt.SetMessage(149)         -- "[Wheeze] So you think you can become Warrior Mages, do you?  It isn't easy.  You must be equally proficient in magical skills and physical skills.  There is a test of this.  Visit the Red Dwarf Mines.  Inside you will find two kinds of beasts--one that can be harmed only with magic, and one that can be harmed only with steel.  In the back of the lower section of the mines you will find a machine created by the Dwarves that powers the lift-- the only access between the upper and lower sections of the mines.  To keep the creatures trapped in the lower section, you will have to replace the belt in the machine with this one, a worn belt that will only last about an hour before breaking.  This should give you enough time to get to the lift and get out before you are trapped down there.  Seal away these creatures and return to me-- only then will I call you Warrior Mages."
	evt.Add("Inventory", 649)         -- "Worn Belt"
	evt.Add("QBits", 31)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Steagal Snick in Avlee."
	evt.Add("QBits", 216)         -- Worn Belt - I lost it
	evt.SetNPCTopic{NPC = 41, Index = 0, Event = 68}         -- "Steagal Snick" : "Warrior Mage"
end

-- "Warrior Mage"
evt.global[68] = function()
	if not evt.Cmp("QBits", 58) then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
		evt.SetMessage(151)         -- "You haven't sabotaged the machine yet.  You must finish this before I'll promote you to Warrior Mage."
		return
	end
	evt.SetMessage(150)         -- "Very Good.  You have passed the test.  Now the creatures are sealed away and won't be able to prey on the dwarves any longer, and you have proven your ability in both sorcery and steel.  I am proud to declare all Archers amongst you Warrior Mages, and everyone else Honorary Warrior Mages.  Congratulations!  Now get out.  I already weary of your company."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 34)         -- "Promoted to Warrior Mage"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 35)         -- "Promoted to Honorary Warrior Mage"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 34)         -- "Promoted to Warrior Mage"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 35)         -- "Promoted to Honorary Warrior Mage"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 34)         -- "Promoted to Warrior Mage"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 35)         -- "Promoted to Honorary Warrior Mage"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Archer) then
		evt.Set("ClassIs", const.Class.WarriorMage)
		evt.Add("Awards", 34)         -- "Promoted to Warrior Mage"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 35)         -- "Promoted to Honorary Warrior Mage"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 31)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Steagal Snick in Avlee."
	evt.Add("Gold", 7500)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 41, Index = 0, Event = 69}         -- "Steagal Snick" : "Sniper"
end

-- "Sniper"
evt.global[69] = function()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(152)         -- "Getting ambitious, are we?  Think you can earn the title of sniper?  Perhaps you can.  Here is what you must do:  In the stronghold of the Titans is a very special bow that was meant as a peace offering from the elves to the humans to quell a conflict long since forgotten.  [Master Snick shakes his head] Gads! This peace stuff makes me nauseous!  In any case, fetch the bow for the good of our profession, and I'll promote you to Sniper.  [Heh] you better act like snipers if you expect to defeat the Titans.  A toe to toe...or should I say head to knee fight won't go well for you."
		evt.Set("QBits", 32)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Steagal Snick in Avlee."
		evt.SetNPCTopic{NPC = 41, Index = 0, Event = 70}         -- "Steagal Snick" : "Sniper"
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(154)         -- "Following the Path of Light, are we?  How can you be a Sniper if you cry everytime you shoot someone in the back?  Maybe you should ask that lily-livered Lawrence Mark to help you.  I know that I will not."
	else
		evt.SetMessage(153)         -- "Want to be a Sniper, eh? Maybe.  But I doubt you have the heart for it.  It needs to shrivel like a raisin and get hard as a stone to be able to do what you must.  Prove to me you are following the Path of Darkness, and then I will teach you further."
	end
end

-- "Sniper"
evt.global[70] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 542) then         -- "The Perfect Bow"
		evt.SetMessage(156)         -- "More failure? [Master Snick yawns]  How surprising.  I'll make it simple--no bow, no title."
		return
	end
	evt.SetMessage(155)         -- "You have the bow?!  Excellent!  It's been centuries since someone was brave enough to take on the Titans and try to get that bow back!  Let me take some measurements and adjust it to your specific style of archery.  I am proud to be the one to first call all Warrior Mages amongst you Snipers, and to say that all Honorary Warrior Mages are Honorary Snipers!  I must admit I didn't think you had it in you to succeed.  I am happy that I was wrong."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.Sniper)
		evt.Add("Awards", 38)         -- "Promoted to Sniper"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 39)         -- "Promoted to Honorary Sniper"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.Sniper)
		evt.Add("Awards", 38)         -- "Promoted to Sniper"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 39)         -- "Promoted to Honorary Sniper"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.Sniper)
		evt.Add("Awards", 38)         -- "Promoted to Sniper"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 39)         -- "Promoted to Honorary Sniper"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.WarriorMage) then
		evt.Set("ClassIs", const.Class.Sniper)
		evt.Add("Awards", 38)         -- "Promoted to Sniper"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 39)         -- "Promoted to Honorary Sniper"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 32)         -- "Retrieve the Perfect Bow from the Titans' Stronghold in Avlee and return it to Steagal Snick in Avlee."
	evt.Add("Inventory", 543)         -- "The Perfect Bow"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 542) then         -- "The Perfect Bow"
		evt.Subtract("Inventory", 542)         -- "The Perfect Bow"
	end
	evt.SetNPCTopic{NPC = 41, Index = 0, Event = 0}         -- "Steagal Snick"
	evt.SetNPCGreeting{NPC = 41, Greeting = 59}         -- "Steagal Snick" : "Students…[Mr. Snick rasps the word, then smiles] no longer.  I am proud to have helped you on your way.  Use your new weapon…[wheeze] wisely."
end

-- "Champion"
evt.global[71] = function()
	if not evt.Cmp("Awards", 16) then         -- "Promoted to Cavalier"
		if not evt.Cmp("Awards", 17) then         -- "Promoted to Honorary Cavalier"
			evt.SetMessage(160)         -- "I am the person to talk to if you want to be called Champions.  First, though, you must practice.  Return to me when you've become Cavaliers.  Then, if you have the right outlook, I will tell you what you must do to become Champions."
			return
		end
	end
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(159)         -- "Call you Champions?  Never!  The only reason I'm not hacking you evil doers to bits is that you came here peacefully.  Leave now, before I change my mind and rid the world of another problem."
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(157)         -- "So you want to be champions, do you?  Ha!  How can you be a champion if you don't win any tournaments?  You know, I can't really promote you to Champion status--you have to do it yourself, just like everything else.  Go and win five championship tournaments in the Arena at Knight level, and come back to me.  I'll call you Champions then, if you want."
		evt.Set("QBits", 33)         -- "Win five arena challenges then return to Leda Rowan in the Bracada Desert."
		evt.SetNPCTopic{NPC = 42, Index = 0, Event = 72}         -- "Leda Rowan" : "Champion"
	else
		evt.SetMessage(158)         -- "I can see you very much want to be called Champions, but I'm not so sure I should help you.  Prove to me that you follow the Path of Light, and then we'll talk about promotion."
	end
end

-- "Champion"
evt.global[72] = function()
	if evt.Cmp("ArenaWinsKnight", 4) then
		if evt.Cmp("ArenaWinsLord", 1) then
			goto _3
		end
		goto _48
	end
	if evt.Cmp("ArenaWinsKnight", 3) then
		goto _48
	end
	if evt.Cmp("ArenaWinsKnight", 2) then
		goto _49
	end
	if evt.Cmp("ArenaWinsKnight", 1) then
		goto _50
	end
::_51::
	if not evt.Cmp("ArenaWinsLord", 5) then
		if not evt.Cmp("ArenaWinsKnight", 5) then
			evt.SetMessage(162)         -- "You have not yet won 5 championship tournaments in the Arena.  Return to me when you have won five, and I will promote you.  Remember, these battles MUST be at the Knight difficulty level."
			return
		end
	end
::_3::
	evt.SetMessage(161)         -- "Congratulations for you recent tourney victories, my friends!  I gladly name the Cavaliers among you Champions, and the Honorary Cavaliers I name Honorary Champions!  Always fight for the Light, Champions!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Promoted to Champion"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 19)         -- "Promoted to Honorary Champion"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Promoted to Champion"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 19)         -- "Promoted to Honorary Champion"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Promoted to Champion"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 19)         -- "Promoted to Honorary Champion"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 18)         -- "Promoted to Champion"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 19)         -- "Promoted to Honorary Champion"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 33)         -- "Win five arena challenges then return to Leda Rowan in the Bracada Desert."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 42, Index = 0, Event = 0}         -- "Leda Rowan"
	evt.SetNPCGreeting{NPC = 42, Greeting = 61}         -- "Leda Rowan" : "Hail, champions!  Your courage and skill has all the tongues in the Kingdom wagging!  I am very proud of you!"
	do return end
::_48::
	if evt.Cmp("ArenaWinsLord", 2) then
		goto _3
	end
::_49::
	if evt.Cmp("ArenaWinsLord", 3) then
		goto _3
	end
::_50::
	if evt.Cmp("ArenaWinsLord", 4) then
		goto _3
	end
	goto _51
end

-- "Cavalier"
evt.global[73] = function()
	evt.SetMessage(163)         -- "The hallmark of the Cavalier is courage.  I can promote you to Cavalier status, but before I'll do that, you'll have to prove to me your bravery in battle.  Since most people are yellow bellied cowards at heart, I doubt you'll succeed.  But if you want to try, here is what you must do: Destroy all the undead in the haunted mansion in the Barrow Downs."
	evt.Set("QBits", 34)         -- "Destroy all the undead in the Haunted House in the Barrow Downs and return to Frederick Org in Erathia."
	evt.SetNPCTopic{NPC = 43, Index = 0, Event = 74}         -- "Frederick Org" : "Cavalier"
end

-- "Cavalier"
evt.global[74] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 140) then         -- Cleaned out the haunted mansion (Cavalier promo)
		evt.SetMessage(165)         -- "Did one little haunted house send you packing in fear?  I've seen chocolate eclairs with more backbone than you!  Get you gone, and don't come back 'til you've stiffened your spine!"
		return
	end
	evt.SetMessage(164)         -- "So you're back!  And from the look on your faces I see you have finished the job.  Well done!  I hereby officially promote all Knights amongst you to Cavaliers, and everyone else to honorary Cavaliers.  Carry your title with pride!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Promoted to Cavalier"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 17)         -- "Promoted to Honorary Cavalier"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Promoted to Cavalier"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 17)         -- "Promoted to Honorary Cavalier"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Promoted to Cavalier"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 17)         -- "Promoted to Honorary Cavalier"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Cavalier)
		evt.Add("Awards", 16)         -- "Promoted to Cavalier"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 17)         -- "Promoted to Honorary Cavalier"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 34)         -- "Destroy all the undead in the Haunted House in the Barrow Downs and return to Frederick Org in Erathia."
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 43, Index = 0, Event = 75}         -- "Frederick Org" : "Black Knight"
end

-- "Black Knight"
evt.global[75] = function()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(166)         -- "So you think you can become Black Knights, do you?  Very well.  You know, I've heard many people say that criminals are cowards.  That just isn't true.  It takes a lot of courage to risk your life in a robbery, or in battle.  You've already proven you are courageous, and now it's time to put that courage and your skills to use.  I want you to rob the Elvish Treasury.  It's one of the biggest hoards of treasure in the land, and it is very well guarded.  Do the deed and abscond with the wealth.  Return to me when you've finished.  Then I will promote you to Black Knights."
		evt.Set("QBits", 35)         -- "Raid the Elven Treasury at Castle Navan in the Tularean Forest and return to Frederick Org in Erathia."
		evt.SetNPCTopic{NPC = 43, Index = 0, Event = 76}         -- "Frederick Org" : "Black Knight"
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(168)         -- "Bah!  You do-gooders are worthless!  It is impossible for me to teach anything more to you!  "
	else
		evt.SetMessage(167)         -- "It's true that I am the one you go to when you're looking to be promoted to Black Knight status.  But how can you become a Black Knight when you haven't even decided whether or not you're evil?  Return to me when you have fully committed to Darkness.  Only then will I resume your training."
	end
end

-- "Black Knight"
evt.global[76] = function()
	if not evt.Cmp("QBits", 60) then         -- Robbed Elven treasury.  Black Knight promo quest.
		evt.SetMessage(170)         -- "Robbery not complete?  No.  Don't come to me and report failure.  Don't come and tell me you lost your nerve.  Get out there and rob that treasury!  Failure is not an option!"
		return
	end
	evt.SetMessage(169)         -- "All RIGHT!  That robbery was brilliant!  I am very proud of you.  Keep the loot--it's your reward for a job well done.  I can safely say the Cavaliers among you have become Black Knights today, and I'll throw in an Honorary Black Knight title for the rest of you.  You've done well, my students!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.BlackKnight)
		evt.Add("Awards", 20)         -- "Promoted to Black Knight"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 21)         -- "Promoted to Honorary Black Knight"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.BlackKnight)
		evt.Add("Awards", 20)         -- "Promoted to Black Knight"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 21)         -- "Promoted to Honorary Black Knight"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.BlackKnight)
		evt.Add("Awards", 20)         -- "Promoted to Black Knight"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 21)         -- "Promoted to Honorary Black Knight"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cavalier) then
		evt.Set("ClassIs", const.Class.BlackKnight)
		evt.Add("Awards", 20)         -- "Promoted to Black Knight"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 21)         -- "Promoted to Honorary Black Knight"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 35)         -- "Raid the Elven Treasury at Castle Navan in the Tularean Forest and return to Frederick Org in Erathia."
	evt.Add("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 43, Index = 0, Event = 0}         -- "Frederick Org"
	evt.SetNPCGreeting{NPC = 43, Greeting = 63}         -- "Frederick Org" : "[Frederick rises hastily to his feet] None shall pass! [he blinks and rubs his eyes] Oh.  It's you.  Sorry, I thought you were someone else.  How goes the villainy?"
end

-- "Ranger Lord"
evt.global[77] = function()
	if not evt.Cmp("Awards", 28) then         -- "Promoted to Hunter"
		if not evt.Cmp("Awards", 29) then         -- "Promoted to Honorary Hunter"
			evt.SetMessage(173)         -- "[Lysander shakes his head, smiling gently] Too soon, eager ones.  I train only the most advanced students.  Seek me out again when you reach Hunter status."
			return
		end
	end
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(171)         -- "Well, it looks like you might be able to do the job I have in mind.  The fundamental task a Ranger Lord faces is caring for the land.  Recently, poachers removed a magical gemstone called the ""heart of the forest"" from the Tularean Forest.  The forest has become restless, and attacks travelers who come too close.  The forest blames all 'Walkers' for the theft, and won't calm down until the stone is returned.  Find the stone and return it to the oldest tree in the Forest.  Come back to me when you've done this."
		evt.Set("QBits", 36)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
		evt.SetNPCTopic{NPC = 44, Index = 0, Event = 78}         -- "Lysander Sweet" : "Ranger Lord"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(174)         -- "[Lysander frowns] You've chosen the path of darkness.  I refuse to teach such as you--you would only use my lessons to further your selfish goals.  May Heaven have mercy on your souls."
	else
		evt.SetMessage(172)         -- "I would like to be your teacher--I really would, but I'm not sure you're cut out to be a Ranger Lord.  Soon you must make a decision of the heart.  If you choose the Path of Light, return to me.  I would be honored to be your teacher."
	end
end

-- "Ranger Lord"
evt.global[78] = function()
	if not evt.Cmp("QBits", 41) then         -- Solved Tree quest
		if evt.Cmp("QBits", 40) then         -- Talked to the Oldest Tree
			evt.SetMessage(176)         -- "Well, you've spoken with the tree, and now know as much as I do about the theft.  If you manage to find the stone, take it directly to the tree and then come see me."
		else
			evt.SetMessage(175)         -- "If you can't figure out where to start, you should try finding the oldest tree in the forest.  It should be somewhere outside of Pierpont in Avlee.  The oldest tree has the power of speech, and may know something helpful.  It will be happy to tell you whatever you want to hear, plus a whole lot more.  You'll see."
		end
		return
	end
	evt.SetMessage(177)         -- "You've done a good thing, returning the Heart.  The forest is quieter now, and no longer attacks travelers.  You've probably saved many lives.  For service to the Land and the Light, I hereby promote all Hunters among you to Ranger Lords, and all honorary Hunters to honorary Ranger Lords!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.RangerLord)
		evt.Add("Awards", 30)         -- "Promoted to Ranger Lord"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 31)         -- "Promoted to Honorary Ranger Lord"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.RangerLord)
		evt.Add("Awards", 30)         -- "Promoted to Ranger Lord"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 31)         -- "Promoted to Honorary Ranger Lord"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.RangerLord)
		evt.Add("Awards", 30)         -- "Promoted to Ranger Lord"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 31)         -- "Promoted to Honorary Ranger Lord"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.RangerLord)
		evt.Add("Awards", 30)         -- "Promoted to Ranger Lord"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 31)         -- "Promoted to Honorary Ranger Lord"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 36)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 44, Index = 0, Event = 0}         -- "Lysander Sweet"
	evt.SetNPCGreeting{NPC = 44, Greeting = 65}         -- "Lysander Sweet" : "Your good works have served the forest well.  And, I can see, the experience has served you well in turn.  May you continue to reap the rewards of your good deeds, my friends!"
end

-- "Hunter"
evt.global[79] = function()
	evt.SetMessage(178)         -- "Think you can improve?  I have a test for you.  A hunter needs to understand the woods, and a hunter needs to be as skilled with magic as with a blade.  The best teachers for that are the faeries.  There's a faerie mound in Northern Avlee.  Figure out how to get in, and the Faeries will grant magic to the genuine rangers among you, meaning that they will be promoted to Hunter status.  The rest of you will be honorary hunters. "
	evt.Set("QBits", 37)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
	evt.SetNPCTopic{NPC = 45, Index = 0, Event = 80}         -- "Ebednezer Sower" : "Hunter"
end

-- "Hunter"
evt.global[80] = function()
	evt.SetMessage(179)         -- "Foxed by the Faeries? [Ebednezer snickers, then begins to laugh uproariously at his own wit] Foxed?  Faeries?  Hahahah!  Get it?  Foxed… you know…ah ahahah.  Maybe not.  Well, I've already told you how to become Hunters.  Get inside the Faerie Mound in Avlee.  Now, stop bothering me!  "
end

-- "Bounty Hunter"
evt.global[81] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(182)         -- "Gahhh!  I can smell the stink of self righteousness on you!  Get away from me!  G'won, get!"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(180)         -- "Better a bounty hunter than a plain old hunter, huh?  Well, this test is even simpler than the Faerie Mound idea, and you won't have to think so hard.  Ever notice how the town halls are always looking for someone to kill a monster for them?  All you have to do is collect 10,000 in bounties from town halls.  When you've done that, come back to me, and I'll promote you to Bounty Hunters.  "
		evt.Set("QBits", 38)         -- "Collect 10,000 gold worth of bounties from the Bounty Hunts in the town halls, then return to Ebednezer Sower in the Tularean Forest."
		evt.SetNPCTopic{NPC = 45, Index = 0, Event = 82}         -- "Ebednezer Sower" : "Bounty Hunter"
	else
		evt.SetMessage(181)         -- "I'll be blunt.  I don't think I like you.  You'll have to prove to me you're worth something.  Soon, you will have to choose if you'll follow the Path of Dark or the Path of Light.  If you choose Light, don't even bother speaking to me again.  Got it?"
	end
end

-- "Bounty Hunter"
evt.global[82] = function()
	if not evt.Cmp("MontersHunted", 10000) then
		evt.SetMessage(184)         -- "Not yet, not good enough!  You need to collect more bounties, and more importantly, kill more creatures.  There's some good clean fun in that.  Killing, don't you know."
		return
	end
	evt.SetMessage(183)         -- "So, how did if feel?  All that killing?  Mmmmm.  Heh.  You qualify, my friends.  You definitely qualify.  All Hunters amongst you are now Bounty Hunters, and all Honorary hunters and Honorary Bounty Hunters!  Good job."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.BountyHunter)
		evt.Add("Awards", 32)         -- "Promoted to Bounty Hunter"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 33)         -- "Promoted to Honorary Bounty Hunter"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.BountyHunter)
		evt.Add("Awards", 32)         -- "Promoted to Bounty Hunter"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 33)         -- "Promoted to Honorary Bounty Hunter"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.BountyHunter)
		evt.Add("Awards", 32)         -- "Promoted to Bounty Hunter"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 33)         -- "Promoted to Honorary Bounty Hunter"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Hunter) then
		evt.Set("ClassIs", const.Class.BountyHunter)
		evt.Add("Awards", 32)         -- "Promoted to Bounty Hunter"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 33)         -- "Promoted to Honorary Bounty Hunter"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 38)         -- "Collect 10,000 gold worth of bounties from the Bounty Hunts in the town halls, then return to Ebednezer Sower in the Tularean Forest."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 45, Index = 0, Event = 0}         -- "Ebednezer Sower"
	evt.SetNPCGreeting{NPC = 45, Greeting = 67}         -- "Ebednezer Sower" : "Bounty Hunters.  [Ebednezer smiles slowly and evilly]  Now THERE'S a job!  Yes sir.  Get things done righteo quick, I'll say. Heh."
end

-- "Hunter?"
evt.CanShowTopic[83] = function()
	return evt.Cmp("QBits", 37)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
end

evt.global[83] = function()
	evt.SetMessage(185)         -- "Come to my door looking for magic?  Thee've always had it, if thee knew where to look.  Some I tell this to, and they still can't see it, though it be plain as the nose on their face.  Those amongst thee that are simple Rangers are now Hunters, and those who aren't are but Honorary Hunters.  Clever the ones who can knock on my door!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Ranger) then
		evt.Set("ClassIs", const.Class.Hunter)
		evt.Add("Awards", 28)         -- "Promoted to Hunter"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 29)         -- "Promoted to Honorary Hunter"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Ranger) then
		evt.Set("ClassIs", const.Class.Hunter)
		evt.Add("Awards", 28)         -- "Promoted to Hunter"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 29)         -- "Promoted to Honorary Hunter"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Ranger) then
		evt.Set("ClassIs", const.Class.Hunter)
		evt.Add("Awards", 28)         -- "Promoted to Hunter"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 29)         -- "Promoted to Honorary Hunter"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Ranger) then
		evt.Set("ClassIs", const.Class.Hunter)
		evt.Add("Awards", 28)         -- "Promoted to Hunter"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 29)         -- "Promoted to Honorary Hunter"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 37)         -- "Solve the secret to the entrance of the Faerie Mound in Avlee and speak to the Faerie King."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 45, Index = 0, Event = 81}         -- "Ebednezer Sower" : "Bounty Hunter"
	evt.SetNPCTopic{NPC = 52, Index = 0, Event = 0}         -- "Faerie King"
end

-- "Heart of the Wood"
evt.CanShowTopic[84] = function()
	return evt.Cmp("QBits", 36)         -- "Calm the trees in the Tularean Forest by speaking to the Oldest Tree then return to Lysander Sweet in the Bracada Desert."
end

evt.global[84] = function()
	evt.SetMessage(186)         -- "The thieves reached deep inside me to take my Heart.  The grapevines say they are hiding in the Mercenary Guild in Tatalia.  We would squeeze them, but they aren't close enough to reach.  Walkers are needed to catch walkers.  Catch the thieves for us.  Ok?"
	evt.Set("QBits", 39)         -- "Find the Heart of the Forest in the Mercenary Guild in Tatalia and return it to the Oldest Tree in the Tularean Forest."
	evt.SetNPCTopic{NPC = 53, Index = 0, Event = 85}         -- "The Oldest Tree" : "Heart of the Wood"
end

-- "Heart of the Wood"
evt.global[85] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 600) then         -- "Heart of the Wood"
		evt.SetMessage(187)         -- "Ahhh!  [The tree sighs happily]  You have the heart!  The forest sings with joy!  Tonight we will recite the song of the ancestors.  Will you stay and recite with us?"
		evt.Subtract("Inventory", 600)         -- "Heart of the Wood"
		evt.Subtract("QBits", 217)         -- Heart of Wood - I lost it
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 39)         -- "Find the Heart of the Forest in the Mercenary Guild in Tatalia and return it to the Oldest Tree in the Tularean Forest."
		evt.Set("QBits", 41)         -- Solved Tree quest
		evt.SetNPCTopic{NPC = 53, Index = 0, Event = 0}         -- "The Oldest Tree"
		evt.SetNPCGreeting{NPC = 53, Greeting = 71}         -- "The Oldest Tree" : "Ohhhhh…It's the Walkers from the South.  I remember you!  You returned the Heart.  The trees are very happy, and promise not to kill any more walkers.  Come and talk to me any time."
		evt.Set("Awards", 61)         -- "Retrieved the Heart of the Wood"
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	else
		evt.SetMessage(188)         -- "Oh, the forest is still very angry.  The grapevines say the thieves have not left their hiding place.  You will catch the thieves for us, won't you?"
	end
end

-- "Priest of Light"
evt.global[86] = function()
	if not evt.Cmp("Awards", 62) then         -- "Promoted to Priest"
		if not evt.Cmp("Awards", 63) then         -- "Promoted to Honorary Priest"
			evt.SetMessage(191)         -- "If you wish to become Priests of the Light, you must first become Priests.  I don't have time to train priests, but my bitter rival, Daedalus Falk, does.  Do not worry, he will promote you fairly, even if you do not wish to follow the terrible path of darkness that he represents."
			return
		end
	end
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(189)         --[[ "Priests.  You have come to me seeking that I be your guide on the Path of Light.  But be warned, to learn its ways, you must learn the ways of your own soul.  I would suggest that we meditate on this for awhile, but you look like you're in a hurry.  South of Bracada is an island called Evenmorn, and upon that island are the old temples of the Sun and the Moon.  Both are inhabited by the remnants of the two religions, their once proud churches reduced to two old temples fighting for a small island.

The Church of the Sun was the founding religion for our current faith, the Path of Light.  I propose we help them out and tip the balance in favor of the Church of the Sun.  Using the map that Daedalus Falk sent you to find in order to become priests, convince a sea captain to bring you to the island.  There, bring aid and comfort to the Church of the Sun by purifying the altar in the Church of the Moon.  This will so weaken the Moon cult that the Church of the Sun will be able to overcome them in battle.  Return to me when you have done this.   " ]]
		evt.Set("QBits", 42)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Rebecca Devine in Celeste."
		evt.SetNPCTopic{NPC = 46, Index = 0, Event = 87}         -- "Rebecca Devine" : "Priest of Light"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(192)         -- "You've come to the wrong person if you want to be promoted beyond priest.  I am well aware of your choice to follow the Path of the Dark, and I will have nothing to do with you."
	else
		evt.SetMessage(190)         -- "If you wish to follow the Path of Light, first you must formally choose it.  Soon you will be asked to make the choice, and the way will be clear.  Until then, I cannot be your guide."
	end
end

-- "Priest of Light"
evt.global[87] = function()
	if not evt.Cmp("QBits", 62) then         -- Purified the Altar of Evil.  Priest of Light promo quest.
		evt.SetMessage(194)         -- "You must visit Evenmorn island and purify the Altar of Darkness in the Church of the Moon.  Only then can I promote you to Priests of the Light."
		return
	end
	evt.SetMessage(193)         -- "Your bravery has advanced our faith tremendously, Priests.  It's with a glad heart that I can hereby promote all Priests to Priests of the Light, and all honorary Priests to Honorary Priests of the Light.  Thank you so much for your help!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 64)         -- "Promoted to Priest of the Light"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 65)         -- "Promoted to Honorary Priest of the Light"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 64)         -- "Promoted to Priest of the Light"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 65)         -- "Promoted to Honorary Priest of the Light"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 64)         -- "Promoted to Priest of the Light"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 65)         -- "Promoted to Honorary Priest of the Light"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 64)         -- "Promoted to Priest of the Light"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 65)         -- "Promoted to Honorary Priest of the Light"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 42)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Rebecca Devine in Celeste."
	evt.Add("Gold", 10000)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 46, Index = 0, Event = 0}         -- "Rebecca Devine"
	evt.SetNPCGreeting{NPC = 46, Greeting = 73}         -- "Rebecca Devine" : "Sunlight Reveal, my fellow Priests.  I am always delighted to see you!"
end

-- "Priest"
evt.global[88] = function()
	evt.SetMessage(195)         -- "[Falk gives you a grandfatherly smile] You have, perhaps, an ambition to be priests?  I can help you, if you'll help me.  There is an island south of Bracada where stands an old temple that I need to find again.  I think the pirates west of Erathia must know where the island is.  The Erathian navy is rather feeble, and hasn't been able to root them out of their hiding places amongst the Tidewater Caverns.  Perhaps the pirates have a map.  If you can bring me that map, I would promote you to Priest status immediately."
	evt.Set("QBits", 43)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk in the Deyja Moors."
	evt.SetNPCTopic{NPC = 47, Index = 0, Event = 89}         -- "Daedalus Falk" : "Priest"
end

-- "Priest"
evt.global[89] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 683) then         -- "Map to Evenmorn Island"
		evt.SetMessage(197)         -- "If there is a map that says where that island is, the map would be in the Tidewater Caverns of western Erathia.  When you bring me that map, then I will be happy to promote you all to Priests."
		return
	end
	evt.SetMessage(196)         -- "The Map!  You found it!  [Falk looks at the map, and points at the island] There it is.  The island has been shrouded in mist since the Churches of the Sun and Moon began fighting over a century ago.  Keep the map--I have the coordinates now, and will have no trouble finding the place when I need to.  I am proud to declare the Clerics amongst you to be Priests, and the rest to be honorary Priests.  Thank you so much for your good work!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 62)         -- "Promoted to Priest"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 63)         -- "Promoted to Honorary Priest"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 62)         -- "Promoted to Priest"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 63)         -- "Promoted to Honorary Priest"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 62)         -- "Promoted to Priest"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 63)         -- "Promoted to Honorary Priest"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.Priest)
		evt.Add("Awards", 62)         -- "Promoted to Priest"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 63)         -- "Promoted to Honorary Priest"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 43)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk in the Deyja Moors."
	evt.Add("Gold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 683)         -- "Map to Evenmorn Island"
	evt.Subtract("QBits", 218)         -- Map to Evenmorn - I lost it
	evt.SetNPCTopic{NPC = 47, Index = 0, Event = 90}         -- "Daedalus Falk" : "Priest of Dark"
	evt.Set("QBits", 64)         -- Activate boat to area 9.  Priest promo quest
end

-- "Priest of Dark"
evt.global[90] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(200)         -- "How dare you insult me with your presence?  You have chosen the Path of the Light, and have forever renounced me as your teacher.  Go now, and wallow in your weakness somewhere else."
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(198)         --[[ "Priests.  [Falk gazes coldly at you] Well it is that you have come to see the wisdom of the Path of the Dark.  Never regret your decision, and never look back.  South of Bracada is an island called Evenmorn, and upon that island are the old temples of the Sun and the Moon.  Both are inhabited by the remnants of the two religions, their once proud churches reduced to two old temples fighting for a small island.

The Church of the Moon was the founding religion for our current faith, the Path of Darkness.  I propose we help them out and tip the balance in favor of the Church of the Moon.  Using the map that I sent you to find, convince a sea captain to bring you to the island.  There, bring aid and comfort to the Church of the Moon by defiling the altar in the Church of the Sun.  This will so weaken the Sun cult that the Church of the Moon will be able to overcome them in battle.  Return to me when you have done this.   " ]]
		evt.Set("QBits", 44)         -- "Deface the Altar of Good in the Temple of the Sun on Evenmorn Isle then return to Daedalus Falk in the Deyja Moors."
		evt.SetNPCTopic{NPC = 47, Index = 0, Event = 91}         -- "Daedalus Falk" : "Priest of Dark"
	else
		evt.SetMessage(199)         -- "If you wish to follow the Path of Darkness, first you must formally choose it.  Soon you will be asked to make the choice, and the way will be clear.  Until then, I cannot be your guide."
	end
end

-- "Priest of Dark"
evt.global[91] = function()
	if not evt.Cmp("QBits", 63) then         -- Defaced the Altar of Good.  Priest of Dark promo quest.
		evt.SetMessage(202)         -- "You must visit Evenmorn island and defile the Altar of Light in the Church of the Sun.  Only then can I promote you to Priests of the Dark."
		return
	end
	evt.SetMessage(201)         -- "Your bravery has advanced our faith tremendously, Priests.  It's with pleasure that I can hereby promote all Priests to Priests of the Dark, and all honorary Priests to Honorary Priests of the Dark.  Thank you so much for your help!"
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestDark)
		evt.Add("Awards", 66)         -- "Promoted to Priest of the Dark"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 67)         -- "Promoted to Honorary Priest of the Dark"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestDark)
		evt.Add("Awards", 66)         -- "Promoted to Priest of the Dark"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 67)         -- "Promoted to Honorary Priest of the Dark"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestDark)
		evt.Add("Awards", 66)         -- "Promoted to Priest of the Dark"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 67)         -- "Promoted to Honorary Priest of the Dark"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Priest) then
		evt.Set("ClassIs", const.Class.PriestDark)
		evt.Add("Awards", 66)         -- "Promoted to Priest of the Dark"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 67)         -- "Promoted to Honorary Priest of the Dark"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 44)         -- "Deface the Altar of Good in the Temple of the Sun on Evenmorn Isle then return to Daedalus Falk in the Deyja Moors."
	evt.Add("Gold", 10000)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 47, Index = 0, Event = 0}         -- "Daedalus Falk"
	evt.SetNPCGreeting{NPC = 47, Greeting = 75}         -- "Daedalus Falk" : "Shadow Conceal, Brethren.  My time is always yours."
end

-- "Wizard"
evt.global[92] = function()
	evt.SetMessage(203)         --[[ "I am indeed the one to speak to if you wish to become Wizards.  Every student of mine must complete a project before I name them Wizards.  This year's project is to build a golem.  There are spare parts scattered about the lands from here to Avlee.  You'll need all four limbs plus the torso and the head.  Pay special attention to where you get the head--one of my students made a mistake while making a head last summer and gave the defective head away as a joke.  

When you have all the parts, come talk to me.  I'll promote you to Wizards then, and I'll animate your Golem.  Well, on your way, and have fun!" ]]
	evt.Set("QBits", 45)         -- "Collect the six golem pieces and construct a complete golem, then return to Thomas Grey in the School of Sorcery."
	evt.Set("NPCs", 56)         -- "Golem"
	evt.SetNPCTopic{NPC = 48, Index = 0, Event = 93}         -- "Thomas Grey" : "Wizard"
end

-- "Wizard"
evt.global[93] = function()
	if not evt.Cmp("QBits", 74) then         -- Finished constructing Golem with normal head
		if not evt.Cmp("QBits", 73) then         -- Finished constructing Golem with Abbey normal head
			evt.SetMessage(205)         -- "You have to have all the parts together and properly assembled for me to animate it, students!  I can't animate incomplete golems."
			return
		end
	end
	evt.SetMessage(204)         -- "[You proudly display your assembled golem to Master Grey, and he nods approvingly] Well done.  Head looks alright, but you can never be sure…Well, good work!  Clearly, you qualify for Wizard status.  All Sorcerers amongst you are now Wizards, and all non Sorcerers are now honorary Wizards!  [Master Grey spends awhile casting the spell that animates your golem] He's all yours!  Take him back to your castle and put him where you want.  He'll attack intruders relentlessly.  "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 74)         -- "Promoted to Wizard"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 75)         -- "Promoted to Honorary Wizard"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 74)         -- "Promoted to Wizard"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 75)         -- "Promoted to Honorary Wizard"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 74)         -- "Promoted to Wizard"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 75)         -- "Promoted to Honorary Wizard"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Sorcerer) then
		evt.Set("ClassIs", const.Class.Wizard)
		evt.Add("Awards", 74)         -- "Promoted to Wizard"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 75)         -- "Promoted to Honorary Wizard"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 45)         -- "Collect the six golem pieces and construct a complete golem, then return to Thomas Grey in the School of Sorcery."
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 48, Index = 0, Event = 94}         -- "Thomas Grey" : "Archmage"
	evt.SetNPCGreeting{NPC = 56, Greeting = 84}         -- "Golem" : "I am yours to command, master."
	evt.Set("QBits", 46)         -- Player Castle.  Golem should appear in castle bit.
	evt.Subtract("QBits", 219)         -- Golem Head - I lost it
	evt.Subtract("QBits", 220)         -- Abby normal head - I lost it
end

-- "Archmage"
evt.global[94] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(206)         --[[ "Welcome back, students.  The golem lesson was just an exercise, but to advance to Archmage, you really have to do something for the profession.  Copies of the fabled Divine Intervention spell are very rare, and unfortunately the School doesn't have one.  There's been a history of bad luck regarding the spell.

It has been around for time immemorial, but the spell has never found its way into our hands.  Always just out of reach, we often send guild members to find it, but every one has failed.  Sometimes they have it in their hands, but lose it on the way back, other times, the book seems to vanish, only to resurface 20 years later in some old dungeon, or on a deserted island.  Right now, we think it's in the Breeding Zone in the Pit.  Find the spell, and return with it.  Break the curse!" ]]
		evt.Set("QBits", 47)         -- "Find the Book of Divine Intervention in the Breeding Zone in the Pit and return it to Thomas Grey in the School of Sorcery."
		evt.SetNPCTopic{NPC = 48, Index = 0, Event = 95}         -- "Thomas Grey" : "Archmage"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(208)         -- "You've chosen Darkness, my students.  I will teach you no more."
	else
		evt.SetMessage(207)         -- "Archmage training is reserved only for people dedicated to the Path of Light.  Prove to me you have chosen the right way, and I will be proud to be your teacher."
	end
end

-- "Archmage"
evt.global[95] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 487) then         -- "Divine Intervention"
		evt.SetMessage(210)         -- "I expect trouble finding the book, which is why I'm sending you to find it.  I know you can succeed in this mission.  Keep trying!"
		return
	end
	evt.SetMessage(209)         -- "The book!  The book!  [Master Grey clutches his ears and spins around in joy] You did it!  Oh, what a wonderful day!  I am so proud of you!  You're all Archmages!  Of course, if you weren't Wizards to begin with, it's only an honorary title, but who cares?  You found the book!  [The Master sets the book down on a table next to a blank book.  Both open simultaneously, and quill arises from the desk to begin copying the text in the new book] You may keep the copy, and you should start seeing more copies in the Light guilds of Bracada and Celeste."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 76)         -- "Promoted to Archmage"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 77)         -- "Promoted to Honorary Archmage"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 76)         -- "Promoted to Archmage"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 77)         -- "Promoted to Honorary Archmage"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 76)         -- "Promoted to Archmage"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 77)         -- "Promoted to Honorary Archmage"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.ArchMage)
		evt.Add("Awards", 76)         -- "Promoted to Archmage"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 77)         -- "Promoted to Honorary Archmage"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 47)         -- "Find the Book of Divine Intervention in the Breeding Zone in the Pit and return it to Thomas Grey in the School of Sorcery."
	evt.Subtract("QBits", 226)         -- Book of Divine Intervention - I lost it
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 48, Index = 0, Event = 0}         -- "Thomas Grey"
	evt.SetNPCGreeting{NPC = 48, Greeting = 77}         -- "Thomas Grey" : "I am honored to be graced with your presence, my lords."
end

-- "Lich"
evt.global[96] = function()
	if not evt.Cmp("Awards", 74) then         -- "Promoted to Wizard"
		if not evt.Cmp("Awards", 75) then         -- "Promoted to Honorary Wizard"
			evt.SetMessage(212)         -- "If you haven't even become Wizards yet, you aren't ready to become Liches.  Trouble me not 'til you're qualified."
			return
		end
	end
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(211)         --[[ "Fear not death?  I can perform the Ritual on any Wizard.  You need a Soul Jar.  Years ago the Wizards stole a shipment of Jars en route from Nighon to Deyja.  The jars are very hard to destroy, so they hid them, thinking we would never be able to find them.

Fortunately for us, dead men do indeed tell tales.  Better, in fact, than living ones--dead men never forget, never refuse to talk, and never lie.  So, we found the one who buried the Jars, and made him die.  He was very cooperative after his death, and said he hid them somewhere in the Walls of Mist for the Wizards in Celeste. 

Retrieve these jars and I will perform the Ritual on all Wizards amongst you.  The rest may become Honorary Liches, for what that's worth, in thanks for finding the extra Jars for us." ]]
		evt.Set("QBits", 48)         -- "Retrieve the lich jars from the Proving Grounds in Celeste and bring them back to Halfgild Wynac in the Pit."
		evt.SetNPCTopic{NPC = 49, Index = 0, Event = 97}         -- "Halfgild Wynac" : "Lich"
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(214)         -- "Having chosen the path of Light, you are not suited to become Liches.  The Ritual would reject you, and you would die a real death.  If that is what you want, you certainly don't need my help…"
	else
		evt.SetMessage(213)         -- "Only followers of the Dark Path can become Liches.  You have not yet chosen the path.  Return when you choose Darkness."
	end
end

-- "Lich"
evt.global[97] = function()
	evt.ForPlayer(0)
	if evt.Cmp("Inventory", 615) then         -- "Lich Jar"
		evt.ForPlayer(1)
		if evt.Cmp("Inventory", 615) then         -- "Lich Jar"
			evt.ForPlayer(2)
			if not evt.Cmp("Inventory", 615) then         -- "Lich Jar"
				goto _11
			end
			evt.ForPlayer(3)
			if not evt.Cmp("Inventory", 615) then         -- "Lich Jar"
				goto _11
			end
			evt.SetMessage(215)         -- "Jars.  Yessss.  You have helped us greatly.  Now for the Ritual.  [The Lich draws a knife, and approaches you]  This won't hurt a bit!  [The ritual actually hurts quite a bit, and takes several hours to complete.  When it is over, the Lich speaks again]  So, now it is done.  Those among you who were Wizards are now most certainly Liches.  Those who were not, have my gratitude for returning the jars, and I will call you ""Honorary Liches"".  Remember, Liches must keep their Soul Jars with them at all times while they travel.  You cannot be separated from your Jar for long, or you will die a real death."
			evt.ForPlayer(0)
			if evt.Cmp("ClassIs", const.Class.Wizard) then
				evt.Set("ClassIs", const.Class.Lich)
				evt.Add("Awards", 78)         -- "Promoted to Lich"
				evt.Add("Experience", 80000)
			else
				evt.Add("Awards", 79)         -- "Promoted to Honorary Lich"
				evt.Add("Experience", 40000)
			end
			goto _22
		end
	end
::_11::
	evt.SetMessage(216)         -- "I have no spare Jars with which to perform the Ritual.  It is impossible for me to promote you until you return with the Jars.  Remember, each one of you must have a Jar to be Promoted."
	do return end
::_22::
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 78)         -- "Promoted to Lich"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 79)         -- "Promoted to Honorary Lich"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 78)         -- "Promoted to Lich"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 79)         -- "Promoted to Honorary Lich"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Wizard) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 78)         -- "Promoted to Lich"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 79)         -- "Promoted to Honorary Lich"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 48)         -- "Retrieve the lich jars from the Proving Grounds in Celeste and bring them back to Halfgild Wynac in the Pit."
	evt.Subtract("QBits", 229)         -- Lich Jar (Empty) - I lost it
	evt.Add("Gold", 7500)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
::_51::
	if not evt.Cmp("Inventory", 615) then         -- "Lich Jar"
		evt.SetNPCTopic{NPC = 49, Index = 0, Event = 0}         -- "Halfgild Wynac"
		evt.SetNPCGreeting{NPC = 49, Greeting = 79}         -- "Halfgild Wynac" : "Why do you insist on bothering me?  [The Lich's eyes flare a hellish red for a moment] "
		return
	end
	evt.Subtract("Inventory", 615)         -- "Lich Jar"
	goto _51
end

-- "Great Druid"
evt.global[98] = function()
	evt.SetMessage(217)         -- "Advancement as a Druid is simple.  You must visit the three ancient temples to nature we erected centuries ago and pray at their centers.  They are in Tatalia, Evenmorn Isle, and Avlee, and look like circles of stone with an altar of water in their centers.  Where exactly I will not say, but exploring the land about them is part of the process.  When you have visited all three Circles, return to me to detail your experience."
	evt.Set("QBits", 49)         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
	evt.SetNPCTopic{NPC = 50, Index = 0, Event = 99}         -- "Anthony Green" : "Great Druid"
end

-- "Great Druid"
evt.global[99] = function()
	if evt.Cmp("QBits", 50) then         -- Visited all stonehenges
		evt.SetMessage(220)         -- "I have only to look into your eyes to see where you've been.  You have seen the circles, and they have left their imprint upon you.  Telling you that all Druids amongst you are now Great Druids is but a formality.  Telling the rest of you that you're now honorary Druids is showing you respect for the respect you have shown me and my faith.  "
		evt.ForPlayer(0)
		if evt.Cmp("ClassIs", const.Class.Druid) then
			evt.Set("ClassIs", const.Class.GreatDruid)
			evt.Add("Awards", 68)         -- "Promoted to Great Druid"
			evt.Add("Experience", 30000)
		else
			evt.Add("Awards", 69)         -- "Promoted to Honorary Great Druid"
			evt.Add("Experience", 15000)
		end
		goto _17
	end
	if not evt.Cmp("QBits", 51) then         -- Visited stonehenge 1 (area 9)
		if not evt.Cmp("QBits", 52) then         -- Visited stonehenge 2 (area 13)
			if not evt.Cmp("QBits", 53) then         -- Visited stonehenge 3 (area 14)
				evt.SetMessage(218)         -- "Visit the Circles, then return to me.  That is the process.  "
				return
			end
		end
	end
	evt.SetMessage(219)         -- "You've found a circle!  Very good, but you must find all three before you will be ready for promotion.  Remember, circles three, then return to me."
	do return end
::_17::
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 68)         -- "Promoted to Great Druid"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 69)         -- "Promoted to Honorary Great Druid"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 68)         -- "Promoted to Great Druid"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 69)         -- "Promoted to Honorary Great Druid"
		evt.Add("Experience", 15000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Druid) then
		evt.Set("ClassIs", const.Class.GreatDruid)
		evt.Add("Awards", 68)         -- "Promoted to Great Druid"
		evt.Add("Experience", 30000)
	else
		evt.Add("Awards", 69)         -- "Promoted to Honorary Great Druid"
		evt.Add("Experience", 15000)
	end
	evt.Subtract("QBits", 49)         -- "Visit the three stonehenge monoliths in Tatalia, the Evenmorn Islands, and Avlee, then return to Anthony Green in the Tularean Forest."
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 50, Index = 0, Event = 100}         -- "Anthony Green" : "Arch Druid"
end

-- "Arch Druid"
evt.global[100] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(221)         --[[ "To be named an Arch Druid, you must serve the land.  I know of a service you could perform.  In the land above Stone City, where the Dwarves bury their dead, is the barrow of King Zokarr IV.  He died fighting in defense of Stone City during the invasion of Erathia by Nighon.  His remains were never recovered and still lie in those tunnels.    

Retrieve his bones and place them in his coffin in his barrow.  When you have done this, the King will rest, and so will the land.  Return to me when you've performed this service, and I will perform the Ceremony of Ascension and name you Arch Druids." ]]
		evt.Set("QBits", 54)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
		evt.SetNPCTopic{NPC = 50, Index = 0, Event = 101}         -- "Anthony Green" : "Arch Druid"
	elseif evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(223)         -- "Servants of Darkness, I am sorry I promoted you earlier.  I am ashamed I didn't notice the darkness in your souls until it was too late.  Leave me."
	else
		evt.SetMessage(222)         -- "I am dedicated to the service of the Light.  I will not promote you further until you are as dedicated as I.  Come back to me when you choose the Light."
	end
end

-- "Arch Druid"
evt.global[101] = function()
	if not evt.Cmp("QBits", 65) then         -- Barrow downs.   Returned the bones of the Dwarf King.  Arch Druid promo quest.
		evt.SetMessage(225)         -- "The Service is not easy, but it needs to be done.  Remember, you must bring the bones of King Zokarr IV from where they lie in the tunnels between Stone City and Nighon to Zokarr's coffin in a secret dwarven barrow.  Only then can I perform the Ceremony of Ascension and promote you."
		return
	end
	evt.SetMessage(224)         --[[ "[Master Green seems beside himself with joy at your accomplishment] I felt the King's soul return to the land of the dead when you returned his bones.  The land breathed a sigh of relief--did you feel it?  

The Ceremony of Ascension is complete.  I'm happy to promote all Great Druids amongst you to Arch Druids, and all honorary Great Druids to Honorary Arch Druids.  This is a very happy day!  Your service will be remembered!" ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 70)         -- "Promoted to Arch Druid"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 71)         -- "Promoted to Honorary Arch Druid"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 70)         -- "Promoted to Arch Druid"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 71)         -- "Promoted to Honorary Arch Druid"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 70)         -- "Promoted to Arch Druid"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 71)         -- "Promoted to Honorary Arch Druid"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.ArchDruid)
		evt.Add("Awards", 70)         -- "Promoted to Arch Druid"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 71)         -- "Promoted to Honorary Arch Druid"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 54)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 50, Index = 0, Event = 0}         -- "Anthony Green"
	evt.SetNPCGreeting{NPC = 50, Greeting = 81}         -- "Anthony Green" : "Fortune be your friend, lords.  Do you seek my advice today?"
end

-- "Warlock"
evt.global[102] = function()
	if not evt.Cmp("Awards", 68) then         -- "Promoted to Great Druid"
		if not evt.Cmp("Awards", 69) then         -- "Promoted to Honorary Great Druid"
			evt.SetMessage(227)         -- "I would love to get you started on the way to becoming Warlocks, but nothing I can do for you will be of any use until you become Great Druids.  Return when you have achieved that level of understanding."
			return
		end
	end
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(226)         --[[ "Becoming a Warlock for some is a simple process, and for others it is nearly impossible.  You need to find a familiar suited to your personality.  The familiar will help to focus your magical abilities and sharpen your concentration.  Sometimes a single familiar can be shared, other times not.  The magical effects will not be noticed by anyone but a Great Druid--someone who is already attuned to nature.  Now, let me see what kind of familiar you will need...[Tor picks up an elaborately carved gem and peers at you through it.  He frowns.]  Hmm.  Well, the good news is that you all need the same familiar, and when you find it, you will be very powerful.  The bad news is that you need to find a dragon familiar.  

You must find a dragon egg.  Bring them back here and I will hatch it, and cast the familiar spell.  The baby dragon will imprint to you all, and you to it.  You may be able to find an egg in a dragon cave in the Land of the Giants.  'Ware the mother, though." ]]
		evt.Set("QBits", 55)         -- "Retrieve the dragon egg from the Dragon Cave in the Land of the Giants and return it to Tor Anwyn in Mount Nighon."
		evt.SetNPCTopic{NPC = 51, Index = 0, Event = 103}         -- "Tor Anwyn" : "Warlock"
	elseif evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(229)         -- "Hmmmm.  [Tor looks at you carefully]  Nope.  Can't teach you.  You chose the Path of Light.  I can smell it on you.  I can sympathize with your choice, but I know that none of our spells or rituals can promote you once you have started down that path.  Sorry."
	else
		evt.SetMessage(228)         -- "Though I like to think of the Warlocks as being followers of the Path of Twilight, or Dawn, we are technically followers of the Path of Darkness.  You must be dedicated followers of Darkness before I can help you.  "
	end
end

-- "Warlock"
evt.global[103] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 647) then         -- "Dragon Egg"
		evt.SetMessage(231)         -- "You need to bring me a dragon's egg so you I can hatch your familiar.  There is no way around this.  Try looking in the Land of the Giants for a dragon cave-- perhaps there you can find an egg."
		return
	end
	evt.SetMessage(230)         -- "[Tor looks at you in astonishment] You really found a dragon egg!  It's been more than a century since any Warlock has both needed and found a dragon familiar!  This will go down in the history books, that's for sure!  My spell book!  I need my book!  Ah, here it is.  [Tor chants a spell from the book, then taps the egg three times.  The egg hatches, and a baby dragon crawls out of the shell]  There you are!  Awww, isn't he cute?  Congratulations!  No longer are you simple Great Druids, but Warlocks!  Of course, that's just an honorary title if you weren't a natural Great Druid to begin with, but nonetheless, something to be proud of.  "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.Warlock)
		evt.Add("Awards", 72)         -- "Promoted to Warlock"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 73)         -- "Promoted to Honorary Warlock"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.Warlock)
		evt.Add("Awards", 72)         -- "Promoted to Warlock"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 73)         -- "Promoted to Honorary Warlock"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.Warlock)
		evt.Add("Awards", 72)         -- "Promoted to Warlock"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 73)         -- "Promoted to Honorary Warlock"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.GreatDruid) then
		evt.Set("ClassIs", const.Class.Warlock)
		evt.Add("Awards", 72)         -- "Promoted to Warlock"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 73)         -- "Promoted to Honorary Warlock"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 55)         -- "Retrieve the dragon egg from the Dragon Cave in the Land of the Giants and return it to Tor Anwyn in Mount Nighon."
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 647)         -- "Dragon Egg"
	evt.Subtract("QBits", 227)         -- Dragon Egg - I lost it
	evt.SetNPCTopic{NPC = 51, Index = 0, Event = 0}         -- "Tor Anwyn"
	evt.SetNPCGreeting{NPC = 50, Greeting = 83}         -- "Anthony Green" : "A delight and a pleasure, lords.  Have you come for business or conversation?"
	evt.Set("NPCs", 57)         -- "Baby Dragon"
end

-- "Golem Parts"
evt.global[104] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 66) then         -- Placed Golem torso
		if evt.Cmp("Inventory", 639) then         -- "Golem chest"
			evt.Add("QBits", 66)         -- Placed Golem torso
			evt.Subtract("Inventory", 639)         -- "Golem chest"
			evt.Subtract("QBits", 225)         -- Torso - I lost it
			evt.SetMessage(232)         -- "You prepare the torso for assembly with the rest of the parts."
			return
		end
	end
	if not evt.Cmp("QBits", 67) then         -- Placed Golem left leg
		if evt.Cmp("Inventory", 642) then         -- "Golem left leg"
			evt.Subtract("Inventory", 642)         -- "Golem left leg"
			evt.Subtract("QBits", 224)         -- Left leg - I lost it
			evt.Add("QBits", 67)         -- Placed Golem left leg
			evt.SetMessage(233)         -- "You prepare the left leg for assembly with the rest of the parts."
			return
		end
	end
	if not evt.Cmp("QBits", 68) then         -- Placed Golem right leg
		if evt.Cmp("Inventory", 643) then         -- "Golem right leg"
			evt.SetMessage(234)         -- "You prepare the right leg for assembly with the rest of the parts."
			evt.Subtract("Inventory", 643)         -- "Golem right leg"
			evt.Subtract("QBits", 223)         -- Right leg - I lost it
			evt.Add("QBits", 68)         -- Placed Golem right leg
			return
		end
	end
	if not evt.Cmp("QBits", 69) then         -- Placed Golem left arm
		if evt.Cmp("Inventory", 645) then         -- "Golem left arm"
			evt.SetMessage(235)         -- "You prepare the left arm for assembly with the rest of the parts."
			evt.Subtract("Inventory", 645)         -- "Golem left arm"
			evt.Subtract("QBits", 222)         -- Left arm - I lost it
			evt.Add("QBits", 69)         -- Placed Golem left arm
			return
		end
	end
	if not evt.Cmp("QBits", 70) then         -- Placed Golem left leg
		if evt.Cmp("Inventory", 644) then         -- "Golem right arm"
			evt.SetMessage(236)         -- "You prepare the right arm for assembly with the rest of the parts."
			evt.Subtract("Inventory", 644)         -- "Golem right arm"
			evt.Subtract("QBits", 221)         -- Right arm - I lost it
			evt.Add("QBits", 70)         -- Placed Golem left leg
			return
		end
	end
	if evt.Cmp("QBits", 71) then         -- Placed Golem head
		goto _71
	end
	if evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
		goto _71
	end
	if evt.Cmp("Inventory", 641) then         -- "Golem head"
		evt.SetMessage(237)         -- "You prepare the head for assembly with the rest of the parts."
		evt.Subtract("Inventory", 641)         -- "Golem head"
		evt.Subtract("QBits", 219)         -- Golem Head - I lost it
		evt.Add("QBits", 71)         -- Placed Golem head
		return
	end
	if evt.Cmp("QBits", 71) then         -- Placed Golem head
		goto _71
	end
	if evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
		goto _71
	end
	if evt.Cmp("Inventory", 640) then         -- "Abbey Normal Golem Head"
		evt.SetMessage(238)         -- "You prepare the head (with a dent in it) for assembly with the rest of the parts."
		evt.Subtract("Inventory", 640)         -- "Abbey Normal Golem Head"
		evt.Subtract("QBits", 220)         -- Abby normal head - I lost it
		evt.Add("QBits", 72)         -- Placed Golem Abbey normal head
		return
	end
::_92::
	evt.SetMessage(239)         -- "You have no parts to assemble yet."
	do return end
::_71::
	if evt.Cmp("QBits", 66) then         -- Placed Golem torso
		if evt.Cmp("QBits", 67) then         -- Placed Golem left leg
			if evt.Cmp("QBits", 68) then         -- Placed Golem right leg
				if evt.Cmp("QBits", 69) then         -- Placed Golem left arm
					if evt.Cmp("QBits", 70) then         -- Placed Golem left leg
						if evt.Cmp("QBits", 71) then         -- Placed Golem head
							evt.Add("QBits", 74)         -- Finished constructing Golem with normal head
							evt.SetMessage(240)         -- "You have all the parts together!  Now you just have to return to Master Grey for the animation process."
							evt.SetNPCTopic{NPC = 56, Index = 1, Event = 0}         -- "Golem"
							return
						end
						if evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
							evt.Add("QBits", 73)         -- Finished constructing Golem with Abbey normal head
							evt.SetMessage(240)         -- "You have all the parts together!  Now you just have to return to Master Grey for the animation process."
							evt.SetNPCTopic{NPC = 56, Index = 1, Event = 0}         -- "Golem"
							return
						end
					end
				end
			end
		end
	end
	goto _92
end

evt.CanShowTopic[104] = function()
	if not evt.Cmp("QBits", 73) then         -- Finished constructing Golem with Abbey normal head
		return not evt.Cmp("QBits", 74)         -- Finished constructing Golem with normal head
	end
	return false
end

-- "Swap Heads"
evt.global[105] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 640) then         -- "Abbey Normal Golem Head"
		evt.Subtract("Inventory", 640)         -- "Abbey Normal Golem Head"
		evt.Subtract("QBits", 220)         -- Abby normal head - I lost it
		evt.ForPlayer("Current")
		evt.Add("Inventory", 641)         -- "Golem head"
		evt.Add("QBits", 219)         -- Golem Head - I lost it
		evt.Subtract("QBits", 71)         -- Placed Golem head
		evt.Add("QBits", 72)         -- Placed Golem Abbey normal head
		evt.SetMessage(241)         -- "You remove the normal head and replace it with the dented head."
	elseif evt.Cmp("Inventory", 641) then         -- "Golem head"
		evt.Subtract("Inventory", 641)         -- "Golem head"
		evt.Subtract("QBits", 219)         -- Golem Head - I lost it
		evt.ForPlayer("Current")
		evt.Add("Inventory", 640)         -- "Abbey Normal Golem Head"
		evt.Add("QBits", 220)         -- Abby normal head - I lost it
		evt.Subtract("QBits", 72)         -- Placed Golem Abbey normal head
		evt.Add("QBits", 71)         -- Placed Golem head
		evt.SetMessage(242)         -- "You remove the dented head and replace it with the normal head."
	else
		evt.SetMessage(243)         -- "You should not be reading this message.  This means that you somehow have triggered this event without holding the normal or Abbey normal Golem heads which, based on the preconditions for this event, is absolutely impossible.  Please tell Bryan that he lost his bet and owes Keith 5 bucks because this event doesn't work properly."
	end
end

evt.CanShowTopic[105] = function()
	if evt.Cmp("QBits", 71) then         -- Placed Golem head
		return evt.Cmp("Inventory", 640)         -- "Abbey Normal Golem Head"
	elseif not evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
		return false
	else
		return evt.Cmp("Inventory", 641)         -- "Golem head"
	end
end

-- "Goblins"
evt.global[106] = function()
	if evt.Cmp("QBits", 135) then         -- Player castle goblins are all dead
		evt.SetMessage(244)         -- "Thank heavens you've cleaned them out!  Now we need to find a way to clean up the castle and rebuild the damaged sections.  The only people I can think of who would have the inclination and the ability to do this are the Dwarves in Stone City, located in the Barrow Downs to the south.  The entrance to Stone City lies in the center of the Barrow Downs on one of the largest hills.  "
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 75)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
		evt.Add("Awards", 4)         -- "Removed goblins from Castle Harmondale"
		evt.MoveNPC{NPC = 58, HouseId = 174}         -- "Butler" -> "Throne Room"
		evt.SetNPCTopic{NPC = 58, Index = 0, Event = 0}         -- "Butler"
		evt.SetNPCGreeting{NPC = 58, Greeting = 86}         -- "Butler" : "You rang, my lords?"
		evt.Set("QBits", 146)         -- "Talk to the Dwarves in Stone City in the Barrow Downs to find a way to repair Castle Harmondale."
	else
		evt.SetMessage(245)         -- "I fear that talking will fail with these goblins, my lords.  May I suggest violence?"
	end
end

-- "Rescue Dwarves"
evt.global[107] = function()
	evt.SetMessage(246)         --[[ "So…The new lords of Harmondale I have before me.  Not impressed.  Doubt other kings think much of you either.  Hrmph.  Probably get yourselves killed soon.  But maybe there's more than meets the eye here.  Yes.  Maybe you can do something for me, and I for you.  Medusas have taken my mines in eastern Bracada.  Turned a few of my people to stone.  Dangerous monsters, don't want to lose more lives on a rescue.  Ok to lose yours though.  

Take this elixir and pour it on the statues.  Wake them up.  Then I will fix up your castle.  Give you respect.  Go now, and beware the griffins in Bracada.  " ]]
	evt.Set("QBits", 76)         -- "Rescue the dwarves from the Red Dwarf Mines and return to the Dwarf King in Stone City in the Barrow Downs."
	evt.Subtract("QBits", 146)         -- "Talk to the Dwarves in Stone City in the Barrow Downs to find a way to repair Castle Harmondale."
	evt.Add("Inventory", 629)         -- "Elixir"
	evt.Add("QBits", 230)         -- Elixir - I lost it
	evt.SetNPCTopic{NPC = 59, Index = 0, Event = 108}         -- "Hothfarr IX" : "Rescue Dwarves"
end

-- "Rescue Dwarves"
evt.global[108] = function()
	if evt.Cmp("NPCs", 60) then         -- "Drathen Keldin"
		if evt.Cmp("NPCs", 61) then         -- "Jaycen Keldin"
			if evt.Cmp("NPCs", 62) then         -- "Yarrow Keldin"
				if evt.Cmp("NPCs", 63) then         -- "Fausil Keldin"
					if evt.Cmp("NPCs", 64) then         -- "Red Keldin"
						if evt.Cmp("NPCs", 65) then         -- "Thom Keldin"
							if evt.Cmp("NPCs", 66) then         -- "Arvin Keldin"
								evt.SetMessage(247)         --[[ "Welcome back, Lords of Harmondale!  Now, I will help you.  My engineer will work for you.  Fix up your castle.  You have my thanks.  You are welcome here forever.

Hmmph.  One more thing.  Your work has interested the other courts.  They will send ambassadors to you now--check your throne room.  Watch your back, my friends." ]]
								evt.Add("History4", 0)
								evt.Add("Gold", 5000)
								evt.Subtract("QBits", 76)         -- "Rescue the dwarves from the Red Dwarf Mines and return to the Dwarf King in Stone City in the Barrow Downs."
								evt.Subtract("Reputation", 5)
								evt.ForPlayer("All")
								evt.Add("Awards", 5)         -- "Rescued the dwarves from the Red Dwarf Mine"
								evt.Add("Experience", 12500)
								evt.Subtract("Inventory", 629)         -- "Elixir"
								evt.Subtract("QBits", 230)         -- Elixir - I lost it
								evt.Set("QBits", 98)         -- Built Castle to Level 2 (rescued dwarf guy)
								evt.Subtract("NPCs", 60)         -- "Drathen Keldin"
								evt.MoveNPC{NPC = 60, -- ERROR: Not found
HouseId = 999}         -- "Drathen Keldin"
								evt.MoveNPC{NPC = 67, HouseId = 174}         -- "Ellen Rockway" -> "Throne Room"
								evt.MoveNPC{NPC = 68, HouseId = 174}         -- "Alain Hani" -> "Throne Room"
								evt.Subtract("NPCs", 61)         -- "Jaycen Keldin"
								evt.Subtract("NPCs", 62)         -- "Yarrow Keldin"
								evt.Subtract("NPCs", 63)         -- "Fausil Keldin"
								evt.Subtract("NPCs", 64)         -- "Red Keldin"
								evt.Subtract("NPCs", 65)         -- "Thom Keldin"
								evt.Subtract("NPCs", 66)         -- "Arvin Keldin"
								evt.SetNPCTopic{NPC = 59, Index = 0, Event = 0}         -- "Hothfarr IX"
								evt.SetNPCGreeting{NPC = 59, Greeting = 88}         -- "Hothfarr IX" : "Welcome, Harmondale!  Stone city is at your disposal."
								return
							end
						end
					end
				end
			end
		end
	end
	evt.SetMessage(248)         -- "Back again, eh?  Your part of the bargain isn't finished.  No help 'til you're done.  "
end

-- "Use Elixir"
evt.CanShowTopic[109] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[109] = function()
	evt.Set("NPCs", 60)         -- "Drathen Keldin"
	evt.SetNPCGreeting{NPC = 60, Greeting = 89}         -- "Drathen Keldin" : "Thanks for rescuing me.  I am at your service."
end

-- "Use Elixir"
evt.CanShowTopic[110] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[110] = function()
	evt.Set("NPCs", 61)         -- "Jaycen Keldin"
	evt.SetNPCGreeting{NPC = 61, Greeting = 90}         -- "Jaycen Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[111] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[111] = function()
	evt.Set("NPCs", 62)         -- "Yarrow Keldin"
	evt.SetNPCGreeting{NPC = 62, Greeting = 90}         -- "Yarrow Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[112] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[112] = function()
	evt.Set("NPCs", 63)         -- "Fausil Keldin"
	evt.SetNPCGreeting{NPC = 63, Greeting = 90}         -- "Fausil Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[113] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[113] = function()
	evt.Set("NPCs", 64)         -- "Red Keldin"
	evt.SetNPCGreeting{NPC = 64, Greeting = 90}         -- "Red Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[114] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[114] = function()
	evt.Set("NPCs", 65)         -- "Thom Keldin"
	evt.SetNPCGreeting{NPC = 65, Greeting = 90}         -- "Thom Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "Use Elixir"
evt.CanShowTopic[115] = function()
	return evt.Cmp("Inventory", 674)         -- "Elixir Placeholder"
end

evt.global[115] = function()
	evt.Set("NPCs", 66)         -- "Arvin Keldin"
	evt.SetNPCGreeting{NPC = 66, Greeting = 90}         -- "Arvin Keldin" : "Thanks for rescuing me.  I owe you my life."
end

-- "An invitation…"
evt.global[116] = function()
	if not evt.Cmp("QBits", 88) then         -- Talked to Catherine
		evt.SetMessage(249)         -- "Your Queen wishes to speak with you as soon as possible.  Since the War, she has taken up residence at Gryphonheart Castle in Steadwick.  This is strictly business--whenever new lords assume their office she meets with them to make sure there are no misunderstandings.  Queen Catherine is particularly interested in you, and has told me she wishes to employ your services."
	elseif evt.Cmp("QBits", 81) then         -- Gave Loren to Catherine
		evt.SetMessage(251)         -- "The queen is very pleased with you!  The rescue operation went well, and Loren can no longer be held as a bargaining chip for that wicked King Parson!  When the current Harmondale conflict is over, I'm sure the Queen will reward you for your aid."
	else
		evt.SetMessage(250)         -- "I've received word that you met with the Queen.  I hope it went well."
	end
end

-- "False Plans"
evt.CanShowTopic[117] = function()
	return evt.Cmp("QBits", 82)         -- Gave false plans to elfking (betray)
end

evt.global[117] = function()
	evt.SetMessage(252)         -- "The Queen tells me your loyalty is very strong.  You did the right thing when you informed the Queen of the treachery King Parson was plotting.  And I'll tell you this:  Your loyalty is not only strong, but it is well placed.  Harmondale is the rightful province of Erathia, despite Elvish claims to the contrary.  Your work for us helps to ensure that Harmondale will forever be in the hands of Humans."
end

-- "Artifact"
evt.CanShowTopic[118] = function()
	return evt.Cmp("Inventory", 634)         -- "Gryphonheart's Trumpet"
end

evt.global[118] = function()
	evt.SetMessage(253)         -- "[Lady Ellen gasps in delight] You have Gryphonheart's Trumpet!  This is wonderful!  When it disappeared from the strongbox, we thought it had been stolen by the enemy!  Thank you for bringing it back to us!"
	evt.Add("Gold", 5000)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 634)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 84)         -- Gave artifact to humans
	evt.SetNPCTopic{NPC = 67, Index = 2, Event = 0}         -- "Ellen Rockway"
end

-- "Betrayed?"
evt.CanShowTopic[119] = function()
	return evt.Cmp("QBits", 83)         -- Gave false Loren to Catherine (betray)
end

evt.global[119] = function()
	evt.SetMessage(255)         -- "I've learned from Queen Catherine that you betrayed us with the old false prisoner trick.  [Lady Ellen curtsies respectfully] Your skills in the art of deception are formidable.  I will be sure not to be tricked so easily by your sincere manner again."
end

-- "An invitation…"
evt.global[120] = function()
	if not evt.Cmp("QBits", 89) then         -- Talked to elfking
		evt.SetMessage(256)         -- "Though Avlee is not currently in charge of Harmondale, my King, Eldrich Parson of Avlee, lays claim to this territory as our rightful domain.  The reasons are complicated, but boil down to the simple fact that Erathia stole our land in the Timber Wars many years ago, and we will not give up until we have it back.  My King wishes to speak with you.  Please travel to Pierpont in the Tularean Forest and meet with him.  We will make it worth your while."
	elseif evt.Cmp("QBits", 80) then         -- Gave plans to elfking
		evt.SetMessage(258)         -- "I've heard of your daring infiltration of Fort Riverstride, and I am impressed!  Our strategists are analyzing the plans now, and they say the information will be very useful in any assault they mount against the Fort.  You have Avlee's gratitude!"
	else
		evt.SetMessage(257)         -- "Messengers have informed me of your visit with my King.  I hope you can see now why we are the rightful rulers of Harmondale.  "
	end
end

-- "False Prisoner"
evt.CanShowTopic[121] = function()
	return evt.Cmp("QBits", 83)         -- Gave false Loren to Catherine (betray)
end

evt.global[121] = function()
	evt.SetMessage(259)         -- "Word from Court is that you rejected a request from Erathia to break that spy Loren Steel out of prison.  Not only that, you helped us plant a false prisoner who has been feeding them misinformation ever since he got there.  Avlee is in your debt!"
end

-- "Artifact"
evt.CanShowTopic[122] = function()
	return evt.Cmp("Inventory", 634)         -- "Gryphonheart's Trumpet"
end

evt.global[122] = function()
	evt.SetMessage(260)         -- "You have Gryphonheart's Trumpet!  Excellent!  We lost track of it during the raid, and were afraid that one of the Erathians got away with it.  Thank you very much for your help!"
	evt.Add("Gold", 5000)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 634)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 85)         -- Gave artifact to elves
	evt.SetNPCTopic{NPC = 68, Index = 2, Event = 0}         -- "Alain Hani"
end

-- "Betrayed?"
evt.CanShowTopic[123] = function()
	return evt.Cmp("QBits", 82)         -- Gave false plans to elfking (betray)
end

evt.global[123] = function()
	evt.SetMessage(262)         -- "I've received a warning from my superiors regarding your delivery of falsified plans from Erathia.  The King is not amused. And there was some concern that you had more treachery in store for us.  [Alain smiles, true to his profession] All's fair in love and war, so it's all water under the bridge, eh?  Yes, all is forgotten.  [The ambassador chuckles heartily].  "
end

-- "Prisoner of War"
evt.global[124] = function()
	evt.SetMessage(263)         --[[ "[Queen Catherine inclines her head regally] You are the lot that won Lord Markham's silly contest, I see.  I must admit I had little faith until the Dwarf King recognized you as the rightful rulers of Harmondale.  You must have done something to win his respect, or he would have nothing to do with you.  I'm still not sure what he saw in you, but perhaps there really is something of substance here.  We shall see.

Maybe you can do something for me that would make me think I should let you keep your new titles.  Recently, a valuable...agent of mine was arrested in the Tularean Forest for merely doing his job.  They're keeping him in a cave somewhere outside of Pierpont.  His name is Loren Steel, and they are threatening to execute him if certain unacceptable conditions are not met in 28 days.  Return with him before then and you will win respect, gold, and gratitude." ]]
	evt.SetNPCTopic{NPC = 69, Index = 0, Event = 125}         -- "Queen Catherine" : "Prisoner of War"
	evt.Add("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
	evt.Add("QBits", 88)         -- Talked to Catherine
	evt.Set("Counter1", 0)
end

-- "Prisoner of War"
evt.global[125] = function()
	if evt.Cmp("Counter1", 672) then
		evt.SetMessage(273)         -- "Well, time ran out for poor Loren.  He was executed for espionage by Avlee on schedule.  Don't bother with the rescue.  He's gone."
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 1, Event = 0}         -- "Queen Catherine"
		evt.Subtract("NPCs", 71)         -- "Loren Steel"
		evt.Subtract("NPCs", 72)         -- "Fake Loren"
		evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
		evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
	elseif evt.Cmp("NPCs", 71) then         -- "Loren Steel"
		evt.SetMessage(264)         -- "[Catherine stands and smiles] Good job!  You've really solved a terrible dilemma for me.  [Catherine turns to Loren and shakes his hand] Loren.  It's good to meet you at last.  Since everyone knows who you are now, you're not much good to me as a spy, but I would like to offer you a job in the Royal Diplomatic Corps.  Please give it some thought.  As for our heroes, you have my thanks.  My purser will credit your bank account with 5000 gold pieces for your services.   "
		evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
		evt.Add("QBits", 81)         -- Gave Loren to Catherine
		evt.ForPlayer("Current")
		evt.Add("BankGold", 5000)
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 6)         -- "Rescued Loren Steel"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 1, Event = 0}         -- "Queen Catherine"
		evt.Subtract("NPCs", 71)         -- "Loren Steel"
		evt.Subtract("NPCs", 72)         -- "Fake Loren"
	elseif evt.Cmp("NPCs", 72) then         -- "Fake Loren"
		evt.SetMessage(266)         -- "[Catherine stands and smiles] Good job!  You've really solved a terrible dilemma for me.  [Catherine turns to the false Loren and shakes his hand] Loren.  It's good to meet you at last.  Since everyone knows who you are now, you're not much good to me as a spy, but I would like to offer you a job in the Royal Diplomatic Corps.  Please give it some thought.  As for our heroes, you have my thanks.   "
		evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
		evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
		evt.Add("QBits", 83)         -- Gave false Loren to Catherine (betray)
		evt.Add("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Awards", 7)         -- "Gave Loren Imposter to Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 1, Event = 0}         -- "Queen Catherine"
		evt.Subtract("NPCs", 71)         -- "Loren Steel"
		evt.Subtract("NPCs", 72)         -- "Fake Loren"
	else
		evt.SetMessage(265)         -- "Loren's life is on the line.  I cannot give into the Elvish demands, or many more lives will be lost.  Please hurry.  I'm sure Avlee will execute him on schedule."
	end
end

-- "Here's a fake prisoner…"
evt.CanShowTopic[126] = function()
	return evt.Cmp("NPCs", 72)         -- "Fake Loren"
end

evt.global[126] = function()
	evt.SetMessage(267)         -- "[The Queen's eyes narrow] What's this?  You're admitting to treachery?  How noble.  Guards!  Off with their heads!"
	evt.Subtract("NPCs", 71)         -- "Loren Steel"
	evt.Subtract("NPCs", 72)         -- "Fake Loren"
	evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
	evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
	evt.Set("QBits", 90)         -- Told Catherine about fake prisoner
	evt.SetNPCTopic{NPC = 69, Index = 0, Event = 0}         -- "Queen Catherine"
	evt.SetNPCTopic{NPC = 69, Index = 1, Event = 0}         -- "Queen Catherine"
	evt.ForPlayer(0)
	evt.Set("Dead", 1)
	evt.ForPlayer(1)
	evt.Set("Dead", 1)
	evt.ForPlayer(2)
	evt.Set("Dead", 1)
	evt.ForPlayer(3)
	evt.Set("Dead", 1)
end

-- "Riverstride plans"
evt.CanShowTopic[127] = function()
	if not evt.Cmp("QBits", 77) then         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
		return false
	end
	if not evt.Cmp("QBits", 92) then         -- Fort Riverstride.  Opened chest with plans
		return not evt.Cmp("Counter2", 672)
	end
	return false
end

evt.global[127] = function()
	evt.SetMessage(268)         -- "King Parson asked you to steal the floor plan to Fort Riverstride?  Hmmm.  [Catherine turns to one of her advisors] Have some false plans of Fort Riverstride drawn up.  Make it painful.  [She turns back to you] If it's plans he wants, it's plans he'll get.  Give these plans to the King.  I'm sure he'll be grateful.  Make sure you don't let him know they're fake.  [After awhile the advisor returns with the plans and gives them to you]  You'll need to get the plans back to him on time, of course.  I'm sure he plans to attack us soon."
	evt.SetNPCTopic{NPC = 69, Index = 2, Event = 128}         -- "Queen Catherine" : "Riverstride plans"
	evt.Set("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.Add("Inventory", 706)         -- "False Riverstride Plans"
	evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
end

-- "Riverstride plans"
evt.global[128] = function()
	if evt.Cmp("QBits", 82) then         -- Gave false plans to elfking (betray)
		evt.SetMessage(269)         -- "He took the plans?  Excellent!  I'll have the Riverstride commander roll out the red carpet for them.  As for you, I've instructed my purser to deposit 5,000 gold pieces in your account."
		evt.Subtract("Reputation", 5)
		evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("BankGold", 5000)
		evt.SetNPCTopic{NPC = 69, Index = 2, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 3, Event = 0}         -- "Queen Catherine"
	elseif evt.Cmp("QBits", 91) then         -- Told Elfking about fake plans
		evt.SetMessage(271)         -- "You told the king the plans were fake?!?  [The Queen puts her hand on her head, jaw agape] I have never seen such incompetence in all my life!  Astounding!  Get out of my sight!  Just go!  "
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
		evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
		evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.SetNPCTopic{NPC = 69, Index = 2, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 3, Event = 0}         -- "Queen Catherine"
	elseif evt.Cmp("Counter2", 672) then
		evt.SetMessage(274)         -- "King Parson is beyond the date when he could have used those false papers.  Don't bother taking them to him--it doesn't matter anymore.  "
		evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
		evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
		evt.SetNPCTopic{NPC = 69, Index = 2, Event = 0}         -- "Queen Catherine"
		evt.SetNPCTopic{NPC = 69, Index = 3, Event = 0}         -- "Queen Catherine"
		evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
	else
		evt.SetMessage(270)         -- "You have to get the plans to him before he attacks Riverstride.  If you don't, they won't lead his forces into all the traps we've prepared for them.  So hurry up and deliver those plans!  I'm counting on you!"
	end
end

-- "We stole the plans…"
evt.CanShowTopic[129] = function()
	return evt.Cmp("Inventory", 705)         -- "Riverstride Plans"
end

evt.global[129] = function()
	evt.SetMessage(272)         -- "[The Queen raises her eyebrows with interest as you tell her how you infiltrated her fort, stole secret plans, and killed many of her guards while in the service of a foreign king] I wish I could truthfully say this is the most shocking treason I have ever witnessed, but unfortunately, it's not.  Nonetheless...Guards!  Off with their heads!"
	evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
	evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
	evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.SetNPCTopic{NPC = 69, Index = 2, Event = 0}         -- "Queen Catherine"
	evt.SetNPCTopic{NPC = 69, Index = 3, Event = 0}         -- "Queen Catherine"
	evt.ForPlayer(0)
	evt.Set("Dead", 1)
	evt.ForPlayer(1)
	evt.Set("Dead", 1)
	evt.ForPlayer(2)
	evt.Set("Dead", 1)
	evt.ForPlayer(3)
	evt.Set("Dead", 1)
end

-- "Artifact"
evt.CanShowTopic[130] = function()
	return evt.Cmp("Inventory", 634)         -- "Gryphonheart's Trumpet"
end

evt.global[130] = function()
	evt.SetMessage(287)         -- "My loyal subjects!  You were the ones who took the Trumpet!  Good work.  We thought it lost forever.  Once again, my purser will deposit gold in your account.  5,000 gold, to be exact."
	evt.Add("BankGold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 634)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 84)         -- Gave artifact to humans
	evt.SetNPCTopic{NPC = 69, Index = 4, Event = 0}         -- "Queen Catherine"
end

-- "Riverstride plans"
evt.global[131] = function()
	evt.SetMessage(275)         --[[ "Welcome.  I understand you've been appointed Lords of Harmondale by that idiot Markham.  You know, I WILL restore Avlee's rule over Harmondale--the only question is whether you are with me, or against me.  If you're with me, I will ensure that you retain your post.  Against me, and I will have done with you once my armies occupy your lands.  

[King Parson smiles affably] So, of course you're with me!  You just need to prove it.  Like a famous leader once said:  Trust, but verify!  Words to live by.  What I want right now is the plans to Fort Riverstride.  It's a huge fort that stands between your lands and Erathia proper.  You can't miss the thing.  Sneak in there and get me those plans.  If you can do this, I will be in your debt.  Not only that, there's a substantial gold reward as well.  If the plans are to be any use to me at all, though, I need them delivered to me within a month." ]]
	evt.SetNPCTopic{NPC = 70, Index = 0, Event = 132}         -- "ElfKing" : "Riverstride plans"
	evt.Add("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.Add("QBits", 89)         -- Talked to elfking
	evt.Set("Counter2", 0)
end

-- "Riverstride plans"
evt.global[132] = function()
	if evt.Cmp("Counter2", 672) then
		evt.SetMessage(285)         -- "The time where I could have used those plans is over.  Thanks for any efforts you may have put into finding them, but I no longer need the plans."
		evt.SetNPCTopic{NPC = 70, Index = 0, Event = 0}         -- "ElfKing"
		evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "ElfKing"
		evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
		evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
		evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
		evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
	else
		evt.ForPlayer("All")
		if evt.Cmp("Inventory", 705) then         -- "Riverstride Plans"
			evt.SetMessage(276)         -- "[The King smiles broadly as you hand him the plans]  Thank you!  These will be VERY useful.  My factor will deposit 5,000 gold pieces in your bank account for services rendered.  When we finally win this round against Erathia, I will not forget you."
			evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
			evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
			evt.Add("QBits", 80)         -- Gave plans to elfking
			evt.ForPlayer("Current")
			evt.Add("BankGold", 5000)
			evt.Subtract("Reputation", 5)
			evt.ForPlayer("All")
			evt.Add("Experience", 10000)
			evt.Add("Awards", 8)         -- "Retrieved Fort Riverstride Plans"
			evt.SetNPCTopic{NPC = 70, Index = 0, Event = 0}         -- "ElfKing"
			evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "ElfKing"
			evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
			evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
		elseif evt.Cmp("Inventory", 706) then         -- "False Riverstride Plans"
			evt.SetMessage(278)         -- "[The King smiles broadly as you hand him the false plans.  Sucker! ]  Thank you!  These will be VERY useful.  When we finally win this round against Erathia, I will not forget you."
			evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
			evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
			evt.Add("QBits", 82)         -- Gave false plans to elfking (betray)
			evt.Add("Reputation", 5)
			evt.ForPlayer("All")
			evt.Add("Awards", 9)         -- "Gave false plans to Elfking"
			evt.SetNPCTopic{NPC = 70, Index = 0, Event = 0}         -- "ElfKing"
			evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "ElfKing"
			evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
			evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
		else
			evt.SetMessage(277)         -- "I really do need those plans soon.  If you take too long, I'll have to prepare my attack without the plans."
		end
	end
end

-- "Here's fake plans…"
evt.CanShowTopic[133] = function()
	return evt.Cmp("Inventory", 706)         -- "False Riverstride Plans"
end

evt.global[133] = function()
	evt.SetMessage(279)         -- "What do you mean, these plans are false?  So you admit to plotting against me?  [The King throws up his hands in disgust] Guards!  Take these traitors to the courtyard and execute them!"
	evt.Subtract("Inventory", 706)         -- "False Riverstride Plans"
	evt.Subtract("Inventory", 705)         -- "Riverstride Plans"
	evt.Subtract("QBits", 94)         -- "Give false Riverstride plans to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.Subtract("QBits", 77)         -- "Retrieve plans from Fort Riverstride and return them to Eldrich Parson in Castle Navan in the Tularean Forest."
	evt.Set("QBits", 91)         -- Told Elfking about fake plans
	evt.SetNPCTopic{NPC = 70, Index = 0, Event = 0}         -- "ElfKing"
	evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "ElfKing"
	evt.ForPlayer(0)
	evt.Set("Dead", 1)
	evt.ForPlayer(1)
	evt.Set("Dead", 1)
	evt.ForPlayer(2)
	evt.Set("Dead", 1)
	evt.ForPlayer(3)
	evt.Set("Dead", 1)
end

-- "Prison Break"
evt.CanShowTopic[134] = function()
	if not evt.Cmp("QBits", 78) then         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
		return false
	end
	if not evt.Cmp("QBits", 93) then         -- Tularean Caves.  Got Loren
		return not evt.Cmp("Counter1", 672)
	end
	return false
end

evt.global[134] = function()
	evt.SetMessage(280)         -- "The wily queen moves against me, eh?  [The King frowns in thought, then brightens] I have an idea!  I know someone who looks just like that spy she wants you to rescue.  Bring my man with you and deliver him to the Queen.  She's never met him, and won't know the difference.  His 'inside information' will encourage her to make mistakes.  [The King takes a moment to summon the imposter]  Be careful not to tip your hand.  It wouldn't do for her to discover our little plan.  "
	evt.SetNPCTopic{NPC = 70, Index = 2, Event = 135}         -- "ElfKing" : "Prison Break"
	evt.Set("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
	evt.Set("NPCs", 72)         -- "Fake Loren"
	evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
end

-- "Prison Break"
evt.global[135] = function()
	if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
		evt.SetMessage(281)         -- "The imposter has infiltrated her military and diplomatic advisors' ranks, and will cause plenty of damage before he's discovered, I'm sure.  Thank you for your help! My factor will deposit 5000 gold into your account at the bank."
		evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("BankGold", 5000)
		evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "ElfKing"
		evt.SetNPCTopic{NPC = 70, Index = 3, Event = 0}         -- "ElfKing"
	elseif evt.Cmp("QBits", 90) then         -- Told Catherine about fake prisoner
		evt.SetMessage(283)         -- "You told Queen Catherine about the imposter?!? I can't believe my ears!  Why did you do it?  Why?  [The King stands and points at the door] Get out!"
		evt.ForPlayer("All")
		evt.Subtract("NPCs", 72)         -- "Fake Loren"
		evt.Subtract("NPCs", 71)         -- "Loren Steel"
		evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
		evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "ElfKing"
		evt.SetNPCTopic{NPC = 70, Index = 3, Event = 0}         -- "ElfKing"
	elseif evt.Cmp("Counter1", 672) then
		evt.SetMessage(286)         -- "The execution date for Loren Steel has passed.  Don't bother bringing the imposter to the Queen--she'll be too suspicious for our ruse to succeed.  He'll be leaving you now."
		evt.Subtract("NPCs", 72)         -- "Fake Loren"
		evt.Subtract("NPCs", 71)         -- "Loren Steel"
		evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "ElfKing"
		evt.SetNPCTopic{NPC = 70, Index = 3, Event = 0}         -- "ElfKing"
		evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
		evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
	else
		evt.SetMessage(282)         -- "It's important to get the imposter to the Queen before Mr. Steel's scheduled execution.  After all, you can't rescue Mr. Steel if everyone knows I've executed him.  And she'll become suspicious if I stay the execution.  I've never stayed one before."
	end
end

-- "We rescued Loren!.."
evt.CanShowTopic[136] = function()
	return evt.Cmp("NPCs", 71)         -- "Loren Steel"
end

evt.global[136] = function()
	evt.SetMessage(284)         -- "[The king is silent while you detail your crimes against Avlee, then smiles and spreads his hands once you've finished] Well!  I suppose that story speaks for itself, doesn't it?  Guards!  Take these traitors to the courtyard and execute them!"
	evt.Subtract("NPCs", 71)         -- "Loren Steel"
	evt.Subtract("NPCs", 72)         -- "Fake Loren"
	evt.Subtract("QBits", 78)         -- "Rescue Loren Steel from the Tularean Caves in the Tularean Forest and return him to Queen Catherine."
	evt.Subtract("QBits", 95)         -- "Return the Loren imposter to Queen Catherine in Castle Gryphonheart in Erathia."
	evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "ElfKing"
	evt.SetNPCTopic{NPC = 70, Index = 3, Event = 0}         -- "ElfKing"
	evt.ForPlayer(0)
	evt.Set("Dead", 1)
	evt.ForPlayer(1)
	evt.Set("Dead", 1)
	evt.ForPlayer(2)
	evt.Set("Dead", 1)
	evt.ForPlayer(3)
	evt.Set("Dead", 1)
end

-- "Artifact"
evt.CanShowTopic[137] = function()
	return evt.Cmp("Inventory", 634)         -- "Gryphonheart's Trumpet"
end

evt.global[137] = function()
	evt.SetMessage(288)         -- "Ah, the Trumpet!  You captured it!  We weren't sure how things turned out when news of the human raid reached us.  Thank you again, my friends.  My factor will deposit 5,000 gold in your account for your services."
	evt.Add("BankGold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Inventory", 634)         -- "Gryphonheart's Trumpet"
	evt.Subtract("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
	evt.Set("QBits", 85)         -- Gave artifact to elves
	evt.SetNPCTopic{NPC = 70, Index = 4, Event = 0}         -- "ElfKing"
end

-- "Hint"
evt.global[138] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(290)         --[[ "Once again, the Human kingdom of Erathia and the Elvish kingdom of Harmondale are fighting.  As the local Judge, it has fallen to me to patch up their differences and bring the two sides to the negotiating table.  The two sides are so evenly matched that either could prevail.  [The judge leans closer to you, lowering his voice] And I'll tell you something else--I don't much care anymore who wins.  They are like children fighting over a toy.  Neither really wants Harmondale--they just want to deny it to the other.  

So, you're on your own.  Whatever actions you take now in support of one side or another could really make a difference.  Just remember that they couldn't possibly care less what happens to you or who rules in Harmondale.  Protect yourselves and your people first.  We didn't have this conversation." ]]
	else
		evt.SetMessage(289)         --[[ "If there is one piece of advice I could give you, it would be to fix your castle.  I don't know how you're going to find the gold and workers to do it, as only wealthy nobles and kings can afford such large scale projects.  I suppose it's the old chicken and egg question...you must appear noble to gain wealth and respect, but you must have wealth and respect in order to appear noble.  

In any event, if you expect to be lords of Harmondale for more than a few months, you need to find a way to prove you're not just lucky peasants.  You must prove that you're fit to rule." ]]
	end
end

-- "Artifact"
evt.CanShowTopic[140] = function()
	return evt.Cmp("Inventory", 634)         -- "Gryphonheart's Trumpet"
end

evt.global[140] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 634) then         -- "Gryphonheart's Trumpet"
		evt.SetMessage(291)         -- "You were wise to return the Trumpet to me.  Now I can use it to help shore up the weak side in this conflict and promote peace.  Thank you.  "
		evt.Set("QBits", 147)         -- Gave artifact to arbiter
		evt.Add("Experience", 12500)
		evt.Subtract("Inventory", 634)         -- "Gryphonheart's Trumpet"
		evt.Subtract("QBits", 79)         -- "Retrieve Gryphonheart's Trumpet from the battle in the Tularean Forest and return it to whichever side you choose."
		evt.SetNPCTopic{NPC = 74, Index = 2, Event = 0}         -- "Judge Grey"
	end
end

-- "I choose you!"
evt.global[141] = function()
	evt.Subtract("NPCs", 77)         -- "Judge Fairweather"
	evt.MoveNPC{NPC = 77, HouseId = 112}         -- "Judge Fairweather" -> "Familiar Place"
	evt.SetNPCGreeting{NPC = 77, Greeting = 104}         --[[ "Judge Fairweather" : "No decision yet?  Why do you waver in the face of what is clearly the moral choice?  Think about it:

Choosing me puts an end to the war quickly.  Many people will have you to thank for saving their lives.

You will be allying with Bracada, and rejecting Deyja.  All the Light has to offer will be yours to learn.

Most importantly, you will be CHOOSING THE PATH OF LIGHT.  This choice is permanent, and cannot be withdrawn." ]]
	evt.SetNPCGreeting{NPC = 78, Greeting = 102}         -- "Judge Sleen" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and begin to ""sort out this mess"".  [Heh!]"
	evt.Set("NPCs", 78)         -- "Judge Sleen"
	evt.SetMessage(292)         -- "A wise decision.  You won't regret this--believe me.  I knew you were going to make this decision, and my bags are already packed and ready to go.  All you need to do now is get me to my new home, and I'll take care of the rest."
	evt.SetNPCTopic{NPC = 78, Index = 0, Event = 0}         -- "Judge Sleen"
	evt.SetNPCTopic{NPC = 77, Index = 0, Event = 143}         -- "Judge Fairweather" : "I choose you!"
end

-- "Hint"
evt.global[142] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 110) then         -- Finished Necro Proving Grounds
		evt.SetMessage(293)         -- "Your first order of business is to talk to Lord Ironfist and complete his 'mission.'  Once your ability and loyalty are proven, you will be allowed to help in more…interesting… ways."
	elseif not evt.Cmp("QBits", 111) then         -- Finished Necro Task 2 - Temple of Light
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 112) then         -- Finished Necro Task 3 - Soul Jars
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 113) then         -- Finished Necro Task 4 - Clanker's Lab
		evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
	elseif not evt.Cmp("QBits", 118) then         -- Killed Good MM3 Person
		evt.SetMessage(295)         -- "Tolberti has a mission of great importance.  Everything we've staked so far rests on its completion.  Prepare well for his task or you will certainly fail."
	elseif not evt.Cmp("QBits", 120) then         -- Got Hive part
		evt.SetMessage(296)         -- "Xenofex and the rest of the Kreegan must be put down; go to their 'hive' in the Land of the Giants and put a stop to Xenofex and his minions once and for all."
	elseif evt.Cmp("QBits", 121) then         -- Got the sci-fi part
		evt.SetMessage(298)         -- "Bring the Oscillation Overthruster back to Kastore with all possible speed!  Every moment you dally allows a chance for failure!"
	else
		evt.SetMessage(297)         -- "You will need to visit the craft that brought Kastore and his men to Erathia to continue.  Go west of Avlee, and make sure to be properly outfitted."
	end
end

-- "I choose you!"
evt.global[143] = function()
	evt.Subtract("NPCs", 78)         -- "Judge Sleen"
	evt.MoveNPC{NPC = 78, HouseId = 111}         -- "Judge Sleen" -> "The Snobbish Goblin"
	evt.SetNPCGreeting{NPC = 78, Greeting = 101}         --[[ "Judge Sleen" : "Still considering your choice, I see.  Let me remind you of what's at stake:  [The Ambassador holds up a finger]

The length of the war--The longer it lasts, the better off we'll all be.  Erathia and Avlee will be weaker, and unable to interfere in our affairs.

You will be allying with us.  There are things we can teach you...

Most importantly, YOU WILL CHOOSE THE PATH OF DARKNESS.  This choice cannot be withdrawn." ]]
	evt.SetNPCGreeting{NPC = 77, Greeting = 105}         -- "Judge Fairweather" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and put this horrible war to an end."
	evt.Set("NPCs", 77)         -- "Judge Fairweather"
	evt.SetMessage(292)         -- "A wise decision.  You won't regret this--believe me.  I knew you were going to make this decision, and my bags are already packed and ready to go.  All you need to do now is get me to my new home, and I'll take care of the rest."
	evt.SetNPCTopic{NPC = 77, Index = 0, Event = 0}         -- "Judge Fairweather"
	evt.SetNPCTopic{NPC = 78, Index = 0, Event = 141}         -- "Judge Sleen" : "I choose you!"
end

-- "Hint"
evt.global[144] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 114) then         -- Finished Wizard Proving Grounds
		evt.SetMessage(300)         -- "First, you need to speak to Gavin Magnus in Celeste and complete his training.  After you have proven your ability and loyalty you will learn more about your role in the future of Erathia."
	elseif not evt.Cmp("QBits", 115) then         -- Finished Wizard Task 2 - Temple of Dark
		evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 116) then         -- Finished Wizard Task 3 - Wine Cellar
		evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 117) then         -- Finished Wizard Task 4 - Soul Jars
		evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
	elseif not evt.Cmp("QBits", 119) then         -- Killed Evil MM3 Person
		evt.SetMessage(302)         -- "Robert the Wise has a regrettable, but necessary, mission for you to complete.  For any of our plans to continue, this mission must succeed.  Prepare most carefully for the task, or you invite certain failure."
	elseif not evt.Cmp("QBits", 120) then         -- Got Hive part
		evt.SetMessage(303)         -- "The Kreegan, the Devils, and their leader Xenofex must be destroyed completely for the plan to have any long-term benefit.  You will find their 'hive' in the Land of the Giants."
	elseif evt.Cmp("QBits", 121) then         -- Got the sci-fi part
		evt.SetMessage(305)         -- "Bring the Oscillation Overthruster back to Resurectra immediately!  Every moment wastes valuable time!"
	else
		evt.SetMessage(304)         -- "To the west of Avlee lies the craft that Resurectra and her associates used to come to Erathia.  Visit the ship and retrieve the Oscillation Overthruster to insure our victory.  Make sure to be properly outfitted for the journey."
	end
end

-- "Proving Grounds"
evt.global[145] = function()
	evt.SetMessage(306)         -- "The Test involves entering the 'front door' of the Walls of Mist, and exiting through the 'back door'.  I use the word 'door' loosely--you'll see when you get there.  You will not need your weapons.  You will fail the test if you kill any creature in the Walls of Mist.  If you can complete this task, you will be given membership in the Guild of Light. Good luck."
	evt.Set("QBits", 101)         -- "Complete the Walls of Mist without killing a single opponent and return to Gavin Magnus in Castle Lambent in Celeste."
	evt.Subtract("QBits", 152)         -- "Enter Celeste from the grand teleporter in the Bracada Desert, then talk to Gavin Magnus in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 79, Index = 0, Event = 146}         -- "Gavin Magnus" : "Proving Grounds"
end

-- "Proving Grounds"
evt.global[146] = function()
	if evt.Cmp("QBits", 102) then         -- Completed Proving Grounds without killing a single creature
		evt.SetMessage(307)         -- "You passed the Test!  That's quite an achievement--few succeed as quickly as you did.  My advisors are now eager to speak to  you; they can be found in the four houses on the eastern side of Celeste.  Once again, congratulations!"
		evt.Subtract("QBits", 101)         -- "Complete the Walls of Mist without killing a single opponent and return to Gavin Magnus in Castle Lambent in Celeste."
		evt.SetNPCTopic{NPC = 79, Index = 0, Event = 0}         -- "Gavin Magnus"
		evt.Add("History10", 0)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 114)         -- Finished Wizard Proving Grounds
		evt.Add("Awards", 46)         -- "Completed Wizard Proving Grounds"
		evt.SetNPCGreeting{NPC = 79, Greeting = 108}         -- "Gavin Magnus" : "Welcome back, my friends.  My advisors are anxious to speak with you.  "
		evt.MoveNPC{NPC = 80, HouseId = 425}         -- "Resurectra" -> "Hostel"
		evt.MoveNPC{NPC = 81, HouseId = 426}         -- "Crag Hack" -> "Hostel"
		evt.MoveNPC{NPC = 82, HouseId = 427}         -- "Sir Caneghem" -> "Hostel"
		evt.MoveNPC{NPC = 83, HouseId = 428}         -- "Robert the Wise" -> "Hostel"
		evt.SetNPCGreeting{NPC = 80, Greeting = 111}         -- "Resurectra" : "Always a pleasure to see you, Lords."
		evt.SetNPCGreeting{NPC = 81, Greeting = 114}         -- "Crag Hack" : "It's good to see you again, lords.  I hope all is well with you and your realm."
		evt.SetNPCGreeting{NPC = 82, Greeting = 117}         -- "Sir Caneghem" : "Ah, welcome back my lords.  I hope all is well."
		evt.SetNPCGreeting{NPC = 83, Greeting = 120}         -- "Robert the Wise" : "I'm happy you're still alive and working for the Light.  Come and see me when you've finished my friend's tasks."
		evt.Add("Awards", 59)         -- "Joined the Light Guild"
	else
		evt.SetMessage(308)         -- "Remember, you must enter through the front door of the Walls of Mist, and exit through the back door.  You must not kill any creatures in the Walls of Mist.  When you have done this, return to me."
	end
end

-- "Temple of the Dark"
evt.CanShowTopic[147] = function()
	return evt.Cmp("QBits", 114)         -- Finished Wizard Proving Grounds
end

evt.global[147] = function()
	evt.SetMessage(309)         -- "We need your help retrieving half of a key to a very important place from our enemies, the Necromancers.  Like us, they have enshrined their half of the key in their highest temple--The Temple of the Dark.  I'm under no illusions this will be easy.  Take your time and act when you're prepared.  Also, bring our half of the key to us, as well.  It is enshrined in the Temple of the Light.  Since you're our ally, no one should trouble you when you go there to fetch the key.  By the same token, please don't harm any of them, either."
	evt.Set("QBits", 103)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Resurectra in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 80, Index = 0, Event = 148}         -- "Resurectra" : "Temple of the Dark"
end

-- "Temple of the Dark"
evt.global[148] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 676) then         -- "Altar Piece"
		if evt.Cmp("Inventory", 677) then         -- "Altar Piece"
			evt.SetMessage(313)         -- "I knew you could do it!  Never doubted you for a second!  [You hand her the key halves, and she joins them by running a finger along the crack between them.  It mends before your eyes, good as new] Finally!  One piece of the plan is in place.  Your assistance has been invaluable.  We are already in your debt, and I expect we'll be even deeper in debt before our plan comes to fruition.  So have faith in us awhile longer--the future we're planning will astound you!"
			evt.Subtract("Inventory", 676)         -- "Altar Piece"
			evt.Subtract("Inventory", 677)         -- "Altar Piece"
			evt.Subtract("QBits", 232)         -- Altar Piece (Good) - I lost it
			evt.Subtract("QBits", 233)         -- Altar Piece (Evil) - I lost it
			evt.Add("History12", 0)
			evt.Add("Experience", 50000)
			evt.SetNPCTopic{NPC = 80, Index = 0, Event = 0}         -- "Resurectra"
			evt.Subtract("QBits", 103)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Resurectra in Castle Lambent in Celeste."
			evt.Set("QBits", 115)         -- Finished Wizard Task 2 - Temple of Dark
			evt.Set("Awards", 47)         -- "Retrieved Both Temple Pieces"
			evt.SetNPCGreeting{NPC = 80, Greeting = 112}         -- "Resurectra" : "Always a pleasure to see you, Lords."
			evt.ForPlayer("Current")
			evt.Subtract("Reputation", 5)
		else
			evt.SetMessage(311)         -- "Well, I'm glad you found our half of the key, but you still need their half.  Hold onto it until you get the other half.  When you have both halves, return to me.  I will make them whole."
		end
	elseif evt.Cmp("Inventory", 677) then         -- "Altar Piece"
		evt.SetMessage(312)         -- "Good work on retrieving their half of the key, but you still need ours.  It is located in the Temple of the Light here in Celeste."
	else
		evt.SetMessage(310)         -- "No key halves yet, I see.  Well, take your time.  It must be done eventually, and sooner is better than later, but later is better than being chained to an altar and sacrificed by the High Priest of the Dark in one of their bloody rituals.  Just bring back both halves of the key from the temples of Dark and Light, and try not to get yourselves killed doing it."
	end
end

-- "Strike the Devils"
evt.CanShowTopic[149] = function()
	return evt.Cmp("QBits", 119)         -- Killed Evil MM3 Person
end

evt.global[149] = function()
	evt.SetMessage(314)         --[[ "Our plans rapidly approach their conclusion, but there is a hitch.  The Kreegan--also known as the Devils, or the Demons, must be destroyed before we finish our plans.  They represent a terrible threat, and though they do little but lick their wounds today, will one day regain their strength and devastate the world.  If anything we do is to have lasting effect, we must first destroy these monsters for once and for all.

You are strong, but not strong enough to defeat the devils on your own.  They are vulnerable to the brand of magic most commonly wielded by the Necromancers, and less so by our own Wizards.  It is imperative that you infiltrate the Devil's base and kill their leader Xenofex.  That should end their threat to this world for some time.  The Warlocks have dug a tunnel from their volcano to the Land of the Giants-- the land the Devils claim as their own.  Perhaps you can use that." ]]
	evt.Set("QBits", 104)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 80, Index = 1, Event = 150}         -- "Resurectra" : "Strike the Devils"
end

-- "Strike the Devils"
evt.global[150] = function()
	if evt.Cmp("QBits", 105) then         -- Slayed Xenofex
		evt.ShowMovie{DoubleSize = 1, Name = "\"mm3 people good\" "}
		evt.SetMessage(315)         -- "YOU ARE HEROES!!!  Your work against the devils was masterful!  And the rescue of King Roland was as delightful as it was unexpected.  History will never forget your names for doing what you just did!  I, for one, am very proud to know you.  "
		evt.Add("Gold", 50000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 500000)
		evt.Subtract("QBits", 104)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		evt.Set("QBits", 120)         -- Got Hive part
		evt.SetNPCTopic{NPC = 80, Index = 1, Event = 169}         -- "Resurectra" : "Final Task"
		evt.Add("Awards", 48)         -- "Slayed Xenofex"
	else
		evt.SetMessage(316)         -- "I guess there's no hurry getting this job done, but we don't want the Necromancers to grow bored waiting for us to do our part and destroy the blocker.  So, please, as soon as you feel ready you must attack the Devils.  Remember that the Warlocks have dug a tunnel from their volcano to the land of the Devils.  You should be able to use that to get yourselves there."
	end
end

-- "Vampires"
evt.CanShowTopic[151] = function()
	return evt.Cmp("QBits", 114)         -- Finished Wizard Proving Grounds
end

evt.global[151] = function()
	evt.SetMessage(317)         -- "Our allies in Tatalia have been complaining for some time of a mysterious presence.  There have been numerous deaths and disappearances for the last few months, and they've asked us if we knew anything about it.  I think I do.  I suspect a vampire is preying on Tatalia.  I don't have time to pursue the question myself, but to keep our allies happy, I'm asking you to please look into it.  It's possible the monster's presence has deeper implications than just bad luck for Tatalia."
	evt.Set("QBits", 106)         -- "Investigate the Wine Cellar in Tatalia and return to Crag Hack in Castle Lambent in Celeste."
	evt.SetNPCTopic{NPC = 81, Index = 0, Event = 152}         -- "Crag Hack" : "Vampires"
end

-- "Vampires"
evt.global[152] = function()
	if evt.Cmp("QBits", 107) then         -- Slayed the vampire
		evt.SetMessage(318)         -- "Just as I suspected!  Good work.  With the death of the Vampire, Tatalia can sleep a bit easier now.  Queen Catherine is grateful as well, and has been making moves to further strengthen the ties between Bracada and Erathia."
		evt.Add("Gold", 20000)
		evt.Add("History13", 0)
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("Awards", 49)         -- "Solved the Mystery of the Wine Cellar"
		evt.SetNPCTopic{NPC = 81, Index = 0, Event = 0}         -- "Crag Hack"
		evt.SetNPCGreeting{NPC = 81, Greeting = 115}         -- "Crag Hack" : "It's good to see you again, lords.  I hope all is well with you and your realm."
		evt.Subtract("QBits", 106)         -- "Investigate the Wine Cellar in Tatalia and return to Crag Hack in Castle Lambent in Celeste."
		evt.Add("QBits", 116)         -- Finished Wizard Task 3 - Wine Cellar
	else
		evt.SetMessage(319)         -- "Keep looking for that Vampire.  I'm sure that's our problem, and he must be somewhere in or near Tatalia.  "
	end
end

-- "Soul Jars"
evt.CanShowTopic[153] = function()
	return evt.Cmp("QBits", 114)         -- Finished Wizard Proving Grounds
end

evt.global[153] = function()
	evt.SetMessage(320)         -- "The plan involves stealing the soul jars the Necromancers rely on to prolong their miserable lives.  They have them hidden somewhere in their Guild Castle, and are probably not prepared for the kind of small scale assault you people are so good at.  A quick strike--in and out--should do the trick.  Don't hang around the castle too long, or reinforcements will arrive, and try to get it right the first time, or they will permanently double their patrols.  Once you have the soul jars, bring them back here so we can dispose of them properly."
	evt.Set("QBits", 108)         -- "Retrieve the Case of Soul Jars from Castle Gloaming in the Pit and return to Sir Caneghem in Celeste."
	evt.SetNPCTopic{NPC = 82, Index = 0, Event = 154}         -- "Sir Caneghem" : "Soul Jars"
end

-- "Soul Jars"
evt.global[154] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 602) then         -- "Case of Soul Jars"
		evt.SetMessage(321)         -- "[Sir Caneghem looks at the jars curiously, as though observing a poisonous snake behind glass] So these are soul jars.  I expected something more…impressive, I suppose.  Good job!  [he takes the case of jars] I will make sure these jars are never seen again."
		evt.Subtract("Inventory", 602)         -- "Case of Soul Jars"
		evt.Subtract("QBits", 231)         -- Lich Jar Case - I lost it
		evt.Add("History11", 0)
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 108)         -- "Retrieve the Case of Soul Jars from Castle Gloaming in the Pit and return to Sir Caneghem in Celeste."
		evt.Add("QBits", 117)         -- Finished Wizard Task 4 - Soul Jars
		evt.SetNPCTopic{NPC = 82, Index = 0, Event = 0}         -- "Sir Caneghem"
		evt.SetNPCGreeting{NPC = 82, Greeting = 118}         -- "Sir Caneghem" : "Ah, welcome back my lords.  I hope all is well."
		evt.Add("Awards", 80)         -- "Retrieved Soul Jars"
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
		evt.SetNPCGreeting{NPC = 88, Greeting = 136}         -- "Archibald Ironfist" : "Back for more target practice?  You know, if you wait long enough, my people will regenerate.  Bigger challenge then."
		evt.MoveNPC{NPC = 88, HouseId = 0}         -- "Archibald Ironfist"
		evt.SetNPCTopic{NPC = 88, Index = 1, Event = 0}         -- "Archibald Ironfist"
	else
		evt.SetMessage(322)         -- "Be well prepared when you go for the jars.  Their security won't be so lax if you have to retreat and return.  "
	end
end

-- "Tolberti"
evt.CanShowTopic[155] = function()
	if not evt.Cmp("QBits", 114) then         -- Finished Wizard Proving Grounds
		return false
	elseif not evt.Cmp("QBits", 115) then         -- Finished Wizard Task 2 - Temple of Dark
		return false
	elseif not evt.Cmp("QBits", 116) then         -- Finished Wizard Task 3 - Wine Cellar
		return false
	else
		return evt.Cmp("QBits", 117)         -- Finished Wizard Task 4 - Soul Jars
	end
end

evt.global[155] = function()
	evt.SetMessage(323)         -- "Our counterparts, the former advisors to Archibald, each carry a token called a command cube on their person that we absolutely must acquire to complete the Goal.  There is no way any of them will part with their cube willingly, which means that we must get it some other way.  You will have to take it from one of them, and we think the easiest would be Tolberti.  Unlike the rest of them, he disdains proper security and has taken up residence in one of the apartments in the Pit.  I need you to infiltrate the pit again and get the cube from him.  Be careful--he is well armed and much tougher than he appears.  When you have the Cube, return to me.  We have but a short distance to the Goal, and all will be revealed very soon."
	evt.Set("QBits", 109)         -- "Assassinate Tolberti in his house in the Pit and return his control cube to Robert the Wise in Celeste."
	evt.SetNPCTopic{NPC = 83, Index = 0, Event = 156}         -- "Robert the Wise" : "Tolberti"
end

-- "Tolberti"
evt.global[156] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Keep trying to find his apartment.  Tolberti has never really believed anything bad could happen to him, and so far he's been right.  We need to prove him wrong.  Take the cube any way you can.  If you can do it without violence, fine.  If you must kill him, well, that's O.K. too.  Just get the cube."
		return
	end
	evt.SetMessage(324)         -- "[Robert takes the cube] Once again, you succeed!  The Goal is so close!  I know you have many questions, and I'm sure Resurectra will answer them all, after you do just one more mission for her.  You will find her with Gavin Magnus in the throne room of Castle Lambent."
	evt.Subtract("Inventory", 675)         -- "Control Cube"
	evt.Add("History22", 0)
	evt.Add("Experience", 250000)
	evt.Subtract("QBits", 109)         -- "Assassinate Tolberti in his house in the Pit and return his control cube to Robert the Wise in Celeste."
	evt.Add("QBits", 119)         -- Killed Evil MM3 Person
	evt.Add("Awards", 81)         -- "Assassinated Tolberti"
	evt.ForPlayer(0)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(1)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(2)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(3)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.SetNPCTopic{NPC = 80, Index = 3, Event = 223}         -- "Resurectra" : "Ancient Weapon Grandmaster"
	evt.SetNPCTopic{NPC = 81, Index = 1, Event = 222}         -- "Crag Hack" : "Ancient Weapon Master"
	evt.SetNPCTopic{NPC = 82, Index = 1, Event = 221}         -- "Sir Caneghem" : "Ancient Weapon Expert"
	evt.SetNPCGreeting{NPC = 83, Greeting = 0}         -- "Robert the Wise" : ""
	evt.Subtract("Reputation", 5)
	evt.MoveNPC{NPC = 80, HouseId = 182}         -- "Resurectra" -> "Throne Room"
	evt.SetNPCTopic{NPC = 83, Index = 0, Event = 0}         -- "Robert the Wise"
end

-- "Temple of the Light"
evt.CanShowTopic[157] = function()
	return evt.Cmp("QBits", 110)         -- Finished Necro Proving Grounds
end

evt.global[157] = function()
	evt.SetMessage(326)         --[[ "We need your help retrieving half of a key to a very important place from our enemies, the Wizards.  Like us, they have enshrined their half of the key in their highest temple--The Temple of the Light.  It'll be a snap.  Most so called good people spend more time defending and healing themselves than delivering damage.  How can you win if you don't fight?  Anyway, take your time and act when you're prepared.  

Also, bring our half of the key to us, as well.  It is enshrined in the Temple of the Darkness.  Since you're our ally, no one should trouble you when you go there to fetch the key.  But if you feel like you need the practice, go ahead a take a whack at some of them.  They're not very important, and most of them can regenerate from even the most severe injuries.  Try it--it's alot of fun!" ]]
	evt.Set("QBits", 122)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Kastore in the Pit."
	evt.SetNPCTopic{NPC = 84, Index = 0, Event = 158}         -- "Kastore" : "Temple of the Light"
end

-- "Temple of the Light"
evt.global[158] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 676) then         -- "Altar Piece"
		if evt.Cmp("Inventory", 677) then         -- "Altar Piece"
			evt.SetMessage(330)         -- "Excellent!  [Kastore takes the two halves of the key and bangs them together.  With a bright white flash, they join together seamlessly]  The first part of the Plan is complete.  I knew we, uh, Archibald made the right decision in trusting you!  "
			evt.Subtract("Inventory", 676)         -- "Altar Piece"
			evt.Subtract("Inventory", 677)         -- "Altar Piece"
			evt.Subtract("QBits", 232)         -- Altar Piece (Good) - I lost it
			evt.Subtract("QBits", 233)         -- Altar Piece (Evil) - I lost it
			evt.Add("History20", 0)
			evt.Add("Experience", 50000)
			evt.SetNPCTopic{NPC = 84, Index = 0, Event = 0}         -- "Kastore"
			evt.Subtract("QBits", 122)         -- "Retrieve the altar piece from the Temple of Light in Celeste and the Temple of Dark in the Pit and return them to Kastore in the Pit."
			evt.Set("QBits", 111)         -- Finished Necro Task 2 - Temple of Light
			evt.Set("Awards", 47)         -- "Retrieved Both Temple Pieces"
			evt.SetNPCGreeting{NPC = 84, Greeting = 112}         -- "Kastore" : "Always a pleasure to see you, Lords."
		else
			evt.SetMessage(329)         -- "Finally!  I was beginning to wonder if you might have got yourselves killed already.  Well, no matter.  You forgot to get the key from the Temple of the Dark, so be on your way.  When you have it, return to me so I can make the two halves whole again."
		end
	elseif evt.Cmp("Inventory", 677) then         -- "Altar Piece"
		evt.SetMessage(328)         -- "Well, I'm glad you found our half of the key, but you still need their half.  Hold onto it until you get the other half.  When you have both halves, get back over here and I'll fix them."
	else
		evt.SetMessage(327)         -- "No key halves yet?  Bah!  I hope you're more competent than you seem right now!  How hard can this be?  All you have to do is burst in the front door and start shooting.  When there's no one left, you can clean their place out at your leisure.  Just hurry up and bring us both key halves."
	end
end

-- "Strike the Devils"
evt.CanShowTopic[159] = function()
	return evt.Cmp("QBits", 118)         -- Killed Good MM3 Person
end

evt.global[159] = function()
	evt.SetMessage(331)         --[[ "Soon our plans will bear fruit, but there are a few details that must be handled before we are ready.  The Kreegan, also known as the Devils, share this world with us.  The only reason we're sharing is because they are weak right now.  If they ever get strong, they will try to kill every person in the world.

Anyway, it's no fun to rule a world full of dead people, so we have to kill the Devils before they kill us.  Our plan is for you to infiltrate the Devils lair and destroy their leader, Xenofex.  The warlocks of Nighon have dug a tunnel from their volcano to the Land of the Giants-- the land of the Devils.  You can probably use that tunnel to get there." ]]
	evt.Set("QBits", 123)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Kastore in the Pit."
	evt.SetNPCTopic{NPC = 84, Index = 1, Event = 160}         -- "Kastore" : "Strike the Devils"
end

-- "Strike the Devils"
evt.global[160] = function()
	if evt.Cmp("QBits", 105) then         -- Slayed Xenofex
		evt.ShowMovie{DoubleSize = 1, Name = "\"mm3 people evil\" "}
		evt.SetMessage(332)         -- "THAT WAS AWESOME!  You did it!  And now the single greatest threat to our plans is gone!  We will be Kings of the World!  [Kastore throws his head back and laughs wildly] AHAHAHAHAHA!!!!! Ah ha ha. Yes.  Well, good job.  I'll even forgive you for letting that King Roland character go free--we could have used him as a bargaining chip, you know.  [he shrugs] you probably didn't have a choice, I suppose.  In any event, this is a happy day!  "
		evt.Add("Gold", 50000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 500000)
		evt.Subtract("QBits", 123)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Kastore in the Pit."
		evt.Set("QBits", 120)         -- Got Hive part
		evt.SetNPCTopic{NPC = 84, Index = 1, Event = 171}         -- "Kastore" : "Final Task"
		evt.Add("Awards", 48)         -- "Slayed Xenofex"
	else
		evt.SetMessage(333)         -- "Could you please hurry up with this raid against the Devils?  Archibald has promised forces, but they won't be available forever.  What's worse, the devils breed faster than rabbits.  The longer you wait, the more you'll have to fight."
	end
end

-- "Soul Jars"
evt.CanShowTopic[161] = function()
	return evt.Cmp("QBits", 110)         -- Finished Necro Proving Grounds
end

evt.global[161] = function()
	evt.SetMessage(334)         -- "Archibald has asked us to find a source of soul jars for his necromancers.  These are the jars that are needed to complete the Ritual that gives them eternal life, and we're almost out.  There are far more candidates for Lichdom than we have jars, so some of our necromancers are facing the grim possibility of real death.  The makers of the jars are the Warlocks.  Go to them and convince them to give us the jars.  If they won't hand them over, take the jars by force-- I'm done negotiating prices with them."
	evt.Set("QBits", 124)         -- "Retrieve the Case of Soul Jars from the Warlocks in Thunderfist Mountain and bring them to Maximus in the Pit."
	evt.SetNPCTopic{NPC = 85, Index = 0, Event = 162}         -- "Maximus" : "Soul Jars"
end

-- "Soul Jars"
evt.global[162] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 602) then         -- "Case of Soul Jars"
		evt.SetMessage(335)         -- "[Maximus takes the case of jars with obvious delight] Nice work.  I won't even ask what you had to do to get them.  Success speaks for itself.  "
		evt.Subtract("Inventory", 602)         -- "Case of Soul Jars"
		evt.Subtract("QBits", 231)         -- Lich Jar Case - I lost it
		evt.Add("History18", 0)
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 124)         -- "Retrieve the Case of Soul Jars from the Warlocks in Thunderfist Mountain and bring them to Maximus in the Pit."
		evt.Add("QBits", 112)         -- Finished Necro Task 3 - Soul Jars
		evt.Add("Awards", 80)         -- "Retrieved Soul Jars"
		evt.SetNPCTopic{NPC = 85, Index = 0, Event = 0}         -- "Maximus"
		evt.SetNPCGreeting{NPC = 85, Greeting = 127}         -- "Maximus" : "Glad to have you back, allies."
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(336)         -- "You don't have to be nice about getting the jars from them--just get the jars any way you can.  We can renegotiate peace with them if we must, just like we renegotiate the price for each purchase of soul jars."
	end
end

-- "Clanker's Laboratory"
evt.CanShowTopic[163] = function()
	return evt.Cmp("QBits", 110)         -- Finished Necro Proving Grounds
end

evt.global[163] = function()
	evt.SetMessage(337)         -- "Lord Archibald has another request--the creatures that have inhabited Clanker's laboratory must be evicted--and the teleport shield brought down.  The laboratory is on an island east of Pierpont in the Tularean Forest.  Be careful--the monsters in that lab were created by Clanker himself, and some of them are much more powerful than their more common fellows elsewhere in the world.  Take whatever you like from the place.  Lord Archibald is only interested in the real estate and the laboratory equipment.  Once the shield is down, Lord Archibald will be able to begin moving necromancers and equipment inside via Lloyd's Beacon. "
	evt.Set("QBits", 125)         -- "Destroy the magical defenses inside Clanker's Laboratory and return to Dark Shade in the Pit."
	evt.SetNPCTopic{NPC = 86, Index = 0, Event = 164}         -- "Dark Shade" : "Clanker's Laboratory"
end

-- "Clanker's Laboratory"
evt.global[164] = function()
	if evt.Cmp("QBits", 198) then         -- Archibald in Clankers Lab now
		evt.MoveToMap{X = 0, Y = -709, Z = 1, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 198, Icon = 9, Name = "D12.blv"}         -- "Clanker's Laboratory"
	elseif evt.Cmp("QBits", 126) then         -- Destroyed the magical defenses in Clanker's Lab
		evt.SetMessage(338)         -- "It's good to see we can count on you.  So few of our allies are as reliable and capable as yourselves.  Thank you very much for your aid."
		evt.Add("History21", 0)
		evt.Subtract("Reputation", 5)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Subtract("QBits", 125)         -- "Destroy the magical defenses inside Clanker's Laboratory and return to Dark Shade in the Pit."
		evt.Add("QBits", 113)         -- Finished Necro Task 4 - Clanker's Lab
		evt.SetNPCTopic{NPC = 86, Index = 0, Event = 0}         -- "Dark Shade"
		evt.SetNPCGreeting{NPC = 86, Greeting = 130}         -- "Dark Shade" : "Welcome, allies.  Always good to have you back."
		evt.Add("Awards", 82)         -- "Cleaned out Clanker's Laboratory"
	else
		evt.SetMessage(339)         -- "This is a simple task--get a move on!  Once again, the laboratory on an island east of Pierpont in the Tularean Forest.  Get the shield lowered, and your part of the job is done."
	end
end

-- "Robert the Wise"
evt.CanShowTopic[165] = function()
	if not evt.Cmp("QBits", 110) then         -- Finished Necro Proving Grounds
		return false
	elseif not evt.Cmp("QBits", 111) then         -- Finished Necro Task 2 - Temple of Light
		return false
	elseif not evt.Cmp("QBits", 112) then         -- Finished Necro Task 3 - Soul Jars
		return false
	else
		return evt.Cmp("QBits", 113)         -- Finished Necro Task 4 - Clanker's Lab
	end
end

evt.global[165] = function()
	evt.SetMessage(340)         -- "Just as Archibald has us, King Magnus of Bracada has his advisors.  And, just like us, each of them wears a small token called a command cube.  We need one of their cubes, and they're not going to just hand one over to us.  We must take one of their cubes, and we have decided it should be Robert the Wise who suffers.  One of our spies in their castle has damaged the lock to his room.  They have been lax about replacing it, so you should have no trouble going through the door.  I don't care if you kill him or not--just get the cube and return to me at once."
	evt.Set("QBits", 127)         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
	evt.SetNPCTopic{NPC = 87, Index = 0, Event = 166}         -- "Tolberti" : "Robert the Wise"
end

-- "Robert the Wise"
evt.global[166] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(342)         -- "What's wrong?  Don't tell me you're losing your nerve?  He's tough, but not immortal.  You can take him!  I wouldn't have sent you on this mission if I didn't think you could handle it."
		return
	end
	evt.SetMessage(341)         -- "[Tolberti takes the cube] This brings us very close to completing our Plan.  I know Kastore hasn't told you exactly what the Plan is, but you'll like it, I'm sure!  I am not allowed to say much, but I can tell you your position will be much higher than simply Lords of Harmondale, you can count on that!  You will find Kastore in his place on the throne of Castle Gloaming."
	evt.Subtract("Inventory", 675)         -- "Control Cube"
	evt.Add("History23", 0)
	evt.Add("Experience", 250000)
	evt.Subtract("QBits", 127)         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
	evt.Add("QBits", 118)         -- Killed Good MM3 Person
	evt.Add("Awards", 83)         -- "Assassinated Robert the Wise"
	evt.ForPlayer(0)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(1)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(2)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.ForPlayer(3)
	if not evt.Cmp("BlasterSkill", 1) then
		evt.Set("BlasterSkill", 1)
	end
	evt.SetNPCTopic{NPC = 84, Index = 3, Event = 223}         -- "Kastore" : "Ancient Weapon Grandmaster"
	evt.SetNPCTopic{NPC = 85, Index = 1, Event = 222}         -- "Maximus" : "Ancient Weapon Master"
	evt.SetNPCTopic{NPC = 86, Index = 1, Event = 221}         -- "Dark Shade" : "Ancient Weapon Expert"
	evt.SetNPCGreeting{NPC = 87, Greeting = 0}         -- "Tolberti" : ""
	evt.Subtract("Reputation", 5)
	evt.SetNPCTopic{NPC = 87, Index = 0, Event = 0}         -- "Tolberti"
end

-- "Breeding Pit"
evt.CanShowTopic[167] = function()
	return not evt.Cmp("QBits", 99)         -- Chose the path of Light
end

evt.global[167] = function()
	evt.SetMessage(343)         -- "Yes, the test.  It's simple.  Near the center of the city is a place we call the Breeding Zone.  There's a lot of foul monsters in the pit, and they regenerate constantly.  It makes for a good source of slaves, spare parts, and target practice.  All of our necromancers are tested there when they want to rise above the level of initiate.  I'm sure you'll pass the test.  Just jump in the pit and find a way out.  Kill anything you want down there.  Show no mercy.  When you escape, crawl out of the pit and come see me again.  If you complete this, I will give you membership in the Guild of Dark. *If* you complete this..."
	evt.Set("QBits", 128)         -- "Complete the Breeding Zone and return to Archibald in the Pit."
	evt.Subtract("QBits", 151)         -- "Enter the Pit from the Hall of the Pit in the Deyja Moors, then talk to Archibald in Castle Gloaming in the Pit."
	evt.SetNPCTopic{NPC = 88, Index = 0, Event = 168}         -- "Archibald Ironfist" : "Breeding Pit"
end

-- "Breeding Pit"
evt.global[168] = function()
	if evt.Cmp("QBits", 129) then         -- Completed Breeding Pit.
		evt.SetMessage(344)         -- "You show promise, my friends.  A fine performance.  I think it will be sufficient proof of your skill for my advisors.  They are quite eager to assign tasks to you now; they can be found in the four houses in the western side of the Pit.  And don't worry.  Rewards will follow, of course."
		evt.Add("History17", 0)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("Awards", 84)         -- "Completed Necromancer Breeding Pit"
		evt.Subtract("QBits", 128)         -- "Complete the Breeding Zone and return to Archibald in the Pit."
		evt.Add("QBits", 110)         -- Finished Necro Proving Grounds
		evt.SetNPCTopic{NPC = 88, Index = 0, Event = 0}         -- "Archibald Ironfist"
		evt.SetNPCGreeting{NPC = 88, Greeting = 137}         -- "Archibald Ironfist" : "Welcome back, allies.  My advisors are eager to speak with you."
		evt.MoveNPC{NPC = 84, HouseId = 442}         -- "Kastore" -> "Hostel"
		evt.MoveNPC{NPC = 85, HouseId = 434}         -- "Maximus" -> "Hostel"
		evt.MoveNPC{NPC = 86, HouseId = 441}         -- "Dark Shade" -> "Hostel"
		evt.MoveNPC{NPC = 87, HouseId = 433}         -- "Tolberti" -> "Hostel"
		evt.SetNPCGreeting{NPC = 84, Greeting = 123}         -- "Kastore" : "[Kastore smiles] Welcome back, allies.  I trust you are well?"
		evt.SetNPCGreeting{NPC = 85, Greeting = 126}         -- "Maximus" : "Glad to have you back, allies."
		evt.SetNPCGreeting{NPC = 86, Greeting = 129}         -- "Dark Shade" : "Welcome, allies.  Always good to have you back."
		evt.SetNPCGreeting{NPC = 87, Greeting = 132}         -- "Tolberti" : "Glad you're still on our side!  Come and see me when you're done with my associates' missions."
		evt.Add("Awards", 60)         -- "Joined the Dark Guild"
	else
		evt.SetMessage(345)         -- "I am beginning to suspect my allies were right about you.  Can't you pass this simple test?  Are you too afraid, or too feeble to succeed?  Perhaps we need new allies?"
	end
end

-- "Final Task"
evt.global[169] = function()
	evt.SetMessage(346)         --[[ "The time has come to achieve our Goal.  The reason we have sent you on all these missions is simple:  we have been busy gathering the parts needed to open a gate to the Ancients--the ones who colonized this world ages ago.  Unfortunately, our former compatriots also seek those parts for their own dark dreams.  They wish to rebuild the Heavenly Forge from the times before the Silence, and use it to duplicate the weapons we brought with us to your world.  We have been competing with them for these parts, but at last we have what we need.  

Except for one thing.  We have been unable to find the Oscillation Overthruster on your world.  All would be lost, but there is one such device aboard the Lincoln--the vehicle that brought us to your world.  It is in the sea west of Avlee and secured against entry, even from ourselves.  Now you must wear our environment suits, enter the ship, and return with the Overthruster; you will find these suits in the chest outside this throne room.  For the suit to function properly you must not be wearing any equipment.  As for us, we must stand watch at the gate, and battle our former comrades.  " ]]
	evt.Add("History26", 0)
	evt.Set("QBits", 130)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
	evt.SetNPCTopic{NPC = 80, Index = 1, Event = 170}         -- "Resurectra" : "Final Task"
end

-- "Final Task"
evt.global[170] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 605) then         -- "Oscillation Overthruster"
		evt.Subtract("Inventory", 605)         -- "Oscillation Overthruster"
		evt.Subtract("QBits", 235)         -- Wetsuit - I lost it
		evt.Subtract("QBits", 236)         -- Final Part - I lost it
		evt.Subtract("QBits", 130)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Resurectra in Celeste."
		evt.SetNPCTopic{NPC = 80, Index = 1, Event = 0}         -- "Resurectra"
		evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"Endgame 1 Good\" "}
		evt.SetNPCGroupNews{NPCGroup = 10, NPCNews = 33}         -- "Southern Village Group in Harmondy" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 11, NPCNews = 33}         -- "Main village in Harmondy" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 12, NPCNews = 33}         -- "Tent camp in Erathia" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 13, NPCNews = 33}         -- "Stedwick Group" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 14, NPCNews = 33}         -- "Stilt city dwellers in the Tularean Forest" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 15, NPCNews = 33}         -- "Group walkers in the Tularean forest" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 16, NPCNews = 33}         -- "Northern town on Deyja" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 17, NPCNews = 33}         -- "Southern town in Deyja" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 18, NPCNews = 35}         -- "Stable and Tele dwellers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 19, NPCNews = 35}         -- "Eastern village and boat dwellers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 20, NPCNews = 35}         -- "Ridge walkers in Bracada" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 21, NPCNews = 35}         -- "Peasents up till town fountain in Celeste" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 22, NPCNews = 35}         -- "Peasents after town fountain in Celeste" : "Congratulations on completing the gate!  Erathia is in your debt!"
		evt.SetNPCGroupNews{NPCGroup = 23, NPCNews = 33}         -- "Peasents in first area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 24, NPCNews = 33}         -- "Peasents in the second area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 25, NPCNews = 33}         -- "Peasents in the third area of the pit" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 26, NPCNews = 33}         -- "Peasents in main town of nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 27, NPCNews = 33}         -- "Peasents in western town of Nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 28, NPCNews = 33}         -- "Peasents in Eastern village of Nighon" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 29, NPCNews = 33}         -- "Peasents in the Mercenary guild village" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 30, NPCNews = 33}         -- "Peasents in the wharf town" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 31, NPCNews = 33}         -- "Peasents in the village area" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.SetNPCGroupNews{NPCGroup = 32, NPCNews = 33}         -- "Peasents in the Dock area" : "I heard there was a gate built to the Ancients!  I wonder what they look like."
		evt.EnterHouse(600)         -- Win Good
	else
		evt.SetMessage(348)         -- "Don't forget you'll need the wetsuits to get to the Lincoln.  These suits are in the chest outside this throne room and the Lincoln is in the sea west of Avlee.  Return here with the Overthruster as soon as possible."
	end
end

-- "Final Task"
evt.global[171] = function()
	evt.SetMessage(349)         --[[ "Our finest hour is upon us.  While you have been taking care of all those important tasks, my compatriots and I have been struggling with our former friends for the parts we need to rebuild the Heavenly Forge of legend.  By former friends, I mean the four chief advisors to King Magnus of the Wizards.  They have a plan to build a gate to the Ancients.  They could have stood with us, but threw it all away on some vague hope of a 'better future'.  But you!  You have stood with us all this time.

Only one task remains--we need the Oscillation Overthruster from our old vehicle, the Lincoln.  We have been unable to find one on your world.  The ship is in the sea west of Avlee and secured against entry, even from ourselves.  Now you must wear our environment suits, enter the ship, and return with the Overthruster.  Our old environments suits have been prepared for you in the chest outside this throne room.  For the suit to function properly you must not be wearing any equipment.We will stand watch over the Forge, and defend it against our enemies.  Bring us the Overthruster, my friends, and together, we shall rule the world!" ]]
	evt.Add("History27", 0)
	evt.Set("QBits", 131)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Kastore in the Pit."
	evt.SetNPCTopic{NPC = 84, Index = 1, Event = 172}         -- "Kastore" : "Final Task"
end

-- "Final Task"
evt.global[172] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 605) then         -- "Oscillation Overthruster"
		evt.Subtract("Inventory", 605)         -- "Oscillation Overthruster"
		evt.Subtract("QBits", 235)         -- Wetsuit - I lost it
		evt.Subtract("QBits", 236)         -- Final Part - I lost it
		evt.Subtract("QBits", 131)         -- "Go to the Lincoln in the sea west of Avlee and retrieve the Oscillation Overthruster and return it to Kastore in the Pit."
		evt.SetNPCTopic{NPC = 84, Index = 1, Event = 0}         -- "Kastore"
		evt.ShowMovie{DoubleSize = 1, ExitCurrentScreen = true, Name = "\"Endgame 2 Evil\" "}
		evt.SetNPCGroupNews{NPCGroup = 10, NPCNews = 34}         -- "Southern Village Group in Harmondy" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 11, NPCNews = 34}         -- "Main village in Harmondy" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 12, NPCNews = 34}         -- "Tent camp in Erathia" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 13, NPCNews = 34}         -- "Stedwick Group" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 14, NPCNews = 34}         -- "Stilt city dwellers in the Tularean Forest" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 15, NPCNews = 34}         -- "Group walkers in the Tularean forest" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 16, NPCNews = 36}         -- "Northern town on Deyja" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 17, NPCNews = 36}         -- "Southern town in Deyja" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 18, NPCNews = 34}         -- "Stable and Tele dwellers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 19, NPCNews = 34}         -- "Eastern village and boat dwellers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 20, NPCNews = 34}         -- "Ridge walkers in Bracada" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 21, NPCNews = 34}         -- "Peasents up till town fountain in Celeste" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 22, NPCNews = 34}         -- "Peasents after town fountain in Celeste" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 23, NPCNews = 36}         -- "Peasents in first area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 24, NPCNews = 36}         -- "Peasents in the second area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 25, NPCNews = 36}         -- "Peasents in the third area of the pit" : "Congratulations on completing the forge!  Victory will surely be ours!"
		evt.SetNPCGroupNews{NPCGroup = 26, NPCNews = 34}         -- "Peasents in main town of nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 27, NPCNews = 34}         -- "Peasents in western town of Nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 28, NPCNews = 34}         -- "Peasents in Eastern village of Nighon" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 29, NPCNews = 34}         -- "Peasents in the Mercenary guild village" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 30, NPCNews = 34}         -- "Peasents in the wharf town" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 31, NPCNews = 34}         -- "Peasents in the village area" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.SetNPCGroupNews{NPCGroup = 32, NPCNews = 34}         -- "Peasents in the Dock area" : "I've heard rumors of goblins and undead armed with ancient weapons threatening to conquer Erathia!  How dreadful!"
		evt.EnterHouse(601)         -- Win Evil
	else
		evt.SetMessage(351)         -- "Don't forget you'll need the environmental suits to get to the Lincoln.  These suits are in the chest outside the throne room, and the Lincoln is in the sea west of Avlee.  What else do you need to know?"
	end
end

-- "Enter Temple of Light"
evt.global[173] = function()
	evt.MoveToMap{X = -6784, Y = -2832, Z = 1649, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "T01.blv"}
end

-- "Enter Temple of Dark"
evt.global[174] = function()
	evt.MoveToMap{X = 0, Y = -4059, Z = 513, Direction = 512, LookAngle = 0, SpeedZ = 0, HouseId = 0, Icon = 0, Name = "T02.blv"}
end

-- "Thomas Grey"
evt.global[175] = function()
	evt.SetMessage(480)         -- "Thomas Grey runs the School of Sorcery.  If you're looking for promotion to Wizard or Honorary Wizard, he's your man.  His room is right through the door behind me."
end

-- "Book Shop"
evt.CanShowTopic[176] = function()
	return not evt.Cmp("QBits", 145)         -- Membership to the School of Sorcery Scroll Shop
end

evt.global[176] = function()
	evt.SetMessage(481)         -- "Would you like a membership to the School of Sorcery Scroll Shop?  A membership allows you free access to the scrolls available in our library.  It costs 5000 gold for a six month membership, but the shop stocks once per week."
	evt.SetNPCTopic{NPC = 281, Index = 1, Event = 177}         -- "Eric Swarrel" : "Book Shop"
end

-- "Book Shop"
evt.global[177] = function()
	if evt.Cmp("Gold", 5000) then
		evt.SetMessage(482)         -- "Here's the membership, remember it only lasts for six months.  Check the shelves in the front rooms here to see what is available."
		evt.Set("QBits", 145)         -- Membership to the School of Sorcery Scroll Shop
		evt.Subtract("Gold", 5000)
		evt.SetNPCTopic{NPC = 281, Index = 1, Event = 0}         -- "Eric Swarrel"
	else
		evt.SetMessage(483)         -- "You don't have enough gold-- it's no use trying to fool a Wizard."
	end
end

-- "Zokarr's Bones"
evt.CanShowTopic[178] = function()
	return evt.Cmp("QBits", 54)         -- "Retrieve the bones of the Dwarf King from the tunnels between Stone City and Nighon and place them in their proper resting place in the Barrow Downs, then return to Anthony Green in the Tularean Forest."
end

evt.global[178] = function()
	evt.SetMessage(484)         -- "You want to bury the bones of Zokarr IV in our old barrows?  No dwarf here will brave the dangers, but Zokarr deserves to be laid to rest in the right place.  Look for the secret barrow, the one with only one entrance.  In there is a coffin waiting for Zokarr's bones."
	evt.Add("Inventory", 626)         -- "Zokarr IV's Skull"
	evt.Add("QBits", 228)         -- Dwarf Bones - I lost it
	evt.SetNPCTopic{NPC = 59, Index = 1, Event = 0}         -- "Hothfarr IX"
end

-- "Quest"
evt.global[179] = function()
	evt.SetMessage(485)         -- "We have no one to turn to but you, the new Lords of Harmondale. The Lantern of Light is a treasured holy relic, used by the temples of Erathia.  Its value is more symbolic than of power-- without it the temples servants lose faith.  This Lantern disappeared while being brought to this temple from the temple in Stone City.  We believe it was lost somewhere in the maze-like Barrows.  Please find it and return it to us."
	evt.SetNPCTopic{NPC = 93, Index = 0, Event = 180}         -- "Tarin Withern" : "Quest"
	evt.Set("QBits", 155)         -- "Retrieve the Lantern of Light from the Barrow Downs and return it to Tarin Withern in Harmondale."
end

-- "Quest"
evt.global[180] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 648) then         -- "Lantern of Light"
		evt.SetMessage(487)         -- "Thank you, Lords of Harmondale.  The Lantern's return will bolster our faith and allows us to continue our services.  Please take this small reward as a token of our gratitude."
		evt.Subtract("Inventory", 648)         -- "Lantern of Light"
		evt.Add("Awards", 92)         -- "Returned Withern's Lantern"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 1000)
		evt.Subtract("QBits", 155)         -- "Retrieve the Lantern of Light from the Barrow Downs and return it to Tarin Withern in Harmondale."
		evt.SetNPCTopic{NPC = 93, Index = 0, Event = 0}         -- "Tarin Withern"
		evt.SetNPCGreeting{NPC = 93, Greeting = 152}         -- "Tarin Withern" : "Thanks for returning the Lantern of Light.  Ceremonies can continue normally at the temple!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(486)         -- "Have you found the Lantern of Light?  We're certain it was lost in the maze of Barrows in the Barrow Downs."
	end
end

-- "Quest"
evt.global[181] = function()
	evt.SetMessage(488)         -- "My, brother, Haldar passed away last month.  The family was sending his remains to me to be put to final rest.  Something happened to those delivering these remains to me; they disappeared in Nighon and not been heard from since. I fear my brothers soul will never rest unless they are found!  Please return Haldar to me if you find him? I will reward you well for this!"
	evt.SetNPCTopic{NPC = 94, Index = 0, Event = 182}         -- "Mazim Dusk" : "Quest"
	evt.Set("QBits", 156)         -- "Retrieve Haldar's Remains from the Maze in Nighon and return them to Mazim Dusk in Nighon."
end

-- "Quest"
evt.global[182] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 628) then         -- "Haldar's Remains"
		evt.SetMessage(490)         -- "Thank you for returning my ""brother's"" remains!  He was a promising Warlock and his life was ended to soon.  Now that I have his remains, I will attempt to bring him back as a Lich, and together we will seek greater power and glory!"
		evt.Subtract("Inventory", 628)         -- "Haldar's Remains"
		evt.Add("Awards", 93)         -- "Returned Haldar's Remains"
		evt.Add("Experience", 50000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 35000)
		evt.Subtract("QBits", 156)         -- "Retrieve Haldar's Remains from the Maze in Nighon and return them to Mazim Dusk in Nighon."
		evt.SetNPCTopic{NPC = 94, Index = 0, Event = 0}         -- "Mazim Dusk"
		evt.SetNPCGreeting{NPC = 94, Greeting = 154}         -- "Mazim Dusk" : "My thanks for returning Haldar's remains!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(489)         -- "Did you find Haldar's Remains?  His soul must be in sheer agony!  Please find the jar with his remains!"
	end
end

-- "Quest"
evt.global[183] = function()
	evt.SetMessage(491)         -- "My lords, I was beset by foul bandits when I returned from Avlee and they took everything I had brought with me from the Elves.  They even took my signet ring!  Without it I cannot continue my business because I cannot seal contracts between myself and other merchants.  I've heard the bandits base themselves out of a camp in Erathia, but I'm no warrior-- I'd not last a minute against them.  Please go to Erathia and see this justice done!"
	evt.SetNPCTopic{NPC = 95, Index = 0, Event = 184}         -- "Davrik Peladium" : "Quest"
	evt.Set("QBits", 157)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Harmondale."
end

-- "Quest"
evt.global[184] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 606) then         -- "Signet Ring"
		evt.SetMessage(493)         -- "My ring!  Thank you lords.  I can now continue my business and recover my losses, and you have made the trading routes safer for all the merchants!"
		evt.Subtract("Inventory", 606)         -- "Signet Ring"
		evt.Add("Awards", 94)         -- "Returned Lord Davrik's signet Ring"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.Subtract("QBits", 157)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Harmondale."
		evt.SetNPCTopic{NPC = 95, Index = 0, Event = 0}         -- "Davrik Peladium"
		evt.MoveNPC{NPC = 95, HouseId = 0}         -- "Davrik Peladium"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(492)         -- "You don't have my ring yet?  The bandits are south of Castle Gryphonheart in Erathia.  Please help me, I don't have anyone else to turn to."
	end
end

-- "Quest"
evt.global[185] = function()
	evt.SetMessage(494)         -- "So you are the Lords of Harmondale, eh?  You don’t look like much; we shall see how history judges you!  I myself am a historian and collector of rare historical items.  Lord Markham also collects such items of interest and there is one item in particular that would complete my collection, Parson's Quill-- the Quill used to sign the Treaty of Pierpont ending the first Timber War.  I know you have dealt with Lord Markham before, it's how you became Lords of this land after all, and if you would take this letter to Lord Markham in Tatalia, I'm sure he would respond favorably.  I would be even more in your debt if Lord Markham sends this item back with you!  I would be sure to favorably record your heroic acts and deeds!"
	evt.SetNPCTopic{NPC = 96, Index = 0, Event = 186}         -- "Norbert Thrush" : "Thrush's Letter"
	evt.Set("QBits", 158)         -- "Take Sealed Letter to Lord Markham in Lord Markham's Manor in Tatalia for collector Norbert Thrush."
	evt.Add("Inventory", 614)         -- "Letter from Norbert Thrush to Lord Markham"
end

-- "Thrush's Letter"
evt.global[186] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 603) then         -- "Parson's Quill"
		evt.SetMessage(496)         -- "The actual Peacock feather that was used to sign the Treaty of Pierpont.  My collection is complete!  I will be sure to record your activities and deeds correctly and justly so that all will know you as the true Lords of Harmondale!"
		evt.Subtract("Inventory", 603)         -- "Parson's Quill"
		evt.Add("Awards", 95)         -- "Returned Parson's Quill to Norbert Thrush"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Gold", 2000)
		evt.Subtract("QBits", 159)         -- "Return Parson's Quill to Norbert Thrush in Erathia."
		evt.SetNPCTopic{NPC = 96, Index = 0, Event = 0}         -- "Norbert Thrush"
		evt.SetNPCGreeting{NPC = 96, Greeting = 158}         -- "Norbert Thrush" : "Thank you for returning the Parson's Quill sent by Lord Markham.  You help has made my collection complete!"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(495)         -- "Did Lord Markham refuse to give you the Quill, or have you not even visited him yet?  His Manor is in Tatalia, please don't forget to help me."
	end
end

-- "Quest"
evt.global[187] = function()
	evt.ForPlayer("All")
	evt.SetMessage(497)         -- "A letter from Norbert Thrush the Historian? Let me see it.  [Lord Markham scans the letter briefly] Hmmmmm…he wants the Peacock feather that was used to sign the Treaty of Pierpont, does he.  Well, seeing as though he has a supposed original of the Treaty, I guess the feather should go to him.  He has promised me anything else in his collection.  Take this to him and tell him that I will come collect from him shortly!"
	evt.Subtract("Inventory", 614)         -- "Letter from Norbert Thrush to Lord Markham"
	evt.ForPlayer("Current")
	evt.Add("Inventory", 603)         -- "Parson's Quill"
	evt.Subtract("QBits", 158)         -- "Take Sealed Letter to Lord Markham in Lord Markham's Manor in Tatalia for collector Norbert Thrush."
	evt.Set("QBits", 159)         -- "Return Parson's Quill to Norbert Thrush in Erathia."
	evt.SetNPCTopic{NPC = 1, Index = 4, Event = 0}         -- "Lord Markham"
end

evt.CanShowTopic[187] = function()
	return evt.Cmp("Inventory", 614)         -- "Letter from Norbert Thrush to Lord Markham"
end

-- "Quest"
evt.global[188] = function()
	evt.SetMessage(498)         -- "I hear you folk are the new Lords of Harmondale, eh?  Perhaps you could do me a large favor, and help yourselves in the process.  To the north, in Avlee, lies the Hall under the Hill, the domain of the Faerie King.  He owes me a debt from a previous service of mine, and I would like to collect it.  Unfortunately, the faeries in the Hall and the tricks they play frighten me to death.  If you would deliver this letter to the Faerie King, and return what he gives you to me, I'd be very grateful.  You would also have the chance to meet the Faerie King for yourselves."
	evt.Add("QBits", 179)         -- "Take the sealed letter to the Faerie King in the Hall under the Hill in Avlee."
	evt.Add("Inventory", 607)         -- "Letter from Johann Kerrid to the Faerie King"
	evt.SetNPCTopic{NPC = 97, Index = 0, Event = 190}         -- "Johann Kerrid" : "Quest"
end

-- "Pipes"
evt.global[189] = function()
	evt.ForPlayer("All")
	evt.SetMessage(65)         -- "So, Johann be wanting the Faerie Pipes, eh?  I can't say I'm surprised--he wouldn't come here himself, the coward.  The Pipes will cost you, though… all your food.  Of course, I've got some delightful food down below, should thee be wanting to restock your packs."
	evt.Subtract("Inventory", 607)         -- "Letter from Johann Kerrid to the Faerie King"
	evt.Add("Experience", 2000)
	evt.ForPlayer("Current")
	evt.Add("Inventory", 633)         -- "Faerie Pipes"
	evt.SetNPCTopic{NPC = 52, Index = 1, Event = 0}         -- "Faerie King"
	evt.Subtract("QBits", 179)         -- "Take the sealed letter to the Faerie King in the Hall under the Hill in Avlee."
	evt.Add("QBits", 180)         -- "Take the Faerie Pipes to Johann Kerrid in the Tularean Forest."
	evt.Set("Food", 0)
end

evt.CanShowTopic[189] = function()
	return evt.Cmp("Inventory", 607)         -- "Letter from Johann Kerrid to the Faerie King"
end

-- "Quest"
evt.global[190] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 633) then         -- "Faerie Pipes"
		evt.SetMessage(499)         -- "Excellent!  The Pipes!  You don't know what this means to me.  Here, take this as a reward and thank you again for your help in this!"
		evt.Subtract("Inventory", 633)         -- "Faerie Pipes"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Awards", 96)         -- "Returned Faerie Pipes to Johann Kerrid"
		evt.Add("Gold", 1000)
		evt.Subtract("QBits", 180)         -- "Take the Faerie Pipes to Johann Kerrid in the Tularean Forest."
		evt.SetNPCTopic{NPC = 97, Index = 0, Event = 0}         -- "Johann Kerrid"
		evt.SetNPCGreeting{NPC = 97, Greeting = 160}         -- "Johann Kerrid" : "Thank you so much for returning the Faerie Pipes to me!  I would have never been able to brave the Hall under the Hill myself."
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(500)         -- "Don't forget to give the letter to the Faerie King.  Without it, he probably won't even want to talk to you."
	end
end

-- "Quest"
evt.CanShowTopic[191] = function()
	if not evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		return evt.Cmp("QBits", 99)         -- Chose the path of Light
	end
	return false
end

evt.global[191] = function()
	evt.SetMessage(501)         -- "We request your services for only one small task.  In Castle Lambent rests a valuable tapestry taken from an attack on Watchtower 3 years ago.  I would like you to get the tapestry for me, as you must have *some* access to the Castle-- my normal associates can't even come near the place.  I hear a large band of goblins and renegade swordsmen are about... it would be a shame if they happened to find a way to Harmondale.  You have one month to get the tapestry.  Don't be late."
	evt.Set("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	evt.Set("Counter5", 0)
	evt.SetNPCTopic{NPC = 99, Index = 0, Event = 193}         -- "Niles Stantley" : "Quest"
end

-- "Quest"
evt.CanShowTopic[192] = function()
	if not evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		return evt.Cmp("QBits", 100)         -- Chose the path of Dark
	end
	return false
end

evt.global[192] = function()
	evt.SetMessage(502)         -- "We request your services for one task.  A rare and valuable tapestry rests in Castle Gloaming, an antique from near the Silence stolen from the wizards some time ago.  I would like you to get the tapestry for me, as my normal associates don't have access to Castle Gloaming.  In return, I'll make sure that the large band of renegade swordsmen and goblins near Harmondale don't accidentally stumble upon your quiet, little village.  You have one month; don't be late."
	evt.Set("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
	evt.Set("Counter5", 0)
	evt.SetNPCTopic{NPC = 99, Index = 1, Event = 193}         -- "Niles Stantley" : "Quest"
end

-- "Quest"
evt.global[193] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Counter5", 672) then
		evt.SetMessage(504)         -- "I see.  Well, it would appear that the band of renegades has indeed discovered your little town, and has begun looting.  You may find your bank account a little, well, pinched.  Consider this a lesson in punctuality.  Go now and have a pleasant, pleasant day."
		evt.Add("QBits", 183)         -- Failed either goto or do guild quest
	elseif evt.Cmp("Inventory", 620) then         -- "Big Tapestry"
		evt.SetMessage(503)         -- "Excellent!  I see that you can be trusted to perform well when called upon.  I'll keep that in mind the next time I need a job done.  Your reward is nothing more than status quo-- things could be much worse than they already are.  Go now, I have no more time for you."
		evt.Subtract("Inventory", 620)         -- "Big Tapestry"
		evt.Add("Reputation", 5)
		evt.Add("QBits", 190)         -- Finished with Malwick & Assc.
		evt.Subtract("QBits", 182)         -- "Steal the Tapestry from your associate's Castle and return it to Niles Stantley in the Mercenary Guild in Tatalia."
		evt.SetNPCTopic{NPC = 99, Index = 0, Event = 0}         -- "Niles Stantley"
		evt.SetNPCTopic{NPC = 99, Index = 1, Event = 0}         -- "Niles Stantley"
		evt.SetNPCTopic{NPC = 99, Index = 2, Event = 0}         -- "Niles Stantley"
	else
		evt.SetMessage(73)         -- "You don't have the tapestry yet, and the clock is ticking.  It would be prudent to keep to the task at hand rather than bothering me with your babble."
	end
end

-- "Quest"
evt.global[194] = function()
	evt.SetMessage(505)         -- "A few years back, while mining underneath Stone City, we came upon quite a shock.  It seems that the Warlocks from Nighon had burrowed under the sea to make a sneak attack upon the shores of Erathia.  Their careless tunneling has sunken the earth around here until now the areas around the old dwarven barrows and, of course, Stone City, rest far above the terrain.  We discovered a force of troglodytes in our mining areas, with a tunnel leading back to Nighon.  If you could help us by ridding the tunnels of the troglodytes, we could get back to mining.  Can you help us?"
	evt.Set("QBits", 186)         -- "Kill all the Troglodytes underneath Stone City and return to Spark Burnkindle in Stone City."
	evt.SetNPCTopic{NPC = 100, Index = 0, Event = 195}         -- "Spark Burnkindle" : "Quest"
end

-- "Quest"
evt.global[195] = function()
	if not evt.CheckMonstersKilled{CheckType = 2, Id = 213, Count = 0} then
		evt.SetMessage(506)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	elseif not evt.CheckMonstersKilled{CheckType = 2, Id = 214, Count = 0} then
		evt.SetMessage(506)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	elseif evt.CheckMonstersKilled{CheckType = 2, Id = 215, Count = 0} then
		evt.SetMessage(507)         -- "They're gone?  Routed back into the connecting tunnels to Nighon!  Excellent!  We can get back to mining immediately!  Thank you so much for your help; take this as a reward for your services."
		evt.Add("Gold", 2500)
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 186)         -- "Kill all the Troglodytes underneath Stone City and return to Spark Burnkindle in Stone City."
		evt.Set("Awards", 97)         -- "Troglodyte Slayer"
		evt.SetNPCTopic{NPC = 100, Index = 0, Event = 0}         -- "Spark Burnkindle"
		evt.Subtract("Reputation", 10)
		evt.SetNPCGreeting{NPC = 100, Greeting = 164}         -- "Spark Burnkindle" : "Thank you for helping us by getting rid of those nasty Troglodytes!"
	else
		evt.SetMessage(506)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
	end
end

-- "Quest"
evt.CanShowTopic[196] = function()
	return evt.Cmp("QBits", 100)         -- Chose the path of Dark
end

evt.global[196] = function()
	evt.SetMessage(508)         -- "I have recently gained information that the forces of Queen Catherine, in Erathia, have begun to build a force to attack Deyja.  Because of the difficult terrain, they have begun to breed and train griffins to assist in their attack.  These griffins are being raised in both Erathia and the Bracada Desert.  I need you to kill off all the griffins in those two areas so that the Erathians will be forced to drastically delay their plans of attack."
	evt.Set("QBits", 187)         -- "Kill all the Griffins in Erathia and the Bracada Desert and return to Seth Drakkson in the Deyja Moors."
	evt.SetNPCTopic{NPC = 284, Index = 0, Event = 197}         -- "Seth Drakkson" : "Quest"
end

-- "Quest"
evt.global[197] = function()
	if evt.Cmp("QBits", 188) then         -- Killed all Erathian Griffins
		if not evt.Cmp("QBits", 189) then         -- Killed all Bracada Desert Griffins
			evt.SetMessage(511)         -- "You've killed the griffins near Steadwick, but you haven't dealt with the griffins in the Bracada Desert yet.  Finish them both off and return to me."
			return
		end
	else
		if not evt.Cmp("QBits", 189) then         -- Killed all Bracada Desert Griffins
			evt.SetMessage(509)         -- "You haven't killed off all the griffins in either Erathia or the Bracada Desert.  It is imperative that you finish this task to prevent their invasion."
			return
		end
		if not evt.Cmp("QBits", 188) then         -- Killed all Erathian Griffins
			evt.SetMessage(510)         -- "You've killed the griffins near Spyre Town, but you haven't dealt with the griffins in Erathia yet.  Finish them both off and return to me."
			return
		end
	end
	evt.SetMessage(512)         -- "Excellent!  You've done a splendid job.  Here, take this as your reward and know you've earned the respect of Deyja for your bold success."
	evt.Subtract("QBits", 187)         -- "Kill all the Griffins in Erathia and the Bracada Desert and return to Seth Drakkson in the Deyja Moors."
	evt.Add("Gold", 5000)
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.Subtract("Reputation", 10)
	evt.Add("Awards", 98)         -- "Griffin Slayer"
	evt.SetNPCTopic{NPC = 284, Index = 0, Event = 0}         -- "Seth Drakkson"
	evt.SetNPCGreeting{NPC = 284, Greeting = 166}         -- "Seth Drakkson" : "Good work on those griffins, my lords.  It is always a pleasure to see you."
end

-- "Quest"
evt.global[198] = function()
	evt.SetMessage(450)         --[[ "My brother, Elron, was an avid Arcomage player.  Have you played Arcomage yet?  Horribly addicting game, if I do say so.  In any rate, you can only play if you have a deck, and decks are hard to come by… so I guess you probably haven't.  In any case, Elron wanted to go over some strategies to help him win more games.  Unfortunately, he didn't want to be in town because he didn't want anyone else to spy on him learn his tricks so he went to the White Cliff Caves southeast a bit from town.

Elron hasn't been back in almost a week.  I'm certain something horrible has happened to him, but if he's alive I'd like to know that too.  Would you do me the service of locating him?  I don't have a lot of money to pay you back with, but I'd be greatly in your debt." ]]
	evt.Set("QBits", 194)         -- "Find the fate of Darron's brother in the White Cliff Caves, then return to Darron Temper in Harmondale."
	evt.SetNPCTopic{NPC = 285, Index = 0, Event = 199}         -- "Darron Temper" : "Quest"
end

-- "Quest"
evt.global[199] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 651) then         -- "Arcomage Deck"
		evt.SetMessage(452)         -- "Dead?  Oh dear!  Those are certainly his cards, though.  I don't want the cards; you can have them-- that game has cost me enough now.  Oh, poor Elron!  I have a little money you can keep for your help, and thank you for finding out what happened to Elron."
		evt.Add("Experience", 2000)
		evt.ForPlayer("Current")
		evt.Subtract("QBits", 194)         -- "Find the fate of Darron's brother in the White Cliff Caves, then return to Darron Temper in Harmondale."
		evt.Add("Gold", 750)
		evt.SetNPCTopic{NPC = 285, Index = 0, Event = 0}         -- "Darron Temper"
		evt.Subtract("Reputation", 5)
	else
		evt.SetMessage(451)         -- "Still no sign of him?  I understand.  If you do happen to find out what happened to him, please let me know."
	end
end

-- "Quest"
evt.CanShowTopic[313] = function()
	return evt.Cmp("QBits", 99)         -- Chose the path of Light
end

evt.global[313] = function()
	evt.SetMessage(453)         -- "The School of Sorcery here in the Bracada Desert collects a number of odd magical paraphernalia.  A few years ago an item of particular interest was stolen from the School by raiders from Deyja.  This item, the Seasons' Stole, was worn by Priests of the Sun during religious ceremonies at the turn of the seasons.  As a representative of the School of Sorcery, I'm authorized to reward you for its return.  Our last information placed the stolen Stole in the Hall of the Pit; I would suggest checking there first."
	evt.Add("QBits", 195)         -- "Retrieve the Seasons' Stole from the Hall of the Pit and return it to Gary Zimm in the Bracada Desert."
	evt.SetNPCTopic{NPC = 286, Index = 0, Event = 314}         -- "Gary Zimm" : "Quest"
end

-- "Quest"
evt.global[314] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 638) then         -- "Season's Stole"
		evt.SetMessage(455)         -- "Excellent!  This most certainly is the Seasons' Stole.  Here is your reward; you've done both the School of Sorcery and myself a great service."
		evt.Subtract("Inventory", 638)         -- "Season's Stole"
		evt.Add("Experience", 7500)
		evt.ForPlayer("Current")
		evt.Add("Gold", 7500)
		evt.Subtract("QBits", 195)         -- "Retrieve the Seasons' Stole from the Hall of the Pit and return it to Gary Zimm in the Bracada Desert."
		evt.Add("Awards", 99)         -- "Retrieved the Seasons' Stole"
		evt.Subtract("Reputation", 5)
		evt.SetNPCTopic{NPC = 286, Index = 0, Event = 0}         -- "Gary Zimm"
	else
		evt.SetMessage(454)         -- "Don't forget there is a reward for the Seasons' Stole if you are able to find it and return it to me."
	end
end

-- "Elsie Pederton"
evt.global[315] = function()
	evt.SetMessage(514)         -- "The Master instructor of the Staff, Elsie Pederton, can be found in the Bracada Desert, on a ridge in the southwest region."
	evt.Set("AutonotesBits", 128)         -- ""
end

-- "Jillian Mithrit"
evt.global[316] = function()
	evt.SetMessage(515)         -- "The ultimate teacher in the ways of the Staff, Jillian Mithrit, can be found in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 129)         -- ""
end

-- "Tugor Slicer"
evt.global[317] = function()
	evt.SetMessage(516)         -- "The Master instructor of the Sword, Tugor Slicer, maintains his residence in a small village in the western region of the Deyja."
	evt.Set("AutonotesBits", 130)         -- ""
end

-- "Chadric Townsaver"
evt.global[318] = function()
	evt.SetMessage(517)         -- "The Grandmaster of the Sword, Chadric Townsaver, can be found in a small village in Welnin, just south of the city of Harmondale."
	evt.Set("AutonotesBits", 131)         -- ""
end

-- "Aznog Slasher"
evt.global[319] = function()
	evt.SetMessage(518)         -- "The Master tutor of the Dagger, Aznog Slasher, can be found in the northern region of Nighon."
	evt.Set("AutonotesBits", 132)         -- ""
end

-- "Tonken Fist"
evt.global[320] = function()
	evt.SetMessage(519)         -- "The Grandmaster of the Dagger, Token Fist, can be found in city of Tidewater in Tatalia.  Rumor has it that the Master Thief in the depths of the Erathian Sewers beneath the capitol city of Steadwick can also instruct at this level."
	evt.Set("AutonotesBits", 133)         -- ""
end

-- "Dalin Keenedge"
evt.global[321] = function()
	evt.SetMessage(520)         -- "The Master Instructor of all that is the Axe, Dalin Keenedge, can be found in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 134)         -- ""
end

-- "Karn Stonecleaver"
evt.global[322] = function()
	evt.SetMessage(521)         -- "The ultimate teacher of the uses of the Axe, Karn Stonecleaver, can be found in the snowy heights of the northeast region of Tatalia."
	evt.Set("AutonotesBits", 135)         -- ""
end

-- "Claderin Silverpoint"
evt.global[323] = function()
	evt.SetMessage(522)         -- "The Master teacher, Claderin Silverpoint, can be found in the northeast section of the city of Pierpont in the elven region of the Tularean Forest. There he will further you knowledge of the Spear."
	evt.Set("AutonotesBits", 136)         -- ""
end

-- "Seline Falconeye"
evt.global[324] = function()
	evt.SetMessage(523)         -- "The Grandmaster of the Spear, Selene Falconeye, makes her home in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 137)         -- ""
end

-- "Lanshee Ravensight"
evt.global[325] = function()
	evt.SetMessage(524)         -- "The Master tutor of the Bow, Lanshee Ravensight, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 138)         -- ""
end

-- "Cardric the Steady"
evt.global[326] = function()
	evt.SetMessage(525)         -- "The Grandmaster of the Bow, Cardric the Steady, can be found just to the southeast of the castle in the city of Harmondale."
	evt.Set("AutonotesBits", 139)         -- ""
end

-- "Brother Rothham"
evt.global[327] = function()
	evt.SetMessage(526)         -- "The Master instructor of the Mace, Brother Rothham, can be found in the southern region of the swamps of Tatalia."
	evt.Set("AutonotesBits", 140)         -- ""
end

-- "Patwin Fellbern"
evt.global[328] = function()
	evt.SetMessage(527)         -- "The Grandmaster of the Mace, Patwin Felburn, teaches from his home in the goblin village found in the eastern area of the Deyja. "
	evt.Set("AutonotesBits", 141)         -- ""
end

-- "Isram Gallowswell"
evt.global[329] = function()
	evt.SetMessage(528)         -- "My Master, Isram Gallowswell, can be found in the snowy heights of the northeast area of Tatalia. You will gain further instruction in the Shield there."
	evt.Set("AutonotesBits", 142)         -- ""
end

-- "Fedwin Smithson"
evt.global[330] = function()
	evt.SetMessage(529)         -- "The Grandmaster of the Shield, Fedwin Smithson, can be found on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 143)         -- ""
end

-- "Rabisa Nedlon"
evt.global[331] = function()
	evt.SetMessage(530)         -- "The Master tutor of Leather Armor, Rabisa Neldon, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 144)         -- ""
end

-- "Miyon the Quick"
evt.global[332] = function()
	evt.SetMessage(531)         -- "The Grandmaster of Leather Armor, Miyon the Quick, can be found in the eastern section of the city of Pierpont in the elven region of the Tularean Forest."
	evt.Set("AutonotesBits", 145)         -- ""
end

-- "Medwari Dragontracker"
evt.global[333] = function()
	evt.SetMessage(532)         -- "The Master instructor of uses of Chain Armor, Medwari Dragontracker, can be found in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 146)         -- ""
end

-- "Halian Nevermore"
evt.global[334] = function()
	evt.SetMessage(533)         -- "The Grandmaster instructor of Chain Armor, Halian Nevermore, maintains his residence in a large city in the northwest region of Deyja."
	evt.Set("AutonotesBits", 147)         -- ""
end

-- "Dekian Forgewright"
evt.global[335] = function()
	evt.SetMessage(534)         -- "My Master, Dekian Forgewright, makes his home in Erathia in the capitol city of Steadwick. He can provide further instruction in the uses of Plate Armor."
	evt.Set("AutonotesBits", 148)         -- ""
end

-- "Brand the Maker"
evt.global[336] = function()
	evt.SetMessage(535)         -- "The Grandmaster of Plate Armor, Brand the Maker, can be found in the Bracada desert, on a ridge in the central region."
	evt.Set("AutonotesBits", 149)         -- ""
end

-- "Ashen Temper"
evt.global[337] = function()
	evt.SetMessage(536)         -- "The Master tutor of Fire Magic, Ashen Temper, can be found in the city of Harmondale near the stables."
	evt.Set("AutonotesBits", 150)         -- ""
end

-- "Blayze "
evt.global[338] = function()
	evt.SetMessage(537)         -- "The Grandmaster of Fire Magic, Blayze, makes his home in Erathia in the capitol city of Steadwick."
	evt.Set("AutonotesBits", 151)         -- ""
end

-- "Rislyn Greenstorm"
evt.global[339] = function()
	evt.SetMessage(538)         -- "The Master tutor of Air Magic, Rislyn Greenstorm, lives in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 152)         -- ""
end

-- "Gayle"
evt.global[340] = function()
	evt.SetMessage(539)         -- "The Grandmaster of Air Magic, Gayle, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 153)         -- ""
end

-- "Tobren Rainshield"
evt.global[341] = function()
	evt.SetMessage(540)         -- "The Master tutor of the uses of Water Magic, Tobren Rainshield, lives in the southwest region of Nighon."
	evt.Set("AutonotesBits", 154)         -- ""
end

-- "Torrent"
evt.global[342] = function()
	evt.SetMessage(541)         -- "The Grandmaster of Water Magic, Torrent, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 155)         -- ""
end

-- "Lara Stonewright"
evt.global[343] = function()
	evt.SetMessage(542)         -- "The Master tutor of Earth Magic, Lara Stonewright, makes her home in the elven territory of the Tularean Forest.  Her residence is in the city of Pierpont."
	evt.Set("AutonotesBits", 156)         -- ""
end

-- "Avalanche"
evt.global[344] = function()
	evt.SetMessage(543)         -- "The Grandmaster instructor of Earth Magic, Avalanche, maintains his residence in the western region of the Deyja."
	evt.Set("AutonotesBits", 157)         -- ""
end

-- "Heather Dreamwright"
evt.global[345] = function()
	evt.SetMessage(544)         -- "The Master who taught me, Heather Dreamwright, makes her home in Erathia, somewhere in the capitol city of Steadwick.  Further knowledge of Spirit Magic can be gained there."
	evt.Set("AutonotesBits", 158)         -- ""
end

-- "Benjamin the Balanced"
evt.global[346] = function()
	evt.SetMessage(545)         -- "The ultimate teacher in the ways of Spirit Magic, Benjamin the Balanced, can be found in the elven territory of the Tularean Forest.  His home is in the city of Pierpont."
	evt.Set("AutonotesBits", 159)         -- ""
end

-- "Myles Featherwind"
evt.global[347] = function()
	evt.SetMessage(546)         -- "The Master teacher in the ways of Mind Magic, Myles Featherwind, can be found in the elven territory of Avlee.  His home is in the city to the northeast."
	evt.Set("AutonotesBits", 160)         -- ""
end

-- "Xavier Bremen"
evt.global[348] = function()
	evt.SetMessage(547)         -- "The Grandmaster of Mind Magic, Xavier Bremen, can be found in the snowy heights of the northeast area of Tatalia. "
	evt.Set("AutonotesBits", 161)         -- ""
end

-- "Brother Bombah"
evt.global[349] = function()
	evt.SetMessage(548)         -- "The Master teacher in the ways of Body Magic, Brother Bombah, can be found in the swampy regions of Tatalia.  His home is somewhere in the southern region."
	evt.Set("AutonotesBits", 162)         -- ""
end

-- "Tempus"
evt.global[350] = function()
	evt.SetMessage(549)         -- "The Grandmaster teacher in the ways of Body Magic, Tempus, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 163)         -- ""
end

-- "Samuel Benson"
evt.global[351] = function()
	evt.SetMessage(550)         -- "The Master of the Identify Item skill, Samuel Benson, can be found on a ridge in the central region of the Bracada desert."
	evt.Set("AutonotesBits", 164)         -- ""
end

-- "Payge Blueswan"
evt.global[352] = function()
	evt.SetMessage(551)         -- "The Grandmaster of the Identify Item skill, Payge Blueswan, can be found in the elven territory of Tularean Forest.  His home is just northeast of the elven city of Pierpont."
	evt.Set("AutonotesBits", 165)         -- ""
end

-- "Bethold Caverhill"
evt.global[353] = function()
	evt.SetMessage(552)         -- "The Master of the Merchant skill, Berthold Caverhill, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 166)         -- ""
end

-- "Brigham the Frugal"
evt.global[354] = function()
	evt.SetMessage(553)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 167)         -- ""
end

-- "Thomas Moore"
evt.global[355] = function()
	evt.SetMessage(554)         -- "The Master teacher of the Repair Item Skill, Thomas Moore, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 168)         -- ""
end

-- "Gareth the Fixer"
evt.global[356] = function()
	evt.SetMessage(555)         -- "The Grandmaster of the Repair Item Skill, Gareth the Fixer, teaches from his home in the capitol city of Steadwick in Erathia."
	evt.Set("AutonotesBits", 169)         -- ""
end

-- "Wanda Foestryke"
evt.global[357] = function()
	evt.SetMessage(556)         -- "The Master of the of the art of Body Building, Wanda Foestryke, can be found in the goblin village in eastern DeyJa Moor."
	evt.Set("AutonotesBits", 170)         -- ""
end

-- "Evandar Thomas"
evt.global[358] = function()
	evt.SetMessage(557)         -- "The Grandmaster of the Body Building skill, Evander Thomas, makes his home in the eastern regions of Nighon."
	evt.Set("AutonotesBits", 171)         -- ""
end

-- "Tessa Greensward"
evt.global[359] = function()
	evt.SetMessage(558)         -- "The Master of Meditation, Tessa Greensward, can be found on a ridge in the southeast region of the Bracada desert."
	evt.Set("AutonotesBits", 172)         -- ""
end

-- "Kaine"
evt.global[360] = function()
	evt.SetMessage(559)         -- "The Grandmaster of Meditation, Kaine, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 173)         -- ""
end

-- "Garret Dotes"
evt.global[361] = function()
	evt.SetMessage(560)         -- "The Master of the Perception Skill, Garret Dotes, can be found in the elven area of the Tularean Forest.  His home is in the Elven city of Pierpont."
	evt.Set("AutonotesBits", 174)         -- ""
end

-- "Petra Cleareye"
evt.global[362] = function()
	evt.SetMessage(561)         -- "The Grandmaster of the Skill of Perception, Petra Cleareye, can be found in the city in the northwest region of the Deyja."
	evt.Set("AutonotesBits", 175)         -- ""
end

-- "Lenord Skinner"
evt.global[363] = function()
	evt.SetMessage(562)         -- "The Master of Disarm Trap Skill, Lenord Skinner, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 176)         -- ""
end

-- "Silk Quicktoungue"
evt.global[364] = function()
	evt.SetMessage(563)         -- "The Grandmaster of the Disarm Trap Skill, Silk Quicktoungue, makes his home in the southern region of Nighon."
	evt.Set("AutonotesBits", 177)         -- ""
end

-- "Oberic Crane"
evt.global[365] = function()
	evt.SetMessage(564)         -- "The Master of the Dodging Skill, Oberic Crane, can be found on the eastern most island of the Evenmorn Islands"
	evt.Set("AutonotesBits", 178)         -- ""
end

-- "Kenneth Wain"
evt.global[366] = function()
	evt.SetMessage(565)         -- "The Grandmaster of the Dodging Skill, Kenneth Wain, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 179)         -- ""
end

-- "Ulbrecht the Brawler"
evt.global[367] = function()
	evt.SetMessage(566)         -- "The Master of Unarmed Combat, Ulbrecht the Brawler, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 180)         -- ""
end

-- "Norris "
evt.global[368] = function()
	evt.SetMessage(567)         -- "The Grandmaster of Unarmed Combat, Norris, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 181)         -- ""
end

-- "Jeni Swiftfoot"
evt.global[369] = function()
	evt.SetMessage(568)         -- "The Master instructor of the Identify Monster Skill, Jeni Swiftfoot, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 182)         -- ""
end

-- "Raven the Hunter"
evt.global[370] = function()
	evt.SetMessage(569)         -- "The Grandmaster of the Identify Monster Skill, Raven the Hunter, can be found in a small village to the south of Harmondale."
	evt.Set("AutonotesBits", 183)         -- ""
end

-- "Paula Brightspear"
evt.global[371] = function()
	evt.SetMessage(570)         -- "The Master tutor of the Armsmaster Skill, Paula Brightspear, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 184)         -- ""
end

-- "Lasiter the Slayer"
evt.global[372] = function()
	evt.SetMessage(571)         -- "The Grandmaster of the Armsmaster Skill, Lasiter the Slayer, makes his home in the eastern region of Eeofol."
	evt.Set("AutonotesBits", 185)         -- ""
end

-- "Leane Shadowrunner"
evt.global[373] = function()
	evt.SetMessage(572)         -- "The Master tutor of the Stealing Skill, Leane Shadowrunner, makes her home in the goblin village in the eastern region of the Deyja."
	evt.Set("AutonotesBits", 186)         -- ""
end

-- "Everil Nightwalker"
evt.global[374] = function()
	evt.SetMessage(573)         -- "The Grandmaster teacher of the art of Stealing, Everil Nightwalker, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 187)         -- ""
end

-- "Elzbet Winterspoon"
evt.global[375] = function()
	evt.SetMessage(574)         -- "The Master of Alchemy, Elzbet Winterspoon, can be found in the western region of Nighon."
	evt.Set("AutonotesBits", 188)         -- ""
end

-- "Lucid Apple"
evt.global[376] = function()
	evt.SetMessage(575)         -- "The Grandmaster instructor of Alchemy, Lucid Apple, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 189)         -- ""
end

-- "Dorothy Senjac"
evt.global[377] = function()
	evt.SetMessage(576)         -- "The Master of Learning, Dorothy Senjac, can be found in the southeast region of Nighon."
	evt.Set("AutonotesBits", 190)         -- ""
end

-- "William Davies"
evt.global[378] = function()
	evt.SetMessage(577)         -- "The Grandmaster of Learning, William Smithson, instructs from his home on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 191)         -- ""
end

-- "Helena Morningstar"
evt.global[379] = function()
	evt.SetMessage(578)         -- "The Master of Light Magic, Helena Mornigstar, can be found in the cloud city of Celeste!"
	evt.Set("AutonotesBits", 192)         -- ""
end

-- "Gavin Magnus"
evt.global[380] = function()
	evt.SetMessage(579)         -- "The Grand Master of Light Magic can be found in the wizards castle, Castle Lambent."
	evt.Set("AutonotesBits", 193)         -- ""
end

-- "Seth Darkenmore"
evt.global[381] = function()
	evt.SetMessage(580)         -- "The Master of Dark, Seth Darkenmore, can be found in The Pit beneath Deyja!"
	evt.Set("AutonotesBits", 194)         -- ""
end

-- "Archibald"
evt.global[382] = function()
	evt.SetMessage(581)         -- "The Grand Master of Dark Magic can be found in the necromancer castle, Castle Gloaming.  At times Archibald has been know to take the journey to Clankers Lab."
	evt.Set("AutonotesBits", 195)         -- ""
end

-- "Empty Barrel"
evt.global[383] = function()
	evt.StatusText(582)         -- "Empty Barrel"
end

-- "Red Barrel"
evt.global[384] = function()
	evt.StatusText(583)         -- "+2 Might permanent"
	evt.Add("BaseMight", 2)
	evt.Set("AutonotesBits", 33)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Yellow Barrel"
evt.global[385] = function()
	evt.StatusText(584)         -- "+2 Accuracy permanent"
	evt.Add("BaseAccuracy", 2)
	evt.Set("AutonotesBits", 37)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Blue Barrel"
evt.global[386] = function()
	evt.StatusText(585)         -- "+2 Personality permanent"
	evt.Add("BasePersonality", 2)
	evt.Set("AutonotesBits", 35)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Orange Barrel"
evt.global[387] = function()
	evt.StatusText(586)         -- "+2 Intellect permanent"
	evt.Add("BaseIntellect", 2)
	evt.Set("AutonotesBits", 34)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Green Barrel"
evt.global[388] = function()
	evt.StatusText(587)         -- "+2 Endurance permanent"
	evt.Add("BaseEndurance", 2)
	evt.Set("AutonotesBits", 36)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Purple Barrel"
evt.global[389] = function()
	evt.StatusText(588)         -- "+2 Speed permanent"
	evt.Add("BaseSpeed", 2)
	evt.Set("AutonotesBits", 38)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "White Barrel"
evt.global[390] = function()
	evt.StatusText(589)         -- "+2 Luck permanent"
	evt.Add("BaseLuck", 2)
	evt.Set("AutonotesBits", 39)         -- ""
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Empty Cauldron"
evt.global[391] = function()
	evt.StatusText(590)         -- "Empty Cauldron"
end

-- "Steaming Cauldron"
evt.global[392] = function()
	evt.StatusText(591)         -- "+2 Fire Resistance permanent"
	evt.Add("FireResistance", 2)
	evt.Set("AutonotesBits", 40)         -- ""
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Frosty Cauldron"
evt.global[393] = function()
	evt.StatusText(592)         -- "+2 Water Resistance permanent"
	evt.Add("WaterResistance", 2)
	evt.Set("AutonotesBits", 41)         -- ""
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Shocking Cauldron"
evt.global[394] = function()
	evt.StatusText(593)         -- "+2 Air Resistance permanent"
	evt.Add("AirResistance", 2)
	evt.Set("AutonotesBits", 42)         -- ""
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Dirty Cauldron"
evt.global[395] = function()
	evt.StatusText(594)         -- "+2 Earth Resistance permanent"
	evt.Add("EarthResistance", 2)
	evt.Set("AutonotesBits", 43)         -- ""
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Trash Heap"
evt.global[396] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[397] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[398] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[411] = function()
	local i
	i = Game.Rand() % 2
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
			return
		end
	end
	evt.StatusText(596)         -- "Nothing Here"
end

-- "Campfire"
evt.global[412] = function()
	evt.Add("Food", 2)
	if evt.Cmp("PerceptionSkill", 1) then
		evt.GiveItem{Strength = 2, Type = const.ItemType.Ring_, Id = 0}
		evt.ChangeEvent(0)
	else
		evt.ChangeEvent(0)
	end
end

-- "Campfire"
evt.global[413] = function()
	evt.Add("Food", 1)
	if evt.Cmp("PerceptionSkill", 1) then
		evt.GiveItem{Strength = 1, Type = const.ItemType.Ring_, Id = 0}
		evt.ChangeEvent(0)
	else
		evt.ChangeEvent(0)
	end
end

-- "Food Bowl"
evt.global[414] = function()
	evt.Add("Inventory", 630)         -- "Red Apple"
	evt.ChangeEvent(0)
end

-- "Empty Cask"
evt.global[415] = function()
	evt.StatusText(599)         -- "Empty Cask"
end

-- "Cask"
evt.global[416] = function()
	local i
	i = Game.Rand() % 6
	if i >= 3 and i <= 5 then
		i = Game.Rand() % 6
		if i >= 3 and i <= 5 then
			evt.Set("PoisonedGreen", 0)
			evt.StatusText(597)         -- "Poisoned!"
		else
			evt.Set("Drunk", 0)
			evt.StatusText(598)         -- "Drunk!"
		end
	else
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.Add("Inventory", 202)         -- "Vial of Troll Blood"
		elseif i == 3 or i == 4 then
			evt.Add("Inventory", 217)         -- "Vial of Ooze Endoplasm"
		elseif i == 5 then
			evt.Add("Inventory", 218)         -- "Mercury"
		else
			evt.Add("Inventory", 214)         -- "Vial of Devil Ichor"
		end
	end
	evt.ChangeEvent(415)         -- "Empty Cask"
end

-- "Mushroom"
evt.global[417] = function()
	evt.Add("Inventory", 215)         -- "Mushroom"
	evt.ChangeEvent(0)
end

-- "Lord Markham"
evt.global[418] = function()
	evt.SetMessage(601)         -- "So YOU'RE the ones that won Lord Markham's contest!  How do you like your winnings so far?  Had enough winning?  If I were you, I'd give him a piece of my mind!  His mansion is in Tatalia, near the wharf."
end

-- "The Master Thief"
evt.global[419] = function()
	evt.SetMessage(602)         -- "Watch your wallet while you're here, my friends--Steadwick abounds in thieves.  As a matter of fact, we are the world capital of thieves!  It's common knowledge that Bill Lasker, the Master Thief, lives in the sewers beneath Steadwick."
end

-- "Watchtowers"
evt.CanShowTopic[420] = function()
	if not evt.Cmp("QBits", 196) then         -- Find second entrance to Watchtower6
		return evt.Cmp("QBits", 19)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
	end
	return true
end

evt.global[420] = function()
	if evt.Cmp("QBits", 196) then         -- Find second entrance to Watchtower6
		evt.SetMessage(644)         -- "Glad you found the way in the back door.  You probably avoided a really nasty ambush that way.  I hope my advice was useful!"
	else
		evt.SetMessage(603)         -- "Back when I was in the army, I was assigned to scout out the watchtowers in Deyja.  <chuckling> It's no good trying to go through the front door, so I usually looked around for another way in.  Those Necromancers are so cowardly, they always have an escape route.  And a way out is also a way in..."
	end
end

-- "Bill Lasker"
evt.global[421] = function()
	evt.SetMessage(604)         -- "Bill Lasker may be a criminal, but he has worked for the Crown from time to time.  Special missions, official denials of involvement, spying…that sort of stuff.  Quite a few unusual events can be tied to Bill, but none to the Crown.  Seriously, don't you think the Queen's men could find and arrest one man, even if he was hiding in the sewer?"
end

-- "Lady Carmine"
evt.CanShowTopic[422] = function()
	if not evt.Cmp("Awards", 14) then         -- "Promoted to Assassin"
		if not evt.Cmp("Awards", 15) then         -- "Promoted to Honorary Assassin"
			return evt.Cmp("QBits", 21)         -- "Go to the Celestial Court in Celeste and kill Lady Eleanor Carmine.  Return with proof to Seknit Undershadow in the Deyja Moors."
		end
	end
	return true
end

evt.global[422] = function()
	if not evt.Cmp("Inventory", 540) then         -- "Lady Carmine's Dagger"
		if not evt.Cmp("Awards", 14) then         -- "Promoted to Assassin"
			if not evt.Cmp("Awards", 15) then         -- "Promoted to Honorary Assassin"
				evt.SetMessage(605)         -- "You want to know about that traitor, Carmine?  Well, she used to work for the diplomatic corps, until she went soft and signed up with the goody two-shoes wizards.  Now she walks the streets of Celeste freely, without a care in the world for the people she left behind.  Something bad will happen to her soon, mark my words!"
				return
			end
		end
	end
	evt.SetMessage(645)         -- "So…what goes around comes around, eh?  Good job with that Carmine traitor!"
end

-- "Assasins"
evt.global[423] = function()
	evt.SetMessage(606)         -- "Looking for ""work""?  You can find the Master Assassin somewhere in the Pit.  He'll have something for you.  There's always someone or something that needs killing, that's for certain."
end

-- "Wromthrax the Heartless"
evt.CanShowTopic[424] = function()
	if not evt.Cmp("Awards", 40) then         -- "Promoted to Crusader"
		if not evt.Cmp("Awards", 41) then         -- "Promoted to Honorary Crusader"
			return evt.Cmp("QBits", 22)         -- "Kill Wromthrax the Heartless in his cave in Tatalia, then talk to Sir Charles Quixote."
		end
	end
	return true
end

evt.global[424] = function()
	if not evt.Cmp("Awards", 14) then         -- "Promoted to Assassin"
		if not evt.Cmp("Awards", 15) then         -- "Promoted to Honorary Assassin"
			evt.SetMessage(607)         -- "Until recently, our local dragon Wromthrax the Heartless has confined his depredations to the hills in the south--eating goats, farm animals, and stray dogs.  But he has developed a taste for elvish blood, and now hunts us as well.  If you should care to confront him, his cave is in the north, west of the Mercenary Guild in the mountains.  He isn't always there.  Be careful--he is mighty."
			return
		end
	end
	evt.SetMessage(646)         -- "The dragon is fallen--and at your hands!  You are a hero!"
end

-- "Crusaders"
evt.global[425] = function()
	evt.SetMessage(608)         -- "What, you wanna be a crusader too?  This town is filling up with them, I swear!  Well, there's a crazy man living in the back of a building near the center of town.  People keep trying to sign up with him, and he keeps rejecting them.  Good luck."
end

-- "The Fairest of them all"
evt.global[426] = function()
	evt.SetMessage(609)         -- "Just a minute, let me check.  Mirror, mirror, on the wall… <the witch peers into her mirror for a few minutes, then sighs> It's still Alice Hargreaves.  She lives in Castle Gryphonheart.  She's quite a noble beauty, that girl is!  Takes me back to my youth, this one does."
end

-- "Villains"
evt.global[427] = function()
	evt.SetMessage(610)         --[[ "One of our finest, most upstanding citizens is William Setag, considered by some to be the most black hearted villain alive.  As a matter of fact, he's one of our best agents.  Wizards and their ilk complain because they've been on the receiving end of his schemes too many times-- but he's about the best there is in his profession.  

If you're looking for employment, go see him.  His tower is on the north shore of Deyja at a rather inaccessible point.  He doesn't like visitors, but he should be glad to see more students turn up at his door." ]]
end

-- "Monk Training"
evt.global[428] = function()
	evt.SetMessage(611)         -- "If you're looking for a teacher to begin serious monk training, speak with Bartholomew Hume--you can find him in the village south of the town of Harmondale."
end

-- "Medusas"
evt.global[429] = function()
	evt.SetMessage(617)         -- "There is a breed of Medusa infesting the Red Dwarf Mines that is immune to magic.  These monsters are a real terror!  I can only thank the Gods that these creatures haven't escaped the mine.  What would we do then, beat them to death with our staves?"
end

-- "Temple of Baa"
evt.CanShowTopic[430] = function()
	if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
		if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
			return evt.Cmp("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		end
	end
	return true
end

evt.global[430] = function()
	if not evt.Cmp("Inventory", 530) then         -- "Cloak of the Sheep"
		if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
			if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
				evt.SetMessage(613)         -- "A few years back, a weird cult called the Temple of Baa moved into the area.  At first they seemed popular, what with their free offers of healing, but it soon became clear they were devoted to darkness.  No one goes up there very much, now, and it seems that whatever evil gods were backing them have withdrawn their support.  But they're up there still, lurking in the shadows.  Creepy."
				return
			end
		end
	end
	evt.SetMessage(647)         -- "The Baa cult is gone?  Well that IS good news!  Everyone is in your debt, whether they know it or not.  "
end

-- "Missing Sheep"
evt.CanShowTopic[431] = function()
	if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
		if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
			return evt.Cmp("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
		end
	end
	return true
end

evt.global[431] = function()
	if not evt.Cmp("Inventory", 530) then         -- "Cloak of the Sheep"
		if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
			if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
				evt.SetMessage(614)         -- "Lots of sheep have gone missing since the Baa cult moved in--and I mean lots.  No doubt they were taken to the Baa temple for sacrifice.  I'm going to go broke if someone doesn't do something about those cultists!"
				return
			end
		end
	end
	evt.SetMessage(648)         -- "Glad to hear the Baa cult has gone missing, instead of my sheep!  Good job!"
end

-- "Ciphers"
evt.global[432] = function()
	evt.SetMessage(615)         -- "Ssspies abound in places like this, my friendsss.  If you wish your letters and communiqués to remain sssecret, you should use a cipher when you write.  There is a book in the Castle library that will explain everything, my friendsss."
end

-- "The nature of ooze"
evt.global[433] = function()
	evt.SetMessage(616)         --[[ "Eight years ago, we sent a team of scholars to what is now the Red Dwarf Mine to study the strange creatures that would occasionally show up there.  

The first thing we noticed was that Ooze ectoplasm makes an excellent potion catalyst.  The second was that ooze just can't be physically damaged--they split apart or squish, then run back together. If you want to kill one, you'll have to do it with magic." ]]
end

-- "Medusas"
evt.global[434] = function()
	evt.SetMessage(617)         -- "There is a breed of Medusa infesting the Red Dwarf Mines that is immune to magic.  These monsters are a real terror!  I can only thank the Gods that these creatures haven't escaped the mine.  What would we do then, beat them to death with our staves?"
end

-- "Titans' Stronghold"
evt.global[435] = function()
	evt.SetMessage(618)         -- "If you head south past the Wyvern Plains, don't go knocking at the door of that huge fortress you'll see standing in the middle of the water.  It's the Titan's Stronghold, and they don't much like visitors."
end

-- "The Arena"
evt.global[436] = function()
	evt.SetMessage(619)         -- "Arena fighting is available to anyone who wants to practice against any kind of opponent.  You can get to the arena by visiting a stable on any Sunday and asking them to take you there.  "
end

-- "Arena Championships"
evt.global[437] = function()
	evt.SetMessage(620)         -- "Arena Champships are held on each Sunday.  They are open to all--but be careful!  Your opponents are chosen by the Arena management, not you!"
end

-- "Haunted Mansion"
evt.global[438] = function()
	evt.SetMessage(621)         -- "Every graveyard or ancestral burial place seems to have a haunted house nearby--and ours is no exception.  There is a mansion near one of the plateaus on the surface in the northwest.  It is most certainly haunted."
end

-- "Ghosts"
evt.global[439] = function()
	evt.SetMessage(622)         -- "Fear the touch of the Ghost as you fear the loss of your life.  It inflicts terrible spiritual wounds and drains your youth before your eyes!"
end

-- "Secret passage"
evt.global[440] = function()
	evt.SetMessage(623)         -- "A few wars ago, my great grandfather worked on an escape tunnel from the Elvish castle to the Tularean Caves.  I don't think it's ever been used--no attack on the castle has ever brought it down--but it sure is an interesting piece of history, don't you think?"
end

-- "Faeries"
evt.global[441] = function()
	if evt.Cmp("QBits", 197) then         -- Entered Faerie Mound
		evt.SetMessage(649)         -- "I'm impressed--very few actually make it inside the fairy mound, or get very far."
	else
		evt.SetMessage(624)         -- "They say that elves are faeries, but in truth we are only distantly related.  The true faeries don't live in civilization, and they're just like the stories say--playful, cruel, magical, and dangerous.  But if you really want to meet them, you could visit them in their Hall under the Hill, as they call it.  It is just outside of the village, to the North and West.  It will be challenging to get to the front door... "
	end
end

-- "Mad Forest"
evt.global[442] = function()
	if not evt.Cmp("Inventory", 600) then         -- "Heart of the Wood"
		if not evt.Cmp("Awards", 30) then         -- "Promoted to Ranger Lord"
			if not evt.Cmp("Awards", 31) then         -- "Promoted to Honorary Ranger Lord"
				if not evt.Cmp("Awards", 61) then         -- "Retrieved the Heart of the Wood"
					evt.SetMessage(625)         -- "A while ago, I saw some men come to the Tularean Forest at night with axes and torches, following some sort of map.  When they left, they were laughing and happy.  It looked like they were carrying a big green rock.  My brother says they were a band of mercenaries from Tatalia.  Anyway, the next day was when the forest went mad.  It's too dangerous to go there now."
					return
				end
			end
		end
	end
	evt.SetMessage(650)         -- "The forest is much safer now, thanks you to!  The oldest tree is very happy with you, and has included you in its history recitals."
end

-- "Oldest Tree"
evt.global[443] = function()
	evt.SetMessage(626)         -- "The Tularean Forest is so old that it has developed a mind…sort of.  The forest is vaguely aware of who walks through it, but only one part of the forest can communicate with people.  That's the oldest tree.  If you want to have a very long and slow conversation, it will be happy to oblige.  Look for it on an island to the south east of the forest.  It's larger than the rest of the trees.  You can't miss it."
end

-- "Bounty Hunting"
evt.global[444] = function()
	evt.SetMessage(627)         -- "Anyone needing to earn some spare cash can visit a town hall in any major city to pick up a bounty hunting assignment.  City councils are always fearful of the latest man eating monster or bandit or mad wizard, and set bounties on the creature that is bothering them most this month.  There's no rhyme or reason to their choices, so don't try to figure it out.  They often pay quite well."
end

-- "Professional Bounty Hunting"
evt.global[445] = function()
	evt.SetMessage(628)         -- "If you ever get tired of amateur bounty hunts, and want to advance your career, speak with Ebednezer Sower in Avlee.  He only teaches followers of the shadow path, though."
end

-- "Tidewater Caverns"
evt.global[446] = function()
	evt.SetMessage(629)         -- "Pirates been operating out of the tidewater caverns for twenty years.  They're not Regnans, and they aren't part of Bill Lasker's men, but they're still pretty mean.  You want to get in there, just get yourself out to the islands to the west."
end

-- "Evenmorn Islands"
evt.global[447] = function()
	if not evt.Cmp("Inventory", 683) then         -- "Map to Evenmorn Island"
		if not evt.Cmp("Awards", 62) then         -- "Promoted to Priest"
			if not evt.Cmp("Awards", 63) then         -- "Promoted to Honorary Priest"
				evt.SetMessage(630)         -- "Evenmorn Island isn't lost, so much as hard to get to.  It is surrounded by treacherous reefs, sandbars, whirlpools, and sharks.  If it's dangerous, the Island is surrounded by it.  There are only one or two safe ways in, and the map for those ways was stolen by pirates during the chaos of the recent wars.  They probably still have the map in their caves.  "
				return
			end
		end
	end
	evt.SetMessage(651)         -- "Oh, so the map is found?  What will you do with your newfound treasure?  Share it, I hope!"
end

-- "Reef Maps"
evt.global[448] = function()
	if not evt.Cmp("Inventory", 683) then         -- "Map to Evenmorn Island"
		if not evt.Cmp("Awards", 62) then         -- "Promoted to Priest"
			if not evt.Cmp("Awards", 63) then         -- "Promoted to Honorary Priest"
				evt.SetMessage(631)         -- "The boat captains would be happy to take any paying fare to Evenmorn island, but they don't have proper maps.  There's no way anyone is going to risk their ship in the reefs around the Island unless they have the map!"
				return
			end
		end
	end
	evt.SetMessage(652)         -- "Now that you have the map, I guess you'll be going there soon.  Be careful--they say the island is cursed!"
end

-- "The Curse"
evt.global[449] = function()
	evt.SetMessage(653)         -- "If you don't mind the swamp and fog, Evenmorn Island is a great place to live.  Of course, the Curse doesn't help--ghosts and skeletons roam the island freely--but other than that, the neighbors keep to themselves.  The Churches of the Sun and the Moon don't even fight each other very much anymore.  <Heh!> probably means they're running out of adherents..."
end

-- "Golem parts"
evt.global[450] = function()
	evt.SetMessage(632)         -- "Well, I don't have any golem parts--I never took that class--but there are students all over Bracada who have spare golem parts lying around.  They aren't worth anything unless you have them all, so they'll probably just give them to you for free."
end

-- "Golems"
evt.global[451] = function()
	evt.SetMessage(633)         -- "You see all those golems walking around Bracada?  Every single one of them was made by the School.  Not bad for students, eh?  They don't have much to say, but they're tough guardians and can tell when a follower of Darkness is near.  You should see them go into action when one of those Necromancers or Warlocks wanders into our lands.  Zowwwwwieeee!"
end

-- "Divine Intervention Book"
evt.global[452] = function()
	if not evt.Cmp("Inventory", 487) then         -- "Divine Intervention"
		if not evt.Cmp("Awards", 76) then         -- "Promoted to Archmage"
			if not evt.Cmp("Awards", 77) then         -- "Promoted to Honorary Archmage"
				evt.SetMessage(634)         -- "Our astrologers have determined that the missing Divine Intervention text lies somewhere deep under the ground.  Under Deyja, to be precise.  They fear that the current incarnation of the text has fallen into the Breeding Pit--the Necromancer's version of our Proving Grounds.  Oh, what must we have done to offend the Gods so?  We will never retrieve the text from that forsaken place!"
				return
			end
		end
	end
	evt.SetMessage(654)         -- "Divine intervention has been found and copied?  A miracle!  I never expected to see it in my lifetime!  "
end

-- "Divine Intervention"
evt.global[453] = function()
	if not evt.Cmp("Inventory", 487) then         -- "Divine Intervention"
		if not evt.Cmp("Awards", 76) then         -- "Promoted to Archmage"
			if not evt.Cmp("Awards", 77) then         -- "Promoted to Honorary Archmage"
				evt.SetMessage(635)         -- "The spell of Divine Intervention, the highest of the school of Light magic, has been missing for centuries.  It is a curse, we believe, for our lack of devotion and faith to the Light.  We struggle, and some go forth to find the spell, from time to time, but none have been successful.  Each time they find it, fate cruelly snatches it from our hands.  Our Grandmasters have been bereft of this final, great spell for as long as anyone alive can remember."
				return
			end
		end
	end
	evt.SetMessage(655)         -- "All the grandmasters are very pleased with you.  You have done our profession a great service!"
end

-- "Soul Jars"
evt.global[454] = function()
	evt.SetMessage(636)         -- "The only people in the world who make soul jars are the Warlocks of Nighon.  It is a secret of their profession--which is strange, since they have absolutely no use for them.  Still, we are forced to bargain for the jars in order to advance our craft.  Of course, we have wrested the jars from them, from time to time...but then they raise their prices in revenge.  It must be our fate to suffer so."
end

-- "The Rituals"
evt.global[455] = function()
	evt.SetMessage(637)         -- "Every Necromancer aspires to be a Lich one day.  All you need is a Soul Jar, knowledge of the Ritual, and the magical skill to survive the journey to the Land of the Dead and return.  The body withers while the soul lives on in a glorious state free from hunger, disease, and injury.  Only shallow and superficial people would mind what the Ritual does to one's appearance.  True practitioners hardly notice."
end

-- "Circle of stone"
evt.global[456] = function()
	if not evt.Cmp("Awards", 68) then         -- "Promoted to Great Druid"
		if not evt.Cmp("Awards", 69) then         -- "Promoted to Honorary Great Druid"
			evt.SetMessage(638)         -- "Three circles of stones were built by the Druids long ago.  Since hearing of their locations ruins ascension attempts for would be Great Druids, I can only give you a general clue--All are in the open, unhidden and bare, and all are distant from settlements.  To tell you more would spoil your Ascension."
			return
		end
	end
	evt.SetMessage(656)         -- "Since you've discovered the circles on your own they have worked their magic on you.  I hope you will refrain from telling others of their whereabouts, as I have done for you."
end

-- "Summer Circle"
evt.global[457] = function()
	evt.SetMessage(639)         -- "Originally, there were four Circles of Stone, one for each Cardinal direction and season, but the Eastern Circle was destroyed somewhere in Nighon during the wars between the Churches of the Sun and the Moon."
end

-- "The graveyard"
evt.global[458] = function()
	evt.SetMessage(640)         -- "The graveyard does indeed hold the bones of the ancient King, but the hallowed land will curse any who disturb it.  I don't envy you this task.  Each grave you open will unleash its curse, and possibly some other trap.  Best be sure you're opening the correct grave when you begin to dig."
end

-- "Barrow Navigation"
evt.global[459] = function()
	evt.SetMessage(641)         -- "Though the barrows were built to deter thieves, a way was needed to navigate them during burials and ceremonies.  Near each of the gates you'll find a plaque.  These plaques are cryptic, but they will keep you from losing your way, as long as you use them.  No thief yet has realized their significance, so once they enter the barrows, they never leave."
end

-- "Land of the Titans"
evt.global[460] = function()
	evt.SetMessage(642)         -- "We built a tunnel leading from our Thunderfist Mountain to the Land of the Giants during the War.  It was there we discovered the Kreegan, and more titans and dragons then you can imagine.  I suppose one who's familiar is to be a dragon could find eggs in one of the dragon caves of that terrible land.  'Ware the mother..."
end

-- "The Mega Dragon"
evt.global[461] = function()
	evt.SetMessage(643)         -- "I've heard legends that there is a dragon in the Land of the Titans greater than any that have come before.  Lesser dragons and titans do battle on the slopes of the mountain in which its cave resides.  This dragon is so huge, and so mighty that the other dragons feed it for fear it will one day leave its cave and devour them all in its fury.  The dragons believe it is a god.  If that is so, imagine its treasure..."
end

-- "Quest"
evt.global[462] = function()
	evt.SetMessage(657)         -- "During the wars between the Temples of the Sun and Moon, three statuettes were stolen from the shrines in the Bracada Desert, Tatalia, and Avlee.  I represent a group of Druids that want these shrines back to their original form-- it is critical for their worship.  To this end, I am offering a substantial reward for anyone that will find the statuettes and place them on the shrines."
	evt.Set("QBits", 200)         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
	evt.SetNPCTopic{NPC = 288, Index = 0, Event = 463}         -- "Thom Lumbra" : "Quest"
end

-- "Quest"
evt.global[463] = function()
	if evt.Cmp("QBits", 201) then         -- Placed item 617 in out14(statue)
		if evt.Cmp("QBits", 202) then         -- Place item 618 in out13(statue)
			if evt.Cmp("QBits", 203) then         -- Place item 619 in out06(statue)
				evt.SetMessage(659)         -- "Great work!  The Druids are so pleased, they threw in a little extra for your fine performance.  Take this… you most certainly deserve it."
				evt.Add("Gold", 50000)
				evt.Subtract("Reputation", 10)
				evt.ForPlayer("All")
				evt.Subtract("QBits", 200)         -- "Retrieve the three statuettes and place them on the shrines in the Bracada Desert, Tatalia, and Avlee, then return to Thom Lumbra in the Tularean Forest."
				evt.Add("Experience", 50000)
				evt.Add("Awards", 100)         -- "Found and placed all the statuettes"
				evt.SetNPCGreeting{NPC = 288, Greeting = 174}         -- "Thom Lumbra" : "Excellent work; my associates are quite pleased."
				evt.SetNPCTopic{NPC = 288, Index = 0, Event = 0}         -- "Thom Lumbra"
				return
			end
		end
	end
	evt.SetMessage(658)         -- "All three statuettes are not placed.  I cannot reward partial success.  Return when you have placed all three."
end

-- "Quest"
evt.global[464] = function()
	evt.SetMessage(660)         -- "As you may have already guessed, I'm a collector of fine art.  Currently, I am looking for a set of paintings, one of King Roland, one of his brother Archibald, and one of the angel statue in the courtyard of Castle Ironfist.  This set is of great value, and, as a collector, I'm willing to pay quite handsomely for it.  If you should gather the entire set of paintings bring them back to me and I'll be sure to compensate you well for your effort."
	evt.Set("QBits", 204)         -- "Retrieve the three paintings and return them to Ferdinand Visconti in Tatalia."
	evt.SetNPCTopic{NPC = 289, Index = 0, Event = 465}         -- "Ferdinand Visconti" : "Quest"
end

-- "Quest"
evt.global[465] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 621) then         -- "Angel Statue Painting"
		if evt.Cmp("Inventory", 622) then         -- "Archibald Ironfist Painting"
			if evt.Cmp("Inventory", 623) then         -- "Roland Ironfist Painting"
				evt.SetMessage(663)         -- "Wonderful!  This set has eluded me for years!  You more than deserve the reward I promised; here, hopefully this will be sufficient."
				evt.Subtract("Inventory", 621)         -- "Angel Statue Painting"
				evt.Subtract("Inventory", 622)         -- "Archibald Ironfist Painting"
				evt.Subtract("Inventory", 623)         -- "Roland Ironfist Painting"
				evt.ForPlayer("Current")
				evt.Add("Gold", 50000)
				evt.Subtract("Reputation", 10)
				evt.ForPlayer("All")
				evt.Subtract("QBits", 204)         -- "Retrieve the three paintings and return them to Ferdinand Visconti in Tatalia."
				evt.Add("Experience", 50000)
				evt.Add("Awards", 101)         -- "Retrieved the complete set of paintings"
				evt.SetNPCGreeting{NPC = 289, Greeting = 176}         -- "Ferdinand Visconti" : "Thank you for your assistance in completing my collection.  You have my gratitude forever!"
				evt.SetNPCTopic{NPC = 289, Index = 0, Event = 0}         -- "Ferdinand Visconti"
				return
			end
		end
	end
	evt.SetMessage(662)         -- "Remember, I need the complete set of paintings-- they aren't worth much by themselves.  When you have the rest, bring them all to me."
end

-- "Quest"
evt.global[466] = function()
	evt.SetMessage(664)         -- "To be declared ArcoMage Champion, you must win a game of ArcoMage in every tavern on, in, and under the continent of Erathia.  There are 13 such taverns sponsoring ArcoMage events.  When you have accomplished this, return to me to claim the prize."
	evt.Set("QBits", 205)         -- "Win a game of Arcomage in all thirteen taverns, then return to Gina Barnes in Erathia."
	evt.SetNPCTopic{NPC = 290, Index = 0, Event = 467}         -- "Gina Barnes" : "Quest"
end

-- "Quest"
evt.global[467] = function()
	if evt.Cmp("QBits", 238) then         -- Won all Arcomage games
		evt.SetMessage(666)         -- "Congratulations!  You have become the ArcoMage Champion!  The prize is waiting in the chest right outside my house."
		evt.Subtract("QBits", 205)         -- "Win a game of Arcomage in all thirteen taverns, then return to Gina Barnes in Erathia."
		evt.Add("Gold", 100000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 244)         -- Finished ArcoMage Quest - Get the treasure
		evt.Add("Awards", 102)         -- "ArcoMage Champion"
		evt.SetNPCGreeting{NPC = 290, Greeting = 178}         -- "Gina Barnes" : "Welcome ArcoMage Champions!"
		evt.SetNPCTopic{NPC = 290, Index = 0, Event = 0}         -- "Gina Barnes"
	else
		evt.SetMessage(665)         -- "You must claim a victory at ALL 13 taverns.  Until you do, you cannot be declared ArcoMage Champion."
	end
end

-- "Stone City"
evt.global[468] = function()
	evt.SetMessage(669)         -- "People say the Dwarves live in the barren lands south of Harmondale, but that's not exactly true--They live UNDER them.  Look for their front gate in the center of the Barrow Downs where three bridges meet."
end

-- "Stone City"
evt.global[469] = function()
	evt.SetMessage(670)         -- "Ever since the Warlocks of Nighon tunneled through Stone City from their island, travelers have been asking to pass through the city to get to Nighon.  The Dwarf King hates this, and would like to charge a hefty fee for people seeking to enter Stone City.  He has not started charging however, fearing political and possible violent repercussions with the Warlocks of Nighon."
end

-- "Passage to Nighon"
evt.global[470] = function()
	evt.SetMessage(671)         -- "The Warlocks of Nighon live in Thunderfist Mountain--an extinct volcano on a large island a few miles from the mainland.  During the recent wars, the Warlocks tunneled through Stone City to transport their forces across the channel.  Those tunnels are still open and can be traversed."
end

-- "Warlock's Tunnels"
evt.global[471] = function()
	evt.SetMessage(672)         -- "During the War, the Warlocks tunneled from Nighon through Stone City to get to the mainland and seize territory.  Even though they were pushed back to their island by Erathia, the tunnels remain."
end

-- "Barrows"
evt.global[472] = function()
	evt.SetMessage(673)         -- "Dwarves live under the ground of the Barrow Downs--a barren collection of ancient gravesites built by their race centuries ago to honor fallen kings and heroes.  Not all of the barrows can be reached on the surface--many are magically connected to each other through a system of teleporters and traps that protect the graves from those who would rob them.  If you look closely at the walls you should see markings that might help you navigate."
end

-- "Medusas"
evt.global[473] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(703)         -- "The Lords of Harmondale!  Heroes, I say!  My cousin was one of the ones you rescued!  We are in your debt!"
	else
		evt.SetMessage(674)         -- "We were making a fortune in the Red Dwarf Mines until the Medusas came!  We had to run before they turned everyone to stone.  Without our mining, we have almost no way to make a living.  Not the way for a proper Dwarf to live, I say!"
	end
end

-- "Red Dwarf Mines"
evt.global[474] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(704)         -- "Thank you for delivering our people from the medusas!  The Dwarves of Stone City will not forget you!"
	else
		evt.SetMessage(675)         -- "Bracada leased the land where we started the Red Dwarf Mine to us a few years ago.  That was until the Medusas came and took the mines from our people.  Only the Gods know what horrors go on in there now.  The mines were in the Northeast corner of Bracada."
	end
end

-- "The Statues"
evt.global[475] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(705)         -- "We owe you much for your daring rescue of our people.  Rebuilding your castle was the least we could do for you."
	else
		evt.SetMessage(676)         -- "When the Medusas took the Red Dwarf Mines from us, not everyone escaped.  There are still several statues in the mines.  They can be rescued if their statues haven't been broken yet, but you would have to fight through the Medusas to do it."
	end
end

-- "Stone City"
evt.global[476] = function()
	evt.SetMessage(677)         -- "Do you like our city?  It's not just a hole in the ground--it's a home in the ground!  Dwarves have been working this mountain for centuries!  There isn't much mining left here, though, and what there is happens to be in unstable and unsafe tunnels.  Be careful if you go to the lower levels."
end

-- "Harmondale"
evt.global[477] = function()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(678)         -- "Respectfully, my lords, I must say that no one expects you to last long because no other lords of Harmondale have lasted long.  The fighting and politics between Erathia and Avlee will claim you sooner or later.  Probably sooner."
			return
		end
	end
	evt.SetMessage(706)         -- "Good day, my lords.  I must say the people are changing their minds about your chances of survival.  Everyone is saying how wonderful it is to have stable rulers in the Castle!"
end

-- "Rebellions"
evt.global[478] = function()
	evt.SetMessage(679)         -- "Rebellions here in Harmondale are rare, but we've had a couple of big ones!  Most of the time lords here don't last long enough to rebel against, but there've been some wicked ones!  Not that I think you're wicked, my lords."
end

-- "Castle Harmondale"
evt.global[479] = function()
	if evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		evt.SetMessage(707)         -- "It's good to see the Castle rebuilt and those loathsome goblin bandits evicted.  Things are looking better around here since you took over!"
	else
		evt.SetMessage(680)         -- "It's good to see someone in Harmondale again, my lords.  The castle's been standing empty since the War, except for the goblins.  But they don't count, I suppose."
	end
end

-- "Tularean Caves"
evt.global[480] = function()
	evt.SetMessage(681)         -- "What with all the wars that Avlee gets itself into all the time, and all the high taxes, I've moved to Harmondale to stay.  Harmondale sees a lot of violence, but at least they don't conscript.  You know, there's been so many wars in Avlee that one of the kings had a tunnel dug from his castle to the caves in the North just in case the castle was taken AGAIN."
end

-- "White Cliff Caves"
evt.global[481] = function()
	evt.SetMessage(682)         -- "A ways outside of Harmondale there's a cave system that's always been the home of bandits, monsters, and other ne'er-do-wells.  They're called the White Cliff Caves.  If you're ever robbed, or are looking for some evil doers to punish, all you got to do is go up there.  You'll find a fight for sure!"
end

-- "Fort Riverstride"
evt.global[482] = function()
	if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
		evt.SetMessage(708)         -- "I've heard Fort Riverstride was taken with the aid of treachery!  What a shame that those wretches were able to wring concessions from the Queen in exchange for the return of what was already ours!"
	else
		evt.SetMessage(683)         -- "Did you notice that covered bridge on the way from Harmondale to Steadwick?  It's called Fort Riverstride, and it protects us from surprise Elvish attacks coming through Harmondale.  There's so many traps and tricks inside there, they say it will never fall without the help of treachery.  "
	end
end

-- "The Trophy"
evt.CanShowTopic[483] = function()
	return evt.Cmp("QBits", 98)         -- Built Castle to Level 2 (rescued dwarf guy)
end

evt.global[483] = function()
	if evt.Cmp("QBits", 84) then         -- Gave artifact to humans
		evt.SetMessage(709)         -- "Looks like the trophy fell into the hands of Erathia.  I hear there was quite a fight over it! "
	elseif evt.Cmp("QBits", 85) then         -- Gave artifact to elves
		evt.SetMessage(710)         -- "Looks like the trophy fell into the hands of Avlee.  I hear there was quite a fight over it! "
	elseif evt.Cmp("QBits", 147) then         -- Gave artifact to arbiter
		evt.SetMessage(711)         -- "Looks like the trophy fell into the hands of the Arbiter.  I hear there was quite a fight over it! "
	else
		evt.SetMessage(684)         -- "There's an artifact that Avlee and Erathia have been fighting over for decades.  Both claim it was made by their people, and have lost the thing to raids against one another many times.  It isn't even magical--just a trophy.  Fifteen years ago, the trophy was lost during a raid, and no one knows where it went.  Recently, rumors have been flying, and the hunt's been on to figure out where it went.  If they find it--watch out!  Blood will be spilt. "
	end
end

-- "The Arbiter"
evt.CanShowTopic[484] = function()
	return evt.Cmp("QBits", 98)         -- Built Castle to Level 2 (rescued dwarf guy)
end

evt.global[484] = function()
	if evt.Cmp("QBits", 134) then         -- Arbiter Messenger only happens once
		evt.SetMessage(712)         -- "The death of Judge Grey was a blow to all of us.  I hope his replacement does his legacy justice."
	else
		evt.SetMessage(685)         -- "Because of all the tension in the air, Erathia and Avlee hired an arbiter to help them work out their differences.  He's staying in the ""House of Stars"" on the eastern edge of Harmondale territory.  Maybe he has some advice for you."
	end
end

-- "Lost and Found"
evt.global[485] = function()
	evt.SetMessage(686)         -- "If you ever feel like you need advice on what next to do, or you've lost something important, go visit the Arbiter in the House of Stars near the Eastern edge of Harmondale territory.  He often knows where lost items went, or has advice on what you need to do.  I'm sure you'll find him helpful."
end

-- "The Choice"
evt.CanShowTopic[486] = function()
	return evt.Cmp("QBits", 134)         -- Arbiter Messenger only happens once
end

evt.global[486] = function()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(687)         -- "The death of Judge Grey, Arbiter of Harmondale, has put the War on hold.  It's like the whole world is holding its breath, waiting for you to make a choice.  Better be careful who you choose--this sounds like a big one, my Lords."
			return
		end
	end
	evt.SetMessage(713)         -- "It looks like the consequences of your choice are just beginning, my lords.  I hope you chose wisely."
end

-- "Proving Grounds"
evt.global[487] = function()
	evt.SetMessage(688)         -- "The proving grounds, called the Walls of Mist,  is the place where all the wizards in Celeste have to go before they learn the High Art.  I hear it is much more of a moral test than a physical one.  You aren't allowed to kill any of the monsters in the maze."
end

-- "Celeste"
evt.global[488] = function()
	evt.SetMessage(689)         -- "The city of Celeste has been home to the Light for centuries.  It was established by King Magnus II  in 499 as the centerpiece to the Kingdom of Bracada, and as a beacon of hope to the rest of the world.  "
end

-- "The Pit"
evt.global[489] = function()
	evt.SetMessage(690)         -- "What you see on the surface in Deyja is only a small part of the true Kingdom of Death.  There is an underground city they call the Pit.  It can be reached from the surface only by way of the Hall of the Pit in Northern Deyja.  "
end

-- "Celeste"
evt.global[490] = function()
	evt.SetMessage(691)         -- "Celeste is the magical city built by the Wizards of Bracada centuries ago, and anchored half in the mountains, and half in mist high above Bracada.  You must use one of their teleporters to get there--you can find it near the center of Bracada."
end

-- "Mysterious Murders"
evt.CanShowTopic[491] = function()
	return evt.Cmp("QBits", 98)         -- Built Castle to Level 2 (rescued dwarf guy)
end

evt.global[491] = function()
	if evt.Cmp("QBits", 107) then         -- Slayed the vampire
		evt.SetMessage(714)         -- "So it was a vampire that was killing all those people!  I hear you're the ones to get rid of it, too!  Thanks!  Everyone feels much safer now."
	else
		evt.SetMessage(692)         -- "There was another murder, recently, that's been all the talk around town.  Another body--young woman, so I hear--was found near the sewers.  Drained of blood, for the love of Light!  It's those thieves living' in the sewers I tell you!  Rats, they are.  Someone should go down there and put them out of business!"
	end
end

-- "The Kreegan"
evt.global[492] = function()
	evt.SetMessage(693)         -- "During the War, the Warlocks had dealings with some strange creatures called the ""Kreegan"" in the mountains south of Avlee.  It's impossible to get there from the mainland, but the Warlocks dug a tunnel under the sea from their island that leads to the Kreegan's home."
end

-- "Losing the War"
evt.global[493] = function()
	evt.SetMessage(694)         -- "We…overplayed our hand during the War, and failed to win any territory on the mainland.  Our ""allies"", the Kreegan, turned out to be very untrustworthy.  People from Enroth call them devils--now we know why.  At just the moment when we needed them most, they turned and ran, leaving us to face the wrath of the armies of Erathia and Avlee.  Next time, we won't be so trusting."
end

-- "Falling out in Deyja"
evt.CanShowTopic[494] = function()
	return evt.Cmp("QBits", 198)         -- Archibald in Clankers Lab now
end

evt.global[494] = function()
	evt.SetMessage(695)         -- "There's been quite a bit of activity in Deyja, people are saying.  It seems that Archibald Ironfist, the leader of Deyja (and former King of Enroth) has left the Pit for an island off the Eastern shore of Avlee.  A lot of Necromancers followed him there--seems there's some sort of split going on."
end

-- "Roland of Enroth"
evt.CanShowTopic[495] = function()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return false
		end
	end
end

evt.global[495] = function()
	if evt.Cmp("QBits", 240) then         -- Talked to Roland
		evt.SetMessage(715)         -- "They say you are being credited with rescuing King Roland!  That's quite a feather in your cap, my lords!  QUITE a feather!"
	else
		evt.SetMessage(696)         -- "Rumors have been trickling out of Nighon that King Roland of Enroth may still be alive.  Some Warlocks have said that they personally saw him when they met with the foul Kreegan.  The rumors also say that the Kreegan are keeping him in a cage and mistreating him horribly."
	end
end

-- "Soul Jars"
evt.global[496] = function()
	evt.SetMessage(697)         -- "A Soul Jar is what a Necromancer needs to complete the Ritual and become a Lich--an immortal undead monster that retains its mind and memories from life.  It's pretty obvious that this is not a desirable condition for most people, which is why the market for these artifacts isn't very good.  Nonetheless, Necromancers will do almost anything to get more--their profession's very existence depends on them."
end

-- "Warlocks"
evt.global[497] = function()
	evt.SetMessage(700)         -- "Although the Warlocks are technically servants of the Dark, they usually aren't violent.  They will defend themselves if attacked, of course, but they won't start a fight unless you start it first.  They're quite reasonable, as a matter of fact, and they take their business seriously.  I've found dealing with them to be quite pleasant."
end

-- "Clanker's Defenses"
evt.CanShowTopic[498] = function()
	if not evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			return false
		end
	end
end

evt.global[498] = function()
	if evt.Cmp("QBits", 125) then         -- "Destroy the magical defenses inside Clanker's Laboratory and return to Dark Shade in the Pit."
		evt.SetMessage(699)         -- "So much for the mighty defenses.  Word is the Necromancers, led by Archibald Ironfist, teleported straight into Clanker's Laboratory and took over.  I'm told that treachery from within had something to do with it, though."
	else
		evt.SetMessage(701)         -- "The underground complex Clanker has created is surprisingly well defended.  The front door will keep out all magical attacks, and the island makes it difficult for any sort of large force to land on the island.  So far, Clanker has kept to himself, and no one has seriously tried his defenses, but his best protection comes from a series of teleport blockers inside the complex.  No magical invasion force can teleport past the front door until those blockers are brought down first."
	end
end

-- "Expert Teachers"
evt.global[499] = function()
	evt.SetMessage(716)         -- "Looking for Expert instruction in one of your Skills?  Expert teachers for most Skills can be found in Harmondale, Erathia and the Tularean Forest. "
end

-- "Missing People"
evt.global[500] = function()
	evt.SetMessage(698)         -- "People have been disappearing recently.  Not just one or two, but several every day!  They go to bed at night, and the next day they aren't seen and their houses are empty!  I certainly wish someone would find out what it happening!"
end

-- "Make Weapon"
evt.global[501] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
	else
		evt.SetMessage(718)         -- "You need ore for me to create weapons.  The better the ore, the better the weapon I can make."
	end
end

-- "Make Armor"
evt.global[502] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	else
		evt.SetMessage(720)         -- "You need ore for me to create armor.  The better the ore, the better the armor I can make."
	end
end

-- "Make Item"
evt.global[503] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	else
		evt.SetMessage(722)         -- "You need ore for me to create items.  The better the ore, the better the items I can make."
	end
end

-- "Signal "
evt.global[504] = function()
	evt.SetMessage(723)         -- "The signal rocket on the west side of the island should be set of to warn ships off from approaching to close to that side of the island.  The reefs off the west coast have proven deadly in the past."
end

-- "Dragon Flies"
evt.global[505] = function()
	evt.SetMessage(724)         -- "Beware the marshes of the southern tip of the island.  The dragon flies that pester our town spawn there!  "
end

-- "Fallen Trees"
evt.global[506] = function()
	evt.SetMessage(725)         -- "Fallen or dead trees can sometimes be the hiding place of some treasure or trinket.  However, it can also be home to insects or worse!"
end

-- "Bracada Teleporters"
evt.global[507] = function()
	evt.SetMessage(726)         -- "The teleporters of central Bracada can get you to numerous locations in the desert.  Just check the pillar in front of the teleporter for the location it will take you to.  Be careful however, some of the teleporters haven't been working correctly and will not show the destination!"
end

-- "Castle Upgrade"
evt.CanShowTopic[508] = function()
	if not evt.Cmp("QBits", 98) then         -- Built Castle to Level 2 (rescued dwarf guy)
		return false
	end
end

evt.global[508] = function()
	if evt.Cmp("Awards", 84) then         -- "Completed Necromancer Breeding Pit"
		evt.SetMessage(727)         -- "My Lords!  Lord Archibald sent engineers and artisans to upgrade Castle Harmondale!  Now we have an upstairs and downstairs!  Lord Archibald also left gifts in chests in these new areas.  The artisans are setting up shop in the entry hall and will have many wonderful items for sale!  Oh, yes, the workers discovered an older area to the castle--a torture chamber and dungeon!  We are very lucky!  I never thought Harmondale could afford such luxuries, my lords!"
	elseif evt.Cmp("Awards", 46) then         -- "Completed Wizard Proving Grounds"
		evt.SetMessage(728)         -- "My Lords!  Gavin Magnus sent engineers and artisans to upgrade Castle Harmondale!  Now we have an upstairs and downstairs!  Gavin Magnus also left gifts in chests in these new areas.  The artisans are setting up shop in the entry hall and will have many wonderful items for sale!  The workers, however, discovered an older area to the castle--a torture chamber and dungeon.  It isn't a pretty sight, I'm afraid."
	else
		evt.SetMessage(732)         -- "My Lords. Castle Harmondale stands ready."
	end
end

-- "Pedestals"
evt.global[509] = function()
	evt.SetMessage(733)         -- "Pedestals can be found through out the land that can lend you temporary protection from certain types of magic. "
end

-- "Disputed Land"
evt.global[510] = function()
	evt.SetMessage(729)         -- "My Lords ::bows:: Now that you have cleared Castle Harmondale of the goblins and vermin, you should concentrate on removing the goblins from the area surrounding Harmondale.  To the east of here is the center of the disputed region.  Many great battles have been waged there between the forces of King Eldrich of the Elves and Queen Catherine of Erathia.  The goblins have taken the ruined fort in this area an use it to attack any travelers attempting to reach Harmondale!"
end

-- "Castle Harmondale"
evt.global[511] = function()
	evt.SetMessage(730)         -- "My Lords, remember Castle Harmondale is YOURS.  Feel free to relax while you're here.  Your sleep will never be disturbed by attacking monsters, nor will anything you decide to store in the castle's chests ever be stolen or removed.  You are home."
end

-- "Beacon Fires"
evt.global[512] = function()
	evt.SetMessage(731)         -- "If you seek aid from Erathia, light the beacon fires near the roads to the Barrow Downs, Erathia, and the Tularean Forest.  The Erathian forces near here will see the fires and rush to your aid!"
end

-- "Pay 1000 Gold"
evt.global[513] = function()
	if evt.Cmp("Gold", 1000) then
		evt.SetMessage(738)         -- "This 1000 gold will go a long way to keeping zombies off the roads.  Thank you for your contribution."
		evt.Subtract("Gold", 1000)
		evt.Set("QBits", 249)         -- Don't get ambushed
	else
		evt.SetMessage(755)         -- "I can see your heart is in the right place, but your purse obviously isn't.  If you don't have the money, just say so.  In any event, good luck dealing with the zombies.  Ta-ta!"
	end
	evt.SetNPCTopic{NPC = 122, Index = 0, Event = 0}         -- "Lunius Shador"
	evt.SetNPCTopic{NPC = 122, Index = 1, Event = 0}         -- "Lunius Shador"
end

-- "Don't Pay"
evt.global[514] = function()
	evt.SetMessage(739)         -- "That's a shame.  What a coincidence, I think I see some zombies on the roads.  Perhaps next time you'll be more inclined to contribute."
	evt.SetNPCTopic{NPC = 122, Index = 0, Event = 0}         -- "Lunius Shador"
	evt.SetNPCTopic{NPC = 122, Index = 1, Event = 0}         -- "Lunius Shador"
end

-- "Buy Arrowheads for 200 Gold"
evt.CanShowTopic[515] = function()
	if not evt.Cmp("QBits", 252) then         -- Bought Item 3
		return not evt.Cmp("QBits", 256)         -- Can't keep buying 1
	end
	return true
end

evt.global[515] = function()
	evt.SetMessage(740)         -- "Excellent!  Here is a crate of Arrowheads.  Pip Hillier in Erathia pays the best prices for these. Be sure to see him!"
	evt.Subtract("QBits", 252)         -- Bought Item 3
	if evt.Cmp("Gold", 200) then
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 692)         -- "Crate of Arrowheads"
		evt.Set("QBits", 250)         -- Bought Item 1
		evt.Set("QBits", 256)         -- Can't keep buying 1
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Tularean Wood"
evt.global[516] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 694) then         -- "Crate of Tularean Wood"
		evt.SetMessage(741)         -- "Ahh, a shipment of Tularean Wood from my friend Robert Belknap.  I hope everything is well with him. Here's your payment."
		evt.Subtract("Inventory", 694)         -- "Crate of Tularean Wood"
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 294)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 241)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 251)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 237)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 273)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 255)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 286)
		end
	end
end

-- "Buy Griffin Feathers for 200 Gold"
evt.CanShowTopic[517] = function()
	if not evt.Cmp("QBits", 250) then         -- Bought Item 1
		return not evt.Cmp("QBits", 257)         -- Can't keep buying 2
	end
	return true
end

evt.global[517] = function()
	evt.SetMessage(742)         -- "Here's your crate of Griffin Feathers.  Robert Belknap in the Tularean Forest pays the best prices for these feathers.  Be sure to give him my regards when you see him."
	evt.Subtract("QBits", 250)         -- Bought Item 1
	if evt.Cmp("Gold", 200) then
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 693)         -- "Crate of Griffin Feathers"
		evt.Set("QBits", 251)         -- Bought Item 2
		evt.Set("QBits", 257)         -- Can't keep buying 2
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Arrowheads"
evt.global[518] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 692) then         -- "Crate of Arrowheads"
		evt.SetMessage(743)         -- "Rydric has sent me another shipment of Arrowheads.  Wonderful!  Here's your payment."
		evt.Subtract("Inventory", 692)         -- "Crate of Arrowheads"
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 261)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 286)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 237)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 255)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 294)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 273)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 244)
		end
	end
end

-- "Buy Tularean Wood for 200 Gold"
evt.CanShowTopic[519] = function()
	if not evt.Cmp("QBits", 251) then         -- Bought Item 2
		return not evt.Cmp("QBits", 258)         -- Can't keep buying 3
	end
	return true
end

evt.global[519] = function()
	evt.SetMessage(744)         -- "Here's your crate of Tularean Wood.  Be sure to take it to Rydric in Harmondale.  He will pay you well for them."
	evt.Subtract("QBits", 251)         -- Bought Item 2
	if evt.Cmp("Gold", 200) then
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 694)         -- "Crate of Tularean Wood"
		evt.Set("QBits", 252)         -- Bought Item 3
		evt.Set("QBits", 258)         -- Can't keep buying 3
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Griffin Feathers"
evt.global[520] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 693) then         -- "Crate of Griffin Feathers"
		evt.SetMessage(745)         -- "Pip Hillier sends another shipment of Griffin Feathers.  Here's your payment.  Enjoy the day!"
		evt.Subtract("Inventory", 693)         -- "Crate of Griffin Feathers"
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 234)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 267)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 250)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 291)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 244)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 285)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 273)
		end
	end
end

-- "Buy Sand for 2000 Gold"
evt.CanShowTopic[521] = function()
	if not evt.Cmp("QBits", 255) then         -- Bought Item 6
		return not evt.Cmp("QBits", 259)         -- Can't keep buying 4
	end
	return true
end

evt.global[521] = function()
	evt.SetMessage(746)         -- "Thanks!  Here's your crate of Sand. Arvin Beneclowd in the forsaken Barrow Downs pays well for this Sand, from it he creates fine bottles!"
	evt.Subtract("QBits", 255)         -- Bought Item 6
	if evt.Cmp("Gold", 2000) then
		evt.Subtract("Gold", 2000)
		evt.Add("Inventory", 695)         -- "Crate of Sand"
		evt.Set("QBits", 253)         -- Bought Item 4
		evt.Set("QBits", 259)         -- Can't keep buying 4
		evt.Set("Counter7", 0)
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Enrothian Wine"
evt.global[522] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 697) then         -- "Crate of Enrothian Wine"
		evt.SetMessage(747)         -- "Ahh, a shipment of Enrothian Wine from Infernon.  This will warm the hearts of many! Here's your payment."
		evt.Subtract("Inventory", 697)         -- "Crate of Enrothian Wine"
		evt.ForPlayer("Current")
		if not evt.Cmp("Counter9", 24) then
			evt.Add("Gold", 3000)
		elseif not evt.Cmp("Counter9", 120) then
			evt.Add("Gold", 2750)
		elseif evt.Cmp("Counter9", 240) then
			evt.Add("Gold", 2500)
		else
			evt.Add("Gold", 2250)
		end
	end
end

-- "Buy Glass Bottles for 2000 Gold"
evt.CanShowTopic[523] = function()
	if not evt.Cmp("QBits", 253) then         -- Bought Item 4
		return not evt.Cmp("QBits", 260)         -- Can't keep buying 5
	end
	return true
end

evt.global[523] = function()
	evt.SetMessage(748)         -- "Be sure to take this crate of Glass Bottles to Infernon in Avlee.  He bottles the finest Enrothian Wine."
	evt.Subtract("QBits", 253)         -- Bought Item 4
	if evt.Cmp("Gold", 2000) then
		evt.Subtract("Gold", 2000)
		evt.Add("Inventory", 696)         -- "Crate of Glass Bottles"
		evt.Set("QBits", 254)         -- Bought Item 5
		evt.Set("QBits", 260)         -- Can't keep buying 5
		evt.Set("Counter8", 0)
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Sand"
evt.global[524] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 695) then         -- "Crate of Sand"
		evt.SetMessage(749)         -- "Ahh, a shipment of Sand from Calindra Goldensight.  Here's your payment."
		evt.Subtract("Inventory", 695)         -- "Crate of Sand"
		evt.ForPlayer("Current")
		if not evt.Cmp("Counter7", 24) then
			evt.Add("Gold", 3000)
		elseif not evt.Cmp("Counter7", 120) then
			evt.Add("Gold", 2750)
		elseif evt.Cmp("Counter7", 240) then
			evt.Add("Gold", 2500)
		else
			evt.Add("Gold", 2250)
		end
	end
end

-- "Buy Enrothian Wine for 2000 Gold"
evt.CanShowTopic[525] = function()
	if not evt.Cmp("QBits", 254) then         -- Bought Item 5
		return not evt.Cmp("QBits", 261)         -- Can't keep buying 6
	end
	return true
end

evt.global[525] = function()
	evt.SetMessage(750)         -- "Here's your crate of Enrothian Wine.  Take this to Calindra Goldensight in Tatalia and she will pay you well! "
	evt.Subtract("QBits", 254)         -- Bought Item 5
	if evt.Cmp("Gold", 2000) then
		evt.Subtract("Gold", 2000)
		evt.Add("Inventory", 697)         -- "Crate of Enrothian Wine"
		evt.Set("QBits", 255)         -- Bought Item 6
		evt.Set("QBits", 261)         -- Can't keep buying 6
		evt.Set("Counter9", 0)
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Glass Bottles"
evt.global[526] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 696) then         -- "Crate of Glass Bottles"
		evt.SetMessage(751)         -- "Arvin Beneclowd sends me another shipment of Glass Bottles.  Time to bottle some more Enrothian Wine.  Here's your payment."
		evt.Subtract("Inventory", 696)         -- "Crate of Glass Bottles"
		evt.ForPlayer("Current")
		if not evt.Cmp("Counter8", 24) then
			evt.Add("Gold", 3000)
		elseif not evt.Cmp("Counter8", 120) then
			evt.Add("Gold", 2750)
		elseif evt.Cmp("Counter8", 240) then
			evt.Add("Gold", 2500)
		else
			evt.Add("Gold", 2250)
		end
	end
end

-- "Boat Schedule"
evt.global[527] = function()
	evt.SetMessage(752)         -- "You can charter a boat from this port to Erathia on Tuesdays, Thursdays and Saturdays. Boats for the Bracada Desert leave on Mondays and Wednesdays. Boats leave for Avlee on Friday only. If you have completed the Priest quest you can charter a boat to Evenmorn Island on Sundays."
end

-- "Nighon Tunnel"
evt.global[528] = function()
	evt.SetMessage(753)         -- "If you are looking to make it quickly to Nighon through the tunnels below, you should take the left fork of the Nighon Tunnel.  Many have taken the right fork and have never been heard from again.  Then again they may have made it to Nighon only to be taken by the Warlocks!"
end

-- "Trading"
evt.global[529] = function()
	evt.SetMessage(754)         -- "Many traders all over Erathia hire out to travelers to deliver their goods!  If you are ever in need of some extra coin, try finding one of these merchants and make a delivery for them!"
end

-- "Haste Pedestal"
evt.global[530] = function()
	evt.CastSpell{Spell = 5, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Haste"
end

-- "Earth Resistance Pedestal"
evt.global[531] = function()
	evt.CastSpell{Spell = 36, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Earth Resistance"
end

-- "Day of the Gods Pedestal"
evt.global[532] = function()
	evt.CastSpell{Spell = 83, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Day of the Gods"
end

-- "Shield Pedestal"
evt.global[533] = function()
	evt.CastSpell{Spell = 17, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Shield"
end

-- "Water Resistance Pedestal"
evt.global[534] = function()
	evt.CastSpell{Spell = 25, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Water Resistance"
end

-- "Fire Resistance Pedestal"
evt.global[535] = function()
	evt.CastSpell{Spell = 3, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Resistance"
end

-- "Heroism Pedestal"
evt.global[536] = function()
	evt.CastSpell{Spell = 51, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Heroism"
end

-- "Immolation Pedestal"
evt.global[537] = function()
	evt.CastSpell{Spell = 8, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Immolation"
end

-- "Mind Resistance Pedestal"
evt.global[538] = function()
	evt.CastSpell{Spell = 58, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Mind Resistance"
end

-- "Body Resistance Pedestal"
evt.global[539] = function()
	evt.CastSpell{Spell = 69, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Body Resistance"
end

-- "Stone Skin Pedestal"
evt.global[540] = function()
	evt.CastSpell{Spell = 38, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Stone Skin"
end

-- "Air Resistance Pedestal"
evt.global[541] = function()
	evt.CastSpell{Spell = 14, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Air Resistance"
end

-- "Game of Might"
evt.global[542] = function()
	if evt.Cmp("PlayerBits", 31) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 31)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Endurance"
evt.global[543] = function()
	if evt.Cmp("PlayerBits", 32) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 32)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Intellect"
evt.global[544] = function()
	if evt.Cmp("PlayerBits", 33) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 33)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Personality"
evt.global[545] = function()
	if evt.Cmp("PlayerBits", 34) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 34)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Accuracy"
evt.global[546] = function()
	if evt.Cmp("PlayerBits", 35) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 35)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Speed"
evt.global[547] = function()
	if evt.Cmp("PlayerBits", 36) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 36)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Game of Luck"
evt.global[548] = function()
	if evt.Cmp("PlayerBits", 37) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(761)         -- "You win!  +3 Skill Points"
		evt.Set("PlayerBits", 37)
	else
		evt.StatusText(756)         -- "You have failed the game!"
	end
end

-- "Contest of Might"
evt.global[549] = function()
	if evt.Cmp("PlayerBits", 38) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 38)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Endurance"
evt.global[550] = function()
	if evt.Cmp("PlayerBits", 39) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 39)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Intellect"
evt.global[551] = function()
	if evt.Cmp("PlayerBits", 40) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 40)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Personality"
evt.global[552] = function()
	if evt.Cmp("PlayerBits", 41) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 41)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Accuracy"
evt.global[553] = function()
	if evt.Cmp("PlayerBits", 42) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 42)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Speed"
evt.global[554] = function()
	if evt.Cmp("PlayerBits", 43) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 43)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Contest of Luck"
evt.global[555] = function()
	if evt.Cmp("PlayerBits", 44) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(762)         -- "You win!  +5 Skill Points"
		evt.Set("PlayerBits", 44)
	else
		evt.StatusText(757)         -- "You have failed the contest!"
	end
end

-- "Test of Might"
evt.global[556] = function()
	if evt.Cmp("PlayerBits", 45) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 45)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Endurance"
evt.global[557] = function()
	if evt.Cmp("PlayerBits", 46) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 46)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Intellect"
evt.global[558] = function()
	if evt.Cmp("PlayerBits", 47) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 47)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Personality"
evt.global[559] = function()
	if evt.Cmp("PlayerBits", 48) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 48)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Accuracy"
evt.global[560] = function()
	if evt.Cmp("PlayerBits", 49) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 49)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Speed"
evt.global[561] = function()
	if evt.Cmp("PlayerBits", 50) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 50)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Test of Luck"
evt.global[562] = function()
	if evt.Cmp("PlayerBits", 51) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(763)         -- "You win!  +7 Skill Points"
		evt.Set("PlayerBits", 51)
	else
		evt.StatusText(758)         -- "You have failed the test!"
	end
end

-- "Challenge of Might"
evt.global[563] = function()
	if evt.Cmp("PlayerBits", 52) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 52)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Endurance"
evt.global[564] = function()
	if evt.Cmp("PlayerBits", 53) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 53)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Intellect"
evt.global[565] = function()
	if evt.Cmp("PlayerBits", 54) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 54)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Personality"
evt.global[566] = function()
	if evt.Cmp("PlayerBits", 55) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 55)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Accuracy"
evt.global[567] = function()
	if evt.Cmp("PlayerBits", 56) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 56)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Speed"
evt.global[568] = function()
	if evt.Cmp("PlayerBits", 57) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 57)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Luck"
evt.global[569] = function()
	if evt.Cmp("PlayerBits", 58) then
		evt.StatusText(760)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(764)         -- "You win!  +10 Skill Points"
		evt.Set("PlayerBits", 58)
	else
		evt.StatusText(759)         -- "You have failed the challenge!"
	end
end

-- "Traitor!"
evt.CanShowTopic[570] = function()
	return evt.Cmp("Inventory", 716)         -- "Letter to Hairbaugh"
end

evt.global[570] = function()
	evt.SetMessage(765)         -- "What!  You wouldn't believe this fabrication would you?  I would never dream of sabotaging your rule here!  Gaahh!  Prepare to die!"
	evt.SetMonGroupBit{NPCGroup = 33, Bit = const.MonsterBits.Invisible, On = true}         -- ""
	evt.SetMonGroupBit{NPCGroup = 34, Bit = const.MonsterBits.Invisible, On = false}         -- ""
end

-- "Shrine"
evt.global[571] = function()
	evt.SetMessage(766)         -- "I have heard rumors that the shrine to the southeast of here can send you to the Land of the Giants.  I have been to the shrine many times and it has never done anything special for me.  Or is that you can get here, FROM the Land of the Giants? I wonder..."
end

-- "Challenges"
evt.global[572] = function()
	evt.SetMessage(767)         -- "Scattered around the land are the Challenges.  If your ability is great enough, and you best the challenge, you will be award skill points to do with as you wish!"
end

