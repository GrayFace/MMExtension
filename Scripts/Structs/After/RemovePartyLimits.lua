local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local mmv = |...| (select(mmver - 5, ...))
local mm78 = |...| (select(mmver - 6, ...))


-- extend Game.PlayerFaces


local ResizeFaces = ||;
local function HookLoadedFaces()
	local p = mem.StaticAlloc(4)
	i4[p] = mmv(12, 25-1, 30)*4
	ResizeFaces = mem.ExtendGameStructure{
		Ptr = mmv(0x4D479C, 0x50758C, 0x518E40),
		Limit = mmv(12, 25, 30),
		Size = 4,
		Refs = mmv(
			{0x450F76, 0x450F8D, 0x450FAA, 0x450FC7, 0x451EBD},
			{0x495C5D, 0x495C78, 0x495C93, 0x495CAE, 0x496AE9},
			{0x4C4E94, 0x4C559A}
		),
		SizeRefs = {p},
	}
	-- allow up to 256 faces
	HookManager{p = p}.asmhook2(mmv(0x451EAE, 0x496ADB, 0x4C559E), [[
		mmdef reg, edi, ecx, edi
		cmp reg, [%p%]
	]])
end

mem.ExtendGameStructure{'PlayerFaces',
	Size = 4,
	Refs = mmv(
		{0x451E83, 0x486422, 0x48A50B},
		{0x491CE3, 0x491DF4, 0x496AAC},
		{0x4908F4, 0x4909C6, 0x4C5565}
	),
	CustomOnce = {HookLoadedFaces},
	Custom = {|n| ResizeFaces(n, true)},
}


-- remove skills list limits


if mmver > 6 then
	mem.ExtendGameStructure{'ArmorSkills',
		Size = 4, BaseStruct = Game.DialogLogic,
		Refs = mm78(
			{0x419544, 0x419BF5},
			{0x4194BD, 0x419F17}
		),
		EndRefs = mm78(
			{0x4195A4, 0x419D71},
			{0x419735, 0x419F44}
		),
	}

	mem.ExtendGameStructure{'WeaponSkills',
		Size = 4, BaseStruct = Game.DialogLogic,
		Refs = mm78(
			{0x419444, 0x419806},
			{0x418D70, 0x419E4B}
		),
		EndRefs = mm78(
			{0x4194B4, 0x41997D},
			{0x418FE8, 0x419E78}
		),
	}

	mem.ExtendGameStructure{'MiscSkills',
		Size = 4, BaseStruct = Game.DialogLogic,
		Refs = mm78(
			{0x4195C1, 0x419DFC},
			{0x419860}
		),
		EndRefs = mm78(
			{0x41961D, 0x419F6A},
			{0x419AD8}
		),
	}

	mem.ExtendGameStructure{'MagicSkills',
		Size = 4, BaseStruct = Game.DialogLogic,
		Refs = mm78(
			{0x4194D1, 0x419A02},
			{0x419113}
		),
		EndRefs = mm78(
			{0x419531, 0x419B6D},
			{0x419395}
		),
	}
end
