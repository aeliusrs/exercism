open Base

let pick (s,lst) (s', lst') = if s <= s' then (s, lst) else (s', lst')

let init_step = function | 0 -> (0, []) | _ -> (Int.max_value, [])

let get i coin step = (* get function *)
  if i >= coin && fst step.(i - coin) <> Int.max_value then
    (1 + fst step.(i - coin), coin :: snd step.(i - coin))
  else (Int.max_value, [])

(* Algo *)
let find_change target coins =
  let step = Array.init (Int.succ target) ~f:init_step in
  let range = List.init target ~f:Int.succ in
  List.iter range ~f:(fun i ->
    let v =
      List.fold coins ~init:(Int.max_value, []) ~f:(fun acc coin -> pick (get i coin step) acc)
      in
        step.(i) <- v;);
   step.(target)

let compute_change t c =
  match find_change t (List.rev c) with
  | (i, _) when i = Int.max_value -> Error "can't make target with given coins"
  | (_, lst) -> Ok (List.sort lst ~compare:Int.compare)

(* Main *)
let make_change ~target ~coins =
  match target, coins with
  | 0, _                        -> Ok []
  | t, _ when t < 0             -> Error "target can't be negative"
  | _, []                       -> Error "can't make target with given coins"
  | t, c when t < List.hd_exn c -> Error "can't make target with given coins"
  | t, c                        -> compute_change t c
