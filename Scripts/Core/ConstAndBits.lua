local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil
local is67 = mmver < 8 or nil
local m6 = is6 and 1 or 0
local m7 = is7 and 1 or 0
local m8 = is8 and 1 or 0

const = const or {}
Const = const

local _KNOWNGLOBALS

do
	offsets.PatchDll = offsets.PatchDll or mem.dll[AppPath.."mm"..internal.MMVersion.."patch"] or {}
	local PatchOptionsPtr = offsets.PatchDll.GetOptions
	offsets.PatchOptionsSize = PatchOptionsPtr and mem.i4[PatchOptionsPtr()] or 0
end
local PatchOptionsSize = offsets.PatchOptionsSize  -- Game.PatchOptions.Size
 
const.Novice = 1
const.Expert = 2
const.Master = 3
if mmver ~= 6 then
	const.GM = 4
end
const.MapLimit = 22528

const.Minute = 256  -- each in-game minute amounts to 2 seconds of real time
const.RTSecond = 128  -- second in real time
const.Second = const.Minute/60
const.Hour = const.Minute*60
const.Day = const.Hour*24
const.Week = const.Day*7
const.Month = const.Week*4
const.Year = const.Month*12

local function MakeBitsDefiner(name)
	internal[name] = function(define)
		for n, b in pairs(const[name]) do
			define.bit(n, b)
		end
		return define
	end
end

MakeBitsDefiner("FacetBits")
const.FacetBits = {
	IsPortal = 0x00000001,
	IsWater = 0x00000010,
	ProjectToXY = 0x00000100,
	ProjectToXZ = 0x00000200,
	ProjectToYZ = 0x00000400,
	Invisible = 0x00002000,
	AnimatedTFT = 0x00004000,
	MoveByDoor = 0x00040000,
	--TriggerByTouch = 0x00080000,  -- doesn't work anymore
	IsEventJustHint = 0x00100000,  -- [MM7+]
	AlternativeSound = 0x00200000,
	IsSky = 0x00400000,  -- outdoor in software mode: horizontal flow
	FlipU = 0x00800000,
	FlipV = 0x01000000,
	TriggerByClick = 0x02000000,
	TriggerByStep = 0x04000000,
	Untouchable = 0x20000000,  -- great for vertical facets of stairs. [MM7+] Shouldn't be used for sloped floor, like it's used in MM6.
	IsLava = 0x40000000,
	HasData = 0x80000000,
}

if mmver > 6 then
	table.copy({
		IsSecret = 0x00000002,  -- show in red with Perception
		ScrollDown = 0x00000004,  -- moving texture
		ScrollUp = 0x00000020,  -- moving texture
		ScrollLeft = 0x00000040,  -- moving texture
		ScrollRight = 0x00000800,  -- moving texture
		AlignTop = 0x00000008,  -- align door texture in D3D
		AlignLeft = 0x00001000,  -- align door texture in D3D
		AlignRight = 0x00008000,  -- align door texture in D3D
		AlignBottom = 0x00020000,  -- align door texture in D3D
	}, const.FacetBits, true)
end
if mmver < 8 then
	table.copy({
		TriggerByMonster = 0x08000000,  -- happens even if there's no event assigned
		TriggerByObject = 0x10000000,  -- happens even if there's no event assigned
	}, const.FacetBits, true)
else
	table.copy({
		DisableEventByCtrlClick = 0x08000000,  -- indoor only: click event gets disabled by Ctrl+Click
		EventDisabledByCtrlClick = 0x10000000,
	}, const.FacetBits, true)
end

MakeBitsDefiner("SpriteBits")
const.SpriteBits = {
	TriggerByTouch = 0x0001,  -- only for "Event Trigger" sprites - triggered when a player comes into 'TriggerRadius'
	TriggerByMonster = 0x0002,  -- only for "Event Trigger" sprites - triggered when a monster comes into 'TriggerRadius'
	TriggerByObject = 0x0004,  -- only for "Event Trigger" sprites - triggered when an object gets into 'TriggerRadius'
	ShowOnMap = 0x0008,
	IsChest = 0x0010,
	Invisible = 0x0020,
	[mmver == 6 and "IsShip" or "IsObeliskChest"] = 0x0040,
}

MakeBitsDefiner("ChestBits")
const.ChestBits = {
	Trapped = 1,
	ItemsPlaced = 2,
	Identified = 4,
}

MakeBitsDefiner("MonsterBits")
const.MonsterBits = {
	Active = 0x00000400,  -- inside the active radius
	ShowOnMap = 0x00008000,  -- monster was once seen by party
	Invisible = 0x00010000,
	NoFlee = 0x00020000,
	Hostile = 0x00080000,
	OnAlertMap = 0x00100000,
	TreasureGenerated = 0x00800000,  -- treasure is in 'Items'[0] and 'Items'[1], gold is in 'Items'[3]
	ShowAsHostile = 0x01000000,  -- show as hostile on map
}
if mmver == 8 then
	const.MonsterBits.IsObeliskChest = 0x02000000
end

const.AIState = {
	Stand = 0,
	Active = 1,
	MeleeAttack = 2,
	RangedAttack = 3,
	Dying = 4,
	Dead = 5,
	Pursue = 6,
	Flee = 7,
	Stunned = 8,
	Fidget = 9,
	Interact = 10,
	Removed = 11,
	RangedAttack2 = 12,
	CastSpell = 13,
	Stoned = 14,
	Paralyzed = 15,
	Resurrect = 16,
	Summoned = 17,
	RangedAttack4 = 18,
	Invisible = 19,
}

const.MonsterBonus = {
  Curse         = 1,
  Weak          = 2,
  Asleep        = 3,
  Drunk         = 4,
  Insane        = 5,
  Poison1       = 6,
  Poison2       = 7,
  Poison3       = 8,
  Disease1      = 9,
  Disease2      = 10,
  Disease3      = 11,
  Paralyze      = 12,
  Uncon         = 13,
  Dead          = 14,
  Stone         = 15,
  Errad         = 16,
  Brkitem       = 17,
  Brkarmor      = 18,
  Brkweapon     = 19,
  Steal         = 20,
  Age           = 21,
  Drainsp       = 22,
  Afraid        = 23,
}

MakeBitsDefiner("MonsterPref")

if mmver == 6 then

	const.MonsterPref = {
		Knight = 0x0001,
		Paladin = 0x0002,
		Archer = 0x0004,
		Druid = 0x0008,
		Cleric = 0x0010,
		Sorcerer = 0x0020,
		Male = 0x0040,
		Female = 0x0080,
	}

elseif mmver == 7 then

	const.MonsterPref = {
		Knight = 0x0001,
		Paladin = 0x0002,
		Archer = 0x0004,
		Druid = 0x0008,
		Cleric = 0x0010,
		Sorcerer = 0x0020,
		Ranger = 0x0040,
		Thief = 0x0080,
		Monk = 0x0100,
		Male = 0x0200,  -- in monsters.txt it's "M" in MM6 and "X" in MM7 and MM8
		Female = 0x0400,
		Human = 0x0800,
		Elf = 0x1000,
		Dwarf = 0x2000,
		Goblin = 0x4000,
	}

