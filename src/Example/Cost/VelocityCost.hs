module Example.Cost.VelocityCost where

import Type.Player
import Type.Index
import Type.CostInfo

maximumVelocityCost :: (Floating a, Ord a) => Player a -> [a] -> a
maximumVelocityCost player states = max (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = maxVelocityC $ costInfo player

minimumVelocityCost :: (Floating a, Ord a) => Player a -> [a] -> a
minimumVelocityCost player states = min (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = minVelocityC $ costInfo player


nominalVelocityCost :: (Floating a) => Player a -> [a] -> a
nominalVelocityCost player states = (velocity - nomVelocity) ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    nomVelocity = nominalVelocityC $ costInfo player