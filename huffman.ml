(* Définition du type de l'arbre de Huffman 
  Pour une feuille, on stocke la fréquence d'apparition du caractère
  Un noeud stocke la somme des fréquences des feuilles de son sous arbre *)
type arbre_huffman =
  | Leaf of char * int
  | Node of int * arbre_huffman * arbre_huffman



(* Fonction utilitaire pour obtenir la fréquence d'un nœud *)
let freq = function
  | Leaf (_, w) -> w
  | Node (w, _, _) -> w



(* Calcul des fréquences des caractères *)
let cmpt_frequence str =
  let freq_dico = Hashtbl.create 256 in
  String.iter (fun c ->
    let count = try Hashtbl.find freq_dico c with Not_found -> 0 in
    Hashtbl.replace freq_dico c (count + 1)
  ) str;
  Hashtbl.fold (fun c w acc -> Leaf (c, w) :: acc) freq_dico []



(* Construction de l'arbre de Huffman *)
let constr_arbre feuilles =
  let compare_arbre t1 t2 = compare (freq t1) (freq t2) in
  let rec constr_queue = function
    | [] -> failwith "Impossible de construire un arbre vide"
    | [t] -> t
    | t1 :: t2 :: q ->
        let p = Node (freq t1 + freq t2, t1, t2) in
        constr_queue (List.sort compare_arbre (p :: q))
  in constr_queue (List.sort compare_arbre feuilles)



(* Génération de la table de codage (dictionnaire de bits) *)
let constr_table arbre =
  let rec aux noeud prefixe acc =
    match noeud with
    | Leaf (c, _) -> (c, List.rev prefixe) :: acc
    | Node (_, g, d) ->
        let acc_g = aux g (0 :: prefixe) acc in
        aux d (1 :: prefixe) acc_g
  in aux arbre [] []



(* Compression de la chaîne de caractères *)
let compresser str table =
  let caract c = List.assoc c table in
  let rec encodage i acc =
    if i < 0 then acc
    else encodage (i - 1) (caract str.[i] @ acc)
  in encodage (String.length str - 1) []



(* Test *)
let () =
  let message = "huffman en ocaml" in
  print_endline ("Message d'origine : " ^ message);

  let frequence = cmpt_frequence message in
  let arbre = constr_arbre frequence in
  let table = constr_table arbre in
  let msg_compresse = compresser message table in

  print_string "Message compressé : ";
  List.iter print_int msg_compresse;
  print_newline ()