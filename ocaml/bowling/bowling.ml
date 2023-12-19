open Base

type t = { game: int list; frames: int }


(* tool *)
let is_strike pins = (pins = 10)

let is_frame_start f = (Int.rem f 2 = 0)

let is_last_frame f = (f > 18 && f < 21)

let is_pin_overflow a b = (a + b > 10)

let count_points game =
  game
  |> List.map ~f:(fun lst -> List.fold ~init:0 lst ~f:(+))
  |> List.fold ~init:0 ~f:(+)

(* algo *)
let new_game : t = { game = []; frames = 0 }

let roll throw {game; frames} =
  match game, frames, throw with
  | _, _, n when n < 0 -> Error "Negative roll is invalid"
  | _, _, n when n > 10 -> Error "Pin count exceeds pins on the lane"
  | [], 0, 10 -> Ok {game = [10;0]; frames = 2} (* begin strike *)
  | [], 0, n -> Ok {game = [n]; frames = 1} (* begin open *)
  | hd :: sd :: _, 20, _ when (* last frame *)
      not(is_strike sd) && not(is_strike (hd + sd)) ->
        Error "Cannot roll after game is over"
  | hd :: sd :: _, 20, n when (* last frame *)
      is_pin_overflow hd n && not(is_strike (hd + sd)) ->
        Error "Pin count exceeds pins on the lane"
  | g, f, 10 when f < 18 -> Ok { game = 10 :: 0 :: g; frames = f + 2 } (* normal strike *)
  | g, f, 10 -> Ok { game = 10 :: 0 :: g; frames = f + 1 } (* normal strike *)
  | hd :: _, f, n when
      is_frame_start f && not(is_strike hd) && is_pin_overflow hd n ->
      Error "Pin count exceeds pins on the lane"
  | g, f, n -> Ok { game = n :: g; frames = f + 1 } (* normal open *)

let score { game; frames } =
  match game, frames with
  | hd :: sd :: _, f when is_strike (hd + sd) && is_last_frame f ->
      Error "Score cannot be taken until the end of the game"
  | hd :: _, f when is_strike hd && is_last_frame f ->
      Error "Score cannot be taken until the end of the game"
  | _, f when f < 20 ->
      Error "Score cannot be taken until the end of the game"
  | g, _ -> Ok (List.chunks_of ~length:2 g |> count_points)


