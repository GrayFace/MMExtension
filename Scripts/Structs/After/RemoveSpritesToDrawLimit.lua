local i4, i2, i1, u4, u2, u1 = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1
local mmver = offsets.MMVersion

local function mmv(...)
	local ret = select(mmver - 5, ...)
	assert(ret ~= nil)
	return ret
end

local OldCount = 500+1
local OldPtr = mmv(0x4D6B38, 0x5120D0, 0x5239B0)
local NewBlock
local size = mmv(0x20, 0x34, 0x34)
OldPtr = OldPtr - size  -- also need an item for index -1

local counts = mmv(
	{0x4338AA+1, 0x433D10+2, 0x43421D+1, 0x46ABDF+1, 0x46B099+1, 0x46B526+2},
	{0x43FC71+1, 0x44003B+1, 0x4404C8+6, 0x47AE67+6, 0x47B346+6, 0x47B90F+1},
	{0x43CBF6, 0x43CF98, 0x43D432, 0x47A0F6, 0x47A614, 0x47ABF7, 0x4C1038}
)
local refs = mmv(
	{0x4331BA, 0x4338A6, 0x433D0C, 0x433EC1, 0x434841, 0x46ABF7, 0x46AD31, 0x46B522, 0x46B6AE},
	
	{0x43F545, 0x43FC6D, 0x440037, 0x440366, 0x440D35, 0x46A808, 0x47AE83, 0x47AFBF, 0x47B90B, 0x47BB34, 0x4C06CC, 0x4C0730, 0x4C08E7, 0x4C1294, 0x4C129D, 0x4C153E},
	
	{0x43C44B, 0x43CBF1, 0x43CF93, 0x43D2CB, 0x43DC81, 0x468BDE, 0x468DA7, 0x47A111, 0x47A288, 0x47ABF2, 0x47AE23, 0x4BE2B0, 0x4BE31E, 0x4BE4DB, 0x4BEDFE, 0x4BEE07, 0x4BF09E, 0x4C1062}
)

local function Process(t, d)
	for _, p in ipairs(t) do
		u4[p] = u4[p] + d
	end
end

--!-
function SetSpritesToDrawLimit(NewCount)
	NewCount = NewCount + 1
	if NewCount <= OldCount then
		return
	end
	mem.IgnoreProtection(true)
	NewBlock = ffi.new("uint8_t[?]", size*NewCount)
	mem.fill(ffi.cast("int", NewBlock), NewCount)
	Process(counts, NewCount - OldCount)
	Process(refs, ffi.cast("int", NewBlock) - OldPtr)
	OldCount = NewCount
	OldPtr = ffi.cast("int", NewBlock)
	mem.IgnoreProtection(false)
end

SetSpritesToDrawLimit(3000)