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
import Type.Dynamics
import Dynamics.MultiModels
import Dynamics.Models


simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon { iterationCount = 60, sample = 0.25, horizon = 20}

simParamsMaxT :: SimulationParameters
simParamsMaxT = SimulationParametersWithMaxTime {iterationCount = 60, sample = 0.25, maxTime = 5}

initState :: Vector R
initState = vector [2.5, -10, pi / 2.0 , 5.0,
                   -1, -10, pi / 2.0, 5.0,
                    2.5, 10.0, pi / 2.0, 5.25]

initInput :: Vector R
initInput = vector [0,0,0,0,0,0]

players :: Floating a => [Player a]
players = [player1, player2, player3]

nonlinearDynamics :: SystemDynamicsFunctionType
nonlinearDynamics = multiPlayerSystem [carDyn,carDyn,bicDyn]

quadratizeCostsE :: StateControlData -> LinearMultiSystemCosts
quadratizeCostsE = quadratizeCosts totalCost players

quadratizeCostsForPlayerE :: Player R -> Vector R -> Vector R -> LinearSystemCosts
quadratizeCostsForPlayerE = quadratizeCostsForPlayer totalCost

runSimulationWithIterationAndMaxTimeE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeE = runSimulationWithIterationAndMaxTime nonlinearDynamics totalCost players

runSimulationWithIterationAndHorizonE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonE = runSimulationWithIterationAndHorizon nonlinearDynamics totalCost players

totalCostsForPlayersPerIterationE :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithIteration "./examples/Example2" players
