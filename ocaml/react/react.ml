open Base

type 'a kind = | Input | Compute

type 'a cell = {
    mutable value: 'a;
    mutable prev: 'a;
    mutable update: ('a -> unit) list;
    mutable callbacks: (int * ('a -> unit)) list;
    mutable call_ids: int;
    kind: 'a kind; (* cell type *)
    eq: 'a -> 'a -> bool;
}

type callback_id = int

let create_cell ~kind ~value ~eq =
  {eq; value; kind; callbacks = []; update = []; call_ids = 0; prev = value; }

let value_of {value; _} = value


let call_callbacks cell =
  if not (cell.eq cell.value cell.prev) then
    List.iter ~f:(fun (_, f) -> (f cell.value)) cell.callbacks;
    cell.prev <- cell.value

let compute_value cell v =
  let _ = if cell.eq cell.value v then () else cell.value <- v in
  List.iter cell.update ~f:(fun f' -> f' v)

let set_value cell a =
  match cell.kind with
  | Input -> let _ = compute_value cell a in call_callbacks cell
  | _ -> invalid_arg "should be a kind input"

let add_callback cell ~k =
  let _ = cell.call_ids <- Int.succ cell.call_ids in
  let _ = cell.callbacks <- (cell.call_ids, k) :: cell.callbacks in
  cell.call_ids

let remove_callback cell i =
    cell.callbacks <- List.filter ~f:(fun (i', _) -> i <> i') cell.callbacks

let add_update cell ~k = cell.update <- k :: cell.update

(* Create Cells *)
let create_input_cell ~value ~eq = create_cell ~kind:Input ~value ~eq

let create_compute_cell_1 i ~f ~eq =
    let value = f (value_of i) in
    let cell' = create_cell ~kind:Compute ~value ~eq in
    let _ = add_update i ~k:(fun a -> compute_value cell' (f a)) in
    let _ = add_callback i ~k:(fun _ -> call_callbacks cell') in
    cell'

let create_compute_cell_2 i1 i2 ~f ~eq =
    let getv = fun () -> f (value_of i1) (value_of i2) in
    let cell' = create_cell ~kind:Compute ~value:(getv ()) ~eq in
    let up = fun _ -> compute_value cell' (getv ()) in
    let _ = add_update i1 ~k:up in
    let _ = add_update i2 ~k:up in
    let _ = add_callback i1 ~k:(fun _ -> call_callbacks cell') in
    let _ = add_callback i2 ~k:(fun _ -> call_callbacks cell') in
    cell'
