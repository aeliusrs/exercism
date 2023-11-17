open Base

let response_for msg =
  let msg = String.strip msg in
  let is_question = String.is_suffix ~suffix:"?" msg in
  let is_silence = String.is_empty msg in
  let is_yelling =
    String.exists ~f:Char.is_uppercase msg &&
    not (String.exists ~f:Char.is_lowercase msg)
  in
  match is_question, is_yelling, is_silence with
  | true, true, _ -> "Calm down, I know what I'm doing!"
  | true, _, _-> "Sure."
  | _, true, _-> "Whoa, chill out!"
  | _, _, true -> "Fine. Be that way!"
  | _ -> "Whatever."
