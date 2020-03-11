#ifndef HASH
#define HASH

#include "rng.h"
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>

#define min(a,b) ((a<b) ? a : b)

uint64_t minihash(char* str); //Un hash très simple qui renvoit 8 octets

#endif

