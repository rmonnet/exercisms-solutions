//Package leap provides a function to check if a year is a leap year.
package leap

// IsLeapYear check if a yer is  leap year.
func IsLeapYear(year int) bool {
	return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)
}
