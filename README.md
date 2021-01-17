MMExtension
===

About
---

MMExtension is a rich modding environment for MM6-8. It features a level editor, uses Lua scripting language, lets you use all commands of internal M&M scripts language (Evt commands) and lets you do a lot of other things.

Setup
---

You can use one Git-synchronized version of MMExtension across all MM games. Here's how:

- Install latest versions of my patches. GrayFace patch version 2.1+ is required.

- In mm6.ini/mm7.ini/mm8.ini add these lines:

```ini
[ExeMods]
MMExtension=(path to the repository)\ExeMods\MMExtension.dll
```

- Make sure your game folder doesn't contain copies of MMExtension scripts and ExeMods\MMExtension.dll.

Now you can run the game. This is a convenient development environment with some scripts made for developers like GodMode.lua or FindHelper.lua, as well as keeping a small history of console logs (you'll find more old logs in Recycle Bin).

Once you decide to release your mod, you can get a stand-alone version of MMExtension to distribute with it in one of two ways:

- Download the latest release, which can be outdated, but better tested.

- Run Build() from the console of any game. Build\MMExtension\ folder inside of MMExtension home folder would be generated with only those scripts that should be distributed to end users.
