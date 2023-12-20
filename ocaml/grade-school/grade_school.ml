open Base

module Int_map = Map.M(Int)
type school = string list Int_map.t

let empty_school = Map.empty (module Int)

let add name grade school = school |> Map.add_multi ~key:grade ~data:name

let grade want school =
  school
  |> Map.to_alist
  |> List.filter ~f:(fun (g, _) -> g = want)
  |> List.concat_map ~f:(fun (_, name) -> name)

let sorted school =
  school |> Map.map ~f:(fun lst -> List.sort ~compare:String.compare lst)

let roster school = school |> sorted |> Map.data |> List.concat
