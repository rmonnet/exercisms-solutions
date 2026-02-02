package gigasecond

import "core:time"
import "core:time/datetime"

add_gigasecond :: proc(moment: datetime.DateTime) -> datetime.DateTime {

	GIGASECOND :: 1_000_000_000 * time.Second

	current_time, _ := time.compound_to_time(moment)
	future_time := current_time
	future_time._nsec += i64(GIGASECOND)
	future_datetime, _ := time.time_to_compound(future_time)
	return future_datetime
}
