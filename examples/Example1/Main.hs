module Main(main) where

import Simulation

main :: IO ()
main = do
    -- run simulation
    let iters = runSimulationWithIterationAndHorizonE1 initState initInput 50 0.1 50

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE1 iters
    print $ last costs

    -- Create animation
    createAnimationOfEquilibriumE $ last iters
