#include "stdafx.h"
#include <stdlib.h>
#include <windows.h>
extern "C"
{
	#include "lua.h"
	#include "lauxlib.h"
}
#include "hde32.h"

static DWORD ToDWORD(lua_State *L, int i)
{
	lua_Number num = lua_tonumber(L, i);
	if (num>=0)
		return (DWORD)num;
	else
		return (int)num;
}

static int DoGetHookSize(lua_State *L, DWORD lim)
{
	DWORD p = ToDWORD(L, 1);
	lua_settop(L, 0);
	DWORD n = 0;
	bool jumps = false, jumpl = false;
	while (n < lim)
	{
		hde32s a;
		hde32_disasm((void*)(p + n), &a);
		n += a.len;
		// recognize relative jump/call instructions
		// https://c9x.me/x86/html/file_module_x86_id_147.html, https://c9x.me/x86/html/file_module_x86_id_26.html, https://c9x.me/x86/html/file_module_x86_id_146.html
		// ignore short jumps within the code block
		jumps = jumps || ((a.opcode|0xF) == 0x7F || a.opcode == 0xEB || a.opcode == 0xE3) && ((DWORD)(*(signed char*)(p + n - 1) + n) >= lim);  // conditional, jmp, jecxz
		// report all near jumps regardless
		jumpl = jumpl || a.opcode == 0x0F && (a.opcode2|0xF) == 0x8F || a.opcode == 0xE8 || a.opcode == 0xE9;  // conditional, call, jmp
	}
	lua_pushnumber(L, n);
	lua_pushboolean(L, jumps);
	lua_pushboolean(L, jumpl);
	return 3;
}

static int GetHookSize(lua_State *L)
{
	return DoGetHookSize(L, 5);
}

static int GetInstructionSize(lua_State *L)
{
	return DoGetHookSize(L, 1);
}

void RSMemHDetourRegister(lua_State *L)
{
	lua_getglobal(L, "mem");
	lua_pushcfunction(L, GetHookSize);
	lua_setfield(L, -2, "GetHookSize");
	lua_pushcfunction(L, GetInstructionSize);
	lua_setfield(L, -2, "GetInstructionSize");
	lua_pop(L, 1);
}
