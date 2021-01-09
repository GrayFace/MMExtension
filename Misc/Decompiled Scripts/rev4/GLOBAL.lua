-- Deactivate all standard events
Game.GlobalEvtLines.Count = 0

-- ERROR: Duplicate label: 120:0
-- ERROR: Duplicate label: 518:5

-- "Castle Harmondale?"
evt.CanShowTopic[1] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[1] = function()
	evt.SetMessage(6)         -- "If you win, you'll be in charge of one of the most scenic areas in all Erathia!  Harmondale is just outside of the Tularean Forest, right on the edge of the Elf-Human border.  And I'm sure you'll love the castle.  It's a bit of a fixer-upper, but it's quite roomy and has excellent ventilation.  It breaks my heart to part with this property, but I feel that the time has come for me to give something back to the people."
end

-- "What do you think about the hunt?"
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
	evt.Subtract("NPCs", 3)         -- "Big Daddy Jim"
	evt.Set("QBits", 17)         -- No more docent babble
	evt.ForPlayer("All")
	evt.Add("Experience", 1000)
	evt.Add("Awards", 2)         -- "Won the Scavenger Hunt on Emerald Island"
	evt.Set("QBits", 284)         -- Beginning of Festival
	evt.SetNPCGroupNews{NPCGroup = 1, NPCNews = 5}         -- "" : "Congratulations!"
end

-- "Your ship…"
evt.global[4] = function()
	evt.SetMessage(8)         -- "Well, the ship that will take you to your fiefdom awaits you in the harbor.  My entourage and I will be taking a different ship out.  Just board whenever you're ready."
	evt.Add("QBits", 15)         -- Able to use boat to get off Emerald Island
	evt.SetNPCTopic{NPC = 11, Index = 0, Event = 33}         -- "William Darvees" : "Let's Go!"
	evt.SetNPCTopic{NPC = 1, Index = 2, Event = 0}         -- "Lord Markham"
	evt.SetNPCGreeting{NPC = 1, Greeting = 0}         -- "Lord Markham" : ""
end

-- "Tell us the rules of the hunt"
evt.global[5] = function()
	evt.SetMessage(25)         -- "Good afternoon.  My duty is to verify that you have all the items necessary to win the contest.  You are required to bring a red potion, a longbow, a floor tile from the Temple of the Moon, a wealthy hat, seashell, and an instrument to me.  You can bring them in any order, just show them to me one at a time so that I may verify them."
end

-- "We found something!"
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
		if evt.Cmp("Inventory", 43) then         -- "Recurve Bow"
			evt.SetMessage(29)         -- "This longbow certainly qualifies for the hunt.  Good work, I shall mark that off your list."
			evt.Subtract("Inventory", 43)         -- "Recurve Bow"
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
								evt.SetNPCGreeting{NPC = 6, Greeting = 9}         -- "Wren Wilder" : ""
								return
							end
						end
					end
				end
			end
		end
	else
		if evt.Cmp("Inventory", 631) then         -- "Wealthy Hat"
			evt.SetMessage(26)         -- "I see you have found a wealthy hat.  I shall mark this off your list accordingly, good work."
			evt.Subtract("Inventory", 631)         -- "Wealthy Hat"
			evt.Subtract("QBits", 6)         -- "Return a wealthy hat to the Judge on Emerald Island."
			evt.Add("Experience", 500)
			evt.Add("QBits", 13)         -- Brought hat
			return
		end
	end
	evt.SetMessage(33)         -- "I'm sorry, but nothing you have is necessary for the hunt.  I don't mean to belittle what you have, but I'm not looking for any of it."
end

-- "MM7Rev4mod"
evt.global[7] = function()
	evt.SetMessage(152)         --[[ "The development of this mod began in October 2007 as an ‘experiment’ in reverse-engineering the ‘event language’ of MM6, MM7, and MM8.  This was a massive effort that consumed countless hours of ‘blood sweating’ research and applications programming trials.  The MM7Rev4mod is the result of this ‘experiment’ and was completed by yours truly as a solo effort.  That makes me the ‘Sole Proprietor’ of this venture – author, designer, programmer, chef, bottle washer, and ‘go-for’.

If you enjoy this mod, ‘kudos’ to me. If you don’t like the mod … well ya gotta admit that the price was right ... different strokes and all that stuff.

Have fun exploring Vori.

The Coding Wizard

09March2008" ]]
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 8}         -- "Big Daddy Jim" : "Credits"
end

-- "Credits"
evt.global[8] = function()
	evt.SetMessage(153)         --[[ "The MM8LevelEditor utility was an invaluable database import and extract tool during the development process.  My appreciation and recognition to the author and his dedicated efforts to produce this fine utility.

Thanks to Pascal (AKA: Asterix, asterix15, etal), for the initial announcements and ‘marketing’ of this mod, for contributing a few custom graphics to the otherwise status-quo visuals in the game, and for ‘early’ play testing of the R1 release.  If ya know about this mod, chances are it is due to Pascal’s efforts.

An ‘above and beyond the call of duty’ thanks to my work compatriots for giving up their Christmas holiday to ‘play test’ the R1 mod.  Special note to Tom A., Wren, Tony, Jude, and the ever-elusive ‘Count Zero, Seeker of Lost Ones’.  For programming Geeks, you guys are OK by me.

A ‘special’ thanks to Sarah Lambent (of the Courier Guild), simply because of her infectious ‘love’ of the MM7 gaming universe.

BDJ" ]]
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 9}         -- "Big Daddy Jim" : "Friends of  'The Game'"
end

-- "Friends of  'The Game'"
evt.global[9] = function()
	evt.SetMessage(154)         --[[ "Finally, I’d like to recognize the contributions from the MM community at-large, and specifically the following six ‘gamers’.  Each has provided me with significant encouragement and play-testing ‘bug reports’ and suggestions.  As a special ‘Thanks!’, each of these contributors has become ‘immortalized’ within Erathia as an NPC in the MM7Rev4mod game.

Pascal the Mad Mage
Lord Godwinson
Zedd True Shot
Duke Bimbasto
Sir Vilx of Stone City
Baron BunGleau

Thank you all for your assistance.

Big Daddy Jim
15 April, 2008
" ]]
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 0}         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 3, Index = 1, Event = 0}         -- "Big Daddy Jim"
	evt.Subtract("NPCs", 3)         -- "Big Daddy Jim"
end

-- "We are going to win the Scavenger Hunt!"
evt.global[10] = function()
	evt.SetMessage(34)         -- "Are you contestants in Lord Markham's Scavenger Hunt?  How neat!  I'm here to provide entertainment to Lord Markham's entourage, the contestants, and to anyone else that would like to hear a song."
end

-- "Do you have any instruments?"
evt.global[11] = function()
	evt.SetMessage(35)         -- "I own a few instruments, but I only brought my lute with me.  Its old and not quite as well kept as some of the others, but I didn't want one of my good instruments stolen by pirates or damaged from exposure to the humid, salty air."
end

-- "We need an instrument for the contest"
evt.global[12] = function()
	evt.ForPlayer("All")
	evt.SetMessage(36)         -- "You say you need an instrument for the Scavenger Hunt?  I suppose you could buy my lute, but I've had it for such a long time.  I guess I'd part with it for 500 gold.  Interested?"
	evt.SetNPCTopic{NPC = 4, Index = 2, Event = 13}         -- "Ailyssa the Bard" : "Buy Lute for 500 gold"
end

evt.CanShowTopic[12] = function()
	local result
	if not evt.Cmp("Inventory", 632) then         -- "Lute"
		result = not evt.Cmp("QBits", 12)         -- Brought instrument
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

-- "What do you think about the ocean?"
evt.global[14] = function()
	evt.SetMessage(12)         -- "I love being out on this side of the island, the view of the ocean is much better than from town, don't you agree?"
end

-- "Do you have any seashells?"
evt.global[15] = function()
	evt.SetMessage(13)         -- "I have some nice sea shells for sale, shells that you can only find on Emerald Island.  Can I sell one to you?  They're only a hundred gold pieces each."
	evt.SetNPCTopic{NPC = 5, Index = 1, Event = 16}         -- "Sally" : "Buy a Seashell for 100 gold"
end

-- "Buy a Seashell for 100 gold"
evt.global[16] = function()
	if evt.Cmp("Gold", 100) then
		evt.Subtract("Gold", 100)
		evt.Add("Inventory", 635)         -- "Seashell"
		evt.SetMessage(14)         -- "Here you go, I hope it reminds you of your trip to Emerald Island."
	else
		evt.SetMessage(15)         -- "I really can't go any less than 100 gold; I need to make a living, too."
	end
end

-- "Harmondale?"
evt.CanShowTopic[17] = function()
	return not evt.Cmp("QBits", 7)         -- Finished Scavenger Hunt
end

evt.global[17] = function()
	evt.SetMessage(10)         --[[ "Congratulations!  You’ve completed all four assignments in record time, just as the Erathian Festival of the Five Moons is ending!   You are now ready to join the ranks of our elite guild. I hereby promote you to the rank of Master Courier!  Welcome to the Guild! 

Now just one more thing.  Our couriers used to service the Evenmorn Islands. Unfortunately through a series of miss-haps, all keys to the island chain were lost, stolen, or destroyed.   If you ever come across one of these keys, please bring it back to me so that I can make a copy of it.  I will reward you handsomely in gold.  Good luck, Master Couriers!"" ]]
end

-- "Gatekeeper Woes!"
evt.global[18] = function()
	evt.SetMessage(17)         -- "The Town Portal spell has been unmade by strange and sinister magics.  The mages in Bracada have tried to remake the spell, but with no success.  This has caused all Gate Keepers much ruin since they can no longer earn their living through their abilites.  Why just the other day I saw Merta the Gatekeeper sweeping out the stables just to make ends meet.  I hope the mages can restore this spell soon."
end

-- "Erathia has been betrayed!"
evt.global[19] = function()
	evt.SetMessage(21)         -- "We have discovered a corruption so powerful that it threatens to engulf all of Erathia. Due to this peril, we have formed a temporary truce with Lord Archibald until we can ‘neutralize’ this threat. Since the danger was spawned in The Pit, you need to travel there and seek out Maximus.  He will brief you on the situation.  Obey him as if his words were spoken by Gavin Magnus, himself."
	evt.Set("QBits", 293)         -- Return to NWC
	evt.SetNPCTopic{NPC = 82, Index = 0, Event = 0}         -- "Sir Caneghem"
	evt.MoveNPC{NPC = 85, HouseId = 434}         -- "Maximus" -> "Hostel"
	evt.SetNPCTopic{NPC = 85, Index = 0, Event = 22}         -- "Maximus" : "Dangerous Mission"
end

-- "Erathia has been betrayed!"
evt.global[20] = function()
	evt.SetMessage(206)         -- "We have discovered a corruption so powerful that it threatens to engulf all of Erathia. Due to this peril, we have formed a temporary truce with Gavin Magnus until we can ‘neutralize’ this threat. Since the danger was spawned in Celeste, you need to travel there and seek out Sir Caneghem.  He will brief you on the situation.  Obey him as if his words were spoken by Lord Archibald, himself."
	evt.Set("QBits", 293)         -- Return to NWC
	evt.SetNPCTopic{NPC = 85, Index = 0, Event = 0}         -- "Maximus"
	evt.MoveNPC{NPC = 82, HouseId = 427}         -- "Sir Caneghem" -> "Hostel"
	evt.SetNPCTopic{NPC = 82, Index = 0, Event = 21}         -- "Sir Caneghem" : "Dangerous Mission"
end

-- "Dangerous Mission"
evt.global[21] = function()
	evt.SetMessage(209)         -- "This assignment is extremely dangerous, adventurers.  So I have taken the liberty to solicit the assistance of the four Grandmasters of the Elemental Magicks, and each has agreed to provide what assistance they may to you.  So before I can brief you on this mission, you must first visit these Grandmasters and receive their blessing.  After this, return to me."
	evt.SetNPCTopic{NPC = 82, Index = 0, Event = 117}         -- "Sir Caneghem" : "We've received the Blessings!"
	evt.SetNPCTopic{NPC = 145, Index = 2, Event = 23}         -- "Torrent" : "Blessing"
	evt.SetNPCTopic{NPC = 139, Index = 2, Event = 24}         -- "Blayze " : "Blessing"
	evt.SetNPCTopic{NPC = 142, Index = 2, Event = 25}         -- "Gayle" : "Blessing"
	evt.SetNPCTopic{NPC = 148, Index = 2, Event = 26}         -- "Avalanche" : "Blessing"
end

-- "Dangerous Mission"
evt.global[22] = function()
	evt.SetMessage(209)         -- "This assignment is extremely dangerous, adventurers.  So I have taken the liberty to solicit the assistance of the four Grandmasters of the Elemental Magicks, and each has agreed to provide what assistance they may to you.  So before I can brief you on this mission, you must first visit these Grandmasters and receive their blessing.  After this, return to me."
	evt.SetNPCTopic{NPC = 85, Index = 0, Event = 119}         -- "Maximus" : "We've received the Blessings!"
	evt.SetNPCTopic{NPC = 145, Index = 2, Event = 23}         -- "Torrent" : "Blessing"
	evt.SetNPCTopic{NPC = 139, Index = 2, Event = 24}         -- "Blayze " : "Blessing"
	evt.SetNPCTopic{NPC = 142, Index = 2, Event = 25}         -- "Gayle" : "Blessing"
	evt.SetNPCTopic{NPC = 148, Index = 2, Event = 26}         -- "Avalanche" : "Blessing"
end

-- "Blessing"
evt.global[23] = function()
	evt.SetMessage(211)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 295)         -- Water
	evt.ForPlayer(0)
	evt.Add("WaterResistance", 50)
	evt.ForPlayer(1)
	evt.Add("WaterResistance", 50)
	evt.ForPlayer(2)
	evt.Add("WaterResistance", 50)
	evt.ForPlayer(3)
	evt.Add("WaterResistance", 50)
	evt.SetNPCTopic{NPC = 145, Index = 2, Event = 0}         -- "Torrent"
end

-- "Blessing"
evt.global[24] = function()
	evt.SetMessage(211)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 296)         -- Fire
	evt.ForPlayer(0)
	evt.Add("FireResistance", 50)
	evt.ForPlayer(1)
	evt.Add("FireResistance", 50)
	evt.ForPlayer(2)
	evt.Add("FireResistance", 50)
	evt.ForPlayer(3)
	evt.Add("FireResistance", 50)
	evt.SetNPCTopic{NPC = 139, Index = 2, Event = 0}         -- "Blayze "
end

-- "Blessing"
evt.global[25] = function()
	evt.SetMessage(211)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 297)         -- Air
	evt.ForPlayer(0)
	evt.Add("AirResistance", 50)
	evt.ForPlayer(1)
	evt.Add("AirResistance", 50)
	evt.ForPlayer(2)
	evt.Add("AirResistance", 50)
	evt.ForPlayer(3)
	evt.Add("AirResistance", 50)
	evt.SetNPCTopic{NPC = 142, Index = 2, Event = 0}         -- "Gayle"
end

-- "Blessing"
evt.global[26] = function()
	evt.SetMessage(211)         --[[ "What you are about to attempt will try your mettle and prove your worth.  If you are successful, you’ll be heralded as the ‘Heroes of Erathia’.  If you fail, the Erathian way of life will be destroyed by unspeakable evil. For Erathia, and for your victory, I give you my blessing.

For Truth!  For Justice!  For the Erathian Way!" ]]
	evt.Set("QBits", 298)         -- Earth
	evt.ForPlayer(0)
	evt.Add("EarthResistance", 50)
	evt.ForPlayer(1)
	evt.Add("EarthResistance", 50)
	evt.ForPlayer(2)
	evt.Add("EarthResistance", 50)
	evt.ForPlayer(3)
	evt.Add("EarthResistance", 50)
	evt.SetNPCTopic{NPC = 148, Index = 2, Event = 0}         -- "Avalanche"
end

-- "Will you rejoin our party?"
evt.global[27] = function()
	evt.SetMessage(54)         -- "You have decided to listen to my tour about the points of interest on Emerald Island.  If you decide that you no longer want me to point out areas of interest then select Tour Off."
	evt.Subtract("QBits", 17)         -- No more docent babble
	evt.Set("NPCs", 3)         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 3, Index = 2, Event = 43}         -- "Big Daddy Jim" : "We need your help!"
end

-- "Fire Magic Expert"
evt.global[28] = function()
	evt.SetMessage(22)         --[[ "So you wanna become an Ekspert in Fire Magic? My, my ... aren't we feeling 'special'!  <hic!>  Pardon me.  I've been hittin' the sauce too much lately.

Ohhh!  I've gotta hangov ...  err ... headache.  I can't deal with this right now.  Just go away ... <burp> ... and let me be!!!" ]]
end

-- "Purchase Town Portal Pass for 200 gold"
evt.global[29] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 200) then
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 200)
		evt.Add("Inventory", 737)         -- "Town Portal Pass"
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Fire Magic Master"
evt.global[30] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 560) then         -- "Watcher's Ring of Elemental Fire"
		evt.SetMessage(776)         -- "I see that you've returned with the Watcher's Ring of Elemental Fire. Excellent!   Now we can discuss your promotion to Master of Fire Magic."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 138, Index = 0, Event = 237}         -- "Ashen Temper" : "Fire Magic Master"
		return
	end
	if not evt.Cmp("Inventory", 562) then         -- "Ring of UnWarding"
		evt.ForPlayer("Current")
		evt.Set("Inventory", 562)         -- "Ring of UnWarding"
	end
	evt.SetMessage(775)         -- "Before I can promote you to Master of Fire Magic, you must first retrieve the Watcher's Ring of Elemental Fire and return it to me.  The Ring is guarded by powerful Dragons who live in a cave on Emerald Island.  Make sure you keep the Ring of UnWarding with you to enter the cave."
end

-- "Earth Magic Grandmaster"
evt.global[31] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 553) then         -- "Watcher's Ring of Elemental Earth "
		evt.SetMessage(778)         -- "I see that you've defeated Greckaw and returned with the Watcher's Ring of Elemental Earth. An impressive accomplishment, indeed!!   Now we can discuss your promotion to Master of Earth Magic."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 148, Index = 0, Event = 247}         -- "Avalanche" : "Earth Magic Grandmaster"
		return
	end
	if not evt.Cmp("Inventory", 253) then         -- "Divine Cure"
		evt.Set("Inventory", 253)         -- "Divine Cure"
	end
	evt.Set("QBits", 324)         -- White Cliff Cave Permission
	evt.SetMessage(777)         --[[ "Retrieve the Watcher's Ring of Elemental Earth and then we’ll discuss promotions.  The Ring is guarded by Greckaw, Hurler of Mountains, a powerful Earth Elemental who dwells in the White Cliff Caves in Harmondale. 

Be extremely cautious when you enter this cave, children.  The Mad Mage Pascal, Diviner of Strange Flesh has sent his army of Trolls to take this ring by force, and a battle rages between Greckaw’s minions and these invaders.  You would do well to let them fight it out and then kill the survivors.  But make no mistake, young ones, either side will turn on you in a heartbeat! 

Make sure you have some healing potents with you.  You’ll need them!" ]]
end

-- "Let's go!"
evt.global[32] = function()
	evt.SetMessage(24)         -- "Sorry mates, this vessel's moored until a winner has been declared in the contest."
end

-- "Let's Go!"
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

-- "Do you have any quests for us?"
evt.global[34] = function()
	evt.SetMessage(44)         -- "Keep in mind I have a 1000 gold reward for the group to bring back information on the contestants that have disappeared."
	evt.SetNPCTopic{NPC = 1, Index = 3, Event = 35}         -- "Lord Markham" : "About the missing contestants..."
	evt.Set("QBits", 16)         -- "Find the missing contestants on Emerald Island and bring back proof to Lord Markham."
end

-- "About the missing contestants..."
evt.global[35] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 658) then         -- "Contestant's Shield"
		evt.SetMessage(46)         -- "Killed by another group of contestants?!  Beyond belief!  Is there no end to the Greed of Man?!  Thanks for dispatching these criminals for me!  Here's your reward."
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

-- "The Coding Wizard"
evt.global[36] = function()
	evt.SetMessage(770)         -- "“BDJ the Coding Wizard, lives on the mainland. All those who have gained Grandmaster status in their chosen profession should seek out this wizard.  It is reported that he offers to ‘cross-train’ them into a second profession, thereby granting dual-character classes to all who meet his requirements.”"
end

-- "Is the cave behind your house the abandoned temple?"
evt.global[37] = function()
	evt.SetMessage(48)         -- "The cave right behind my house is not the Abandoned Temple.  It belongs to Morcarack the Pitiless, the Dragon of Emerald Island.  You don't have to worry, though.  The cave has been magically sealed for ages by the Watchers.  The Abandoned Temple is buried in the hill south of my house.  You can get to it by entering the caves at the top of the hill."
end

-- "The Watchers"
evt.global[38] = function()
	evt.SetMessage(49)         -- "In the beginning, the Watchers forged four Scarab Rings of Elemental Magic and hid them in the land under the protection of a fierce guardian.  Powerful indeed is the wizard who obtains these rings!!"
end

-- "How can we get to the mainland from here?"
evt.global[39] = function()
	evt.SetMessage(50)         -- "Getting to the mainland is no problem.  The Lady Margaret makes daily trips to Harmondale.  Getting back, now that's a different story. The fine Lady only carries cargo back to here. I have heard rumors that there is a teleporter hub in Harmondale, but I don't know if it can return you to our island."
end

-- "Let's Go!"
evt.global[40] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Invisible, On = true}         -- "Main village in Harmondy"
		evt.Set("NPCs", 21)         -- "Zedd True Shot"
		evt.SetNPCTopic{NPC = 21, Index = 1, Event = 0}         -- "Zedd True Shot"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Have you seen any other contestants?"
