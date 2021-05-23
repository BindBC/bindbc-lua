
//          Copyright 2019 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.lua;
public import bindbc.lua.config;

version(LUA_54) public import bindbc.lua.v54;
else version(LUA_53) public import bindbc.lua.v53;
else version(LUA_52) public import bindbc.lua.v52;
else version(LUA_51) public import bindbc.lua.v51;
else static assert(0, "Please specify a Lua version on the commandline (e.g. -version=LUA_52) or in your dub.json/sdl configuration");