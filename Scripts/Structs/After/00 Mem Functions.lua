local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1

local function Process(t, d)
	for _, p in ipairs(t) do
		u4[p] = u4[p] + d
	end
end

local function ChangeGameArray(name, p, count)
	structs.o.GameStructure[name] = p
	internal.SetArrayUpval(Game[name], "o", p)
	internal.SetArrayUpval(Game[name], "count", count)
end
mem.ChangeGameArray = ChangeGameArray

function mem.ExtendGameStructure(t)
	local name, size, refs, countRefs, endRefs = t[1], t.Size or {}, t.Refs or {}, t.CountRefs or {}, t.EndRefs or {}
	local ptr, count, limit
	local function Resize(newCount, canShrink)
		local a = Game[name]
		local OldCount = count or a.limit
		if newCount == OldCount or newCount < OldCount and not canShrink then
			return
		end
		count = newCount
		mem.prot(true)
		local dp = 0
		if count > (limit or OldCount) then
			local old = ptr or a['?ptr']
			ptr = mem.reallocMM(old, size*OldCount, size*count, not ptr)
			limit, dp = count, ptr - old
			Process(refs or {}, dp)
		end
		Process(countRefs or {}, count - OldCount)
		Process(endRefs or {}, dp + (count - OldCount)*size)
		mem.prot(false)
		ChangeGameArray(name, ptr, count)
	end
	local function SetHigh(newMax, canShrink)
		Resize(newMax - Game[name].low + 1, canShrink)
	end
	rawset(Game[name], 'SetHigh', SetHigh)
	rawset(Game[name], 'Resize', Resize)
end
