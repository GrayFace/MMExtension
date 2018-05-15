-- interface:
PalettesInfo = {
	Count = PalettesInfo and PalettesInfo.Count or 200,  -- new maximum number of palettes
	-- PtrGetBW  ->  void* __fastcall GetBW(int palID)
	--  calling:  return mem.call(PalettesInfo.PtrGetBW, 2, palID)
	-- PtrGetRed in MM6 (similar)
	-- shades of other colors are obtained using traditional means
}

local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1

local mmver = offsets.MMVersion
local function mmv(...)
	return (select(mmver - 5, ...))
end

function events.ScriptsLoaded()
	local PalettesCount = PalettesInfo.Count
	-- Instead of default 50 palettes we'll make N consequent blocks of 50 palettes each
	local BlocksCount = (PalettesCount + 49):div(50)
	-- if BlocksCount <= 1 then
	-- 	return
	-- end
	local PalBlockIndex = mmv(106, 154, 154)
	local PalBlockSize = PalBlockIndex*0x4000

	local OldPalettes = mmv(0x762D80, 0x80D018, 0x84AFE0)
	-- div is unusual here. (-5):div(10) = -1
	local BasePalBlock = (mem.malloc((BlocksCount + 1)*PalBlockSize) + 0x3FFF - OldPalettes):div(0x4000)
	local NewPalettes = OldPalettes + BasePalBlock*0x4000
	local NewPalettesEnd = NewPalettes + BlocksCount*PalBlockSize
	mem.fill(NewPalettes, BlocksCount*PalBlockSize, 0)

	local IDOff = mmv(0x1A5E00, 0x267A00, 0x267A00)
	local MistColorOff = mmv(0x1A5ED0, 0x267AD0, 0x267AD0)


	local refs = {
		[""] = "%",
		BasePalBlock = BasePalBlock,
		PalBlockSize = PalBlockSize,
		PalBlockIndex = PalBlockIndex,
		NewPalettes = NewPalettes,
	}

	local function c(code)
		return (code:gsub("%%(%w*)%%", refs))
	end

	-- pointers to BW (and Red in MM6)
	-- local function GetOffsetBW(i)
	-- 	i = i - BasePalBlock
	-- 	return i:div(PalBlockIndex)*PalBlockSize + (i % PalBlockIndex)*0x200
	-- end

	-- in Asm
	refs.GetPtrBW = c[[
	macro GetPtrBW REG, OFF, REGOUT
	{
		lea eax, [REG - %BasePalBlock%]
		xor edx, edx
		mov ecx, %PalBlockIndex%
		idiv ecx       ; eax = i:div(PalBlockIndex)
		mov ecx, edx   ; ecx = (i % PalBlockIndex)
		mov edx, %PalBlockSize%
		imul edx       ; eax = i:div(PalBlockIndex)*PalBlockSize
		sal ecx, 9     ; ecx = (i % PalBlockIndex)*0x200
		if REGOUT eq
			lea REG, [%NewPalettes% + OFF + eax + ecx]
		else
			lea REGOUT, [%NewPalettes% + OFF + eax + ecx]
		end if
	}
	GetPtrBW]]

	if mmver == 6 then
		-- BW
		mem.asmpatch(0x434894, c[[
			savereg eax, edx
			%GetPtrBW% ecx, 0x199600
		]])

		mem.asmpatch(0x46B70A, c[[
			savereg eax, ecx
			%GetPtrBW% edx, 0x199600
		]])
		
		-- Red
		mem.asmpatch(0x46B773, c[[
			pop esi
			%GetPtrBW% eax, 0x19FA00
		]])
		
		mem.asmpatch(0x46B90A, c[[
			%GetPtrBW% eax, 0x19FA00
		]])
		
		-- for use in Lua
		PalettesInfo.PtrGetBW = mem.asmproc(c[[
			%GetPtrBW% ecx, 0x199600, eax
			ret
		]])
		
		PalettesInfo.PtrGetRed = mem.asmproc(c[[
			%GetPtrBW% ecx, 0x19FA00, eax
			ret
		]])
		
	else

		local CodeBW = c[[
			savereg edx, ecx
			%GetPtrBW% eax, 0x261600
		]]
		
		mem.asmpatch(mmv(nil, 0x440DC0, 0x43DD0C), CodeBW)
		mem.asmpatch(mmv(nil, 0x47BBDC, 0x47AECB), CodeBW)
		
		-- for use in Lua
		PalettesInfo.PtrGetBW = mem.asmproc(c[[
			%GetPtrBW% ecx, 0x261600, eax
			ret
		]])
	end

	-- not in Asm
	-- if mmver == 6 then
		-- -- Red
		-- mem.hook(0x434894, function(d)
			-- d.ecx = NewPalettes + 0x199600 + GetOffsetBW(d.ecx)
		-- end)

		-- mem.hook(0x46B70A, function(d)
			-- d.edx = NewPalettes + 0x199600 + GetOffsetBW(d.edx)
		-- end)
		
		-- -- BW
		-- mem.hook(0x46B777, function(d)
			-- d.eax = NewPalettes + 0x19FA00 + GetOffsetBW(d.eax/512)
		-- end)

		-- mem.hook(0x46B90A, function(d)
			-- d.eax = NewPalettes + 0x19FA00 + GetOffsetBW(d.eax)
		-- end)
		
	-- else

		-- local function BWHook(d)
			-- d.eax = NewPalettes + 0x261600 + GetOffsetBW(d.eax/0x200)
		-- end

		-- mem.hook(mmv(nil, 0x440DC3, 0x43DD0F), BWHook)
		-- mem.hook(mmv(nil, 0x47BBDC, 0x47AECE), BWHook)
	-- end


	-- copy mist/tint colors
	local function CopyMist(a)
		mem.copy(a + MistColorOff, OldPalettes + MistColorOff, 0x20)
	end

	-- functions that should run for each block
	local function Batcher(ptr)
		local size = mem.GetHookSize(ptr)
		local std = mem.copycode(ptr, size)
		mem.hook(ptr, function(d)
			if d.ecx == OldPalettes then
				d.ecx = NewPalettes
			end
			CopyMist(d.ecx)
			local a = d.ecx + PalBlockSize
			if a < NewPalettesEnd then
				mem.call(ptr, 1, a)
			end
			mem.u4[d.esp] = std
		end, size)
	end

	if mmver == 6 then
		Batcher(0x47CD80)
		Batcher(0x47CB70)
		Batcher(0x47D0E0)
		Batcher(0x47D0B0)
		-- 47C400 isn't used
	elseif mmver == 7 then
		Batcher(0x48A5FA)
		Batcher(0x48A31C)
		Batcher(0x48A35F)
		Batcher(0x48A8B2)
		Batcher(0x48A889)
		Batcher(0x48A2E6)
	elseif mmver == 8 then
		Batcher(0x489EF2)
		Batcher(0x489C19)
		Batcher(0x489C5C)
		Batcher(0x48A1AA)
		Batcher(0x48A181)
		Batcher(0x489BE3)
	end


	-- LoadPalette
	local function FindInPals(id)
		for p = NewPalettes, NewPalettesEnd - 1, PalBlockSize do
			for i = 1, 49 do
				if i4[p + IDOff + i*4] == id then
					return p
				end
			end
		end
	end

	local aa = {}
	local load_std = mem.copycode(mmv(0x47CBC0, 0x48A3A2, 0x489C9F), mmv(6, 9, 9))
	mem.hook(mmv(0x47CBC0, 0x48A3A2, 0x489C9F), function(d)
		local id = i4[d.esp + 8]
		local p = FindInPals(id) or FindInPals(0) or NewPalettes
		CopyMist(p)
		d.eax = mem.call(load_std, 1, p, id) + (p - OldPalettes)/0x4000
		d.esp = d.esp + 4
		d:ret(4)
	end, mmv(6, 9, 9))
	
end