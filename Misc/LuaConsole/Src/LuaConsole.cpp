// LuaConsole.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "common.h"
#include "lua_main.h"



int CALLBACK WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	InitPath(hInstance);
	InitLua();
	return 0;
}