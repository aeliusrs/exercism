open Base

type player = O | X

(* --- tool *)
let formatted line = (* to format the input *)
  line
  |> String.filter ~f:(fun c -> not (Char.equal c ' '))
  |> String.to_list

let rotate board = (* rotate 90deg the matrix *)
  board
  |> List.transpose_exn
  |> List.map ~f:List.rev

(* --- Algorithm *)

let retrieve board y x =
  match List.nth board y with
  | None -> '.'
  | Some line -> line
      |> Fn.flip List.nth x
      |> function | None -> '.' | Some c -> c

let get_connected board player y x = (* check player is connected *)
  let indices = [
   (y, x - 1); (y, x + 1); (* left / right *)
   (y - 1, x); (y + 1, x); (* up left / down right *)
   (y - 1, x + 1); (y + 1, x - 1) (* up right / down left *)
  ] in
  List.filter indices ~f:(fun (y', x') ->
    Char.equal (retrieve board y' x') player)

let compute board player =
    get_ps board player 0

(* --- MAIN *)
let connect board =
  board
  |> List.map ~f:formatted

  |> fun board' -> (compute board' 'X', compute (rotate board') 'O')
  |> function
    | (true, _) -> Some X
    | (_, true) -> Some O
    | _ -> None
