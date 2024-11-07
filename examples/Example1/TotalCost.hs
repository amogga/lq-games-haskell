module TotalCost where

import Example.Cost.GoalCost
import Example.Cost.LaneCost
import Example.Cost.VelocityCost
import Example.Cost.ProximityCost
import Type.Player
import Type.Weight
import Type.Index


totalCost :: (Floating a, Ord a) => Player a -> [a] -> [a] -> a
totalCost player states input =
  let 
      goalCostP = goalCostFromStates player states
      proximityP = proximityCost player states
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
                                              -- progess
                                              goalW stateWeightCar * goalCostP +

                                              -- stay in lane
                                              polylineW stateWeightCar * polylineCostP + polylineW stateWeightCar * polylineBoundaryCostP +

                                              -- adjust speed and keep within bounds: nominal, maximum and minimum speed
                                              maxVelocityW stateWeightCar * maxVelCost + 
                                              minVelocityW stateWeightCar * minVelCost +

                                              -- avoid collisions with other road users
                                              proximityW stateWeightCar * proximityP +

                                              -- penalize inputs: angular velocity and acceleration
                                              angularVelocityW inputWeightCar * angularVelocityCostP ** 2 + 
                                              accelerationW inputWeightCar * accelerationCostP ** 2

    (Bicycle _ _ _ stateWeightBicycle inputWeightBicycle _) -> 
                                            
                                            let steeringAngleCostP = input !! steeringAngleInputIndex (inputIndex player)
                                                accelerationCostP = input !! accelerationInputIndex (inputIndex player)
                                               
                                               in

                                               -- progess
                                                goalW stateWeightBicycle * goalCostP +

                                                -- adjust speed and keep within bounds: nominal, maximum and minimum speed
                                                maxVelocityW stateWeightBicycle * maxVelCost + 
                                                minVelocityW stateWeightBicycle * minVelCost +
                                                
                                                -- avoid collisions with other road users
                                                proximityW stateWeightBicycle * proximityP + 

                                                -- penalize inputs: steering angle and acceleration
                                                steeringAngleW inputWeightBicycle * steeringAngleCostP ** 2 + 
                                                accelerationW inputWeightBicycle * accelerationCostP ** 2