open Base
open React

type progress = Win | Lose | Busy of int

type state = { word: char list; found: char list; guesses: int; }

type t = state signal * (?step:step -> state -> unit)

(* TOOL *)
let is_mem lst c = List.mem lst c ~equal:Char.equal

let is_guess word found c = is_mem word c && not (is_mem found c)

let is_complete word found = List.for_all word ~f:(is_mem found)

(* GET *)
let get_mask {word; found; _} =
  word
  |> List.map ~f:(fun c -> if is_mem found c then c else '_')
  |> String.of_list

let get_game {word; found; guesses } =
  match word, found, guesses with
  | _, _, g when g < 0 -> Lose
  | w, f, _ when is_complete w f -> Win
  | _, _, g -> Busy g

(* MAIN *)
let create word =
  S.create {word = String.to_list word; found = []; guesses = 9; }

let feed c ((state, update_state) : t) =
  let {word; found; guesses} = S.value state in
  let success = is_guess word found c in
  let found' = if success then c :: found else found in
  let guesses' = if success then guesses else Int.pred guesses in
  update_state {word; found = found'; guesses = guesses'}

let masked_word (state, _) = S.map get_mask state

let progress (state, _) = S.map get_game state
