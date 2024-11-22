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
import Type.Dynamics
import Dynamics.Models
import Dynamics.MultiModels

simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon {iterationCount = 60, sample = 0.1, horizon = 50}

simParamsMaxT :: SimulationParameters
simParamsMaxT = SimulationParametersWithMaxTime {iterationCount = 60, sample = 0.25, maxTime = 5}

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

quadratizeCostsT :: Monad m => m StateControlData -> m LinearMultiSystemCosts
quadratizeCostsT = quadratizeCosts totalCost players

runSimulationWithIterationAndHorizonT :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonT = runSimulationWithIterationAndHorizon nonlinearDynamics totalCost players

runSimulationWithIterationAndMaxTimeT :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeT = runSimulationWithIterationAndMaxTime nonlinearDynamics totalCost players

totalCostsForPlayersPerIterationT :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationT = totalCostsForPlayersPerIteration totalCost players