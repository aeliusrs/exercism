open Base

(* ----------------------- TOOL *)

(* exclude element at index i in a list *)
let exclude lst i = List.filteri lst ~f:(fun i' _ -> i <> i')

let rotate (x, y) = (y, x)

let can_connect a b = Int.equal (snd a) (fst b)

(* check that all element in a row are valid *)
let is_row board row_idx start_idx end_idx =
  let board_height = List.length board in
  if row_idx < 0 || row_idx >= board_height then
    false
  else
    board
    |> Fn.flip List.nth_exn row_idx
    |> List.sub ~pos:start_idx ~len:(end_idx - start_idx)
    |> List.for_all ~f:(fun c -> Char.equal c '-' || Char.equal c '+')

(* check that all element in take sub col are valid *)
let is_col board col_idx start_idx end_idx =
  let board_height = List.length board in
  if start_idx < 0 || start_idx > board_height || end_idx >= board_height then
    false
  else
    board
    |> List.transpose_exn
    |> Fn.flip List.nth_exn col_idx
    |> List.sub ~pos:start_idx ~len:(end_idx - start_idx)
    |> List.for_all ~f:(fun c -> Char.equal c '|' || Char.equal c '+')

(* ----------------------- get COORDINATE *)
let collect_corners board =
  List.concat_mapi board ~f:(fun x str ->
    List.foldi str ~init:[] ~f:(fun y acc c ->
      if Char.equal c '+' then (x, y) :: acc else acc))

let validate_corners board hd lst =
  lst
  |> List.filter ~f:(fun e -> Poly.compare hd e <= 0)
  |> List.filter ~f:(fun e ->
      match hd, e with
      | (x, y), (x', y') when x <= x' && y <= y' ->
          is_row board x y y' && is_col board y x x'
      | _ -> false)

(* Collect all '+' knows as corners
   Sort the list
   Generate List of sublist for each coordinate of corners
   apply validate_corners to check the connection are valid character
   Filter to keep only the coordinate that have 4 or more connection *)
let get_corners board =
  collect_corners board
  |> List.sort ~compare:Poly.compare
  |> fun lst -> List.mapi lst ~f:(fun i hd -> hd :: (exclude lst i))
  |> List.map ~f:(fun lst ->
      let hd = List.hd_exn lst in (validate_corners board hd lst))
  |> List.filter ~f:(fun l -> (List.length l) > 3)

let compute lst =
  List.map lst ~f:(function | [] -> [] | (hd :: tl) as l ->
      build_chains [hd] l
      |> List.tl_exn
      |> List.chunks_of ~length:4
      |> List.filter ~f:(fun l' -> List.length l' > 3))
  |> List.concat


(* ----------------------- MAIN *)
let sanitize arr = Array.to_list arr |> List.map ~f:String.to_list

let count_rectangles board = sanitize board |> get_corners |> compute
