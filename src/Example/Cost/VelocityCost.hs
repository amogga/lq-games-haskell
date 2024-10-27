module Example.Cost.VelocityCost where

import Type.Player
import Type.Index
import Type.CostInfo

maximumVelocityCost :: (Floating a, Ord a) => [a] -> Player a -> a
maximumVelocityCost states player = max (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = maxVelocityC $ costInfo player

minimumVelocityCost :: (Floating a, Ord a) => [a] -> Player a -> a
minimumVelocityCost states player = min (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = minVelocityC $ costInfo player