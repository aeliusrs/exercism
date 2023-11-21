open Base

let are_balanced =
  String.fold_until ~init:[] ~f:(fun acc c ->
    match c, acc with
    | '(', _  -> Continue (c :: acc)
    | ')', '(' :: tl -> Continue tl
    | ')', _ -> Stop false
    | '[', _  -> Continue (c :: acc)
    | ']', '[' :: tl -> Continue tl
    | ']', _ -> Stop false
    | '{', _  -> Continue (c :: acc)
    | '}', '{' :: tl -> Continue tl
    | '}', _ -> Stop false
    | _ -> Continue acc)
  ~finish:List.is_empty

  (* Basically, we loop over the string and collecting opening
     brackets in the accumulator.
     This "buffer" explain why we can continue to fold without stoping.

     For every closing brackets meet we do the following :
       - is the opening bracket present as the first elements of the acc ?
          if not that mean there is a mismatch or a wrong placement
       - if the accumulator is empty, or the first element is not his opening
          bracket, that mean there is a mismatch or wrong placement

    for any other character we just ignore.
    fold_until is a very interesting and complete function
    I recommend to use it as much as possible, same for Sequence.unfold
  *)
