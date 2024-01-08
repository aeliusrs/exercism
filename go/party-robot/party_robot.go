package partyrobot

import "fmt"

// Welcome greets a person by name.
func Welcome(name string) string {
	return "Welcome to my party, " + name + "!"
}

// HappyBirthday wishes happy birthday to the birthday person and exclaims their age.
func HappyBirthday(name string, age int) string {
	getMsg := fmt.Sprintf("Happy birthday %s! You are now %d years old!", name, age)
	return getMsg
}

// AssignTable assigns a table to each guest.
func AssignTable(name string, table int, neighbor, direction string, distance float64) string {
	formatString := "Welcome to my party, %s!\n" +
	"You have been assigned to table %.3d. " +
	"Your table is %s, exactly %.1f meters from here.\n" +
	"You will be sitting next to %s."
	getMsg := fmt.Sprintf(formatString , name, table, direction, distance, neighbor)
	return getMsg
}
