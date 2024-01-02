open Base

let square_of_sum n =
  let sum = List.init n ~f:Int.succ |> List.fold ~init:0 ~f:(+)
  in sum * sum

let sum_of_squares n =
  List.init n ~f:(fun i -> (Int.succ i) * (Int.succ i))
  |> List.fold ~init:0 ~f:(+)

let difference_of_squares n = (square_of_sum n) - (sum_of_squares n)
