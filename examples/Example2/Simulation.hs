module Simulation where

import Type.Player
import Players
import Type.Basic
import Example.Quadratization (quadratizeCosts, quadratizeCostsForPlayer)
import Example.Simulation
import Example.Utilities
import TotalCost (totalCost)
import Numeric.LinearAlgebra
  
players :: Floating a => [Player a]
players = [player1, player2, player3]

quadratizeCostsE1 :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE1 = quadratizeCosts totalCost players

quadratizeCostsForPlayerE1 :: Player R -> Vector R -> Vector R -> LinearSystemCosts
quadratizeCostsForPlayerE1 = quadratizeCostsForPlayer totalCost

runSimulationWithIterationE1 :: Vector R -> Vector R -> Int -> [[StateControlData]]
runSimulationWithIterationE1 = runSimulationWithIteration totalCost players

totalCostsForPlayersPerIterationE1 :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE1 = totalCostsForPlayersPerIteration totalCost players
