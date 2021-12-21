-- 128 models outdoor / 8192 facets indoor is too restricting
-- This script extends that to x4 of the amounts

local mmver = offsets.MMVersion
if mmver < 7 then
	return
end

FacetRefsLimit = 0x8000

local _KNOWNGLOBALS = Game
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, i8, u8 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.i8, mem.u8

local function mm78(...)
	return (select(mmver - 5, nil, ...))
end

--[[
Only facets may reach indeces above 4096, so repack facets:
high-order bit 0x8000 indicates it's a facet, other bits contain facet index.
Other ObjRefs remain unchanged.
]]

local refs = {
	[""] = "%",
	RealRef = mem.StaticAlloc(4),
	MyRefs = mem.StaticAlloc(640*480*4),
	ZBufRefs = mm78(0xE31A9C, 0xF019B4),
	RefsSize = 640*480*4,
}

local function patch(p, code, size)
	mem.asmpatch(p, code:gsub("%%(%w*)%%", refs), size)
end

local function hook1(p, code, size)
	mem.asmhook(p, code:gsub("%%(%w*)%%", refs), size)
end

local function hook2(p, code, size)
	mem.asmhook2(p, code:gsub("%%(%w*)%%", refs), size)
end

-- Store D3D
patch(mm78(0x4C0D11, 0x4BE89A), [[
	or ax, 0x8000
]])

patch(mm78(0x4C0DF8, 0x4BE982), [[
	or ax, 0x8000
]])

if mmver == 7 then
	patch(0x4C16F1, [[
		or cx, 0x8000
		xor ax, ax
	]], 9)
else
	patch(0x4BF297, [[
		or cx, 0x8000
	]])
end

patch(mm78(0x4C184A, 0x4BF3EA), [[
	or cx, 0x8000
]])

hook2(mm78(0x4C107C, 0x4BEC07), [[
	and eax, 0x7FFF
	shr eax, 6
]], 3)

-- Store indoor SW
patch(mm78(0x4AE595, 0x4AC94C), [[
	or ax, 0x8000
]])

hook1(mm78(0x4ADC81, 0x4AC035), [[
	lea eax, [ecx + 0x8000]
	mov [0xF8ABA8*mm7 + 0xFFCFB0*mm8], eax
]])

-- Store ourdoor SW
patch(mm78(0x47880B, 0x4772B5), [[
	or ax, 0x8000
]])

if mmver == 8 then
	patch(0x47778C, [[
		or ax, 0x8000
	]])
end

patch(mm78(0x478CB4, 0x477BE5), [[
	or ax, 0x8000
]])

-- Render done
-- fill FacetRefs, return ZBufRefs to its traditional form

hook2(mm78(0x440F2C, 0x43DE78), [[
	xor ecx, ecx
	cmp [0xE31AF0*mm7 + 0xF01A08*mm8], ecx  ; is D3D?
	jnz @done
	mov edi, [%ZBufRefs%]
@loop:	
	mov eax, [ecx + edi]
	mov [ecx + %MyRefs%], eax
	test ax, 0x8000
	jz @next
	shl ax, 3
	or al, 6
	mov [ecx + edi], eax
@next:
	add ecx, 4
	cmp ecx, %RefsSize%
	jnz @loop
@done:	
]])

-- D3D result
-- set RealRef, return result in traditional form

hook2(mm78(0x4C1B2F, 0x4BF6D9), [[
	mov edx, eax
	and edx, 0x7FFF
	test ax, 0x8000
	jz @next
	shl edx, 3
	or dl, 6
	mov ax, dx
@next:
	mov [%RealRef%], edx
	leave
	ret 4
]], 3)

-- With hooks above all standard maps should work fine already

-- ObjectByPixel
-- set RealRef

local ObjectByPixelHook = [[
	savereg edx
	mov edx, [ecx+eax*4]
	xor edx, 6
	test edx, 7
	jnz @std
	; facet:
	mov edx, [%MyRefs% + eax*4]
	and edx, 0x7FFF
	shl edx, 3
	or dl, 6
	jmp @store
@std:
	xor edx, 6
	and edx, 0xFFFF
@store:
	mov [%RealRef%], edx
]]

local hooks = mm78({0x433111, 0x433D9A, 0x434F9D}, {0x4212CE, 0x43097E, 0x4315E9, 0x432924})

for _, p in ipairs(hooks) do
	hook2(p, ObjectByPixelHook)
end

if mmver == 7 then
	hook2(0x422140, ObjectByPixelHook, 9)
end
hook2(mm78(0x4211FD, 0x420624), ObjectByPixelHook, 8)

-- Use RealRef for facets

patch(mm78(0x42120E, 0x420635), [[
	mov edx, [%RealRef%]
	; !!! tmp
	;cmp dx, ax
	;jz @f
	;int 3
	mov dx, ax
@@:
]])

patch(mm78(0x42217C, 0x42130D), [[
	mov eax, [%RealRef%]
	shr eax, 3
]])

