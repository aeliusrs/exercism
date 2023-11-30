open Base
open Sequence

type palindrome_products = {
  value : int option;
  factors : (int * int) list;
}

let is_palindrome number =
  let n = Int.to_string number in
  String.(rev n = n)

let get_palindrome min max =
  Sequence.range ~start:`inclusive ~stop:`inclusive min max
  |> fun lst ->
      Sequence.concat_map lst ~f:(fun x ->
        Sequence.map lst ~f:(fun y ->
          if x < y || x = y then
          (x * y, Some (x, y))
        else
          (x * y, None) ))
  |> Sequence.filter ~f:(function
    | (_, None) -> false
    | _ as e -> true)
  |> Sequence.filter ~f:(fun (f, _) -> is_palindrome f)
  |> Sequence.to_list
  |> List.sort ~compare:(fun (f, _) (f', _) -> Int.compare f f')
  |> List.group ~break:(fun (f, _) (f', _) -> f <> f')
  |> List.map ~f:(fun sublst ->
      List.fold sublst ~init:(0, []) ~f:(fun (_, acc) (f, Some p) -> (f, acc @ [p] )))

let smallest ~min ~max =
  let palindrome = get_palindrome min max |> Fn.flip List.nth 0 in
    |> (function
      | Some x -> factors_of x
      | None -> [])
  in
  Ok { value = palindrome; factors = factors_lst }

let largest ~min ~max =
  let palindrome = get_palindrome min max |> List.last in
  let factors_lst = palindrome
    |> (function
      | Some x -> factors_of x
      | None -> [])
  in
  Ok { value = palindrome; factors = factors_lst }

let show_palindrome_products _ =
  failwith "'show_palindrome_products' is missing"

let equal_palindrome_products _ _ =
  failwith "'equal_palindrome_products' is missing"