else

	const.MonsterPref = {
		Necro = 0x0001,
		Cleric = 0x0002,
		Knight = 0x0004,
		Troll = 0x0008,
		Minotaur = 0x0010,
		DarkElf = 0x0020,
		Vampire = 0x0040,
		Dragon = 0x0080,
		Male = 0x0100,
		Female = 0x0200,
	}

end

if mmver == 8 then
	const.MonsterImmune = 65000
else
	const.MonsterImmune = 200
end

if mmver == 7 then
	const.MonsterKind = {
		Undead = 1,
		Demon = 2,
		Dragon = 3,
		Elf = 4,
		Swimmer = 5,
		Immobile = 6,
		Titan = 7,
		NoArena = 8,
	}
elseif mmver == 8 then
	const.MonsterKind = {
		Undead = 1,
		Dragon = 2,
		Swimmer = 3,
		Immobile = 4,
		Peasant = 5,
		NoArena = 6,
		Ogre = 7,
		Elemental = 8,
	}
end

const.MonsterAction = {
	Attack1 = 0,
	Attack2 = 1,
	Spell1 = 2,
	Spell2 = mmver > 6 and 3 or nil,
}

const.ObjectRefKind = {
	Nothing = 0,
	Door = 1,
	Object = 2,
	Monster = 3,
	Party = 4, -- Index is player index in #Party.PlayersArray:structs.GameParty.PlayersArray#
	Sprite = 5,
	Facet = 6, -- Outdoors Index = ModelId*64 + FaceId
	Light = 7,
}

const.Keys = {
	LBUTTON = 1,
	RBUTTON = 2,
	CANCEL = 3,
	MBUTTON = 4,  -- NOT contiguous with L & RBUTTON
	XBUTTON1 = 5,
	XBUTTON2 = 6,
	BACK = 8,
	BACKSPACE = 8,
	TAB = 9,
	CLEAR = 12,
	RETURN = 13,
	ENTER = 13,
	SHIFT = 16,
	CONTROL = 17,
	CTRL = 17,
	MENU = 18,
	ALT = 18,
	PAUSE = 19,
	CAPITAL = 20,
	CAPSLOCK = 20,
	KANA = 21,
	HANGUL = 21,
	JUNJA = 23,
	FINAL = 24,
	HANJA = 25,
	KANJI = 25,
	CONVERT = 28,
	NONCONVERT = 29,
	ACCEPT = 30,
	MODECHANGE = 31,
	ESCAPE = 27,
	SPACE = 32,
	PRIOR = 33,
	PGUP = 33,
	NEXT = 34,
	PGDN = 34,
	END = 35,
	HOME = 36,
	LEFT = 37,
	UP = 38,
	RIGHT = 39,
	DOWN = 40,
	SELECT = 41,
	PRINT = 42,
	EXECUTE = 43,
	SNAPSHOT = 44,
	INSERT = 45,
	DELETE = 46,
	HELP = 47,
	LWIN = 91,
	RWIN = 92,
	APPS = 93,
	SLEEP = 95,
	NUMPAD0 = 96,
	NUMPAD1 = 97,
	NUMPAD2 = 98,
	NUMPAD3 = 99,
	NUMPAD4 = 100,
	NUMPAD5 = 101,
	NUMPAD6 = 102,
	NUMPAD7 = 103,
	NUMPAD8 = 104,
	NUMPAD9 = 105,
	MULTIPLY = 106,
	ADD = 107,
	SEPARATOR = 108,
	SUBTRACT = 109,
	DECIMAL = 110,
	DIVIDE = 111,
	F1 = 112,
	F2 = 113,
	F3 = 114,
	F4 = 115,
	F5 = 116,
	F6 = 117,
	F7 = 118,
	F8 = 119,
	F9 = 120,
	F10 = 121,
	F11 = 122,
	F12 = 123,
	F13 = 124,
	F14 = 125,
	F15 = 126,
	F16 = 127,
	F17 = 128,
	F18 = 129,
	F19 = 130,
	F20 = 131,
	F21 = 132,
	F22 = 133,
	F23 = 134,
	F24 = 135,
	NUMLOCK = 144,
	SCROLLLOCK = 145,
	SCROLL = 145,
	-- VK_L & VK_R - left and right Alt, Ctrl and Shift virtual keys.
	-- Used only as parameters to GetAsyncKeyState() and GetKeyState().
	-- No other API or message will distinguish left and right keys in this way.
	LSHIFT = 160,
	RSHIFT = 161,
	LCONTROL = 162,
	RCONTROL = 163,
	LMENU = 164,
	RMENU = 165,
	BROWSER_BACK = 166,
	BROWSER_FORWARD = 167,
	BROWSER_REFRESH = 168,
	BROWSER_STOP = 169,
	BROWSER_SEARCH = 170,
	BROWSER_FAVORITES = 171,
	BROWSER_HOME = 172,
	VOLUME_MUTE = 173,
	VOLUME_DOWN = 174,
	VOLUME_UP = 175,
	MEDIA_NEXT_TRACK = 176,
	MEDIA_PREV_TRACK = 177,
	MEDIA_STOP = 178,
	MEDIA_PLAY_PAUSE = 179,
	LAUNCH_MAIL = 180,
	LAUNCH_MEDIA_SELECT = 181,
	LAUNCH_APP1 = 182,
	LAUNCH_APP2 = 183,
	OEM_1 = 186,
	OEM_PLUS = 187,
	OEM_COMMA = 188,
	OEM_MINUS = 189,
	OEM_PERIOD = 190,
	OEM_2 = 191,
	OEM_3 = 192,
	OEM_4 = 219,
	OEM_5 = 220,
	OEM_6 = 221,
	OEM_7 = 222,
	OEM_8 = 223,
	OEM_102 = 226,
	PACKET = 231,
	PROCESSKEY = 229,
	ATTN = 246,
	CRSEL = 247,
	EXSEL = 248,
	EREOF = 249,
	PLAY = 250,
	ZOOM = 251,
	NONAME = 252,
	PA1 = 253,
	OEM_CLEAR = 254,
}

-- VK_0 thru VK_9 are the same as ASCII '0' thru '9' (0x30 - 0x39)
for i = 0x30, 0x39 do
	const.Keys[string.char(i)] = i
end

-- VK_A thru VK_Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A)
for i = 0x41, 0x5A do
	const.Keys[string.char(i)] = i
end


