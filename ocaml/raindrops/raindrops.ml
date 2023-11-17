let raindrop num = let open Base in [(3, "Pling");(5, "Plang");(7, "Plong")]
  |> List.fold ~f:(fun acc (i, s) -> if num % i = 0 then acc ^ s else acc) ~init:""
  |> function "" -> Int.to_string num | s -> s
