#include "stdafx.h"
#include "lua_main.h"
#include "FunctionCalls.h"

#define HKT_CALL     0x000001E8 // 5 bytes call
#define HKT_JMP      0x000001E9 // 5 bytes jump
#define HKT_JMP2     0x00000000 // 2 bytes jump (near)
#define HKT_JMP6     0x00000200 // 6 bytes conditional jump (use in combination with JZ, JA etc.)
#define HKT_BYTE     0x00000300 // Write 1 byte
#define HKT_WORD     0x00000400 // Write 2 bytes
#define HKT_LONG     0x00000500 // Write 4 bytes
#define HKT_DWORD    HKT_LONG   // same
#define HKT_PATCH    0x00000600 // Patch with a hex string of kind "10 5F 76 89 AF", any spaces between bytes are ignored
#define HKT_STR	     0x00000700 // Copy string without trailing 0
#define HKT_STR0     0x00000800 // Copy string including trailing 0
#define HKT_NOP      0x00000900 // Write NOPs

#define HKT_PTR      0x00001000 // 'what' points to a variable which value should be used
#define HKT_WHEREPTR 0x00002000 // 'wherePtr' points to a variable which value should be used as address to patch

// Conditional jumps:
#define HKT_JZ       0x74 // ==
#define HKT_JNZ      0x75
#define HKT_JA       0x77 // > (uint)
#define HKT_JNA      0x76
#define HKT_JB       0x72 // < (uint)
#define HKT_JNB      0x73
#define HKT_JG       0x7F // > (int)
#define HKT_JNG      0x7E
#define HKT_JL       0x7C // < (int)
#define HKT_JNL      0x7D
#define HKT_JC       0x72 // overflow (uint) (same as JB)
#define HKT_JNC      0x73
#define HKT_JO       0x70 // overflow (int)
#define HKT_JNO      0x71
#define HKT_JP       0x7A // parity flag
#define HKT_JNP      0x7B
#define HKT_JS       0x78 // sign flag (operation result is less than zero)
#define HKT_JNS      0x79


extern struct __HooksList
{
	long  wherePtr;  // address to hook/patch
	long  what;   // new function address / value to put / patch string
	long  flag;
	long  size;
	long* backup; // store last value in that variable
	long  queue;  // if some hook is optional, set queue to non-zero value and pass this value to WriteHooks if patching is needed
} MM6_HooksList[], MM7_HooksList[], MM8_HooksList[];

byte charToInt(byte ch)
{
	if (ch >= 'A') return ch - 'A' + 10;
	if (ch >= 'a') return ch - 'a' + 10;
	return ch - '0';
}

