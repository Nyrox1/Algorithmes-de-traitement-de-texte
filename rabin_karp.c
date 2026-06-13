#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <assert.h>



uint64_t B = 256;
uint64_t P = 1869461003;



// Fonction de puissance modulaire
uint64_t exp_mod(uint64_t base, uint64_t exp, uint64_t mod) {
    uint64_t res = 1;
    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (__uint128_t)res * base % mod;
        base = (__uint128_t)base * base % mod;
        exp /= 2;
    }
    return res;
}



// Fonction de hachage
uint64_t hash(char *s, int len) {
    uint64_t h = 0;
    for (int i = 0; i < len; i++) {
        char c = s[i];
        h = (h * B + c) % P;
    }
    return h;
}



int rabin_karp(char *m, char *t) {
    int lm = strlen(m), lt = strlen(t);
    assert(lm > 0);
    if (lt < lm) return 0;
    uint64_t sh = exp_mod(B, lm - 1, P);
    uint64_t hm = hash(m, lm);
    uint64_t ht = hash(t, lm);
    /* On ne calcule les hash qu'une seule fois afin de gagner 
    en complexité temporelle */
    int cpt = 0;
    for (int i = 0; true; i++) {
        if (ht == hm && strncmp(t + i, m, lm) == 0) {
            printf("-> Occurrence trouvée à la position %d\n", i);
            cpt++;
        }
        if (i == lt - lm) break;
        char ci = t[i];
        ht = (ht + P - (ci * sh) % P) % P; 
        char c = t[i + lm];
        ht = (ht * B + c) % P;
        /* On recalcule le hash de la partie du texte à partir de la 
        partie précedente pour gagner en complexité temporelle */
    }
    return cpt;
}



int main() {
    // Test

    char* t1 = "ABRACADABRA";
    char* m1 = "ABRA";
    int res1 = rabin_karp(m1, t1);
    printf("%d occurrences trouvées (Attendu : 2)\n\n", res1);

    char* t2 = "AAAAA";
    char* m2 = "AAA";
    int res2 = rabin_karp(m2, t2);
    printf("%d occurrences trouvées (Attendu : 3)\n\n", res2);

    char* t3 = "Hello World !";
    char* m3 = "Bonjour";
    int res3 = rabin_karp(m3, t3);
    printf("%d occurrences trouvées (Attendu : 0)\n\n", res3);

    char* t4 = "Chat";
    char* m4 = "Chatons";
    int res4_2 = rabin_karp(m4, t4);
    printf("Résultat motif trop long : %d (Attendu : 0)\n\n", res4_2);

    return 0;
}
