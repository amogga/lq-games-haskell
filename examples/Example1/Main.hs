module Main(main) where

import Numeric.LinearAlgebra
import Simulation
import Plot.CreateGifs

main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    -- run simulation
    let iters = runSimulationWithTerminationE1 states input 1e-4 100
    -- print $ map priorState (last iters)

    print $ length iters
    -- Costs
    -- let costs = map totalCostsForPlayersPerIterationE1 iters
    -- print $ "Initial Cost = " ++ show (head costs)
    -- print $ "Costs = " ++ show (last costs)


    -- create animation
    createAnimationWithIterations players iters
