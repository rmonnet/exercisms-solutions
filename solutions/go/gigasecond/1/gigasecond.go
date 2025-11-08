// Package gigasecond provides operations to add a Gigaseconds to a time.
package gigasecond

import "time"

// AddGigasecond adds 1 Gigaseconds (1 billion seconds) to a time
// a returns the new time.
func AddGigasecond(t time.Time) time.Time {
	return t.Add(time.Second * 1_000_000_000)
}
