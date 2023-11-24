open Base

let is_valid acc c = match c with
  | '0'..'9' -> acc
  | '(' | ')' | '+' | '-' | '.' | ' ' -> acc
  | 'a'..'z' | 'A'..'Z' -> Error "letters not permitted"
  | _ -> Error "punctuations not permitted"

let check_length str =
  match (String.is_prefix ~prefix:"1" str, String.length str) with
  | true, 10 -> Ok str
  | true, 11 -> Ok (String.chop_prefix_exn ~prefix:"1" str)
  | false, 10 -> Ok str
  | false, 11 -> Error "11 digits must start with 1"
  | _, n when n > 11 -> Error "more than 11 digits"
  | _, _ -> Error "incorrect number of digits"

let check_code str =
  match (String.get str 0, String.get str 3) with
  | '0', _ -> Error "area code cannot start with zero"
  | '1', _ -> Error "area code cannot start with one"
  | _, '0' -> Error "exchange code cannot start with zero"
  | _, '1' -> Error "exchange code cannot start with one"
  | _ -> Ok str

let number str =
  str
  |> String.fold ~init:(Ok str) ~f:(fun acc c -> is_valid acc c)
  |> function (* clean the number *)
    | Error m -> Error m
    | Ok s -> Ok (String.filter ~f:Char.is_digit s)
  |> function (* check length and remove the country code *)
    | Error m -> Error m
    | Ok s -> check_length s
  |> function (* check the validity of area and exchange code *)
    | Error m -> Error m
    | Ok s -> check_code s
