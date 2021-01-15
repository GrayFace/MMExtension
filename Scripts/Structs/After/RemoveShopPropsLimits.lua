local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local mmv = |...| select(mmver - 5, ...)
local mm78 = |...| select(mmver - 6, ...)
local Extend = mem.ExtendGameStructure
local ExtendAndSave = mem.ExtendAndSaveGameStructure

-- To check that all manual addresses are fine:
-- local function Extend(t)
-- 	for _, p in ipairs(t.Refs) do
-- 		print(('%x'):format(mem.u4[p]))
-- 	end
-- end

-- To check arrays individually (not changed for ExtendAndSave):
-- local done = {}
-- local Extend = function(t)
-- 	t.Custom = nil
-- 	for _, p in ipairs(t.Refs or {}) do
-- 		assert(not done[p], ('%X'):format(p))
-- 		done[p] = true
-- 	end
-- 	for _, p in ipairs(t.CountRefs or {}) do
-- 		assert(not done[p], ('%X'):format(p))
-- 		done[p] = true
-- 	end
-- 	return Extend(t)
-- end


local ShopLim = mem.StaticAlloc(4*6)
local TheftLim = ShopLim + 4*5
i4[ShopLim] = 0
i4[TheftLim] = 53
local lims = {'ShopWeaponKinds', 'ShopArmorKinds', 'ShopMagicLevels', mmver == 6 and 'GeneralStoreItemKinds' or 'ShopAlchemistLevels'}
local function UpdateShopLim(i)
	local s = lims[i]
	i4[ShopLim + 4*i] = min(Game[s].high, Game[s..'Special'].high) + 1
end
UpdateShopLim(1)
UpdateShopLim(2)
UpdateShopLim(3)
UpdateShopLim(4)

local UpdateTheft = |s| mmver > 6 and (|| Game.ShopTheftExpireTime.SetHigh(Game[s].high)) or nil
local UpdateRefill = |s| || Game.ShopNextRefill.SetHigh(Game[s].high)
local UpdateShopItems = |i| Game.ShopItems.SetHigh(Game[lims[i]].high)
local UpdateShopSpecialItems = |i| Game.ShopSpecialItems.SetHigh(Game[lims[i]..'Special'].high)

local function PatchShops()
	local jumpsT = mmv(
		{0x49FCBB, 0x49FB72, 0x49FBB1, 0x49FC01, 0x49FC1C;  0x49FEBB, 0x49FD72, 0x49FDB1, 0x49FE01, 0x49FE1C},
		{0x4B8E8F, 0x4B8DCC, 0x4B8DFC, 0x4B8E3B, 0x4B8E4C;  0x4B9005, 0x4B8F27, 0x4B8F57, 0x4B8F9B, 0x4B8FB0},
		{0x4B7487, 0x4B7328, 0x4B735D, 0x4B739E, 0x4B73BC;  0x4B75C3, 0x4B74E6, 0x4B7514, 0x4B755A, 0x4B756F}
	)
	local buf = mem.StaticAlloc(4*11)
	for i, v in ipairs(jumpsT) do
		u4[buf + i*4] = v
	end
	
	local function patch(p, len, reg, jumps, p2, len2, cmd2)
		local hooks = HookManager{
			kind = reg,
			house = mmv('eax', 'esi', 'esi'),
			lim = ShopLim,
			jumps = jumps,
			buf = buf,
			cmd2 = mmv('jl', 'jle', 'jle'),
		}
		hooks.asmhook2(p, [[
			mov dword [%buf%], 0
			cmp %kind%, 4
			ja @f
			cmp %house%, [%lim% + %kind%*4]
			jge @f
			mov dword [%buf%], %kind%
		@@:
		]], len)
		hooks.asmhook2(p2, [[
			%cmd2% @f
			mov %kind%, [%buf%]
			jmp dword [%jumps% + %kind%*4]
		@@:
		]], len2)
	end
	
	patch(mmv(0x49FB65, 0x4B8DBF, 0x4B7316), 7,            mmv('edx', 'ecx', 'ecx'), buf + 4,       mmv(0x49FC16, 0x4B8E47, 0x4B73B6), mmv(0, 3, 0))
	patch(mmv(0x49FD65, 0x4B8F1C, 0x4B74DB), mmv(7, 5, 5), mmv('edx', 'eax', 'eax'), buf + 4 + 4*5, mmv(0x49FE16, 0x4B8FAA, 0x4B7569), 0)
