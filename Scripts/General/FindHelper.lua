local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, i8, u8 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.i8, mem.u8
local format = string.format

local function DoFR(p, p1, start, stop, sz)
	p1 = p1 or p + 1
	local q = {{}, {}, {}}
	local a = sz == 4 and u4 or sz == 2 and u2 or sz == 1 and u1

	local last, kind
	local store = || if last then
		local t = q[kind]
		t[#t+1] = format("0x%X", last)
	end
	
	local good = start or 0x401000
	for i = good, (stop or select(Game.Version - 5, 0x4B9000, 0x4D8000, 0x508000)) do
		local n, IsJump, _ = mem.GetInstructionSize(i)
		if sz == 4 then
			_, IsJump = mem.GetHookSize(i)
		end
		if not IsJump then
			local op = u1[i]
			for j = i + 1, i + n - sz do
				local v = a[j]
				if v >= p and v < p1 then
					local knd = i ~= good and 3 or op == 0x68 and 2 or 1  -- put "push XXX" in q[2], probably wrong ones in q[3]
					if j ~= last then
						store()
						last, kind = j, knd
					elseif knd < kind then
						kind = knd
					end
				end
			end
		end
		if i == good then
			good = good + n
		end
	end
	store()
	return "Ref{"..table.concat(q[1], ", ").."}", "RefPush{"..table.concat(q[2], ", ").."}", "RefSus{"..table.concat(q[3], ", ").."}"
end


FR = |p, p1, start, stop| DoFR(p, p1, start, stop, 4)
FR1 = |p, p1, start, stop| DoFR(p, p1, start, stop, 1)


--[=[

-- Find array refs:
local a = Game.ItemsTxt
print(FR(a.?ptr - a[1].?size, a.?ptr))
print(FR(a.?ptr, a[a.High].?ptr))
print(FR(a[a.High].?ptr, a[a.High].?ptr + a[1].?size*2))

-- Find all function calls:
local need = 0x402CAE
local str = [[    (p: $%X; old: $402CAE; newp: @FastCosX; t: RShtCall; Querry: hqSmoothMouseLook), // Smooth mouse look]]
local t = {}

local p = 0x401000
local stop = select(Game.Version - 5, 0x4B9000, 0x4D8000, 0x508000)
while true do
	p = mem.findcall(p, need, stop)
	if p then
		print(str:format(p))
	else
		break
	end
	p = p + 5
end

-- Find series of AddButton calls preceeded by certain parameters (for player portraits):
local need = 0x41D0D8
local str = [[    (p: $%X; old: $41D0D8; newp: @FixPortraitHeight; t: RShtCallBefore), // Fix incorrect player portraits area size]]
local t = {}

local c1, c2, c3, c4

local p = 0x401000
local stop = select(Game.Version - 5, 0x4B9000, 0x4D8000, 0x508000)
while true do
	p = mem.findcall(p, need, stop)
	if not p then
		break
	else
		c1, c2, c3, c4, p = c2, c3, c4, p, p + 5
	end
	if c1 and c4 - c1 < 0x200 and mem.findcode(c3, "\x68\x97\1\0\0", c4) and mem.findcode(c2, "\x68\x24\1\0\0", c3) and mem.findcode(c1, "\x68\xB1\0\0\0", c2) then
		print(str:format(c1))
		print(str:format(c2))
		print(str:format(c3))
		print(str:format(c4))
	end
end
]=]
