package pascals_triangle

rows :: proc(count: int) -> [][]u128 {
	triangle := make([][]u128, count)
	for i in 0 ..< count {
		triangle[i] = make([]u128, i + 1)
		triangle[i][0] = 1
		for j in 1 ..< i {
			triangle[i][j] = triangle[i - 1][j - 1] + triangle[i - 1][j]
		}
		triangle[i][i] = 1
	}
	return triangle
}
