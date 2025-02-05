module Dynamics.Models(carDyn, bicDyn) where

-- Model equations
carDyn :: Floating a => [a] -> [a] -> [a]
carDyn [_, _, th, v] [w, a] = [v * cos th, v * sin th, w, a]
carDyn _ _ = error "Invalid arguments"

bicDyn :: Floating a => [a] -> [a] -> [a]
bicDyn [_, _, psi, v] [a,deltaf] = [v * cos (psi+beta), v * sin (psi+beta), v / lr * sin beta, a]
  where
    lf = 0.5
    lr = 0.5
    beta = atan (lr / (lf+lr) * tan deltaf)
bicDyn _ _ = error "Invalid arguments"