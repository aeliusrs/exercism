package meetup

import "time"

// Define the WeekSchedule type here.
type WeekSchedule int

// Teenth
const First  = 1
const Second = 8
const Third  = 15
const Fourth = 22
const Fifth  = 30
const Teenth = 13

// Get the day one week before end of the month
const Last   = -6

func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
	if wSched == Last { month++ }

	dayOfMonth := time.Date(year, month, int(wSched), 0, 0, 0, 0, time.UTC)
	daysNext := (int(wDay) - int(dayOfMonth.Weekday()) + 7) % 7

	return dayOfMonth.Day() + daysNext
}
