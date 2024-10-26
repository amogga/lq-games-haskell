module Examples.E1.Costs.GoalCost where

import Data.List.Split (chunksOf)
import Algorithms.Helpers

goalCost :: Floating a => [a] -> Int -> a
goalCost states player = case player of
  1 -> let goal = [6.0,35.0] in euclidDistance position goal ** 2
  2 -> let goal = [12,12] in euclidDistance position goal ** 2
  3 -> let goal = [15,21] in euclidDistance position goal ** 2
  _ -> error "No more players! Choose from player set {1,2,3}"

  where position = map (take 2) (chunksOf 4 states) !! (player - 1)