local TXT = Localize{
	[0] = " ",
	[1] = "Door",
	[2] = "Storage Container",
	[3] = "Computer Terminal",
	[4] = "It's a short circuit!",
	[5] = "The door won't budge.",
	[6] = "Control Center",
	[7] = "Exit",
	[8] = "",
	[9] = "",
	[10] = "",
	[11] = "Hello and welcome to this self-guided tour of the Varn Planetary Control Facility.  We gladly welcome all visitors.  As you arrive at each key area, be sure to check any of our display screens for more information.  Enjoy your tour!",
	[12] = "This is the main equipment storage and repair facility.  By now, you may have noticed several floating Drone-bots.  They are responsible both for maintaining the key systems of this facility as well as sanitation.  If a unit becomes damaged, it is brought here to be repaired.",
	[13] = "The room to your left is the main meeting hall.  Visiting dignitaries from around the world have feasted at banquets held in their honor.  In fact, it is said that at his 21st birthday party King Sheridan nearly choked to death on a piece of mogred, but was saved by a serving girl who he later married and made his Queen.  Ahh, l�amour.",
	[14] = "Chief Engineer Wilson�s Personal Log.  I have locked myself in Storage Room #6 but currently have no means of escape.  The drone-bots have gone mad and have started killing everyone in sight.  I was able to access the main control terminal on Level Four despite warnings of a hazardous leak, and I sent a distress signal, but since we have not had contact with any of the colonies for several weeks, I do not believe that a rescue is possible.  I have also managed to seal this facility so that the drones can not escape.  It is my hope that the colonists will be able to mount some sort of defense by the time my encryption codes are broken.  Tell Emma I love her.  Wilson out.",
	[15] = "We apologize for any inconvenience, but we ask that all personnel evacuate the facility at this time.  Please do not be alarmed.  Thank you.",
	[16] = "Before entering the Planetary Reaction Chamber, please request a pair of Safety Goggles from one of our Drones.  During peak hours of operation, this facility can generate enough power to produce a light bright enough to be seen from space.  Please avoid looking directly into the light.",
	[17] = "Alert, environmental controls are offline on Level Four, Sections 18 through 96.  Access restricted to drones until further notice.",
	[18] = "Warning, intruder alert, Level Four, Section.  All drones proceed to Level Four to intercept intruders.  Reactor is offline.  Encryption integrity at 2.064%.  Warning, intruder alert, Level Four�",
	[19] = "Blaster weapons provide an effective, accurate ranged attack.  To operate the blaster, hold the grip comfortably in your hand, point the barrel at your target, and gently squeeze the trigger.  Should the weapon misfire, do not look into the barrel- give the weapon to an instructor and let them fix the problem.  Never point a blaster at something you do not want to vaporize.",
}
table.copy(TXT, evt.str, true)

-- Deactivate all standard events
Game.MapEvtLines.Count = 0


evt.map[1] = function()  -- function events.LoadMap()
	evt.ForPlayer("All")
	evt.Set("Eradicated", 0)
end

events.LoadMap = evt.map[1].last

