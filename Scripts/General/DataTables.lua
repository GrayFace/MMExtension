-- Config:

local BinFolder = "DataFiles/"

-- /Config

BinFolder = path.addslash(BinFolder)
local mmver = Game.Version

local UpdateMode
local TimesTable = {}
local timebuf = mem.StaticAlloc(8)

local function SetFileTime(fname, time1, time2)
	mem.u4[timebuf] = time1
	mem.u4[timebuf + 4] = time2
	local kernel32 = mem.dll.kernel32
	-- fname, FILE_WRITE_ATTRIBUTES, all share flags, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nil
	local h = kernel32.CreateFileA(fname, 0x0100, 7, 0, 3, 0x80, 0)
	kernel32.SetFileTime(h, 0, 0, timebuf)
	kernel32.CloseHandle(h)
end

local function FixFileTimes()
	for _, t in ipairs(TimesTable) do
		SetFileTime(unpack(t))
	end
	TimesTable = {}
end

local function DataTable(name, f, checkBin, VeryLazy)
	local nameTxt = DataTables.Files[name] or "Data/Tables/"..name..'.txt'
	local nameBin = BinFolder.."d"..name..'.bin'
	local dir, old = path.dir(nameTxt), errorinfo()
	errorinfo('file "'..nameTxt..'"')
	if dir == '' then
		if nameTxt ~= '' then
			f(Game.LoadTextFileFromLod(nameTxt))
		end
		errorinfo(old)
		return
	elseif VeryLazy and not path.FindFirst(nameTxt) and not path.FindFirst(nameBin) then
		errorinfo(old)
		return
	end
	local time1, time2
	if not UpdateMode then
		for _, a in path.find(nameTxt) do
			time1, time2 = a.LastWriteTimeLow, a.LastWriteTimeHigh
		end
	end
	if not time1 and not UpdateMode and DataTables.LazyMode then
		-- do nothing
	elseif not time1 then
		os.mkdir(dir)
		if name == 'SFT' then
			mem.dll.user32.ClipCursor(0)
			MessageBox("MMExtension is about to generate text tables for binary files. This will take a few minutes. On the next run of the game you will also experience a small delay.")
		end
		io.save(nameTxt, f())
	else
		if checkBin then
			for _, a in path.find(nameBin) do
				local t1, t2 = a.LastWriteTimeLow, a.LastWriteTimeHigh
				time1 = (time2 ~= t2 or time1 ~= t1) and time1
			end
		end
		if time1 then
			if name == 'SFT' then
				mem.dll.user32.ClipCursor(0)
			end
			f(io.load(nameTxt))
			if checkBin then
				TimesTable[#TimesTable + 1] = {nameBin, time1, time2}
			end
			errorinfo(old)
			return true
		end
	end
	errorinfo(old)
end

local function SaveBin(name, t)
	os.mkdir(BinFolder)
	io.save(BinFolder.."d"..name..".bin", DataTables.ToBin(t))
	FixFileTimes()
end

local function update()
	local sameSFT = true
	DataTable('Class HP SP', DataTables.HPSP)
	if mmver ~= 6 then
		DataTable('Class Skills', DataTables.Skills)
	end
	DataTable('Class Starting Skills', DataTables.StartingSkills)
	DataTable('Class Starting Stats', DataTables.StartingStats)
	DataTable('House Movies', DataTables.HouseMovies)
	if DataTable('SFT', DataTables.SFTBin, true) then
		sameSFT = false
		DataTables.UpdateSFTGroups()
		io.save(BinFolder.."dsft.bin", DataTables.STFToBin())
		FixFileTimes()
	end
	if DataTable('DecList', DataTables.DecListBin, sameSFT) then
		SaveBin('declist', Game.DecListBin)
	end
	if DataTable('PFT', DataTables.PFTBin, true) then
		DataTables.UpdatePFTGroups()
		SaveBin('pft', Game.PFTBin)
	end
	if DataTable('IFT', DataTables.IFTBin, true) then
		DataTables.UpdateIFTGroups()
		SaveBin('ift', Game.IFTBin)
	end
	if DataTable('TFT', DataTables.TFTBin, true) then
		DataTables.UpdateTFTGroups()
		SaveBin('tft', Game.TFTBin)
	end
	if DataTable('Chest', DataTables.ChestBin, true) then
		SaveBin('chest', Game.ChestBin)
	end
	if DataTable('Overlay', DataTables.OverlayBin, sameSFT, mmver > 6) then
		SaveBin('overlay', Game.OverlayBin)
	end
	if DataTable('ObjList', DataTables.ObjListBin, sameSFT) then
		SaveBin('objlist', Game.ObjListBin)
	end
	if DataTable('MonList', DataTables.MonListBin, sameSFT) then
		SaveBin('monlist', Game.MonListBin)
	end
	if DataTable('Sounds', DataTables.SoundsBin, true) then
		SaveBin('sounds', Game.SoundsBin)
	end
	if DataTable('Tile', DataTables.TileBin, true) then
		SaveBin('tile', Game.TileBin)
	end
	if mmver == 8 then
		if DataTable('Tile2', DataTables.Tile2Bin, true) then
			SaveBin('tile2', Game.Tile2Bin)
		end
		if DataTable('Tile3', DataTables.Tile3Bin, true) then
			SaveBin('tile3', Game.Tile3Bin)
		end
	end
	if mmver > 6 then
		DataTable('Monster Kinds', DataTables.MonsterKinds)
	end
	-- DataTable('Player Animations', DataTables.PlayerAnimations)
	DataTable('Shops', DataTables.Shops)
	for s, f in pairs(DataTables.Handlers) do
		DataTable(s, f)
	end
	events.DataTablesUpdate1(DataTable)
	FixFileTimes()  -- just to be sure
end

local function update2()
	DataTable('Town Portal', DataTables.TownPortal)
	DataTable('Spells2', DataTables.Spells2)
	DataTable('Transport Index', DataTables.TransportIndex)
	DataTable('Transport Locations', DataTables.TransportLocations)
	for s, f in pairs(DataTables.Handlers2) do
		DataTable(s, f)
	end
	events.DataTablesUpdate2(DataTable)
	FixFileTimes()  -- just to be sure
	events.DataTablesLoaded()
end

function events.GameInitialized1()
	update()
end

function events.GameInitialized2()
	update2()
	UpdateMode = true
end

function UpdateDataTables()
	update()
	if UpdateMode then
		update2()
	end
end

function ReloadDataTables()
	local old = UpdateMode
	UpdateMode = nil
	update()
	if old then
		update2()
	end
	UpdateMode = old
end
