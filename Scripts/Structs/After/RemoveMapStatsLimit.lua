local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

-- Note that im MM7 you must also increase number of columns in NPCDist.txt accordingly

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local OldCount, NewCount = mmv(68, 77, 77), nil

local function Process(t, d)
	for _, p in ipairs(t) do
		u4[p] = u4[p] + d
	end
end

local function Extend(p, size, t, tend, extraSize)
	local esize = tonumber(extraSize) or 0
	local new = mem.StaticAlloc(size*NewCount + esize)
	mem.copy(new, p, size*min(OldCount, NewCount) + esize)
	if extraSize == 'fill' then
		for i = OldCount, NewCount - 1 do
			mem.copy(new + i*size, p, size)
		end
	end
	Process(t, new - p)
	if tend then
		Process(tend, new - p + (NewCount - OldCount)*size)
	end
	return new
end

local function ChangeGameArray(name, p, count)
	structs.o.GameStructure[name] = p
	internal.SetArrayUpval(Game[name], "o", p)
	internal.SetArrayUpval(Game[name], "count", count or NewCount)
end

mem.autohook(mmv(0x4466F7, 0x453FD1, 0x45173B), function(d)
	NewCount = DataTables.ComputeRowCountInPChar(d.eax, mmv(26, 30, 30), 3) - 2
	if NewCount == OldCount then
		return
	end
	
	-- set new read limit
	
	mem.IgnoreProtection(true)

	if mmver == 6 then
		Process({0x446724+4, 0x446B5C+6}, NewCount - OldCount)
		OldCount = 100
		Process({0x446717+6}, NewCount - OldCount)
	elseif mmver == 7 then
		mem.asmpatch(0x454747, ([[
			cmp ebx, %s
			jl absolute 0x453FF4
		]]):format(NewCount))
	else
		mem.asmpatch(0x451EB1, ([[
			cmp ebx, %s
			jl absolute 0x45175E
		]]):format(NewCount))
	end

	if NewCount <= OldCount then
		return mem.IgnoreProtection(false)
	end

	-- extend the array
	local ptr, door, fog

	if mmver == 6 then
		
		door = Extend(0x4C3B74, 2, {0x45552C, 0x455541, 0x4603F0}, nil, 'fill')  -- door sounds
		
		ptr = Extend(0x55F628, 56,
			{0x40CAC1, 0x40EB6E, 0x40EBB7, 0x40ED24, 0x40EFEB, 0x419BF8, 0x41E55A, 0x41E5C2, 0x425E48, 0x425EEB, 0x42C6DF, 0x42C71B, 0x42E07A, 0x42E0A2, 0x42E0C0, 0x42E0F3, 0x42E648, 0x42F049, 0x4309DF, 0x4309FC, 0x43A197, 0x43A1B5, 0x43A202, 0x43A221, 0x43A323, 0x43A3DA, 0x43A3EC, 0x43A403, 0x43A542, 0x43A566, 0x43A654, 0x43A683, 0x43A70D, 0x43A714, 0x43A7EE, 0x43EA25, 0x43EA71, 0x448F4A, 0x45022A, 0x450243, 0x454F97, 0x454FAE, 0x455330, 0x455349, 0x45631A, 0x456333, 0x469DC4, 0x469DDD, 0x48A175, 0x48A18E, 0x4972A4, 0x49830A, 0x499904, 0x40C857, 0x40C87B, 0x40CA55, 0x40CA75},
			{0x42C708},
			4
		)
		Process({0x446719, 0x446BD7, 0x446C02}, (NewCount - OldCount)*56) -- ignore 0x446B5E
		d.ebx = ptr
		
	elseif mmver == 7 then

		local old = OldCount
		OldCount = OldCount + 1
		door = Extend(0x4EFEC8, 2, {0x460CE9, 0x46F23F}, nil, 'fill')  -- door sounds
		OldCount = 16
		fog = Extend(0x4EC9B8, 4, {0x4894C6}, nil, 'fill')  -- fog chances
		OldCount = old
		
		ptr = Extend(0x5CAA38, 0x44,
			{0x410DBB, 0x410DCB, 0x410FB2, 0x413C39, 0x413C7A, 0x413D8F, 0x413F97, 0x41CC24, 0x42042E, 0x42045C, 0x42EC03, 0x42EC1C, 0x432F72, 0x43331B, 0x43349C, 0x4334B1, 0x4334CD, 0x4334FB, 0x4338D1, 0x433969, 0x433B9F, 0x433C1B, 0x4340A4, 0x4340D8, 0x438D72, 0x438E35, 0x438E4E, 0x444565, 0x444577, 0x44495D, 0x44496F, 0x4449C5, 0x4449D7, 0x444A8A, 0x444BCB, 0x444D38, 0x444D60, 0x444E05, 0x444F02, 0x444F80, 0x448D30, 0x448D7F, 0x45025C, 0x450275, 0x456DCA, 0x4603B0, 0x4603C7, 0x460B7F, 0x460B96, 0x46116E, 0x464945, 0x47A3EC, 0x47A404, 0x489482, 0x49594A, 0x49595C, 0x497F94, 0x4ABF59, 0x4ABF71, 0x4ABFC6, 0x4ABFE0, 0x4AC02A, 0x4AC0D1, 0x4B2A1F, 0x4B3518, 0x4B41EA, 0x4B69DF, 0x4B6A91, 0x4B6DE2, 0x4BE045, 0x4BE05A},
			{0x4340CD},
			4
		)
		Process({0x453FEC, 0x454752, 0x4547D9, 0x4547FE}, (NewCount - OldCount)*0x44)
		Process({0x433B8A}, NewCount - OldCount)
		d.esi = ptr
		mem.asmpatch(0x497F88, ([[
			cmp eax, %s
			jge absolute 0x497F84
		]]):format(NewCount))
		
		-- NPCDist.txt
		local p = Extend(0x73A594, 64, {0x476B62, 0x476BD9, 0x476C22, 0x4774F1, 0x47750A})
		
		mem.asmpatch(0x476BC1, ([[
			cmp ebx, %s
			jge absolute 0x476BDF
		]]):format(NewCount))
		
		mem.asmhook2(0x476BFC, ([[
			cmp ecx, %s
		]]):format(NewCount))

		mem.asmhook2(0x476C20, ([[
			mov dword [esp], %s
		]]):format(NewCount))
		
		-- NPCDist.txt - make caring of it unaccessory
		mem.asmhook(0x4774FB, [[
			test ebx, ebx
			jnz @std
			mov ecx, 56
			idiv ecx
			mov eax, edx
			cmp eax, 38-3
			jl @f
			inc eax
			cmp eax, 51-3
			jl @f
			inc eax
		@@:
			jmp absolute 0x477516
		@std:
		]])
	else

		local old = OldCount
		OldCount = OldCount + 1
		door = Extend(0x5004E8, 2, {0x447171, 0x45E5EA, 0x46DD17}, nil, 'fill')  -- door sounds
		OldCount = 16
		fog = Extend(0x4FC9EC, 4, {0x488DC8}, nil, 'fill')  -- fog chances
		OldCount = old
		
		ptr = Extend(0x5E6E00, 0x44,
			{0x4121C9, 0x4121DC, 0x41336B, 0x4133A7, 0x41C145, 0x41F926, 0x41F936, 0x4307E0, 0x430BBA, 0x430D3D, 0x430D60, 0x430D79, 0x430D9F, 0x431186, 0x43120F, 0x4313B6, 0x431433, 0x4319B0, 0x4319D0, 0x4367C7, 0x4367DF, 0x441440, 0x441452, 0x441886, 0x441898, 0x4418FA, 0x44190C, 0x441A16, 0x441B68, 0x441D48, 0x441E1E, 0x441E97, 0x446160, 0x446193, 0x44D984, 0x44D998, 0x454661, 0x45DE1A, 0x45DE28, 0x45E499, 0x45E4B0, 0x45EA89, 0x462C8C, 0x4795DE, 0x4795F6, 0x47E2CC, 0x488DA8, 0x493C17, 0x493C29, 0x4949AA, 0x4AA3ED, 0x4AA400, 0x4AA45A, 0x4AA474, 0x4AA4BE, 0x4AA565, 0x4B1232, 0x4B1E34, 0x4B2C94, 0x4B5290, 0x4B52F0, 0x4B5656, 0x4D1827},
			{0x4319C5},
			4
		)

		Process({0x451756, 0x451EBD, 0x451F43, 0x451F68}, (NewCount - OldCount)*0x44)
		Process({0x4313A8}, NewCount - OldCount)
		-- fix by Rodril
		mem.asmpatch(0x4949a0, ([[
			cmp eax, %s
			jge absolute 0x49499c
		]]):format(NewCount))
		d.esi = ptr
	end
	mem.IgnoreProtection(false)
	OldCount = NewCount
	
	ChangeGameArray("MapStats", ptr)
	internal.SetArrayUpval(Game.MapStats, "lenP", ptr + structs.MapStatsItem["?size"]*NewCount)
	
	ChangeGameArray("MapDoorSound", door)
	if fog then
		ChangeGameArray("MapFogChances", fog)
	end
end)
