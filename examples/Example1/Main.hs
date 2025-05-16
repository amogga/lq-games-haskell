module Main(main) where

import Simulation

main :: IO ()
main = do
    -- run simulation

    let iters0 = runSimulationWithIterationAndMaxTimeE simParamsMaxT initState initInput  
    let iters = runSimulationWithIterationAndHorizonE simParamsHorizon initState initInput

    -- compute costs per iteration
    let costs0 = map totalCostsForPlayersPerIterationE iters0
    print $ last costs0

    let costs = map totalCostsForPlayersPerIterationE iters
    print $ last costs

    -- Create animation
    createAnimationOfEquilibriumE $ last iters