open Base
open Result

let is_valid acc c = match c with
  | '0'..'9' -> acc
  | '(' | ')' | '+' | '-' | '.' | ' ' -> acc
  | 'a'..'z' | 'A'..'Z' -> Error "letters not permitted"
  | _ -> Error "punctuations not permitted"

let number str =
  String.fold ~init:(Ok str) ~f:is_valid str
  >>= (fun s -> Ok (String.filter ~f:Char.is_digit s))
  >>= (fun s -> match (String.is_prefix ~prefix:"1" s, String.length s) with
      | true, 10 -> Ok s
      | true, 11 -> Ok (String.chop_prefix_exn ~prefix:"1" s)
      | false, 10 -> Ok s
      | false, 11 -> Error "11 digits must start with 1"
      | _, n when n > 11 -> Error "more than 11 digits"
      | _, _ -> Error "incorrect number of digits")
  >>= (fun s -> match (String.get s 0, String.get s 3) with
      | '0', _ -> Error "area code cannot start with zero"
      | '1', _ -> Error "area code cannot start with one"
      | _, '0' -> Error "exchange code cannot start with zero"
      | _, '1' -> Error "exchange code cannot start with one"
      | _ -> Ok s)