if mmver == 6 then
	const.Skills = {
		Staff = 0,
		Sword = 1,
		Dagger = 2,
		Axe = 3,
		Spear = 4,
		Bow = 5,
		Mace = 6,
		Blaster = 7,
		Shield = 8,
		Leather = 9,
		Chain = 10,
		Plate = 11,
		Fire = 12,
		Air = 13,
		Water = 14,
		Earth = 15,
		Spirit = 16,
		Mind = 17,
		Body = 18,
		Light = 19,
		Dark = 20,
		IdentifyItem = 21,
		Merchant = 22,
		Repair = 23,  -- proper name "RepairItem" is supported since MMExt 2.3
		Bodybuilding = 24,
		Meditation = 25,
		Perception = 26,
		Diplomacy = 27,
		Thievery = 28,
		DisarmTraps = 29,  -- proper name "DisarmTrap" is supported since MMExt 2.3
		Learning = 30,
	}
elseif mmver == 7 then
	const.Skills = {
		Staff = 0,
		Sword = 1,
		Dagger = 2,
		Axe = 3,
		Spear = 4,
		Bow = 5,
		Mace = 6,
		Blaster = 7,
		Shield = 8,
		Leather = 9,
		Chain = 10,
		Plate = 11,
		Fire = 12,
		Air = 13,
		Water = 14,
		Earth = 15,
		Spirit = 16,
		Mind = 17,
		Body = 18,
		Light = 19,
		Dark = 20,
		IdentifyItem = 21,
		Merchant = 22,
		Repair = 23,
		Bodybuilding = 24,
		Meditation = 25,
		Perception = 26,
		Diplomacy = 27,
		Thievery = 28,
		DisarmTraps = 29,
		Dodging = 30,
		Unarmed = 31,
		IdentifyMonster = 32,
		Armsmaster = 33,
		Stealing = 34,
		Alchemy = 35,
		Learning = 36,
	}
else
	const.Skills = {
		Staff = 0,
		Sword = 1,
		Dagger = 2,
		Axe = 3,
		Spear = 4,
		Bow = 5,
		Mace = 6,
		Blaster = 7,
		Shield = 8,
		Leather = 9,
		Chain = 10,
		Plate = 11,
		Fire = 12,
		Air = 13,
		Water = 14,
		Earth = 15,
		Spirit = 16,
		Mind = 17,
		Body = 18,
		Light = 19,
		Dark = 20,
		DarkElfAbility = 21,
		VampireAbility = 22,
		DragonAbility = 23,
		IdentifyItem = 24,
		Merchant = 25,
		Repair = 26,
		Bodybuilding = 27,
		Meditation = 28,
		Perception = 29,
		Regeneration = 30,
		DisarmTraps = 31,
		Dodging = 32,
		Unarmed = 33,
		IdentifyMonster = 34,
		Armsmaster = 35,
		Stealing = 36,
		Alchemy = 37,
		Learning = 38,
	}
end
setmetatable(const.Skills, {__index = {DisarmTrap = const.Skills.DisarmTraps}})
setmetatable(const.Skills, {__index = {RepairItem = const.Skills.Repair}})

const.SkillClub = mmv(-1, 37, PatchOptionsSize > 364 and 39 or 40)
const.SkillMisc = mmv(12, 38, 40)

const.Condition = {
	Cursed         = 0,
	Weak           = 1,
	Asleep         = 2,
	Afraid         = 3,
	Drunk          = 4,
	Insane         = 5,
	Poison1        = 6,
	Disease1       = 7,
	Poison2        = 8,
	Disease2       = 9,
	Poison3        = 10,
	Disease3       = 11,
	Paralyzed      = 12,
	Unconscious    = 13,
	Dead           = 14,
	Stoned         = 15,
	Eradicated     = 16,
	Good           = mmver > 6 and 18 or 17,
}
if mmver > 6 then
	const.Condition.Zombie = 17
	-- Condition 19 was originally meant to mean Lich
end

const.ItemType = {
	Any        = 0,
	Weapon     = 1,
	Weapon2H   = 2,
	Missile    = 3,
	Armor      = 4,
	Shield     = 5,
	Helm       = 6,
	Belt       = 7,
	Cloak      = 8,
	Gauntlets  = 9,  -- Was called 'Gountlets' before MMExtension v2.3, old name is supported for backward compatibility
	Boots      = 10,
	Ring       = 11,
	Amulet     = 12,
	Wand       = 13, -- weaponw
	Reagent    = 14, -- herb
	Potion     = 15, -- bottle
	Scroll     = 16, -- sscroll
	Book       = 17,
	MScroll    = 18, -- always creates item 001
	Gold       = 19,
	
	Weapon_    = 20,
	Armor_     = 21,
	Misc       = 22,
	Sword      = 23,
	Dagger     = 24,
	Axe        = 25,
	Spear      = 26,
	Bow        = 27,
	Mace       = 28,
	Club       = 29,
	Staff      = 30,
	Leather    = 31,
	Chain      = 32,
	Plate      = 33,
	Shield_    = 34,
	Helm_      = 35,
	Belt_      = 36,
	Cloak_     = 37,
	Gauntlets_ = 38,  -- Was called 'Gountlets_' before MMExtension v2.3, old name is supported for backward compatibility
	Boots_     = 39,
	Ring_      = 40,
	Amulet_    = 41,
	Wand_      = 42,
	Scroll_    = 43,
	Potion_    = 44,
	Reagent_   = 45,
	Gems       = 46,
	Gems2      = 47,
	Gold_      = 50,
}
setmetatable(const.ItemType, {__index = {Gountlets = 9, Gountlets_ = 38}})

const.ItemSlot = {
	ExtraHand = 0,
	MainHand = 1,
	Bow = 2,
	Armor = 3,
	Helm = 4,
	Belt = 5,
	Cloak = 6,
	Gauntlets = 7,  -- Was called 'Gountlets' before MMExtension v2.3, old name is supported for backward compatibility
	Boots = 8,
	Amulet = 9,
	Ring1 = 10,
	Ring2 = 11,
	Ring3 = 12,
	Ring4 = 13,
	Ring5 = 14,
	Ring6 = 15,
}
setmetatable(const.ItemSlot, {__index = {Gountlets = 7}})

if mmver == 6 then
	const.Damage = {
		Phys = 0,
		Magic = 1,
		Fire = 2,
		Elec = 3,
		Cold = 4,
		Poison = 5,
		Energy = 6,
	}
else
	const.Damage = {
		Fire = 0,
		Air = 1,
		Water = 2,
		Earth = 3,
		Phys = 4,
		Magic = 5,
		Spirit = 6,
		Mind = 7,
		Body = 8,
		Light = 9,
		Dark = 10,
		Energy = 12,
		Dragon = mmver == 8 and 50 or nil,
	}
end


if mmver == 6 then
	const.Class = {
		Knight = 0,
		Cavalier = 1,
		Champion = 2,
		Cleric = 3,
		Priest = 4,
		HighPriest = 5,
		Sorcerer = 6,
		Wizard = 7,
		ArchMage = 8,
		Paladin = 9,
		Crusader = 10,
		Hero = 11,
		Archer = 12,
		BattleMage = 13,
		WarriorMage = 14,
		Druid = 15,
		GreatDruid = 16,
		ArchDruid = 17,
	}
