#include <stdlib.h>
#include <stdio.h>
#include <string.h>



int** table_decalage(char *m, int lm) {
    // On crée la table de décalage pour tous les caractères de notre alphabet
	int** table = calloc(lm, sizeof(int*));
	for (int j = 0; j < lm; j++) {
		table[j] = calloc(256, sizeof(int));
		for (int c = 0; c < 256; c++) {
			table[j][c] = -1;
		}
		for (int k = 0; k < j; k++) {
			char c = m[k];
			table[j][c] = k;
		}
	}
	return table;
}



void boyer_moore(char *m, char *t) {
	int lm = strlen(m), lt = strlen(t);
	int** table = table_decalage(m, lm);
	int occ = 0;
    // On parcourt le texte
	for (int i = 0; i <= lt - lm;) {
		int k = 0;
		// On compare la portion du texte au motif en partant de la fin
		for (int j = lm - 1; j >= 0; j--) {
			if (t[i + j] != m[j]) {
				char c = t[i + j];
				k = j - table[j][c];
				// k représente le nombre de décalage à effectuer
	 			break;
			}
		}
		if (k == 0) {
			printf("Occurrence à la position %d\n", i);
			occ++;
			k = 1;
		}
		// On se décale
		i += k;
		
	}
	printf("Il y a %d occurrences du motif dans le texte \n", occ);
}



int main() {
    // Test
    char* t = "GTTAGTAGCGTTAGCTGATCGCGGCGTAGCGTGCG";
    char* m = "GTAGCGT";

    printf("Texte : %s\n", t);
    printf("Motif : %s\n", m);

    boyer_moore(m,t);
    
    return 0;
}

