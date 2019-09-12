
ASCcrypte : main.o cryptage.o rng.o correction.o ASCcmpFonctions.luac ASCcrypteFonctions.luac gestionFS.luac RAMusage.luac
	gcc main.o cryptage.o correction.o rng.o -llua -lm -ldl -o ASCcrypte

ASCcmpFonctions.luac : ASCcmpFonctions.lua
	luac -o ASCcmpFonctions.luac ASCcmpFonctions.lua

ASCcrypteFonctions.luac : ASCcrypteFonctions.lua
	luac -o ASCcrypteFonctions.luac ASCcrypteFonctions.lua

gestionFS.luac : gestionFS.lua
	luac -o gestionFS.luac gestionFS.lua

RAMusage.luac : RAMusage.lua
	luac -o RAMusage.luac RAMusage.lua

main.o : main.c cryptage.h
	gcc -c main.c -Wall -o main.o

cryptage.o : cryptage.c cryptage.h
	gcc -c cryptage.c -Wall -o cryptage.o

rng.o : rng.c rng.h
	gcc -c rng.c -Wall -o rng.o

correction.o : correction.c correction.h
	gcc -c correction.c -Wall -o correction.o

clean :
	rm -f *.o
	rm -f *.luac
	rm -f ASCcrypte

install : uninstall
	mkdir /usr/local/share/ASCcrypte
	cp ASCcrypte /usr/local/bin
	cp ASCcmpFonctions.luac /usr/local/share/ASCcrypte
	cp ASCcrypteFonctions.luac /usr/local/share/ASCcrypte
	cp gestionFS.luac /usr/local/share/ASCcrypte
	cp RAMusage.luac /usr/local/share/ASCcrypte

uninstall :
	rm -Rf /usr/local/share/ASCcrypte
	rm -f /usr/local/bin/ASCcrypte

