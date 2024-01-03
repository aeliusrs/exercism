open Base

type direction = Left | Right [@@deriving sexp]

type 'a t = {
  focus : 'a;
  left : 'a t option;
  right : 'a t option;
  top: (direction * 'a t) option;
}
[@@deriving sexp]

let equal feq a b = feq a.focus b.focus

let rec of_tree (t : 'a Tree.t) =
  {
    focus = t.value;
    left = Option.map t.left ~f:of_tree;
    right = Option.map t.right ~f:of_tree;
    top= None;
  }

let value z = z.focus

let left z = Option.map z.left ~f:(fun left ->
  { left with top = Some (Left, z) })

let right z = Option.map z.right ~f:(fun right ->
  { right with top = Some (Right, z) })

let up z = Option.map z.top ~f:(function
  | (Left, top') -> { top' with left = Some z }
  | (Right, top') -> { top' with right = Some z })

let set_value v z = { z with focus = v }

let set_left l z = { z with left = Option.map l ~f:of_tree }

let set_right r z = { z with right = Option.map r ~f:of_tree }

let rec to_root z =
  match up z with
  | None -> z
  | Some z' -> to_root z'

let to_tree z : 'a Tree.t =
  let rec build z' : 'a Tree.t =
    {
      value = z'.focus;
      left = Option.map z'.left ~f:build;
      right = Option.map z'.right ~f:build
    }
  in
  to_root z |> build
