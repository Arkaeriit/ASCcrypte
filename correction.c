#include "correction.h"

int correction_decompress(const char* source,const char* dest){
    if(gFS_exist(source)){
        if(gFS_isDir(dest)){
            return 1;
        }else{
            fprintf(stderr,"Error: %s is a not dirrectory.\n",dest);
            return 0;
        }
    }else{
        fprintf(stderr,"Error: no such file as %s.\n",source);
        return 0;
    }
}

