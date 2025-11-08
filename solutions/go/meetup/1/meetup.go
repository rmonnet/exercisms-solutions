package meetup

import "time"

// WeekSchedule defines the type used to request a specific weekday of the month
// as first, second, third, fourth, teenth (between the 13th and the 19th),
// and last (different from fourth when there is 5 of the same weekday in a month).
type WeekSchedule int

const (
    First WeekSchedule = iota
    Second
    Third
    Fourth
    Teenth
    Last
)

// DaysInMonth represents the number of days in a month. It doesn't account for
// leap years.
var daysInMonth = map[time.Month]int{
    time.January: 31, time.February: 28, time.March: 31, time.April: 30, time.May: 31,
    time.June: 30, time.July: 31, time.August: 31, time.September: 30,
    time.October: 31, time.November: 30, time.December: 31}

// IsLeapYear checks if a specific year is a leap year.
func isLeapYear(year int) bool {
    return (year % 4 == 0) && (!(year % 100 == 0) || (year % 400 == 0))
}

// LastDayForMonth computes the number of the last day in a specific month.
// It accounts for leap years.
func lastDayForMonth(month time.Month, year int) int {
    res := daysInMonth[month]
    if month == time.February && isLeapYear(year) {
        res += 1
    }
    return res
}

// Day returns the day of the month where a specific weekday occurs. The specific
// weekday is requested using a WeekSchedule argument (see above for definition of
// WeekSchedule).
func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
    firstDay := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)
    // Start with the first requested weekday in the month.
    dayOfMonth := 1 + int(wDay) - int(firstDay.Weekday())
    if dayOfMonth <= 0 {
        dayOfMonth += 7
    }
    // If the request is not for the first weekday, adjust accordingly.
    switch wSched {
        case Second: dayOfMonth += 7
        case Third: dayOfMonth += 14
        case Fourth: dayOfMonth += 21
        case Last:
        	dayOfMonth += 21
        	if lastDayForMonth(month, year) - dayOfMonth >= 7 {
                dayOfMonth += 7
            }
        case Teenth:
        	for dayOfMonth < 13 {
                dayOfMonth += 7
            }
    }
	return dayOfMonth
}
