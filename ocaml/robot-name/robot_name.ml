open Base

type robot = { mutable name : string; }

let known_serial = Hash_set.create ~growth_allowed:true (module String)

let rec gen_name () =
  let serial = String.init 5 ~f:(function
        | i when i < 2 -> Random.int 26 |> (+) 65 |> Char.of_int_exn
        | _ -> Random.int 9 |> (+) 49 |> Char.of_int_exn)
  in
  match Hash_set.mem known_serial serial with
  | true -> gen_name()
  | _  -> (Hash_set.add known_serial serial; serial)

let new_robot () = { name = gen_name () }

let name robot = robot.name

let reset robot =
  Hash_set.remove known_serial robot.name; robot.name <- gen_name ()

