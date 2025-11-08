package rectangles

func isRectangle(diagram []string, r0, r1, c0, c1 int) bool {
    isHorizLine := func (r int) bool {
        for c := c0+1; c <= c1-1; c++ {
            if diagram[r][c] != '-' && diagram[r][c] != '+' {
                return false
            }
        }
        return true
    }
    isVertLine := func (c int) bool {
        for r := r0+1; r <= r1-1; r++ {
            if diagram[r][c] != '|' && diagram[r][c] != '+' {
                return false
            }
        }
        return true
    }
    return isHorizLine(r0) && isHorizLine(r1) && isVertLine(c0) && isVertLine(c1)
}

func Count(diagram []string) int {
    count := 0
	for r0 := 0; r0 < len(diagram); r0++ {
        // Find the two top corners (r0, c0) and (r0, c1).
        for c0 := 0; c0 < len(diagram[r0]); c0++ {
            if diagram[r0][c0] != '+' {
                continue
            }
            for c1 := c0 + 1; c1 < len(diagram[r0]); c1++ {
                if diagram[r0][c1] != '+' {
                    continue
                }
                // Find the two bottom corners (r1, c0), (r1, c1)
                for r1 := r0 + 1; r1 < len(diagram); r1++ {
                    if diagram[r1][c0] != '+' || diagram[r1][c1] != '+' {
                        continue
                    }
                    // Verify the sides are fully drawn.
                    if isRectangle(diagram, r0, r1, c0, c1) {
                        count++
                        
                    }
                }
            }
        }
    }
    return count
}
