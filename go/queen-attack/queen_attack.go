package queenattack

import "fmt"

func abs(x int) int { if x < 0 { return -x }; return x }

func parsePosition(pos string) (int, int, error) {
	if len(pos) != 2 {
		return 0, 0, fmt.Errorf("invalid position format: %s", pos)
	}

	cols := int(pos[0] - 'a')
	rows := int(pos[1] - '1')
	if cols < 0 || cols > 7 || rows < 0 || rows > 7 {
		return 0, 0, fmt.Errorf("invalid position: %s", pos)
	}
	return cols, rows, nil
}

func canAttack(wX, wY, bX, bY int) bool {
	switch {
		case wY == bY: return true
		case wX == bX: return true
		case abs(wX-bX) == abs(wY-bY): return true
		default: return false
	}
}

func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	if whitePosition == blackPosition {
		return false, fmt.Errorf("Can not be on the same case")
	}

	wX, wY, err := parsePosition(whitePosition)
	if err != nil { return false, err }

	bX, bY, err := parsePosition(blackPosition)
	if err != nil { return false, err }

	return canAttack(wX, wY, bX, bY), nil
}
