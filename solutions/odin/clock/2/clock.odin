package clock

import "core:fmt"

Clock :: struct {
	hours:   int,
	minutes: int,
}

normalize_clock :: proc(c: ^Clock) {

	for c.minutes < 0 {
		c.hours -= 1
		c.minutes += 60
	}

	for c.hours < 0 {
		c.hours += 24
	}

	c.hours = (c.hours + c.minutes / 60) % 24
	c.minutes = c.minutes % 60

}

create_clock :: proc(hour, minute: int) -> Clock {

	clock := Clock {
		hours   = hour,
		minutes = minute,
	}
	normalize_clock(&clock)
	return clock
}

to_string :: proc(clock: Clock) -> string {

	return fmt.aprintf("%02d:%02d", clock.hours, clock.minutes)
}

add :: proc(clock: ^Clock, minutes: int) {

	clock.minutes += minutes
	normalize_clock(clock)
}

subtract :: proc(clock: ^Clock, minutes: int) {

	clock.minutes -= minutes
	normalize_clock(clock)
}

equals :: proc(clock1, clock2: Clock) -> bool {

	return clock1.hours == clock2.hours && clock1.minutes == clock2.minutes
}
