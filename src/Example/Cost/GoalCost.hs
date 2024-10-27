module Example.Cost.GoalCost where

import Algorithm.Basic
import Type.Player
import Type.Position
import Type.Utilities
import Type.CostInfo

goalCostFromStates :: Floating a => Player a -> [a] -> a
goalCostFromStates player states = goalCost player position
  where position = positionOfPlayer player states

goalCost :: Floating a => Player a -> Position a -> a
goalCost player position = euclidPositionsDistance position (goalC $ costInfo player) ** 2