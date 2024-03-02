/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module lua;

import bindbc.lua.config;
import bindbc.lua.codegen;

import bindbc.common.types: va_list;

public import
	lua.auxlib,
	lua.lib;

enum LUA_VERSION = {
	if(luaVersion >= Version(5,4,0)) return "";
	else if(luaVersion >= Version(5,3,0)) return "";
	else if(luaVersion >= Version(5,2,0)) return "";
	else if(luaVersion >= Version(5,1,0)) return "Lua 5.1";
	else if(luaVersion >= Version(5,0,0)) return "Lua 5.0.3";
	else if(luaVersion >= Version(4,0,0)) return "Lua 4.0.1";
	else assert(0);
}();
static if(luaVersion >= Version(5,1,0)){
	enum LUA_RELEASE = {
		if(luaVersion >= Version(5,4,0)) return "";
		else if(luaVersion >= Version(5,3,0)) return "";
		else if(luaVersion >= Version(5,2,0)) return "";
		else if(luaVersion >= Version(5,1,0)) return "Lua 5.1.5";
		else assert(0);
	}();
	enum LUA_VERSION_NUM = {
		if(luaVersion >= Version(5,4,0)) return 504;
		else if(luaVersion >= Version(5,3,0)) return 503;
		else if(luaVersion >= Version(5,2,0)) return 502;
		else if(luaVersion >= Version(5,1,0)) return 501;
		else assert(0);
	}();
}
enum LUA_COPYRIGHT = {
	if(luaVersion >= Version(5,4,0)) return "";
	else if(luaVersion >= Version(5,3,0)) return "";
	else if(luaVersion >= Version(5,2,0)) return "";
	else if(luaVersion >= Version(5,1,0)) return "Copyright (C) 1994-2012 Lua.org, PUC-Rio";
	else if(luaVersion >= Version(5,0,0)) return "Copyright (C) 1994-2006 Tecgraf, PUC-Rio";
	else if(luaVersion >= Version(4,0,0)) return "Copyright(C) 1994-2000 TeCGraf, PUC-Rio";
	else assert(0);
}();
enum LUA_AUTHORS = {
	if(luaVersion >= Version(5,4,0)) return "";
	else if(luaVersion >= Version(5,3,0)) return "";
	else if(luaVersion >= Version(5,2,0)) return "";
	else if(luaVersion >= Version(5,0,0)) return "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";
	else if(luaVersion >= Version(4,0,0)) return "W. Celes, R. Ierusalimschy & L. H. de Figueiredo";
	else assert(0);
}();

static if(luaVersion < Version(5,0,0)){
	enum LUA_ERRORMESSAGE = "_ERRORMESSAGE";
}

static if(luaVersion >= Version(5,1,0)){
	enum LUA_SIGNATURE = "\033Lua";
}

enum LUA_NOREF        = -2;
enum LUA_REFNIL       = -1;
static if(luaVersion < Version(5,0,0)){
	enum LUA_REFREGISTRY  =  0;
	
	enum LUA_ANYTAG  = -1;
	enum LUA_NOTAG   = -2;
}

enum LUA_MULTRET = -1;

enum LUA_REGISTRYINDEX = -10000;
static if(luaVersion < Version(5,1,0)){
	enum LUA_GLOBALSINDEX  = -10001;
}else{
	enum LUA_ENVIRONINDEX = -10001;
	enum LUA_GLOBALSINDEX = -10002;
}
pragma(inline, true) int lua_upvalueindex(int i) @nogc nothrow{ return LUA_GLOBALSINDEX-i; }

static if(luaVersion < Version(5,1,0))
enum{
	LUA_ERRRUN     = 1,
	LUA_ERRFILE    = 2,
	LUA_ERRSYNTAX  = 3,
	LUA_ERRMEM     = 4,
	LUA_ERRERR     = 5,
}
else
enum{
	LUA_YIELD      = 1,
	LUA_ERRRUN     = 2,
	LUA_ERRSYNTAX  = 3,
	LUA_ERRMEM     = 4,
	LUA_ERRERR     = 5,
}

