open Base

let encode str =
  String.to_list str
  |> List.group ~break:(fun a b -> not(Char.equal a b))
  |> List.map ~f:(fun l -> match List.length l with
     | 1 -> List.hd_exn l |> String.of_char
     | n -> (Int.to_string n) ^ (List.nth_exn l 0 |> String.of_char))
  |> String.concat

let format_group lst = (* e.g -> lst = ['1';'2';'W']  *)
  List.fold lst ~init:"" ~f:(fun acc e ->
      if Char.is_digit e then acc ^ (String.of_char e) else acc)
  |> function
    | "" -> String.make 1 (List.last_exn lst)
    | s -> String.make (Int.of_string s) (List.last_exn lst)

let decode str =
  String.to_list str
  |> List.group ~break:(fun a _ -> Char.is_alpha a || Char.is_whitespace a)
  |> List.map ~f:(fun lst -> format_group lst) (*List.group create list of list*)
  |> String.concat
