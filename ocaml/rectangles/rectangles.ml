open Base

let sanitize arr = Array.to_list arr |> List.map ~f:String.to_list

(* TODO ADD MORE CHECKING FOR THE INDEX... *)

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

(* Collect coordinate of all corners *)
let get_corners board =
  List.concat_mapi board ~f:(fun x str ->
    List.foldi str ~init:[] ~f:(fun y acc c ->
      if Char.equal c '+' then (x, y) :: acc else acc))

(* REFACTO TO BE MORE READABLE *)
let count_rectangles arr =
  let board = sanitize arr in
  let corners = get_corners board in
  List.filter corners ~f:(fun top_left ->
    List.exists corners ~f:(fun bot_right ->
      Poly.compare top_left bot_right < 0 &&
      let bot_left = (bot_right |> fst, top_left |> snd) in
      let top_right = (top_left |> fst, bot_right |> snd) in
      List.mem corners top_right ~equal:Poly.equal &&
      List.mem corners bot_left ~equal:Poly.equal &&
      is_row board (fst top_left) (snd top_left) (snd bot_right) &&
      is_row board (fst bot_right) (snd top_left) (snd bot_right) &&
      is_col board (snd top_left) (fst top_left) (fst bot_right) &&
      is_col board (snd bot_right) (fst top_left) (fst bot_right)
    )
  )
  |> List.length

