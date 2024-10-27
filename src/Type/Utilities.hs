module Type.Utilities where

import Type.Player 
import Type.Position
import Type.Index

positionOfPlayer :: [a] -> Player a -> Position a
positionOfPlayer states player = case positionFromList $ map (states !!) (positionStateIndices $ stateIndex player) of
    Just pos -> pos
    Nothing -> error "States cannot be converted to a position. Please check position indices!"