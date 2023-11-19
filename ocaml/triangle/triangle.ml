let is_valid a b c =
  a <> 0 && b <> 0 && c <> 0 &&
  (a + b > c) && (b + c > a) && (a + c > b)

let is_equilateral a b c =
  is_valid a b c &&
  (a = b && b = c && c = a)

let is_isosceles a b c =
  is_valid a b c &&
  (a = b || b = c || a = c)

let is_scalene a b c =
  is_valid a b c &&
  (a != b && b != c && c != a)
