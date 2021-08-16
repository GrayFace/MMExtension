local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, prot = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.prot
local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end

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
		internal.SetArrayUpval(Game[name], 'o', p)
	end
	if count then
		internal.SetArrayUpval(Game[name], 'count', count)
	end
	if lenP then
		internal.SetArrayUpval(Game[name], 'lenP', lenP)
	end
end
mem.ChangeGameArray = ChangeGameArray

local ItemSize = |t| t[t.low]['?size']

local function Extend(t)
	local name, size, endSize, start = t[1], t.Size or ItemSize(Game[t[1]]), t.EndSize or 0, t.StartSize or 0
	local esize = endSize + start
	local ptr, count, limit
	if not size then
		error('size unspecified: '..(name or ('%X'):format(t.Struct['?ptr'])))
	end
	local function Resize(newCount, canShrink)
		local a = name and Game[name] or t.Struct
		local OldCount = count or t.UseDynCount and a.count or a.limit
		if newCount == OldCount or newCount < OldCount and not canShrink then
			return
		end
		count, limit = newCount, limit or a.limit
		local dp, dlim, dnum, old = 0, 0, count - OldCount, ptr or a['?ptr']
		if count > limit then
			dlim = count - limit
			ptr = mem.reallocMM(old, limit*size + esize, count*size + esize, not ptr)
			if endSize ~= 0 then
				mem.copy(ptr + start + count*size, ptr + start + limit*size, endSize)
			end
			if t.Fill then
				for i = limit, count - 1 do
					mem.copy(ptr + start + i*size, ptr + start + t.Fill*size, size)
				end
			end
			-- move EditablePChar to new location
			if ptr ~= old then
				local p2 = old + limit*size + esize
				local pc = internal.EditablePCharText
				local new = {}
				for k, v in pairs(pc) do
					if k >= old and k < p2 then
						if not ptr and v == u4[k] then
							u4[k] = 0
						end
						local k1 = k + (ptr - old) + (k >= p2 - endSize and (count - limit)*size or 0)
						new[k1] = v
						pc[k] = nil
					end
				end
				table.copy(new, pc, true)
			end
			limit, dp = count, ptr - old
			BatchAdd(t.Refs or {}, dp)
			BatchAdd(t.LimCountRefs or {}, dlim)
			BatchAdd(t.LimSizeRefs or {}, dlim*size)
			BatchAdd(t.LimEndRefs or {}, dp + dlim*size)
			for _, f in ipairs(t.CustomOnce or {}) do
				f(count, OldCount, dp, ptr, size, t, dlim)
			end
			t.CustomOnce = nil
		end
		BatchAdd(t.CountRefs or {}, dnum)
		BatchAdd(t.SizeRefs or {}, dnum*size)
		BatchAdd(t.EndRefs or {}, dp + dnum*size)
		for _, s in ipairs(t) do
			-- If lenP is set, 'count' acts as a limit and should be set only if dp ~= 0
			-- If lenP is inside the relocated area, correct it.
			-- If it's at the end of it, also move it by 'dlim*size'.
			local lenP = internal.GetArrayUpval(Game[s], 'lenP')
			local n = (not lenP or dp ~= 0) and count or nil
			if lenP and n and lenP >= old and lenP < old + (limit - dlim)*size + esize then
				lenP = lenP + dp + (lenP < old + start and 0 or dlim*size)
			else
				lenP = nil
			end
			ChangeGameArray(s, ptr, n, lenP)
		end
		for _, f in ipairs(t.Custom or {}) do
			f(count, OldCount, dp, ptr or old, size, t, dlim)
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
mem.ExtendGameStructure = Extend

