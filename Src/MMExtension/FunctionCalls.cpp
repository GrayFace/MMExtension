#include "stdafx.h"
#include "lua_main.h"

char TextBuffer[0x2000];

byte EVTBuf[0x10000];
// Also need: CurrentEvtLines, CurrentEvtLinesCount, targetObj, GlobalEventInfo
int __stdcall MM6_CallProcessEvent(int evtId, int seq, int vTargetMember)
{
	_asm
	{
		push    offset _exit

// do call
		sub     esp, 26Ch
		push    ebx
		mov     ebx, evtId
		push    ebp
		push    esi
		push    edi
		mov     [esp+27Ch-254h], ebx // _EventId
		mov     ds:[0x552F4C], 0

		mov     eax, seq
		mov     dword ptr [esp+27Ch-268h], eax   // curLabel
		mov     ds:[0x54D03C], eax     // EvtLabelNum
		mov     eax, vTargetMember
		mov     [esp+27Ch-25Ch], eax // vTargetMember
		mov     eax, offset EVTBuf
		mov     ds:[0x551D14], eax   // CurrentEvtBuf
		
		push    0x43C8EA
		ret

_exit:
	}
}

// Also need: CurrentEvtLines, CurrentEvtLinesCount, targetObj, GlobalEventInfo
int __stdcall MM7_CallProcessEvent(int evtId, int seq, int vTargetMember, int param)
{
	_asm
	{
		push    param
		push    offset _exit

// do call
		sub     esp, 498h
		push    ebx
		xor     ebx, ebx
		push    ebp
		push    esi
		push    edi
		mov     eax, evtId
		mov     [esp+4A8h-47Ch], eax // _EventId
		mov     [esp+4A8h-474h], ebx
		mov     ds:[0x5B6444], ebx

		mov     eax, vTargetMember
		mov     [esp+4A8h-488h], eax // vTargetMember
		mov     eax, seq
		mov     dword ptr [esp+4A8h-498h], eax   // curLabel
		mov     ds:[0x597D98], eax     // EvtLabelNum
		mov     eax, offset EVTBuf
		mov     ds:[0x590EFC], eax   // CurrentEvtBuf
		
		push    0x446915
		ret

_exit:
	}
}

int MM8_EH_prolog = 0x4D9DEC;
static int MM8_evtId, MM8_seq, MM8_TargetMember;
// Also need: CurrentEvtLines, CurrentEvtLinesCount, targetObj, GlobalEventInfo
int __stdcall MM8_CallProcessEvent(int evtId, int seq, int vTargetMember, int param)
{
	MM8_evtId = evtId;
	MM8_seq = seq;
	MM8_TargetMember = vTargetMember;
	_asm
	{
		push    param
		push    offset _exit

// do call
		mov     eax, 0x4E6CD1
		call    MM8_EH_prolog
		sub     esp, 540h
		push    ebx
		push    ebp
		push    esi
		xor     esi, esi
		push    edi
		mov     eax, MM8_evtId
		mov     [esp+55Ch-538h], eax // _EventId
		mov     [esp+55Ch-52Ch], esi
		mov     ds:[0x5CCCD4], esi

		mov     ebp, MM8_TargetMember
		mov     [esp+55Ch-524h], ebp // vTargetMember
		mov     eax, MM8_seq
		mov     dword ptr [esp+55Ch-548h], eax   // curLabel
		mov     ds:[0x5AC208], eax     // EvtLabelNum
		mov     eax, offset EVTBuf
		mov     ds:[0x5A536C], eax   // CurrentEvtBuf
		xor     edi, edi

		push    0x44382C
		ret

_exit:
	}
}

void RegisterFunctionCalls()
{
	LuaInternalConst("EvtBuf", (int)&EVTBuf);

	if (MMVersion == 6)
		LuaInternalConst("CallProcessEvent", (int)MM6_CallProcessEvent);
	if (MMVersion == 7)
		LuaInternalConst("CallProcessEvent", (int)MM7_CallProcessEvent);
	if (MMVersion == 8)
		LuaInternalConst("CallProcessEvent", (int)MM8_CallProcessEvent);

	LuaInternalConst("TextBuffer", (int)TextBuffer);
}
