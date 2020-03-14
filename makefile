FLAGS = -Wall -g
LUA = -llua -lm -ldl

ASCcrypte : main.o cryptage.o rng.o hash.o compress.o gestionFS.o correction.o ASCcmpFonctions.luac ASCcrypteFonctions.luac RAMusage.luac
	gcc main.o cryptage.o correction.o rng.o hash.o compress.o gestionFS.o $(FLAGS) $(LUA) -o ASCcrypte

test.bin : test.o cryptage.o rng.o hash.o compress.o gestionFS.o correction.o ASCcmpFonctions.luac ASCcrypteFonctions.luac RAMusage.luac
	gcc test.o cryptage.o correction.o rng.o hash.o compress.o gestionFS.o $(FLAGS) $(LUA) -o test.bin

ASCcmpFonctions.luac : ASCcmpFonctions.lua
	luac -o ASCcmpFonctions.luac ASCcmpFonctions.lua

ASCcrypteFonctions.luac : ASCcrypteFonctions.lua
	luac -o ASCcrypteFonctions.luac ASCcrypteFonctions.lua

RAMusage.luac : RAMusage.lua
	luac -o RAMusage.luac RAMusage.lua

main.o : main.c
	gcc -c main.c $(FLAGS) -o main.o

test.o : test.c
	gcc -c test.c $(FLAGS) -o test.o

compress.o : compress.c compress.h
	gcc -c compress.c $(FLAGS) -o compress.o

cryptage.o : cryptage.c cryptage.h
	gcc -c cryptage.c $(FLAGS) -o cryptage.o

rng.o : rng.c rng.h
	gcc -c rng.c $(FLAGS) -o rng.o

hash.o : hash.c hash.h
	gcc -c hash.c $(FLAGS) -o hash.o

correction.o : correction.c correction.h
	gcc -c correction.c $(FLAGS) -o correction.o

gestionFS.o : gestionFS.c gestionFS.h
	gcc -c gestionFS.c $(FLAGS) -o gestionFS.o

test : test.bin
	./test.bin

clean :
	rm -f *.o
	rm -f *.luac
	rm -f ASCcrypte
	rm -f out*

install : 
	mkdir -p /usr/local/share/ASCcrypte
	cp -f ASCcrypte /usr/local/bin
	cp -f ASCcmpFonctions.luac /usr/local/share/ASCcrypte
	cp -f ASCcrypteFonctions.luac /usr/local/share/ASCcrypte
	cp -f RAMusage.luac /usr/local/share/ASCcrypte

uninstall :
	rm -Rf /usr/local/share/ASCcrypte
	rm -f /usr/local/bin/ASCcrypte

