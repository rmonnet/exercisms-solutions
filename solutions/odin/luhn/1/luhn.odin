package luhn

valid :: proc(value: string) -> bool {

    checksum := 0
    n_idx := 0
    n_digits := 0
    for i := len(value)-1; i >= 0; i -= 1 {
        if value[i] == ' ' { continue }
        if value[i] < '0' || value[i] > '9' { return false }
        n_digits += 1
        n := int(value[i] - '0')
        n_idx += 1
        if n_idx % 2 == 0 {
            n = 2 * n
            if n > 9 {
                n -= 9
            }
        }
        checksum += n
    }
	return checksum % 10 == 0 && (checksum != 0 || n_digits > 1)
}
