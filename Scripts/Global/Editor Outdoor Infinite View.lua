Editor = Editor or {}
local _KNOWNGLOBALS

if offsets.MMVersion ~= 8 or Game.RendererD3D == 0 then
	function Editor.UpdateVisibility()
	end
	return
end

local i4, i2, i1, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar

if Editor.UpdateVisibility then
	return
end

local addr = 0x47F0CD
local CodeStd = mem.string(addr, 6, true)

mem.asmpatch(addr, [[
	mov dword [ebp - 0x58], 0
	savereg ecx, edi
	
	mov edi, 0x7AB810
	mov ecx, (0x7ABA10 - 0x7AB810)/4
	mov eax, 2
	rep stosd
	
	mov edi, 0x7AB410
	mov ecx, (0x7AB610 - 0x7AB410)/4
	mov eax, 125
	rep stosd
	
	mov ecx, 128
@loop:
	mov [0x7ABA10 + ecx*4], ecx
	dec ecx
	jnz @loop
	
	loadreg
	mov eax, 128
	jmp absolute 0x47F707
]])

-- mem.hook(addr, function(d)
	-- i4[d.ebp - 0x58] = 0
	-- d.eax = 128
	-- for i = 0x7AB810, 0x7ABA10 - 1, 4 do
		-- i4[i] = 2
	-- end
	-- for i = 0x7AB410, 0x7AB610 - 1, 4 do
		-- i4[i] = 125
	-- end
	-- for i = 0, 127 do
		-- i4[0x7ABA10 + i*4] = i
	-- end
	-- u4[d.esp] = 0x47F707
-- end, 6)

local CodeMine = mem.string(addr, 6, true)

local last = {}

function Editor.UpdateVisibility(full)
	local on = Editor.WorkMode
	mem.IgnoreProtection(true)
	local function set(p, v, a)
		a = a or i4
		if on then
			last[p] = last[p] or a[p]
			a[p] = math.max(v, last[p])
		elseif last[p] then
			a[p], last[p] = last[p], nil
		end
	end
	
	set(0x6F3004, Editor.TileBrushSize == 0 and 15000 or 25000)
	if full then
		set(0x6F3084, 200)
		set(0x6F3088, 200)
		set(0x6F308C, 200)
		-- set(0x4800DF, 0x9090, u2)
		-- set(0x4808F2, 0xEB, u1)
		if Map.IsOutdoor() then
			mem.call(0x464A86, 0)
		end
		
		mem.copy(addr, on and CodeMine or CodeStd, 6)
	end
	mem.IgnoreProtection(false)
end

Editor.UpdateVisibility(false)
