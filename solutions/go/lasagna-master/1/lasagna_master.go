package lasagna

const noodleQtyPerLayer = 50
const sauceQtyPerLayer = 0.2

// PreparationTime computes the time required to prepare the lasagna based
// on the number of layers and the preparation time per layer.
func PreparationTime(layers []string, layerPrepTime int) int {
    // If layerPrepTime is invalid, set to 2.
    if layerPrepTime == 0 {
        layerPrepTime = 2
    }
    return len(layers) * layerPrepTime
}

// Quantities computes the quantity of noodles and sauce required
// to make the lasagna as a function of the number of layers.
func Quantities(layers []string) (noodleQty int, sauceQty float64) {
    for _, layer := range layers {
        if layer == "noodles" {
            noodleQty += noodleQtyPerLayer
        } else if layer == "sauce" {
            sauceQty += sauceQtyPerLayer
        }
    }
    return
}

// AddSecretIngredient adds your friend secret ingredient to your list of
// ingredients by replacing the last ingredient in your list by the last
// ingredient in his list.
func AddSecretIngredient(friendList, myList []string) {
    myList[len(myList)-1] = friendList[len(friendList)-1]
}

// ScaleRecipe scales the quantities from the original recipe (2 portions) to 
// the specified number of portions.
func ScaleRecipe(quantities []float64, numberOfPortions int) []float64 {
    scaleFactor := float64(numberOfPortions) / 2
    scaledQuantities := make([]float64, len(quantities))
    for i := 0; i < len(quantities); i++ {
        scaledQuantities[i] = scaleFactor * quantities[i]
    }
    return scaledQuantities
}


