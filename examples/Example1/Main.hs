module Main (main) where

import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import Example.Cost.TotalCost
import Players
import Type.Player
import Simulation
import Numeric.AD
import Example.Quadratization


main :: IO ()
main = do
    let states = vector [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    let input = vector [0,0,0,0,0,0]

    let iters = runSimulationE1 states input 10
    print $ map totalCostsForPlayersPerIterationE1 iters

    -- let itersCount = 20
    -- let iters = runSimulation states input itersCount 

    -- let costs = map totalCostsForPlayersPerIteration iters
    -- print costs
    -- let states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
    -- let input = [0,0,0,0,0,0.0]
    
    -- let prox = proximityCost [[3,0.4],[5.5,2.3],[4.4,3]] player
    -- let pos = Position (2.2,4)
    -- let pos2 = Position (4.4,5)
    -- print $ map (totalCostN states input) [player1, player2, bicycle]

    -- print $ grad totalCost1 (states++input)