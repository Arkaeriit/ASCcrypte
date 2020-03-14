#include "cryptage.h"
#include "gestionFS.h"

int main(){
    crypte_file("hash.h","out1","kjh");
    crypte_file("out1","out2","kjh");
    mode_t o = gFS_getPerm("out2");
    chmod("out2", o);
    return 0;
}