void WriteHooks(int queue = 0)
{
	__HooksList *HooksList;
	switch (MMVersion)
	{
		case 6:  HooksList = MM6_HooksList;  break;
		case 7:  HooksList = MM7_HooksList;  break;
		case 8:  HooksList = MM8_HooksList;  break;
	}
	long dummy, protLen, flag, p, what, size;
	long* back;
	for(int i = 0; HooksList[i].wherePtr; i++)
	{
		if(HooksList[i].queue != queue)
			continue;

		flag = HooksList[i].flag;
		p = HooksList[i].wherePtr;
		if(flag&HKT_WHEREPTR)
			p = *(long*)p;
		what = HooksList[i].what;
		if(flag&HKT_PTR)
			what = *(long*)what;
		size = HooksList[i].size;
		back = HooksList[i].backup;
		if (back == 0)
			back = &dummy;

		DWORD oldProt = 0;
		switch(flag&0xF00)
		{
			case HKT_JMP2: // 0x000 - 2 bytes
				VirtualProtect((void*)p, max(size, protLen = 2), PAGE_EXECUTE_READWRITE, &oldProt);
				*(byte*)p = (byte)((flag&255) ? (flag&255) : 0xEB);
				*back = *(signed char*)(p+1) + p + 2;
				*(signed char*)(p+1) = (signed char)(what-p-2);
				break;
			case (HKT_CALL&0xF00): // 0x100 - 5 bytes
				VirtualProtect((void*)p, max(size, protLen = 5), PAGE_EXECUTE_READWRITE, &oldProt);
				*(byte*)p = (byte)((flag&255) ? (flag&255) : 0xE9);
				*back = *(long*)(p+1) + p + 5;
				*(long*)(p+1) = what-p-5;
				break;
			case ((HKT_JZ|HKT_JMP6)&0xF00): // 0x200 - 6 bytes
				VirtualProtect((void*)p, max(size, protLen = 6), PAGE_EXECUTE_READWRITE, &oldProt);
				*(byte*)p = 0x0F;
				*(byte*)(p+1) = (byte)flag + 0x10;
				*back = *(char*)(p+2) + p + 6;
				*(long*)(p+2) = what-p-6;
				break;
			case HKT_BYTE:
				VirtualProtect((void*)p, max(size, protLen = 1), PAGE_EXECUTE_READWRITE, &oldProt);
				*(byte*)back = *(byte*)p;
				*(byte*)p = (byte)what;
				break;
			case HKT_WORD:
				VirtualProtect((void*)p, max(size, protLen = 2), PAGE_EXECUTE_READWRITE, &oldProt);
				*(WORD*)back = *(WORD*)p;
				*(WORD*)p = (WORD)what;
				break;
			case HKT_LONG:
				VirtualProtect((void*)p, max(size, protLen = 4), PAGE_EXECUTE_READWRITE, &oldProt);
				*back = *(long*)p;
				*(long*)p = (long)what;
				break;
			case HKT_PATCH:
			{
				int j = 0;
				for(byte* s = (byte*)what; *s; s++)
					if(*s != ' ')
						j++;
				VirtualProtect((void*)p, max(size, protLen = j/2), PAGE_EXECUTE_READWRITE, &oldProt);
				byte* s = (byte*)what;
				for(byte* t = (byte*)p; ; t++)
				{
					while(*s == ' ') s++;
					if(*s == 0) break;
					byte b = charToInt(*s)*16;
					s++;
					*t = b + charToInt(*s);
					s++;
				}
				break;
			}
			case HKT_STR:
			{
				VirtualProtect((void*)p, max(size, protLen = strlen((char*)what)), PAGE_EXECUTE_READWRITE, &oldProt);
				char* d = (char*)p;
				for(char* s = (char*)what; *s; s++, d++)
					*d = *s;
				break;
			}
			case HKT_STR0:
			{
				VirtualProtect((void*)p, max(size, protLen = strlen((char*)what) + 1), PAGE_EXECUTE_READWRITE, &oldProt);
				char* d = (char*)p;
				for(char* s = (char*)what; *d = *s; s++, d++) ;
				break;
			}
			default:
			{
				VirtualProtect((void*)p, size, PAGE_EXECUTE_READWRITE, &oldProt);
				protLen = 0;
				break;
			}
		}

		if (size > protLen)
			for (int j = protLen; j < size; j++)
				*(byte*)(p + j) = 0x90;
		VirtualProtect((void*)p, max(size, protLen), oldProt, &oldProt);
	}
}

// --------------------------------------- Hook Functions ---------------------------------------

void Start()
{
	InitLua();
}

long StartStd;
__declspec(naked) void _Start() 
{
	_asm
	{
		pushad
		call Start
		popad
		jmp StartStd
	}
}

void __stdcall AfterProcessEvent(int retseq, int evt, int seq, int GlobalEventInfo, int targetObj, int param)
{
	LuaRun("AfterProcessEvent", evt, seq, GlobalEventInfo, targetObj, param, retseq);
}

