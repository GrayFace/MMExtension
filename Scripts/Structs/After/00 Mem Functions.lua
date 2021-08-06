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
		count, limit = newCount, a.limit or limit
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
				f(count, OldCount, dp, ptr or old, size, t)
			end
			t.CustomOnce = {}
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
			f(count, OldCount, dp, ptr or old, size, t)
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
		local t, sgd = Game[name], internal.SaveGameData
		local p, sz, s = t['?ptr'] + sz0, t['?size'] - sz0, sgd[sname] or ''
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
