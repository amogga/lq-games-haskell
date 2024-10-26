module Main (main) where

import Numeric.LinearAlgebra
import Examples.E1.Simulation
import Examples.E1.Costs.TotalCost

main :: IO ()
main = do

    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    let itersCount = 20
    let iters = runSimulation states input itersCount 

    -- let specificIter = iters !! (itersCount - 1)
    -- print $ controlInput $ specificIter !! 4
    -- print $ priorState $ specificIter !! 5


    let costs = map totalCostsForPlayersPerIteration iters
    print costs



-- main :: IO ()
-- main = defaultMain [
--            bench "Total Costs" $ whnf (quadratizeCosts states) input
--         ]
--         where
--             states = [6.5, 0.0, pi / 2.0, 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
--             input = [0,0,0,0,0,0]