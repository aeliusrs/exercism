let rec fold ~init ~f = function
  | [] -> init
  | hd :: tl -> fold ~init:(f init hd) ~f tl [@tail]

let reverse t =
  fold ~init:[] ~f:(fun acc e -> e :: acc) t

let length t =
  fold ~init:0 ~f:(fun acc _ -> succ acc) t

let fold_right ~init ~f t =
  reverse t |> fold ~init ~f

let map ~f t =
  fold_right ~init:[] ~f:(fun acc e -> (f e) :: acc) t

let filter ~f t =
  fold_right ~init:[] 
  ~f:(fun acc e -> if f e then e :: acc else acc) t

let append t t' =
  fold_right ~init:t' ~f:(fun acc e -> e :: acc) t

let concat t = (* test will always time out, even concat from base is slow)
  fold_right ~init:[] ~f:(fun acc e -> append e acc) t
