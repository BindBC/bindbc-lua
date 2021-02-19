
//          Copyright Michael D. Parker 2018.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.lua.config;

enum LuaSupport {
    noLibrary,
    badLibrary,
    lua51 = 51,
    lua52 = 52,
    lua53 = 53,
    lua54 = 54,
}

version(LUA_54) {
    enum luaSupport = LuaSupport.lua54;
}
else version(LUA_53) {
    enum luaSupport = LuaSupport.lua53;
}
else version(LUA_52) {
    enum luaSupport = LuaSupport.lua52;
}
else version(LUA_51) {
    enum luaSupport = LuaSupport.lua51;
}