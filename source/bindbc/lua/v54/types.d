
//          Copyright 2019 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.lua.v54.types;

version(LUA_54):

import core.stdc.stdio : BUFSIZ, FILE;
import core.stdc.stdint : intptr_t;
import core.stdc.config : c_long;

// luaconf.h
alias LUA_INT32 = int;
alias LUAI_UMEM = size_t;
alias LUAI_MEM = ptrdiff_t;
alias LUA_NUMBER = double;
alias LUA_INTEGER = ptrdiff_t;
alias LUA_UNSIGNED = uint;

alias LUA_KCONTEXT =  intptr_t;
enum LUAI_MAXSTACK = 1000000;
enum LUA_EXTRASPACE = (void*).sizeof;
enum LUA_IDSIZE = 60;
enum LUAL_BUFFERSIZE = cast(int)(16 * (void*).sizeof * lua_Number.sizeof);

mixin template LUAI_MAXALIGN() {
    lua_Number n;
    double u;
    void *s;
    lua_Integer i;
    c_long l;
}


// lauxlib.h
enum LUA_ERRFILE = LUA_ERRERR+1;
enum LUA_LOADED_TABLE = "_LOADED";
enum LUA_PRELOAD_TABLE = "_PRELOAD";

struct luaL_Reg {
    const(char)* name;
    lua_CFunction func;
}

enum LUAL_NUMSIZES = lua_Integer.sizeof * 16 + lua_Number.sizeof;

enum LUA_NOREF = -2;
enum LUA_REFNIL = -1;

struct luaL_Buffer {
    char* b;
    size_t size;
    size_t n;
    lua_State* L;
    union init {
        mixin LUAI_MAXALIGN!();
        char[LUAL_BUFFERSIZE] initb;
    }
}

alias LUA_FILEHANDLE = FILE*;

struct luaL_Stream {
    FILE* f;
    lua_CFunction closef;
}

// lua.h
enum LUA_VERSION_MAJOR = "5";
enum LUA_VERSION_MINOR = "4";
enum LUA_VERSION_RELEASE = "2";

enum LUA_VERSION_NUM = 504;
enum LUA_VERSION_RELEASE_NUM = LUA_VERSION_NUM * 100 + 0;

enum LUA_VERSION = "Lua " ~ LUA_VERSION_MAJOR ~ "." ~ LUA_VERSION_MINOR;
enum LUA_RELEASE = LUA_VERSION ~ "." ~ LUA_VERSION_RELEASE;

enum LUA_SIGNATURE = "\x1bLua";
enum LUA_MULTRET = -1;

enum LUA_REGISTRYINDEX = -LUAI_MAXSTACK - 1000;

enum LUA_OK = 0;
enum LUA_YIELD = 1;
enum LUA_ERRRUN = 2;
enum LUA_ERRSYNTAX = 3;
enum LUA_ERRMEM = 4;
enum LUA_ERRERR = 5;

enum LUA_TNONE = -1;
enum LUA_TNIL = 0;
enum LUA_TBOOLEAN = 1;
enum LUA_TLIGHTUSERDATA = 2;
enum LUA_TNUMBER = 3;
enum LUA_TSTRING = 4;
enum LUA_TTABLE = 5;
enum LUA_TFUNCTION = 6;
enum LUA_TUSERDATA = 7;
enum LUA_TTHREAD = 8;
enum LUA_NUMTYPES = 9;

alias LUA_NUMTAGS = LUA_NUMTYPES;

enum LUA_MINSTACK = 20;

enum LUA_RIDX_MAINTHREAD = 1;
enum LUA_RIDX_GLOBALS = 2;
enum LUA_RIDX_LAST = LUA_RIDX_GLOBALS;

alias lua_Number = LUA_NUMBER;
alias lua_Integer = LUA_INTEGER;
alias lua_Unsigned = LUA_UNSIGNED;
alias lua_KContext = LUA_KCONTEXT;

struct lua_State;

nothrow {
    alias lua_CFunction = int function(lua_State* L);
    alias lua_KFunction = int function(lua_State* L, int status, lua_KContext ctx);
    alias lua_Reader = const(char)* function(lua_State* L, void* ud, size_t sz);
    alias lua_Writer = int function(lua_State* L, const(void)* p, size_t sz, void* ud);
    alias lua_Alloc = void* function(void* ud, void* ptr, size_t osize, size_t nsize);
    alias lua_WarnFunction = void function(void* ud, const(char)* msg, int tocont);
}


enum LUA_OPADD = 0;
enum LUA_OPSUB = 1;
enum LUA_OPMUL = 2;
enum LUA_OPMOD = 3;
enum LUA_OPPOW = 4;
enum LUA_OPDIV = 5;
enum LUA_OPIDIV = 6;
enum LUA_OPBAND = 7;
enum LUA_OPBOR = 8;
enum LUA_OPBXOR = 9;
enum LUA_OPSHL = 10;
enum LUA_OPSHR = 11;
enum LUA_OPUNM = 12;
enum LUA_OPBNOT = 13;

enum LUA_OPEQ = 0;
enum LUA_OPLT = 1;
enum LUA_OPLE = 2;

enum LUA_GCSTOP = 0;
enum LUA_GCRESTART = 1;
enum LUA_GCCOLLECT = 2;
enum LUA_GCCOUNT = 3;
enum LUA_GCCOUNTB = 4;
enum LUA_GCSTEP = 5;
enum LUA_GCSETPAUSE = 6;
enum LUA_GCSETSTEPMUL = 7;
enum LUA_GCISRUNNING = 9;

enum LUA_HOOKCALL = 0;
enum LUA_HOOKRET = 1;
enum LUA_HOOKLINE = 2;
enum LUA_HOOKCOUNT = 3;
enum LUA_HOOKTAILRET = 4;

enum LUA_MASKCALL = 1 << LUA_HOOKCALL;
enum LUA_MASKRET = 1 << LUA_HOOKRET;
enum LUA_MASKLINE = 1 << LUA_HOOKLINE;
enum LUA_MASKCOUNT = 1 << LUA_HOOKCOUNT;

struct lua_Debug {
    int event;
    const(char)* name;
    const(char)* namewhat;
    const(char)* what;
    const(char)* source;
    size_t srclen;
    int currentline;
    int linedefined;
    int lastlinedefined;
    ubyte nups;
    ubyte nparams;
    char isvararg;
    char istailcall;
    ushort ftransfer;
    ushort ntransfer;
    char[LUA_IDSIZE] short_src;
    private void* i_ci;
}

alias lua_Hook = void function(lua_State*,lua_Debug*) nothrow;

// lualib.h
enum LUA_VERSUFFIX = "_" ~ LUA_VERSION_MAJOR ~ "_" ~ LUA_VERSION_MINOR;
enum LUA_COLIBNAME = "coroutine";
enum LUA_TABLIBNAME = "table";
enum LUA_IOLIBNAME = "io";
enum LUA_OSLIBNAME = "os";
enum LUA_STRLIBNAME = "string";
enum LUA_UTF8LIBNAME = "utf8";
enum LUA_MATHLIBNAME = "math";
enum LUA_DBLIBNAME = "debug";
enum LUA_LOADLIBNAME = "package";