package chessboard

import "errors"

type File []bool

type Chessboard map[string]File

func CountInFile(cb Chessboard, file string) (sum int) {
	value, ok := cb[file]

	if !ok { errors.New("wrong arg given") }
	for _, e := range value { if e == true { sum++ } }
	return
}

func CountInRank(cb Chessboard, rank int) (sum int) {
	rank = rank - 1
	for _, v := range cb {
		if rank >= 0 && rank < len(v) && v[rank] { sum++ }
	}
	return
}

func CountAll(cb Chessboard) (sum int) {
	for _, row := range cb { sum += len(row) }; return
}

func CountOccupied(cb Chessboard) (sum int) {
	for row := range cb { sum += CountInFile(cb, row) }; return
}
