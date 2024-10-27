module Type.Utilities where

import Type.Player 
import Type.Position
import Type.Index

positionOfPlayer :: Player a -> [a] -> Position a
positionOfPlayer player states = case positionFromList $ map (states !!) (positionStateIndices $ stateIndex player) of
    Just pos -> pos
    Nothing -> error "States cannot be converted to a position. Please check position indices!"