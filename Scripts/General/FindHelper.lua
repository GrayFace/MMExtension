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
