#include "hash.h"

uint64_t minihash(char* str){
    uint64_t ret;
    char* eq = (char*) &ret; //On travaille sur le ret comme si s'était un vecteur de 8 char
    memset(eq, 255, 8);
    for(int i=0; i<min(8,strlen(str)); i++)
        eq[i] ^= str[i];
    return ret;
}

