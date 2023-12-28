open Base


(* Algo *)
let get_pairs range coins =
  List.cartesian_product range coins
  |> List.map ~f:(fun (a,c) -> if a - c >= 0 then (a, c) else (a, -1))
  |> List.filter ~f:(fun (_, c) -> c >= 0)

let find_path pairs value =
  let dp = Array.create ~len:(value + 1) Int.max_value in
  let acc = Array.create ~len:(value + 1) [] in
  dp.(0) <- 0;

  Base.List.iter pairs ~f:(fun (_, coin) ->
    Base.List.iter (List.range coin (value + 1)) ~f:(fun i ->
        if i - coin >= 0 then begin
          dp.(i) <- min dp.(i) (dp.(i - coin) + 1);
          if dp.(i) < Int.max_value then
            acc.(i) <- coin :: acc.(i - coin)
        end
    ));

  acc
  List.rev acc.(value)

let comput target coins =
    let step = Array.make (target + 1) Int.max_int in
    let acc = Array.make (target + 1) [] in
    let range = List.init target
    let g counter x = if counter >= x && sub.(counter-x) != Int.max_int
        then (1 + sub.(counter-x), x::sel.(counter-x))
        else (Int.max_int, []) in
    sub.(0) <- 0;
    for counter = 1 to target do 
        let g1 m x = cmin (g counter x) m in
        let v, o  = List.fold_left g1 (Int.max_int, []) coins in
        sub.(counter) <- v;
        sel.(counter) <- o; 
        done;
    sub.(target), sel.(target);;


let compute_change target coins =
  let coins = List.filter coins ~f:(fun c -> c <= target) in
  let range = List.init (Int.succ target) ~f:Fn.id in
  let pairs = get_pairs range coins in
  match find_path pairs target with
  | [] -> Error "can't make target with given coins"
  | lst -> Ok (List.rev lst)

(* Main *)
let make_change ~target ~coins =
  match target, coins with
  | 0, _                        -> Ok []
  | t, _ when t < 0             -> Error "target can't be negative"
  | _, []                       -> Error "can't make target with given coins"
  | t, c when t < List.hd_exn c -> Error "can't make target with given coins"
  | t, c                        -> compute_change t c
