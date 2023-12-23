open Base

let custom_def = Hashtbl.create (module String)

(* Tools*)
let parse str =
  let str = String.uppercase str in
  match String.get str 0 with
  | ':' -> [str]
  | _ -> String.split ~on:' ' str

let is_number str = String.for_all str ~f:Char.is_digit

let is_definition str = Char.equal (String.get str 0) ':'

let is_custom str = Hashtbl.find custom_def str |> Option.is_some

(* Definition *)
let parse_def def =
  def
  |> String.filter ~f:(fun c -> Char.(c <> ':' && c <> ';'))
  |> String.strip
  |> String.split ~on:' '

let get_definition stack def =
  match parse_def def with
  | hd :: tl when not(is_number hd) ->
      Hashtbl.set custom_def ~key:hd ~data:tl; Some stack
  | _ -> None

(* Apply instruction *)
let rec run_definition stack def =
  match Hashtbl.find custom_def def with
  | Some lst -> List.fold lst ~init:(Some stack) ~f:compute
  | None -> None

and compute stack inst =
  match inst, stack with
  | w, Some stk when is_number w      -> Some ((Int.of_string w) :: stk)
  | w, Some stk when is_custom w      -> run_definition stk w
  | "+", Some (a :: b :: tl)      -> Some ((b + a) :: tl)
  | "-", Some (a :: b :: tl)      -> Some ((b - a) :: tl)
  | "*", Some (a :: b :: tl)      -> Some ((b * a) :: tl)
  | "/", Some (a :: b :: tl) when a <> 0 && b <> 0 -> Some ((b / a) :: tl)
  | "SWAP", Some (a :: b :: tl)   -> Some (b :: a :: tl)
  | "OVER", Some (a :: b :: tl)   -> Some (b :: a :: b :: tl)
  | "DUP", Some (a :: tl)         -> Some (a :: a :: tl)
  | "DROP", Some (_ :: tl)        -> Some tl
  | w, Some stk when is_definition w  -> get_definition stk w
  | _, _       -> None

let evaluate ops =
  ops
  |> List.map ~f:parse
  |> List.concat
  |> List.fold ~init:(Some []) ~f:compute
  |> function
    | None -> None
    | Some stack -> Some (List.rev stack)