elseif mmver == 7 then
	const.Class = {
		Knight = 0,
		Cavalier = 1,
		Champion = 2,
		BlackKnight = 3,
		Thief = 4,
		Rogue = 5,
		Spy = 6,
		Assassin = 7,
		Monk = 8,
		Initiate = 9,
		Master = 10,
		Ninja  = 11,
		Paladin = 12,
		Crusader = 13,
		Hero = 14,
		Villain = 15,
		Archer = 16,
		WarriorMage = 17,
		MasterArcher = 18,
		Sniper = 19,
		Ranger = 20,
		Hunter = 21,
		RangerLord = 22,
		BountyHunter = 23,
		Cleric = 24,
		Priest = 25,
		PriestLight = 26,
		PriestDark = 27,
		Druid = 28,
		GreatDruid = 29,
		ArchDruid = 30,
		Warlock = 31,
		Sorcerer = 32,
		Wizard = 33,
		ArchMage = 34,
		Lich = 35,
	}
else
	const.Class = {
		Necromancer = 0,
		Lich = 1,
		Cleric = 2,
		PriestLight = 3,
		Knight = 4,
		Champion = 5,
		Troll = 6,
		WarTroll = 7,
		Minotaur = 8,
		MinotaurLord = 9,
		DarkElf = 10,
		Patriarch = 11,
		Vampire = 12,
		Nosferatu = 13,
		Dragon = 14,
		GreatWyrm = 15,
	}
end

if mmver == 7 then
	const.Race = {
		Human = 0,
		Elf = 1,
		Goblin = 2,
		Dwarf = 3,
	}
end

if mmver == 6 then
	const.Stats = {
		Might = 0,
		Intellect = 1,
		Personality = 2,
		Endurance = 3,
		Accuracy = 4,
		Speed = 5,
		Luck = 6,
		HP = 7,
		HitPoints = 7,
		SP = 8,
		SpellPoints = 8,
		ArmorClass = 9,
		FireResistance = 10,
		ElecResistance = 11,
		ColdResistance = 12,
		PoisonResistance = 13,
		Level = 14,
		MeleeAttack = 15,
		MeleeDamageBase = 16,
		MeleeDamageMin = 17,
		MeleeDamageMax = 18,
		RangedAttack = 19,
		RangedDamageBase = 20,
		RangedDamageMin = 21,
		RangedDamageMax = 22,
		MagicResistance = 23,
	}
else
	const.Stats = {
		Might = 0,
		Intellect = 1,
		Personality = 2,
		Endurance = 3,
		Accuracy = 4,
		Speed = 5,
		Luck = 6,
		HP = 7,
		HitPoints = 7,
		SP = 8,
		SpellPoints = 8,
		ArmorClass = 9,
		FireResistance = 10,
		AirResistance = 11,
		WaterResistance = 12,
		EarthResistance = 13,
		MindResistance = 14,
		BodyResistance = 15,
		Alchemy = 16,
		Stealing = 17,
		DisarmTraps = 18,
		IdentifyItem = 19,
		IdentifyMonster = 20,
		Armsmaster = 21,
		Dodging = 22,
		Unarmed = 23,
		Level = 24,
		MeleeAttack = 25,
		MeleeDamageBase = 26,
		MeleeDamageMin = 27,  -- For Stats screen. Only used in #CalcStatBonusByItems:events.CalcStatBonusByItems#, other events use MeleeDamageBase
		MeleeDamageMax = 28,  -- For Stats screen. Only used in #CalcStatBonusByItems:events.CalcStatBonusByItems#, other events use MeleeDamageBase
		RangedAttack = 29,
		RangedDamageBase = 30,
		RangedDamageMin = 31,  -- For Stats screen. Only used in #CalcStatBonusByItems:events.CalcStatBonusByItems#, other events use RangedDamageBase
		RangedDamageMax = 32,  -- For Stats screen. Only used in #CalcStatBonusByItems:events.CalcStatBonusByItems#, other events use RangedDamageBase
		SpiritResistance = 33,
		FireMagic = 34,
		AirMagic = 35,
		WaterMagic = 36,
		EarthMagic = 37,
		SpiritMagic = 38,
		MindMagic = 39,
		BodyMagic = 40,
		LightMagic = 41,
		DarkMagic = 42,
		Meditation = 43,
		Bow = 44,
		Shield = 45,
		Learning = 46,
	}
end
if mmver == 8 then
	table.copy({
		DarkElf = 47,
		Vampire = 48,
		Dragon = 49,
	}, const.Stats, true)
end

const.Screens = {
	Game = 0,
	Menu = 1,
	Controls = 2,
	Info = 3,  -- Quests, Autonotes, Map, Calendar, History, Town Portal, Lloyd Beacon
	NPC = 4,
	Rest = 5,
	Query = 6,  -- like with hotkeys in Chinese debug MM6
	Inventory = 7,  -- character screen, not necessarily Inventory
	SpellBook = 8,
	NewGameBriefing = 9,  -- was called 'NewGameBreefing' before MMExtension v2.3, old name is supported for backward compatibility
	Chest = 10,
	SaveGame = 11,
	LoadGame = 12,
	House = 13,
	InventoryInShop = 14,  -- double clicking a character in any Buy dialog in MM6 or in Buy Standard in MM7
	InventoryInChest = 15,
	MainManu = 16,  -- or movie
	WalkToMap = 17,
	MapEntrance = 18,  -- or #Question:# screen
	SimpleMessage = 19,
	SelectTarget = 20,  -- Heal and other such spells in MM8
	CreateParty = 21,
	EscMessage = 22,
	ItemSpell = 23,
	KeyConfig = 26,
	VideoOptions = 28,
	AdventurersInn = 29,
	ItemSpellMM6 = 103,
	QuickReference = 104,
}
setmetatable(const.Screens, {__index = {NewGameBreefing = 9}})

