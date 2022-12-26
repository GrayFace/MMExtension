local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

assert(mmver > 6)

local P = {}

local NeedStarting = table.invert{'Tower', 'Wall', 'IncomeBricks', 'IncomeGems', 'IncomeBeasts', 'Bricks', 'Gems', 'Beasts'}

local function MakeTxt()
	local t = {{'#', 'TowerToWin', 'ResToWin', 'Tower', 'Wall', 'IncomeBricks', 'IncomeGems', 'IncomeBeasts', 'Bricks', 'Gems', 'Beasts', 'AI', 'CardsCount', 'NPCText'}}
	local p = mm78(0x4E1890, 0x4F2D60)
	for i = 0, 12 do
		local q = {i + mm78(108, 107)}
		t[#t+1] = q
		for j = 0, 9 do
			q[#q+1] = u2[p + j*2]
		end
		q[#q+1] = i4[p + 20]
		q[#q+1] = 6
		q[#q+1] = i + mm78(357, 137)
		if i == 0 then
			q[#q+1] = '(NPCText is optional)'
		end
		p = p + 24
	end
	return WriteBasicTextTable(t)
end

local function MakeTemplate()
	local s = Game.NPCText[mm78(357, 137) + 1]
	local p = mm78(0x4E1890, 0x4F2D60) + 24
	local t0 = {'TowerToWin', 'ResToWin', 'StartingTower', 'StartingWall'}
	local t = {}
	for j = 0, 3 do
		t[u2[p + j*2]..''] = '%'..t0[j+1]..'%'
	end
	return s:gsub('%%', '%%%%'):gsub('%d+', t)
end

function P.SaveLoad(txt)
	txt = txt or MakeTxt()
	P.Text = P.Text or Localize{Template = MakeTemplate()}
	local qq = ParseBasicTextTable(txt, 0, 0)
	local names = qq[0]
	local tt = {}
	P.Taverns = tt
	for _, q in ipairs(qq) do
		local t = {[''] = '%'}
		for i, v in ipairs(q) do
			local k = names[i]
			v = tonumber(v)
			if k == '#' then
				tt[v] = t
			elseif NeedStarting[k] then
				t['Starting'..k] = v
			elseif k and k ~= '' then
				t[k] = v
			end
		end
	end
	return txt
end

function events.DataTablesUpdate2(DataTable)
	if P.Enabled then
		DataTable('Arcomage', P.SaveLoad, nil, P.LazyMode)
	end
	if not P.Text then
		P.SaveLoad()
	end
end

if GameInitialized2 then
	P.SaveLoad()
end

function P.Enable(lazy)
	P.LazyMode = lazy
	P.Enabled = true
end

function events.ArcomageSetup(t, house)
	local q = P.Taverns[house]
	for k, v in pairs(q or {}) do
		if k ~= '' and type(t[k]) == 'number' then
			t[k] = v
		end
	end
end

function events.ArcomageText(t)
	local q = P.Taverns[t.House]
	if q then
		t.Result = P.Text[t.House] or q.NPCText and Game.NPCText[q.NPCText] or P.Text.Template:gsub("%%([%w_]*)%%", q)
	end
end

events.PopulateHouseDialog = |t| if t.PicType == const.HouseType.Tavern then
	t.Result = {15, 16, 96, P.Taverns[t.House] and 101}
end

events.ArcomageWin = |n| if (n < mm78(108, 107) or n > mm78(120, 117)) and P.Taverns[n] and not tget(vars, 'ArcomageWins')[n] then
	-- give gold for new taverns
	vars.ArcomageWins[n] = true
	Party.AddGold(Game.Houses[n].Val * 100)
end

return P