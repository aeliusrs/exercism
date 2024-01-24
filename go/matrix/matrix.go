package matrix

import "strings"
import "strconv"
import "errors"
//import "unicode"

// Define the Matrix type here.
type Matrix [][]int

func New(s string) (Matrix, error) {
	rows := strings.Split(s, "\n")
	
	acc := make([][]int, len(rows))
	for i, row := range rows {
		cols := strings.Split(row, " ")

		intCols := make([]int, len(cols))
		for j, col := range cols {
			if col != "" {
				n, err := strconv.Atoi(col)

				if err != nil { return nil, err }
				intCols[j] = n
			}
		}

		if i > 0 && len(intCols) != len(acc[i - 1]) {
			return nil, errors.New("can not be empty")
		}
		acc[i] = intCols
	}
	return acc, nil
}

// Cols and Rows must return the results without affecting the matrix.
func (m Matrix) Cols() [][]int {
	panic("Please implement the Cols function")
}

func (m Matrix) Rows() [][]int {
	panic("Please implement the Rows function")
}

func (m Matrix) Set(row, col, val int) bool {
	panic("Please implement the Set function")
}
