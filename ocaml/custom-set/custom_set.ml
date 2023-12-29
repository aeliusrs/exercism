module type ELEMENT = sig
  type t
  val compare : t -> t -> int
end

module Make(El: ELEMENT) = struct
    open Base

    type t = El.t list
    type el = El.t

    let el_equal a b = Poly.compare a b = 0

    let is_empty lst = List.is_empty lst

    let is_member lst m = List.exists lst ~f:(el_equal m)

    let is_subset lst sub = List.for_all lst ~f:(is_member sub)

    let is_disjoint lst sub = List.for_all lst ~f:(fun x -> not(is_member sub x))

    let equal a b = is_subset a b && is_subset b a

    let of_list lst = List.dedup_and_sort lst ~compare:El.compare

    let add lst m = m :: lst

    type status = [
        | `OnlyA
        | `OnlyB
        | `Both
    ]

    let diff_filter _ _ _ = failwith "'diff_filter' is missing"

    let difference a b = List.filter a ~f:(fun x -> not(is_member b x))

    let intersect a b = List.filter a ~f:(is_member b)

    let union a b = a @ b |> of_list
end
