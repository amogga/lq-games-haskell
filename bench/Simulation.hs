module Simulation where

import Example.Quadratization
import Players
import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import TotalCost
import Type.Simulation

players :: Floating a => [Player a]
players = [player1, player2, bicycle]

quadratizeCostsE :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE = quadratizeCosts totalCost players

runSimulationWithIterationAndHorizonE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonE = runSimulationWithIterationAndHorizon totalCost players

runSimulationWithIterationAndMaxTimeE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeE = runSimulationWithIterationAndMaxTime totalCost players

totalCostsForPlayersPerIterationE :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE = totalCostsForPlayersPerIteration totalCost players
