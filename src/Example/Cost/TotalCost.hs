module Example.Cost.TotalCost where

import Example.Cost.GoalCost
import Example.Cost.PolylineCost
import Example.Cost.VelocityCost
import Example.Cost.ProximityCost
import Type.Player
import Type.Weight
import Type.Index
import Data.List.Split (chunksOf)

totalCostN :: (Floating a, Ord a) => [a] -> [a] -> Player a -> a
totalCostN states input player =
  let goalCostP = goalCostFromStates states player
      proximityP = proximityCostE1 states player
      maxVelCost = maximumVelocityCost states player
      minVelCost = minimumVelocityCost states player
  in

  case player of
    (Car _ _ _ stateWeightCar inputWeightCar) -> 

                                           let polylineCostP =  polylineCost states player
                                               polylineBoundaryCostP = polylineBoundaryCost states player
                                               angularVelocityCostP = input !! angularVelocityInputIndex (inputIndex player)
                                               accelerationCostP = input !! accelerationInputIndex (inputIndex player)
                                              in
                                              -- states
                                              goalW stateWeightCar * goalCostP +
                                              polylineW stateWeightCar * polylineCostP + polylineW stateWeightCar * polylineBoundaryCostP +
                                              maxVelocityW stateWeightCar * maxVelCost + minVelocityW stateWeightCar * minVelCost +
                                              proximityW stateWeightCar * proximityP +
                                              -- inputs
                                              angularVelocityW inputWeightCar * angularVelocityCostP ** 2 + 
                                              accelerationW inputWeightCar * accelerationCostP ** 2

    (Bicycle _ _ _ stateWeightBicycle inputWeightBicycle) -> 
                                            
                                            let steeringAngleCostP = input !! steeringAngleInputIndex (inputIndex player)
                                                accelerationCostP = input !! accelerationInputIndex (inputIndex player)
                                               
                                               in
                                                goalW stateWeightBicycle * goalCostP +
                                                maxVelocityW stateWeightBicycle * maxVelCost + minVelocityW stateWeightBicycle * minVelCost +
                                                proximityW stateWeightBicycle * proximityP + 

                                                steeringAngleW inputWeightBicycle * steeringAngleCostP ** 2 + 
                                                accelerationW inputWeightBicycle * accelerationCostP ** 2





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
    -- carCosts = [goalCost states player, polylineCost states player, polylineBoundaryCost states player, maxVelocityCost states maxvCar player, minVelocityCost states minvCar player, proximityCost states player]
    -- bikeCosts = [goalCost states player, maxVelocityCost states maxvBicycle player, minVelocityCost states minvBicycle player, proximityCost states player]
    carCosts = []
    bikeCosts = []

    inputCosts = map (**2) playerInput
    playerInput = chunksOf 2 input !! (player - 1)
    (minvCar,maxvCar) = (0,10)
    (minvBicycle,maxvBicycle) = (1,2.5)