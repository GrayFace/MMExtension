local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local mmv = |...| (select(mmver - 5, ...))
local mm78 = |...| mmv(nil, ...)
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil

-- if mmver ~= 81 then  return  end

-- extend Game.AwardsTxt

mem.ExtendGameStructure{'AwardsTxt', is78 and 'AwardsSort', Size = mmv(4, 8, 8),
	Refs = mmv(
		{0x415194, 0x416434, 0x41FDEC, 0x420284, 0x467FCB, 0x48A04B;  0x46803F},  -- 0x46803F is the read limit
		{0x41910B, 0x41919D, 0x4191A4, 0x41A14A, 0x41A1F7, 0x44A887, 0x44B222, 0x47642E, 0x4956EC},
		{0x418A01, 0x418A93, 0x418A9A, 0x41A132, 0x41A1B3, 0x447E9C, 0x4487CB, 0x475514, 0x4939F0}
	),
}

-- extend Player.Awards

if mmver == 6 then
	return  -- not for MM6 for now
end

local PAwardsCount
local function HookAwards()
	PAwardsCount = mem.StaticAlloc(4)
	local hooks = HookManager{p = PAwardsCount}
	hooks.asmpatch(mm78(0x419138, 0x418A2E), [[
		cmp ebx, [%p%]
		jl absolute mm7*0x419108 + mm8*0x4189FE
	]])
	
	if is7 then
		-- patch places that work with bits directly instead of calling CheckBit
		local hooks = HookManager{check = 0x449B7A, off = 0x152}
		local patch2 = |p, p2, code| hooks.asmpatch(p, code, p2 - p)
		-- cmp
		patch2(0x449D87, 0x449DA5, [[
			mov edx, eax
			lea ecx, [esi + %off%]
			call absolute %check%
			mov cl, 0xff
		]])
		-- set
		patch2(0x44A876, 0x44A87F, [[
			mov edx, [ebp + 0xC]
			lea ecx, [eax + %off%]
			call absolute %check%
			test al, al
		]])
		-- add
		patch2(0x44B205, 0x44B21A, [[
			movsx edx, word [ebp + 0xC]
			add ecx, %off%
			call absolute %check%
			test al, al
		]])
	end
end

local t = {
	CustomOnce = {HookAwards},
	Custom = {|n| do
		Game.AwardsTxt.SetHigh(n)
		i4[PAwardsCount] = min(n, 500)  -- limited by Game.DialogLogic.List, 500 should be enough for everything
		assert(n <= 500, 'attempt to use over 500 awards')
	end},
}

for i, a in Party.PlayersArray do
	t[i + 1] = a.Awards
end

local resize_bits = mem.ExtendBitsArray(t)

mem.autohook(mm78(0x476425, 0x47550A), function(d)
	local n = DataTables.ComputeRowCountInPChar(d.eax, 1, 1)
	resize_bits(n - 1)
	mem.prot(true)
	i4[mm78(0x4764B7, 0x47559C)] = Game.AwardsTxt['?ptr'] + 8*n
	mem.prot(false)
end)
