#pragma once

typedef unsigned char byte;

extern char AppPath[];
extern bool InMMDir;
extern HWND *MainWindow;
extern int Width, Height;

void ErrorMessage(const char * msg);
void InitPath(HMODULE hModule);
const char *RelPath(const char *path);  // converts path relative to <DLL folder>
PROC DllImport(const char * dll, const char * proc, bool halt);