#include "compress.h"

int fileSize(lua_State* L){
    const char* fileName = luaL_checkstring(L,1);
    FILE* descripteurFile;
    descripteurFile = fopen(fileName,"r");
    fseek(descripteurFile,0,SEEK_END);
    long size = ftell(descripteurFile);
    fclose(descripteurFile);
    lua_pushinteger(L,size);
    return 1;
}

void CMP_include(lua_State *L){
    lua_pushcfunction(L,fileSize);
    lua_setglobal(L,"fileSize");
}

