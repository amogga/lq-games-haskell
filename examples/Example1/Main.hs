module Main(main) where

import Simulation

main :: IO ()
main = do
    -- run simulation
    
    let iters = runSimulationWithIterationAndHorizonE initState initInput simParamsHorizon

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE iters
    print $ last costs

    -- Create animation
    createAnimationOfEquilibriumE $ last iters
