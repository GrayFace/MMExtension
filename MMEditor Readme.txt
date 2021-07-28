MMEditor v2.2
By Sergey Rozhenko <mailto:sergroj@mail.ru>
https://sites.google.com/site/sergroj/

Requires: versions 2.2 of my patch and MMExtension or higher + windowed mode + preferrably Hardware 3D (indoors).
Level geometry is made in 3D modelling software and imported into the game. One major limitation of MM engine is that textures can't be rotated, stretched or even flipped. I am thinking of patching it in the future to add support for any such transformation (any affine transformation).

Keys:
Alt+F1      	Activate editor / go back to game mode
Ctrl+S      	Save
Ctrl+O      	Open
Ctrl+Z      	Undo (note that whole map .obj import can't be undone)
Ctrl+Shift+Z	Redo (also Ctrl+Y)
WASD        	Movement (hold Shift to move twice as fast, Double Speed mode of the patch also works)
Mouse Wheel 	Move up/down
M           	Map
X           	Unselect
E           	Edit properties
Space       	Indoor: Switch door state (same as double-clicking the Door State button)
            	Outdoor: Switch between facet mode and model mode.
Q           	Door properties
R           	Room properties
T           	Choose Texture / Type of object / Test chest
C           	Create / Clone object
Delete      	Delete object / chest
P           	Move object to party position (and set its direction to direction of the party)
L           	Land object on the ground
Arrows      	Move object (hold Alt to do it in smaller steps or Ctrl for larger steps)
Page Up/Down	Move object up/down
Ctrl        	If you hold Ctrl while clicking Select Same Texture or Select Same Object outdoors, facets of all models would be selected rather than just the current one. Ctrl and Shift affect selecting things with the mouse in standard way.

Import:
Import As Objects - every object or group in .obj is marked as a separate object. Only done for Select Object button.
Import As Rooms - each object or group in .obj becomes a room. Rooms are connected via portals which can be created automatically or manually. Automatic mode is used for rooms which have no manual portals connecting them with other rooms.
When using automatic mode: Make sure your dungeon doesn't have furniture etc. as separate objects in it. Create a plane separating a future room from the rest of the dungeon, split the dungeon with the plane (to get 2 objects), then delete the plane. Continue the process...
Here's how you can create portals manually in case you need to: Connected rooms preferably should be connected through a single portal. A portal is a facet with texture "_Portal_", present in only one of the 2 rooms. Note that you cannot use triangulation in export setup of your 3D software.
You can also assign "_Invisible_" texture to facets that should become invisible when imported.
Rooms improve performance significantly, but more importantly the minimap is opened room-by-room. My advise is to postpone breaking the dungeon into rooms until it's pretty much done.
Import can't be undone with Undo button. However, when importing models to an outdoor map and choosing to delete models not present in the .obj, you can then undo the deletion.


Spawns:
"m1" / "m2" / "m3" - a group of monsters of type 1 / 2 / 3 (see MapStats.txt)
"m1a" / "m1b" / "m1c" - a single weak / average / strong monster of type 1
Similar with "m2a", "m3a" etc.
"i1".."i7" - item level 1 (.. item level 7). Level 7 is artifact. Other levels are then modified according to location level in MapStats.txt. Map level is the maximum resulting item level. So, resulting level of "i6" item always equals map level.

Chests:
Info example:
1/2/3/4/5/6 A7 C8 - means 1 level 1 item, ..., 6 level 6 items, 7 artifacts, 8 custom items. See the note about location level in MapStats.txt in Spawns section.

Map Setup:
OutlineFlatSkip - from 0 to 1 (default is 0.9, game default is 1). Set lower value to ignore more outlines between almost flat facets.
