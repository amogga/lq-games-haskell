module Example.Cost.TotalCost where

import Example.Cost.GoalCost
import Example.Cost.PolylineCost
import Example.Cost.VelocityCost
import Example.Cost.ProximityCost
import Type.Player
import Type.Weight
import Type.Index

totalCost :: (Floating a, Ord a) => Player a -> [a] -> [a] -> a
totalCost player states input =
  let goalCostP = goalCostFromStates player states
      proximityP = proximityCostE1 player states
      maxVelCost = maximumVelocityCost player states
      minVelCost = minimumVelocityCost player states
  in

  case player of
    (Car _ _ _ stateWeightCar inputWeightCar _) -> 

                                           let polylineCostP =  polylineCost player states
                                               polylineBoundaryCostP = polylineBoundaryCost player states
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

    (Bicycle _ _ _ stateWeightBicycle inputWeightBicycle _) -> 
                                            
                                            let steeringAngleCostP = input !! steeringAngleInputIndex (inputIndex player)
                                                accelerationCostP = input !! accelerationInputIndex (inputIndex player)
                                               
                                               in
                                                goalW stateWeightBicycle * goalCostP +
                                                maxVelocityW stateWeightBicycle * maxVelCost + minVelocityW stateWeightBicycle * minVelCost +
                                                proximityW stateWeightBicycle * proximityP + 

                                                steeringAngleW inputWeightBicycle * steeringAngleCostP ** 2 + 
                                                accelerationW inputWeightBicycle * accelerationCostP ** 2