Editor = Editor or {}
local _KNOWNGLOBALS

local mmver = offsets.MMVersion
if mmver < 7 or Game.RendererD3D == 0 or Editor.UpdateVisibility then
	function Editor.UpdateVisibility()
	end
	return
end

local i4, i2, i1, u4, u2, u1, pchar = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar

local function mm78(a, b)
	return mmver == 7 and a or b
end

local addr = mm78(0x47F8D2, 0x47F0CD)
local CodeStd = mem.string(addr, 6, true)

if CodeStd == "\15\135\52\6\0\0" then
	HookManager{m7 = 8 - mmver, m8 = mmver - 7}.asmpatch(addr, [[
	  push ecx
	  push edi
	  push ebx  ; X-Y swap

	  xor ebx, ebx
		mov ecx, dword [ebp - 0x58]
	  test ecx, ecx
	  jz @NoSwap
	  cmp ecx, 3
	  jz @NoSwap
	  cmp ecx, 4
	  jz @NoSwap
	  cmp ecx, 7
	  jz @NoSwap
	  ; swap X and Y
	  mov ebx, 0x7ABA10 - 0x7AB810
	@NoSwap:

		lea edi, [%m7%*0x76D848 + %m8%*0x7AB810 + ebx]  ; beginy
		mov ecx, (0x7ABA10 - 0x7AB810)/4
		mov eax, 2
		rep stosd

		lea edi, [%m7%*0x76D448 + %m8%*0x7AB410 + ebx]  ; endy
		mov ecx, (0x7AB610 - 0x7AB410)/4
		mov eax, 125
		rep stosd

	  neg ebx
	  add ebx, %m7%*0x76DA48 + %m8%*0x7ABA10 + 4  ; beginx
		mov ecx, 127
	@loop:
		dec ecx
		mov [ebx + ecx*4], ecx
		jnz @loop

	  pop ebx
		pop edi
	  pop ecx
		mov eax, 128
		jmp absolute %m7%*0x47FF0C + %m8%*0x47F707
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
end

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
	
	set(mm78(0x6BDEFC, 0x6F3004), Editor.TileBrushSize == 0 and 15000 or 25000)
	if full then
		if on or last[mm78(0x6BDF84, 0x6F308C)] then
			-- set(0x6F3084, 200)
			-- set(0x6F3088, 200)
			set(mm78(0x6BDF84, 0x6F308C), 200)
			-- set(0x4800DF, 0x9090, u2)
			-- set(0x4808F2, 0xEB, u1)
			if Map.IsOutdoor() then
				mem.call(mm78(0x4666D9, 0x464A86), 0)
			end
		end
		
		if CodeStd ~= CodeMine then
			mem.copy(addr, on and CodeMine or CodeStd, 6)
		end
	end
	mem.IgnoreProtection(false)
end

Editor.UpdateVisibility(true)
