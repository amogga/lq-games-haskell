module Simulation where

import Example.Quadratization
import Players
import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import TotalCost

players :: Floating a => [Player a]
players = [player1, player2, bicycle]

quadratizeCostsE1 :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE1 = quadratizeCosts totalCost players

runSimulationWithIterationAndHorizonE1 :: Vector R -> Vector R -> Int -> R -> Int -> [[StateControlData]]
runSimulationWithIterationAndHorizonE1 = runSimulationWithIterationAndHorizon totalCost players

totalCostsForPlayersPerIterationE1 :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE1 = totalCostsForPlayersPerIteration totalCost players
