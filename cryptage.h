/*--------------------------------------------------------------\
|Ces fonctions servent à faire le cryptage grâce à des xor des  |
|fichiers à crypter. Les deux fonctions se retrouveront dans les|
|lua_State.                                                     |
\--------------------------------------------------------------*/

#ifndef CRYPTAGE
#define CRYPTAGE

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <string.h>
#include <stdlib.h>
#include "rng.h"
#include "hash.h"

int cryptage(lua_State *L); //Reçoit deux chaines et la longueur de la première, resort la première cryptée
int crypte_file(const char* in, const char* out, const char* password); //Crypte le contenu du fichier au chemin in vers le ficher ou chemin out. Retourne 1 ou 2 en cas d'erreur.
int crypte_file_lua(lua_State* L); //Warper en lua de crypte_file

void CR_include(lua_State *L); //Permet de mettre la fonction d'au dessu dans le lua_State

#endif

