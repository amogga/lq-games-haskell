module Examples.E1.Costs.TotalCost where

import Types.Basic
import Numeric.LinearAlgebra
import Examples.E1.Costs.GoalCost
import Examples.E1.Costs.PolylineCost
import Examples.E1.Costs.VelocityCost
import Examples.E1.Costs.ProximityCost
import Data.List.Split (chunksOf)
import Data.List (transpose)

totalCost :: (Floating a, Ord a) => [a] -> [a] -> Int -> a
totalCost states input player = case player of
  1 -> let weightsx = [1,50,50,100,100,100]
           weightsu = [25,1]
           weightedCarCosts = sum $ zipWith (*) weightsx carCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts
        in weightedCarCosts + weightedInputCosts

  2 -> let weightsx = [1,50,50,100,100,100] 
           weightsu = [25,1]
           weightedCarCosts = sum $ zipWith (*) weightsx carCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts
        in weightedCarCosts + weightedInputCosts

  3 -> let weightsx = [1,100,100,1]
           weightsu = [1,1]
           weightedBicycleCosts = sum $ zipWith (*) weightsx bikeCosts
           weightedInputCosts = sum $ zipWith (*) weightsu inputCosts 
        in weightedBicycleCosts + weightedInputCosts

  _ -> error "No more players! Choose from the players set {1,2,3}"
  where
    carCosts = [goalCost states player, polylineCost states player, polylineBoundaryCost states player, maxVelocityCost states maxvCar player, minVelocityCost states minvCar player, proximityCost states player]
    bikeCosts = [goalCost states player, maxVelocityCost states maxvBicycle player, minVelocityCost states minvBicycle player, proximityCost states player]
    inputCosts = map (**2) playerInput
    playerInput = chunksOf 2 input !! (player - 1)
    (minvCar,maxvCar) = (0,10)
    (minvBicycle,maxvBicycle) = (1,2.5)

-- Convenience functions for later use
totalCostsForPlayersPerIteration :: [StateControlData] -> [R]
totalCostsForPlayersPerIteration iterationStateControlPairs = map sum (transpose costPerHorizon)
  where
    costPerHorizon = map totalCostsForPlayers iterationStateControlPairs

totalCostsForPlayers :: StateControlData -> [R]
totalCostsForPlayers controlInputPairs = map (totalCost (toList x) (toList u)) [1..3]
  where
    StateControlPair x u = controlInputPairs