module Main (main) where

import Simulation

main :: IO ()
main = do
    -- run simulation
    let iters = runSimulationWithIterationAndHorizonE initState initInput simParamsHorizon

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE iters
    print $ last costs

    -- create animation
    createAnimationOfEquilibriumE (last iters)
