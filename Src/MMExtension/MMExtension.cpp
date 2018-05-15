// MMExtension.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "common.h"
#include "Hooks.h"



BOOL APIENTRY DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpReserved)
{
	if (dwReason == DLL_PROCESS_ATTACH)
	{
		FindMMVersion();
		InitPath(hModule);
		WriteHooks();
	}
	return TRUE;
}