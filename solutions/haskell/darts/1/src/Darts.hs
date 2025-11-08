module Darts (score) where

score :: Float -> Float -> Int
score x y
  | radius > 10 = 0
  | radius > 5 = 1
  | radius > 1 = 5
  | otherwise = 10
  where radius = sqrt (x^2 + y^2)

