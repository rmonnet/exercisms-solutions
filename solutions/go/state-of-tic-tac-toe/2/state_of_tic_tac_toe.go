package stateoftictactoe

import "errors"

type State string

// The algorithm below is more generic but the instructions
// explicitely call for a 3x3 grid so let's enforce that.
const size = 3

const (
	Win     State = "win"
	Ongoing State = "ongoing"
	Draw    State = "draw"
)

func isWin(board []string, player byte) bool {
    // Check the rows.
    for r := 0; r < size; r++ {
        winningRow := true
        for c := 0; c < size; c++ {
            if board[r][c] != player {
                winningRow = false
                break
            }
        }
        if winningRow {
            return true
        }
    }
    // Check the columns.
    for c := 0; c < size; c++ {
        winningCol := true
        for r := 0; r < size; r++ {
            if board[r][c] != player {
                winningCol = false
                break
            }
        }
        if winningCol {
            return true
        }
    }
    // Check the left-to-right diagonal.
    if board[0][0] == player && board[1][1] == player && board[2][2] == player {
        return true
    }
    // Check the right-to-left diagonal.
    if board[0][2] == player && board[1][1] == player && board[2][0] == player {
        return true
    }
    return false
}

func numberTurns(board []string, player byte) int {
    turns := 0
	for r := 0; r < size; r++ {
       for c := 0; c < size; c++ {
           if board[r][c] == player {
               turns++
           }
        }
    }
    return turns
}

func StateOfTicTacToe(board []string) (State, error) {
	if len(board) != size || len(board[0])+len(board[1])+len(board[2]) != size*size {
        return State(""), errors.New("grid is not a 3x3 square") 
    }
    turnsForX := numberTurns(board, 'X')
    turnsForO := numberTurns(board, 'O')
    unplayed := numberTurns(board, ' ')
    if turnsForX + turnsForO + unplayed != size * size {
        return "", errors.New("board contains invalid marker")
    }
    if  !(turnsForO <= turnsForX && turnsForX <= turnsForO + 1) {
        return "", errors.New("a player played out of turn")
    }
    winForX := isWin(board, 'X')
    winForO := isWin(board, 'O')
    switch {
    case winForX && winForO:
        return State(""), errors.New("game was played after it already ended")
    case winForX || winForO:
        return Win, nil
    case unplayed == 0:
        return Draw, nil
    default:
        return Ongoing, nil
    }
}
