open Base

type t = { game: int list; frames: int }

let get_last_frame = function
  | a :: b :: _ -> (a, b)
  | a :: _ -> (a, 0)
  | _ -> (0, 0)

let rec count acc i lst =
  if i < 10 then
    match lst with (* strike / spare / open / error *)
    | 10 :: (b :: c :: _ as rest) -> count (acc + 10 + b + c) (Int.succ i) rest
    | a :: b :: (c :: _ as rest) when a + b = 10 ->
        count (acc + 10 + c) (Int.succ i) rest
    | a :: b :: rest when a + b < 10 -> count (acc + a + b) (Int.succ i) rest
    | _ :: _ | [] -> Error "Score cannot be taken until the end of the game"
  else Ok acc

let new_game : t = { game = []; frames = 0 }

let score { game; _ } = count 0 0 (List.rev game)

let roll throw {game; frames} =
  match throw, frames, get_last_frame game with
  | t, _, _       when t < 0 -> Error "Negative roll is invalid"
  | t, _, _       when t > 10 -> Error "Pin count exceeds pins on the lane"
  | t, f, (a, _)  when f < 18 && (Int.rem f 2 <> 0) && (a + t > 10)->
      Error "Pin count exceeds pins on the lane"
  | t, 20, (a, 10) when a < 10 && (a + t > 10) ->
      Error "Pin count exceeds pins on the lane"
  | _, f, _       when f > 20 -> Error "Cannot roll after game is over"
  | _, 20, (a, b) when a + b < 10 -> Error "Cannot roll after game is over"
  | t, f, _       when t = 10 && (Int.rem f 2 = 0) && f < 18 -> (* Strike *)
      Ok {game = t :: game; frames = f + 2 }
  | _ -> Ok {game = throw :: game; frames = frames + 1 } (* Open *)
