/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module lua.lib;

import bindbc.lua.config;
import bindbc.lua.codegen;

import lua;

static if(luaVersion < Version(5,0,0)){
	enum LUA_ALERT = "_ALERT";
}else{
	enum{
		LUA_COLIBNAME = "coroutine",
		LUA_TABLIBNAME = "table",
		LUA_IOLIBNAME = "io",
		LUA_OSLIBNAME = "os",
		LUA_STRLIBNAME = "string",
		LUA_MATHLIBNAME = "math",
		LUA_DBLIBNAME = "debug",
	}
}

mixin(joinFnBinds({
	FnBind[] ret;
	static if(luaVersion < Version(5,0,0)){
		FnBind[] add = [
			{q{void}, q{lua_baselibopen}, q{LuaState* l}},
			{q{void}, q{lua_iolibopen}, q{LuaState* l}},
			{q{void}, q{lua_strlibopen}, q{LuaState* l}},
			{q{void}, q{lua_mathlibopen}, q{LuaState* l}},
			{q{void}, q{lua_dblibopen}, q{LuaState* l}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{int}, q{luaopen_base}, q{LuaState* l}, aliases: ["lua_baselibopen"]},
			{q{int}, q{luaopen_table}, q{LuaState* l}, aliases: ["lua_tablibopen"]},
			{q{int}, q{luaopen_io}, q{LuaState* l}, aliases: ["lua_iolibopen"]},
			{q{int}, q{luaopen_string}, q{LuaState* l}, aliases: ["lua_strlibopen"]},
			{q{int}, q{luaopen_math}, q{LuaState* l}, aliases: ["lua_mathlibopen"]},
			{q{int}, q{luaopen_debug}, q{LuaState* l}, aliases: ["lua_dblibopen"]},
			{q{int}, q{luaopen_loadlib}, q{LuaState* l}},
		];
		ret ~= add;
	}
	return ret;
}()));
