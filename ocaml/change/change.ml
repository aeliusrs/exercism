open Base

let pick a b = if Poly.compare a b < 0 then a else b

let init_step = function | 0 -> (0, []) | _ -> (Int.max_value, [])

let update i coin step = (* get function *)
  if i >= coin && fst step.(i - coin) <> Int.max_value then
    (1 + fst step.(i - coin), coin :: snd step.(i - coin))
  else (Int.max_value, [])

let find_coin i coins step = (* fold on coins *)
  List.fold coins ~init:(Int.max_value, []) ~f:(fun acc coin ->
    pick (update i coin step) acc)

(*
   init memoize array
   init a range from 1 to target, for each, fold on coins and try
   to find best one
*)
let compute_change target coins =
  let step = Array.init (Int.succ target) ~f:init_step in
  let range = List.init target ~f:Int.succ in
  List.iter range ~f:(fun i -> step.(i) <- (find_coin i coins step));
  match step.(target) with
  | (v, _) when v = Int.max_value -> Error "can't make target with given coins"
  | (_, lst) -> Ok (List.sort lst ~compare:Int.compare)

(* Main *)
let make_change ~target ~coins =
  match target, coins with
  | 0, _                        -> Ok []
  | t, _ when t < 0             -> Error "target can't be negative"
  | _, []                       -> Error "can't make target with given coins"
  | t, c when t < List.hd_exn c -> Error "can't make target with given coins"
  | t, c                        -> compute_change t c
