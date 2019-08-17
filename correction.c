#include "correction.h"

int exist(lua_State *L,char* fichier){
    lua_getglobal(L,"exist");
    lua_pushstring(L,fichier);
    lua_call(L,1,1);
    int ret = lua_toboolean(L,-1);
    return ret;
}

int isDir(lua_State *L,char* fichier){
    if(exist(L,fichier)){
        lua_getglobal(L,"isDir");
        lua_pushstring(L,fichier);
        lua_call(L,1,1);
        int ret = lua_toboolean(L,-1);
        return ret;
    }else{
        return 0;
    }
}

int correction_decompress(lua_State *L,char* source,char* dest){
    if(exist(L,source)){
        if(isDir(L,dest)){
            return 1;
        }else{
            fprintf(stderr,"Error: %s is a not dirrectory.\n",dest);
            return 0;
        }
    }else{
        fprintf(stderr,"Error: no such file as %s.\n",source);
        return 0;
    }
}

