local i4, i2, i1, u4, u2, u1, i8, u8 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.i8, mem.u8
local format = string.format

function FR(p, p1, start, stop)
	p1 = p1 or p + 1
	local t = {}
	local t1 = {}

	local last
	for i = (start or 0x401000), (stop or select(Game.Version - 5, 0x4B9000, 0x4D8000, 0x508000)) do
		local n = mem.GetInstructionSize(i)
		local _, IsJump = mem.GetHookSize(i)
		if not IsJump then
			local op = u1[i]
			for i = i + 1, i + n - 4 do
				local v = u4[i]
				if v >= p and v < p1 then
					if i ~= last then
						local t = (op ~= 0x68 and t or t1)  -- put "push XXX" in t1
						t[#t+1], last = format("0x%X", i), i
					end
				end
			end
		end
	end	
	return "Ref{".._G.table.concat(t, ", ").."}", "Ref{".._G.table.concat(t1, ", ").."}"
end

function FR1(p, p1, start, stop)
	p1 = p1 or p + 1
	local t = {}
	local t1 = {}

	local last
	for i = (start or 0x401000), (stop or select(Game.Version - 5, 0x4B9000, 0x4D8000, 0x508000)) do
		local n, IsJump = mem.GetInstructionSize(i)
		if not IsJump then
			local op = u1[i]
			for i = i + 1, i + n - 1 do
				local v = u1[i]
				if v >= p and v < p1 then
					if i ~= last then
						local t = (op ~= 0x68 and t or t1)  -- put "push XXX" in t1
						t[#t+1], last = format("0x%X", i), i
					end
				end
			end
		end
	end	
	return "Ref{".._G.table.concat(t, ", ").."}", "Ref{".._G.table.concat(t1, ", ").."}"
end

--[=[-- Find all function calls:
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
