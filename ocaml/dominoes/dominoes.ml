open Base

type dominoe = (int * int)

let rotate (x, y) = (y, x)

let can_connect a b = (snd a = fst b)

let wavefront_arbiter a b = Int.compare (fst a + snd a) (fst b + snd b)

let is_dominoe_in lst a = List.exists lst ~f:(fun e -> Poly.equal a e)

let check lst = Int.equal (List.hd_exn lst |> fst) (List.last_exn lst |> snd)

let find_connect hd lst =
  List.find lst ~f:(fun e -> can_connect hd e || can_connect hd (rotate e))
  |> function
    | None -> lst
    | Some e -> if can_connect hd e then [e] else [(rotate e)]

let build_chains lst =
  List.zip_exn lst (List.tl_exn lst @ [List.hd_exn lst])
  |> List.fold ~init:([],[]) ~f:(fun (acc,rest) (a, b) ->
  if Poly.equal a b then (a :: acc, a :: rest)
  else if is_dominoe_in rest a
  then (acc, rest)
  else if can_connect a b || can_connect (rotate a) b || can_connect a (rotate b)
  || can_connect (rotate a) (rotate b)
  then (acc @ [a], rest)
  else
    (acc, a :: rest))




let chain = function
  | [] as lst -> Some lst
  | lst -> let ret = List.sort lst ~compare:wavefront_arbiter |> build_chains lst in
      match check ret with
      | true  -> Some ret
      | false -> None

