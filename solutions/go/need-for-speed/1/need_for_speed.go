package speed

// Car defines the characteristics of a car.
type Car struct {
    battery int
    batteryDrain int
    speed int
    distance int
}

// NewCar creates a new remote controlled car with full battery and given specifications.
func NewCar(speed, batteryDrain int) Car {
	return Car{ battery: 100, batteryDrain: batteryDrain, speed: speed, distance: 0}
}

// Track defines the characteristics of a test track.
type Track struct {
    distance int
}

// NewTrack creates a new track
func NewTrack(distance int) Track {
	return Track{distance: distance}
}

// Drive drives the car one time. If there is not enough battery to drive one more time,
// the car will not move.
func Drive(car Car) Car {
    if car.battery - car.batteryDrain < 0 {
        return car
    }
	return Car{speed: car.speed, batteryDrain: car.batteryDrain,
               distance: car.distance + car.speed, battery: car.battery - car.batteryDrain}
}

// CanFinish checks if a car is able to finish a certain track.
func CanFinish(car Car, track Track) bool {
    // We need to account for the fact that the distance to drive may not be an exact
    // multiple of the time unit.
	numInc := float64(track.distance) / float64(car.speed)
    return float64(car.battery) - numInc * float64(car.batteryDrain) >= 0
}
