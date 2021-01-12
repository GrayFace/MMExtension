#include "stdafx.h"
#include <stdio.h>

HWND MainWindowValue;
HWND *MainWindow;
char PathBuffer[MAX_PATH*2+1] = {0};
char *PathNamePart;
char AppPath[MAX_PATH+1];
bool InMMDir;
int Width, Height;

void ErrorMessage(const char * msg)
{
	MessageBox(*MainWindow, msg, "LuaConsole Error", MB_ICONERROR | (*MainWindow ? MB_TOPMOST : 0));
}

void InitPath(HMODULE hModule)
{
	MainWindow = &MainWindowValue;
	char name[MAX_PATH+1], name2[MAX_PATH+1], *namePart;
	GetModuleFileName(hModule, name, MAX_PATH+1);
	strcpy(strrchr(name, '.'), ".ini");
	GetFullPathName(name, MAX_PATH+1, AppPath, &namePart);
	*namePart = 0;
	GetPrivateProfileString("Settings", "GitPath", AppPath, name2, MAX_PATH+1, name);
	Width = GetPrivateProfileInt("Settings", "Width", 800, name);
	Height = GetPrivateProfileInt("Settings", "Height", 600, name);
	strcat_s(name2, "\\a");
	GetFullPathName(name2, MAX_PATH+1, PathBuffer, &PathNamePart);
	//LoadLibrary(name);
	*PathNamePart = 0;
	InMMDir = (stricmp(PathBuffer, AppPath) == 0);
}

const char *RelPath(const char *path)
{
	strcpy_s(PathNamePart, MAX_PATH+1, path);
	return PathBuffer;
}

static void DllImportHalt(const char * dll, const char * proc)
{
	char buf[256];
	sprintf_s(buf, 256, "Failed to load \"%s\" function from \"%s\"", proc, dll);
	ErrorMessage(buf);
	ExitProcess(0);
}

PROC DllImport(const char * dll, const char * proc, bool halt)
{
	PROC ret = GetProcAddress(LoadLibrary(dll), proc);
	if (!ret && halt)
		DllImportHalt(dll, proc);
	return ret;
}
