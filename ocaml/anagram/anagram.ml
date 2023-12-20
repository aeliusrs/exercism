open Base

let sanitize str =
  str |> String.strip |> String.lowercase |> String.filter ~f:Char.is_alpha

let to_list str =
  str |> String.to_list |> List.sort ~compare:Char.compare

let is_anagram word str =
  match to_list word, to_list str with
  | w, s when List.length w <> List.length s -> false
  | w, s when List.equal Char.equal w s -> true
  | _ -> false

let anagrams word wlist =
  List.filter wlist ~f:(fun s -> String.(<>) (sanitize word) (sanitize s) &&
  is_anagram (sanitize word) (sanitize s))
