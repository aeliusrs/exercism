open Base

let retrieve board row col =
  match List.nth board col with
  | None -> ' '
  | Some line -> String.to_list line 
      |> Fn.flip List.nth row
      |> function | None -> ' ' | Some c -> c

let mark board row col =
  let indices = [
    row - 1, col - 1; row, col - 1; row + 1, col - 1; (* top columns *)
    row - 1, col; row + 1, col; (* current columns *)
    row - 1, col + 1; row, col + 1; row + 1, col + 1; (* bottoms columns *)
  ] in
  List.count indices ~f:(fun (row', col') ->
    Char.equal (retrieve board row' col') '*')
  |> function | 0 -> ' ' | n -> (Int.to_string n |> Char.of_string)

let annotate board =
  List.mapi board ~f:(fun col line ->
    String.mapi line ~f:(fun row c ->
      if Char.equal ' ' c then (mark board row col) else c))
