/*-----------------------------------------------------------\
|Ces fonctions servent à donner les moyens aux scripts lua de|
|connaitre la taille d'un fichier.                           |
\-----------------------------------------------------------*/

#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int fileSize(lua_State* L); //Permet de savoir en lua la taille d'un fichier

void CMP_include(lua_State* L); //Permet d'inclure les fonctions que l'on veut
