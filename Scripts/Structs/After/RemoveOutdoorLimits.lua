local i4, i2, i1, u4, u2, u1, i8, u8 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.i8, mem.u8
local mmver = offsets.MMVersion
mem.IgnoreProtection(true)

local OldCount = 2000
local NewCount = (FacetRefsLimit or 8192) + 6000

if mmver == 6 then

	local PolySize = 84

	local dn = NewCount - OldCount
	local Offset = mem.StaticAlloc(PolySize*NewCount) - 0x6CBBD8
	local Offset2 = mem.StaticAlloc(PolySize*NewCount) - 0x72F8F8

	local counts = {0x4695DD, 0x470B71, 0x470F49, 0x471312, 0x47915C, 0x47999D}
	local refs = {0x4694E1, 0x469C18, 0x469C1E, 0x469C2C, 0x469FB4, 0x469FCA, 0x470A6E, 0x470E92, 0x471267, 0x4717DD, 0x479896, 0x479956}
	local endrefs = {0x469FC2+1, 0x469FD9+1}
	local refs2 = {0x4798A1, 0x4798E4, 0x479951}

	local function Process(t, d)
		for _, p in ipairs(t) do
			u4[p] = u4[p] + d
		end
	end

	Process(counts, dn)
	Process(refs, Offset)
	Process(endrefs, Offset + dn*PolySize)
	Process(refs2, Offset2)

elseif mmver == 7 then

	local PolySize = 268
	local dn = NewCount - OldCount
	local Offset = mem.StaticAlloc(PolySize*NewCount) - 0x77EA88
	local Offset2 = mem.StaticAlloc(4*NewCount) - 0x80A8A8

	local counts = {0x4787B7, 0x478C6A, 0x48062A, 0x480A5B, 0x480E58, 0x4814EC, 0x481802, 0x481ADF, 0x487499}
	local refs = {0x4784D1, 0x478B5F, 0x479363, 0x479385, 0x47A568, 0x47A582, 0x480565, 0x48098D, 0x480D8A, 0x48141D, 0x48171C, 0x4819FF, 0x481EC8, 0x487366, 0x4873AC, 0x48745F, 0x487DAE}
	local endrefs = {0x47A57A+1, 0x47A592+1, 0x487DBA+1}
	local refs2 = {0x4873BD, 0x4873ED, 0x48747A}

	local function Process(t, d)
		for _, p in ipairs(t) do
			u4[p] = u4[p] + d
		end
	end

	Process(counts, dn)
	Process(refs, Offset)
	Process(endrefs, Offset + dn*PolySize)
	Process(refs2, Offset2)

else
	
	local PolySize = 268
	local dn = NewCount - OldCount
	local Offset = mem.StaticAlloc(PolySize*NewCount) - 0x7BCA50
	local Offset2 = mem.StaticAlloc(4*NewCount) - 0x848870

	local counts = {0x477261, 0x477738, 0x477B9B, 0x47FE0F, 0x480234, 0x48064D, 0x480D56, 0x48106E, 0x48134B, 0x4872DF}
	local refs = {0x476F6F, 0x477469, 0x477A90, 0x478294, 0x4782B8, 0x479750, 0x47976A, 0x47FD52, 0x48014A, 0x48057D, 0x480C86, 0x480F86, 0x48126B, 0x481734, 0x486CA6, 0x486CEC, 0x4872AB, 0x4876BF}
	local endrefs = {0x4876CB+1, 0x479762+1, 0x47977A+1}
	local refs2 = {0x486CFD, 0x486D31, 0x4872C5}

	local function Process(t, d)
		for _, p in ipairs(t) do
			u4[p] = u4[p] + d
		end
	end

	Process(counts, dn)
	Process(refs, Offset)
	Process(endrefs, Offset + dn*PolySize)
	Process(refs2, Offset2)

	-- SW limits
	do
		local OldEdgeCount = 6000
		local NewEdgeCount = NewCount*3

		local OldSpansCount = 15000
		local NewSpansCount = OldSpansCount*(NewCount/OldCount)
		
		-- surfs
		local size = 0x24
		local sizes = {0x4863BF, 0x4868A9}
		local counts = {0x4864EC+6}  -- strange: 0x4876F9
		Process(counts, dn)
		Process(sizes, dn*size)
		
		-- edges
		local size = 0x34
		local sizes = {0x4863A2, 0x486823}
		local counts = {0x486502}
		local dn = NewEdgeCount - OldEdgeCount
		Process(counts, dn)
		Process(sizes, dn*size)

		-- spans
		local size = 0x18
		local sizes = {0x486386}
		local counts = {0x486AAB+6, 0x486B94+6}
		local dn = NewSpansCount - OldSpansCount
		Process(counts, dn)
		Process(sizes, dn*size)
	end
	
end

mem.IgnoreProtection(false)