struct LuaState;

extern(C) nothrow{
	alias LuaCFunction = int function(LuaState* l);
	alias LuaReader = const(char)* function(LuaState* l, void* ud, size_t* sz);
	alias LuaWriter = int function(LuaState* l, const(void)* p, size_t sz, void* ud);
	static if(luaVersion < Version(5,1,0)){
		alias LuaChunkReader = LuaReader;
		alias LuaChunkWriter = LuaWriter;
		alias LuaAlloc = void* function(void* ud, void* ptr, size_t oSize, size_t nSize);
	}
}

static if(luaVersion < Version(5,0,0)){
	enum LuaT{
		none       = -1,
		userData   =  0,
		nil        =  1,
		number     =  2,
		string     =  3,
		table      =  4,
		function_  =  5,
	}
}else{
	enum LuaT{
		none           = -1,
		nil            =  0,
		boolean        =  1,
		lightUserData  =  2,
		number         =  3,
		string         =  4,
		table          =  5,
		function_      =  6,
		userData       =  7,
		thread         =  8,
	}
}

enum LUA_MINSTACK = 20;

alias LuaNumber = double;

alias LuaInteger = ptrdiff_t;

pragma(inline, true) nothrow @nogc{
	void lua_pop(LuaState* l, int n){ lua_settop(l, -n-1); }
	
	static if(luaVersion < Version(5,0,0)){
		void lua_pushuserdata(LuaState* l, void* u){ lua_pushusertag(l, u, 0); }
	}
	void lua_pushcfunction(LuaState* l, LuaCFunction f){ lua_pushcclosure(l, f, 0); }
	static if(luaVersion < Version(5,0,0)){
		int lua_clonetag(LuaState* l, int t){ return lua_copytagmethods(l, lua_newtag(l), t); }
	}
	
	bool lua_isfunction(LuaState* l, int n){ return lua_type(l, n) == LuaT.function_; }
	bool lua_istable(LuaState* l, int n){    return lua_type(l, n) == LuaT.table; }
	static if(luaVersion < Version(5,0,0)){
		bool lua_isuserdata(LuaState* l, int n){ return lua_type(l, n) == LuaT.userData; }
	}
	bool lua_isnil(LuaState* l, int n){      return lua_type(l, n) == LuaT.nil; }
	bool lua_isnone(LuaState* l, int n){     return lua_type(l, n) == LuaT.none; }
	alias lua_isnull = lua_isnone;
	
	static if(luaVersion >= Version(5,0,0)){
		void* lua_boxpointer(LuaState* l, void* u){ return *cast(void**)lua_newuserdata(l, (void*).sizeof) = u; }
		
		void* lua_unboxpointer(LuaState* l, int i){ return *cast(void**)lua_touserdata(l, i); }
		
		void lua_register(LuaState* l, const(char)* n, LuaCFunction f){
			lua_pushstring(l, n);
			lua_pushcfunction(l, f);
			lua_settable(l, LUA_GLOBALSINDEX);
		}
		
		bool lua_islightuserdata(LuaState* l, int n){ return lua_type(l, n) == LuaT.lightUserData; }
		bool lua_isboolean(LuaState* l, int n){       return lua_type(l, n) == LuaT.boolean; }
		bool lua_isnoneornil(LuaState* l, int n){     return lua_type(l, n) <= 0; }
		
		void lua_pushliteral(LuaState* l, const(char)* s){ lua_pushlstring(l, s, (s.sizeof / char.sizeof)-1); }
		
		void lua_getregistry(LuaState* l){ lua_pushvalue(l, LUA_REGISTRYINDEX); }
		void lua_setglobal(LuaState* l, const(char)* s){
			lua_pushstring(l, s), lua_insert(l, -2);
			lua_settable(l, LUA_GLOBALSINDEX);
		}
		
		void lua_getglobal(LuaState* l, const(char)* s){
			lua_pushstring(l, s);
			lua_gettable(l, LUA_GLOBALSINDEX);
		}
		
		int lua_ref(LuaState* l, int lock){
			if(!lock){
				lua_pushstring(l, "unlocked references are obsolete");
				lua_error(l);
				return 0;
			}
			return luaL_ref(l, LUA_REGISTRYINDEX);
		}
		
		void lua_unref(LuaState* l, int ref_){ luaL_unref(l, LUA_REGISTRYINDEX, ref_); }
		
		void lua_getref(LuaState* l, int ref_){ lua_rawgeti(l, LUA_REGISTRYINDEX, ref_); }
	}else{
		void lua_register(LuaState* l, const(char)* n, LuaCFunction f){
			lua_pushcfunction(l, f);
			lua_setglobal(l, n);
		}
		
		int lua_getregistry(LuaState* l){ return lua_getref(l, LUA_REFREGISTRY); }
	}
}

