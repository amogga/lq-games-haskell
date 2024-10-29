module Simulation where

import Example.Quadratization
import Players
import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import Solver.LQGame
import Dynamics.DiscreteModels

players :: Floating a => [Player a]
players = [player1, player2, bicycle]

lqGameSolverE1 :: [StateControlData] -> [PAndAlpha]
lqGameSolverE1 = lqGameSolverWStateControl players

quadratizeCostsE1 :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE1 = quadratizeCosts players

runSimulationWithTerminationE1 :: Vector R -> Vector R -> Double -> Int -> [[StateControlData]]
runSimulationWithTerminationE1 = runSimulationWithTermination players

runSimulationWithIterationE1 :: Vector R -> Vector R -> Int -> [[StateControlData]]
runSimulationWithIterationE1 = runSimulationWithIteration players

totalCostsForPlayersPerIterationE1 :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE1 = totalCostsForPlayersPerIteration players