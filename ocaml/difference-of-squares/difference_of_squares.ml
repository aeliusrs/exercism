open Base
open Int

let square_of_sum n =
  let sum =
    List.init n ~f:(fun i -> succ i) |> List.fold ~f:(+) ~init:0
  in
  sum * sum

let sum_of_squares n =
  List.init n ~f:(fun i -> (succ i) * (succ i))
  |> List.fold ~f:(+) ~init:0

let difference_of_squares n =
  (square_of_sum n) - (sum_of_squares n)
