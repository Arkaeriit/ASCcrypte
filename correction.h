#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int exist(lua_State *L,char* fichier); //Indique si fichier existe
int isDir(lua_State *L,char* fichier); //Indique si fichier est un dossier
int correction_decompress(lua_State *L,char* source,char* dest); //permet de savoir si tout est bon pour la decompression

