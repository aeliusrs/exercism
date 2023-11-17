type nucleotide = A | C | G | T

let calculate a b =
  List.map2 (fun x y -> x = y) a b
  |> List.filter (fun x -> x = false)
  |> List.length

let hamming_distance a b =
  let alen = List.length a in
  let blen = List.length b in
  match alen, blen with
  | 0, n when n > 0   -> Error "left strand must not be empty"
  | n, 0 when n > 0   -> Error "right strand must not be empty"
  | n, m when n <> m  -> Error "left and right strands must be of equal length"
  | _, _ -> Ok (calculate a b)

