open Base

let preprocess txt =
  let is_valid c =
    Char.is_alphanum c || Char.equal c ' ' || Char.equal c '\''
  in
  txt
  |> String.lowercase
  |> String.map ~f:(fun c -> if is_valid c then c else ' ')
  |> String.split ~on:' '
  |> List.filter ~f:(fun s -> not(String.is_empty s))
  |> List.map ~f:(fun w ->
      w
      |> String.chop_prefix_if_exists ~prefix:"'"
      |> String.chop_suffix_if_exists ~suffix:"'"
  )

let word_count txt =
  preprocess txt
  |> List.fold
    ~init:(Map.empty (module String))
    ~f:(fun acc word ->
      Map.update acc word ~f:(function
        | Some count -> count + 1
        | None -> 1
      )
    )

