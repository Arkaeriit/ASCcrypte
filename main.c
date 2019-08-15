#include "cryptage.h"
#include "correction.h"

#define devel 0

void manuel(void);

int main(int argc,char** argv){
    lua_State* L;
    L = luaL_newstate();
    luaL_openlibs(L);
    include(L);

    //On charge les fichiers
#if devel == 1
    fprintf(stdout,"Mode de developpement...\n");
    luaL_dofile(L,"ASCcmpFonctions.lua"); //dev
    luaL_dofile(L,"ASCcrypteFonctions.lua"); //dev
#else
    luaL_dofile(L,"/usr/local/share/ASCcrypte/ASCcmpFonctions.luac");
    luaL_dofile(L,"/usr/local/share/ASCcrypte/ASCcrypteFonctions.luac");
#endif

    if(argc>1){ //On a une instruction
        const char* commande = *(argv+1);
        if(!strcmp(commande,"encryption")){ //On encrypte
            if(argc == 2 || argc > 5){ //Il y a une erreur dans le nombre d'arguments
               manuel();
            }else{
                if(exist(L,*(argv + 2))){
                    lua_getglobal(L,"encrypt");
                    lua_pushstring(L,*(argv + 2));
                    lua_pushstring(L,*(argv + 3));
                    if(argc == 4){ //Pas d'output file
                        lua_pushboolean(L,0);
                        lua_call(L,3,0);
                    }else{ //Un output file
                        if(isDir(L,*(argv + 4))){
                            fprintf(stderr,"Error: %s is a directoty and can not be written over.\n",*(argv + 4));
                        }else{
                            lua_pushstring(L,*(argv + 4));
                            lua_call(L,3,0);
                        }
                    }
                }else{
                    fprintf(stderr,"Error, no such file or directory as %s.\n",*(argv + 2));
                }
            }
        }
        if(!strcmp(commande,"compress")){
            if(argc == 2 || argc > 4){ //Il y a une erreur dans le nombre d'arguments
                manuel();
            }else{
                if(isDir(L,*(argv + 2))){
                    lua_getglobal(L,"compress");
                    lua_pushstring(L,*(argv + 2));
                    if(argc == 3){ //Pas d'ouput file
                        lua_pushboolean(L,0);
                        lua_call(L,2,0);
                    }else{ //Un output file
                        if(isDir(L,*(argv + 3))){
                            fprintf(stderr,"Error, no such file or directory as %s.\n",*(argv + 2));
                        }else{
                            lua_pushstring(L,*(argv + 3));
                            lua_call(L,2,0);
                        }
                    }
                }else{
                    fprintf(stderr,"Error: no such directory as %s.\n",*(argv + 2));
                }
            }
        }
        if(!strcmp(commande,"decompress")){
            if(argc != 4){ //pas le bon nombre d'arguments
                manuel();
            }else{
                if(correction_decompress(L,*(argv+2),*(argv+3))){
                    lua_getglobal(L,"decompress");
                    lua_pushstring(L,*(argv+2));
                    lua_pushstring(L,*(argv+3));
                    lua_call(L,2,0);
                }
            }
        }
        if(strcmp(commande,"encryption") && strcmp(commande,"compress") && strcmp(commande,"decompress")){ //mauvaise commande
            manuel();
        }
    }else{ //Pas d'instruction
        manuel();
    }

    lua_close(L);
    return 0;
}

void manuel(void){
    fprintf(stderr,"This software is used to compress directories and encrypt files or directories\nUsage: ASCcrypte <option> <input file/directory> [password] [output file/directory]\n\nAvailable options:\n    encryption: Encrypt or decrypt the input file or directory. If the input is a directory it will be compressed first. You need to give a password for this to function.\n    compress: Compress the input directory in a single file.\n    decompress: Decompress a directory from a file. You need to give an output directory for  this function.\n\nIf you don't give an output file the result will be written on stdout.\n");
}

