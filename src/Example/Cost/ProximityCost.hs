module Example.Cost.ProximityCost where

import Algorithm.Basic
import Type.Player
import Type.Index
import Type.CostInfo
import Type.Utilities


proximityCostE1 :: (Floating a, Ord a) => Player a -> [a] -> a
proximityCostE1 player states = proximityCost player egoPosition otherPositions
  where 
    egoPlayerPositionIndices = positionStateIndices $ stateIndex player
    egoPosition = listFromPosition $ positionOfPlayer player states
    allIndices = allPositionStateIndices $ stateIndex player
    otherPositions = map (map (states !!)) (filter (/=egoPlayerPositionIndices) allIndices)

proximityCost :: (Floating a, Ord a) => Player a -> [a] -> [[a]] -> a
proximityCost player egoPosition otherPositions = sum $ map (**2) costs
  where
      pairs = [(egoPosition, p2) | p2 <- otherPositions]
      costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - prox) 0) pairs
      prox = proximityC $ costInfo player


-- proximityCostE1 :: (Floating a, Ord a) => Player a -> [a] -> a
-- proximityCostE1 player states = proximityCost player otherPositions
--   where 
--     egoPlayerPositionIndices = positionStateIndices $ stateIndex player
--     egoPosition = listFromPosition $ positionOfPlayer player states
--     allIndices = allPositionStateIndices $ stateIndex player
--     otherPositions = map (map (states !!)) allIndices


-- proximityCost :: (Floating a, Ord a) => Player a -> [[a]] -> a
-- proximityCost player points = sum $ map (**2) costs
--   where
--       pairs = [(p1, p2) | p1 <- points, p2 <- points, p1 /= p2] -- generate pairs
--       costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - prox) 0) pairs
--       prox = proximityC $ costInfo player