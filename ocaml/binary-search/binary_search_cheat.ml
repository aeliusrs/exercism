open Base

let find lst e =
  match Array.findi ~f:(fun _ e' -> e = e') lst with
  | Some (index, _) -> Ok index
  | None -> Error "value not in array"
