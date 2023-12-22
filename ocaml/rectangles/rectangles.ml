open Base

(* transform the given array to a list of list of char *)
let sanitize arr = Array.to_list arr |> List.map ~f:String.to_list

(* exclude element at index i from a list *)
let exclude lst i = List.filteri lst ~f:(fun i' _ -> i <> i')

(* collect all char '+', AKA corners *)
let collect_corners board =
  List.concat_mapi board ~f:(fun x row ->
    List.foldi row ~init:[] ~f:(fun y acc c ->
      if Char.equal c '+' then acc @ [(x, y)]  else acc))

(* exclude top_left from the list, and reverse order *)
let generate_pairs tl i lst =
  exclude lst i
  |> List.filter ~f:(fun e -> fst tl < fst e && snd tl < snd e)
  |> List.rev
  |> List.map ~f:(fun br -> (tl, br))

(* check that all element in a row are valid *)
let is_row board row_idx start_idx end_idx =
  List.nth board row_idx
  |> function | None -> false | Some l ->
     List.sub l ~pos:start_idx ~len:(end_idx - start_idx + 1)
     |> List.for_all ~f:(fun c -> Char.equal c '-' || Char.equal c '+')

(* check that all element in take sub col are valid *)
let is_col board col_idx start_idx end_idx =
  board
  |> List.transpose_exn
  |> Fn.flip List.nth col_idx
  |> function | None -> false | Some l ->
     List.sub l ~pos:start_idx ~len:(end_idx - start_idx + 1)
     |> List.for_all ~f:(fun c -> Char.equal c '|' || Char.equal c '+')

(* generate top_right and bottom left coord
   then check the connection between them are valid *)
let is_rectangle board tl br =
  is_row board (fst tl) (snd tl) (snd br) &&
  is_row board (fst br) (snd tl) (snd br) &&
  is_col board (snd tl) (fst tl) (fst br) &&
  is_col board (snd br) (fst tl) (fst br)

(* collect, generate needed coordinate and possible match, and apply
   is_rectangle to get a list of bool, then count number of bool *)
let get_rectangles board =
  collect_corners board
  |> fun lst -> List.concat_mapi lst ~f:(fun i tl -> generate_pairs tl i lst)
  |> List.map ~f:(fun (tl, br) -> is_rectangle board tl br |> Bool.to_int)
  |> List.fold ~init:0 ~f:(+)

let count_rectangles board = sanitize board |> get_rectangles
