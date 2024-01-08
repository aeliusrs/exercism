package lasagna

func PreparationTime(layers []string, time int) int {
	if time == 0 { time = 2 }
	return (len(layers) * time)
}

func Quantities(layers []string,) (grams int, liters float64) {
	for _, el := range layers {
		switch el {
		case "noodles": grams += 50
		case "sauce": liters += 0.2
		}
	}
	return
}

func AddSecretIngredient(friendsList, myList []string) []string {
	if len(friendsList) > 0 && len(myList) > 0 {
		myList[len(myList) - 1] = friendsList[len(friendsList) - 1]
	}
	return myList
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
	scaledQuantities := make([]float64, len(quantities))
	for i, amount := range quantities {
		scaledQuantities[i] = amount * float64(portions) / 2
	}
	return scaledQuantities
}
