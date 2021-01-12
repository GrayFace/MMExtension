#include "stdafx.h"
#include "lua_main.h"

char TextBuffer[0x2000];

void RegisterFunctionCalls()
{
	LuaInternalConst("TextBuffer", (int)TextBuffer);
}