evt.global[41] = function()
	evt.SetMessage(52)         -- "I'd watch those other contestants-- some of them seem ruthless.  One particularly nasty group headed to the north side of the island, and I haven't seen them since.  I'm surprised at the attention this contest has received, apparently people are hoping to get on the good side of the contestants for future favors if they win."
end

-- "Good Bye."
evt.global[42] = function()
	evt.StatusText(42)         -- "Enjoy the Game!"
	evt.SetNPCTopic{NPC = 3, Index = 0, Event = 0}         -- "Big Daddy Jim"
	evt.SetNPCTopic{NPC = 3, Index = 1, Event = 0}         -- "Big Daddy Jim"
	evt.Subtract("NPCs", 3)         -- "Big Daddy Jim"
end

-- "We need your help!"
evt.global[43] = function()
	evt.SetMessage(54)         -- "You have decided to listen to my tour about the points of interest on Emerald Island.  If you decide that you no longer want me to point out areas of interest then select Tour Off."
	evt.Subtract("QBits", 17)         -- No more docent babble
	evt.SetNPCTopic{NPC = 3, Index = 2, Event = 42}         -- "Big Daddy Jim" : "Good Bye."
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
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(58)         -- "You have chosen the path of Darkness, and I will promote you no further.  Perhaps an Assassin would have something to teach you.  I hear there is one in Deyja."
		else
			evt.SetMessage(59)         -- "You are not quite ready to take the next step.  The time is fast approaching when you must decide whether to follow the path of light, or the path of darkness.  If you choose the Light, return to me to complete your training."
		end
	end
end

-- "Spy"
evt.global[47] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 20) then         -- Watchtower 6.  Weight in the appropriate box.  Important for Global event 47 (Spy promotion)
		if evt.Cmp(-- ERROR: Not found
"Inventory", 999) then
			evt.SetMessage(61)         -- "Um…The weight needs to go in the box in the lower gatehouse—not here.  Go back to Watchtower 6 and put the weight in the right box!"
		else
			if evt.Cmp("QBits", 56) then         -- Watchtower 6.  Taken the weight from the upper gatehouse.  Spy promo quest
				evt.SetMessage(62)         -- "Hmm.  Removing the weight from the upper gatehouse was a start, but where is it now?!?  The plan won’t work unless you put the weight in the lower gatehouse!  Go back to Watchtower 6 and put the weight in the right box!"
			else
				evt.SetMessage(63)         -- "You haven’t done the job yet!  Remember, you must go to Watchtower 6 and move the weight from the box in the upper gatehouse to the lower gatehouse.  I will not promote you until that is done. "
			end
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
	evt.SetNPCGreeting{NPC = 15, Greeting = 39}         -- "William Lasker" : "Greetings Rogues, how may I be of service?"
end

-- "Greetings from BDJ!"
evt.global[48] = function()
	evt.SetMessage(71)         --[[ "BDJ’s the name, coding wizard’s the Game! And I do trust that you are enjoying the ‘game’.

I see that you have survived The Gauntlet in good fashion.  Congratulations!  You may now select a new profession for each qualified party member.  Each member will be presented with three choices for a new profession.  Based upon the choice, twenty ‘bonus’ points will be distributed to one-or-more attributes: re, a new fighter will gain +15 Endurance and +5 Might; a new sorcerer will gain +20 Intellect.

When you select the new profession, the member will automatically be promoted to the highest rating in that character class; re, a Fighter will immediately become a Champion, a Sorcerer an Arch Mage.  Once you’ve selected your new profession, you will no longer continue to advance in your original profession, although you will retain all or your previous skill and spell abilities." ]]
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 49}         -- "The Coding Wizard" : "How does this work?"
	evt.MoveNPC{NPC = 460, HouseId = 470}         -- "Lord Godwinson" -> "Godwinson Estate"
	evt.SetNPCTopic{NPC = 460, Index = 0, Event = 96}         -- "Lord Godwinson" : "Coding Wizard Quest"
	evt.SetNPCGreeting{NPC = 460, Greeting = 26}         -- "Lord Godwinson" : "Well met, my friends!  Sit a-spell and tell me all about your recent adventures."
end

-- "How does this work?"
evt.global[49] = function()
	evt.SetMessage(72)         --[[ "Here’s how the process works.  You have four members in your party; member 1, member 2, member 3, and member 4 (from left-to-right).  Each time you select “New Profession”, you will ‘index’ to a different party member, starting at member 1.  The member will be presented with a single ‘fast track’ choice.  You may either select this choice or ‘EXIT’ and then select me a second time to be presented with three choices.

When the selected party member has chosen a new profession, proceed to the Brazier to acquire the new profession and then return to me.  When all four members have selected their new Profession, return to me one more time and then we’re done.  So let’s get started, ok?" ]]
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 50}         -- "The Coding Wizard" : "New Profession."
end

-- "New Profession."
evt.global[50] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 338) then         -- BDJ Final
		evt.SetMessage(86)         -- "Adventurer 4, select your new profession."
		evt.ForPlayer(3)
	else
		if evt.Cmp("QBits", 337) then         -- BDJ 3
			evt.SetMessage(85)         -- "Adventurer 3, select your new profession."
			evt.ForPlayer(2)
		else
			if evt.Cmp("QBits", 336) then         -- BDJ 2
				evt.SetMessage(84)         -- "Adventurer 2, select your new profession."
				evt.ForPlayer(1)
			else
				evt.SetMessage(83)         -- "Adventurer 1, select your new profession."
				evt.ForPlayer(0)
			end
		end
	end
	evt.Set("QBits", 349)         -- One Use
	if evt.Cmp("ClassIs", const.Class.ArchMage) then
		evt.SetNPCTopic{NPC = 456, Index = 0, Event = 70}         -- "The Coding Wizard" : "Archer"
		evt.SetNPCTopic{NPC = 456, Index = 1, Event = 86}         -- "The Coding Wizard" : "Paladin"
		evt.SetNPCTopic{NPC = 456, Index = 2, Event = 57}         -- "The Coding Wizard" : "Cleric"
	else
		if evt.Cmp("ClassIs", const.Class.PriestLight) then
			evt.SetNPCTopic{NPC = 456, Index = 0, Event = 75}         -- "The Coding Wizard" : "Druid"
			evt.SetNPCTopic{NPC = 456, Index = 1, Event = 86}         -- "The Coding Wizard" : "Paladin"
			evt.SetNPCTopic{NPC = 456, Index = 2, Event = 70}         -- "The Coding Wizard" : "Archer"
		else
			if evt.Cmp("ClassIs", const.Class.MasterArcher) then
				evt.SetNPCTopic{NPC = 456, Index = 0, Event = 86}         -- "The Coding Wizard" : "Paladin"
				evt.SetNPCTopic{NPC = 456, Index = 1, Event = 81}         -- "The Coding Wizard" : "Monk"
				evt.SetNPCTopic{NPC = 456, Index = 2, Event = 75}         -- "The Coding Wizard" : "Druid"
			else
				if evt.Cmp("ClassIs", const.Class.ArchDruid) then
					evt.SetNPCTopic{NPC = 456, Index = 0, Event = 70}         -- "The Coding Wizard" : "Archer"
					evt.SetNPCTopic{NPC = 456, Index = 1, Event = 81}         -- "The Coding Wizard" : "Monk"
					evt.SetNPCTopic{NPC = 456, Index = 2, Event = 56}         -- "The Coding Wizard" : "Sorcerer"
				else
					if evt.Cmp("ClassIs", const.Class.Champion) then
						evt.SetNPCTopic{NPC = 456, Index = 0, Event = 70}         -- "The Coding Wizard" : "Archer"
						evt.SetNPCTopic{NPC = 456, Index = 1, Event = 76}         -- "The Coding Wizard" : "Ranger"
						evt.SetNPCTopic{NPC = 456, Index = 2, Event = 75}         -- "The Coding Wizard" : "Druid"
					else
						if evt.Cmp("ClassIs", const.Class.Master) then
							evt.SetNPCTopic{NPC = 456, Index = 0, Event = 82}         -- "The Coding Wizard" : "Thief"
							evt.SetNPCTopic{NPC = 456, Index = 1, Event = 75}         -- "The Coding Wizard" : "Druid"
							evt.SetNPCTopic{NPC = 456, Index = 2, Event = 70}         -- "The Coding Wizard" : "Archer"
						else
							if evt.Cmp("ClassIs", const.Class.Hero) then
								evt.SetNPCTopic{NPC = 456, Index = 0, Event = 75}         -- "The Coding Wizard" : "Druid"
								evt.SetNPCTopic{NPC = 456, Index = 1, Event = 76}         -- "The Coding Wizard" : "Ranger"
								evt.SetNPCTopic{NPC = 456, Index = 2, Event = 70}         -- "The Coding Wizard" : "Archer"
							else
								if evt.Cmp("ClassIs", const.Class.RangerLord) then
									evt.SetNPCTopic{NPC = 456, Index = 0, Event = 70}         -- "The Coding Wizard" : "Archer"
									evt.SetNPCTopic{NPC = 456, Index = 1, Event = 86}         -- "The Coding Wizard" : "Paladin"
									evt.SetNPCTopic{NPC = 456, Index = 2, Event = 82}         -- "The Coding Wizard" : "Thief"
								else
									if not evt.Cmp("ClassIs", const.Class.Spy) then
										evt.Subtract("QBits", 349)         -- One Use
										evt.SetMessage(40)         -- "You don't Qualify"
										return
									end
									evt.SetNPCTopic{NPC = 456, Index = 0, Event = 70}         -- "The Coding Wizard" : "Archer"
									evt.SetNPCTopic{NPC = 456, Index = 1, Event = 69}         -- "The Coding Wizard" : "Fighter"
									evt.SetNPCTopic{NPC = 456, Index = 2, Event = 81}         -- "The Coding Wizard" : "Monk"
								end
							end
						end
					end
				end
			end
		end
	end
	evt.SetNPCTopic{NPC = 456, Index = 3, Event = 123}         -- "The Coding Wizard" : "No Thanks."
end

-- "Crusader"
evt.global[51] = function()
	evt.ForPlayer("Current")
	evt.SetMessage(74)         -- "If you wish to be promoted to Crusader, you must first bring me the map that indicates the location of Sir BunGleau's panoply. Here, take this scroll of the Saints.  It will provide you with a firm foundation as you begin your quest."
	evt.Set("QBits", 22)         -- "Find the map that shows the location of Sir BunGleau's panoply and return it to the Massenger of the Saints.."
	evt.Add("Inventory", 730)         -- "Saints of Selinas Scroll 2"
	evt.SetNPCGreeting{NPC = 450, Greeting = 10}         -- "Messenger of the Saints" : "Greetings again, friends."
	evt.SetNPCTopic{NPC = 450, Index = 0, Event = 52}         -- "Messenger of the Saints" : "Crusader"
end

-- "Crusader"
evt.global[52] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 739) then         -- "Map to Treasure"
		evt.SetMessage(76)         -- "You must bring the map to me before I can name thee Crusaders."
		return
	end
	evt.SetMessage(75)         -- "Ahh!  I see you've completed your quest and have returned with the map.  May the Saints be praised! I hereby promote all Paladins to Crusaders, and all others to Honorary Crusaders!  Congratulations!"
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
	evt.Subtract("QBits", 22)         -- "Find the map that shows the location of Sir BunGleau's panoply and return it to the Massenger of the Saints.."
	evt.Subtract("NPCs", 17)         -- "Sally"
	evt.Subtract("Inventory", 739)         -- "Map to Treasure"
	evt.Subtract("Inventory", 729)         -- "Saints of Selinas Scroll 1"
	evt.Subtract("Inventory", 733)         -- "Saints of Selinas Scroll 5"
	evt.Subtract("Inventory", 730)         -- "Saints of Selinas Scroll 2"
	evt.Subtract("Inventory", 735)         -- "Saints of Selinas Scroll 6"
	evt.Subtract("Inventory", 731)         -- "Saints of Selinas Scroll 3"
	evt.Subtract("Inventory", 732)         -- "Saints of Selinas Scroll 4"
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 450, Index = 0, Event = 53}         -- "Messenger of the Saints" : "Hero"
end

-- "Hero"
evt.global[53] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(77)         -- "I am pleased to see you have chosen the path of Light, Crusaders!  It is now time to retrieve the panoply of Sir BunGleau and once again employ it in the fight against the Dark!!  To accomplish this you must return to Emerald Island and drink from the Well of Luck.  This will transport you to the Place of Hiding where you will find the panoply.  Return to me with this panoply to complete your promotion.  ** Oh ... beware of the Blue Guardians!! *"
		evt.SetNPCTopic{NPC = 450, Index = 0, Event = 54}         -- "Messenger of the Saints" : "Hero"
		evt.Set("QBits", 24)         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
		evt.SetNPCGreeting{NPC = 450, Greeting = 10}         -- "Messenger of the Saints" : "Greetings again, friends."
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(78)         -- "I will not have truck with thee further, scoundrel!  I see now thee hath chosen the path of Darkness.  Mayhaps thee should seek a villain like thyself for training."
		else
			evt.SetMessage(79)         -- "Ah, my Crusader friends!  I know you seek another task with which to hone your Crusading skills, but first you must pass a far more serious test.  You must agree to follow the Path of Light before I can help you further.  You will know when you have made this choice.  Return to me then."
		end
	end
end

-- "Hero"
evt.global[54] = function()
	if not evt.Cmp("Inventory", 557) then         -- "SBG's Blessed Gauntlets"
		evt.SetMessage(81)         -- "Though your deeds remain impressive indeed, crusaders, I cannot declare you Heroes until you return the panoply to me."
		return
	end
	evt.SetMessage(80)         -- "You’ve done it! I knew you could do it!  I’m so proud of you!  Another victory for the Light!  You can keep the panoply and use it for Truth, Justice, and the Erathian way! [The Angel sighs and smiles broadly] Well.  My work here is done!  You have passed the tests and deserve your reward.  Therefore do I solemnly declare you Heroes! "
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
	evt.Subtract("QBits", 24)         -- "Find the Blessed Panoply of Sir BunGleau and return to the Angel in Castle Harmondale""
	evt.Subtract("NPCs", 54)         -- "Alice Hargreaves"
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.SetNPCGreeting{NPC = 450, Greeting = 46}         -- "Messenger of the Saints" : "Salutations Heroes!  I am certain thou hast much to accomplish before we dally about."
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Southern Village Group in Harmondy"
	evt.SetNPCTopic{NPC = 450, Index = 0, Event = 0}         -- "Messenger of the Saints"
	evt.Set("QBits", 373)         -- Harm no respawn
end

-- "Hello?"
evt.global[55] = function()
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		if evt.Cmp("QBits", 25) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.SetMessage(85)         -- "Adventurer 3, select your new profession."
		else
			evt.SetMessage(84)         -- "Adventurer 2, select your new profession."
			evt.Set("QBits", 25)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
			evt.Set("NPCs", 54)         -- "Alice Hargreaves"
		end
	else
		if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(83)         -- "Adventurer 1, select your new profession."
		else
			if evt.Cmp("QBits", 25) then         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
				evt.SetMessage(87)         -- "There ya go!  Now return this scroll to Lord Godwinson to complete this quest.  Then he’ll know that I am more than a myth."
			else
				evt.SetMessage(86)         -- "Adventurer 4, select your new profession."
				evt.Set("QBits", 25)         -- Mini-dungeon Area 5.  Rescued/Captured Alice Hargreaves.
				evt.Set("NPCs", 54)         -- "Alice Hargreaves"
			end
		end
	end
end

-- "Sorcerer"
evt.global[56] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 339)         -- Sorcerer
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Cleric"
evt.global[57] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 340)         -- Cleric
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Initiate"
evt.global[58] = function()
	evt.SetMessage(93)         -- "Ah, it is normal for novice Monks to ask for the path of enlightenment.  I shall tell you of the path, though the journey is yours to make.  In the Barrow Downs is a series of tombs-- one of which was constructed on a site of great natural power.  You will know the right barrow because it is different from the rest.  Reach this barrow and meditate by the water, and your promotion to Initiate will be complete."
	evt.Set("QBits", 27)         -- "Find the lost meditation spot in the Dwarven Barrows."
	evt.SetNPCTopic{NPC = 38, Index = 1, Event = 59}         -- "Bartholomew Hume" : "Initiate"
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
	evt.SetNPCTopic{NPC = 38, Index = 1, Event = 61}         -- "Bartholomew Hume" : "Master"
	evt.SetNPCTopic{NPC = 55, Index = 0, Event = 0}         -- "Bartholomew Hume"
end

-- "Master"
evt.global[61] = function()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(97)         -- "I am sorry, but I am permitted to train you no longer.  You will need to find a new Master to learn from."
	else
		if evt.Cmp("QBits", 99) then         -- Chose the path of Light
			evt.SetMessage(96)         -- "I see you wish to continue your journey.  Excellent!  Have no fear, for you are prepared for your next step.  You must extinguish the remnants of an evil order- the Order of Baa.  Defeat their High Priest and return to me and I shall complete your training and promote you to Master."
			evt.Set("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
			evt.SetNPCTopic{NPC = 38, Index = 1, Event = 62}         -- "Bartholomew Hume" : "Master"
		else
			evt.SetMessage(98)         -- "A fork approaches in your path.  I will only train you after you've chosen to walk the lighter path."
		end
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
	evt.SetNPCTopic{NPC = 38, Index = 1, Event = 0}         -- "Bartholomew Hume"
	evt.SetNPCGreeting{NPC = 38, Greeting = 52}         -- "Bartholomew Hume" : "Greetings again, Masters.  How can Bartholomew aid you?"
end

-- "Quest"
evt.global[63] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 552) then         -- "Grognard's Cutlass"
		evt.SetMessage(53)         -- "I see you’ve cleared the area of Goblins and have returned with Grognard’s Cutlass.  Good job!  The stables will now renew our services."
		evt.Set("Awards", 26)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 7500)
		evt.Add("Gold", 500)
		evt.Subtract("QBits", 383)         -- "Bring the Grognard's Cutlass to Christian at the J.V.C Corral."
		evt.SetNPCTopic{NPC = 461, Index = 0, Event = 0}         -- "Christian the Stablemaster"
	else
		evt.SetMessage(2)         --[[ "The Stable Guild has discovered that a raiding force of Goblins, lead by the infamous Grognard, is poised to launch an incursion into Harmondale.  Until this threat is ‘neutralized’, the stables will remain closed.

The Guild has intercepted and ‘detained’ a Goblin courier who has revealed that the Goblin force will launch their attack shortly after ‘signal fires’ are lighted.  Don’t know about these ‘signal fires’, but if you can find them, light them, and then ambush the invasion force, perhaps you could deal with this threat decisively.

If you will ‘neutralize’ this threat and bring me proof that it is safe once again to renew our services, I will re-open the stables.  The proof I will need is the Grognard’s Cutlass carried by the Goblin leader." ]]
		evt.Set("QBits", 383)         -- "Bring the Grognard's Cutlass to Christian at the J.V.C Corral."
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
	evt.SetMessage(142)         -- "Well done.  No one can argue with success except apologists for the weak and the cowardly.  I hearby promote all Initiates to Ninjas, and all non-Initiates to Honorary Ninjas.  Oh yeah, go ahead and keep that little trinket you stole from the tomb.  This was just a training exercise, after all."
	evt.ForPlayer(0)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(1)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(2)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.ForPlayer(3)
	if evt.Cmp("ClassIs", const.Class.Initiate) then
		evt.Set("ClassIs", const.Class.Ninja)
		evt.Add("Awards", 26)         -- "Reopened Harmondale Stables"
		evt.Add("Experience", 80000)
	else
		evt.Add("Awards", 27)         -- "Promoted to Honorary Ninja"
		evt.Add("Experience", 40000)
	end
	evt.Subtract("QBits", 29)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
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
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(145)         -- "You have chosen the path of Darkness.  I will never help you improve, for fear you will use your skills to advance your selfish goals!"
		else
			evt.SetMessage(144)         -- "So, you've achieved the rank of Warrior Mage, and wish to advance to Master Archer!  A worthy goal, but I only promote those who's heart and courage match their skill.  Come back to me when you have firmly committed to the Light.  Then I will help you."
		end
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
	evt.SetMessage(149)         -- "So you want to become Warrior Mages, do you?  It isn't easy.  You must be equally proficient in magical skills and physical skills.  There is a test of this.  Visit the Red Dwarf Mines.  Inside you will find two kinds of beasts--one that can be harmed only with magic, and one that can be harmed only with steel.  In the back of the lower section of the mines you will find a machine created by the Dwarves that powers the lift-- the only access between the upper and lower sections of the mines.  To keep the creatures trapped in the lower section, you will have to replace the belt in the machine with this one, a worn belt that will only last about an hour before breaking.  This should give you enough time to get to the lift and get out before you are trapped down there.  Seal away these creatures and return to me-- only then will I call you Warrior Mages."
	evt.Add("Inventory", 649)         -- "Worn Belt"
	evt.Add("QBits", 31)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
	evt.Add("QBits", 216)         -- Worn Belt - I lost it
	evt.SetNPCTopic{NPC = 21, Index = 1, Event = 68}         -- "Zedd True Shot" : "Warrior Mage"
end

-- "Warrior Mage"
evt.global[68] = function()
	if not evt.Cmp("QBits", 58) then         -- Destroyed critter generator in dungeon.  Warrior Mage promo quest.
		evt.SetMessage(151)         -- "You haven't sabotaged the machine yet.  You must finish this before I'll promote you to Warrior Mage."
		return
	end
	evt.SetMessage(150)         -- "Very Good.  You have passed the test.  Now the creatures are sealed away and won't be able to prey on the dwarves any longer, and you have proven your ability in both sorcery and steel.  I am proud to declare all Archers amongst you Warrior Mages, and everyone else Honorary Warrior Mages.  Congratulations!  See you later in 'The Game'. "
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
	evt.Subtract("QBits", 31)         -- "Sabotage the lift in the Red Dwarf Mines in the Bracada Desert then return to Zedd True Shot on Emerald Island."
	evt.Add("Gold", 7500)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 21, Index = 1, Event = 0}         -- "Zedd True Shot"
end

-- "Fighter"
evt.global[69] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 341)         -- Fighter
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Archer"
evt.global[70] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 346)         -- Archer
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
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
	else
		if evt.Cmp("QBits", 99) then         -- Chose the path of Light
			evt.SetMessage(157)         -- "So you want to be champions, do you?  Ha!  How can you be a champion if you don't win any tournaments?  You know, I can't really promote you to Champion status--you have to do it yourself, just like everything else.  Go and win five championship tournaments in the Arena at Knight level, and come back to me.  I'll call you Champions then, if you want."
			evt.Set("QBits", 33)         -- "Win five arena challenges then return to Leda Rowan in the Bracada Desert."
			evt.SetNPCTopic{NPC = 42, Index = 0, Event = 72}         -- "Leda Rowan" : "Champion"
		else
			evt.SetMessage(158)         -- "I can see you very much want to be called Champions, but I'm not so sure I should help you.  Prove to me that you follow the Path of Light, and then we'll talk about promotion."
		end
	end
