module Main (main) where

import Players
import Simulation
import Type.Utilities
import Numeric.LinearAlgebra
import Example.Cost.ProximityCost

main = do
    let states = vector [2.5, -10, pi / 2.0 , 5.0,
                         -1, -10, pi / 2.0, 5.0,
                         2.5, 10.0, pi / 2.0, 5.25]
    let input = vector [0,0,0,0,0,0]

    let pos = map (`positionOfPlayer` toList states) players

    let prox = map (`proximityCost` toList states) players
    print $ prox