enum LUA_NUMBER_SCAN = "%lf";

enum LUA_NUMBER_FMT = "%.14g";

enum LuaHookType{
	call     = 0,
	ret      = 1,
	line     = 2,
	count    = 3,
	tailRet  = 4,
}

enum LuaMask{
	call   = 1 << LuaHookType.call,
	ret    = 1 << LuaHookType.ret,
	line   = 1 << LuaHookType.line,
	count  = 1 << LuaHookType.count,
}

alias LuaHook = extern(C) void function(LuaState* l, LuaDebug* ar) nothrow;

enum LUA_IDSIZE = 60;

struct LuaTObject;

struct LuaDebug{
	static if(luaVersion < Version(5,0,0)){
		const(char)* event;
		int currentLine;
	}else{
		int event;
	}
	const(char)* name;
	const(char)* nameWhat;
	static if(luaVersion < Version(5,0,0)){
		int nUps;
		int lineDefined;
		const(char)* what;
		const(char)* source;
	}else{
		const(char)* what;
		const(char)* source;
		int currentLine;
		int nUps;
		int lineDefined;
	}
	char[LUA_IDSIZE] shortSrc;
	
	static if(luaVersion < Version(5,0,0)){
		private LuaTObject* _func;
	}else{
		private int i_ci;
	}
};