const.DlgID = {
	Generic = 1,  -- a lot of dialogs use this Id
	Menu = 3,
	Inventory = 4,  -- character screen, not necessarily Inventory
	Controls = 6,
	-- ControlsUnk = 8,
	Info = 9,  -- Quests, Autonotes, Map, Calendar, History, Town Portal, Lloyd Beacon. See #const.InfoDialog:# for values of 'Param' that define the dialog type.
	NPC = 10,  -- 'Param' is NPC index
	QuickReference = 12,
	Rest = 16,
	WalkToMap = 17,
	SpellBook = 18,
	SimpleMessage = 19,
	Chest = 20,
	SaveGame = 23,
	LoadGame = 24,
	House = 25,  -- 'Param' is the #house:Game.Houses# index
	MapEntrance = 26,
	SelectTarget = 27,  -- Heal and other such spells
	Scroll = 30,  -- When reading a message scroll
	ItemSpell = 31,
	EscMessage = 70,
	Query = 80,
	CheatCreateItem = 89,
	Button = 90,  -- shown for 1 frame when clicking most buttons
	ButtonImg2 = 91,
	ButtonTransparent = 92,
	ButtonTransparentImg2 = 93,
	ButtonSaveLoad = 94,  -- clicking Save/Load button in corresponding dialog
	ButtonEscTransparent = 95,
	ButtonEsc = 96,
	ButtonEscImg2 = 97,
	ButtonRestAndHeal = 98,
	DrawImage = 99,  -- used in Info screen to draw the currently selected book
	CheatCreateMonster = 103,
	ConfigureKeyboard = 105,
	VideoOptions = 106,
	CustomDialog = 1000,  -- used by CustomDialog function
	BlockDialogs = 1001,  -- in MM8 if #custom dialogs:CustomDialog# exist, these screens are created for each OO dialog in order to prevent processing of said custom dialogs
	BlockDialogsNoDraw = 1002,  -- used in situation discribed above when it's also important to block drawing the dialogs
}

const.InfoDialog = {
	Quests = 200,
	Autonotes = 201,
	Map = 202,
	Calendar = 203,
	History = 224,
	TownPortal = 195,
	LloydBeacon = 177,
}

const.CharScreens = {
	Stats = 100,
	Skills = 101,
	Awards = 102,
	Inventory = 103,
}

const.HouseScreens = {
	Teacher = -1,
	ChoosePerson = 0,
	Main = 1,
	BuyStandard = 2,
	Sell = 3,
	Identify = 4,
	Repair = 5,
	BuySpecialMM6 = 6,
	BankDeposit = 7,
	BankWithdraw = 8,
	
	Heal = 10,
	Donate = 11,
	ProfNews = 12,  -- NPC command
	JoinMenu = 13,  -- NPC command
	News = 14,  -- NPC command
	TavernSleep = 15,
	TavernFood = 16,
	Train = 17,
	BuySpells = 18,
	A = 19,  -- NPC command
	B = 20,  -- NPC command
	C = 21,  -- NPC command
	D = is78 and 22,  -- NPC command
	E = is78 and 23,  -- NPC command
	F = is78 and 24,  -- NPC command
	Beg = is6 and 22,  -- NPC command
	Threat = is6 and 23,  -- NPC command
	Bribe = is6 and 24,  -- NPC command
	TavernDrink = 25,
	TavernTip = 26,
	
	-- 36..(66/72/74) = skills
	
	HireOrDismiss = 76 - m6*6,  -- NPC command
	MoreInformation = 77 - m6*6,  -- NPC command
	TeachSkill = 78 - m6*6,  -- NPC command
	DoTeachSkill = 79 - m6*6,  -- NPC command
	
	JoinGuild = 81 - m6*6,  -- NPC command
	DoJoinGuild = 82 - m6*6,  -- NPC command
	BountyHuntNPC = 83 - m6*6,  -- NPC command
	SeerILostIt = 84 - m6*6,  -- NPC command
	
	SeerPilgrimage = is6 and 88,  -- NPC command
	SeerHint = is6 and 22,  -- NPC command
	-- MM6: 79 = ?
	
	ArenaPage = 85 - m6*5,  -- NPC command
	ArenaSquire = 86 - m6*5,  -- NPC command
	ArenaKight = 87 - m6*5,  -- NPC command
	ArenaLord = 88 - m6*5,  -- NPC command
	ArenaMenu = 89 - m6*5,  -- NPC command
	ArenaGoBack = 90 - m6*5,  -- NPC command
	ArenaWin = 91 - m6*5,  -- NPC command
	ArenaAlreadyWon = 92 - m6*5,  -- NPC command
	
	DisplayInventory = is78 and 94,
	BuySpecial = is6 and 6 or 95,
	LearnSkills = is78 and 96,
	
	BountyHunt = is78 and 99,
	PayFine = is78 and 100,
	ArcomageMenu = is78 and 101,
	ArcomageRules = is78 and 102,
	ArcomageConditions = is78 and 103,
	ArcomagePlay = is78 and 104,
	Travel1 = 106 - m6*39,
	Travel2 = 107 - m6*39,
	Travel3 = 108 - m6*39,
	Travel4 = is78 and 109,
	BuySpellsFire = is8 and 110,
	BuySpellsAir = is8 and 111,
	BuySpellsWater = is8 and 112,
	BuySpellsEarth = is8 and 113,
	BuySpellsSpirit = is8 and 114,
	BuySpellsMind = is8 and 115,
	BuySpellsBody = is8 and 116,
	BuySpellsLight = is8 and 117,
	BuySpellsDark = is8 and 118,
	JoinRoster = is8 and 119,  -- Yes item in the join menu
	JoinRosterNo = is8 and 120,
	StreetNPC = 200,  -- Not used by the game, only by MMExt for #PopulateNPCDialog:events.PopulateNPCDialog# event.
	LackFame = 201,  -- Not used by the game, only by MMExt for #PopulateNPCDialog:events.PopulateNPCDialog# event.
	BegThreatBribe = 202,  -- Not used by the game, only by MMExt for #PopulateNPCDialog:events.PopulateNPCDialog# event.
	ThreatBribe = 203,  -- Not used by the game, only by MMExt for #PopulateNPCDialog:events.PopulateNPCDialog# event.
}

for k, v in pairs(const.Skills) do
	const.HouseScreens[k] = v + 36
end

