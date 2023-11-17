open Base

let empty = Map.empty (module Char)

let is_not_nucl c = not (String.mem "AGCT" c)
let is_valid s = String.find s ~f:(fun e -> is_not_nucl e)

let count_nucleotide s c =
    match (is_not_nucl c), (is_valid s) with
    | true, _ -> Error c
    | false, Some n -> Error n
    | false, None -> Ok (String.count s ~f:(fun e -> Char.equal e c))


let count_nucleotides s =
  String.fold_until s
  ~init:empty
  ~f:(fun acc c ->
    match count_nucleotide s c with
    | Error _ as e -> Stop e
    | Ok 0 -> Continue acc
    | Ok v -> Continue (Map.set acc ~key:c ~data:v))
  ~finish:(fun map -> Ok map)
