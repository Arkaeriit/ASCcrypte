

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <string.h>
#include <stdlib.h>

int cryptage(lua_State *L); //Reçoit deux chaines et la longueur de la première, resort un xor des deux
int passwordGenerator(lua_State *L); //Reçoit une chaine et sa longueur, renvoie un mot de passe de 4096 charactères 

void include(lua_State *L); //Permet de mettre la fonction d'au dessu dans le lua_State
unsigned int minirand(unsigned int max); //Donne un entier aléatoire inférieur à max
