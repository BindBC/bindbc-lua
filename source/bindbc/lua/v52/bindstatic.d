
//          Copyright Michael D. Parker 2018.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.lua.v52.bindstatic;


version(BindBC_Static) version = BindLua_Static;
version(BindLua_Static) {
    version(LUA_52) version = LUA_52_STATIC;
}

version(LUA_52_STATIC):

import core.stdc.stdarg : va_list;
import bindbc.lua.v52.types;

extern(C) @nogc nothrow:
    // lauxlib.h
    void luaL_checkversion_(lua_State*,lua_Number);
    int luaL_getmetafield(lua_State*,int,const(char)*);
    int luaL_callmeta(lua_State*, int,const(char)*);
    const(char)* luaL_tolstring(lua_State*,int,size_t*);
    int luaL_argerror(lua_State*,int,const(char)*);
    const(char)* luaL_checklstring(lua_State*,int,size_t*);
    const(char)* luaL_optlstring(lua_State*,int,const(char)*,size_t*);
    lua_Number luaL_checknumber(lua_State*,int);
    lua_Number luaL_optnumber(lua_State*,int,lua_Number);
    lua_Integer luaL_checkinteger(lua_State*,int);
    lua_Integer luaL_optinteger(lua_State*,int,lua_Integer);
    lua_Unsigned luaL_checkunsigned(lua_State*,int);
    lua_Unsigned luaL_optunsigned(lua_State*,int,lua_Unsigned);
    void luaL_checkstack(lua_State*,int,const(char)*);
    void luaL_checktype(lua_State*,int,int);
    void luaL_checkany(lua_State*,int);
    int luaL_newmetatable(lua_State*,const(char)*);
    void luaL_setmetatable(lua_State*,const(char)*);
    void* luaL_testudata(lua_State*,int,const(char)*);
    void* luaL_checkudata(lua_State*,int,const(char)*);
    void luaL_where(lua_State*,int);
    int luaL_error(lua_State*,const(char)*,...);
    int luaL_checkoption(lua_State*,int,const(char)*);
    int luaL_fileresult(lua_State*,int,const(char)*);
    int luaL_execresult(lua_State*,int);
    int luaL_ref(lua_State*,int);
    void luaL_unref(lua_State*,int,int);
    int luaL_loadfilex(lua_State*,const(char)*,const(char)*);
    int luaL_loadbufferx(lua_State*,const(char)*,size_t,const(char)*,const(char)*);
    int luaL_loadstring(lua_State*,const(char)*);
    lua_State* luaL_newstate();
    int luaL_len(lua_State*,int);
    const(char)* luaL_gsub(lua_State*,const(char)*,const(char)*,const(char)*);
    void luaL_setfuncs(lua_State*,const(luaL_Reg)*,int);
    int luaL_getsubtable(lua_State*,int,const(char)*);
    void luaL_traceback(lua_State*,lua_State*,const(char)*,int);
    void luaL_requiref(lua_State*,const(char)*,lua_CFunction,int);
    void luaL_buffinit(lua_State*,luaL_Buffer*);
    char* luaL_prepbuffsize(luaL_Buffer*,size_t);
    void luaL_addlstring(luaL_Buffer*,const(char)*,size_t);
    void luaL_addstring(luaL_Buffer*, const(char)*);
    void luaL_addvalue(luaL_Buffer*);
    void luaL_pushresult(luaL_Buffer*);
    void luaL_pushresultsize(luaL_Buffer*,size_t);
    char* luaL_buffinitsize(lua_State*,luaL_Buffer*,size_t);

    // lua.h
    lua_State* lua_newstate(lua_Alloc,void*);
    lua_State* lua_close(lua_State*);
    lua_State* lua_newthread(lua_State*);
    lua_CFunction lua_atpanic(lua_State*,lua_CFunction);
    const(lua_Number)* lua_version(lua_State*);
    int lua_absindex(lua_State*,int);
    int lua_gettop(lua_State*);
    void lua_settop(lua_State*,int);
    void lua_pushvalue(lua_State*,int);
    void lua_remove(lua_State*,int);
    void lua_insert(lua_State*,int);
    void lua_replace(lua_State*,int);
    void lua_copy(lua_State*,int,int);
    int lua_checkstack(lua_State*,int);
    void lua_xmove(lua_State*,lua_State*,int);
    int lua_isnumber(lua_State*,int);
    int lua_isstring(lua_State*,int);
    int lua_iscfunction(lua_State*,int);
    int lua_isuserdata(lua_State*,int);
    int lua_type(lua_State*,int);
    const(char)* lua_typename(lua_State*,int);
    lua_Number lua_tonumberx(lua_State*,int,int*);
    lua_Integer lua_tointegerx(lua_State*,int,int*);
    lua_Unsigned lua_tounsignedx(lua_State*,int,int*);
    int lua_toboolean(lua_State*,int);
    const(char)* lua_tolstring(lua_State*,int,size_t*);
    size_t lua_rawlen(lua_State*,int);
    lua_CFunction lua_tocfunction(lua_State*,int);
    void* lua_touserdata(lua_State*,int);
    lua_State* lua_tothread(lua_State*,int);
    const(void)* lua_topointer(lua_State*,int);
    void lua_arith(lua_State*,int);
    int lua_rawequal(lua_State*,int,int);
    int lua_compare(lua_State*,int,int,int);
    void lua_pushnil(lua_State*);
    void lua_pushnumber(lua_State*,lua_Number);
    void lua_pushinteger(lua_State*,lua_Integer);
    void lua_pushunsigned(lua_State*,lua_Unsigned);
    void lua_pushlstring(lua_State*,const(char)*,size_t);
    void lua_pushstring(lua_State*,const(char)*);
    const(char)* lua_pushvfstring(lua_State*,const(char)*,va_list);
    const(char)* lua_pushfstring(lua_State*,const(char)*,...);
    void lua_pushcclosure(lua_State*,lua_CFunction,int);
    void lua_pushboolean(lua_State*,int);
    void lua_pushlightuserdata(lua_State*,void*);
    int lua_pushthread(lua_State*);
    void lua_getglobal(lua_State*,const(char)*);
    void lua_gettable(lua_State*,int);
    void lua_getfield(lua_State*,int,const(char)*);
    void lua_rawget(lua_State*,int);
    void lua_rawgeti(lua_State*,int,int);
    void lua_rawgetp(lua_State*,int,const(void)*);
    void lua_createtable(lua_State*,int,int);
    void* lua_newuserdata(lua_State*,size_t);
    int lua_getmetatable(lua_State*,int);
    void lua_getuservalue(lua_State*,int);
    void lua_setglobal(lua_State*,const(char)*);
    void lua_settable(lua_State*,int);
    void lua_setfield(lua_State*,int,const(char)*);
    void lua_rawset(lua_State*,int);
    void lua_rawseti(lua_State*,int,int);
    void lua_rawsetp(lua_State*,int,const(void)*);
    int lua_setmetatable(lua_State*,int);
    int lua_setuservalue(lua_State*,int);
    void lua_callk(lua_State*,int,int,int,lua_CFunction);
    int lua_getctx(lua_State*,int*);
    int lua_pcallk(lua_State*,int,int,int,int,lua_CFunction);
    int lua_load(lua_State*,lua_Reader,void*,const(char)*);
    int lua_dump(lua_State*,lua_Writer,void*);
    int lua_yieldk(lua_State*,int,int,lua_CFunction);
    int lua_resume(lua_State*,int);
    int lua_status(lua_State*);
    int lua_gc(lua_State*,int,int);
    int lua_error(lua_State*);
    int lua_next(lua_State*,int);
    void lua_concat(lua_State*,int);
    lua_Alloc lua_getallocf(lua_State*,void**);
    void lua_setallocf(lua_State*,lua_Alloc,void*);
    int lua_getstack(lua_State*,lua_Debug*);
    int lua_getinfo(lua_State*,const(char)*,lua_Debug*);
    const(char)* lua_getlocal(lua_State*,const(lua_Debug)*,int);
    const(char)* lua_setlocal(lua_State*,const(lua_Debug)*,int);
    const(char)* lua_getupvalue(lua_State*,int,int);
    const(char)* lua_setupvalue(lua_State*,int,int);
    void* lua_upvalueid(lua_State*,int,int);
    void lua_upvaluejoin(lua_State*,int,int,int,int);
    int lua_sethook(lua_State*,lua_Hook,int,int);
    lua_Hook lua_gethook(lua_State*);
    int lua_gethookmask(lua_State*);
    int lua_gethookcount(lua_State*);

    // lualib.h
    int luaopen_base(lua_State*);
    int luaopen_coroutine(lua_State*);
    int luaopen_table(lua_State*);
    int luaopen_io(lua_State*);
    int luaopen_os(lua_State*);
    int luaopen_string(lua_State*);
    int luaopen_bit32(lua_State*);
    int luaopen_math(lua_State*);
    int luaopen_debug(lua_State*);
    int luaopen_package(lua_State*);
    void luaL_openlibs(lua_State*);