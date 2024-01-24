let reverse_string str =
  let open Base in
  let len = String.length str in
  String.init len ~f:(fun i -> str.[len - i - 1])
