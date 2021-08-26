--[=[!File
Together with PaperDoll.lua can be used to create new character portraits and voices, or add them from other games. Unlike PaperDoll.lua, everything here is 0-based. If included, creates and/or loads "Faces.txt" and "Face Animations.txt" data tables.

Including the module:
!LUA[[
local P = require"Faces"
]]

You can add extra columns into "Faces.txt":
!'[[!\ AllowVoice]] - [MM7+] Enable/disable selecting voice on start (if not specified, the value of 'Allow' is used).
!'[[Voice]] - [MM7+] Use specified default voice instead of the one with the same number as the face.
!'[[Expressions]] - Expressions list to use. Default is "Expressions". Use if you combine MM6 faces with faces from other games.
!'[[Sounds]] - Sounds list to use. Default is "Sounds". Use if you combine MM6 voices with faces from other games.
!'[[SoundsOffset]] - This value will be added to the sound id (the one being searched in dsounds.bin). You will need this if you add voices from all 3 games.

Note that 'AllowVoice', 'Female', 'Sounds' and sound counts are properties of voice, the rest are properties of face. If you leave any field empty, the default value would be used.

You can add extra columns into "Face Animations.txt". If their names are valid identifiers, thay would be read as lists. E.g. imagine you've added MM6 characters into another game - then you can add "Expressions6" and "Sounds6" columns there and set 'Expressions' and 'Sounds' columns for these characters to "Expressions6" and "Sounds6" respectively. You would however also need to join PFT.txt files and replace indexes in expressions lists accordingly.

The way animations work: random expression is picked from the list in "Expressions" column of "Face Animations.txt" (or "Expressions6" column in the above example). This number is looked up in PFT.txt and the animation is played. Expression 21 is special - it shows the character speaking the voice line as long as it lasts.
When it comes to voice, sound index is picked at random from the "Sounds" column list (or "Sounds7" in the above example), then sounds count for the voice is looked up and one of the variations of the sound is played. Up to 2 variations are supported.
]=]
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.pchar, mem.call
local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil

--!++(package.loaded.Faces.ExtraFields)v You can define you own functions to read extra fields from Faces.txt

--!++(package.loaded.Faces.Faces)v

--!++(package.loaded.Faces.FaceAnimations)v

--!++(package.loaded.Faces.Update) Call it if you change 'Faces' table manually. Triggers #UpdateFaces:events.UpdateFaces# event.

local P = {ExtraFields = {}}
local Hooked
local Update

-- animations event

