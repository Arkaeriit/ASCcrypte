
ASCcrypte : main.o cryptage.o rng.o compress.o gestionFS.o correction.o ASCcmpFonctions.luac ASCcrypteFonctions.luac RAMusage.luac
	gcc main.o cryptage.o correction.o rng.o compress.o gestionFS.o -llua -lm -ldl -o ASCcrypte

ASCcmpFonctions.luac : ASCcmpFonctions.lua
	luac -o ASCcmpFonctions.luac ASCcmpFonctions.lua

ASCcrypteFonctions.luac : ASCcrypteFonctions.lua
	luac -o ASCcrypteFonctions.luac ASCcrypteFonctions.lua

RAMusage.luac : RAMusage.lua
	luac -o RAMusage.luac RAMusage.lua

main.o : main.c cryptage.h
	gcc -c main.c -Wall -o main.o

compress.o : compress.c compress.h
	gcc -c compress.c -Wall -o compress.o

cryptage.o : cryptage.c cryptage.h
	gcc -c cryptage.c -Wall -o cryptage.o

rng.o : rng.c rng.h
	gcc -c rng.c -Wall -o rng.o

correction.o : correction.c correction.h
	gcc -c correction.c -Wall -o correction.o

gestionFS.o : gestionFS.c gestionFS.h
	gcc -c gestionFS.c -Wall -o gestionFS.o
clean :
	rm -f *.o
	rm -f *.luac
	rm -f ASCcrypte

install : 
	mkdir -p /usr/local/share/ASCcrypte
	cp -f ASCcrypte /usr/local/bin
	cp -f ASCcmpFonctions.luac /usr/local/share/ASCcrypte
	cp -f ASCcrypteFonctions.luac /usr/local/share/ASCcrypte
	cp -f RAMusage.luac /usr/local/share/ASCcrypte

uninstall :
	rm -Rf /usr/local/share/ASCcrypte
	rm -f /usr/local/bin/ASCcrypte

