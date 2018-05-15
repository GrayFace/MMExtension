-- since editor LODs aren't in the Data folder of the game, load them manually
local LoadCustomLod = mem.dll["mm"..Game.Version.."patch"].LoadCustomLod

function events.GameInitialized1()
	LoadCustomLod(Game.BitmapsLod["?ptr"], DevPath.."Data\\editor.bitmaps.lod")
	LoadCustomLod(Game.IconsLod["?ptr"], DevPath.."Data\\editor.icons.lod")
	LoadCustomLod(Game.SpritesLod["?ptr"], DevPath.."Data\\editor.sprites.lod")
end
