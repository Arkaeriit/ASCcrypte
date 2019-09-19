/*-----------------------------------------------------------\
|Ces fonctions permettent au script lua d'intéragir propement|
|avec les système de fichiers.                               |
\-----------------------------------------------------------*/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>

int gFS_ls(lua_State* L); //permet d'avoir le ls en lua
int gFS_mkdir(lua_State* L); //permet d'avoir le mkdir en lua

void gFS_include(lua_State *L);

