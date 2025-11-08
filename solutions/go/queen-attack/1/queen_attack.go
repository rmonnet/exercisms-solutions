package queenattack

import "errors"

const size = 8

type cell struct {
	row int
	col int
}

func getCell(position string) (cell, error) {
	row := int(7 - position[1] + '1')
	col := int(position[0] - 'a')
	if row < 0 || row >= size || col < 0 || col >= size {
		return cell{}, errors.New("invalid position")
	}
	return cell{row, col}, nil
}

func abs(a int) int {
	if a < 0 {
		a = -a
	}
	return a
}

func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	if whitePosition == blackPosition {
		return false, errors.New("white and black queens can't occupy the same position")
	}
	whiteCell, err := getCell(whitePosition)
	if err != nil {
		return false, err
	}
	blackCell, err := getCell(blackPosition)
	if err != nil {
		return false, err
	}
	// Queen can attack if on same row, same column or same diagonal.
	// Being on the same diagonal means that we can move from one position
	// to the other by incrementing (+ or -) the position by the same amount
	// in both dimensions.
	canAttack := whiteCell.row == blackCell.row || whiteCell.col == blackCell.col ||
		abs(whiteCell.col-blackCell.col) == abs(whiteCell.row-blackCell.row)
	return canAttack, nil
}
