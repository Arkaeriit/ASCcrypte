#include "rng.h"

XOSHIROetat memState;

uint64_t xorshift_rand(uint64_t seed){
    uint64_t ret = seed ^ (seed << 13);
    ret ^= ret >> 7;
    ret ^= ret << 17;
    return  ret;
}

void XOSHIRO_seed(uint64_t seed){ //Pour remplir tout l'état avec une seule seed on utilise un simple xorshift pour trouver de quoi remplir l'état
    memState[0] = xorshift_rand(seed);
    memState[1] = xorshift_rand(memState[0]);
    memState[2] = xorshift_rand(memState[1]);
    memState[3] = xorshift_rand(memState[2]);
}

uint64_t XOSHIRO_rand(){
    uint64_t const ret = (((memState[1] * 5) << 7) | ((memState[1] * 7) >> (64 - 7)) ) * 9;
    uint64_t const t = memState[1] << 17;

    memState[2] ^= memState[0];
    memState[3] ^= memState[1];
    memState[1] ^= memState[2];
    memState[0] ^= memState[3];
    
    memState[2] ^= t;
    memState[3] = (memState[3] << 45) | (memState[3] >> (64 - 45));

    return ret;
}


unsigned int minirand(unsigned int max){
    unsigned int masque = 1 << ((sizeof(unsigned int) * 8) - 1);//Dans un premier temps on regarde combien de bits sont nécessaire pour écrire des nombres inférieurs à max. Cela à pour but de réduire le temps de calcul du nombre aléatoire.
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
    unsigned int ret = XOSHIRO_rand() & masque; //maitenant on s'intéresse au nombre que l'on veut retourner
    while(ret > max){
        ret = XOSHIRO_rand() & masque;
    }
    return ret;
}

