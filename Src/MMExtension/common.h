#pragma once

typedef unsigned char byte;

extern int MMVersion;
extern HWND *MainWindow;

extern byte *SPStatKinds;
extern byte MM6_SPStatKinds[];
extern byte MM7_SPStatKinds[];
extern byte MM8_SPStatKinds[];
extern char AppPath[];
extern bool InMMDir;

void FindMMVersion();
void ErrorMessage(const char * msg);
void InitPath(HMODULE hModule);
const char *RelPath(const char *path);  // converts path relative to <DLL folder>
PROC DllImport(const char * dll, const char * proc, bool halt);