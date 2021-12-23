local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, r4, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.r4, mem.pchar, mem.call

local mmver = Game.Version
local mm78 = |x, y| mmver == 7 and x or y

local P = {}

-- No software snow in D3D
P.Patch = mm78(|| do
	mem.asmhook(0x441D4C, [[
		cmp dword [0xE31AF0], 0
		jnz absolute 0x441D51
	]])
	P.Patch = ||
end, ||)

local function GetUVForRect(p, w, h)
	local x1, y1, x2, y2 = i4[p], i4[p+4], i4[p+8], i4[p+12]
	local ViewMul = Game.OutdoorViewMul
	local m = max(w, h)
	return x1, y1, x2, y2, (x2 - x1)/ViewMul*w/m, (y2 - y1)/ViewMul*h/m
end


P.BaseSnowSetup = {
	Bitmap = 'snow01', FallSpeed = 0.002, FadeSpeed = 0.004, distMul = 0.28,
	Opacity = 0.88, BottomOpMul = 0.8, NightLight = 4.7, RMul = 1, GMul = 1, BMul = 1,
	AngleMul = 1, MoveMul = 0.0002, MoveFwdMul = 0.15, MoveFwdLim = 20, MoveZMul = 0.45,
}
P.BaseSnowSetup.Layers = {
	{u = 0.81, v = 0.97, dist = 0.5, sx = -0.1, sy = 0.9, opacity = 0.18},
	{u = 0.46, v = 0.01, dist = 1.25, sx = 0.2, sy = 0.9, opacity = 0.65},
	{u = 0.27, v = 0.82, dist = 1.6, sx = 0.02, sy = 0.9, opacity = 0.55},
	{u = 0.4, v = 0.4, dist = 3, sx = -0.03, sy = 0.95, opacity = 0.8},
	{u = 0.81, v = 0.97, dist = 5, sx = 0.08, sy = 1, opacity = 0.75},
}
-- P.BaseSnowSetup.Layers = {
-- 	{u = 0.81, v = 0.97, dist = 0.5, sx = -0.1, sy = 0.9, opacity = 0.15},
-- 	{u = 0.46, v = 0.01, dist = 1.3, sx = 0.2, sy = 0.9, opacity = 0.75},
-- 	{u = 0.27, v = 0.82, dist = 1.6, sx = 0.02, sy = 0.9, opacity = 0.55},
-- 	{u = 0.4, v = 0.4, dist = 3, sx = -0.03, sy = 0.95, opacity = 0.9},
-- 	{u = 0.81, v = 0.97, dist = 5, sx = 0.08, sy = 1, opacity = 0.75},
-- }
-- P.BaseSnowSetup.Layers = {
-- 	--{u = 0.08, v = 0.28, dist = 0.65, sx = 0.16, sy = 1, opacity = 1},
-- 	--{u = 0.18, v = 0.58, dist = 0.75, sx = 0.26, sy = 1, opacity = 1},
-- 	--{u = 0.08, v = 0.28, dist = 0.75, sx = -0.26, sy = 1, opacity = 0.5},
-- 	--{u = 0.07, v = 0.67, dist = 1, sx = 0.15, sy = 1, opacity = 0.6},
-- 	{u = 0.46, v = 0.01, dist = 1.3, sx = 0.2, sy = 0.9, opacity = 0.75},
-- 	{u = 0.27, v = 0.82, dist = 1.7, sx = 0.02, sy = 0.9, opacity = 0.5},
-- 	-- {u = 0.43, v = 0.64, dist = 2.5, sx = -0.15, sy = 1, opacity = 1},
-- 	-- {u = 0.17, v = 0.14, dist = 3, sx = -0.03, sy = 1, opacity = 1},
-- 	--{u = 0.81, v = 0.97, dist = 3.5, sx = 0.17, sy = 1, opacity = 1},
-- 	{u = 0.4, v = 0.4, dist = 3, sx = 0.01, sy = 0.9, opacity = 1},
-- 	{u = 0.21, v = 0.12, dist = 4, sx = -0.1, sy = 1, opacity = 0.9},
-- 	{u = 0.81, v = 0.97, dist = 4, sx = 0.08, sy = 1, opacity = 0.75},
-- }

local sn = P.BaseSnowSetup

--[[
Rain:

local t = table.copy(P.BaseSnowSetup, {
	Bitmap = 'rain01', Opacity = 0.4, RMul = 0.45, GMul = 0.6,
	distMul = 0.5*0.28/0.31, FallSpeed = 0.0055,
})
t.Layers = {
	--{u = 0.08, v = 0.28, dist = 3.65, sx = 0.16, sy = 2, opacity = 1},
	{u = 0.18, v = 0.58, dist = 1.75, sx = 0.26, sy = 2, opacity = 1},
--	{u = 0.08, v = 0.28, dist = 2.75, sx = -0.26, sy = 2, opacity = 0.5},
	--{u = 0.07, v = 0.67, dist = 1.5, sx = 0.15, sy = 2, opacity = 1},
	{u = 0.46, v = 0.01, dist = 1.8, sx = 0.2, sy = 2, opacity = 1},
	{u = 0.27, v = 0.82, dist = 2, sx = -0.12, sy = 2, opacity = 1},
	--{u = 0.43, v = 0.64, dist = 2.5, sx = -0.15, sy = 2, opacity = 1},
	{u = 0.17, v = 0.14, dist = 3, sx = -0.03, sy = 2, opacity = 1},
	{u = 0.81, v = 0.97, dist = 3.5, sx = 0.17, sy = 2, opacity = 1},
	{u = 0.21, v = 0.12, dist = 6, sx = -0.1, sy = 2, opacity = 1},
	{u = 0.81, v = 0.97, dist = 6, sx = 0.08, sy = 2, opacity = 0.7},
}
P.SetEffect(t)
]]

