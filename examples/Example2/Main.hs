module Main (main) where

import Simulation

main :: IO ()
main = do
    -- run simulation
    let iters = runSimulationWithIterationAndHorizonE1 initState initInput simParamsHorizon

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE1 iters
    print $ last costs

    -- create animation
    createAnimationOfEquilibriumE (last iters)
