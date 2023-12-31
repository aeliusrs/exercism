let transform lst = let open Base in
  List.concat_map lst ~f:(fun (n, sublst) ->
      List.map sublst ~f:(fun c -> (Char.lowercase c, n) ))
  |> List.sort ~compare:Poly.compare
