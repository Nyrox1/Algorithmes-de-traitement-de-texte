# Algorithmes de traitement de texte

Implémentation d'algorithmes de traitement de texte (Boyer-Moore, Huffman, Lempel-Ziv-Welch et Rabin-Karp) utilisés pour la **recherche de motifs** dans un texte et la **compression** de texte.

---

## 📝 Sommaire

1. 🔎 Boyer-Moore (C)
2. 📦 Huffman (OCaml)
3. 📦 Lempel-Ziv-Welch (OCaml)
4. 🔎 Rabin-Karp (C)

---

## 🔎 Boyer-Moore

📁 Fichier : `boyer_moore.c`  
💻 Langage : C

### Description

L’algorithme de Boyer-Moore est efficace pour la recherche de motifs. Il saute intelligemment des portions de texte en utilisant deux heuristiques : **bad character** et **good suffix**.

### Fonctionnalités

- Recherche rapide d’un motif dans une chaîne
- Optimisation basée sur la connaissance du motif

### Complexité

On note $n$ la longueur du texte, $m$ la longueur du motif et $\Sigma$ l'alphabet.

- **Meilleur cas** : $O(n/m)$ 
- **Pire cas** : $O(n \times m)$
- **Pré-traitement** : $O(m+|\Sigma|)$
- **Spatiale** : $O(|\Sigma|)$ (table de sauts)



### Compilation et Exécution

```bash
ocamlc boyermoore.c -o bm
./bm
```

---



## 📦 Huffman

📁 Fichiers : `huffman.ml`  
💻 Langage : OCaml

### Description

L’algorithme de Huffman est un algorithme de compression sans perte qui construit un **arbre binaire de codage** à partir des fréquences des caractères.

### Fonctionnalités

- Construction d’un arbre de Huffman
- Encodage basé sur les fréquences

### Complexité

On note $n$ la longueur du texte et $\Sigma$ l'alphabet.


- **Temporelle** : $O(n +|\Sigma| \log |\Sigma|)$
- **Spatiale** : $O(|\Sigma|)$ (stocker la table)


### Compilation et Exécution

```bash
ocamlc huffman.ml -o huffman
./huffman
```


---

## 📦 Lempel-Ziv-Welch

📁 Fichiers : `lempel_ziv_welch.ml`
💻 Langage : OCaml

### Description

L’algorithme de Lempel-Ziv-Welch est un algorithme de compression sans perte et **online** qui construit un dictionnaire de chaînes de caractères à partir des motifs rencontrés au fur et à mesure de la lecture du texte.

### Fonctionnalités

- Construction d’un dictionnaire de chaînes de caractères qui est enrichit au fur et à mesure
- **Online** : Compresse les données à la volée sans avoir besoin de stocker le texte 

### Complexité

On note $n$ la longueur du texte.

- **Complexité** : $O(n)$


### Compilation et Exécution

```bash
gcc lempel_ziv_welch.ml -o lzw 
./lzw
```

---

## 🔎 Rabin-Karp

📁 Fichier : `rabin_karp.c`  
💻 Langage : C

### Description

L’algorithme de Rabin-Karp utilise une fonction de **hachage** pour rechercher un motif dans un texte. Il est optimisé pour détecter rapidement les correspondances en comparant des **valeurs de hachage** plutôt que les chaînes elles-mêmes.

### Fonctionnalités

- Recherche d’un motif dans un texte en se basant sur les valeurs de hachage
- Calcul optimisé des valeurs de hachage
- Affichage de la position du motif s’il est trouvé

### Complexité

On note $n$ la longueur du texte et $m$ la longueur du motif.

- **Meilleur cas** : $O(n + m)$ 
- **Pire cas** : $O(n \times m)$
- **Spatiale** : $O(1)$ 

### Compilation et Exécution

```bash
gcc rabinkarp.c -o rk
./rk
```

---

