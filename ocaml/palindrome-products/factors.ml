open Base
open Sequence

(* this is an example of set theory for prime factors to general factors
   and then a function to generate general factors *)

let prime_factors_of number =
  Sequence.unfold_step ~init:(2, number)
  ~f:(fun (f, buf) -> match f, buf with
    | _, n when n = 1        -> Step.Done
    | i, n when (n % i) = 0  -> Step.Yield { value = i; state = (2, (n / i)) }
    | i, n                   -> Step.Skip { state = (Int.succ i, n) })
  |> Sequence.to_list

let rec subsets_of = function
  | [] -> [[]]
  | hd :: tl ->
      let second = subsets_of tl in
      List.append (List.map ~f:(fun e -> hd :: e) second) second

let get_factors num =
  prime_factors_of num
  |> subsets_of
  |> List.map ~f:(fun subset ->
      List.fold ~init:1 ~f:( * ) subset)
  |> List.dedup_and_sort ~compare:Int.compare

let factors_of number =
  Sequence.unfold_step ~init:(1, number)
  ~f:(function
    | f, num when f > num -> Step.Done
    | f, num when (num % f) = 0 ->
        Step.Yield { value = f; state = (Int.succ f, num) }
    | f, num ->
        Step.Skip { state = (Int.succ f, num) })
  |> Sequence.to_list