const.FaceAnimation = {
	KillSmallEnemy = 1,
	KillBigEnemy = 2,
	StoreClosed = 3,
	DisarmTrap = 4,
	TrapExploaded = 5,  -- sorry about that / it's gonna blow!
	AvoidDamage = 6,  -- sits down. Avoids either trap damage with Perception or attack damage with Dodging
	IdentifyUseless = 7,
	IdentifyGreat = 8,
	IdentifyFail = 9,
	RepairItem = 10,
	RepairFail = 11,
	SetQuickSpell = 12,
	CantRestHere = 13,
	SkillIncreased = 14,  -- in Skills screen
	CantCarry = 15,
	MixPotion = 16,
	PotionExplode = 17,
	DoorLocked = 18,
	WontBudge = 19,  -- like pulling sword out of stone in MM6
	CantLearnSpell = 20,
	LearnSpell = 21,
	Hello = 22,
	HelloNight = 23,  -- 10PM <= time < 5AM
	Damaged = 24,
	Weak = 25,
	Afraid = 26,
	Poisoned = 27,
	Deseased = 28,
	Insane = 29,
	Cursed = 30,
	Drunk = 31,
	Unconsious = 32,
	Death = 33,
	Stoned = 34,
	Eradicated = 35,
	DinkPotion = 36,  -- or eat reagent
	ReadScoll = 37,
	NotEnoughGold = 38,
	CantEquip = 39,
	ItemBrokenStolen = 40,
	SPDrained = 41,
	Aged = 42,
	SpellFailed = 43,
	DamagedParty = 44,  -- with explosive impact
	Tired = 45,
	EnterDungeon = 46,  -- come on let's go in
	LeaveDungeon = 47,  -- let's get out of here
	AlmostDead = 48,
	CastSpell = 49,
	Shoot = 50,
	AttackHit = 51,
	AttackMiss = 52,
	Beg = 53,
	BegFail = 54,
	Threat = 55,
	ThreatFail = 56,
	Bribe = 57,
	BribeFail = 58,
	NPCDontTalk = 59,
	FoundItem = 60,
	HireNPC = 61,

	LookUp = 63,
	LookDown = 64,
	Yell = 65,
	Falling = 66,
	TavernPacksFull = 67,  -- shakes head
	TavernDrink = 68,
	TavernGotDrunk = 69,
	TavernTip = 70,
	TravelHorse = 71,
	TravelBoat = 72,
	ShopIdentify = 73,
	ShopRepair = 74,
	ShopItemBought = 75,	
	ShopAlreadyIdentified = 76,
	ShopItemSold = 77,
	SkillLearned = 78,
	ShopWrongShop = 79,
	ShopRude = 80,
	BankDeposit = 81,  -- or paying a fine
	TempleHeal = 82,
	TempleDonate = 83,
	HelloHouse = 84,
	SkillMasteryIcreased = 85,  -- by a teacher
	JoinedGuild = 86,
	LevelUp = 87,
	
	StatBonusIncreased = 91,
	StatBaseIncreased = 92,
	QuestGot = 93,
	
	AwardGot = 96,  -- or autonote added, or QBits removed, or used Genie Lamp

	AfraidSilent = 98,
	CheatedDeath = 99,  -- "okay!". After death of party / after zombification
	InPrison = 100,
	
	ChooseMe = 102,
	Awaken = 103,
	IdMonsterWeak = 104,
	IdMonsterBig = 105,
	IdMonsterFail = 106,
	LastManStanding = 107,
	NotEnoughFood = 108,
	DeathBlow = 109,
}

-- backward compatibility
setmetatable(const.FaceAnimation, {__index = {
	TrapWillBlow = 5,
	AvoidTrapDamage = 6,
	SmileRandom = 14,
	Strain = 19,  -- like pulling sword out of stone in MM6
	Smile = 36,
	SmileHuge = 57,
	ShakeHeadNo = 67,  -- shakes head
	ShakeHeadYes = 71,
	SmileBig = 82,
	Hungry = 108,
}})

const.Season = {
	Automn = 0,
	Summer = 1,
	Fall = 2,
	Winter = 3,
}

if mmver == 6 then
	const.PartyBuff = {
		FireResistance = 0,
		ColdResistance = 1,
		ElecResistance = 2,
		MagicResistance = 3,
		PoisonResistance = 4,
		FeatherFall = 5,
		WaterWalk = 6,
		Fly = 7,
		GuardianAngel = 8,
	
		WizardEye = 10,
		TorchLight = 11,
	}
	
	const.PlayerBuff = {
		Bless = 0,
		Heroism = 1,
		Haste = 2,
		Shield = 3,
		Stoneskin = 4,
		TempLuck = 5,
		TempIntellect = 6,
		TempPersonality = 7,
		TempAccuracy = 8,
		TempSpeed = 9,
		TempMight = 10,
		TempEndurancy = 11,
	}

	const.MonsterBuff = {
		Null = 0,
		Charm = 1,
		Curse = 2,
		ShrinkingRay = 3,
		Fear = 4,
		Stoned = 5,
		Paralyze = 6,
		Slow = 7,
		Feeblemind = 8,
		-- unknown: 9 - 13
	}	
elseif mmver == 7 then

	const.PartyBuff = {
		AirResistance = 0,
		BodyResistance = 1,
		DayOfGods = 2,
		DetectLife = 3,
		EarthResistance = 4,
		FeatherFall = 5,
		FireResistance = 6,
		Fly = 7,
		Haste = 8,
		Heroism = 9,
		Immolation = 10,
		Invisibility = 11,
		MindResistance = 12,
		ProtectionFromMagic = 13,
		Shield = 14,
		Stoneskin = 15,
		TorchLight = 16,
		WaterResistance = 17,
		WaterWalk = 18,
		WizardEye = 19,
	}
	
	const.PlayerBuff = {
		AirResistance = 0,
		Bless = 1,
		BodyResistance = 2,
		EarthResistance = 3,
		Fate = 4,
		FireResistance = 5,
		Hammerhands = 6,
		Haste = 7,
		Heroism = 8,
		MindResistance = 9,
		PainReflection = 10,
		Preservation = 11,
		Regeneration = 12,
		Shield = 13,
		Stoneskin = 14,
		TempAccuracy = 15,
		TempEndurance = 16,
		TempIntellect = 17,
		TempLuck = 18,
		TempMight = 19,
		TempPersonality = 20,
		TempSpeed = 21,
		WaterResistance = 22,
		WaterBreathing = 23,
	}
	
	const.MonsterBuff = {
		Null = 0,
		Charm = 1,
		Summoned = 2,
		ShrinkingRay = 3,
		Fear = 4,
		Stoned = 5,
		Paralyze = 6,
		Slow = 7,
		ArmorHalved = 8,
		Berserk = 9,
		MassDistortion = 10,
		Fate = 11,
		Enslave = 12,
		DayOfProtection = 13,
		HourOfPower = 14,
		Shield = 15,
		StoneSkin = 16,
		Bless = 17,
		Heroism = 18,
		Haste = 19,
		PainReflection = 20,
		Hammerhands = 21,
	}
	
elseif mmver == 8 then

	const.PartyBuff = {
		AirResistance = 0,
		BodyResistance = 1,
		DayOfGods = 2,
		DetectLife = 3,
		EarthResistance = 4,
		FeatherFall = 5,
		FireResistance = 6,
		Fly = 7,
		Haste = 8,
		Heroism = 9,
		Immolation = 10,
		Invisibility = 11,
		MindResistance = 12,
		ProtectionFromMagic = 13,
		Shield = 14,
		Stoneskin = 15,
		TorchLight = 16,
		WaterResistance = 17,
		WaterWalk = 18,
		WizardEye = 19,
	}
	
	const.PlayerBuff = {
		AirResistance = 0,
		Bless = 1,
		BodyResistance = 2,
		EarthResistance = 3,
		Fate = 4,
		FireResistance = 5,
		Hammerhands = 6,
		Haste = 7,
		Heroism = 8,
		MindResistance = 9,
		PainReflection = 10,
		Preservation = 11,
		Regeneration = 12,
		Shield = 13,
		Stoneskin = 14,
		TempAccuracy = 15,
		TempEndurance = 16,
		TempIntellect = 17,
		TempLuck = 18,
		TempMight = 19,
		TempPersonality = 20,
		TempSpeed = 21,
		WaterResistance = 22,
		WaterBreathing = 23,
		Glamour = 24,
		Levitate = 25,
		Misform = 26,
	}

	const.MonsterBuff = {
		Null = 0,
		Charm = 1,
		Summoned = 2,
		ShrinkingRay = 3,
		Fear = 4,
		Stoned = 5,
		Paralyze = 6,
		Slow = 7,
		Berserk = 8,
		MassDistortion = 9,
		Fate = 10,
		Enslave = 11,
		DayOfProtection = 12,
		HourOfPower = 13,
		Shield = 14,
		StoneSkin = 15,
		Bless = 16,
		Heroism = 17,
		Haste = 18,
		PainReflection = 19,
		Hammerhands = 20,
		ArmorHalved = 21,
		MeleeOnly = 22,  -- (part of Blind and Dark Grasp)
		DamageHalved = 23,
		Wander = 24,  -- monster wanders aimlessly (part of Blind)
		Mistform = 25,
	}

