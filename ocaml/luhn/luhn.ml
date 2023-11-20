open Base
open Int

let doubling i c =
  let n = Char.get_digit_exn c in
  match (succ i % 2) = 0, n with
  | true, n when n * 2 >= 9 -> n * 2 - 9
  | true, n -> n * 2
  | _ -> n

let allowed s =
  String.for_all ~f:Char.is_digit s &&
  String.length s > 1 

let valid s =
  let s = String.filter ~f:(fun c -> not (Char.is_whitespace c)) s in
  match allowed s with
  | true -> s
    |> String.to_list
    |> List.rev
    |> List.foldi ~init:0 ~f:(fun i acc n -> acc + (doubling i n))
    |> Fn.flip ( % ) 10
    |> ( = ) 0
  | false -> false