local function HookFaceAnimations()
	local function get(anim, faces, s)
		faces = anim[faces and faces[s] or s]
		return faces and faces[1] and faces[Game.Rand() % #faces + 1] or 0
	end
	function events.InternalFaceAnimation(t)
		local anim = P.Animations[t.Animation] or {}
		t.Face = get(anim, P.Faces[t.Player.Face], 'Expressions')
		local sounds = P.Faces[t.Player[is78 and 'Voice' or 'Face']] or {}
		local snd = get(anim, sounds, 'Sounds')
		t.Sound = snd
		t.SoundCount = sounds[snd] or 0
		t.SoundOffset = sounds.SoundsOffset or 0
	end
	HookFaceAnimations = ||
end


-- Faces.txt

local function GetSexRace(i)
	if is6 then
		return i > 7 and 1 or 0
	end
	local pl = Party.PlayersArray[0]
	local old1, old2 = pl.Face, pl.Voice
	pl.Face, pl.Voice = i, i
	local s, r, c = pl:GetSex(), is7 and pl:GetRace(), is8 and pl:GetStartingClass()
	pl.Face, pl.Voice = old1, old2
	return s, r, c
end

local bool = {[false] = '-', [true] = '+'}
local bool2 = {[0] = '-', '+'}
local ibool = table.invert(bool)

local function MakeFaces()
	local irace = is7 and table.invert(const.Race)
	local iclass = is8 and table.invert(const.Class)
	local t = {'#', 'Face', 'Allow', is7 and 'Race' or is8 and 'Class'}
	t[#t+1] = 'Female'  -- property of voice
	t[#t+1] = '(Sounds count:)'
	for k in Game.StandardPlayerSoundsCount do
		t[#t+1] = k
	end
	
	local t = {[0] = t}
	for i, name in Game.PlayerFaces do
		local fem, race, class = GetSexRace(i)
		local q = {
			['#'] = i,
			Face = name,
			Allow = bool[i < (is8 and (Hooked and 24 or i1[0x43385D] + 1) or u1[mmv(0x430518, 0x435F1E)])],
			Female = bool2[fem] or fem,
			Race = irace and irace[race] or race,
			Class = iclass and iclass[class] or class,
		}
		t[i+1] = q
		for k, a in Game.StandardPlayerSoundsCount do
			q[k] = a[i]
		end
	end
	return WriteNamedColTable(t)
end

local rint = |s| s ~= '' and assert(tonumber(s), 'not a number') or nil
local rbool = |s| assert(s == '' or ibool[s] ~= nil, 'not a boolean') and ibool[s]
local rbi = |s| tonumber(s) or rbool(s)
local rstr = |s| s ~= '' and s or nil
local rrace = is7 and (|s| const.Race[s] or rint(s))
local rclass = is8 and (|s| const.Class[s] or rint(s))

local Read = {Allow = rbool, AllowVoice = rbool, Voice = rint, Female = rbi, Race = rrace, Class = rclass, Expressions = rstr, Sounds = rstr, SoundsOffset = rint}

function P.FacesHandler(text)
	text = text or MakeFaces()
	local all = {}
	for i, t in ipairs(ParseNamedColTable(text)) do
		local q = {}
		if t.Face and t.Face ~= '' then
			Game.PlayerFaces.Resize(i)
			Game.PlayerFaces[i - 1] = t.Face
		end
		for s, f in pairs(Read) do
			q[s] = f(t[s] or '')
		end
		if q.AllowVoice == nil then
			q.AllowVoice = q.Allow
		end
		for s, f in pairs(P.ExtraFields) do
			q[s] = f(t[s] or '', q, t, i - 1, s)
		end
		for i = 1, 50 do
			q[i] = rint(t[i..''] or '')
		end
		all[i - 1] = q
	end
	P.Faces = all
	Update(true)
	return text
end


-- Face Animations.txt

local function ToTbl(s)
	local t = {}
	for s in s:gmatch('[^ ,]+') do
		t[#t+1] = assert(tonumber(s), 'not a number')
	end
	return t
end

local function ArrToStr(a)
	local t = {}
	for _, v in a do
		if v ~= 0 then
			t[#t+1] = v
		end
	end
	return table.concat(t, ', ')
end

local function MakeFaceAnimations()
	local t = {{'#', 'Expressions', 'Sounds'}}
	local names = table.invert(const.FaceAnimation)
	for i, a in Game.StandardFaceAnimations do
		local s = names[i]
		t[i + 2] = {(s and i..'  '..s or i), ArrToStr(a.Expressions), ArrToStr(a.Sounds)}
	end
	return WriteBasicTextTable(t)
end

function P.FaceAnimationsHandler(text)
	text = text or MakeFaceAnimations()
	local all = {}
	for i, t in ipairs(ParseNamedColTable(text)) do
		local q = {}
		for s, v in pairs(t) do
			if s:match('[%a_][%w_]*') then
				q[s] = ToTbl(v)
			end
		end
		all[i - 1] = q
	end
	P.Animations = all
	HookFaceAnimations()
	return text
end


-- Update

local function UpdateHooks()
	Hooked = true
	local ref = {}
	local allocs = {'fnext', 'flast', 'sex', is78 and 'vnext', is78 and 'vlast', is78 and 'voice', is7 and 'race' or is8 and 'class'}
	do
		local p = mem.allocMM(#allocs*4)
		for i, s in ipairs(allocs) do
			ref[s] = p + i*4 - 4
		end
	end
	local last = 0
	P.MemRef = ref  -- tmp?
	
	local function resize(p0, k)
		local n = #P.Faces + 1
		local p = u4[p0]
		if n > last then
			p = mem.reallocMM(p, last*(k or 1), n*(k or 1), last == 0)
			u4[p0] = p
		end
		return p
	end
	
	local function WriteNext(p0, i, d, allow)
		local t, p = P.Faces, resize(p0)
		local n, v = #t + 1, i
		for _ = 1, n do
			i = (i + d)%n
			u1[p + i] = v
			v = t[i][allow] and i or v
		end
	end
	
	local function UpdateNext(s, allow)
		for i = 0, #P.Faces do
			if P.Faces[i][allow] then
				WriteNext(ref[s..'next'], i, -1, allow)
				WriteNext(ref[s..'last'], i, 1, allow)
				break
			end
		end
	end
	
	function UpdateHooks()
		UpdateNext('f', 'Allow')
		if is78 then
			UpdateNext('v', 'AllowVoice')
		end
		local sex = resize(ref.sex)
		local race = ref.race and resize(ref.race)
		local class = ref.class and resize(ref.class, 4)
		local voice = ref.voice and resize(ref.voice)
		for i = 0, #P.Faces do
			local t = P.Faces[i]
			u1[sex + i] = t.Female == true and 1 or t.Female or 0
			if race then
				u1[race + i] = t.Race or 0
			end
			if class then
				i4[class + i*4] = t.Class or 4
			end
			if voice then
				u1[voice + i] = t.Voice or i
			end
		end
		last = max(last, #P.Faces + 1)
	end
	UpdateHooks()
	
	-- do the hooks
	ref.Get = [[
		macro Get a, ptr, v
		{
			movzx e#v#x, byte [ptr]
			add e#v#x, [a]
			movzx e#v#x, byte [e#v#x]
			mov [ptr], v#l
		}
		Get ]]

	local hooks = HookManager(ref)
	local patch2 = |p, p2, code| hooks.asmpatch(p, code, p2 - p)

	if is6 then
		-- face-
		patch2(0x4304A7, 0x4304B7, [[
			%Get% %flast%, edi, a
		]])
		-- face+
		patch2(0x43052F, 0x430535, [[
			%Get% %fnext%, esi, d
		]])
		-- set sex
		patch2(0x482CD3, 0x482CE2, [[
			movzx eax, byte [esi]
			add eax, [%sex%]
			mov al, byte [eax]
			mov byte [esi + 0x11], al
		]])
		--!- for PaperDoll
		function structs.Player:GetSex()
			local t = P.Faces[self.Face]
			local b = t and t.Female
			return b == true and 1 or b or 0
		end
	elseif is7 then
		-- face-
		patch2(0x435FD9, 0x435FE3, [[
			%Get% %flast%, eax, d
			add edx, [%voice%]
			movzx eax, byte [edx]
		]])
		-- face+
		patch2(0x435F2E, 0x435F3B, [[
			%Get% %fnext%, ecx, d
			mov eax, [%voice%]
			movzx eax, byte [eax + edx]
		]])
		-- voice-
		patch2(0x435BF6, 0x435C08, [[
			%Get% %vlast%, edi+1920h, d
		]])
		-- voice+
		patch2(0x435B83, 0x435B90, [[
			%Get% %vnext%, edi+1920h, d
		]])
		-- sex
		patch2(0x49013F, 0x49015A, [[
			add ecx, [%sex%]
			movzx eax, byte [ecx]
			ret
		]])
		-- set sex
		patch2(0x4901FC, 0x490216, [[
			add eax, [%sex%]
			mov dl, byte [eax]
		]])
		-- race
		patch2(0x490108, 0x490138, [[
			movzx ecx, cl
			add ecx, [%race%]
			movzx eax, byte [ecx]
			ret
		]])
	elseif is8 then
		mem.nop(0x43392B)
		-- face-
		patch2(0x433924, 0x43392B, [[
			%Get% %flast%, eax, d
			add edx, [%voice%]
			movzx eax, byte [edx]
		]])
		-- face+
		patch2(0x433859, 0x433866, [[
			%Get% %fnext%, eax, d
			add edx, [%voice%]
			movzx eax, byte [edx]
		]])
		-- voice-
		patch2(0x4337E1, 0x4337F3, [[
			%Get% %vlast%, ebp+1BE4h, d
		]])
		-- voice+
		patch2(0x433787, 0x43379C, [[
			%Get% %vnext%, ebp+1BE4h, d
		]])
		-- sex
		patch2(0x48F5E5, 0x48F5FB, [[
			add ecx, [%sex%]
			movzx eax, byte [ecx]
			ret 4
		]])
		-- sex from face
		hooks.asmhook2(0x48F5D6, [[
			movzx ecx, cl
			add ecx, [%voice%]
			movzx ecx, byte [ecx]
		]])
		-- class
		patch2(0x48F559, 0x48F58D, [[
			mov eax, [%class%]
			mov eax, [eax + ecx*4]
			ret
		]])
	end
end

Update = |JustRead| if P.Faces[0] then
	-- Triggered when "Faces.txt" is read or when #Update:package.loaded.Faces.Update# is called.
	events.cocall("BeforeUpdateFaces", JustRead)
	UpdateHooks()
	-- Triggered after the changes to Faces were applied.
	events.cocall("AfterUpdateFaces", JustRead)
end

P.Update = || Update()


DataTables.Handlers['Faces'] = P.FacesHandler
DataTables.Handlers['Face Animations'] = P.FaceAnimationsHandler


return P