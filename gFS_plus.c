#include "gFS_plus.h"

int gFS_exist(const char* fileName){
    return (access( fileName, F_OK ) != -1);
}

mode_t gFS_getPerm(const char* fileName){
    struct stat buffer;
    stat(fileName, &buffer);
    return buffer.st_mode;
}

int gFS_isDir(const char* fileName){
    struct stat statFichier;
    stat(fileName,&statFichier);
    return S_ISDIR(statFichier.st_mode);
}

