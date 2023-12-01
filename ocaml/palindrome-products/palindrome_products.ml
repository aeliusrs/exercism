open Base

type palindrome_products = { value : int option; factors : (int * int) list; }

let is_palindrome number =
  let n = Int.to_string number in
  String.(rev n = n)

let get_palindrome ~min ~max ~finish =
  let lst = Sequence.range ~stop:`inclusive min max in
  Sequence.concat_mapi lst ~f:(fun i x -> (* loop of loop to generate tuple *)
    Sequence.drop lst i |> Sequence.map ~f:(fun y -> (x,y))) 
  |> Sequence.fold ~init:(Map.empty (module Int)) ~f:(fun acc (a, b) ->
      let f = a * b in
      if a <= b && is_palindrome f then
        Map.add_multi acc ~key:f ~data:(a,b)
      else acc)
  |> Map.to_alist (* retrieve the palindrome map to list *)
  |> finish (* pass the finish function to get element *)
  |> function (* format the element *)
    | Some (pal, lst) -> Ok {value = Some pal; factors = lst}
    | None -> Ok {value=None; factors=[]}

let smallest ~min ~max =
  match min <= max with
  | true -> get_palindrome ~min:min ~max:max ~finish:List.hd
  | false -> Error "min must be <= max"

let largest ~min ~max =
  match min <= max with
  | true -> get_palindrome ~min:min ~max:max ~finish:List.last
  | false -> Error "min must be <= max"

let show_palindrome_products p = match p.value with
  | Some x ->
      let lst = List.hd_exn p.factors in
      Printf.sprintf "{%d; [%d, %d]}" x (fst lst) (snd lst)
  | None -> "{None; []}"

let equal_palindrome_products a b =
  match a.value, b.value with
  | Some p, Some p' -> p = p'
  | None, None -> true
  | _ -> false
