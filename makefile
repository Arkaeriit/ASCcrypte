
ASCcrypte : main.o cryptage.o ASCcmpFonctions.luac ASCcrypteFonctions.luac
	gcc main.o cryptage.o -llua -lm -ldl -o ASCcrypte

ASCcmpFonctions.luac : ASCcmpFonctions.lua
	luac -o ASCcmpFonctions.luac ASCcmpFonctions.lua

ASCcrypteFonctions.luac : ASCcrypteFonctions.lua
	luac -o ASCcrypteFonctions.luac ASCcrypteFonctions.lua

main.o : main.c cryptage.h
	gcc -c main.c -Wall -o main.o

cryptage.o : cryptage.c cryptage.h
	gcc -c cryptage.c -Wall -o cryptage.o

clean :
	rm -f *.o
	rm -f *.luac
	rm -f ASCcrypte

install : uninstall
	mkdir /usr/local/share/ASCcrypte
	cp ASCcrypte /usr/local/bin
	cp ASCcmpFonctions.luac /usr/local/share/ASCcrypte
	cp ASCcrypteFonctions.luac /usr/local/share/ASCcrypte

uninstall :
	rm -Rf /usr/local/share/ASCcrypte
	rm -f /usr/local/bin/ASCcrypte

