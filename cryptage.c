#include "cryptage.h"


int cryptage(lua_State *L){
    const char* clair = luaL_checkstring(L,1);
    const char* password = luaL_checkstring(L,2);
    long int len = luaL_checkinteger(L,3);
    unsigned int lenPsw = luaL_checkinteger(L,4);
    char* result = malloc(sizeof(char) * len);
    for(int i = 0;i<len;i++){
        *(result + i) = *(clair + i) ^ *(password + i%lenPsw);
    }
    lua_pushlstring(L,result,len);
    free(result);
    return 1;
}

int passwordGenerator(lua_State *L){
    const char* psw = luaL_checkstring(L,1);
    unsigned int len = luaL_checkinteger(L,2);
    long int pswSum = 0;
    for(int i=0;i<len;i++){
        pswSum = pswSum + (unsigned int) *(psw + i);
    }
    XOSHIRO_seed(pswSum + len * *(psw)); //La somme du mot de passe va nous permettre de choisir le début du hasard.
    unsigned int lenTotal = (4096 + pswSum * (22 + minirand(34))) * (1 + minirand(10)); //La taille du mot de passe allongé est aussi aléatoire
    if(lenTotal > (1000000000 * minirand(5))){
        lenTotal = 1000000000 * minirand(5) + 4096 * minirand(255);
    }
    char* ret = malloc(sizeof(char) * lenTotal);
    for(int i=0;i<lenTotal;i++){
        unsigned int place = minirand(len);
        *(ret + i) = *(psw + place); //On prend un élément du mot de passe au pif et on le met à la suite.
    }
    lua_pushlstring(L,ret,lenTotal);
    free(ret);
    return 1;
}

void include(lua_State *L){
    lua_pushcfunction(L,cryptage);
    lua_setglobal(L,"C_cryptage");
    lua_pushcfunction(L,passwordGenerator);
    lua_setglobal(L,"passwordGenerator");
}

