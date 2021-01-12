#pragma once

//#include "lua.h"
//#include "lualib.h"
//#include "lauxlib.h"
//#include "pluto.h"

//extern lua_State *Lua;

//const char* ToString(lua_State *L, int i);
//int ToInteger(lua_State *L, int i);
//int LuaFunction(const char *name);
//int LuaPCall(int nArgs, int nResults);

int DoLuaRun(const char *name, int n, ...);
int __inline LuaRun(const char * name)  { return DoLuaRun(name, 0); }
int __inline LuaRun(const char * name, double a1)  { return DoLuaRun(name, 1, a1); }
int __inline LuaRun(const char * name, double a1, double a2)  { return DoLuaRun(name, 2, a1, a2); }
int __inline LuaRun(const char * name, double a1, double a2, double a3)  { return DoLuaRun(name, 3, a1, a2, a3); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4)  { return DoLuaRun(name, 4, a1, a2, a3, a4); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4, double a5)  { return DoLuaRun(name, 5, a1, a2, a3, a4, a5); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4, double a5, double a6)  { return DoLuaRun(name, 6, a1, a2, a3, a4, a5, a6); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4, double a5, double a6, double a7)  { return DoLuaRun(name, 7, a1, a2, a3, a4, a5, a6, a7); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4, double a5, double a6, double a7, double a8)  { return DoLuaRun(name, 8, a1, a2, a3, a4, a5, a6, a7, a8); }
int __inline LuaRun(const char * name, double a1, double a2, double a3, double a4, double a5, double a6, double a7, double a8, double a9)  { return DoLuaRun(name, 9, a1, a2, a3, a4, a5, a6, a7, a8, a9); }

void LuaInternalConst(const char *name, int value);

void InitLua();