open Base

type base = int

let valid digits from =
  List.filter digits ~f:(function
      | n when n >= 0 && n < from -> false
      | _ -> true)
  |> List.is_empty

let convert_bases ~from ~digits ~target =
  match from > 1 && target > 1 && valid digits from with
  | false -> None
  | true ->
    digits
    |> List.fold ~init:0 ~f:(fun acc n -> (acc * from) + n)
    |> fun n ->
        Sequence.unfold ~init:n ~f:(function
          | s when s <= 0 -> None
          | s -> Some(s % target, s / target)
        )
    |> Sequence.to_list_rev
    |> function | [] -> Some [0] | lst -> Some lst
