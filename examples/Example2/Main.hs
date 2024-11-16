module Main (main) where

import Simulation

main :: IO ()
main = do
    -- run simulation
    let iters = runSimulationWithIterationAndHorizonE1 initState initInput 60 0.25 20

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE1 iters
    print $ last costs

    -- create animation
    createAnimationOfEquilibriumE (last iters)
