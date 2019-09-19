

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h>

int ls(lua_State* L); //permet d'avoir le ls en lua

void gFS_include(lua_State *L);

