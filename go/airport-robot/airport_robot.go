package airportrobot

import "fmt"

type Greeter interface {
	LanguageName() string
	Greet(string) string
}

// Italian
type Italian struct {}

func (g Italian) LanguageName() string { return "Italian" }

func (g Italian) Greet(name string) string {
	return fmt.Sprintf("Ciao %s!", name)
}

// Portuguese
type Portuguese struct {}

func (g Portuguese) LanguageName() string { return "Portuguese" }

func (g Portuguese) Greet(name string) string {
	return fmt.Sprintf("Olá %s!", name)
}

func SayHello(name string, g Greeter) string {
	return fmt.Sprintf("I can speak %s: %s", g.LanguageName(), g.Greet(name))
}
