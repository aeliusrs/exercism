# the algorithm is as follow

using this board:
. . . .
x x . .
. . x x
x x x .

we get the position of every x in a col.

col 0 -> (0, 1); (0, 3) -> is connected ? -> [true; true] so acc +1
col 1 -> (1, 1); (1, 3) -> is connected ? -> [true; true] so acc +1
col 2 -> (2, 2); (2, 3) -> is connected ? -> [true; true] so acc +1
col 3 -> (3, 2); -> is connected ? -> [true] so acc +1

acc = width ? Some x else None

is connect check in cross, not diagonals
