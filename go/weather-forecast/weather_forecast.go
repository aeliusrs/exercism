// Package weather package provides function for weather reporting.
package weather

// CurrentCondition return the current state condition of the Weather.
var CurrentCondition string
// CurrentLocation return the location of the weather report.
var CurrentLocation string

// Forecast func : return a string containing the current weather condition
// and the current location.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
