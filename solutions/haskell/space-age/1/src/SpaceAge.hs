module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn planet seconds = seconds / (yearOnPlanet planet)
  where earthYear = 31557600
        yearOnPlanet Mercury = 0.2408467 * earthYear
        yearOnPlanet Venus = 0.61519726 * earthYear
        yearOnPlanet Earth = earthYear
        yearOnPlanet Mars = 1.8808158 * earthYear
        yearOnPlanet Jupiter = 11.862615 * earthYear
        yearOnPlanet Saturn = 29.447498 * earthYear
        yearOnPlanet Uranus = 84.016846 * earthYear
        yearOnPlanet Neptune = 164.79132 * earthYear

        
        
