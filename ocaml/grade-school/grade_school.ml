open Base

module Int_map = Map.M(Int)
type school = string list Int_map.t

let empty_school = Map.empty (module Int)

let add name grade (s: school) =
  Map.update s grade
  ~f:(function
    | None -> name :: []
    | Some lst -> name :: lst
  )

let grade want (s: school) =
  s
  |> Map.to_alist
  |> List.filter ~f:(fun (g, _) -> g = want)
  |> List.map ~f:(fun (_, name) -> name)
  |> List.concat

let sorted (s: school) =
  s
  |> Map.map ~f:(fun lst -> List.sort ~compare:String.compare lst)

let roster (s: school) =
  s
  |> sorted
  |> Map.to_alist
  |> List.map ~f:(fun (_, name) -> name)
  |> List.concat
