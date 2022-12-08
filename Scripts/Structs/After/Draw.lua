local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, r4, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.r4, mem.pchar, mem.call

local function mwrite(p, a, v, ...)
	if v then
		a[p] = v
		return mwrite(p + 4, a, ...)
	end
	return p
end

local function D3DTLVertex(p, x, y, cl, u, v)
	p = mwrite(p, r4, x, y, 0, 1)
	p = mwrite(p, i4, cl, 0)
	return mwrite(p, r4, u, v)
end

local poly

function DrawScreenEffectD3D(BitmapIndex, u, v, du, dv, x1, y1, x2, y2, cl, cl2, cl3, cl4)
	if not Game.IsD3D then
		return
	end
	poly = poly or mem.allocMM(4*4*8)
	local p = poly
	cl = cl or 0xFFFFFF
	cl2 = cl2 or cl
	p = D3DTLVertex(p, x1, y1, cl, u, v)
	p = D3DTLVertex(p, x1, y2, cl2, u, v + dv)
	p = D3DTLVertex(p, x2, y2, cl3 or cl2, u + du, v + dv)
	p = D3DTLVertex(p, x2, y1, cl4 or cl, u + du, v)
	local dev = u4[Game.RendererD3D + 56]
	local vt = u4[dev]
	local SetTexture = u4[vt + 152]
	local SetRenderState = u4[vt + 88]
	local DrawPrimitive = u4[vt + 112]
	local SetTextureStageState = u4[vt + 0xA0]
	call(SetTextureStageState, 0, dev, 0, 12, 1)  -- D3DTSS_ADDRESS = D3DTADDRESS_WRAP
	call(SetTexture, 0, dev, 0, Game.BitmapsLod.D3D_Textures[BitmapIndex])
	
	call(SetRenderState, 0, dev, 28, 0)  -- D3DRENDERSTATE_FOGENABLE
	call(SetRenderState, 0, dev, 27, 1)  -- D3DRENDERSTATE_ALPHABLENDENABLE
	call(SetRenderState, 0, dev, 14, 0)  -- D3DRENDERSTATE_ZWRITEENABLE
	call(SetRenderState, 0, dev, 19, 2)  -- D3DRENDERSTATE_SRCBLEND
	call(SetRenderState, 0, dev, 20, 2)  -- D3DRENDERSTATE_DESTBLEND
	call(SetRenderState, 0, dev, 26, 0)  -- D3DRENDERSTATE_DITHERENABLE
	call(SetRenderState, 0, dev, 23, 8)  -- D3DRENDERSTATE_ZFUNC
	call(DrawPrimitive, 0, dev, 6, 452, poly, 4, 28)
	call(SetRenderState, 0, dev, 19, 2)  -- D3DRENDERSTATE_SRCBLEND
	call(SetRenderState, 0, dev, 20, 1)  -- D3DRENDERSTATE_DESTBLEND
	call(SetRenderState, 0, dev, 27, 0)  -- D3DRENDERSTATE_ALPHABLENDENABLE
	call(SetRenderState, 0, dev, 14, 1)  -- D3DRENDERSTATE_ZWRITEENABLE
	call(SetRenderState, 0, dev, 26, 1)  -- D3DRENDERSTATE_DITHERENABLE
	call(SetRenderState, 0, dev, 23, 2)  -- D3DRENDERSTATE_ZFUNC
end
