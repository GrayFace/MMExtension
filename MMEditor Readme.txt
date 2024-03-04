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
WASD        	Movement (hold Shift to move 3 times as fast, Double Speed mode of the patch also works)
Mouse Wheel 	Move up/down
M           	Map
X           	Unselect all
E           	Edit properties
Space       	Indoor: Switch door state (same as double-clicking the Door State button)
            	Outdoor: Switch between facet mode and model mode.
Q           	Door properties
R           	Room properties
T           	Choose Texture / Type of object / Test chest / Load model
C           	Create / Clone object
Delete      	Delete object / chest
P           	Move object to party position (and set its direction to direction of the party)
L           	Land object on the ground
Arrows      	Move object / Move texture cordinates (hold Alt to do it in smaller steps or Ctrl for larger steps)
Page Up/Down	Move object up/down
Ctrl        	If you hold Ctrl while clicking Select Same Texture or Select Same Object outdoors, facets of all models would be selected rather than just the current one. If you hold Ctrl while clicking New Door indoors, a more automated process would happen: The facets you've selected would be considered the moving part of the door, while adjacent facets would become part of the door; VertexFilter would be set to "Free", which works great in most cases. Otherwise, MovedByDoor=true is set for selected facets, no VertexFilter is set and no other facets become part of the door. See Doors section for more info.
Shift+Click 	Add to selection or remove from selection.

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
"i1".."i7" - item level 1 (.. item level 7). Level 7 is artifact. See "Treasure Levels" section.

Chests:
Info example:
1/2/3/4/5/6 A7 C8 - this means 1 level 1 item, ..., 6 level 6 items, 7 artifacts, 8 custom items. See "Treasure Levels" section.

Treasure Levels:
Treasure levels you specify for chest items or item spawns are modified according to location level in MapStats.txt (the "Tres" column). The following table is used with M# meaning map level and T# meaning treasure level of the item:
     M1   M2   M3   M4   M5   M6   M7
T1 [ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ][ 1 ]
T2 [ 1 ][1-2][ 2 ][ 2 ][ 2 ][ 2 ][ 2 ]
T3 [1-2][ 2 ][2-3][ 3 ][ 3 ][ 3 ][ 3 ]
T4 [ 2 ][ 2 ][ 3 ][3-4][ 4 ][ 4 ][ 4 ]
T5 [ 2 ][ 2 ][3-4][ 4 ][4-5][ 5 ][ 5 ]
T6 [ 2 ][ 2 ][ 4 ][4-5][ 5 ][5-6][ 6 ]
T7 [ 2 ][ 2 ][ 7 ][ 7 ][ 7 ][ 7 ][ 7 ]

Doors:
When modelling a door, think of how it will look on the minimap. If it moves into a wall of a hall, this would be visible to the player. That's why in all standard maps doors are continuations of walls.
When making the door interactive in the editor, it would be easier to first select its side that's perpendicular to its future movement direction and press New Door. The direction of the door would be set accordingly, but you may need to change its sign. Then select other sides and press Door Shape.
In D3D UV coordinates of moving parts of doors get reset, it's a limitation of the engine. Use Align* properties of such facets, as they are respected.
VertexFilter parameter determines how moving vertexes are chosen for the door:
"Free"       - Vertexes that aren't connected to any non-door walls would be moving.
nil          - All vertexes of facets with MovedByDoor attribute would be moving.
"Grow"       - Vertexes further along the door's direction axis would move, making it grow.
"Shrink"     - Vertexes from the other end would be chosen causing it to shrink.
"CheckShift" - You can see it on some MM6 maps. When other filters don't fit, this one is used. Currently there's no way to edit what vertexes are moved in this case. These vertexes have a hidden Shift parameter. You'll also see that the door is halfway closed when you export the dungeon.

"Grow" and "Shrink" filters also support VertexFilterParam1 and VertexFilterParam2 parameters. When you use "Grow" filter, VertexFilterParam1 is 0.5 by default, which means everything further than half of door's length will move. Lowering it would make more vertexes move. VertexFilterParam2 is the upper limit, unset by default. It can be useful in some scenarios. With "Shrink" filter it's the same logic, but door movement is in reverse direction.

Models:
When you select a facet on an outdoor map, pressing Space switches to/from model manipulation mode. You can move, land or save models in special format by pressing Save button.
Besides exporting and importing whole outdoor map, you can also import individual models. To do so, when nothing is selected choose Model and then click Type and choose the model file, then press Create. Besides standard OBJ import this allows you to load previously saved models in MDT format, which retains all setup, such as facet bits indicating water flowing in a fountain, event numbers etc. Which workflow to choose is up to you.
