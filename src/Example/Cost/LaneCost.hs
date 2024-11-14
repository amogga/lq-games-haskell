module Example.Cost.LaneCost where

import Algorithm.Basic
import Type.Player
import qualified Type.CostInfo as I
import Type.Utilities

laneCost :: (Floating a, Ord a) => Player a -> [a] -> a
laneCost player states = pointLinePositionDistance position lane ** 2
  where 
    lane = I.lane $ costInfo player
    position = positionOfPlayer player states

laneBoundaryCost :: (Floating a, Ord a) => Player a -> [a] -> a
laneBoundaryCost player states = if plineCost > threshold then plineCost else 0
  where plineCost = laneCost player states
        threshold = I.laneBoundary $ costInfo player
