#include "gestionFS.h"

int gFS_ls(lua_State* L){
    const char* dirName = luaL_checkstring(L,1);
    DIR *dirDesc;
    struct dirent *dirEntry;
    dirDesc = opendir(dirName);
    lua_createtable(L,25,0); //On créé une table, on pese qu'il y aura environt 25élem mais c'est une approximation assez vulgaire.
    int index = 0; //sert à indéxer la table
    if(dirDesc){ //Le dossier existe
        while((dirEntry = readdir(dirDesc)) != NULL){
            char* currentfile = dirEntry->d_name;
            if( (strcmp(currentfile,".")) && (strcmp(currentfile,".."))){
                index++;
                lua_pushinteger(L,index);
                lua_pushstring(L,currentfile);
                lua_settable(L,-3); //On met le fichier dans la tale à l'index index.
            }
        }
    }
    /* La table est déja au sommet de la stack */
    return 1;
}

int gFS_mkdir(lua_State *L){
    const char* dirName = luaL_checkstring(L,1);
    mkdir(dirName,755);
    return 0;
}

void gFS_include(lua_State* L){
    lua_pushcfunction(L,gFS_ls);
    lua_setglobal(L,"ls");
    lua_pushcfunction(L,gFS_mkdir);
    lua_setglobal(L,"createDir");
}

