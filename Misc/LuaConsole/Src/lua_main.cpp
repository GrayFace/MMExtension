#include "stdafx.h"
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "lua_main.h"
#include "common.h"
extern "C"
{
	#include "lua.h"
	#include "lualib.h"
	#include "lauxlib.h"
	#include "luasocket.h"
	extern unsigned char *lj_get_char_bits();
}
#include "FunctionCalls.h"
//#include "lupvaluejoin.h"
#include "RSMem.h"

// set panic (&error) function, error function

#define Dword DWORD

lua_State *Lua;

int ErrfIndex;

int ToInteger(lua_State *L, int i)
{
	//if (lua_isnumber(L, i))  return (int)lua_tonumber(L, i);
	//if (lua_isboolean(L, i))  return lua_toboolean(L, i);
	//return 0;

	lua_Number num = lua_tonumber(L, i);
	if (num>=0)
		return (DWORD)num;
	else
		return (int)num;
}

const char* ToString(lua_State *L, int i)
{
	const char* str = lua_tostring(L, i);
	if (str)  return str;

	int type = lua_type(L, i);
	if (type == LUA_TBOOLEAN)  return (lua_toboolean(L, i) ? "true" : "false");
	return lua_typename(L, lua_type(L, i));
}

static void ErrorMessageExe(lua_State *L)
{
	ErrorMessage(ToString(L, -1));			
	lua_pop(L, 1);
}

static void ErrorMessage(lua_State *L)
{
	int param = lua_gettop(L);

	lua_getfield(L, LUA_REGISTRYINDEX, "ErrorMessage"); // get 'internal.ErrorMessage'
	lua_pushvalue(L, param);
	if (lua_pcall(L, 1, 0, 0) == 0)
	{
		lua_settop(L, param - 1);
		return;
	}
	lua_settop(L, param);
	ErrorMessageExe(L);
}

//-------- Messages ---------

int PanicMessage(lua_State *L)
{
	const char* str = "nil";
	if (lua_gettop(L) != 0)
	{
		str = ToString(L, 1);
	}
	ErrorMessage(str);
	lua_settop(L, 0);
	return 0;
}

//-------- xpcall ---------

//static int lua_xpcall (lua_State *L) {
//	luaL_checktype(L, 2, LUA_TFUNCTION);
//
//	// switch function & error function
//	lua_pushvalue(L, 1);
//	lua_pushvalue(L, 2);
//	lua_replace(L, 1);
//	lua_replace(L, 2);
//
//	// call
//	lua_pushboolean(L, 0 == lua_pcall(L, lua_gettop(L) - 2, LUA_MULTRET, 1));
//	lua_replace(L, 1);
//	return lua_gettop(L);
//}

//-------- random ---------

//int DelphiRSeed;
//
//_declspec( naked ) int __fastcall DelphiRand(int /*range*/)
//{
//	_asm
//	{
//		mov eax, ecx
//		push ebx
//		xor ebx, ebx
//		imul edx, DelphiRSeed[ebx], 0x08088405
//		inc edx
//		mov DelphiRSeed, edx
//		mul edx
//		mov eax, edx
//		pop ebx
//		ret
//	}
//}

//-------- os.find support ---------

typedef struct MY_WIN32_FIND_DATA
{
	WIN32_FIND_DATA d;
	HANDLE h;
	DWORD attr; //, attrF;
	bool started;
} *PMY_WIN32_FIND_DATA;

static int LuaFindStart(lua_State *L)
{
	char file[MAX_PATH + 1];
	strcpy_s(file, sizeof(file), ToString(L, 1));
	DWORD attr = (lua_toboolean(L, 2) ? FILE_ATTRIBUTE_DIRECTORY : 0);
	lua_settop(L, 0);

	PMY_WIN32_FIND_DATA data = (PMY_WIN32_FIND_DATA)lua_newuserdata(L, sizeof(MY_WIN32_FIND_DATA));
	if (data == 0) return 0;

	GetFullPathName(file, sizeof(file), file, 0);
	HANDLE fh = FindFirstFile(file, &data->d);
	if (fh == INVALID_HANDLE_VALUE) return 0;

	// Push userdata
	data->h = fh;
	//data->attrF = FILE_ATTRIBUTE_DIRECTORY;
	data->attr = attr;
	data->started = false;
	lua_newtable(L);
	lua_setmetatable(L, 1);

	// Push directory of the files
	int i = strlen(file) - 1;
	while ((i >= 0) && (file[i] != '/') && (file[i] != '\\'))  i--;
	lua_pushlstring(L, file, i+1);
	lua_pushnumber(L, (DWORD)&data->d);

	return 3;
}

