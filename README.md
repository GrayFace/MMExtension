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

Now you can run the game.
