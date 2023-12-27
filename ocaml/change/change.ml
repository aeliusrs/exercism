open Base

(* Algo *)

let compare_list a b = Int.compare (List.length a) (List.length b)

let gen_pairs lst =
  List.concat_map lst ~f:(fun x -> List.map lst ~f:(fun y -> x, y))

(*let rec find_change acc amount coins =
  let coins = List.filter coins ~f:(fun coin -> coin <= amount) in
  if List.is_empty coins then [acc]
  else
    List.concat_map coins ~f:(fun v ->
      match amount - v with
      | 0 -> [[v] @ acc]
      | n when n < 0 -> [acc]
      | n -> find_change (v :: acc) n coins) *)

(* let compute_change target coins =
  find_change [] target coins
  |> List.dedup_and_sort ~compare:compare_list
  |> List.map ~f:List.rev
  |> List.hd
  |> function
    | Some lst -> Ok lst
    | None -> Error "can't make target with given coins" *)

let rec find_change acc amount coins =

let compute target coins =
  let pairs = List.cartersian_product coins coins in


(* Main *)
let make_change ~target ~coins =
  match target, coins with
  | 0, _                        -> Ok []
  | t, _ when t < 0             -> Error "target can't be negative"
  | _, []                       -> Error "can't make target with given coins"
  | t, c when t < List.hd_exn c -> Error "can't make target with given coins"
  | t, c                        -> compute_change t c
