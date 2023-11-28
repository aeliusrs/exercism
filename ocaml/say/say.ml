open Base
open Int64

let units = [
  "zero"; "one"; "two"; "three"; "four"; "five"; 
  "six"; "seven"; "eight"; "nine"
]

let teens = [
  "ten"; "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen";
  "sixteen"; "seventeen"; "eighteen"; "nineteen"
]


let tens = [
  ""; ""; "twenty"; "thirty"; "forty"; "fifty";
  "sixty"; "seventy"; "eighty"; "ninety"
]

let get_n n div lst sep =
  let upper_i = Int64.(/) n div |> Int64.to_int_exn in
  let minor_i = Int64.rem n div in
  if minor_i = 0L then
    List.nth_exn lst upper_i
  else
    (List.nth_exn lst upper_i) ^ sep ^ (translate minor_i)

let rec translate number =
  match number with
  | 0L -> "zero"
  | n when n < 10L -> List.nth_exn units (Int64.to_int_exn n)
  | n when n < 20L -> List.nth_exn teens (Int64.to_int_exn (n - 10L))
  | n when n < 100L -> get_n n 10L tens " "
  | n when n < 1000L -> get_n n 100L units " hundred "
  | n when n < 10_000L -> get_n n 1000L units " thousand "
  | n when n < 100_000L -> get_n n 1000L tens " thousand "
  | _ -> "coming"

let compress number =
  List.fold ~init:number ~f(fun acc n

let in_english = function
  | n when n < 0L -> Error "numbers below zero are out of range"
  | n when n > 100_000L -> Error "numbers above 999,999,999,999 are out of range"
  | n -> Ok (compress n)
