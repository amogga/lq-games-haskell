module Example.Cost.LaneCost where

import Algorithm.Basic
import Type.Player
import Type.CostInfo
import Type.Utilities

polylineCost :: (Floating a, Ord a) => Player a -> [a] -> a
polylineCost player states = pointLinePositionDistance position polyline ** 2
  where 
    polyline = polylineC $ costInfo player
    position = positionOfPlayer player states

polylineBoundaryCost :: (Floating a, Ord a) => Player a -> [a] -> a
polylineBoundaryCost player states = if plineCost > threshold then plineCost else 0
  where plineCost = polylineCost player states
        threshold = polylineBoundaryThresholdC $ costInfo player