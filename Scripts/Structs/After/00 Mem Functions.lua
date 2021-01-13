local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, prot = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.prot

local function BatchAdd(t, d)
	prot(true)
	for _, p in ipairs(t) do
		u4[p] = u4[p] + d
	end
	prot(false)
end
mem.BatchAdd = BatchAdd

local function ChangeGameArray(name, p, count, lenP)
	if p then
		structs.o.GameStructure[name] = p
		internal.SetArrayUpval(Game[name], "o", p)
	end
	if count then
		internal.SetArrayUpval(Game[name], "count", count)
	end
	if lenP then
		internal.SetArrayUpval(Game[name], "lenP", lenP)
	end
end
mem.ChangeGameArray = ChangeGameArray

function mem.ExtendGameStructure(t)
	local name, size, endSize, start = t[1], t.Size, t.EndSize or 0, t.StartSize or 0
	local esize = endSize + start
	local ptr, count, limit
	local function Resize(newCount, canShrink)
		local a = name and Game[name] or t.Struct
		local OldCount = count or t.UseDynCount and a.count or a.limit
		if newCount == OldCount or newCount < OldCount and not canShrink then
			return
		end
		count, limit = newCount, a.limit or limit
		local dp, dnum, dlim = 0, count - OldCount, count - limit
		if dlim > 0 then
			local old = ptr or a['?ptr']
			ptr = mem.reallocMM(old, limit*size + esize, count*size + esize, not ptr)
			if endSize ~= 0 then
				mem.copy(ptr + start + count*size, ptr + start + limit*size, endSize)
			end			
			if t.Fill then
				for i = limit, count - 1 do
					mem.copy(ptr + start + i*size, ptr + start + t.Fill*size, size)
				end
			end
			limit, dp = count, ptr - old
			BatchAdd(t.Refs or {}, dp)
			BatchAdd(t.LimCountRefs or {}, dlim)
			BatchAdd(t.LimSizeRefs or {}, dlim*size)
			BatchAdd(t.LimEndRefs or {}, dp + dlim*size)
		end
		BatchAdd(t.CountRefs or {}, dnum)
		BatchAdd(t.SizeRefs or {}, dnum*size)
		BatchAdd(t.EndRefs or {}, dp + dnum*size)
		for _, s in ipairs(t) do
			ChangeGameArray(s, ptr, count)
		end
		for _, f in ipairs(t.Custom or {}) do
			f(count, OldCount, dp, ptr, size)
		end
	end
	local function SetHigh(newMax, canShrink)
		Resize(newMax - Game[name].low + 1, canShrink)
	end
	for _, s in ipairs(t) do
		rawset(Game[s], 'Resize', Resize)
		rawset(Game[s], 'SetHigh', SetHigh)
	end
	return Resize, SetHigh
end
