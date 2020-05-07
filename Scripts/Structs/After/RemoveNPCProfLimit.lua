local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

if mmver ~= 7 then
	return  -- only for MM7 for now
end

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local OldCount, NewCount = mmv(78, 59), nil

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

mem.autohook(mmv(nil, 0x477167), function(d)
	NewCount = DataTables.ComputeRowCountInPChar(d.eax, 3, mmv(4, 3)) - 3
	if NewCount == OldCount then
		return
	end
	
	-- set new read limit
	
	mem.IgnoreProtection(true)

	if mmver == 7 then
		Process({0x477196-4, 0x477265-4}, NewCount - OldCount)
	else
	end

	if NewCount <= OldCount then
		return mem.IgnoreProtection(false)
	end

	-- extend the arrays
	local ptr
	if mmver == 7 then
		ptr = Extend(0x737AA8, 0x14, {0x416B8F, 0x416BA3, 0x420CAB, 0x44536E, 0x44551D, 0x445526, 0x445548, 0x4455A7, 0x4455B0, 0x49597F, 0x4B1FE5, 0x4B228F, 0x4B2298, 0x4B22ED, 0x4B2367, 0x4B3DDC, 0x4B4104, 0x4BC680, 0x477189-4}, nil, 'fill')
	else
	end

	local ptr
	if mmver == 7 then
		ptr = Extend(0x73C110, 4, {0x416C79, 0x41E9DD, 0x445488, 0x4B2B10})
	else
	end
	mem.IgnoreProtection(false)
	ChangeGameArray("NPCProfNames", ptr)
	
	-- load names from NPCProf.txt
	local t = mem.string(d.eax):split('\r\n', true)
	for i = 1, NewCount - 1 do
		Game.NPCProfNames[i] = t[i + 4]:match('\t([^\t]*)')
	end
end)
