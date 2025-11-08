package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	return map[string]int{
        "quarter_of_a_dozen": 3,
        "half_of_a_dozen": 6,
        "dozen": 12,
        "small_gross": 120,
        "gross": 144,
        "great_gross": 1728,
    }
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	return make(map[string]int)
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	qty, ok := units[unit]
    if ok {
        bill[item] += qty
    }
    return ok
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	unitQty, unitExist := units[unit]
    if ! unitExist {
        return false
    }
    itemQty, itemInBill := bill[item]
    if ! itemInBill || itemQty - unitQty < 0{
        return false
    } else if itemQty - unitQty == 0 {
        delete(bill, item)
        return true
    } else {
     	bill[item] -= unitQty
        return true
    }
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	itemQty, itemInBill := bill[item]
    return itemQty, itemInBill
}
