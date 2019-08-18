/*--------------------------------------------------------------------\
|Ces fonctions servent à générer des nombres psedo-aléatoires.        |
|Pour que les mot de passe puissent décripter il est capital que      |
|ce ne soir pas du vrais hasard. Les algorithme xorshift et xoshiro** |
|sont assez bon pour ce que l'on veut (on cherche à générer une petite|
|quantité de nombres cahotiques) et le fait que le cripatage passe par|
|des xor les rend joliement appropriés.                               |
\--------------------------------------------------------------------*/

#include <stdint.h>

typedef uint64_t XOSHIROetat [4];

uint64_t xorshift_rand(uint64_t seed); //Renvoie un nombre aléatoire calculé à partir d'un xorshift.
void XOSHIRO_seed(uint64_t seed); //initialise le rng
void XORISHO_rand(); //renvoie un nombre aléatoire calculé à partir du xoshiro**

unsigned int minirand(unsigned int max); //calcule rapidement un entier naturel aléatoire inférieur à max

