module Example.Cost.PolylineCost where

import Algorithm.Basic
import Type.Player
import Type.CostInfo
import Type.Utilities

polylineCost :: (Floating a, Ord a) => [a] -> Player a -> a
polylineCost states player = pointLinePositionDistance position polyline ** 2
  where 
    polyline = polylineC $ costInfo player
    position = positionOfPlayer states player

polylineBoundaryCost :: (Floating a, Ord a) => [a] -> Player a -> a
polylineBoundaryCost states player = if plineCost > threshold then plineCost else 0
  where plineCost = polylineCost states player
        threshold = polylineBoundaryThresholdC $ costInfo player