end

const.Actions = {
	Exit = 113,
	CustomDialogButton = 1000,
	CustomDialogHint = 1001,
	CustomDialogMouseUp = 1002,
}

--!-
const.GameActions = const.Actions

const.ExitMapAction = {
	None = 0,
	Exit = 1,  -- used in main menu
	LoadMap = 2,  -- when you exit a map and enter another one
	LoadGame = 3,
	NewGame = 4,
	MainMenu = 7,
	Death = 8,
	WinScreen = 9,  -- draw the Win message
}

const.HouseTypeInv = {
	"Weapon Shop",
	"Armor Shop",
	"Magic Shop",
	(mmver == 6 and "General Store" or "Alchemist"),
	"Fire Guild",
	"Air Guild",
	"Water Guild",
	"Earth Guild",
	"Spirit Guild",
	"Mind Guild",
	"Body Guild",
	"Light Guild",
	"Dark Guild",
	(mmver == 6 and "Element Guild" or "Elemental Guild"),
	"Self Guild",
	nil,  -- 16 - "mir..." - planned, but not included Mirrored Path Guild of Light and Dark
	(mmver ~= 6 and "Town Hall" or "Thieves Guild"),  -- everything else in MM6
	"Merc Guild",
	mmv("Town Hall"),
	"Throne",
	"Tavern",
	"Bank",
	"Temple",
	"Castle Entrance",
	"Dungeon Ent",
	"Seer",
	"Stables",
	"Boats",
	"House",
	"Training",
	"Jail",
	"Circus",
	nil, -- 33
	nil, -- 34
	"The Adventurer's Inn",
}
const.HouseType = table.invert(const.HouseTypeInv)
const.HouseType["General Store"] = 4  -- MM6
const.HouseType["Alchemist"] = 4  -- MM7,8
const.HouseType["Element Guild"] = 14  -- MM6
const.HouseType["Elemental Guild"] = 14  -- MM7,8
const.HouseType["Spell Shop"] = 14  -- MM8
if mmver ~= 6 then
	const.HouseType["Thieves Guild"] = 18  -- Merc Guild works similar to it and doesn't work without a few tweaks anyway
end
const.HouseType["The Seer"] = 26  -- MM6, MM7
const.HouseType["The Oracle"] = 26  -- MM6
const.HouseType["Seer Good"] = 26  -- MM7
const.HouseType["Seer Evil"] = 26  -- MM7
const.HouseType["Castle Ent"] = 24  -- consistancy
const.HouseType["Dungeon Entrance"] = 25  -- consistancy

if mmver == 6 then
	
	const.NPCProfession = {
		Smith = 1,
		Armorer = 2,
		Alchemist = 3,
		Scholar = 4,
		Guide = 5,
		Tracker = 6,
		Pathfinder = 7,
		Sailor = 8,
		Navigator = 9,
		Healer = 10,
		ExpertHealer = 11,
		MasterHealer = 12,
		Teacher = 13,
		Instructor = 14,
		ArmsMaster = 15,
		WeaponsMaster = 16,
		Apprentice = 17,
		Mystic = 18,
		SpellMaster = 19,
		Trader = 20,
		Merchant = 21,
		Scout = 22,
		Counselor = 23,
		Barrister = 24,
		Tinker = 25,
		Locksmith = 26,
		Fool = 27,
		ChimneySweep = 28,
		Porter = 29,
		QuarterMaster = 30,
		Factor = 31,
		Banker = 32,
		Cook = 33,
		Chef = 34,
		Horseman = 35,
		Bard = 36,
		Enchanter = 37,
		Cartographer = 38,
		WindMaster = 39,
		WaterMaster = 40,
		GateMaster = 41,
		Acolyte = 42,
		Piper = 43,
		Explorer = 44,
		Pirate = 45,
		Squire = 46,
		Psychic = 47,
		Gypsy = 48,
		Negotiator = 49,
		Duper = 50,
		Burglar = 51,
		Peasant = 52,
		Serf = 53,
		Tailor = 54,
		Laborer = 55,
		Farmer = 56,
		Cooper = 57,
		Potter = 58,
		Weaver = 59,
		Cobbler = 60,
		DitchDigger = 61,
		Miller = 62,
		Carpenter = 63,
		StoneCutter = 64,
		Jester = 65,
		Trapper = 66,
		Beggar = 67,
		Rustler = 68,
		Hunter = 69,
		Scribe = 70,
		Missionary = 71,
		Clerk = 72,
		Guard = 73,
		FollowerofBaa = 74,
		Noble = 75,
		Gambler = 76,
		Child = 77,
	}
	
elseif mmver == 7 then

	const.NPCProfession = {
		Smith = 1,
		Armorer = 2,
		Alchemist = 3,
		Scholar = 4,
		Guide = 5,
		Tracker = 6,
		Pathfinder = 7,
		Sailor = 8,
		Navigator = 9,
		Healer = 10,
		ExpertHealer = 11,
		MasterHealer = 12,
		Teacher = 13,
		Instructor = 14,
		ArmsMaster = 15,
		WeaponsMaster = 16,
		Apprentice = 17,
		Mystic = 18,
		SpellMaster = 19,
		Trader = 20,
		Merchant = 21,
		Scout = 22,
		Herbalist = 23,
		Apothecary = 24,
		Tinker = 25,
		Locksmith = 26,
		Fool = 27,
		ChimneySweep = 28,
		Porter = 29,
		QuarterMaster = 30,
		Factor = 31,
		Banker = 32,
		Cook = 33,
		Chef = 34,
		Horseman = 35,
		Bard = 36,
		Enchanter = 37,
		Cartographer = 38,
		WindMaster = 39,
		WaterMaster = 40,
		GateMaster = 41,
		Chaplain = 42,
		Piper = 43,
		Explorer = 44,
		Pirate = 45,
		Squire = 46,
		Psychic = 47,
		Gypsy = 48,
		Diplomat = 49,
		Duper = 50,
		Burglar = 51,
		FallenWizard = 52,
		Acolyte = 53,
		Initiate = 54,
		Prelate = 55,
		Monk = 56,
		Sage = 57,
		Hunter = 58,
	}

