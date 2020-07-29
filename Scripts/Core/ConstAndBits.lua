local mmver = offsets.MMVersion

local function mmv(...)
	return (select(mmver - 5, ...))
end

const = const or {}
Const = const

local _KNOWNGLOBALS

const.Novice = 1
const.Expert = 2
const.Master = 3
if mmver ~= 6 then
	const.GM = 4
end
const.MapLimit = 22528

const.Minute = 256
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
		Untouchable = 0x20000000,
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
	TriggerByTouch = 0x0001,  -- triggered when a player comes into 'TriggerRadius'
	TriggerByMonster = 0x0002,  -- triggered when a monster comes into 'TriggerRadius'
	TriggerByObject = 0x0004,  -- triggered when an object gets into 'TriggerRadius'
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
		Male = 0x0200,
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

const.ObjectRefKind = {
	Nothing = 0,
	Door = 1,
	Object = 2,
	Monster = 3,
	Party = 4, -- Index is player index (1-4 or 0 for whole party ???)
	Sprite = 5,
	Facet = 6, -- outdoors Index = ModelId*64 + FaceId
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
		Repair = 23,
		Bodybuilding = 24,
		Meditation = 25,
		Perception = 26,
		Diplomacy = 27,
		Thievery = 28,
		DisarmTraps = 29,
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
}
if mmver > 6 then
	const.Condition.Zombie = 17
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
	Gountlets  = 9,
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
	Gountlets_ = 38,
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

const.ItemSlot = {
	ExtraHand = 0,
	MainHand = 1,
	Bow = 2,
	Armor = 3,
	Helm = 4,
	Belt = 5,
	Cloak = 6,
	Gountlets = 7,
	Boots = 8,
	Amulet = 9,
	Ring1 = 10,
	Ring2 = 11,
	Ring3 = 12,
	Ring4 = 13,
	Ring5 = 14,
	Ring6 = 15,
}

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
		MeleeDamageMin = 27,
		MeleeDamageMax = 28,
		RangedAttack = 29,
		RangedDamageBase = 30,
		RangedDamageMin = 31,
		RangedDamageMax = 32,
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
	Info = 3,  -- quests, map, autonotes
	NPC = 4,
	Rest = 5,
	Query = 6,  -- like with hotkeys in Chinese debug MM6
	Inventory = 7,
	SpellBook = 8,
	NewGameBreefing = 9,
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

const.CharScreens = {
	Stats = 100,
	Skills = 101,
	Awards = 102,
	Inventory = 103,
}

const.FaceAnimation = {
	KillSmallEnemy = 1,
	KillBigEnemy = 2,
	StoreClosed = 3,
	DisarmTrap = 4,
	TrapWillBlow = 5,  -- it's gonna blow!
	AvoidTrapDamage = 6,  -- sit down
	IdentifyUseless = 7,
	IdentifyGreat = 8,
	IdentifyFail = 9,
	RepairItem = 10,
	RepairFail = 11,
	SetQuickSpell = 12,
	CantRestHere = 13,
	SmileRandom = 14,
	CantCarry = 15,
	MixPotion = 16,
	PotionExplode = 17,
	DoorLocked = 18,
	Strain = 19,  -- like pulling sword out of stone in MM6
	CantLearnSpell = 20,
	LearnSpell = 21,
	Hello = 22,
	HelloNight = 23,
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
	Smile = 36,
	ReadScoll = 37,
	NotEnoughGold = 38,
	CantEquip = 39,
	ItemBrokenStolen = 40,
	SPDrained = 41,
	Aged = 42,
	SpellFailed = 43,
	DamagedParty = 44,
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

	ThreatFail = 56,
	
	SmileHuge = 57,
	
	BribeFail = 58,
	NPCDontTalk = 59,
	SmileRandom2 = 60,

	LookUp = 63,
	LookDown = 64,
	Yell = 65,
	Falling = 66,
	ShakeHeadNo = 67,  -- shakes head

	TavernGotDrunk = 69,
	TavernTip = 70,
	ShakeHeadYes = 71,

	ShopIdentify = 73,
	ShopRepair = 74,
	
	ShopAlreadyIdentified = 76,

	ShopWrongShop = 79,
	ShopRude = 80,
	BankDeposit = 81,
	SmileBig = 82,
	TempleDonate = 83,
	HelloHouse = 84,

	AfraidSilent = 98,
	
	InPrison = 100,
	
	ChooseMe = 102,
	Awaken = 103,
	IdMonsterWeak = 104,
	IdMonsterBig = 105,
	IdMonsterFail = 106,
	LastManStanding = 107,
	Hungry = 108,
}

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

const.GameActions = {
	Exit = 113,
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
