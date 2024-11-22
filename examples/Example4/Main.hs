module Main (main) where

import Simulation
import Type.Simulation

main :: IO ()
main = do
    -- run simulation iterations
    let simParamsMax = SimulationParametersWithMaxTime {iterationCount = 50, sample = 0.25, maxTime = 15}
    let iters = runSimulationWithIterationAndMaxTimeE simParamsMax initState initInput

    -- compute costs per iteration
    let costs = map totalCostsForPlayersPerIterationE iters
    print $ last costs
    
    -- Create animation
    createAnimationOfEquilibriumE $ last iters