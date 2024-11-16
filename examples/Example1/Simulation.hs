module Simulation where

import Example.Quadratization
import Players
import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import TotalCost
import Plot.CreateGifs

initState :: Vector R
initState = vector [6.5, 0.0, pi / 2.0 , 1.0,
                    1.5, 40, -(pi / 2.0), 0.1,
                    0.0, 22.0, 0.0, 2.0]

initInput :: Vector R
initInput = vector [0,0,
                    0,0,
                    0,0]

players :: Floating a => [Player a]
players = [player1, player2, bicycle]

quadratizeCostsE1 :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE1 = quadratizeCosts totalCost players

-- runSimulationWithTerminationE1 :: Vector R -> Vector R -> Double -> Int -> [[StateControlData]]
-- runSimulationWithTerminationE1 = runSimulationWithTermination totalCost players

runSimulationWithIterationAndHorizonE1 :: Vector R -> Vector R -> Int -> R -> Int -> [[StateControlData]]
runSimulationWithIterationAndHorizonE1 = runSimulationWithIterationAndHorizon totalCost players

totalCostsForPlayersPerIterationE1 :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE1 = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithIteration "./examples/Example1" players
