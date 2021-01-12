-- Config:

local BinFolder = "DataFiles/"

-- /Config

BinFolder = path.addslash(BinFolder)

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

local function DataTable(name, f, checkBin)
	nameTxt = DataTables.Files[name] or "Data/Tables/"..name..'.txt'
	local dir = path.dir(nameTxt)
	errorinfo('file "'..nameTxt..'"')
	if dir == '' then
		if nameTxt ~= '' then
			f(Game.LoadTextFileFromLod(nameTxt))
		end
		errorinfo('')
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
			for _, a in path.find(BinFolder.."d"..name..'.bin') do
				local t1, t2 = a.LastWriteTimeLow, a.LastWriteTimeHigh
				time1 = (time2 ~= t2 or time1 ~= t1) and time1
			end
		end
		if time1 then
			if name == 'SFT' then
				mem.dll.user32.ClipCursor(0)
			end
			f(io.load(nameTxt))
			errorinfo('')
			if checkBin then
				TimesTable[#TimesTable + 1] = {BinFolder.."d"..name..'.bin', time1, time2}
			end
			return true
		end
	end
	errorinfo('')
end

local function StructsArray(arr, offs, tabl)
	tabl = tabl or {}
	return function(str)
		return DataTables.StructsArray(arr, offs, table.copy(tabl, {Resisable = true, IgnoreFields = {SFTIndex = true, Bits = true}, IgnoreRead = {['#'] = true}}, true), str)
	end
end

local function NameHeader(hdr, arr)
	for i, a in arr do
		hdr[i] = ("%s  %s"):format(i, a.Name)
	end
	return hdr
end

local function SaveBin(name, t)
	os.mkdir(BinFolder)
	io.save(BinFolder.."d"..name..".bin", DataTables.ToBin(t))
	FixFileTimes()
end

local function update()
	local sameSFT = true
	DataTable('Class HP SP', DataTables.HPSP)
	if Game.Version ~= 6 then
		DataTable('Class Skills', DataTables.Skills)
	end
	DataTable('Class Starting Skills', DataTables.StartingSkills)
	DataTable('Class Starting Stats', DataTables.StartingStats)
	DataTable('House Movies', DataTables.HouseMovies)
	local FtIgnore = {TotalTime = true, NotGroupEnd = true, Bits = true, SpriteIndex = true, PaletteIndex = true, IconIndex = true, Index = true, Loaded = true}
	local FtIgnoreRead = Game.Version == 6 and {Images3 = true, Glow = true, Transparent = true} or nil
	if DataTable('SFT', StructsArray(Game.SFTBin.Frames, structs.o.SFTItem, {IgnoreFields = FtIgnore, IgnoreRead = FtIgnoreRead}), true) then
		sameSFT = false
		DataTables.UpdateSFTGroups()
		io.save(BinFolder.."dsft.bin", DataTables.STFToBin())
		FixFileTimes()
	end
	if DataTable('DecList', StructsArray(Game.DecListBin, nil), sameSFT) then
		SaveBin('declist', Game.DecListBin)
	end
	if DataTable('PFT', StructsArray(Game.PFTBin, nil, {NoRowHeaders = true, IgnoreFields = FtIgnore}), true) then
		DataTables.UpdatePFTGroups()
		SaveBin('pft', Game.PFTBin)
	end
	if DataTable('IFT', StructsArray(Game.IFTBin, nil, {IgnoreFields = FtIgnore}), true) then
		DataTables.UpdateIFTGroups()
		SaveBin('ift', Game.IFTBin)
	end
	if DataTable('TFT', StructsArray(Game.TFTBin, nil, {NoRowHeaders = true, IgnoreFields = FtIgnore}), true) then
		DataTables.UpdateTFTGroups()
		SaveBin('tft', Game.TFTBin)
	end
	if DataTable('Chest', StructsArray(Game.ChestBin, nil), true) then
		SaveBin('chest', Game.ChestBin)
	end
	if DataTable('Overlay', StructsArray(Game.OverlayBin, nil, {NoRowHeaders = true}), sameSFT) then
		SaveBin('overlay', Game.OverlayBin)
	end
	local param = {NoRowHeaders = true, IgnoreFields = {SFTIndex = true, Bits = true, LoadedParticlesColor = true}}
	if DataTable('ObjList', StructsArray(Game.ObjListBin, nil, param), sameSFT) then
		SaveBin('objlist', Game.ObjListBin)
	end
	if DataTable('MonList', StructsArray(Game.MonListBin, nil, {IgnoreFields = {Tint = true}}), sameSFT) then
		SaveBin('monlist', Game.MonListBin)
	end
	local param = {NoRowHeaders = true, IgnoreFields = {Locked = true, Bits = true, Data3D = true, Decompressed = true},
	               Alias = {Type = {system = 1, swap = 2, lock = 4}}}
	if DataTable('Sounds', StructsArray(Game.SoundsBin, nil, param), true) then
		SaveBin('sounds', Game.SoundsBin)
	end
	if DataTable('Tile', StructsArray(Game.TileBin, nil, {IgnoreFields = {Bits = true, Bitmap = true}}), true) then
		SaveBin('tile', Game.TileBin)
	end
	if Game.Version == 8 then
		if DataTable('Tile2', StructsArray(Game.Tile2Bin, nil, {IgnoreFields = {Bits = true, Bitmap = true}}), true) then
			SaveBin('tile2', Game.Tile2Bin)
		end
		if DataTable('Tile3', StructsArray(Game.Tile3Bin, nil, {IgnoreFields = {Bits = true, Bitmap = true}}), true) then
			SaveBin('tile3', Game.Tile3Bin)
		end
	end
	if Game.Version > 6 then
		local hdr = NameHeader({[-1] = "Monster"}, Game.MonListBin)
		DataTable('Monster Kinds', StructsArray(Game.MonsterKinds, nil, {Resisable = false, RowHeaders = hdr}))
	end
	-- DataTable('Player Animations', StructsArray(Game.PlayerAnimations, nil, {Resisable = false, IgnoreFields = {Sounds = true, Expressions = true}}))
	DataTable('Shop Props', DataTables.ShopProps)
	events.DataTablesUpdate1(DataTable)
	FixFileTimes()  -- just to be sure
end

local function update2()
	DataTable('Town Portal', DataTables.TownPortal)
	do  -- Spells2
		local hdr = NameHeader({[-1] = "Spell"}, Game.SpellsTxt)
		local is6 = (Game.Version == 6) or nil
		DataTable('Spells2', StructsArray(Game.Spells, nil, {Resisable = false, RowHeaders = hdr, IgnoreFields = 
		          {CastByMonster = true, CastByEvent = true, CauseDamage = true, SpecialDamage = true, Bits = true,
		           SpellPointsNormal = is6, SpellPointsExpert = is6, SpellPointsMaster = is6}}))
	end
	DataTable('Transport Index', StructsArray(Game.TransportIndex, {[1] = 1, [2] = 2, [3] = 3, [4] = Game.Version > 6 and 4 or nil},
		{Resisable = false, RowHeaders = {[Game.TransportIndex.low - 1] = "2D Event"}}))
	DataTable('Transport Locations', StructsArray(Game.TransportLocations, nil,
		{Resisable = false, IgnoreFields = {MapIndex = true}}))
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
