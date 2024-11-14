module Example.Cost.VelocityCost where

import Type.Player
import Type.Index
import qualified Type.CostInfo as I

maximumVelocityCost :: (Floating a, Ord a) => Player a -> [a] -> a
maximumVelocityCost player states = max (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = I.maxVelocity $ costInfo player

minimumVelocityCost :: (Floating a, Ord a) => Player a -> [a] -> a
minimumVelocityCost player states = min (velocity - threshold) 0 ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    threshold = I.minVelocity $ costInfo player

nominalVelocityCost :: (Floating a) => Player a -> [a] -> a
nominalVelocityCost player states = (velocity - nomVelocity) ** 2
  where
    velocity = states !! velocityStateIndex (stateIndex player)
    nomVelocity = I.nominalVelocity $ costInfo player
