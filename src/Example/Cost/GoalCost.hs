module Example.Cost.GoalCost where

import Algorithm.Basic
import Type.Player
import Type.Position
import Type.Utilities
import Type.CostInfo

goalCostFromStates :: Floating a => [a] -> Player a -> a
goalCostFromStates states player = goalCost position player
  where position = positionOfPlayer states player

goalCost :: Floating a => Position a -> Player a -> a
goalCost position player = euclidPositionsDistance position (goalC $ costInfo player) ** 2