end

-- "Champion"
evt.global[72] = function()
	if not evt.Cmp("ArenaWinsKnight", 5) then
		evt.SetMessage(162)         -- "You have not yet won 5 championship tournaments in the Arena.  Return to me when you have won five, and I will promote you.  Remember, these battles MUST be at the Knight difficulty level."
		return
	end
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
	evt.SetNPCTopic{NPC = 43, Index = 0, Event = 0}         -- "Frederick Org"
	evt.MoveNPC{NPC = 43, HouseId = 0}         -- "Frederick Org"
end

-- "Druid"
evt.global[75] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 347)         -- Druid
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Ranger"
evt.global[76] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 345)         -- Ranger
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
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
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(174)         -- "[Lysander frowns] You've chosen the path of darkness.  I refuse to teach such as you--you would only use my lessons to further your selfish goals.  May Heaven have mercy on your souls."
		else
			evt.SetMessage(172)         -- "I would like to be your teacher--I really would, but I'm not sure you're cut out to be a Ranger Lord.  Soon you must make a decision of the heart.  If you choose the Path of Light, return to me.  I would be honored to be your teacher."
		end
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

-- "Monk"
evt.global[81] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 343)         -- Monk
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Thief"
evt.global[82] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 344)         -- Thief
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
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
	evt.SetNPCTopic{NPC = 45, Index = 0, Event = 0}         -- "Ebednezer Sower"
	evt.SetNPCTopic{NPC = 52, Index = 0, Event = 0}         -- "Faerie King"
	evt.MoveNPC{NPC = 45, HouseId = 0}         -- "Ebednezer Sower"
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

-- "Paladin"
evt.global[86] = function()
	evt.ForPlayer("All")
	evt.Set("QBits", 342)         -- Paladin
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(41)         -- "Proceed to the Brazier to acquire your new profession."
end

-- "Let's Continue."
evt.global[87] = function()
	evt.ForPlayer("All")
	evt.SetMessage(87)         -- "There ya go!  Now return this scroll to Lord Godwinson to complete this quest.  Then he’ll know that I am more than a myth."
	evt.SetNPCTopic{NPC = 456, Index = 0, Event = 0}         -- "The Coding Wizard"
	evt.Set("QBits", 206)         -- Harmondale - Town Portal
	evt.Set("QBits", 207)         -- Erathia - Town Portal
	evt.Set("QBits", 208)         -- Tularean Forest - Town Portal
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for Malwick's Assc."
	evt.ForPlayer("Current")
	evt.Add("Inventory", 775)         -- "LG's Proof"
end

-- "Priest"
evt.global[88] = function()
	evt.SetMessage(195)         -- "[Falk gives you a grandfatherly smile] You have, perhaps, an ambition to be priests?  I can help you, if you'll help me.  There is an island south of Bracada where stands an old temple that I need to find again.  I think the pirates west of Erathia must know where the island is.  The Erathian navy is rather feeble, and hasn't been able to root them out of their hiding places amongst the Tidewater Caverns.  Perhaps the pirates have a map.  If you can bring me that map, I would promote you to Priest status immediately."
	evt.Set("QBits", 43)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk on Emerald Island."
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
	evt.Subtract("QBits", 43)         -- "Find the lost pirate map in the Tidewater Caverns in Tatalia and return to Daedalus Falk on Emerald Island."
	evt.Add("Gold", 5000)
	evt.Subtract("Reputation", 5)
	evt.ForPlayer("All")
	evt.Subtract("Inventory", 683)         -- "Map to Evenmorn Island"
	evt.Subtract("QBits", 218)         -- Map to Evenmorn - I lost it
	evt.SetNPCTopic{NPC = 47, Index = 0, Event = 90}         -- "Daedalus Falk" : "Priest of Light"
	evt.Set("QBits", 64)         -- Activate boat to area 9.  Priest promo quest
end

-- "Priest of Light"
evt.global[90] = function()
	if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		evt.SetMessage(200)         -- "How dare you insult me with your presence?  You have chosen the Path of Darkness, and have forever renounced me as your teacher.  Go now, and be consumed by your own selfish desires.  Get out of my sight!"
	else
		if evt.Cmp("QBits", 99) then         -- Chose the path of Light
			evt.SetMessage(198)         -- "Priests.  [Falk gazes warmly at you] Well it is that you have come to see the purity of the Path of Light.  Never regret your decision, and never look back.  South of Bracada is an island called Evenmorn, and upon that island are the old temples of the Sun and the Moon.  Both are inhabited by the remnants of the two religions, their once proud churches reduced to two old temples fighting for a small island.  The Church of the Sun was the founding religion for our current faith, the Path of Lights.  I propose we help them out and tip the balance in favor of the Church of the Sun.  Using the map that I sent you to find, convince a sea captain to bring you to the island.  There, bring aid and comfort to the Church of the Sun by purifying the altar in the Church of the Moon.  This will so weaken theMoon cult that the Church of the Sun will be able to overcome them in battle.  Return to me when you have done this.   "
			evt.Set("QBits", 42)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Daedalus Falk on Emerald Island."
			evt.SetNPCTopic{NPC = 47, Index = 0, Event = 91}         -- "Daedalus Falk" : "Priest of Light"
		else
			evt.SetMessage(199)         -- "If you wish to follow the Path of Light, first you must formally choose it.  Soon you will be asked to make the choice, and the way will be clear.  Until then, I cannot be your guide."
		end
	end
end

