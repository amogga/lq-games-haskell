module Main (main) where

import Players
import Simulation
import TotalCost
import Numeric.LinearAlgebra
import TotalCost (totalCost)
import Simulation (quadratizeCostsE1)
import Numeric.AD 
import Plot.CreateGifs
import Numeric.AD.Internal.Kahn (Tape(Var))
import Type.Basic (StateControlData(priorState))

main :: IO ()
main = do
    let states =  vector [2.5, -10, pi / 2.0 , 5.0,
                         -1, -10, pi / 2.0, 5.0,
                         2.5, 10.0, pi / 2.0, 5.25]
    let input =  vector [0,0,0,0,0,0]

--    let _ = map (`positionOfPlayer` toList states) players

--    let prox = map (`proximityCost` toList states) players

    -- let totCost = map (\p -> totalCost p states input) players
    -- let quadrr = quadratizeCostsForPlayerE1 player2 states input
    -- print $ quadrr

    let iters = runSimulationWithIterationE1 states input 61
    print $ map (\h -> 180 / pi * (priorState h) ! 2) (last iters)

    -- createAnimationWithIteration players (last iters)
--    putStrLn "Cool Stuff"
