module Example.Cost.ProximityCost where

import Algorithm.Basic
import Type.Player
import Type.Index
import qualified Type.CostInfo as I
import Type.Utilities


proximityCost :: (Floating a, Ord a) => Player a -> [a] -> a
proximityCost player states = proximityCost' player egoPosition otherPositions
  where 
    egoPlayerPositionIndices = positionStateIndices $ stateIndex player
    egoPosition = listFromPosition $ positionOfPlayer player states
    allIndices = allPositionStateIndices $ stateIndex player
    otherPositions = map (map (states !!)) (filter (/=egoPlayerPositionIndices) allIndices)

proximityCost' :: (Floating a, Ord a) => Player a -> [a] -> [[a]] -> a
proximityCost' player egoPosition otherPositions = sum $ map (**2) costs
  where
      pairs = [(egoPosition, p2) | p2 <- otherPositions]
      costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - prox) 0) pairs
      prox = I.proximity $ costInfo player
