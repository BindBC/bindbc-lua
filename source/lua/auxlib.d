module lua.auxlib;

import bindbc.lua.config;
import bindbc.lua.codegen;

import lua;

import core.stdc.stdio: BUFSIZ;

struct LuaLReg{
	const(char)* name;
	LuaCFunction func;
}

pragma(inline, true) nothrow @nogc{
	void luaL_argcheck(LuaState* l, bool cond, int numArg, const(char)* extraMsg){
		if(!cond){
			luaL_argerror(l, numArg, extraMsg);
		}
	}
	alias luaL_arg_check = luaL_argcheck;
	const(char)* luaL_checkstring(LuaState* l, int n){ return luaL_check_lstr(l, n, null); }
	alias luaL_check_string = luaL_checkstring;
	const(char)* luaL_optstring(LuaState* l, int n, const(char)* d){ return luaL_opt_lstr(l, n, d, null); }
	alias luaL_opt_string = luaL_optstring;
	int luaL_checkint(LuaState* l, int n){ return cast(int)luaL_check_number(l, n); }
	alias luaL_check_int = luaL_checkint;
	long luaL_checklong(LuaState* l, int n){ return cast(long)luaL_check_number(l, n); }
	alias luaL_check_long = luaL_checklong;
	int luaL_optint(LuaState* l, int n, double d){ return cast(int)luaL_opt_number(l, n, d); }
	alias luaL_opt_int = luaL_optint;
	long luaL_optlong(LuaState* l, int n, double d){ return cast(long)luaL_opt_number(l, n, d); }
	alias luaL_opt_long = luaL_optlong;
	static if(luaVersion < Version(5,0,0)){
		void luaL_openl(LuaState* l, const(LuaLReg)* a){ luaL_openlib(l, a, a.sizeof / a[0].sizeof); }
	}
}

enum LUAL_BUFFERSIZE = BUFSIZ;

struct LuaLBuffer{
	ubyte* p;
	int lvl;
	LuaState* l;
	ubyte[LUAL_BUFFERSIZE] buffer;
}

pragma(inline, true) nothrow @nogc{
	void luaL_putchar(LuaLBuffer* b, uint c){
		if(b.p >= (&b.buffer[LUAL_BUFFERSIZE-1] + 1)){
			luaL_prepbuffer(b);
		}
		*b.p++ = cast(ubyte)c;
	}
	
	ubyte* luaL_addsize(LuaLBuffer* b, size_t n) pure{ return b.p += n; }
}

mixin(joinFnBinds({
	FnBind[] ret = [
		{q{void}, q{luaL_argerror}, q{LuaState* l, int numArg, const(char)* extraMsg}},
		
		{q{void}, q{luaL_checkstack}, q{LuaState* l, int sz, const(char)* msg}},
		{q{void}, q{luaL_checktype}, q{LuaState* l, int nArg, int t}},
		{q{void}, q{luaL_checkany}, q{LuaState* l, int nArg}},
		
		{q{void}, q{luaL_buffinit}, q{LuaState* l, LuaLBuffer* b}},
		{q{ubyte*}, q{luaL_prepbuffer}, q{LuaLBuffer* b}},
		{q{void}, q{luaL_addlstring}, q{LuaLBuffer* b, const(char)* s, size_t l}},
		{q{void}, q{luaL_addstring}, q{LuaLBuffer* b, const(char)* s}},
		{q{void}, q{luaL_addvalue}, q{LuaLBuffer* b}},
		{q{void}, q{luaL_pushresult}, q{LuaLBuffer* b}},
	];
	static if(luaVersion < Version(5,0,0)){
		FnBind[] add = [
			{q{void}, q{luaL_openlib}, q{LuaState* l, const(LuaLReg)* l_, int n}},
			{q{const(char)*}, q{luaL_check_lstr}, q{LuaState* l, int nArg, size_t* len}},
			{q{const(char)*}, q{luaL_opt_lstr}, q{LuaState* l, int nArg, const(char)* def, size_t* len}},
			{q{double}, q{luaL_check_number}, q{LuaState* l, int nArg}},
			{q{double}, q{luaL_opt_number}, q{LuaState* l, int nArg, double def}},
			
			{q{void}, q{luaL_verror}, q{LuaState* l, const(char)* fmt, ...}},
			{q{int}, q{luaL_findstring}, q{const(char)* st, const(char*)* lst}},
			
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{void}, q{luaL_openlib}, q{LuaState* l, const(char)* libName, const(LuaLReg)* l_, int nUp}},
			{q{int}, q{luaL_getmetafield}, q{LuaState* l, int obj, const(char)* e}},
			{q{int}, q{luaL_callmeta}, q{LuaState* l, int obj, const(char)* e}},
			{q{int}, q{luaL_typerror}, q{LuaState* l, int nArg, const(char)* tName}},
			{q{const(char)*}, q{luaL_checklstring}, q{LuaState* l, int numArg, size_t* l_}, aliases: ["luaL_check_lstr"]},
			{q{const(char)*}, q{luaL_optlstring}, q{LuaState* l, int numArg, const(char)* def, size_t* l_}, aliases: ["luaL_opt_lstr"]},
			{q{LuaNumber}, q{luaL_checknumber}, q{LuaState* l, int numArg}, aliases: ["luaL_check_number"]},
			{q{LuaNumber}, q{luaL_optnumber}, q{LuaState* l, int nArg, LuaNumber def}, aliases: ["luaL_opt_number"]},
			
			{q{int}, q{luaL_newmetatable}, q{LuaState* l, const(char)* tName}},
			{q{void}, q{luaL_getmetatable}, q{LuaState* l, const(char)* tName}},
			{q{void*}, q{luaL_checkudata}, q{LuaState* l, int ud, const(char)* tName}},
			
			{q{void}, q{luaL_where}, q{LuaState* l, int lvl}},
			{q{int}, q{luaL_error}, q{LuaState* l, const(char)* fmt, ...}},
			
			{q{int}, q{luaL_ref}, q{LuaState* l, int t}},
			{q{void}, q{luaL_unref}, q{LuaState* l, int t, int ref_}},
			
			{q{int}, q{luaL_getn}, q{LuaState* l, int t}},
			{q{void}, q{luaL_setn}, q{LuaState* l, int t, int n}},
			
			{q{int}, q{luaL_loadfile}, q{LuaState* l, const(char)* filename}},
			{q{int}, q{luaL_loadbuffer}, q{LuaState* l, const(char)* buff, size_t sz, const(char)* name}},
			
			{q{int}, q{lua_dofile}, q{LuaState* l, const(char)* filename}},
			{q{int}, q{lua_dostring}, q{LuaState* l, const(char)* str}},
			{q{int}, q{lua_dobuffer}, q{LuaState* l, const(char)* buff, size_t sz, const(char)* n}},
		];
		ret ~= add;
	}
	return ret;
}()));
