open Base
open CalendarLib

type schedule = First | Second | Third | Fourth | Teenth | Last

type weekday = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday

(* result type (year, month, day_of_month) *)
type date = (int * int * int)

let wk_to_day = function
  | Monday    -> Date.Mon
  | Tuesday   -> Date.Tue
  | Wednesday -> Date.Wed
  | Thursday  -> Date.Thu
  | Friday    -> Date.Fri
  | Saturday  -> Date.Sat
  | Sunday    -> Date.Sun

let get_teenth_days y m d =
  [13; 14; 15; 16; 17; 18; 19]
  |> List.map ~f:(fun d' -> Date.make y m d')
  |> List.find_exn ~f:(fun d' -> phys_equal d (Date.day_of_week d'))

let get_last y m wd =
  let ym_day n = Date.make y m n in
  let rec find_last start =
    let d = ym_day start in
    match phys_equal wd (Date.day_of_week d) with
    | true -> d
    | _ -> find_last (start - 1)
  in
  find_last (ym_day 1 |> Date.days_in_month )

let get_nth_day y m d n = Date.nth_weekday_of_month y m d n

let meetup_day schedule weekday ~year ~month =
  let day = wk_to_day weekday in
  let month_int = Date.month_of_int month in
  let day' =
    match schedule with
    | First -> get_nth_day year month_int day 1
    | Second -> get_nth_day year month_int day 2
    | Third -> get_nth_day year month_int day 3
    | Fourth -> get_nth_day year month_int day 4
    | Last -> get_last year month day
    | Teenth -> get_teenth_days year month day
  in
  (year, month, Date.day_of_month day')
