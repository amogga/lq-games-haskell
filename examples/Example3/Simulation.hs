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
import Type.Simulation
import Type.Dynamics
import Dynamics.Models
import Dynamics.MultiModels

simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon {iterationCount = 50, sample = 0.25, horizon = 20}

simParamsMaxT :: SimulationParameters
simParamsMaxT = SimulationParametersWithMaxTime {iterationCount = 80, sample = 0.05 , maxTime = 10 }

initState :: Vector R
initState = vector [-2, -30.0, pi / 2.0 , 4.0,
                    -10, 45, -(pi / 2.0), 3.0,
                    -11, 16.0, 0.0, 1.25]

initInput :: Vector R
initInput = vector [0,0,
                    0,0,
                    0,0]

players :: Floating a => [Player a]
players = [player1, player2, bicycle]

nonlinearDynamics :: SystemDynamicsFunctionType
nonlinearDynamics = multiPlayerSystem [carDyn,carDyn,bicDyn]

runSimulationWithIterationAndMaxTimeE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeE = runSimulationWithIterationAndMaxTime nonlinearDynamics totalCost players


runSimulationWithIterationAndHorizonE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonE = runSimulationWithIterationAndHorizon nonlinearDynamics totalCost players

totalCostsForPlayersPerIterationE :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithGoalsAndIteration "./examples/Example3" players
