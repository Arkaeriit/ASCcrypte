#include "cryptage.h"

int cryptage(lua_State *L){
    const char* clair = luaL_checkstring(L,1);
    const char* password = luaL_checkstring(L,2);
    long int len = luaL_checkinteger(L,3);
    char* result = malloc(sizeof(char) * len);
    XOSHIROetat* state = maxihash(password);
    XOSHIRO_importState(*state);
    free(state);
    for(int i = 0;i<len;i++){
        *(result + i) = *(clair + i) ^ (char) XOSHIRO_rand();
    }
    lua_pushlstring(L,result,len);
    free(result);
    return 1;
}

int crypte_file(const char* in,const char* out, const char* password){
    //Initialisation des pointeurs de fichier
    FILE *fin,*fout;
    if( (fin = fopen(in,"r")) == NULL)
        return 1;
    if( (fout = fopen(out,"w")) == NULL)
        return 2;
    //Calcul de la taille des fichiers
    fseek(fin, 0, SEEK_END);
    size_t size = ftell(fin);
    fseek(fin, 0, SEEK_SET);
    //Initialisation du rng
    XOSHIROetat* state = maxihash(password); 
    XOSHIRO_importState(*state);
    free(state);
    //Cryptage
    for(size_t i=0; i<size; i++)
        fputc( fgetc(fin) ^ (char) XOSHIRO_rand(), fout);
    //Fermeture des fichiers
    fclose(fout);
    fclose(fin);
    return 0;
}

int crypte_file_lua(lua_State* L){
    const char* in = luaL_checkstring(L,1);
    const char* out = luaL_checkstring(L,2);
    const char* password = luaL_checkstring(L,3);
    int code = crypte_file(in,out,password);
    if(code)
        fprintf(stderr, "Error : while encrypting file.\nError code : %i.\n",code);
    return 0;
}

void CR_include(lua_State *L){
    lua_pushcfunction(L,cryptage);
    lua_setglobal(L,"C_cryptage");
    lua_pushcfunction(L,crypte_file_lua);
    lua_setglobal(L,"crypte_file");
}

