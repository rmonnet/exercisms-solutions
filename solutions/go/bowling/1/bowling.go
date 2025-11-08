package bowling

import "errors"

type Game struct {
    frames [11][2]int
    curFrame int
    curBall int
}

func NewGame() *Game {
	return &Game{}
}

func (g Game) isStrike(frame int) bool {
    return g.frames[frame][0] == 10
}

func (g Game) isSpare(frame int) bool {
    return g.frames[frame][0] != 10 &&
    	(g.frames[frame][0] + g.frames[frame][1]) == 10
}

func (g Game) isGameOver() bool {
    return g.curFrame == 11 || 
    	(g.curFrame == 10 &&
    		!(g.isStrike(9) || (g.isSpare(9) && g.curBall == 0)))
}

func (g *Game) Roll(pins int) error {
    if g.isGameOver() {
        return errors.New("game is over")
    }
    if pins < 0 || pins > 10 {
        return errors.New("roll must be between 0 and 10")
    }
    if g.curBall == 1 && (g.frames[g.curFrame][0] + pins) > 10 &&
    	!(g.curFrame == 10 && g.isStrike(10)) {
        	return errors.New("rolls in the same frame can't exceed 10 points")
    }
    g.frames[g.curFrame][g.curBall] = pins
    if g.curFrame < 10 && g.isStrike(g.curFrame) {
        g.curFrame++
    } else {
        g.curBall++
        if g.curBall == 2 {
            g.curFrame++
            g.curBall = 0
    	}
    }
    return nil
}

func (g *Game) Score() (int, error) {
    if !g.isGameOver() {
        return 0, errors.New("game is not over")
    }
	score := 0
    for i := 0; i < 10; i++ {
        score += g.frames[i][0] + g.frames[i][1]
        if g.isSpare(i) {
            score += g.frames[i+1][0]
        }
        if g.isStrike(i) {
            score += g.frames[i+1][0]
            if i == 9 || !g.isStrike(i+1) {
                score += g.frames[i+1][1]
            } else {
                score += g.frames[i+2][0]
            }
        }
    }
    return score, nil
}
