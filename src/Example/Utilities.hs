module Example.Utilities where

import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Data.List (transpose)
import Example.Cost.TotalCost
import Algorithm.ODESolver

generateInitialStateControlPairs :: Vector R -> Vector R -> Int -> [StateControlData]
generateInitialStateControlPairs states input horizon = zipWith StateControlPair initialOperatingPoints initialInputs
    where
        initialOperatingPoints = take horizon $ iterate (`nonlinearDynamicsSolve` input) states
        initialInputs = replicate horizon input

totalCostsForPlayersPerIteration :: [StateControlData] -> [R]
totalCostsForPlayersPerIteration iterationStateControlPairs = map sum (transpose costPerHorizon)
  where
    costPerHorizon = map totalCostsForPlayers iterationStateControlPairs

totalCostsForPlayers :: StateControlData -> [R]
totalCostsForPlayers controlInputPairs = map (totalCost (toList x) (toList u)) [1..3]
  where
    StateControlPair x u = controlInputPairs