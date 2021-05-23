
//          Copyright 2019 - 2021 Michael D. Parker
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
    void luaL_checkversion_(lua_State* L, lua_Number ver);
    int luaL_getmetafield(lua_State* L, int obj, const(char)* e);
    int luaL_callmeta(lua_State* L,  int obj, const(char)* e);
    const(char)* luaL_tolstring(lua_State* L, int idx, size_t* len);
    int luaL_argerror(lua_State* L, int numarg, const(char)* extramsg);
    const(char)* luaL_checklstring(lua_State* L, int numArg, size_t* l);
    const(char)* luaL_optlstring(lua_State* L, int numArg, const(char)* def, size_t* l);
    lua_Number luaL_checknumber(lua_State* L, int numArg);
    lua_Number luaL_optnumber(lua_State* L, int nArg, lua_Number def);
    lua_Integer luaL_checkinteger(lua_State* L, int numArg);
    lua_Integer luaL_optinteger(lua_State* L, int nArg, lua_Integer def);
    lua_Unsigned luaL_checkunsigned(lua_State* L, int numArg);
    lua_Unsigned luaL_optunsigned(lua_State* L, int numArg, lua_Unsigned def);
    void luaL_checkstack(lua_State* L, int sz, const(char)* msg);
    void luaL_checktype(lua_State* L, int narg, int t);
    void luaL_checkany(lua_State* L, int narg);
    int luaL_newmetatable(lua_State* L, const(char)* tname);
    void luaL_setmetatable(lua_State* L, const(char)* tname);
    void* luaL_testudata(lua_State* L, int ud, const(char)* tname);
    void* luaL_checkudata(lua_State* L, int ud, const(char)* tname);
    void luaL_where(lua_State* L, int lvl);
    int luaL_error(lua_State* L, const(char)* fmt, ...);
    int luaL_checkoption(lua_State* L, int narg, const(char)* def, const(char)** lst);
    int luaL_fileresult(lua_State* L, int stat, const(char)* fname);
    int luaL_execresult(lua_State* L, int stat);
    int luaL_ref(lua_State* L, int t);
    void luaL_unref(lua_State* L, int t, int ref_);
    int luaL_loadfilex(lua_State* L, const(char)* filename, const(char)* mode);
    int luaL_loadbufferx(lua_State* L, const(char)* buff, size_t sz, const(char)* name, const(char)* mode);
    int luaL_loadstring(lua_State* L, const(char)* s);
    lua_State* luaL_newstate();
    int luaL_len(lua_State* L, int idx);
    const(char)* luaL_gsub(lua_State* L, const(char)* s, const(char)* p, const(char)* r);
    void luaL_setfuncs(lua_State* L, const(luaL_Reg)* l, int nup);
    int luaL_getsubtable(lua_State* L, int idx, const(char)* fname);
    void luaL_traceback(lua_State* L, lua_State* L1, const(char)* msg, int level);
    void luaL_requiref(lua_State* L, const(char)* modname, lua_CFunction openf, int glb);
    void luaL_buffinit(lua_State* L, luaL_Buffer* B);
    char* luaL_prepbuffsize(luaL_Buffer*, size_t sz);
    void luaL_addlstring(luaL_Buffer* B, const(char)* s, size_t l);
    void luaL_addstring(luaL_Buffer* B,  const(char)* s);
    void luaL_addvalue(luaL_Buffer* B);
    void luaL_pushresult(luaL_Buffer* B);
    void luaL_pushresultsize(luaL_Buffer* B, size_t sz);
    char* luaL_buffinitsize(lua_State* L, luaL_Buffer* B, size_t sz);

    // lua.h
    lua_State* lua_newstate(lua_Alloc f, void* ud);
    lua_State* lua_close(lua_State* L);
    lua_State* lua_newthread(lua_State* L);
    lua_CFunction lua_atpanic(lua_State* L, lua_CFunction panicf);
    const(lua_Number)* lua_version(lua_State* L);
    int lua_absindex(lua_State* L, int idx);
    int lua_gettop(lua_State* L);
    void lua_settop(lua_State* L, int idx);
    void lua_pushvalue(lua_State* L, int idx);
    void lua_remove(lua_State* L, int idx);
    void lua_insert(lua_State* L, int idx);
    void lua_replace(lua_State* L, int idx);
    void lua_copy(lua_State* L, int fromidx, int toidx);
    int lua_checkstack(lua_State* L, int sz);
    void lua_xmove(lua_State* from, lua_State* to, int n);
    int lua_isnumber(lua_State* L, int idx);
    int lua_isstring(lua_State* L, int idx);
    int lua_iscfunction(lua_State* L, int idx);
    int lua_isuserdata(lua_State* L, int idx);
    int lua_type(lua_State* L, int idx);
    const(char)* lua_typename(lua_State* L, int tp);
    lua_Number lua_tonumberx(lua_State* L, int idx, int* isnum);
    lua_Integer lua_tointegerx(lua_State* L, int idx, int* isnum);
    lua_Unsigned lua_tounsignedx(lua_State* L, int idx, int* isnum);
    int lua_toboolean(lua_State* L, int idx);
    const(char)* lua_tolstring(lua_State* L, int idx, size_t* len);
    size_t lua_rawlen(lua_State* L, int idx);
    lua_CFunction lua_tocfunction(lua_State* L, int idx);
    void* lua_touserdata(lua_State* L, int idx);
    lua_State* lua_tothread(lua_State* L, int idx);
    const(void)* lua_topointer(lua_State* L, int idx);
    void lua_arith(lua_State* L, int op);
    int lua_rawequal(lua_State* L, int idx1, int idx2);
    int lua_compare(lua_State* L, int idx1, int idx2, int op);
    void lua_pushnil(lua_State* L);
    void lua_pushnumber(lua_State* L, lua_Number n);
    void lua_pushinteger(lua_State* L, lua_Integer n);
    void lua_pushunsigned(lua_State* L, lua_Unsigned n);
    void lua_pushlstring(lua_State* L, const(char)* s, size_t l);
    void lua_pushstring(lua_State* L, const(char)* s);
    const(char)* lua_pushvfstring(lua_State* L, const(char)* fmt, va_list argp);
    const(char)* lua_pushfstring(lua_State* L, const(char)* fmt, ...);
    void lua_pushcclosure(lua_State* L, lua_CFunction fn, int n);
    void lua_pushboolean(lua_State* L, int b);
    void lua_pushlightuserdata(lua_State* L, void* p);
    int lua_pushthread(lua_State* L);
    void lua_getglobal(lua_State* L, const(char)* var);
    void lua_gettable(lua_State* L, int idx);
    void lua_getfield(lua_State* L, int idx, const(char)* k);
    void lua_rawget(lua_State* L, int idx);
    void lua_rawgeti(lua_State* L, int idx, int n);
    void lua_rawgetp(lua_State* L, int idx, const(void)* p);
    void lua_createtable(lua_State* L, int narr, int nrec);
    void* lua_newuserdata(lua_State* L, size_t sz);
    int lua_getmetatable(lua_State* L, int objindex);
    void lua_getuservalue(lua_State* L, int idx);
    void lua_setglobal(lua_State* L, const(char)* var);
    void lua_settable(lua_State* L, int idx);
    void lua_setfield(lua_State* L, int idx, const(char)* k);
    void lua_rawset(lua_State* L, int idx);
    void lua_rawseti(lua_State* L, int idx, int n);
    void lua_rawsetp(lua_State* L, int idx, const(void)* p);
    int lua_setmetatable(lua_State* L, int objindex);
    int lua_setuservalue(lua_State* L, int idx);
    void lua_callk(lua_State* L, int nargs, int nresults, int ctx, lua_CFunction k);
    int lua_getctx(lua_State* L, int* ctx);
    int lua_pcallk(lua_State* L, int nargs, int nresults, int errfunc, int ctx, lua_CFunction k);
    int lua_load(lua_State* L, lua_Reader reader, void* dt, const(char)* chunkname, const(char)* mode);
    int lua_dump(lua_State* L, lua_Writer writer, void* data);
    int lua_yieldk(lua_State* L, int nresults, int ctx, lua_CFunction k);
    int lua_resume(lua_State* L, lua_State* from, int narg);
    int lua_status(lua_State* L);
    int lua_gc(lua_State* L, int what, int data);
    int lua_error(lua_State* L);
    int lua_next(lua_State* L, int idx);
    void lua_concat(lua_State* L, int n);
    void lua_len(lua_State* L, int idx);
    lua_Alloc lua_getallocf(lua_State* L, void** ud);
    void lua_setallocf(lua_State* L, lua_Alloc f, void* ud);
    int lua_getstack(lua_State* L, int level, lua_Debug* ar);
    int lua_getinfo(lua_State* L, const(char)* what, lua_Debug* ar);
    const(char)* lua_getlocal(lua_State* L, const(lua_Debug)* ar, int n);
    const(char)* lua_setlocal(lua_State* L, const(lua_Debug)* ar, int n);
    const(char)* lua_getupvalue(lua_State* L, int funcindex, int n);
    const(char)* lua_setupvalue(lua_State* L, int funcindex, int n);
    void* lua_upvalueid(lua_State* L, int fidx, int n);
    void lua_upvaluejoin(lua_State* L, int fidx1, int n1, int fidx2, int n2);
    int lua_sethook(lua_State* L, lua_Hook func, int mask, int count);
    lua_Hook lua_gethook(lua_State* L);
    int lua_gethookmask(lua_State* L);
    int lua_gethookcount(lua_State* L);

    // lualib.h
    int luaopen_base(lua_State* L);
    int luaopen_coroutine(lua_State* L);
    int luaopen_table(lua_State* L);
    int luaopen_io(lua_State* L);
    int luaopen_os(lua_State* L);
    int luaopen_string(lua_State* L);
    int luaopen_bit32(lua_State* L);
    int luaopen_math(lua_State* L);
    int luaopen_debug(lua_State* L);
    int luaopen_package(lua_State* L);
    void luaL_openlibs(lua_State* L);