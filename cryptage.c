#include "cryptage.h"


int cryptage(lua_State *L){
    const char* clair = luaL_checkstring(L,1);
    const char* password = luaL_checkstring(L,2);
    long int len = luaL_checkinteger(L,3);
    char* result = malloc(sizeof(char) * len);
    for(int i = 0;i<len;i++){
        *(result + i) = *(clair + i) ^ *(password + i);
    }
    lua_pushlstring(L,result,len);
    free(result);
    return 1;
}

int passwordGenerator(lua_State *L){
    const char* psw = luaL_checkstring(L,1);
    unsigned int len = luaL_checkinteger(L,2);
    unsigned int lenTotal = luaL_checkinteger(L,3);
    char* ret = malloc(sizeof(char) * lenTotal); //Le mot de passeque l'o va sortir fera la meme taille que le mot de passe d'entrée.
    long int pswSum = 0;
    for(int i=0;i<len;i++){
        pswSum = pswSum + (unsigned int) *(psw + i);
    }
    srand(pswSum); //La somme du mot de passe va nous permettre de choisir le début du hasard.
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

unsigned int minirand(unsigned int max){
    int masque = 1 << ((sizeof(int) * 8) - 1);//Dans un premier temps on regarde combien de bits sont nécessaire pour écrire des nombres inférieurs à max
    int nombreBits = 0;
    for(int i=sizeof(int) * 8;i>0;i--){
        if(masque & max){
            nombreBits = i;
            break;
        }
        masque = masque >> 1;
    }
    masque = 1;
    for(int i=1;i<nombreBits;i++){
        masque = masque << 1;
        masque++;
    }
    unsigned int ret = rand() & masque; //maitenant on s'intéresse au nombre que l'on veut retourner
    while(ret > max){
        ret = rand() & masque;
    }
    return ret;
}

