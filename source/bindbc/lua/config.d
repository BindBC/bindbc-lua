/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module bindbc.lua.config;

public import bindbc.common.versions;

enum staticBinding = (){
	version(BindBC_Static)       return true;
	else version(BindLua_Static) return true;
	else return false;
}();

enum luaVersion = (){
	version(Lua_5_4)      return Version(5,4,0);
	else version(Lua_5_3) return Version(5,3,0);
	else version(Lua_5_2) return Version(5,2,0);
	else version(Lua_5_1) return Version(5,1,0);
	else version(Lua_4_0) return Version(4,0,0);
	else                  return Version(5,0,0);
}();