local function SaveLoad(name, p0, sz0)
	local sname = 'Extra'..name
	function events.InternalBeforeSaveGame()
		local t, sgd = Game[name], internal.SaveGameData
		local p, sz = t['?ptr'], t['?size'] - sz0
		mem.copy(p0, p, sz0)
		sgd[sname] = mem.string(p + sz0, sz, true)
	end
	events.InternalBeforeLoadMap = |was, loaded| if not was then
		local t, s = Game[name], internal.SaveGameData[sname] or ''
		local p, sz = t['?ptr'] + sz0, t['?size'] - sz0
		if not loaded then
			return mem.fill(p, sz)
		end
		mem.copy(p - sz0, p0, sz0)
		mem.copy(p, s, min(#s, sz))
		if #s < sz then
			mem.fill(p + #s, sz - #s)
		end
	end
end

function mem.ExtendAndSaveGameStructure(t)
	local name = t[1]
	local p0, size0 = Game[name]['?ptr'], Game[name]['?size']
	t.CustomOnce = t.CustomOnce or {}
	t.CustomOnce[#t.CustomOnce + 1] = || SaveLoad(name, p0, size0)
	return Extend(t)
end


-- bits for Awards, Quests

local sizes, ptrs, lims = {}, {}, {}
internal.BitArrayExtras = ptrs
internal.BitArrayBaseSizes = sizes
internal.BitArrayLimits = lims

local function NeedBitHooks()
	local function handler(d)
		local p = d.ecx
		local n = sizes[p]
		local k = n and d.dx
		if n and k >= n then
			d.ecx = ptrs[p]
			d.edx = k - n
		end
	end
	mem.autohook(mmv(0x43FDC0, 0x449B7A, 0x447279), handler)  -- check bit
	mem.autohook(mmv(0x43FDF0, 0x449BA1, 0x4472A0), handler)  -- set bit
	NeedBitHooks = ||
end

local function GetPtr2(obj, off)
	local check = rawget(obj, "?CheckOffset")
	if check then
		check(obj, off, 3)
	end
	local p = obj["?ptr"]
	local sz = sizes[p]/8
	if off < sz then
		return p + off
	end
	return ptrs[p] + off - sz
end

local function NeedSaveBits(a, p)
	local list = {}
	internal.SaveBitsList = list
	function events.InternalBeforeSaveGame()
		local sgd = internal.SaveGameData
		local t = sgd.ExtraBitArrays or {}
		for a, p in pairs(list) do
			local p2, n = ptrs[p], lims[p]
			t[p] = p2 and mem.string(p2, n and (n - sizes[p])/8 or 0, true) or ''
		end
		sgd.ExtraBitArrays = t
	end
	events.InternalBeforeLoadMap = |was, loaded| if not was then
		local t = loaded and internal.SaveGameData.ExtraBitArrays or {}
		for a, p in pairs(list) do
			local s, sz, sz0 = t[p] or '', lims[p], sizes[p]
			sz = sz and (sz - sz0)/8 or 0
			if sz < #s then
				sz = #s
				local n = a.limit
				a:Resize(#s*8)
				a:Resize(n, true)
			end
			local p2 = ptrs[p]
			-- !!! ...
			mem.copy(p2, s, min(#s, sz))
			if #s < sz then
				mem.fill(p2 + #s, sz - #s)
			end
		end
	end
	function NeedSaveBits(a, p)
		list[a] = p
	end
	return NeedSaveBits(a, p)
end

function mem.ExtendBitsArray(t)
	local resize, limit = {}, (t[1].limit + 7):AndNot(7)
	local count, limit
	
	local function Resize(newCount, canShrink)
		local OldCount = count or a.count
		if count == OldCount or count < OldCount and not canShrink then
			return
		end
		local dlim, newLim = 0, count > limit
		if newLim then
			newLim = (count + 7):AndNot(7)
			NeedBitHooks()
			for _, a in ipairs(t) do
				local p = a['?ptr']
				local ptr = ptrs[p]
				ptrs[p] = mem.reallocMM(ptr or 0, (limit - base)*8, (newLim - base)*8, not ptr)
				lims[p] = newLim
				if not ptr then
					sizes[p] = limit
					internal.SetArrayUpval(a, 'GetPtr', GetPtr2)
				end
			end
			dlim = newLim - limit
			limit = newLim
			BatchAdd(t.LimCountRefs or {}, dlim)
			for _, f in ipairs(t.CustomOnce or {}) do
				f(count, OldCount, t, dlim)
			end
			t.CustomOnce = nil
		end
		BatchAdd(t.CountRefs or {}, count - OldCount)
		for _, a in ipairs(t) do
			-- If lenP is set, 'count' acts as a limit and should be set only if it's changed
			if newLim or not internal.GetArrayUpval(a, 'lenP') then
				internal.SetArrayUpval(a, 'count', count)
			end
		end
		for _, f in ipairs(t.Custom or {}) do
			f(count, OldCount, t, dlim)
		end
	end
	local function SetHigh(newMax, canShrink)
		Resize(newMax - a.low + 1, canShrink)
	end

	for i, a in ipairs(t) do
		rawset(a, 'Resize', Resize)
		rawset(a, 'SetHigh', SetHigh)
		if not t.NoSave then
			NeedSaveBits(a, p)
		end
	end
	
	return Resize, SetHigh
end
