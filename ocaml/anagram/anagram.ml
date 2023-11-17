
let is_alpha = function 'a' .. 'z' -> true | _ -> false

let sanitize str =
  str
  |> String.trim
  |> String.lowercase_ascii

let to_list str =
  str
  |> String.to_seq
  |> List.of_seq
  |> List.filter (fun l -> is_alpha l)
  |> List.sort compare

let is_anagram word str =
  let w = word |> sanitize |> to_list in
  let s = str  |> sanitize |> to_list in
  match w, s with
  | n, m when List.length n != List.length m -> false
  | n, m when n = m -> true
  | _ -> false

let anagrams word wlist =
  wlist
  |> List.filter (fun str -> (sanitize word) <> (sanitize str))
  |> List.filter (fun str -> is_anagram word str)
