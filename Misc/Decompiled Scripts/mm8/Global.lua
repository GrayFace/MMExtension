Game.GlobalEvtLines.Count = 0  -- Deactivate all standard events


-- "Cataclysm"
evt.global[1] = function()
	evt.SetMessage(1)         -- "My fellow Journeyman, we face grave times.  Hopefully our Master will find a way for us to leave this troubled region and return safely to Alvar.  I would not wish to end my life here, even though it is the place of my birth."
	evt.Add("QBits", 232)         -- Set when you talk to S'ton
end

-- "Caravan Master"
evt.global[2] = function()
	evt.SetMessage(2)         -- "Dadeross led us here to trade with the Lizardman Clan of Onefang for their tobersk fruit.  He has gone to talk with Brekish Onefang, the village leader.  Perhaps you should look for him?"
	evt.Add("QBits", 232)         -- Set when you talk to S'ton
end

-- "Pirates of Regna"
evt.global[3] = function()
	evt.SetMessage(3)         -- "The Regnan Pirates are a threat to the economy and free travel in Jadame.  Very few boats ply the sea, for fear of being sunk…or worse!  When in Ravenshore, I did hear rumors of a small band of smugglers who have been working beneath the notice of the pirates.  I wonder how they do that!"
	evt.Add("QBits", 232)         -- Set when you talk to S'ton
end

-- "Cataclysm"
evt.global[4] = function()
	evt.SetMessage(4)         --[[ "It is as I have read in the prophecy of the Unmaking! ""...and a Mountain of Fire shall rise from the sea, like a wound drawn by the quick stroke of a dagger…"".

You must find a way off of these islands, if not for the caravan, at least for yourself!  Someone must take news of what has happened here to the Merchant Council in Alvar!  They must know of the cataclysm and of the Regnan raid!" ]]
	evt.SetNPCTopic{NPC = 2, Index = 0, Event = 20}         -- "Dadeross" : "Quest"
end

-- "Pirates"
evt.global[5] = function()
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		evt.SetMessage(616)         -- "Good work dealing with those pirates. Now that they're gone, maybe Chief Onefang and his people can rebuild their lives. It really is a travesty what has happened here."
	else
		evt.SetMessage(5)         -- "The pirates from the dread Island of Regna are using the cataclysm and the confusion created by it to aid them in overrunning the islands.  If they conquer Dagger Wound, they can use it as an outpost for direct raids on Ravenshore!  The Merchant Council in Alvar must be notified!  You must find a way to the boats and tell them!"
	end
end

-- "Caravan"
evt.global[6] = function()
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		evt.SetMessage(617)         -- "Sadly, the caravan was one of the first things the pirates looted in their raids. I have no idea what they're going to do with three-hundred cases of tobersk fruit! Naturally, I miss the fruit, but the worst of it is the damage they did to the carts. It looks like I'll be here for at least the next season overseeing their repair. I just hope the task is done before the next tobersk harvest so I can see some return out of this profitless venture."
	else
		evt.SetMessage(6)         -- "It will take several boats to ferry the entire caravan back to Ravenshore, or many trips by one boat.  This cannot be done until the waters around the Dagger Wound Islands are free from Regnan Pirates.  It is best that you return to Alvar and tell the Council of the Regnan attack.  They will send help to rescue us!"
	end
end

-- "Cataclysm"
evt.global[7] = function()
	if evt.Cmp("QBits", 6) then         -- Pirate Leader in Dagger Wound Pirate Outpost killed (quest given at Q Bit 5). Ends pirate/lizardman war on Dagger Wound. Shuts off pirate timer.
		evt.SetMessage(615)         -- "What with the damage caused by giant waves, falling rocks and the pirate raid, I don't know if our village will ever be the same. I know you have done great things for us, but not everything can be fixed once broken. I'm not sure what we'll do. Perhaps we will rebuild, or maybe we'll leave. Time and circumstance will decide."
	else
		evt.SetMessage(7)         -- "In the middle of the night the ground shook!  Flaming rocks dropped from the sky!  Many of my people were hurt or killed!  Great damage was done to the village.  The bridges that allowed travel between the smaller islands and the main island were destroyed.  We found ourselves stuck on the main island, unable to reach those on the smaller islands who may be injured.  Many family members and friends are missing.  We cannot reach the islands with the boat docks, and thus we are unable to send to Ravenshore for help. I do not even know if any boats survived!"
	end
end

-- "Portals of Stone"
evt.global[8] = function()
	evt.SetMessage(8)         -- "In time long past, my people used the Portals of Stone to travel quickly from island to island, but we have lost the knowledge of their operation. Only the pair connecting the village to the southwestern fields still functions. Now that the bridges are gone, we're trapped on the island!"
	evt.SetNPCTopic{NPC = 1, Index = 1, Event = 21}         -- "Brekish Onefang" : "Quest"
end

-- "Fredrick Talimere"
evt.global[9] = function()
	evt.SetMessage(9)         -- "A Cleric, by the name of Fredrick Talimere, has been living with us for the last few years.  He has been studying the Portals of Stone and the outer ruins of the Abandoned Temple.  Maybe he has the knowledge to get the Portals working again!  Find him and see if he will help!"
end

-- "Portals of Stone"
evt.global[10] = function()
	evt.SetMessage(10)         --[[ "Ah yes…""the portals."" I have been studying them and the lost culture that built them for years.

They were built by the civilization that had its day long before the Lizardmen came to inhabit these islands. They were a means of instantaneous travel between the islands. Sadly, the power stones needed to operate them are in short supply." ]]
end

-- "Cataclysm"
evt.global[11] = function()
	evt.SetMessage(11)         -- "The first night of the mountain of fire, I went to the beach to see if I could see anything of its eruption.  I cannot be certain, but as the volcano continued to erupt, I thought I saw Earth Elementals roaming the lava encrusted base of the mountain."
end

-- "Power Stone"
evt.CanShowTopic[12] = function()
	return evt.Cmp("Inventory", 617)         -- "Power Stone"
end

evt.global[12] = function()
	evt.SetMessage(12)         -- "So Clanleader Onefang gave you that power stone he was holding onto! It will power the portal on the southwestern tip of the island. To use it, hold an image of the stone in your mind as you step onto the portal."
	evt.ForPlayer("All")
	evt.Add("Awards", 2)         -- "Brought Power Stone to Fredrick Talimere."
	evt.Add("Experience", 1500)
	evt.Subtract("QBits", 7)         -- "Bring Brekish Onefang's portal crystal to Fredrick Talimere."
	evt.Add("QBits", 8)         -- Fredrick Talimere visited by player with crystal in their possesion.
	evt.SetNPCTopic{NPC = 32, Index = 2, Event = 602}         -- "Fredrick Talimere" : "Roster Join Event"
	evt.SetNPCTopic{NPC = 1, Index = 2, Event = 0}         -- "Brekish Onefang"
end

-- "Abandoned Temple"
evt.global[13] = function()
	evt.SetMessage(13)         --[[ "The ruins of a temple built by the lost civilization lies on the island just northwest of the main island. I have not explored it however, for dangerous reptiles have made it their lair. I do suspect that the temple leads to an underwater tunnel which surfaces near the boat docks on the northwest island.

With the bridges out, that tunnel may be the only way to reach the docks and a boat to safety!" ]]
end

-- "Quest"
evt.global[14] = function()
	if evt.Cmp("QBits", 138) then         -- Found Isthric the Tongue
		evt.SetMessage(749)         -- "You found Isthric and told him how to return home?  We are indeed in debt to you, Merchant of Alvar!  I will speak well of you to Clan Leader Brekish Onefang.  Please take these potions of Cure Wounds as a reward."
		evt.ForPlayer("All")
		evt.Add("Experience", 750)
		evt.ForPlayer(0)
		evt.Add("Inventory", 222)         -- "Cure Wounds"
		evt.Add("Inventory", 222)         -- "Cure Wounds"
		evt.Subtract("QBits", 137)         -- "Find Isthric the Tongue, brother of Rohtnax.  Return to Rohtnax in the village of Blood Drop on Dagger Wound Island."
		evt.ForPlayer("All")
		evt.Add("Awards", 54)         -- "Rescued Isthric the Tongue, brother of Rohtnax, on the Dagger Wound Islands."
		evt.SetNPCTopic{NPC = 33, Index = 0, Event = 0}         -- "Rohtnax"
	else
		evt.SetMessage(14)         -- "My brother, Isthric the Tongue, went to check on the tobersk plants on one of the lesser islands.  He has not returned!  I am afraid that he is one of those stranded by the cataclysm. He may even be hurt!  If you were to fix the Portals of Stone, he would surely be able to return, and we could get help to those who need it!  Find him for me!"
		evt.Add("QBits", 137)         -- "Find Isthric the Tongue, brother of Rohtnax.  Return to Rohtnax in the village of Blood Drop on Dagger Wound Island."
	end
end

-- "Portals of Stone"
evt.global[15] = function()
	if evt.Cmp("QBits", 1) then         -- Activate Area 1 teleporters 3 and 4.
		evt.SetMessage(748)         -- "You have repaired the Portals of Stone?  That is tremendous news!  Quickly, find my brother, Isthric and tell him to return home!"
	else
		evt.SetMessage(15)         -- "My Granda used to tell us of the times past, when the Portals of Stone were the main travel route between the islands.  She told us that the keys to the Portals disappeared during one of the first raids committed by the Regnan Pirates.  If the Portals of Stone were working my brother Isthric could return back to the main island!"
	end
end

-- "Fredrick Talimere"
evt.global[16] = function()
	evt.SetMessage(16)         -- "That rude man?  He's more concerned with that Abandoned Temple than he is with the life that goes on around him!  My Granda warned him that the Temple is a place of great Evil.  He never listened.  Now Granda isn't with us anymore and we have no one but Brekish Onefang to remind us of the past."
end

-- "Mountain of Fire"
evt.global[17] = function()
	evt.SetMessage(17)         -- "We have offended the Ancients!  Why else would they call up the Mountain of Fire!  The Prophecies tell of a time when the oceans would boil!  This is the beginning of the end!"
end

-- "Prophecies"
evt.global[18] = function()
	evt.SetMessage(18)         -- "There are many Prophecies that tell of the destruction of Jadame and the entire world!   Most tell of a time when the world will be consumed by that which created it.  Perhaps the Ancients have decided to wipe us all out!"
end

-- "Quest"
evt.global[19] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 652) then         -- "Prophecies of the Snake"
		evt.SetMessage(750)         -- "You have found the Prophecies of the Snake!  Perhaps the details of our future can be found in its writings!  Please take this reward for your assistance!"
		evt.Subtract("Inventory", 652)         -- "Prophecies of the Snake"
		evt.Subtract("QBits", 135)         -- "Find the Prophecies of the Snake for Pascella Tisk."
		evt.ForPlayer(0)
		evt.Add("Gold", 500)
		evt.ForPlayer("All")
		evt.Add("Experience", 750)
		evt.SetNPCTopic{NPC = 34, Index = 1, Event = 0}         -- "Pascella Tisk"
	else
		evt.SetMessage(19)         --[[ "There is one Prophecy, the Prophecy of the Snake, that I have been unable to find a copy of.  I think it may be most revealing about the future of Jadame.

Fredrick Talimere, the Cleric, has told me of the snake ruins, and of the Abandoned Temple.  He is in agreement with me, that there may be a copy of this prophecy, somewhere in the temple.  Could you find it for me?" ]]
		evt.Add("QBits", 135)         -- "Find the Prophecies of the Snake for Pascella Tisk."
	end
end

-- "Quest"
evt.CanShowTopic[20] = function()
	return not evt.Cmp("QBits", 4)         -- Letter from Q Bit 3 delivered.
end

evt.global[20] = function()
	if evt.Cmp("QBits", 3) then         -- "Deliver Dadeross' Letter to Elgar Fellmoon at the Merchant House in Ravenshore."
		evt.SetMessage(21)         -- "You must bring my letter to Elgar Fellmoon in Ravenshore!"
	else
		evt.SetMessage(20)         --[[ "You must find a way off of these islands. Someone must take news of what has happened here to our masters, the Merchants of Alvar!  They must know of the cataclysm and of the Regnan raid! 

I've written a letter to the Merchants of Alvar representative in Ravenshore, Elgar Fellmoon. In it I explain our situation here. If anyone can advise us on what to do here, it is Fellmoon. Take this to him now." ]]
		evt.SetNPCGreeting{NPC = 2, Greeting = 8}         -- "Dadeross" : "What are you doing here? Get my letter to Fellmoon!"
		evt.Add("Inventory", 741)         -- "Dadeross' Letter to Fellmoon"
		evt.Add("QBits", 221)         -- Dadeross' Letter to Fellmoon - I lost it, taken event g 28
		evt.Add("QBits", 3)         -- "Deliver Dadeross' Letter to Elgar Fellmoon at the Merchant House in Ravenshore."
		evt.Subtract("QBits", 85)         -- "Find Dadeross, the Minotaur in charge of your merchant caravan. When you saw him last, he was going to talk to the village clan leader."
	end
end

-- "Quest"
evt.CanShowTopic[21] = function()
	return not evt.Cmp("QBits", 8)         -- Fredrick Talimere visited by player with crystal in their possesion.
end

evt.global[21] = function()
	if evt.Cmp("QBits", 7) then         -- "Bring Brekish Onefang's portal crystal to Fredrick Talimere."
		evt.SetMessage(23)         -- "Bring the portal crystal to Fredrick Talimere. He will know what it does."
	else
		evt.SetMessage(22)         -- "Take this crystal to Fredrick Talimere. I know that it has something to do with the portals of stone. Perhaps he can tell you how it functions."
		evt.Add("Inventory", 617)         -- "Power Stone"
		evt.Add("QBits", 212)         -- Power Stone - I lost it
		evt.Add("QBits", 7)         -- "Bring Brekish Onefang's portal crystal to Fredrick Talimere."
		evt.SetNPCTopic{NPC = 32, Index = 2, Event = 12}         -- "Fredrick Talimere" : "Power Stone"
		evt.SetNPCTopic{NPC = 32, Index = 3, Event = 13}         -- "Fredrick Talimere" : "Abandoned Temple"
	end
end

-- "Promotion to Dark Elf Patriarch"
evt.global[22] = function()
	evt.SetMessage(24)         --[[ "The Merchant Council had sent our greatest warrior, Cauri Blackthorne, to consult with the Sun Temple priests about the disasters that have struck all of Jadame.

Cauri left for the Temple of the Sun in Murmurwoods shortly after rumors of the cataclysms were heard here in Alvar.  She was to return after consulting the priests.  We are very concerned that she has not returned.

As for your promotion, only Cauri can accurately test your skills and assess your worthiness for promotion.  If you find her, provide her with any assistance she may need and return here with news of her status and location." ]]
	evt.Add("QBits", 39)         -- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
	evt.SetNPCTopic{NPC = 52, Index = 0, Event = 31}         -- "Relburn Jeebes" : "Where is Cauri?"
end

-- "Cauri Blackthorne"
evt.global[23] = function()
	if not evt.Cmp("Awards", 19) then         -- "Promoted to Elf Patriarch."
		if not evt.Cmp("Awards", 20) then         -- "Rescued Cauri Blackthorne."
			evt.SetMessage(39)         -- "This is the home of Cauri Blackthorne, greatest Dark Elf warrior.  She is currently out, working for the Merchant Council of Alvar.  Perhaps you should consult them as to her whereabouts."
			return
		end
	end
	evt.SetMessage(30)         -- "Cauri returned and informed us of this assistance you provided her.  She also notified us of your promotion.  Congratulations, may your profits bring you much joy!"
	evt.ForPlayer(0)
	evt.Add("Gold", 15000)
	evt.SetNPCTopic{NPC = 52, Index = 1, Event = 0}         -- "Relburn Jeebes"
end

-- "Thank you!"
evt.global[24] = function()
	evt.SetMessage(26)         --[[ "Thank you for your assistance with the Basilisk Curse.  Usually I am prepared to handle the vile lizards, but this time there were just too many of them.

The Temple of the Sun asked me to check on a few pilgrims that were looking for the Druid Circle of Stone in this area.  When I found the first statue, I realized what had happened to the pilgrims.  

I myself did not know of the increase in the number of Basilisks in this area.  They seem to be agitated by something.  I was going to investigate the Druid Circle of Stone when the Basilisks attacked me." ]]
end

-- "Patriarch"
evt.global[25] = function()
	evt.SetMessage(27)         --[[ "::Cauri looks over the Dark Elf(s) in your party::

To rescue me, you must have researched my path, and investigated the places I had been.  This demonstrates the intelligence needed to succeed in dealing with the world and business.

To get to where I was attacked, you must have the skills needed to fight the Basilisks and other threats, demonstrating your prowess as a warrior.  Skill in battle is needed when proper negotiations break down.

To ask me for promotion demonstrates desire, and without desire success will always escape your grasp.

You have all of the traits necessary to hold the title of Patriarch.  I will notify to Council upon my return.  It would be my pleasure to travel with you again.  You can find me in the Inn in Ravenshore." ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.Subtract("QBits", 39)         -- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
	evt.Add("QBits", 40)         -- Found and Rescued Cauri Blackthorne
	evt.Add("QBits", 430)         -- Roster Character In Party 31
	evt.SetNPCTopic{NPC = 55, Index = 1, Event = 38}         -- "Cauri Blackthorne" : "Thanks for your help!"
end

-- "Circle of Stone"
evt.global[26] = function()
	evt.SetMessage(28)         --[[ "I need to investigate the Circle of Stone further for the Temple of the Sun.  Hopefully not all of the pilgrims met the fate of these. Hopefully there are survivors!

Something has agitated the creatures in this area, and I think the source can be found in the Circle." ]]
end

-- "Cauri Blackthorne"
evt.global[27] = function()
	if evt.Cmp("QBits", 39) then         -- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
		goto _2
	end
	if not evt.Cmp("QBits", 40) then         -- Found and Rescued Cauri Blackthorne
		goto _2
	end
	evt.Subtract("QBits", 39)         -- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
::_15::
	evt.SetNPCTopic{NPC = 54, Index = 0, Event = 26}         -- "Dantillion " : "Circle of Stone"
	do return end
::_2::
	evt.SetMessage(31)         -- "Cauri Blackthorne was here well over a week ago, maybe longer.  She had asked us many questions about the elemental incursions.  We provided her with what information we had here.  She said she would return to Alvar with the information.  Before she left, we asked her if she could do a favor for us.  We asked her if she could check on a group of pilgrims that were traveling to the old Druid Circle of Stone to the northeast of here.  She assured us that she would check in on them on her way back to Alvar."
	evt.ForPlayer(0)
	evt.Add("Inventory", 339)         -- "Stone to Flesh"
	evt.ForPlayer(1)
	evt.Add("Inventory", 339)         -- "Stone to Flesh"
	evt.ForPlayer(2)
	evt.Add("Inventory", 339)         -- "Stone to Flesh"
	evt.ForPlayer(3)
	evt.Add("Inventory", 339)         -- "Stone to Flesh"
	evt.ForPlayer(4)
	evt.Add("Inventory", 339)         -- "Stone to Flesh"
	goto _15
end

-- "Letter"
evt.global[28] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 741) then         -- "Dadeross' Letter to Fellmoon"
		evt.SetMessage(33)         --[[ "What is this? A letter from caravan master, Dadeross? Let's see…hmmm…

Well, it seems that serious events are afoot. It is a pity--what has happened on Dagger Wound. Serious action may need to be taken, but I require more information…

…and I think I know how to get it! Perhaps you would be interested in helping me? I will compensate you, of course. And, here. Take this as payment for delivering Dadeross' letter." ]]
		evt.SetNPCTopic{NPC = 3, Index = 0, Event = 29}         -- "Elgar Fellmoon" : "Quest"
		evt.SetNPCGreeting{NPC = 2, Greeting = 58}         -- "Dadeross" : "Hail, adventurer!"
		evt.ForPlayer("All")
		evt.Subtract("QBits", 3)         -- "Deliver Dadeross' Letter to Elgar Fellmoon at the Merchant House in Ravenshore."
		evt.Add("QBits", 4)         -- Letter from Q Bit 3 delivered.
		evt.Subtract("Inventory", 741)         -- "Dadeross' Letter to Fellmoon"
		evt.Subtract("QBits", 221)         -- Dadeross' Letter to Fellmoon - I lost it, taken event g 28
		evt.ForPlayer(0)
		evt.Add("Gold", 2500)
		evt.ForPlayer("All")
		evt.Add("Experience", 7500)
		evt.Add("Awards", 4)         -- "Delivered Dadeross' Letter to Elgar Fellmoon."
	else
		evt.SetMessage(32)         -- "You come to me claiming to have a message from one of my caravan masters. Well, where is it then? If it was so important, perhaps you should have been better about not losing it along the way!"
	end
end

-- "Quest"
evt.global[29] = function()
	if evt.Cmp("QBits", 12) then         -- Quest 11 is done.
		evt.SetMessage(38)         -- "You must reach Bastian Loudrin in Alvar. Go! He must be informed of recent events!"
	elseif evt.Cmp("QBits", 24) then         -- Received Reward from Elgar Fellmoon for completing quest 9.
		evt.SetMessage(37)         --[[ "As you may be aware, our guild headquarters is located in the city of Alvar. If you've never been there, the easiest way to reach it is to follow the river up through the canyon to the north.

Go to the guild house and find Bastian Loudrin. Tell him about the crystal, and the rumors. Lourdrin will know what to do." ]]
		evt.Add("QBits", 11)         -- "Report to Bastian Loudrin, the merchant guildmaster in Alvar."
	elseif evt.Cmp("QBits", 10) then         -- Letter from Q Bit 9 delivered.
		evt.SetMessage(36)         --[[ "Very good, and here is the payment we agreed upon. Hunter's boats will be useful to us through the crisis.

Yes, ""crisis,"" I say! Since your initial visit, several other caravans have missed their scheduled stops. There are also the rumors. Twice I've heard of the appearance of a burning lake of fire rising out of the desert.

Volcanoes! Lakes of fire! I fear the mysterious crystal has something to do with it. In any event, the guildmasters in Alvar must be informed!" ]]
		evt.ForPlayer("All")
		evt.Add("Awards", 3)         -- "Blackmailed the Wererat Smugglers."
		evt.Add("Experience", 12000)
		evt.Add("QBits", 24)         -- Received Reward from Elgar Fellmoon for completing quest 9.
		evt.Subtract("QBits", 284)         -- "Return to Fellmoon in Ravenshore and report your success in blackmailing the wererat smuggler, Arion Hunter."
	elseif evt.Cmp("QBits", 9) then         -- "Deliver Fellmoon's blackmail letter to Arion Hunter, leader of the wererat smugglers. Report back to Fellmoon."
		evt.SetMessage(35)         -- "Listen. We need those boats! Deliver my letter to Arion Hunter. Did you forget? His lair is to the west, up the coast!"
	else
		evt.SetMessage(34)         --[[ "The local smugglers have the fastest boats in Ravenshore. If these were available to my agents, they could make quick scouting missions up and down the coast so we could see the extent of the cataclysm mentioned in Dadeross' letter.

Here. Bring this letter to the smuggler leader, Arion Hunter. I'm sure it will ""persuade"" him to lend his services. You'll find his hideout westward up the coast.

Oh, I almost forgot. The smugglers--they're wererats--and you know how they can be. Hunter can be reasoned with, but don't be surprised if his crew is less than civil." ]]
		evt.Add("QBits", 9)         -- "Deliver Fellmoon's blackmail letter to Arion Hunter, leader of the wererat smugglers. Report back to Fellmoon."
		evt.Add("Inventory", 742)         -- "Blackmail Letter"
		evt.Add("QBits", 222)         -- Blackmail Letter - I lost it, taken event g 32
		evt.SetNPCGreeting{NPC = 3, Greeting = 11}         -- "Elgar Fellmoon" : "Have you done as I've asked of you?"
	end
end

-- "Blackthorne Residence"
evt.global[30] = function()
	if evt.Cmp("QBits", 40) then         -- Found and Rescued Cauri Blackthorne
		evt.SetMessage(30)         -- "Cauri returned and informed us of this assistance you provided her.  She also notified us of your promotion.  Congratulations, may your profits bring you much joy!"
	else
		evt.SetMessage(39)         -- "This is the home of Cauri Blackthorne, greatest Dark Elf warrior.  She is currently out, working for the Merchant Council of Alvar.  Perhaps you should consult them as to her whereabouts."
	end
end

-- "Where is Cauri?"
evt.CanShowTopic[31] = function()
	return not evt.Cmp("QBits", 40)         -- Found and Rescued Cauri Blackthorne
end

evt.global[31] = function()
	evt.SetMessage(25)         -- "Have you found Cauri?  We really need to know what happened to her!  Without her, we are all diminished!"
end

-- "Blackmail"
evt.CanShowTopic[32] = function()
	return evt.Cmp("Inventory", 742)         -- "Blackmail Letter"
end

evt.global[32] = function()
	evt.SetMessage(40)         --[[ "You did all that to my guards just to deliver a letter! Let me see that…

…hmmm…Fellmoon wants my boats? Never! I…what!…he threatens my Irabelle…I…I…sigh…

V-very well. You can tell Fellmoon he can have my boats. I guess there's no refusing the Merchants of Alvar what they want." ]]
	evt.ForPlayer("All")
	evt.Add("QBits", 10)         -- Letter from Q Bit 9 delivered.
	evt.Subtract("QBits", 9)         -- "Deliver Fellmoon's blackmail letter to Arion Hunter, leader of the wererat smugglers. Report back to Fellmoon."
	evt.Add("QBits", 284)         -- "Return to Fellmoon in Ravenshore and report your success in blackmailing the wererat smuggler, Arion Hunter."
	evt.Subtract("Inventory", 742)         -- "Blackmail Letter"
	evt.Subtract("QBits", 222)         -- Blackmail Letter - I lost it, taken event g 32
	evt.SetNPCTopic{NPC = 4, Index = 0, Event = 33}         -- "Arion Hunter" : "Smuggler Boats"
	evt.Add("History3", 0)
	evt.Subtract("QBits", 231)         -- The were-rats are mad at you
end

-- "Smuggler Boats"
evt.global[33] = function()
	evt.SetMessage(41)         -- "My cargoes are not the kind that want inspecting by harbor officials so my boats have to be, and are, the fastest on the coast of Jadame. They can even outrun a Regnan galley! From here they run west to Ravage Roaming and east to Shadowspire."
end

-- "Ancient Troll Home"
evt.global[34] = function()
	evt.SetMessage(42)         --[[ "Ancient Troll legends tell of a time when we did not live here in this desolate region.  They tell of a place that was quiet and tranquil.  We were driven from this place by the Curse of the Stone.  So for many hundred years we have dwelt here upon the Sand of Iron.  Now it seems we will be forced from this place as well.  The growing sea of fire has destroyed most of my village.  Many friends and family have perished.  This may indeed be the end of my Clan.

There is a saying amongst my people, ""a thing lives only as long as it is remembered.""  As long as I remember our homeland, then it will always be there for us to return too.  It just needs to be found." ]]
end

-- "Quest"
evt.global[35] = function()
	evt.SetMessage(43)         --[[ "Perhaps if you could locate our previous homeland, and check to see if the Curse of the Stone still exists.  If it does perhaps there is a way to remove it.  Any Troll in your party who completes this task would be promoted to War Troll of our Clan. Many honors are bestowed with this title, and you would be forever known to us as a legendary hero.

One of our warriors, Dartin Dunewalker, set out to find this place.  He left thinking he would find clues among the stone fields of Ravage Roaming.  Perhaps you can find him there and work together--or at the least, find clues that will lead you to our goal." ]]
	evt.Add("QBits", 68)         -- "Find the Ancient Troll Homeland and return to Volog Sandwind in the Ironsand Desert."
	evt.SetNPCTopic{NPC = 56, Index = 0, Event = 40}         -- "Volog Sandwind" : "Ancient Home"
end

-- "Ancient Home Found!"
evt.CanShowTopic[36] = function()
	return evt.Cmp("QBits", 69)         -- Ancient Troll Homeland Found
end

evt.global[36] = function()
	evt.SetMessage(45)         --[[ "You have found our Ancient Home?  Its located in the western area of the Murmurwoods?  This is wonderful news.  Perhaps there is still time to move my people.  Unfortunately the Elemental threat must be dealt with first, or no people will be safe! 

All Trolls among you have been promoted to War Troll, and their names will be forever remembered in our songs.  I will teach the rest of you what skills I can, perhaps it will be enough to help you save all of Jadame." ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.Subtract("QBits", 68)         -- "Find the Ancient Troll Homeland and return to Volog Sandwind in the Ironsand Desert."
	evt.SetNPCTopic{NPC = 56, Index = 1, Event = 612}         -- "Volog Sandwind" : "Roster Join Event"
end

-- "Curse of Stone"
evt.global[37] = function()
	evt.SetMessage(46)         --[[ "You were sent to find the Ancient Troll Home?  Your assistance is welcomed!  I am at a loss; the clues I followed to this region have lead to a dead end.  No one here knows about the Curse of the Stone mentioned in our legends.  The Ogre Mage, Zog was less than helpful.  I was lucky to escape his fortress with my life. 

Although, he may have provided assistance with out meaning too!  When I mentioned the Curse of the Stone, he said if I bothered him further, he would be sure to cage me with his pet Basilisk!  Basilisks roam the Murmurwoods!" ]]
end

-- "Thanks for your help!"
evt.global[38] = function()
	evt.SetMessage(47)         -- "Thanks again for your assistance with the Basilisk curse!  Hurry back to Alvar!  We must do what we can to save Jadame."
end

-- "Thanks for your help!"
evt.global[39] = function()
	evt.SetMessage(48)         -- "Thanks for finding our Ancient Home, once the treat to Jadame has been handled we can begin to move there!"
end

-- "Ancient Home"
evt.CanShowTopic[40] = function()
	return evt.Cmp("QBits", 68)         -- "Find the Ancient Troll Homeland and return to Volog Sandwind in the Ironsand Desert."
end

evt.global[40] = function()
	evt.SetMessage(49)         -- "Have you found the Ancient Home for our Clan?  Without its location, my people will surely perish!"
end

-- "Deliver Report"
evt.CanShowTopic[41] = function()
	return evt.Cmp("QBits", 11)         -- "Report to Bastian Loudrin, the merchant guildmaster in Alvar."
end

evt.global[41] = function()
	evt.SetMessage(50)         --[[ "Disaster in Dagger Wound, too? This is indeed disturbing. If one were to believe all the rumors, one would think that all of Jadame is in upheaval and chaos.

I wish I knew more. I rely on our caravan masters for news, but all who were supposed to arrive here this month have not. What I do hear, troubles me. Hurricanes, floods, and now a volcano! The worst I've heard is that a sea of fire has appeared in the Ironsand Desert--and this from many sources.

I wonder if this crystal in Ravenshore has something to do with it. Its appearance at the onset of the calamity seems to be more than a coincidence." ]]
	evt.Subtract("QBits", 11)         -- "Report to Bastian Loudrin, the merchant guildmaster in Alvar."
	evt.Add("QBits", 12)         -- Quest 11 is done.
	evt.SetNPCTopic{NPC = 5, Index = 0, Event = 42}         -- "Bastian Loudrin" : "Quest"
	evt.ForPlayer("All")
	evt.Add("Experience", 15000)
	evt.ForPlayer(0)
	evt.Add("Gold", 2000)
end

-- "Quest"
evt.global[42] = function()
	if not evt.Cmp("QBits", 25) then         -- "Find a witness to the lake of fire's formation. Bring him back to the merchant guild in Alvar."
		evt.SetMessage(51)         --[[ "All of this upheaval is seriously impacting our guild's business. I need more information, but I'm being buried in gossip and rumor.

Many tell me of this sea of fire in the Ironsand Desert. I've heard the tale enough that I almost believe it. Confirmation or denial of the lake's existence would be of great help to me.

If you would serve me, go to the Ironsand Desert and seek this lake. If it is indeed there, find me someone who saw it appear. Bring him back here so I can hear his story myself." ]]
		evt.Add("QBits", 25)         -- "Find a witness to the lake of fire's formation. Bring him back to the merchant guild in Alvar."
		evt.Add("History4", 0)
		evt.MoveNPC{NPC = 7, HouseId = 177}         -- "Overdune Snapfinger" -> "Overdune's House"
		evt.MoveNPC{NPC = 60, HouseId = 177}         -- "Farhill Snapfinger" -> "Overdune's House"
	elseif evt.Cmp("Players", 4) then
		evt.SetMessage(892)         --[[ "Oh, what a mess you've made of things! When I asked you to find me a witness of events in the Ironsand Desert, I thought it would be obvious that you'd have to return him to me in good condition! I mean look at the poor Troll! Take him to the temple and get him fixed up.

And please...try to remember you're working for the guild. We do have a reputation for conducting ourselves with at least passing competence." ]]
	elseif evt.Cmp("QBits", 60) then         -- Party visits Ironsand After QuestBit 25 set.
		evt.SetMessage(53)         --[[ "Well, so it is true. Imagine…a lake of fire. But where is my eyewitness? I need to speak with someone who saw its formation. This is important…for reasons I'm unwilling to discuss with you now.

Find me someone who saw the birth of the lake of fire! Try searching the Troll village, Rust." ]]
	else
		evt.SetMessage(52)         --[[ "I must know more about what is going on in the Ironsand Desert. I can't use more rumors. I have enough of those already.

I need you to actually go there. The desert is several days travel to the east." ]]
	end
end

-- "Quest"
evt.global[43] = function()
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		goto _3
	end
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		goto _3
	end
::_10::
	evt.SetMessage(54)         --[[ "You must form an alliance to stand against our threatened oblivion! Seek support from the Necromancers' Guild, Temple of the Sun, Minotaurs of Ravage Roaming, Dragons of Garrote Gorge, and the Dragon hunting party of Charles Quixote in Garrote Gorge. I'm sure that you will find it impossible to get all of them to agree to work together, but still, you must make your best effort.

If we are to survive in this time of prophecy, my sages tell me that at least three of the groups I mentioned must agree to work together. Go and do this thing. If you value this world and your lives, go!" ]]
	do return end
::_3::
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		goto _6
	end
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		goto _6
	end
	goto _10
::_6::
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.SetMessage(886)         --[[ "Very good…or at least, as good as can be expected. You managed to bring three partners into the alliance--the minimum number my advisors told me would be sufficient to fulfill the ""…Jadame, must stand together…"" part of the prophecy. A pity it could not be more, but events of the cataclysm are clearly coming to a head. It is time to move onward.

You must travel to Ravenshore and meet with the alliance council gathered there. With them, decide what must be the next step we take in meeting the elemental crisis." ]]
		return
	end
	goto _10
end

-- "Well Done"
evt.global[44] = function()
	evt.SetMessage(55)         --[[ "You have done what I feared was impossible. Though these times are fraught with uncertainties, that you have united key factions of Jadame goes a long way towards securing our continued existence.

Well, I have done what I can. I leave the defense of the land to the alliance council. I hope they find the accommodations I have provided them in Ravenshore to be adequate--the guild house there is not our most luxurious. Still, I though it would be best if the council was located near the crystal.

I wish them, and you, good luck!" ]]
end

-- "Lake of Fire"
evt.global[45] = function()
	evt.SetMessage(56)         --[[ "Yes, I was here when the lake of fire first appeared. A strange gateway appeared on the desert plain outside the village. The fire you see spilled forth from it. The fire spread like water poured on the ground.

A wave of flames rushed over the edge of the village. Most of my people were lost instantly. What remains of this village is as you see it.

I was in the hills overlooking the village when this all happened. I saw it all, but I can hardly believe it." ]]
	evt.SetNPCTopic{NPC = 7, Index = 0, Event = 46}         -- "Overdune Snapfinger" : "Come to Alvar"
end

-- "Come to Alvar"
evt.global[46] = function()
	if evt.Cmp("QBits", 62) then         -- Vilebites Ashes (item603) placed in troll tomb.
		evt.SetMessage(59)         -- "You have done my family a great service. With his ashes safe in the holy sanctuary of the village tomb, Vilebite can lie in peace. My father, too is greatly improved. We have talked and I believe that he can now take care of himself while I accompany you to Alvar."
		evt.Add("QBits", 63)         -- Quest 61 done.
		evt.Subtract("QBits", 61)         -- "Put Vilebite's ashes in the Dust village tomb then return to Overdune."
		evt.ForPlayer("All")
		evt.Add("Awards", 6)         -- "Placed Vilebite's ashes in the Troll Tomb."
		evt.ForPlayer(0)
		evt.Add("Gold", 7500)
		evt.ForPlayer("All")
		evt.Add("Experience", 20000)
		evt.SetNPCTopic{NPC = 7, Index = 0, Event = 604}         -- "Overdune Snapfinger" : "Roster Join Event"
		evt.SetNPCGreeting{NPC = 60, Greeting = 18}         -- "Farhill Snapfinger" : "Come in…you are always welcome here."
		evt.SetNPCTopic{NPC = 60, Index = 0, Event = 47}         -- "Farhill Snapfinger" : "Vilebite"
	elseif evt.Cmp("QBits", 61) then         -- "Put Vilebite's ashes in the Dust village tomb then return to Overdune."
		evt.SetMessage(58)         -- "I will go with you only after my brother's ashes are safely in the village tomb."
	else
		evt.SetMessage(57)         --[[ "I would come with you, If it were not for my father. So deep is his mourning for my brother, Vilebite, that he cannot care for himself.

My father believes that Vilebite's soul cannot rest until his remains are at rest in the village tomb. Unfortunately, Gogs infested the tomb when the lake of fire appeared.

Here! Take my brother's ashes. I'm sure my father's grief will lessen if they are placed in the tomb. Do this for me and I will travel with you to Alvar." ]]
		evt.Add("QBits", 61)         -- "Put Vilebite's ashes in the Dust village tomb then return to Overdune."
		evt.Add("Inventory", 603)         -- "Urn of Ashes"
		evt.Add("QBits", 202)         -- Urn of Ashes - I lost it
	end
end

-- "Vilebite"
evt.global[47] = function()
	evt.SetMessage(60)         -- "Vilebite was a good son. I will miss him. But at least I can take comfort knowing that he is at peace. Thank you for your kind and heroic deed."
end

-- "Alliance"
evt.CanShowTopic[48] = function()
	return evt.Cmp("QBits", 17)         -- "Form an alliance with the Dragons of Garrote Gorge."
end

evt.global[48] = function()
	evt.SetMessage(72)         --[[ """An alliance to unite Jadame,"" you say. If it wasn't Lordrin who was proposing it, I would normally have slain you for my supper.

While intriguing, I cannot consider the idea now. We are under daily attack by the accursed knights of Charles Quixote. If he were not a problem, I could do as Lordrin asks.

Perhaps you could help me with Quixote?" ]]
	evt.SetNPCTopic{NPC = 21, Index = 0, Event = 49}         -- "Deftclaw Redreaver" : "Quest"
end

-- "Quest"
evt.global[49] = function()
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if not evt.Cmp("QBits", 33) then         -- "Find the Dragon Egg and return it to the dragon leader, Deftclaw Redreaver."
			evt.SetMessage(73)         --[[ "Last month one of Quixote's raiding parties invaded our caves. They slew many and took with them the egg containing my unborn heir. While those foul slayers hold the egg, we cannot attack their encampment.

If you were to return the egg to me, I could destroy Quixote. Do this for me and I will join your alliance." ]]
			evt.Add("QBits", 33)         -- "Find the Dragon Egg and return it to the dragon leader, Deftclaw Redreaver."
		else
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 605) then         -- "Dragon Leader's Egg"
				evt.ShowMovie{DoubleSize = 1, Name = "\"dragonsrevenge\" "}
				evt.SetMessage(860)         --[[ "Now that I need not fear my heir's destruction. I will visit my revenge on Quixote. His camp will face the assault of fire and claw. Those who have hunted us are now our prey animals.

As for your alliance…you have done me a great service. I will honor my debt. As soon as I've set my enemies to flight or the beyond, I will join the alliance council in Ravenshore." ]]
				evt.Add("QBits", 22)         -- Allied with Dragons. Return Dragon Egg to Dragons done.
				evt.Add("QBits", 35)         -- Quest 33 is done.
				evt.Subtract("QBits", 16)         -- "Form an alliance with the Dragon hunters of Garrote Gorge."
				evt.Subtract("QBits", 17)         -- "Form an alliance with the Dragons of Garrote Gorge."
				evt.Subtract("QBits", 31)         -- "Recover the Dragon Egg from Zog's fortress in Ravage Roaming and return it to Charles Quixote in Garrote Gorge."
				evt.Subtract("QBits", 33)         -- "Find the Dragon Egg and return it to the dragon leader, Deftclaw Redreaver."
				evt.SetNPCTopic{NPC = 19, Index = 0, Event = 0}         -- "Sir Charles Quixote"
				evt.SetNPCGreeting{NPC = 21, Greeting = 20}         -- "Deftclaw Redreaver" : "What do you want?"
				evt.SetNPCTopic{NPC = 21, Index = 0, Event = 0}         -- "Deftclaw Redreaver"
				evt.ForPlayer("All")
				evt.Add("Experience", 20000)
				evt.ForPlayer("All")
				evt.Subtract("Inventory", 605)         -- "Dragon Leader's Egg"
				evt.Subtract("QBits", 204)         -- Dragon Leader's Egg - I lost it, taken event g49, g64
				evt.ForPlayer(0)
				evt.Add("Gold", 10000)
				evt.ForPlayer("All")
				evt.Add("Awards", 7)         -- "Formed an alliance with the Garrote Gorge Dragons."
				evt.Add("History7", 0)
			else
				evt.SetMessage(74)         -- "If you want me to join your alliance, you will have to help me against Charles Quixote. Bring me the Dragon egg he stole from me!"
			end
		end
	end
end

-- "Cure for Blazen Stormlance"
evt.CanShowTopic[50] = function()
	return evt.Cmp("QBits", 72)         -- "Inquire about a cure for Blazen Stormlance from Dervish Chevron in Ravenshore."
end

evt.global[50] = function()
	evt.SetMessage(68)         --[[ "The Gem of Restoration may cure the knight, Blazen Stormlance, of what you say has befallen him.  There is no love lost between the Temple of the Sun and the Guild of Necromancers; any opponent of theirs is definitely a friend of ours.  Restore Stormlance to life so that he may rejoin Charles Quixote.
" ]]
	evt.SetNPCTopic{NPC = 63, Index = 0, Event = 743}         -- "Dervish Chevron" : "Travel with you!"
	evt.Add("Inventory", 623)         -- "Gem of Restoration"
	evt.Add("QBits", 73)         -- Received Cure for Blazen Stormlance
	evt.Add("QBits", 217)         -- Gem of Restoration - I lost it
	evt.Subtract("QBits", 72)         -- "Inquire about a cure for Blazen Stormlance from Dervish Chevron in Ravenshore."
end

-- "Skeletal Dragons"
evt.global[51] = function()
	evt.SetMessage(61)         -- "My father believed that the Necromancers of Shadowspire were attempting to create an undead Dragon.  This would be a truly horrid beast. He believed is was his personal duty to stop them."
end

-- "Promotion to Champion"
evt.global[52] = function()
	evt.SetMessage(62)         -- "My father Blazen, left here years ago to slay the Skeletal Dragons in the Shadowspire Region. Unfortunately, he has never returned.  He took with him, Ebonest, the greatest Dragon slaying spear ever forged. Charles Quixote has never forgiven my father for taking Ebonest with him.  Unfortunately we have no idea what befell my father.  Because my father was Charles’ second in command and responsible for the loss of Ebonest, Charles is unwilling to promote me to Champion, regardless of the merit of my skills. Perhaps if you find Ebonest, Charles with promote your knights and myself to Champions!"
	evt.Add("QBits", 70)         -- "Find Blazen Stormlance and recover the spear Ebonest. Return to Leane Stormlance in Garrote Gorge and deliver Ebonest to Charles Quixote."
	evt.SetNPCTopic{NPC = 62, Index = 0, Event = 59}         -- "Leane Stormlance" : "My Father"
end

-- "Ebonest"
evt.global[53] = function()
	evt.SetMessage(63)         -- "I was captured in the center of the Mad Necromancer’s lab.  There I was tortured and many curses were placed upon me.   Ebonest must have been taken from me when I fell, and perhaps is still in the central chamber.  If you were to recover it and return it to Quixote, at least my family name will be cleared, and my daughter can continue her life without my failure haunting her."
end

-- "Cure"
evt.global[54] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 623) then         -- "Gem of Restoration"
		evt.ForPlayer("All")
		evt.SetMessage(531)         -- "The Cleric sent you back with the Gem of Restoration?  I am free of this place!  Search me out if you wish for me to ever travel with you!  It would be my pleasure to join you in your journeys!  I will wait for you at the Adventurer's Inn in Ravenshore."
		evt.Subtract("Inventory", 623)         -- "Gem of Restoration"
		evt.Subtract("QBits", 217)         -- Gem of Restoration - I lost it
		evt.Add("Experience", 15000)
		evt.Add("QBits", 134)         -- Gave Gem of Restoration to Blazen Stormlance
		evt.Add("QBits", 435)         -- Roster Character In Party 36
		evt.ForPlayer("All")
		evt.Add("Awards", 25)         -- "Rescued Blazen Stormlance."
		evt.SetNPCTopic{NPC = 295, Index = 1, Event = 0}         -- "Blazen Stormlance"
	else
		evt.SetMessage(64)         -- "Perhaps the Clerics of the Sun have a way to cure me, for they would be the only ones who would know how to counter the dark magics that afflict me. There is a friend of mine in Ravenshore named Dervish Chevron. He left the Temple of the Sun years ago to pursue his own research into the mysteries of Jadame.  Perhaps he would know of a cure, or even have it in his possession.  If he cannot help, promise you will return here and kill me so I may at last be at rest!"
		evt.Add("QBits", 72)         -- "Inquire about a cure for Blazen Stormlance from Dervish Chevron in Ravenshore."
	end
end

-- "Mad Necromancer"
evt.global[55] = function()
	evt.SetMessage(65)         -- "Zanthora moved here from the Shadowspire to continue experiments she began at the Necromancers' Guild.  She desired to create the ultimate horror, the Skeletal Dragon.  Her fellow Necromancers feared the end result. If the created Dragons where ever to escape Zanthora’s control, there would be no stopping them."
end

-- "Stormlance"
evt.global[56] = function()
	evt.SetMessage(66)         -- "Blazen Stormlance was my lieutenant and my friend.  I never understood his personal quest--this need to find these rumored Skeletal Dragons.  He took my greatest tool with him.  With Ebonest in my hand, I would have the Dragon problem well in hand.  "
end

-- "Ebonest"
evt.global[57] = function()
	evt.SetMessage(67)         -- "The Clerics of the Sun imbued this spear with their blessings, making it the strongest spear forged.  Its power is said to be able to slay any Dragon with one blow.  If this were so, I could end my conflict quickly, cleanly and efficiently."
end

-- "Promotion to Champion"
evt.CanShowTopic[58] = function()
	return evt.Cmp("QBits", 73)         -- Received Cure for Blazen Stormlance
end

evt.global[58] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 539) then         -- "Ebonest"
		evt.SetMessage(85)         -- "You have found Blazen Stormlance? But where is Ebonest?  Return to me when you have the spear and you will be promoted!"
		return
	end
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetMessage(71)         --[[ "What is this?  You ally with my mortal enemies and then seek to do me a favor?

I wonder what the Dragons think of this. But so be it.  I am in your debt for returning Ebonest to me.  I will promote any Knights in your party to Champion, however they will never be accepted in my service.  The rest I will teach what I can. 

I do not wish to see you again!" ]]
	else
		evt.SetMessage(70)         --[[ "You found Blazen Stormlance?  What about MY spear Ebonest?  You have that as well?

FANTASTIC!

I thank you for this and find myself in your debt!  I will promote all knights in your party to Champion and teach what skills I can to the rest of your party. " ]]
	end
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Experience", 50000)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
		evt.Subtract("Inventory", 539)         -- "Ebonest"
	else
		evt.Add("Experience", 35000)
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Experience", 50000)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
		evt.Subtract("Inventory", 539)         -- "Ebonest"
	else
		evt.Add("Experience", 35000)
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Experience", 50000)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
		evt.Subtract("Inventory", 539)         -- "Ebonest"
	else
		evt.Add("Experience", 35000)
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Experience", 50000)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
		evt.Subtract("Inventory", 539)         -- "Ebonest"
	else
		evt.Add("Experience", 35000)
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Experience", 50000)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
		evt.Subtract("Inventory", 539)         -- "Ebonest"
	else
		evt.Add("Experience", 35000)
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.Subtract("QBits", 70)         -- "Find Blazen Stormlance and recover the spear Ebonest. Return to Leane Stormlance in Garrote Gorge and deliver Ebonest to Charles Quixote."
	evt.SetNPCTopic{NPC = 19, Index = 2, Event = 735}         -- "Sir Charles Quixote" : "Promote Knights"
	evt.SetNPCTopic{NPC = 65, Index = 2, Event = 735}         -- "Sir Charles Quixote" : "Promote Knights"
end

-- "My Father"
evt.global[59] = function()
	if evt.Cmp("QBits", 435) then         -- Roster Character In Party 36
		if evt.Cmp("Inventory", 539) then         -- "Ebonest"
			goto _8
		end
		if evt.Cmp("Awards", 24) then         -- "Returned Ebonest to Charles Quixote."
			goto _8
		end
	elseif not evt.Cmp("Inventory", 539) then         -- "Ebonest"
		evt.SetMessage(69)         -- "Have you found my father?  Or the spear Ebonest?  We must get it back to Charles Quixote!"
		return
	end
	evt.SetMessage(893)         -- "You found Ebonest?  What of my father?  Where is he?  I thought you were going to return when you had found both my father and the spear."
	do return end
::_8::
	evt.SetMessage(894)         -- "You found my father and Ebonest?  I will be forever in your debt!  We should take the spear to Charles Quixote, and if he is agreeable, he will promote me and any knights in your party!"
	evt.ForPlayer("All")
	evt.Add("Experience", 5000)
	evt.SetNPCTopic{NPC = 62, Index = 0, Event = 611}         -- "Leane Stormlance" : "Roster Join Event"
end

-- "Promotion to Great Wyrm"
evt.global[60] = function()
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.SetMessage(76)         -- "You think I would promote a Dragon that serves those who have allied themselves with our Mortal enemy, Charles Quixote.  What arrogance!  What outrageousness!  You will have to prove yourselves to me! And in the proving you will deal a serious blow to your allies!  To the southwest of here, Quixote has established an encampment of his puny “Dragon Slayers.”  This camp is lead by Jeric Whistlebone, the second in command of Quixote’s army.  Destroy this camp!  Kill all of those who serve Quixote in that region and return to me.  Return to me with the sword of  Whistlebone the Slayer."
		evt.Add("QBits", 74)         -- "Kill all Dragon Slayers and return the Sword of Whistlebone the Slayer to Deftclaw Redreaver in Garrote Gorge."
		evt.SetNPCTopic{NPC = 21, Index = 1, Event = 61}         -- "Deftclaw Redreaver" : "Dragon Slayers"
		evt.SetNPCTopic{NPC = 21, Index = 1, Event = 61}         -- "Deftclaw Redreaver" : "Dragon Slayers"
	else
		evt.Cmp("QBits", 22)         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetMessage(75)         -- "To attain the status of Great Wyrm, a Dragon must prove that he can handle himself against a great number of foes.  He must face down the vermin that Charles Quixote would send against us.  To the southwest of here, Quixote has established an encampment of his puny “Dragon Slayers.”  This camp is lead by Jeric Whistlebone, the second in command of Quixote’s army.  Destroy this camp!  Kill all of those who serve Quixote in that region and return to me.  Return to me with the sword of  Whistlebone the Slayer.  In doing this, you will prove to me your worthiness.  "
		evt.Add("QBits", 74)         -- "Kill all Dragon Slayers and return the Sword of Whistlebone the Slayer to Deftclaw Redreaver in Garrote Gorge."
		evt.SetNPCTopic{NPC = 21, Index = 1, Event = 61}         -- "Deftclaw Redreaver" : "Dragon Slayers"
		evt.SetNPCTopic{NPC = 66, Index = 1, Event = 61}         -- "Deftclaw Redreaver" : "Dragon Slayers"
	end
end

-- "Dragon Slayers"
evt.CanShowTopic[61] = function()
	return not evt.Cmp("QBits", 75)         -- Killed all Dragon Slayers in southwest encampment in Area 5
end

evt.global[61] = function()
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
			evt.SetMessage(77)         -- "Have you slain the “Dragon Slayers?""  Where is the sword of Whistlebone the Slayer?!?"
		else
			evt.SetMessage(86)         -- "That cursed knight, Charles Quixote is assembling his best Dragon Slayers at an encampment to the southwest of here.  He must be planning another assault upon the Dragon Caves!"
		end
	end
end

-- "Sword of the Slayer"
evt.CanShowTopic[62] = function()
	return evt.Cmp("QBits", 75)         -- Killed all Dragon Slayers in southwest encampment in Area 5
end

evt.global[62] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 540) then         -- "Sword of Whistlebone"
		evt.SetMessage(81)         -- "You have killed the Dragon Slayers, but where is the Sword of Whistlebone?  Return to me when you have it!"
		return
	end
	if evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		goto _11
	end
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		goto _11
	end
	evt.SetMessage(80)         -- "You return to me with the sword of the Slayer, Whistlebone!  Is there no end to the treachery that you will commit? Is there no one that you owe allegiance to?  I will promote those Dragons who travel with you to Great Wyrm, however they will never fly underneath me!  There rest of your traitorous group will be instructed in those skills which can be taught to them!  Go now!  Never show your face here again, unless you want it eaten!"
::_15::
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
		evt.Subtract("Inventory", 540)         -- "Sword of Whistlebone"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
		evt.Subtract("Inventory", 540)         -- "Sword of Whistlebone"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
		evt.Subtract("Inventory", 540)         -- "Sword of Whistlebone"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
		evt.Subtract("Inventory", 540)         -- "Sword of Whistlebone"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
		evt.Subtract("Inventory", 540)         -- "Sword of Whistlebone"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 74)         -- "Kill all Dragon Slayers and return the Sword of Whistlebone the Slayer to Deftclaw Redreaver in Garrote Gorge."
	evt.SetNPCTopic{NPC = 21, Index = 2, Event = 736}         -- "Deftclaw Redreaver" : "Promote Dragons"
	evt.SetNPCTopic{NPC = 66, Index = 2, Event = 736}         -- "Deftclaw Redreaver" : "Promote Dragons"
	do return end
::_11::
	evt.SetMessage(79)         -- "You return to me with the sword of the Slayer, Whistlebone!  You are indeed worthy of my notice!  The Dragons in your group are promoted to Great Wyrm!  I will teach the others of your group what skills I can as a reward for their assistance!"
	goto _15
end

-- "Alliance"
evt.CanShowTopic[63] = function()
	return evt.Cmp("QBits", 16)         -- "Form an alliance with the Dragon hunters of Garrote Gorge."
end

evt.global[63] = function()
	evt.SetMessage(82)         --[[ "Hmmm…things must be serious if trader Loudrin is involving himself in matters other than his own fortunes...and I must say that there is a taint of doom in the air.

If only for continued good business between my operation and his, I would normally entertain this notion of Loudrin's. Unfortunately, matters here are tying up all of my resources. I have none to spare for support of this alliance you speak of.

Say, perhaps we can help each other? If you were to take care of a little matter for me, I could consider honoring your request." ]]
	evt.SetNPCTopic{NPC = 19, Index = 0, Event = 64}         -- "Sir Charles Quixote" : "Quest"
end

-- "Quest"
evt.global[64] = function()
	if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		if not evt.Cmp("QBits", 31) then         -- "Recover the Dragon Egg from Zog's fortress in Ravage Roaming and return it to Charles Quixote in Garrote Gorge."
			evt.SetMessage(83)         --[[ "One of my customers, an Ogre that goes by the charming moniker of ""Zog the Jackal,"" has seriously betrayed my trust. I gave him an item of great value on promise of future payment. This rather large payment never arrived. I sent a messenger to demand return of the item--a Dragon's egg of great potential. This messenger was slain!

Needless to say, this matter concerns me greatly. I have allotted both money and men for the purpose of revenge. If, however, you were to recover the egg for me from Zog's fortress in Ravage Roaming, I would be glad to pledge service to your alliance." ]]
			evt.Add("QBits", 31)         -- "Recover the Dragon Egg from Zog's fortress in Ravage Roaming and return it to Charles Quixote in Garrote Gorge."
		else
			evt.ForPlayer("All")
			if evt.Cmp("Inventory", 605) then         -- "Dragon Leader's Egg"
				evt.ShowMovie{DoubleSize = 1, Name = "\"dragonhunters\" "}
				evt.SetMessage(853)         --[[ "Well, that matter's done. I will make arrangements to travel to Ravenshore so I myself may sit on your council. Frankly, I could use a bit of change. I will leave my second in command, Reginald Dorray, in charge.

Again, good job." ]]
				evt.Add("QBits", 21)         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
				evt.Add("QBits", 35)         -- Quest 33 is done.
				evt.Subtract("QBits", 16)         -- "Form an alliance with the Dragon hunters of Garrote Gorge."
				evt.Subtract("QBits", 17)         -- "Form an alliance with the Dragons of Garrote Gorge."
				evt.Subtract("QBits", 31)         -- "Recover the Dragon Egg from Zog's fortress in Ravage Roaming and return it to Charles Quixote in Garrote Gorge."
				evt.Subtract("QBits", 33)         -- "Find the Dragon Egg and return it to the dragon leader, Deftclaw Redreaver."
				evt.SetNPCTopic{NPC = 19, Index = 0, Event = 0}         -- "Sir Charles Quixote"
				evt.SetNPCGreeting{NPC = 19, Greeting = 22}         -- "Sir Charles Quixote" : "You just caught me. I'm almost ready to leave for Ravenshore, but how may I help you?"
				evt.SetNPCTopic{NPC = 21, Index = 0, Event = 0}         -- "Deftclaw Redreaver"
				evt.MoveNPC{NPC = 443, HouseId = 0}         -- "Bazalath"
				evt.ForPlayer("All")
				evt.Add("Experience", 20000)
				evt.ForPlayer("All")
				evt.Subtract("Inventory", 605)         -- "Dragon Leader's Egg"
				evt.Subtract("QBits", 204)         -- Dragon Leader's Egg - I lost it, taken event g49, g64
				evt.ForPlayer(0)
				evt.Add("Gold", 10000)
				evt.ForPlayer("All")
				evt.Add("Awards", 8)         -- "Formed an alliance with Charles Quixote and his Dragon Hunters."
				evt.Add("History8", 0)
			else
				evt.SetMessage(84)         --[[ "Have you recovered the Dragon egg from Zog's Ravage Roaming fortress? Oh, never mind. I can see from your abashed expression that you have not.

I stand firm on our deal. Bring me that egg, or I'll have nothing to do with your alliance!" ]]
			end
		end
	end
end

-- "Alliance"
evt.global[65] = function()
	evt.SetMessage(87)         --[[ "You would like my herd to join into an alliance? How could I refuse you? Not only have you saved us from certain death, we have suffered directly from the cataclysm the alliance is being created to fight!

You have my pledge. With the greatest haste I myself will travel to Ravenshore to take a seat on the alliance council." ]]
	evt.ForPlayer("All")
	evt.Add("Awards", 9)         -- "Formed an alliance with the Minotaurs of Ravage Roaming."
	evt.Add("Experience", 20000)
	evt.Add("QBits", 23)         -- Allied with Minotaurs. Rescue the Minotaurs done.
	evt.Subtract("QBits", 18)         -- "Form an alliance with the Minotaurs of Ravage Roaming."
	evt.Subtract("QBits", 30)         -- "Rescue the Minotaurs trapped in their lair in Ravage Roaming."
	evt.Add("History11", 0)
	evt.SetNPCTopic{NPC = 13, Index = 0, Event = 0}         -- "Masul"
	evt.SetNPCTopic{NPC = 70, Index = 0, Event = 613}         -- "Thanys" : "Roster Join Event"
	evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "Thanys"
	evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "Thanys"
end

-- "Flood"
evt.global[66] = function()
	evt.SetMessage(88)         -- "It was the worst of horrors! I was on guard in the main labyrinth just north of here when the waters came. A great wave as high as my head flooded through the passages. I managed to reach this high chamber. I waited for others, but there were none. I fear that many of the herd are dead or trapped inside the lair."
	evt.SetNPCTopic{NPC = 70, Index = 0, Event = 67}         -- "Thanys" : "Quest"
end

-- "Quest"
evt.global[67] = function()
	if evt.Cmp("QBits", 30) then         -- "Rescue the Minotaurs trapped in their lair in Ravage Roaming."
		evt.SetMessage(90)         -- "I just feel it. There are still survivors of my herd trapped in the lair. If you can figure out how to drain the water from flooded passages, you may be able to reach them. Help them, I beg of you!"
	else
		evt.SetMessage(89)         --[[ "Balthazar Lair has many levels. There are other chambers as high as this one., so there may be others who have survived.

I have thought long on this. Though many of the tunnels are flooded, it may be possible to drain them using the doors and air vents as valves. In fact, the whole lair could be drained through the lower level escape tunnel. Help my herd! You would have our eternal gratitude." ]]
		evt.Add("QBits", 30)         -- "Rescue the Minotaurs trapped in their lair in Ravage Roaming."
	end
end

-- "Axe of Balthazar"
evt.global[68] = function()
	evt.SetMessage(91)         -- "Balthazar, the greatest leader in the history of our herd, led our warriors in a mighty battle against the Dark Dwarf vermin that erupt from the earth and spread like a plague. It was not a battle that went well for us. Though Balthazar and some warriors escaped, many were lost along with Balthazar's Axe--his regalia of office, and a powerful artifact as well."
end

-- "Promotion to Minotaur Lord"
evt.global[69] = function()
	evt.SetMessage(92)         -- "Only Masul, our herd leader, can deem an individual worthy of the title of Minotaur Lord.  One way to prove your worth, would be to recover his father’s axe, the Axe of Balthazar from the bowels of the Mines of the Dark Dwarfs.  Set your feet upon the path of this quest, and great is you future!  But we must be sure that the axe you find is indeed the Axe of Balthazar.  Take the Axe to Dadeross, a Minotaur in the service of the Merchants of Alvar, on the island of Dagger Wound.  He will be able to verify the truth of what you find."
	evt.Add("QBits", 76)         -- "Find the Axe of Balthazar, in the Dark Dwarf Mines.  Have the Axe authenticated by Dadeross.  Return the axe to Tessalar, heir to the leadership of the Minotaur Herd."
	evt.SetNPCTopic{NPC = 71, Index = 0, Event = 71}         -- "Tessalar" : "Quest"
end

-- "Dark Dwarves"
evt.global[70] = function()
	evt.SetMessage(93)         -- "These little vermin work with or for the Elements of the Earth.  No one can tell which.  They burrow up from the earth in search of wealth, food, and slaves.  Nothing is left behind where these scavengers have been."
end

-- "Quest"
evt.CanShowTopic[71] = function()
	return evt.Cmp("Inventory", 732)         -- "Certificate of Authentication"
end

evt.global[71] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 541) then         -- "Axe of Balthazar"
		evt.SetMessage(98)         -- "Where is Balthazar's Axe?  You waste my time!  Find the axe, find Dadeross and return to me!"
		return
	end
	if not evt.Cmp("Inventory", 732) then         -- "Certificate of Authentication"
		evt.SetMessage(94)         -- "You have found the Axe of Balthazar!  Have you presented it to Dadeross?  Without his authentication, we can not proceed with the Rite’s of Purity!  Find him and return to us once you have presented him with the axe!"
		return
	end
	evt.SetMessage(95)         -- "You have found the Axe of Balthazar!  Have you presented it to Dadeross? Ah, you have authentication from Dadeross!  The Rite’s of Purity will begin immediately! You proven yourselves worthy, and our now members of our herd!  The Minotaurs who travel with you are promoted to Minotaur Lord.  The others in your group will be taught what skills we have that maybe useful to them."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
		evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
		evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
		evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
		evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
		evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
		evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
		evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
		evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
		evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
		evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
		evt.ForPlayer("All")
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.Subtract("QBits", 76)         -- "Find the Axe of Balthazar, in the Dark Dwarf Mines.  Have the Axe authenticated by Dadeross.  Return the axe to Tessalar, heir to the leadership of the Minotaur Herd."
	evt.Add("QBits", 87)         -- 0
	evt.Subtract("Inventory", 541)         -- "Axe of Balthazar"
	evt.Subtract("Inventory", 732)         -- "Certificate of Authentication"
	evt.SetNPCTopic{NPC = 71, Index = 0, Event = 740}         -- "Tessalar" : "Promote Minotuars"
end

--[[ "Balthazar of 
Ravage Roaming" ]]
evt.global[72] = function()
	if evt.Cmp("QBits", 76) then         -- "Find the Axe of Balthazar, in the Dark Dwarf Mines.  Have the Axe authenticated by Dadeross.  Return the axe to Tessalar, heir to the leadership of the Minotaur Herd."
		evt.SetNPCTopic{NPC = 2, Index = 3, Event = 73}         -- "Dadeross" : "The Axe of Balthazar"
	else
		evt.SetMessage(96)         -- "It was my pleasure to serve under Lord Balthazar, he was the finest herd leader in my tribe’s history.  Unfortunately, my services were pledged to the Merchants of Alvar, or I may have been in the battle where Balthazar fell.  Perhaps my ability and my axe could have saved my lord.  We’ll never know now."
	end
end

-- "The Axe of Balthazar"
evt.CanShowTopic[73] = function()
	return evt.Cmp("Inventory", 541)         -- "Axe of Balthazar"
end

evt.global[73] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 541) then         -- "Axe of Balthazar"
		evt.SetMessage(97)         -- "Of course I would know Balthazar's Axe if I saw it!  Do you have it with you? This IS the axe!  You must take this back to Tessalar, so the Rite’s of Purity may be performed upon the axe, so it be made ready for the son of Balthazar, Masul.  Take this letter with you, it carries my personal seal, and statement that this is indeed the Axe of Balthazar!"
		evt.ForPlayer(0)
		evt.Add("Inventory", 732)         -- "Certificate of Authentication"
		evt.SetNPCTopic{NPC = 2, Index = 3, Event = 75}         -- "Dadeross" : "Hurry!"
	else
		evt.SetMessage(100)         -- "Of course I would know Balthazar's Axe if I saw it!  Do you have it with you?  If you find it, return to me so that I may certify that it is indeed the axe of my late lord, Balthazar."
	end
end

-- "Thanks for your help!"
evt.global[74] = function()
	evt.SetMessage(99)         -- "Thank you for returning the Axe of Balthazar to us!  When we complete the Rites of Purity, we will present the axe to Masul. It will then be known as the Axe of Masul and surely Masul will be a wise and just herd leader."
end

-- "Hurry!"
evt.global[75] = function()
	if evt.Cmp("QBits", 87) then         -- 0
		evt.SetMessage(102)         -- "Ah, you returned Balthazar's Axe with my certificate to Tessalar!  The Rites of Purity have begun.  Soon Lord Masul will wield his father's axe as his own!  Greatness will return to my herd!"
	else
		evt.SetMessage(101)         -- "You have found Balthazar's Axe and I have authenticated it!  Hurry back to Tessalar so that the Rites of Purity may begin!"
	end
end

-- "Prophecies of the Sun"
evt.global[76] = function()
	evt.ForPlayer("All")
	evt.SetMessage(103)         -- "Of the many Prophecies of Jadame, the only ones that I have not be studied are the Prophecies of the Sun.  This temple was established by Tesius Dawnglow, who traveled here from Erathia many years ago to find these Prophecies.  Unfortunately, they were not found.  It is our hope that these Prophecies hold the solution to the events that are destroying Jadame."
end

evt.CanShowTopic[76] = function()
	if not evt.Cmp("Awards", 30) then         -- "Promoted to Cleric of the Sun."
		return evt.Cmp("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	return true
end

-- "Clues"
evt.global[77] = function()
	evt.ForPlayer("All")
	evt.SetMessage(104)         -- "I know that the Prophecies can be found in the Lair of the Feathered Serpent.  However, I have no idea what that means, thus the clue is no help to me. "
end

evt.CanShowTopic[77] = function()
	if not evt.Cmp("Awards", 30) then         -- "Promoted to Cleric of the Sun."
		return not evt.Cmp("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	return false
end

-- "Promtion to Cleric of the Sun"
evt.global[78] = function()
	evt.SetMessage(105)         -- "You seek promotion for the clerics of our faith who travel with you.?  I can promote you, but I do not place much trust or faith in strangers these days.  If you were to do something for me, such as finding the lost Prophecies of the Sun, and returning them to me, then I would be agreeable to promoting you."
	evt.Add("QBits", 78)         --[[ "Find the Prophecies of the Sun in the Abandoned Temple 
and take them to Stephen." ]]
	evt.SetNPCTopic{NPC = 72, Index = 2, Event = 81}         -- "Stephen" : "Quest"
end

--[[ "Lair of the 
Feathered Serpent" ]]
evt.global[79] = function()
	evt.SetMessage(118)         -- "Lair of the Feathered Serpent?  That could possibly refer to the poisonous couatl, but they have not been seen for centuries."
end

-- "Prophecies of the Sun"
evt.global[80] = function()
	evt.ForPlayer("All")
	evt.SetMessage(119)         -- "The Prophecies of the Sun have never been found.  They may not event exist. The Prophecies were written by our greatest prophet.  If they are found it is our hope they will be returned to us!"
end

evt.CanShowTopic[80] = function()
	if not evt.Cmp("Awards", 30) then         -- "Promoted to Cleric of the Sun."
		return not evt.Cmp("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	return false
end

-- "Quest"
evt.CanShowTopic[81] = function()
	return evt.Cmp("Inventory", 626)         -- "Prophecies of the Sun"
end

evt.global[81] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 626) then         -- "Prophecies of the Sun"
		evt.SetMessage(106)         -- "Have you found this Lair of the Feathered Serpent and the Prophecies of the Sun?  Do not waste my time!  The world is ending and you waste time with useless conversation!  Return to me when you have found the Prophecies and have taken them to the Temple of the Sun."
		return
	end
	evt.SetMessage(107)         -- "You have found the lost Prophecies of the Sun?  May the Light forever shine upon you and may the Prophet guide your steps.  With these we may be able to find the answer to what has befallen Jadame! "
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
		evt.Subtract("Inventory", 626)         -- "Prophecies of the Sun"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
		evt.Subtract("Inventory", 626)         -- "Prophecies of the Sun"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
		evt.Subtract("Inventory", 626)         -- "Prophecies of the Sun"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
		evt.Subtract("Inventory", 626)         -- "Prophecies of the Sun"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
		evt.Subtract("Inventory", 626)         -- "Prophecies of the Sun"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.Subtract("QBits", 78)         --[[ "Find the Prophecies of the Sun in the Abandoned Temple 
and take them to Stephen." ]]
	evt.SetNPCTopic{NPC = 72, Index = 2, Event = 737}         -- "Stephen" : "Promote Clerics"
end

-- "Korbu"
evt.global[82] = function()
	evt.SetMessage(109)         -- "Korbu was the most powerful of the Vampire race.  Over one hundred years ago, he sought something that our kind cannot accept.  Absolution.  Somehow, Korbu began to experience guilt over the need to feed.  Or perhaps over the act of feeding itself.  He could no longer bear the thought of killing in order to survive.  Many of our elders argued with him.  He decided to find a place where he could ponder his existence.  Thus the Crypt of Korbu was constructed with slave labor in the Ravage Roaming region.   Korbu has not been heard from since he left.  "
end

-- "Quest"
evt.global[83] = function()
	evt.SetMessage(110)         -- "In this time of chaos, we need the minds of all our elders.  Return to us with Korbu, or his remains, if he has perished.  If he has indeed perished, you must return his Sarcophagus with him.  We will attempt to reanimate him so that we may consult his wisdom."
	evt.Add("QBits", 80)         -- "Find the Sarcophagus of Korbu and Korbu's Remains and return them to Lathean in Shadowspire."
	evt.SetNPCTopic{NPC = 75, Index = 1, Event = 90}         -- "Lathean" : "Return of Korbu"
end

-- "Korbu"
evt.global[84] = function()
	evt.SetMessage(152)         -- "Korbu?  He was the greatest of our kind, and yet he always seemed troubled.  There are some of us that remember the times before he left. He always seemed disturbed to me."
end

-- "Korbu"
evt.global[85] = function()
	evt.SetMessage(153)         -- "Korbu left us after making the ""Arrangement"" with the necromancers here in Shadowspire.  We aid them in any research they are working on, and assist with the defense of their guild.  In return we are allowed to feed on the local population without hindrance."
end

-- "Lich"
evt.global[86] = function()
	evt.SetMessage(113)         -- "Ah, you seek to achieve the ultimate in the darker arts.  The necromancer’s among you seek to turn themselves into Liches, the most potent of necromancers.  Very well, I can perform this transformation for you, but you must do something for me...and get something for yourselves.  I require the Lost Book of Khel.  It contains secrets of necromancy that had been hidden since Khel’s tower sank beneath the waves.  The Lizardmen of Dagger Wound celebrated when the sea took Khel and his knowledge from us.  With the volcanic upheaval in that region, I believe the Tower of Khel can be found.  Retrieve the book from the library and bring it to me!  Now, for yourselves, you will need a Lich Jar for every necromancer that wishes to become a Lich.  Zanthora, the Mad Necromancer keeps a large supply of these jars, perhaps she will sell you one!  If not you must take them from her!"
	evt.Add("QBits", 82)         -- "Find the Lost Book of Khel and return it to Vertrinus in Shadowspire."
	evt.SetNPCTopic{NPC = 74, Index = 0, Event = 89}         -- "Vetrinus Taleshire" : "Promotion to Lich"
end

-- "Lich Jars"
evt.global[87] = function()
	evt.ForPlayer("All")
	evt.SetMessage(154)         -- "The Guild of Necromancers is very stingy when it comes to parting with Lich Jars.  You may be better off seeking out Zanthora, and obtaining one from her."
end

evt.CanShowTopic[87] = function()
	if not evt.Cmp("Awards", 34) then         -- "Promoted to Lich."
		return evt.Cmp("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	return true
end

-- "The Lost Book of Khel"
evt.global[88] = function()
	evt.ForPlayer("All")
	evt.SetMessage(155)         -- "the Lost Book of Khel is rumored to hold the secrets to the ultimate powers of the dark art of necromancy.  It may be good that no one knows where it is!"
end

evt.CanShowTopic[88] = function()
	if not evt.Cmp("Awards", 34) then         -- "Promoted to Lich."
		return evt.Cmp("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	return true
end

-- "Promotion to Lich"
evt.global[89] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 611) then         -- "Lost Book of Kehl"
		evt.SetMessage(115)         -- "You do not have the Lost Book of Khel!  I cannot help you, if you do not help me!  Return here with the Book and a Lich Jar for each necromancer in your party that wishes to become a Lich!"
		return
	end
	evt.ForPlayer(0)
	if not evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _9
	end
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _9
	end
::_28::
	evt.SetMessage(114)         -- "You have the Lost Book of Khel, however you lack the Lich Jars needed to complete the transformation!  Return here when you have one for each necromancer in your party!"
	do return end
::_9::
	evt.ForPlayer(1)
	if not evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _14
	end
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _14
	end
	goto _28
::_14::
	evt.ForPlayer(2)
	if not evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _19
	end
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _19
	end
	goto _28
::_19::
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
			goto _27
		end
		goto _28
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _27
	end
::_30::
	evt.SetMessage(116)         --[[ "You have brought everything needed to perform the transformation!  So be it!  All necromancer’s in your party will be transformed into Liches!  May the dark energies flow through them for all eternity!  The rest of you will gain what knowledge I can teach them as reward for their assistance!  Lets begin!

After we have completed, good friend Lathean can handle any future promotions for your party." ]]
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 611)         -- "Lost Book of Kehl"
	evt.Subtract("QBits", 82)         -- "Find the Lost Book of Khel and return it to Vertrinus in Shadowspire."
	evt.SetNPCTopic{NPC = 74, Index = 0, Event = 742}         -- "Vetrinus Taleshire" : "Travel with you!"
	do return end
::_27::
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _30
	end
	goto _28
end

-- "Return of Korbu"
evt.CanShowTopic[90] = function()
	return evt.Cmp("QBits", 80)         -- "Find the Sarcophagus of Korbu and Korbu's Remains and return them to Lathean in Shadowspire."
end

evt.global[90] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 627) then         -- "Remains of Korbu"
		if evt.Cmp("Inventory", 612) then         -- "Sarcophagus of Korbu"
			evt.SetMessage(112)         -- "You return to us with the Sarcophagus of Korbu, but where are his remains? We cannot complete the act of reanimation without them!  Return to us when you have both the Sarcophagus and his remains!"
		else
			evt.SetMessage(151)         -- "We need to consult Korbu!  You have agreed to bring us his remains and his Sarcophagus!  Do not bother us until you have these items!"
		end
		return
	end
	if not evt.Cmp("Inventory", 612) then         -- "Sarcophagus of Korbu"
		evt.SetMessage(111)         -- "You return to us with the remains of Korbu, but where is his Sarcophagus? We cannot complete the act of reanimation without it!  Return to us when you have both the remains and the Sarcophagus!"
		return
	end
	evt.SetMessage(117)         -- "You have brought us the Sarcophagus of Korbu and his sacred remains.  We will attempt to reanimate Korbu and seek his wisdom in these troubled times!  The vampires among you will be transformed into Nosferatu, and the others will be taught what skills we can teach them as reward for your service."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
		evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
		evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
		evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
		evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
		evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
		evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
		evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
		evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Experience", 35000)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
		evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
		evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	else
		evt.Add("Experience", 25000)
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.Subtract("QBits", 80)         -- "Find the Sarcophagus of Korbu and Korbu's Remains and return them to Lathean in Shadowspire."
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 627)         -- "Remains of Korbu"
	evt.Subtract("Inventory", 612)         -- "Sarcophagus of Korbu"
	evt.SetNPCTopic{NPC = 75, Index = 1, Event = 739}         -- "Lathean" : "Promote Vampires"
end

-- "Thanks for your help!"
evt.global[91] = function()
	evt.SetMessage(120)         -- "Thank you for finding the Prophecies of the Sun.  May the Sun always light you way and provide you with protection!"
end

-- "Thanks for your help!"
evt.global[92] = function()
	evt.SetMessage(121)         -- "You returned Korbu to us, and we will always be in your debt!  Now leave me, so that I may consult the elders!"
end

-- "Thanks for your help!"
evt.global[93] = function()
	evt.SetMessage(151)         -- "We need to consult Korbu!  You have agreed to bring us his remains and his Sarcophagus!  Do not bother us until you have these items!"
end

-- "Alliance"
evt.CanShowTopic[94] = function()
	return evt.Cmp("QBits", 14)         -- "Form an alliance with the Necromancers' Guild in Shadowspire."
end

evt.global[94] = function()
	evt.SetMessage(156)         --[[ "Bastian Loudrin has been a great friend to the guild. Sadly, I must refuse his request at this time. Even as we speak, my guild is embroiled in a battle for its very survival. For you see, the Temple of the Sun has declared a holy war on us. Most of our members are away in the fields either leading armies or raising zombies to serve in them.

I wish I could say otherwise, but the accursed temple holds the upper hand. If only the balance would tilt in our favor." ]]
	evt.SetNPCTopic{NPC = 9, Index = 0, Event = 95}         -- "Sandro" : "Quest"
end

-- "Quest"
evt.global[95] = function()
	if evt.Cmp("QBits", 28) then         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		evt.SetMessage(158)         -- "I will not join you until the security of the guild is secure. Bring me the Nightshade Brazier from the Temple of the Sun in Murmurwoods. We will talk again of alliance after that is done."
		return
	end
	evt.SetMessage(157)         --[[ "If we had the Nightshade Brazier back in our possession, Shadowspire's defense would not be an issue. We could bring this war to the doors of the Sun Temple. We would annihilate them!

Knowing its importance, the clerics keep the brazier in a secure chamber deep within their temple. Dyson Leland believes he can gain access to that chamber. Bring him to the temple, recover the brazier and return it to me. You want me in your alliance? Well, do this for me, and I will be in your debt.

If you have any questions about the Nightshade Brazier ask Thant. It was he who created the thing." ]]
	evt.Add("QBits", 28)         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
	if not evt.Cmp("QBits", 89) then         -- Dyson Leland talks to you about the Necromancers. For global event 97-100.
		if not evt.Cmp("QBits", 90) then         -- Dyson Leland talks to you about the Temple of the Sun. For Global event 97-100.
			return
		end
	end
	evt.SetNPCTopic{NPC = 11, Index = 3, Event = 634}         -- "Dyson Leland" : "Roster Join Event"
end

-- "Dyson Leland"
evt.CanShowTopic[96] = function()
	return not evt.Cmp("Players", 34)
end

evt.global[96] = function()
	evt.SetMessage(159)         --[[ "Early on our conflict, the Sun Temple attempted to infiltrate our ranks with a spy. Such foolishness--thinking they could so easily deceive a host of dark magicians!

It was child's play to unmask their agent--one ""Dyson Leland."" Since then we have turned him against his former masters, or so it would seem. Frankly, I don't entirely trust in his loyalty. Still, he has proven useful. As long as he does, we will continue to let him live." ]]
end

-- "Necromancers"
evt.global[97] = function()
	evt.SetMessage(160)         --[[ "How can anyone's quest for power bring him to participate in the horrors of the Dark Path? And yet, here is a whole house of them! Oh, they will call themselves ""seekers of knowledge,"" but these magicians of death are abomination! Loathsome corruption incarnate!

Only through my own fear can the foul Necromancers' Guild call itself ""my master.""" ]]
	evt.Add("QBits", 89)         -- Dyson Leland talks to you about the Necromancers. For global event 97-100.
	if not evt.Cmp("QBits", 90) then         -- Dyson Leland talks to you about the Temple of the Sun. For Global event 97-100.
		return
	end
	if not evt.Cmp("QBits", 28) then         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		if not evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
			evt.SetNPCTopic{NPC = 11, Index = 3, Event = 100}         -- "Dyson Leland" : "Join"
			return
		end
	end
	evt.SetNPCTopic{NPC = 11, Index = 3, Event = 634}         -- "Dyson Leland" : "Roster Join Event"
end

-- "Sun Temple"
evt.global[98] = function()
	evt.SetMessage(161)         --[[ "When I was young, all I wanted to do was to join the Order of Light--to be a selfless servant of the good. As soon as I was of age, I entered the Temple of the Sun with a heart filled with the fire of purity.

What a fool I was. If there is goodness in the world, I have not seen it. There is certainly none in the halls of the Sun Temple! Hiding behind the righteousness of sanctity, Order members perform the worst crimes of greed and self-indulgence. If it were not so horrid, it would pass for something like irony." ]]
	evt.Add("QBits", 90)         -- Dyson Leland talks to you about the Temple of the Sun. For Global event 97-100.
	if not evt.Cmp("QBits", 89) then         -- Dyson Leland talks to you about the Necromancers. For global event 97-100.
		return
	end
	if not evt.Cmp("QBits", 28) then         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		if not evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
			evt.SetNPCTopic{NPC = 11, Index = 3, Event = 100}         -- "Dyson Leland" : "Join"
			return
		end
	end
	evt.SetNPCTopic{NPC = 11, Index = 3, Event = 634}         -- "Dyson Leland" : "Roster Join Event"
end

-- "Yourself"
evt.global[99] = function()
	evt.SetMessage(162)         --[[ "A few months ago, I was called to a private audience with the Sun Temple head priest, Oskar Tyre. He sent me out on a mission of infiltration against the Necromancers' Guild. ""Become as they are,"" he said. ""Gain their trust. While you bide your time waiting to deliver a killing blow, feed us their secrets.""

A too simple plan from too simple a leader! Oh, I did as he said, bathing myself in evil so I might seem evil. But it was as if the guild could see into my heart. I was unmasked as a spy. Under threat of death, I now follow their orders. " ]]
end

-- "Join"
evt.global[100] = function()
	evt.SetMessage(163)         -- "Join with you? An interesting idea. But what can you offer me? After all I have been through I find myself consumed with a thirst for revenge. I would go with you, but am unwilling to spend my efforts lightly. Give me an opportunity to hurt one of my enemies--the cursed Temple of the Sun or the abominable Necromancers' Guild--and I will travel with you gladly."
end

-- "Thant"
evt.global[101] = function()
	evt.SetMessage(164)         -- "Now that the Nightshade Brazier covers Shadowspire in its fortifying darkness. Thant goes to lead his minions."
end

-- "Alliance"
evt.CanShowTopic[102] = function()
	return evt.Cmp("QBits", 15)         -- "Form an alliance with the Temple of the Sun in Murmurwoods."
end

evt.global[102] = function()
	evt.SetMessage(165)         --[[ "Certainly the elemental unrest concerns us greatly. Why one need travel only a short distance north from our temple to see a great maelstrom of unnatural duration and fury. But sadly we have other matters pressing.

The sick horror that is the Necromancers' Guild must be blighted from this land! We wage holy war on the evil in Shadowspire. Our entire spirit and power goes into the campaign we wage against Sandro and his minions. Until that is done we cannot entertain participation in your alliance." ]]
	evt.SetNPCTopic{NPC = 37, Index = 0, Event = 103}         -- "Oskar Tyre" : "Quest"
end

-- "Quest"
evt.global[103] = function()
	if evt.Cmp("QBits", 27) then         -- Skeleton Transformer Destroyed.
		evt.SetMessage(168)         --[[ "Excellent work! With the Skeleton Transformer destroyed, I am more than confident that the light of righteousness will cleanse Shadowspire of evil. The Necromancers' Guild is as good as no more.

As I agreed, you may now consider the Temple of the Sun an ally against the elemental cataclysm. I myself will sit on your alliance council in Ravenshore. I will make my departure arrangements with all due haste." ]]
		evt.Subtract("QBits", 26)         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
		evt.Subtract("QBits", 14)         -- "Form an alliance with the Necromancers' Guild in Shadowspire."
		evt.Subtract("QBits", 15)         -- "Form an alliance with the Temple of the Sun in Murmurwoods."
		evt.Subtract("QBits", 28)         -- "Bring the Nightshade Brazier to the Necromancers' Guild leader, Sandro. The Brazier is in the Temple of the Sun."
		evt.Add("QBits", 20)         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		evt.SetNPCTopic{NPC = 37, Index = 0, Event = 0}         -- "Oskar Tyre"
		evt.Add("History9", 0)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.ForPlayer(0)
		evt.Add("Gold", 10000)
		evt.ForPlayer("All")
		evt.Add("Awards", 11)         -- "Formed and alliance with the Temple of the Sun."
	elseif evt.Cmp("QBits", 26) then         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
		evt.SetMessage(167)         -- "You come here again with talk of alliance? I have told you what you must do. Go to the Necromancers' Guild in Shadowspire, find Dyson Leland and help him to destroy their Skeleton Transformer!"
	else
		evt.SetMessage(166)         --[[ "Then again, we could spare some resources for your alliance if the war would turn in our favor. Perhaps you could be our agent of fortune?

Inside the Necromancers' Guild is a device known as the ""Skeleton Transformer."" It converts living creatures into the skeletons which the dark mages use for the bulk of their reinforcements. If it were destroyed, we would quickly have the upper hand.

We have an agent, Dyson Leland, placed in their guild. Find him and help him to wreck their skeleton making device. Do this and I will consider your request more favorably." ]]
		evt.Add("QBits", 26)         -- "Find the skeleton transformer in the Shadowspire Necromancers' Guild. Destroy it and return to Oskar Tyre."
	end
end

-- "Alliance"
evt.global[104] = function()
	evt.SetMessage(169)         -- "Do you take the prophecy so lightly that you shirk the role it has cast for you? These are dire times calling for dire actions from all. Go forth across the land and forge the unity represented by the alliance. Go, unless you favor the oblivion that threatens us!"
end

-- "Strange Gateways"
evt.global[105] = function()
	evt.SetMessage(170)         -- "Using Arion Hunter's boats we have managed to gather some information. I sent one to Ravage Roaming and another to the Dagger Wound Islands. It is reported that strange portal gateways have appeared in both regions. The gateway in the islands stands on the slopes of the large volcano that rose from the sea southeast of the main island. The Ravage Roaming portal is in the middle of the large lake. It is said that the water which formed the lake flooded out of the gateway."
end

-- "Ironfists"
evt.global[106] = function()
	evt.SetMessage(171)         --[[ "Within hours of our first meeting, a most fortuitous development occurred. We were contacted by a great sage, Xanthor, of the Ironfist courts of Enroth!

Using his great magic, he projected his image into this very chamber. He and Roland and Catherine Ironfist were at sea off our shores when the cataclysm occurred. They survived the resulting storms and now would like to land in Ravenshore to aid the alliance. Unfortunately, they are blocked by the Regnan pirate fleet. We must help them to land. Xanthor claims much knowledge of what has happened here. We need his council!" ]]
	evt.SetNPCTopic{NPC = 53, Index = 0, Event = 107}         -- "Elgar Fellmoon" : "Quest"
end

-- "Quest"
evt.global[107] = function()
	if evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		evt.SetMessage(173)         --[[ "Your good work sinking the Regnan fleet has already had the desired results. Just yesterday morning, Catherine and Roland Ironfist arrived along with their sage, Xanthor. With them in the alliance, we are made stronger--immeasurably so.

I will admit that the time of this crisis has contained some of my darkest moments. Thanks to your efforts I believe that the worst of this is over. I have hopes that we will indeed survive this." ]]
		evt.Subtract("QBits", 36)         -- "Sink the Regnan Fleet. Return to the Ravenshore council chamber."
		evt.Add("QBits", 38)         -- Quest 36 is done.
		evt.SetNPCTopic{NPC = 53, Index = 0, Event = 109}         -- "Elgar Fellmoon" : "Xanthor"
		evt.ForPlayer("All")
		evt.Add("Experience", 100000)
		evt.ForPlayer(0)
		evt.Add("Gold", 10000)
		evt.ForPlayer("All")
		evt.Add("Awards", 12)         -- "Sunk the Regnan fleet allowing Roland and Catherine Ironfist to join the alliance."
	elseif evt.Cmp("QBits", 36) then         -- "Sink the Regnan Fleet. Return to the Ravenshore council chamber."
		evt.SetMessage(174)         -- "You must sink that Regnan fleet! It is imperative that the Ironfists be allowed to land safely. Their sage Xanthor has knowledge of the crisis that we cannot do without."
	else
		evt.SetMessage(172)         --[[ "Our sources believe the main Regnan fleet is in a hidden port somewhere on Regna Island. If you could sink the fleet in dock you could greatly cripple their ability to patrol the seas off our shore. Unfortunately, we don't have a fleet of our own strong enough to make a landing on Regna.

Brekish Onefang has gotten message to us that the Regnans have built an outpost on an atoll off the main Dagger Wound Island. He believes this outpost is resupplied by mysterious means. His scouts never see ships land there, but they are always well stocked. Perhaps you should go there and solve the mystery. Perhaps the answer will convey you to Regna?

Regardless of the means, the Regnan fleet must be sunk if the Ironfists are to land in Ravenshore." ]]
		evt.Add("QBits", 36)         -- "Sink the Regnan Fleet. Return to the Ravenshore council chamber."
		evt.Add("History12", 0)
	end
end

-- "Pirates"
evt.global[108] = function()
	evt.SetMessage(175)         -- "For all their claims of empire and their airs of civilization, the Regnans are the worst scum of Jadame. Why I cannot find myself the least bit surprised that they would take advantage of the crisis to expand their pirating operations. What concerns me most is their new outpost on Dagger Wound. I am sure they mean to use it as a base of attack on the continent. Why, it even puts them in striking distance of Ravenshore!"
end

-- "Xanthor"
evt.global[109] = function()
	evt.SetMessage(176)         --[[ "I have only met with him briefly, but I am convinced that Xanthor is remarkably knowledgeable about the workings of the elemental planes. Apparently he learned much from the Ironfists' elemental allies during their recent campaigns against the devils of Erathia.

Even now he studies the strange crystal in the town square. You may find him there, or perhaps in the nearby residence we have provided him." ]]
	evt.SetNPCTopic{NPC = 53, Index = 0, Event = 110}         -- "Elgar Fellmoon" : "Quest"
end

-- "Quest"
evt.global[110] = function()
	if evt.Cmp("QBits", 91) then         -- "Consult the Ironfists' court sage, Xanthor about the Ravenshore crystal."
		evt.SetMessage(178)         -- "We look to Xanthor to formulate our next actions. Go to him and see how you can help."
	else
		evt.SetMessage(177)         --[[ "We of the council have great faith in this Xanthor. He has told me that he is formulating a plan for dealing with the elemental crisis. If anyone can find a solution to our problems, it is he.

If you would help us further, be of service to this great sage. Consult with him about the crystal and see what you might do for him." ]]
		evt.Add("QBits", 91)         -- "Consult the Ironfists' court sage, Xanthor about the Ravenshore crystal."
		evt.MoveNPC{NPC = 23, HouseId = 276}         -- "Xanthor" -> "Hostel"
		evt.MoveNPC{NPC = 77, HouseId = 0}         -- "Derrin Delver"
	end
end

-- "Ironfists' Arrival"
evt.global[111] = function()
	evt.SetMessage(179)         -- "That we have been joined by the royal court of Enroth has been nothing but good. I was worried they would be afflicted with the need for pomp which infects many other monarchs. I am gladdened to report that this is not the case with this king and queen. They disembarked and set directly to work on our problem. As key members of our alliance, you will find access to them easy. We have put them up in houses here in Ravenshore."
end

-- "Plane of Fire"
evt.global[112] = function()
	evt.SetMessage(180)         -- "From what Xanthor has told us, I'm sure all of the elemental planes are dangerous. Still, I would advise you to take particular caution when exploring the Plane of Fire. Its denizens, according to reports from the Ironsand Desert, are being particularly belligerent."
end

-- "Plane Between Planes"
evt.global[113] = function()
	evt.SetMessage(181)         -- "All I know of the Plane Between Planes is what I learned from the Alvarian loremasters. Still, if the Destroyer's base is there, proceed with the greatest caution! It is said the plane is made of the stuff of chaos from which all the other planes are formed as if from clay. While chaos has a form, it is fluid. Whatever you see there will not be as it seems. And what is there may be subject to continuous change."
end

-- "Elemental Lord Prisons"
evt.global[114] = function()
	evt.SetMessage(182)         -- "What the Alvar loremasters told me of the Plane Between Planes applies here. While I am sure the prisons of the elemental lords are prisons in every sense of the word, I am equally sure that they will not appear as one would expect."
end

-- "Merchant House"
evt.global[115] = function()
	evt.SetMessage(183)         -- "The Merchant Guild of Alvar owes you a great debt. As a small measure of repayment, we have decided to make this merchanthouse permanently available to you. Please take this gift from us as a token of our profound gratitude for your valorous deeds."
end

-- "Dragon Hunting"
evt.global[116] = function()
	evt.SetMessage(184)         --[[ "I know being part of your alliance is important work. Still, I do miss the hunt! I keep imagining all the good fun my men are having while I'm here pushing around papers.

Hurry up with this alliance business! I want to get this mess taken care of with dispatch! Without the thrill of the hunt, my life is missing its usual spark." ]]
end

-- "Blackwell Cooper"
evt.global[117] = function()
	evt.SetMessage(185)         -- "Judging from the tactics employed by the Regnan pirates, I suspect that Blackwell Cooper is involved. Cooper is an old…shall we say, ""associate,"" of mine. Why, if I were a gambling man, I'd bet gold that he is leading the Regnan expeditionary force on Dagger Wound."
end

-- "Xanthor"
evt.global[118] = function()
	evt.SetMessage(186)         -- "I know I hold the council's minority opinion on the subject, but really, I don't see why we have to involve some charlatan magician in this matter! Surely this crisis is solvable, like most things, with judicious application of a length of well-forged steel."
end

-- "Raising an Army"
evt.global[119] = function()
	evt.SetMessage(187)         -- "Fah! If you ask me, this idea of Xanthor's is foolhardy! I say if we're facing attack by elemental armies, we should be raising an army to meet them. Frankly, all this talk of prophecy leaves me uneasy. This council is too much under the sway of the Ironfist's pet wizard. I say we take the fight to the elemental planes and introduce the invaders to the sharp edges of our blades!"
end

-- "Plane Between Planes"
evt.global[120] = function()
	evt.SetMessage(188)         -- "I tell you, this Xanthor is sending you on a wild goose chase. ""Plane Between Planes,"" indeed! What hogwash! The worst of it is that we make no preparations for war in the event the crazy scheme fails, which I expect it will. This mad following of prophecy flies in the face of good military sense!"
end

-- "Xanthor"
evt.global[121] = function()
	evt.SetMessage(189)         -- "I have had more of my share of doubts about this Xanthor, but it is the mark of a man how readily he admits his errors. It is clear to me now that he has given nothing but good and effective advise. If he tells you to rescue the elemental lords, then that is what you must do. Go! And good luck!"
end

-- "Dragon Hunting"
evt.global[122] = function()
	evt.SetMessage(190)         --[[ "Good to see you again, Heroes of Jadame. A good job there, saving the world, and all. You certainly have my thanks, and I'm sure, the thanks of many.

I'm sure you've got plenty of other opportunities at this point, but let me know if you want a job hunting Dragons. Probably not much of a challenge for the likes of you, but the offer stands!" ]]
end

-- "Accommodations"
evt.global[123] = function()
	evt.SetMessage(191)         --[[ "Small ones, hurry with your alliance preparations! My patience with this land lacking in caves and prey grows dangerously thin. Not only must I sleep in a barn, these people do not even raise cattle. I must live off of fish! Fah!

If you value my good temper, be quick!" ]]
end

-- "Regna Island"
evt.global[124] = function()
	evt.SetMessage(192)         -- "Reaching Regna Island is no small challenge. One of my scouts has reported to me that Regnan boats lie thick on the sea. He also said he saw that the Regnans have a craft that can travel beneath the water. It is said they supply their Dagger Wound outpost with the craft. Perhaps you can use it to reach Regna. The pirates will either miss your passage or take you for one of their own."
end

-- "Quixote's Treasure"
evt.global[125] = function()
	evt.SetMessage(193)         -- "I know this is not the time to think of revenge, but I would pass onto you something I learned about my enemy, Charles Quixote. The Minotaur king, Masul, mentioned that Quixote keeps a sword of great power with him in his keep. It is called, ""Snake."" Perhaps your acquiring of it would help the alliance cause?"
end

-- "Gateways"
evt.global[126] = function()
	evt.SetMessage(194)         -- "My Dragon patrols have located two of the elemental gateways. One lies on the side of a large volcano southeast of the largest Dagger Wound Islands. The other is located in the center of the large lake in Ravage Roaming. I know not where they lead, but you will have to cross a lot of water to reach either."
end

-- "Crystal Dragons"
evt.global[127] = function()
	evt.SetMessage(195)         -- "An Erathian Dragon visited my cave shortly before you arrived there. He reported to me that a new type of Dragon, one seemingly made of crystalline rock, has been seen in Erathia. I'm not sure why I tell you this. Perhaps the giant crystal in the town square reminds me of the story. "
end

-- "The Destroyer"
evt.global[128] = function()
	evt.SetMessage(196)         -- "Interesting that the Destroyer himself sends you to undo his works. I guess I am not surprised. The workings of the greater Powers are mysterious at best."
end

-- "Great Deeds"
evt.global[129] = function()
	evt.SetMessage(197)         -- "You have done this land and Dragonkind a great service. For this, we owe you. Know that we will tolerate your presence in our caves, further, we will not hunt you as prey."
end

-- "The Light"
evt.global[130] = function()
	evt.SetMessage(198)         --[[ "Did you know that our temple in Murmurwoods is the first in this land of Jadame? It is our mission to bring the Light to all corners of the world--even here. We were surprised to see that our enemies, the Necromancers' Guild had preceded our arrival with their own. But no matter, they will soon be dealt with.

Say, don't you think this merchant house would make a fine Sun Temple? I will bring it up with Fellmoon after the crisis is over." ]]
end

-- "Mace of the Sun"
evt.global[131] = function()
	evt.SetMessage(199)         -- "If you're off to Regna, you might want to look for the Mace of the Sun. When my brothers and I made the crossing from Erathia, we were attacked by the Regnan fleet. All but one of our ships escaped. Sadly, the lost ship was the one carrying the mission leader, Brother Howe. He had the weapon in his possession. I saw Brother Howe slain by the pirates, but perhaps they still have the mace."
end

-- "Ironfists"
evt.global[132] = function()
	evt.SetMessage(550)         -- "I am pleased with these Ironfists and their sage, Xanthor. Though we have never worked together directly, their work in Enroth and Erathia against the Necromancers' Guild and the devils have clearly marked them as servants of The Light. I have full faith in their plans for saving us from the crisis."
end

-- "Plane of Air"
evt.global[133] = function()
	evt.SetMessage(551)         -- "The Sun Temple has had much time to study the gateway which appeared in Murmurwoods. I am positive it leads to the Plane of Air. On several occasions my brothers have seen air spirits around the gateway. Some of the braver have peered through it and have reported seeing a whirling realm of clouds."
end

-- "Source of the Crisis"
evt.global[134] = function()
	evt.SetMessage(552)         -- "As a Priest of the Light, I have my own ideas about the source of the crisis. I am positive that either the Temple of the Moon or the Necromancers' Guild is somehow involved. Great Light! What if they've banded together? What a horrid thought."
end

-- "Devils"
evt.global[135] = function()
	evt.SetMessage(553)         -- "I'm not sure you can trust the words of this so called, ""Destroyer."" Certainly he is not the Destroyer of scripture. And all this talk of Kreegans and men living on many worlds. It flies in the face of the Truth my temple has shepherded from the beginning of time!"
end

-- "Servants of the Light"
evt.global[136] = function()
	evt.SetMessage(554)         -- "It is good to have you with us, Heroes of Jadame. Know that the Temple of the Sun also considers you servants of the Light. You are always welcome among us."
end

-- "The Library"
evt.global[137] = function()
	evt.SetMessage(555)         -- "I wish my first visit to Ravenshore was made under better circumstances. This town has a lot to offer and I wish I had time to explore it more. On the bright side, this merchant house has a great library. Have you seen it?"
end

-- "Pirate Raid"
evt.CanShowTopic[138] = function()
	return not evt.Cmp("QBits", 57)         -- The Pirates invaded Ravenshore
end

evt.global[138] = function()
	evt.SetMessage(556)         -- "The Regnans have built and outpost on one of the Dagger Wound Islands. We fear they may attack Ravenshore. If this happens, we will evacuate the city. We will return once the garrison has rid Ravenshore of pirates."
end

-- "Catherine Ironfist"
evt.global[139] = function()
	evt.SetMessage(557)         -- "When I became herd leader, I never expected my reign would be so full of rich experience. Certainly I never thought I'd meet anyone like Queen Catherine! Did you know that until she abdicated her rule in Erathia, she was ruler of both it and Enroth?"
end

-- "Plane of Water"
evt.global[140] = function()
	evt.SetMessage(558)         -- "As you know, the gateway leading to the Plane of Water appeared near Balthazar Lair in Ravage Roaming. It lies in the middle of the lake created by the great flood that poured forth from it."
end

-- "Iron Rations"
evt.global[141] = function()
	if evt.Cmp("QBits", 99) then         -- Masul gave party food.
		evt.SetMessage(614)         -- "I have no more rations to give. If you need more, you'll have to find food elsewhere."
	else
		evt.SetMessage(559)         -- "You may have difficulty finding supplies in the lands beyond the crystal. When I left Balthazar Lair, I brought with me a quantity of the iron rations carried by my armies on campaign. Here, take what I have. They are light and nourishing. I hope you find them useful."
		evt.Add("Food", 20)
		evt.Add("QBits", 99)         -- Masul gave party food.
	end
end

-- "Salvation"
evt.global[142] = function()
	evt.SetMessage(560)         -- "Why if the imprisonment of the elemental lords is what started this crisis, then surely releasing them is the way to end it! They are beings of almost unimaginable power. Once freed of the Destroyer's control, they would be able to set things right again. This must be what the prophecy speaks of!"
end

-- "Keys to the City"
evt.global[143] = function()
	evt.SetMessage(561)         -- "It cannot be said enough. My herd as well as all the beings of Jadame are forever in your debt. Thanks to your good work here and in the planes, Balthazar Lair can once again know greatness. You and your comrades are welcome here any time you wish to visit. A blessing on you all!"
end

-- "Temple of the Sun"
evt.global[144] = function()
	evt.SetMessage(562)         -- "I can't help feeling that I could be doing better work elsewhere. I'm sure Thant can handle operation of the guild in my absence, but still, sitting here on my hands while we are at war with the Sun Temple tries my patience. You really must be quicker about your duties!"
end

-- "Pirate Mages"
evt.global[145] = function()
	evt.SetMessage(563)         -- "When one thinks of the Regnans, the phrase ""masters of magic"" doesn't normally come to mind. But I caution you, the Regnan pirates have held their island for many centuries. They have had much time to both acquire and study arcane knowledge. Some powerful magicians live there. If you must face them in combat, be prepared for anything."
end

-- "Wizards"
evt.global[146] = function()
	evt.SetMessage(564)         -- "It is not true that we of the Necromancers' Guild do not respect mages of other schools. That they have chosen paths leading to lesser powers is of their own concerns. This Xanthor is formidable for a wizard not of the Dark Path. As much as is possible, I find his advise, passably worthy."
end

-- "Ring of Planes"
evt.CanShowTopic[147] = function()
	return not evt.Cmp("Inventory", 519)         -- "Ring of Planes"
end

evt.global[147] = function()
	evt.SetMessage(565)         -- "I have learned that the Dark Dwarves of Alvar hold an item I have long coveted, but may be of particular use to you if you when you travel among the elemental planes. The Ring of Planes conveys upon its wearer powerful wards against damaging spells of earth, water, air, and fire."
end

-- "Nightmares"
evt.global[148] = function()
	evt.SetMessage(566)         -- "In my studies I have learned something of this Plane Between Planes. It is written that its denizens are not born in the normal fashion. I have heard that creatures can be found there which manifest the energies of the nightmare dreams of humankind. I have little more information, but I imagine such a creature would be both powerful and malevolent."
end

-- "Elemental Wars"
evt.global[149] = function()
	evt.SetMessage(567)         -- "A basic fact of magic is that Fire opposes Water, and Air opposes Earth. Within these parings, the one element has weaknesses regarding its opposite element. I expect the Destroyer exploits this principle in the construction of his prisons."
end

-- "Safety"
evt.global[150] = function()
	evt.SetMessage(568)         --[[ "I know I speak for the guild when I say we owe you a debt of gratitude. I discharge this debt by granting you and your companions safe passage through all lands under our control. No guild member will kidnap you for arcane experimentation, nor will any member consider you feed for his servants, living or otherwise. This guild edict will be in effect for a period of one year from today.

And of course, you have my personal, thanks." ]]
end

-- "Xanthor"
evt.global[151] = function()
	evt.SetMessage(569)         -- "The master is not here at present. He went to consult with Elgar Fellmoon at the council chamber. Perhaps you will find him there."
end

-- "The Crystal"
evt.global[152] = function()
	evt.SetMessage(570)         --[[ "The crystal placed by the Destroyer in the town square serves two functions. One, if we do nothing, it will destroy the world. Two, it acts as a gateway to another realm of existence--the Plane Between Planes--where the Destroyer most certainly has his base.

The crystal calls forth the elemental forces into our world and draws them to it. When these forces meet here at the crystal, the world will be destroyed in cataclysm. If we are to prevent this someone will have to use the crystal as a gateway to reach the Destroyer and either convince him to end his assault, or eliminate him." ]]
	evt.Subtract("QBits", 91)         -- "Consult the Ironfists' court sage, Xanthor about the Ravenshore crystal."
	evt.Add("QBits", 92)         -- Quest 91 done.
	evt.SetNPCTopic{NPC = 23, Index = 0, Event = 153}         -- "Xanthor" : "Quest"
	evt.SetNPCTopic{NPC = 23, Index = 1, Event = 154}         -- "Xanthor" : "Gateway"
end

-- "Quest"
evt.global[153] = function()
	if not evt.Cmp("QBits", 41) then         -- "Bring the Heart of Water from the Plane of Water to Xanthor."
		evt.SetMessage(571)         --[[ "Since the crystal is attuned to the elemental forces, it will only pass through those who are themselves so attuned. I believe it is possible to create a key that will simulate attunement for a small group such as yourselves. I can make the key, but require components of pure elemental forces to do so.

Such components exist in only one form that I know of. On each of the four elemental planes, you will find gemstones called the ""elemental hearts."" Bring these to me and I will build the key to open the crystal gateway." ]]
		evt.Add("QBits", 41)         -- "Bring the Heart of Water from the Plane of Water to Xanthor."
		evt.Add("QBits", 42)         -- "Bring the Heart of Air from the Plane of Air to Xanthor."
		evt.Add("QBits", 43)         -- "Bring the Heart of Earth from the Plane of Earth to Xanthor."
		evt.Add("QBits", 44)         -- "Bring the Heart of Fire from the Plane of Fire to Xanthor."
		evt.Add("History14", 0)
		evt.SetNPCTopic{NPC = 53, Index = 0, Event = 0}         -- "Elgar Fellmoon"
		evt.SetNPCTopic{NPC = 53, Index = 1, Event = 112}         -- "Elgar Fellmoon" : "Plane of Fire"
		evt.SetNPCTopic{NPC = 65, Index = 0, Event = 119}         -- "Sir Charles Quixote" : "Raising an Army"
		evt.SetNPCTopic{NPC = 66, Index = 0, Event = 126}         -- "Deftclaw Redreaver" : "Gateways"
		evt.SetNPCTopic{NPC = 67, Index = 0, Event = 133}         -- "Oskar Tyre" : "Plane of Air"
		evt.SetNPCTopic{NPC = 68, Index = 0, Event = 140}         -- "Masul" : "Plane of Water"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 147}         -- "Sandro" : "Ring of Planes"
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 606) then         -- "Heart of Fire"
		if not evt.Cmp("Inventory", 607) then         -- "Heart of Water"
			if not evt.Cmp("Inventory", 608) then         -- "Heart of Air"
				if not evt.Cmp("Inventory", 609) then         -- "Heart of Earth"
					evt.SetMessage(572)         -- "To go through the crystal gateway and confront the Destroyer, you need the key I must build! To build this key, I need the elemental heart gemstones from the four elemental planes! Go and get these for me!"
					return
				end
			end
		end
	end
	evt.SetMessage(573)         -- "I am glad that you have had some measure of success in retrieving the elemental hearts, but what you have is not enough. I need one from each of the four elemental planes before I can build the key to the crystal gateway. Bring me the rest of the hearts so we can proceed."
end

-- "Gateway"
evt.global[154] = function()
	evt.SetMessage(574)         --[[ "Something about this crystal seems to put a compulsion on the denizens of the elemental planes. Why else would they make war on our plane? I have heard yours and other first hand reports. It seems almost as if these elementals are driven by a madness.

And madness it is! For destroying Enroth would create a mighty planar unbalance which would certainly victimize their own planes. They might even conceivably be themselves destroyed in the cataclysm. At the very least, they risk changing the nature of their own planes. I cannot see how such change could possibly be for the better!" ]]
end

-- "Elemental Lords"
evt.global[155] = function()
	evt.SetMessage(575)         --[[ "That the elemental lords are imprisoned on the Plane Between Planes explains much. I had wondered why the denizens of the Earth, Air, Water, and Fire Planes have become so hostile. Usually, they are content to keep to their own place in the order. I suppose it was necessary for the Destroyer to take the lords from their homelands. Without the lords calming presence, it would be much easier for him to compel the elementals as he has.

It is important for you to free the elemental lords. They can restore order to their planes and prevent the cataclysm!" ]]
end

-- "The Destroyer"
evt.global[156] = function()
	evt.SetMessage(576)         --[[ "Yes, I have heard the name, ""Escaton."" He is variously called in the legends of many cultures. I know not his nature, but it is his purpose to destroy worlds.

Yes, ""worlds,"" I say. More and more evidence points to the conclusion that Enroth is not the only place in this universe where there is life. Tales from before the Silence speak of many living among the stars. Yes, it sounds impossible to think that one could live on a light in the sky, but consider that these stars may be like our sun. If this is so, then why can't these suns shine on other places like Enroth? If this was the case, then there could be a ""destroyer of worlds."" I believe that this is what we face." ]]
end

-- "Leaving"
evt.global[157] = function()
	evt.SetMessage(577)         --[[ "No, I don't think I will be leaving when the Ironfists continue their journey back to Enroth. Perhaps I will join with them in some years, but for now, I find myself fascinated by these lands. Though it is destroyed, I would study the remains of the crystal gateway. Never in my knowledge has there been in this world an artifact of comparable power. Perhaps I will find some use for the crystal shards?

No matter. Regardless, when the Ironfists go, they will go without me." ]]
end

-- "Nightshade Brazier"
evt.global[158] = function()
	evt.SetMessage(578)         --[[ "Without false modesty I must say that the Nightshade Brazier is the greatest creation of my dark arts. When its fires are properly tended, the accursed sun is incapable of shining within its area of influence. The soothing shadow of night takes up permanent residence over a vast region. Within these boundaries, vampires and other night creatures know freedoms they would not otherwise know. We are free of the crypts with no worries of the destroying light of day!

And now the Temple of the Sun has taken my prize. It must be retrieved!" ]]
end

-- "Who Are You?"
evt.global[159] = function()
	evt.SetMessage(579)         --[[ "I am Escaton the Destroyer also called ""Devil's Doom,"" ""The Spider in the Web Gate"" and ""Ruin."" There are places where I am worshiped as a god. But to myself I think of myself only as a servant to my greater masters.

Know too that I have brought the cataclysm to your world, which must be destroyed. It is a doom you have brought on yourselves by failing to eliminate the devil Kreegans from your realms. " ]]
	evt.SetNPCTopic{NPC = 26, Index = 0, Event = 160}         -- "Escaton" : "Masters"
	evt.SetNPCTopic{NPC = 26, Index = 1, Event = 161}         -- "Escaton" : "Cataclysm"
	evt.SetNPCTopic{NPC = 26, Index = 2, Event = 162}         -- "Escaton" : "Kreegans"
	evt.SetNPCTopic{NPC = 26, Index = 3, Event = 163}         -- "Escaton" : "Save the World"
	evt.SetNPCTopic{NPC = 23, Index = 0, Event = 155}         -- "Xanthor" : "Elemental Lords"
	evt.SetNPCTopic{NPC = 23, Index = 1, Event = 156}         -- "Xanthor" : "The Destroyer"
	evt.SetNPCGreeting{NPC = 23, Greeting = 112}         -- "Xanthor" : "You are back? Have you need of advice? Or are you finding the task at hand too difficult?"
	evt.Add("QBits", 235)         -- Have talked to Escaton
	evt.Set("MapVar29", 4)
	evt.Set("MapVar30", 4)
	evt.Set("MapVar31", 4)
end

-- "Masters"
evt.global[160] = function()
	if not evt.Cmp("MapVar29", 4) then
		if evt.Cmp("MapVar29", 3) then
			evt.SetMessage(581)         -- "On your world they speak of a Silence which has lasted for a thousand years and more. I am old beyond that and my masters are ancient to me."
			evt.Set("MapVar29", 2)
			return
		end
		if evt.Cmp("MapVar29", 2) then
			evt.SetMessage(582)         -- "There are more worlds than yours--a myriad of them. These worlds were once held in a great web whose threads could be traversed like bridges over rivers. What you call the Silence was marked by the breaking of the web which was built by my masters."
			evt.Set("MapVar29", 1)
			return
		end
		if evt.Cmp("MapVar29", 1) then
			evt.SetMessage(583)         --[[ "At one time my ancient masters were caretakers of more worlds than there are apples in a bushel. Before the Kreegans--before the Silence--they were worlds of wonder. My masters were kings and queens of a golden civilization. I was made, not because I was needed, but because I could be made--a protector of that which needed no protection...a symbol of might to a mighty people.

But now, and for a millennium, the Kreegan blight has eaten away the splendor of the worlds. And so have my masters fallen. They are warlords and generals, and I am their greatest soldier." ]]
			evt.Set("MapVar29", 4)
			return
		end
	end
	evt.SetMessage(580)         -- "My masters are those who created me. They gave me form and function. I have thus proven indestructible. I destroy worlds infested by Kreegans."
	evt.Set("MapVar29", 3)
end

-- "Cataclysm"
evt.global[161] = function()
	if not evt.Cmp("MapVar30", 4) then
		if evt.Cmp("MapVar30", 3) then
			evt.SetMessage(585)         --[[ "The cataclysm was brought into being when I performed the ritual Convocation of Cataclysm which brought into being the crystal. It is a weapon of last resort created by my masters to defend themselves against the Kreegans.

I do have other weapons. But when I became aware of the Kreegans infestation on your world, I deemed the use of ultimate force necessary. Your world has fallen so far--it seemed certain you would not be able to defend yourselves against my enemies. Though I underestimated your abilities, and the Kreegans were ultimately destroyed, I still feel that I was right to err on the side of caution." ]]
			evt.Set("MapVar30", 2)
			return
		end
		if evt.Cmp("MapVar30", 2) then
			evt.SetMessage(586)         -- "My masters, afraid the Kreegans would learn ways to corrupt me, have made me incorruptible. I am unable to undo the Convocation of Cataclysm once it has been performed. This command of theirs is part of my very being. I am powerless but to obey."
			evt.Set("MapVar30", 1)
			return
		end
		if evt.Cmp("MapVar30", 1) then
			evt.SetMessage(587)         --[[ "The Convocation of Cataclysm, as powerful as it is, cannot of itself destroy a world. Each of the elemental planes is ruled by a lord. These lords can fight the compulsion placed on their lesser subjects. For this reason, I have removed the lords from their realms. They are my ""guests"" for the time being.

Once the cataclysm has run its course, I will return them so that they might rebuild your realm and theirs." ]]
			evt.Set("MapVar30", 4)
			return
		end
	end
	evt.SetMessage(584)         -- "Your world will be destroyed by the elemental forces that created it. The crystal in Jadame's central city compels those who live on the elemental planes to open their worlds onto yours. When their worlds meet at the crystal, the reaction will unleash irrepressible destruction across the lands, sky and sea. All things living will live no longer."
	evt.Set("MapVar30", 3)
end

-- "Kreegans"
evt.global[162] = function()
	if not evt.Cmp("MapVar31", 4) then
		if evt.Cmp("MapVar31", 3) then
			evt.SetMessage(589)         --[[ "I am aware that the king and queen of Enroth have rid your world of Kreegans. Still, your world is to be destroyed. Once I am called, I must perform the Convocation. Once the Convocation is begun, it must continue.

I was called while Kreegan still lived on your world. It matters not that they were dust by the time I arrived." ]]
			evt.Set("MapVar31", 2)
			return
		end
		if evt.Cmp("MapVar31", 2) then
			evt.SetMessage(590)         -- "If it were not for the Kreegans and the state of war they impose, my masters could rebuild the Web of Worlds and lift what you call ""The Silence."" My masters have attempted to rebuild the Web many times, but the Kreegans always destroy it. Now they have concluded that the Kreegans must be entirely eliminated or the golden civilization will never rise again. It is to fulfill this purpose that I have been created."
			evt.Set("MapVar31", 1)
			return
		end
		if evt.Cmp("MapVar31", 1) then
			evt.SetMessage(591)         --[[ "As far as I'm able to feel such, I am amazed that your world was able to eliminate its Kreegan infestation. They are quite a bit more…advanced than you. The king and queen of Enroth must be strategists of the highest order. Too bad that they were not able to finish their task sooner.

If I could regret, I would regret having to needlessly annihilate your world." ]]
			evt.Set("MapVar31", 4)
			return
		end
	end
	evt.SetMessage(588)         --[[ "In the time since the Silence, your world has lost knowledge of the Kreegan's origin. That they resemble the devils of myth has been enough for you, and indeed, ""devils"" is what most call them. The truth is they came from the beyond. Before they attacked us, my masters had no knowledge of them.

The Kreegans infest our worlds and spread if they can. It would seem in an endless universe that they could expand in another direction than ours. But they have not made this choice so we must defend ourselves from them." ]]
	evt.Set("MapVar31", 3)
end

-- "Save the World"
evt.global[163] = function()
	evt.SetMessage(592)         --[[ "Yes, your world does need saving! The cataclysm, if not stopped, will destroy it utterly.

A quandary for you: I, as bringer of the cataclysm know how it can be ended. Further, I acknowledge that since there are no longer Kreegans on your world it need not be destroyed. But, as servant to my masters, I am compelled to let the cataclysm continue by not divulging my knowledge to you.

Still I will ask you some questions. Perhaps there is something for you in the answers?" ]]
	evt.Add("QBits", 98)         -- Escaton, heard the first message in global event 163
	evt.SetNPCTopic{NPC = 26, Index = 0, Event = 164}         -- "Escaton" : "Riddle One"
	evt.SetNPCTopic{NPC = 26, Index = 1, Event = 165}         -- "Escaton" : "Riddle Two"
	evt.SetNPCTopic{NPC = 26, Index = 2, Event = 166}         -- "Escaton" : "Riddle Three"
	evt.SetNPCTopic{NPC = 26, Index = 3, Event = 0}         -- "Escaton"
end

-- "Riddle One"
evt.global[164] = function()
	if evt.Cmp("QBits", 94) then         -- Escaton, riddle one answered correctly.
		evt.SetMessage(598)         -- "Jails, prisons and cells come in many forms. We hear of so called ""prisons of the mind."" But I wonder. The riddle seems to speak of a physical prison. What think you?"
	elseif evt.Question{Question = 595, Answer1 = 100, Answer2 = 101} then         --[[ "Where does one serve to pay,
  Is not free to leave,
  But is free when one leaves?" ]]
		if not evt.Cmp("QBits", 95) then         -- Escaton, riddle two answered correctly.
			goto _7
		end
		if not evt.Cmp("QBits", 96) then         -- Escaton, riddle three answered correctly.
			goto _7
		end
		evt.SetMessage(607)         --[[ "I would judge that you've answered the riddles correctly. I suppose in asking them to you I have in some way helped you. As far as I and my nature are concerned, this is sufficient.

As a reward for your performance, take this small bauble. I have more than one and therefore, more than I require. And see? I can give it to you because I don't know you have the knowledge to use it." ]]
		evt.Add("QBits", 97)         -- Escaton, all riddles answered correctly.
		evt.Add("QBits", 48)         -- "Rescue Pyrannaste, Lord of Fire."
		evt.Add("QBits", 50)         -- "Rescue Gralkor the Cruel, Lord of Earth."
		evt.Add("QBits", 52)         -- "Rescue Acwalander, Lord of Water."
		evt.Add("QBits", 54)         -- "Rescue Shalwend, Lord of Air."
		evt.Subtract("QBits", 46)         -- "Find the cause of the cataclysm through the Crystal Gateway."
		evt.Add("QBits", 47)         -- Quest 46 done. Used to allow entrance to elemental lord prisons. Now player needs item 629.
		evt.Add("Inventory", 629)         -- "Ring of Keys"
		evt.Add("QBits", 220)         -- Ring of Keys - I lost it
		evt.Add("History16", 0)
		evt.Subtract("AutonotesBits", 15)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

? + Inside + Egg" ]]
		evt.Add("AutonotesBits", 13)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

Prison + Inside + Egg" ]]
	else
		evt.SetMessage(597)         -- "That doesn't seem right at all."
	end
::_35::
	evt.SetNPCTopic{NPC = 26, Index = 0, Event = 160}         -- "Escaton" : "Masters"
	evt.SetNPCTopic{NPC = 26, Index = 1, Event = 161}         -- "Escaton" : "Cataclysm"
	evt.SetNPCTopic{NPC = 26, Index = 2, Event = 162}         -- "Escaton" : "Kreegans"
	evt.SetNPCTopic{NPC = 26, Index = 3, Event = 171}         -- "Escaton" : "Riddles"
	do return end
::_7::
	evt.SetMessage(596)         -- "Yes. Your answer seems to fit the riddle nicely. Perhaps that is the correct answer."
	evt.Add("QBits", 94)         -- Escaton, riddle one answered correctly.
	if evt.Cmp("QBits", 95) then         -- Escaton, riddle two answered correctly.
		evt.Add("AutonotesBits", 11)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ?

Prison + Inside + ?" ]]
		evt.Subtract("AutonotesBits", 14)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ?

? + Inside + ?" ]]
	elseif evt.Cmp("QBits", 96) then         -- Escaton, riddle three answered correctly.
		evt.Add("AutonotesBits", 12)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ""Egg.""

Prison + ? + Egg" ]]
		evt.Subtract("AutonotesBits", 16)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ?  Riddle Three: ""Egg.""

? + ? + Egg" ]]
	else
		evt.Add("AutonotesBits", 10)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ?

Prison + ? + ?" ]]
	end
	goto _35
end

-- "Riddle Two"
evt.global[165] = function()
	if evt.Cmp("QBits", 95) then         -- Escaton, riddle two answered correctly.
		evt.SetMessage(602)         -- "Inside. Inside what? And what is inside? And while we're asking...why?"
	elseif evt.Question{Question = 599, Answer1 = 102, Answer2 = 103} then         --[[ "What is there when
  You enter a room,
  And cannot be outside,
  Though you leave the door open?" ]]
		if not evt.Cmp("QBits", 94) then         -- Escaton, riddle one answered correctly.
			goto _7
		end
		if not evt.Cmp("QBits", 96) then         -- Escaton, riddle three answered correctly.
			goto _7
		end
		evt.SetMessage(607)         --[[ "I would judge that you've answered the riddles correctly. I suppose in asking them to you I have in some way helped you. As far as I and my nature are concerned, this is sufficient.

As a reward for your performance, take this small bauble. I have more than one and therefore, more than I require. And see? I can give it to you because I don't know you have the knowledge to use it." ]]
		evt.Add("QBits", 97)         -- Escaton, all riddles answered correctly.
		evt.Add("QBits", 48)         -- "Rescue Pyrannaste, Lord of Fire."
		evt.Add("QBits", 50)         -- "Rescue Gralkor the Cruel, Lord of Earth."
		evt.Add("QBits", 52)         -- "Rescue Acwalander, Lord of Water."
		evt.Add("QBits", 54)         -- "Rescue Shalwend, Lord of Air."
		evt.Subtract("QBits", 46)         -- "Find the cause of the cataclysm through the Crystal Gateway."
		evt.Add("QBits", 47)         -- Quest 46 done. Used to allow entrance to elemental lord prisons. Now player needs item 629.
		evt.Add("Inventory", 629)         -- "Ring of Keys"
		evt.Add("QBits", 220)         -- Ring of Keys - I lost it
		evt.Add("History16", 0)
		evt.Subtract("AutonotesBits", 12)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ""Egg.""

Prison + ? + Egg" ]]
		evt.Add("AutonotesBits", 13)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

Prison + Inside + Egg" ]]
	else
		evt.SetMessage(601)         -- "I suppose that could work…no, on second thought, it seems entirely wrong."
	end
::_35::
	evt.SetNPCTopic{NPC = 26, Index = 0, Event = 160}         -- "Escaton" : "Masters"
	evt.SetNPCTopic{NPC = 26, Index = 1, Event = 161}         -- "Escaton" : "Cataclysm"
	evt.SetNPCTopic{NPC = 26, Index = 2, Event = 162}         -- "Escaton" : "Kreegans"
	evt.SetNPCTopic{NPC = 26, Index = 3, Event = 171}         -- "Escaton" : "Riddles"
	do return end
::_7::
	evt.SetMessage(600)         -- "The vagaries of language are many. Still, your answer seems to apply well to the question."
	evt.Add("QBits", 95)         -- Escaton, riddle two answered correctly.
	if evt.Cmp("QBits", 94) then         -- Escaton, riddle one answered correctly.
		evt.Add("AutonotesBits", 11)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ?

Prison + Inside + ?" ]]
		evt.Subtract("AutonotesBits", 10)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ?

Prison + ? + ?" ]]
	elseif evt.Cmp("QBits", 96) then         -- Escaton, riddle three answered correctly.
		evt.Add("AutonotesBits", 15)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

? + Inside + Egg" ]]
		evt.Subtract("AutonotesBits", 16)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ?  Riddle Three: ""Egg.""

? + ? + Egg" ]]
	else
		evt.Add("AutonotesBits", 14)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ?

? + Inside + ?" ]]
	end
	goto _35
end

-- "Riddle Three"
evt.global[166] = function()
	if evt.Cmp("QBits", 96) then         -- Escaton, riddle three answered correctly.
		evt.SetMessage(606)         -- """Egg,"" yes. or perhaps, ""eggs."" Eggs are a source of life, a seed of sorts. They are also of an unusual shape not found in many places elsewhere. Perhaps placing the answer in context will give a clue or some direction."
	elseif evt.Question{Question = 603, Answer1 = 104, Answer2 = 105} then         --[[ "A moon colored box
  meant to be opened from the inside
  protects the sun colored
  treasure of life.
  What is it?" ]]
		if not evt.Cmp("QBits", 94) then         -- Escaton, riddle one answered correctly.
			goto _7
		end
		if not evt.Cmp("QBits", 95) then         -- Escaton, riddle two answered correctly.
			goto _7
		end
		evt.SetMessage(607)         --[[ "I would judge that you've answered the riddles correctly. I suppose in asking them to you I have in some way helped you. As far as I and my nature are concerned, this is sufficient.

As a reward for your performance, take this small bauble. I have more than one and therefore, more than I require. And see? I can give it to you because I don't know you have the knowledge to use it." ]]
		evt.Add("QBits", 97)         -- Escaton, all riddles answered correctly.
		evt.Add("QBits", 48)         -- "Rescue Pyrannaste, Lord of Fire."
		evt.Add("QBits", 50)         -- "Rescue Gralkor the Cruel, Lord of Earth."
		evt.Add("QBits", 52)         -- "Rescue Acwalander, Lord of Water."
		evt.Add("QBits", 54)         -- "Rescue Shalwend, Lord of Air."
		evt.Subtract("QBits", 46)         -- "Find the cause of the cataclysm through the Crystal Gateway."
		evt.Add("QBits", 47)         -- Quest 46 done. Used to allow entrance to elemental lord prisons. Now player needs item 629.
		evt.Add("Inventory", 629)         -- "Ring of Keys"
		evt.Add("QBits", 220)         -- Ring of Keys - I lost it
		evt.Add("History16", 0)
		evt.Subtract("AutonotesBits", 11)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ?

Prison + Inside + ?" ]]
		evt.Add("AutonotesBits", 13)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

Prison + Inside + Egg" ]]
	else
		evt.SetMessage(605)         -- "I don't see how that could be the answer. Really I can't."
	end
::_35::
	evt.SetNPCTopic{NPC = 26, Index = 0, Event = 160}         -- "Escaton" : "Masters"
	evt.SetNPCTopic{NPC = 26, Index = 1, Event = 161}         -- "Escaton" : "Cataclysm"
	evt.SetNPCTopic{NPC = 26, Index = 2, Event = 162}         -- "Escaton" : "Kreegans"
	evt.SetNPCTopic{NPC = 26, Index = 3, Event = 171}         -- "Escaton" : "Riddles"
	do return end
::_7::
	evt.SetMessage(604)         -- "What else indeed could the answer be? I'm sure if one were to apply some thought, one could think of something. Still in these matters, it is best to have confidence in one's clearest thought. I suppose your answer could be correct."
	evt.Add("QBits", 96)         -- Escaton, riddle three answered correctly.
	if evt.Cmp("QBits", 94) then         -- Escaton, riddle one answered correctly.
		evt.Add("AutonotesBits", 12)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ""Egg.""

Prison + ? + Egg" ]]
		evt.Subtract("AutonotesBits", 10)         --[[ "Destroyer's Riddles. Riddle One: ""Prison.""  Riddle Two: ?  Riddle Three: ?

Prison + ? + ?" ]]
	elseif evt.Cmp("QBits", 95) then         -- Escaton, riddle two answered correctly.
		evt.Add("AutonotesBits", 15)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ""Egg.""

? + Inside + Egg" ]]
		evt.Subtract("AutonotesBits", 14)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ""Inside.""  Riddle Three: ?

? + Inside + ?" ]]
	else
		evt.Add("AutonotesBits", 16)         --[[ "Destroyer's Riddles. Riddle One: ?  Riddle Two: ?  Riddle Three: ""Egg.""

? + ? + Egg" ]]
	end
	goto _35
end

-- "Release Shalwend"
evt.global[167] = function()
	if not evt.Cmp("QBits", 51) then         -- Quest 50 done.
		goto _5
	end
	if not evt.Cmp("QBits", 53) then         -- Quest 52 done.
		goto _5
	end
	if not evt.Cmp("QBits", 49) then         -- Quest 48 done.
		goto _5
	end
	evt.SetMessage(888)         --[[ "Thank you for releasing me. Know that Shalwend, Lord of Air, holds you in his favor. 

I go now to restore order to my realm and to join with my fellow lords to do what I can for yours. Be warned! Our actions will destabilize the crystal gateway. Leave now for your home, lest you be trapped here forever.  Inform Xanthor of what has happened here. Farewell" ]]
	evt.Add("QBits", 56)         -- All Lords from quests 48, 50, 52, 54 rescued.
	evt.Add("History17", 0)
::_10::
	evt.SetNPCTopic{NPC = 30, Index = 0, Event = 0}         -- "Shalwend"
	evt.MoveNPC{NPC = 30, HouseId = 0}         -- "Shalwend"
	evt.ForPlayer("All")
	evt.Add("Experience", 100000)
	evt.ForPlayer(0)
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 54)         -- "Rescue Shalwend, Lord of Air."
	evt.Add("QBits", 55)         -- Quest 54 done.
	evt.Add("Awards", 14)         -- "Rescued Shalwend, Lord of Air."
	do return end
::_5::
	evt.SetMessage(608)         -- "Thank you for releasing me. I go now to restore order to my realm and to do what I can for yours. Know that Shalwend, Lord of Air, holds you in his favor. Farewell."
	goto _10
end

-- "Release Acwalander"
evt.global[168] = function()
	if not evt.Cmp("QBits", 51) then         -- Quest 50 done.
		goto _5
	end
	if not evt.Cmp("QBits", 55) then         -- Quest 54 done.
		goto _5
	end
	if not evt.Cmp("QBits", 49) then         -- Quest 48 done.
		goto _5
	end
	evt.SetMessage(889)         --[[ """The Destroyer"" is a fitting moniker for one who would imprison me in such a fashion. If it were not for you, I, Acwalander, Lord of Water, would have soon perished. My passing would have had an unbalancing effect across all the planes. Thank you. I go now to gather with the other lords. Together we will set things right.

 Be warned! Our actions will destabilize the crystal gateway. Leave now for your home, lest you be trapped here forever. Inform Xanthor of what has happened here. Farewell." ]]
	evt.Add("QBits", 56)         -- All Lords from quests 48, 50, 52, 54 rescued.
	evt.Add("History17", 0)
::_10::
	evt.SetNPCTopic{NPC = 28, Index = 0, Event = 0}         -- "Acwalander"
	evt.MoveNPC{NPC = 28, HouseId = 0}         -- "Acwalander"
	evt.ForPlayer("All")
	evt.Add("Experience", 100000)
	evt.ForPlayer(0)
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 52)         -- "Rescue Acwalander, Lord of Water."
	evt.Add("QBits", 53)         -- Quest 52 done.
	evt.Add("Awards", 15)         -- "Rescued Acwalander, Lord of Water."
	do return end
::_5::
	evt.SetMessage(609)         -- """The Destroyer"" is a fitting moniker for one who would imprison me in such a fashion. If it were not for you, I, Acwalander, Lord of Water, would have soon perished. My passing would have had an unbalancing effect across all the planes. Thank you. I go now to set things right."
	goto _10
end

-- "Release Gralkor"
evt.global[169] = function()
	if not evt.Cmp("QBits", 55) then         -- Quest 54 done.
		goto _5
	end
	if not evt.Cmp("QBits", 53) then         -- Quest 52 done.
		goto _5
	end
	if not evt.Cmp("QBits", 49) then         -- Quest 48 done.
		goto _5
	end
	evt.SetMessage(890)         --[[ "I am free! Now will he who was fool enough to jail me--this Destroyer--feel my wrath. That I, the Lord of Earth, am called ""Gralkor the Cruel"" is no mistake. The suffering I have felt will be his returned in multitudes!

I go now to gather with the other lords. Together we will set things right. Be warned! Our actions will destabilize the crystal gateway. Leave now for your home, lest you be trapped here forever. Inform Xanthor of what has happened here. Farewell" ]]
	evt.Add("QBits", 56)         -- All Lords from quests 48, 50, 52, 54 rescued.
	evt.Add("History17", 0)
::_10::
	evt.SetNPCTopic{NPC = 29, Index = 0, Event = 0}         -- "Gralkor the Cruel"
	evt.MoveNPC{NPC = 29, HouseId = 0}         -- "Gralkor the Cruel"
	evt.ForPlayer("All")
	evt.Add("Experience", 100000)
	evt.ForPlayer(0)
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 50)         -- "Rescue Gralkor the Cruel, Lord of Earth."
	evt.Add("QBits", 51)         -- Quest 50 done.
	evt.Add("Awards", 16)         -- "Rescued Gralkor the Cruel, Lord of Earth."
	do return end
::_5::
	evt.SetMessage(610)         -- "I am free! Now will he who was fool enough to jail me--this Destroyer--feel my wrath. That I, the Lord of Earth, am called ""Gralkor the Cruel"" is no mistake. The suffering I have felt will be his returned in multitudes!"
	goto _10
end

-- "Release Pyrannaste"
evt.global[170] = function()
	if not evt.Cmp("QBits", 51) then         -- Quest 50 done.
		goto _5
	end
	if not evt.Cmp("QBits", 53) then         -- Quest 52 done.
		goto _5
	end
	if not evt.Cmp("QBits", 55) then         -- Quest 54 done.
		goto _5
	end
	evt.SetMessage(891)         --[[ "Free at last. My torment is over, but what of my subjects? I know the Destroyer has them compelled to a terrible task. My presence will sooth them. I must go to restore order to my realm and yours.

Before I return to the Plane of Fire, I will gather with the other lords. Together we will set things right. Be warned! Our actions will destabilize the crystal gateway. Leave now for your home, lest you be trapped here forever.  Inform Xanthor of what has happened here. Farewell" ]]
	evt.Add("QBits", 56)         -- All Lords from quests 48, 50, 52, 54 rescued.
	evt.Add("History17", 0)
::_10::
	evt.SetNPCTopic{NPC = 27, Index = 0, Event = 0}         -- "Pyrannaste"
	evt.MoveNPC{NPC = 27, HouseId = 0}         -- "Pyrannaste"
	evt.ForPlayer("All")
	evt.Add("Experience", 100000)
	evt.ForPlayer(0)
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.Subtract("QBits", 48)         -- "Rescue Pyrannaste, Lord of Fire."
	evt.Add("QBits", 49)         -- Quest 48 done.
	evt.Add("Awards", 17)         -- "Rescued Pyrannaste, Lord of Fire."
	do return end
::_5::
	evt.SetMessage(611)         -- "Free at last. My torment is over, but what of my subjects? I know the Destroyer has them compelled to a terrible task. My presence will sooth them. I must go. I must…farewell…"
	goto _10
end

-- "Riddles"
evt.global[171] = function()
	if evt.Cmp("QBits", 97) then         -- Escaton, all riddles answered correctly.
		evt.SetMessage(594)         --[[ "My masters have made me a holder, and not a giver, of knowledge. Still perhaps you have given yourself knowledge through my questions? I have given you all the questions I will, so you must look at what you have. Perhaps you should question the answers.

A ""prison"" implies a prisoner. Who? ""Inside?"" Inside of what? And ""egg."" What kind of egg? A bird's egg? Perhaps something like an egg?" ]]
	else
		evt.SetMessage(593)         --[[ "Though I must destroy your world, what I need do I have already done. Until the cataclysm has culminated, there is nothing to stop me from indulging you with my conversation. This cannot continue forever. Nothing does.

Sometimes questions create more questions. Sometimes they provide answers. I wonder what my questions will provide you?" ]]
		evt.SetNPCTopic{NPC = 26, Index = 0, Event = 164}         -- "Escaton" : "Riddle One"
		evt.SetNPCTopic{NPC = 26, Index = 1, Event = 165}         -- "Escaton" : "Riddle Two"
		evt.SetNPCTopic{NPC = 26, Index = 2, Event = 166}         -- "Escaton" : "Riddle Three"
		evt.SetNPCTopic{NPC = 26, Index = 3, Event = 0}         -- "Escaton"
	end
end

-- "Raiders"
evt.global[172] = function()
	evt.SetMessage(613)         -- "There are many predators who would take advantage of the lair in this vulnerable time. I've already driven off looters…and worse. One of Zog's patrols stopped by soon after the flood. I fought them off, but some escaped. I am sure they will be back in greater numbers."
	evt.SetNPCTopic{NPC = 70, Index = 2, Event = 173}         -- "Thanys" : "Join"
end

-- "Join"
evt.global[173] = function()
	evt.SetMessage(612)         -- "No! Someone must remain here to guard the lair against the barbarian raiders. Come back after you've helped my herd. I may consider joining you then."
end

-- "Quest"
evt.global[174] = function()
	evt.SetMessage(619)         -- "Yellow Fever is a very crippling disease that pops up every few years.  Usually we arrange for medicine from the mainland, but now that the bridges are destroyed, no one can make it to the docks!"
	evt.SetNPCTopic{NPC = 78, Index = 0, Event = 175}         -- "Aislen" : "Quest"
end

-- "Quest"
evt.CanShowTopic[175] = function()
	return not evt.Cmp("QBits", 108)         -- Yellow Fever epidemic cured!
end

evt.global[175] = function()
	evt.SetMessage(620)         -- "Here, take these scrolls of Cure Disease.  Maybe we can at least prevent an epidemic!  The six huts on the outer islands are infected.  If the teleporters between the islands are repaired, you can take these scrolls to the huts.  Unfortunately you will have to find three more scrolls in your travels."
	evt.Add("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
	evt.SetNPCTopic{NPC = 78, Index = 0, Event = 176}         -- "Aislen" : "Have you stopped the epidemic?"
	evt.Add("Inventory", 373)         -- "Cure Disease"
	evt.Add("Inventory", 373)         -- "Cure Disease"
	evt.Add("Inventory", 373)         -- "Cure Disease"
end

-- "Have you stopped the epidemic?"
evt.CanShowTopic[176] = function()
	return evt.Cmp("QBits", 108)         -- Yellow Fever epidemic cured!
end

evt.global[176] = function()
	evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
	evt.Subtract("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
	evt.Add("Gold", 1500)
	evt.ForPlayer("All")
	evt.Add("Awards", 18)         -- "Stopped the Yellow Fever Epidemic on Dagger Wound Island"
	evt.SetNPCTopic{NPC = 78, Index = 0, Event = 661}         -- "Aislen" : "Pirate Raids"
end

-- "Quest"
evt.CanShowTopic[177] = function()
	return not evt.Cmp("QBits", 110)         -- Poison removed from water supply!
end

evt.global[177] = function()
	evt.SetMessage(622)         -- "I hear that Yellow Fever is once again spreading through the people.  Usually the water supply here on the main island is the primary source of the disease.  We used to get an Anointed Herb Potion from the mainland when the disease popped up.  Without access to the dock however, we cannot get this needed cure.  If you find a way to the mainland, perhaps the smugglers of Ravenshore have the cure.  If you can procure the Anointed Potion, return to me with it!"
	evt.Add("QBits", 109)         -- "Find and return an Anointed Potion to Languid in the Dagger Wound Islands."
	evt.SetNPCTopic{NPC = 79, Index = 0, Event = 178}         -- "Languid" : "Do you have the antidote?"
end

-- "Do you have the antidote?"
evt.global[178] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 616) then         -- "Anointed Herb Potion"
		evt.SetMessage(623)         -- "Thank you!  I will go introduce this to the water supply!"
		evt.Subtract("Inventory", 616)         -- "Anointed Herb Potion"
		evt.ForPlayer("All")
		evt.Add("Experience", 7500)
		evt.ForPlayer(0)
		evt.Add("Gold", 2000)
		evt.ForPlayer("All")
		evt.Subtract("QBits", 109)         -- "Find and return an Anointed Potion to Languid in the Dagger Wound Islands."
		evt.Subtract("QBits", 245)         -- Annointed Herb Potion - I lost it!
		evt.Add("QBits", 110)         -- Poison removed from water supply!
		evt.Add("Awards", 59)         -- "Brought the Annointed Herb Potion to Languid on the Dagger Wound Islands."
		evt.SetNPCTopic{NPC = 79, Index = 0, Event = 0}         -- "Languid"
	else
		evt.SetMessage(745)         -- "Without the Anointed Herb Potion we cannot remove the poison from our water supply!"
	end
end

-- "Potion of Pure Speed"
evt.CanShowTopic[179] = function()
	return not evt.Cmp("QBits", 113)         -- "Bring Thistle on the Dagger Wound Islands the basic ingredients for a potion of Pure Speed."
end

evt.global[179] = function()
	evt.SetMessage(624)         -- "Perhaps you can bring me the basic ingredients for a Potion of Pure speed?  With them I can make this incredible potion and finish my studies in alchemy!  I will reward you well for your assistance!"
	evt.Add("QBits", 113)         -- "Bring Thistle on the Dagger Wound Islands the basic ingredients for a potion of Pure Speed."
	evt.SetNPCTopic{NPC = 88, Index = 0, Event = 0}         -- "Thistle"
end

-- "Ingredients"
evt.global[180] = function()
	evt.SetMessage(747)         -- "Black Potions are made of a complex blending of many of the three basic alchemical reagents. Red reagents include Widowsweep Berries, Wolf's Eye, and Phials of Gog Blood.  Some blue reagents are Phoenix Feather, Phima Root, Meteor Fragment and Will O' Wisps Heart.  And some yellow reagents are Datura, Dragon Turtle Fang, Poppy Pods and Thornbark."
end

-- "Do you have the Ingredients?"
evt.CanShowTopic[181] = function()
	return evt.Cmp("QBits", 113)         -- "Bring Thistle on the Dagger Wound Islands the basic ingredients for a potion of Pure Speed."
end

evt.global[181] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 4} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 2} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 1} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(626)         -- "The ingredients!  Thank you!  Take this as a reward!"
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 4}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 2}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 1}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 113)         -- "Bring Thistle on the Dagger Wound Islands the basic ingredients for a potion of Pure Speed."
		evt.Add("QBits", 114)         -- returned ingredients for a potion of Pure Speed
		evt.Add("Inventory", 265)         -- "Pure Speed"
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
		evt.SetNPCTopic{NPC = 88, Index = 2, Event = 0}         -- "Thistle"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Quest"
evt.CanShowTopic[182] = function()
	return not evt.Cmp("QBits", 112)         -- Found Idol of the Snake
end

evt.global[182] = function()
	evt.SetMessage(627)         -- "I believe I may know how to stop the destructive force of the mountain of fire!  I have found an ancient spell that should give me the power to send the mountain of fire back into the sea! To complete the spell I need an ancient relic called the Idol of the Snake.  With this item of power I should be able to complete the spell."
	evt.Add("QBits", 111)         -- "Bring Hiss on the Dagger Wound Islands the Idol of the Snake from the Abandoned Temple."
	evt.SetNPCTopic{NPC = 89, Index = 0, Event = 183}         -- "Hiss" : "Do you have the Idol?"
end

-- "Do you have the Idol?"
evt.global[183] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 630) then         -- "Idol of the Snake"
		evt.SetMessage(628)         -- "Thank you for returning with the Idol.  Upon further study I discovered that the entire spell was useless.  Still, this is not your fault and you deserve some reward for returning to me!"
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 630)         -- "Idol of the Snake"
		evt.Add("Experience", 7500)
		evt.ForPlayer(0)
		evt.Add("Gold", 2000)
		evt.ForPlayer("All")
		evt.Subtract("QBits", 111)         -- "Bring Hiss on the Dagger Wound Islands the Idol of the Snake from the Abandoned Temple."
		evt.Add("QBits", 112)         -- Found Idol of the Snake
		evt.Add("Awards", 51)         -- "Recovered Idol of the Snake for Hiss of Blood Drop village."
		evt.SetNPCTopic{NPC = 89, Index = 0, Event = 0}         -- "Hiss"
	else
		evt.SetMessage(746)         -- "Where is the Idol?  Do not waste my time unless you have it!"
	end
end

-- "Quest"
evt.global[184] = function()
	evt.SetMessage(629)         -- "The packs of Dire Wolves that roam this region are a threat to travelers and commerce.  The Merchants of Alvar have instructed me to hire competent people to hunt down these wolves and to ""thin the pack"" in their words.  You look like skilled adventurers!  I will reward you well if you can eliminate the entire pack and those in their lair."
	evt.Add("QBits", 139)         -- "Kill all Dire Wolves in Ravenshore. Return to Maddigan in Ravenshore."
	evt.SetNPCTopic{NPC = 91, Index = 0, Event = 186}         -- "Maddigan the Tracker" : "Finally!"
end

-- "Dire Wolf Pelts"
evt.global[185] = function()
	evt.SetMessage(630)         -- "I pay 250 gold for every intact Dire Wolf Pelt that you return to me."
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 633) then         -- "Dire Wolf Pelt"
		evt.ForPlayer(0)
		evt.Add("Gold", 250)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 633)         -- "Dire Wolf Pelt"
	else
		evt.SetMessage(754)         -- "You have no more pelts, return when you have more!"
	end
end

-- "Finally!"
evt.CanShowTopic[186] = function()
	return evt.Cmp("QBits", 140)         -- Killed all Dire Wolves in Ravenshore
end

evt.global[186] = function()
	evt.SetMessage(753)         -- "You have killed all of the dire wolves in the region!  Travelers are once again safe. However, I now find myself in need of a new business!"
	evt.Add("Gold", 2500)
	evt.ForPlayer("All")
	evt.Add("Experience", 7500)
	evt.Subtract("QBits", 139)         -- "Kill all Dire Wolves in Ravenshore. Return to Maddigan in Ravenshore."
	evt.Add("Awards", 60)         -- "Killed all of the Dire Wolves in the Ravenshore area."
	evt.SetNPCTopic{NPC = 91, Index = 0, Event = 0}         -- "Maddigan the Tracker"
end

-- "Quest"
evt.global[187] = function()
	if evt.Cmp("QBits", 120) then         -- Rescued Smuggler Leader's Familly 
		evt.SetMessage(755)         -- "My family returned and told me of how you rescued them.  Tell the Merchants of Alvar, that they no longer need rely upon our ""bargain.""  I will keep my word to them and to you, my boats will always be at your service!"
		evt.Subtract("QBits", 120)         -- Rescued Smuggler Leader's Familly 
		evt.ForPlayer("All")
		evt.Add("Experience", 15000)
		evt.Add("Awards", 56)         -- "Rescued Irabelle Hunter from the Ogre Fortress in Alvar."
		evt.ForPlayer(0)
		evt.Add("Gold", 10000)
		evt.SetNPCTopic{NPC = 4, Index = 2, Event = 0}         -- "Arion Hunter"
	else
		evt.SetMessage(632)         -- "The Merchants of Alvar took my family into what they termed ""protective custody"" and use this as the means to secure my services. However as the caravan with my family was returning to Alvar, they were attacked by Ogres and bandits.  The Ogre Zog, took my family from them!  He took them to his fortress in the Alvar region.  Now, I am to spy on the Merchants of Alvar for him.  As long as I do so, my family lives.  If I stop, they die.  Can you rescue them for me?"
		evt.Add("QBits", 119)         -- "Rescue Arion Hunter's daughter from Ogre Fortress in Alvar."
	end
end

-- "Quest"
evt.CanShowTopic[188] = function()
	return not evt.Cmp("QBits", 118)         -- Delivered false report to Stanley
end

evt.global[188] = function()
	evt.SetMessage(633)         -- "I send periodic reports of the activities of the Merchants of Alvar to the Dread Pirate Stanley in the tavern, The Pirate's Rest on the Island of Regna. Now that the Merchants have ""bargained"" for my assistance, we must deliver a false set of reports to keep Stanley from being suspicious.  Take this report to him in Harecksburg on the island of Regna!"
	evt.Add("QBits", 117)         -- "Deliver fake report to the Dread Pirate Stanley in the Pirate's Rest Tavern on the Island of Regna."
	evt.Add("QBits", 282)         -- False Report - I lost it!
	evt.Add("Inventory", 602)         -- "False Report"
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 189}         -- "Arion Hunter" : "Report has been delivered?"
end

-- "Report has been delivered?"
evt.CanShowTopic[189] = function()
	return evt.Cmp("QBits", 118)         -- Delivered false report to Stanley
end

evt.global[189] = function()
	evt.SetMessage(634)         -- "You delivered the report to Stanley?  This is will at least buy us sometime before he becomes suspicious of the activities here in Ravenshore and those of the Merchants in Alvar."
	evt.ForPlayer("All")
	evt.Add("Experience", 10000)
	evt.SetNPCTopic{NPC = 4, Index = 1, Event = 299}         -- "Arion Hunter" : "Fate of Jadame"
end

-- "Anointed Herb Potion"
evt.CanShowTopic[190] = function()
	return evt.Cmp("QBits", 109)         -- "Find and return an Anointed Potion to Languid in the Dagger Wound Islands."
end

evt.global[190] = function()
	evt.SetMessage(635)         -- "I hear that you are looking for an Anointed Herb potion to purify the water supply.  The Smugglers of Jadame deal with all kind of strange goods.  If anyone would know about or have this anointed herb potion, it would be them!"
end

-- "Naga Hides"
evt.global[191] = function()
	evt.SetMessage(636)         -- "The Dark Elves of Alvar pay well for leather made from Naga Hides. Once treated and tanned, the Naga Hides can last almost longer than a Dark Elf's lifetime! "
end

-- "500 Gold!"
evt.global[192] = function()
	evt.SetMessage(637)         -- "I will pay you 500 gold for each Naga Hide you bring."
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 632) then         -- "Naga Hide"
		evt.Subtract("Inventory", 632)         -- "Naga Hide"
		evt.ForPlayer(0)
		evt.Add("Gold", 500)
	else
		evt.SetMessage(756)         -- "You do not have any Naga Hides!  You waste my time!"
	end
end

-- "Quest"
evt.CanShowTopic[193] = function()
	return not evt.Cmp("QBits", 128)         -- Recovered the the Shield, Eclipse for Lathius
end

evt.global[193] = function()
	evt.SetMessage(638)         -- "Many decades ago, the legendary Priest of the Sun, Camien Thryce, led a crusade against the Necromancers' Guild in Shadowspire.  The Guild was able to defeat Thryce's forces with the aid of the Vampires that also dwell in the Shadowspire region.  Camien Thryce carried with him the clerical artifact called Eclipse with him into battle.  The shield was lost when Thryce was struck down by a Nosferatu in the final battle."
	evt.Add("QBits", 127)         -- "Recover the shield, Eclipse, for Lathius in Ravenshore."
	evt.SetNPCTopic{NPC = 98, Index = 0, Event = 194}         -- "Lathius" : "Eclipse"
end

-- "Eclipse"
evt.global[194] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 516) then         -- "Eclipse"
		evt.SetMessage(639)         -- "You have recovered the shield, Eclipse?  The Temple is grateful for you help in recovering this potent artifact.  Please, continue to carry the shield with our blessing."
		evt.ForPlayer("All")
		evt.Add("Experience", 25000)
		evt.ForPlayer(0)
		evt.Add("Gold", 2000)
		evt.ForPlayer("All")
		evt.Subtract("QBits", 127)         -- "Recover the shield, Eclipse, for Lathius in Ravenshore."
		evt.Subtract("QBits", 283)         -- Eclipse - I lost it!
		evt.Add("QBits", 128)         -- Recovered the the Shield, Eclipse for Lathius
		evt.Add("Awards", 55)         -- "Found the shield Eclipse."
		evt.SetNPCTopic{NPC = 98, Index = 0, Event = 703}         -- "Lathius" : "Use Eclipse well!"
	else
		evt.SetMessage(757)         -- "Where is Eclipse?  Return to me when you have found the shield!"
	end
end

-- "Delicacy"
evt.global[195] = function()
	evt.SetMessage(766)         -- "Royal Wasp Jelly is a delicacy!  The upper caste of Merchants enjoys this tasty treat with almost every meal!"
end

-- "1000 Gold!"
evt.global[196] = function()
	evt.SetMessage(767)         -- "I pay 1000 gold for Royal Wasp Jelly!"
end

-- "Royal Wasp Jelly"
evt.global[197] = function()
	evt.SetMessage(768)         -- ""
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 635) then         -- "Royal Wasp Jelly"
		evt.ForPlayer(0)
		evt.Add("Gold", 1000)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 635)         -- "Royal Wasp Jelly"
	else
		evt.SetMessage(769)         -- "Return when you have Wasp Jelly and then I will pay you!"
	end
end

-- "Quest"
evt.global[198] = function()
	if evt.Cmp("QBits", 130) then         -- Killed all Ogres in Alvar canyon area and in Ogre Fortress
		evt.SetMessage(645)         -- "Excellent!  Now that the Ogres are cleared from the roads and no longer inhabit the fortress, the roads to Ravenshore, Ironsand and Murmurwoods are safe again!  Please take this 5000 gold as reward!"
		evt.ForPlayer(0)
		evt.Add("Gold", 5000)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 53)         -- "Killed all of the Ogres in the Alvar region."
		evt.Subtract("QBits", 129)         -- "Kill all Ogres in the Alvar canyon area and in Ogre Fortress and return to Keldon in Alvar."
		evt.SetNPCTopic{NPC = 123, Index = 0, Event = 200}         -- "Keldon" : "It's safe to travel again!"
	elseif evt.Cmp("QBits", 129) then         -- "Kill all Ogres in the Alvar canyon area and in Ogre Fortress and return to Keldon in Alvar."
		evt.SetMessage(644)         -- "You have not defeated all of the Ogres!  The roads will not be safe until they are destroyed!"
	else
		evt.SetMessage(643)         -- "The forces of the Ogre Mage, Zog moved into this area right around the time that the bright flash traveled across the night sky.  They harass and even kill travelers who seek to reach the city of Alvar. It would be of great service to Alvar if you were to eliminate all of the Ogres that harass the roads to Alvar and the Ogres in the fortress near the city of Alvar.  Return to me when you have killed all of the ogres in this region, and I will reward you."
		evt.Add("QBits", 129)         -- "Kill all Ogres in the Alvar canyon area and in Ogre Fortress and return to Keldon in Alvar."
	end
end

-- "Bounty for Ogre Ears"
evt.global[199] = function()
	evt.SetMessage(758)         -- "I pay 500 gold for Ogre Ears.  The Merchant Guild of Alvar supports me in paying this bounty to anyone who can kill and ogre."
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 653) then         -- "Ogre Ear"
		evt.ForPlayer(0)
		evt.Add("Gold", 500)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 653)         -- "Ogre Ear"
	else
		evt.SetMessage(759)         -- "Return to me with Ogre ears if you wish to be paid!"
	end
end

-- "It's safe to travel again!"
evt.global[200] = function()
	evt.SetMessage(942)         -- "Excellent!  Now that the Ogres are cleared from the roads and no longer inhabit the fortress, the roads to Ravenshore, Ironsand and Murmurwoods are safe again!  "
end

-- "Potion of Pure Luck"
evt.CanShowTopic[201] = function()
	return not evt.Cmp("QBits", 115)         -- "Bring Rihansi in Alvar the basic ingredients for a potion of Pure Luck."
end

evt.global[201] = function()
	evt.SetMessage(646)         -- "A Potion of Pure Luck would be of great assistance to any merchant.  One could stumble upon any number of great deals if his Luck was at its highest!  Bring me the basic ingredients for a Potion of Pure Luck and I will reward you well!"
	evt.Add("QBits", 115)         -- "Bring Rihansi in Alvar the basic ingredients for a potion of Pure Luck."
	evt.SetNPCTopic{NPC = 99, Index = 0, Event = 0}         -- "Rihansi"
end

-- "Ingredients"
evt.global[202] = function()
	evt.SetMessage(747)         -- "Black Potions are made of a complex blending of many of the three basic alchemical reagents. Red reagents include Widowsweep Berries, Wolf's Eye, and Phials of Gog Blood.  Some blue reagents are Phoenix Feather, Phima Root, Meteor Fragment and Will O' Wisps Heart.  And some yellow reagents are Datura, Dragon Turtle Fang, Poppy Pods and Thornbark."
end

-- "Do you have the Ingredients?"
evt.CanShowTopic[203] = function()
	return evt.Cmp("QBits", 115)         -- "Bring Rihansi in Alvar the basic ingredients for a potion of Pure Luck."
end

evt.global[203] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 2} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 3} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 3} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(648)         -- "Excellent!  With this I can brew another Potion of Pure Luck.  Take this potion as your reward!"
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 2}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 3}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 3}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 115)         -- "Bring Rihansi in Alvar the basic ingredients for a potion of Pure Luck."
		evt.Add("QBits", 116)         -- returned ingredients for a potion of Pure Luck
		evt.Add("Inventory", 264)         -- "Pure Luck"
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 99, Index = 2, Event = 0}         -- "Rihansi"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Wasp Stingers"
evt.global[204] = function()
	evt.SetMessage(649)         -- "Wasp stingers!  From cold remedies to herbal teas, a little bit of ground wasp stinger goes a long way!  Don't trust those who sell that weak ground wyvern horn!  Only wasp stinger will do if you want the best!  I'll pay you for every stinger you bring me!"
end

-- "500 Gold!"
evt.global[205] = function()
	evt.SetMessage(650)         -- "I pay 500 gold for every wasp stinger you bring me!"
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 654) then         -- "Wasp Stingers"
		evt.ForPlayer(0)
		evt.Add("Gold", 500)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 654)         -- "Wasp Stingers"
	else
		evt.SetMessage(760)         -- "I only pay for Wasp Stingers!  Nothing more, nothing less!"
	end
end

-- "Survival!"
evt.global[206] = function()
	evt.SetMessage(651)         -- "Trolls have a natural fear of fire!  Many of us perished when the Gate of Fire opened and spilled out the lake of fire! Without appropriate protection, there was nothing we could do."
end

-- "Quest"
evt.CanShowTopic[207] = function()
	return not evt.Cmp("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
end

evt.global[207] = function()
	evt.SetMessage(652)         -- "The survivors in this region need Potions of Fire Resistance!  With them we can survive until a place is found for us to move to!  Take these potions!  Unfortunately they are all I have!  Deliver them to the six southernmost houses that remain standing in the village of Rust!"
	evt.Add("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
	evt.Add("Inventory", 256)         -- "Fire Resistance"
	evt.Add("Inventory", 256)         -- "Fire Resistance"
	evt.Add("Inventory", 256)         -- "Fire Resistance"
	evt.SetNPCTopic{NPC = 186, Index = 1, Event = 208}         -- "Pole" : "Not enough potions?"
end

-- "Not enough potions?"
evt.global[208] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
		evt.ForPlayer(0)
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Add("Awards", 52)         -- "Brought Potions of Fire Resistance to the southern houses of Rust."
		evt.Subtract("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
		evt.SetNPCTopic{NPC = 186, Index = 1, Event = 209}         --[[ "Pole" : "The village can hold 
its own." ]]
	else
		evt.SetMessage(653)         -- "You have not delivered Potions of Fire Resistance to all of the houses!  If the lake of fire grows in size everyone will perish!"
	end
end

--[[ "The village can hold 
its own." ]]
evt.global[209] = function()
	evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
end

-- "Potion of Pure Endurance"
evt.CanShowTopic[210] = function()
	return not evt.Cmp("QBits", 121)         -- "Bring Talion in the Ironsand Desert the basic ingredients for a potion of Pure Endurance."
end

evt.global[210] = function()
	evt.SetMessage(655)         -- "Endurance.  That ability which keeps a warrior on his feet, or lets him down gently as he slides into unconsciousness.  A Potion of Pure Endurance can boost a person's ability to take damage to a legendary strength!  Bring me the basic ingredients of a Potion of Pure Endurance and I will reward you well."
	evt.Add("QBits", 121)         -- "Bring Talion in the Ironsand Desert the basic ingredients for a potion of Pure Endurance."
	evt.SetNPCTopic{NPC = 160, Index = 0, Event = 212}         -- "Talion" : "Do you have the Ingredients?"
end

-- "Ingredients"
evt.global[211] = function()
	evt.SetMessage(747)         -- "Black Potions are made of a complex blending of many of the three basic alchemical reagents. Red reagents include Widowsweep Berries, Wolf's Eye, and Phials of Gog Blood.  Some blue reagents are Phoenix Feather, Phima Root, Meteor Fragment and Will O' Wisps Heart.  And some yellow reagents are Datura, Dragon Turtle Fang, Poppy Pods and Thornbark."
end

-- "Do you have the Ingredients?"
evt.CanShowTopic[212] = function()
	return evt.Cmp("QBits", 121)         -- "Bring Talion in the Ironsand Desert the basic ingredients for a potion of Pure Endurance."
end

evt.global[212] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 2} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 4} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 1} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(648)         -- "Excellent!  With this I can brew another Potion of Pure Luck.  Take this potion as your reward!"
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 2}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 4}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 1}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 121)         -- "Bring Talion in the Ironsand Desert the basic ingredients for a potion of Pure Endurance."
		evt.Add("QBits", 122)         -- returned ingredients for a potion of Pure Endurance
		evt.Add("Inventory", 267)         -- "Pure Endurance"
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 160, Index = 2, Event = 0}         -- "Talion"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Quest"
evt.CanShowTopic[213] = function()
	return not evt.Cmp("QBits", 22)         -- Allied with Dragons. Return Dragon Egg to Dragons done.
end

evt.global[213] = function()
	evt.SetMessage(658)         -- "The Dragonbane Flower has many medicinal uses.  It also has some uses that are less than medicinal.  From this flower we can distill a poison that is deadly to Dragons.  With it we should be able to make quick work of the Dragon vermin that infest this region.  Find this flower and return to me with it.  You will not be disappointed by my reward."
	evt.Add("QBits", 150)         -- "Find a Dragonbane Flower for Calindril in Garrote Gorge."
	evt.SetNPCTopic{NPC = 231, Index = 0, Event = 214}         -- "Calindril" : "Poison!"
end

-- "Poison!"
evt.global[214] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 636) then         -- "Dragonbane Flower"
		evt.Add("QBits", 151)         -- Found Dragonbane for Dragon Hunters
		evt.Subtract("QBits", 150)         -- "Find a Dragonbane Flower for Calindril in Garrote Gorge."
		evt.Subtract("Inventory", 636)         -- "Dragonbane Flower"
		evt.ForPlayer(0)
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 57)         -- "Found the Dragonbane flower for Calindril in the Garrote Gorge Dragon Hunter's Fort."
		evt.SetMessage(771)         -- "The Dragons of Garrote Gorge are susceptible to a poison that can be distilled from the rare dragonbane flower.  The flower also is the only means of an antidote for the Dragons."
		evt.SetNPCTopic{NPC = 231, Index = 0, Event = 215}         -- "Calindril" : "Thanks for your help!"
	else
		evt.SetMessage(659)         -- "I asked for the Dragonbane Flower and you return empty handed.  Why waste my time?"
	end
end

-- "Thanks for your help!"
evt.global[215] = function()
	evt.SetMessage(660)         -- "Yes, this is indeed the Dragonbane Flower.  Once we have distilled the poison, we will wipe the Dragon population out!"
end

-- "Quest"
evt.CanShowTopic[216] = function()
	return not evt.Cmp("QBits", 21)         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
end

evt.global[216] = function()
	evt.SetMessage(661)         -- "The Dragonbane Flower has many medicinal uses.  It also has some uses that are less than medicinal.  From this flower a poison is made that is deadly to dragons, but the poison's antidote is also found in its petals. Find this flower and return to me with it.  You will not be disappointed by my reward."
	evt.Add("QBits", 152)         -- "Find a Dragonbane Flower for the Balion Tearwing in the Garrote Gorge Dragon Caves."
	evt.SetNPCTopic{NPC = 239, Index = 0, Event = 217}         -- "Balion Tearwing" : "Poison!"
end

-- "Poison!"
evt.global[217] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 636) then         -- "Dragonbane Flower"
		evt.Add("QBits", 153)         -- Found Dragonbane for Dragons
		evt.Subtract("QBits", 152)         -- "Find a Dragonbane Flower for the Balion Tearwing in the Garrote Gorge Dragon Caves."
		evt.Subtract("Inventory", 636)         -- "Dragonbane Flower"
		evt.ForPlayer(0)
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Add("Experience", 10000)
		evt.Add("Awards", 58)         -- "Found the Dragonbane flower for Balion Tearwing in Garrote Gorge."
		evt.SetMessage(771)         -- "The Dragons of Garrote Gorge are susceptible to a poison that can be distilled from the rare dragonbane flower.  The flower also is the only means of an antidote for the Dragons."
		evt.SetNPCTopic{NPC = 239, Index = 0, Event = 218}         -- "Balion Tearwing" : "Thanks for your help!"
	else
		evt.SetMessage(662)         -- "I asked for the Dragonbane Flower and you return empty handed.  Why waste my time?"
	end
end

-- "Thanks for your help!"
evt.global[218] = function()
	evt.SetMessage(663)         -- "Yes, this is indeed the Dragonbane Flower.  Once the petals are ingested we will be protected from the poison that the Dragon Hunter's would use against us.  "
end

-- "Quest"
evt.CanShowTopic[219] = function()
	return not evt.Cmp("QBits", 22)         -- Allied with Dragons. Return Dragon Egg to Dragons done.
end

evt.global[219] = function()
	if evt.Cmp("QBits", 155) then         -- Killed all Dragons in Garrote Gorge Area
		evt.Subtract("QBits", 154)         -- "Kill all the Dragons in the Garrote Gorge wilderness area. Return to Avalon in Garrote Gorge."
		evt.SetMessage(772)         -- "With all of the Dragons in the wilderness defeated, we can move on the Dragon Cave and eliminate the Dragons once and for all!  Thanks again for your help in defeating them."
		evt.Add("Gold", 2500)
		evt.ForPlayer("All")
		evt.Add("Experience", 20000)
		evt.Add("Awards", 62)         -- "Killed all of the Dragons in the Garrote Gorge area for Avalon in the Garrote Gorge Dragon Hunter's Fort."
		evt.SetNPCTopic{NPC = 240, Index = 0, Event = 220}         -- "Avalon" : "At last!"
	elseif evt.Cmp("QBits", 154) then         -- "Kill all the Dragons in the Garrote Gorge wilderness area. Return to Avalon in Garrote Gorge."
		evt.SetMessage(532)         -- "You have not slain all of the vermin.  I have reports here that tell of Dragons still in the region.  Return when you have slain them all!"
	else
		evt.SetMessage(664)         -- "You seek to gain the favor of Charles Quixote?  Help us in his crusade against the Dragons of Garrote Gorge. If all of the Dragons in the region and in the Dragon Cave are slain, Charles Quixote will be sure to hear of your name! Return to me when they are all dead!  I will reward you well."
		evt.Add("QBits", 154)         -- "Kill all the Dragons in the Garrote Gorge wilderness area. Return to Avalon in Garrote Gorge."
	end
end

-- "At last!"
evt.global[220] = function()
	evt.SetMessage(665)         -- "You have slain the vermin!  Here is the reward that I promised!  I will also personally mention your assistance to Charles Quixote!"
end

-- "Quest"
evt.CanShowTopic[221] = function()
	return not evt.Cmp("QBits", 21)         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
end

evt.global[221] = function()
	if evt.Cmp("QBits", 158) then         -- Killed all Dragon Hunters in Garrote Gorge wilderness area
		evt.SetMessage(773)         -- "With all of the Dragon hunters in the wilderness defeated, we can move on their camp and eliminate them once and for all!  Thanks again for your help in defeating them."
		evt.Add("Gold", 2500)
		evt.ForPlayer("All")
		evt.Add("Experience", 20000)
		evt.Add("Awards", 63)         -- "Killed all of the Dragon Hunters in the Garrote Gorge are for Jerin Flame-eye in the Dragon Cave of Garrote Gorge."
		evt.Subtract("QBits", 157)         -- "Kill all the Dragon Hunter's in the Garrote Gorge wilderness area. Return to Jerin Flame-eye in the Garrote Gorge Dragon Caves."
		evt.SetNPCTopic{NPC = 273, Index = 0, Event = 222}         -- "Jerin Flame-eye" : "Land is ours yet again!"
	elseif evt.Cmp("QBits", 157) then         -- "Kill all the Dragon Hunter's in the Garrote Gorge wilderness area. Return to Jerin Flame-eye in the Garrote Gorge Dragon Caves."
		evt.SetMessage(533)         -- "You have not slain all of the Dragon hunters.  A Flight returned just moments ago and reported seeing them out on the plains.  Return when you have slain them all!"
	else
		evt.SetMessage(666)         -- "You seek the favor of Deftclaw Redreaver?  Don't we all?  If you were to kill all of the Dragon hunters in the Garrote Gorge wilderness, I would be certain to mention you to him.  I would also be in the position to offer you a generous reward!"
		evt.Add("QBits", 157)         -- "Kill all the Dragon Hunter's in the Garrote Gorge wilderness area. Return to Jerin Flame-eye in the Garrote Gorge Dragon Caves."
	end
end

-- "Land is ours yet again!"
evt.global[222] = function()
	evt.SetMessage(667)         -- "The infernal dragon hunters of Charles Quixote are dead? Fantastic!  We can once again enjoy the peace of Garrote Gorge without fear.  Here is your promised reward!  I will go speak with Deftclaw Redreaver of your bravery this instant!"
end

-- "Quest"
evt.global[223] = function()
	evt.SetMessage(668)         -- "The Drum of Victory needs to be recovered if we are to ever defeat the Dragons in this region.  If you were to recover the Drum I would reward you well!"
	evt.Add("QBits", 160)         -- "Find the Legendary Drum of Victory. Return it to Zelim in Garrote Gorge."
	evt.SetNPCTopic{NPC = 274, Index = 0, Event = 225}         -- "Zelim" : "Where is the drum?"
end

-- "Drum of Victory History"
evt.global[224] = function()
	evt.SetMessage(669)         -- "The Drum of Victory was brought here by Charles Quixote.  Its deafening sound drives terror into the heart of any Dragon who hears it.  Unfortunately is was lost in a battle against the Nagas when Charles Quixote was trying to establish his keep, here in Garrote Gorge."
end

-- "Where is the drum?"
evt.global[225] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 615) then         -- "Drum of Victory"
		evt.SetMessage(670)         -- "You have returned with the Drum of Victory!  Charles will be grateful for its return!  Here is your promised reward."
		evt.ForPlayer(0)
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Subtract("QBits", 160)         -- "Find the Legendary Drum of Victory. Return it to Zelim in Garrote Gorge."
		evt.Subtract("QBits", 246)         -- Drum of Victory - I lost it!
		evt.Subtract("Inventory", 615)         -- "Drum of Victory"
		evt.Add("Experience", 20000)
		evt.SetNPCTopic{NPC = 274, Index = 0, Event = 0}         -- "Zelim"
	else
		evt.SetMessage(774)         -- "Return when you have the Drum of Victory.  You waste your time and mine otherwise!"
	end
end

-- "Quest"
evt.global[226] = function()
	evt.SetMessage(671)         -- "For years the Guild of Necromancers has searched for the Bone of Doom.  The powerful artifact would be of great use to them if recovered.  If you were to find this item and bring it to me, you will be rewarded beyond your wildest dreams."
	evt.Add("QBits", 166)         -- "Find the Bone of Doom for Tantilion of Shadowspire."
	evt.SetNPCTopic{NPC = 275, Index = 0, Event = 228}         -- "Tantilion" : "Great!"
end

-- "Bone History"
evt.global[227] = function()
	evt.SetMessage(672)         -- "In times almost forgotten a powerful Necromancer named Zacharia almost dominated all of Jadame.  His mastery of the dark arts of necromancy and the elemental magics were combined with an unnaturally strong afinity for Dark energy. His legions of undead helped him enslave all peoples, including the Dark Elves of Alvar.  A plan was made by the Temple of the Sun to defeat Zacharia.  Utilizing the combined might of all of the Clerics in the Temple they forged the sword named Solkrist.  The Patriarch of the Temple led the legions of the Sun against the forces of Zacharia.  The battle raged for years after which the forces of the Temple of the Sun found themselves at the base of the dreaded Shadowspire.  There the Patriarch battled Zarcharia in single combat. At the end of the battle both the Patriarch and Zacharia lay dead.  The Patriarch had cut the left arm from Zacharia's body just as the Necromancer's last spell stopped the Patriarch's heart.  The power of the sword Solkrist instantly slew the Necromancer.  Solkrist disappeared forever in the mayhem after the fight, as did the arm of Zacharia.  The bone from this arm was so instilled with such Dark Magic that it was called the Bone of Doom."
end

-- "Great!"
evt.global[228] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 637) then         -- "Bone of Doom"
		evt.SetMessage(673)         -- "Ah, the Bone of Doom!  The legend of Zacharia will continue!  Here is your reward!"
		evt.Add("Gold", 1500)
		evt.Subtract("QBits", 166)         -- "Find the Bone of Doom for Tantilion of Shadowspire."
		evt.Subtract("QBits", 247)         -- Bone of Doom - I lost it!
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 637)         -- "Bone of Doom"
		evt.Add("Experience", 7500)
		evt.ForPlayer(0)
		evt.Add("Gold", 7500)
		evt.SetNPCTopic{NPC = 275, Index = 0, Event = 0}         -- "Tantilion"
	else
		evt.SetMessage(775)         -- "I ask for the Bone, and you return with nothing. Be gone!"
	end
end

-- "Quest"
evt.global[229] = function()
	evt.SetMessage(674)         -- "Some say that Iseldir's Puzzle Box is cursed and that use of it will make the owner go slowly mad.  This can't be true!  All of my studies have provided me with enough proof to determine that the box is the ultimate game in Jadame--not that ridiculous card game, Arcomage.  The last reported owner of Iseldir's Puzzle Box was Zanthora, who is also known as the Mad Necromancer of Shadowspire."
	evt.Add("QBits", 162)         -- "Find Iseldir's Puzzle Box for Benefice of Shadowspire."
	evt.SetNPCTopic{NPC = 276, Index = 0, Event = 231}         -- "Benefice" : "Hours of Enjoyment!"
end

-- "Puzzle History"
evt.global[230] = function()
	evt.SetMessage(675)         -- "I ask you to recover the Puzzle Box and you return with nothing.  So you reward is nothing.  Return with the box!"
end

-- "Hours of Enjoyment!"
evt.global[231] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 613) then         -- "Puzzle Box"
		evt.SetMessage(676)         -- "The Puzzle Box is mine!  Hours of mindless enjoyment at my finger tips!  Here, take you reward for it is nothing compared to the box!"
		evt.Add("Gold", 1500)
		evt.Subtract("QBits", 162)         -- "Find Iseldir's Puzzle Box for Benefice of Shadowspire."
		evt.Subtract("QBits", 249)         -- Puzzle Box - I lost it!
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 613)         -- "Puzzle Box"
		evt.Add("Experience", 15000)
		evt.SetNPCTopic{NPC = 276, Index = 0, Event = 0}         -- "Benefice"
	else
		evt.SetMessage(776)         -- "I need not see you again until you have the Puzzle Box!"
	end
end

-- "Potion of Pure Intellect"
evt.CanShowTopic[232] = function()
	return not evt.Cmp("QBits", 123)         -- "Bring Kelvin in Shadowspire the basic ingredients for a potion of Pure Intellect."
end

evt.global[232] = function()
	evt.SetMessage(677)         -- "A Necromancer's greatest ability is his Intellect!  Without sufficient Intellect, a Necromancer can find himself without spell points when he needs them most! If you bring me the basic ingredients of a Potion of Pure Intellect, I will reward you with the potion that I create!"
	evt.Add("QBits", 123)         -- "Bring Kelvin in Shadowspire the basic ingredients for a potion of Pure Intellect."
	evt.SetNPCTopic{NPC = 185, Index = 0, Event = 0}         -- "Kelvin"
end

-- "War between the Guild and Temple"
evt.global[233] = function()
	evt.SetMessage(885)         -- "Centuries ago the largest battle to date between the Guild of Necromancers and the Temple of the Sun was fought on this spot!  So much magical energy was released that the very ground was scorched and is black to this very day!"
end

-- "Do you have the Ingredients?"
evt.CanShowTopic[234] = function()
	return evt.Cmp("QBits", 123)         -- "Bring Kelvin in Shadowspire the basic ingredients for a potion of Pure Intellect."
end

evt.global[234] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 1} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 2} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 4} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(679)         -- "You have returned with the ingredients, holding up you end of the bargain.  Here is your Potion of Pure Intellect."
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 1}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 2}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 4}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 123)         -- "Bring Kelvin in Shadowspire the basic ingredients for a potion of Pure Intellect."
		evt.Add("QBits", 124)         -- returned ingredients for a potion of Pure Intellect
		evt.Add("Inventory", 266)         -- "Pure Intellect"
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 185, Index = 2, Event = 0}         -- "Kelvin"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Quest"
evt.global[235] = function()
	evt.SetMessage(680)         -- "We seek to put to rest the soul of the Nosferatu called Korbu.  We have heard rumors that the vampires of Shadowspire seek to resurrect this ancient evil.  There is a Vial of Grave Dirt kept hidden in the Vampire Crypt in the region of Shadowspire that is instrumental in bringing Korbu back to life.  Find us this vial and return it to us.  We will always be in your debt and we will reward you well."
	evt.Add("QBits", 164)         -- "Find a Vial of Grave Dirt. Return it to Halien in Shadowspire."
	evt.SetNPCTopic{NPC = 277, Index = 0, Event = 237}         -- "Hallien" : "Do you have the vial?"
end

-- "Vial of Grave Dirt"
evt.global[236] = function()
	evt.SetMessage(681)         -- "Korbu scattered vials of the dirt from his original grave to safe guard himself.  This way he could always gain access to the dirt and move his crypt if he needed to."
end

-- "Do you have the vial?"
evt.global[237] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 614) then         -- "Vial of Grave Earth"
		evt.SetMessage(682)         -- "Ah, once we perform the Rites of Purification upon this dirt, Korbu will rest eternally.  We are in your debt and here is your reward as promised!"
		evt.ForPlayer(0)
		evt.Add("Gold", 1500)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 614)         -- "Vial of Grave Earth"
		evt.Subtract("QBits", 164)         -- "Find a Vial of Grave Dirt. Return it to Halien in Shadowspire."
		evt.Subtract("QBits", 248)         -- Vial of Grave Dirt - I lost it!
		evt.Add("Experience", 22000)
		evt.SetNPCTopic{NPC = 277, Index = 0, Event = 0}         -- "Hallien"
	else
		evt.SetMessage(936)         -- "Where is the Vial of Grave Dirt?  Do not bother me until you have it!"
	end
end

-- "Potion of Pure Personality"
evt.CanShowTopic[238] = function()
	return not evt.Cmp("QBits", 125)         -- "Bring Castigeir in Murmurwoods the basic ingredients for a potion of Pure Personality."
end

evt.global[238] = function()
	evt.SetMessage(683)         -- "Personality--the cleric's truest strength.  If you were to provide me with the basic ingredients of a Potion of Pure Personality, I would be more than happy to brew one for you!  Bring me the ingredients!"
	evt.Add("QBits", 125)         -- "Bring Castigeir in Murmurwoods the basic ingredients for a potion of Pure Personality."
	evt.SetNPCTopic{NPC = 232, Index = 0, Event = 0}         -- "Castigeir"
end

-- "Ingredients"
evt.global[239] = function()
	evt.SetMessage(747)         -- "Black Potions are made of a complex blending of many of the three basic alchemical reagents. Red reagents include Widowsweep Berries, Wolf's Eye, and Phials of Gog Blood.  Some blue reagents are Phoenix Feather, Phima Root, Meteor Fragment and Will O' Wisps Heart.  And some yellow reagents are Datura, Dragon Turtle Fang, Poppy Pods and Thornbark."
end

-- "Thanks for the Ingredients"
evt.CanShowTopic[240] = function()
	return evt.Cmp("QBits", 125)         -- "Bring Castigeir in Murmurwoods the basic ingredients for a potion of Pure Personality."
end

evt.global[240] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 1} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 4} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 2} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(685)         -- "Ah, you learned the recipe or are very lucky!  Here is your potion!"
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 1}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 4}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 2}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 125)         -- "Bring Castigeir in Murmurwoods the basic ingredients for a potion of Pure Personality."
		evt.Add("QBits", 126)         -- returned ingredients for a potion of Pure Personallity
		evt.Add("Inventory", 268)         -- "Pure Personality"
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 232, Index = 2, Event = 0}         -- "Castigeir"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Ancient Wyverns"
evt.global[241] = function()
	evt.SetMessage(686)         -- "Wyverns are one of the toughest creatures that roam the continent of Jadame.  The Ancient Wyvern can even slay the mightiest adventurer with one blow.  The horn of the Ancient Wyvern is said to have many medicinal any magical properties.  There are many people who pay well for ground wyvern horn."
end

-- "Bounty for Horn of the Wyvern"
evt.global[242] = function()
	evt.SetMessage(687)         -- "I will buy Wyvern horns from you for 1500 gold!  I grind these horns up and sell them throughout Jadame.  Someday I hope to be able to ship them over sea to Enroth and Erathia.  That of course depends on whether the Pirates of Regna are still a problem to shipping or not!"
	evt.SetNPCTopic{NPC = 187, Index = 1, Event = 243}         -- "Xevius" : "1500 gold!"
end

-- "1500 gold!"
evt.global[243] = function()
	evt.SetMessage(688)         -- "1500 gold!"
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 640) then         -- "Wyvern Horn"
		evt.ForPlayer(0)
		evt.Add("Gold", 500)
		evt.ForPlayer("All")
		evt.Subtract("Inventory", 640)         -- "Wyvern Horn"
	else
		evt.SetMessage(765)         -- "Return when you have more Wyvern Horns and I will pay you more!"
	end
end

-- "Potion of Pure Accuracy"
evt.CanShowTopic[244] = function()
	return not evt.Cmp("QBits", 133)         -- returned ingredients for a potion of Pure Accuracy
end

evt.global[244] = function()
	evt.SetMessage(689)         -- "Accuracy can determine who lives and who dies in battle.  If you cannot hit your opponent you will surely perish!  If you bring me the ingredients of a Potion of Pure Accuracy, I will brew that potion for you."
	evt.Add("QBits", 133)         -- returned ingredients for a potion of Pure Accuracy
	evt.SetNPCTopic{NPC = 124, Index = 0, Event = 0}         -- "Galvinus"
end

-- "Ingredients"
evt.global[245] = function()
	evt.SetMessage(747)         -- "Black Potions are made of a complex blending of many of the three basic alchemical reagents. Red reagents include Widowsweep Berries, Wolf's Eye, and Phials of Gog Blood.  Some blue reagents are Phoenix Feather, Phima Root, Meteor Fragment and Will O' Wisps Heart.  And some yellow reagents are Datura, Dragon Turtle Fang, Poppy Pods and Thornbark."
end

-- "Do you have the Ingredients?"
evt.CanShowTopic[246] = function()
	return evt.Cmp("QBits", 133)         -- returned ingredients for a potion of Pure Accuracy
end

evt.global[246] = function()
	if not evt.CheckItemsCount{MinItemIndex = 200, MaxItemIndex = 204, Count = 2} then         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif not evt.CheckItemsCount{MinItemIndex = 205, MaxItemIndex = 209, Count = 1} then         -- "Phima Root"..."Dragon Turtle Fang"
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	elseif evt.CheckItemsCount{MinItemIndex = 210, MaxItemIndex = 214, Count = 4} then         -- "Poppy Pod"..."Unicorn Horn"
		evt.SetMessage(691)         -- "Ah, the right ingredients always do the trick! Here is your potion."
		evt.RemoveItems{MinItemIndex = 200, MaxItemIndex = 204, Count = 2}         -- "Widowsweep Berries"..."Phoenix Feather"
		evt.RemoveItems{MinItemIndex = 205, MaxItemIndex = 209, Count = 1}         -- "Phima Root"..."Dragon Turtle Fang"
		evt.RemoveItems{MinItemIndex = 210, MaxItemIndex = 214, Count = 4}         -- "Poppy Pod"..."Unicorn Horn"
		evt.Subtract("QBits", 133)         -- returned ingredients for a potion of Pure Accuracy
		evt.Add("QBits", 134)         -- Gave Gem of Restoration to Blazen Stormlance
		evt.Add("Inventory", 269)         -- "Pure Accuracy"
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.SetNPCTopic{NPC = 124, Index = 2, Event = 0}         -- "Galvinus"
	else
		evt.SetMessage(684)         -- "You are missing all or some of the needed ingredients.  Return when you have them all."
	end
end

-- "Dread Pirate Stanley's Treasure"
evt.global[247] = function()
	evt.SetMessage(692)         -- "The legendary Pirate Stanley is rumored to have stolen hundreds and thousands of gold pieces from the Merchants of Alvar.  No one has ever found where he has hidden his treasure.  Some say it isn't even hidden on the Island of Regna."
end

-- "Riches"
evt.global[248] = function()
	evt.SetMessage(693)         -- "Years and years ago, I remember hearing that Stanley journeyed to Ravage Roaming to speak with the Ogre Mage Zog about a curse that had fallen upon him.  Apparently his memory was fading, and he was certain that an evil mage was responsible."
end

-- "Quest"
evt.global[249] = function()
	if evt.Cmp("QBits", 168) then         -- Found the treasure of the Dread Pirate Stanley!
		evt.Add("Experience", 15500)
		evt.SetMessage(694)         -- "He who finds the treasure of the Dread Pirate Stanley will be a rich person!  Will that person be you?"
		evt.Subtract("QBits", 236)         -- "Find the treasure of the Dread Pirate Stanley."
		evt.SetNPCTopic{NPC = 278, Index = 0, Event = 0}         -- "One-Eye"
	else
		evt.SetMessage(690)         -- "You have not found the treasure of the Dread Pirate Stanley!  "
		evt.Add("QBits", 236)         -- "Find the treasure of the Dread Pirate Stanley."
	end
end

-- "Buy Tobersk Fruit for 200 gold"
evt.CanShowTopic[250] = function()
	if not evt.Cmp("QBits", 252) then         -- Bought Item brandy
		return not evt.Cmp("QBits", 259)         -- Can't keep buying fruit
	end
	return true
end

evt.global[250] = function()
	evt.SetMessage(695)         -- "Tobersk fruit is native only to the Dagger Wound Island region.  Here the mild winters and humid summers provide the perfect conditions for the Tobersk fruit to achieve the correct levels of sugar and juice.  The pulp masters in Ravenshore pay good money for the tobersk fruit."
	evt.Subtract("QBits", 251)         -- Bought Item pulp
	if evt.Cmp("Gold", 200) then
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 643)         -- "Tobersk Fruit"
		evt.Add("QBits", 250)         -- Bought Item fruit
		evt.Add("QBits", 259)         -- Can't keep buying fruit
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Tobersk Brandy"
evt.global[251] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 645) then         -- "Tobersk Brandy"
		evt.SetMessage(696)         -- "Tobersk brandy is favorite drink of the Lizardmen of Dagger Wound Island.  Some call it an acquired taste.  How ever you look at it, it equals pure profit!"
		evt.Subtract("Inventory", 645)         -- "Tobersk Brandy"
		evt.Subtract("QBits", 261)         -- Can't keep buying brandy
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 557)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 589)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 511)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 577)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 513)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 544)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 511)
		end
	end
end

-- "Buy Tobersk Pulp for 300 gold"
evt.CanShowTopic[252] = function()
	if not evt.Cmp("QBits", 250) then         -- Bought Item fruit
		return not evt.Cmp("QBits", 260)         -- Can't keep buying pulp
	end
	return true
end

evt.global[252] = function()
	evt.SetMessage(697)         -- "Tobersk fruit is processed in Ravenshore into tobersk pulp.  Its from this pulp that the master brewers in Alvar distill tobersk brandy."
	evt.Subtract("QBits", 250)         -- Bought Item fruit
	if evt.Cmp("Gold", 300) then
		evt.Subtract("Gold", 300)
		evt.Add("Inventory", 644)         -- "Tobersk Pulp"
		evt.Add("QBits", 251)         -- Bought Item pulp
		evt.Add("QBits", 260)         -- Can't keep buying pulp
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Tobersk Fruit"
evt.global[253] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 643) then         -- "Tobersk Fruit"
		evt.SetMessage(698)         -- "Here the mild winters and humid summers provide the perfect conditions for the tobersk fruit to achieve the correct levels of sugar and juice.  Here you can purchase tobersk fruit so our pulp masters can labor over the fruit, processing it into tobersk pulp."
		evt.Subtract("Inventory", 643)         -- "Tobersk Fruit"
		evt.Subtract("QBits", 259)         -- Can't keep buying fruit
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

-- "Buy Tobersk Brandy 500 gold"
evt.CanShowTopic[254] = function()
	if not evt.Cmp("QBits", 251) then         -- Bought Item pulp
		return not evt.Cmp("QBits", 261)         -- Can't keep buying brandy
	end
	return true
end

evt.global[254] = function()
	evt.SetMessage(699)         -- "Tobersk brandy is a favorite drink among the Lizardmen of Dagger Wound Island.  Some call it an acquired taste.  How ever you look at it, it equals pure profit!  Be gentle with the bottles as you travel back to the islands."
	evt.Subtract("QBits", 251)         -- Bought Item pulp
	if evt.Cmp("Gold", 500) then
		evt.Subtract("Gold", 500)
		evt.Add("Inventory", 645)         -- "Tobersk Brandy"
		evt.Add("QBits", 252)         -- Bought Item brandy
		evt.Add("QBits", 261)         -- Can't keep buying brandy
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Sell Tobersk Pulp"
evt.global[255] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 644) then         -- "Tobersk Pulp"
		evt.SetMessage(700)         -- "Tobersk pulp is combined with the waters of the Alvar River and is distilled over time until the brew masters declare it ready for consumption. "
		evt.Subtract("Inventory", 644)         -- "Tobersk Pulp"
		evt.Subtract("QBits", 260)         -- Can't keep buying pulp
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 394)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 341)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 351)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 337)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 373)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 355)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 386)
		end
	end
end

-- "Buy Heartwood of Jadame for 1000 gold"
evt.CanShowTopic[256] = function()
	if not evt.Cmp("QBits", 255) then         -- Bought Sunfish
		return not evt.Cmp("QBits", 262)         -- Can't keep buying heartwood
	end
	return true
end

evt.global[256] = function()
	evt.SetMessage(701)         -- "The Heartwood of Jadame is used by the vampires of the Shadowspire region in the construction of their coffins.  The Heartwood's durability provides the coffin's owner with many years of rest during the daylight hours."
	evt.Subtract("QBits", 255)         -- Bought Sunfish
	if evt.Cmp("Gold", 1000) then
		evt.Subtract("Gold", 1000)
		evt.Add("Inventory", 646)         -- "Heartwood of Jadame"
		evt.Add("QBits", 253)         -- Bought heartwood
		evt.Add("QBits", 262)         -- Can't keep buying heartwood
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Dried Sunfish"
evt.global[257] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 648) then         -- "Dried Sunfish"
		evt.SetMessage(702)         -- "Dried sunfish is a delicacy enjoyed by the High Clerics of the Temple of the Sun.  They pay good money for deliveries of this flaky, somewhat salty fish."
		evt.Subtract("Inventory", 648)         -- "Dried Sunfish"
		evt.Subtract("QBits", 264)         -- Can't keep buying sinfish
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 2234)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 2267)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 2250)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 2291)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 2244)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 2285)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 2273)
		end
	end
end

-- "Buy Pirate Amulets for 1500 gold"
evt.CanShowTopic[258] = function()
	if not evt.Cmp("QBits", 253) then         -- Bought heartwood
		return not evt.Cmp("QBits", 263)         -- Can't keep buying amulets
	end
	return true
end

evt.global[258] = function()
	evt.SetMessage(703)         -- "The Pirates of Regna like flamboyant jewelry!  Amulets that fail to take enchantments cast by the Necromancers of Shadowspire fill this need quite well.  The Pirates pay some of their ""hard earned"" bounty to get these amulets."
	evt.Subtract("QBits", 253)         -- Bought heartwood
	if evt.Cmp("Gold", 1500) then
		evt.Subtract("Gold", 1500)
		evt.Add("Inventory", 647)         -- "Flawed Amulets"
		evt.Add("QBits", 254)         -- Bought amulets
		evt.Add("QBits", 263)         -- Can't keep buying amulets
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Heartwood of Jadame"
evt.global[259] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 646) then         -- "Heartwood of Jadame"
		evt.SetMessage(704)         -- "The Heartwood of Jadame is used by the Vampires of the Shadowspire region in the construction of their coffins.  The Heartwood's durability provides the coffin's owner with many years of rest during the daylight hours."
		evt.Subtract("Inventory", 646)         -- "Heartwood of Jadame"
		evt.Subtract("QBits", 262)         -- Can't keep buying heartwood
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 1761)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 1786)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 1637)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 1655)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 1794)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 1773)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 1744)
		end
	end
end

-- "Buy Dried Sunfish for 2000 gold"
evt.CanShowTopic[260] = function()
	if not evt.Cmp("QBits", 254) then         -- Bought amulets
		return not evt.Cmp("QBits", 264)         -- Can't keep buying sinfish
	end
	return true
end

evt.global[260] = function()
	evt.SetMessage(705)         -- "Dried Sunfish is a delicacy enjoyed by the High Clerics of the Temple of the Sun.  They pay good money for deliveries of this flaky, somewhat salty fish."
	evt.Subtract("QBits", 254)         -- Bought amulets
	if evt.Cmp("Gold", 2000) then
		evt.Subtract("Gold", 2000)
		evt.Add("Inventory", 648)         -- "Dried Sunfish"
		evt.Add("QBits", 255)         -- Bought Sunfish
		evt.Add("QBits", 264)         -- Can't keep buying sinfish
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Pirate Amulets"
evt.global[261] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 647) then         -- "Flawed Amulets"
		evt.SetMessage(706)         -- "The Pirates of Regna like flamboyant jewelry!  Amulets that fail to take enchantments cast by the Necromancers of Shadowspire fill this need quite well.  The Pirates pay some of their ""hard earned"" bounty to get these amulets."
		evt.Subtract("Inventory", 647)         -- "Flawed Amulets"
		evt.Subtract("QBits", 263)         -- Can't keep buying amulets
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 1994)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 2041)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 2051)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 2037)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 1973)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 1955)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 2086)
		end
	end
end

-- "Buy Silver Dust of the Sea for 5000 gold"
evt.CanShowTopic[262] = function()
	if not evt.Cmp("QBits", 258) then         -- Bought Item Ground Wyvern Horn
		return not evt.Cmp("QBits", 265)         -- Can't keep buying Silver Dust of the Sea
	end
	return true
end

evt.global[262] = function()
	evt.SetMessage(707)         -- "Purchase Silver Dust of the Sea made by the Necromancers of Shadowspire. It is used by the smugglers of Ravenshore to hide their boats.  It provides the boats with a limited form of invisibility."
	evt.Subtract("QBits", 267)         -- Can't keep buying Ground Wyvern horn
	if evt.Cmp("Gold", 5000) then
		evt.Subtract("Gold", 5000)
		evt.Add("Inventory", 649)         -- "Silver Dust of the Sea"
		evt.Add("QBits", 253)         -- Bought heartwood
		evt.Add("QBits", 262)         -- Can't keep buying heartwood
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Ground Wyvern Horn"
evt.global[263] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 651) then         -- "Ground Wyvern Horn"
		evt.SetMessage(708)         -- "Ground Wyvern Horn is reported to be one of the most potent reagents used by the necromancers of Shadowspire.  Unlike the reagents used by alchemists, this reagent is only used by the highest ranking members of the Necromancers' Guild."
		evt.Subtract("Inventory", 651)         -- "Ground Wyvern Horn"
		evt.Subtract("QBits", 267)         -- Can't keep buying Ground Wyvern horn
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 8234)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 8267)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 8250)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 8291)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 8244)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 8285)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 8273)
		end
	end
end

-- "Buy Forged Credit Vouchers for 6500 gold"
evt.CanShowTopic[264] = function()
	if not evt.Cmp("QBits", 256) then         -- Bought Item Silver Dust of the Sea
		return not evt.Cmp("QBits", 266)         -- Can't keep buying Forged Credit Vouchers
	end
	return true
end

evt.global[264] = function()
	evt.SetMessage(709)         -- "These Forged Credit Vouchers are used by agents of the Ogre Mage Zog to acquire gold from the Merchants of Alvar."
	evt.Subtract("QBits", 265)         -- Can't keep buying Silver Dust of the Sea
	if evt.Cmp("Gold", 6500) then
		evt.Subtract("Gold", 6500)
		evt.Add("Inventory", 650)         -- "Forged Vouchers"
		evt.Add("QBits", 257)         -- Bought Item Forged Credit Vouchers
		evt.Add("QBits", 266)         -- Can't keep buying Forged Credit Vouchers
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Silver Dust of the Sea"
evt.global[265] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 649) then         -- "Silver Dust of the Sea"
		evt.SetMessage(710)         -- "Purchase Silver Dust of the Sea made by the necromancers of Shadowspire. It is used by the Smuggler's of Ravenshore to hide their boats.  It provides the boats with a limited form of invisibility."
		evt.Subtract("Inventory", 649)         -- "Silver Dust of the Sea"
		evt.Subtract("QBits", 265)         -- Can't keep buying Silver Dust of the Sea
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 6261)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 6286)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 6237)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 6255)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 6294)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 6273)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 6244)
		end
	end
end

-- "Buy Ground Wyvern Horn for 7500 gold"
evt.CanShowTopic[266] = function()
	if not evt.Cmp("QBits", 257) then         -- Bought Item Forged Credit Vouchers
		return not evt.Cmp("QBits", 267)         -- Can't keep buying Ground Wyvern horn
	end
	return true
end

evt.global[266] = function()
	evt.SetMessage(711)         -- "Ground Wyvern Horn is reported to be one of the most potent reagents used by the necromancers of Shadowspire.  Unlike the reagents used by alchemists, this reagents is only used by the highest members of the Necromancers' Guild."
	evt.Subtract("QBits", 266)         -- Can't keep buying Forged Credit Vouchers
	if evt.Cmp("Gold", 7500) then
		evt.Subtract("Gold", 7500)
		evt.Add("Inventory", 651)         -- "Ground Wyvern Horn"
		evt.Add("QBits", 258)         -- Bought Item Ground Wyvern Horn
		evt.Add("QBits", 267)         -- Can't keep buying Ground Wyvern horn
	else
		evt.SetMessage(740)         -- "You don't have enough gold!"
	end
end

-- "Sell Forged Credit Vouchers"
evt.global[267] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 650) then         -- "Forged Vouchers"
		evt.SetMessage(712)         -- "These Forged Credit Vouchers are used by agents of the Ogre Mage Zog to acquire gold from the Merchants of Alvar."
		evt.Subtract("Inventory", 650)         -- "Forged Vouchers"
		evt.Subtract("QBits", 266)         -- Can't keep buying Forged Credit Vouchers
		evt.ForPlayer("Current")
		if evt.Cmp("DayOfWeekIs", 0) then
			evt.Add("Gold", 7294)
		elseif evt.Cmp("DayOfWeekIs", 1) then
			evt.Add("Gold", 7241)
		elseif evt.Cmp("DayOfWeekIs", 2) then
			evt.Add("Gold", 7251)
		elseif evt.Cmp("DayOfWeekIs", 3) then
			evt.Add("Gold", 7237)
		elseif evt.Cmp("DayOfWeekIs", 4) then
			evt.Add("Gold", 7273)
		elseif evt.Cmp("DayOfWeekIs", 5) then
			evt.Add("Gold", 7255)
		elseif evt.Cmp("DayOfWeekIs", 6) then
			evt.Add("Gold", 7286)
		end
	end
end

-- "Empty Barrel"
evt.global[268] = function()
	evt.StatusText(713)         -- "Empty Barrel"
end

-- "Red Barrel"
evt.global[269] = function()
	evt.StatusText(714)         -- "+2 Might permanent"
	evt.Add("BaseMight", 2)
	evt.Set("AutonotesBits", 33)         -- "Red liquid grants Might."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Yellow Barrel"
evt.global[270] = function()
	evt.StatusText(715)         -- "+2 Accuracy permanent"
	evt.Add("BaseAccuracy", 2)
	evt.Set("AutonotesBits", 37)         -- "Yellow liquid grants Accuracy."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Blue Barrel"
evt.global[271] = function()
	evt.StatusText(716)         -- "+2 Personality permanent"
	evt.Add("BasePersonality", 2)
	evt.Set("AutonotesBits", 35)         -- "Blue liquid grants Personality."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Orange Barrel"
evt.global[272] = function()
	evt.StatusText(717)         -- "+2 Intellect permanent"
	evt.Add("BaseIntellect", 2)
	evt.Set("AutonotesBits", 34)         -- "Orange liquid grants Intellect."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Green Barrel"
evt.global[273] = function()
	evt.StatusText(718)         -- "+2 Endurance permanent"
	evt.Add("BaseEndurance", 2)
	evt.Set("AutonotesBits", 36)         -- "Green liquid grants Endurance."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Purple Barrel"
evt.global[274] = function()
	evt.StatusText(719)         -- "+2 Speed permanent"
	evt.Add("BaseSpeed", 2)
	evt.Set("AutonotesBits", 38)         -- "Purple liquid grants Speed."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "White Barrel"
evt.global[275] = function()
	evt.StatusText(720)         -- "+2 Luck permanent"
	evt.Add("BaseLuck", 2)
	evt.Set("AutonotesBits", 39)         -- "White liquid grants Luck."
	evt.ChangeEvent(268)         -- "Empty Barrel"
end

-- "Empty Cauldron"
evt.global[276] = function()
	evt.StatusText(721)         -- "Empty Cauldron"
end

-- "Steaming Cauldron"
evt.global[277] = function()
	evt.StatusText(722)         -- "+2 Fire Resistance permanent"
	evt.Add("FireResistance", 2)
	evt.Set("AutonotesBits", 40)         -- "Steaming liquid grants Fire Resistance."
	evt.ChangeEvent(276)         -- "Empty Cauldron"
end

-- "Frosty Cauldron"
evt.global[278] = function()
	evt.StatusText(723)         -- "+2 Water Resistance permanent"
	evt.Add("WaterResistance", 2)
	evt.Set("AutonotesBits", 41)         -- "Frosty liquid grants Water Resistance."
	evt.ChangeEvent(276)         -- "Empty Cauldron"
end

-- "Shocking Cauldron"
evt.global[279] = function()
	evt.StatusText(724)         -- "+2 Air Resistance permanent"
	evt.Add("AirResistance", 2)
	evt.Set("AutonotesBits", 42)         -- "Shocking liquid grants Air Resistance."
	evt.ChangeEvent(276)         -- "Empty Cauldron"
end

-- "Dirty Cauldron"
evt.global[280] = function()
	evt.StatusText(725)         -- "+2 Earth Resistance permanent"
	evt.Add("EarthResistance", 2)
	evt.Set("AutonotesBits", 43)         -- "Dirty liquid grants Earth Resistance."
	evt.ChangeEvent(276)         -- "Empty Cauldron"
end

-- "Trash Heap"
evt.global[281] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(726)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
::_15::
	evt.ChangeEvent(284)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[282] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(726)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
::_15::
	evt.ChangeEvent(284)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[283] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		goto _15
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
		end
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		goto _15
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(726)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
::_15::
	evt.ChangeEvent(284)         -- "Trash Heap"
end

-- "Trash Heap"
evt.global[284] = function()
	local i
	i = Game.Rand() % 2
	if i == 1 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(726)         -- "Diseased!"
			return
		end
	end
	evt.StatusText(727)         -- "Nothing Here"
end

-- "Camp Fire"
evt.global[285] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		evt.Add("Food", 3)
		evt.ChangeEvent(0)
	elseif i == 2 then
		evt.Add("Food", 2)
		evt.ChangeEvent(0)
	else
		evt.Add("Food", 1)
		evt.ChangeEvent(0)
	end
end

-- "Camp Fire"
evt.global[286] = function()
	local i
	i = Game.Rand() % 3
	if i == 1 then
		evt.Add("Food", 4)
		evt.ChangeEvent(0)
	elseif i == 2 then
		evt.Add("Food", 3)
		evt.ChangeEvent(0)
	else
		evt.Add("Food", 2)
		evt.ChangeEvent(0)
	end
end

-- "Food Bowl"
evt.global[287] = function()
	evt.Add("Inventory", 655)         -- "Green Apple"
	evt.ChangeEvent(0)
end

-- "Empty Cask"
evt.global[288] = function()
	evt.StatusText(739)         -- "Empty Cask"
end

-- "Cask"
evt.global[289] = function()
	local i
	i = Game.Rand() % 6
	if i >= 3 and i <= 5 then
		i = Game.Rand() % 6
		if i >= 3 and i <= 5 then
			evt.Set("PoisonedGreen", 0)
			evt.StatusText(728)         -- "Poisoned!"
		else
			evt.Set("Drunk", 0)
			evt.StatusText(738)         -- "Drunk!"
		end
	else
		i = Game.Rand() % 6
		if i == 1 or i == 2 then
			evt.Add("Inventory", 202)         -- "Phial of Gog Blood"
		elseif i == 3 or i == 4 then
			evt.Add("Inventory", 210)         -- "Poppy Pod"
		elseif i == 5 then
			evt.Add("Inventory", 212)         -- "Sulfur"
		else
			evt.Add("Inventory", 218)         -- "Mercury"
		end
	end
	evt.ChangeEvent(288)         -- "Empty Cask"
end

-- "Yellow Fever"
evt.CanShowTopic[290] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[290] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 102)         -- Delivered cure to hut 1
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
		if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
			if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
				if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
					if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
						if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Yellow Fever"
evt.CanShowTopic[291] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[291] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 103)         -- Delivered cure to hut 2
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
		if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
			if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
				if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
					if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
						if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Yellow Fever"
evt.CanShowTopic[292] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[292] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 104)         -- Delivered cure to hut 3
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
		if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
			if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
				if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
					if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
						if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Yellow Fever"
evt.CanShowTopic[293] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[293] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 105)         -- Delivered cure to hut 4
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
		if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
			if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
				if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
					if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
						if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Yellow Fever"
evt.CanShowTopic[294] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[294] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 106)         -- Delivered cure to hut 5
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
		if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
			if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
				if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
					if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
						if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Yellow Fever"
evt.CanShowTopic[295] = function()
	return evt.Cmp("QBits", 101)         -- "Deliver Cure Disease Scrolls to the six huts on the outer Dagger Wound Islands.  Return to Aislen on Dagger Wound Island."
end

evt.global[295] = function()
	if evt.Cmp("QBits", 108) then         -- Yellow Fever epidemic cured!
		evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
		return
	end
	if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
		evt.SetMessage(743)         -- "Thanks for the cure! Be sure to deliver scrolls to those who still suffer from the Yellow Fever."
		return
	end
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 373) then         -- "Cure Disease"
		evt.SetMessage(742)         -- "I am very sick, without a Cure Disease scroll I will surely perish from Yellow Fever!."
		return
	end
	evt.Subtract("Inventory", 373)         -- "Cure Disease"
	evt.Add("QBits", 107)         -- Delivered cure to hut 6
	evt.ForPlayer("All")
	evt.Add("Experience", 250)
	if evt.Cmp("QBits", 107) then         -- Delivered cure to hut 6
		if evt.Cmp("QBits", 102) then         -- Delivered cure to hut 1
			if evt.Cmp("QBits", 103) then         -- Delivered cure to hut 2
				if evt.Cmp("QBits", 104) then         -- Delivered cure to hut 3
					if evt.Cmp("QBits", 105) then         -- Delivered cure to hut 4
						if evt.Cmp("QBits", 106) then         -- Delivered cure to hut 5
							evt.ForPlayer("All")
							evt.Add("Experience", 1500)
							evt.SetMessage(621)         -- "The Yellow Fever epidemic is over!  Thank you for your help!"
							evt.Add("QBits", 108)         -- Yellow Fever epidemic cured!
							return
						end
					end
				end
			end
		end
	end
	evt.SetMessage(741)         -- "Thanks for the cure, but others in the area are still sick!  Be sure to deliver the cure to them as well!"
end

-- "Rothnax"
evt.global[296] = function()
	evt.SetMessage(751)         -- "My brother Rohtnax lives!  And you have repaired the Portals of Stone?  I must return home to him, so that we can plan our family's survival!"
	evt.Add("QBits", 138)         -- Found Isthric the Tongue
	evt.MoveNPC{NPC = 90, HouseId = 225}         -- "Isthric the Tongue" -> "Rohtnax's House"
	evt.SetNPCTopic{NPC = 90, Index = 0, Event = 297}         -- "Isthric the Tongue" : "Thank you again!"
end

-- "Thank you again!"
evt.CanShowTopic[297] = function()
	return evt.Cmp("QBits", 134)         -- Gave Gem of Restoration to Blazen Stormlance
end

-- "Report!"
evt.CanShowTopic[298] = function()
	return evt.Cmp("QBits", 117)         -- "Deliver fake report to the Dread Pirate Stanley in the Pirate's Rest Tavern on the Island of Regna."
end

evt.global[298] = function()
	evt.SetMessage(777)         -- "You're new aren't you?  Tell Arion Hunter that I expect more of his rabble than the likes of you!  Give me the reports and leave my sight!  You make me sick!"
	evt.Subtract("QBits", 117)         -- "Deliver fake report to the Dread Pirate Stanley in the Pirate's Rest Tavern on the Island of Regna."
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 602)         -- "False Report"
	evt.Add("Awards", 61)         -- "Delivered False Report to the Dread Pirate Stanley for Arion Hunter."
	evt.Subtract("QBits", 282)         -- False Report - I lost it!
	evt.Add("Experience", 20000)
	evt.ForPlayer(0)
	evt.Add("Gold", 15000)
	evt.SetNPCTopic{NPC = 296, Index = 0, Event = 0}         -- "Dread Pirate Stanley"
	evt.MoveNPC{NPC = 296, HouseId = 0}         -- "Dread Pirate Stanley"
end

-- "Fate of Jadame"
evt.global[299] = function()
	if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
		evt.SetMessage(791)         -- "Jadame owes you a great debt!  You have saved the entire world from total destruction!"
	else
		evt.SetMessage(790)         -- "Who knows the fate of Jadame now.  Perhaps you will find a way to save us from destruction?"
	end
end

-- "Puddle Thain"
evt.global[417] = function()
	evt.SetMessage(417)         -- "Puddle Thain, is a most promising student.  If you seek Expert instruction in the uses of the Staff, you can find him in the city of Ravenshore."
	evt.Set("AutonotesBits", 128)         -- "- Staff   Expert   Ravenshore -  Puddle Thain in the city of Ravenshore."
end

-- "Celia Stone"
evt.global[418] = function()
	evt.SetMessage(418)         -- "Celia Stone, Master of the Staff, dwells in Troll village of Rust in the Ironsand Desert.  She can instruct you to Mastery of the Staff is that is what you desire."
	evt.Set("AutonotesBits", 129)         -- "- Staff   Master   Ironsand Desert -  Celia Stone located in the village of Rust. Rust is in the Ironsand Desert."
end

-- "Tristen Stillwater"
evt.global[419] = function()
	evt.SetMessage(419)         -- "Grand Master Tristen Stillwater, instructs all students of the Staff.  Only he can help you in attaining Grand Mastery of this fine weapon.  Seek him out in the city of Twilight at the base of the Shadowspire."
	evt.Set("AutonotesBits", 130)         -- "- Staff   Grand    Shadowspire -  Tristen Stillwater is located in the Shadowspire city of Twilight."
end

-- "Aerie Luodrin"
evt.global[420] = function()
	evt.SetMessage(420)         -- "Aerie Luodrin currently dwells in Ravenshore.  She is a most dedicated student of the uses of the Sword and can instruct you to and Expert skill level with the weapon."
	evt.Set("AutonotesBits", 131)         -- "= Sword   Expert   Ravenshore =   Aerie Luodrin in the city of Ravenshore."
end

-- "Jaycin Cardron"
evt.global[421] = function()
	evt.SetMessage(421)         -- "Unfortunately Jaycin Cardron, Master of the Sword, felt that his skills would be more, shall we say, ""profitable taught"" to the Dragon Hunter's of Garrote Gorge.  If you seek Master skill level with the Sword, you will have to go to him at the Garrote Gorge Dragon Hunter Camp."
	evt.Set("AutonotesBits", 132)         -- "= Sword   Master   Garrote Gorge =   Jaycin Cardron. You can find her in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Miyon Dragontracker"
evt.global[422] = function()
	evt.SetMessage(422)         -- "Miyon Dragontracker, Grand Master of the Sword, has joined the knight, Charles Quixote in his quest to exterminate the Dragons of Garrote Gorge.  You can find Miyon at the Dragon Hunter's Fort."
	evt.Set("AutonotesBits", 133)         -- "= Sword   Grand    Regna =   Miyon Dragontracker can be found on the island of Regna."
end

-- "Lori Vespers"
evt.global[423] = function()
	evt.SetMessage(423)         -- "The Expert instructor of the Dagger, Lori Vespers, lives in the Dark Elf city of Alvar.  Seek her out there."
	evt.Set("AutonotesBits", 134)         -- "+ Dagger   Expert   Alvar +  Lori Vespers lives in the Dark Elf city of Alvar."
end

-- "Jobber"
evt.global[424] = function()
	evt.SetMessage(424)         -- "Master Jobber can instruct students of the Dagger to Mastery.  He lives in the city of Ravenshore."
	evt.Set("AutonotesBits", 135)         -- "+ Dagger   Master   Ravenshore +  Master Jobber lives in the city of Ravenshore."
end

-- "Karla Nirses"
evt.global[425] = function()
	evt.SetMessage(425)         -- "Karla Nirses, the Grand Master of the Dagger trains all Regnan Pirates in the uses of the Dagger.  She dwells with them on the Island of Regna as they pay her well."
	evt.Set("AutonotesBits", 136)         -- "+ Dagger   Grand    Regna +  Karla Nirses can be found on Regna Island."
end

-- "Herald Foestryke"
evt.global[426] = function()
	evt.SetMessage(426)         -- "Herald Foestryke, one of Charles Quixote's finest knights, is the Expert teacher of the skills of the Axe.  He can be found at the Dragon Hunter's Camp in Garrote Gorge."
	evt.Set("AutonotesBits", 137)         -- "- Axe   Expert   Garrote Gorge -   Herald Foestryke is in the Dragon Hunter's Camp."
end

-- "Jasp Hunter "
evt.global[427] = function()
	evt.SetMessage(427)         -- "Jasp Hunter is the Master instructor of the axe.  He can teach you the skills that will lead to Mastery of the axe.  His home is in the seaside city of Ravenshore."
	evt.Set("AutonotesBits", 138)         -- "- Axe   Master   Ravenshore -   Jasp Hunter's home is in the seaside city of Ravenshore."
end

-- "Garic Senjac"
evt.global[428] = function()
	evt.SetMessage(428)         -- "Grand Master Garic Senjac, is the Grand Master teacher of the ways of the Axe.  His home is in Balthazar Lair in the Ravage Roaming region."
	evt.Set("AutonotesBits", 139)         -- "- Axe   Grand    Ravage Roaming -   Garic Senjac makes his home in Balthazar Lair located in Ravage Roaming."
end

-- "Matric Townsaver"
evt.global[429] = function()
	evt.SetMessage(429)         -- "Matric Townsaver defended the city of Ravenshore against many Regnan Pirate raids.  His skill and instruction of the uses of the spear allowed the townsfolk to push the Pirates back. He can instruct you to Expert skill level with the spear."
	evt.Set("AutonotesBits", 140)         -- "= Spear   Expert   Ravenshore =  Matric Townsaver."
end

-- "Ashandra Withersmythe"
evt.global[430] = function()
	evt.SetMessage(430)         -- "Ashandra Withersmythe is the Master teacher of the Spear.  Her instruction of the ways of the Spear will lead you to Mastery of the weapon.  She lives in the merchant city of Alvar."
	evt.Set("AutonotesBits", 141)         -- "= Spear   Master   Alvar =  Ashandra Withersmythe lives in the merchant city of Alvar."
end

-- "Yarrow"
evt.global[431] = function()
	evt.SetMessage(431)         -- "Yarrow is the Grand Master of the Spear.  Her keen eye and stalking ability have aided her in attaining this level of skill.  She uses the Spear to stalk the poisonous couatl of the jungles of the Dagger Wound Islands."
	evt.Set("AutonotesBits", 142)         -- "= Spear   Grand    Dagger Wound Islands =  Yarrow."
end

-- "Shivan Keeneye"
evt.global[432] = function()
	evt.SetMessage(432)         -- "Shivan Keeneye is an Expert shot with the Bow.  Her teachings can lead you to an Expert skill level with this ranged weapon.  She lives in the village of Blood Drop on the Dagger Wound Islands."
	evt.Set("AutonotesBits", 143)         -- "+ Bow   Expert   Dagger Wound Islands +  Shivan Keeneye lives in the village of Blood Drop on the Dagger Wound Islands."
end

-- "Oberic Nosewort"
evt.global[433] = function()
	evt.SetMessage(433)         -- "Master Oberic Nosewort teaches students of the bow in his home in Ravenshore.  If you seek Mastery of this weapon you must seek him out there."
	evt.Set("AutonotesBits", 144)         -- "+ Bow   Master   Ravenshore +  Oberic Nosewort lives in Ravenshore city"
end

-- "Solis"
evt.global[434] = function()
	evt.SetMessage(434)         -- "Solis, Grand Master of the Bow, lives in the Dark Elf city of Alvar.  She can teach you Grand Mastery of the Bow."
	evt.Set("AutonotesBits", 145)         -- "+ Bow   Grand    Alvar +  Solis lives in the Dark Elf city of Alvar."
end

-- "Lisha Sourbrow"
evt.global[435] = function()
	evt.SetMessage(435)         -- "Lisha Sourbrow teaches Expert uses of the Mace from her home in Ravenshore."
	evt.Set("AutonotesBits", 146)         -- "- Mace   Expert   Ravenshore -  Lisha Sourbrow teaches from her home in Ravenshore."
end

-- "Robert Morningstar"
evt.global[436] = function()
	evt.SetMessage(436)         -- "Robert Morningstar, teaches Mastery of the Mace to the knights in Garrote Gorge."
	evt.Set("AutonotesBits", 147)         -- "- Mace   Master   Garrote Gorge -  Robert Morningstar trains the knights of the Garrote Gorge Dragon Hunter's Camp."
end

-- "Brother Hearthsworn"
evt.global[437] = function()
	evt.SetMessage(437)         -- "Brother Hearthsworn, the Grand Master of the Mace, retired to the peace of the Ironsand Desert, seeking tranquility among the dunes of that region.  His home is in the village of Rust."
	evt.Set("AutonotesBits", 148)         -- "- Mace   Grand    Ironsand Desert -  Brother Hearthsworn can be found in the village of Rust located in the Ironsand Desert."
end

-- "Qillain Moore"
evt.global[438] = function()
	evt.SetMessage(438)         -- "Qillain Moore used to serve the knight, Charles Quixote, but disagreed with his crusade to slay all the Dragons in the Garrote Gorge area. Moore still teaches Expert uses of the Shield from his home in the city of Alvar."
	evt.Set("AutonotesBits", 152)         -- "= Shield   Expert   Alvar =  Qillain Moore lives in the the city of Alvar."
end

-- "Sheldon Nightwood"
evt.global[439] = function()
	evt.SetMessage(439)         -- "Sheldon Nightwood lives in the city of Twilight, beneath the Necromancers' Guild on the Shadowspire.  She can teach you Mastery of the Shield."
	evt.Set("AutonotesBits", 153)         -- "= Shield   Master   Shadowspire =  Sheldon Nightwood lives in the Shadowspire city of Twilight."
end

-- "Peryn Reaverston"
evt.global[440] = function()
	evt.SetMessage(440)         -- "The knight, Peryn Reaverston, holds the title of Grand Master of the Shield.  He is currently in service to Charles Quixote and teaches knights in the proper uses of the shield.  Search him out in the Dragon Hunter's Camp in Garrote Gorge."
	evt.Set("AutonotesBits", 154)         -- "= Shield   Grand    Garrote Gorge =  Peryn Reaverston lives in the Dragon Hunter's Camp in Garrote Gorge."
end

-- "Thadin"
evt.global[441] = function()
	evt.SetMessage(441)         -- "The Lizardman Thadin is the Expert instructor of the use of Leather armor.  His instruction will give you an Expert skill level with this armor.  You can find him on the Island of Dagger Wound."
	evt.Set("AutonotesBits", 155)         -- "- Leather   Expert   Dagger Wound Islands -  Thadin. You can find him on the Island of Dagger Wound."
end

-- "Shamus Hollyfield"
evt.global[442] = function()
	evt.SetMessage(442)         -- "Master Shamus Hollyfield dwells in the Minotaur city, Balthazar Lair, which is located in the Ravage Roaming region.  He can teach you Mastery of Leather armor."
	evt.Set("AutonotesBits", 156)         -- "- Leather   Master   Ravage Roaming -  Shamus Hollyfield dwells in the Minotaur city, Balthazar Lair, which is located in the Ravage Roaming region."
end

-- "Medwari Elmsmire"
evt.global[443] = function()
	evt.SetMessage(443)         -- "Medwari Elmsmire makes the finest Leather armor in the realm.  She also holds the title of Grand Master of Leather Armor and can instruct you at her home in the village of Rust in the Ironsand Desert."
	evt.Set("AutonotesBits", 157)         -- "- Leather   Grand    Ironsand Desert -  Medwari Elmsmire makes her home in the village of Rust in the Ironsand Desert."
end

-- "Tobren Forgewright "
evt.global[444] = function()
	evt.SetMessage(444)         -- "Tobren Forgewright assisted the city of Ravenshore in the First Pirate War.  Her forge glowed for four weeks straight as she made chain armor for the defenders of Ravenshore.  She still teaches Expert use of the armor from her home in the seaside port of Ravenshore."
	evt.Set("AutonotesBits", 158)         -- "= Chain   Expert   Ravenshore =  Tobren Forgewright lives in the seaside port of Ravenshore."
end

-- "Halian Eversmyle"
evt.global[445] = function()
	evt.SetMessage(445)         -- "Halian Eversmyle learned all the skills he could from the Grand Master of Chain armor and then fled to the city of Alvar where he teaches Mastery of this armor to the Merchants of Alvar.  He will instruct you to Mastery as well."
	evt.Set("AutonotesBits", 159)         -- "= Chain   Master   Alvar =  Halian Eversmyle can be found in the city of Alvar."
end

-- "Seline Burnkindle"
evt.global[446] = function()
	evt.SetMessage(446)         -- "Grand Master Seline Burnkindle teaches ways of using chain armor to its greatest advantage.  She lives among the Pirates of Regna."
	evt.Set("AutonotesBits", 160)         -- "= Chain   Grand    Renga =  Seline Burnkindle teaches from her home on the island of Renga."
end

-- "Bone"
evt.global[447] = function()
	evt.SetMessage(447)         -- "Bone teaches the Expert skills of Plate armor from his hut on Dagger Wound Island."
	evt.Set("AutonotesBits", 161)         -- "+ Plate   Expert   Dagger Wound Islands +  Bone."
end

-- "Botham"
evt.global[448] = function()
	evt.SetMessage(448)         -- "Master Botham was one of the finest warriors in the First Pirate War.  Ravenshore owes him a debt of gratitude.  Botham and his fellow swordsman led the charge against the first wave of Regnans.  Their Plate armor deflected all but the most serious blows.  He still teaches Mastery of Plate armor from his home."
	evt.Set("AutonotesBits", 162)         -- "+ Plate   Master   Ravenshore +  Botham lives in the city of Ravenshore."
end

-- "Seth Ironfist"
evt.global[449] = function()
	evt.SetMessage(449)         -- "Seth Ironfist, Grand Master of Plate Armor, is the true force behind Charles Quixote's crusade against the Dragons of Garrote Gorge.  Without his instruction in the use of Plate armor, Quixote's knights would be mere fodder before the wrath Redreaver's Dragons."
	evt.Set("AutonotesBits", 163)         -- "+ Plate   Grand    Garrote Gorge +  Seth Ironfist teaches in the Dragon Hunter's Camp in Garrote Gorge."
end

-- "Taren Temper"
evt.global[450] = function()
	evt.SetMessage(450)         -- "Taren Temper, fled Erathia to make a new life for himself among those who know nothing of the Temper history.  He teaches Expert skills in Fire Magic from his home in Ravenshore."
	evt.Set("AutonotesBits", 164)         -- "- Fire Magic   Expert   Ravenshore -  Taren Temper teaches from his home in Ravenshore."
end

-- "Solomon Steele"
evt.global[451] = function()
	evt.SetMessage(451)         -- "Solomon Steele, Master of Fire, lives in the tranquil city of Alvar.  He can teach you Mastery of Fire Magic."
	evt.Set("AutonotesBits", 165)         -- "- Fire Magic   Master   Alvar -  Solomon Steele lives in the tranquil city of Alvar."
end

-- "Burn"
evt.global[452] = function()
	evt.SetMessage(452)         -- "Burn, Grand Master of Fire dwells in the oppressive heat of the Plane of Fire.  Perhaps the Gate of Fire that has appeared in the Ironsand Desert will lead you to him.  He can instruct you in Grand Mastery of Fire Magic.  "
	evt.Set("AutonotesBits", 166)         -- "- Fire Magic   Grand    Plane of Fire -  Burn dwells in the oppressive heat of the Plane of Fire."
end

-- "Reshie"
evt.global[453] = function()
	evt.SetMessage(453)         -- "Reshie teaches the Expert skill of Air Magic from his home on the Dagger Wound Islands."
	evt.Set("AutonotesBits", 167)         -- "= Air Magic   Expert   Dagger Wound Islands =  Reshie teaches from his home on the Dagger Wound Islands."
end

-- "Hollis Stormeye"
evt.global[454] = function()
	evt.SetMessage(454)         -- "Hollis Stormeye, Master of Air, made her home in Balthazar Lair, home of the Minotaurs.  "
	evt.Set("AutonotesBits", 168)         -- "= Air Magic   Master   Ravage Roaming =  Hollis Stormeye makes her home in Balthazar Lair located in Ravage Roaming."
end

-- "Cloud Nedlon"
evt.global[455] = function()
	evt.SetMessage(455)         -- "Cloud Nedlon sought to make a deal with the Lords of Air.  He left to find a way into the Plane of Air, where he thought he would learn all that remained unclear to him about the ways of Air Magic.  You will have to travel to the Plane of Air to see if he was successful."
	evt.Set("AutonotesBits", 169)         -- "= Air Magic   Grand    Plane of Air =  Cloud Nedlon may be found on the Plane of Air."
end

-- "Ulbrecht Pederton"
evt.global[456] = function()
	evt.SetMessage(456)         -- "Ulbrecht Pederton single handedly stopped the Second Pirate War.  He charged down the beach to come to Ravenshore's defense as the pirates began to land.  He manipulated the sea itself and forced the Regnan fleet back into the ocean.  Unfortunately this effort cost him the ability to use magic altogether.  He still, however, teaches the knowledge of Expert Water Magic.  He lives in Ravenshore to this day."
	evt.Set("AutonotesBits", 170)         -- "+ Water Magic   Expert   Ravenshore +  Ulbrecht Pederton lives in Ravenshore city."
end

-- "Gregory Mist"
evt.global[457] = function()
	evt.SetMessage(457)         -- "Gregory Mist, Master of Water, makes his home in the village of Rust in the Ironsand Desert.  He claims to have a plan to use his magic to change the hot desert into a verdant green plain.  If he has the time, he can teach you Mastery of Water Magic."
	evt.Set("AutonotesBits", 171)         -- "+ Water Magic   Master   Ironsand Desert +  Gregory Mist makes his home in the village of Rust in the Ironsand Desert."
end

-- "Black Current"
evt.global[458] = function()
	evt.SetMessage(458)         -- "Black Current was once a powerful mage in this region.  Her ambition for power outgrew her caution and she attempted to conquer the Plane of Water.  She summoned a gate to the plane and stepped through.  She was never heard from again.  She was the Grand Master of Water Magic.  If she still lives you may find her in the Plane of Water."
	evt.Set("AutonotesBits", 172)         -- "+ Water Magic   Grand    Plane of Water +  Black Current may be found on the Plane of Water."
end

-- "Ostrin Grivic"
evt.global[459] = function()
	evt.SetMessage(459)         -- "Ostrin Grivic, Expert instructor of Earth Magic, lives in the village of Blood Drop on the Dagger Wound Islands."
	evt.Set("AutonotesBits", 173)         -- "- Earth Magic   Expert   Dagger Wound Islands -  Ostrin Grivic lives in the village of Blood Drop on the Dagger Wound Islands."
end

-- "Dorothy Sablewood"
evt.global[460] = function()
	evt.SetMessage(460)         -- "Earth Magic Master Dorothy Sablewood helped end the First Pirate War.  With the aid of an unknown Air Mage, she erected walls of clay to keep the Regnan Pirates from leaving their boats.  She now teaches her skills from her home in Alvar."
	evt.Set("AutonotesBits", 174)         -- "- Earth Magic   Master   Alvar -  Dorothy Sablewood lives in the city of Alvar."
end

-- "Griven"
evt.global[461] = function()
	evt.SetMessage(461)         -- "Grand Master Griven passed into the Plane of Earth after teaching his final lesson to Dorothy Sablewood.  Perhaps he lives there to this day.  Who knows what transpires in an elemental plane?"
	evt.Set("AutonotesBits", 175)         -- "- Earth Magic   Grand    Plane of Air -  Griven may be found on the Plane of Air."
end

-- "Straton Hawthorne"
evt.global[462] = function()
	evt.SetMessage(462)         -- "Straton Hawthorne can raise you to Expert level in the arts of Spirit Magic. He makes his home in the port city of Ravenshore."
	evt.Set("AutonotesBits", 176)         -- "= Spirit Magic   Expert   Ravenshore =  Straton Hawthorne makes his home in the port city of Ravenshore."
end

-- "Bethold Kern"
evt.global[463] = function()
	evt.SetMessage(463)         -- "Master Bethold Kern, serves the knight Charles Quixote in his crusade against the Dragons of the Garrote Gorge region.  Search him out there at the Dragon Hunter's Camp.  If you are lucky, he will have time to instruct you in Mastery of Spirit Magic."
	evt.Set("AutonotesBits", 177)         -- "= Spirit Magic   Master   Garrote Gorge =  Bethold Kern can be found in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Lasiter Ravensight"
evt.global[464] = function()
	evt.SetMessage(464)         -- "Lasiter Ravensight, is the Grand Master of Spirit Magic.  He lives in the Murmurwoods close to the Temple of the Sun, where he continues his studies in to the essence of Spirit.  He can raise your skill in Spirit Magic to Grand Mastery."
	evt.Set("AutonotesBits", 178)         -- "= Spirit Magic   Grand    Murmurwoods =  Lasiter Ravensight lives in the Murmurwoods close to the Temple of the Sun."
end

-- "Shane Krewlen "
evt.global[465] = function()
	evt.SetMessage(465)         -- "Shane Krewlen, student of Mind Magic, can instruct you in the Expert skills of this arcane magic.  Seek him out in the Dark Elf city of Alvar."
	evt.Set("AutonotesBits", 179)         -- "+ Mind Magic   Expert   Alvar +  Shane Krewlen lives in the Dark Elf city of Alvar."
end

-- "Barthine Lotts"
evt.global[466] = function()
	evt.SetMessage(466)         -- "Barthine Lotts, Master of Mind Magic, dwells in the Minotaur city of Balthazar Lair in the Ravage Roaming region.  Through her instruction can gain Mastery of Mind Magic."
	evt.Set("AutonotesBits", 180)         -- "+ Mind Magic   Master   Ravage Roaming +  Barthine Lotts dwells in the Minotaur city of Balthazar Lair in the Ravage Roaming region."
end

-- "Gilad Dreamwright"
evt.global[467] = function()
	evt.SetMessage(467)         -- "Gilad Dreamwright, Grand Master of Mind Magic, has joined many other Grand Masters of Magic in the Murmurwoods region.  Here they work with the Temple of the Sun to further their combined skills and knowledge.  Gilad can instruct you to Grand Master skill level in Mind Magic."
	evt.Set("AutonotesBits", 181)         -- "+ Mind Magic   Grand    Murmurwoods +  Gilad Dreamwright lives in Murmurwoods near the Temple of the Sun."
end

-- "Zevah Poised"
evt.global[468] = function()
	evt.SetMessage(468)         -- "Zevah Poised, Expert instructor of the arcane skills of Body Magic, lives with his people on the Islands of Dagger Wound in the Ifarine Sea."
	evt.Set("AutonotesBits", 182)         -- "- Body Magic   Expert   Dagger Wound Islands -  Zevah Poised lives with his people on the Islands of Dagger Wound."
end

-- "Tugor Arin"
evt.global[469] = function()
	evt.SetMessage(469)         -- "Tugor Arin, Master of Body Magic, practices his healing skills in the service of the knight Charles Quixote in the Garrote Gorge region.  His skills in Body Magic are put to good use healing the unfortunate young knights who are wounded in the crusade against the Dragons of Garrote Gorge."
	evt.Set("AutonotesBits", 183)         -- "- Body Magic   Master   Garrote Gorge -  Tugor Arin can be found in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Critias Snowtree"
evt.global[470] = function()
	evt.SetMessage(470)         -- "Grand Master Critias Snowtree, dwells in the peace of the Murmurwoods forest away from the trials and troubles of the world.  Only he can instruct you in the ways of Body Magic and raise you to Grand Mastery of this arcane skill."
	evt.Set("AutonotesBits", 184)         -- "- Body Magic   Grand    Murmurwoods -  Critias Snowtree dwells in the Murmurwoods forest."
end

-- "Archibald Dawnsglow"
evt.global[471] = function()
	evt.SetMessage(471)         -- "Archibald Dawnsglow, Expert instructor of Light Magic, practices his arts in the city of Ravenshore on the Ifarine Sea.  His parents gave his name not knowing that it was the same name as the leader of the Erathian Necromancers' Guild.  Archibald desires to have his own name made in the Light, not in the darkness of his namesake."
	evt.Set("AutonotesBits", 185)         -- "= Light Magic   Expert   Ravenshore =  Archibald Dawnsglow practices his arts in the city of Ravenshore."
end

-- "Lunius Dawnbringer"
evt.global[472] = function()
	evt.SetMessage(472)         -- "Master Lunius Dawnbringer, dwells among the the Clerics of Murmurwoods.He can promote you to Master of Light Magic, if you can survive the dangers of the forest."
	evt.Set("AutonotesBits", 186)         -- "= Light Magic   Master   Murmurwoods =  Lunius Dawnbringer dwells near the Temple of the Sun in the Murmurwoods."
end

-- "Aldrin Cleareye"
evt.global[473] = function()
	evt.SetMessage(473)         -- "Aldrin Cleareye, Grand Master of the Light, makes his home on the island of Regna.  He hopes to bring an end to the Pirates evil ways.  He can instruct you to Grand Masterey, if you survive the Pirates."
	evt.Set("AutonotesBits", 187)         -- "= Light Magic   Grand    Regna =  Aldrin Cleareye lives on the island of Regna."
end

-- "Patwin Darkenmore"
evt.global[474] = function()
	evt.SetMessage(474)         -- "Patwin Darkenmore, Expert teacher of the ways of Dark Magic, lives among the Dark Elves of Alvar.  "
	evt.Set("AutonotesBits", 188)         -- "+ Dark Magic   Expert   Alvar +  Patwin Darkenmore lives among the Dark Elves of Alvar."
end

-- "Carla Umberpool"
evt.global[475] = function()
	evt.SetMessage(475)         -- "Dark Magic Master Carla Umberpool followed the travels of Sithicus Shadowrunner, Grand Master of the Dark, and makes her home with the Necromancers of Shadowspire."
	evt.Set("AutonotesBits", 189)         -- "+ Dark Magic   Master   Shadowspire +  Carla Umberpool has a home in the village of Twilight at the base of the Shadowspire."
end

-- "Sithicus Shadowrunner"
evt.global[476] = function()
	evt.SetMessage(476)         -- "Sithicus Shadowrunner, Grand Master of the art of Dark Magic, and has established a home on the Island of Regna.  Here the pirate captains get her blessing on the ships before a raid.  She can instruct you in Grand Mastery of Dark Magic."
	evt.Set("AutonotesBits", 190)         -- "+ Dark Magic   Grand    Regna +  Sithicus Shadowrunner lives on the island of Regna."
end

-- "Kyra Sparkmen"
evt.global[477] = function()
	evt.SetMessage(477)         -- "Kyra Sparkmen, Expert teacher of the Identify Item skill, lives in the city of Alvar.  "
	evt.Set("AutonotesBits", 200)         -- "- Identify Item   Expert   Alvar -  Kyra Sparkmen lives in the city of Alvar."
end

-- "Eithian"
evt.global[478] = function()
	evt.SetMessage(478)         -- "Eithian, Master instructor of the Identify Item skill, serves the Merchants of Alvar, and currently lives on the Dagger Wound Islands. Many travelers bring their prizes to Eithian for identification.  He may have to time to instruct you to Mastery of this skill if you travel to him."
	evt.Set("AutonotesBits", 201)         -- "- Identify Item   Master   Dagger Wound Islands -  Eithian lives on the Dagger Wound Islands."
end

-- "Elzbet Roggen"
evt.global[479] = function()
	evt.SetMessage(479)         -- "Elzbet Roggen, Grand Master of the Identify Item skill, lives in the Shadowspire city of Twilight.  She can teach you what is needed to achieve Grand Mastery."
	evt.Set("AutonotesBits", 202)         -- "- Identify Item   Grand    Shadowspire -  Elzbet Roggen lives in the Shadowspire city of Twilight."
end

-- "Fishner Thomb"
evt.global[480] = function()
	evt.SetMessage(480)         -- "Fishner Thomb, retired from service with the Merchants of Alvar and returned to his home Island of Dagger Wound in the Ifarine Sea.  Seek him out there for his teachings in the Expert way of being a Merchant."
	evt.Set("AutonotesBits", 203)         -- "= Merchant   Expert   Dagger Wound Islands =  Fishner Thomb makes his home on the Islands of Dagger Wound."
end

-- "Fenton Iverson"
evt.global[481] = function()
	evt.SetMessage(481)         -- "Fenton Iverson, Master Merchant of Alvar, tests all who wish to advanced with the skills of a Merchant.  You will find Fenton in the merchant city of Alvar, where he can instruct you to Mastery of the Merchant skill."
	evt.Set("AutonotesBits", 204)         -- "= Merchant   Master   Alvar =  Fenton Iverson lives in the merchant city of Alvar."
end

-- "Raven Quicktoungue"
evt.global[482] = function()
	evt.SetMessage(482)         -- "Raven Quicktoungue, Grand Master Merchant of Alvar, dwells in the city of Ravenshore.  There, Raven can watch the interaction of numerous races as the trade with each other.  Only he can raise your knowledge to Grand Mastery of the merchant skill."
	evt.Set("AutonotesBits", 205)         -- "= Merchant   Grand    Ravenshore =  Raven Quicktoungue dwells in the city of Ravenshore."
end

-- "Evandar Lotts "
evt.global[483] = function()
	evt.SetMessage(483)         -- "Evandar Lotts teaches the Expert skills of Repairing Items.  He dwells in the seaside city of Ravenshore."
	evt.Set("AutonotesBits", 206)         -- "+ Repair Item   Expert   Ravenshore +  Evandar Lotts dwells in the seaside city of Ravenshore."
end

-- "Quick Jeni"
evt.global[484] = function()
	evt.SetMessage(484)         -- "Quick Jeni, is the Master of the Repair Item skill. She lives in the village around the Dargon Hunter's Fort in Garrote Gorge."
	evt.Set("AutonotesBits", 207)         -- "+ Repair Item   Master   Garrote Gorge +  Quick Jeni lives in the village around the Dragon Hunter's Fort in Garrote Gorge."
end

-- "Quethrin Tonk"
evt.global[485] = function()
	evt.SetMessage(485)         -- "Quethrin Tonk, Grand Master of the Repair Item skill, dwells in the tranquil Murmurwoods.  His skills have proven invaluable to the Temple of the Sun."
	evt.Set("AutonotesBits", 208)         -- "+ Repair Item   Grand    Murmurwoods +  Quethrin Tonk dwells in Murmurwoods."
end

-- "Menasaur"
evt.global[486] = function()
	evt.SetMessage(486)         -- "Menasaur, the strongest Lizardmen on the Dagger Wound Islands, is the Expert instructor of the Body Building skill. "
	evt.Set("AutonotesBits", 209)         -- "- Body Building   Expert   Dagger Wound Islands -  Menasaur lives on the Dagger Wound Islands."
end

-- "Kenneth Otterton"
evt.global[487] = function()
	evt.SetMessage(487)         -- "Kenneth Otterton, holds the title of Crusader, and serves under the knight Charles Quixote in Garrote Gorge.  Rumor has it that he wrestled a Dragon to the ground single-handedly.  Of course, other knights had to assist in the kill.  Kenneth also holds the title, Master Instructor of Body Building."
	evt.Set("AutonotesBits", 210)         -- "- Body Building   Master   Garrote Gorge -  Kenneth Otterton lives in the Dragon Hunter's Camp in Garrote Gorge."
end

-- "Mikel Smithson"
evt.global[488] = function()
	evt.SetMessage(488)         -- "Mikel Smithson, holds the title of Strongest in Jadame.  He is also the Grand Master of the Body Building skill.  Seek him out in the village of Rust in the Ironsand Desert if you wish to perfect the strength of your bodies."
	evt.Set("AutonotesBits", 211)         -- "- Body Building   Grand    Ironsand Desert -  Mikel Smithson. Seek him out in the village of Rust in the Ironsand Desert."
end

-- "Alton Putnam"
evt.global[489] = function()
	evt.SetMessage(489)         -- "Alton Putnam, is an Expert in the art of Meditation.  He can instruct you if you seek him out in the seaside city of Ravenshore."
	evt.Set("AutonotesBits", 212)         -- "= Meditation   Expert   Ravenshore =  Alton Putnam can instruct you if you seek him out in the seaside city of Ravenshore."
end

-- "Gretchin Nevermore"
evt.global[490] = function()
	evt.SetMessage(490)         -- "Gretchin Nevermore, instructs all Clerics of the Sun the Master arts of Meditation. He dwells in the Murmurwoods near the Temple of the Sun."
	evt.Set("AutonotesBits", 213)         -- "= Meditation   Master   Alvar =  Gretchin Nevermore dwells in the merchant city of Alvar."
end

-- "Lenord Nightcrawler"
evt.global[491] = function()
	evt.SetMessage(491)         -- "Lenord Nightcrawler, Grand Master of Meditation, serves as one of the foremost members of the Necromancers' Guild of Shadowspire.  He instructs all necromancers in the art of Meditation from his home in the village of Twilight."
	evt.Set("AutonotesBits", 214)         -- "= Meditation   Grand    Shadowspire =  Lenord Nightcrawler teaches from his home in the village of Twilight."
end

-- "Silk Nightwalker"
evt.global[492] = function()
	evt.SetMessage(492)         -- "Silk Nightwalker, Expert teacher of the Perception skill, makes his home in the Dark Elf city of Alvar.  Instructing the Merchants of Alvar in the skills needed to detect that which is supposed to remain secret occupies most of his time, however him may take the time to instruct you if luck is with you."
	evt.Set("AutonotesBits", 215)         -- "+ Perception   Expert   Alvar +  Silk Nightwalker makes his home in the Dark Elf city of Alvar."
end

-- "Helga Steeleye"
evt.global[493] = function()
	evt.SetMessage(493)         -- "Helga Steeleye, lives among the necromancers of Shadowspire in the village of Twilight.  The Necromancers' Guild is thankful for her Master level instructions in the skill of Perception."
	evt.Set("AutonotesBits", 216)         -- "+ Perception   Master   Shadowspire +  Helga Steeleye lives in the Shadowspire city of Twilight."
end

-- "Balan Suretrail"
evt.global[494] = function()
	evt.SetMessage(494)         -- "Grand Master Balan Suretrail lives in the Minotaur city of Balthazar Lair.  To gain his instruction in the skill of Perception, you must seek him out in Ravage Roaming."
	evt.Set("AutonotesBits", 217)         -- "+ Perception   Grand    Ravage Roaming +  Balan Suretrail lives in the Minotaur city of Balthazar Lair."
end

-- "Kethric Tarent"
evt.global[495] = function()
	evt.SetMessage(495)         -- "Kethric Tarent, teaches the Expert knowledge of Regeneration from his home in the Ironsand Desert, in the village of Rust."
	evt.Set("AutonotesBits", 218)         -- "- Regeneration   Expert   Ironsand Desert -  Kethric Tarent is in the Ironsand Desert village of Rust."
end

-- "William Sampson"
evt.global[496] = function()
	evt.SetMessage(496)         -- "William Sampson, Master of Regeneration, lives in the peace of the Murmurwoods.  He uses the libraries of the Temple of the Sun to further his knowledge of Trollish history."
	evt.Set("AutonotesBits", 219)         -- "- Regeneration   Master   Murmurwoods -  William Sampson lives in Murmurwoods."
end

-- "Ush the Many Tailed"
evt.global[497] = function()
	evt.SetMessage(497)         -- "Ush the Many Tailed, Grand Master of Regeneration and legendary warrior, lives among his people on Dagger Wound Island.  Legends say he has lost his tail thirteen times in battle against the Regnan Pirates, and each time he has grown a new tail!"
	evt.Set("AutonotesBits", 220)         -- "- Regeneration   Grand    Dagger Wound Islands -  Ush the Many Tailed lives among his people on the Dagger Wound Islands."
end

-- "Chevon Wist"
evt.global[498] = function()
	evt.SetMessage(498)         -- "Chevon Wist, teaches the Expert knowledge of the Disarm Trap skill, which has proven useful to those who explore the ruined temples near his home on the Dagger Wound Islands."
	evt.Set("AutonotesBits", 221)         -- "= Disarm Trap   Expert   Dagger Wound Islands =  Chevon Wist is on the Dagger Wound Islands."
end

-- "Kelli Lightfingers"
evt.global[499] = function()
	evt.SetMessage(499)         -- "Kelli Lightfingers, Master of Disarming Traps, has retired to her home in the merchant city of Alvar.  There she still teaches young merchants the skills of trapping and disarming chests.  If you are worthy she can raise your Disarm Trap skills to that of a Master."
	evt.Set("AutonotesBits", 222)         -- "= Disarm Trap   Master   Alvar =  Kelli Lightfingers teaches from her home in the city of Alvar."
end

-- "Gareth Lifter"
evt.global[500] = function()
	evt.SetMessage(500)         -- "Gareth Lifter, Grand Master of Disarming Traps, lives on the opulent island of Regna, where he teaches his fellow pirates in the best way to trap their chests of stolen booty."
	evt.Set("AutonotesBits", 223)         -- "= Disarm Trap   Grand    Regna =  Gareth Lifter teaches from his home on the island of Regna."
end

-- "Tessa Maker"
evt.global[507] = function()
	evt.SetMessage(507)         -- "Tessa Maker, Expert in Monster Identification, seeks to improve her skills by cataloging the different Dragons of Garrote Gorge.  She is currently in the service of the knight, Charles Quixote."
	evt.Set("AutonotesBits", 230)         -- "+ Identify Monster   Expert   Garrote Gorge +  Tessa Maker lives in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Matric Keenedge"
evt.global[508] = function()
	evt.SetMessage(508)         -- "Matric Keenedge, Master of the skill of Identify Monster, is currently studying the creatures of the Murmurwoods.  If you seek Mastery of this skill you need to seek him out there."
	evt.Set("AutonotesBits", 231)         -- "+ Identify Monster   Master   Murmurwoods +  Matric Keenedge can be found in Murmurwoods."
end

-- "Blacken Stonecleaver"
evt.global[509] = function()
	evt.SetMessage(509)         -- "Blacken Stonecleaver, Grand Master of Monster Identification, has seen every creature on the continent of Jadame.  He can teach you his knowledge if you find his home in the city of Ravenshore."
	evt.Set("AutonotesBits", 232)         -- "+ Identify Monster   Grand    Ravenshore +  Blacken Stonecleaver teaches his skill from his home in the city of Ravenshore."
end

-- "Norbert Slayer"
evt.global[510] = function()
	evt.SetMessage(510)         -- "Knight Norbert Slayer, instructs all of Charles Quixote's knights in the Expert forms of  Armsmastery.  If you travel to Garrote Gorge, you can attend one of his teachings."
	evt.Set("AutonotesBits", 233)         -- "- Armsmaster   Expert   Garrote Gorge -  Knight Norbert Slayer lives in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Lasatin the Scarred"
evt.global[511] = function()
	evt.SetMessage(511)         -- "Lasatin the Scarred, Master of the Armsmaster skill, lives on the Islands of Dagger Wound."
	evt.Set("AutonotesBits", 234)         -- "- Armsmaster   Master   Dagger Wound Islands -  Lasatin the Scarred lives on the Islands of Dagger Wound."
end

-- "Jasper Steelcoif"
evt.global[512] = function()
	evt.SetMessage(512)         -- "Jasper Steelcoif, Grand Master of the Armsmaster skill, is one of the leaders of the Regnan Pirate Council.  He instructs all pirates in the use of weapons.  If you are brave enough to travel to Regna--and survive his instruction--you too, will have Grand Mastery of this skill."
	evt.Set("AutonotesBits", 235)         -- "- Armsmaster   Grand    Regna -  Jasper Steelcoif can be found on Regna Island."
end

-- "Tabitha Watershed"
evt.global[516] = function()
	evt.SetMessage(516)         -- "Tabitha Watershed, Expert Alchemist, teaches the skills of potions and poultices from her home in the merchant city of Alvar."
	evt.Set("AutonotesBits", 239)         -- "= Alchemy   Expert   Alvar =  Tabitha Watershed teaches from her home in the merchant city of Alvar."
end

-- "Kethry Treasurestone"
evt.global[517] = function()
	evt.SetMessage(517)         -- "Kethry Treasurestone, Master Alchemist, lives in the Murmurwoods, studying plants and mushrooms that grow in that peaceful forest."
	evt.Set("AutonotesBits", 240)         -- "= Alchemy   Master   Murmurwoods =  Kethry Treasurestone lives in the Murmurwoods region."
end

-- "Ich"
evt.global[518] = function()
	evt.SetMessage(518)         -- "Ich, Grand Master of Alchemy, has studied the art of brewing for decades.  He knows all there is to know about blending reagents into beneficial and harmful potions.  Seek out his home in the lush jungles of the Dagger Wound Islands."
	evt.Set("AutonotesBits", 241)         -- "= Alchemy   Grand    Dagger Wound Islands =  Ich teaches from his home in the lush jungles of the Dagger Wound Islands."
end

-- "Petra Mithrit"
evt.global[519] = function()
	evt.SetMessage(519)         -- "Petra Mithrit, Expert in the skill of Learning, dwells near the Temple of the Sun in the Murmurwoods."
	evt.Set("AutonotesBits", 242)         -- "+ Learning   Expert   Murmurwoods +  Petra Mithrit dwells near the Temple of the Sun in the Murmurwoods."
end

-- "Garret Mistspring"
evt.global[520] = function()
	evt.SetMessage(520)         -- "Garret Mistspring, Master of Learning, instructs all students of necromancy in the art of Learning.  For this the Necromancers' Guild rewards him well.  His home is in the hamlet of Twilight at the base of the Shadowspire."
	evt.Set("AutonotesBits", 243)         -- "+ Learning   Master   Shadowspire +  Garret Mistspring instructs students from his home is in the Shadowspire city of Twilight."
end

-- "Wanda Lightsworn"
evt.global[521] = function()
	evt.SetMessage(521)         -- "Wanda Lightsworn, Grand Master of Learning, is in the hire of Charles Quixote, and instructs all of his knights in the skills of Learning.  It is the hope of Charles Quixote that this will give his forces and edge in battle against the Dragons of Garrote Gorge."
	evt.Set("AutonotesBits", 244)         -- "+ Learning   Grand    Garrote Gorge +  Wanda Lightsworn lives in the Garrote Gorge Dragon Hunter's Camp."
end

-- "Flynn Shador"
evt.global[522] = function()
	evt.SetMessage(522)         -- "Flynn Shador, Expert Vampire, lives in the city of Twilight, serving as eyes and a safe house for any Vampires that travel to that region.  He can instruct you in the Expert abilities of a Vampire."
	evt.Set("AutonotesBits", 194)         -- "= Vampire   Expert   Shadowspire =  Flynn Shador lives in the Shadowspire city of Twilight."
end

-- "Douglas Dirthmoore"
evt.global[523] = function()
	evt.SetMessage(523)         -- "Douglas Dirthmoore, Master Vampire, will teach any whose skills measure up to his standards.  Once he is done with you, you will have Mastered the abilities native to all Vampires.  His home is in the Shadowspire village of Twilight."
	evt.Set("AutonotesBits", 195)         -- "= Vampire   Master   Shadowspire =  Douglas Dirthmoore makes his home in the Shadowspire city of Twilight."
end

-- "Payge Arachnia"
evt.global[524] = function()
	evt.SetMessage(524)         -- "Though no one knows for sure, Payge Arachnia, Grand Master Vampire, is rumored to be the first Vampire on the continent of Jadame. She knows all there is to be known about living as a Vampire and can teach you the Grand Master abilities she possesses.  Seek out her lair in Shadowspire."
	evt.Set("AutonotesBits", 196)         -- "= Vampire   Grand    Shadowspire =  Payge Arachnia lives in her lair located in Shadowspire."
end

-- "Fedwin Dervish"
evt.global[525] = function()
	evt.SetMessage(525)         -- "Fedwin Dervish, can instruct you in the Expert ways of the Dark Elf.  Once you have learned from him, you will have begun a great journey to becoming a leader of your people.  Search him out in the Dark Elf city of Alvar."
	evt.Set("AutonotesBits", 191)         -- "- Dark Elf   Expert   Alvar -  Fedwin Dervish. Search him out in the Dark Elf city of Alvar."
end

-- "Lanshee Caverhill"
evt.global[526] = function()
	evt.SetMessage(526)         -- "Lanshee Caverhill, Master Merchant of Alvar currently lives in the seaside port of Ravenshore.  She knows all about Mastering the natural abilities all Dark Elves have."
	evt.Set("AutonotesBits", 192)         -- "- Dark Elf   Master   Ravenshore -  Lanshee Caverhill lives in the seaside port of Ravenshore."
end

-- "Ton Agraynel"
evt.global[527] = function()
	evt.SetMessage(527)         -- "Ton Agraynel, Master Merchant of Alvar, can instruct you in the Grand Master skills of a Dark Elf.  You will have to prove yourself worthy of his instruction, but the benefits are well worth the effort."
	evt.Set("AutonotesBits", 193)         -- "- Dark Elf   Grand    Alvar -  Ton Agraynel lives in the city of Alvar."
end

-- "Ishton"
evt.global[528] = function()
	evt.SetMessage(528)         -- "Ishton, Junior Flight Leader of the Dragons of Garrote Gorge, instructs all young Dragons to an Expert skill level with their racial Dragon abilities.  He dwells here, in the Dragon Caves of Garrote Gorge."
	evt.Set("AutonotesBits", 197)         -- "+ Dragon   Expert   Garrote Gorge +  Ishton dwells in the Dragon Caves of Garrote Gorge."
end

-- "Erthint"
evt.global[529] = function()
	evt.SetMessage(529)         -- "Master Dragon Erthint is the Flight Leader of all of the Dragons that serve under Deftclaw Redreaver, and can instruct a Dragon in Mastery of his natural Dragon abilities. Erthint lives in the Dragon Caves of Garrote Gorge."
	evt.Set("AutonotesBits", 198)         -- "+ Dragon   Master   Garrote Gorge +  Erthint lives in the Dragon Caves of Garrote Gorge."
end

-- "Klain Scarwing"
evt.global[530] = function()
	evt.SetMessage(530)         -- "Klain Scarwing, is second in strength only to Deftclaw Redreaver himself.  Klain holds the title of Grand Master Dragon and instructs all Dragons in the use of their natural abilities.  See him if you wish to attain Grand Master status.  He dwells here in the Dragon Caves of Garrote Gorge."
	evt.Set("AutonotesBits", 199)         -- "+ Dragon   Grand    Garrote Gorge +  Klain dwells in the Dragon Caves of Garrote Gorge."
end

-- "Haste Pedestal"
evt.global[531] = function()
	evt.CastSpell{Spell = 5, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Haste"
end

-- "Earth Resistance Pedestal"
evt.global[532] = function()
	evt.CastSpell{Spell = 36, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Earth Resistance"
end

-- "Day of the Gods Pedestal"
evt.global[533] = function()
	evt.CastSpell{Spell = 83, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Day of the Gods"
end

-- "Shield Pedestal"
evt.global[534] = function()
	evt.CastSpell{Spell = 17, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Shield"
end

-- "Water Resistance Pedestal"
evt.global[535] = function()
	evt.CastSpell{Spell = 25, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Water Resistance"
end

-- "Fire Resistance Pedestal"
evt.global[536] = function()
	evt.CastSpell{Spell = 3, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Fire Resistance"
end

-- "Heroism Pedestal"
evt.global[537] = function()
	evt.CastSpell{Spell = 51, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Heroism"
end

-- "Immolation Pedestal"
evt.global[538] = function()
	evt.CastSpell{Spell = 8, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Immolation"
end

-- "Mind Resistance Pedestal"
evt.global[539] = function()
	evt.CastSpell{Spell = 58, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Mind Resistance"
end

-- "Body Resistance Pedestal"
evt.global[540] = function()
	evt.CastSpell{Spell = 69, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Body Resistance"
end

-- "Stone Skin Pedestal"
evt.global[541] = function()
	evt.CastSpell{Spell = 38, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Stone Skin"
end

-- "Air Resistance Pedestal"
evt.global[542] = function()
	evt.CastSpell{Spell = 14, Mastery = const.GM, Skill = 5, FromX = 0, FromY = 0, FromZ = 0, ToX = 0, ToY = 0, ToZ = 0}         -- "Air Resistance"
end

-- "Game of Might"
evt.global[543] = function()
	if evt.Cmp("PlayerBits", 31) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 31)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Endurance"
evt.global[544] = function()
	if evt.Cmp("PlayerBits", 32) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 32)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Intellect"
evt.global[545] = function()
	if evt.Cmp("PlayerBits", 33) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 33)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Personality"
evt.global[546] = function()
	if evt.Cmp("PlayerBits", 34) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 34)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Accuracy"
evt.global[547] = function()
	if evt.Cmp("PlayerBits", 35) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 35)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Speed"
evt.global[548] = function()
	if evt.Cmp("PlayerBits", 36) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 36)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Game of Luck"
evt.global[549] = function()
	if evt.Cmp("PlayerBits", 37) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 25) then
		evt.Add("SkillPoints", 3)
		evt.StatusText(734)         -- "You win!  +3 Skill Points"
		evt.Add("PlayerBits", 37)
	else
		evt.StatusText(729)         -- "You have failed the game!"
	end
end

-- "Contest of Might"
evt.global[550] = function()
	if evt.Cmp("PlayerBits", 38) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 38)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Endurance"
evt.global[551] = function()
	if evt.Cmp("PlayerBits", 39) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 39)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Intellect"
evt.global[552] = function()
	if evt.Cmp("PlayerBits", 40) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 40)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Personality"
evt.global[553] = function()
	if evt.Cmp("PlayerBits", 41) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 41)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Accuracy"
evt.global[554] = function()
	if evt.Cmp("PlayerBits", 42) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 42)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Speed"
evt.global[555] = function()
	if evt.Cmp("PlayerBits", 43) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 43)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Contest of Luck"
evt.global[556] = function()
	if evt.Cmp("PlayerBits", 44) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 50) then
		evt.Add("SkillPoints", 5)
		evt.StatusText(735)         -- "You win!  +5 Skill Points"
		evt.Add("PlayerBits", 44)
	else
		evt.StatusText(730)         -- "You have failed the contest!"
	end
end

-- "Test of Might"
evt.global[557] = function()
	if evt.Cmp("PlayerBits", 45) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 45)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Endurance"
evt.global[558] = function()
	if evt.Cmp("PlayerBits", 46) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 46)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Intellect"
evt.global[559] = function()
	if evt.Cmp("PlayerBits", 47) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 47)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Personality"
evt.global[560] = function()
	if evt.Cmp("PlayerBits", 48) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 48)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Accuracy"
evt.global[561] = function()
	if evt.Cmp("PlayerBits", 49) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 49)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Speed"
evt.global[562] = function()
	if evt.Cmp("PlayerBits", 50) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 50)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Test of Luck"
evt.global[563] = function()
	if evt.Cmp("PlayerBits", 51) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 100) then
		evt.Add("SkillPoints", 7)
		evt.StatusText(736)         -- "You win!  +7 Skill Points"
		evt.Add("PlayerBits", 51)
	else
		evt.StatusText(731)         -- "You have failed the test!"
	end
end

-- "Challenge of Might"
evt.global[564] = function()
	if evt.Cmp("PlayerBits", 52) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentMight", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 52)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Endurance"
evt.global[565] = function()
	if evt.Cmp("PlayerBits", 53) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentEndurance", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 53)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Intellect"
evt.global[566] = function()
	if evt.Cmp("PlayerBits", 54) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentIntellect", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 54)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Personality"
evt.global[567] = function()
	if evt.Cmp("PlayerBits", 55) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentPersonality", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 55)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Accuracy"
evt.global[568] = function()
	if evt.Cmp("PlayerBits", 56) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentAccuracy", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 56)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Speed"
evt.global[569] = function()
	if evt.Cmp("PlayerBits", 57) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentSpeed", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 57)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Challenge of Luck"
evt.global[570] = function()
	if evt.Cmp("PlayerBits", 58) then
		evt.StatusText(733)         -- "You have already won!"
	elseif evt.Cmp("CurrentLuck", 200) then
		evt.Add("SkillPoints", 10)
		evt.StatusText(737)         -- "You win!  +10 Skill Points"
		evt.Add("PlayerBits", 58)
	else
		evt.StatusText(732)         -- "You have failed the challenge!"
	end
end

-- "Fire Resistance Potion"
evt.CanShowTopic[571] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[571] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 143)         -- Delivered potion to house 1
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
		if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
			if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
				if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
					if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
						evt.ForPlayer("All")
						evt.Add("Experience", 7500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Fire Resistance Potion"
evt.CanShowTopic[572] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[572] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 144)         -- Delivered potion to house 2
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
			if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
				if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
					if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
						evt.ForPlayer("All")
						evt.Add("Experience", 1500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Fire Resistance Potion"
evt.CanShowTopic[573] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[573] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 145)         -- Delivered potion to house 3
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
			if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
				if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
					if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
						evt.ForPlayer("All")
						evt.Add("Experience", 1500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Fire Resistance Potion"
evt.CanShowTopic[574] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[574] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 146)         -- Delivered potion to house 4
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
			if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
				if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
					if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
						evt.ForPlayer("All")
						evt.Add("Experience", 1500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Fire Resistance Potion"
evt.CanShowTopic[575] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[575] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 147)         -- Delivered potion to house 5
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
			if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
				if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
					if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
						evt.ForPlayer("All")
						evt.Add("Experience", 1500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Fire Resistance Potion"
evt.CanShowTopic[576] = function()
	return evt.Cmp("QBits", 142)         -- "Deliver Fire Resistance Potions to the six southernmost houses of Rust.  Return to Hobert in Rust."
end

evt.global[576] = function()
	if evt.Cmp("QBits", 149) then         -- Southern houses of Rust all have Potions of Fire Resistance.
		evt.SetMessage(654)         -- "You have at least pushed our demise away for a time, but a new home needs to be found for us!  Thank you for delivering the Potions of Fire Resistance!"
		return
	end
	if evt.Cmp("QBits", 148) then         -- Delivered potion to house 6
		evt.SetMessage(763)         -- "Thanks for the potion!"
	else
		evt.ForPlayer("All")
		if not evt.Cmp("Inventory", 256) then         -- "Fire Resistance"
			evt.SetMessage(762)         -- "I an defenseless against the onslaught of the sea of fire!  I need a Potion of Fire Resistance!"
			return
		end
		evt.Subtract("Inventory", 256)         -- "Fire Resistance"
		evt.Add("QBits", 148)         -- Delivered potion to house 6
		evt.ForPlayer("All")
		evt.Add("Experience", 1000)
	end
	if evt.Cmp("QBits", 143) then         -- Delivered potion to house 1
		if evt.Cmp("QBits", 144) then         -- Delivered potion to house 2
			if evt.Cmp("QBits", 145) then         -- Delivered potion to house 3
				if evt.Cmp("QBits", 146) then         -- Delivered potion to house 4
					if evt.Cmp("QBits", 147) then         -- Delivered potion to house 5
						evt.ForPlayer("All")
						evt.Add("Experience", 1500)
						evt.SetMessage(764)         -- "Thanks for providing Potions of Fire Resistance to the southernmost houses here in Rust.  Perhaps we can survive until a new home can be found for us!"
						evt.Add("QBits", 149)         -- Southern houses of Rust all have Potions of Fire Resistance.
						return
					end
				end
			end
		end
	end
	evt.SetMessage(761)         -- "Thanks for the potion, but others in the area are without protection!  Be sure to deliver a potion to them as well!"
end

-- "Guild of Bounty Hunters"
evt.global[577] = function()
	if evt.Cmp("QBits", 169) then         -- Named Novice Bounty Hunter by the Guild of Bounty Hunters
		evt.SetMessage(647)         -- "Greetings Novice Bounty Hunter! The Guild of Bounty Hunters serves the public by paying qualified individuals a fee for eliminating the threat of certain creatures or bandits in the realm of Jadame.  To achieve the rank of Journeyman Bounty Hunter you will have to earn a total bounty of 30,000 gold."
	elseif evt.Cmp("QBits", 170) then         -- Named Journeyman Bounty Hunter by the Guild of Bounty Hunters
		evt.SetMessage(656)         -- "Greetings Journeyman Bounty Hunter! The Guild of Bounty Hunters serves the public by paying qualified individuals a fee for eliminating the threat of certain creatures or bandits in the realm of Jadame.  To achieve the rank of Master Bounty Hunter you will have to earn a total bounty of 70,000 gold."
	elseif evt.Cmp("QBits", 171) then         -- Named Novice Master Hunter by the Guild of Bounty Hunters
		evt.SetMessage(678)         -- "Greetings Master Bounty Hunter! The Guild of Bounty Hunters thanks you for your services to all of Jadame. We are at your disposal!"
	else
		evt.SetMessage(625)         -- "The Guild of Bounty Hunters serves the public by paying qualified individuals a fee for eliminating the threat of certain creatures or bandits in the realm of Jadame.  To achieve the rank of Novice Bounty Hunter you will have to earn 10,000 gold worth of bounties."
	end
end

-- "Bounty!"
evt.global[578] = function()
	if evt.IsTotalBountyInRange{MinGold = 10000, MaxGold = 29999} then
		evt.SetMessage(779)         -- "You currently hold the rank of Novice Bounty Hunter, but lack sufficient bounty to be promoted to Journeyman."
		evt.ForPlayer(0)
		if not evt.Cmp("Awards", 38) then         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(0)
			evt.Add("Experience", 40000)
		end
		evt.ForPlayer(1)
		if not evt.Cmp("Awards", 38) then         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(1)
			evt.Add("Experience", 40000)
		end
		evt.ForPlayer(2)
		if not evt.Cmp("Awards", 38) then         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(2)
			evt.Add("Experience", 40000)
		end
		evt.ForPlayer(3)
		if not evt.Cmp("Awards", 38) then         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(3)
			evt.Add("Experience", 40000)
		end
		evt.ForPlayer(4)
		if not evt.Cmp("Awards", 38) then         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(4)
			evt.Add("Experience", 40000)
		end
		evt.ForPlayer("All")
		evt.Add("QBits", 169)         -- Named Novice Bounty Hunter by the Guild of Bounty Hunters
		return
	end
	if evt.IsTotalBountyInRange{MinGold = 30000, MaxGold = 69999} then
		evt.SetMessage(780)         -- "You currently hold the rank of Journeyman Bounty Hunter, but lack sufficient bounty to be promoted to Master."
		evt.ForPlayer(0)
		if not evt.Cmp("Awards", 39) then         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Subtract("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.ForPlayer(0)
			evt.Add("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Add("Experience", 80000)
		end
		evt.ForPlayer(1)
		if not evt.Cmp("Awards", 39) then         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Subtract("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
			evt.ForPlayer(1)
			evt.Add("Experience", 80000)
		end
		evt.ForPlayer(2)
		if not evt.Cmp("Awards", 39) then         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Subtract("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
			evt.ForPlayer(2)
			evt.Add("Experience", 80000)
		end
		evt.ForPlayer(3)
		if not evt.Cmp("Awards", 39) then         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Subtract("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
			evt.ForPlayer(3)
			evt.Add("Experience", 80000)
		end
		evt.ForPlayer(4)
		if not evt.Cmp("Awards", 39) then         -- "Have earned status of Journeyman Bounty Hunter."
			evt.Subtract("Awards", 38)         -- "Have earned status of Novice Bounty Hunter."
			evt.Add("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
			evt.ForPlayer(4)
			evt.Add("Experience", 80000)
		end
		evt.ForPlayer("All")
		evt.Subtract("QBits", 169)         -- Named Novice Bounty Hunter by the Guild of Bounty Hunters
		evt.Add("QBits", 170)         -- Named Journeyman Bounty Hunter by the Guild of Bounty Hunters
		return
	end
	if not evt.IsTotalBountyInRange{MinGold = 70000, MaxGold = 1000000} then
		evt.SetMessage(778)         -- "You have not gathered sufficient bounties to allow us to promote you!"
		return
	end
	evt.SetMessage(781)         -- "You currently hold the rank of Master Bounty Hunter! This is the highest rank of our guild."
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 40) then         -- "Have earned status of Master Bounty Hunter."
		evt.Subtract("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
		evt.Add("Awards", 40)         -- "Have earned status of Master Bounty Hunter."
		evt.ForPlayer(0)
		evt.Add("Experience", 1200000)
	end
	evt.ForPlayer(1)
	if not evt.Cmp("Awards", 40) then         -- "Have earned status of Master Bounty Hunter."
		evt.Subtract("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
		evt.Add("Awards", 40)         -- "Have earned status of Master Bounty Hunter."
		evt.ForPlayer(1)
		evt.Add("Experience", 1200000)
	end
	evt.ForPlayer(2)
	if not evt.Cmp("Awards", 40) then         -- "Have earned status of Master Bounty Hunter."
		evt.Subtract("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
		evt.Add("Awards", 40)         -- "Have earned status of Master Bounty Hunter."
		evt.ForPlayer(2)
		evt.Add("Experience", 1200000)
	end
	evt.ForPlayer(3)
	if not evt.Cmp("Awards", 40) then         -- "Have earned status of Master Bounty Hunter."
		evt.Subtract("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
		evt.Add("Awards", 40)         -- "Have earned status of Master Bounty Hunter."
		evt.ForPlayer(3)
		evt.Add("Experience", 1200000)
	end
	evt.ForPlayer(4)
	if not evt.Cmp("Awards", 40) then         -- "Have earned status of Master Bounty Hunter."
		evt.Subtract("Awards", 39)         -- "Have earned status of Journeyman Bounty Hunter."
		evt.Add("Awards", 40)         -- "Have earned status of Master Bounty Hunter."
		evt.ForPlayer(4)
		evt.Add("Experience", 1200000)
	end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 170)         -- Named Journeyman Bounty Hunter by the Guild of Bounty Hunters
	evt.Add("QBits", 171)         -- Named Novice Master Hunter by the Guild of Bounty Hunters
	evt.SetNPCTopic{NPC = 297, Index = 2, Event = 0}         -- "Bryant Conlan"
	evt.SetNPCTopic{NPC = 298, Index = 2, Event = 0}         -- "Cahalli Evenall"
end

-- "Arcomage Tournament "
evt.global[580] = function()
	evt.SetMessage(540)         -- "To be declared Arcomage Champion, you must win a game of Arcomage in every tavern on, in, and under the continent of Jadame.  There are 11 such taverns sponsoring Arcomage events.  When you have accomplished this, return to me to claim the prize."
	evt.Add("QBits", 173)         -- "Win a game of Arcomage in all eleven taverns, then return to Tonk Blueswan in Ravenshore."
	evt.SetNPCTopic{NPC = 410, Index = 0, Event = 0}         -- "Tonk Blueswan"
end

-- "Cleric Necromancer War"
evt.global[581] = function()
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.SetMessage(783)         -- "Through your delivery of the Nightshade Brazier into their hands, the Necromancers' Guild has come out on top in their war with the Temple of the Sun. The artifact's magic creates a permanent shadow of darkness which surrounds the Shadowspire region. Under this cover, vampires defend the land both day and night. This has allowed the guild to field larger forces of skeletons, zombies and other undead against the temple's armies. Each report I receive puts the heart of the battle closer and closer to the Sun Temple's doorstep."
	elseif evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		evt.SetMessage(784)         -- "Because you have destroyed the Necromancers' Guild Skeleton Transformer, the Temple of the Sun has come out on top in their war with the guild. The skeletons created by the device made up the bulk of the guild's reinforcements. Without these, the necromancers' forces crumble before the temple's advance. Each report I receive puts the heart of the battle closer to the Necromancers' Guild doorstep."
	else
		evt.SetMessage(782)         --[[ "Lying as they do on opposite ends of the Light to Dark spectrum, relationships between the Necromancers' Guild and the Temple of the Sun have never been the best, but now they battle openly. Oskar Tyre, head priest of the Temple says a holy vision drove him to declare war on the guild so as to rid Jadame of the taint of darkness.

Both groups are relative newcomers to our continent. The guild has set up its foothold in Shadowspire, and the First (and only) Sun Temple of Jadame is in Murmurwoods." ]]
	end
end

-- "Dragon Hunters"
evt.global[582] = function()
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.SetMessage(786)         -- "It seems Charles Quixote's Dragon hunting operation in Garrote Gorge has almost completely wiped out Garrote Gorge's Dragon population. I'm sure once their done, those mountains will be safer to travel. Still, I wonder what Jadame will be like without Dragons."
	elseif evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
		evt.SetMessage(787)         -- "By recovering Deftclaw Redreaver's heir for him, you've allowed him to safely attack Charles Quixote's camp. Dragon hunters operate by isolating members of their prey. They just aren't prepared to face Dragons in number! Needless to say, the camp's production of Dragon goods has dwindled to a trickle. A pity. The guild used to turned a good profit off them."
	else
		evt.SetMessage(785)         -- "The renown Dragon slayer, Charles Quixote of Erathia, has set up a hunting expedition in Garrote Gorge. This is no ""safari,"" in fact, it's the largest operation of this type I've heard of. The hunters have a permanent base from which they sell hides, eggs, baby dragons, and other items. Garrote Gorge has always had a large Dragon population, but I imagine they must be facing extinction--so efficient are Quixote's hunters."
	end
end

-- "Minotaurs"
evt.global[583] = function()
	if evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.SetMessage(789)         -- "By rescuing the Balthazar Lair Minotaurs, you have ingratiated them to yourselves and by extension, to our guild. Even through the crisis, trade relations with them have improved immeasurably. Once maters of the cataclysm are resolved, I'm sure we will see a tidy profit--a direct result from your good work."
	else
		evt.SetMessage(788)         -- "The Minotaurs of Balthazar Lair in Ravage Roaming are a proud culture. Their recent defeat of the Vori Frost Giants has, if anything, made them even more fiercely independent--more sure of their ability to face any task alone. Still, I have told the guild that they would make great allies, both to face the current crisis and later as trade partners."
	end
end

-- "A bridge too far?"
evt.global[584] = function()
	if evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.SetMessage(793)         -- "You have repaired the Portals of Stone?  We are all in your debt.  If only it was safe to travel through the Abandoned Temple!  Well, at least we can attempt to get to the boat dock through there."
	else
		evt.SetMessage(792)         -- "With the bridges destroyed by the eruption of the mountain of fire, we cannot get to the boat dock!  We are cut off from the mainland!"
	end
end

-- "Travel between the Islands"
evt.global[585] = function()
	if evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.SetMessage(802)         -- "With the Portals of Stone repaired, we can at least check on the outer islands and those who live there.  We are in your debt for fixing the Portals of Stone."
	else
		evt.SetMessage(801)         -- "We used to travel freely between the islands using the bridges.  These bridges were destroyed when the mountain of fire erupted.  Many families are trapped on the outer islands.  We don’t even know if the people who live there are still alive."
	end
end

-- "The boat dock"
evt.global[586] = function()
	if evt.Cmp("QBits", 2) then         -- Activate Area 1 teleporters 5 and 6.
		evt.SetMessage(804)         -- "We can get to the boat docks?  But we have to go through the Abandoned Temple?  Well that's something.  At least we can get to the boats."
	else
		evt.SetMessage(803)         -- "The boat dock on the northernmost island is the only way to travel between Dagger Wound and the mainland.  With the bridges destroyed, we cannot get to the boat dock and those arriving from Ravenshore cannot get to the village of Blood Drop!"
	end
end

-- "Kreegans"
evt.global[587] = function()
	evt.SetMessage(795)         -- "Did you know I was their captive for over six years? At first, I thought they were devils from hell, but now I am not so sure. They looked like devils surely, but did not act as demons. No, I think they were but another type of monstrous race, like ogres or goblins. Regardless, devils or not, I am glad the world is rid of them!"
end

-- "Elemental Lords"
evt.global[588] = function()
	evt.SetMessage(796)         -- "Catherine and I have had dealings with these ""lords"" of the elemental planes. I've never trusted them, and now it seems I am right. They were our recent allies against the Kreegans, but a few months later, we find ourselves at war with them here! In both cases I understand neither their reasons for helping or hindrance. They are fickle beings at best...""treacherous"" is perhaps a better word for them."
end

-- "Enroth"
evt.global[589] = function()
	evt.SetMessage(797)         -- "I must say I'm looking forward to returning to my lands of Enroth. It has been so long since I've seen them, or my son, Prince Nicolai. He was just a lad when I saw him last and now he is nearly grown. Sir Humphrey was a good choice for regent, but the land has been too long without its king at the reins of state."
end

-- "Erathia"
evt.global[590] = function()
	evt.SetMessage(798)         -- "After we defeated the Kreegans in Erathia, I abdicated my throne into the regenthood of one of my generals, Morgan Kendal. I have left in his capable hands the task of choosing Erathia's new ruler. I'm sure this seems to be much to give up, but I am first and foremost, the queen of Enroth. We were sailing for there when the cataclysm struck, drawing us here."
end

-- "Kreegans"
evt.global[591] = function()
	evt.SetMessage(799)         -- "The Kreegans? They are no more; I am sure of it. After we put down Lucifer Kreegan, my armies scoured Eofol searching for any signs of their continued existence. We found none. No, the Kreegan infestation of our world is eliminated."
end

-- "Elementals"
evt.global[592] = function()
	evt.SetMessage(800)         -- "I fought alongside elementals in our campaigns against the Kreegan. I found them stalwart and loyal. I know Roland disagrees, but I cannot call their hostility here a case of fickleness. No, I think something else drives them to attack us--magic perhaps? You should speak with our sage, Xanthor. He has been studying the Destroyer's crystal. I'm sure he's come up with some theory by now."
end

-- "Make Weapon"
evt.global[594] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
		evt.SetMessage(534)         -- "Here's your weapon. If you find more ore, I'll be happy to make you more weapons."
	else
		evt.SetMessage(535)         -- "You need ore for me to create weapons.  The better the ore, the better the weapon I can make."
	end
end

-- "Make Armor"
evt.global[595] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(536)         -- "Here's your armor. If you find more ore, I'll be happy to make you more armor."
	else
		evt.SetMessage(537)         -- "You need ore for me to create armor.  The better the ore, the better the armor I can make."
	end
end

-- "Make Item"
evt.global[596] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
		evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
		evt.GiveItem{Strength = 5, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
		evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
		evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
		evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
		evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
		evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
		evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	elseif evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
		evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
		evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(538)         -- "Here is your item. If you find more ore, I'll be happy to make you more items."
	else
		evt.SetMessage(539)         -- "You need ore for me to create items.  The better the ore, the better the items I can make."
	end
end

-- "Arcomage Tournament "
evt.global[597] = function()
	if evt.Cmp("QBits", 174) then         -- Won all Arcomage games
		evt.SetMessage(542)         -- "Congratulations!  You have become the Arcomage Champion!  The prize is waiting in the chest right outside my house."
		evt.Subtract("QBits", 173)         -- "Win a game of Arcomage in all eleven taverns, then return to Tonk Blueswan in Ravenshore."
		evt.Subtract("QBits", 174)         -- Won all Arcomage games
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 175)         -- Finished ArcoMage Quest - Get the treasure
		evt.Add("Awards", 41)         -- "Arcomage Champion."
		evt.SetNPCGreeting{NPC = 410, Greeting = 0}         -- "Tonk Blueswan" : ""
		evt.SetNPCTopic{NPC = 410, Index = 1, Event = 0}         -- "Tonk Blueswan"
	elseif evt.Cmp("QBits", 173) then         -- "Win a game of Arcomage in all eleven taverns, then return to Tonk Blueswan in Ravenshore."
		evt.SetMessage(541)         -- "You must claim a victory at ALL 11 taverns.  Until you do, you cannot be declared Arcomage Champion."
	else
		evt.SetMessage(540)         -- "To be declared Arcomage Champion, you must win a game of Arcomage in every tavern on, in, and under the continent of Jadame.  There are 11 such taverns sponsoring Arcomage events.  When you have accomplished this, return to me to claim the prize."
		evt.Add("QBits", 173)         -- "Win a game of Arcomage in all eleven taverns, then return to Tonk Blueswan in Ravenshore."
	end
end

-- "Rock Spire"
evt.global[598] = function()
	if evt.Cmp("PerceptionSkill", 1) then
		evt.SummonObject{Item = 35, X = 4010, Y = 7736, Z = 544, Speed = 1000, Count = 1, RandomAngle = false}         -- "Minotaur Battleaxe" : "Minotaur Battleaxe"
		evt.SummonObject{Item = 36, X = 4010, Y = 7736, Z = 544, Speed = 1000, Count = 1, RandomAngle = false}         -- "Two-Handed Axe" : "Two-Handed Axe"
		evt.SummonObject{Item = 37, X = 4010, Y = 7736, Z = 544, Speed = 1000, Count = 1, RandomAngle = false}         -- "Footman's Axe" : "Footman's Axe"
		evt.SummonObject{Item = 38, X = 4010, Y = 7736, Z = 544, Speed = 1000, Count = 1, RandomAngle = false}         -- "Minotaur War Axe" : "Minotaur War Axe"
		evt.SummonObject{Item = 39, X = 4010, Y = 7736, Z = 544, Speed = 1000, Count = 1, RandomAngle = false}         -- "Elite Minotaur Axe" : "Elite Minotaur Axe"
		evt.StatusText(805)         -- ""
	else
		evt.Set("DiseasedGreen", 0)
		evt.StatusText(806)         -- ""
	end
end

-- "My Life"
evt.global[654] = function()
	if evt.Cmp("QBits", 179) then         -- Quests 176-178 done.
		evt.SetMessage(816)         -- "With the cheeses you have brought me, I have now eaten all of the world's known cheeses. Now none can say that I, Asael Fromago, am not history's most eminent connoisseur of cheese! None can compare to my glory! Ha-ha-ha…"
	else
		evt.SetMessage(815)         -- "Even as a lad I knew I had a special relationship with cheese. Why, my first memory is of nibbling a bit of farmer's cheddar from my mother's hand! From that day I knew it would be my passion to eat cheese, to know all of the endless variety of its tasty wonderment, and to search the world for rare and exotic cheese-stuff. And so have I made my life...and destiny."
	end
end

-- "Vori Cheese Masters"
evt.global[655] = function()
	evt.SetMessage(814)         -- "There are no people more dedicated to cheesecraft than the august cheese masters of Vori. Otherwise known to be rather barbaric, the Vori Frost Giants are true emblems of the potential of civilized development--at least as far as cheese making is concerned. Did you know that they have forty-two different words for ""cheese."""
end

-- "Quest"
evt.global[656] = function()
	if not evt.Cmp("QBits", 176) then         -- "Find a wheel of Frelandeau Cheese. Bring it to Asael Fromago in Alvar."
		evt.SetMessage(810)         -- "I have traveled to these lands to catalog its array of available cheese. My task is nearly complete, but there are yet three cheeses I have yet to sample. These are Frelandeau, Eldenbrie and Dunduck. I would reward highly any who could locate these rare and reputedly tasty culinary gems for me."
		evt.Add("QBits", 176)         -- "Find a wheel of Frelandeau Cheese. Bring it to Asael Fromago in Alvar."
		evt.Add("QBits", 177)         -- "Find a log of Eldenbrie Cheese. Bring it to Asael Fromago in Alvar."
		evt.Add("QBits", 178)         -- "Find a ball of Dunduck Cheese. Bring it to Asael Fromago in Alvar."
		return
	end
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 658) then         -- "Wheel of Frelandeau"
		if evt.Cmp("Inventory", 659) then         -- "Log of Eldenbrie"
			if evt.Cmp("Inventory", 660) then         -- "Ball of Dunduck"
				evt.SetMessage(813)         --[[ "Excellent! Give me the cheeses! I must consume them!

Ah….munch munch….frelandeau, exquisite….mmmm, and eldenbrie, wondrously smoky…and hmmm, dunduck…well, that's not very nice, is it?

You have made my Jadamean cheese cataloging safari a success! I can die a happy man! You have the humble thanks of a man of cheese. And here is your promised reward!" ]]
				evt.ForPlayer(0)
				evt.Add("Gold", 25000)
				evt.ForPlayer("All")
				evt.Add("Experience", 20000)
				evt.Subtract("Inventory", 658)         -- "Wheel of Frelandeau"
				evt.Subtract("Inventory", 659)         -- "Log of Eldenbrie"
				evt.Subtract("Inventory", 660)         -- "Ball of Dunduck"
				evt.Add("Awards", 42)         -- "Retrieved three cheeses for Asael Fromago, the Cheese Connoisseur of Alvar."
				evt.Subtract("QBits", 176)         -- "Find a wheel of Frelandeau Cheese. Bring it to Asael Fromago in Alvar."
				evt.Subtract("QBits", 177)         -- "Find a log of Eldenbrie Cheese. Bring it to Asael Fromago in Alvar."
				evt.Subtract("QBits", 178)         -- "Find a ball of Dunduck Cheese. Bring it to Asael Fromago in Alvar."
				evt.Add("QBits", 179)         -- Quests 176-178 done.
				evt.SetNPCTopic{NPC = 442, Index = 2, Event = 0}         -- "Asael Fromago"
				return
			end
		end
	end
	if not evt.Cmp("Inventory", 658) then         -- "Wheel of Frelandeau"
		if not evt.Cmp("Inventory", 659) then         -- "Log of Eldenbrie"
			if not evt.Cmp("Inventory", 660) then         -- "Ball of Dunduck"
				evt.SetMessage(811)         -- "You say you will find me the cheeses I desire, but here you are returned, empty-handed! Do not waste my precious time! Bring me cheese--Frelandeau, Eldenbrie and Dunduck! Do not return until you have them!"
				return
			end
		end
	end
	evt.SetMessage(812)         -- "Very good, you have found me some of the cheese I seek. But now I have my heart set on a full cheese tasting with all three cheeses eaten at once so I can savor them in comparison. Come back when you have then all. I will not take what you have now. I don't think I could resist sampling what you leave--and then the cheese tasting would be ruined!"
end

-- "The Stranger"
evt.global[657] = function()
	evt.SetMessage(817)         -- "The night the stranger came through here was the same night that the crystal erupted in the center of town.  I only caught a glimpse of the stranger.  He didn’t appear the potent mage that he was.  I was not in the town square when he summoned the crystal, but I did see the flash of light that traveled across the sky.  It was truly a terrible night."
end

-- "Night of the Crystal"
evt.global[658] = function()
	evt.SetMessage(818)         -- "A wanderer came into town.  Several ruffians sought to relieve this traveler of whatever wealth he possibly possessed. The wanderer barely paid any of them much notice.  With a small flick of his wrist all fell before him.  Then he walked to the town square and summoned the giant crystal that you'll find there today."
end

-- "The Crystal"
evt.global[659] = function()
	evt.SetMessage(819)         -- "There is an ancient saying among the Dark Elf people,  ""a thing lives only as long as the last person who remembers it.""  The events the night the crystal burst forth into our lives will live for a very long time.  Many of us saw the events of that night.  The mage who summoned forth the crystal said not one word to anyone us.  When he looked upon us, it seemed that all there was in his heart and eyes was pity."
end

-- "Wandering Mage"
evt.global[660] = function()
	evt.SetMessage(820)         -- "When the mage came into town I didn’t think much of it.  This is Ravenshore.  Everyone who travels the roads of Jadame comes through here at some time or another.  I guess I should have paid more attention to him.  Seems he caused quite a stir in the town square."
end

-- "Pirate Raids"
evt.global[661] = function()
	evt.SetMessage(821)         -- "The Pirates of Regna own the seas.  No one can stand against them!  Several years ago, some fishing boat captains thought that they could sail to Erathia to get help dealing with the pirates.  We never saw or heard from them again."
end

-- "Regnans"
evt.global[662] = function()
	evt.SetMessage(822)         -- "The Regnans are the worst slime to ever set foot on the shore of Jadame. They keep the peoples of this continent from trading with Erathia and Enroth.  What choice do we have?  Even the Merchants of Alvar couldn’t muster a fleet to deal with the pirates.  Rumor says that there are smugglers around that have found ways around the pirate blockades."
end

-- "Empire of the Endless Ocean"
evt.global[663] = function()
	evt.SetMessage(823)         -- "The Regnans call themselves the Empire of the Endless Ocean--trying to make more of themselves than there really is.  All they are is bullies and bandits.  Of course, don’t tell them that I said that!"
end

-- "Ogres and Bandits"
evt.global[664] = function()
	evt.SetMessage(824)         -- "Over the last few weeks there have been reports of bandits and Ogres robbing travelers on all of the major roads of Jadame. Times just seem to be getting worse.  Between the Regnan Pirates and these bandits it seems that no one is safe to travel by any means."
end

-- "Overland Travel"
evt.global[665] = function()
	evt.SetMessage(825)         -- "Several of the warriors got together to go take care of the ogres that were camping on the road to Ravenshore.  That’s when we first had word of the fortress they were constructing to the southwest of here.  Since the fortress was completed the roads to the south and west have not been safe."
end

-- "Smugglers"
evt.global[666] = function()
	evt.SetMessage(826)         -- "The Smuggler of Jadame may be a myth, but I think not.  The Merchants of Alvar seem to be able to send small amounts of goods away across the sea to Erathia and Enroth.  Yet they own no boats of their own.   This would seem to support the idea that there really are smugglers.  Now why they work for the merchants is beyond the likes of me."
end

-- "Wererats!"
evt.global[667] = function()
	evt.SetMessage(827)         -- "Wererats!  They are the worst of scum!  The pick through our trash at night!  Always scurrying around in the dark!  Never seen when the sun is up.  Gives one the shivers it does!"
end

-- "Cyclopes of Ironsand"
evt.global[668] = function()
	evt.SetMessage(828)         -- "The Cyclopes that dwell to the southeast of here have always been a threat to the village of Rust!  But the village has always been able to push back any raid.  They aren't so tough in small numbers, but if they can catch you out in the desert unaware, you will not survive!  "
end

-- "Sea of Fire"
evt.global[669] = function()
	evt.SetMessage(829)         -- "The sea of fire took us all by surprise.  It spread through the eastern half of the village like wildfire.  Luckily its growth seems to have slowed.  Still I don’t know how much longer any of us can last."
end

-- "Find us a home!"
evt.global[670] = function()
	evt.SetMessage(830)         -- "We need to find a new place to live!  There is no way any people could live under these conditions.  Even the Cyclopes will be forced to move.  There are legends that talk about the ancient homeland that we traveled here from.  The stories say that it was lush and green.  If we only had such a place to return to."
end

-- "Ore Traders"
evt.global[671] = function()
	evt.SetMessage(831)         -- "There are traders in Alvar and Shadowspire that trade for the different types of ore that can be found all over Jadame.  They use the ore to create items that they are more than happy to trade for more ore!"
end

-- "Vault of Time"
evt.global[672] = function()
	evt.SetMessage(832)         -- "You know, it is said the Vault of Time was here before Ravenshore; the town was built around it. It is supposed to contain the treasure of the old Emperor Thorn who ruled the lands around here hundreds of years ago. Many come here to try and open the vault, but none succeed."
end

-- "Renegade Dragons"
evt.global[673] = function()
	evt.SetMessage(833)         -- "As if Quixote was not enough of a problem to plague us, we must also contend with Ilsingore, Ilsingore and Old Loeb--renegades among our kind! They think they can rebuild our race by scattering across Jadame and starting their own tribes. Fools! All they do is weaken us by removing themselves from our numbers. Yaardrake has fled to the Ironsand Desert. I know not where the others have gone."
end

-- "Other Dragons"
evt.global[674] = function()
	evt.SetMessage(834)         -- "While Garrote Gorge has the highest concentration of dragons in Jadame, I hear there is hunting to be had elsewhere. For instance, there is rumored to be a great old dragon out in the Ironsand Desert. Another is supposed to be somewhere in the badlands of Ravage Roaming."
end

-- "Dragon on Regna"
evt.global[675] = function()
	evt.SetMessage(835)         -- "When Charles Quixote brought us over from Erathia, we sailed past Regna Island. Since this was our first sight of Jadamean land on the voyage, it was an omen of our hunting expedition's future success that I saw an ancient dragon winging its way towards the island. How I wish I could get a spear in that one! It was the biggest dragon I'd ever seen!"
end

-- "The Destroyer"
evt.global[676] = function()
	evt.SetMessage(836)         -- "Yes, I was here the day the Destroyer walked through Ravenshore! I was at the blacksmith's getting a knife sharpened. He walked right past us like he owned the town. A crowd was following him at a distance. One of them threw a rock, but it bounced off a magic shield surrounding him. He didn't even seem to notice. Later I heard an explosion from the town square. I ran out to look, but the Destroyer was gone and that crystal and scattered bodies were all that remained."
end

-- "The Destroyer"
evt.global[677] = function()
	evt.SetMessage(837)         -- "Yeah, I saw the ""Destroyer"" and well named he is! I thought he was a rich merchant, and he looked like easy prey, so I…well, I tried to rob him. I ran ahead of him and lay in ambush in an alley, waiting for him to pass. When he walked by, I made a grab for him. My mistake! I didn't even touch him! As soon as I got near him, I was thrown back by his magic. In fact, I was thrown over a house into the next street!"
end

-- "Temple of Eep"
evt.global[678] = function()
	evt.SetMessage(838)         -- "Those cursed ratmen--those so-called ""Priests of Eep""--are nothing but trouble. More like a pack of thieves than holy men, they are! I'll warn you, traveler. Keep an eye on your equipment when they're around. They'll steal anything that isn't nailed down."
end

-- "Cheese"
evt.global[679] = function()
	evt.SetMessage(839)         -- "Well, if you're looking for cheese, I daresay you will find it in the churches of Eep. You know mice like cheese. Well, this rule also applies to the ratmen of Eep. It is said that they keep a horde of the stuff in each of their temples."
end

-- "Gralkor the Cruel"
evt.global[680] = function()
	evt.SetMessage(840)         -- "On top of all of our problems here, the lord of our plane, Gralkor the Cruel is missing. He is a being of great power and could no doubt fight the dark magic which assails this plane."
end

-- "Plane of Earth"
evt.global[681] = function()
	evt.SetMessage(841)         -- "I wish I understood what has happened here. One day it was life as usual here…and this is normally a peaceful realm. Then suddenly everyone was howling with violent madness and was filled with a thirst to crush your land of Jadame. Even now my fellow Earth Plane denizens work single-mindedly to push the firmament of our realm into yours."
end

-- "Shalwend"
evt.global[682] = function()
	evt.SetMessage(842)         -- "Perhaps the reason I am not affected by the madness is that I carry with me an amulet given to me by the lord of this plane, Shalwend. It is said in our legends that he and the other elemental lords made your world. No doubt if Shalwend was here he could stop the creeping madness, but he is missing! Where is our lord in our time of greatest need?"
end

-- "Plane of Air"
evt.global[683] = function()
	evt.SetMessage(843)         -- "It was clearly magic which caused the madness that has taken my fellow Plane of Air dwellers. On the day it struck there was instant chaos. All who were affected dropped what they were doing and began to howl. It was a chorus of horror! Only a handful of us maintain our sanity. Now, day by day, our glorious realm falls further and further towards a state of hellish decline."
end

-- "Plane of Water"
evt.global[684] = function()
	evt.SetMessage(844)         -- "I am not unschooled in the ways of magic. Clearly some spell of almost unimaginable power has affected those that live in this watery realm. My main curiosity is to know why this has occurred. Clearly no one would risk using such power if it was not to achieve some terrible end. All I know is that the Plane of Water makes war upon your realm. From here, I can discern no reason to it!"
end

-- "Acwalander"
evt.global[685] = function()
	evt.SetMessage(845)         -- "W-what has h-happened to my home w-waters? All are c-consumed by m-m-madness! And worse, our l-lord is m-missing! Where is our r-ruler, th-the mighty Acw-w-walander! W-without him w-we are d-doomed!"
end

-- "Pyrannaste"
evt.global[686] = function()
	evt.SetMessage(846)         -- "I know to your eyes, this plane must seem a hell-scape. But I tell you, normally it is not so. Before the madness we lived here together in a state of peace and harmony. But then, one day the madness fell and our Lord Pyrannaste was nowhere to be found. Perhaps his absence caused the madness? It may be so, he has never before been gone from this realm in my memory."
end

-- "Plane of Fire"
evt.global[687] = function()
	evt.SetMessage(847)         -- "Though the madness affects almost all of those that live here, it has not robbed them of their cunning. As I am sure you are aware, they make war on your realm, but it is not with crazed abandon that they do so. Leaders have emerged among the affected, and these make shrewd military designs against you. Even now they mass near the gateway to Jadame in preparation for a massive assault."
end

-- "Adventure"
evt.global[688] = function()
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.SetMessage(321)         -- "Well, now that things seem to be settled with our little war with the Temple of the Sun. Sandro has said that guild members may turn their attention to other matters. Since arriving in Jadame, I have seen little of it save for the lands of Shadowspire. Say...perhaps you could use my services!"
		evt.SetNPCTopic{NPC = 466, Index = 0, Event = 617}         -- "Hevatia Deverbero" : "Roster Join Event"
	else
		evt.SetMessage(322)         -- "I wish I could join with you. Sadly, our war with the Temple of the Sun takes up all of our time. The guild cannot spare me now."
	end
end

-- "Join with Us"
evt.global[689] = function()
	if evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
		evt.SetMessage(323)         -- "Yes! I would love to join with you. Now that our holy war against the foul Necromancers' Guild seems to be going well, I find I have little to do around here. I will go with you if you will take me."
		evt.SetNPCTopic{NPC = 467, Index = 0, Event = 618}         -- "Verish " : "Roster Join Event"
	else
		evt.SetMessage(396)         -- "I wish I could. Unfortunately, we make holy war with the foul Necromancers' Guild. All of the Sun Temple's resources, including myself, are dedicated to that cause."
	end
end

-- "Adventure"
evt.global[690] = function()
	if evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		evt.SetMessage(397)         -- "Adventure with you? Yes I will. In fact, before he left, Charles Quixote suggested just that. ""Nelix,"" he said, ""if those alliance heroes come by, you ought to consider going with them."" Apparently, he thinks highly of you. Well, his recommendation is enough for me. Shall we go?"
		evt.SetNPCTopic{NPC = 468, Index = 0, Event = 619}         -- "Nelix Uriel" : "Roster Join Event"
	else
		evt.SetMessage(398)         -- "Go with you? I think not. Why would I want to join up with a bunch of amateurs when I have all the action I can handle here? Don't make me laugh. What can you offer me that a life of Dragon hunting does not?"
	end
end

-- "Come with Us"
evt.global[691] = function()
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		evt.SetMessage(400)         -- "Yes, that sounds good. Though the village could use me to protect it, I think the best I could do for it would be to go with you. My people will be destroyed if the cataclysm is not ended. If I can do something to stop it, I should."
		evt.SetNPCTopic{NPC = 469, Index = 0, Event = 620}         -- "Sethrc Thistlebone" : "Roster Join Event"
	else
		evt.SetMessage(399)         -- "Go with you? I like the idea, but I must stay here. I am one of the last veteran warriors left here. I must stay to protect the village."
	end
end

-- "Adventure"
evt.global[692] = function()
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		evt.SetMessage(401)         -- "Join your group? I would be glad to. Not only have you done a great service for my herd, it has become clear to me that your actions will decide our very survival."
		evt.SetNPCTopic{NPC = 470, Index = 0, Event = 621}         -- "Rionel" : "Roster Join Event"
	else
		evt.SetMessage(408)         -- "Join you? I must decline the offer. Though you have done a great service for my herd, I am not yet sure of your leadership. I want to help fight the cataclysm, but I'm not sure your way is the right one."
	end
end

-- "Adventure"
evt.global[693] = function()
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		evt.SetMessage(409)         -- "Don't think your exploits have gone unnoticed! Clearly you are adventurers of the highest caliber. I would consider joining your team…that is, if you will have me."
		evt.SetNPCTopic{NPC = 471, Index = 0, Event = 622}         -- "Adric Stellare" : "Roster Join Event"
	else
		evt.SetMessage(410)         -- "I see you too are adventurers. But…well, can I be frank? Though I don't doubt your potential, clearly you are not the most experienced group I've seen. I'd be happy to join you if you were more…shall we say, ""seasoned?"""
	end
end

-- "Go with Us"
evt.global[694] = function()
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		evt.SetMessage(501)         -- "Yes! Yes! An excellent idea. You are just the kind of companions I am seeking. I have heard of you and your adventures."
		evt.SetNPCTopic{NPC = 472, Index = 0, Event = 623}         -- "Infaustus " : "Roster Join Event"
	else
		evt.SetMessage(502)         -- "No. I am an elder vampire. To be clear, you're not worthy of me. I seek adventure, not to be your caretaker. I don't have the patience to teach you all the basics."
	end
end

-- "Come with Us"
evt.global[695] = function()
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		evt.SetMessage(503)         -- "Yes, you seem worthy of my company. Very well, I will go if you will have me."
		evt.SetNPCTopic{NPC = 473, Index = 0, Event = 624}         -- "Brimstone" : "Join"
	else
		evt.SetMessage(504)         -- "I think not. Now that I've had a chance to look at you, it is clear that you are not worthy of my company. I seek a group of greater renown."
	end
end

-- "Join Us"
evt.global[696] = function()
	if evt.Cmp("QBits", 38) then         -- Quest 36 is done.
		evt.SetMessage(505)         -- "I must say I find the idea appealing. Hmmm, yes! The taste of the open road is just what I need. I have been long at this business of dragon slaying, and I must say it grows stale. A man must keep himself interested. I will go with you if you like."
		evt.SetNPCTopic{NPC = 476, Index = 0, Event = 627}         -- "Tempus " : "Roster Join Event"
	else
		evt.SetMessage(513)         -- "You must be joking! I am a rightly famous knight. Why would I want to travel with such riff-raff as yourselves? Oh, it might be fun after a fashion, but I do have my reputation to think of."
	end
end

-- "Join Us"
evt.global[697] = function()
	if evt.Cmp("QBits", 38) then         -- Quest 36 is done.
		evt.SetMessage(514)         -- "Yes! That sounds great. From what I hear of your adventures you have a chance to know greatness. With my help, we could make that chance a certainty. Well, shall we? I'm always looking for a chance to add to my legend!"
		evt.SetNPCTopic{NPC = 477, Index = 0, Event = 628}         -- "Thorne Understone" : "Roster Join Event"
	else
		evt.SetMessage(515)         -- "Join you? Ho-ho. What an amusing idea. Why would the great Thorne Understone travel with the likes of you?"
	end
end

-- "Adventure"
evt.global[698] = function()
	if evt.Cmp("QBits", 38) then         -- Quest 36 is done.
		evt.SetMessage(543)         -- "Ah, ""adventure."" Surely I have not had enough of it recently. Since our war with the Frost Giants, I have done little but train young warriors. Say, you wouldn't happen to want a traveling companion? Perhaps I could come with you. I have many skills you might find useful, and I swing a deadly axe!"
		evt.SetNPCTopic{NPC = 478, Index = 0, Event = 629}         -- "Ulbrecht" : "Roster Join Event"
	else
		evt.SetMessage(544)         -- "Yes, adventure is a fine thing. Why I have had several. In fact, let me tell you about the time I….Say, it just occurred to me you are suggesting I adventure with you! A nice offer, but well…how can I say this politely? You're just not seasoned enough. I'm afraid I would grow bored with the kinds of challenges you are ready to face."
	end
end

-- "Come with Us"
evt.global[699] = function()
	if evt.Cmp("QBits", 38) then         -- Quest 36 is done.
		evt.SetMessage(545)         -- "Ah, you suggest I come along with you to see the land for myself. An excellent suggestion. I am certainly well rested enough! Very well, I am ready to travel if you will take me."
		evt.SetNPCTopic{NPC = 480, Index = 0, Event = 631}         -- "Artorius Veritas" : "Roster Join Event"
	else
		evt.SetMessage(546)         -- "Though I may not look it after my long sleep, know that you speak with one of the greatest vampires alive today. Go with you? I think not. Your inexperience would make you more of a hindrance to me than anything. I would do better on my own."
	end
end

-- "Join Us"
evt.global[700] = function()
	if evt.Cmp("QBits", 38) then         -- Quest 36 is done.
		evt.SetMessage(547)         -- "Join you! Ha! I admire your audacity. Yes…admire it a great deal. Very well. You have my respect. I will go with you."
		evt.SetNPCTopic{NPC = 481, Index = 0, Event = 632}         -- "Duroth the Eternal" : "Join"
	else
		evt.SetMessage(548)         -- "Join you? What a fool's notion. I already travel with a certain number of fleas. I don't need any more parasites. Be gone!"
	end
end

-- "The Family Tomb"
evt.global[701] = function()
	evt.SetMessage(848)         -- "The Snapfinger family tomb is one of the lowest in our village's burial catacombs. Since we are such an honored family, our crypt is the largest. It isn't the easiest place to find--even I have become lost looking for it! When I do, I find it by keeping a hand on the right-side wall. I eventually get there."
end

-- "Have you found the shield?"
evt.CanShowTopic[702] = function()
	return not evt.Cmp("QBits", 128)         -- Recovered the the Shield, Eclipse for Lathius
end

evt.global[702] = function()
	evt.SetMessage(849)         -- "Have you found the shield?  The recovery of Eclipse is very important to the Temple of the Sun!  You must help us find it!"
end

-- "Use Eclipse well!"
evt.global[703] = function()
	evt.SetMessage(850)         -- "Thanks again for recovering the shield Eclipse!  I hope it has proven helpful in your adventures."
end

-- "Come with Us"
evt.global[706] = function()
	if evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		evt.SetMessage(855)         -- "Sure, why not? I'm ready to go--just have to grab my gear! I'll show the guild who is worthy and who isn't!"
		evt.SetNPCTopic{NPC = 458, Index = 0, Event = 609}         -- "Karanya Memoria" : "Roster Join Event"
	else
		evt.SetMessage(854)         -- "I'm sorry. I'd like to adventure, yes, but you're just not at my level."
	end
end

-- "Come with Us"
evt.global[707] = function()
	if evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		evt.SetMessage(857)         -- "Say, that sounds grand! Yes, I will go with you, if you will have me."
		evt.SetNPCTopic{NPC = 459, Index = 0, Event = 610}         -- "Maylander " : "Roster Join Event"
	else
		evt.SetMessage(856)         -- "No…no, that life is over for me. Besides, if I were to take up the mace again, it would be with other companions. I'm afraid--if I may speak bluntly--I just can't see myself traveling with a group as inexperienced as yours."
	end
end

-- "Join Us"
evt.global[708] = function()
	if evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		evt.SetMessage(859)         -- "Yes, we'd make quite a team! We have all done such great deeds, how could not further greatness follow from our joining together? I'll go with you if you want."
		evt.SetNPCTopic{NPC = 463, Index = 0, Event = 614}         -- "Jasp Thelbourne" : "Roster Join Event"
	else
		evt.SetMessage(858)         -- "I think not! Why would I travel with the likes of you? Perhaps you didn't catch my name, ""Jasp Thelbourne?"" Yes, that ""Thelbourne,"" rabble. No, whatever you're up to, I'm not interested."
	end
end

-- "Ogre Raiders"
evt.global[709] = function()
	if evt.Cmp("QBits", 67) then         -- I have killed all the oges in the ogre fort
		evt.SetMessage(862)         -- "You have done us all a great service by clearing out the Ogre's fort. Now our caravans can freely travel to Murmurwoods. I thank you…and my purse certainly thanks you!"
	else
		evt.SetMessage(861)         -- "I tell you, with all that's going on, it's like an honest merchant can't get business done! I mean, we've always had to deal with Ogre raiders, but now they've grown so bold as to have built a fort right here in Alvar! Now no caravans can take the west road to Murmurwoods. The worst of it is most of my trade with the Temple of the Sun there!"
	end
end

-- "Wasps"
evt.global[710] = function()
	evt.SetMessage(863)         -- "Sure we have wasps in Alvar--and rather large ones, too--but we tolerate them for good reason. Many of our customers desire wasp products. Say…if you want to get in on the action, the trader, Veldon, is a broker for wasp parts. He lives here in town, and I hear he is currently trying to fill a large order for wasp stingers."
end

-- "Trained Dragons"
evt.global[711] = function()
	evt.SetMessage(864)         -- "Not many people know this, but it is possible to train a Dragon. It's sort of like breaking a horse, except that it requires more special equipment and a lot of magic. Those tame Dragons outside the fort are an example of my work. Right now they are loyal to us, but I will bond them to their ultimate customer, Fennis Greenwood, a minor lord back in Erathia. Well, I will do so as soon as he pays us, that is."
end

-- "Zanthora"
evt.global[712] = function()
	evt.SetMessage(865)         -- "Zanthora is a strange character. Not to say that members of the Necromancers' Guild are not all strange, but she is truly mad. I hear that other guild members simply refuse to work with her--so terrible are her experiments. Still, they value her dark genius. To keep her around, they built her a lab of her own out on the marshy wastes outside of town."
end

-- "Vampire Crypt"
evt.global[713] = function()
	evt.SetMessage(866)         -- "For the most part, the Necromancers' Guild has the local vampires under control…mostly. But there's one place you don't want to go! Most of them sleep in a communal crypt north of the guild. Watch out if you go there. They're a bit, shall we say…""territorial."""
end

-- "The Guild"
evt.global[714] = function()
	evt.SetMessage(867)         -- "The Necromancers' Guild? Hey, I think they're great. You should have seen this place before they came--nothing going on at all! Sure, we got vampires, skeletons and other undead running around. Still, I gotta say, things are sure a lot more lively around here!"
end

-- "Coffins"
evt.global[715] = function()
	evt.SetMessage(868)         -- "As you might imagine, business is great. Oh, sure, the guild necromancers turn most of my customers into skeletons and zombies, but vampires are repeat business! Want a piece of the action? There's a wood dealer in town, Mylander, who is always looking for good Murmurwood lumber. If you have any he'll pay a pretty penny for it."
end

-- "Lava Tunnel"
evt.global[716] = function()
	evt.SetMessage(869)         -- "Hunting has become pretty hazardous of late, but still we must do it if we are to eat! Yesterday I was out along the western shore of the fire lake and found a tunnel that seems to go under the lake. I didn't explore it though. It was infested with gogs and worse...like everything else around here these days."
end

-- "Navigation"
evt.global[717] = function()
	evt.SetMessage(870)         -- "Even we who live here get lost. If you would not lose your way, follow the floating waystones. Ahhh…the madness returns….It returns!"
end

-- "The Easy Life"
evt.global[718] = function()
	evt.SetMessage(871)         -- "Ah, I'm glad you're out saving the world. I mean, someone has to do it. Me, I'm for the easy life. As long as I got my boat and my pole, and the fish are biting, I don't see any reason to do much else. Good luck to you though!"
end

-- "Dread Pirate Stanley"
evt.global[719] = function()
	evt.SetMessage(872)         -- "That Stanley, now there's a Regnan with some spark! Why I hear he's the one that got us in good with that thar Zog the Jackal--some sort of Ogre or giant Troll or something, I think--a genuine barbarian king. Now we got us our ships on the seas and a bunch of club swinging devils on the land. I tell ya, the Great and Mighty Regnan Empire is headed for greatness, what with the likes of the Dread Pirate Stanley doing for us!"
end

-- "Jadamean Smugglers"
evt.global[720] = function()
	evt.SetMessage(873)         -- "Oh sure, we Regnans have to put up with a bit of competition--I'm talking about smugglers, you know--but I understand the Dread Pirate Stanley is putting the clamp on that. Why I understand he kidnapped Arion Hunter's family just so he can pressure the wererat into staying off our turf. "
end

-- "Stanley's Treasure"
evt.global[721] = function()
	evt.SetMessage(874)         -- "Yeah, I know the ""Dread"" Pirate Stanley is the hero of the moment around here, but I say, fah! Sure he's done a lot for Regna, but no man does anything that doesn't help himself. Why I hear old Stanley's been shaving off the top of every deal he's in--and that's a lot of deals! What I'd like to know is where he keeps his booty. Probably not on Regna, I reckon. It wouldn't be a fortnight before someone dug it up!"
end

-- "Hidden Treasure"
evt.global[722] = function()
	evt.SetMessage(875)         -- "I have come up with a scheme for finding hidden treasure. Before you barged in, I was hard at work formulating a spell for sensing gold hidden beneath the ground. If I am successful, I plan to have a Dragon carry me over the wastelands of Ravage Roaming where the Dread Pirate Stanley's treasure is rumored to be buried. My spell will find it and I will be a wealthy man."
end

-- "Burial Mound"
evt.global[723] = function()
	evt.SetMessage(876)         -- "You mean the one just north of here? Well, none of us have anything to do with it. It's haunted!"
end

-- "Followers of Eep"
evt.global[724] = function()
	evt.SetMessage(877)         -- "I don't know where they're at, but I know there's some of them ratmen around here somewhere. At night I hear all sorts of squeaking and scuffling outside. In the morning, pretty much everything that isn't under lock or bolted down is gone. If I knew where that Eep church was. I'd take some of my boys over for a little...talk."
end

-- "Water Gateway"
evt.global[725] = function()
	evt.SetMessage(878)         -- "I was out with one of the crews working along the new lake searching for things that were washed out of the lair. We think we found the source of the flood. There is a strange gateway out in the middle of the lake. We don't have any boats, so we didn't explore it, but even from the shore, it is clear to see that it leads to a watery realm."
end

-- "Pirate Fortress"
evt.global[726] = function()
	evt.SetMessage(879)         -- "Well, if you haven't been to the fortress, that's the first place you should go. As you are aware from your orientation, the so-called fortress on this island is just a front to fool our enemies. You'll need to make your way to the real fort on the crescent island. Just take the underground passage marked on your orientation map."
end

-- "Regnan Culture"
evt.global[727] = function()
	evt.SetMessage(880)         -- "I know they call us ""pirates"" on Jadame, but really, we're just running our empire. It is not our fault that our Jadamean subjects refuse to acknowledge our rule and do not pay their taxes. Since they do not pay, we're forced to collect tribute in the form of booty. Actually we prefer it this way--saves us the trouble of having to actually rule the continent."
end

-- "Nightshade Amulets"
evt.global[728] = function()
	if evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		evt.SetMessage(882)         -- "Normally, we vampires need one of Thant's Nightshade Amulets to travel freely during the day, but since you've brought us the Nightshade Brazier, glorious night covers Shadowspire around the clock! Now those of us who don't have the amulets can walk about during the day...well, at least as long as we stay in the area."
	else
		evt.SetMessage(881)         -- "We vampires cannot normally walk about in the daylight, but Thant the Necromancers' Guildmaster has created an artifact to deal with this. A vampire wearing one of his Nightshade Amulets can move about freely day or night. Sadly, there are few available. I myself do not have one so must stay indoors during the day."
	end
end

-- "Gaudy Jewelry"
evt.global[729] = function()
	evt.SetMessage(883)         -- "Though it isn't my style, I must say a lot of folks around here like to cover themselves with all sorts of jewelry. They say it's fashion, but I just find it gaudy. Anyway, if you have any to sell go find Pavel in town. He does a brisk trade in all sorts of tacky junk."
end

-- "Sunfish"
evt.global[730] = function()
	evt.SetMessage(884)         -- "You looking for sunfish? Sorry, can't help you. Funny thing is, I had a whole catch of them just last week, but Pavel the merchant bought the whole lot. Maybe you can get them from him."
end

-- "The Warehouse"
evt.global[731] = function()
	evt.SetMessage(887)         -- "We have a small warehouse downstairs. You are free to use the chests there to store extra equipment. Put anything in there you don't want to wander off!"
end

-- "Hint"
evt.global[732] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 4) then         -- Letter from Q Bit 3 delivered.
		if evt.Cmp("QBits", 3) then         -- "Deliver Dadeross' Letter to Elgar Fellmoon at the Merchant House in Ravenshore."
			evt.SetMessage(896)         -- "Hmmm…I cannot look too far ahead--for the ether is thick today. All I see is that you must deliver the letter Dadeross gave you to the merchant, Elgar Fellmoon. Fellmoon lives in the city of Ravenshore."
			evt.Add("AutonotesBits", 273)         -- "Hmmm…I cannot look too far ahead--for the ether is thick today. All I see is that you must deliver the letter Dadeross gave you to the merchant, Elgar Fellmoon. Fellmoon lives in the city of Ravenshore."
		else
			evt.SetMessage(895)         -- "You are employed by the Merchants of Alvar, yes? Well, I think you should speak with Dadeross, the leader of your caravan. My far seeing vision tells me he is on the Dagger Wound Islands."
			evt.Add("AutonotesBits", 272)         -- "You are employed by the Merchants of Alvar, yes? Well, I think you should speak with Dadeross, the leader of your caravan. My far seeing vision tells me he is on the Dagger Wound Islands."
		end
		return
	end
	if not evt.Cmp("QBits", 24) then         -- Received Reward from Elgar Fellmoon for completing quest 9.
		evt.SetMessage(897)         -- "I see a vision of you in which you take a letter from Elgar Fellmoon in Ravenshore to Arion Hunter, the leader of the Ravenshore smugglers. After this, you return to Fellmoon. The end of the vision is a blur, so you must not have lived entirely through it. Still, it is your fate to do these things."
		evt.Add("AutonotesBits", 274)         -- "I see a vision of you in which you take a letter from Elgar Fellmoon in Ravenshore to Arion Hunter, the leader of the Ravenshore smugglers. After this, you return to Fellmoon. The end of the vision is a blur, so you must not have lived entirely through it. Still, it is your fate to do these things."
		return
	end
	if not evt.Cmp("QBits", 12) then         -- Quest 11 is done.
		evt.SetMessage(898)         -- "I don't need my vision to tell me what you must do next. Do as Fellmoon asked of you. Go seek Bastian Loudrin, the guildmaster of the Alvarian Merchant Guild. He is in the city of Alvar."
		evt.Add("AutonotesBits", 275)         -- "I don't need my vision to tell me what you must do next. Do as Fellmoon asked of you. Go seek Bastian Loudrin, the guildmaster of the Alvarian Merchant Guild. He is in the city of Alvar."
		return
	end
	if not evt.Cmp("QBits", 62) then         -- Vilebites Ashes (item603) placed in troll tomb.
		if evt.Cmp("QBits", 25) then         -- "Find a witness to the lake of fire's formation. Bring him back to the merchant guild in Alvar."
			evt.SetMessage(900)         -- "In my dreams last night, I saw you traveling to the Ironsand Desert to find a witness to the formation of a great lake of fire which formed there during the cataclysm."
			evt.Add("AutonotesBits", 277)         -- "In my dreams last night, I saw you traveling to the Ironsand Desert to find a witness to the formation of a great lake of fire which formed there during the cataclysm."
		else
			evt.SetMessage(899)         -- "I see an important connection has not been made between the present and your future. You must return to Bastian Loudrin and continue your conversations with him. He will send you on the next step down your road."
			evt.Add("AutonotesBits", 276)         -- "I see an important connection has not been made between the present and your future. You must return to Bastian Loudrin and continue your conversations with him. He will send you on the next step down your road."
		end
		return
	end
	if not evt.Cmp("QBits", 59) then         -- Returned to the Merchant guild in Alvar with overdune. Quest 25 done.
		evt.SetMessage(901)         -- "It is clear to me that you must bring the Troll, Overdune, to the merchant guild in Alvar."
		evt.Add("AutonotesBits", 278)         -- "It is clear to me that you must bring the Troll, Overdune, to the merchant guild in Alvar."
		return
	end
	if evt.Cmp("QBits", 34) then         -- Alliance Council formed. Quest 13 done.
		if evt.Cmp("QBits", 57) then         -- The Pirates invaded Ravenshore
			evt.SetMessage(908)         -- "In case you haven't heard, Ravenshore is under attack by the Regnan pirates. The town has been evacuated. You must eliminate the pirate threat before the alliance council will return to guide you."
			evt.Add("AutonotesBits", 285)         -- "In case you haven't heard, Ravenshore is under attack by the Regnan pirates. The town has been evacuated. You must eliminate the pirate threat before the alliance council will return to guide you."
			return
		end
		if not evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
			if evt.Cmp("QBits", 36) then         -- "Sink the Regnan Fleet. Return to the Ravenshore council chamber."
				evt.SetMessage(907)         -- "You must do as the alliance council has asked of you. Find a way to Regna Island and sink the Regnan port fleet."
				evt.Add("AutonotesBits", 284)         -- "You must do as the alliance council has asked of you. Find a way to Regna Island and sink the Regnan port fleet."
			else
				evt.SetMessage(906)         -- "I see an important connection has not been made between the present and your future destiny. You must return to the council chamber in the Ravenshore merchant guild. The councilors will send you on the next step down your road."
				evt.Add("AutonotesBits", 283)         -- "I see an important connection has not been made between the present and your future destiny. You must return to the council chamber in the Ravenshore merchant guild. The councilors will send you on the next step down your road."
			end
			return
		end
		if not evt.Cmp("QBits", 38) then         -- Quest 36 is done.
			evt.SetMessage(909)         -- "Now that you've sunk the Regnan fleet. Go and seek the wisdom of your alliance council. They will give you the next task that will make your destiny."
			evt.Add("AutonotesBits", 286)         -- "Now that you've sunk the Regnan fleet. Go and seek the wisdom of your alliance council. They will give you the next task that will make your destiny."
			return
		end
		if not evt.Cmp("QBits", 92) then         -- Quest 91 done.
			if evt.Cmp("QBits", 91) then         -- "Consult the Ironfists' court sage, Xanthor about the Ravenshore crystal."
				evt.SetMessage(911)         -- "I see an important link between the present and your future has not been forged. Seek out the sage, Xanthor who resides in Ravenshore. He will send you on your destiny's next task."
				evt.Add("AutonotesBits", 288)         -- "I see an important link between the present and your future has not been forged. Seek out the sage, Xanthor who resides in Ravenshore. He will send you on your destiny's next task."
			else
				evt.SetMessage(910)         -- "You must speak to the Ironfists' court sage, Xanthor. He is housed in Ravenshore."
				evt.Add("AutonotesBits", 287)         -- "You must speak to the Ironfists' court sage, Xanthor. He is housed in Ravenshore."
			end
			return
		end
		if evt.Cmp("QBits", 45) then         -- Quests 41-44 done. Items from 41-44 given to XANTHOR.
			if evt.Cmp("QBits", 47) then         -- Quest 46 done. Used to allow entrance to elemental lord prisons. Now player needs item 629.
				if evt.Cmp("QBits", 228) then         -- You have seen the Endgame movie
					evt.SetMessage(918)         -- "The Balance is restored. Now that your destiny is made, I can no longer guide you--my sight only pertains to what is connected to the fate of Balance. What you do now is up to you. Good luck to you, Heroes of Jadame!"
					evt.Add("AutonotesBits", 295)         -- "The Balance is restored. Now that your destiny is made, I can no longer guide you--my sight only pertains to what is connected to the fate of Balance. What you do now is up to you. Good luck to you, Heroes of Jadame!"
				elseif evt.Cmp("QBits", 56) then         -- All Lords from quests 48, 50, 52, 54 rescued.
					evt.SetMessage(917)         -- "Seek out Xanthor! Though he is but a piece in the game of Balance, the next move you make towards destiny it through a meeting with him."
					evt.Add("AutonotesBits", 294)         -- "Seek out Xanthor! Though he is but a piece in the game of Balance, the next move you make towards destiny it through a meeting with him."
				else
					evt.SetMessage(916)         -- "Your path is clear to my vision. You must seek out the four elemental lords and release them from their prisons. These prisons are in the Destroyer's realm--the Plane Between Planes."
					evt.Add("AutonotesBits", 293)         -- "Your path is clear to my vision. You must seek out the four elemental lords and release them from their prisons. These prisons are in the Destroyer's realm--the Plane Between Planes."
				end
			elseif evt.Cmp("QBits", 235) then         -- Have talked to Escaton
				evt.SetMessage(915)         -- "You have talked to the Destroyer, but have failed to gather from him the key which will unlock your future. Return to him and continue your conversations."
				evt.Add("AutonotesBits", 292)         -- "You have talked to the Destroyer, but have failed to gather from him the key which will unlock your future. Return to him and continue your conversations."
			else
				evt.SetMessage(914)         -- "Your destiny lies through the crystal gateway in Ravenshore. It will take you to the Plane Between Planes. There you will find the source of the elemental cataclysm."
				evt.Add("AutonotesBits", 291)         -- "Your destiny lies through the crystal gateway in Ravenshore. It will take you to the Plane Between Planes. There you will find the source of the elemental cataclysm."
			end
			return
		end
		if evt.Cmp("Inventory", 606) then         -- "Heart of Fire"
			if evt.Cmp("Inventory", 607) then         -- "Heart of Water"
				if evt.Cmp("Inventory", 608) then         -- "Heart of Air"
					if evt.Cmp("Inventory", 609) then         -- "Heart of Earth"
						evt.SetMessage(913)         -- "Now that you have the four elemental heartstones, you must now bring them to Xanthor in Ravenshore."
						evt.Add("AutonotesBits", 290)         -- "Now that you have the four elemental heartstones, you must now bring them to Xanthor in Ravenshore."
						return
					end
				end
			end
		end
		evt.SetMessage(912)         -- "It is clear that you must do as Xanthor has asked of you. Go to the four elemental planes and find in each, an elemental heartstone."
		evt.Add("AutonotesBits", 289)         -- "It is clear that you must do as Xanthor has asked of you. Go to the four elemental planes and find in each, an elemental heartstone."
		return
	end
	if not evt.Cmp("QBits", 23) then         -- Allied with Minotaurs. Rescue the Minotaurs done.
		evt.SetMessage(902)         -- "I see far through space today, but not through time. A great disaster has befallen the Minotaurs of Balthazar Lair in Ravage Roaming. I feel that your destiny is linked with their fate. You must rescue them from their peril."
		evt.Add("AutonotesBits", 279)         -- "I see far through space today, but not through time. A great disaster has befallen the Minotaurs of Balthazar Lair in Ravage Roaming. I feel that your destiny is linked with their fate. You must rescue them from their peril."
		return
	end
	if not evt.Cmp("QBits", 19) then         -- Allied with Necromancers Guild. Steal Nightshade Brazier done.
		if not evt.Cmp("QBits", 20) then         -- Allied with Temple of the Sun. Destroy the Skeleton Transformer done.
			evt.SetMessage(903)         -- "There is great turmoil in the Balance. It has taken me some time to know its source, but I know it now. It is caused by the war between the clerics of the Temple of the Sun located in Murmurwoods, and the Necromancers' Guild of Shadowspire. It is your destiny to undo the turmoil by choosing one of these two to ally with."
			evt.Add("AutonotesBits", 280)         -- "There is great turmoil in the Balance. It has taken me some time to know its source, but I know it now. It is caused by the war between the clerics of the Temple of the Sun located in Murmurwoods, and the Necromancers' Guild of Shadowspire. It is your destiny to undo the turmoil by choosing one of these two to ally with."
			return
		end
	end
	if not evt.Cmp("QBits", 21) then         -- Allied with Charles Quioxte's Dragon Hunters. Return Dragon Egg to Quixote done.
		if not evt.Cmp("QBits", 22) then         -- Allied with Dragons. Return Dragon Egg to Dragons done.
			evt.SetMessage(904)         -- "There is great turmoil in the Balance. It has taken me some time to know its source, but I know it now. There is conflict between the Dragons and Knights who fight in Garrote Gorge. It is your destiny to ally with one of the two at the expense of the other."
			evt.Add("AutonotesBits", 281)         -- "There is great turmoil in the Balance. It has taken me some time to know its source, but I know it now. There is conflict between the Dragons and Knights who fight in Garrote Gorge. It is your destiny to ally with one of the two at the expense of the other."
			return
		end
	end
	evt.SetMessage(905)         -- "You have done good work in forging the alliances you have. It is now time for you to seek the council of those allies you have brought together. Seek them out in their council chamber within the merchant guild in Ravenshore."
	evt.Add("AutonotesBits", 282)         -- "You have done good work in forging the alliances you have. It is now time for you to seek the council of those allies you have brought together. Seek them out in their council chamber within the merchant guild in Ravenshore."
end

-- "Promote Dark Elves"
evt.global[733] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 19) then         -- "Promoted to Elf Patriarch."
		if not evt.Cmp("Awards", 20) then         -- "Rescued Cauri Blackthorne."
			evt.SetMessage(919)         -- "You cannot be promoted until we know where Cauri Blackthorne is!  Locate her, and she will promote you.  After she is found and has retuned to the Merchant Guild, I will be glad to promote any Dark Elves in your party to Patriarch."
			return
		end
	end
	evt.SetMessage(920)         -- "Cauri told me of how you helped her with the curse of the Basilisk.  She has instructed me to promote any Dark Elves that travel with you to Patriarch."
	evt.Subtract("QBits", 39)         -- "Find Cauri Blackthorne then return to Dantillion in Murmurwoods with information of her location."
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.DarkElf) then
		evt.Set("ClassIs", const.Class.Patriarch)
		evt.Add("Awards", 19)         -- "Promoted to Elf Patriarch."
	else
		evt.Add("Awards", 20)         -- "Rescued Cauri Blackthorne."
	end
end

-- "Promote Trolls"
evt.global[734] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 21) then         -- "Promoted to War Troll."
		if not evt.Cmp("Awards", 22) then         -- "Found Troll Homeland."
			evt.SetMessage(921)         -- "You cannot be promoted until the Ancient Troll Home has been found!  Return here when you have found it and talk with Volog."
			return
		end
	end
	evt.SetMessage(922)         -- "Before Volog left, he instructed me to promote any Trolls that travel with you to War Troll.  The village of Rust will be forever thankful to you!"
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Troll) then
		evt.Set("ClassIs", const.Class.WarTroll)
		evt.Add("Awards", 21)         -- "Promoted to War Troll."
	else
		evt.Add("Awards", 22)         -- "Found Troll Homeland."
	end
end

-- "Promote Knights"
evt.global[735] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 23) then         -- "Promoted to Champion."
		if not evt.Cmp("Awards", 24) then         -- "Returned Ebonest to Charles Quixote."
			evt.SetMessage(923)         -- "You cannot be promoted to Champion until you have proven yourself worthy!  "
			return
		end
	end
	evt.SetMessage(924)         -- "Thanks for you help recovering the spear Ebonest!  I can promote any Knights that travel with you to Champion."
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
	else
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
	else
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
	else
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Knight) then
		evt.Set("ClassIs", const.Class.Champion)
		evt.Add("Awards", 23)         -- "Promoted to Champion."
	else
		evt.Add("Awards", 24)         -- "Returned Ebonest to Charles Quixote."
	end
end

-- "Promote Dragons"
evt.global[736] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 26) then         -- "Promoted to Great Wyrm."
		if not evt.Cmp("Awards", 27) then         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
			evt.SetMessage(925)         -- "You have not proven yourself worthy!  Until you strike a blow against the Dragon Hunters, none of you will be promoted!"
			return
		end
	end
	evt.SetMessage(926)         -- "You have proven yourself and I will promote any Dragons that travel with you to Great Wyrm."
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
	else
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
	else
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
	else
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Dragon) then
		evt.Set("ClassIs", const.Class.GreatWyrm)
		evt.Add("Awards", 26)         -- "Promoted to Great Wyrm."
	else
		evt.Add("Awards", 27)         -- "Gave the Sword of Whistlebone the Slayer to the Deftclaw Redreaver."
	end
end

-- "Promote Clerics"
evt.global[737] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 30) then         -- "Promoted to Cleric of the Sun."
		if not evt.Cmp("Awards", 31) then         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
			evt.SetMessage(927)         -- "You cannot be promoted to Priest of the Sun until you have recovered the Prophecies of the Sun!"
			return
		end
	end
	evt.SetMessage(928)         -- "You are always welcome here!  Of course I will promote any Clerics that travel with you to Priest of the Sun!  "
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
	else
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
	else
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
	else
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Cleric) then
		evt.Set("ClassIs", const.Class.PriestLight)
		evt.Add("Awards", 30)         -- "Promoted to Cleric of the Sun."
	else
		evt.Add("Awards", 31)         -- "Found the lost Prophecies of the Sun and returned them to the Temple of the Sun."
	end
end

-- "Promote Necromancers"
evt.global[738] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 34) then         -- "Promoted to Lich."
		if not evt.Cmp("Awards", 35) then         -- "Found the Lost Book of Khel."
			evt.SetMessage(929)         -- "You have not recovered the Lost Book of Kehl!  There will be no promotions until you return with the book!  Speak with Vetrinus Taleshire."
			return
		end
	end
	evt.SetMessage(930)         -- "Ah, you return seeking promotion for others in your party?  I have not forgotten your help in recovering the Lost Book of Kehl!  All Necromancers in your party will be promoted to Lich.  Be sure each Necromancer has a Lich Jar in his possession."
	evt.ForPlayer(1)
	if not evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _11
	end
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _11
	end
::_25::
	evt.SetMessage(114)         -- "You have the Lost Book of Khel, however you lack the Lich Jars needed to complete the transformation!  Return here when you have one for each necromancer in your party!"
	do return end
::_11::
	evt.ForPlayer(2)
	if not evt.Cmp("ClassIs", const.Class.Necromancer) then
		goto _16
	end
	if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _16
	end
	goto _25
::_16::
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		if evt.Cmp("Inventory", 628) then         -- "Lich Jar"
			goto _24
		end
	else
		evt.ForPlayer(4)
		if evt.Cmp("ClassIs", const.Class.Necromancer) then
			goto _24
		end
	end
	goto _25
::_24::
	if not evt.Cmp("Inventory", 628) then         -- "Lich Jar"
		goto _25
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Necromancer) then
		evt.Set("ClassIs", const.Class.Lich)
		evt.Add("Awards", 34)         -- "Promoted to Lich."
		evt.Subtract("Inventory", 628)         -- "Lich Jar"
	else
		evt.Add("Awards", 35)         -- "Found the Lost Book of Khel."
	end
end

-- "Promote Vampires"
evt.global[739] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 32) then         -- "Promoted to Nosferatu."
		if not evt.Cmp("Awards", 33) then         -- "Found the Sarcophagus and Remains of Korbu."
			evt.SetMessage(931)         -- "You have not found Korbu and until you have I refuse to promote any of you!  Begone!"
			return
		end
	end
	evt.SetMessage(932)         -- "Any Vampires among you will be promoted to Nosferatu!  I remember those who helped in the recovery of the Remains of Korbu."
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
	else
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
	else
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
	else
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Vampire) then
		evt.Set("ClassIs", const.Class.Nosferatu)
		evt.Add("Awards", 32)         -- "Promoted to Nosferatu."
	else
		evt.Add("Awards", 33)         -- "Found the Sarcophagus and Remains of Korbu."
	end
end

-- "Promote Minotuars"
evt.global[740] = function()
	evt.ForPlayer(0)
	if not evt.Cmp("Awards", 28) then         -- "Promoted to Minotaur Lord."
		if not evt.Cmp("Awards", 29) then         -- "Recovered Axe of Balthazar."
			evt.SetMessage(933)         -- "You have not found the Axe of Balthazar!  You are not worthy of promotion!"
			return
		end
	end
	evt.SetMessage(934)         -- "The Herd of Masul is in debt to you.  Any Minotaurs in your party are promoted to Minotaur Lord!"
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
	else
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
	else
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
	else
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
	evt.ForPlayer(4)
	if evt.Cmp("ClassIs", const.Class.Minotaur) then
		evt.Set("ClassIs", const.Class.MinotaurLord)
		evt.Add("Awards", 28)         -- "Promoted to Minotaur Lord."
	else
		evt.Add("Awards", 29)         -- "Recovered Axe of Balthazar."
	end
end

-- "Thank you!"
evt.CanShowTopic[741] = function()
	return evt.Cmp("QBits", 119)         -- "Rescue Arion Hunter's daughter from Ogre Fortress in Alvar."
end

evt.global[741] = function()
	evt.SetMessage(935)         -- "My father sent you to rescue me?  I am grateful.  I will return to my father and let him know of your assistance!"
	evt.ForPlayer("All")
	evt.Add("Experience", 5000)
	evt.SetNPCTopic{NPC = 285, Index = 0, Event = 0}         -- "Irabelle Hunter"
	evt.Subtract("QBits", 119)         -- "Rescue Arion Hunter's daughter from Ogre Fortress in Alvar."
	evt.Add("QBits", 120)         -- Rescued Smuggler Leader's Familly 
end

-- "Travel with you!"
evt.global[742] = function()
	if evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		evt.SetMessage(938)         -- "I remember you!  The Book of Kehl has proven invaluable, and it would be a privilege to travel with you."
		evt.SetNPCTopic{NPC = 74, Index = 0, Event = 625}         -- "Vetrinus Taleshire" : "Roster Join Event"
	else
		evt.SetMessage(937)         -- "I cannot yet travel with you!  I would sooner sign on with a merchant caravan, than travel with you.  Return to me when you have discovered more of the world, and your place in it."
	end
end

-- "Travel with you!"
evt.global[743] = function()
	if evt.Cmp("QBits", 37) then         -- Regnan Pirate Fleet is sunk.
		evt.SetMessage(940)         -- "Certainly!  Traveling with you would be an honor!"
		evt.SetNPCTopic{NPC = 63, Index = 0, Event = 626}         -- "Dervish Chevron" : "Roster Join Event"
	else
		evt.SetMessage(939)         -- "When you have grown and learned more of the ways of the world, then it would be my pleasure to travel with you.  Until then I have studies to complete here."
	end
end

-- "Rescue"
evt.global[744] = function()
	evt.SetMessage(941)         -- "You have done us a great service, adventurers. On behalf of my herd, I give you our humblest thanks. Know that the Minotaurs of Balthazar Lair hold you in the highest regard. You will always be welcome among us."
	evt.SetNPCTopic{NPC = 70, Index = 0, Event = 613}         -- "Thanys" : "Roster Join Event"
	evt.SetNPCTopic{NPC = 70, Index = 1, Event = 0}         -- "Thanys"
	evt.SetNPCTopic{NPC = 70, Index = 2, Event = 0}         -- "Thanys"
end

