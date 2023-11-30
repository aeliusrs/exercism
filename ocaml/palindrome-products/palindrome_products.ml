open Base
open Sequence

type palindrome_products = { value : int option; factors : (int * int) list; }

let is_palindrome number =
  let n = Int.to_string number in
  String.(rev n = n)

let get_palindrome min max =
  let range = List.range ~stop:`inclusive min max in
  List.concat_map range ~f:(fun x ->
     Sequence.unfold_step ~init:range ~f:(function
       | [] -> Step.Done
       | hd :: tl -> let f = x * hd in
           match (x < hd || x = hd) && is_palindrome f with
           | true   -> Step.Yield { value = (f, (x, hd)); state = tl }
           | false  -> Step.Skip { state = tl })
     |> Sequence.to_list)
  |> List.sort ~compare:(fun (f, _) (f', _) -> Int.compare f f')
  |> List.group ~break:(fun (f, _) (f', _) -> f <> f')
  |> List.map ~f:(fun sublst ->
      List.fold sublst ~init:(0, []) ~f:(fun (_, acc) (f, p) -> (f, acc @ [p])))

let smallest ~min ~max =
  if min > max then
    Error "min must be <= max"
  else
    match get_palindrome min max |> Fn.flip List.nth 0 with
    | Some (f, lst) -> Ok {value = Some f; factors = lst}
    | None -> Ok {value=None; factors=[]}

let largest ~min ~max =
  if min > max then
    Error "min must be <= max"
  else
    match get_palindrome min max |> List.last with
    | Some (f, lst) -> Ok {value = Some f; factors = lst}
    | None -> Ok {value=None; factors=[]}

let show_palindrome_products p =
  match p.value with
  | Some x ->
      let lst = List.hd_exn p.factors in
      Printf.sprintf "{%d; [%d, %d]}" x (fst lst) (snd lst)
  | None -> "{None; []}"

let equal_palindrome_products a b =
  match a.value, b.value with
  | Some p, Some p' -> p = p'
  | None, None -> true
  | _ -> false
