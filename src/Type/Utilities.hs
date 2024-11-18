module Type.Utilities where

import Type.Basic
import Type.Player
import Type.Position
import Type.Index
import Numeric.LinearAlgebra

positionFromList :: [a] -> Maybe (Position a)
positionFromList [x, y] = Just (Position (x, y))
positionFromList _      = Nothing

tupleFromPosition :: Position Double -> (Double,Double)
tupleFromPosition (Position (x,y)) = (x,y)

listFromPosition :: Position a -> [a]
listFromPosition position = let Position (x,y) = position in [x,y]

positionOfPlayerFromStateControlData :: Player R -> StateControlData -> Position R
positionOfPlayerFromStateControlData player iteration = positionOfPlayer player (toList playerState)
    where
        playerState = priorState iteration

positionOfPlayer :: Player a -> [a] -> Position a
positionOfPlayer player states = case positionFromList $ map (states !!) (positionStateIndices $ stateIndex player) of
    Just pos -> pos
    Nothing -> error "States cannot be converted to a position. Please check position indices!"

psiOfPlayerFromStateControlData :: Player R -> StateControlData -> R
psiOfPlayerFromStateControlData player iteration = toList playerState !! psiStateIndex (stateIndex player)
    where
        playerState = priorState iteration