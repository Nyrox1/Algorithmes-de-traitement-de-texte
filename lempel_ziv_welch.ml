(* On va appliquer notre algorithme sur des séquences ADN *)
(* On peut généraliser le code pour un texte sur l'alphabet ASCII *)


let compresser msg =
  let len = String.length msg in
  if len = 0 then []
  else
    (* Création du dictionnaire *)
    (* On lui donne une taille initiale de 512 *)
    let dict = Hashtbl.create 512 in
    
    (* Initialisation avec les 4 bases ADN *)
    Hashtbl.add dict "A" 0;
    Hashtbl.add dict "T" 1;
    Hashtbl.add dict "G" 2;
    Hashtbl.add dict "C" 3;
    
    (* Le prochain code disponible est maintenant 4 *)
    let prochain_code = ref 4 in
    let acc_code = ref [] in
    let w = ref (String.make 1 msg.[0]) in
    
    (* Boucle sur le reste du texte *)
    for j = 1 to len - 1 do
      let c = String.make 1 msg.[j] in
      let wc = !w ^ c in
      
      if Hashtbl.mem dict wc then
        w := wc
      else begin
        acc_code := Hashtbl.find dict !w :: !acc_code;
        
        Hashtbl.add dict wc !prochain_code;
        incr prochain_code;
        w := c
      end
    done;
    
    (* On n'oublie pas d'ajouter le code du dernier morceau restant *)
    acc_code := Hashtbl.find dict !w :: !acc_code;
    
    (* On remet la liste dans le bon sens car on a accumulé par le début *)
    List.rev !acc_code



let decompresser codes =
  match codes with
  | [] -> ""
  | h :: q ->
      (* Initialisation identique avec les 4 bases ADN *)
      let dict = Hashtbl.create 512 in
      Hashtbl.add dict 0 "A";
      Hashtbl.add dict 1 "T";
      Hashtbl.add dict 2 "G";
      Hashtbl.add dict 3 "C";
      
      (* Le prochain code attendu est bien 4 *)
      let prochain_code = ref 4 in
      let w = ref (Hashtbl.find dict h) in
      let acc_text = ref [!w] in
      
      List.iter (fun k ->
        let code =
          if Hashtbl.mem dict k then
            Hashtbl.find dict k
          else if k = !prochain_code then
            !w ^ (String.make 1 !w.[0])
          else
            failwith "Code de compression invalide"
        in
        
        acc_text := code :: !acc_text;
        Hashtbl.add dict !prochain_code (!w ^ (String.make 1 code.[0]));
        incr prochain_code;
        w := code
      ) q;
      
      String.concat "" (List.rev !acc_text)



(* Test *)
let () =
  let gene = "ATGCGATCGATCGATCGATAGCGCGTATATAGCGCGCGATCGATC" in
  let gene_compresse = compresser gene in
  Printf.printf "Gène : %s\n" gene;
  Printf.printf "Codes LZW : ";
  List.iter (Printf.printf "%d ") gene_compresse;
  print_newline ();

  let gene_decommpresse = decompresser gene_compresse in
  Printf.printf "Séquence ADN reconstruite : %s\n" gene_decommpresse;
