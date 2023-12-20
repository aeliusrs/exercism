open Base

let get_values n =
  let minus = Int.to_string (Int.pred n) in
  let current = Int.to_string n in
  match n with
  | 2 -> (current ^ " bottles", "Take one down and pass it around, ", minus ^ " bottle")
  | 1 -> (current ^ " bottle", "Take it down and pass it around, ",  "no more bottles")
  | 0 -> ("No more bottles", "Go to the store and buy some more, ", "99 bottles")
  | _ -> (current ^ " bottles", "Take one down and pass it around, ", minus ^ " bottles")

let get_line n =
  let (top, take, bottom) = get_values n in
  top ^ " of beer on the wall, " ^ String.lowercase top ^ " of beer.\n"
  ^ take ^ bottom ^ " of beer on the wall."

let recite from until =
  Sequence.unfold ~init:(from, until) ~f:(fun (from', until') ->
    if until' <= 0 || from' < 0 then None
    else Some (get_line from', (Int.pred from', Int.pred until')))
  |> Sequence.fold ~init:"" ~f:(fun acc str -> acc ^ str ^ "\n\n")
  |> String.strip