local po = Game.PatchOptions
local DrawRect = po.Present'RenderRectLeft' and po['?ptr'] + structs.o.PatchOptions.RenderRectLeft or mm78(0xF8BAA4, 0xFFDE9C)

local LastDir, LastLookAngle, LastX, LastY, LastZ = 0, 0, 0, 0, 0

function P.DrawSnow(on)
	if not on and (P.Opacity or 0) == 0 or mmver < 7 then
		P.Opacity = 0
		return false
	end
	P.Bmp = P.Bmp or Game.BitmapsLod:LoadBitmap(sn.Bitmap)
	local pic = Game.BitmapsLod.Bitmaps[P.Bmp]
	local x1, y1, x2, y2, du, dv = GetUVForRect(DrawRect, pic.Width, pic.Height)
	
	-- shift from moving
	local mul = sn.MoveMul
	local dx, dy = Party.X - LastX, Party.Y - LastY
	local mx, my = math.cos(LastDir*math.pi/1024), math.sin(LastDir*math.pi/1024)
	dx, dy = (mx*dy - my*dx)*mul, (Party.Z - LastZ)*math.cos(LastLookAngle*math.pi/1024)*sn.MoveZMul*mul
	local dfw = min(mx*dx + my*dy, sn.MoveFwdLim)*sn.MoveFwdMul*mul
	LastX, LastY, LastZ = XYZ(Party)
	
	-- shift from changing view direction
	local mul = sn.AngleMul*math.pi/1024
	local ax, ay = dx + (Party.Direction - LastDir)*mul, dy + (Party.LookAngle - LastLookAngle)*mul
	LastDir, LastLookAngle = Party.Direction, Party.LookAngle
	
	-- adjust global opacity (fade in/out)
	local dt = Game.TimeDelta
	if on then
		P.Opacity = min((P.Opacity or 1) + dt*sn.FadeSpeed, 1)
	else
		P.Opacity = max((P.Opacity or 0) - dt*sn.FadeSpeed, 0)
	end
	
	-- global dist mul and snow color
	local distMul = sn.distMul*(Game.PatchOptions.UILayoutActive() and 1 or 0.93)
	local cl = mem.call(mm78(0x47C500, 0x47B893), 2, 31, 0, mem.i4[mm78(0x50AA9C, 0x51C374)], 1, 0)
	local b, g, r = cl:And(0xFF), cl:And(0xFF00)/0x100, cl:And(0xFF0000)/0x10000
	r, g, b = r*sn.RMul, g*sn.GMul, b*sn.BMul
	local op = P.Opacity*sn.Opacity
	local opb = min(op*sn.NightLight, op*sn.BottomOpMul*255/max(max(r, g), b))
	op = op*min(sn.NightLight, 255/max(max(r, g), b))
	
	for _, t in pairs(sn.Layers) do
		-- move the texture by changing UV, then draw
		local dist = t.dist*distMul
		t.u = (t.u - t.sx*dt*sn.FallSpeed - ax*dist - dx/t.dist)%1
		t.v = (t.v - t.sy*dt*sn.FallSpeed - ay*dist - (dy - dfw)/t.dist)%1
		local op1 = op*t.opacity
		cl = (b*op1):round() + (g*op1):round()*0x100 + (r*op1):round()*0x10000
		local op1 = opb*t.opacity
		cl2 = (b*op1):round() + (g*op1):round()*0x100 + (r*op1):round()*0x10000
		DrawScreenEffectD3D(P.Bmp, t.u, t.v, du*dist, dv*dist, x1, y1, x2, y2, cl, cl2)
	end
	
	return true
end

function P.SetEffect(t)
	P.Bmp = nil
	sn = t
end

local AutoSnow, AutoOn

local function UpdateAutoSnow(on, keep)
	on, P.Bmp, P.Opacity = on and Map.IsOutdoor(), keep and P.Bmp, keep and P.Opacity
	if on and not AutoOn then
		events.PostRender = AutoSnow
	elseif AutoOn and not on then
		events.remove('PostRender', AutoSnow)
	end
	AutoOn = on
end

events.LoadMap = || UpdateAutoSnow(AutoSnow)

function P.Enable(f)
	local old, f = AutoSnow, f and (|| f(P.DrawSnow, P)) or || P.DrawSnow(Game.Weather.Snow)
	AutoSnow, P.Opacity = f, P.Opacity or 0
	if not old then
		P.Patch()
	else
		events.remove('PostRender', old)
		AutoOn = false
	end
	UpdateAutoSnow(true, true)
end

function P.Disable()
	UpdateAutoSnow()
	AutoSnow = nil
end

return P
