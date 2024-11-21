{-# LANGUAGE RankNTypes #-}

module Example.Utilities where

import Type.Basic
import Type.Player
import Numeric.LinearAlgebra
import Data.List (transpose)
import Algorithm.ODESolver
import Type.Quadratization
import Type.Dynamics

generateInitialStateControlPairs :: SystemDynamicsFunctionType -> Vector R -> Vector R -> DiscreteSample -> Horizon -> [StateControlData]
generateInitialStateControlPairs dyn states input sample horizon = zipWith StateControlPair initialOperatingPoints initialInputs
  where
    initialOperatingPoints = take horizon $ iterate (\x -> rk4Solve dyn sample x input) states
    initialInputs = replicate horizon input

totalCostsForPlayersPerIteration :: CostFunctionType -> [Player R] -> [StateControlData] -> [R]
totalCostsForPlayersPerIteration totCost players iterationStateControlPairs = map sum (transpose costPerHorizon)
  where
    costPerHorizon = map (totalCostsForPlayers totCost players) iterationStateControlPairs

totalCostsForPlayers :: CostFunctionType -> [Player R] -> StateControlData -> [R]
totalCostsForPlayers totCost players controlStateData = map (\player -> totCost player (toList x) (toList u)) players 
  where 
    x = priorState controlStateData
    u = controlInput controlStateData