open Base

let is_valid c = Char.is_alphanum c || Char.equal c ' ' || Char.equal c '\''

let clean w = w
    |> String.lowercase
    |> String.chop_prefix_if_exists ~prefix:"'"
    |> String.chop_suffix_if_exists ~suffix:"'"

let preprocess txt =
  txt
  |> String.map ~f:(fun c -> if is_valid c then c else ' ')
  |> String.split ~on:' '
  |> List.filter_map ~f:(fun w ->
      match String.is_empty w with
      | true -> None
      | false -> Some (clean w , 1)
  )

let word_count txt =
  txt
  |> preprocess
  |> Map.of_alist_fold (module String) ~init:0 ~f:(+)
