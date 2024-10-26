module Main (main) where

import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities

main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    let itersCount = 20
    let iters = runSimulation states input itersCount 

    let costs = map totalCostsForPlayersPerIteration iters
    print costs