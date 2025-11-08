module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year = (year `isDivisible` 4) && ((year `notDivisible` 100) || (year `isDivisible` 400))
  where isDivisible a b = a `rem` b == 0
        notDivisible a b = not (isDivisible a b)

