/*-----------------------------------------------------------------\
|Ces fonctions permettent de créer des hash pour initialiser l'état|
|du RNG xoshiro.                                                   |
\-----------------------------------------------------------------*/

#ifndef HASH
#define HASH

#include "rng.h"
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>

#define min(a,b) ((a<b) ? a : b)

uint64_t minihash(const char* str); //Un hash très simple qui renvoit 8 octets
XOSHIROetat* maxihash(const char* str); //Un hash qui donne un résultat de 32 octets

#endif

