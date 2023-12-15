open Base

type player = O | X

(* --- Tools *)
let retrieve board y x = (* get a cell in the board *)
  match List.nth board y with
  | None -> '.'
  | Some line -> line
      |> Fn.flip List.nth x
      |> function | None -> '.' | Some c -> c

let get_ps board player y = (* get all position of player in certain columns *)
  board
  |> List.map ~f:(fun l -> List.nth l y)
  |> List.foldi ~init:[] ~f:(fun index acc e ->
      match e with
      | None -> acc
      | Some e' -> if Char.equal e' player then (index, y) :: acc else acc)
  |> List.rev

let get_connected board player y x = (* check cell have connection *)
  let ps = [
   (y, x - 1); (y, x + 1); (* left / right *)
   (y - 1, x); (y + 1, x); (* up left / down right *)
   (y - 1, x + 1); (y + 1, x - 1) (* up right / down left *)
  ] in
  List.filter ps ~f:(fun (y', x') -> Char.equal (retrieve board y' x') player)

let path_equal path path' = (* compare list of coordinate *)
  List.map2 path path' ~f:(fun (y1, x1) (y2, x2) -> y1 = y2 && x1 = x2)
  |> function
    | Ok l -> not (List.exists l ~f:(fun e -> Bool.equal e false))
    | Unequal_lengths -> false

let add_path board player stones = (* get connect coordinate for each element *)
  List.fold stones ~init:stones ~f:(fun acc (y, x) ->
    List.append acc (get_connected board player y x)) (* append connected *)
  |> List.dedup_and_sort ~compare:(fun (y1, x1) (y2, x2) ->
      if Int.(y1 <> y2) then y1 - y2 else x1 - x2) (* remove duplicate *)

let rec get_paths board player width stones =
  let stones' = add_path board player stones in
  if List.exists stones ~f:(fun (_, x) -> x = width) || path_equal stones stones'
  then stones
  else (get_paths board player width stones')

(* --- Algorithm *)
let compute board player =
  let width = List.nth_exn board 0 |> List.length |> Int.pred in
  let start_ps = get_ps board player 0 in (* get first row *)
  let end_ps = get_ps board player width in (* get last row *)
  let paths = get_paths board player width start_ps in (* get list of coord *)
  List.map end_ps ~f:(fun (y1, x1) -> (* check if end_ps is present in paths *)
    List.exists paths ~f:(fun (y2, x2) -> y1 = y2 && x1 = x2))
  |> List.exists ~f:(fun e -> Bool.equal e true)

(* --- Formating *)
let formatted line =
  line |> String.filter ~f:(fun c -> not (Char.equal c ' ')) |> String.to_list

let rotate board =
  board |> List.transpose_exn

(* --- MAIN *)
let connect board =
  board
  |> List.map ~f:formatted
  |> fun board' -> (compute board' 'X', compute (rotate board') 'O')
  |> function
    | (true, _) -> Some X
    | (_, true) -> Some O
    | _ -> None
