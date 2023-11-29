open Base
open Int64

let units = [|
  ""; "one"; "two"; "three"; "four"; "five";
  "six"; "seven"; "eight"; "nine";"ten";
  "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen";
  "sixteen"; "seventeen"; "eighteen"; "nineteen" |]

let tens = [|
  ""; ""; "twenty"; "thirty"; "forty"; "fifty";
  "sixty"; "seventy"; "eighty"; "ninety" |]

let rec translate = function
  | n when n < 20L -> units.(Int64.to_int_exn n)
  | n when n < 100L ->
      let x' = n / 10L in
      let x'' = n % 10L in
      if x'' = 0L then
        tens.(Int64.to_int_exn x')
      else
        tens.(Int64.to_int_exn x') ^ "-" ^ translate x''
  | n when n < 1000L ->
      let x' = n / 100L in
      let x'' = n % 100L in
      translate x' ^ " hundred " ^ translate x''
  | n when n < 1_000_000L ->
      let x' = n / 1000L in 
      let x'' = n % 1000L in
      translate x' ^ " thousand " ^ translate x''
  | n when n < 1_000_000_000L ->
      let x' = n / 1_000_000L in 
      let x'' = n % 1_000_000L in
      translate x' ^ " million " ^ translate x''
  | n when n < 1_000_000_000_000L ->
      let x' = n / 1_000_000_000L
      in let x'' = n % 1_000_000_000L in
      translate x' ^ " billion " ^ translate x''
  | _ -> ""

let in_english = function
  | 0L -> Ok "zero"
  | n when n < 0L || n > 999_999_999_999L -> Error "input out of range"
  | n -> Ok (translate n |> String.strip)
