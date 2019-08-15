//exemple d'appel de fonctions lua par du C


#include "cryptage.h"

void manuel(void);

int main(int argc,char** argv){
    lua_State* L;
    // initialize Lua interpreter
    L = luaL_newstate();

    // load Lua base libraries (print / math / etc)
    luaL_openlibs(L);

    //On charge les fonctions custom
    include(L);

    //On charge le fichier
    luaL_dofile(L,"ASCcmpFonctions.lua"); //dev
    luaL_dofile(L,"ASCcrypteFonctions.lua"); //dev
    
    if(argc>1){ //On a une instruction
        const char* commande = *(argv+1);
        if(!strcmp(commande,"encryption")){ //On encrypte
            if(argc == 2 || argc > 5){ //Il y a une erreur dans le nombre d'arguments
               manuel();
            }else{
            lua_getglobal(L,"encrypt");
                lua_pushstring(L,*(argv + 2));
                lua_pushstring(L,*(argv + 3));
                if(argc == 4){ //Pas d'output file
                    lua_pushboolean(L,0);
                }else{ //Un output file
                    lua_pushstring(L,*(argv + 4));
                }
                lua_call(L,3,0);
            }
        }
        if(!strcmp(commande,"compress")){
            printf("TODO\n");
        }
        if(!strcmp(commande,"decompress")){
            printf("TODO\n");
        }
    }else{ //Pas d'instruction
        manuel();
    }
    //On appelle la fonction
    //lua_getglobal(L,"main");

    //On execute la fonction
    //lua_call(L,0,0);
    
    // Cleanup
    lua_close(L);

    return 0;
}

void manuel(void){
    printf("This software is used to compress directories and encrypt files or directories\nUsage : ASCcrypte <option> <input file/directory> [password] [output file/directory]\n\nAvailable options :\n    encryption : Encrypt or decrypt the input file or directory. If the input is a directory it will be compressed first. You need to give a password for this to function.\n    compress : Compress the input directory in a single file.\n    decompress : Decompress a directory from a file. You need to give an output directory for  this function\n\nIf you dont give an output file the result will be writen on stdout.\n");
}

