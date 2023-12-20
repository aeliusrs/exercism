let to_roman number = let open Base in
  Sequence.unfold ~init:number ~f:(function
     | s when s <= 0    -> None
     | s when s >= 1000 -> Some("M", (s-1000))
     | s when s >= 900  -> Some("CM",(s-900))
     | s when s >= 500  -> Some("D" , (s-500))
     | s when s >= 400  -> Some("CD" , (s-400))
     | s when s >= 100  -> Some("C", (s-100))
     | s when s >= 90   -> Some("XC", (s-90))
     | s when s >= 50   -> Some("L", (s-50))
     | s when s >= 40   -> Some("XL", (s-40))
     | s when s >= 10   -> Some("X", (s-10))
     | 9                -> Some("IX", -1)
     | s when s >= 5    -> Some("V", (s-5))
     | 4                -> Some("IV", -1)
     | s                -> Some("I", (s-1)) )
  |> Sequence.fold ~init:"" ~f:(fun acc str -> acc ^ str)
