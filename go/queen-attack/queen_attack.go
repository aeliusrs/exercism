package queenattack

import "fmt"

func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	if whitePosition == blackPosition {
		return false, fmt.Errorf("Can not be on the same case")
	}

	t := [4]int{
		int(whitePosition[0] - 'a'), // 0 -> white x
		int(whitePosition[1] - '1'), // 1 -> white y
		int(blackPosition[0] - 'a'), // 2 -> black x
		int(blackPosition[1] - '1'), // 3 -> black y
	}

	for _, v := range t {
		if v < 0 || v > 7 {
			return false, fmt.Errorf("Position outbound")
		}
	}

	return (t[1] == t[3] || t[0] == t[2] ||
	t[1] - t[0] == t[3] - t[2] || t[1] - t[0] == t[2] - t[3]), nil
}
