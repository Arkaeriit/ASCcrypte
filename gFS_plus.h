
#ifndef GESTIONFSPLUS
#define GESTIONFSPLUS

#include <dirent.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int gFS_exist(const char* fileName); //indique si un fichier existe ou non.
mode_t gFS_getPerm(const char* fileName); //Retourne les permitions d'un fihier 
int gFS_isDir(const char* fileName); //indique si fileName existe

#endif