end



ExtendAndSave{'ShopItems',
	Refs = mmv(
		{0x41F462, 0x47D1FE, 0x4960A8, 0x49A895, 0x49AA1C, 0x49AAAE, 0x49AB6D, 0x49FC81, 0x49FC9B, 0x49FCD6, 0x49FD04, 0x4A0335, 0x4A04BC, 0x4A0559, 0x4A1448, 0x4A15CF, 0x4A1661, 0x4A1D65, 0x4A1EED, 0x4A1F81, 0x4A4988, 0x4A4A1D, 0x4A5285},
		
		{0x4B574A, 0x4B5804, 0x4B5A3D, 0x4B5B4F, 0x4B6A0E, 0x4B8E5D, 0x4B8E7A, 0x4B8E9B, 0x4B8EC0, 0x4B985C, 0x4B998F, 0x4B9AA1, 0x4BA2EB, 0x4BA3A7, 0x4BA5E9, 0x4BA6FB, 0x4BB099, 0x4BB22B, 0x4BB341, 0x4BD5D4, 0x4BD65C, 0x4BDFF1},
		
		{0x4B02A8, 0x4B4194, 0x4B424F, 0x4B4490, 0x4B4572, 0x4B73CD, 0x4B73EA, 0x4B7410, 0x4B743F, 0x4B7468, 0x4B747F, 0x4B7E04, 0x4B7F3B, 0x4B801D, 0x4B885B, 0x4B8918, 0x4B8B68, 0x4B8C4A, 0x4B9599, 0x4B9748, 0x4B982A, 0x4BB081, 0x4BB10D, 0x4BBC26}
	),
	Custom = {UpdateRefill'ShopItems', UpdateTheft'ShopItems'},
	-- ItemNumRefs = mmv({0x47D207-4}, {}, {}),
}

ExtendAndSave{'ShopSpecialItems',
	Refs = mmv(
		{0x47D223, 0x496143, 0x49B416, 0x49B478, 0x49B50A, 0x49B6BF, 0x49FE81, 0x49FE9B, 0x49FED6, 0x49FF04, 0x4A0DB8, 0x4A0E1A, 0x4A0EB7, 0x4A2802, 0x4A2865, 0x4A28F9, 0x4A47E4, 0x4A487D, 0x4A50CC},
		{0x4B1AB1, 0x4B58B5, 0x4B596F, 0x4B5A62, 0x4B5B58, 0x4B8FC2, 0x4B8FF4, 0x4B9012, 0x4B903B, 0x4B98EE, 0x4B99B4, 0x4B9AAA, 0x4BA462, 0x4BA51B, 0x4BA60E, 0x4BA704, 0x4BB15B, 0x4BB250, 0x4BB34A, 0x4BB50A, 0x4BB59C, 0x4BB614, 0x4BD6C0, 0x4BD748, 0x4BDFFD},
		{0x4B02B1, 0x4B4301, 0x4B43BC, 0x4B44BB, 0x4B457B, 0x4B7580, 0x4B75B2, 0x4B75D1, 0x4B75FA, 0x4B7E97, 0x4B7F66, 0x4B8026, 0x4B89D7, 0x4B8A94, 0x4B8B93, 0x4B8C53, 0x4B9668, 0x4B9773, 0x4B9833, 0x4B99E6, 0x4B9A6F, 0x4B9AFD, 0x4BB16F, 0x4BB1FB, 0x4BBC32}
	),
	Custom = {UpdateRefill'ShopSpecialItems', UpdateTheft'ShopSpecialItems'},
}

ExtendAndSave{'GuildItems',
	Refs = mmv(
		{0x47D247, 0x495FDF, 0x49BC6B, 0x49BDE6, 0x49BE76, 0x49BEEE, 0x4A441B, 0x4A443F, 0x4A46D4, 0x4A4F46},
		{0x4B1A24, 0x4B5EF3, 0x4B5F68, 0x4B5FDC, 0x4B60A0, 0x4BC92A, 0x4BC949, 0x4BC95C, 0x4BD364, 0x4BDEC3},
		{0x4B0224, 0x4B482C, 0x4B48CD, 0x4B4969, 0x4B4A32, 0x4BA95E, 0x4BB319, 0x4BBB0B}
	),
	Custom = {|| Game.GuildNextRefill.SetHigh(Game.GuildItems.high)},
}

