package booking

import (
	"time"
	"fmt"
	"errors"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	t, err := time.Parse("1/02/2006 15:04:05", date)

	if err != nil { errors.New("error parsing time") }
	return t
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	t, err := time.Parse("January 2, 2006 15:04:05", date)

	if err != nil { errors.New("error parsing time") }
	return t.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	t, err := time.Parse("Monday, January 2, 2006 15:04:05", date)

	if err != nil { errors.New("error parsing time") }

	if t.Hour() >= 12 && t.Hour() < 18 { return true }
	return false
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	t, err := time.Parse("1/2/2006 15:04:05", date)

	if err != nil { errors.New("error parsing time") }

	format := t.Format("Monday, January 2, 2006, at 15:04.")
	return fmt.Sprintf("You have an appointment on %s", format)
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	date := fmt.Sprintf("%d-09-15", time.Now().Year())
	t, err := time.Parse("2006-01-2", date)

	if err != nil { errors.New("error parsing time") }
	return t
}
