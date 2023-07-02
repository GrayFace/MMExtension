local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, prot = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.prot
local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end

local BatchAdd = |t, d| if d ~= 0 then
	prot(true)
	local moved = mem.MovedCode
	for _, p in ipairs(t) do
		p = moved[p] or p
		u4[p] = u4[p] + d
	end
	prot(false)
end
mem.BatchAdd = BatchAdd

local function ChangeGameArray(name, p, count, lenP, stru)
	stru = stru or Game
	if p then
		structs.o[structs.name(stru)][name] = p
		internal.SetArrayUpval(stru[name], 'o', p)
	end
	if count then
		internal.SetArrayUpval(stru[name], 'count', count)
	end
	if lenP then
		internal.SetArrayUpval(stru[name], 'lenP', lenP)
	end
end
mem.ChangeGameArray = ChangeGameArray

local function ReallocAligned(p, OldSize, NewSize, align, calign, NoFree)
	local new = mem.allocMM(NewSize + align - 1)
	local nalign = (p - new)%align
	new = new + nalign
	if OldSize < NewSize then
		mem.copy(new, p, OldSize)
		mem.fill(new + OldSize, NewSize - OldSize, 0)
	else
		mem.copy(new, p, NewSize)
	end
	if not NoFree then
		mem.freeMM(p - calign)
	end
	return new, nalign
end

local function Extend(t)
	local stru = t.BaseStruct or Game
	local name, size, endSize, start, before = t[1], t.Size or stru[t[1]].ItemSize, t.EndSize or 0, t.StartSize or 0, t.StartBefore or 0
	start = start + before
	local esize = endSize + start
	local align, calign = t.Align or 1, 0
	local ptr, count, limit
	if not size then
		error('size unspecified: '..(name or ('%X'):format(t.Struct['?ptr'])))
	end
	local function Resize(newCount, canShrink)
		local a = name and stru[name] or t.Struct
		local OldCount = count or t.UseDynCount and a.count or t.Limit or a.limit
		if newCount == OldCount or newCount < OldCount and not canShrink then
			return
		end
		count, limit = newCount, limit or t.Limit or a.limit
		local dp, dlim, dnum, old = 0, 0, count - OldCount, ptr or (t.Ptr or a['?ptr']) - before
		if count > limit then
			dlim = count - limit
			ptr, calign = ReallocAligned(old, limit*size + esize, count*size + esize, align, calign, not ptr)
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
			local lenP = internal.GetArrayUpval(stru[s], 'lenP')
			local n = (not lenP or dp ~= 0) and count or nil
			if lenP and n and lenP >= old and lenP < old + (limit - dlim)*size + esize then
				lenP = lenP + dp + (lenP < old + start and 0 or dlim*size)
			else
				lenP = nil
			end
			ChangeGameArray(s, structs.o[structs.name(stru)][s] + dp, n, lenP, stru)
		end
		for _, f in ipairs(t.Custom or {}) do
			f(count, OldCount, dp, ptr or old, size, t, dlim)
		end
	end
	local function SetHigh(newMax, canShrink)
		Resize(newMax - stru[name].low + 1, canShrink)
	end
	for _, s in ipairs(t) do
		rawset(stru[s], 'Resize', Resize)
		rawset(stru[s], 'SetHigh', SetHigh)
	end
	return Resize, SetHigh
end
mem.ExtendGameStructure = Extend

local function TrimNull(s)
	local i = s:match('()%z+$')
	return i and s:sub(1, i - 1) or s
end

local function SaveLoad(name, p0, sz0)
	local sname = 'Extra'..name
	function events.InternalBeforeSaveGame()
		local t, sgd = Game[name], internal.SaveGameData
		local p, sz = t['?ptr'], t['?size'] - sz0
		mem.copy(p0, p, sz0)
		sgd[sname] = TrimNull(mem.string(p + sz0, sz, true))
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

local function SetBitArrayProc(a, p, lim)
	local f, sz = internal.GetArrayUpval(a, 'f'), lim/8
	local function newF(o, ...)
		if o >= sz then
			o = o - sz + ptrs[p] - p
		end
		return f(o, ...)
	end
	internal.SetArrayUpval(a, 'f', newF, true)
end

local function NeedSaveBits(a, p)
	local list = {}
	internal.SaveBitsList = list
	
	function events.InternalBeforeSaveGame()
		local sgd = internal.SaveGameData
		local t = sgd.ExtraBitArrays or {}
		for a, p in pairs(list) do
			local p2, n = ptrs[p], lims[p]
			t[p] = p2 and TrimNull(mem.string(p2, n and (n - sizes[p])/8 or 0, true))
		end
		sgd.ExtraBitArrays = next(t) and t
	end
	
	events.InternalBeforeLoadMap = |was, loaded| if not was then
		local t = loaded and internal.SaveGameData.ExtraBitArrays or {}
		for a, p in pairs(list) do
			local s, sz, sz0 = t[p] or '', lims[p], sizes[p]
			sz = sz and (sz - sz0)/8 or 0
			if sz < #s then
				sz = #s
				local n = a.limit
				a.Resize(#s*8 - 7)
				a.Resize(n, true)
			end
			local p2 = ptrs[p]
			if p2 then
				mem.copy(p2, s, #s)
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
	local resize, limit = {}, t.Limit or (t[1].limit + 7):AndNot(7)
	local count
	
	local function Resize(newCount, canShrink)
		local OldCount = count or t[1].count
		if newCount == OldCount or newCount < OldCount and not canShrink then
			return
		end
		count = newCount
		local dlim, newLim = 0, count > limit
		if newLim then
			newLim = (count + 7):AndNot(7)
			NeedBitHooks()
			for _, a in ipairs(t) do
				local p = a['?ptr']
				local ptr = ptrs[p]
				local base = ptr and sizes[p] or limit
				ptrs[p] = mem.reallocMM(ptr or 0, (limit - base)*8, (newLim - base)*8, not ptr)
				lims[p] = newLim
				if not ptr then
					sizes[p] = limit
					SetBitArrayProc(a, p, limit)
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
			NeedSaveBits(a, a['?ptr'])
		end
	end
	
	return Resize, SetHigh
end