// Reenter info - use stored event buffer
#define StartRestoreReenter(CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount) }\
	_asm{ mov edx, ds:[CurrentEvtBuf] }\
	_asm{ push edx }\
	_asm{ mov edx, ds:[CurrentEvtLines] }\
	_asm{ push edx }\
	_asm{ mov edx, ds:[CurrentEvtLinesCount] }\
	_asm{ push edx }\
	_asm{ lea edx, ReenterEvtBuf }\
	_asm{ mov ds:[CurrentEvtBuf], edx }\
	_asm{ mov edx, ReenterEvtLines }\
	_asm{ mov ds:[CurrentEvtLines], edx }\
	_asm{ mov edx, [ReenterEvtLinesCount] }\
	_asm{ mov ds:[CurrentEvtLinesCount], edx }\
	_asm{ mov [ReenterEvtLinesCount], 0 }\
	_asm{

// Reenter info - revert to game's event buffer
#define EndRestoreReenter(CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount) }\
	_asm{ pop edx }\
	_asm{ mov ds:[CurrentEvtLinesCount], edx }\
	_asm{ pop edx }\
	_asm{ mov ds:[CurrentEvtLines], edx }\
	_asm{ pop edx }\
	_asm{ mov ds:[CurrentEvtBuf], edx }\
	_asm{

int tmp1, tmp2;
long ProcessEventStartStd;
// Calls AfterProcessEvent after the EVT_ProcessEvent finishes
__declspec(naked) void _MM6_ProcessEventStart()
{
	_asm
	{
		cmp ecx, 0x7FFF // reentering my event?
		jnz _normal
		pop eax            // -return address (into the EVT_ProcessEvent)

		// AfterProcessEvent params
		push 0             // param
		push edx           // targetObj
		push ds:[0x55BC00] // GlobalEventInfo
		push ds:[0x54D03C] // seq
		push ecx           // evt
		StartRestoreReenter(0x551D14, 0x533EC0, 0x54D010) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		// CallProcessEvent params: int evtId, int seq, int vTargetMember, int param
		push 0             // param
		push 1               /// vTargetMember
		push ds:[0x54D03C]   /// seq
		push ecx             /// evtId
		call MM6_CallProcessEvent
		EndRestoreReenter(0x551D14, 0x533EC0, 0x54D010) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		// call AfterProcessEvent
		push eax           // retseq
		call AfterProcessEvent
		ret

_normal:
		pop   eax  // -function ptr
		// param and return address for AfterProcessEvent
		mov   tmp1, ecx
		mov   tmp2, edx
		pop   edx  // -return address
		push  0    // param
		push  tmp2 // targetObj
		push  ds:[0x55BC00] // GlobalEventInfo
		push  ds:[0x54D03C] // seq
		push  tmp1  // evt
		push  0     // retseq
		push  edx   // return address
		mov   edx, tmp2
		push  AfterProcessEvent // new return address for EVT_ProcessEvent

		//sub   esp, 0x26C // std code
		//jmp   eax
		push eax
		jmp ProcessEventStartStd
	}
}


__declspec(naked) void _MM7_ProcessEventStart() 
{
	_asm
	{
		cmp ecx, 0x7FFF // reentering my event?
		jnz _normal
		pop eax            // -return address (into the EVT_ProcessEvent)

		// AfterProcessEvent params
		push [esp + 4]     // param
		push edx           // targetObj
		mov edx, [esp + 4]
		push ds:[0x5C32A0] // GlobalEventInfo
		push ds:[0x597D98] // seq
		push ecx           // evt
		StartRestoreReenter(0x590EFC, 0x5840B8, 0x590EF8) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		// CallProcessEvent params: int evtId, int seq, int vTargetMember, int param
		push edx             /// param
		push 1               /// vTargetMember
		push ds:[0x597D98]   /// seq
		push ecx             /// evtId
		call MM7_CallProcessEvent
		EndRestoreReenter(0x590EFC, 0x5840B8, 0x590EF8) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		push eax           // retseq
		call AfterProcessEvent
		ret 4

_normal:
		pop   eax  // -function ptr
		// param and return address for AfterProcessEvent
		mov   tmp2, edx
		pop   edx  // -return address
		mov   tmp1, edx
		mov   edx, [esp] // param
		push  tmp2 // targetObj
		push  ds:[0x5C32A0] // GlobalEventInfo
		push  ds:[0x597D98] // seq
		push  ecx  // evt
		push  0     // retseq
		push  tmp1   // return address
		push  edx // param
		mov   edx, tmp2
		push  AfterProcessEvent // new return address for EVT_ProcessEvent

		push eax
		jmp ProcessEventStartStd
	}
}

__declspec(naked) void _MM8_ProcessEventStart() 
{
	_asm
	{
		cmp ecx, 0x7FFF // reentering my event?
		jnz _normal
		pop eax            // -return address (into the EVT_ProcessEvent)

		// AfterProcessEvent params
		push [esp + 4]     // param
		push edx           // targetObj
		mov edx, [esp + 4]
		push ds:[0x5DB750] // GlobalEventInfo
		push ds:[0x5AC208] // seq
		push ecx           // evt
		StartRestoreReenter(0x5A536C, 0x596908, 0x5A5368) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		// CallProcessEvent params: int evtId, int seq, int vTargetMember, int param
		push edx             /// param
		push 1               /// vTargetMember
		push ds:[0x5AC208]   /// seq
		push ecx             /// evtId
		call MM8_CallProcessEvent
		EndRestoreReenter(0x5A536C, 0x596908, 0x5A5368) // CurrentEvtBuf, CurrentEvtLines, CurrentEvtLinesCount
		push eax           // retseq
		call AfterProcessEvent
		ret 4

_normal:
		pop   eax  // -function ptr
		// param and return address for AfterProcessEvent
		mov   tmp2, edx
		pop   edx  // -return address
		mov   tmp1, edx
		mov   edx, [esp] // param
		push  tmp2 // targetObj
		push  ds:[0x5DB750] // GlobalEventInfo
		push  ds:[0x5AC208] // seq
		push  ecx  // evt
		push  0     // retseq
		push  tmp1   // return address
		push  edx // param
		mov   edx, tmp2
		push  AfterProcessEvent // new return address for EVT_ProcessEvent

		push eax
		jmp ProcessEventStartStd
	}
}


// EVT_ProcessEvent finds a 01 command. Its Seq (line number) is used as return value now.
__declspec(naked) void _MM6_ProcessEventReturn01() 
{
	_asm
	{
		// esi = Current Cmd Buffer
		xor eax, eax
		mov al, [esi+3]
		pop edi
		pop esi
		pop ebp
		pop ebx
		add esp, 0x26C
		ret
	}
}

__declspec(naked) void _MM6_ProcessEventReturnOther()
{
	_asm
	{
		xor eax, eax
		add esp, 0x26C
		ret
	}
}

long _MM7_EVT_OnMapLeave = 0x443FB8;
__declspec(naked) void _MM7_ProcessEventReturn01() 
{
	_asm
	{
		// esi = Current Cmd Buffer
		xor eax, eax
		mov al, [esi+3]
		cmp [esp+4A8h-474h], 1
		jnz _norm
		push eax
		call _MM7_EVT_OnMapLeave
		pop eax
_norm:
		pop edi
		pop esi
		pop ebp
		pop ebx
		add esp, 0x498
		ret 4
	}
}

__declspec(naked) void _MM7_ProcessEventReturnOther()
{
	_asm
	{
		xor eax, eax
		add esp, 0x498
		ret 4
	}
}

long _MM8_EVT_OnMapLeave = 0x440DBC;
__declspec(naked) void _MM8_ProcessEventReturn01() 
{
	_asm
	{
		// esi = Current Cmd Buffer
		xor eax, eax
		mov al, [esi+3]
		cmp [esp+55Ch-52Ch], 1
		jnz _norm
		push eax
		call _MM8_EVT_OnMapLeave
		pop eax
_norm:
		mov ecx, [esp+55Ch-0Ch]
		push 0x445759
		ret
	}
}

__declspec(naked) void _MM8_ProcessEventReturnOther()
{
	_asm
	{
		xor eax, eax
		mov ecx, [esp+55Ch-0Ch]
		push 0x445759
		ret
	}
}

int __fastcall ProcessCanShowTopic(int evt, int def)
{
	return LuaRun("CanShowTopic", evt, def);
}

__declspec(naked) void _ProcessCanShowTopic()
{
	_asm
	{
		mov ecx, [esp + 0x14 - 4]
		mov edx, eax
		call ProcessCanShowTopic
		pop ebp
		add esp, 0x10
		ret
	}
}


void *(*MM6_OnLoadMapStd)();

__declspec(naked) void MM7_OnLoadMapStd()
{
	_asm
	{
		push ebp
		mov ebp, esp
		sub esp, 0x4C
		push 0x444005
		ret
	}
}

__declspec(naked) void MM8_OnLoadMapStd()
{
	_asm
	{
		push ebp
		mov ebp, esp
		sub esp, 0x68
		push 0x440E09
		ret
	}
}

void _OnLoadMap()
{
	if(MMVersion != 6)
		LuaRun("OnLoadMap");

	if (MMVersion == 6)
		MM6_OnLoadMapStd();
	else if (MMVersion == 7)
		MM7_OnLoadMapStd();
	else
		MM8_OnLoadMapStd();

	LuaRun("AfterLoadMap");
}

void MM6_OnLoadMapMiddle()
{
	LuaRun("OnLoadMap");
}

__declspec(naked) void _MM6_OnLoadMapMiddle()
{
	_asm
	{
		mov ds:[0x533EB4], edx
		push ecx
		call MM6_OnLoadMapMiddle
		pop ecx
		mov edx, ds:[0x533EB4]
		test edx, edx
		ret
	}
}

__declspec(naked) void _MM6_OnLoadMapNoEvt()
{
	_asm
	{
		push    ebp
		push    esi
		push    edi
		mov     ecx, 320h
		xor     eax, eax
		mov     edi, 0x54F060
		xor     ebp, ebp
		rep stosd
		mov     ecx, 2328h
		mov     eax, 80808080h
		mov     edi, 0x552F58
		xor     esi, esi
		rep stosd
		xor     edx, edx
		mov     ds:[0x552F50], ebp
		mov     ds:[0x533EB4], ebp
		xor     eax, eax
		mov     ecx, 0x552F58 + 4
		pop ebp
		pop esi
		pop edi
		call MM6_OnLoadMapMiddle
		add esp, 0x38
		ret
	}
}

__declspec(naked) void _MM7_OnLoadMapNoEvt()
{
	_asm
	{
		xor eax, eax
		cmp ds:[0x5B0F94], eax
		jnz _norm
		mov [esp], 0x443FB6
_norm:
		ret 0x18
	}
}

__declspec(naked) void _MM8_OnLoadMapNoEvt()
{
	_asm
	{
		xor ecx, ecx
		cmp ds:[0x5C7024], ecx
		jnz _norm
		mov [esp], 0x440DBA
_norm:
		ret 0x18
	}
}

char * __fastcall OnGetEventHint(int evt)
{
	return LuaRun("OnGetEventHint", evt) ? TextBuffer : 0;
}

__declspec(naked) void _MM6_OnGetEventHint()
{
	_asm
	{
		push ecx
		call OnGetEventHint
		test eax, eax
		jz _normal
		add esp, (4+2)*4
		ret

_normal:
		pop ecx
		mov edi, ds:[0x533EB4]
		ret
	}
}

__declspec(naked) void _MM7_OnGetEventHint()
{
	_asm
	{
		push ecx
		call OnGetEventHint
		test eax, eax
		jz _normal
		add esp, (3+2)*4
		ret

_normal:
		pop ecx
		mov edi, ds:[0x5B0F90]
		ret
	}
}

__declspec(naked) void _MM8_OnGetEventHint()
{
	_asm
	{
		push ecx
		call OnGetEventHint
		test eax, eax
		jz _normal
		add esp, (3+2)*4
		ret

_normal:
		pop ecx
		mov edi, ds:[0x5C7020]
		ret
	}
}

char * __fastcall MM6_OnGetMazeInfo()
{
	return LuaRun("OnGetMazeInfo") ? TextBuffer : 0;
}

__declspec(naked) void _MM6_OnGetMazeInfo()
{
	_asm
	{
		call MM6_OnGetMazeInfo
		test eax, eax
		jz _normal
		add esp, 2*4
		ret

_normal:
		mov esi, ds:[0x533EB4]
		ret
	}
}

void MainLoopEnd()
{
	LuaRun("OnExitToMainMenu");
}

__declspec(naked) void _MM6_MainLoopEnd()
{
	_asm
	{
		call MainLoopEnd
		pop ebx
		add esp, 0x6C
		ret
	}
}

long MM78_MainLoopEndStd;
__declspec(naked) void _MM78_MainLoopEnd()
{
	_asm
	{
		call MM78_MainLoopEndStd
		jmp MainLoopEnd
	}
}

void OnLoadGame()
{
	LuaRun("OnLoadGame");
}

__declspec(naked) void _MM6_LoadGame()
{
	_asm
	{
		call OnLoadGame
		mov ecx, 0x610830
		ret
	}
}

__declspec(naked) void _MM7_LoadGame()
{
	_asm
	{
		push ecx
		call OnLoadGame
		pop ecx
		pop eax
		push 0x4E94EC
		jmp eax
	}
}

__declspec(naked) void _MM8_LoadGame()
{
	_asm
	{
		call OnLoadGame
		pop eax
		push 0x4F90A0
		jmp eax
	}
}

void OnSaveGame()
{
	LuaRun("OnSaveGame");
}

__declspec(naked) void _MM6_SaveGame()
{
	_asm
	{
		call OnSaveGame
		mov edi, 0x4C04DC
		ret
	}
}

__declspec(naked) void _MM7_SaveGame()
{
	_asm
	{
		push eax
		call OnSaveGame
		pop eax
		pop ecx
		push 0x4E9574
		jmp ecx
	}
}

__declspec(naked) void _MM8_SaveGame()
{
	_asm
	{
		push eax
		call OnSaveGame
		pop eax
		pop ecx
		push 0x4F913C
		jmp ecx
	}
}

void LeaveMap()
{
	LuaRun("OnLeaveMap");
}

__declspec(naked) void _MM6_LeaveMapWalk()
{
	_asm
	{
		call LeaveMap
		mov ecx, 0x52D0A8
		ret
	}
}

__declspec(naked) void _MM6_LeaveMapDie()
{
	_asm
	{
		call LeaveMap
		mov edi, offset TextBuffer
		ret
	}
}

__declspec(naked) void _MM6_LeaveMapOther()
{
	_asm
	{
		call LeaveMap
		mov ecx, 0x4D5180
		ret
	}
}

__declspec(naked) void _MM7_LeaveMap()
{
	_asm
	{
		pop eax
		push LeaveMap
		push eax
		cmp ds:[0x5B0F90], edi
		push 0x443FC1
		ret
	}
}

__declspec(naked) void _MM8_LeaveMap()
{
	_asm
	{
		pop eax
		push LeaveMap
		push eax
		cmp ds:[0x5C7020], edi
		push 0x440DC5
		ret
	}
}

void *(__fastcall *OnTimerStd)(int par);
void __fastcall _OnTimer(int par)
{
	LuaRun("OnTimer");
	OnTimerStd(par);
}

void BeforeLoadMap()
{
	LuaRun("BeforeMapLoad");
}

__declspec(naked) void _MM6_BeforeLoadMap()
{
	_asm
	{
		push BeforeLoadMap
		sub esp, 0x40C
		push 0x458BD6
		ret
	}
}

__declspec(naked) void _MM7_BeforeLoadMap()
{
	_asm
	{
		push BeforeLoadMap
		push ebp
		mov ebp, esp
		sub esp, 0x40C
		push 0x46074E
		ret
	}
}

__declspec(naked) void _MM8_BeforeLoadMap()
{
	_asm
	{
		push BeforeLoadMap
		push ebp
		mov ebp, esp
		sub esp, 0x40C
		push 0x45E061
		ret
	}
}

__declspec(naked) int __stdcall MM6_CalcSpellDamageStd(int spell, int skill, int mastery, int monHP)
{
	_asm
	{
		mov eax, [esp+4]
		push esi
		push 0x47F0A5
		ret
	}
}

__declspec(naked) int __fastcall MM7_CalcSpellDamageStd(int spell, int skill, int mastery, int monHP)
{
	_asm
	{
		xor eax, eax
		push edi
		cmp ecx, 7
		push 0x43B00C
		ret
	}
}

__declspec(naked) int __fastcall MM8_CalcSpellDamageStd(int spell, int skill, int mastery, int monHP)
{
	_asm
	{
		push ebp
		mov ebp, esp
		xor eax, eax
		push 0x438B0A
		ret
	}
}

int __stdcall MM6_CalcSpellDamage(int spell, int skill, int mastery, int monHP)
{
	return LuaRun("CalcSpellDamage", MM6_CalcSpellDamageStd(spell, skill, mastery, monHP), spell, skill, mastery, monHP);
}

int __fastcall MM7_CalcSpellDamage(int spell, int skill, int mastery, int monHP)
{
	return LuaRun("CalcSpellDamage", MM7_CalcSpellDamageStd(spell, skill, mastery, monHP), spell, skill, mastery, monHP);
}

int __fastcall MM8_CalcSpellDamage(int spell, int skill, int mastery, int monHP)
{
	return LuaRun("CalcSpellDamage", MM8_CalcSpellDamageStd(spell, skill, mastery, monHP), spell, skill, mastery, monHP);
}


int (__fastcall *TravelWalkStd)(const char *mapName, int, int x, int y, char* buf, int bufsize);

__declspec(naked) int __fastcall MM6_TravelWalkStd(const char *mapName, int, int x, int y, char* buf, int bufsize)
{
	_asm
	{
		mov eax, [esp + 0x10]
		mov edx, ecx
		push 0x47BCA6
		ret
	}
}

__declspec(naked) int __fastcall MM7_TravelWalkStd(const char *mapName, int, int x, int y, char* buf, int bufsize)
{
	_asm
	{
		push ebp
		mov ebp, esp
		sub esp, 0x78
		push 0x48901A
		ret
	}
}

__declspec(naked) int __fastcall MM8_TravelWalkStd(const char *mapName, int, int x, int y, char* buf, int bufsize)
{
	_asm
	{
		push ebp
		mov ebp, esp
		sub esp, 0x78
		push 0x4889AE
		ret
	}
}

int __fastcall TravelWalk(const char *mapName, int, int x, int y, char* buf, int bufsize)
{
	return LuaRun("TravelWalk", (int)mapName, x, y, (int)buf, bufsize, TravelWalkStd(mapName, 0, x, y, buf, bufsize));
}


void SetFogRange()
{
	LuaRun("SetFogRange");
}

__declspec(naked) void _MM6_SetFogRange()
{
	_asm
	{
		mov ds:[0x689C8C], ecx
		jmp SetFogRange
	}
}

__declspec(naked) void _MM7_SetFogRange()
{
	_asm
	{
		mov ds:[0x6A1174], eax
		jmp SetFogRange
	}
}

__declspec(naked) void _MM8_SetFogRange()
{
	_asm
	{
		mov ds:[0x6CF0E0], eax
		jmp SetFogRange
	}
}


void NewGameMap()
{
	LuaRun("NewGameMap");
}

long NewGameMapStd;

__declspec(naked) void _NewGameMap()
{
	_asm
	{
		push ecx
		push edx
		call NewGameMap
		pop edx
		pop ecx
		jmp NewGameMapStd
	}
}


int __cdecl MM6_DeathMap(char* std, char* current)
{
	strcpy(TextBuffer, std);
	LuaRun("DeathMap", (DWORD)TextBuffer);
	return strcmpi(TextBuffer, current);
}

int __cdecl MM78_DeathMap(char* name, char* current)
{
	LuaRun("DeathMap", (DWORD)name);
	return strcmpi(name, current);
}


int _EndPaint(HWND wnd, const PAINTSTRUCT* paint)
{
	int r = EndPaint(wnd, paint);
	HWND w = GetActiveWindow();
	if (w != wnd)
	{
		ValidateRect(wnd, 0);
		InvalidateRect(w, 0, false);
		UpdateWindow(w);
	}
	return r;
}

int (__fastcall *Initialize1Std)(int a1, int a2);
int __fastcall Initialize1(int a1, int a2)
{
	int r = Initialize1Std(a1, a2);
	if (r)  LuaRun("GameInitialized1");
	return r;
}


int (__fastcall *Initialize2Std)(int a1);
int __fastcall Initialize2(int a1)
{
	int r = Initialize2Std(a1);
	if (r)  LuaRun("GameInitialized2");
	return r;
}

const int MM8_GetCurrentIntellect = 0x48C462;
const int MM8_GetCurrentPersonality = 0x48C4BF;
const int MM8_GetStatEffect = 0x48E18E;
__declspec(naked) void _MM8_SPStatIP()
{
	_asm
	{
		mov ecx, edi
		call MM8_GetCurrentIntellect
		mov ecx, edi
		push eax
		call MM8_GetStatEffect
		add esi, eax
		mov ecx, edi
		call MM8_GetCurrentPersonality
		mov ecx, edi
		push eax
		call MM8_GetStatEffect
		add esi, eax
		mov ecx, edi
		push 0x48DA52
		ret
	}
}


/*
void _Validate()
{
	HWND wnd = *MainWindow;
	//ValidateRect(*MainWindow, 0);
	HWND w = GetActiveWindow();
	if (w != wnd)
	{
		ValidateRect(wnd, 0);
		InvalidateRect(w, 0, false);
		//UpdateWindow(w);
	}
}

__declspec(naked) void _MM7_Validate()
{
	_asm
	{
		push 0x4639FE
		call _Validate
	}
}

int IsActive()
{
	return 0;//GetActiveWindow() == *MainWindow;
}

__declspec(naked) void _LoopFlush()
{
	_asm
	{
		push ecx
		call IsActive
		pop ecx
		test eax, eax
		jz _skip
		pop eax
		push    ebp
		mov     ebp, esp
		sub     esp, 28h
		jmp eax
_skip:
		ret
	}
}


	//{0x4638FF, (long)_EndPaint, HKT_CALL, 6}, // 
	//{0x4638A5, (long)_MM7_Validate, HKT_JMP, 6},
	{0x49FBC7, (long)_LoopFlush, HKT_CALL, 6},
*/

#include "MM6_HooksList.h"
#include "MM7_HooksList.h"
#include "MM8_HooksList.h"
