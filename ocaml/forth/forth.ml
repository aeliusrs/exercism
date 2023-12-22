open Base

(* Instruction *)
let get_pairs stack = match Stack.pop stack, Stack.pop stack with
  | Some a, Some b -> Some (a, b)
  | _ -> None

let add stack = match get_pairs stack with
  | Some (a, b) -> Int.(a + b) |> Stack.push stack
  | None -> Stack.clear stack

let min stack = match get_pairs stack with
  | Some (a, b) -> Int.(a - b) |> Stack.push stack
  | None -> Stack.clear stack

let mul stack = match get_pairs stack with
  | Some (a, b) -> Int.(a * b) |> Stack.push stack
  | None -> Stack.clear stack

let div stack = match get_pairs stack with
  | Some (a, b) -> Int.(a / b) |> Stack.push stack
  | None -> Stack.clear stack

let dup stack = match Stack.pop stack with
  | Some x -> Stack.push stack x; Stack.push stack x
  | None -> Stack.clear stack

let swap stack = match get_pairs stack with
  | Some (a, b) -> Stack.push stack b; Stack.push stack a
  | None -> Stack.clear stack

let over stack = ()

let drop stack = ignore(Stack.pop stack)

(* Tools *)
let known_word = [|
  ("+", add); ("-", min); ("*", mul); ("/", div);
  ("dup", dup); ("drop", drop); ("swap", swap); ("over", over)
|]

let sanitize op = op |> String.lowercase |> String.split ~on:' '

let is_number str = String.for_all ~f:Char.is_digit str

let is_assign str = not(String.is_empty str) && Char.(String.get str 0 = ':')

let assign op stack = ()

let run word stack =
  Array.find known_word ~f:(fun (w, _) -> String.equal word w)
  |> function
    | None -> ()
    | Some (_, f) -> f stack

let compute op stack =
  sanitize op
  |> List.iter ~f:(fun inst ->
      if is_number inst then
        Stack.push stack (inst |> Int.of_string)
      else
        run inst stack)

let parse op stack =
  if is_assign op then assign op stack else compute op stack

let evaluate ops =
  let ret = Stack.create() in
  List.iter ops ~f:(fun op -> parse op ret);
  match Stack.to_list ret with
  | [] -> None
  | r -> Some r
