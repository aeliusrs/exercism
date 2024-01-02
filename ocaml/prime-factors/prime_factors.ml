open Base
open Int64
open Sequence

let factors_of (number : int64) =
  Sequence.unfold_step ~init:(2L, number) ~f:(function
  | _, n when n = 1L        -> Step.Done
  | i, n when (n % i) = 0L  -> Step.Yield { value = i; state = (2L, (n / i)) }
  | i, n                    -> Step.Skip { state = (succ i, n) })
|> Sequence.to_list
