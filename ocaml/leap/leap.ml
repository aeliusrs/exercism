
let leap_year year =
  [4; 100; 400]
  |> List.map (fun x -> year mod x)
  |> (fun lst -> match lst with
     | hd :: md :: tl when (hd = 0 && md = 0 && tl = [0]) -> true
     | hd :: md :: _ when (hd = 0 && md != 0) -> true
     | _ -> false)
