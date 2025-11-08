// Package weather provides functions to forecast the weather
// for a given location.
package weather

// CurrentCondition stores the weather condition at the current location.
var CurrentCondition string
// CurrentLocation represents the location associated with the forecast.
var CurrentLocation string

// Forecast returns the weather report for a given location and condition.
// It also stores the given location and condition for future references.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