local eaxReal = [[
	mov eax, [%RealRef%]
]]

patch(mm78(0x43311A, 0x430987), eaxReal)

if mmver == 7 then
	patch(0x433DA5, eaxReal)
else
	patch(0x4315F4, [[
		mov esi, [%RealRef%]
	]])
end

patch(mm78(0x434FA6, 0x43292E), eaxReal)

-- ObjectByPixel iteration routines (2 special cases)

-- on space press:

patch(mm78(0x46A200, 0x468570), [[
	mov eax, %MyRefs%
]])

hook2(mm78(0x46A241, 0x4685B1), [[
	and ecx, 0x8007
]], 2)

patch(mm78(0x46A320, 0x468690), [[
	mov eax, ecx
	and ecx, 0x7FFF
	test eax, 0x8000
	jz @std
	shl ecx, 3
	or cl, 6
@std:
	mov [%RealRef%], ecx
]])

-- because mm8patch calls the function passing a fake ref
hook1(mm78(0x46A339, 0x4686A9), [[
	mov ecx, [%RealRef%]
]])

-- 468F2F:

patch(mm78(0x46A9FA, 0x468F2F), [[
	mov eax, %MyRefs%
]])

patch(mm78(0x46AA3C, 0x468F78), [[
	cmp edi, ebx
	jz @stay
	xor eax, eax
@stay:
	test eax, 0x8007
]])

patch(mm78(0x46AAD6, 0x469010), [[
	mov eax, esi
	and esi, 0x7FFF
	test eax, 0x8000
	jz @std
	shl esi, 3
	add esi, 6
@std:
]])


-- MMExt structures

local function MyRef(p)
	p = p - u4[refs.ZBufRefs]
	if p >= 0 and p < refs.RefsSize then
		return p + refs.MyRefs
	end
	-- error("unknown structure used an ObjectRef declaration")
end

local ObjectRef = structs.f.ObjectRef
function structs.f.ObjectRef(define, ...)
	ObjectRef(define, ...)
	define.members.Value = nil
	define.members.Kind = nil
	define.members.Index = nil
	define
	[0].CustomType('Value', 2, function(o, obj, _, val)
		local p = obj["?ptr"] + o
		local p1 = MyRef(p)
		if val == nil then
			local v = u2[p1 or p]
			if p1 and v >= 0x8000 then
				return (v - 0x8000)*8 + 6
			end
			return v
		else
			u2[p] = val
			if p1 and val % 8 ~= 6 then
				u2[p1] = val
			elseif p1 then
				u2[p1] = val:div(8) + 0x8000
			end
		end
	end)
	[0].CustomType('Kind', 0, function(o, obj, _, val)
		if val == nil then
			return obj.Value%8
		else
			obj.Value = obj.Value:AndNot(7) + val%8
		end
	end)
	[0].CustomType('Index', 2, function(o, obj, _, val)
		if val == nil then
			return obj.Value:div(8)
		else
			obj.Value = obj.Value%8 + math.floor(val)*8
		end
	end)
end

function events.StructsLoaded()
	structs.f.ObjectRef = ObjectRef
	structs.ObjectRef = nil
end


local MTargetBuf, MTargetBufStd, MTarget

local function ObjectRefMouse(define, ...)
	ObjectRef(define, ...)
	define.members.Value = nil
	define.members.Kind = nil
	define.members.Index = nil
	define
	[0].CustomType('Value', 2, function(o, obj, _, val)
		local p = obj["?ptr"] + o
		if val == nil then
			return u4[MTargetBuf]
		else
			u4[MTargetBuf] = val
		end
	end)
	[0].CustomType('Kind', 0, function(o, obj, _, val)
		if val == nil then
			return u4[MTargetBuf]%8
		else
			u4[MTargetBuf] = u4[MTargetBuf]:AndNot(7) + val%8
		end
	end)
	[0].CustomType('Index', 2, function(o, obj, _, val)
		if val == nil then
			return u4[MTargetBuf]:div(8)
		else
			u4[MTargetBuf] = u4[MTargetBuf]%8 + math.floor(val)*8
		end
	end)
end

local GameMouse = structs.f.GameMouse
function structs.f.GameMouse(define, ...)
	GameMouse(define, ...)
	local GetRef = mm78(0x4C1B63, 0x4BF70D)
	local pCGame = mm78(0x71FE94, 0x75CE00)
	function define.class.GetTarget()
		if Game.RendererD3D ~= 0 then
			MTargetBuf = MTargetBuf or mem.StaticAlloc(8)
			MTargetBufStd = MTargetBuf + 4
			MTarget = MTarget or mem.struct(ObjectRefMouse):new(MTargetBufStd)
			i4[MTargetBufStd] = mem.call(GetRef, 1, u4[u4[pCGame] + 3660])
			i4[MTargetBuf] = i4[refs.RealRef]
			return MTarget
		end
		local mouse = Game.Mouse
		return Game.ObjectByPixel[mouse.Y][mouse.X]
	end
end
