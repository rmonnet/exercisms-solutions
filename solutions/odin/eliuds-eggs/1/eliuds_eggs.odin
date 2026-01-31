package eliuds_eggs

egg_count :: proc(number: uint) -> uint {
	egg_row := number
    eggs := uint(0)
    for egg_row > 0 {
        if (egg_row & 1) == 1 {
            eggs += 1
        }
        egg_row = egg_row >> 1
    }
	return eggs
}
