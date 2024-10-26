module Example.Cost.VelocityCost where
import Data.List.Split (chunksOf)


maxVelocityCost :: (Floating a, Ord a) => [a] -> a -> Int -> a
maxVelocityCost states threshold player = max (velocity - threshold) 0 ** 2
  where
    velocity = last $ chunksOf 4 states !! (player - 1)

minVelocityCost :: (Floating a, Ord a) => [a] -> a -> Int -> a
minVelocityCost states threshold player = min (velocity - threshold) 0 ** 2
  where
    velocity = last $ chunksOf 4 states !! (player-1)