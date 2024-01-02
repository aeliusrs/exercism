open Base

let translate c = Char.of_int_exn (Char.to_int 'z' - Char.to_int c + Char.to_int 'a')

let encode ?(block_size=5) str =
  String.lowercase str
  |> String.filter ~f:Char.is_alphanum
  |> String.map ~f:(fun a -> if Char.is_alpha a then translate a else a)
  |> String.to_list
  |> List.chunks_of ~length:block_size
  |> List.map ~f:String.of_char_list
  |> String.concat ~sep: " "

let decode str =
  String.filter str ~f:Char.is_alphanum
  |> String.map ~f:(fun a -> if Char.is_alpha a then translate a else a)
