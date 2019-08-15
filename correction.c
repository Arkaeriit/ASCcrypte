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
            fprintf(stderr,"Error: %s is a dirrectory anc cannot be written over.\n",dest);
            return 0;
        }else{
            return 1;
        }
    }else{
        fprintf(stderr,"Error: no such file as %s.\n",source);
        return 0;
    }
}

