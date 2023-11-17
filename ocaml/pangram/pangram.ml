let is_pangram str = let open Base in
  String.init 26 ~f:(fun i -> 97 + i |> Char.of_int_exn)
  |> String.filter ~f:(fun c -> String.mem (String.lowercase str) c |> not)
  |> String.is_empty
