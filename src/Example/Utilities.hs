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

totalCostsForPlayersPerIteration :: [Player R] -> [StateControlData] -> [R]
totalCostsForPlayersPerIteration players iterationStateControlPairs = map sum (transpose costPerHorizon)
  where
    costPerHorizon = map (totalCostsForPlayers players) iterationStateControlPairs

totalCostsForPlayers :: [Player R] -> StateControlData -> [R]
totalCostsForPlayers players controlInputPairs = map (\player -> totalCost player (toList x) (toList u)) players
  where
    StateControlPair x u = controlInputPairs