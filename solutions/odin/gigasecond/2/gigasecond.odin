package gigasecond

import "core:time"
import "core:time/datetime"

add_gigasecond :: proc(moment: datetime.DateTime) -> datetime.DateTime {

	GIGASECOND :: 1_000_000_000 * time.Second

	t, _ := time.compound_to_time(moment)
	t._nsec += i64(GIGASECOND)
	future_moment, _ := time.time_to_compound(t)
	return future_moment
}