static int DoFindNext(PMY_WIN32_FIND_DATA data)
{
	if (data->h == 0)
		return 0;

	if (FindNextFile(data->h, &data->d) == 0)
	{
		FindClose(data->h);
		data->h = 0;
		return 0;
	}
	return 1;
}

static int LuaFindNext(lua_State *L)
{
	PMY_WIN32_FIND_DATA data = (PMY_WIN32_FIND_DATA)lua_touserdata(L, 1);
	lua_settop(L, 0);
	if (data->h == 0) return 0;
	DWORD attr = data->attr;
	const DWORD attrF = FILE_ATTRIBUTE_DIRECTORY; // data->attrF;
	if (data->started && DoFindNext(data) == 0)
		return 0;
	data->started = true;
	while ((data->d.dwFileAttributes & attrF) != attr || *(WORD*)data->d.cFileName == '.' || (*(DWORD*)data->d.cFileName & 0xFFFFFF) == '.' + '.'*256)
		if (DoFindNext(data) == 0)
			return 0;
	lua_pushstring(L, data->d.cFileName);
	lua_pushnumber(L, (lua_Number)(((long long)data->d.nFileSizeHigh) << 32) + (long long)data->d.nFileSizeLow);
	return 2;
}

static int LuaFindClose(lua_State *L)
{
	PMY_WIN32_FIND_DATA data = (PMY_WIN32_FIND_DATA)lua_touserdata(L, 1);
	if (data->h)
	{
		FindClose(data->h);
		data->h = 0;
	}
	lua_settop(L, 0);
	return 0;
}

//-------- Debug Console ---------

char * (__stdcall *DebugDialog)(HWND wnd, const char * text, long top);
void (__stdcall *DebugDialogAnswer)(const char * text, long selpos);
void (__stdcall *DebugDialogBranch)(const char * text);
int (__stdcall *DebugDialogCharsInLine)(HWND wnd);
void (__stdcall *DebugDialogResize)(int w, int h);
void (__stdcall *DebugDialogCaption)(const char * text);
const char * (__stdcall *DebugDialogLastResult)(const char * text);

static int DebugConsole(lua_State *L)
{
	const char * s = (lua_isstring(L, 3) ? lua_tostring(L, 3) : "");
	DebugDialogBranch(s);
	if (lua_isstring(L, 1))
	{
		s = lua_tostring(L, 1);
		if (s == 0)
			s = "";
	}
	else
	{
		s = 0;
	}
	lua_pushstring(L, DebugDialog(*MainWindow, s, lua_toboolean(L, 2)));
	return 1;
}

static int DebugConsoleAnswer(lua_State *L)
{
	DebugDialogAnswer(lua_tostring(L, 1), lua_gettop(L) > 1 ? (long)lua_tonumber(L, 2) : 0);
	return 0;
}

static int DebugConsoleCharsInLine(lua_State *L)
{
	lua_pushnumber(L, DebugDialogCharsInLine(*MainWindow));
	return 1;
}

static int DebugConsoleLastResult(lua_State *L)
{
	lua_pushstring(L, DebugDialogLastResult(0));
	if (lua_gettop(L) > 1 && lua_isstring(L, 1))
		DebugDialogLastResult(lua_tostring(L, 1));
	return 1;
}

//-------- Asm compiler ---------

int (__stdcall *fasm_Assemble)(LPCCH source, byte *memory, int MemorySize, int PassesLimit, int DisplayPipe);

struct LINE_HEADER
{
	LPCCH file_path;
	int line_number;
	union
	{
		int file_offset;
		LINE_HEADER* macro_calling_line;
	};
	LINE_HEADER* macro_line;
};

static struct FASM_STATE
{
	int condition;
	union
	{
		int output_length;
		int error_code;
	};
	union
	{
		char *output_data;
		LINE_HEADER *error_line;
	};
	byte CodeBuffer[0x10000]; // my addition. The size is mentioned in AsmGenErrors error message
} fasm_state;

static void AsmPushLineNumber(lua_State *L, LINE_HEADER* a, int BaseLine)
{
	if (a->line_number >= 0)
	{
		lua_pushnumber(L, a->line_number - BaseLine);
	}
	else
	{
		AsmPushLineNumber(L, a->macro_calling_line, BaseLine);
		lua_pushstring(L, ":macro:");
		AsmPushLineNumber(L, a->macro_line, BaseLine);
	}
}

