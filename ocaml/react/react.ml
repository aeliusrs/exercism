open Base

type callback_id = int

type 'a kind = | Input | Compute

type 'a cell = {
  mutable value: 'a; (* current value of the cell *)
  mutable prev: 'a; (* previous value of the cell *)
  mutable update: ('a -> unit) list; (* List of dependence *)
  mutable callbacks: (int * ('a -> unit)) list; (* list of function *)
  mutable call_ids: int; (* uniq ID for callback *)
  kind: 'a kind; (* cell type *)
  eq: 'a -> 'a -> bool;
}

(* general cell function *)
let create_cell ~kind ~value ~eq =
  {eq; value; kind; callbacks = []; update = []; call_ids = 0; prev = value; }

let value_of {value; _} = value

(* set_value & manage callback and update *)
let call_callbacks cell =
  if not (cell.eq cell.value cell.prev) then
    List.iter ~f:(fun (_, f) -> (f cell.value)) cell.callbacks;
    cell.prev <- cell.value

let compute_value cell v =
  let _ = if cell.eq cell.value v then () else cell.value <- v in
  List.iter cell.update ~f:(fun f' -> f' v)

let set_value cell a =
  match cell.kind with
  | Input -> compute_value cell a; call_callbacks cell
  | _ -> ()

(* manage callback and update *)
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
  let cell' = create_cell ~kind:Compute ~value:(f (value_of i)) ~eq in
  let _ = add_update i ~k:(fun a -> compute_value cell' (f a)) in
  let _ = add_callback i ~k:(fun _ -> call_callbacks cell') in
  cell'

let create_compute_cell_2 i1 i2 ~f ~eq =
  let value' = fun () -> f (value_of i1) (value_of i2) in
  let cell' = create_cell ~kind:Compute ~value:(value' ()) ~eq in
  let update' = fun _ -> compute_value cell' (value' ()) in
  let _ = add_update i1 ~k:update' in
  let _ = add_update i2 ~k:update' in
  let _ = add_callback i1 ~k:(fun _ -> call_callbacks cell') in
  let _ = add_callback i2 ~k:(fun _ -> call_callbacks cell') in
  cell'
