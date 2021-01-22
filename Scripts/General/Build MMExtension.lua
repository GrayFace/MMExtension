-- Find new files, ask what to do with them
local function UpdateList()
	local ListFName = DevPath.."Scripts/Modules/Build Files List.lua"
	local ok, OldList = pcall(dofile, ListFName)
	OldList = ok and OldList or {}
	local list = {}

	local function Include(fname)
		local id = fname:replace(DevPath, ""):gsub("\\", "/")
		list[id] = list[id] or OldList[id] or (MessageBox("Include "..id.."?", "Build MMExtension", "confirm") == 1 and 1 or 0)
	end
	
	local function IncludeMask(mask)
		for f in path.find(mask) do
			Include(f)
		end
	end

	IncludeMask(DevPath.."Data/*")
	IncludeMask(DevPath.."Scripts/Core/*")
	IncludeMask(DevPath.."Scripts/General/*")
	IncludeMask(DevPath.."Scripts/Global/*")
	IncludeMask(DevPath.."Scripts/Modules/*")
	IncludeMask(DevPath.."Scripts/Structs/*")
	IncludeMask(DevPath.."Scripts/Structs/After/*")
	IncludeMask(DevPath.."ExeMods/*")
	IncludeMask(DevPath.."ExeMods/MMExtension/*")
	IncludeMask(DevPath.."*")

	local s = dump(list, nil, true)
	if s ~= dump(OldList, nil, true) then
		io.save(ListFName, "return "..s)
	end

	for id, b in pairs(list) do
		if b == 0 then
			list[id] = nil
		end
	end
	
	return list
end

local function CopyFile(id, folder)
	local new = DevPath.."Build/"..folder.."/"..id
	os.mkdir(path.dir(new))
	os.copy(DevPath..id, new, false)
end

-- avoid opening multiple consoles with each command by using a temporary bat file
local PackBat = [[
cd "%~dp0"
xcopy ..\Misc\KillObsolete "MMExtension" /E /I

cd "%~dp0\MMExtension"
mkdir Scripts\Global
mkdir Scripts\Modules
mkdir Scripts\Maps
]]..(path.FindFirst[[c:\Program Files\WinRAR\Rar.exe]] and [[
"c:\Program Files\WinRAR\Rar.exe" a -m5 -r ..\MMExtension.rar *

cd "%~dp0\MMEditor"
"c:\Program Files\WinRAR\Rar.exe" a -m5 -r ..\MMEditor.rar *

cd "%~dp0"
rmdir MMExtension /S /Q
rmdir MMEditor /S /Q
]] or 'cd "%~dp0"\n')..[[
del pack.bat
]]

-- Copy and pack files
function Build(...)
	local list = UpdateList()
	
	os.remove(DevPath.."Build", true)
	
	events.Build(...)
	
	for id in pairs(list) do
		if id:match("/[eE]ditor") or id:match("MMEditor") or id:match("Convert Blv") then
			CopyFile(id, "MMEditor")
		else
			CopyFile(id, "MMExtension")
		end
	end
	
	io.save(DevPath.."Build/pack.bat", PackBat)
	os.execute('"'..DevPath..'Build/pack.bat"')

	events.PostBuild(...)
	
	mem.dll.user32.MessageBeep(0x40)
end
