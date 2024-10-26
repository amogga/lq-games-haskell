module Example.Cost.ProximityCost where
  
import Data.List.Split (chunksOf)
import Algorithm.Basic

proximityCost :: (Floating a, Ord a) => [a] -> Int -> a
proximityCost states player = sum $ map (**2) costs
  where
      positions = map (take 2) (chunksOf 4 states) -- extract 2D positions
      pairs = [(p1, p2) | p1 <- positions, p2 <- positions, p1 /= p2] -- generate pairs
      costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - proximity) 0) pairs
      proximity = if player == 1 || player == 2
                  then 2 else 1