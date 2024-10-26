module Example.Cost.PolylineCost where

import Data.List.Split (chunksOf)
import Algorithm.Basic

polylineCost :: (Floating a, Ord a) => [a] -> Int -> a
polylineCost states player = case player of
  1 -> let polyline = [[6.0,-100.0],[6.0,100.0]] in pointLineDistance position polyline ** 2
  2 -> let polyline = [[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]] in pointLineDistance position polyline ** 2
  _ -> error "No more players! Choose from player set {1,2,3}"

  where position = map (take 2) (chunksOf 4 states) !! (player - 1)

polylineBoundaryCost :: (Floating a, Ord a) => [a] -> Int -> a
polylineBoundaryCost states player = if plineCost > threshold then plineCost else 0
  where plineCost = polylineCost states player
        threshold = 1.0