open Base

type bst =
  | Leaf (* equivalent of null *)
  | Node of int * bst * bst (*equivalent of tuple *)

  (* is equivalent of None or Some (tuple) *)

let empty = Leaf

let value = function
  | Leaf -> Error "No value found"
  | Node (v, _, _) -> Ok v

let left = function
  | Leaf -> Error "No bst found"
  | Node (_, l, _) -> Ok l

let right = function
  | Leaf -> Error "No bst found"
  | Node (_, _, r) -> Ok r

let rec insert v = function
  | Leaf -> Node (v, Leaf, Leaf)
  | Node (v', l, r) ->
      match v <= v' with
      | true -> Node (v', (insert v l), r)
      | false -> Node (v', l, (insert v r))

let to_list tree =
  let rec folder acc = function
    | Leaf -> acc
    | Node (v, l , r) ->
      acc
      |> List.append (folder acc r)
      |> List.append [v]
      |> List.append (folder acc l)
  in
  folder [] tree
