package booking

import (
    "time"
)

// parseTime is an auxilliary function that parse a string date
// and return a Time. It will panic if parsing the date fails.
func parseTime(layout, date string) time.Time {
    scheduleDate, err := time.Parse(layout, date)
    if err != nil {
        panic("Unable to parse date: " + err.Error())
    }
    return scheduleDate
}

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
    return parseTime("1/02/2006 15:04:05", date)
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
    scheduleDate := parseTime("January 2, 2006 15:04:05", date)
	return scheduleDate.Compare(time.Now()) < 0
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	scheduleDate := parseTime("Monday, January 2, 2006 15:04:05", date)
    scheduleHour := scheduleDate.Hour()
    return scheduleHour >= 12 && scheduleHour < 18
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	scheduleDate := parseTime("1/2/2006 15:04:05", date)
	return scheduleDate.Format(
        "You have an appointment on Monday, January 2, 2006, at 15:04.")
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
    thisYear := time.Now().Year()
    return time.Date(thisYear, time.September, 15, 0, 0, 0, 0, time.UTC)
}
