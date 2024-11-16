module Simulation where

import Type.Player
import Players
import Type.Basic
import Example.Quadratization (quadratizeCosts, quadratizeCostsForPlayer)
import Example.Simulation
import Example.Utilities
import TotalCost (totalCost)
import Numeric.LinearAlgebra
import Plot.CreateGifs
import Type.Simulation


simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon { iterationCount = 60, sample = 0.25, horizon = 20}

initState :: Vector R
initState = vector [2.5, -10, pi / 2.0 , 5.0,
                   -1, -10, pi / 2.0, 5.0,
                    2.5, 10.0, pi / 2.0, 5.25]

initInput :: Vector R
initInput = vector [0,0,0,0,0,0]

players :: Floating a => [Player a]
players = [player1, player2, player3]

quadratizeCostsE1 :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE1 = quadratizeCosts totalCost players

quadratizeCostsForPlayerE1 :: Player R -> Vector R -> Vector R -> LinearSystemCosts
quadratizeCostsForPlayerE1 = quadratizeCostsForPlayer totalCost

runSimulationWithIterationAndHorizonE1 :: Vector R -> Vector R -> SimulationParameters -> [[StateControlData]]
runSimulationWithIterationAndHorizonE1 = runSimulationWithIterationAndHorizon totalCost players

totalCostsForPlayersPerIterationE1 :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE1 = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithIteration "./examples/Example2" players
