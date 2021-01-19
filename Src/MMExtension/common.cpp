#include "stdafx.h"
#include <stdio.h>

int MMVersion, m6, m7, m8;
HWND *MainWindow;
byte *SPStatKinds;
byte MM6_SPStatKinds[] = {0,0,0, 2,2,2, 1,1,1, 2,2,2, 1,1,1, 3,3,3};
byte MM7_SPStatKinds[] = {0,0,0,0, 0,1,1,1, 0,2,2,2, 2,2,2,2, 1,1,1,1, 0,3,3,3, 2,2,2,2, 3,3,3,3, 1,1,1,1};
byte MM8_SPStatKinds[] = {1,1, 2,2, 0,0, 0,0, 2,2, 1,1, 2,2, 1,1};
char PathBuffer[MAX_PATH*2+1] = {0};
char *PathNamePart;
char AppPath[MAX_PATH+1];
bool InMMDir;

void FindMMVersion()
{
	switch (*(byte*)0x41EDE1)  // just a random address
	{
		case 0xEC:
			MMVersion = 6;
			m6 = 1;
			MainWindow = (HWND*)0x61076C;
			SPStatKinds = MM6_SPStatKinds;
			break;
		case 0x45:
			MMVersion = 7;
			m7 = 1;
			MainWindow = (HWND*)0x6BE174;
			SPStatKinds = MM7_SPStatKinds;
			break;
		case 0x53:
			MMVersion = 8;
			m8 = 1;
			MainWindow = (HWND*)0x6F3934;
			SPStatKinds = MM8_SPStatKinds;
			break;
		default:
			MessageBox(0, "This is not a supported Might and Magic game", "MMExtension Error", MB_ICONERROR);
			ExitProcess(0);
	}
}

void ErrorMessage(const char * msg)
{
	MessageBox(*MainWindow, msg, "MMExtension Error", MB_ICONERROR | (*MainWindow ? MB_TOPMOST : 0));
}

void InitPath(HMODULE hModule)
{
	char name[MAX_PATH+1], *namePart;
	GetModuleFileName(hModule, name, MAX_PATH+1);
	//LoadLibrary(name);
	strcat_s(name, "\\..\\..\\a");
	GetFullPathName(name, MAX_PATH+1, PathBuffer, &PathNamePart);
	GetCurrentDirectory(MAX_PATH+1, name);
	strcat_s(name, "\\a");
	GetFullPathName(name, MAX_PATH+1, AppPath, &namePart);
	*PathNamePart = *namePart = 0;
	InMMDir = (_stricmp(PathBuffer, AppPath) == 0);
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
