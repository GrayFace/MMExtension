local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

if mmver ~= 7 then
	return  -- only for MM7
end

local OldCount, NewCount = 196, 256

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

mem.IgnoreProtection(true)

Process({0x41264C-4, 0x41382B-4}, NewCount - OldCount)
Extend(0x723598, 8, {0x412656, 0x412665, 0x4137DC, 0x4137F1, 0x41392B, 0x44ACE1, 0x44ACFC, 0x44B6A6, 0x44B6C4, 0x476797}, {0x47689D})

mem.IgnoreProtection(false)