mixin(joinFnBinds({
	FnBind[] ret = [
		{q{void}, q{lua_close}, q{LuaState* l}},
		
		{q{int}, q{lua_gettop}, q{LuaState* l}},
		{q{void}, q{lua_settop}, q{LuaState* l, int idx}},
		{q{void}, q{lua_pushvalue}, q{LuaState* l, int idx}},
		{q{void}, q{lua_remove}, q{LuaState* l, int idx}},
		{q{void}, q{lua_insert}, q{LuaState* l, int idx}},
		{q{int}, q{lua_stackspace}, q{LuaState* l}},
		
		{q{int}, q{lua_type}, q{LuaState* l, int idx}},
		{q{const(char)*}, q{lua_typename}, q{LuaState* l, int tp}},
		{q{int}, q{lua_isnumber}, q{LuaState* l, int idx}},
		{q{int}, q{lua_isstring}, q{LuaState* l, int idx}},
		{q{int}, q{lua_iscfunction}, q{LuaState* l, int idx}},
		{q{int}, q{lua_tag}, q{LuaState* l, int index}},
		
		{q{int}, q{lua_equal}, q{LuaState* l, int idx1, int idx2}},
		{q{int}, q{lua_lessthan}, q{LuaState* l, int idx1, int idx2}},
		
		{q{LuaNumber}, q{lua_tonumber}, q{LuaState* l, int idx}},
		{q{const(char)*}, q{lua_tostring}, q{LuaState* l, int idx}},
		{q{size_t}, q{lua_strlen}, q{LuaState* l, int idx}},
		{q{LuaCFunction}, q{lua_tocfunction}, q{LuaState* l, int idx}},
		{q{void*}, q{lua_touserdata}, q{LuaState* l, int idx}},
		{q{const(void)*}, q{lua_topointer}, q{LuaState* l, int idx}},
		
		{q{void}, q{lua_pushnil}, q{LuaState* l}},
		{q{void}, q{lua_pushnumber}, q{LuaState* l, double n}},
		{q{void}, q{lua_pushlstring}, q{LuaState* l, const(char)* s, size_t l_}},
		{q{void}, q{lua_pushstring}, q{LuaState* l, const(char)* s}},
		{q{void}, q{lua_pushcclosure}, q{LuaState* l, LuaCFunction fn, int n}},
		
		{q{void}, q{lua_gettable}, q{LuaState* l, int idx}},
		{q{void}, q{lua_rawget}, q{LuaState* l, int idx}},
		{q{void}, q{lua_rawgeti}, q{LuaState* l, int idx, int n}},
		{q{int}, q{lua_getref}, q{LuaState* l, int ref_}},
		{q{void}, q{lua_newtable}, q{LuaState* l}},
		
		{q{void}, q{lua_setglobal}, q{LuaState* l, const(char)* name}},
		{q{void}, q{lua_settable}, q{LuaState* l, int idx}},
		{q{void}, q{lua_rawset}, q{LuaState* l, int idx}},
		{q{void}, q{lua_rawseti}, q{LuaState* l, int idx, int n}},
		
		{q{int}, q{lua_call}, q{LuaState* l, int nArgs, int nResults}},
		
		{q{int}, q{lua_getgcthreshold}, q{LuaState* l}},
		{q{int}, q{lua_getgccount}, q{LuaState* l}},
		{q{void}, q{lua_setgcthreshold}, q{LuaState* l, int newThreshold}},
		
		{q{int}, q{lua_next}, q{LuaState* l, int index}},
		{q{int}, q{lua_getn}, q{LuaState* l, int index}},
		
		{q{void}, q{lua_concat}, q{LuaState* l, int n}},
		
		{q{void*}, q{lua_newuserdata}, q{LuaState* l, size_t sz}},
		
		{q{int}, q{lua_getstack}, q{LuaState* l, int level, LuaDebug* ar}},
		{q{int}, q{lua_getinfo}, q{LuaState* l, const(char)* what, LuaDebug* ar}},
		{q{const(char)*}, q{lua_getlocal}, q{LuaState* l, const(LuaDebug)* ar, int n}},
		{q{const(char)*}, q{lua_setlocal}, q{LuaState* l, const(LuaDebug)* ar, int n}},
	];
	static if(luaVersion < Version(5,0,0)){
		FnBind[] add = [
			{q{LuaState*}, q{lua_open}, q{int stackSize}},
			
			{q{void}, q{lua_pushusertag}, q{LuaState* l, void* u, int tag}},
			
			{q{void}, q{lua_getglobal}, q{LuaState* l, const(char)* name}},
			{q{void}, q{lua_getglobals}, q{LuaState* l}},
			{q{void}, q{lua_gettagmethod}, q{LuaState* l, int tag, const(char)* event}},
			
			{q{void}, q{lua_setglobals}, q{LuaState* l}},
			{q{void}, q{lua_settagmethod}, q{LuaState* l, int tag, const(char)* event}},
			{q{int}, q{lua_ref}, q{LuaState* l, int lock}},
			
			{q{void}, q{lua_error}, q{LuaState* l, const(char)* s}},
			
			{q{void}, q{lua_rawcall}, q{LuaState* l, int nArgs, int nResults}},
			{q{int}, q{lua_dofile}, q{LuaState* l, const(char)* filename}},
			{q{int}, q{lua_dostring}, q{LuaState* l, const(char)* str}},
			{q{int}, q{lua_dobuffer}, q{LuaState* l, const(char)* buff, size_t size, const(char)* name}},
			
			{q{int}, q{lua_newtag}, q{LuaState* l}},
			{q{int}, q{lua_copytagmethods}, q{LuaState* l, int tagTo, int tagFrom}},
			{q{void}, q{lua_settag}, q{LuaState* l, int tag}},
			
			{q{void}, q{lua_unref}, q{LuaState* l, int ref_}},
			
			{q{LuaHook}, q{lua_setcallhook}, q{LuaState* l, LuaHook func}},
			{q{LuaHook}, q{lua_setlinehook}, q{LuaState* l, LuaHook func}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{LuaState*}, q{lua_open}, q{}},
			{q{LuaState*}, q{lua_newthread}, q{LuaState* l}},
				
			{q{LuaCFunction}, q{lua_atpanic}, q{LuaState* l, LuaCFunction panicF}},
				
			{q{void}, q{lua_replace}, q{LuaState* l, int idx}},
			{q{int}, q{lua_checkstack}, q{LuaState* l, int sz}},
				
			{q{void}, q{lua_xmove}, q{LuaState* from, LuaState* to, int n}},
				
			{q{int}, q{lua_isuserdata}, q{LuaState* l, int idx}},
				
			{q{int}, q{lua_rawequal}, q{LuaState* l, int idx1, int idx2}},
				
			{q{int}, q{lua_toboolean}, q{LuaState* l, int idx}},
			{q{LuaState*}, q{lua_tothread}, q{LuaState* l, int idx}},
				
			{q{const(char)*}, q{lua_pushvfstring}, q{LuaState *l, const(char)* fmt, va_list argP}},
			{q{const(char)*}, q{lua_pushfstring}, q{LuaState *l, const(char)* fmt, ...}},
			{q{void}, q{lua_pushboolean}, q{LuaState* l, int b}},
			{q{void}, q{lua_pushlightuserdata}, q{LuaState* l, void* p}},
				
			{q{int}, q{lua_getmetatable}, q{LuaState* l, int objIndex}},
			{q{void}, q{lua_getfenv}, q{LuaState* l, int idx}},
				
			{q{int}, q{lua_setmetatable}, q{LuaState* l, int objIndex}},
			{q{int}, q{lua_setfenv}, q{LuaState* l, int idx}},
				
			{q{int}, q{lua_pcall}, q{LuaState* l, int nArgs, int nResults, int errFunc}},
			{q{int}, q{lua_cpcall}, q{LuaState* l, LuaCFunction func, void* ud}},
			{q{int}, q{lua_load}, q{LuaState* l, LuaReader reader, void* dt, const(char)* chunkName}},
				
			{q{int}, q{lua_dump}, q{LuaState* l, LuaWriter writer, void* data}},
				
			{q{int}, q{lua_yield}, q{LuaState* l, int nResults}},
			{q{int}, q{lua_resume}, q{LuaState* l, int nArg}},
				
			{q{const(char)*}, q{lua_version}, q{}},
			{q{void}, q{lua_error}, q{LuaState* l}},
				
			{q{int}, q{lua_pushupvalues}, q{LuaState* l}},
				
			{q{const(char)*}, q{lua_getupvalue}, q{LuaState* l, int funcIndex, int n}},
			{q{const(char)*}, q{lua_setupvalue}, q{LuaState* l, int funcIndex, int n}},
				
			{q{int}, q{lua_sethook}, q{LuaState* l, LuaHook func, int mask, int count}},
			{q{LuaHook}, q{lua_gethook}, q{LuaState* l}},
			{q{int}, q{lua_gethookmask}, q{LuaState* l}},
			{q{int}, q{lua_gethookcount}, q{LuaState* l}},
		];
		ret ~= add;
	}
	return ret;
}()));
