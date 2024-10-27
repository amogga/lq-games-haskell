module Example.Cost.ProximityCost where
  
import Data.List.Split (chunksOf)
import Algorithm.Basic
import Type.Player
import Type.CostInfo

proximityCostE1 :: (Floating a, Ord a) => [a] -> Player a -> a
proximityCostE1 states = proximityCost positions
  where
      positions = map (take 2) (chunksOf 4 states) -- extract 2D positions

proximityCost :: (Floating a, Ord a) => [[a]] -> Player a -> a
proximityCost points player = sum $ map (**2) costs
  where
      pairs = [(p1, p2) | p1 <- points, p2 <- points, p1 /= p2] -- generate pairs
      costs = map (\(p1, p2) -> min (euclidDistance p1 p2 - prox) 0) pairs
      prox = proximityC $ costInfo player