-- "Priest of Light"
evt.global[91] = function()
	if not evt.Cmp("QBits", 62) then         -- Purified the Altar of Evil.  Priest of Light promo quest.
		evt.SetMessage(202)         -- "You must visit Evenmorn island and purify the Altar of Darkness in the Church of the Moon.  Only then can I promote you to Priests of the Light."
		return
	end
	evt.SetMessage(201)         -- "Your bravery has advanced our faith tremendously, Priests.  It's with pleasure that I can hereby promote all Priests to Priests of the Light, and all honorary Priests to Honorary Priests of the Light.  Thank you so much for your help!"
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
	evt.Subtract("QBits", 42)         -- "Purify the Altar of Evil in the Temple of the Moon on Evenmorn Isle then return to Daedalus Falk on Emerald Island."
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
		evt.SetMessage(18)         --[[ "Our Diviners have been unable to discover who, or what, caused the unmaking of the Town Portal spell, but they have located the book that was used to accomplish this dastardly deed.  It’s called the Book of UnMakings.  The book was  kept under guard in the Strange Temple here in the Bracada.  However, several years ago, the temple was swallowed up by a terrible tremor that shook the Bracada, and the book went down with it.  This temple is now buried deep within the depths of the land, with no known entrance from the surface.

However, after consulting with Torrent, the Grandmaster of Water Migicks, we have been able to open an astral tunnel into the temple and link it to the Home Portal here in Bracada.  The tunnel is not too stable, and we aren’t sure how long we can keep it open.

If you desire this promotion, you must enter the tunnel, find the Book of UnMakings, and return it to me.  But you must go NOW.  We cannot afford to wait even an hour, lest the tunnel close." ]]
		evt.Set("QBits", 47)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
		evt.SetNPCTopic{NPC = 48, Index = 0, Event = 95}         -- "Thomas Grey" : "We've retrieved the Book of UnMakings!"
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(208)         -- "You've chosen Darkness, my students.  I will teach you no more."
		else
			evt.SetMessage(207)         -- "Archmage training is reserved only for people dedicated to the Path of Light.  Prove to me you have chosen the right way, and I will be proud to be your teacher."
		end
	end
end

-- "We've retrieved the Book of UnMakings!"
evt.global[95] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 499) then         -- "Book of UnMakings"
		evt.SetMessage(20)         --[[ "“The portal has collapsed!  Had you but heeded my words there would have been a chance to recover the Book of UnMakings.  But your hesitation has lost the book forever.

Get out of my sight.  You don’t have what it takes for this advancement."" ]]
		evt.SetNPCTopic{NPC = 48, Index = 0, Event = 0}         -- "Thomas Grey"
		evt.Subtract("QBits", 47)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
		return
	end
	evt.SetMessage(210)         --[[ "The Book of UnMakings!  Good work at recovering this book!  Now we can undo its work and remake the Town Portal spell!

Have you discovered who, or what, performed this dastardly deed of unMaking?  [You recount the encounter with the Golems, the Angels, and the Devils]    Devils, you say?  And they were in-league with the Golems and the Angels?!  This is not good ... not good at all!!!  But who, or what, could have engineered such a twisted coalition?

I sense that we haven’t unveiled the real source for this unnatural corruption.  I will consult our Diviners to see if they can unlock this mystery.  As for your party, you have done well and have earned your promotion.  Congratulations! " ]]
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
	evt.Subtract("QBits", 47)         -- "Recover the Book of Unmakings from the Strange Temple and return it to Thomas Grey in the School of Sorcery."
	evt.Subtract("QBits", 226)         -- Book of Divine Intervention - I lost it
	evt.Add("Gold", 10000)
	evt.ForPlayer("All")
	evt.SetNPCTopic{NPC = 48, Index = 0, Event = 0}         -- "Thomas Grey"
	evt.SetNPCGreeting{NPC = 48, Greeting = 77}         -- "Thomas Grey" : "I am honored to be graced with your presence, my lords."
	evt.Set("QBits", 206)         -- Harmondale - Town Portal
	evt.Set("QBits", 207)         -- Erathia - Town Portal
	evt.Set("QBits", 208)         -- Tularean Forest - Town Portal
	evt.Subtract("Inventory", 499)         -- "Book of UnMakings"
	evt.SetNPCTopic{NPC = 93, Index = 1, Event = 0}         -- "Tarin Withern"
end

-- "Coding Wizard Quest"
evt.global[96] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 775) then         -- "LG's Proof"
		evt.SetMessage(88)         --[[ "What’s this? [You proudly hand the scroll to Lord Godwinson].  A message for me written in the hand of the legendary Coding Wizard!?  I just **knew** that I was right!  He does exist!  Thank you soooo much for this scroll!

Here, take this reward of 50 Skill Points for each party member.  It should help you in upgrading your new skills!

Now tell me all about your adventure!" ]]
		evt.Subtract("Inventory", 775)         -- "LG's Proof"
		evt.Add("SkillPoints", 50)
		evt.Subtract("QBits", 353)         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
		evt.Set("Awards", 8)         -- "Completed Coding Wizard Quest"
		evt.SetNPCTopic{NPC = 460, Index = 0, Event = 0}         -- "Lord Godwinson"
		evt.Subtract("NPCs", 18)         -- "Lord Godwinson"
		evt.MoveNPC{NPC = 460, HouseId = 470}         -- "Lord Godwinson" -> "Godwinson Estate"
	else
		if evt.Cmp("QBits", 353) then         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
			evt.SetMessage(89)         -- "Bring me proof that the Coding Wizard is more than just a myth."
		else
			evt.SetMessage(67)         --[[ "Erathian folklore mentions a mysterious ‘coding wizard’ named ‘BDJ’. The legend says he has mastered the ‘coding magicks’ that control ‘The Game’. As the story goes, he is able to offer a second character class to those who have already mastered their chosen profession.

I spent much of my youth in search of this wizard, but alas, I was never able to find him.  Maybe he’s just a myth to entice the Young into the world of adventuring; maybe not.  For my peace of mind, I’ve got to know if he is more than a myth.  If you can find this wizard and return to me with proof of his existence, I will reward you handsomely.

I have a dear friend, the Lady Kathryn, who may be able to assist you with this quest.  She resides on Evenmorn Island.  Seek her out and heed her advise.

Good luck, adventurers!" ]]
			evt.Set("QBits", 353)         -- "Bring proof of the Coding Wizard's existence to Lord Godwinson."
			evt.MoveNPC{NPC = 457, HouseId = 115}         -- "Lady K" -> "The Laughing Monk"
			evt.SetNPCTopic{NPC = 457, Index = 0, Event = 97}         -- "Lady K" : "Lord Godwinson sent us!"
		end
	end
end

-- "Lord Godwinson sent us!"
evt.global[97] = function()
	evt.SetMessage(68)         --[[ "Ah, my old friend Lord Godwinson!  I trust that he is doing well?

So you’ve decided to take the journey to find BDJ the Coding Wizard?  He’s a strange one, that Wizard.  A mysterious legend in Erathia who, above all, covets his privacy and guards his secrets closely.  But if you can find him, the rewards are worth the journey!

I do know this.  To reach this wizard you must first run The Gauntlet.  The Lector EAO is the foremost authority on this ‘gauntlet’.  She travels quite a bit, but she does return to her home in Erathia each Summer.  Seek her out.  She may be able to assist you on your journey." ]]
	evt.Set("QBits", 354)         -- 0
	evt.SetNPCTopic{NPC = 457, Index = 0, Event = 0}         -- "Lady K"
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
	else
		if evt.Cmp("QBits", 100) then         -- Chose the path of Dark
			evt.SetMessage(223)         -- "Servants of Darkness, I am sorry I promoted you earlier.  I am ashamed I didn't notice the darkness in your souls until it was too late.  Leave me."
		else
			evt.SetMessage(222)         -- "I am dedicated to the service of the Light.  I will not promote you further until you are as dedicated as I.  Come back to me when you choose the Light."
		end
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

-- "Can you tell us about The Gauntlet?"
evt.global[102] = function()
	evt.SetMessage(69)         --[[ "The Gauntlet. Yes.  Legend has it that it was established by the recluse BDJ, commonly called the Coding Wizard, during the Second Age of Erathia, when he decided to withdraw from public life to pursue research on what he termed ‘The Game’.  The purpose of The Gauntlet is to dissuade idle curiosity seekers, indolent ‘wannabees’, and other tavern-dwellers from taking the magicks of coding for granted and unbalancing ‘The Game’.  This is in perfect harmony with the ‘TANSTAAFL!’ principle championed by Mage Emeritus R. Heinlein.

To reach this wizard, one must first ‘run The Gauntlet’, which consists of a series of ‘challenges’ in the realms of Earth, Fire, Water, and finally of Air and of Light.  The rewards of the Coding Wizard await those who emerge from these trials.

The Duchess of Deja may have information on the legendary location of The Gauntlet. Seek her out to continue your journey." ]]
	evt.SetNPCTopic{NPC = 458, Index = 0, Event = 0}         -- "EAO the Lector"
	evt.MoveNPC{NPC = 459, HouseId = 346}         -- "Duchess of Deja" -> "Duchess of Deja"
	evt.SetNPCTopic{NPC = 459, Index = 0, Event = 103}         -- "Duchess of Deja" : "Where is The Gauntlet?"
end

-- "Where is The Gauntlet?"
evt.global[103] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 355) then         -- "Bring a Red Delicious Apple to the Duchess of Deja."
		goto _4
	end
::_2::
	evt.Subtract("Inventory", 630)         -- "Red Delicious Apple"
	if evt.Cmp("Inventory", 630) then         -- "Red Delicious Apple"
		goto _2
	end
::_4::
	if evt.Cmp("Inventory", 630) then         -- "Red Delicious Apple"
		evt.SetMessage(70)         --[[ "The Apple!  Oh this is soooo delicious! [The duchess takes a large byte out of the apple and begins to chew]  Ummmm.  I have waited sooo long for this treat.  Thank you!  Now to my part of our bargain.

Unfortunately, no one knows exactly **where** The Gauntlet is located.  Some scholars believe that it has been created in the vast expanse of the Coding Void surrounded by the Null of Darkness.  Others believe that it is hidden in plain sight, cloaked in the Great Expanse of the Exclusive OR. Pure speculation if you ask me.

However, I do know **how** you can enter The Gauntlet.  You simply need to pray at the proper altar.  All you need to do is to find this alter.

Good Luck!" ]]
		evt.Subtract("Inventory", 630)         -- "Red Delicious Apple"
		evt.Subtract("QBits", 355)         -- "Bring a Red Delicious Apple to the Duchess of Deja."
		evt.Set("QBits", 356)         -- 0
		evt.SetNPCTopic{NPC = 459, Index = 0, Event = 0}         -- "Duchess of Deja"
	else
		evt.SetMessage(90)         --[[ "So you want to know the location of the legendary ‘Gauntlet’ leading to the Coding Wizard?  Perhaps I can help.  But you must first do something for me.

As you can see, Deja is not exactly the Land of Milk and Honey.  I have a terrible hunger for a fresh Red Delicious Apple from the forests in Tulerea.  Bring one of these apples to me, and then we’ll talk."" ]]
		evt.Set("QBits", 355)         -- "Bring a Red Delicious Apple to the Duchess of Deja."
	end
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
	local result
	if not evt.Cmp("QBits", 73) then         -- Finished constructing Golem with Abbey normal head
		result = not evt.Cmp("QBits", 74)         -- Finished constructing Golem with normal head
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
	else
		if evt.Cmp("Inventory", 641) then         -- "Golem head"
			evt.Subtract("Inventory", 641)         -- "Golem head"
			evt.Subtract("QBits", 219)         -- Golem Head - I lost it
			evt.ForPlayer("Current")
			evt.Add("Inventory", 640)         -- "Abbey Normal Golem Head"
			evt.Add("QBits", 220)         -- Abby normal head - I lost it
			evt.Subtract("QBits", 72)         -- Placed Golem Abbey normal head
			evt.Add("QBits", 71)         -- Placed Golem head
			evt.SetMessage(242)         -- "You remove the dented head and replace it with the normal head."
		else
			evt.SetMessage(243)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
		end
	end
end

evt.CanShowTopic[105] = function()
	local result
	if evt.Cmp("QBits", 71) then         -- Placed Golem head
		result = evt.Cmp("Inventory", 640)         -- "Abbey Normal Golem Head"
	else
		if not evt.Cmp("QBits", 72) then         -- Placed Golem Abbey normal head
			result = false
		else
			return evt.Cmp("Inventory", 641)         -- "Golem head"
		end
	end
end

-- "Castle Harmondale"
evt.global[106] = function()
	evt.SetMessage(243)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
	evt.SetNPCTopic{NPC = 58, Index = 0, Event = 121}         -- "Butler" : "Castle Harmondale"
	evt.MoveNPC{NPC = 58, HouseId = 108}         -- "Butler" -> "On the House"
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
								evt.SetMessage(247)         --[[ "Welcome back, Lords of Harmondale!  Now, I will help you.  My engineer will work for you.  Fix up your castle.  You have my thanks.  You are welcome here forever..  

Oh, and before I forget .. take this teleportal key to Emerald Island.  Don't know where you can use it, but you might find it helpful in the future. Perhaps you should see Illene Farswell in Harmondale.  She may know where you can use this key. 

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
								evt.ForPlayer(0)
								evt.Add("Inventory", 664)         -- "Emerald Is. Teleportal Key"
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
	evt.SetMessage(249)         -- "I bring greetings from Queen Catherine, the rightful ruler of all Erathia.  She has taken up residence at Gryphonheart Castle in Steadwick. She is currently involved in matters of State and cannot spare the time to grant you an audience.  If the Queen needs you, she shall summon you."
end

-- "We've received the Blessings!"
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

-- "We've received the Blessings!"
evt.global[119] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("QBits", 295) then         -- Water
		if not evt.Cmp("QBits", 296) then         -- Fire
			if not evt.Cmp("QBits", 297) then         -- Air
				if not evt.Cmp("QBits", 298) then         -- Earth
					return
				end
			end
		end
	end
	evt.SetMessage(216)         --[[ "Ok then.  Here’s your briefing.

We have recently discovered that the Strange Temple is being used as a ‘staging area’ for a group known as The Corruption. This group has joined forces with the Devil-King Xenoflex to form an unholy alliance. They are currently raising an army of Golems, Devils, Angels, and other creatures of the land, both Light and Dark.  Once at-strength, they plan on storming Erathia like a plague of locusts and seizing power throughout all lands. To make things worse, The Corruption discovered some ancient weapons and is attempting to reproduce them en-mass in order to equip their army. And at the center of this unseemly coalition is one of The Pit’s own … Judas the Geek! He has betrayed all of Erathia!!

What I need you to do is to proceed to the residence of Judas, find the hidden teleport therein, and enter the Strange Temple. Once in the temple, destroy all creatures within, retrieve the ancient weapons, and return to me. Should you encounter the traitor, terminate him … with extreme prejudice." ]]
	evt.MoveNPC{NPC = 85, HouseId = 0}         -- "Maximus"
	evt.Set("QBits", 299)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
end

-- "An invitation…"
evt.global[120] = function()
	evt.SetMessage(256)         -- "Though Avlee is not currently in charge of Harmondale, my King, Eldrich Parson of Avlee, lays claim to this territory as our rightful domain.  The reasons are complicated, but boil down to the simple fact that Erathia stole our land in the Timber Wars many years ago, and we will not give up until we have it back.  You'd be well served to stay out of this conflict.  However, if my King needs you, he will summon you."
end

-- "Castle Harmondale"
evt.global[121] = function()
	if evt.Cmp("QBits", 135) then         -- Player castle goblins are all dead
		evt.SetMessage(244)         --[[ "Thank heavens you've cleaned them out!  Now we need to find a way to clean up the castle and rebuild the damaged sections.  The only people I can think of who would have the inclination and the ability to do this are the Dwarves in Stone City, located in the Barrow Downs to the south.  The entrance to Stone City lies in the center of the Barrow Downs on one of the largest hills.

Oh, by the way … an angel appeared to me a few hours ago.  He said that he needs to speak to the new lords of Harmondale and that he would be waiting for you inside of the castle.  If I were you, I’d talk with him before going to see the Dwarf King. " ]]
		evt.ForPlayer("All")
		evt.Add("Experience", 5000)
		evt.Subtract("QBits", 75)         -- "Clean out Castle Harmondale and return to the Butler in the tavern, On the House, in Harmondale."
		evt.Add("Awards", 4)         -- "Cleared out Castle Harmondale"
		evt.MoveNPC{NPC = 58, HouseId = 174}         -- "Butler" -> "Throne Room"
		evt.SetNPCTopic{NPC = 58, Index = 0, Event = 0}         -- "Butler"
		evt.SetNPCGreeting{NPC = 58, Greeting = 86}         -- "Butler" : "You rang, my lords?"
		evt.Set("QBits", 146)         -- "Talk to the Dwarves in Stone City in the Barrow Downs to find a way to repair Castle Harmondale."
	else
		evt.SetMessage(243)         -- "I fear that talking will fail with these ruffians, my lords.  May I suggest violence?"
	end
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

-- "No Thanks."
evt.global[123] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 338) then         -- BDJ Final
		evt.Subtract("QBits", 349)         -- One Use
		evt.SetNPCTopic{NPC = 456, Index = 0, Event = 87}         -- "The Coding Wizard" : "Let's Continue."
	else
		if evt.Cmp("QBits", 337) then         -- BDJ 3
			evt.Set("QBits", 338)         -- BDJ Final
			evt.SetNPCTopic{NPC = 456, Index = 0, Event = 50}         -- "The Coding Wizard" : "New Profession."
		else
			if evt.Cmp("QBits", 336) then         -- BDJ 2
				evt.Set("QBits", 337)         -- BDJ 3
				evt.SetNPCTopic{NPC = 456, Index = 0, Event = 50}         -- "The Coding Wizard" : "New Profession."
			else
				evt.Set("QBits", 336)         -- BDJ 2
				evt.SetNPCTopic{NPC = 456, Index = 0, Event = 50}         -- "The Coding Wizard" : "New Profession."
			end
		end
	end
	evt.SetNPCTopic{NPC = 456, Index = 1, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 2, Event = 0}         -- "The Coding Wizard"
	evt.SetNPCTopic{NPC = 456, Index = 3, Event = 0}         -- "The Coding Wizard"
	evt.SetMessage(267)         -- "Ok then.  Let's move on."
end

-- "So you're the new lords of Harmondale."
evt.global[124] = function()
	evt.SetMessage(263)         -- "[Queen Catherine inclines her head regally] You are the lot that won Lord Markham's silly contest, I see.  I must admit I had little faith until the Dwarf King recognized you as the rightful rulers of Harmondale.  You must have done something to win his respect, or he would have nothing to do with you.  I'm still not sure what he saw in you, but perhaps there really is something of substance here.  Only time will tell.  If I have a need for your services, I'll summon you.  You are dismissed."
end

-- "Bow Expert"
evt.global[125] = function()
	evt.SetMessage(341)         -- "The only teacher that I know of is the renown Zedd True Shot.  You can find him on Emerald Island.  He's also the Warrior Mage promoter. "
end

-- "Let's Go!"
evt.global[126] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for M1"
		evt.Set("NPCs", 34)         -- "Duke Bimbasto"
		evt.SetNPCTopic{NPC = 34, Index = 1, Event = 0}         -- "Duke Bimbasto"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
evt.global[127] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 7, Bit = const.MonsterBits.Invisible, On = true}         -- "Group fo M2"
		evt.Set("NPCs", 35)         -- "Sir Vilx of Stone City"
		evt.SetNPCTopic{NPC = 35, Index = 1, Event = 0}         -- "Sir Vilx of Stone City"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Congratulations!"
evt.global[128] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 99) then         -- Chose the path of Light
		evt.SetMessage(323)         --[[ "You have saved Erathia, adventurers!  From henceforth, you shall be known as ‘The Heroes of Erathia’!  You may now travel safely anywhere in The Pit without harm or molestation.  However, don’t ‘pick a fight’ with our locals or all bets are off!!

Because of your service, heroes, I hereby grant all members of your party the Ancient Weapon skill and all magic users among your party the mastery in the Dark Magic skill. You can use our promoters to advance in the ancient weapon skill.  Use your new skills wisely!

Oh! and Lord Archibald, himself, has place a reward for you in the House that once belonged to Judas.  It’s in the chest on the second floor.  You may retrieve the reward at any time.

After you have rested, return to Celeste for your next assignment."" ]]
		evt.Subtract("QBits", 299)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
		evt.Set("QBits", 303)         -- Reward
		evt.Set("BlasterSkill", 1)
		evt.Set("Awards", 7)         -- "Declared Heroes of Erathia"
		evt.Add("Experience", 200000)
		evt.Add("Awards", 60)         -- "Joined the Dark Guild"
		evt.ForPlayer(0)
		if evt.Cmp("FireSkill", 1) then
			goto _15
		end
		if evt.Cmp("BodySkill", 1) then
			goto _15
		end
		goto _16
	end
	if not evt.Cmp("QBits", 100) then         -- Chose the path of Dark
		return
	end
	evt.SetMessage(324)         --[[ "You have saved Erathia, adventurers!  From henceforth, you shall be known as ‘The Heroes of Erathia’!  You may now travel safely anywhere in Celeste without harm or molestation.  However, don’t ‘pick a fight’ with our locals or all bets are off!!

Because of your service, heroes, I hereby grant all members of your party the Ancient Weapon skill and all magic users among your party mastery in the Light Magic skill. You can use our promoters to advance in the ancient weapon skills.  Use your new skills wisely!

Oh! and Gavin Magnus, himself, has place a reward for you in the House that once belonged to Robert the Wise.  It’s in the chest on the second floor.  You may retrieve the reward at any time.

After you have rested, return to The Pit for your next assignment." ]]
	evt.Subtract("QBits", 299)         -- "Clear out the Strange Temple,  retrieve the ancient weapons, and return to Maximus in The Pit"
	evt.Set("QBits", 303)         -- Reward
	evt.Set("BlasterSkill", 1)
	evt.Set("Awards", 7)         -- "Declared Heroes of Erathia"
	evt.Add("Experience", 200000)
	evt.Add("Awards", 59)         -- "Joined the Light Guild"
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		goto _57
	end
	if evt.Cmp("BodySkill", 1) then
		goto _57
	end
::_58::
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		goto _62
	end
	if evt.Cmp("BodySkill", 1) then
		goto _62
	end
::_63::
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		goto _67
	end
	if evt.Cmp("BodySkill", 1) then
		goto _67
	end
::_68::
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		goto _72
	end
	if evt.Cmp("BodySkill", 1) then
		goto _72
	end
::_73::
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 80, HouseId = 422}         -- "Resurectra" -> "House Devine"
	evt.SetNPCTopic{NPC = 80, Index = 0, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 80, Index = 1, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 80, Index = 2, Event = 0}         -- "Resurectra"
	evt.SetNPCTopic{NPC = 80, Index = 3, Event = 223}         -- "Resurectra" : "Ancient Weapon Grandmaster"
	evt.MoveNPC{NPC = 81, HouseId = 423}         -- "Crag Hack" -> "Morningstar Residence"
	evt.SetNPCTopic{NPC = 81, Index = 0, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 81, Index = 1, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 81, Index = 2, Event = 0}         -- "Crag Hack"
	evt.SetNPCTopic{NPC = 81, Index = 3, Event = 221}         -- "Crag Hack" : "Ancient Weapon Expert"
	evt.SetNPCTopic{NPC = 82, Index = 1, Event = 222}         -- "Sir Caneghem" : "Ancient Weapon Master"
	evt.SetNPCGreeting{NPC = 81, Greeting = 196}         -- "Crag Hack" : "Welcome back  Heroes!   What can I do for you?"
	evt.SetNPCGreeting{NPC = 80, Greeting = 196}         -- "Resurectra" : "Welcome back  Heroes!   What can I do for you?"
	do return end
::_15::
	evt.Set("DarkSkill", 136)
::_16::
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		goto _20
	end
	if evt.Cmp("BodySkill", 1) then
		goto _20
	end
::_21::
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		goto _25
	end
	if evt.Cmp("BodySkill", 1) then
		goto _25
	end
::_26::
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		goto _30
	end
	if evt.Cmp("BodySkill", 1) then
		goto _30
	end
::_31::
	evt.ForPlayer("All")
	evt.MoveNPC{NPC = 84, HouseId = 437}         -- "Kastore" -> "Sand Residence"
	evt.SetNPCTopic{NPC = 84, Index = 0, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 84, Index = 1, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 84, Index = 2, Event = 0}         -- "Kastore"
	evt.SetNPCTopic{NPC = 84, Index = 3, Event = 223}         -- "Kastore" : "Ancient Weapon Grandmaster"
	evt.MoveNPC{NPC = 86, HouseId = 441}         -- "Dark Shade" -> "Hostel"
	evt.SetNPCTopic{NPC = 86, Index = 0, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 86, Index = 1, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 86, Index = 2, Event = 0}         -- "Dark Shade"
	evt.SetNPCTopic{NPC = 86, Index = 3, Event = 221}         -- "Dark Shade" : "Ancient Weapon Expert"
	evt.SetNPCTopic{NPC = 85, Index = 1, Event = 222}         -- "Maximus" : "Ancient Weapon Master"
	evt.SetNPCGreeting{NPC = 86, Greeting = 196}         -- "Dark Shade" : "Welcome back  Heroes!   What can I do for you?"
	evt.SetNPCGreeting{NPC = 84, Greeting = 196}         -- "Kastore" : "Welcome back  Heroes!   What can I do for you?"
	evt.MoveNPC{NPC = 80, HouseId = 182}         -- "Resurectra" -> "Throne Room"
	evt.Subtract("QBits", 302)         -- Small House only Once
	do return end
::_57::
	evt.Set("LightSkill", 136)
	goto _58
::_62::
	evt.Set("LightSkill", 136)
	goto _63
::_67::
	evt.Set("LightSkill", 136)
	goto _68
::_72::
	evt.Set("LightSkill", 136)
	goto _73
::_20::
	evt.Set("DarkSkill", 136)
	goto _21
::_25::
	evt.Set("DarkSkill", 136)
	goto _26
::_30::
	evt.Set("DarkSkill", 136)
	goto _31
end

-- "Congratulations!"
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

-- "You're the new lords,huh?"
evt.global[131] = function()
	evt.SetMessage(275)         -- "Welcome.  I understand you've been appointed Lords of Harmondale by that idiot Markham.  You know, I WILL restore Avlee's rule over Harmondale--the only question is whether you are with me, or against me.  If you're with me, I will ensure that you retain your post.  Against me, and I will have done with you once my armies occupy your lands.    [King Parson smiles affably] So, of course you're with me!  If I have a need for your services, I'll summon you.  You are dismissed."
end

-- "Map"
evt.global[132] = function()
	evt.SetMessage(277)         --[[ "Well, Seekers, I see you’ve finally arrived.  I’ve been waiting for this moment for ages! 

What?!  You think that all of us have wings and just fly around the countryside impressing the Young?  We can take any form we desire.  We often appear as peasants and beggars so that we may move freely amongst your kind.  Besides, I rather enjoy the shocked look of these foul winged beasts as their perceived ‘easy prey’ sends them to their deaths!  If you have some time on your hands, lure some of these beasties to me, stand back, and watch me in action.  I'm very good, you know!  Besides, I need some entertainment! 

But enough about me.  You came in search of The Map, I guess.  Here it is.  Return it to my kin in Castle Harmondale for your promotion and reward.  Adou. " ]]
	evt.ForPlayer("Current")
	evt.Add("Inventory", 739)         -- "Map to Treasure"
	evt.SetNPCTopic{NPC = 454, Index = 0, Event = 0}         -- "Map Giver"
end

-- "Most Excellent!!"
evt.global[133] = function()
	evt.SetMessage(315)         -- "YOU ARE HEROES!!!  Your work against the devils was masterful!  And the rescue of King Roland was as delightful as it was unexpected.  History will never forget your names for doing what you just did!  I, for one, am very proud to know you.  "
	evt.Add("Gold", 50000)
	evt.Subtract("Reputation", 10)
	evt.ForPlayer("All")
	evt.Add("Experience", 500000)
	evt.Subtract("QBits", 104)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
	evt.Set("QBits", 120)         -- Got Hive part
	evt.SetNPCTopic{NPC = 80, Index = 1, Event = 169}         -- "Resurectra" : "Final Task"
	evt.Add("Awards", 48)         -- "Slayed Xenofex"
	evt.Subtract("QBits", 105)         -- Slayed Xenofex
	evt.Add("SkillPoints", 100)
end

-- "Let's Go!"
evt.global[134] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for Malwick's Assc."
		evt.Set("NPCs", 37)         -- "Pascal the Mad Mage"
		evt.SetNPCTopic{NPC = 37, Index = 1, Event = 0}         -- "Pascal the Mad Mage"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
evt.global[135] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Invisible, On = true}         -- "Southern Village Group in Harmondy"
		evt.Set("NPCs", 20)         -- "Baron BunGleau"
		evt.SetNPCTopic{NPC = 20, Index = 1, Event = 0}         -- "Baron BunGleau"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
end

-- "Let's Go!"
evt.global[136] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(325)         -- "Gladly, friends!"
		evt.SetMonGroupBit{NPCGroup = 8, Bit = const.MonsterBits.Invisible, On = true}         -- "Group for M3"
		evt.Set("NPCs", 18)         -- "Lord Godwinson"
		evt.SetNPCTopic{NPC = 18, Index = 1, Event = 0}         -- "Lord Godwinson"
	else
		evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	end
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

-- "I lost it"
evt.global[139] = function()
	evt.SetMessage(668)         -- "That's too bad, children.  You really ought to take better care of your toys!  It looks like you are S.O.L."
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
	evt.SetNPCGreeting{NPC = 77, Greeting = 104}         -- "Judge Fairweather" : "We need to go to Judge Grey's old house in Harmondale.  Only then can I start my new job and begin to ""sort out this mess"".  [Heh!]"
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
	else
		if not evt.Cmp("QBits", 111) then         -- Finished Necro Task 2 - Temple of Light
			evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
		else
			if not evt.Cmp("QBits", 112) then         -- Finished Necro Task 3 - Soul Jars
				evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
			else
				if not evt.Cmp("QBits", 113) then         -- Finished Necro Task 4 - Clanker's Lab
					evt.SetMessage(294)         -- "Each of the advisors to Lord Ironfist has a task for you, complete each one.  Talk to Kastore, Dark Shade, and Maaximus for more information.  The completion of these tasks is vital for our future."
				else
					if not evt.Cmp("QBits", 118) then         -- Killed Good MM3 Person
						evt.SetMessage(295)         -- "Judas the Geek has a mission of great importance.  Everything we've staked so far rests on its completion.  Prepare well for his task or you will certainly fail."
					else
						if not evt.Cmp("QBits", 120) then         -- Got Hive part
							evt.SetMessage(296)         -- "Xenofex and the rest of the Kreegan must be put down; go to their 'hive' in the Land of the Giants and put a stop to Xenofex and his minions once and for all."
						else
							if evt.Cmp("QBits", 121) then         -- Got the sci-fi part
								evt.SetMessage(298)         -- "Bring the Oscillation Overthruster back to Kastore with all possible speed!  Every moment you dally allows a chance for failure!"
							else
								evt.SetMessage(297)         -- "You will need to visit the craft that brought Kastore and his men to Erathia to continue.  Go west of Avlee, and make sure to be properly outfitted."
							end
						end
					end
				end
			end
		end
	end
end

-- "I choose you!"
evt.global[143] = function()
	evt.Subtract("NPCs", 78)         -- "Judge Sleen"
	evt.MoveNPC{NPC = 78, HouseId = 111}         -- "Judge Sleen" -> "The Snobbish Goblin"
	evt.SetNPCGreeting{NPC = 78, Greeting = 101}         -- "Judge Sleen" : "Free"
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
	else
		if not evt.Cmp("QBits", 115) then         -- Finished Wizard Task 2 - Temple of Dark
			evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
		else
			if not evt.Cmp("QBits", 116) then         -- Finished Wizard Task 3 - Wine Cellar
				evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
			else
				if not evt.Cmp("QBits", 117) then         -- Finished Wizard Task 4 - Soul Jars
					evt.SetMessage(301)         -- "Each of Gavin's advisors has a task for you.  Talk to Resurectra, Sir Caneghem, and Crag Hack for more information.  Do not fail in these missions- in them rests the balance of the future."
				else
					if not evt.Cmp("QBits", 119) then         -- Killed Evil MM3 Person
						evt.SetMessage(302)         -- "Robert the Wise has a regrettable, but necessary, mission for you to complete.  For any of our plans to continue, this mission must succeed.  Prepare most carefully for the task, or you invite certain failure."
					else
						if not evt.Cmp("QBits", 120) then         -- Got Hive part
							evt.SetMessage(303)         -- "The Kreegan, the Devils, and their leader Xenofex must be destroyed completely for the plan to have any long-term benefit.  You will find their 'hive' in the Land of the Giants."
						else
							if evt.Cmp("QBits", 121) then         -- Got the sci-fi part
								evt.SetMessage(305)         -- "Bring the Oscillation Overthruster back to Resurectra immediately!  Every moment wastes valuable time!"
							else
								evt.SetMessage(304)         -- "To the west of Avlee lies the craft that Resurectra and her associates used to come to Erathia.  Visit the ship and retrieve the Oscillation Overthruster to insure our victory.  Make sure to be properly outfitted for the journey."
							end
						end
					end
				end
			end
		end
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
		evt.MoveNPC{NPC = 82, HouseId = 427}         -- "Sir Caneghem" -> "Hostel"
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
	else
		if evt.Cmp("Inventory", 677) then         -- "Altar Piece"
			evt.SetMessage(312)         -- "Good work on retrieving their half of the key, but you still need ours.  It is located in the Temple of the Light here in Celeste."
		else
			evt.SetMessage(310)         -- "No key halves yet, I see.  Well, take your time.  It must be done eventually, and sooner is better than later, but later is better than being chained to an altar and sacrificed by the High Priest of the Dark in one of their bloody rituals.  Just bring back both halves of the key from the temples of Dark and Light, and try not to get yourselves killed doing it."
		end
	end
end

-- ""
-- ""
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
		evt.SetNPCTopic{NPC = 82, Index = 0, Event = 19}         -- "Sir Caneghem" : "Erathia has been betrayed!"
		evt.MoveNPC{NPC = 85, HouseId = 434}         -- "Maximus" -> "Hostel"
		evt.Add("Awards", 80)         -- "Retrieved Soul Jars"
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
		evt.SetNPCGreeting{NPC = 88, Greeting = 136}         -- "Archibald Ironfist" : "Back for more target practice?  You know, if you wait long enough, my people will regenerate.  Bigger challenge then."
		evt.MoveNPC{NPC = 88, HouseId = 0}         -- "Archibald Ironfist"
		evt.SetNPCTopic{NPC = 88, Index = 1, Event = 0}         -- "Archibald Ironfist"
		evt.SetNPCTopic{NPC = 85, Index = 0, Event = 22}         -- "Maximus" : "Dangerous Mission"
	else
		evt.SetMessage(322)         -- "Be well prepared when you go for the jars.  Their security won't be so lax if you have to retreat and return.  "
	end
end

-- "Strike the Devils"
evt.global[155] = function()
	if not evt.Cmp("QBits", 326) then         -- Resurectra
		evt.SetMessage(314)         --[[ "Our plans rapidly approach their conclusion, but there is a hitch.  You have defeated the unholy alliance of The Corruption, but the traitor Judas has escaped and taken refuge with Xenofex and his Devil minions. They still represent a terrible threat, and though they are licking their wounds from our recent victory, will one day regain their strength and devastate the world.  If anything we do is to have lasting effect, we must first destroy these monsters for once and for all.

You are strong, but not strong enough to defeat the devils on your own.  They are vulnerable to the brand of magic most commonly wielded by the Necromancers, and less so by our own Wizards.  It is imperative that you infiltrate the Devil's base and kill their leader Xenofex and the traitor, Judas.  That should end their threat to this world for some time.  The Warlocks have dug a tunnel from their volcano to the Land of the Giants-- the land the Devils claim as their own.  Perhaps you can use that." ]]
		evt.Set("QBits", 104)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
		evt.Set("QBits", 326)         -- Resurectra
	else
		if evt.Cmp("QBits", 105) then         -- Slayed Xenofex
			evt.SetMessage(315)         -- "YOU ARE HEROES!!!  Your work against the devils was masterful!  And the rescue of King Roland was as delightful as it was unexpected.  History will never forget your names for doing what you just did!  I, for one, am very proud to know you.  "
			evt.Add("Gold", 50000)
			evt.Subtract("Reputation", 10)
			evt.ForPlayer("All")
			evt.Add("Experience", 500000)
			evt.Subtract("QBits", 104)         -- "Go to Colony Zod in the Land of the Giants and slay Xenofex then return to Resurectra in Castle Lambent in Celeste."
			evt.Set("QBits", 120)         -- Got Hive part
			evt.SetNPCTopic{NPC = 80, Index = 1, Event = 169}         -- "Resurectra" : "Final Task"
			evt.Add(-- ERROR: Not found
"Awards", 83886128)
		else
			evt.SetMessage(316)         -- "I guess there's no hurry getting this job done, but we don't want the Necromancers to grow bored waiting for us to do our part and destroy the blocker.  So, please, as soon as you feel ready you must attack the Devils.  Remember that the Warlocks have dug a tunnel from their volcano to the land of the Devils.  You should be able to use that to get yourselves there."
		end
	end
end


-- ERROR: Not found

-- "Beacon Fires"
evt.global[512] = function()
	evt.SetMessage(731)         -- "If you seek aid from Erathia, light the beacon fires near the roads to the Barrow Downs, Erathia, and the Tularean Forest.  The Erathian forces near here will see the fires and rush to your aid!"
end

-- ERROR: Unknown command: 0:10 (0xA0)
-- ERROR: Invalid command size: 2560:160 (Cmd00)
-- ERROR: Not found

-- ERROR: Invalid command size: 40970:0 (SetSnow)
-- ERROR: Not found

evt.global[40970] = function()
	evt.SetSnow{EffectId = 18, On = true}
end

-- "Strike the Devils"
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
		evt.SetNPCTopic{NPC = 85, Index = 0, Event = 20}         -- "Maximus" : "Erathia has been betrayed!"
		evt.MoveNPC{NPC = 82, HouseId = 427}         -- "Sir Caneghem" -> "Hostel"
		evt.ForPlayer("Current")
		evt.Subtract("Reputation", 5)
		evt.SetNPCTopic{NPC = 82, Index = 0, Event = 21}         -- "Sir Caneghem" : "Dangerous Mission"
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
	if evt.Cmp("QBits", 126) then         -- Destroyed the magical defenses in Clanker's Lab
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
	local result
	if not evt.Cmp("QBits", 110) then         -- Finished Necro Proving Grounds
		result = false
	else
		if not evt.Cmp("QBits", 111) then         -- Finished Necro Task 2 - Temple of Light
			result = false
		else
			if not evt.Cmp("QBits", 112) then         -- Finished Necro Task 3 - Soul Jars
				result = false
			else
				return evt.Cmp("QBits", 113)         -- Finished Necro Task 4 - Clanker's Lab
			end
		end
	end
end

evt.global[165] = function()
	evt.SetMessage(340)         -- "We cannot leave until we have the Control Cube."
	evt.Set("QBits", 127)         -- "Assassinate Robert the Wise in his house in Celeste and return to Tolberti in the Pit."
	evt.SetNPCTopic{NPC = 87, Index = 0, Event = 166}         -- "Tolberti" : "Robert the Wise"
end

-- "Robert the Wise"
evt.global[166] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 675) then         -- "Control Cube"
		evt.SetMessage(342)         --[[ "I understand your enthusiasm adventurers.  But you are far too inexperienced for the required promotion task.  Travel about on the mainland, gain some real-world experience, and return to the ‘EI’.  Then we’ll discuss the promotion.

So I’ll await your return?  Good.  See you soon." ]]
		return
	end
	evt.SetMessage(341)         -- "The only teacher that I know of is the renown Zedd True Shot.  You can find him on Emerald Island.  He's also the Warrior Mage promoter. "
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
		evt.MoveNPC{NPC = 85, HouseId = 434}         -- "Maximus" -> "Hostel"
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
		evt.Set("QBits", 374)         -- End Game
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
		evt.Set(-- ERROR: Not found
"Awards", 108)
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
	evt.Set("QBits", 157)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Erathia."
end

-- "Quest"
evt.global[184] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 606) then         -- "Signet Ring"
		evt.SetMessage(493)         --[[ "My ring!  Thank you lords.  I can now continue my business and recover my losses, and you have made the trading routes safer for all the merchants! 

Take this key as your reward." ]]
		evt.Subtract("Inventory", 606)         -- "Signet Ring"
		evt.Add("Awards", 94)         -- "Returned Lord Davrik's signet Ring"
		evt.Add("Experience", 5000)
		evt.ForPlayer("Current")
		evt.Add("Inventory", 670)         -- "Home Key"
		evt.Add("Gold", 5000)
		evt.Subtract("QBits", 157)         -- "Retrieve Davrik's Signet ring from the Bandit Caves in the northeast of Erathia and return it to Davrik Peladium in Erathia."
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
	local result
	if not evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		result = evt.Cmp("QBits", 99)         -- Chose the path of Light
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
	local result
	if not evt.Cmp("QBits", 183) then         -- Failed either goto or do guild quest
		result = evt.Cmp("QBits", 100)         -- Chose the path of Dark
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
	else
		if evt.Cmp("Inventory", 620) then         -- "Big Tapestry"
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
	else
		if not evt.CheckMonstersKilled{CheckType = 2, Id = 214, Count = 0} then
			evt.SetMessage(506)         -- "There are still troglodytes roaming the lower mine levels.  Please remove them!"
		else
			if evt.CheckMonstersKilled{CheckType = 2, Id = 215, Count = 0} then
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
	end
end

-- "The Kennel"
evt.global[196] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 782) then         -- "Journal of Experiments"
		evt.SetMessage(92)         -- "The Journal!!!  I knew you were up to the task.  You have done the crown a great service.  I hereby grant you the title of ‘The Queen’s Champions’."
		evt.Subtract("QBits", 29)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
		evt.Add("Experience", 50000)
		evt.Set("Awards", 9)         -- "Declared the Queen’s Champions"
		evt.SetNPCTopic{NPC = 69, Index = 0, Event = 0}         -- "Queen Catherine"
		evt.SetNPCGreeting{NPC = 69, Greeting = 20}         -- "Queen Catherine" : "The door to the west leads to the local Tavern.  The tavern is a safe place to sleep at night, and to buy food so you can sleep outdoors.  You can often meet interesting people in taverns, or catch the local gossip if you're looking for something to do.  To enter the tavern, just click on the front door."
		evt.Subtract("Inventory", 782)         -- "Journal of Experiments"
	else
		evt.SetMessage(91)         --[[ " During our recent disputes with the Elves, we began conducting experiments to produce the ultimate combat instrument, a creature with no fear and great predatory abilities.  These experiments were conducted in an abandoned tomb appropriately renamed ‘the Kennel’, located along the southeastern shore of the Erathian River.

Well, our experiments were far too successful and the creatures turned on their handlers and devoured them. I have sent small contingents of my personal retinue to dispense of these creatures, but none has returned.  I assume them all dead.

I need you to proceed to the Kennel, eliminate all creatures, obtain the Journal of Experiments, and return to me.  The reward will be commensurate with your efforts.

Oh! before I forget.  The entrance to the Kennel is secured by a cipher lock.  The combination is Top, Right, Bottom, Left, Center.  Good luck!" ]]
		evt.Set("QBits", 29)         -- "Kill the creatures in the Kennel and return to Queen Catherine with the Journal of Experiments.."
	end
end

-- "Control Cube"
evt.global[197] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 675) then         -- "Control Cube"
		if evt.Cmp("Awards", 32) then         -- "Declared Friends of ‘The Game’"
			evt.Subtract("NPCs", 21)         -- "Zedd True Shot"
			evt.Subtract("NPCs", 18)         -- "Lord Godwinson"
			evt.Subtract("NPCs", 20)         -- "Baron BunGleau"
			evt.Subtract("NPCs", 35)         -- "Sir Vilx of Stone City"
			evt.Subtract("NPCs", 34)         -- "Duke Bimbasto"
			evt.Subtract("NPCs", 37)         -- "Pascal the Mad Mage"
			evt.SetMessage(251)         -- "Excellent!  Now that we have the Control Cube, you need to see Resurectra in Castle Lambent.  She will provide details on your next assignment."
			evt.Subtract("QBits", 362)         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
			evt.Subtract("Inventory", 675)         -- "Control Cube"
			evt.SetNPCTopic{NPC = 83, Index = 0, Event = 0}         -- "Robert the Wise"
			evt.MoveNPC{NPC = 83, HouseId = 0}         -- "Robert the Wise"
			evt.Set("Awards", 14)         -- "Retrieved Control Cube"
			evt.Add("Experience", 500000)
			evt.SetNPCTopic{NPC = 80, Index = 1, Event = 155}         -- "Resurectra" : "Strike the Devils"
		else
			evt.Set("Awards", 33)         -- "Hall of Shame Award ‘Unfaithful Friends’"
			evt.Subtract("Inventory", 675)         -- "Control Cube"
			evt.Set("Eradicated", 0)
		end
	else
		if not evt.Cmp("QBits", 362) then         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
			evt.SetMessage(23)         --[[ "Our preparations are nearing completion.  However we first need to obtain an artifact known as the ‘Control Cube’.  This artifact is guarded by Jester’s Folly, a dragon of such power that all other creatures flee from its presence!  This dragon resides in the Vault, a cavern deep within the bowls of Deja. The entrance to the Vault is guarded by the Treasury, a bulwark fortress built by the Necromancers to protect the artifact.

We need your party to break into the Treasury, find the key, enter the Vault, slay Jester’s Folly, retrieve the Control Cube, and return to me.

Duke Bimbasto and Sir Vilx.., Erathia's Greatest Champions, have offered their assistance.  They will meet you at the entrance to the Treasury.

Be careful on this quest.  The dangers are many, and the foes are plenty." ]]
			evt.Set("QBits", 362)         -- " Enter the Treasury in Deja, find the key and enter the Vault, retrieve the Control Cube, and return to Robert the Wise in Celeste."
			evt.SetNPCGreeting{NPC = 83, Greeting = 22}         -- "Robert the Wise" : "You must bring the Control Cube to me."
		end
	end
end

-- "Mourning"
evt.global[198] = function()
	evt.SetMessage(741)         -- "Pardon me, strangers, but I'm not feeling very sociable right now.  My brother Elrond has recently departed this world and my grief is great at his passing."
	evt.SetNPCTopic{NPC = 285, Index = 0, Event = 516}         -- "Darron Temper" : "Can we help?"
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
	evt.Set("AutonotesBits", 128)         -- "The Master instructor of the Staff, Elsie Pederton, can be found in the Bracada Desert, on a ridge in the southwest region."
end

-- "Jillian Mithrit"
evt.global[316] = function()
	evt.SetMessage(515)         -- "The ultimate teacher in the ways of the Staff, Jillian Mithrit, can be found in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 129)         -- "The ultimate teacher in the ways of the Staff, Jillian Mithrit, can be found in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Swordsmanship"
evt.global[317] = function()
	evt.SetMessage(516)         -- "As you can see, the Master instructor of the Sword, Tugor Slicer, maintains his residence with my brother and myself here on Emerald Island.  Return to us when you need advancement with the blade."
	evt.Set("AutonotesBits", 130)         -- "The Master instructor of the Sword, Tugor Slicer, lives with the Telmar brothers on Emerald Island."
end

-- "Chadric Townsaver"
evt.global[318] = function()
	evt.SetMessage(517)         -- "The Grandmaster of the Sword, Chadric Townsaver, can be found in a small village in Welnin, just south of the city of Harmondale."
	evt.Set("AutonotesBits", 131)         -- "The Grandmaster of the Sword, Chadric Townsaver, can be found in a small village in Welnin, just south of the city of Harmondale."
end

-- "Aznog Slasher"
evt.global[319] = function()
	evt.SetMessage(518)         -- "The Master tutor of the Dagger, Aznog Slasher, can be found in the northern region of Nighon."
	evt.Set("AutonotesBits", 132)         -- "The Master tutor of the Dagger, Aznog Slasher, can be found in the northern region of Nighon."
end

-- "Tonken Fist"
evt.global[320] = function()
	evt.SetMessage(519)         -- "The Grandmaster of the Dagger, Token Fist, can be found in city of Tidewater in Tatalia.  Rumor has it that the Master Thief in the depths of the Erathian Sewers beneath the capitol city of Steadwick can also instruct at this level."
	evt.Set("AutonotesBits", 133)         -- "The Grandmaster of the Dagger, Token Fist, can be found in city of Tidewater in Tatalia.  Rumor has it that the Master Thief in the depths of the Erathian Sewers beneath the capitol city of Steadwick can also instruct at this level."
end

-- "Dalin Keenedge"
evt.global[321] = function()
	evt.SetMessage(520)         -- "The Master Instructor of all that is the Axe, Dalin Keenedge, can be found in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 134)         -- "The Master Instructor of all that is the Axe, Dalin Keenedge, can be found in the northeast corner of Stone City."
end

-- "Karn Stonecleaver"
evt.global[322] = function()
	evt.SetMessage(521)         -- "The ultimate teacher of the uses of the Axe, Karn Stonecleaver, can be found in the snowy heights of the northeast region of Tatalia."
	evt.Set("AutonotesBits", 135)         -- "The ultimate teacher of the uses of the Axe, Karn Stonecleaver, can be found in the snowy heights of the northeast region of Tatalia."
end

-- "Claderin Silverpoint"
evt.global[323] = function()
	evt.SetMessage(522)         -- "The Master teacher, Claderin Silverpoint, can be found in the northeast section of the city of Pierpont in the elven region of the Tularean Forest. There he will further you knowledge of the Spear."
	evt.Set("AutonotesBits", 136)         -- "The Master teacher, Claderin Silverpoint, can be found in the northeast section of the city of Pierpont in the elven region of the Tularean Forest. There he will further you knowledge of the Spear."
end

-- "Seline Falconeye"
evt.global[324] = function()
	evt.SetMessage(523)         -- "The Grandmaster of the Spear, Selene Falconeye, makes her home in the northeast corner of Stone City."
	evt.Set("AutonotesBits", 137)         -- "The Grandmaster of the Spear, Selene Falconeye, makes her home in the northeast corner of Stone City."
end

-- "Lanshee Ravensight"
evt.global[325] = function()
	evt.SetMessage(524)         -- "The Master tutor of the Bow, Lanshee Ravensight, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 138)         -- "The Master tutor of the Bow, Lanshee Ravensight, lives in the northern regions of Nighon."
end

-- "Cardric the Steady"
evt.global[326] = function()
	evt.SetMessage(525)         -- "The Grandmaster of the Bow, Cardric the Steady, can be found just to the southeast of the castle in the city of Harmondale."
	evt.Set("AutonotesBits", 139)         -- "The Grandmaster of the Bow, Cardric the Steady, can be found just to the southeast of the castle in the city of Harmondale."
end

-- "Brother Rothham"
evt.global[327] = function()
	evt.SetMessage(526)         -- "The Master instructor of the Mace, Brother Rothham, can be found in the southern region of the swamps of Tatalia."
	evt.Set("AutonotesBits", 140)         -- "The Master instructor of the Mace, Brother Rothham, can be found in the southern region of the swamps of Tatalia."
end

-- "Patwin Fellbern"
evt.global[328] = function()
	evt.SetMessage(527)         -- "The Grandmaster of the Mace, Patwin Felburn, teaches from his home in the goblin village found in the eastern area of the Deyja. "
	evt.Set("AutonotesBits", 141)         -- "The Grandmaster of the Mace, Patwin Felburn, teaches from his home in the goblin village found in the eastern area of Deyja."
end

-- "Isram Gallowswell"
evt.global[329] = function()
	evt.SetMessage(528)         -- "My Master, Isram Gallowswell, can be found in the snowy heights of the northeast area of Tatalia. You will gain further instruction in the Shield there."
	evt.Set("AutonotesBits", 142)         -- "My Master, Isram Gallowswell, can be found in the snowy heights of the northeast area of Tatalia. You will gain further instruction in the Shield there."
end

-- "Fedwin Smithson"
evt.global[330] = function()
	evt.SetMessage(529)         -- "The Grandmaster of the Shield, Fedwin Smithson, can be found on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 143)         -- "The Grandmaster of the Shield, Fedwin Smithson, can be found on the eastern island of the Evenmorn Islands."
end

-- "Rabisa Nedlon"
evt.global[331] = function()
	evt.SetMessage(530)         -- "The Master tutor of Leather Armor, Rabisa Neldon, lives in the northern regions of Nighon."
	evt.Set("AutonotesBits", 144)         -- "The Master tutor of Leather Armor, Rabisa Neldon, lives in the northern regions of Nighon."
end

-- "Miyon the Quick"
evt.global[332] = function()
	evt.SetMessage(531)         -- "The Grandmaster of Leather Armor, Miyon the Quick, can be found in the eastern section of the city of Pierpont in the elven region of the Tularean Forest."
	evt.Set("AutonotesBits", 145)         -- "The Grandmaster of Leather Armor, Miyon the Quick, can be found in the eastern section of the city of Pierpont in the elven region of the Tularean Forest."
end

-- "Medwari Dragontracker"
evt.global[333] = function()
	evt.SetMessage(532)         -- "The Master instructor of uses of Chain Armor, Medwari Dragontracker, can be found in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 146)         -- "The Master instructor of uses of Chain Armor, Medwari Dragontracker, can be found in the elven territory of Avlee.  His home is in the city in the northeast."
end

-- "Halian Nevermore"
evt.global[334] = function()
	evt.SetMessage(533)         -- "The Grandmaster instructor of Chain Armor, Halian Nevermore, maintains his residence in a large city in the northwest region of Deyja."
	evt.Set("AutonotesBits", 147)         -- "The Grandmaster instructor of Chain Armor, Halian Nevermore, maintains his residence in a large city in the northwest region of Deyja."
end

-- "Dekian Forgewright"
evt.global[335] = function()
	evt.SetMessage(534)         -- "My Master, Dekian Forgewright, makes his home in Erathia in the capitol city of Steadwick. He can provide further instruction in the uses of Plate Armor."
	evt.Set("AutonotesBits", 148)         -- "My Master, Dekian Forgewright, makes his home in Erathia in the capitol city of Steadwick. He can provide further instruction in the uses of Plate Armor."
end

-- "Brand the Maker"
evt.global[336] = function()
	evt.SetMessage(535)         -- "The Grandmaster of Plate Armor, Brand the Maker, can be found in the Bracada desert, on a ridge in the central region."
	evt.Set("AutonotesBits", 149)         -- "The Grandmaster of Plate Armor, Brand the Maker, can be found in the Bracada desert, on a ridge in the central region."
end

-- "Ashen Temper"
evt.global[337] = function()
	evt.SetMessage(536)         -- "The Master tutor of Fire Magic, Ashen Temper, can be found in  her home in the Tularean Forest ."
	evt.Set("AutonotesBits", 150)         -- "The Master tutor of Fire Magic, Ashen Temper, can be found in her home in the Tularean Forest "
end

-- "Blayze "
evt.global[338] = function()
	evt.SetMessage(537)         -- "The Grandmaster of Fire Magic, Blayze, makes his home on Emerald Island."
	evt.Set("AutonotesBits", 151)         -- "The Grandmaster of Fire Magic, Blayze, makes his home in Emerald Island."
end

-- "Rislyn Greenstorm"
evt.global[339] = function()
	evt.SetMessage(538)         -- "The Master tutor of Air Magic, Rislyn Greenstorm, lives in the elven territory of Avlee.  His home is in the city in the northeast."
	evt.Set("AutonotesBits", 152)         -- "The Master tutor of Air Magic, Rislyn Greenstorm, lives in the elven territory of Avlee.  His home is in the city in the northeast."
end

-- "Gayle"
evt.global[340] = function()
	evt.SetMessage(539)         -- "The Grandmaster of Air Magic, Gayle, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 153)         -- "The Grandmaster of Air Magic, Gayle, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Tobren Rainshield"
evt.global[341] = function()
	evt.SetMessage(540)         -- "The Master tutor of the uses of Water Magic, Tobren Rainshield, travels with the Lady Margaret which docks in Emerald Island."
	evt.Set("AutonotesBits", 154)         -- "The Master tutor of the uses of Water Magic, Tobren Rainshield, travels with the Lady Margaret.  The fine Lady docks in Emerald Island."
end

-- "Torrent"
evt.global[342] = function()
	evt.SetMessage(541)         -- "The Grandmaster of Water Magic, Torrent, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 155)         -- "The Grandmaster of Water Magic, Torrent, lives on a ridge, south of Harmondale, overlooking the city."
end

-- "Lara Stonewright"
evt.global[343] = function()
	evt.SetMessage(542)         -- "The Master tutor of Earth Magic, Lara Stonewright, makes her home in the elven territory of the Tularean Forest.  Her residence is in the city of Pierpont."
	evt.Set("AutonotesBits", 156)         -- "The Master tutor of Earth Magic, Lara Stonewright, makes her home in the elven territory of the Tularean Forest.  Her residence is in the city of Pierpont."
end

-- "Avalanche"
evt.global[344] = function()
	evt.SetMessage(543)         -- "The Grandmaster instructor of Earth Magic, Avalanche, maintains his residence in the western region of the Deyja."
	evt.Set("AutonotesBits", 157)         -- "The Grandmaster instructor of Earth Magic, Avalanche, maintains his residence in the western region of the Deyja."
end

-- "Heather Dreamwright"
evt.global[345] = function()
	evt.SetMessage(544)         -- "The Master who taught me, Heather Dreamwright, makes her home in Erathia, somewhere in the capitol city of Steadwick.  Further knowledge of Spirit Magic can be gained there."
	evt.Set("AutonotesBits", 158)         -- "The Master who taught me, Heather Dreamwright, makes her home in Erathia, somewhere in the capitol city of Steadwick.  Further knowledge of Spirit Magic can be gained there."
end

-- "Benjamin the Balanced"
evt.global[346] = function()
	evt.SetMessage(545)         -- "The ultimate teacher in the ways of Spirit Magic, Benjamin the Balanced, can be found in the elven territory of the Tularean Forest.  His home is in the city of Pierpont."
	evt.Set("AutonotesBits", 159)         -- "The ultimate teacher in the ways of Spirit Magic, Benjamin the Balanced, can be found in the elven territory of the Tularean Forest.  His home is in the city of Pierpont."
end

-- "Myles Featherwind"
evt.global[347] = function()
	evt.SetMessage(546)         -- "The Master teacher in the ways of Mind Magic, Myles Featherwind, can be found in the elven territory of Avlee.  His home is in the city to the northeast."
	evt.Set("AutonotesBits", 160)         -- "The Master teacher in the ways of Mind Magic, Myles Featherwind, can be found in the elven territory of Avlee.  His home is in the city to the northeast."
end

-- "Xavier Bremen"
evt.global[348] = function()
	evt.SetMessage(547)         -- "The Grandmaster of Mind Magic, Xavier Bremen, can be found in the snowy heights of the northeast area of Tatalia. "
	evt.Set("AutonotesBits", 161)         -- "The Grandmaster of Mind Magic, Xavier Bremen, can be found in the snowy heights of the northeast area of Tatalia. "
end

-- "Brother Bombah"
evt.global[349] = function()
	evt.SetMessage(548)         -- "The Master teacher in the ways of Body Magic, Brother Bombah, can be found in the swampy regions of Tatalia.  His home is somewhere in the southern region."
	evt.Set("AutonotesBits", 162)         -- "The Master teacher in the ways of Body Magic, Brother Bombah, can be found in the swampy regions of Tatalia.  His home is somewhere in the southern region."
end

-- "Tempus"
evt.global[350] = function()
	evt.SetMessage(549)         -- "The Grandmaster teacher in the ways of Body Magic, Tempus, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 163)         -- "The Grandmaster teacher in the ways of Body Magic, Tempus, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Samuel Benson"
evt.global[351] = function()
	evt.SetMessage(550)         -- "The Master of the Identify Item skill, Samuel Benson, can be found on a ridge in the central region of the Bracada desert."
	evt.Set("AutonotesBits", 164)         -- "The Master of the Identify Item skill, Samuel Benson, can be found on a ridge in the central region of the Bracada desert."
end

-- "Payge Blueswan"
evt.global[352] = function()
	evt.SetMessage(551)         -- "The Grandmaster of the Identify Item skill, Payge Blueswan, can be found in the elven territory of Avlee.  His home is just northwest of the elven city of Spaward."
	evt.Set("AutonotesBits", 165)         -- "The Grandmaster of the Identify Item skill, Payge Blueswan, can be found in the elven territory of Avlee.  His home is just northwest of the elven city of Spaward."
end

-- "Bethold Caverhill"
evt.global[353] = function()
	evt.SetMessage(552)         -- "The Master of the Merchant skill, Berthold Caverhill, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 166)         -- "The Master of the Merchant skill, Berthold Caverhill, can be found on the eastern most island of the Evenmorn Islands."
end

-- "Brigham the Frugal"
evt.global[354] = function()
	evt.SetMessage(553)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
	evt.Set("AutonotesBits", 167)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Thomas Moore"
evt.global[355] = function()
	evt.SetMessage(554)         -- "The Master teacher of the Repair Item Skill, Thomas Moore, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 168)         -- "The Grandmaster of the Merchant skill, Brigham the Frugal, can be found in a tower in the Bracada desert, on a ridge in the northern region."
end

-- "Gareth the Fixer"
evt.global[356] = function()
	evt.SetMessage(555)         -- "The Grandmaster of the Repair Item Skill, Gareth the Fixer, teaches from his home in the capitol city of Steadwick in Erathia."
	evt.Set("AutonotesBits", 169)         -- "The Grandmaster of the Repair Item Skill, Gareth the Fixer, teaches from his home in the capitol city of Steadwick in Erathia."
end

-- "Wanda Foestryke"
evt.global[357] = function()
	evt.SetMessage(556)         -- "The Master of the of the art of Body Building, Wanda Foestryke, can be found in the goblin village in eastern DeyJa Moor."
	evt.Set("AutonotesBits", 170)         -- "The Master of the of the art of Body Building, Wanda Foestryke, can be found in the goblin village in eastern Deyja."
end

-- "Evandar Thomas"
evt.global[358] = function()
	evt.SetMessage(557)         -- "The Grandmaster of the Body Building skill, Evander Thomas, makes his home in the eastern regions of Nighon."
	evt.Set("AutonotesBits", 171)         -- "The Grandmaster of the Body Building skill, Evander Thomas, makes his home in the eastern regions of Nighon."
end

-- "Tessa Greensward"
evt.global[359] = function()
	evt.SetMessage(558)         -- "The Master of Meditation, Tessa Greensward, can be found on a ridge in the southeast region of the Bracada desert."
	evt.Set("AutonotesBits", 172)         -- "The Master of Meditation, Tessa Greensward, can be found on a ridge in the southeast region of the Bracada desert."
end

-- "Kaine"
evt.global[360] = function()
	evt.SetMessage(559)         -- "The Grandmaster of Meditation, Kaine, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 173)         -- "The Grandmaster of Meditation, Kaine, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Garret Dotes"
evt.global[361] = function()
	evt.SetMessage(560)         -- "The Master of the Perception Skill, Garret Dotes, can be found in the elven area of the Tularean Forest.  His home is in the Elven city of Pierpont."
	evt.Set("AutonotesBits", 174)         -- "The Master of the Perception Skill, Garret Dotes, can be found in the elven area of the Tularean Forest.  His home is in the Elven city of Pierpont."
end

-- "Petra Cleareye"
evt.global[362] = function()
	evt.SetMessage(561)         -- "The Grandmaster of the Skill of Perception, Petra Cleareye, can be found in the city in the northwest region of the Deyja."
	evt.Set("AutonotesBits", 175)         -- "The Grandmaster of the Skill of Perception, Petra Cleareye, can be found in the city in the northwest region of Deyja."
end

-- "Lenord Skinner"
evt.global[363] = function()
	evt.SetMessage(562)         -- "The Master of Disarm Trap Skill, Lenord Skinner, lives on a ridge, south of Harmondale, overlooking the city."
	evt.Set("AutonotesBits", 176)         -- "The Master of Disarm Trap Skill, Lenord Skinner, lives on a ridge, south of Harmondale, overlooking the city."
end

-- "Silk Quicktoungue"
evt.global[364] = function()
	evt.SetMessage(563)         -- "The Grandmaster of the Disarm Trap Skill, Silk Quicktoungue, makes his home in the southern region of Nighon."
	evt.Set("AutonotesBits", 177)         -- "The Grandmaster of the Disarm Trap Skill, Silk Quicktoungue, makes his home in the southern region of Nighon."
end

-- "Oberic Crane"
evt.global[365] = function()
	evt.SetMessage(564)         -- "The Master of the Dodging Skill, Oberic Crane, can be found on the eastern most island of the Evenmorn Islands"
	evt.Set("AutonotesBits", 178)         -- "The Master of the Dodging Skill, Oberic Crane, can be found on the eastern most island of the Evenmorn Islands"
end

-- "Kenneth Wain"
evt.global[366] = function()
	evt.SetMessage(565)         -- "The Grandmaster of the Dodging Skill, Kenneth Wain, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 179)         -- "The Grandmaster of the Dodging Skill, Kenneth Wain, can be found in the capitol city of Steadwick, in Erathia."
end

-- "Ulbrecht the Brawler"
evt.global[367] = function()
	evt.SetMessage(566)         -- "The Master of Unarmed Combat, Ulbrecht the Brawler, can be found on the eastern most island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 180)         -- "The Master of Unarmed Combat, Ulbrecht the Brawler, can be found on the eastern most island of the Evenmorn Islands."
end

-- "Norris "
evt.global[368] = function()
	evt.SetMessage(567)         -- "The Grandmaster of Unarmed Combat, Norris, can be found in the capitol city of Steadwick, in Erathia."
	evt.Set("AutonotesBits", 181)         -- "The Grandmaster of Unarmed Combat, Norris, can be found in the capitol city of Steadwick, in Erathia."
end

-- "Jeni Swiftfoot"
evt.global[369] = function()
	evt.SetMessage(568)         -- "The Master instructor of the Identify Monster Skill, Jeni Swiftfoot, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 182)         -- "The Master instructor of the Identify Monster Skill, Jeni Swiftfoot, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Raven the Hunter"
evt.global[370] = function()
	evt.SetMessage(569)         -- "The Grandmaster of the Identify Monster Skill, Raven the Hunter, can be found in a small village to the south of Harmondale."
	evt.Set("AutonotesBits", 183)         -- "The Grandmaster of the Identify Monster Skill, Raven the Hunter, can be found in a small village to the south of Harmondale."
end

-- "Paula Brightspear"
evt.global[371] = function()
	evt.SetMessage(570)         -- "The Master tutor of the Armsmaster Skill, Paula Brightspear, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
	evt.Set("AutonotesBits", 184)         -- "The Master tutor of the Armsmaster Skill, Paula Brightspear, lives in the elven territory of Avlee.  Her home is in the city in the northeast."
end

-- "Lasiter the Slayer"
evt.global[372] = function()
	evt.SetMessage(571)         -- "The Grandmaster of the Armsmaster Skill, Lasiter the Slayer, makes his home in the eastern region of Eeofol."
	evt.Set("AutonotesBits", 185)         -- "The Grandmaster of the Armsmaster Skill, Lasiter the Slayer, makes his home in the eastern region of Eeofol."
end

-- "Leane Shadowrunner"
evt.global[373] = function()
	evt.SetMessage(572)         -- "The Master tutor of the Stealing Skill, Leane Shadowrunner, makes her home in the goblin village in the eastern region of the Deyja."
	evt.Set("AutonotesBits", 186)         -- "The Master tutor of the Stealing Skill, Leane Shadowrunner, makes her home in the goblin village in the eastern region of the Deyja."
end

-- "Everil Nightwalker"
evt.global[374] = function()
	evt.SetMessage(573)         -- "The Grandmaster teacher of the art of Stealing, Everil Nightwalker, can be found in the swampy delta of the southern region of Tatalia."
	evt.Set("AutonotesBits", 187)         -- "The Grandmaster teacher of the art of Stealing, Everil Nightwalker, can be found in the swampy delta of the southern region of Tatalia."
end

-- "Elzbet Winterspoon"
evt.global[375] = function()
	evt.SetMessage(574)         -- "The Master of Alchemy, Elzbet Winterspoon, can be found in the western region of Nighon."
	evt.Set("AutonotesBits", 188)         -- "The Master of Alchemy, Elzbet Winterspoon, can be found in the western region of Nighon."
end

-- "Lucid Apple"
evt.global[376] = function()
	evt.SetMessage(575)         -- "The Grandmaster instructor of Alchemy, Lucid Apple, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
	evt.Set("AutonotesBits", 189)         -- "The Grandmaster instructor of Alchemy, Lucid Apple, can be found in the elven territory of Avlee.  His home is on an island somewhere in the central bay."
end

-- "Dorothy Senjac"
evt.global[377] = function()
	evt.SetMessage(576)         -- "The Master of Learning, Dorothy Senjac, can be found in the southeast region of Nighon."
	evt.Set("AutonotesBits", 190)         -- "The Master of Learning, Dorothy Senjac, can be found in the southeast region of Nighon."
end

-- "William Davies"
evt.global[378] = function()
	evt.SetMessage(577)         -- "The Grandmaster of Learning, William Smithson, instructs from his home on the eastern island of the Evenmorn Islands."
	evt.Set("AutonotesBits", 191)         -- "The Grandmaster of Learning, William Smithson, instructs from his home on the eastern island of the Evenmorn Islands."
end

-- "Helena Morningstar"
evt.global[379] = function()
	evt.SetMessage(578)         -- "The Master of Light Magic, Helena Mornigstar, can be found in the cloud city of Celeste!"
	evt.Set("AutonotesBits", 192)         -- "The Master of Light Magic, Helena Mornigstar, can be found in the cloud city of Celeste!"
end

-- "Gavin Magnus"
evt.global[380] = function()
	evt.SetMessage(579)         -- "The Grand Master of Light Magic can be found in the wizards castle, Castle Lambent."
	evt.Set("AutonotesBits", 193)         -- "The Grand Master of Light Magic can be found in the wizards castle, Castle Lambent."
end

-- "Seth Darkenmore"
evt.global[381] = function()
	evt.SetMessage(580)         -- "The Master of Dark, Seth Darkenmore, can be found in The Pit beneath Deyja!"
	evt.Set("AutonotesBits", 194)         -- "The Master of Dark, Seth Darkenmore, can be found in The Pit beneath Deyja!"
end

-- "Archibald"
evt.global[382] = function()
	evt.SetMessage(581)         -- "The Grand Master of Dark Magic can be found in the necromancer castle, Castle Gloaming.  At times Archibald has been know to take the journey to Clankers Lab."
	evt.Set("AutonotesBits", 195)         -- "The Grand Master of Dark Magic can be found in the necromancer castle, Castle Gloaming.  At times Archibald has been know to take the journey to Clankers Lab."
end

-- "Empty Barrel"
evt.global[383] = function()
	evt.StatusText(582)         -- "Empty Barrel"
end

-- "Red Barrel"
evt.global[384] = function()
	evt.StatusText(583)         -- "+5 Might permanent"
	evt.Add("BaseMight", 5)
	evt.Set("AutonotesBits", 33)         -- "Red liquid grants Might."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Yellow Barrel"
evt.global[385] = function()
	evt.StatusText(584)         -- "+5 Accuracy permanent"
	evt.Add("BaseAccuracy", 5)
	evt.Set("AutonotesBits", 37)         -- "Yellow liquid grants Accuracy."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Blue Barrel"
evt.global[386] = function()
	evt.StatusText(585)         -- "+5 Personality permanent"
	evt.Add("BasePersonality", 5)
	evt.Set("AutonotesBits", 35)         -- "Blue liquid grants Personality."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Orange Barrel"
evt.global[387] = function()
	evt.StatusText(586)         -- "+5 Intellect permanent"
	evt.Add("BaseIntellect", 5)
	evt.Set("AutonotesBits", 34)         -- "Orange liquid grants Intellect."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Green Barrel"
evt.global[388] = function()
	evt.StatusText(587)         -- "+5 Endurance permanent"
	evt.Add("BaseEndurance", 5)
	evt.Set("AutonotesBits", 36)         -- "Green liquid grants Endurance."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Purple Barrel"
evt.global[389] = function()
	evt.StatusText(588)         -- "+5 Speed permanent"
	evt.Add("BaseSpeed", 5)
	evt.Set("AutonotesBits", 38)         -- "Purple liquid grants Speed."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "White Barrel"
evt.global[390] = function()
	evt.StatusText(589)         -- "+5 Luck permanent"
	evt.Add("BaseLuck", 5)
	evt.Set("AutonotesBits", 39)         -- "White liquid grants Luck."
	evt.ChangeEvent(383)         -- "Empty Barrel"
end

-- "Empty Cauldron"
evt.global[391] = function()
	evt.StatusText(590)         -- "Empty Cauldron"
end

-- "Steaming Cauldron"
evt.global[392] = function()
	evt.StatusText(591)         -- "+10 Fire Resistance permanent"
	evt.Add("FireResistance", 10)
	evt.Set("AutonotesBits", 40)         -- "Steaming liquid grants Fire Resistance."
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Frosty Cauldron"
evt.global[393] = function()
	evt.StatusText(592)         -- "+10 Water Resistance permanent"
	evt.Add("WaterResistance", 10)
	evt.Set("AutonotesBits", 41)         -- "Frosty liquid grants Water Resistance."
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Shocking Cauldron"
evt.global[394] = function()
	evt.StatusText(593)         -- "+10 Air Resistance permanent"
	evt.Add("AirResistance", 10)
	evt.Set("AutonotesBits", 42)         -- "Shocking liquid grants Air Resistance."
	evt.ChangeEvent(391)         -- "Empty Cauldron"
end

-- "Dirty Cauldron"
evt.global[395] = function()
	evt.StatusText(594)         -- "+10 Earth Resistance permanent"
	evt.Add("EarthResistance", 10)
	evt.Set("AutonotesBits", 43)         -- "Dirty liquid grants Earth Resistance."
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
		goto _4
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		goto _9
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
	do return end
::_4::
	evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
	goto _15
::_9::
	evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
	goto _15
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
		goto _4
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		goto _9
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
	do return end
::_4::
	evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
	goto _15
::_9::
	evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
	goto _15
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
		goto _4
	elseif i == 2 then
		if not evt.Cmp("PerceptionSkill", 1) then
			evt.Set("DiseasedGreen", 0)
			evt.StatusText(595)         -- "Diseased!"
		end
		goto _9
	end
	if not evt.Cmp("PerceptionSkill", 1) then
		evt.Set("DiseasedYellow", 0)
		evt.StatusText(595)         -- "Diseased!"
	end
	evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
::_15::
	evt.ChangeEvent(411)         -- "Trash Heap"
	do return end
::_4::
	evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
	goto _15
::_9::
	evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
	goto _15
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
	evt.Add("Inventory", 630)         -- "Red Delicious Apple"
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
	local result
	if not evt.Cmp("QBits", 196) then         -- Find second entrance to Watchtower6
		result = evt.Cmp("QBits", 19)         -- "Go to Watchtower 6 in the Deyja Moors, and move the weight from the top of the tower to the bottom of the tower.  Then return to William Lasker in the Erathian Sewers."
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

-- "Quest"
evt.global[421] = function()
	evt.SetMessage(604)         -- "The sacred relic of the Order of Fire, the Scroll of Mage Wonka, has been lost for many years.  The caravan that was transporting this relic from Harmondale to Bracada never made it out of the Barrow Downs.  Find the Lost Scroll of Wonka and return it to me and I will grant all Elemental Magic users in your party Expert Fire Magic with a Skill of ‘8’."
	evt.Add("QBits", 272)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.SetNPCTopic{NPC = 139, Index = 1, Event = 573}         -- "Blayze " : "We've found the Lost Scroll!"
end

-- "Now that's what I call 'fun'!"
evt.global[422] = function()
	evt.SetMessage(252)         --[[ "Hope ya don’t mind that I left ya and went ahead to scout out the area.  Thanks for the help in dispatching them Water Elementals.

I guess we’re gonna hafta run this here ‘gauntlet’, huh?  We’ll I’m a little ‘long in the tooth’ to be runnin’, although thar’s nothin’ wrong with my sword arm.  So if ya don’t mind, I’ll stay here and keep this area safe for our exit.  When ya find the key, don’t wait for me.  I’ll join ya as you exit to the Coding Fortress.

Oh, by the way.  There’s a scroll in that chest over thar that lists some rules for this place.  I suggest ya read it so’s we don’t get into any more trouble than we need to in here.

See ya on the way back my friends." ]]
	evt.SetNPCTopic{NPC = 18, Index = 1, Event = 0}         -- "Lord Godwinson"
end

-- "Buy Speed Boost Potent"
evt.global[423] = function()
	local i
	evt.ForPlayer("All")
	i = Game.Rand() % 6
	if i >= 2 and i <= 5 then
		evt.SetMessage(262)         -- "I just sold my only one.  Come back in an hour."
	else
		if evt.Cmp("Gold", 10000) then
			evt.SetMessage(266)         -- "Here's your Potent of Speed Boost.  It's good doing business with you!"
			evt.ForPlayer("Current")
			evt.Subtract("Gold", 10000)
			evt.Add("Inventory", 244)         -- "Speed Boost"
		else
			evt.SetMessage(265)         -- "You don't have enough gold!"
		end
	end
end

-- ERROR: Invalid command size: 43016:1 (Cmd00)
-- ERROR: Not found

-- "A word of Caution!"
evt.global[424] = function()
	evt.SetMessage(727)         --[[ "Oh! and stay clear of Pascal and his minions of conjured Trolls!  Pascal is really quite ‘mad’ and his minions are somewhat stupid.  If you get too close to them in the heat of Battle, they may attack you!  If this occurs, all of your allies will become your enemies and you will fail the Test of Friendship!

And remember your objective!  Get the cube and gather your friends back into your party.  Once this is done you can dispatch the remaining foes if you like.

When it’s time to leave, you **must** use the exit to Celeste located immediately behind you in company with all six friends!  Don’t leave this cave by any other means or you will fail The Test and The Game!

Good luck, adventurers!" ]]
	evt.SetMonGroupBit{NPCGroup = 6, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M1"
	evt.SetMonGroupBit{NPCGroup = 7, Bit = const.MonsterBits.Hostile, On = false}         -- "Group fo M2"
	evt.SetMonGroupBit{NPCGroup = 8, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for M3"
	evt.SetMonGroupBit{NPCGroup = 9, Bit = const.MonsterBits.Hostile, On = false}         -- "Group for Malwick's Assc."
	evt.SetMonGroupBit{NPCGroup = 10, Bit = const.MonsterBits.Hostile, On = false}         -- "Southern Village Group in Harmondy"
	evt.SetMonGroupBit{NPCGroup = 11, Bit = const.MonsterBits.Hostile, On = false}         -- "Main village in Harmondy"
end

-- "EMPTY"
-- "EMPTY"
-- "EMPTY"
-- ERROR: Invalid command size: 44040:1 (Cmd00)
-- ERROR: Not found

-- "Monk Training"
evt.global[428] = function()
	evt.SetMessage(611)         -- "If you're looking for a teacher to begin serious monk training, speak with Bartholomew Hume--you can find him in the Bracada."
end

-- "Medusas"
evt.global[429] = function()
	evt.SetMessage(617)         -- "There is a breed of Medusa infesting the Red Dwarf Mines that is immune to magic.  These monsters are a real terror!  I can only thank the Gods that these creatures haven't escaped the mine.  What would we do then, beat them to death with our staves?"
end

-- "Temple of Baa"
evt.CanShowTopic[430] = function()
	local result
	if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
		if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
			result = evt.Cmp("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
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
	local result
	if not evt.Cmp("Awards", 24) then         -- "Promoted to Master"
		if not evt.Cmp("Awards", 25) then         -- "Promoted to Honorary Master"
			result = evt.Cmp("QBits", 28)         -- "Go to the Temple of Baa in Avlee and kill the High Priest of Baa, then return to Bartholomew Hume in Harmondale."
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

-- "Warrior Mage Promotion"
evt.global[445] = function()
	evt.ForPlayer("Current")
	if evt.Cmp("Experience", 15000) then
		evt.ForPlayer("All")
		evt.SetMessage(736)         -- "I knew there was something 'special' about you, adventurers!   And I see you have the experience necessary to tackle the Warrior Mage promotion task.  So let's begin, shall we?"
		evt.SetNPCTopic{NPC = 21, Index = 1, Event = 67}         -- "Zedd True Shot" : "Warrior Mage"
	else
		evt.SetMessage(342)         --[[ "I understand your enthusiasm adventurers.  But you are far too inexperienced for the required promotion task.  Travel about on the mainland, gain some real-world experience, and return to the ‘EI’.  Then we’ll discuss the promotion.

So I’ll await your return?  Good.  See you soon." ]]
	end
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

-- "We need your help!"
evt.global[452] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 244) then         -- "Speed Boost"
		evt.SetMessage(259)         --[[ "The Speed Boost potent!  Good!  Give me a minute to complete the elixir.

[]
[]
[]

There you go!  Here’s the Plague Elixir.

Now hurry back to Stone City!" ]]
		evt.Subtract("Inventory", 244)         -- "Speed Boost"
		evt.SetNPCTopic{NPC = 208, Index = 1, Event = 0}         -- "Lucid Apple"
		evt.ForPlayer("Current")
		evt.Add("Inventory", 273)         -- "Plague Elixir"
		evt.SetNPCTopic{NPC = 59, Index = 0, Event = 453}         -- "Hothfarr IX" : "We have the Plague Elixir!"
	else
		evt.SetMessage(258)         --[[ "What’s the problem, adventurers? [You tell Lucid the conditions in Stone City].  Plague!  This is not good, not good at all!  And of course I’ll help.  Give me a minute to see what I have on hand.[Lucid begins to rummage through her inventory, searching through bottles, boxes, barrels, shelves and drawers, all-the-while humming a tune from CCR.]

I can mix-up a Plague Elixir that can be added to the water supply.  It will cure the population of Stone City within one day.  However, I am missing one ‘ingredient’ – a Speed Boost potent.  Bring me this potent with all haste.

[You ask Lucid where you can obtain this potent.]

If you have the skill and ingredients, you can mix one up yourself from a Haste Potent combined with an Orange Potent.  Otherwise, check out the local shops.  As a last resort, find a Wandering Peddler.  Sometimes they carry various potents. This time of year they seem to ‘congregate’ in Steadwick.

Good luck!" ]]
	end
end

-- "We have the Plague Elixir!"
evt.global[453] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 273) then         -- "Plague Elixir"
		evt.SetMessage(264)         --[[ "The Plague Elixir!

[You relate the information from Lucid about how to use this elixir.  The King turns to his personal advisor.]

Have the guards pour this elixir into the underground stream immediately!  Don’t waste a single drop!

[The King turns back to you]

Bless the fates, you have saved my people and my kingdom!  Your bravery, courage and resourcefulness have earned you the title ‘Friend of Hothfarr, King of Dwarves, and Savior of Stone City’!

For this service to The Crown, I present you with a set of four rings of rather plain stature, but of powerful enchantment. You may claim these rings in the two chests outside of my Throne Room.

Oh. Be careful.  The chests are ‘trapped’." ]]
		evt.Add("Experience", 100000)
		evt.Add("Gold", 5000)
		evt.Set("Awards", 21)         -- "Proclaimed Friend of Hothfarr, King of Dwarves and Savior of Stone City"
		evt.Subtract("QBits", 370)         -- "Obtain Plague Elixir from Lucid Apple in Avlee and deliver it to King Hothffar in Stone City within two days."
		evt.Set("QBits", 368)         -- Barrow Normal
		evt.Subtract("Inventory", 273)         -- "Plague Elixir"
		evt.SetNPCTopic{NPC = 59, Index = 0, Event = 0}         -- "Hothfarr IX"
		evt.SetNPCGreeting{NPC = 59, Greeting = 30}         -- "Hothfarr IX" : "Welcome back Friends of Hothfarr and Saviors of Stone City!  The city is at your disposal."
	end
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

-- "Arcomage Tounament"
evt.global[466] = function()
	evt.SetMessage(664)         -- "To be declared ArcoMage Champion, you must win a game of ArcoMage in every tavern on, in, and under the continent of Erathia.  There are 13 such taverns sponsoring ArcoMage events.  When you have accomplished this in Elrond's name, return to me and I shall bestow upon you great rewards."
	evt.Set("QBits", 205)         -- "Honor Elrond's memory by winning the Arcomage Championship, then return to Darron Temper in Pierpont."
	evt.SetNPCTopic{NPC = 285, Index = 0, Event = 467}         -- "Darron Temper" : "Quest"
end

-- "Quest"
evt.global[467] = function()
	if evt.Cmp("QBits", 238) then         -- Won all Arcomage games
		evt.SetMessage(666)         -- "Congratulations!  You have brought honor to Elrond's name by becoming the ArcoMage Champion!  Your reward is waiting in a chest outside of our summer home in Erathia."
		evt.Subtract("QBits", 205)         -- "Honor Elrond's memory by winning the Arcomage Championship, then return to Darron Temper in Pierpont."
		evt.Add("Gold", 100000)
		evt.Subtract("Reputation", 10)
		evt.ForPlayer("All")
		evt.Add("Experience", 50000)
		evt.Add("QBits", 244)         -- Finished ArcoMage Quest - Get the treasure
		evt.Add("Awards", 102)         -- "ArcoMage Champion"
		evt.SetNPCGreeting{NPC = 285, Greeting = 178}         -- "Darron Temper" : "Welcome ArcoMage Champions!"
		evt.SetNPCTopic{NPC = 285, Index = 0, Event = 0}         -- "Darron Temper"
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
	evt.SetMessage(682)         -- "A ways outside of Harmondale there's a cave system called the White Cliff Caves.  The entrance has been magically warded for as long as I can remember.  Recently, the Mad Mage Pascal, Diviner of Strange Flesh, has removed the ward and sent an entire army of Trolls into the cave.  Travelers report that they have heard sounds of a fierce battle being waged near the entrance.  I'd avoid that area, if I were you!"
end

-- "Fort Riverstride"
evt.global[482] = function()
	if evt.Cmp("QBits", 83) then         -- Gave false Loren to Catherine (betray)
		evt.SetMessage(708)         -- "I've heard Fort Riverstride was taken with the aid of treachery!  What a shame that those wretches were able to wring concessions from the Queen in exchange for the return of what was already ours!"
	else
		evt.SetMessage(683)         -- "Did you notice that covered bridge on the way from Harmondale to Steadwick?  It's called Fort Riverstride, and it protects us from surprise Elvish attacks coming through Harmondale.  There's so many traps and tricks inside there, they say it will never fall without the help of treachery.  "
	end
end

-- "The Arena"
evt.global[483] = function()
	evt.SetMessage(684)         -- "There's a Fountain just outside of the School of Sorcery in Bracada that will immediately teleport you to the Arena.   It's a good way to get some experience under your belt; ....  if you survive the encounters!"
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
	evt.SetMessage(693)         -- "During the War, the Warlocks had dealings with some strange creatures commonly known as devils in the mountains south of Avlee.  It's impossible to get there from the mainland, but the Warlocks dug a tunnel under the sea from their island that leads to the devil's home."
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

-- "We Found a lost ONE!"
evt.global[498] = function()
	evt.SetMessage(255)         --[[ "Hey good buddies. That’s Super!  Great!  Peachy Keen!  Boss!  Radical!

Now you need to report these lost ONES, and any other problems, comments, and/or thoughts to Big Daddy Jim as a BLOG response at the following site:

http://hosted.filefront.com/BigDaddyJim

Muchas Gracias!  Many Thanks! And all that stuff ...." ]]
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
	else
		if evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
			evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
			evt.GiveItem{Strength = 5, Type = const.ItemType.Weapon_, Id = 0}
			evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
		else
			if evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
				evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Weapon_, Id = 0}
				evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
			else
				if evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
					evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
					evt.GiveItem{Strength = 3, Type = const.ItemType.Weapon_, Id = 0}
					evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
				else
					if evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
						evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
						evt.GiveItem{Strength = 2, Type = const.ItemType.Weapon_, Id = 0}
						evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
					else
						if evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
							evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
							evt.GiveItem{Strength = 1, Type = const.ItemType.Weapon_, Id = 0}
							evt.SetMessage(717)         -- "Here's your weapon; if you find more ore, I'll be happy to make you more weapons."
						else
							evt.SetMessage(718)         -- "You need ore for me to create weapons.  The better the ore, the better the weapon I can make."
						end
					end
				end
			end
		end
	end
end

-- "Make Armor"
evt.global[502] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Armor_, Id = 0}
		evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
	else
		if evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
			evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
			evt.GiveItem{Strength = 5, Type = const.ItemType.Armor_, Id = 0}
			evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
		else
			if evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
				evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Armor_, Id = 0}
				evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
			else
				if evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
					evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
					evt.GiveItem{Strength = 3, Type = const.ItemType.Armor_, Id = 0}
					evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
				else
					if evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
						evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
						evt.GiveItem{Strength = 2, Type = const.ItemType.Armor_, Id = 0}
						evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
					else
						if evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
							evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
							evt.GiveItem{Strength = 1, Type = const.ItemType.Armor_, Id = 0}
							evt.SetMessage(719)         -- "Here's your armor; if you find more ore, I'll be happy to make you more armor."
						else
							evt.SetMessage(720)         -- "You need ore for me to create armor.  The better the ore, the better the armor I can make."
						end
					end
				end
			end
		end
	end
end

-- "Make Item"
evt.global[503] = function()
	if evt.Cmp("Inventory", 691) then         -- "Stalt-laced ore"
		evt.Subtract("Inventory", 691)         -- "Stalt-laced ore"
		evt.GiveItem{Strength = 6, Type = const.ItemType.Misc, Id = 0}
		evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
	else
		if evt.Cmp("Inventory", 690) then         -- "Erudine-laced ore"
			evt.Subtract("Inventory", 690)         -- "Erudine-laced ore"
			evt.GiveItem{Strength = 5, Type = const.ItemType.Misc, Id = 0}
			evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
		else
			if evt.Cmp("Inventory", 689) then         -- "Kergar-laced ore"
				evt.Subtract("Inventory", 689)         -- "Kergar-laced ore"
				evt.GiveItem{Strength = 4, Type = const.ItemType.Misc, Id = 0}
				evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
			else
				if evt.Cmp("Inventory", 688) then         -- "Phylt-laced ore"
					evt.Subtract("Inventory", 688)         -- "Phylt-laced ore"
					evt.GiveItem{Strength = 3, Type = const.ItemType.Misc, Id = 0}
					evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
				else
					if evt.Cmp("Inventory", 687) then         -- "Siertal-laced ore"
						evt.Subtract("Inventory", 687)         -- "Siertal-laced ore"
						evt.GiveItem{Strength = 2, Type = const.ItemType.Misc, Id = 0}
						evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
					else
						if evt.Cmp("Inventory", 686) then         -- "Iron-laced ore"
							evt.Subtract("Inventory", 686)         -- "Iron-laced ore"
							evt.GiveItem{Strength = 1, Type = const.ItemType.Misc, Id = 0}
							evt.SetMessage(721)         -- "Here is your item; if you find more ore, I'll be happy to make you more items."
						else
							evt.SetMessage(722)         -- "You need ore for me to create items.  The better the ore, the better the items I can make."
						end
					end
				end
			end
		end
	end
end

-- "Signal "
evt.global[504] = function()
	evt.SetMessage(723)         -- "The signal rocket on the west side of the island should be set of to warn ships off from approaching to close to that side of the island.  The reefs off the west coast have proven deadly in the past."
end

-- "Dragon Flies"
evt.global[505] = function()
	evt.SetMessage(724)         -- "Beware the marshes of the southern tip of the island.  A tribe of Goblins has taken up residence there!  "
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
		evt.SetMessage(727)         --[[ "Oh! and stay clear of Pascal and his minions of conjured Trolls!  Pascal is really quite ‘mad’ and his minions are somewhat stupid.  If you get too close to them in the heat of Battle, they may attack you!  If this occurs, all of your allies will become your enemies and you will fail the Test of Friendship!

And remember your objective!  Get the cube and gather your friends back into your party.  Once this is done you can dispatch the remaining foes if you like.

When it’s time to leave, you **must** use the exit to Celeste located immediately behind you in company with all six friends!  Don’t leave this cave by any other means or you will fail The Test and The Game!

Good luck, adventurers!" ]]
	else
		if evt.Cmp("Awards", 46) then         -- "Completed Wizard Proving Grounds"
			evt.SetMessage(728)         -- "My Lords!  Gavin Magnus sent engineers and artisans to upgrade Castle Harmondale!  Now we have an upstairs and downstairs!  The artisans are setting up shop in the entry hall and will have many wonderful items for sale!  The workers, however, discovered an older area to the castle--a torture chamber and dungeon.  It isn't a pretty sight, I'm afraid."
		else
			evt.SetMessage(732)         -- "My Lords. Castle Harmondale stands ready."
		end
	end
end

-- "Pedestals"
evt.global[509] = function()
	evt.SetMessage(733)         -- "Pedestals can be found through out the land that can lend you temporary protection from certain types of magic. "
end

-- "Disputed Land"
evt.global[510] = function()
	evt.SetMessage(729)         -- "My Lords ::bows:: Now that you have cleared Castle Harmondale of the vandals and thieves, you should concentrate on removing the goblins from the area surrounding Harmondale.  To the east of here is the center of the disputed region.  Many great battles have been waged there between the forces of King Eldrich of the Elves and Queen Catherine of Erathia.  The goblins have taken the ruined fort in this area an use it to attack any travelers attempting to reach Harmondale!"
end

-- "Castle Harmondale"
evt.global[511] = function()
	evt.SetMessage(730)         -- "My Lords, remember Castle Harmondale is YOURS.  Feel free to relax while you're here.  Your sleep will never be disturbed by attacking monsters, nor will anything you decide to store in the castle's chests ever be stolen or removed.  You are home."
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

-- "Recent Loss"
evt.global[515] = function()
	evt.SetMessage(740)         -- "My husband Darron recently lost his brother in a freak accident.  So overwhelming is his grief that he spends his days wandering aimlessly about Pierpont.  Poor soul!"
end

-- "Can we help?"
evt.global[516] = function()
	evt.SetMessage(450)         -- "That's very kind of you.  But no .... I've got to deal with his absence in my own way and time.  Wait!!  perhaps you can assist me by honoring my brother's name.  You see, Elron, was an avid Arcomage player.  Horribly addicting game, if I do say so.  Here, take his Arcomage deck and win the Arcomage tournament in his name.  He'd like that.  Thank you."
	evt.ForPlayer("Current")
	evt.Add("Inventory", 651)         -- "Arcomage Deck"
	evt.SetNPCTopic{NPC = 285, Index = 0, Event = 466}         -- "Darron Temper" : "Arcomage Tounament"
end

-- "Disarm Trap Expert"
evt.global[517] = function()
	evt.SetMessage(742)         -- "Bill Lasker is the only one who can provide this advancement.  Seek him out in the Erathian Sewers."
end

-- "Courier Delivery"
evt.global[518] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 277) then         -- Courier Quest 4
		evt.SetMessage(786)         --[[ "My! Aren't you a fine-looking group of adventurers!  Zowie!  Fine, supple, strong; beauty at its best!  It’s always grand to meet others of the same calaibre as myself.  They should call ‘our kind’ the ‘Beautiful Ones’.  My name is Agatha.  Good to feast my eyes on you all. 

Now, onto the task at-hand.  My twin sister Rena lives here in Deja with her husband, Jayce Kedrin.  Rena and I are not identical twins and she was not ‘blessed’ with the ‘looks’ in our family as was I.  She’s, well, kind of plain.  Some might call her a real ‘Bow Wow’, if you know what I mean.  She’s the proverbial ‘two-bag date’.  Anywise, her birthday is upon us and I have purchased a special concoction called ‘Beauty Cream’ from Licia Rivenrock.  She’s indeed a Master Herbalist and her ‘cream’ is reported to do wonders with even the most ‘ordinary’ of subjects. I need you to pick up the order from Licia and deliver it to my sister.  Licia runs a business called ‘The House of Remedies’ in the Barrow Downs.

Oh! And my sister will provide you with the customary fee upon delivery. " ]]
		evt.SetNPCTopic{NPC = 209, Index = 0, Event = 0}         -- "Agatha Putnam"
		return
	end
	if evt.Cmp("QBits", 276) then         -- Courier Quest 3
		if evt.Cmp("Inventory", 774) then         -- "Recipe"
			evt.SetMessage(785)         -- "The recipe!  You made good time on this delivery.  Great service!  Thanks.  Here's your fee."
			evt.Subtract("Inventory", 774)         -- "Recipe"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 451, Index = 0, Event = 0}         -- "Alice the Chef"
			evt.Set("QBits", 280)         -- Courier Quest 3 complete
		else
			evt.SetMessage(783)         -- "Welcome to Alice’s Restaurant … where you can get anything you want!  Well, that is, except me. I’m Alice.  Today’s special is broiled filet of Troll, smothered in toad stools with …  Oh, I’m sorry.  You’re the couriers, aren’t you!  What I need you to do is to pickup a recipe from Peni Pretty in Erathia and return it to me.  The standard delivery fee will be paid upon receipt of the recipe."
		end
		return
	end
	if evt.Cmp("QBits", 275) then         -- Courier Quest 2
		if evt.Cmp("Inventory", 564) then         -- "Talisman (repaired)"
			evt.SetMessage(781)         -- "The talisman, good as new!  Thanks.  Here’s your payment."
			evt.Subtract("Inventory", 564)         -- "Talisman (repaired)"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 38, Index = 0, Event = 0}         -- "Bartholomew Hume"
			evt.Set("QBits", 279)         -- Courier Quest 2 complete
			return
		end
		if not evt.Cmp("Inventory", 563) then         -- "Talisman (broken)"
			evt.ForPlayer("Current")
			evt.Set("Inventory", 563)         -- "Talisman (broken)"
		end
		goto _22
	end
	if not evt.Cmp("QBits", 274) then         -- Courier Quest 1
		return
	end
	if evt.Cmp("Inventory", 773) then         -- "Signed Contract"
		evt.SetMessage(744)         --[[ "Thanks for returning this contract to me.  Here's your reward, as promised. 

Oh! and I found the crossword puzzle answer.  Freddie the Freeloader was a Red Skeleton." ]]
		evt.Subtract("Inventory", 773)         -- "Signed Contract"
		evt.ForPlayer("Current")
		evt.Add("Gold", 5000)
		evt.SetNPCTopic{NPC = 241, Index = 0, Event = 0}         -- "Taren the Lifter"
		evt.Set("QBits", 278)         -- Courier Quest 1 complete
		return
	end
	if not evt.Cmp("Inventory", 772) then         -- "Unsigned Contract"
		evt.ForPlayer("Current")
		evt.Set("Inventory", 772)         -- "Unsigned Contract"
	end
	evt.SetMessage(743)         --[[ "Ahh, the new Courier Initiates arrive at last! I need to have a contract delivered to Mortie Ottin in Pierpont, signed by him, and returned to me post haste.  This is a very time sensitive task that needs to be completed within the month.  I will provide you with the customary payment when the contract is returned to me. 

Oh, before ya leave, maybe you can help me.  I'm 'stuck' on a crossword puzzle question.  Do you know the color of the Skeleton named 'Freddy the Freeloader'?  Didn't think so, but it was worth a try.  See you on your return trip." ]]
	do return end
::_22::
	evt.SetMessage(780)         -- "Ahh,the Couriers in-training!  Your arrival is most propitious!   I need you to deliver this broken talisman to Douglas Iversen in Harmondale.  Wait while he repairs the item and return it to me.  Upon its return, I’ll give you the standard courier fee."
end

-- "Courier Delivery"
evt.global[519] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 277) then         -- Courier Quest 4
		if evt.Cmp("QBits", 282) then         -- Rena Quest
			evt.SetMessage(788)         --[[ "A delivery for me?  Must be my birthday present from Agie. Oh my!  A bottle of the legendary ‘Beauty Cream’.  I’m so excited about this!  Here, let me have it.  [Rena takes the bottle and gulps down the entire content] 

Oh!  I feel so …. strange.  Here, take your delivery fee and leave now.  I’m going to take a little nap.  Visit me later to see the results of the ‘miracle treatment’.  By for now …. " ]]
			evt.Set("QBits", 281)         -- Courier Quest 4 complete
			evt.Subtract("Inventory", 272)         -- "Beauty Creme"
			evt.ForPlayer("Current")
			evt.Add("Gold", 5000)
			evt.SetNPCTopic{NPC = 452, Index = 0, Event = 0}         -- "Rena Putnum Kedrin"
			evt.MoveNPC{NPC = 452, HouseId = 0}         -- "Rena Putnum Kedrin"
			evt.MoveNPC{NPC = 453, HouseId = 336}         -- "Rena Putnum Kedrin" -> "Kedrin Residence"
		else
			evt.SetMessage(787)         --[[ "Hi, I’m Licia.  Can I interest you in some of my herbal remedies?  Perhaps some Love Potent #9?  Or a bottle of my patented ‘potency formula’ named ‘Argaiv’?  

Oh, of course not.  You’re the couriers here for a pick up, aren’t you.  Well here’s the bottle of Beauty Cream, and here’s your Deja Teleportal Key.  Good luck on your journey back to Deja."" ]]
			evt.Set("QBits", 282)         -- Rena Quest
			evt.SetNPCTopic{NPC = 452, Index = 0, Event = 519}         -- "Rena Putnum Kedrin" : "Courier Delivery"
			evt.ForPlayer("Current")
			evt.Set("Inventory", 272)         -- "Beauty Creme"
			evt.Set("Inventory", 666)         -- "Deja Teleportal Key"
			evt.SetNPCTopic{NPC = 399, Index = 0, Event = 0}         -- "Licia Rivenrock"
		end
	else
		if evt.Cmp("QBits", 276) then         -- Courier Quest 3
			evt.ForPlayer("Current")
			evt.Set("Inventory", 774)         -- "Recipe"
			evt.SetMessage(784)         -- "Oh, the couriers!  I suspect you’re here for the recipe?  Here you are.  And here’s the Avlee Teleportal Key."
			evt.Set("Inventory", 667)         -- "Avlee Teleportal Key"
			evt.SetNPCTopic{NPC = 442, Index = 0, Event = 0}         -- "Peni Pretty"
		else
			if evt.Cmp("QBits", 275) then         -- Courier Quest 2
				evt.Subtract("Inventory", 563)         -- "Talisman (broken)"
				evt.ForPlayer("Current")
				evt.Set("Inventory", 564)         -- "Talisman (repaired)"
				evt.SetMessage(782)         -- "What have we here?  Oh, I see.  This will be easy to fix.  [Iversen takes the talisman into the back room and returns in a few minutes]  There ya go, good as new!  Return this to Master Hume for your reward.  Here's your second teleportal key."
				evt.Set("Inventory", 669)         -- "Bracada Teleportal Key"
				evt.SetNPCTopic{NPC = 128, Index = 0, Event = 0}         -- "Douglas Iverson"
			else
				if evt.Cmp("QBits", 274) then         -- Courier Quest 1
					if evt.Cmp("Inventory", 772) then         -- "Unsigned Contract"
						evt.Subtract("Inventory", 772)         -- "Unsigned Contract"
						evt.ForPlayer("Current")
						evt.Set("Inventory", 773)         -- "Signed Contract"
						evt.SetMessage(745)         --[[ "The contract ... finally!  Here, let me look it over.  Looks good .. [Mortie signs the contract and returns it to you]  Return this contract to Taren with all haste.    Here's your first teleportal key.  It will save you some travel time in the delivery.

Oh, and a word about the Teleportal Hub.  The hub can take you to several locations.  Make sure that your party leader (active character) is equipped with only one key -that of your desired destination.  Otherwise you may be transported elsewhere."" ]]
						evt.Set("Inventory", 665)         -- "Tatalia Teleportal Key"
						evt.SetNPCTopic{NPC = 107, Index = 0, Event = 0}         -- "Mortie Ottin"
					else
						evt.SetMessage(746)         -- "Where's the contract?  Oh, sorry ... I mistook you for the couriers from Taren in Tatalia."
					end
				end
			end
		end
	end
end

-- "The Courier Guild"
evt.global[520] = function()
	evt.SetMessage(747)         --[[ "Welcome, adventurers!  I'm Sarah, the Founding Matron and Gran Mouma of the Courier Guild.  The Courier Guild consists of an elite company of Master Couriers who enjoy certain travel privileges throughout the remote areas of Erathia.   Membership to the guild is 500 gold, non-refundable.  With your initial membership, you become a Courier Initiate and receive the Home Key, which entitles you to use all Home Portals to return you to Steadwick.

To become a Master Courier, you must complete four courier assignments.  The completion of each assignment will provide you with (1) a 5000 gold delivery fee and (2) a unique teleportal key that activates the Teleportal Hub in Harmondale."" ]]
	evt.SetNPCTopic{NPC = 449, Index = 0, Event = 521}         -- "Sarah" : "Join the Guild"
end

-- "Join the Guild"
evt.global[521] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Gold", 500) then
		evt.Set("QBits", 273)         -- "Complete four Courier Guild missions."
		evt.ForPlayer("Current")
		evt.Subtract("Gold", 500)
		evt.Add("Inventory", 670)         -- "Home Key"
		evt.SetMessage(748)         -- "A wise decision on your part!  Here’s your Home Key.  Guard it carefully, because it is irreplaceable."
		evt.SetNPCTopic{NPC = 449, Index = 0, Event = 522}         -- "Sarah" : "Courier Assignment"
	else
		evt.SetMessage(125)         -- "You don't have enough gold!"
	end
end

-- "Courier Assignment"
evt.global[522] = function()
	evt.ForPlayer("All")
	if evt.Cmp("QBits", 281) then         -- Courier Quest 4 complete
		evt.SetMessage(10)         --[[ "Congratulations!  You’ve completed all four assignments in record time, just as the Erathian Festival of the Five Moons is ending!   You are now ready to join the ranks of our elite guild. I hereby promote you to the rank of Master Courier!  Welcome to the Guild! 

Now just one more thing.  Our couriers used to service the Evenmorn Islands. Unfortunately through a series of miss-haps, all keys to the island chain were lost, stolen, or destroyed.   If you ever come across one of these keys, please bring it back to me so that I can make a copy of it.  I will reward you handsomely in gold.  Good luck, Master Couriers!"" ]]
		evt.Subtract("QBits", 273)         -- "Complete four Courier Guild missions."
		evt.Subtract("QBits", 274)         -- Courier Quest 1
		evt.Subtract("QBits", 275)         -- Courier Quest 2
		evt.Subtract("QBits", 276)         -- Courier Quest 3
		evt.Subtract("QBits", 277)         -- Courier Quest 4
		evt.Subtract("QBits", 278)         -- Courier Quest 1 complete
		evt.Subtract("QBits", 279)         -- Courier Quest 2 complete
		evt.Subtract("QBits", 280)         -- Courier Quest 3 complete
		evt.Subtract("QBits", 281)         -- Courier Quest 4 complete
		evt.Subtract("QBits", 282)         -- Rena Quest
		evt.SetNPCTopic{NPC = 48, Index = 0, Event = 92}         -- "Thomas Grey" : "Wizard"
		evt.SetNPCTopic{NPC = 41, Index = 0, Event = 67}         -- "Steagal Snick" : "Warrior Mage"
		evt.SetNPCTopic{NPC = 50, Index = 0, Event = 98}         -- "Anthony Green" : "Great Druid"
		evt.SetNPCTopic{NPC = 43, Index = 0, Event = 73}         -- "Frederick Org" : "Cavalier"
		evt.SetNPCTopic{NPC = 45, Index = 0, Event = 79}         -- "Ebednezer Sower" : "Hunter"
		evt.SetNPCTopic{NPC = 38, Index = 1, Event = 58}         -- "Bartholomew Hume" : "Initiate"
		evt.Set("QBits", 283)         -- End of Festival
		evt.ForPlayer(0)
		evt.Add("Experience", 20000)
		evt.Add("Awards", 6)         -- "Promoted to Master Courier"
		evt.ForPlayer(1)
		evt.Add("Experience", 20000)
		evt.Add("Awards", 6)         -- "Promoted to Master Courier"
		evt.ForPlayer(2)
		evt.Add("Experience", 20000)
		evt.Add("Awards", 6)         -- "Promoted to Master Courier"
		evt.ForPlayer(3)
		evt.Add("Experience", 20000)
		evt.Add("Awards", 6)         -- "Promoted to Master Courier"
		evt.SetNPCTopic{NPC = 449, Index = 0, Event = 523}         -- "Sarah" : "Lost Key"
	else
		if evt.Cmp("QBits", 280) then         -- Courier Quest 3 complete
			evt.SetMessage(9)         --[[ "Now to your final assignment.  This one’s a bit tricky, I’m afraid, and somewhat dangerous.  In the mid-western region of Deja there is a small, unnamed village of four or five shanties.  Journey to this village and find Agatha Putnam.  She’ll provide details of your final delivery.  After you’ve completed this assignment, use the Deja Home Portal to return to me for your promotion to Master Courier. 

Oh!  And watch out for the hostiles in this area!  Good luck." ]]
			evt.SetNPCTopic{NPC = 209, Index = 0, Event = 518}         -- "Agatha Putnam" : "Courier Delivery"
			evt.SetNPCTopic{NPC = 399, Index = 0, Event = 519}         -- "Licia Rivenrock" : "Courier Delivery"
			evt.MoveNPC{NPC = 452, HouseId = 336}         -- "Rena Putnum Kedrin" -> "Kedrin Residence"
			evt.Set("QBits", 277)         -- Courier Quest 4
		else
			if evt.Cmp("QBits", 279) then         -- Courier Quest 2 complete
				evt.SetMessage(751)         -- "I see you are well on your way to Master Courier.  Good!  Your third delivery takes you to the town of Spaward in Avlee.  You need to locate Alice's Restaurant  (where you can get anything you want) and just ask Alice.  She'll brief you on the details of the delivery."
				evt.SetNPCTopic{NPC = 451, Index = 0, Event = 518}         -- "Alice the Chef" : "Courier Delivery"
				evt.SetNPCTopic{NPC = 442, Index = 0, Event = 519}         -- "Peni Pretty" : "Courier Delivery"
				evt.Set("QBits", 276)         -- Courier Quest 3
			else
				if evt.Cmp("QBits", 278) then         -- Courier Quest 1 complete
					evt.SetMessage(750)         -- "Good job on your first assignment!  For your next delivery, you must journey to the Bracada Desert and seek out Bartholomew Hume, the Roving Monk. You can normally find him near the Crystal Caravans.  He will provide you with details of the delivery. Bracada does have a Home Portal, in case you need to return here during your assignment.""
					evt.SetNPCTopic{NPC = 38, Index = 0, Event = 518}         -- "Bartholomew Hume" : "Courier Delivery"
					evt.SetNPCTopic{NPC = 128, Index = 0, Event = 519}         -- "Douglas Iverson" : "Courier Delivery"
					evt.Set("QBits", 275)         -- Courier Quest 2
				else
					evt.SetMessage(749)         -- "Your first assignment takes you to Tatalia.  When you arrive, seek out Taren.  He will provide you with details of the delivery.  Tatalia does have a Home Portal, in case you need to return here during your assignment."
					evt.MoveNPC{NPC = 241, HouseId = 410}         -- "Taren the Lifter" -> "Taren's House"
					evt.SetNPCTopic{NPC = 107, Index = 0, Event = 519}         -- "Mortie Ottin" : "Courier Delivery"
					evt.Set("QBits", 274)         -- Courier Quest 1
				end
			end
		end
	end
end

-- "Lost Key"
evt.global[523] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 668) then         -- "Evenmorn Teleportal Key"
		evt.SetMessage(11)         -- "I see you’ve recovered the Evenmorn key.  Great!  This is indeed a good day for The Guild!  Let me make a copy of the key.  Here’s your reward, as promised."
		evt.ForPlayer("Current")
		evt.Add("Gold", 10000)
		evt.SetNPCTopic{NPC = 449, Index = 0, Event = 0}         -- "Sarah"
	else
		evt.SetMessage(779)         -- "Please continue to search for the Evenmorn Key."
	end
end

-- "Purchase 50 food for 500 gold"
evt.global[524] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Gold", 500) then
		evt.SetMessage(125)         -- "You don't have enough gold!"
	else
		if evt.Cmp("Food", 50) then
			evt.SetMessage(39)         -- "Your packs are full!"
		else
			evt.ForPlayer("Current")
			evt.Subtract("Gold", 500)
			evt.Set("Food", 50)
		end
	end
end

-- "I feel Pretty!"
evt.global[525] = function()
	evt.SetMessage(789)         --[[ "I feel pretty, oh so pretty.  I feel pretty .. and witty .. and gay!  And I pity any girl that's in need today. Tra-la-la-la-la-la-lala!! 

I feel stunning,oh so stunning.  Feel like running and jumping for joy!  ....." ]]
end

-- "Promotions"
evt.global[526] = function()
	evt.SetMessage(16)         -- "Sorry, promotions are not available during the Festival of the Five Moons.  Come back after the holidays."
end

-- "Boat Schedule"
evt.global[527] = function()
	evt.SetMessage(752)         -- "You can charter a boat from this port to Erathia on Tuesdays, Thursdays and Saturdays. Boats for the Bracada Desert leave on Mondays and Wednesdays. Boats leave for Avlee on Friday only. If you have completed the Priest quest you can charter a boat to Evenmorn Island on Sundays."
end

-- "Nighon Tunnel"
evt.global[528] = function()
	evt.SetMessage(753)         -- "If you are looking to make it quickly to Nighon through the tunnels below, you should take the left fork of the Nighon Tunnel.  Many have taken the right fork and have never been heard from again.  Then again they may have made it to Nighon only to be taken by the Warlocks!"
end

-- "Harmodale Teleportal Hub"
evt.global[529] = function()
	if evt.Cmp("Inventory", 664) then         -- "Emerald Is. Teleportal Key"
		evt.SetMessage(774)         -- "I see you have the Emerald Island teleportal key.  You cannot use this key in the Harmondale Hub.  It only works at the teleport platform north of the Crystal Caravan."
	else
		evt.SetMessage(754)         -- "The well in this area is a Teleportal Hub used by the Courier Guild. The hub can take you to Bracada, Evenmorn Islands, Deja, Tatalia, and Avlee.  The keys required to use the hub are only issued to guild members in good standing.  The guild's main office is in Steadwick (Erathia proper), accross the way from the Griffin's Rest."
	end
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
	else
		if evt.Cmp("CurrentMight", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 31)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Endurance"
evt.global[543] = function()
	if evt.Cmp("PlayerBits", 32) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentEndurance", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 32)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Intellect"
evt.global[544] = function()
	if evt.Cmp("PlayerBits", 33) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentIntellect", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 33)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Personality"
evt.global[545] = function()
	if evt.Cmp("PlayerBits", 34) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentPersonality", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 34)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Accuracy"
evt.global[546] = function()
	if evt.Cmp("PlayerBits", 35) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentAccuracy", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 35)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Speed"
evt.global[547] = function()
	if evt.Cmp("PlayerBits", 36) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentSpeed", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 36)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Game of Luck"
evt.global[548] = function()
	if evt.Cmp("PlayerBits", 37) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentLuck", 25) then
			evt.Add("SkillPoints", 3)
			evt.StatusText(761)         -- "You win!  +3 Skill Points"
			evt.Set("PlayerBits", 37)
		else
			evt.StatusText(756)         -- "You have failed the game!"
		end
	end
end

-- "Contest of Might"
evt.global[549] = function()
	if evt.Cmp("PlayerBits", 38) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentMight", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 38)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Endurance"
evt.global[550] = function()
	if evt.Cmp("PlayerBits", 39) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentEndurance", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 39)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Intellect"
evt.global[551] = function()
	if evt.Cmp("PlayerBits", 40) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentIntellect", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 40)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Personality"
evt.global[552] = function()
	if evt.Cmp("PlayerBits", 41) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentPersonality", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 41)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Accuracy"
evt.global[553] = function()
	if evt.Cmp("PlayerBits", 42) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentAccuracy", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 42)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Speed"
evt.global[554] = function()
	if evt.Cmp("PlayerBits", 43) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentSpeed", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 43)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Contest of Luck"
evt.global[555] = function()
	if evt.Cmp("PlayerBits", 44) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentLuck", 50) then
			evt.Add("SkillPoints", 5)
			evt.StatusText(762)         -- "You win!  +5 Skill Points"
			evt.Set("PlayerBits", 44)
		else
			evt.StatusText(757)         -- "You have failed the contest!"
		end
	end
end

-- "Test of Might"
evt.global[556] = function()
	if evt.Cmp("PlayerBits", 45) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentMight", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 45)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Endurance"
evt.global[557] = function()
	if evt.Cmp("PlayerBits", 46) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentEndurance", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 46)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Intellect"
evt.global[558] = function()
	if evt.Cmp("PlayerBits", 47) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentIntellect", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 47)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Personality"
evt.global[559] = function()
	if evt.Cmp("PlayerBits", 48) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentPersonality", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 48)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Accuracy"
evt.global[560] = function()
	if evt.Cmp("PlayerBits", 49) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentAccuracy", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 49)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Speed"
evt.global[561] = function()
	if evt.Cmp("PlayerBits", 50) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentSpeed", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 50)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Test of Luck"
evt.global[562] = function()
	if evt.Cmp("PlayerBits", 51) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentLuck", 100) then
			evt.Add("SkillPoints", 7)
			evt.StatusText(763)         -- "You win!  +7 Skill Points"
			evt.Set("PlayerBits", 51)
		else
			evt.StatusText(758)         -- "You have failed the test!"
		end
	end
end

-- "Challenge of Might"
evt.global[563] = function()
	if evt.Cmp("PlayerBits", 52) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentMight", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 52)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Endurance"
evt.global[564] = function()
	if evt.Cmp("PlayerBits", 53) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentEndurance", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 53)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Intellect"
evt.global[565] = function()
	if evt.Cmp("PlayerBits", 54) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentIntellect", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 54)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Personality"
evt.global[566] = function()
	if evt.Cmp("PlayerBits", 55) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentPersonality", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 55)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Accuracy"
evt.global[567] = function()
	if evt.Cmp("PlayerBits", 56) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentAccuracy", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 56)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Speed"
evt.global[568] = function()
	if evt.Cmp("PlayerBits", 57) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentSpeed", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 57)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
	end
end

-- "Challenge of Luck"
evt.global[569] = function()
	if evt.Cmp("PlayerBits", 58) then
		evt.StatusText(760)         -- "You have already won!"
	else
		if evt.Cmp("CurrentLuck", 200) then
			evt.Add("SkillPoints", 10)
			evt.StatusText(764)         -- "You win!  +10 Skill Points"
			evt.Set("PlayerBits", 58)
		else
			evt.StatusText(759)         -- "You have failed the challenge!"
		end
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

-- "SAVE you Game!"
evt.global[571] = function()
	evt.SetMessage(766)         -- "Because of the dangers that you are about to face, it would be a good idea to SAVE your Game.  If anything goes 'wrong', you can always reload your SAVED Game.  Just a word to the wise."
end

-- "Challenges"
evt.global[572] = function()
	evt.SetMessage(767)         -- "Scattered around the land are the Challenges.  If your ability is great enough, and you best the challenge, you will be award skill points to do with as you wish!"
end

-- "We've found the Lost Scroll!"
evt.global[573] = function()
	evt.ForPlayer("All")
	if not evt.Cmp("Inventory", 738) then         -- "Lost Scroll of Wonka"
		evt.SetMessage(768)         -- "You must bring the Lost Scroll of Wonka to me to collect your reward."
		return
	end
	evt.SetMessage(769)         --[[ "“Well I’ll be … ya found the Lost Scroll! <he he> I guess it’s not lost anymore, huh!  [smile]  Excuse me for a moment while I verify the authenticity.

Blayze retires to a back room.  In a few moments he begins an incantation in slow, guttural tones.

‘Oooompa … Looompa … Looompidi Dooo, I’ve got some arcane magic for you’.  Blayze repeats this phrase several times, increasing the intoning speed  with each utterance.  Building to a fever pitch, he commands  ‘Come forth ye Everlasting Gobstopper!  Come forth now!!!’

Blaze returns from the back room, chewing gum and popping bubbles, a broad smile on his face.  Yep, that’s it.  Well done adventurers!!  As promised, here’s your reward.”" ]]
	evt.ForPlayer(3)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 72)
	end
	evt.ForPlayer(2)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 72)
	end
	evt.ForPlayer(1)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 72)
	end
	evt.ForPlayer(0)
	if evt.Cmp("FireSkill", 1) then
		evt.Set("FireSkill", 49152)
		evt.Set("FireSkill", 72)
	end
	evt.ForPlayer("All")
	evt.Subtract("QBits", 272)         -- "Find the Lost Scroll of Wonka and return it to Blayze on Emerald Island."
	evt.Subtract("Inventory", 738)         -- "Lost Scroll of Wonka"
	evt.Add("Awards", 87)         -- "Recovered the Lost Scroll of  Wonka"
	evt.SetNPCTopic{NPC = 139, Index = 1, Event = 0}         -- "Blayze "
	evt.Add("Experience", 40000)
end

-- "Promotion to Water Magic Master"
evt.global[574] = function()
	evt.ForPlayer("All")
	if evt.Cmp("Inventory", 559) then         -- "Watcher's Ring of Elemental Water"
		evt.SetMessage(772)         -- "I see that you've returned with the Watcher's Ring of Elemental Water. Good!    Use the power of this ring wisely, my students in the pursuit of Truth, Justice, and the Erathian Way!  Now I can promote you to Master level  if  you are already an Expert  with a skill of at least '7'  and have been promoted in your chosen profession..  Oh, and my fee is 4000  gold.  Gotta make a living, you know."
		evt.Add("Experience", 30000)
		evt.SetNPCTopic{NPC = 144, Index = 0, Event = 243}         -- "Tobren Rainshield" : "Water Magic Master"
		return
	end
	if not evt.Cmp("Inventory", 326) then         -- "Water Walk"
		evt.ForPlayer("Current")
		evt.Set("Inventory", 326)         -- "Water Walk"
	end
	evt.SetMessage(771)         -- "Before I can promote you to Master of Water Magic, you must prove yourself worthy.  Retrieve the Watcher's Ring of Elemental Water and return it to me.  The Ring is guarded by a powerful Sylph who lives on an island west of Spaward in the Bay of Avlee"
end

-- "The Greatest Hero"
evt.global[575] = function()
	evt.StatusText(47)         --[[ "Sir BunGleau, Baron of Post Lost, was the greatest Hero in Erathia's history.  So great were his deeds and so noble his demeanor that the Saints of Selinas offered him a shiny panoply endowed with boons beyond measure.  But the humble knight refused their offer, remarking that he could not, in good conscience, wear such a flamboyant display of privilege.  So the Saints offered to enchant the armor with invisibility if he would but openly wear the gauntlets to signify their blessing upon him.  To this he agreed. 

When he retired, the Saints hid his armor and placed six scrolls about the countryside.  It is said that if the secret of these scrolls is unlocked, it will reveal the location of a map indicating where this treasure may be found.  " ]]
	evt.SetNPCGreeting{NPC = 450, Greeting = 10}         -- "Messenger of the Saints" : "Greetings again, friends."
	evt.SetNPCTopic{NPC = 450, Index = 0, Event = 51}         -- "Messenger of the Saints" : "Crusader"
end