ExtendAndSave{'ShopNextRefill', Size = 8,
	Refs = mmv(
		{0x49A8C9, 0x49A8D2, 0x4A0369, 0x4A0372, 0x4A147C, 0x4A1485, 0x4A1D99, 0x4A1DA2, 0x4A4735, 0x4A473C, 0x4A47A6, 0x4A47AD, 0x4A48D9, 0x4A48E0, 0x4A494A, 0x4A4951},
		{0x4B5AC3, 0x4B5AD0, 0x4B9A15, 0x4B9A22, 0x4BA66F, 0x4BA67C, 0x4BB2B1, 0x4BB2BE, 0x4BD52E, 0x4BD53F, 0x4BD598, 0x4BD59F},
		{0x4B44E7, 0x4B44F4, 0x4B7F92, 0x4B7F9F, 0x4B8BBF, 0x4B8BCC, 0x4B979F, 0x4B97AC, 0x4BAFDE, 0x4BAFEF, 0x4BB048, 0x4BB04F}
	),
	CustomOnce = {PatchShops},
}

ExtendAndSave{'GuildNextRefill', Size = 8,
	Refs = mmv(
		{0x49BC86, 0x49BC93, 0x4A463C, 0x4A4643, 0x4A46A8, 0x4A46AF},
		{0x4B601E, 0x4B602B, 0x4BD2E5, 0x4BD2F6, 0x4BD343, 0x4BD34A},
		{0x4B49A4, 0x4B49B1, 0x4BB294, 0x4BB2A5, 0x4BB2F3, 0x4BB2FA}
	),
}

if mmver > 6 then
	local PatchPlaces = mm78(
		{0x4158E7, 0x41591E, 0x4463A7, jumps = {0x4160A3, 0x4160A3, 0x4463E8}, reg = {'eax', 'eax', 'esi'}},
		{0x414D3D, 0x414D74, 0x4431C9, jumps = {0x41556C, 0x41556C, 0x44320A}, reg = {'eax', 'eax', 'eax'}}
	)
	local patch = || for i, p in ipairs(PatchPlaces) do
		HookManager{
			buf = TheftLim,
			jmp = PatchPlaces.jumps[i],
			reg = PatchPlaces.reg[i],
		}.asmpatch(p, [[
			cmp %reg%, [%buf%]
			jge %jmp%
		]])
	end
	
	ExtendAndSave{'ShopTheftExpireTime', Size = 8,
		Refs = mm78(
			{0x4158F3, 0x4158FA, 0x41592A, 0x415931, 0x4463AF, 0x4B140A, 0x4B1411, 0x4B1CDC, 0x4B1CED},
			{0x414D49, 0x414D50, 0x414D80, 0x414D87, 0x4431D1, 0x4B0510, 0x4B0525}
		),
		CountRefs = {TheftLim},
		CustomOnce = {patch},
	}
end

Extend{'ShopWeaponKinds',
	Refs = mmv({0x49FB7D-4, 0x49FBA7-4}, {0x4B8DDA-4, 0x4B8DF2-4}, {0x4B7333-4, 0x4B734E-4}),
	Custom = {|| UpdateShopLim(1), || UpdateShopItems(1)},
}
Extend{'ShopWeaponKindsSpecial',
	Refs = mmv({0x49FD7D-4, 0x49FDA7-4}, {0x4B8F35-4, 0x4B8F4D-4}, {0x4B74F1-4, 0x4B750C-4}),
	Custom = {|| UpdateShopLim(1), || UpdateShopSpecialItems(1)},
}

Extend{'ShopArmorKinds',
	Refs = mmv({0x49FBCA-4, 0x49FBF7-4}, {0x4B8E18-4, 0x4B8E34-4}, {0x4B7377-4, 0x4B7392-4}),
	Custom = {|| UpdateShopLim(2), || UpdateShopItems(2)},
}
Extend{'ShopArmorKindsSpecial',
	Refs = mmv({0x49FDCA-4, 0x49FDF7-4}, {0x4B8F75-4, 0x4B8F94-4}, {0x4B7531-4, 0x4B7553-4}),
	Custom = {|| UpdateShopLim(2), || UpdateShopSpecialItems(2)},
}

