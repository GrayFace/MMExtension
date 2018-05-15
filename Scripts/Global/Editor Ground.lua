Editor = Editor or {}
local _KNOWNGLOBALS

local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local mmver = offsets.MMVersion

local function bound(x, n)
	if x < 0 then
		return 0
	elseif x > n then
		return n
	end
	return x
end

-----------------------------------------------------
-- Edit ground
-----------------------------------------------------

local LastFloatHeightMap

local function AddTilesUndo()
	local tiles = Editor.State.TileMap
	Editor.AddUndo(function()
		AddTilesUndo()
		Editor.State.TileMap = tiles
		mem.copy(Map.TileMap["?ptr"], tiles, #tiles)
	end)
end

local function AddHeightUndo()
	local grid = Editor.State.HeightMap
	Editor.AddUndo(function()
		Editor.SetHeightMap(grid)
	end)
end

function Editor.SetHeightMap(grid)
	AddHeightUndo()
	Editor.State.HeightMap = grid
	mem.copy(Map.HeightMap["?ptr"], grid, #grid)
	for y = 0, 127 do
		for x = 0, 127 do
			Editor.UpdateNormals(x, y)
		end
	end
	Party.NeedRender = true
end

local function AddUndo(f)
	if Editor.BeginUndoState() then
		f()
	else
		Editor.AddUndo()
	end
	Editor.EndUndoState()
end

local function UpdateTerrain()
	for k in pairs(Editor.SelectedTiles) do
		Editor.UpdateNormals(k % 128, k:div(128))
	end
	AddUndo(AddHeightUndo)
	Editor.ReadSquares()
	Party.NeedRender = true
end

local function GridPaintFlat(dz)
	local hm = Map.HeightMap
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		hm[y][x] = bound(hm[y][x] + dz, 255)
	end
	UpdateTerrain()
end

local function PrepareFloatHeightMap()
	if not Editor.CheckCompleteUndoState() then
		return LastFloatHeightMap
	end
	local hm, fhm = Map.HeightMap, {}
	for y = 0, 127 do
		for x = 0, 127 do
			fhm[y*128 + x] = hm[y][x]
		end
	end
	LastFloatHeightMap = fhm
	return fhm
end

-- local function GridPaintRound(dz)
	-- local n = Editor.TileBrushSize/2
	-- local nn = n*n
	-- local x0, y0 = Editor.GridX, Editor.GridY
	-- local hm, fhm = Map.HeightMap, PrepareFloatHeightMap()
	-- for k in pairs(Editor.SelectedGrid) do
		-- local x, y = k % 128, k:div(128)
		-- local dx, dy = x - x0, y - y0
		-- fhm[k] = fhm[k] + dz*(1 - (dx*dx + dy*dy)/nn)^0.5
		-- hm[y][x] = bound(fhm[k]:round(), 255)
	-- end
	-- UpdateTerrain()
-- end

--[[ Spline:
	f[0] = 0
	f'[0] = 0
	f[x] = g[x]
	f'[x] = g'[x]
	g[1] = 1
	g'[1] = 0
	
	f = a*xx
	g = b*(1-x)^2 + 1 = b*(xx - 2x + 1)
	
	a*x = b*(x-1)
	a*xx = b*(xx - 2x + 1) + 1
	
	b*(xx - 2x + 1 + x - xx) = -1
	b = 1/(x - 1)
	a = 1/x
]]

local function GridPaintSpline(dz)
	local mid = 1/2
	local a = 1/mid
	local b = 1/(mid - 1)
	
	local n = Editor.TileBrushSize/2
	local x0, y0 = Editor.GridX, Editor.GridY
	local hm, fhm = Map.HeightMap, PrepareFloatHeightMap()
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		local dx, dy = x - x0, y - y0
		local z = 1 - (dx*dx + dy*dy)^0.5/n
		if z <= mid then
			z = a*z*z
		else
			z = z - 1
			z = b*z*z + 1
		end
		fhm[k] = fhm[k] + dz*z
		hm[y][x] = bound(fhm[k]:round(), 255)
	end
	UpdateTerrain()
end

local function GridFlatten()
	local hm = Map.HeightMap
	local t = {}
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		t[#t + 1] = hm[y][x]
	end
	table.sort(t)
	local v = t[(#t):div(2) + 1]  -- median
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		hm[y][x] = v
	end
	UpdateTerrain()
end

-- local function GridSmoothFlat()
	-- local hm = Map.HeightMap
	-- local v, n = 0, 0
	-- for k in pairs(Editor.SelectedGrid) do
		-- local x, y = k % 128, k:div(128)
		-- v = v + hm[y][x]
		-- n = n + 1
	-- end
	-- v = (v / n):round()
	-- for k in pairs(Editor.SelectedGrid) do
		-- local x, y = k % 128, k:div(128)
		-- local v1 = hm[y][x]
		-- if v1 > v then
			-- hm[y][x] = v1 - 1
		-- elseif v1 < v then
			-- hm[y][x] = v1 + 1
		-- end
	-- end
	-- UpdateTerrain()
-- end

-- local function GridSmoothFlatSpline(dz)
	-- local mid = 1/2
	-- local a = 1/mid
	-- local b = 1/(mid - 1)
	
	-- local v, n = 0, 0
	-- local zval = {}
	-- local r = Editor.TileBrushSize/2
	-- local x0, y0 = Editor.GridX, Editor.GridY
	-- local hm, fhm = Map.HeightMap, PrepareFloatHeightMap()
	-- for k in pairs(Editor.SelectedGrid) do
		-- local x, y = k % 128, k:div(128)
		-- local dx, dy = x - x0, y - y0
		-- local z = 1 - (dx*dx + dy*dy)^0.5/r
		-- if z <= mid then
			-- z = a*z*z
		-- else
			-- z = z - 1
			-- z = b*z*z + 1
		-- end
		-- zval[k] = z
		-- z = z*z
		-- v = v + fhm[k]*z
		-- n = n + z
	-- end
	-- v = v / n
	-- for k in pairs(Editor.SelectedGrid) do
		-- local x, y = k % 128, k:div(128)
		-- local v1 = fhm[k]
		-- local z = dz*zval[k]
		-- if abs(v1 - v) < z then
			-- fhm[k] = v
		-- elseif v1 > v then
			-- fhm[k] = v1 - z
		-- elseif v1 < v then
			-- fhm[k] = v1 + z
		-- end
		-- hm[y][x] = fhm[k]:round()
	-- end
	-- UpdateTerrain()
-- end


--[[
	Approximation with plane:
	
  min sum((z - x*a - y*b - c)^2)
	
	sum((z - x*a - y*b - c)) = 0
	sum((z - x*a - y*b - c)*x) = 0
	sum((z - x*a - y*b - c)*y) = 0
	
	Z = X*a + Y*b + N*c
	ZX = XX*a + XY*b + X*c
	ZY = XY*a + YY*b + Y*c
	
	N  X  Y   Z
	X XX XY  ZX
	Y XY YY  ZY
]]

local function NoInf(v)  -- replaces Inf and NaN with 0
	if v*0 ~= 0 then
		return 0
	end
	return v
end

local function Solve3x4(m)
	local function sub(y, base, x)
		local d = (base - y)*4
		y = y*4 + 1
		local mul = NoInf(m[y + x]/m[y + d + x])
		for i = y, y + 3 do
			m[i] = m[i] - mul*m[i + d]
		end
	end
	sub(1, 0, 0)
	sub(2, 0, 0)
	sub(2, 1, 1)
	sub(1, 2, 2)
	sub(0, 2, 2)
	sub(0, 1, 1)
	return NoInf(m[4]/m[1]), NoInf(m[8]/m[6]), NoInf(m[12]/m[11])
end

local function GridSmooth(dz)
	local mid = 1/2
	local a = 1/mid
	local b = 1/(mid - 1)
	
	-- make linear equations matrix
	local zval = {}
	local m = {
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
	}
	local r = Editor.TileBrushSize/2
	local x0, y0 = Editor.GridX, Editor.GridY
	local hm, fhm = Map.HeightMap, PrepareFloatHeightMap()
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		local dx, dy = x - x0, y - y0
		local z = 1 - (dx*dx + dy*dy)^0.5/r
		if z <= mid then
			z = a*z*z
		else
			z = z - 1
			z = b*z*z + 1
		end
		zval[k] = z
		local w = z -- weight
		z = fhm[k]
		
		m[1] = m[1] + w    m[2] = m[2] + x*w      m[3] = m[3] + y*w       m[4] = m[4] + z*w
											 m[6] = m[6] + x*x*w    m[7] = m[7] + x*y*w     m[8] = m[8] + z*x*w
		                                         m[11] = m[11] + y*y*w   m[12] = m[12] + z*y*w
	end
	m[5] = m[2]
	m[9] = m[3]   m[10] = m[7]
	
	local c, a, b = Solve3x4(m)
	
	-- apply
	for k in pairs(Editor.SelectedGrid) do
		local x, y = k % 128, k:div(128)
		local v = a*x + b*y + c
		local v1 = fhm[k]
		local z = dz*zval[k]
		if abs(v1 - v) < z then
			v1 = v
		elseif v1 > v then
			v1 = v1 - z
		elseif v1 < v then
			v1 = v1 + z
		end
		fhm[k] = bound(v1, 255)
		hm[y][x] = fhm[k]:round()
	end
	UpdateTerrain()
end


-----------------------------------------------------
-- Tiles painting
-----------------------------------------------------

do
	local L, R, U, D, X, C = 1, 2, 4, 8, 16, 32
	local conv = {[-1] = 1, [0] = 0, [1] = 2}
	local codes = table.invert{U+R, D+R, U+L, D+L, R, L, U, D, X+U+R, X+D+R, X+U+L, X+D+L}
	local rcodes = table.invert{
		U+R+D+L, U+D, L+R, U+R, U+L, D+R, D+L, U+D+R, U+D+L, U+R+L, D+R+L,
		D, L, U, R, C+U+L+R, C+D+R+L, C+U+D+L, C+U+D+R, C+D+L, C+U+R, C+D+R, C+U+L}

	local function SmoothTile(x, y, DiagRoad)
		local map = Map.TileMap
		local v = map[y][x]
		if v < 90 or v > 233 then
			return
		end
		local v0 = (v - (v - 90) % 36)
		local v1 = v0 + 36
		local IsRoad = v >= 198
		
		local code, dcode, hasC = 0, X, 0
		for yy = -1, 1 do
			for xx = -1, 1 do
				local v = map[bound(y + yy, 127)][bound(x + xx, 127)]
				if IsRoad ~= (v < v0 or v >= v1) then
					local k = conv[xx] + U*conv[yy]
					if xx == 0 or yy == 0 then
						code = code + k
					else
						dcode = dcode:Or(k)
					end
					if v >= 198 + 15 and (xx == 0 and yy == 0 or DiagRoad) then  -- a diagonal road
						hasC = C
					end
				end
			end
		end
		
		if v < 198 then  -- not road
			local c = codes[code] or codes[dcode]
			if c then
				map[y][x] = v0 + c + 11
			elseif v - v0 >= 12 then
				map[y][x] = v0 + math.random(12) - 1
			end
		else
			local c = (rcodes[code + hasC] or rcodes[code])
			if c then
				map[y][x] = 197 + c
			end
		end
	end
	
	function Editor.SmoothTiles(DiagRoad)
		local n = Editor.TileBrushSize/2
		local x, y = Editor.GridX, Editor.GridY
		for y = max(0, y - n - 1), min(127, y + n) do
			for x = max(0, x - n - 1), min(127, x + n) do
				SmoothTile(x, y, DiagRoad)
			end
		end
		AddUndo(AddTilesUndo)
		Editor.ReadSquares()
		Party.NeedRender = true
	end
end

local BrushTiles = {[0] = 1, 90, 126, 162, 198, 198 + 15}

local function PaintGround()
	local map = Map.TileMap
	local v = BrushTiles[Editor.CurrentTileset]
	for k in pairs(Editor.SelectedTiles) do
		local x, y = k % 128, k:div(128)
		map[y][x] = (v >= 198 and v or v + math.random(12) - 1)
	end
	Editor.SmoothTiles(v >= 198 + 15)
end

-----------------------------------------------------
-- Select ground tiles, fire painting
-----------------------------------------------------

Editor.GridX, Editor.GridY = 10000, 10000
local LastPaintTime
local TileGridDelays = {[0] = 100, 100, 100, 100, nil, 100}
local TileGridProcs = {
	GridPaintFlat, 1,
	GridPaintFlat, -1,
	GridPaintSpline, 1,
	GridPaintSpline, -1,
	GridFlatten, 0,
	GridSmooth, 1,
}

local function GetDelay()
	local delay = Editor.TileBrushGrid and TileGridDelays[Editor.TileGridMode] or math.huge
	delay = delay / Editor.TileBrushSpeed
	return delay
end

local function DoPaint(n)
	if Editor.TileBrushGrid then
		if Keys.IsPressed(const.Keys.SHIFT) then
			n = n * 2
		end
		local i = Editor.TileGridMode * 2
		TileGridProcs[i + 1](TileGridProcs[i + 2]*n)
	else
		PaintGround()
	end
end

local function DeselectNonFlatTiles(t)
	local hm = Map.HeightMap
	for k in pairs(t) do
		local x, y = k % 128, k:div(128)
		local v = hm[y][x]
		if y < 127 and x < 127 then
			if hm[y+1][x] ~= v or hm[y+1][x+1] ~= v or hm[y][x+1] ~= v then
				t[k] = nil
			end
		end
	end
end

local function SelectTiles(x, y)
	local n = (Editor.TileBrushSize - 1)/2
	local nn = n*n
	local g, t = {}, {}
	if n == 0 and y >= 0 and y < 128 and x >= 0 and x < 128 then
		t[y*128 + x - 64.5] = true
	end
	for i = max(0, (y - n):ceil()), min(127, y + n) do
		for j = max(0, (x - n):ceil()), min(127, x + n) do
			local dx, dy = j - x, i - y
			if dx*dx + dy*dy < nn then
				g[i*128 + j] = true
				for i = max(0, i - 1), i do
					for j = max(0, j - 1), j do
						t[i*128 + j] = true
					end
				end
			end
		end
	end
	-- deselect non-flat water
	if not Editor.TileBrushGrid and abs(Editor.CurrentTileset - 2) <= 1 then
		if Game.CurrentTileBin[Map.Tilesets[Editor.CurrentTileset - 1].Offset].Water then
			DeselectNonFlatTiles(t)
		end
	end
	
	Editor.SelectedTiles = t
	Editor.SelectedGrid = g
	Editor.DisplaySelectedTiles()
	Party.NeedRender = true
end

function events.Tick()
	if not Keys.IsPressed(const.Keys.LBUTTON) then
		Editor.LButtonPressed = false
		LastPaintTime = nil
	end
	if not Editor.WorkMode or not Editor.StateSync or Editor.TileBrushSize == 0 or Map.IsIndoor() then
		return
	end
	local dx, dy, dz = Editor.GetMouseDirection()
	local x, y, z = XYZ(Party)
	z = z + 120
	if dz >= 0 or z < 0 or Map.IsIndoor() then
		x, y = 0x100000, 0x100000
	else
		x = x - dx*z/dz
		y = y - dy*z/dz
	end
	if Editor.TileBrushSize % 2 == 1 then
		x = (64 + x / 0x200):floor() + 0.5
		y = (64 - y / 0x200):floor() + 0.5
	else
		x = (64.5 + x / 0x200):floor()
		y = (64.5 - y / 0x200):floor()
	end
	if x ~= Editor.GridX or y ~= Editor.GridY then
		LastPaintTime = nil
		Editor.GridX, Editor.GridY = x, y
		SelectTiles(x, y)
	end
	if Editor.LButtonPressed and (not LastPaintTime or timeGetTime() - LastPaintTime > GetDelay()) then
		local delay, t = GetDelay(), timeGetTime()
		LastPaintTime = LastPaintTime and LastPaintTime + delay or t
		local n = 1
		while LastPaintTime + delay < t do
			n = n + 1
			LastPaintTime = LastPaintTime + delay
		end
		DoPaint(n)
	end
end
