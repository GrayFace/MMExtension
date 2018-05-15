-- 128 models outdoor / 8192 facets indoor is too restricting
-- This script extends that to x4 of the amounts

if offsets.MMVersion ~= 8 then
	return
end

FacetRefsLimit = 0x8000

local _KNOWNGLOBALS = Game
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, i8, u8 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.i8, mem.u8

--[[
Only facets may reach indeces above 4096, so repack facets:
high-order bit 0x8000 indicates it's a facet, other bits contain facet index.
Other ObjRefs remain unhanged.
]]

local refs = {
	[""] = "%",
	RealRef = mem.StaticAlloc(4),
	MyRefs = mem.StaticAlloc(640*480*4),
	ZBufRefs = 0xF019B4,
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
patch(0x4BE89A, [[
	or ax, 0x8000
]])

patch(0x4BE982, [[
	or ax, 0x8000
]])

patch(0x4BF297, [[
	or cx, 0x8000
]])

patch(0x4BF3EA, [[
	or cx, 0x8000
]])

hook2(0x4BEC07, [[
	and eax, 0x7FFF
	shr eax, 6
]], 3)

-- Store indoor SW
patch(0x4AC94C, [[
	or ax, 0x8000
]])

hook1(0x4AC035, [[
	lea eax, [ecx + 0x8000]
	mov [0xFFCFB0], eax
]])

-- Store ourdoor SW
patch(0x4772B5, [[
	or ax, 0x8000
]])

patch(0x47778C, [[
	or ax, 0x8000
]])

patch(0x477BE5, [[
	or ax, 0x8000
]])

-- Render done
-- fill FacetRefs, return ZBufRefs to its traditional form

hook2(0x43DE78, [[
	xor ecx, ecx
	cmp [0xF01A08], ecx  ; is D3D?
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

hook2(0x4BF6D9, [[
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

local hooks = {0x4212CE, 0x43097E, 0x4315E9, 0x432924}

for _, p in ipairs(hooks) do
	hook2(p, ObjectByPixelHook)
end

hook2(0x420624, ObjectByPixelHook, 8)

-- Use RealRef for facets

patch(0x420635, [[
	mov edx, [%RealRef%]
	; !!! tmp
	cmp dx, ax
	jz @f
	;int 3
	mov dx, ax
@@:
]])

patch(0x42130D, [[
	mov eax, [%RealRef%]
	shr eax, 3
]])

patch(0x430987, [[
	mov eax, [%RealRef%]
]])

patch(0x4315F4, [[
	mov esi, [%RealRef%]
]])

patch(0x43292E, [[
	mov eax, [%RealRef%]
]])

-- ObjectByPixel iteration routines (2 special cases)

-- on space press:

patch(0x468570, [[
	mov eax, %MyRefs%
]])

hook2(0x4685B1, [[
	and ecx, 0x8007
]], 2)

patch(0x468690, [[
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
hook1(0x4686A9, [[
	mov ecx, [%RealRef%]
]])

-- 468F2F:

patch(0x468F2F, [[
	mov eax, %MyRefs%
]])

patch(0x468F78, [[
	cmp edi, ebx
	jz @stay
	xor eax, eax
@stay:
	test eax, 0x8007
]])

patch(0x469010, [[
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
	function define.class.GetTarget()
		if Game.RendererD3D ~= 0 then
			MTargetBuf = MTargetBuf or mem.StaticAlloc(8)
			MTargetBufStd = MTargetBuf + 4
			MTarget = MTarget or mem.struct(ObjectRefMouse):new(MTargetBufStd)
			i4[MTargetBufStd] = mem.call(0x4BF70D, 1, u4[u4[0x75CE00] + 3660])
			i4[MTargetBuf] = i4[refs.RealRef]
			return MTarget
		end
		local mouse = Game.Mouse
		return Game.ObjectByPixel[mouse.Y][mouse.X]
	end
end