static const int AsmGenErrorsSize = 9;
static const char *AsmGenErrors[AsmGenErrorsSize] = {
	"asm: unknown error",
	"asm: invalid parameter",
	"asm: output size exceeds 64KB limit",
	"asm: stack overflow",
	"asm: source not found",
	"asm: unexpected end of source",
	"asm: cannot generate code",
	"asm: format limitations excedded",
	"asm: write failed"
};

static const int AsmErrorsSize = 42;
static const char *AsmErrors[AsmErrorsSize] = {
	"unknown error",
	"file not found",
	"error reading file",
	"invalid file format",
	"invalid macro arguments ",
	"incomplete macro",
	"unexpected characters",
	"invalid argument",
	"illegal instruction",
	"invalid operand ",
	"invalid operand size",
	"operand size not specified",
	"operand sizes do not match",
	"invalid address size",
	"address sizes do not agree",
	"disallowed combination of registers = -115",
	"long immediate not encodable",
	"relative jump out of range",
	"invalid expression",
	"invalid address ",
	"invalid value",
	"value out of range",
	"undefined symbol",
	"invalid use of symbol",
	"name too long",
	"invalid name",
	"reserved word used as symbol",
	"symbol already defined",
	"missing end quote",
	"missing end directive",
	"unexpected instruction",
	"extra characters on line",
	"section not aligned enough",
	"setting already specified",
	"data already defined",
	"too many repeats",
	"symbol out of scope",
	"unknown error",
	"unknown error",
	"unknown error",
	"user error",
	"assertion failed"
};

static int CompileAsm(lua_State *L)
{
	int r = fasm_Assemble(lua_tostring(L, 1), (byte*)&fasm_state, sizeof(fasm_state), 100, 0);
	int BaseLine = (int)lua_tonumber(L, 2);
	lua_settop(L, 0);
	
	if (r == 0)
	{
		lua_pushlstring(L, fasm_state.output_data, fasm_state.output_length);
		return 1;
	}
	lua_pushnil(L);
	if (r == 2)
	{
		lua_pushstring(L, "asm:");
		AsmPushLineNumber(L, fasm_state.error_line, BaseLine);
		lua_pushstring(L, ": ");
		r = -fasm_state.error_code - 100;
		if (r > 0 && r < AsmErrorsSize)
			lua_pushstring(L, AsmErrors[r]);
		else
			lua_pushstring(L, AsmErrors[0]);
		lua_concat(L, lua_gettop(L) - 1);
	}
	else
	{
		r = -r;
		if (r > 0 && r < AsmGenErrorsSize)
			lua_pushstring(L, AsmGenErrors[r]);
		else
			lua_pushstring(L, AsmGenErrors[0]);
	}
	return 2;
}

//-------- Calls to Lua ---------

int LuaFunction(const char *name)
{
	lua_rawgeti(Lua, LUA_REGISTRYINDEX, ErrfIndex); // error function
	lua_getfield(Lua, LUA_REGISTRYINDEX, name); // get 'internal'.name
	if (lua_type(Lua, -1) != LUA_TFUNCTION)
	{
		lua_pop(Lua, 2);
		lua_pushstring(Lua, "Fatal Lua error: \"");
		lua_pushstring(Lua, name);
		lua_pushstring(Lua, "\" internal function is missing");
		lua_concat(Lua, 3);
		ErrorMessageExe(Lua);
		return 1;
	}

	return 0;
}

int LuaPCall(int nArgs, int nResults)
{
	if (lua_pcall(Lua, nArgs, nResults, -2 - nArgs))
	{
		ErrorMessage(Lua);
		lua_pop(Lua, 1);
		return 1;
	}
	lua_remove(Lua, -1 - nResults);
	return 0;
}

int DoFile(const char *path)
{
	lua_rawgeti(Lua, LUA_REGISTRYINDEX, ErrfIndex);
	if (luaL_loadfile(Lua, path))
	{
		ErrorMessage(Lua);
		lua_pop(Lua, 1);
		return 1;
	}
	return LuaPCall(0, 0);
}

int DoLuaRun(const char *name, int n, ...)
{
	if (LuaFunction(name)) return 0;
	va_list args;
	va_start(args, n);
	for (int i = 0; i < n; i++)
		lua_pushnumber(Lua, va_arg(args, double));
	if (LuaPCall(n, 1)) return 0;
	int r = 0;
	if (lua_isnumber(Lua, -1))
		r = (int)lua_tonumber(Lua, -1);
	lua_pop(Lua, 1);
	return r;
}


void LuaInternalConst(const char * name, int val)
{
	lua_pushnumber(Lua, val);
	lua_setfield(Lua, LUA_REGISTRYINDEX, name);
}

