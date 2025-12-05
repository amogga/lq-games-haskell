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
import Dynamics.MultiModels
import Dynamics.Models

simParamsMaxT :: SimulationParameters
simParamsMaxT = SimulationParametersWithMaxTime {iterationCount = 50, sample = 0.25, maxTime = 10}

simParamsHorizon :: SimulationParameters
simParamsHorizon = SimulationParametersWithHorizon { iterationCount = 50, sample = 0.25, horizon = 24 }

initState :: Vector R
initState = vector [-2, -20.0, pi / 2.0 , 6.0,
                    -2, 10, pi / 2.0, 4.0]

initInput :: Vector R
initInput = vector [0,0,0,0]

players :: Floating a => [Player a]
players = [player1, player2]

nonlinearDynamics :: SystemDynamicsFunctionType
nonlinearDynamics = multiPlayerSystem [carDyn,carDyn]

quadratizeCostsT :: Monad m => m StateControlData -> m LinearMultiSystemCosts
quadratizeCostsT = quadratizeCosts totalCost players

runSimulationWithIterationAndMaxTimeE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndMaxTimeE = runSimulationWithIterationAndMaxTime nonlinearDynamics totalCost players

runSimulationWithIterationAndHorizonE :: SimulationParameters -> Vector R -> Vector R -> [[StateControlData]]
runSimulationWithIterationAndHorizonE = runSimulationWithIterationAndHorizon nonlinearDynamics totalCost players

totalCostsForPlayersPerIterationE :: [StateControlData] -> [R]
totalCostsForPlayersPerIterationE = totalCostsForPlayersPerIteration totalCost players

createAnimationOfEquilibriumE :: [StateControlData] -> IO ()
createAnimationOfEquilibriumE = createAnimationWithGoalsAndIteration "./examples/Example5" players