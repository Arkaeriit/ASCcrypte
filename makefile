
ASCcrypte : main.o cryptage.o ASCcmpFonctions.luac ASCcrypteFonctions.luac
	gcc main.o cryptage.o -llua -ldl -lm -o ASCcrypte

main.o : main.c cryptage.h
	gcc -c main.c -Wall -o main.o

cryptage.o : cryptage.c cryptage.h
	gcc -c cryptage.c -Wall -o cryptage.o

ASCcmpFonctions.luac : ASCcmpFonctions.lua
	luac -o ASCcmpFonctions.luac ASCcmpFonctions.lua 

ASCcrypteFonctions.luac : ASCcrypteFonctions.lua
	luac -o ASCcrypteFonctions.luac ASCcrypteFonctions.lua 

clean :
	rm -f *.o
	rm -f ASCcrypte
	rm -f *.luac
