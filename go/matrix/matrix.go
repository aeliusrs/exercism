package matrix

import "strings"
import "strconv"
import "errors"

type Matrix [][]int

func New(s string) (Matrix, error) {
	rows := strings.Split(s, "\n")
	
	acc := make([][]int, len(rows))
	for i, row := range rows {
		cols := strings.Fields(row)

		intCols := make([]int, len(cols))
		for j, col := range cols {
			n, err := strconv.Atoi(col)
			if err != nil { return nil, err }

			intCols[j] = n
		}
		acc[i] = intCols

		if i > 0 && len(intCols) != len(acc[0]) {
			return nil, errors.New("empty or uneven row")
		}
	}
	return acc, nil
}

func (m Matrix) Rows() [][]int {
	acc := make([][]int, len(m))

    for i := range m {
        acc[i] = make([]int, len(m[i]))
        copy(acc[i], m[i])
    }
	return acc
}

func (m Matrix) Cols() [][]int {
    acc := make([][]int, len(m[0]))

    for j := range m[0] {
        col := make([]int, len(m))
        for i := range m {
            col[i] = m[i][j]
        }
        acc[j] = col
    }
    return acc
}

func (m Matrix) Set(row, col, val int) bool {
	switch {
		case row < 0 || row >= len(m):  return false
		case col < 0 || col >= len(m[0]): return false
		default: m[row][col] = val
	}
	return true
}
