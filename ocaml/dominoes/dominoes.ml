open Base

type dominoe = (int * int)

(* TOOL FUNCTION *)
let rotate (x, y) = (y, x)

let exclude lst i = List.filteri lst ~f:(fun i' _ -> i <> i')

let can_connect a b = Int.equal (snd a) (fst b)

let sort_dominoes lst = List.sort lst ~compare:Poly.compare

(* CHECK FUNCTION *)
let check_loop lst =
  match (List.hd lst, List.last lst) with
  | Some a, Some b -> Int.equal (fst a) (snd b)
  | _ -> false

let check_chain lst =
  List.zip_exn lst (List.tl_exn lst @ [List.hd_exn lst])
  |> List.map ~f:(fun (a, b) -> can_connect a b)
  |> List.for_all ~f:(Bool.equal true)

(* ALGO FUNCTION *)
let find_connect hd lst =
  List.find lst ~f:(fun e -> can_connect hd e || can_connect hd (rotate e))
  |> function
    | None -> lst
    | Some e -> if can_connect hd e then [e] else [(rotate e)]

let rec build_chains acc = function
  | [] -> acc
  | lst ->
      let find = find_connect (List.last_exn acc) lst in
      let pool = List.filter lst ~f:(fun e -> not (
          List.exists find ~f:(fun f ->
            Poly.equal f e || Poly.equal (rotate f) e)))
      in
      build_chains (acc @ find) pool

(* MAIN *)
let chain = function
  | [] as lst -> Some lst
  | lst ->
    let len = List.length lst in
    let lst = sort_dominoes lst in
    List.mapi lst ~f:(fun i hd -> build_chains [hd] (exclude lst i))
    |> List.find ~f:(fun c ->
      (List.length c = len) && check_loop c && check_chain c)

