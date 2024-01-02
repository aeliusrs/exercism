open Base

let acronym str =
  let symbol = ['-'; ','; '_'] in
  str
  |> String.map ~f:(fun l -> if (List.mem symbol l ~equal:Char.equal) then ' ' else l)
  |> String.uppercase
  |> String.split ~on:' '
  |> List.filter ~f:(fun word -> String.length word > 0)
  |> List.map ~f:(fun word -> String.get word 0)
  |> String.of_list
