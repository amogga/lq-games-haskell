module Simulation where

import Players
import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Example.Simulation
import Example.Utilities
import TotalCost
import Plot.CreateGifs
import Type.Simulation
import Type.Dynamics
import Dynamics.MultiModels
import Dynamics.Models

simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon {iterationCount = 50, sample = 0.1, horizon = 50}

simParamsMaxT :: SimulationParameters
simParamsMaxT = SimulationParametersWithMaxTime {iterationCount = 50, sample = 0.1, maxTime = 5}

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

nonlinearDynamics :: SystemDynamicsFunctionType
nonlinearDynamics = multiPlayerSystem [carDyn,carDyn,bicDyn]

-- runSimulationWithTerminationE1 :: Vector R -> Vector R -> Double -> Int -> [[StateControlData]]
-- runSimulationWithTerminationE1 = runSimulationWithTermination totalCost players

runSimulationWithIterationAndMaxTimeE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeE = runSimulationWithIterationAndMaxTime nonlinearDynamics totalCost players


runSimulationWithIterationAndHorizonE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonE = runSimulationWithIterationAndHorizon nonlinearDynamics totalCost players

totalCostsForPlayersPerIterationE :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithGoalsAndIteration "./examples/Example1" players
