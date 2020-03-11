#include "hash.h"

uint64_t minihash(const char* str){
    uint64_t ret;
    char* eq = (char*) &ret; //On travaille sur le ret comme si s'était un vecteur de 8 char
    memset(eq, 255, 8);
    for(int i=0; i<min(8,strlen(str)); i++)
        eq[i] ^= str[i];
    return ret;
}

XOSHIROetat* maxihash(const char* str){
    uint64_t state = minihash(str);
    XOSHIROetat* ret = malloc(sizeof(XOSHIROetat));
    for(int i=0; i<4; i++){ //Initialisation du hash
        *ret[i] = state;
        state = xorshift_rand(state);
    }
    char* eq = (char*) *ret;
    for(int i=0; i<strlen(str); i++){
        eq[i%32] ^= str[i] ^ (char) state;
        state = xorshift_rand(state ^ (uint64_t) str[i]);
    }
    return ret;
}

