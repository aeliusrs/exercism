open Base

type allergen = Eggs | Peanuts | Shellfish | Strawberries | Tomatoes | Chocolate | Pollen | Cats

(* land operator is a bitwise and operator *)
let allergic_to score allergen =
  let ascore =
    match allergen with
    | Eggs -> 1
    | Peanuts -> 2
    | Shellfish -> 4
    | Strawberries -> 8
    | Tomatoes -> 16
    | Chocolate -> 32
    | Pollen -> 64
    | Cats -> 128
  in
  let result = score land ascore in
  result = ascore

let allergies score =
  [ Eggs; Peanuts; Shellfish; Strawberries; Tomatoes; Chocolate; Pollen; Cats ]
  |> List.filter ~f:(allergic_to score)