void LuaInternalStr(const char * name, const char * val)
{
	lua_pushstring(Lua, val);
	lua_setfield(Lua, LUA_REGISTRYINDEX, name);
}

void LuaInternalBool(const char * name, int val)
{
	lua_pushboolean(Lua, val);
	lua_setfield(Lua, LUA_REGISTRYINDEX, name);
}

static const struct luaL_reg LuaLib_general [] =
{
	//{"xpcall", lua_xpcall},  //!LuaJIT
	{0, 0}
};

static const struct luaL_reg LuaLib_internal [] =
{
	{"FindStart", LuaFindStart},
	{"FindNext", LuaFindNext},
	{"FindClose", LuaFindClose},
	{"DebugConsole", DebugConsole},
	{"DebugConsoleAnswer", DebugConsoleAnswer},
	{"DebugConsoleCharsInLine", DebugConsoleCharsInLine},
	{"DebugConsoleLastResult", DebugConsoleLastResult},	
	{"CompileAsm", CompileAsm},
	{0, 0}
};


void InitLua()
{
	*(PROC*)&DebugDialog = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialog", true);
	*(PROC*)&DebugDialogAnswer = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogAnswer", true);
	*(PROC*)&DebugDialogBranch = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogBranch", true);
	*(PROC*)&DebugDialogCharsInLine = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogCharsInLine", true);
	*(PROC*)&DebugDialogResize = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogResize", true);
	*(PROC*)&DebugDialogCaption = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogCaption", true);
	*(PROC*)&DebugDialogLastResult = DllImport(RelPath("ExeMods\\MMExtension\\MMExtDialogs.dll"), "DebugDialogLastResult", true);
	*(PROC*)&fasm_Assemble = DllImport(RelPath("ExeMods\\MMExtension\\FASM.DLL"), "fasm_Assemble", true);

	DebugDialogResize(Width, Height);
	DebugDialogCaption("Lua Console");

	lua_State* L = Lua = luaL_newstate();
	//lua_State* L = Lua = lua_newstate(LuaAlloc, 0);
	//lua_ignorelocale(L);
	//lua_alnum(L)['?'] = 1;
	lj_get_char_bits()['?'] = 128;
	lua_atpanic(L, PanicMessage);

	luaL_openlibs(L); // open all standard libraries
	//luaopen_upvaluejoin(L); // to persist functions with RSPersist
	lua_pushvalue(L, LUA_GLOBALSINDEX);
	luaL_register(L, 0, LuaLib_general);
	lua_pop(L, 1);
	lua_pushvalue(L, LUA_REGISTRYINDEX);
	luaL_register(L, 0, LuaLib_internal);
	lua_pop(L, 1);
	RSMemRegister(L);

	// load luasocket
	lua_getfield(L, LUA_GLOBALSINDEX, "package");
	lua_getfield(L, -1, "preload");
	lua_pushcfunction(L, luaopen_socket_core);
	lua_setfield(L, -2, "socket.core");
	lua_pop(L, 2);

	// coroutine.main
	lua_getglobal(L, "coroutine");
	lua_pushthread(L);
	lua_setfield(L, -2, "main");
	lua_pop(L, 1);

	LuaInternalConst("MessageBox", (int)MessageBox);
	LuaInternalConst("GetCurrentDirectory", (int)GetCurrentDirectory);
	LuaInternalConst("SetCurrentDirectory", (int)SetCurrentDirectory);
	LuaInternalConst("CreateDirectory", (int)CreateDirectory);
	LuaInternalConst("GetKeyState", (int)GetKeyState);
	LuaInternalConst("timeGetTime", (int)DllImport("winmm.dll", "timeGetTime", true));
	//LuaInternalConst("SPStatKinds", (int)SPStatKinds);
	//LuaInternalConst("MMVersion", MMVersion);
	LuaInternalStr("AppPath", AppPath);
	if(!InMMDir)
		LuaInternalStr("GitPath", RelPath(""));
	LuaInternalStr("CoreGamePath", AppPath);
	LuaInternalConst("MainWindowPtrPtr", (int)&MainWindow);
	
	RegisterFunctionCalls();

	if (luaL_loadfile(L, RelPath("Scripts\\Core\\ErrorFunction.lua")) || lua_pcall(L, 0, 1, 0))
	{
		ErrorMessage(Lua);
		ExitProcess(0);
	}
	ErrfIndex = luaL_ref(L, LUA_REGISTRYINDEX);

	if (DoFile(RelPath("Scripts\\Core\\main.lua"))) ExitProcess(0);
}