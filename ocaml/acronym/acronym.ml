let acronym str =
  let symbol = ['-'; ','; '_'] in
  str
  |> String.map (fun l -> if (List.mem l symbol) then ' ' else l)
  |> String.uppercase_ascii
  |> String.split_on_char ' '
  |> List.filter (fun word -> String.length word > 0)
  |> List.map (fun word -> String.get word 0)
  |> List.to_seq
  |> String.of_seq