end

const.Spells = {
	TorchLight = 1,
	Haste = 5,
	Fireball = 6,
	MeteorShower = 9,
	Inferno = 10,
	Incinerate = 11,
	WizardEye = 12,
	Sparks = 15,
	Shield = 17,
	LightningBolt = 18,
	Implosion = 20,
	Fly = 21,
	Starburst = 22,
	Awaken = 23,
	WaterWalk = 27,
	TownPortal = 31,
	IceBlast = 32,
	LloydsBeacon = 33,
	Stun = 34,
	DeadlySwarm = 37,
	StoneSkin = 38,
	Blades = 39,
	StoneToFlesh = 40,
	RockBlast = 41,
	DeathBlossom = 43,
	MassDistortion = 44,
	Bless = 46,
	RemoveCurse = 49,
	Heroism = 51,
	RaiseDead = 53,
	SharedLife = 54,
	Resurrection = 55,
	CureInsanity = 64,
	PsychicShock = 65,
	CureWeakness = 67,
	Harm = 70,
	CurePoison = 72,
	CureDisease = 74,
	FlyingFist = 76,
	PowerCure = 77,
	DispelMagic = 80,
	DayOfTheGods = 83,
	PrismaticLight = 84,
	DivineIntervention = 88,
	Reanimate = 89,
	ToxicCloud = 90,
	DragonBreath = 97,
	Armageddon = 98,
	ShootFire = nil,  -- unused
}

if mmver < 8 then
	table.copy({
		Shoot = 100,
		ShootFire = 101,
		ShootBlaster = 102,
	}, const.Spells, true)
end

if mmver > 6 then
	table.copy({
		FireBolt = 2,
		FireResistance = 3,
		FireAura = 4,
		FireSpike = 7,
		Immolation = 8,
		FeatherFall = 13,
		AirResistance = 14,
		Jump = 16,
		Invisibility = 19,
		PoisonSpray = 24,
		WaterResistance = 25,
		IceBolt = 26,
		RechargeItem = 28,
		AcidBurst = 29,
		EnchantItem = 30,
		Slow = 35,
		EarthResistance = 36,
		Telekinesis = 42,
		DetectLife = 45,
		Fate = 47,
		TurnUndead = 48,
		Preservation = 50,
		SpiritLash = 52,
		MindResistance = 58,
		CureParalysis = 61,
		Berserk = 62,
		MassFear = 63,
		Enslave = 66,
		Heal = 68,
		BodyResistance = 69,
		Regeneration = 71,
		Hammerhands = 73,
		ProtectionFromMagic = 75,
		LightBolt = 78,
		DestroyUndead = 79,
		Paralyze = 81,
		SummonElemental = 82,
		DayOfProtection = 85,
		HourOfPower = 86,
		Sunray = 87,
		VampiricWeapon = 91,
		ShrinkingRay = 92,
		Shrapmetal = 93,
		ControlUndead = 94,
		PainReflection = 95,
		Souldrinker = 99,
	}, const.Spells, true)
end

if mmver == 6 then

	table.copy({
		FlameArrow = 2,
		ProtectionFromFire = 3,
		FireBolt = 4,
		RingOfFire = 7,
		FireBlast = 8,
		StaticCharge = 13,
		ProtectionFromElectricity = 14,
		FeatherFall = 16,
		Jump = 19,
		ColdBeam = 24,
		ProtectionFromCold = 25,
		PoisonSpray = 26,
		IceBolt = 28,
		EnchantItem = 29,
		AcidBurst = 30,
		MagicArrow = 35,
		ProtectionFromMagic = 36,
		TurnToStone = 42,
		SpiritArrow = 45,
		HealingTouch = 47,
		LuckyDay = 48,
		GuardianAngel = 50,
		TurnUndead = 52,
		Meditation = 56,
		RemoveFear = 57,
		MindBlast = 58,
		Precision = 59,
		CureParalysis = 60,
		Charm = 61,
		MassFear = 62,
		Feeblemind = 63,
		Telekinesis = 66,
		FirstAid = 68,
		ProtectionFromPoison = 69,
		CureWounds = 71,
		Speed = 73,
		Power = 75,
		CreateFood = 78,
		GoldenTouch = 79,
		Slow = 81,
		DestroyUndead = 82,
		HourOfPower = 85,
		Paralyze = 86,
		SunRay = 87,
		MassCurse = 91,
		Shrapmetal = 92,
		ShrinkingRay = 93,
		DayOfProtection = 94,
		FingerOfDeath = 95,
		MoonRay = 96,
		DarkContainment = 99,
		
	}, const.Spells, true)
	
elseif mmver == 7 then

	table.copy({
		RemoveFear = 56,
		MindBlast = 57,
		Telepathy = 59,
		Charm = 60,
		Sacrifice = 96,
		
	}, const.Spells, true)

else

	table.copy({
		Telepathy = 56,
		RemoveFear = 57,
		MindBlast = 59,
		SummonWisp = 82,
		DarkGrasp = 96,
		Glamour = 100,
		TravelersBoon = 101,
		Blind = 102,
		DarkfireBolt = 103,
		--Unused = 104,
		--Unused = 105,
		--Unused = 106,
		--Unused = 107,
		--Unused = 108,
		--Unused = 109,
		--Unused = 110,
		Lifedrain = 111,
		Levitate = 112,
		Charm = 113,
		Mistform = 114,
		--Unused = 115,
		--Unused = 116,
		--Unused = 117,
		--Unused = 118,
		--Unused = 119,
		--Unused = 120,
		--Unused = 121,
		Fear = 122,
		FlameBlast = 123,
		Flight = 124,
		WingBuffet = 125,
		--Unused = 126,
		--Unused = 127,
		--Unused = 128,
		--Unused = 129,
		--Unused = 130,
		--Unused = 131,
		--Unused = 132,
		Shoot = 133,
		ShootFire = 134,
		ShootBlaster = 135,
		ShootCannonBall = 136,
		ShootDragon = 137,
	}, const.Spells, true)
	
end

const.ArcomageIf = {
	Always = 1,
	LessIncomeBricks = 2,
	LessIncomeGems = 3,
	LessIncomeBeasts = 4,
	EqualIncomeBricks = 5,
	EqualIncomeGems = 6,
	EqualIncomeBeasts = 7,
	MoreIncomeBricks = 8,
	MoreIncomeGems = 9,
	MoreIncomeBeasts = 10,
	NoWall = 11,
	HaveWall = 12,
	NoEnemyWall = 13,
	HaveEnemyWall = 14,
	LessWall = 15,
	LessTower = 16,
	EqualWall = 17,
	EqualTower = 18,
	MoreWall = 19,
	MoreTower = 20,
}
