package techpalace

import "strings"

// WelcomeMessage returns a welcome message for the customer.
func WelcomeMessage(customer string) string {
	var message string = "Welcome to the Tech Palace, "
	return (message + strings.ToUpper(customer))
}

// AddBorder adds a border to a welcome message.
func AddBorder(welcomeMsg string, numStarsPerLine int) string {
	var border string = strings.Repeat("*", numStarsPerLine)
	var welcomeFmt string = "\n" + welcomeMsg + "\n"
	return border + welcomeFmt + border
}

// CleanupMessage cleans up an old marketing message.
func CleanupMessage(oldMsg string) string {
	cleanMsg := strings.ReplaceAll(oldMsg, "*", "")
	cleanMsg = strings.Trim(cleanMsg, "\n ")
	return cleanMsg
}