Extend{'ShopMagicLevels', Size = 2,
	Refs = mmv({0x49FC09-4}, {0x4B8E43-4}, {0x4B73A6-4}),
	Custom = {|| UpdateShopLim(3), || UpdateShopItems(3)},
}
Extend{'ShopMagicLevelsSpecial', Size = 2,
	Refs = mmv({0x49FE09-4}, {0x4B8FA3-4}, {0x4B7562-4}),
	Custom = {|| UpdateShopLim(3), || UpdateShopSpecialItems(3)},
}

if mmver > 6 then
	Extend{'ShopAlchemistLevels', Size = 2,
		Refs = mm78({0x4B8E8C-4}, {0x4B73FF-4}),
		Custom = {|| UpdateShopLim(4), || UpdateShopItems(4)},
	}
	Extend{'ShopAlchemistLevelsSpecial', Size = 2,
		Refs = mm78({0x4B9002-4}, {0x4B75C0-4}),
		Custom = {|| UpdateShopLim(4), || UpdateShopSpecialItems(4)},
	}
else
	Extend{'GeneralStoreItemKinds',
		Refs = {0x49FC3C-4, 0x49FC5C-4},
		Custom = {|| UpdateShopLim(4), || UpdateShopItems(4)},
	}
	Extend{'GeneralStoreItemKindsSpecial',
		Refs = {0x49FE3C-4, 0x49FE5C-4},
		Custom = {|| UpdateShopLim(4), || UpdateShopSpecialItems(4)},
	}
end

Extend{'GuildSpellLevels', Size = 2,
	Refs = mmv({0x4A4379-4, 0x4A43EE-4}, {0x4BC89D-4, 0x4BC8DA-4}, {0x4BA93A-4}),
	Custom = {|| Game.GuildItems.SetHigh(Game.GuildSpellLevels.high)}
}

Extend{'TrainingLevels', Size = 2,
	Refs = mmv({0x499DE9}, {0x4B4704, 0x4BCAB4}, {0x4B314B, 0x4B324A, 0x4BAAEC}),
}

Extend{'TransportIndex',
	Refs = mmv({0x49CDA8, 0x49D13E, 0x49D700, 0x4A44EF}, {0x4B6855, 0x4B69B2, 0x4B6CD4, 0x4BCC2F}, {0x4B50CF, 0x4B518F, 0x4B5589, 0x4BAB6E}), 
	CountRefs = mmv({0x43C76B-4}, {0x4465D2}, {0x443492-4}),
}

Extend{'TransportLocations',
	Refs = mmv(
		{0x49CDC7, 0x49CDD1, 0x49D17D, 0x49D192, 0x49D1E3, 0x49D719, 0x4A4504},
		{0x4B6871, 0x4B687A, 0x4B69C3, 0x4B6D08, 0x4B6D1E, 0x4B6D67, 0x4B6DD6, 0x4BCC42},
		{0x4B50EB, 0x4B50F4, 0x4B5198, 0x4B55C0, 0x4B55D6, 0x4B561F, 0x4B563E, 0x4BAB84}
	),
	Fill = 0,
}

local function StructsArray(arr, offs, tabl)
	tabl = tabl or {}
	return function(str)
		return DataTables.StructsArray(arr, offs, table.copy(tabl, {Resisable = true, IgnoreFields = {SFTIndex = true, Bits = true}, IgnoreRead = {['#'] = true}}, true), str)
	end
end

local DoTransportIndex = DataTables.TransportIndex

function DataTables.TransportIndex(str)
	if str then
		local n = DataTables.ComputeRowCountInPChar(mem.topointer(str), 2) - 1
		Game.TransportIndex.Resize(n, true)  -- shrink when needed
	end
	return DoTransportIndex(str)
end

local DoTransportLocations = DataTables.TransportLocations

function DataTables.TransportLocations(str)
	if str then
		local n = DataTables.ComputeRowCountInPChar(mem.topointer(str), 2) - 1
		Game.TransportLocations.Resize(n, true)  -- shrink when needed
	end
	return DoTransportLocations(str)
end
