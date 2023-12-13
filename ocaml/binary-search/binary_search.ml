open Base

let find arr n =
  let rec loop acc lst =
    let length = List.length lst / 2 in
    match List.split_n lst length with
    | (_ as left, h :: _) when h = n -> Ok (acc + List.length left)
    | ([], [h]) when n <> h -> Error "value not in array"
    | (_ as left, (h :: _ as right)) when n > h -> loop (acc + List.length left) right
    | (_ as left, (h :: _)) when n < h -> loop acc left
    | _ -> Error "value not in array"
  in
  loop 0 (Array.to_list arr)
